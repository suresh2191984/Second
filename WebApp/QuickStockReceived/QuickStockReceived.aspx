<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuickStockReceived.aspx.cs"
    Inherits="QuickStockReceived_QuickStockReceived" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/INVAttributes.ascx" TagName="INVAttributes"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Quick Stock Receive</title>
    <style>
    #innerDiv{display:none !important;}
    .ww-300{width:300px;}
    .right0{
        right: 0;
    }
    </style>
    
     <script src="Scripts/QuickStockReceived.js" type="text/javascript"></script>
 
</head>
<body onkeydown="return checkShortcut();">
    <form id="prFrm" defaultbutton="btnFinish" runat="server">
    <asp:ScriptManager ID="ScriptManager2" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
     <script language="javascript" type="text/javascript">
         var ErrorMsg = SListForAppMsg.Get("QuickStockReceived_Error") == null ? "Alert" : SListForAppMsg.Get("QuickStockReceived_Error");
         var infromMsg = SListForAppMsg.Get("QuickStockReceived_Information") == null ? "Information" : SListForAppMsg.Get("QuickStockReceived_Information");
         var OkMsg = SListForAppMsg.Get("QuickStockReceived_Ok") == null ? "Ok" : SListForAppMsg.Get("QuickStockReceived_Ok");
         var CancelMsg = SListForAppMsg.Get("QuickStockReceived_Cancel") == null ? "Cancel" : SListForAppMsg.Get("QuickStockReceived_Cancel");
    </script>
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
<script language="javascript" type="text/javascript">

    //-------------Mani--------
    $(document).ready(function() {
        if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'QuickStockReceived') {
            $("#Attuneheader_TopHeader1_lblvalue").text("Quick Stock Receive");
        }
    });
    //----------End------------
    $(document).ready(function() {
        lstProductList = [];
        var AppInterval = $("input[id$=hdnshowintervel]").val();
        setTimeout(fnSaveAsDrafts, AppInterval);
        if ($("#hdnProductList").val() != "") {
            lstProductList = JSON.parse($("#hdnProductList").val());
            Tblist();
        }
    });
    function fnSaveAsDrafts(SaveMetod) {

        $('#hdnDaftMethod').val(SaveMetod);
        if (SaveMetod == 'ManualSave') {
            fnShowProgress();
        }
        var draftValue = $('#ddlSupplier').val();
        var draftData =escape($("#hdnProductList").val());
        var hdnLoginLocationID = $("#hdnLoginLocationID").val();
        var hdnPageID = $("#hdnPageID").val();
        var hdnLoginID = $("#hdnLoginID").val();
        var hdnOrgID = $("#hdnOrgId").val();

        if (draftValue > 0) {
            $.ajax({
                type: "POST",
                url: "../InventoryCommon/WebService/InventoryWebService.asmx/SaveASDraft",
                data: "{ 'OrgID':<%=OrgID%>,'LocationID':<%=InventoryLocationID%>,'PageID':<%=PageID%>,'LoginID':<%=LID%>,'DraftType':'QuickStockReceived','DraftValue':" + draftValue + ",'DraftData':'" + draftData + "'}",
                //data: '{OrgID:"' + hdnOrgID + '",LocationID:"' + hdnLoginLocationID + '",PageID:"' + hdnPageID + '",LoginID:"' + hdnLoginID + '",DraftType:"QuickStockReceived",DraftValue:"' + draftValue + '",DraftData:"' + draftData + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function(response) {
                    ValidationWindow(response.d, ErrorMsg);
                    fnHideProgress();
                }
            });
        }
        if (SaveMetod != 'ManualSave') {
            var AppInterval = $("input[id$=hdnshowintervel]").val();
            setTimeout(fnSaveAsDrafts, AppInterval);
        }
    }
    function OnSuccess(response) {
        // alert(response.d);
        fnHideProgress();
        if ($('#hdnDaftMethod').val() == 'ManualSave') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_01") == null ? "Saved Successfully!!!" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_01");
            ValidationWindow(userMsg, infromMsg);
        }

        $('#hdnDaftMethod').val('');
    }
</script>

<script type="text/javascript" language="javascript">
    var userMsg;
    
  /*  function DynamicTable(id) {
        if (document.getElementById('hdnProductList').value != "") {
            var aRRlist = document.getElementById('hdnProductList').value.split("^");
            document.getElementById('hdnProductList').value = "";
            for (i = 0; i < aRRlist.length; i++) {
                if (aRRlist[i] != "") {
                    y = aRRlist[i].split('~');
                    var totalCP = (parseFloat(y[6]) * parseFloat(y[12])).toFixed(2);
                    var Disc = parseFloat(parseFloat(parseFloat(totalCP) / parseFloat(100)) * parseFloat(y[14])).toFixed(2);
                    var total = parseFloat(parseFloat(totalCP) - parseFloat(Disc)).toFixed(2);
                    var compQtyTotal = (parseFloat(y[11]) * parseFloat(y[12])).toFixed(2);
                    //var IsReqComplQTYCalc = document.getElementById('hdnREQCalcCompQTY').value;
                    var IsReqComplQTYCalc = ToInternalFormat($('#hdnREQCalcCompQTY'));
                    if (id == 'chkIntax') {
                        var tax = parseFloat(parseFloat(parseFloat(total) / parseFloat(100)) * parseFloat(y[15])).toFixed(2);
                        if (IsReqComplQTYCalc == "Y") {
                            var compQtyTax = parseFloat(parseFloat(parseFloat(compQtyTotal) / parseFloat(100)) * parseFloat(y[15])).toFixed(2);
                        }
                        else {
                            compQtyTax = 0;
                        }
                        y[20] = (parseFloat(total) + parseFloat(tax) + parseFloat(compQtyTax)).toFixed(2);
                    }
                    else {
                        var totalSP = (parseFloat(y[6]) * parseFloat(y[13])).toFixed(2);
                        var TotalCompQtySP = (parseFloat(y[11]) * parseFloat(y[13])).toFixed(2);
                        var taxmrp = parseFloat(parseFloat(parseFloat(totalSP) / parseFloat(100 + parseFloat(y[15]))) * parseFloat(y[15])).toFixed(2);
                        if (IsReqComplQTYCalc == "Y") {

                            var CompQtymrp = parseFloat(parseFloat(parseFloat(TotalCompQtySP) / parseFloat(100 + parseFloat(y[15]))) * parseFloat(y[15])).toFixed(2);

                        }
                        else {

                            CompQtymrp = 0;
                        }
                        y[20] = (parseFloat(total) + parseFloat(taxmrp) + parseFloat(CompQtymrp)).toFixed(2);
                    }
                    document.getElementById('hdnProductList').value += y[0] + "~" +
                                                                    y[1] + "~" +
                                                                    y[2].replace(exp, "") + "~" +
                                                                    y[3] + "~" +
                                                                    y[4] + "~" +
                                                                    y[5] + "~" +
                                                                    y[6] + "~" +
                                                                    y[7] + "~" +
                                                                    y[8] + "~" +
                                                                    y[9] + "~" +
                                                                    y[10] + "~" +
                                                                    y[11] + "~" +
                                                                    y[12] + "~" +
                                                                    y[13] + "~" +
                                                                    y[14] + "~" +
                                                                    y[15] + "~" +
                                                                    y[16] + "~" +
                                                                    y[17] + "~" +
                                                                    y[18] + "~" +
                                                                    y[19] + "~" +
                                                                    y[20] + "~" +
                                                                    y[21] + "~" +
                                                                    y[22] + "~" +
                                                                    y[23] + "~" +
                                                                    y[24] + "~" +
                                                                    y[25] + "~" +
								                                     y[26] + "~" +
                                                                    y[27] + "^";
                }
            }
            Tblist();
        }
        TotalCalculation();
        if (document.getElementById('txtTotalCost').value == "NaN") {
            document.getElementById('txtTotalCost').value = '0.00';
            ToTargetFormat($("#txtTotalCost"));
        }
    } */
    ///////////////////////////////////////////////////////////////////    
    function Chkclick(id) {
        if (id == 'chkIntax') {
            document.getElementById('chkExtax').checked = false;
            document.getElementById('chkIntax').checked = true;
            if (document.getElementById('hdnProductList').value != "")
                DynamicTable(id);
            else
                TotalCalculation();
        }
        if (id == 'chkExtax') {
            document.getElementById('chkIntax').checked = false;
            document.getElementById('chkExtax').checked = true;
            if (document.getElementById('hdnProductList').value != "")
                DynamicTable(id);
            else
                TotalCalculation();
        }
    }
    ////////////////////////////////////////////////////////
    function KeyPress1(e) {
        var ddlaction = document.getElementById('ddlSupplier');
        if (ddlaction.options[ddlaction.selectedIndex].value == '0') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_02") == null ? "Select a Supplier" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_02");
            ValidationWindow(userMsg, ErrorMsg);
            return false;
        }

        var Type = 'DC';
        var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
        $find('AutoCompleteDcNumber').set_contextKey(s1val);
    }
    function KeyPress2(e) {
        var ddlaction = document.getElementById('ddlSupplier');
        if (ddlaction.options[ddlaction.selectedIndex].value == '0') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_02") == null ? "Select a Supplier" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_02");
            ValidationWindow(userMsg, ErrorMsg);
            return false;
        }

        var Type = 'INVOICE';
        var s1val = ddlaction.options[ddlaction.selectedIndex].value + '~' + Type;
        $find('AutoCompleteInvoiceNumber').set_contextKey(s1val);
    }
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



/*
    function Tblist() {
        //recalldatepicker();
        //recalltimepicker();
        $('#lblBatchNo').text(slist.BatchNo);
        $('#lblCostPrice').text(slist.CostPrice);
        $('#lblNominal').text(slist.Nominal);
        $('#lblDiscou').text(slist.Discount);
        $('#lblSellingPrice').text(slist.SellingPrice);
        $('#lblMRP').text(slist.MRP);
        $('#lblRakNo').text(slist.RakNo);
        $('#lblTotalCost').text(slist.TotalCost);
        $('#lblRcvdQty').text(slist.RcvdQty);
        $('#lblselling').text(slist.sellingUnit);
        $('#lblInversQty').text(slist.InverseQty);
        $('#lblRcdLSUQty').text(slist.RcvdQty_lsu);
		 $('#lblPurchaseTax').text(slist.PurchaseTax);
        $('#TableCollectedItems').removeClass().addClass('w-100p gridView');

        while (count = document.getElementById('TableCollectedItems').rows.length) {

            for (var j = 0; j < document.getElementById('TableCollectedItems').rows.length; j++) {
                document.getElementById('TableCollectedItems').deleteRow(j);

            }
        }
        var Headrow = document.getElementById('TableCollectedItems').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.className = "bold";
        Headrow.className = "gridHeader"
        var cell20;
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
        cell20 = Headrow.insertCell(13);
        var cell14 = Headrow.insertCell(14);
        var cell15 = Headrow.insertCell(15);
        var cell16 = Headrow.insertCell(16);
        var cell17 = Headrow.insertCell(17);
        var cell18 = Headrow.insertCell(18);
        var cell19 = Headrow.insertCell(19);

        cell1.innerHTML = slist.sno;
        cell2.innerHTML = slist.ProductName;
        cell3.innerHTML = slist.BatchNo;
        cell4.innerHTML = slist.Date;
        cell5.innerHTML = slist.RcvdQty;
        cell6.innerHTML = slist.sellingUnit;
        cell7.innerHTML = slist.InverseQty;
        cell8.innerHTML = slist.RcvdQty_lsu;
        cell9.innerHTML = slist.CompQty;
        cell10.innerHTML = slist.CostPrice;
        cell11.innerHTML = slist.Nominal;
        cell12.innerHTML = slist.Discount;
        cell13.innerHTML = slist.Tax;
        cell14.innerHTML = slist.SellingPrice;
        cell15.innerHTML = slist.Ex_percent;
        cell16.innerHTML = slist.MRP;
        cell17.innerHTML = slist.RakNo;
        cell18.innerHTML = slist.TotalCost;
        cell19.innerHTML = slist.Action;
        cell20.innerHTML = slist.PurchaseTax ;
        //Tax Hide for Vasan
        if ($("#hdnHideTax").val() == "Y") {
            cell13.hidden = true;
            cell15.hidden = true;
            cell20.hidden=true;
        }
        //Tax Hide for Vasan 
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

        document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
        ToTargetFormat($("#lblTotalCostAmount"));
        document.getElementById('txtGrandTotal').value = '0.00';
        ToTargetFormat($("#txtGrandTotal"));
        document.getElementById('txtNetTotal').value = '0.00';
        ToTargetFormat($("#txtNetTotal"));
        document.getElementById('txtGrandwithRoundof').value = '0.00';
        ToTargetFormat($("#txtGrandwithRoundof"));
        document.getElementById('txtRoundOffValue').value = '0.00';
        ToTargetFormat($("#txtRoundOffValue"));
        document.getElementById('txtTotalDiscountAmt').value = '0.00';
        ToTargetFormat($("#txtTotalDiscountAmt"));
        document.getElementById('txtTotalTaxAmt').value = '0.00';
        ToTargetFormat($("#txtTotalTaxAmt"));
        document.getElementById('hdnTotalCost').value = '0';
        ToTargetFormat($("#hdnTotalCost"));
        //document.getElementById('hdnAvailableCreditAmount').value 
        if (Number($('#hdnAvailableCreditAmount').val()) > 0 && ToInternalFormat($('#hdnAvailableCreditAmount')) != '0.00') {
            document.getElementById('txtAvailCreditAmount').value = parseFloat(ToInternalFormat($("#hdnAvailableCreditAmount"))).toFixed(2);
            ToTargetFormat($("#txtAvailCreditAmount"));
        }
        else document.getElementById('txtAvailCreditAmount').value = '0.00';
        document.getElementById('txtUseCreditAmount').value = 0.00;
        if (parseFloat(ToInternalFormat($('#hdnAvailableCreditAmount'))) > 0)
            document.getElementById('txtUseCreditAmount').diabled = false;
        else
            document.getElementById('txtUseCreditAmount').disabled = true;

        if (aRRlist.length == 1) {
            document.getElementById('ddlStockReceivedType').disabled = false;
        }

        for (i = aRRlist.length - 1; 0 < i; i--) {
            if (aRRlist[i] != "") {
                y = aRRlist[i].split('~');
                var row = document.getElementById('TableCollectedItems').insertRow(1);
                row.style.height = "13px";
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
                cell20 = row.insertCell(13);
                var cell14 = row.insertCell(14);
                var cell15 = row.insertCell(15);
                var cell16 = row.insertCell(16);
                var cell17 = row.insertCell(17);
                var cell18 = row.insertCell(18);
                var cell19 = row.insertCell(19);

                cell1.innerHTML = i;
                cell2.innerHTML = y[2]; //Produt Name
                cell3.innerHTML = y[3]; //Batch No
                var dateMFT = ToInternalMonth(y[4]);
                var dateEXP = ToInternalMonth(y[5]);
                cell4.innerHTML = "<table class='w-100p'><tr><td>MFT :" + ToExternalMonth(dateMFT) + "</td><td>EXP :" + ToExternalMonth(dateEXP) + "</td></tr></table>";
                cell4.width = "13%";
                cell5.innerHTML = y[6] + " (" + y[7] + ")";  // Rev qty + Rev Unit
                cell6.innerHTML = y[9];   //Sellling Unit
                cell7.innerHTML = y[8];   //Inve Qty
                cell8.innerHTML = y[10];  // Revd qty(LSU)
                cell9.innerHTML = y[11];  // Comp qty
                cell10.innerHTML = parseFloat(y[12]).toFixed(2);  // Cost Price
                cell11.innerHTML = y[27]; //---Nominal 
                cell12.innerHTML = y[14];  //Discount
                cell13.innerHTML = y[15];  // Tax 
                cell20.innerHTML=y[28];
                cell14.innerHTML =  parseFloat(y[13]).toFixed(2);  // Sellinng Price
                cell15.innerHTML = y[25];   // Ex
                cell16.innerHTML = parseFloat(y[23]).toFixed(2);   // MRP
                cell17.innerHTML = y[22];  // Rak No
                cell18.innerHTML = y[20];  // Total Cost
                cell19.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] +"~"+y[28]+ "' onclick='btnEdit_OnClick(name);' value = '' type='button' title='Click to Edit'  class='pull-left marginR5 ui-icon ui-icon-pencil cursor'   />" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] + "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] +"~"+y[28]+ "' onclick='btnDelete(name);' value = '' type='button' title='Click to Delete'  class='pull-left ui-icon ui-icon-trash cursor'   />";


                document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(y[20]) + parseFloat(ToInternalFormat($("#lblTotalCostAmount")))).toFixed(2);
                ToTargetFormat($("#lblTotalCostAmount"));
                document.getElementById('hdnTotalCost').value = parseFloat(parseFloat(y[20]) + parseFloat(ToInternalFormat($("#hdnTotalCost")))).toFixed(2);
                ToTargetFormat($("#hdnTotalCost"));
                document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(y[20]) + parseFloat(ToInternalFormat($("#txtGrandTotal")))).toFixed(2);
                ToTargetFormat($("#txtGrandTotal"));
                document.getElementById('txtNetTotal').value = parseFloat(ToInternalFormat($("#txtGrandTotal"))).toFixed(2);
                ToTargetFormat($("#txtNetTotal"));
                document.getElementById('txtGrandwithRoundof').value = ToInternalFormat($("#txtNetTotal"));
                ToTargetFormat($("#txtGrandwithRoundof"));
                var totalNominal = parseFloat(parseFloat(y[6]) * parseFloat(y[27])).toFixed(2);
                document.getElementById('hdnfdisplaydata').value = y[12];
                var Cost = ToInternalFormat($('#hdnfdisplaydata'));
                document.getElementById('txtTotalDiscountAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalDiscountAmt"))) + parseFloat(parseFloat(parseFloat(y[14]) / 100) * (parseFloat(Cost - parseFloat(y[27])) * parseFloat(y[6])))).toFixed(2);
                ToTargetFormat($("#txtTotalDiscountAmt"));
                var SubDiscount = parseFloat(parseFloat(parseFloat(y[14]) / 100) * parseFloat(parseFloat(y[12]) * parseFloat(y[6]))).toFixed(2);
                var InclusiveTax = document.getElementById('chkIntax').checked ? "Y" : "N";
                //var IsReqComplQTYCalc = document.getElementById('hdnREQCalcCompQTY').value;
                var IsReqComplQTYCalc = ToInternalFormat($('#hdnREQCalcCompQTY'));
                if (InclusiveTax == "Y") {
                if(y[28]>0)
                        {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) + 
                        parseFloat(parseFloat(parseFloat(y[28]) / 100) * 
                        (parseFloat(parseFloat(parseFloat(y[12]) * parseFloat(y[6])) - parseFloat(SubDiscount))))).toFixed(2);
                        }
                        else
                        {
                    document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) + parseFloat(parseFloat(parseFloat(y[15]) / 100) * (parseFloat(parseFloat(parseFloat(y[12]) * parseFloat(y[6])) - parseFloat(SubDiscount))))).toFixed(2);
                    }
                    if (IsReqComplQTYCalc == "Y") {
                    if(y[28]>0)
                        {
                         document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                          parseFloat(parseFloat(parseFloat(y[28]) / (100)) 
                         * (parseFloat(parseFloat(parseFloat(y[16]) * parseFloat(y[11])))))).toFixed(2);
                        }
                        else
                        {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) + parseFloat(parseFloat(parseFloat(y[15]) / (100)) * (parseFloat(parseFloat(parseFloat(y[16]) * parseFloat(y[11])))))).toFixed(2);
                    }
                    }
                }
                else {
                if(y[28]>0)
                        {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) +
                         parseFloat(parseFloat(parseFloat(y[28]) / (100 + parseFloat(y[15]))) 
                        * (parseFloat(parseFloat(parseFloat(y[13]) * parseFloat(y[6])) - parseFloat(SubDiscount))))).toFixed(2);
                        }
                        else
                        {
                    document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) + parseFloat(parseFloat(parseFloat(y[15]) / (100 + parseFloat(y[15]))) * (parseFloat(parseFloat(parseFloat(y[13]) * parseFloat(y[6])) - parseFloat(SubDiscount))))).toFixed(2);
                    }
                    if (IsReqComplQTYCalc == "Y") {
                    if(y[28]>0)
                        {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) + 
                        parseFloat(parseFloat(parseFloat(y[28]) / (100 + parseFloat(y[28]))) * (parseFloat(parseFloat(parseFloat(y[17]) * 
                        parseFloat(y[11])))))).toFixed(2); //     compqty*price*tax/100
                        }
                        else
                        {
                        document.getElementById('txtTotalTaxAmt').value = parseFloat(parseFloat(ToInternalFormat($("#txtTotalTaxAmt"))) + parseFloat(parseFloat(parseFloat(y[15]) / (100 + parseFloat(y[15]))) * (parseFloat(parseFloat(parseFloat(y[17]) * parseFloat(y[11])))))).toFixed(2); //     compqty*price*tax/100
                    }
                    }
                }
                ToTargetFormat($("#txtTotalTaxAmt"));
                var s = parseFloat(parseFloat(parseFloat(y[12]) * parseFloat(y[6])) - parseFloat(parseFloat(parseFloat(y[14]) / 100) * parseFloat(parseFloat(Cost - parseFloat(y[27])) * parseFloat(y[6])))).toFixed(2);
                //Tax Hide for Vasan
                if ($("#hdnHideTax").val() == "Y") {
                    cell13.hidden = true;
                    cell15.hidden = true;
                    cell20.hidden=true;
                }
                //Tax Hide for Vasan  
            }
        }

        if (aRRlist.length == 0) {
            //document.getElementById('submitTab').style.display = "hide";
            $('#submitTab').removeClass().addClass('hide');

        }
        else {
            //document.getElementById('submitTab').style.display = "table";
            $('#submitTab').removeClass().addClass('displaytb w-100p');
        }
        //document.getElementById('tblPODetail').style.display = "table";
        $('#tblPODetail').removeClass().addClass('w-100p displaytb');
        //document.getElementById('TableCollectedItems').style.display = "table";
        //$('#TableCollectedItems').removeClass().addClass('w-100p displaytb');
        CSTCalculation();

    }


    function CSTCalculation() {
        document.getElementById('txtCST').value = 0.00;
        ToTargetFormat($('#txtCST'));
        var x = document.getElementById('hdnProductList').value.split("^");
        var TotalSales = 0;
        var TotalExcise = 0;
        var CstCalSales = 0
        var p1 = 0;
        var p2 = 0;
        var p3 = 0;
        var pNominal = 0;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');
                pNominal = 0;
                document.getElementById('hdnfdisplaydata').value = y[6];
                p1 = ToInternalFormat($('#hdnfdisplaydata'));
                document.getElementById('hdnfdisplaydata').value = y[12];
                p2 = ToInternalFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[25];
                p3 = ToInternalFormat($('#hdnfdisplaydata'));

                document.getElementById('hdnfdisplaydata').value = y[27];
                pNominal = ToInternalFormat($('#hdnfdisplaydata'));

                var tot = p2 - pNominal;


                TotalSales = TotalSales + (tot * p1);
                if (p3 > 0) {
                    CstCalSales = CstCalSales + (tot * p1);
                    TotalExcise = TotalExcise + (((tot * p1) * p3) / 100)
                }
            }
        }
        document.getElementById('txtTotalSales').value = parseFloat(TotalSales).toFixed(2);
        ToTargetFormat($("#txtTotalSales"));
        document.getElementById('txtTotalExcise').value = parseFloat(TotalExcise).toFixed(2);
        ToTargetFormat($("#txtTotalExcise"));

        document.getElementById('txtCessOnExcise').value = parseFloat((TotalExcise * 2) / 100).toFixed(2);
        ToTargetFormat($("#txtCessOnExcise"));
        document.getElementById('txtHighterEdCess').value = parseFloat((TotalExcise * 1) / 100).toFixed(2);
        ToTargetFormat($("#txtHighterEdCess"));
        if (TotalExcise > 0 && TotalSales > 0) {
            document.getElementById('txtCST').value = parseFloat(((CstCalSales + TotalExcise + ((TotalExcise * 2) / 100) + ((TotalExcise * 1) / 100)) * 5) / 100).toFixed(2);
            ToTargetFormat($("#txtCST"));
        }


    }
 */




    //document.onkeydown = checkShortcut;
    function checkShortcut() {
        if (typeof window.event != 'undefined')
            document.onkeydown = function() {
                if (event.srcElement.tagName.toUpperCase() != 'INPUT')
                    return (event.keyCode != 8);
            }
        else
            document.onkeypress = function(e) {
                if (e.target.nodeName.toUpperCase() != 'INPUT')
                    return (e.keyCode != 8);
            }
    }
    function SupplierListPopup(obj) {
        var suplstpopup = "SupplierList.aspx?pID=" + obj + "&sID=0";
        newwindow = window.open(suplstpopup, 'Supplier_List', 'height=450,width=790,scrollbars=yes');
        newwindow.focus();
    }
    function SupplierListPopup() {
            var obj = document.getElementById('hdnproductId').value;    
             var SupplierList = "../InventoryMaster/SupplierList.aspx?pID=" + obj + "&sID=" + $('#ddlSupplier').val() + "&IsPopup=Y";
             newwindow = window.open(SupplierList, 'Supplier_List', 'height=450 width=800 scrollbars=yes');
             newwindow.focus();
             //return false;

//        var suplstpopup = "SupplierList.aspx?pID=" + obj + "&sID=" + document.getElementById('ddlSupplier').value + "&IsPopup=Y";
//        window.showModalDialog(suplstpopup, 'Supplier_List', "dialogHeight:460px;dialogWidth: 790px; dialogTop: 286px; edge: Raised; center: Yes; resizable: Yes; status: No;");
    }

    
