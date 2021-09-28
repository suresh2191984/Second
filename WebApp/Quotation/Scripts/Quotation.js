var lstProductList = [];
var CGST = 0;
var SGST = 0;
var IGST = 0;


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
    var dropdown = $('#drpUnit');
    dropdown.empty();

    $.each(lstOrderUnit, function(index, item) {
        var $option = $("<option />");
        $option.attr("value", item.UOMCode + "~" + item.ConvesionQty).text(item.UOMCode);
        $(dropdown).append($option);

    });


    if ($.trim(SelectedValue) != "") {
        $("#drpUnit option:contains(" + $.trim(SelectedValue) + ")").attr('selected', true);
    }
    var ddlRecUnitval = ""; 
    if($('#drpUnit').val()!=null)
        ddlRecUnitval=$('#drpUnit').val().split('~');
      $("#txtInverseQuantity").val($.trim(ddlRecUnitval[1]));
      document.getElementById('txtInverseQuantity').disabled = true;
}


function ChangeConvesionQty() {
    var ddlRecUnitval = "";
    if ($('#drpUnit').val() != null)
        ddlRecUnitval = $('#drpUnit').val().split('~');
    var ConQty = $.trim(ddlRecUnitval[1]);
   // var RecQty = $("#txtRECQuantity").val();
//    if ($.trim(RecQty) == "") {
//        RecQty = "0";
//        $("#txtRcvdLSUQty").val("0");
    //      }
    $("#txtInverseQuantity").val(ConQty);
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