</script>

<script type="text/javascript" language="javascript">


    function CalRounfOff() {
        // //debugger;
        var GrandwithRoundof = ToInternalFormat($("#txtGrandwithRoundof"));
        var NetTotal = ToInternalFormat($("#txtNetTotal"));
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
            ToTargetFormatWOR($("#txtRoundOffValue"));
            return true;
        }
        else {
            document.getElementById('txtGrandwithRoundof').value = NetTotal;
            ToTargetFormatWOR($("#txtGrandwithRoundof"));
            document.getElementById('txtRoundOffValue').value = 0.00;
            ToTargetFormatWOR($("#txtRoundOffValue"));
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

    function GetProductsAttributes() {
        var GetValue = '';
        $("#divProductAttributes table tr").each(function() {
            var tr = $(this).closest("tr");
            $(tr).children('td').each(function(i) {
                var td = $(this).closest("td");
                if ($(this).children().attr('type') == 'checkbox') {
                    var id = $(this).children().attr('id');
                    var chk = document.getElementById(id).checked == true ? "Y" : "N";
                    GetValue += id + '~' + chk + '#';
                }
                else if ($(this).children().attr('type') == 'text') {
                    var id = $(this).children().attr('id');
                    var value = document.getElementById(id).value;
                    GetValue += id + '~' + value + '#';
                }
                else if ($(this).children().attr('type') == 'dropdownlist') {
                    var id = $(this).children().attr('id');
                    var value = document.getElementById(id).value;
                    GetValue += id + '~' + value + '#';
                }
            });

        });

        $('#hdnProductAttributes').val(GetValue);
    }

    function SetProductsAttributes() {
        var GetValue = $('#hdnProductAttributes').val().split('#');

        for (var i = 0; i < GetValue.length; i++) {
            if (GetValue[i] != "") {
                var ArrayValue = GetValue[i].split('~');
                var id = ArrayValue[0] + '~' + ArrayValue[1];

                if (document.getElementById(id).type == 'checkbox') {
                    document.getElementById(id).checked = ArrayValue[2] == "Y" ? true : false;
                }
                else if (document.getElementById(id).type == 'text') {
                    document.getElementById(id).value = ArrayValue[2];
                }
                else if (document.getElementById(id).type == 'dropdownlist') {
                    document.getElementById(id).value = ArrayValue[2];
                }
            }
        }
    }

    function SetTax() {
        var GetValue = $('#hdnCatTax').val().split('#');
        for (var i = 0; i < GetValue.length; i++) {
            if (GetValue[i] != "") {
                var ArrayValue = GetValue[i].split('~');
                if ($('#<%= ddlCategory.ClientID %>').val() == ArrayValue[0]) {
                    $('#<%= TxtProdTax.ClientID %>').val(parseFloat(ArrayValue[1]).toFixed(2));
                    $('#hdnGetTax').val(parseFloat(ArrayValue[1]).toFixed(2));
                    ToTargetFormatWOR($("#TxtProdTax"));
                    ToTargetFormatWOR($("#hdnGetTax"));
                    break;
                }
            }
        }

    }
    function doValidatePercent(obj) {
        if (Number(obj.value) > 100) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_03") == null ? "percentage must between 0 to 100" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_03");
            ValidationWindow(userMsg, ErrorMsg);
            obj.value = "0.00";
            obj.select();
        }
        $('#hdnGetTax').val(Number(obj.value));
        return false;
    }

</script>

<script type="text/javascript" language="javascript">
    var slist = { sno: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_07 %>',
        ProductName: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_08 %>',
        BatchNo: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_09 %>',
        Date: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_10 %>',
        RcvdQty: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_11%>',
        sellingUnit: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_12 %>',
        InverseQty: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_13 %>',
        RcvdQty_lsu: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_14 %>',
        CompQty: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_15 %>',
        CostPrice: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_16 %>',
        Discount: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_17 %>',
        Tax: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_18 %>',
        SellingPrice: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_19 %>',
        Ex_percent: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_20 %>',
        MRP: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_21 %>',
        RakNo: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_22 %>',
        TotalCost: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_23 %>',
        Action: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_24 %>',
        Nominal: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_25 %>',
        PurchaseTax: '<%= Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_31 %>'
       
    };
</script>

<script language="javascript" type="text/javascript">
    function ChkDcSupplierCombination(source, eventArgs) {
        var supplierid = eventArgs.get_value();
        var ddl = document.getElementById('ddlSupplier');
        if (supplierid == ddl.options[ddl.selectedIndex].value) {
            DCAlert();
        }
    }
    function ChkInvoiceSupplierCombination(source, eventArgs) {
        var supplierid = eventArgs.get_value();
        var ddl = document.getElementById('ddlSupplier');
        if (supplierid == ddl.options[ddl.selectedIndex].value) {
            InvoiceAlert();
        }
    }
    function DCAlert() {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_04") == null ? "This combination of Supplier name & DC No Already exists. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_04");
        var DC = ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg);
        if (DC == true) {
            document.getElementById('ddlStockReceivedType').focus();
        }
        else {
            document.getElementById('txtDCNumber').value = "";
            //document.getElementById('txtInvoiceNo').value = "";
        }
    }
    function InvoiceAlert() {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_05") == null ? "This combination of Supplier name & Invoice No Already exists. Do you want to continue!Click 'OK'" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_05");
        var Invoice = ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg);
        if (Invoice == true) {
            document.getElementById('ddlStockReceivedType').focus();
        }
        else {
            //document.getElementById('txtDCNumber').value = "";
            document.getElementById('txtInvoiceNo').value = "";
        }
    }
    function setContextKey() {
      $find('AutoCompleteProduct').set_contextKey('N');    
    if($('#ChkIsConsign').prop('checked'))
        $find('AutoCompleteProduct').set_contextKey('Y');
    }
    /*Colour change for Trusted Drugs start*/
    function SetColor() {

        var completionList = $find("AutoCompleteProduct").get_completionList().childNodes;
        var HighlightProduct = '';
        var _Color = '';
        for (var i = 0; i < completionList.length; i++) {
            _Color = completionList[i]._value.split('|');
            if (_Color != undefined && _Color != '') {
                HighlightProduct = _Color[23];
            } else {
                HighlightProduct = 'N';
            }
            if (HighlightProduct == 'Y') {
                completionList[i].style.color = "orange";
            }
        }
    }
    /*Colour change for Trusted Drugs End*/
/*
    function IAmSelected(source, eventArgs) {
        // alert(eventArgs.get_text() + "=>" + eventArgs.get_value());
        //document.getElementById('tdheadLSU').style.display = 'show';
        $('#tdheadLSU').removeClass().addClass('show');
        //document.getElementById('tdShowLSU').style.display = 'show';
        $('#tdShowLSU').removeClass().addClass('show');

        var arrDBVal = eventArgs.get_value().split('|');
        var pProductID = arrDBVal[0];
        var pProductName = arrDBVal[1];
        var pBatchno = arrDBVal[2];
        var pManufacture = arrDBVal[3];
        var pExpDate = arrDBVal[4];
        var pRecQty = arrDBVal[5];
        var pRecUnit = arrDBVal[6];
        var pInverseQty = arrDBVal[7];
        var pSellingUnit = arrDBVal[8];
        var pRecLSUQty = arrDBVal[9];
        var pCompQty = arrDBVal[10];
        var pUnitPrice = arrDBVal[11];
        var pSellingPrice = arrDBVal[12];
        var pDiscount = arrDBVal[13];
        var pTax = arrDBVal[14];
        var pUnitCostPrice = arrDBVal[15];
        var pUnitSellingPrice = arrDBVal[16];
        var pHasBatch = arrDBVal[17];
        var pHasExpiry = arrDBVal[18];
        var pRakNo = arrDBVal[19];
        var pMRP = arrDBVal[20];
        var pExTax = arrDBVal[21];
        var pParentProductID = arrDBVal[22];
        var pNominal = arrDBVal[23];
        var lblLSUValue = arrDBVal[24];
        document.getElementById('txtRakNo').value = pRakNo;
        document.getElementById('txtTax').value = pTax;
        if (pBatchno != "No Batch Found") {
            document.getElementById('hdnproductId').value = pProductID;
            document.getElementById('hdnProductName').value = pProductName.replace(exp, "");
            document.getElementById('txtBatchNo').value = "";
            document.getElementById('txtMFTDate').value = "";
            document.getElementById('txtEXPDate').value = "";
            if (pHasBatch != "N") {
                document.getElementById('txtBatchNo').value = pBatchno;

            }
            if (pHasExpiry != "N") {
                document.getElementById('txtEXPDate').value = pExpDate;
                document.getElementById('txtMFTDate').value = pManufacture;
            }
            document.getElementById('txtBatchNo').focus();
            document.getElementById('txtRECQuantity').value = pRecQty;
            ToTargetFormat($("#txtRECQuantity"));
            document.getElementById('ddlRcvdUnit').value = pRecUnit.trim() == "" ? "0" : pRecUnit;
            // ToTargetFormat($("#ddlRcvdUnit"));
            document.getElementById('ddlSelling').value = pSellingUnit;
            //ToTargetFormat($("#ddlSelling"));
            document.getElementById('txtUnitPrice').value = parseFloat(pUnitPrice).toFixed(2);
            ToTargetFormat($("#txtUnitPrice"));
            var pType = document.getElementById('ddlStockReceivedType').options[document.getElementById('ddlStockReceivedType').selectedIndex].text;
            if (pType == 'FreeProduct') {
                document.getElementById('txtUnitPrice').value = 0.00;
                ToTargetFormat($("#txtUnitPrice"));
                document.getElementById('txtUnitPrice').readOnly = true;
            }
            document.getElementById('txtTotalCost').value = 0.00;
            ToTargetFormat($("#txtTotalCost"));
            document.getElementById('txtTotalCost').readOnly = true;

            document.getElementById('txtCompQuantity').value = pCompQty;
            ToTargetFormat($("#txtCompQuantity"));
            document.getElementById('txtTax').value = pTax;
            ToTargetFormat($("#txtTax"));
            document.getElementById('txtDiscount').value = pDiscount;
            ToTargetFormat($("#txtDiscount"));
            document.getElementById('add').value = 'Add';
            document.getElementById('hdnUnitCostPrice').value = pUnitCostPrice;
            ToTargetFormat($("#hdnUnitCostPrice"));
            document.getElementById('hdnUnitSellingPrice').value = pUnitSellingPrice;
            ToTargetFormat($("#hdnUnitSellingPrice"));
            document.getElementById('hdnAdd').value = 'Add';

            document.getElementById('txtSellingPrice').value = parseFloat(pUnitSellingPrice).toFixed(2);
            ToTargetFormat($("#txtSellingPrice"));
            document.getElementById('txtRcvdLSUQty').value = pRecLSUQty;
            ToTargetFormat($("#txtRcvdLSUQty"));
            document.getElementById('txtInvoiceQty').value = pInverseQty;
            ToTargetFormat($("#txtInvoiceQty"));
            document.getElementById('txtExTax').value = pExTax;
            ToTargetFormat($("#txtExTax"));

            document.getElementById('txtRcvdLSUQty').readOnly = true;
            if (pRecUnit == 'Nos') {
                document.getElementById('ddlSelling').value = 'Nos';
                document.getElementById('txtInvoiceQty').value = 1;
                ToTargetFormat($("#txtInvoiceQty"));

                document.getElementById('txtInvoiceQty').disabled = true;
                document.getElementById('ddlSelling').disabled = true;
            }
            else {

                document.getElementById('txtInvoiceQty').disabled = false;
                document.getElementById('ddlSelling').disabled = false;
            }
            document.getElementById('hdnHasBatchNo').value = pHasBatch;
            document.getElementById('hdnHasExpiryDate').value = pHasExpiry;
            document.getElementById('txtRakNo').value = pRakNo;
            //ToTargetFormat($("#txtRakNo"));
            document.getElementById('txtMRP').value = pMRP;
            document.getElementById('lblLSUValue').innerHTML = lblLSUValue;
            ToTargetFormat($("#txtMRP"));
            document.getElementById('hdnParentProductID').value = pParentProductID;
            document.getElementById('txtNominal').value = pNominal; //Nominal Discount
            ToTargetFormat($("#txtNominal"));

            TotalCalculation();
        } else {

            document.getElementById('hdnproductId').value = pProductID;
            document.getElementById('hdnProductName').value = pProductName.replace(exp, "");
            document.getElementById('txtBatchNo').value = "";
            document.getElementById('txtBatchNo').focus();
            document.getElementById('txtEXPDate').value = "";
            document.getElementById('txtMFTDate').value = "";
            document.getElementById('txtRECQuantity').value = "";
            //document.getElementById('ddlRcvdUnit').value = 0;
            document.getElementById('ddlRcvdUnit').value = pRecUnit.trim() == "" ? "0" : pRecUnit;
            // document.getElementById('ddlSelling').value = 0;
            document.getElementById('ddlSelling').value = pSellingUnit;
            document.getElementById('txtUnitPrice').value = "";

            document.getElementById('txtTotalCost').value = "0.00";
            ToTargetFormat($("#txtTotalCost"));

            document.getElementById('txtTotalCost').readOnly = true;

            document.getElementById('txtCompQuantity').value = "";
            //document.getElementById('txtTax').value = "";
            document.getElementById('txtTax').value = pTax;
            document.getElementById('txtDiscount').value = "";
            document.getElementById('add').value = 'Add';
            document.getElementById('hdnUnitCostPrice').value = "";
            document.getElementById('hdnUnitSellingPrice').value = "";

            document.getElementById('hdnAdd').value = 'Add';

            document.getElementById('txtSellingPrice').value = "";
            document.getElementById('txtRcvdLSUQty').value = "";
            document.getElementById('txtInvoiceQty').value = "";
            // document.getElementById('txtRakNo').value = "";
            document.getElementById('txtMRP').value = "";
            document.getElementById('txtExTax').value = "";
            document.getElementById('txtInvoiceQty').disabled = false;
            document.getElementById('ddlSelling').disabled = false;
            document.getElementById('hdnHasBatchNo').value = pHasBatch;
            document.getElementById('hdnHasExpiryDate').value = pHasExpiry;
            document.getElementById('hdnParentProductID').value = pParentProductID;
            document.getElementById('txtNominal').value = "";
            document.getElementById('lblLSUValue').innerHTML = lblLSUValue;

        }
        //document.getElementById('btnPopUp').style.display = 'show';
        $('#btnPopUp').removeClass().addClass('hide');
        document.getElementById('hdnType').value = '';
        document.getElementById('btnAddNew').focus();
    }
 */
    function doEnableSellingUnit() {

        if (document.getElementById('ddlSelling').value != document.getElementById('ddlRcvdUnit').value) {
            document.getElementById('txtInvoiceQty').disabled = false;
            document.getElementById('ddlSelling').disabled = false;


        }
        if (document.getElementById('ddlSelling').value == document.getElementById('ddlRcvdUnit').value) {
            document.getElementById('txtInvoiceQty').value = "0";
            ToTargetFormatWOR($("#txtInvoiceQty"));
            document.getElementById('ddlSelling').value = 0;
            document.getElementById('txtRcvdLSUQty').value = "0";
            ToTargetFormatWOR($("#txtRcvdLSUQty"));
        }
    }
    function CheckInverseQty() {
        var pRECUnit = document.getElementById('ddlRcvdUnit').value;
        var pSellingUnit = document.getElementById('ddlSelling').value; // document.getElementById('ddlSelling').value
        if (pRECUnit == pSellingUnit) {
            document.getElementById('txtInvoiceQty').value = 1;
            ToTargetFormatWOR($("#txtInvoiceQty"));
            document.getElementById('txtInvoiceQty').disabled = true;
            document.getElementById('txtRcvdLSUQty').readOnly = true;
        }
        else {
            document.getElementById('txtInvoiceQty').value = '0.00';
            ToTargetFormatWOR($("#txtInvoiceQty"));
            document.getElementById('txtInvoiceQty').disabled = false;
            document.getElementById('txtRcvdLSUQty').readOnly = true;
        }
        CheckRcvdLSUQty();

    }
    function CheckRcvdLSUQty() {
        var pInvoiceQty = ToInternalFormat($("#txtInvoiceQty")); //document.getElementById('txtInvoiceQty').value;
        var pRECQuantity = ToInternalFormat($("#txtRECQuantity")); // document.getElementById('txtRECQuantity').value;
        document.getElementById('txtRcvdLSUQty').value = parseFloat(pInvoiceQty).toFixed(2) * parseFloat(pRECQuantity).toFixed(2);
        ToTargetFormatWOR($("#txtRcvdLSUQty"));
        TotalCalculation();
        if (isNaN(ToInternalFormat($("#txtRECQuantity")))) {
            document.getElementById('txtRcvdLSUQty').value = "";
        }
    }
    
   function Disctype() {
        TotalCalculation()
    };
    
    function Schemetype() {
        TotalCalculation()
    };


    function TotalCalculation() {

        var tempTaxAmt;
        var Total;
        var pDiscount;
        var pNominalDiscount;
        var pSchemeDiscount;
        var pTempTotalCost;
        
//        document.getElementById('hdnSchemeType').value = $('#<%=ddlSchemetype.ClientID %> option:selected').text();
//        document.getElementById('hdnDisctype').value = $('#<%=ddlDisctype.ClientID %> option:selected').text();
        
        var IsNeedSchemeInValue = $('#<%=ddlSchemetype.ClientID %> option:selected').val();
        var IsNeedDiscInValue = $('#<%=ddlDisctype.ClientID %> option:selected').val();

        pNominalDiscount = ToInternalFormat($("#txtNominal")) == "" ? 0 : ToInternalFormat($("#txtNominal"));
        calculateCastPerUnit();
        var UnitPrice1 = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));

        if (parseFloat(pNominalDiscount) > parseFloat(UnitPrice1)) {

            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_46") == null ? "Nominal amount greater than Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_46");
            ValidationWindow(userMsg, ErrorMsg);

            $("#txtNominal").val('0');
            return false
        }
        //var pExTax = document.getElementById('txtExTax').value =="" ? 0 : document.getElementById('txtExTax').value;
        var pExTax = ToInternalFormat($("#txtExTax")) == "" ? 0 : ToInternalFormat($("#txtExTax"));

        var tax = 0;
        if (pExTax != 0) {
            tax = pExTax;
            // document.getElementById('txtTax').disabled = true;
        }
        else {
            tax = ToInternalFormat($("#txtTax")) == 0.00 ? 0 : ToInternalFormat($("#txtTax"));
            // document.getElementById('txtTax').disabled = false;
        }

        var Discount = ToInternalFormat($("#txtDiscount")) == 0.00 ? 0 : ToInternalFormat($("#txtDiscount"));
        var SchemeDiscount = ToInternalFormat($("#txtSchemeDisc")) == 0.00 ? 0 : ToInternalFormat($("#txtSchemeDisc"));
        UnitPrice1 = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : document.getElementById('txtUnitPrice').value;
        var PurchaseTax=ToInternalFormat($('#txtPurchaseTax'))==0.00?0:ToInternalFormat($('#txtPurchaseTax'));
        if (document.getElementById('txtRcvdLSUQty').value == "NaN")
            document.getElementById('txtRcvdLSUQty').value = "0";
        var RECQuantity = ToInternalFormat($("#txtRcvdLSUQty")) == 0.00 ? 0 : ToInternalFormat($("#txtRcvdLSUQty"));
        var InclusiveTax = document.getElementById('chkIntax').checked ? "Y" : "N";
        if (document.getElementById('hdnUnitCostPrice').value == "NaN")
            document.getElementById('hdnUnitCostPrice').value = "0";
        var CompQuantity = ToInternalFormat($("#txtCompQuantity")) == 0.00 ? 0 : ToInternalFormat($("#txtCompQuantity"));
        var UnitPrice = ToInternalFormat($("#hdnUnitCostPrice")) == 0.00 ? 0 : ToInternalFormat($("#hdnUnitCostPrice"));

        var TotalCost = (parseFloat(RECQuantity) * parseFloat(UnitPrice)).toFixed(2);
        
        if($('#hdnIsSchemeDiscount').val() == "Y") {
            if(IsNeedSchemeInValue == 0){
              pSchemeDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(SchemeDiscount)).toFixed(2);
            }
            else{
              pSchemeDiscount = parseFloat(SchemeDiscount).toFixed(2);
            }
            
            TotalCost = parseFloat(parseFloat(TotalCost) - parseFloat(pSchemeDiscount)).toFixed(2);
        }
        else {
            TotalCost = parseFloat(TotalCost).toFixed(2);
        }
        
        if(IsNeedDiscInValue == 0){
           pDiscount = parseFloat(parseFloat(parseFloat(TotalCost) / parseFloat(100)) * parseFloat(Discount)).toFixed(2);
        }
        else {
           pDiscount = parseFloat(Discount).toFixed(2);
        }
                
        Total = parseFloat(parseFloat(TotalCost) - parseFloat(pDiscount)).toFixed(2);
        
        if (InclusiveTax == "Y") {
            //tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
                   // if(PurchaseTax>0)
                    //{
                    //tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(PurchaseTax)).toFixed(2);
                    //}
                   /* else
                    {
                    tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
                    }*/
            tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(2);
            if (document.getElementById('hdnREQCalcCompQTY').value == "Y") {
                //added for CompTax calculation
                var CompQtyCost = (parseFloat(CompQuantity) * parseFloat(UnitPrice)).toFixed(2);
                tempCompQtyTax = parseFloat(parseFloat(parseFloat(CompQtyCost) / parseFloat(100)) * parseFloat(PurchaseTax)).toFixed(2);

            }
            else {
                tempCompQtyTax = 0.00;
            }
        }
        else {
            btnCalcSellingPrice();
            var SP = ToInternalFormat($("#hdnUnitSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#hdnUnitSellingPrice"));
            var TotalSP = (parseFloat(RECQuantity) * parseFloat(SP)).toFixed(2);
            //                 pDiscount = parseFloat(parseFloat(parseFloat(TotalSP) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);
           // tempTaxAmt = (parseFloat(parseFloat(TotalSP) / parseFloat(100 + parseFloat(tax))) * parseFloat(tax)).toFixed(2);
          // if(PurchaseTax>0)
            //    {
                tempTaxAmt = (parseFloat(parseFloat(TotalSP) / parseFloat(100 + parseFloat(PurchaseTax))) * parseFloat(PurchaseTax)).toFixed(2);
              //  }
                /*else
                {
                tempTaxAmt = (parseFloat(parseFloat(TotalSP) / parseFloat(100 + parseFloat(tax))) * parseFloat(tax)).toFixed(2);
                }*/
            if (document.getElementById('hdnREQCalcCompQTY').value == "Y") {

                var TotalCompQtySP = (parseFloat(CompQuantity) * parseFloat(SP)).toFixed(2);
                tempCompQtyTax = parseFloat(parseFloat(parseFloat(TotalCompQtySP) / parseFloat(100 + parseFloat(PurchaseTax))) * parseFloat(PurchaseTax)).toFixed(2);
            }
            else {
                tempCompQtyTax = 0.00;
            }
            //                 Total = parseFloat(parseFloat(TotalSP) - parseFloat(pDiscount)).toFixed(6);
           // tempTaxAmt = parseFloat(parseFloat(parseFloat(TotalSP) / parseFloat(100 + parseFloat(tax))) * parseFloat(tax)).toFixed(2);
           // if(PurchaseTax>0)
             //  {
               tempTaxAmt = parseFloat(parseFloat(parseFloat(TotalSP) / parseFloat(100 + parseFloat(PurchaseTax))) * parseFloat(PurchaseTax)).toFixed(2);
               //}
               /*else
               {
               tempTaxAmt = parseFloat(parseFloat(parseFloat(TotalSP) / parseFloat(100 + parseFloat(tax))) * parseFloat(tax)).toFixed(2);
               }*/
        }


        document.getElementById('txtTotalCost').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt) + parseFloat(tempCompQtyTax)).toFixed(2);

        ToTargetFormatWOR($("#txtTotalCost"));

        if (isNaN(ToInternalFormat($("#txtRECQuantity")))) {
            document.getElementById('txtTotalCost').value = '0.00'
            ToTargetFormatWOR($("#txtTotalCost"));
        }
    }
    function calculateCastPerUnit() {
        var IsRule = document.getElementById('hdnIsSellingPriceRuleApply').value;
        var IsRecd = document.getElementById('hdnIsResdCalc').value;
        var pNominalDiscount = ToInternalFormat($("#txtNominal")) == 0.00 ? 0 : ToInternalFormat($("#txtNominal"));
        if (IsRecd == 'SUnit') {
            var Costprice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            //  var UnitPrice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            document.getElementById('hdnUnitCostPrice').value = parseFloat(UnitPrice).toFixed(6);
            //ToTargetFormat($("#hdnUnitCostPrice"));
        }
        if (IsRecd == 'PoUnit') {
            var pNominalDiscount = ToInternalFormat($("#txtNominal")) == 0.00 ? 0 : ToInternalFormat($("#txtNominal"));
            var Costprice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            // var UnitPrice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));

            if (parseFloat(Inverse) == 0) {
                document.getElementById('hdnUnitCostPrice').value = (0).toFixed(2);
                ToTargetFormatWOR($("#hdnUnitCostPrice"));
            }
            else {
                document.getElementById('hdnUnitCostPrice').value = (parseFloat(UnitPrice) / parseFloat(Inverse)).toFixed(6);
                ToTargetFormatWOR($("#hdnUnitCostPrice"));
            }

           // ToTargetFormat($("#hdnUnitCostPrice"));
        }

        if (IsRecd == 'RPoUnit') {

            var UnitPrice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            var RecdQty = ToInternalFormat($("#txtRECQuantity")) == 0.00 ? 0 : ToInternalFormat($("#txtRECQuantity"));
            var perUnit = (parseFloat(UnitPrice) / parseFloat(RecdQty)).toFixed(2);

            //var Inverse = document.getElementById('txtInvoiceQty').value;
            var Inverse = ToInternalFormat($("#txtInvoiceQty"));
            document.getElementById('hdnUnitCostPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
            //ToTargetFormat($("#hdnUnitCostPrice"));
        }
        if (IsRecd == 'RLsuSell') {
            var UnitPrice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            var RecdQtylsu = ToInternalFormat($("#txtRcvdLSUQty")) == 0.00 ? 0 : ToInternalFormat($("#txtRcvdLSUQty"));
            var perUnitLsu = (parseFloat(UnitPrice) / parseFloat(RecdQtylsu)).toFixed(6);
            document.getElementById('hdnUnitCostPrice').value = parseFloat(perUnitLsu).toFixed(6);
           // ToTargetFormat($("#hdnUnitCostPrice"));
        }

        if (IsRule == 'Y') {
            AutoSellingprice();
        }

    }

    function AutoSellingprice() {
        var Istrue = false;
        var pTempUnitPrice;
        
        var IsNeedSchemeInValue = $('#<%=ddlSchemetype.ClientID %> option:selected').val();
        var IsNeedDiscInValue = $('#<%=ddlDisctype.ClientID %> option:selected').val();
        
        var SchemeDiscount = ToInternalFormat($("#txtSchemeDisc")) == 0.00 ? 0 : ToInternalFormat($("#txtSchemeDisc"));
        var Discount = ToInternalFormat($("#txtDiscount")) == 0.00 ? 0 : ToInternalFormat($("#txtDiscount"));
        var tax = ToInternalFormat($("#txtTax")) == 0.00 ? 0 : ToInternalFormat($("#txtTax"));
        var pNominalDiscount = ToInternalFormat($("#txtNominal")) == 0.00 ? 0 : ToInternalFormat($("#txtNominal"));
        var pselval = document.getElementById('hdnSellingPrieRuleList').value.split("^");
        var Costprice = ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
        var UnitPrice = pNominalDiscount > 0 ? parseFloat(parseFloat(Costprice) - parseFloat(pNominalDiscount)).toFixed(6) : ToInternalFormat($("#txtUnitPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtUnitPrice"));
        var sellingPrice = 0.00;
        var tempTaxAmt = 0.00;
        var Total = 0.00;
        var pDiscount = 0.00;
        var pSchemeDiscount = 0.00;
        var Price = 0.00;
        var i;
        if (UnitPrice > 0) {

            for (i = 0; i < pselval.length; i++) {
                if (pselval[i] != "" && Istrue == false) {
                    p_sel = pselval[i].split('~');
                    if (p_sel[4] == "N") {
                      
                        if($('#hdnIsSchemeDiscount').val() == "Y") { 
                            if(IsNeedSchemeInValue == 0){ //If 0 then Percentage else Value Text              
                              pSchemeDiscount = parseFloat(parseFloat(parseFloat(UnitPrice) / parseFloat(100)) 
                                                                 * parseFloat(SchemeDiscount)).toFixed(6);
                           }
                           else {
                             pSchemeDiscount = parseFloat(SchemeDiscount).toFixed(6);
                           }
                           pTempUnitPrice = parseFloat(parseFloat(UnitPrice) - parseFloat(pSchemeDiscount)).toFixed(2);
                        }
                        else {
                           pTempUnitPrice = parseFloat(UnitPrice).toFixed(2);
                        }
                      
                        if(IsNeedDiscInValue == 0) { //If 0 then Percentage else Value Text
                          pDiscount = parseFloat(parseFloat(parseFloat(pTempUnitPrice) / parseFloat(100)) * parseFloat(Discount)).toFixed(6);
                        }
                        else{
                          pDiscount = parseFloat(Discount).toFixed(6);
                        }
                      
                        Total = parseFloat(parseFloat(pTempUnitPrice) - parseFloat(pDiscount)).toFixed(6);
                        
                        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
                        Price = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(6);
                    }
                    else {
                        tempTaxAmt = parseFloat(parseFloat(parseFloat(UnitPrice) / parseFloat(100)) * parseFloat(tax)).toFixed(6);
                        Price = parseFloat(parseFloat(UnitPrice) + parseFloat(tempTaxAmt)).toFixed(6);
                    }


                    if (parseFloat(Price) >= parseFloat(p_sel[1]) && parseFloat(Price) <= parseFloat(p_sel[2])) {

                        sellingPrice = parseFloat(parseFloat(Price) + parseFloat(parseFloat(Price) * parseFloat(parseFloat(p_sel[3]) / 100))).toFixed(6)
                        document.getElementById('txtSellingPrice').value = parseFloat(sellingPrice).toFixed(6);
                        document.getElementById('txtMRP').value = parseFloat(sellingPrice).toFixed(6);
                        ToTargetFormatWOR($('#txtSellingPrice'));
                        ToTargetFormatWOR($('#txtMRP'));

                        Istrue = true;
                    }

                }
            }
        }
        var IsRule = document.getElementById('hdnIsSellingPriceRuleApply').value;
        var IsRecd = document.getElementById('hdnIsResdCalc').value;
        if (IsRecd == 'SUnit') {
            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            document.getElementById('hdnUnitSellingPrice').value = parseFloat(pSellingPrice).toFixed(6);
            ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        }
        if (IsRecd == 'PoUnit') {
            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            document.getElementById('hdnUnitSellingPrice').value = (parseFloat(pSellingPrice) / parseFloat(Inverse)).toFixed(6);
            ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        }

        if (IsRecd == 'RPoUnit') {

            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var RecdQty = ToInternalFormat($("#txtRECQuantity")) == 0.00 ? 0 : ToInternalFormat($("#txtRECQuantity"));
            var perUnit = (parseFloat(pSellingPrice) / parseFloat(RecdQty)).toFixed(6);

            var Inverse = ToInternalFormat($("#txtInvoiceQty"));
            document.getElementById('hdnUnitSellingPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
            ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        }
        if (IsRecd == 'RLsuSell') {
            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            var RecdQtylsu = ToInternalFormat($("#txtRcvdLSUQty")) == 0.00 ? 0 : ToInternalFormat($("#txtRcvdLSUQty"));
            var perUnitLsu = (parseFloat(pSellingPrice) / parseFloat(RecdQtylsu)).toFixed(6);
            document.getElementById('hdnUnitSellingPrice').value = parseFloat(perUnitLsu).toFixed(6);
            ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        }



    }


    function btnCalcSellingPrice() {

        var IsRecd = document.getElementById('hdnIsResdCalc').value;
        if (IsRecd == 'SUnit') {
            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            document.getElementById('hdnUnitSellingPrice').value = parseFloat(pSellingPrice).toFixed(6);
            ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        }
        if (IsRecd == 'PoUnit') {
            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            if (parseFloat(Inverse) > 0) {
                document.getElementById('hdnUnitSellingPrice').value = (parseFloat(pSellingPrice) / parseFloat(Inverse)).toFixed(6);
                ToTargetFormatWOR($("#hdnUnitSellingPrice"));
            }
        }

        if (IsRecd == 'RPoUnit') {

            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var RecdQty = ToInternalFormat($("#txtRECQuantity")) == 0.00 ? 0 : ToInternalFormat($("#txtRECQuantity"));
            var perUnit = (parseFloat(pSellingPrice) / parseFloat(RecdQty)).toFixed(6);

            var Inverse = ToInternalFormat($("#txtInvoiceQty"));
            document.getElementById('hdnUnitSellingPrice').value = (parseFloat(perUnit) / parseFloat(Inverse)).toFixed(6);
            ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        }
        if (IsRecd == 'RLsuSell') {
            var pSellingPrice = ToInternalFormat($("#txtSellingPrice")) == 0.00 ? 0 : ToInternalFormat($("#txtSellingPrice"));
            var Inverse = ToInternalFormat($("#txtInvoiceQty")) == 0.00 ? 0 : ToInternalFormat($("#txtInvoiceQty"));
            var RecdQtylsu = ToInternalFormat($("#txtRcvdLSUQty")) == 0.00 ? 0 : ToInternalFormat($("#txtRcvdLSUQty"));
            var perUnitLsu = (parseFloat(pSellingPrice) / parseFloat(RecdQtylsu)).toFixed(6);
            document.getElementById('hdnUnitSellingPrice').value = parseFloat(perUnitLsu).toFixed(6);
            ToTargetFormatWOR($("#hdnUnitSellingPrice"));
        }
        // btnOnFocus();
    }

    function checkAddToTotal() {
        if (document.getElementById('txtTotaltax').value == "") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_06") == null ? "Supplier Service Tax(%) should not be Empty.Atleast Provide Zero." : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_06");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtTotaltax').focus();
            document.getElementById('txtTotaltax').value = '0.00';
            return false;
        }
        if (document.getElementById('txtTotalDiscount').value == "") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_07") == null ? "PO Discount  should not be Empty.Atleast Provide Zero." : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_07");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtTotalDiscount').focus();
            document.getElementById('txtTotalDiscount').value = '0.00';
            return false;

        }
        var Total = parseFloat(parseFloat(ToInternalFormat($("#hdnTotalCost"))) - parseFloat(ToInternalFormat($("#txtTotalDiscount")))).toFixed(6);

        tempTaxAmt = parseFloat(parseFloat(parseFloat(Total) / parseFloat(100)) * parseFloat(ToInternalFormat($("#txtTotaltax")))).toFixed(6);
        $('#hdnsupplierServiceTaxAmount').val(parseFloat(tempTaxAmt).toFixed(2));
        ToTargetFormatWOR($("#hdnsupplierServiceTaxAmount"));
        document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
        ToTargetFormatWOR($("#lblTotalCostAmount"));
        document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(Total) + parseFloat(tempTaxAmt)).toFixed(2);
        ToTargetFormatWOR($("#txtGrandTotal"));
        document.getElementById('txtNetTotal').value = parseFloat((parseFloat(ToInternalFormat($("#txtGrandTotal")))) - parseFloat(ToInternalFormat($("#txtUseCreditAmount")))).toFixed(2);
        ToTargetFormatWOR($("#txtNetTotal"));
        document.getElementById('txtGrandwithRoundof').value = ToInternalFormat($("#txtNetTotal"));
        ToTargetFormatWOR($("#txtGrandwithRoundof"));
        document.getElementById('txtRoundOffValue').value = "0.00";
        if (parseFloat(ToInternalFormat($("#txtUseCreditAmount"))) > parseFloat(ToInternalFormat($("#txtAvailCreditAmount")))) {

            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_08") == null ? "Use within available credit amount" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_08");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtUseCreditAmount').value = 0;
            ToTargetFormatWOR($("#txtUseCreditAmount"));
            document.getElementById('txtUseCreditAmount').focus();
            return false;
        }
        if (parseFloat(ToInternalFormat($("#txtUseCreditAmount"))) > parseFloat(ToInternalFormat($("#txtGrandTotal")))) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_09") == null ? "Use credit amount lessthan or equal to GrandTotal" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_09");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtUseCreditAmount').value = 0;
            ToTargetFormatWOR($("#txtUseCreditAmount"));
            document.getElementById('txtUseCreditAmount').focus();
            return false;
        }

        return false;
    }
    function getPrecision(id) {
        if (document.getElementById(id).value.trim() != "")
            return parseFloat(document.getElementById(id).value).toFixed(2);
        else
            return "0.00";
    }

    function getvalidation(evt) {
        var keycode = 0;
        if (evt) {
            keycode = evt.keyCode || evt.which;
        }
        else {
            keycode = window.event.keyCode
        }
        if (keycode != 9) {
            var ddlSupplier = document.getElementById('ddlSupplier');
            if (ddlSupplier.options[ddlSupplier.selectedIndex].value == '0') {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_10") == null ? "Select a Supplier Name" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_10");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtProductName').value = "";
                return false;
            }
             if ($('#ChkIsConsign').prop('checked')) {                    
                    return true;
                }
            if ((document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "" )&& document.getElementById('hdnDCNumber').value == "N") {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_11") == null ? "Enter DC Number/InvoiceNo" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_11");
                ValidationWindow(userMsg, ErrorMsg);
                //document.getElementById('txtDCNumber').focus();
                document.getElementById('txtProductName').value = "";
                return false;
            }
            //Change Dc no as Inv Ref No for Vasan
             if ((document.getElementById('txtDCNumber').value == "" && document.getElementById('txtInvoiceNo').value == "" )&& document.getElementById('hdnDCNumber').value == "Y") {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_49") == null ? "Enter Ref.Inv No/InvoiceNo" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_49");
                ValidationWindow(userMsg, ErrorMsg);
                //document.getElementById('txtDCNumber').focus();
                document.getElementById('txtProductName').value = "";
                return false;
            }
            //document.getElementById('txtBatchNo').focus();
            return true;
        }
    }
    //        function supplierdcno_chk() {
    //            var supplier; var dcno; var invoiceno; var msg;
    //            if (document.getElementById('ddlSupplier').options[document.getElementById('ddlSupplier').selectedIndex].text != '--Select--') {
    //                supplier = document.getElementById('ddlSupplier').options[document.getElementById('ddlSupplier').selectedIndex].text

    //                if (document.getElementById('txtDCNumber').value != "") {
    //                    dcno = document.getElementById('txtDCNumber').value;
    //                    //document.getElementById('txtInvoiceNo').disabled = true;
    //                    //                     document.getElementById('tdtxtInvoiceNo').style.display = "hide";
    //                    //                     document.getElementById('tdInvoiceNo').style.display = "hide";                    
    //                }
    //                else {
    //                    dcno = 0;
    //                    //document.getElementById('txtInvoiceNo').disabled = false;
    //                }

    //                if (document.getElementById('txtInvoiceNo').value != "") {
    //                    invoiceno = document.getElementById('txtInvoiceNo').value;
    //                    //document.getElementById('txtDCNumber').disabled = true;
    //                }
    //                else {
    //                    invoiceno = 0;
    //                    // document.getElementById('txtDCNumber').disabled = false;
    //                }
    //            }


    //            InventoryWebService.Checksupplier(supplier, dcno, invoiceno, OnComplete1, OnError1, OnTimeOut1);

    //            //document.getElementById('txtInvoiceNo').focus();
    //            function OnComplete1(arg) {
    //                if (arg == "have") {
    //                    confirm_meth();

    //                }
    //            }
    //            function OnTimeOut1(arg) {
    //                alert("timeOut has occured");
    //            }
    //            function OnError1(arg) {
    //                alert("First Select A Supplier");
    //                document.getElementById('txtDCNumber').value = "";
    //            }

    //        }


    function Validate() {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_12") == null ? "Do you want to continue !Click OK" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_12");
        if (ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg) == false) {
            return false;


        } else {
            document.getElementById('btnCancel').focus();
            return true


        }

    }
    //        function supplierInvoice_chk() {
    //            var supplier1; var dcno1; var invoiceno1; var msg1;
    //            if (document.getElementById('ddlSupplier').options[document.getElementById('ddlSupplier').selectedIndex].text != '--Select--') {
    //                supplier1 = document.getElementById('ddlSupplier').options[document.getElementById('ddlSupplier').selectedIndex].text

    //                if (document.getElementById('txtDCNumber').value != "") {
    //                    dcno1 = document.getElementById('txtDCNumber').value;
    //                    //document.getElementById('txtInvoiceNo').disabled = true;
    //                }
    //                else {
    //                    dcno1 = 0;
    //                    //document.getElementById('txtInvoiceNo').disabled = false;
    //                }
    //                if (document.getElementById('txtInvoiceNo').value != "") {
    //                    invoiceno1 = document.getElementById('txtInvoiceNo').value;
    //                    //document.getElementById('txtDCNumber').disabled = true;
    //                }
    //                else {
    //                    invoiceno1 = 0;
    //                    //document.getElementById('txtDCNumber').disabled = false;
    //                }
    //            }

    //            InventoryWebService.Checksupplier1(supplier1, dcno1, invoiceno1, OnComplete, OnError, OnTimeOut);

    //            function OnComplete(arg) {
    //                if (arg == "have") {
    //                    confirm_meth();
    //                }
    //            }
    //            function OnTimeOut(arg) {
    //                alert("timeOut has occured");
    //            }
    //            function OnError(arg) {
    //                alert("First Select A Supplier");
    //                document.getElementById('txtInvoiceNo').value = "";
    //            }





        

</script>

<script language="javascript" type="text/javascript">

    function checkDetails() {
        var chk = document.getElementById('ChkIsConsign');
        if (document.getElementById('txtPODate').value == '') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_13") == null ? "Select stock received date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_13");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtPODate').focus();
            return false;
        }

        if (document.getElementById('ddlSupplier').options[document.getElementById('ddlSupplier').selectedIndex].value == '0') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_10") == null ? "Select a supplier name" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_10");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('ddlSupplier').focus();
            return false;
        }
         if (!$('#ChkIsConsign').prop('checked')) {
			if (document.getElementById('txtDCNumber').value.trim() == '' && document.getElementById('txtInvoiceNo').value.trim() == '') {
				var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_14") == null ? "Provide invoice details" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_14");
				ValidationWindow(userMsg, ErrorMsg);
				document.getElementById('txtDCNumber').focus();
				return false;
			}
		}
        if (document.getElementById('hdnProductList').value == '') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_15") == null ? "Check the product list" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_15");
            ValidationWindow(userMsg, ErrorMsg);
            return false;
        }
        var pType = document.getElementById('ddlStockReceivedType').options[document.getElementById('ddlStockReceivedType').selectedIndex].text;
        if (pType != 'FreeProduct') {
            if (ToInternalFormat($("#txtGrandTotal")) != 0.00) {
                document.getElementById('hdnGrandTotal').value = ToInternalFormat($("#txtGrandTotal"));
                ToTargetFormatWOR($("#hdnGrandTotal"));
            }
            //else {
            // if (($('hdnisConsignmentStock').val() != 'Y') && chk.checked == false) {
            //        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_15") == null ? "Check the product list" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_15");
            //        ValidationWindow(userMsg, ErrorMsg);
            //        return false;
            //    }
            //}
        }


        if ($('#txtInvoiceNo').val() != "" && $('#txtInvoiceDate').val() == "") {
            $('#imagInvoiceDate').attr("disabled", false);
            $('#txtInvoiceDate').attr("disabled", true);
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_45") == null ? "Check the invoice Date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_45");
            ValidationWindow(userMsg, ErrorMsg);
            return false;
        }
         if (!$('#ChkIsConsign').prop('checked')) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_16") == null ? "Please confirm if this Invoice has been Completed" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_16");
                var pBill = ConfirmWindow(userMsg, infromMsg, OkMsg, CancelMsg);
                if (pBill != true) {
                    return false;
                }
        }

        $('#hdnTotalTax').val($('#txtTotalTaxAmt').val());
        $('#hdnTotalDiscount').val($('#txtTotalDiscountAmt').val());
        return true;
    }
    /*
    function checkIsEmpty(id) {
        //document.getElementById('txtBatchNo').focus();

        if (document.getElementById('txtProductName').value.trim() == '' && document.getElementById('hdnAdd').value != 'Update') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_17") == null ? "Provide product name" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_17");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtProductName').focus();
            return false;
        }

        if (document.getElementById('ddlRcvdUnit').value == 0) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_18") == null ? "Provide the received unit" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_18");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('ddlRcvdUnit').focus();
            return false;
        }
        if (document.getElementById('chkIntax').checked == false && document.getElementById('chkExtax').checked == false) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_19") == null ? "Select the tax calculation with CostPrice or SellingPrice" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_19");
            ValidationWindow(userMsg, ErrorMsg);
            return false;
        }
        if (document.getElementById('hdnHasBatchNo').value != 'N') {
            if (document.getElementById('txtBatchNo').value == '') {
                if ($('#hdnMandFieldDisable').val() == "Y") {
                    var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_20") == null ? "Provide batch number" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_20");
                    ValidationWindow(userMsg, ErrorMsg);
                    document.getElementById('txtBatchNo').focus();
                    return false;
                }
            }

        }

        if (document.getElementById('hdnHasExpiryDate').value != 'N') {
            if (document.getElementById('txtEXPDate').value == '' ) {
                if ($('#hdnMandFieldDisable').val() == "Y") {
                    //alert('Provide expiry date');
                    var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_50") == null ? "Provide Expiry Date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_50");
                    ValidationWindow(userMsg, ErrorMsg);
                    document.getElementById('txtEXPDate').focus();
                    return false;
                }
            }
        }

        if ($("#hdnCompQty").val() == 'Y') {
            if ((ToInternalFormat($("#txtRECQuantity")) == 0.00) && (ToInternalFormat($("#txtCompQuantity")) == 0.00)) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_21") == null ? "Provide received quantity or comp quantity" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_21");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtRECQuantity').focus();
                return false;
            }
        }
        else {
            if (ToInternalFormat($("#txtRECQuantity")) == 0.00) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_22") == null ? "Provide received quantity" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_22");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtRECQuantity').focus();
                return false;
            }
        }

        if (document.getElementById('ddlSelling').value == 0) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_23") == null ? "Select selling unit" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_23");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('ddlSelling').focus();
            return false;
        }

        var pType = document.getElementById('ddlStockReceivedType').options[document.getElementById('ddlStockReceivedType').selectedIndex].text;
        if (pType != 'FreeProduct') {
            if (ToInternalFormat($("#txtUnitPrice")) == 0.00) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_24") == null ? "Provide cost price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_24");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtUnitPrice').focus();
                return false;
            }
        }


        if (ToInternalFormat($("#txtInvoiceQty")) == 0.00) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_25") == null ? "Provide invoice qty" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_25");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtInvoiceQty').focus();
            return false;
        }


        if ($("#hdnCompQty").val() == 'Y') {
            if (ToInternalFormat($("#txtRcvdLSUQty")) == 0.00 && (ToInternalFormat($("#txtCompQuantity")) == 0.00)) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_26") == null ? "Provide received LSU qty or comp qty" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_26");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtRcvdLSUQty').focus();
                return false;
            }
        }
        else {
            if (ToInternalFormat($("#txtRcvdLSUQty")) == 0.00) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_27") == null ? "Provide received LSU qty" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_27");
                ValidationWindow(userMsg, ErrorMsg);
                document.getElementById('txtRcvdLSUQty').focus();
                return false;
            }
        }

        if (Number(ToInternalFormat($("#txtNominal"))) > Number(ToInternalFormat($("#txtUnitPrice")))) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_28") == null ? "Provide Nominal value less then Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_28");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtNominal').focus();
            return false;
        }

        if (ToInternalFormat($("#txtSellingPrice")) == 0.00) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_29") == null ? "Provide Selling Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_29");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtSellingPrice').focus();
            return false;
        }
        if (ToInternalFormat($("#txtMRP")) == 0.00) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_30") == null ? "Provide MRP" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_30");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtMRP').focus();
            return false;
        }

        if (Number(ToInternalFormat($("#txtSellingPrice"))) < Number(ToInternalFormat($("#txtUnitPrice")))) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_31") == null ? "Provide Selling Price greater than Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_31");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtSellingPrice').select();
            return false;
        }

        if (Number(ToInternalFormat($("#txtMRP"))) < Number(ToInternalFormat($("#txtUnitPrice")))) {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32") == null ? "Provide MRP greater than Cost Price" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtMRP').select();
            return false;
        }
        var ExTax = document.getElementById('txtExTax').value;
        var PurchaseTax = document.getElementById('txtPurchaseTax').value;
       if ((ExTax != "" && Number(ToInternalFormat($("#txtExTax"))) > 0) && (PurchaseTax != "" && Number(ToInternalFormat($("#txtPurchaseTax"))) > 0)) {
        
       var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32") == null ? "Provide any one of Tax. Excess Tax / Purchase Tax" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_32");
            ValidationWindow(userMsg, ErrorMsg);
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
                        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_34") == null ? "Product name and batch number combination already exist" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_34");
                        ValidationWindow(userMsg, ErrorMsg);
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

        //document.getElementById('tbTotalCost').style.display = "table";
        $('#tbTotalCost').removeClass().addClass('displaytb w-100p');

        if (document.getElementById('hdnHasBatchNo').value != 'N') {
            return CheckDatesMfg(' ', document.getElementById('txtMFTDate'), 'MFG') == true ? CheckDatesExp(' ', document.getElementById('txtEXPDate'), 'EXP') : false;
        }
        return true;
    }
*/
    function checkvalid() {
        if (document.getElementById('txtProductName').value == '') {

            document.getElementById('txtnewProducts').focus();
            return true;
        }
    }
   /* function BindProductList() {
        document.getElementById('ddlStockReceivedType').disabled = true;
        //document.getElementById('tdShowLSU').style.display = 'hide';
        $('#tdShowLSU').removeClass().addClass('hide');
        //document.getElementById('tdheadLSU').style.display = 'hide';
        $('#tdheadLSU').removeClass().addClass('hide');

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
            var pRecQty = $.trim(document.getElementById('txtRECQuantity').value) == "" ? 0 : document.getElementById('txtRECQuantity').value;
            var pRecUnit = document.getElementById('ddlRcvdUnit').value;
            var pInverseQty = $.trim(document.getElementById('txtInvoiceQty').value) == "" ? 1 : document.getElementById('txtInvoiceQty').value;
            var pSellingUnit = document.getElementById('ddlSelling').value;
            var pRecLSUQty = $.trim(document.getElementById('txtRcvdLSUQty').value) == "" ? 0 : document.getElementById('txtRcvdLSUQty').value;
            var pCompQty = $.trim(document.getElementById('txtCompQuantity').value) == "" ? 0 : document.getElementById('txtCompQuantity').value;
            var pUnitPrice = $.trim(document.getElementById('txtUnitPrice').value) == "" ? 0 : document.getElementById('txtUnitPrice').value;
            var pSellingPrice = $.trim(document.getElementById('txtSellingPrice').value) == "" ? 0 : document.getElementById('txtSellingPrice').value;
            var pDiscount = $.trim(document.getElementById('txtDiscount').value) == "" ? 0 : document.getElementById('txtDiscount').value;
            var pTax = $.trim(document.getElementById('txtTax').value) == "" ? 0 : document.getElementById('txtTax').value;
            var pUnitCostPrice = $.trim(document.getElementById('hdnUnitCostPrice').value) == "" ? 0 : document.getElementById('hdnUnitCostPrice').value;
            var pUnitSellingPrice = $.trim(document.getElementById('hdnUnitSellingPrice').value) == "" ? 0 : document.getElementById('hdnUnitSellingPrice').value;
            var pHasBatch = document.getElementById('hdnHasBatchNo').value
            var pHasExpiry = document.getElementById('hdnHasExpiryDate').value;
            var pTotalCost = $.trim(document.getElementById('txtTotalCost').value) == "" ? 0 : ToInternalFormat($('#txtTotalCost'));
            var pTQty = document.getElementById('hdnType').value;
            var pRakNo = document.getElementById('txtRakNo').value;
            var pMRP = $.trim(document.getElementById('txtMRP').value) == "" ? 0 : ToInternalFormat($('#txtMRP'));
            var pID = $.trim(document.getElementById('hdnID').value) == "" ? 0 : document.getElementById('hdnID').value;
            var pSno = document.getElementById('hdnSno').value
            var pExTax = $.trim(document.getElementById('txtExTax').value) == "" ? 0 : document.getElementById('txtExTax').value;
            var pPurchaseTax = document.getElementById('txtPurchaseTax').value == "" || document.getElementById('txtPurchaseTax').value == undefined ? 0 : document.getElementById('txtPurchaseTax').value;
            if (pBatchno == '') {
                pBatchno = '*';
            }

            if (document.getElementById('txtEXPDate').value == '' ) {
                pExpDate = '**';
            }
            else {
                pExpDate = document.getElementById('txtEXPDate').value;
            }

            if (document.getElementById('txtMFTDate').value == '')  {
                pManufacture = '**';
            }
            else {
                pManufacture = document.getElementById('txtMFTDate').value;
            }
            if (pDiscount == "") {
                document.getElementById('txtDiscount').value = '0.00';

            } else {

                document.getElementById('txtDiscount').value = (parseFloat(ToInternalFormat($("#txtDiscount")))).toFixed(2);
            }
            pDiscount = ToTargetFormat($("#txtDiscount"));

            if (pTax == "") {
                // pTax = '0.00';
                document.getElementById('txtTax').value = '0.00';
            } else {
                document.getElementById('txtTax').value = (parseFloat(ToInternalFormat($("#txtTax")))).toFixed(2);
            }
            pTax = ToTargetFormat($("#txtTax"));
            if (pCompQty == "") {
                //pCompQty = '0.00';
                document.getElementById('txtCompQuantity').value = '0.00';
            } else {
                document.getElementById('txtCompQuantity').value = (parseFloat(ToInternalFormat($("#txtCompQuantity")))).toFixed(2);
            }
            pCompQty = ToTargetFormat($("#txtCompQuantity"));
            if (pRakNo.trim() == "") {
                pRakNo = '--';
            }

            var pParentProductID = document.getElementById('hdnParentProductID').value == "0" ? 0 : document.getElementById('hdnParentProductID').value;

            var pNominal = $.trim(document.getElementById('txtNominal').value) == "" ? 0 : document.getElementById('txtNominal').value;
            if (pNominal == "") {
                document.getElementById('txtNominal').value = '0.00';

            } else {

                document.getElementById('txtNominal').value = (parseFloat(ToInternalFormat($("#txtNominal")))).toFixed(2);
            }
            pNominal = ToTargetFormat($("#txtNominal"));

            document.getElementById('hdnProductList').value += pSno + "~" +
                                                                    pProductID + "~" +
                                                                    pProductName.replace(exp, "") + "~" +
                                                                    pBatchno + "~" +
                                                                    pManufacture + "~" +
                                                                    pExpDate + "~" +
                                                                    pRecQty + "~" +
                                                                    pRecUnit + "~" +
                                                                    pInverseQty + "~" +
                                                                    pSellingUnit + "~" +
                                                                    pRecLSUQty + "~" +
                                                                    pCompQty + "~" +
                                                                    pUnitPrice + "~" +
                                                                    pSellingPrice + "~" +
                                                                    pDiscount + "~" +
                                                                    pTax + "~" +
                                                                    pUnitCostPrice + "~" +
                                                                    pUnitSellingPrice + "~" +
                                                                    pHasBatch + "~" +
                                                                    pHasExpiry + "~" +
                                                                    pTotalCost + "~" +
                                                                    pTQty + "~" +
                                                                    pRakNo + "~" +
                                                                    pMRP + "~" +
                                                                    pID + "~" +
                                                                    pExTax + "~" +
                                                                    pParentProductID + "~" +
                                                                    pNominal +"~"+pPurchaseTax+ "^";
            Tblist();

            
                Attune.Kernel.InventoryCommon.InventoryWebService.SaveTempStockReceived($('#hdnPurchareOrdeID').val(), $('#ddlSupplier').val(), $('#hdnProductList').val());
            }
            //checkTable();
            var pNo = Number(document.getElementById('hdnSno').value);
            document.getElementById('hdnSno').value = pNo + 1;


        }
        document.getElementById('add').value = 'Add';
        document.getElementById('hdnAdd').value = 'Add';
        var objadd = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_51") == null ? "Add" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_51");

        $('#add').text(objadd);
        clearFields();
        document.getElementById('txtProductName').focus();

    } */
    function checkTable() {
        var count = document.getElementById('TableCollectedItems').rows.length;
        if (count > 1) {
            for (i = 1; i < count; i++) {
                if (document.getElementById('chkIntax').checked == true) {
                    document.getElementById("chkExtax").disabled = true;
                }
                if (document.getElementById('chkExtax').checked == true) {
                    document.getElementById('chkIntax').disabled = true;
                }
            }
        }
        else {
            document.getElementById("chkExtax").disabled = false;
            document.getElementById('chkIntax').disabled = false;

        }
    }
    function clearFields() {
        document.getElementById('txtProductName').value = '';
        document.getElementById('hdnproductId').value = 0;
        document.getElementById('hdnProductName').value = '';
        // document.getElementById('TableProductDetails').style.display = "show";
        //document.getElementById('btnPopUp').style.display = 'hide';
        $('#btnPopUp').removeClass().addClass('hide');
        //document.getElementById('ddlRcvdUnit').selectedIndex = 0;
        //document.getElementById('ddlRcvdUnit').value = 0;
        document.getElementById('ddlSelling').selectedIndex = 0;
        document.getElementById('ddlSelling').value = 0;
        document.getElementById('txtRECQuantity').value = '';
        document.getElementById('txtRcvdLSUQty').value = '';
        document.getElementById('txtInvoiceQty').value = '';
        document.getElementById('txtBatchNo').value = '';
        document.getElementById('txtEXPDate').value = '';
        document.getElementById('txtMFTDate').value = '';
        document.getElementById('txtUnitPrice').value = '';
        document.getElementById('txtTotalCost').value = '';
        document.getElementById('txtCompQuantity').value = '';
        document.getElementById('txtTax').value = '';
        document.getElementById('txtDiscount').value = '';
        document.getElementById('hdnSchemeType').value = '';
        document.getElementById('txtSchemeDisc').value = '';
        document.getElementById('txtSellingPrice').value = '';
        document.getElementById('hdnUnitCostPrice').value = '';
        document.getElementById('hdnUnitSellingPrice').value = '';
        document.getElementById('hdnHasBatchNo').value = '';
        document.getElementById('hdnHasExpiryDate').value = '';
        document.getElementById('hdnType').value = '';
        document.getElementById('txtRakNo').value = '';
        document.getElementById('txtMRP').value = '';
        document.getElementById('hdnID').value = "0";
        document.getElementById('txtExTax').value = "";
        document.getElementById('txtRoundOffValue').value = 0.00;
        ToTargetFormatWOR($("#txtRoundOffValue"));
        document.getElementById('hdnParentProductID').value = '0';
        document.getElementById('txtNominal').value = '';
        document.getElementById('ddlSchemetype').value = 0;
        document.getElementById('ddlDisctype').value = 0;
        document.getElementById('hdnSchemeType').value = '';
        document.getElementById('hdnDisctype').value = '';
        
        $('#TxtProdTax').val(0);
        $('#hdnGetTax').val(0);
        $('#lblhsncode').text('');
        $('#txtPurchaseTax').val(0);
          $('#ddlRcvdUnit option:not(:selected)').prop('disabled', false);
  $('#ddlSelling option:not(:selected)').prop('disabled', false);

        AddRecUnitDefault();

    }


/*
    function btnDelete(sEditedData) {

        var i;
        var x = document.getElementById('hdnProductList').value.split("^");
        document.getElementById('hdnProductList').value = '';
        document.getElementById('lblTotalCostAmount').innerHTML = '0.00';
        ToTargetFormat($("#lblTotalCostAmount"));
        document.getElementById('txtGrandTotal').value = '0.00';
        ToTargetFormat($("#txtGrandTotal"));
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {

                if (x[i] != sEditedData) {
                    y = x[i].split('~');
                    document.getElementById('hdnProductList').value += x[i] + "^";
                    document.getElementById('lblTotalCostAmount').innerHTML = parseFloat(parseFloat(x[i].split('~')[16]) + parseFloat(ToInternalFormat($("#lblTotalCostAmount")))).toFixed(2);
                    document.getElementById('txtGrandTotal').value = parseFloat(parseFloat(x[i].split('~')[16]) + parseFloat(ToInternalFormat($("#txtGrandTotal")))).toFixed(2);
                    ToTargetFormat($('#lblTotalCostAmount'));
                    ToTargetFormat($('#txtGrandTotal'));
                }

            }
        }
        document.getElementById('hdnType').value = "";
        document.getElementById('add').value = 'Add';
        document.getElementById('hdnAdd').value = 'Add';

        //btnEdit_OnClick(sEditedData);
        Tblist();*/
     //  <%-- if ('<%= Request.QueryString["sID"] %>' == '') {
   //         Attune.Kernel.InventoryCommon.InventoryWebService.SaveTempStockReceived($('#hdnPurchareOrdeID').val(), $('#ddlSupplier').val(), $('#hdnProductList').val());
   //     }
   //     // checkTable();
  //  }--%>

    function CheckFreeProducts() {
        var pType = document.getElementById('ddlStockReceivedType').options[document.getElementById('ddlStockReceivedType').selectedIndex].text;
        document.getElementById('txtUnitPrice').readOnly = false;
        if (pType == 'FreeProduct') {
            document.getElementById('txtUnitPrice').value = 0.00;
            ToTargetFormatWOR($("#txtUnitPrice"));
            document.getElementById('txtUnitPrice').readOnly = true;
        }
    }

/*
    function Deleterows() {
        var RowEdit = document.getElementById('hdnRowEdit').value;
        var x = document.getElementById('hdnProductList').value.split("^");
        if (RowEdit != "") {
            var pSno = document.getElementById('hdnSno').value;
            var pProductID = document.getElementById('hdnproductId').value;
            var pProductName = document.getElementById('hdnProductName').value;
            var pBatchno = document.getElementById('txtBatchNo').value;
            var pManufacture = "";
            var pExpDate = "";
            var pRecQty = $.trim(document.getElementById('txtRECQuantity').value) == "" ? 0 : document.getElementById('txtRECQuantity').value;
            var pRecUnit = document.getElementById('ddlRcvdUnit').value;
            var pInverseQty = $.trim(document.getElementById('txtInvoiceQty').value) == "" ? 1 : document.getElementById('txtInvoiceQty').value;
            var pSellingUnit = document.getElementById('ddlSelling').value;
            var pRecLSUQty = $.trim(document.getElementById('txtRcvdLSUQty').value) == "" ? 0 : document.getElementById('txtRcvdLSUQty').value;
            var pCompQty = $.trim(document.getElementById('txtCompQuantity').value) == "" ? 0 : document.getElementById('txtCompQuantity').value;
            var pUnitPrice = $.trim(document.getElementById('txtUnitPrice').value) == "" ? 0 : document.getElementById('txtUnitPrice').value;
            var pSellingPrice = $.trim(document.getElementById('txtSellingPrice').value) == "" ? 0 : document.getElementById('txtSellingPrice').value;
            var pDiscount = $.trim(document.getElementById('txtDiscount').value) == "" ? 0 : document.getElementById('txtDiscount').value;
            var pTax = $.trim(document.getElementById('txtTax').value) == "" ? 0 : document.getElementById('txtTax').value;
            var pUnitCostPrice = $.trim(document.getElementById('hdnUnitCostPrice').value) == "" ? 0 : document.getElementById('hdnUnitCostPrice').value;
            var pUnitSellingPrice = $.trim(document.getElementById('hdnUnitSellingPrice').value) == "" ? 0 : document.getElementById('hdnUnitSellingPrice').value;
            var pHasBatch = document.getElementById('hdnHasBatchNo').value;
            var pHasExpiry = document.getElementById('hdnHasExpiryDate').value;
            var pTotalCost = $.trim(document.getElementById('txtTotalCost').value) == "" ? 0 : ToInternalFormat($('#txtTotalCost')); //document.getElementById('txtTotalCost').value;
            var pTQty = document.getElementById('hdnType').value;
            var pRakNo = document.getElementById('txtRakNo').value;
            var pMRP = $.trim(document.getElementById('txtMRP').value) == "" ? 0 : ToInternalFormat($('#txtMRP'));
            var pID = document.getElementById('hdnID').value;
            var pExTax = $.trim(document.getElementById('txtExTax').value) == "" ? 0 : document.getElementById('txtExTax').value;
            var pPurchaseTax = document.getElementById('txtPurchaseTax').value == "" ? 0 : document.getElementById('txtPurchaseTax').value;
            if (pBatchno == '') {
                pBatchno = '*';
            }

            if (document.getElementById('txtEXPDate').value == '' ) {
                pExpDate = '**';
            }
            else {
                pExpDate = document.getElementById('txtEXPDate').value;
            }

            if (document.getElementById('txtMFTDate').value == '') {
                pManufacture = '**';
            }
            else {
                pManufacture = document.getElementById('txtMFTDate').value;
            }
            if (document.getElementById('txtRakNo').value == '') {
                pRakNo = '--';
            }
            var pParentProductID = document.getElementById('hdnParentProductID').value;

            var pNominal = $.trim(document.getElementById('txtNominal').value) == "" ? 0 : document.getElementById('txtNominal').value;
            if (pNominal == "") {
                document.getElementById('txtNominal').value = '0.00';

            } else {

                document.getElementById('txtNominal').value = (parseFloat(ToInternalFormat($("#txtNominal")))).toFixed(2);
            }
            pNominal = ToTargetFormat($("#txtNominal"));
            document.getElementById('hdnProductList').value = pSno + "~" + pProductID + "~" +
                                                                    pProductName.replace(exp, "") + "~" +
                                                                    pBatchno + "~" +
                                                                    pManufacture + "~" +
                                                                    pExpDate + "~" +
                                                                    pRecQty + "~" +
                                                                    pRecUnit + "~" +
                                                                    pInverseQty + "~" +
                                                                    pSellingUnit + "~" +
                                                                    pRecLSUQty + "~" +
                                                                    pCompQty + "~" +
                                                                    pUnitPrice + "~" +
                                                                    pSellingPrice + "~" +
                                                                    pDiscount + "~" +
                                                                    pTax + "~" +
                                                                    pUnitCostPrice + "~" +
                                                                    pUnitSellingPrice + "~" +
                                                                    pHasBatch + "~" +
                                                                    pHasExpiry + "~" +
                                                                    pTotalCost + "~" +
                                                                    pTQty + "~" + pRakNo + "~" + pMRP + "~"
                                                                    + pID + "~" + pExTax + "~" +
                                                                    pParentProductID + "~" +
                                                                    pNominal + "~"+pPurchaseTax+"^"; ;

            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {

                    if (x[i] != RowEdit) {
                        document.getElementById('hdnProductList').value += x[i] + "^";
                    }
                }
            }

            document.getElementById('hdnRowEdit').value = "";
            Tblist();*/
           <%-- if ('<%= Request.QueryString["sID"] %>' == '') {
                Attune.Kernel.InventoryCommon.InventoryWebService.SaveTempStockReceived($('#hdnPurchareOrdeID').val(), $('#ddlSupplier').val(), $('#hdnProductList').val());
            }
            document.getElementById('txtProductName').readOnly = false;
        }
    }--%>
    function AppendMRP() {
        document.getElementById('txtMRP').value = ToInternalFormat($("#txtSellingPrice")); //document.getElementById('txtSellingPrice').value;
        ToTargetFormatWOR($("#txtMRP"));
    }
   /* function btnEdit_OnClick(sEditedData) {

        var y = sEditedData.split('~');
        document.getElementById('hdnSno').value = y[0];
        document.getElementById('hdnproductId').value = y[1];
        document.getElementById('hdnProductName').value = y[2];
        document.getElementById('txtProductName').value = y[2];
        document.getElementById('txtBatchNo').value = y[3];
        var dateMFT = ToInternalMonth(y[4]);
        var dateEXP = ToInternalMonth(y[5]);
        document.getElementById('txtMFTDate').value = ToExternalMonth(dateMFT);
        document.getElementById('txtEXPDate').value = ToExternalMonth(dateEXP);
        document.getElementById('txtRECQuantity').value = y[6];
        document.getElementById('ddlRcvdUnit').value = y[7];
        document.getElementById('txtInvoiceQty').value = y[8];
        document.getElementById('ddlSelling').value = y[9];
        document.getElementById('txtRcvdLSUQty').value = y[10];
        document.getElementById('txtCompQuantity').value = y[11];
        document.getElementById('txtUnitPrice').value = y[12];
        document.getElementById('txtSellingPrice').value = y[13];
        document.getElementById('txtDiscount').value = y[14];
        document.getElementById('txtTax').value = y[15];
        document.getElementById('hdnUnitCostPrice').value = y[16];
        document.getElementById('hdnUnitSellingPrice').value = y[17];
        document.getElementById('hdnHasBatchNo').value = y[18];
        document.getElementById('hdnHasExpiryDate').value = y[19];
        document.getElementById('txtTotalCost').value = y[20];
        document.getElementById('hdnType').value = y[21];
        document.getElementById('txtRakNo').value = y[22];
        document.getElementById('txtMRP').value = y[23];
        document.getElementById('hdnID').value = y[24];
        document.getElementById('txtExTax').value = y[25];
        document.getElementById('hdnParentProductID').value = y[26];
        document.getElementById('txtNominal').value = y[27];
        $('#txtPurchaseTax').val(y[28]);
        document.getElementById('hdnRowEdit').value = sEditedData;
        document.getElementById('add').value = 'Update';
        var objadd = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_50") == null ? "Update" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_50");

        $('#add').text(objadd);
        document.getElementById('hdnAdd').value = 'Update';

        // document.getElementById('TableProductDetails').style.display = "show";

        document.getElementById('txtTotalCost').readOnly = true;
        document.getElementById('txtRcvdLSUQty').readOnly = true;
        document.getElementById('txtProductName').readOnly = true;
        //document.getElementById('btnPopUp').style.display = 'show';
        $('#btnPopUp').removeClass().addClass('hide');

    } */

    function btnOnFocus() {
        document.getElementById('add').focus();
        if (checkIsEmpty())
        { BindProductList(); }
    }
           
</script>

<script type="text/javascript" language="javascript">
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


        if (ObjDate.value.trim() == '') {
            if (flag == "MFG") {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_52") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_52");
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_53") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_53");
                ValidationWindow(userMsg, errorMsg);
            }
            ObjDate.select();
            return false;
        }
       
            else {
                var rtn = CheckFromToMonth($('#txtMFTDate').val(), $('#txtEXPDate').val());
                if (rtn == false) {
                    //  $('#txtMFTDate').focus();

                    var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40") == null ? "Provide valid date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40");
                    ValidationWindow(userMsg, ErrorMsg);

                    return false;
                }
                return true;
            }
        }

   
    function CheckDatesExp(splitChar, ObjDate, flag) {

        var today = GetServerDate();
      if (ObjDate.value.trim() == '') {
             if (flag == "MFG") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_52") == null ? "Provide Manufactured Date!" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_52");
            ValidationWindow(userMsg, errorMsg);
              }
           else {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_53") == null ? "Provide Expiry Date!" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_53");
            ValidationWindow(userMsg, errorMsg);
                 }
        //alert(flag == "MFG" ? 'Provide Manufactured Date!' : 'Provide Expiry Date!');
        ObjDate.select();
        return false;
             }
            else {
               var rtn = CheckFromToMonth($('#txtMFTDate').val(), $('#txtEXPDate').val());
                if (rtn == false) {
                    //  $('#txtMFTDate').focus();

                    var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40") == null ? "Provide valid date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40");
                    ValidationWindow(userMsg, ErrorMsg);

                    return false;
                }
                return true;
            }
        }

   

    function doDateValidation(from, to, bit) {
        var monthFlag = true;
        var i = from.length - 1;
        if (Number(to[i]) >= Number(from[i])) {
            if (Number(to[i]) == Number(from[i])) {
                monthFlag = false;
            }
            i--;
            if (Number(to[i]) >= Number(from[i])) {
                return true;
            }
            else if (monthFlag) {
                return true;
            }
            else {
                if (bit == 0) {
                    var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_35") == null ? "Mismatch Month Between Current & Mfg Date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_35");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                }
                else {
                    var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_36") == null ? "Mismatch Month Between Current & Exp Date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_36");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                }
                return false;
            }
        }
        else {
            if (bit == 0) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_35") == null ? "Mismatch Month Between Current & Mfg Date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_35");
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
            else {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_36") == null ? "Mismatch Month Between Current & Exp Date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_36");
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
            return false;
        }
    }

        
</script>
 <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div class="a-center" id="processMessage">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" 
                                meta:resourcekey="Rs_PleasewaitResource1" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" 
                                ImageUrl="~/PlatForm/Images/working.gif" 
                                meta:resourcekey="imgProgressbarResource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <%--<uc6:ErrorDisplay ID="//ErrorDisplay1" runat="server" />--%>
                <table class="w-100p searchPanel">
                    <tr>
                        <td>
                            <asp:Panel ID="panelQSR" runat="server" >
                                <table class="w-100p lh25">
                                    <tr id="Tr1" runat="server">
                                        <td id="Td1" runat="server">
                                            <asp:Label ID="lblStockReceivedDate" runat="server" Text="Stock Received Date" 
                                                meta:resourcekey="lblStockReceivedDateResource1"></asp:Label>
                                        </td>
                                        <td id="Td2" runat="server">
                                            <asp:TextBox ID="txtPODate" ReadOnly="true" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"  CssClass="small datePickerPres" 
                                                TabIndex="1" meta:resourcekey="txtPODateResource1"></asp:TextBox>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td id="Td3" runat="server">
                                            <asp:Label ID="lblSupplierName" runat="server" Text="Supplier Name" 
                                                meta:resourcekey="lblSupplierNameResource1"></asp:Label>
                                        </td>
                                        <td id="Td4" runat="server">
                                            <div id="divsup1" runat="server">
                                                <asp:DropDownList ID="ddlSupplier" CssClass="small" runat="server" AutoPostBack="True"
                                                    OnSelectedIndexChanged="ddlSupplier_SelectedIndexChanged" TabIndex="3" 
                                                    meta:resourcekey="ddlSupplierResource1">
                                                </asp:DropDownList>
                                                <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                            </div>
                                        </td>
                                        <td runat="server">
                                            <asp:Label ID="lblStocReceivType" runat="server" Text="Stock Received Type" 
                                                meta:resourcekey="lblStocReceivTypeResource1"></asp:Label>
                                        </td>
                                        <td runat="server">
                                            <asp:DropDownList ID="ddlStockReceivedType" CssClass="small" onchange="CheckFreeProducts();"
                                                runat="server" TabIndex="4" 
                                                meta:resourcekey="ddlStockReceivedTypeResource1">
                                            </asp:DropDownList>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td runat="server">
                                            <asp:Label ID="lblComments" runat="server" Text="Comments" 
                                                meta:resourcekey="lblCommentsResource1"></asp:Label>
                                        </td>
                                        <td runat="server">
                                          <asp:TextBox ID="txtComments" onkeypress="return ValidateMultiLangChar(this);" onblur="setFocus(this.id,'F')" TextMode="MultiLine"
                                                runat="server" Columns="25" Rows="2" CssClass="w-100p" TabIndex="7"  MaxLength="250"
                                                meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="Tr2" runat="server">
                                        <td id="Td5" runat="server">
                                            <asp:Label ID="lblDCNumber" runat="server" Text="DC Number" 
                                                meta:resourcekey="lblDCNumberResource1"></asp:Label>
                                            <asp:Label ID="lblDCNumber1" CssClass="hide" runat="server" Text="Ref. Inv No." 
                                                meta:resourcekey="lblDCNumber1Resource1"></asp:Label>
                                        </td>
                                        <td id="Td6" runat="server">
                                            <asp:TextBox ID="txtDCNumber" onkeypress="return ValidateMultiLangChar(this) && KeyPress1(event);" runat="server" MaxLength="50"
                                              CssClass="small" TabIndex="5" meta:resourcekey="txtDCNumberResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteDcNumber" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                MinimumPrefixLength="1" OnClientItemSelected="ChkDcSupplierCombination" ServiceMethod="GetSuppliernumcombination"
                                                ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtDCNumber"
                                                DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td id="Td7" runat="server">
                                            <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No" 
                                                meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                                        </td>
                                        <td id="Td8" runat="server">
                                            <asp:TextBox ID="txtInvoiceNo" runat="server" MaxLength="50" onkeypress="if(ValidateMultiLangChar(this))return KeyPress2(event);"
                                             CssClass="small" onblur="InvoiceCheck();" TabIndex="6"  meta:resourcekey="txtInvoiceNoResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteInvoiceNumber" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                MinimumPrefixLength="1" OnClientItemSelected="ChkInvoiceSupplierCombination"
                                                ServiceMethod="GetSuppliernumcombination" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                TargetControlID="txtInvoiceNo" DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td nowrap="nowrap" runat="server">
                                            <asp:Label ID="Label2" runat="server" Text="Invoice Date" 
                                                meta:resourcekey="Label2Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInvoiceDate" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);" onblur="ValidDate(this)" 
                                                CssClass="small datePickerPast" TabIndex="6" Enabled="false" meta:resourcekey="txtInvoiceDateResource1"></asp:TextBox>
                                           <%-- <asp:ImageButton ID="imagInvoiceDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" TabIndex="2" Height="16px" Enabled="false" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtInvoiceDate"
                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender2"
                                                ControlToValidate="txtInvoiceDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />
                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtInvoiceDate"
                                                Format="dd/MM/yyyy" PopupButtonID="imagInvoiceDate" Enabled="True" />--%>
                                            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        
                                    </tr>
                                    <tr runat="server">
                                        <td colspan="6" class="h-5 a-center" runat="server">
                                            <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="divProduct" runat="server">
                                <table class="w-100p hide" id="tblPODetail">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblProductName3" CssClass="w-13p" runat="server" Text="Product Name" meta:resourcekey="lblProductName3Resource1"></asp:Label>
                                            <asp:TextBox ID="txtProductName" runat="server" CssClass="medium bg-searchimage" onfocus="setContextKey();" 
                                            onkeypress="Productvalidate();"
                                                TabIndex="8" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" FirstRowSelected="True"
                                                MinimumPrefixLength="2" OnClientItemSelected="IAmSelected" ServiceMethod="GetQuickReceiveProductListJSON"
                                                BehaviorID="AutoCompleteProduct" OnClientPopulated="SetColor" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                TargetControlID="txtProductName" DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btnAddNew" runat="server" Text="Add New Product"  OnClientClick="javascript:if(!AddNewProduct()) return false; "
                                                CssClass="btn hide" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                TabIndex="9" meta:resourcekey="btnAddNewResource1" />
                                            <%-- <asp:CheckBoxList ID="chkTax" RepeatDirection="Horizontal" onchange="Chkclick(this.id)"  runat="server">
                                                            <asp:ListItem Value="1">Inclusive</asp:ListItem>
                                                            <asp:ListItem Value="2">Exclusive</asp:ListItem>
                                                          </asp:CheckBoxList>--%>
                                            <asp:CheckBox ID="chkIntax" OnClick="Chkclick(this.id);" runat="server" Text="CP"
                                                value="CP" meta:resourcekey="chkIntaxResource1" />
                                            <asp:CheckBox ID="chkExtax" OnClick="Chkclick(this.id);" runat="server" Text="MRP/SRP"
                                                value="SP" meta:resourcekey="chkExtaxResource1" />
                                            <%--<input name="but" id="btnPopUp" value="Show Costprice List" onclick="SupplierListPopup();"
                                                type="button" class="btn hide" />--%>
                                                <a name="but" id="btnPopUp" value="Show Costprice List" onclick="SupplierListPopup();"
                                                 class="btn hide"><%=Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_28 %></a>
                                        </td>
                                        <td  runat="server" id="trConsign" class="hide">
                                            <asp:CheckBox ID="ChkIsConsign" runat="server" Text="IsConsignment" onclick="return ChangeConsign();" /> 
                                        </td>
                                        <td class="hide" id="tdShowLSU">
                                            <asp:Label ID="lblLSU" runat="server" Text="LSU :" 
                                                meta:resourcekey="lblLSUResource1"></asp:Label>
                                            <asp:Label ID="lblLSUValue" runat="server" Text="-" 
                                                meta:resourcekey="lblLSUValueResource1" />
                                        </td>
                                        <td class="hide" id="tdheadLSU">
                                        </td>
                                        
                                    </tr>
                                    <tr class="hide">
                                        <td class="hide">
                                            <asp:Label ID="lblTotalAmount" runat="server" Text="Total Amount" meta:resourcekey="lblTotalAmountResource1"></asp:Label>
                                        </td>
                                        <td class="hide">
                                            <asp:Label ID="lblTotalCostAmount" Text="0.00" runat="server" meta:resourcekey="lblTotalCostAmountResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table class="w-100p bw-break lh25">
                                                <tr id="Tr5" runat="server">
                                                    <td class="w-7p">
                                                        <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" 
                                                            meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td31" class="w-8p" runat="server">
                                                        <asp:TextBox ID="txtBatchNo" runat="server" CssClass="xsmaller" onkeypress="return ValidateMultiLangChar(this);" TabIndex="10" 
                                                            meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                                    </td>

                                                    <td class="w-8p">
                                                        <asp:Label ID="lblMFTDate" runat="server" Text="MFT Date" 
                                                            meta:resourcekey="lblMFTDateResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td32" class="w-9p" runat="server">
                                                        <asp:TextBox ID="txtMFTDate" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);"  runat="server"
                                                            CssClass="monthYearPicker xsmaller " TabIndex="11" 
                                                            meta:resourcekey="txtMFTDateResource1"></asp:TextBox>
                                                        <%--<ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtMFTDate"
                                                                            Mask="99/9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                            Enabled="True" />--%>
                                                    </td>

                                                    <td id="Td14" class="w-11p" runat="server">
                                                        <asp:Label ID="lblEXPDate" runat="server" Text="EXP Date" 
                                                            meta:resourcekey="lblEXPDateResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td33" class="w-9p" runat="server">
                                                        <asp:TextBox ID="txtEXPDate" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);"  CssClass="xsmaller monthYearPicker"
                                                            runat="server" TabIndex="12" meta:resourcekey="txtEXPDateResource1"></asp:TextBox>
                                                        <%-- <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtEXPDate"
                                                                            Mask="99/9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                            Enabled="True" />--%>
                                                    </td>

                                                    <td id="Td15" class="w-7p" runat="server">
                                                        <asp:Label ID="lblRcvdUnit" runat="server" Text="Rcvd Unit" 
                                                            meta:resourcekey="lblRcvdUnitResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td34" class="w-8p" runat="server">
                                                        <asp:DropDownList ID="ddlRcvdUnit" CssClass="w-81" onchange="return ChangeConvesionQty();"
                                                            runat="server" TabIndex="13" meta:resourcekey="ddlRcvdUnitResource1">
                                                        </asp:DropDownList>
                                                        <%--doEnableSellingUnit();--%>
                                                    </td>

                                                    <td id="Td16" class="w-7p" runat="server">
                                                        <asp:Label ID="lblRcvdQty" runat="server" Text="Rcvd Qty" 
                                                            meta:resourcekey="lblRcvdQtyResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td35" class="w-8p" runat="server">
                                                        <asp:TextBox ID="txtRECQuantity" onblur="CheckRcvdLSUQty();" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            CssClass="xsmaller a-right" runat="server" TabIndex="14" 
                                                            meta:resourcekey="txtRECQuantityResource1"></asp:TextBox>
                                                    </td>
                                               
                                                    <td id="Td17" class="w-6p" runat="server">
                                                        <asp:Label ID="lblselling" runat="server" Text="Selling Unit(lsu)" 
                                                            meta:resourcekey="lblsellingResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td36" runat="server">
                                                        <asp:DropDownList ID="ddlSelling" CssClass="w-81" onchange="CheckInverseQty();" runat="server"
                                                            TabIndex="15" meta:resourcekey="ddlSellingResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr> 
                                                    <td id="Td18" class="" runat="server">
                                                        <asp:Label ID="lblInversQty" runat="server" Text="Inverse Qty" 
                                                            meta:resourcekey="lblInversQtyResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td37" runat="server">
                                                        <asp:TextBox ID="txtInvoiceQty" onblur="CheckRcvdLSUQty();" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            runat="server" CssClass="xsmaller a-right" TabIndex="16" 
                                                            meta:resourcekey="txtInvoiceQtyResource1"></asp:TextBox>
                                                    </td>

                                                    <td id="Td19" class="" runat="server">
                                                        <asp:Label ID="lblRcdLSUQty" runat="server" Text="Rcvd LSU Qty" 
                                                            meta:resourcekey="lblRcdLSUQtyResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td38" runat="server">
                                                        <asp:TextBox ID="txtRcvdLSUQty" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                                            CssClass="xsmaller a-right" TabIndex="17" meta:resourcekey="txtRcvdLSUQtyResource1"></asp:TextBox>
                                                    </td>

                                                    <td id="Td20" class="" runat="server">
                                                        <asp:Label ID="lblComp" runat="server" Text="Comp.Qty(lsu)" 
                                                            meta:resourcekey="lblCompResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td39" class="" runat="server">
                                                        <asp:TextBox ID="txtCompQuantity" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                                            onblur="TotalCalculation()" CssClass="xsmaller a-right" TabIndex="18" 
                                                            meta:resourcekey="txtCompQuantityResource1"></asp:TextBox>
                                                    </td>

                                                    <td id="Td21" class="" runat="server">
                                                        <asp:Label ID="lblCostPrice" runat="server" Text="Cost Price" 
                                                            meta:resourcekey="lblCostPriceResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td40" class="" runat="server">
                                                        <asp:TextBox ID="txtUnitPrice" CssClass="xsmaller a-right" onblur="TotalCalculation()" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            runat="server" TabIndex="19" meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                                    </td>
                                                

                                                    <td id="Td22" class="hide" runat="server">
                                                        <asp:Label ID="lblNominal" runat="server" Text="Nominal" 
                                                            meta:resourcekey="lblNominalResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td41" class="hide" runat="server">
                                                        <asp:TextBox ID="txtNominal" CssClass="xsmaller a-right" onblur="TotalCalculation()" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            runat="server" TabIndex="20" meta:resourcekey="txtNominalResource1"></asp:TextBox>
                                                    </td>

                                                    <%--<td id="Td23" class="" runat="server">
                                                        <asp:Label ID="lblDiscou" runat="server" Text="Discount(%)" 
                                                            meta:resourcekey="lblDiscouResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td42" class="" runat="server">
                                                        <asp:TextBox ID="txtDiscount" CssClass="xsmaller a-right" onblur="TotalCalculation()" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            runat="server" TabIndex="21" meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                    </td>--%>
                                                
                                                    <td id="Td24" class="hide" runat="server">
                                                        <asp:Label ID="lblEx" runat="server" Text="Examination" 
                                                         meta:resourcekey="lblExResource1"   ></asp:Label>
                                                    </td>
                                                    <td id="Td43" runat="server" class="hide">
                                                        <asp:TextBox ID="txtExTax" onblur="CSTCalculation();TotalCalculation();" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            runat="server" CssClass="xsmaller a-right" TabIndex="22" 
                                                            meta:resourcekey="txtExTaxResource1"></asp:TextBox>
                                                    </td>

                                                    <%--<td id="Td25" class="" runat="server">
                                                        <asp:Label ID="lblTax" runat="server" Text="GST" 
                                                            meta:resourcekey="lblTaxResource1"></asp:Label>
                                                    </td>--%>
                                                    <%--<td id="Td44" runat="server" class="p-re">
                                                        <asp:TextBox ID="txtTax" onblur="TotalCalculation()" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            runat="server" CssClass="xsmaller a-right" TabIndex="23"  
                                                            meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                                        <span id="popTaxTrigger" class="ui-icon ui-icon-info inline-block"></span>
                                                        <div id="divTaxDetails" runat="server" class= " right0 ww-300 p-ab card-md card-md-default padding10 hide">
                                                            <%--<table class="responstable w-100p">
                                                                <tr class="responstableHeader">
                                                                    <td>CGST</td>
                                                                    <td>SGST</td>
                                                                    <td>IGST</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>5%</td>
                                                                    <td>5%</td>
                                                                    <td>5%</td>
                                                                </tr>
                                                            </table>--%>
                                                        <%--</div>
                                                        <asp:HiddenField ID="CheckState" runat="server" />--%>
                                                    <%--</td>--%>
                                                </tr>
                                                <tr>
                                                    <td id="tdlblSchemetype" class="" runat="server">
                                                        <asp:Label ID="lblSchemetype" runat="server" Text="Scheme Type"></asp:Label>
                                                    </td>
                                                    <td id="tdddlSchemetype" class="" runat="server" onchange="Schemetype()">
                                                        <asp:DropDownList ID="ddlSchemetype" runat="server" TabIndex="21">
                                                            <asp:ListItem Text="Percentage" Value="0" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Value" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="tdlblSchmedisc" class="" runat="server">
                                                        <asp:Label ID="lblSchemeDisc" runat="server" Text="Scheme Discount"></asp:Label>
                                                    </td>
                                                    <td id="tdtxtSchemedisc" class="" runat="server">
                                                        <asp:TextBox ID="txtSchemeDisc" onblur="TotalCalculation()" CssClass="xsmaller a-right"
                                                            onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" TabIndex="21"></asp:TextBox>
                                                    </td>
                                                    <td id="tdlblDisctype" class="" runat="server">
                                                        <asp:Label ID="lblDisctype" runat="server" Text="Discount Type"></asp:Label>
                                                    </td>
                                                    <td id="tdddlDisctype" class="" runat="server">
                                                        <asp:DropDownList ID="ddlDisctype" runat="server" onchange="Disctype()" TabIndex="21">
                                                            <asp:ListItem Text="Percentage" Value="0" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Value" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="Tdlbldiscou" class="" runat="server">
                                                        <asp:Label ID="lblDiscou" runat="server" Text="Discount(%)" meta:resourcekey="lblDiscouResource1"></asp:Label>
                                                    </td>
                                                    <td id="Tdtxtdiscount" class="" runat="server">
                                                        <asp:TextBox ID="txtDiscount" CssClass="xsmaller a-right" onblur="TotalCalculation()"
                                                            onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" TabIndex="21"
                                                            meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="Td25" class="" runat="server">
                                                        <asp:Label ID="lblTax" runat="server" Text="GST" meta:resourcekey="lblTaxResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td44" runat="server" class="p-re">
                                                        <asp:TextBox ID="txtTax" onblur="TotalCalculation()" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            runat="server" CssClass="xsmaller a-right" TabIndex="23" meta:resourcekey="txtTaxResource1" ReadOnly></asp:TextBox>
                                                        <span id="popTaxTrigger" class="ui-icon ui-icon-info inline-block"></span>
                                                        <div id="divTaxDetails" runat="server" class= " right0 ww-300 p-ab card-md card-md-default padding10 hide">
                                                            <%--<table class="responstable w-100p">
                                                                <tr class="responstableHeader">
                                                                    <td>CGST</td>
                                                                    <td>SGST</td>
                                                                    <td>IGST</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>5%</td>
                                                                    <td>5%</td>
                                                                    <td>5%</td>
                                                                </tr>
                                                            </table>--%>
                                                        </div>
                                                        <asp:HiddenField ID="CheckState" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr> 
                                                    <td id="tdPurchasTax" class="hide" runat="server" >
                                                        <asp:Label ID="lblPurchaseTax" runat="server" Text="Purchase Tax(%)"></asp:Label>
                                                    </td>
                                                    <td id="tdPurchtax" class="hide" runat="server"  >
                                                        <asp:TextBox ID="txtPurchaseTax" onblur="TotalCalculation()" onkeydown="return validatenumber(event);" 
                                                            runat="server" CssClass="xsmaller" TabIndex="24"></asp:TextBox>
                                                    </td>

                                               
                                                    <td id="Td26" class="" runat="server">
                                                        <asp:Label ID="lblSellingPrice" runat="server" Text="Selling Price" 
                                                            meta:resourcekey="lblSellingPriceResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td45" runat="server">
                                                        <asp:TextBox ID="txtSellingPrice" CssClass="xsmaller a-right" onblur="AppendMRP();btnCalcSellingPrice();TotalCalculation();"
                                                            onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" TabIndex="24" 
                                                            meta:resourcekey="txtSellingPriceResource1"></asp:TextBox>
                                                    </td>

                                                    <td id="Td27" class="" runat="server">
                                                        <asp:Label ID="lblMRP" runat="server" Text="MRP" 
                                                            meta:resourcekey="lblMRPResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td9" runat="server">
                                                        <asp:TextBox ID="txtMRP" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                                            CssClass="xsmaller a-right" TabIndex="25" meta:resourcekey="txtMRPResource1"></asp:TextBox>
                                                    </td>

                                                    <td id="Td28" class="" runat="server">
                                                        <asp:Label ID="lblRakNo" runat="server" Text="RakNo" 
                                                            meta:resourcekey="lblRakNoResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtRakNo"  onblur="btnCalcSellingPrice();" runat="server" CssClass="xsmaller"
                                                            TabIndex="26" meta:resourcekey="txtRakNoResource1"></asp:TextBox>
                                                    </td>

                                                    <td id="Td29" class="" runat="server">
                                                        <asp:Label ID="lblTotalCost" runat="server" Text="Total Cost" 
                                                            meta:resourcekey="lblTotalCostResource1"></asp:Label>
                                                    </td>
                                                    <td class="" runat="server">
                                                        <asp:TextBox ID="txtTotalCost" onkeypress="return ValidateSpecialAndNumeric(this);" runat="server"
                                                            CssClass="xsmaller a-right" TabIndex="27" meta:resourcekey="txtTotalCostResource1"></asp:TextBox>
                                                    </td>

                                                    <td id="Td30" runat="server">
                                                    </td>
                                                    <td rowspan="2" runat="server">
                                                        <%--<input id="add" type="button" tabindex="28" onmouseover="this.className='btn btnhov'"
                                                            class="btn" onmouseout="this.className='btn'" onclick="javascript:if(checkIsEmpty()) return BindProductList();btnCalcSellingPrice();"
                                                            name="add" value="<%=Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_06%>" />--%>
                                                            <a id="add" tabindex="28" onmouseover="this.className='btn btnhov'"
                                                            class="btn" onmouseout="this.className='btn'" onclick="javascript:if(checkIsEmpty()) return BindProductList();btnCalcSellingPrice();"
                                                            name="add1"><%=Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_06%></a>
                                                        <asp:HiddenField ID="hdnAdd" runat="server" Value="Add" />
                                                    </td>
                                                </tr>
                                                <tr id="Tr6" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center" colspan="2">
                                            <table class="responstable w-100p font10 marginT10 marginB10" id="TableCollectedItems" runat="server">
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="a-right">
                                            <table class="w-100p" id="tbTotalCost">
                                                <tr>
                                                    <td class="a-left v-top">
                                                        <table class="w-100p lh25">
                                                            <tr>
                                                                <td ></td>
                                                                <td colspan="2"></td>
                                                                <td>
                                                                    <table class="w-100p">
                                                                       <tr>
                                                                            <td class="w-60p">
                                                                                <asp:Label ID="lblTot" runat="server" Text="Total :" CssClass="bold" meta:resourcekey="lblTotResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtNetTotal" CssClass="smaller a-right" onkeypress="return ValidateMultiLangChar(this);" Enabled="False" runat="server" Text="0.00"
                                                                                    meta:resourcekey="txtNetTotalResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            
                                                            <tr>
                                                                <td class="w-25p">
                                                                    <table class="w-100p  bg-grey">
                                                                            <tr>
                                                                                <td class="w-50p">
                                                                                    <asp:Label ID="lblAvailCreditAmt" runat="server" CssClass="bold" Text="Available Credit Amount :"
                                                                                        meta:resourcekey="lblAvailCreditAmtResource1"></asp:Label>
                                                                                </td>
                                                                                <td >
                                                                                    <asp:TextBox ID="txtAvailCreditAmount" CssClass="smaller a-right" TabIndex="28" Enabled="False"
                                                                                        onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" 
                                                                                        meta:resourcekey="txtAvailCreditAmountResource1"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnAvailableCreditAmount" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                </td>
                                                                <td class="w-25p">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblTotaSale" runat="server" Text="Total Sales :" meta:resourcekey="lblTotaSaleResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTotalSales" CssClass="smaller a-right" Enabled="False" onblur="checkAddToTotal();"
                                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" meta:resourcekey="txtTotalSalesResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="w-25p">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblPODisc" runat="server" Text=" PO Discount :" meta:resourcekey="lblPODiscResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTotalDiscount" TabIndex="30" CssClass="smaller a-right" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                                    runat="server" Text="0.00" onblur="checkAddToTotal();" meta:resourcekey="txtTotalDiscountResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p">
                                                                         <tr id="tdTaxAmt" runat="server">
                                                                            <td  class="w-60p">
                                                                                <asp:Label ID="lblTDiscAmount" runat="server" CssClass="bold" Text="Total Discount Amount :" meta:resourcekey="lblTDiscAmountResource1"></asp:Label>
                                                                                  </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTotalDiscountAmt" Enabled="False" runat="server" Text="0.00"  CssClass="smaller a-right" onkeypress="return ValidateMultiLangChar(this);"
                                                                                    meta:resourcekey="txtTotalDiscountAmtResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="hide">
                                                                    <table class="w-100p hide">
                                                                        <tr id="trTotalExcise" runat="server">
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblTotalExcise" runat="server" Text="Total Excise :" meta:resourcekey="lblTotalExciseResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTotalExcise" CssClass="smaller a-right" Enabled="False" onblur="checkAddToTotal();"
                                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" meta:resourcekey="txtTotalExciseResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                
                                                            </tr>
                                                            <tr id="gstRow">
                                                                <td>
                                                                    <table class="w-100p" id="totalCGSTId">
                                                                        <tr>
                                                                            <td class="w-50p">
                                                                                <asp:Label ID="lblcgst" Text="Total CGST:" runat="server" meta:resourcekey="lblcgstResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtcgst" runat="server" CssClass="smaller a-right" Enabled="False"
                                                                                    onblur="checkAddToTotal();" onKeyDown="return validatenumber(event);" runat="server"
                                                                                    Text="0.00"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p" id="totalSGSTId">
                                                                        <tr>
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblsgst" Text="Total SGST:" runat="server" meta:resourcekey="lblsgstResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtsgst" runat="server" CssClass="smaller a-right" Enabled="False"
                                                                                    onblur="checkAddToTotal();" onKeyDown="return validatenumber(event);" runat="server"
                                                                                    Text="0.00"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p" id="totalIGSTId">
                                                                        <tr>
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lbligst" Text="Total IGST:" runat="server" meta:resourcekey="lbligstResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtigst" runat="server" CssClass="smaller a-right" Enabled="False"
                                                                                    onblur="checkAddToTotal();" onKeyDown="return validatenumber(event);" runat="server"
                                                                                    Text="0.00"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p" id="totalGSTOrVATId">
                                                                        <tr id="tdTotalTax" runat="server">
                                                                            <td  class="w-60p">
                                                                                <asp:Label ID="lblTTAmount" runat="server" Text="Total GST/VAT Amount :" CssClass="bold" meta:resourcekey="lblTTAmountResource1"></asp:Label>
                                                                             </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTotalTaxAmt" Enabled="False"  CssClass="smaller a-right" onkeypress="return ValidateMultiLangChar(this);" runat="server" Text="0.00" meta:resourcekey="txtTotalTaxAmtResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="hide">
                                                                    <table class="w-100p">
                                                                        <tr id="trCessEx" runat="server">
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblCessEx" runat="server" Text="Cess On Excise 2%:" meta:resourcekey="lblCessExResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtCessOnExcise" CssClass="smaller a-right" Enabled="False" onblur="checkAddToTotal();"
                                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" meta:resourcekey="txtCessOnExciseResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="hide">
                                                                    <table class="w-100p">
                                                                        <tr id="trHighteEdCes" runat="server">
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblHighteEdCes" runat="server" Text="Highter Ed.Cess 1%:" meta:resourcekey="lblHighteEdCesResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtHighterEdCess" CssClass="smaller a-right" Enabled="False" onblur="checkAddToTotal();"
                                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" meta:resourcekey="txtHighterEdCessResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="hide">
                                                                    <table class="w-100p">
                                                                        <tr id="trCST" runat="server">
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblCST" runat="server" Text="CST 5%:" meta:resourcekey="lblCSTResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtCST" CssClass="smaller a-right" Enabled="False" onblur="checkAddToTotal();"
                                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" runat="server" Text="0.00" meta:resourcekey="txtCSTResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="hide">
                                                                    <table class="w-100p">
                                                                        <tr  id="trStampFee" runat="server">
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblStampFee" runat="server" Text="Stamp Fee :" meta:resourcekey="lblStampFeeResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtStampFee" CssClass="small a-right" onkeypress="return ValidateMultiLangChar(this);"  onblur="checkAddToTotal();"  Enabled="true" runat="server" Text="0.00"
                                                                                    meta:resourcekey="txtStampFeeResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p">
                                                                        <tr id="trHideSupplierSerTax" runat="server">
                                                                            <td class="w-50p">
                                                                                <asp:Label ID="lblSstax" runat="server" Text="Supplier Service Tax(%) :" meta:resourcekey="lblSstaxResource1"></asp:Label>
                                                                
                                                                           </td> 
                                                                            <td>
                                                                                <asp:TextBox ID="txtTotaltax" TabIndex="29" CssClass="smaller a-right" onblur="checkAddToTotal();" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                                    runat="server" Text="0.00" meta:resourcekey="txtTotaltaxResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblRoundOff" runat="server" Text="RoundOff Value :" meta:resourcekey="lblRoundOffResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtRoundOffValue" runat="server" onkeypress="return ValidateMultiLangChar(this);" CssClass="smaller a-right" Text="0.00" Enabled="False"
                                                                                    meta:resourcekey="txtRoundOffValueResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="w-40p">
                                                                                <asp:Label ID="lblRoundedOffNetTotal" runat="server" Text="Rounded-Off Net Total :"
                                                                                    meta:resourcekey="lblRoundedOffNetTotalResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtGrandwithRoundof" onkeypress="return ValidateSpecialAndNumeric(this);" CssClass="smaller a-right"
                                                                                    runat="server" Text="0.00" onblur="return CalRounfOff(); " meta:resourcekey="txtGrandwithRoundofResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                
                                                                 <td>
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="w-60p">
                                                                                <asp:Label ID="lblCreditAmountToBeUsed" runat="server" CssClass="bold" Text="Credit Amount To Be Used :"
                                                                                    meta:resourcekey="lblCreditAmountToBeUsedResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtUseCreditAmount" onkeypress="return ValidateSpecialAndNumeric(this);" CssClass="smaller a-right"
                                                                                    runat="server" Text="0.00" onblur="checkAddToTotal();" meta:resourcekey="txtUseCreditAmountResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table class="w-100p">
                                                                        <tr id="trDeliveryCharges" runat="server">
                                                                            <td class="w-50p">
                                                                                <asp:Label ID="lblDeliveryCharges" runat="server" Text="Delivery Charges :" meta:resourcekey="lblDeliveryChargesResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtDeliveryCharges" CssClass="small a-right" onkeypress="return ValidateMultiLangChar(this);"  onblur="checkAddToTotal();" Enabled="true" runat="server" Text="0.00"
                                                                                    meta:resourcekey="txtDeliveryChargeResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>

                                                                </td>
                                                                <td>

                                                                </td>
                                                                <td>
                                                                    <table class="w-100p dottedbdr">
                                                                        <tr class="lh40">
                                                                            <td class="w-60p">
                                                                                <asp:Label ID="lblGTot" runat="server" Text="Grand Total :" CssClass="bold" meta:resourcekey="lblGTotResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtGrandTotal" onkeypress="return ValidateMultiLangChar(this);" Enabled="False" CssClass="smaller a-right" runat="server" Text="0.00"
                                                                                    meta:resourcekey="txtGrandTotalResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
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
                                            <table id="submitTab" runat="server" class="hide w-100p">
                                                <tr runat="server">
                                                    <td>
                                                        <%--<input type="button" value="Save as draft" class="btn marginR8" onclick="fnSaveAsDrafts('ManualSave')" />--%>
                                                        <a class="btn marginR8" onclick="fnSaveAsDrafts('ManualSave')">
                                                        <%=Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_29 %></a>
                                                        <asp:Button ID="btnFinish" AccessKey="E" TabIndex="31" OnClientClick="javascript:return checkDetails();"
                                                            runat="server" OnClick="btnFinish_Click" Text="Finish" 
                                                            CssClass="btn marginR8" meta:resourcekey="btnFinishResource1" />
                                                        <asp:Button ID="btnCancel" TabIndex="32" runat="server" Text="Home" OnClick="btnCancel_Click"
                                                            OnClientClick="javascript:return Validate();" CssClass="btn" 
                                                            meta:resourcekey="btnCancelResource1" />
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
                <div id="divNewProduct" runat="server" class="hide">
                    <table class="w-100p">
                        <tr>
                            <td colspan="4" class="a-center">
                                <asp:Label ID="lblnewmsg" runat="server" meta:resourcekey="lblnewmsgResource1"></asp:Label>
                                <input type="hidden" id="hdnStatus" runat="server" />
                                <asp:HiddenField ID="hdnproId" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnvalue" runat="server" />
                                <input id="hdnGenericID" runat="server" type="hidden" value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblGenericName" Text="Generic Name" runat="server" meta:resourcekey="lblGenericNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtGenericName" runat="server" MaxLength="50" onkeypress="return ValidateMultiLangChar(this);"
                                    TabIndex="33" CssClass="small"  meta:resourcekey="txtGenericNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderGeneric" runat="server" TargetControlID="txtGenericName"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                    OnClientItemSelected="SelectGeneric" MinimumPrefixLength="1" CompletionInterval="1"
                                    FirstRowSelected="True" ServiceMethod="GetSearchGenericList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblProductName" runat="server" Text="Product Name" meta:resourcekey="lblProductNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtnewProducts" runat="server" MaxLength="100" TabIndex="34" CssClass="small" onkeypress="return ValidateMultiLangChar(this);"
                                 onBlur="return ConverttoUpperCase(this.id);"   meta:resourcekey="txtnewProductsResource1"></asp:TextBox>
                                <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td>
                                <asp:Label ID="lblProductCode" Text="Product Code" runat="server" 
                                    meta:resourcekey="lblProductCodeResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProductCode" runat="server" CssClass="small" TabIndex="35" 
                                    onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtProductCodeResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMake" Text="Make / Brand" runat="server" 
                                    meta:resourcekey="lblMakeResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMake" runat="server" CssClass="small" TabIndex="36" onkeypress="return ValidateMultiLangChar(this);"
                                    meta:resourcekey="txtMakeResource1"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblManufactureName" runat="server" Text="Manufacturer Name" meta:resourcekey="lblManufactureNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMfgName" TabIndex="37" runat="server" CssClass="small" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txtMfgNameResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblManufacture" runat="server" Text=" Manufacturer Code" meta:resourcekey="lblManufactureResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMfgCode" TabIndex="38" runat="server" onkeypress="return ValidateMultiLangChar(this);" CssClass="small" meta:resourcekey="txtMfgCodeResource1"></asp:TextBox>
                            </td>
                            <td class="v-top">
                                <asp:Label ID="lblDescription2" runat="server" Text="Description" meta:resourcekey="lblDescription2Resource1"></asp:Label>
                            </td>
                            <td class="v-top">
                                <asp:TextBox ID="txtDescription" CssClass="large" TabIndex="39" onkeypress="return ValidateMultiLangChar(this);" TextMode="MultiLine"
                                    runat="server" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblType2" runat="server" Text="Type" meta:resourcekey="lblType2Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType" TabIndex="40" CssClass="small" runat="server" meta:resourcekey="ddlTypeResource1">
                                </asp:DropDownList>
                                <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td>
                                <asp:Label ID="lblCategoryName" runat="server" Text="Category Name" meta:resourcekey="lblCategoryNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCategory" TabIndex="41" CssClass="small" runat="server" meta:resourcekey="ddlCategoryResource1"
                                    onblur="javascript:return SetTax();">
                                </asp:DropDownList>
                                <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblUnit" runat="server" Text="Least Sellable Unit" meta:resourcekey="lblUnitResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="bUnits" runat="server" CssClass="small" meta:resourcekey="bUnitsResource1"
                                    TabIndex="42" />
                                <img align="middle" alt="" src="../PlatForm/Images/starbutton.png" />
                            </td>
                            <td class="v-top" id="Taxper" runat="server">
                                <asp:Label ID="Label1" runat="server" Text="Tax Percentage" 
                                    meta:resourcekey="Label1Resource1"></asp:Label>
                            </td>
                            <td class="v-top" id="TaxProTaxCal" runat="server">
                                <asp:TextBox ID="TxtProdTax" runat="server" CssClass="small" TabIndex="43" onkeypress="return ValidateMultiLangChar(this);" 
                                    OnBlur="return doValidatePercent(this);" meta:resourcekey="TxtProdTaxResource1">0</asp:TextBox>
                                %
                            </td>
                        </tr>
                        <tr class="hide">
                            <td class="v-top">
                                <asp:Label ID="lblAssiAttributes" runat="server" Text="Assign Attributes" meta:resourcekey="lblAssiAttributesResource1"></asp:Label>
                                &nbsp;
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkIsScheduleHDrug" TabIndex="44" runat="server" meta:resourcekey="chkIsScheduleHDrugResource1" />
                                            &nbsp;&nbsp;<asp:Label
                                                ID="lblIs" runat="server" Text=" Is " meta:resourcekey="lblIsResource1"></asp:Label>
                                            <asp:Label ID="lblScheduleHDrug" runat="server" Text="ScheduleH Drug" meta:resourcekey="lblScheduleHDrugResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkExpDate" TabIndex="45" runat="server" meta:resourcekey="chkExpDateResource1" />
                                            &nbsp;&nbsp;
                                            <asp:Label ID="lblHasExpiry2" runat="server" Text="Has Expiry " meta:resourcekey="lblHasExpiry2Resource1"></asp:Label>
                                            <asp:Label ID="lblDate2" runat="server" Text="Date" meta:resourcekey="lblDate2Resource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkBatchNo" TabIndex="46" runat="server" meta:resourcekey="chkBatchNoResource1" />
                                            &nbsp;&nbsp;<asp:Label
                                                ID="lblHasBatchNo" runat="server" Text="Has Batch No" meta:resourcekey="lblHasBatchNoResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="v-middle">
                                <asp:Label ID="Label3" runat="server" Text="Attributes" meta:resourcekey="Label3Resource1"></asp:Label>
                            </td>
                            <td >
                                <div id="divProductAttributes" runat="server">
                                </div>
                            </td>
                            <td colspan="4" runat="server" id="tdAddIsConsignment" class="hide">
                                <asp:CheckBox ID="chkAddIsConsignment" TabIndex="44" runat="server" Text="Consignment Product" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLocation" runat="server" Text="Location" 
                                    meta:resourcekey="lblLocationResource1"></asp:Label>
                            </td>
                            <td colspan="3">
                                <div id="divLocation" class="show" runat="server">
                                    <table id="tblLocation" class="w-100p">
                                        <tr>
                                            <td>
                                                <div id="divLocationItem" class="w-100p" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblOrgName" runat="server" Text="Organization Name" 
                                                                    meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtOrgName" TabIndex="47" onkeypress="return ValidateMultiLangChar(this);" onkeydown="javascript:return Checkorgtext();"
                                                                    runat="server" CssClass="large" meta:resourcekey="txtOrgNameResource1"> </asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoOrgName" runat="server" TargetControlID="txtOrgName"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                    OnClientItemSelected="SelectOrganization" MinimumPrefixLength="1" CompletionInterval="1"
                                                                    FirstRowSelected="True" ServiceMethod="GetSearchLocationList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                                    DelimiterCharacters="" Enabled="True" OnClientPopulated="ChangeTxtBoxWidthDynamic">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLocationName" runat="server" Text="Location Name" 
                                                                    meta:resourcekey="lblLocationNameResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtLocationName" CssClass="small" runat="server" TabIndex="48" onkeypress="return ValidateMultiLangChar(this);"
                                                                    onkeydown="javascript:return CheckorgLocationtext();" 
                                                                    meta:resourcekey="txtLocationNameResource1"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLocation" runat="server" TargetControlID="txtLocationName"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                    OnClientItemSelected="SelectLocation" MinimumPrefixLength="1" CompletionInterval="1"
                                                                    FirstRowSelected="True" ServiceMethod="GetSearchLocationList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                                    DelimiterCharacters="" Enabled="True" OnClientPopulated="ChangeTxtBoxWidthDynamiclocat">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblReOrderLevel" runat="server" Text="Re-Order Level" 
                                                                    meta:resourcekey="lblReOrderLevelResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtReOrderLevel" runat="server" CssClass="mini" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                    Text="0" TabIndex="49" meta:resourcekey="txtReOrderLevelResource1"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblMaxQTY" runat="server" Text="Max.Qty(LSU)"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMaxQTY" runat="server"
                                                                  TabIndex="50"  CssClass="small" Width="40px" onKeyDown="return validatenumber(event);" Text="0"> </asp:TextBox>
                                                            </td>
                                                            <td>
                                                                    <button runat="server" class="btn" id="btnAddLocation" value="Add"  meta:resourcekey="btnAddLocation"  onclick="javascript:if(checkLocation()) return BindLocationList();return false;"
                                                                    tabindex="51" ><%=Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_06%> </button>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Table CssClass="w-100p gridView" runat="server" ID="tblLocationlist" meta:resourcekey="tblLocationlistResource1">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                    </table>
                                    <input type="hidden" id="hdnLocationID" value="0" runat="server" />
                                    <input type="hidden" id="hdnLocationName" runat="server" />
                                    <input id="hdnLocationList" runat="server" type="hidden" />
                                    <input id="hdnLocRowEdit" runat="server" type="hidden" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="a-center">
                                <asp:Button ID="btnNewProduct" Text="Save" TabIndex="50" runat="server" onmouseover="this.className='btn btnhov'"
                                    CssClass="btn" OnClientClick="javascript:return NewProductcheckDetails();" onmouseout="this.className='btn'"
                                    OnClick="btnNewProductFinish_Click" meta:resourcekey="btnNewProductResource1" />
                                <asp:Button ID="btnnewCancel" TabIndex="51" OnClientClick="javascript:return NewProductCancel();"
                                    runat="server" Text="Cancel" CssClass="cancel-btn"  meta:resourcekey="btnnewCancelResource1" />
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:HiddenField ID="hdnMandFieldDisable" runat="server" Value="Y" />
                <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
                <input type="hidden" id="hdnTempValue" runat="server" />
                <input type="hidden" id="hdnTempTable" runat="server" />
                <input type="hidden" id="hdnRowEdit" runat="server" />
                <input type="hidden" id="hdnProductList" runat="server" />
                <input type="hidden" id="hdnRowId" value="0" runat="server" />
                <input type="hidden" id="hdnProductName" runat="server" />
                <input type="hidden" id="hdnType" runat="server" />
                <input type="hidden" id="hdnUnitCostPrice" value="0" runat="server" />
                <input type="hidden" id="hdnHasExpiryDate" value="N" runat="server" />
                <input type="hidden" id="hdnHasBatchNo" value="Y" runat="server" />
                 <input type="hidden" id="hdnHasCostPrice" value="N" runat="server" />
        <input type="hidden" id="hdnHasSellingPrice" value="N" runat="server" />
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
                <asp:HiddenField ID="hdnfdisplaydata" runat="server" />
                <asp:HiddenField ID="hdnSellingPrieRuleList" runat="server" />
                <asp:HiddenField ID="hdnIsSellingPriceRuleApply" runat="server" Value="N" />
                <asp:HiddenField ID="hdnOrgId" runat="server" Value="0" />
                <asp:HiddenField ID="hdnProductAttributes" runat="server" Value="" />
                <asp:HiddenField ID="hdnCatTax" runat="server" Value="" />
                <asp:HiddenField ID="hdnGetTax" runat="server" Value="0" />
                <asp:HiddenField ID="hdnTotalTax" runat="server" Value="0" />
                <asp:HiddenField ID="hdnTotalDiscount" runat="server" Value="0" />
                <asp:HiddenField ID="hdnsupplierServiceTaxAmount" runat="server" Value="0" />
                <asp:HiddenField ID="hdnREQCalcCompQTY" runat="server" Value="N" />
                <asp:HiddenField ID="hdnCompQty" runat="server" Value="N" />
                <asp:HiddenField ID="hdnPurchareOrdeID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnHideTax" runat="server" />
                <asp:HiddenField ID="hdnDCNumber" runat="server" Value="N" />
                <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
                <input id="hdnIsEditTax" type="hidden" value="N" runat="server" />
                <input type="hidden" runat="server" id="hdnLoginLocationID" />
                <input type="hidden" runat="server" id="hdnPageID" />
                <input type="hidden" runat="server" id="hdnLoginID" />
                <input type="hidden" id="hdnDaftMethod" />
                <asp:HiddenField ID="hdnisConsignmentStock" runat="server" Value="" />
                <asp:HiddenField ID="hdnIsSchemeDiscount" runat="server" Value="N" />
                <asp:HiddenField ID="hdnSchemeType" runat="server" />
                <asp:HiddenField ID="hdnDisctype" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnCSTValue" runat="server" Value="5" />
    <asp:HiddenField ID="hdnIsVATNotApplicable" runat="server" Value="" />
	<input type="hidden" id="hdnTax" runat="server" />
    <input type="hidden" id="hdnPurchaseTax" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>


<script type="text/javascript" language="javascript">
    function AddNewProduct() {
        //document.getElementById('divNewProduct').style.display = 'block';
        $('#divNewProduct').removeClass().addClass('show');
        //document.getElementById('divProduct').style.display = 'none';
        $('#divProduct').removeClass().addClass('hide');
        document.getElementById('txtnewProducts').value = '';

        document.getElementById('ddlCategory').value = 0;
        document.getElementById('ddlType').value = 0;
        document.getElementById('txtDescription').value = '';
        document.getElementById('txtMfgName').value = '';
        document.getElementById('txtMfgCode').value = '';
        //   document.getElementById('txtReOrderLevel').value = '';
        document.getElementById('chkIsScheduleHDrug').checked = false;
        document.getElementById('chkBatchNo').checked = false;
        document.getElementById('chkExpDate').checked = false;
        //document.getElementById('txtnewProducts').focus();
        document.getElementById('txtGenericName').focus();
        //  document.getElementById('hdnLocationList').value = '';
        document.getElementById('txtGenericName').value = '';
        document.getElementById('txtProductCode').value = '';
        document.getElementById('txtMake').value = '';
        tableLocationList();
        return false;
    }

    function NewProductcheckDetails() {

        if (document.getElementById('txtnewProducts').value.trim() == '') {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_17") == null ? "Provide the product name" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_17");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtnewProducts').focus();
            return false;
        }

        if (document.getElementById('ddlType').value == "0") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_37") == null ? "Select the type" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_37");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('ddlType').focus();
            return false;
        }

        if (document.getElementById('ddlCategory').value == "0") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_38") == null ? "Select the category name" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_38");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('ddlCategory').focus();
            return false;
        }
        //            if (document.getElementById('txtReOrderLevel').value == '') {
        //                userMsg = SListForApplicationMessages.Get('Inventory\\QuickStockReceived.aspx_39');
        //                   if(userMsg !=null)
        //                          {
        //                                 alert (userMsg );
        //                                    return false;
        //                           }  
        //            else{
        //                alert('Provide the reorder level');
        //                   return false;
        //                }
        //                document.getElementById('txtReOrderLevel').focus();
        //                return false;
        //            }
        if (document.getElementById('bUnits').value == "0") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_39") == null ? "Select Least Sellable Unit" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_39");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('bUnits').focus();
            return false;
        }
        GetProductsAttributes();
    }

    function NewProductCancel() {
        //document.getElementById('divNewProduct').style.display = 'none';
        $('#divNewProduct').removeClass().addClass('hide');
        //document.getElementById('divProduct').style.display = 'block';
        $('#divProduct').removeClass().addClass('show');
        document.getElementById('txtProductName').focus();
        document.getElementById('bUnits').value = "0";
        return false;
    }
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

        if ($('#txtInvoiceNo').val() != '') {
            $('#imagInvoiceDate').attr("disabled", false);
           // $('#txtInvoiceDate').attr("disabled", false);
            $('#txtInvoiceDate').focus();
        }
        else {
            $('#txtInvoiceDate').val('');
            $('#imagInvoiceDate').attr("disabled", true);
            $('#txtInvoiceDate').attr("disabled", true);
        }
    }

    function checkDate1(obj) {

        var myValStr = document.getElementById(obj).value;

        if (myValStr != "__/____" && myValStr != "") {
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
               // document.getElementById(obj).focus();
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40") == null ? "Provide valid date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40");
                ValidationWindow(userMsg, ErrorMsg);
                return false;

               // return isTrue;
            }
            var pdate = Mon + pyyyy;
            var pdatelen = pdate.length;
            for (j = 0; j < pdatelen; j++) {
                if (pdate.charAt(j) == "_") {
                    document.getElementById(obj).focus();

                    var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40") == null ? "Provide valid date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_40");
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                }
            }
        }
    }



    function setFocus(obj, pType) {
        if (pType == "F") {
            if ($('#tblPODetail').hasClass('hide')) {
                document.getElementById('txtPODate').focus();
            }
        }

    }
    function SelectGeneric(source, eventArgs) {
        var PColval = eventArgs.get_value().split('~');
        document.getElementById('hdnGenericID').value = PColval[0];
        //            document.getElementById('txtGenericName').value = PColval[1];

    }
    function SelectLocation(source, eventArgs) {
        var PColval = eventArgs.get_value().split('~');
        document.getElementById('hdnLocationID').value = PColval[0];
        document.getElementById('hdnLocationName').value = PColval[1];
        //            document.getElementById('txtLocationName').value = PColval[1];

    }

    function SelectOrganization(source, eventArgs) {
        var PColval = eventArgs.get_value().split('~');
        document.getElementById('hdnOrgId').value = PColval[0];

    }
    function checkLocation() {
        if (document.getElementById('hdnOrgId').value == "0" || document.getElementById('txtOrgName').value.trim() == "") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_41") == null ? "Provide the Organization" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_41");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtOrgName').focus();
            return false;
        }
        if (document.getElementById('txtLocationName').value.trim() == "") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_42") == null ? "Provide the LocationName" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_42");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtLocationName').focus();
            return false;
        }

        if (document.getElementById('txtReOrderLevel').value == "") {
        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_43") == null ? "Provide ReOrder Level quantity" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_43");
            ValidationWindow(userMsg, ErrorMsg);
            document.getElementById('txtReOrderLevel').focus();
            return false;
        }

        if (document.getElementById('btnAddLocation').value != 'Update') {
            var x = document.getElementById('hdnLocationList').value.split("^");
            var pLocID = document.getElementById('hdnLocationID').value;
            var pLocationName = document.getElementById('txtLocationName').value;
            var y; var i;
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    if (y[0] == pLocID) {
                        var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_44") == null ? "This Location already exist" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_44");
                        ValidationWindow(userMsg, ErrorMsg);
                        document.getElementById('txtLocationName').value = '';
                        document.getElementById('txtLocationName').focus();
                        return false;
                    }
                }
            }
        }
        var Update = SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_34') == null ? "Update" : SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_34');
        var Add = SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_35') == null ? "Add" : SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_35');
        if ($('#btnAddLocation').text() == Update) {
            $('#btnAddLocation').text(Add);
        }
        return true;
    }


    function BindLocationList() {
        var Update = SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_34') == null ? "Update" : SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_34');
        if (document.getElementById('btnAddLocation').value == 'Update') {
            DeleterowsLoc();
        }
        else {

            var POrgId = document.getElementById('hdnOrgId').value;
            var pOrgName = document.getElementById('txtOrgName').value;
            var pLocationID = document.getElementById('hdnLocationID').value;
            var pLocationName = document.getElementById('txtLocationName').value;
            var pReOrderLevelQuantity = document.getElementById('txtReOrderLevel').value;
            var pMaxQTY = document.getElementById('txtMaxQTY').value;
            document.getElementById('hdnLocationList').value += pLocationID + "~" + pLocationName + "~" + pReOrderLevelQuantity + "~" + POrgId + "~" + pOrgName + "~" + pMaxQTY + "^";
            tableLocationList();
        }

        document.getElementById('btnAddLocation').value = 'Add';
        document.getElementById('txtLocationName').value = '';
        document.getElementById('txtReOrderLevel').value = '0';
        document.getElementById('txtMaxQTY').value = '0';
        document.getElementById('txtLocationName').focus();
        return false;
    }

    function tableLocationList() {


        while (count = document.getElementById('tblLocationlist').rows.length) {

            for (var j = 0; j < document.getElementById('tblLocationlist').rows.length; j++) {
                document.getElementById('tblLocationlist').deleteRow(j);
            }
        }

        var Headrow = document.getElementById('tblLocationlist').insertRow(0);
        Headrow.id = "HeadID";
        //    Headrow.style.backgroundColor = "#2c88b1";
        Headrow.style.fontWeight = "bold";
        //    Headrow.style.color = "#FFFFFF";
        Headrow.className = "gridHeader"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);


        var SNo = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_01") == null ? "S.No." : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_01");
        var OrganizationName = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_02") == null ? "Organization Name" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_02");
        var Location = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_03") == null ? "Location Name" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_03");
        var REOrder = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_04") == null ? "Re-Order Level Quantity" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_04");
        var Action = SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_05") == null ? "Action" : SListForAppDisplay.Get("QuickStockReceived_QuickStockReceived_aspx_05");
        var MaxQTY = SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_33') == null ? "Maximum Quantity" : SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_33');

        cell1.innerHTML = SNo;
        cell2.innerHTML = OrganizationName;
        cell3.innerHTML = Location;
        cell4.innerHTML = REOrder;
        cell5.innerHTML = MaxQTY;
        cell6.innerHTML = Action;

        var x = document.getElementById('hdnLocationList').value.split("^");
        var pCount = x.length;
        pCount = pCount - 1;

        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');

                var row = document.getElementById('tblLocationlist').insertRow(1);
                row.style.height = "13px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);


                cell1.innerHTML = pCount;
                cell2.innerHTML = y[4];
                cell3.innerHTML = y[1];
                cell4.innerHTML = y[2];
                cell5.innerHTML = y[5];

                var pAction = "";

                pAction = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "' onclick='btnLocEdit_OnClick(name);' value = '' type='button' class='ui-icon ui-icon-pencil pointer pull-left'  />&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "' onclick='btnLocDelete(name);' value = '' type='button' class='ui-icon ui-icon-trash pointer pull-left'  />"
                cell6.innerHTML = pAction;

            }
            pCount = pCount - 1;
        }


    }

    function btnLocEdit_OnClick(sEditedData) {
        var Update = SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_34') == null ? "Update" : SListForAppDisplay.Get('QuickStockReceived_QuickStockReceived_aspx_34');
        $('#btnAddLocation').text(Update);
        var y = sEditedData.split('~');
        document.getElementById('hdnOrgId').value = y[3];
        document.getElementById('txtOrgName').value = y[4];
        document.getElementById('hdnLocationID').value = y[0];
        document.getElementById('txtLocationName').value = y[1];
        document.getElementById('hdnLocationName').value = y[1];
        document.getElementById('txtReOrderLevel').value = y[2];
        document.getElementById('hdnLocRowEdit').value = sEditedData;
        document.getElementById('btnAddLocation').value = 'Update';
    }

    function btnLocDelete(sEditedData) {
        var i;
        var x = document.getElementById('hdnLocationList').value.split("^");
        document.getElementById('hdnLocationList').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('hdnLocationList').value += x[i] + "^";
                }
            }
        }
        tableLocationList();
    }


    function DeleterowsLoc() {
        var RowEdit = document.getElementById('hdnLocRowEdit').value;
        var x = document.getElementById('hdnLocationList').value.split("^");
        if (RowEdit != "") {

            var POrgId = document.getElementById('hdnOrgId').value;
            var pOrgName = document.getElementById('txtOrgName').value;
            var pLocationId = document.getElementById('hdnLocationID').value;
            var pLocationName = document.getElementById('hdnLocationName').value;
            var pReOrderLevelQTY = document.getElementById('txtReOrderLevel').value;
            var pMaxQTY = document.getElementById('txtMaxQTY').value;

            document.getElementById('hdnLocationList').value = pLocationId + "~" + pLocationName + "~" + pReOrderLevelQTY + "~" + POrgId + "~" + pOrgName + "~" + pMaxQTY + "^";


            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != RowEdit) {
                        document.getElementById('hdnLocationList').value += x[i] + "^";
                    }
                }
            }
            document.getElementById('hdnLocRowEdit').value = "";
            tableLocationList();

            document.getElementById('txtLocationName').readOnly = false;

        }
    }

    function Checkorgtext() {

        if ($("#<%=txtOrgName.ClientID%>").val().length > 12) {
            $("#<%=txtOrgName.ClientID%>").val("")
            $("#<%=hdnOrgId.ClientID%>").val("0");
        }
        $("#<%=txtLocationName.ClientID%>").val("")
        $("#<%=hdnLocationID.ClientID%>").val("0");
        var OrgId = $("#<%=hdnOrgId.ClientID%>").val();
        var ContextInfodetails = 'Org' + '~' + OrgId
        $find('AutoOrgName').set_contextKey(ContextInfodetails);

    }
    function CheckorgLocationtext() {
        var OrgId = $("#<%=hdnOrgId.ClientID%>").val();
        var ContextInfodetails = 'Location' + '~' + OrgId
        if (OrgId != "" && OrgId != "0")
            $find('AutoCompleteExtenderLocation').set_contextKey(ContextInfodetails);
        else
            $find('AutoCompleteExtenderLocation').set_contextKey("");
    }


    function ChangeTxtBoxWidthDynamic() {
        var completionList = $find("AutoOrgName").get_completionList().childNodes;
        for (var i = 0; i < completionList.length; i++) {
            var temp = completionList[i].innerHTML;
            if ($('#AutoOrgName_completionListElem').length > 0 && temp.length != '') {
                if (temp.length > 0 && temp.length < 10) {
                    $('#AutoOrgName_completionListElem').css('width', '150px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '200px');
                    });
                }
                else if (temp.length > 10 && temp.length < 25) {
                    $('#AutoOrgName_completionListElem').css('width', '200px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '200px');
                    });
                }
                else if (temp.length > 25 && temp.length < 30) {
                    $('#AutoOrgName_completionListElem').css('width', '250px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '250px');
                    });
                }
                else if (temp.length > 30 && temp.length < 35) {
                    $('#AutoOrgName_completionListElem').css('width', '300px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '300px');
                    });
                }
                else if (temp.length > 35 && temp.length < 40) {
                    $('#AutoOrgName_completionListElem').css('width', '320px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '320px');
                    });
                }
                else if (temp.length > 40 && temp.length < 45) {
                    $('#AutoOrgName_completionListElem').css('width', '340px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '340px');
                    });
                }
                else if (temp.length > 45 && temp.length < 50) {
                    $('#AutoOrgName_completionListElem').css('width', '370px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '370px');
                    });
                }
                else if (temp.length > 50 && temp.length < 55) {
                    $('#AutoOrgName_completionListElem').css('width', '400px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '400px');
                    });
                }
                else if (temp.length > 55 && temp.length < 60) {
                    $('#AutoOrgName_completionListElem').css('width', '450px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '450px');
                    });
                }
                else if (temp.length > 60 && temp.length < 65) {
                    $('#AutoOrgName_completionListElem').css('width', '500px');
                    $("#AutoOrgName_completionListElem li").each(function(n) {
                        $(this).css('width', '500px');
                    });
                }
            }
        }
    }
    function ChangeTxtBoxWidthDynamiclocat() {
        var completionList = $find("AutoCompleteExtenderLocation").get_completionList().childNodes;
        for (var i = 0; i < completionList.length; i++) {
            var temp = completionList[i].innerHTML;
            if ($('#AutoCompleteExtenderLocation_completionListElem').length > 0 && temp.length != '') {
                if (temp.length > 0 && temp.length < 10) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '150px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '200px');
                    });
                }
                else if (temp.length > 10 && temp.length < 25) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '200px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '200px');
                    });
                }
                else if (temp.length > 25 && temp.length < 30) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '250px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '250px');
                    });
                }
                else if (temp.length > 30 && temp.length < 35) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '300px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '300px');
                    });
                }
                else if (temp.length > 35 && temp.length < 40) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '320px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '320px');
                    });
                }
                else if (temp.length > 40 && temp.length < 45) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '340px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '340px');
                    });
                }
                else if (temp.length > 45 && temp.length < 50) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '370px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '370px');
                    });
                }
                else if (temp.length > 50 && temp.length < 55) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '400px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '400px');
                    });
                }
                else if (temp.length > 55 && temp.length < 60) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '450px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '450px');
                    });
                }
                else if (temp.length > 60 && temp.length < 65) {
                    $('#AutoCompleteExtenderLocation_completionListElem').css('width', '500px');
                    $("#AutoCompleteExtenderLocation_completionListElem li").each(function(n) {
                        $(this).css('width', '500px');
                    });
                }
            }
        }
    }
    //sathish-start--should alow alphanumeric.. 
    function ValidateSplChar(txt) {
        txt.value = txt.value.replace(/[^a-zA-Z 0-9\n\r]+/g, '');
    }
    //sathish-end--should alow alphanumeric.. 
    //Karthik-start
    function ValidateDate() {
        var errorMessage = "";
        var txtCollectedTime = $('input[id$="txtAdmissionDate"]');
        if ($(txtCollectedTime).val() == "") {
            var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_48") == null ? "Enter Admission date" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_48");
            ValidationWindow(userMsg, ErrorMsg);
        }
        else if ($(txtCollectedTime).val() != "") {
            var varRegEx = /^\d{2}\/\d{2}\/\d{4} \d{2}\:\d{2}(\:\d{2})\s(AM|am|PM|pm)/;
            if (!$(txtCollectedTime).val().match(varRegEx)) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_47") == null ? "Invalid date and time" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_47");
                ValidationWindow(userMsg, errorMessage);
                $("#txtAdmissionDate").val('');
                $("#txtAdmissionDate").focus();
                return false;
            }
            else {
                Check_FOR_AMS_VIS_ASD(this.id, this.value, 'ApplicationStartDate', 'OP', 'Admission Date cannot be earlier to Application Start Date - ');
            }
        }
    }
    function ValidDate(obj) {
        
        var valDate = obj;
        if ($(valDate).val() != "") {
            var varRegEx = /^\d{2}\/\d{2}\/\d{4}/;
            if (!$(valDate).val().match(varRegEx)) {
                var userMsg = SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_47") == null ? "Invalid Date and Time" : SListForAppMsg.Get("QuickStockReceived_QuickStockReceived_aspx_47");
                ValidationWindow(userMsg, ErrorMsg);
                var ID = obj.id;
                $(obj).val('');
                document.getElementById(ID).focus();
                return false;
            }
        }

    }
    var sID='<%= Request.QueryString["sID"] %>'
    //karthik-end
    function ChangeConsign() {
            //if (document.getElementById('hdnProductList').value.trim() != '') {
          
            var chk = document.getElementById('ChkIsConsign');
            $("#txtProductName").val("");
            $("#imageMand").toggle();
            if (chk.checked) {
                $find('AutoCompleteProduct').set_contextKey('Y');
                $("#txtUnitPrice").prop('disabled', true);
                $("#txtSellingPrice").prop('disabled', true);
                $("#txtMRP").prop('disabled', true);
            }
            else {
                $find('AutoCompleteProduct').set_contextKey('N');
                $("#txtUnitPrice").prop('disabled', false);
                $("#txtSellingPrice").prop('disabled', false);
                $("#txtMRP").prop('disabled', false);
            }

                $("#txtBatchNo").val("");
                $("#txtMFTDate").val("");
                $("#txtEXPDate").val("");
                $("#ddlRcvdUnit").val("0");
                $("#txtRECQuantity").val("");
                $("#ddlSelling").val("0");
                $("#txtInvoiceQty").val("");
                $("#txtRcvdLSUQty").val("");
                $("#txtCompQuantity").val("");
                $("#txtUnitPrice").val("");
                $("#txtDiscount").val("");
                $("#txtExTax").val("");
                $("#ddltax").val("-1");
                $("#txtSellingPrice").val("");
                $("#txtMRP").val("");
                $("#txtRakNo").val("");
                $("#txtTotalCost").val("");
                if ($('#ChkIsConsign').prop('checked')) {
                  
                    //alert('Not check the Dc Number');
                   // $("#txtDCNumber").attr('readonly', true);
                   // $("#txtDCNumber").val('');
                    $("#txtInvoiceNo").val('');
                    $("#txtInvoiceDate").val('');
                    $("#txtInvoiceNo").attr('readonly', true);
                    $("#txtInvoiceDate").attr('readonly', true);
                } else {
               
                 //   $("#txtDCNumber").removeAttr('readonly');
                    $("#txtInvoiceNo").removeAttr('readonly');
                    $("#txtInvoiceDate").removeAttr('readonly');
                }
               
            if (document.getElementById('hdnProductList').value.trim() != '') {
                if (confirm("Added items will be deleted,If you change consignment product to non-consignment product")) {
                    if (document.getElementById('TableCollectedItems').rows.length > 1) {
                        for (var j = 1; j < document.getElementById('TableCollectedItems').rows.length; j++) {
                            document.getElementById('TableCollectedItems').deleteRow(j);
                        }


                        $("#txtTotalSales").val("0.00");
                        $("#txtTotalDiscountAmt").val("0.00");
                        $("#txtTotalTaxAmt").val("0.00");
                        $("#txtTotalExcise").val("0.00");
                        $("#txtCessOnExcise").val("0.00");
                        $("#txtHighterEdCess").val("0.00");
                        $("#txtCST").val("0");
                        $("#txtTotaltax").val("0.00");
                        $("#txtTotalDiscount").val("0.00");
                        $("#txtGrandTotal").val("0.00");
                        $("#txtUseCreditAmount").val("0");
                        $("#txtNetTotal").val("0.00");
                        $("#txtRoundOffValue").val("0.00");
                        $("#txtGrandwithRoundof").val("0.00");
                        $("#lblTotalCostAmount").empty();
                        document.getElementById('hdnProductList').value = '';
                    }

                }
                else {
                    if (chk.checked) {
                        chk.checked = false;
                    }
                    else {
                        chk.checked = true;
                    }
                }


            }
        }
        function Productvalidate() {
            var flag = false
            if (ValidateMultiLangChar(this)) {
                flag = true;
                if (getvalidation(event)) {
                    flag = true;
                    FreeTextValidateBasedOnFeeType()
                }
                return flag;
            }
        }
</script>
   <style>
       .responstable th, .responstable .responstableHeader td {
           border: 1px solid #eee !important;
           border-right: 1px solid #ccc !important;
       }
   </style>
</body>




   <script src="../PlatForm/Scripts/ProgressBar.js" type="text/javascript"></script>
</html>
