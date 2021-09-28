function fun_BindData() {
    var pFromdate = $('#hdnfromdate').val();
    var pTodate = $('#hdnTodate').val();
    var pOrgId = $('#hdnOrgID').val();
    var OrgAddressID = $('#hdnLocationID').val();
    var LocationId = $('#hdnDepartmentID').val();
    var ProductName = $('#hdnProductName').val();

    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetStockAdjasment",
        data: '{pFromDate: "' + pFromdate + '",pToDate: "' + pTodate + '",pOrgID: "' + pOrgId + '",OrgAddressID: "' + OrgAddressID + '",LocationID: "' + LocationId + '",pName: "' + ProductName + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function Success(data) {
            var Items = data.d;
            fun_Adjasment(Items);
        },
        error: function(jqXHR, textStatus, errorThrown) {
           
        }
    });
}
var TRE;
function fun_Adjasment(JST) {
    TRE = [];
    $.each(JST, function() {
        var ProductName = this.ProductName;
        var LocationName = this.LocationName;
        var RcvdQty = this.RcvdLSUQty;
        var OutFlowQty = this.InvoiceQty;
        var StockReceivedDt = fun_JSON_DM(this.Manufacture);
        var OutFlowDate = fun_JSON_DM(this.ExpiryDate);
        var UserName = this.Name;

        TRE.push([ProductName = ProductName,
                     LocationName = LocationName,
                     RcvdQty = RcvdQty,
                     OutFlowQty = OutFlowQty,
                     StockReceivedDt = StockReceivedDt,
                     OutFlowDate = OutFlowDate,
                     UserName = UserName
                     ]);
    });


    $("#gvIndents").dataTable().fnDestroy();
    $('#gvIndents').dataTable({

        "bProcessing": true,
        "bPaginate": true,
        "bDeferRender": true,
        "bSortable": false,
        "bJQueryUI": true,
        "aaData": TRE,
        'bSort': true,
        'bFilter': true,
     
        'sPaginationType': 'full_numbers',
        "sDom": '<"H"Tfr>t<"F"ip>'
      

    });

}
function fun_JSON_DT(DST) {
    var m, day;
    JDT = DST;
    var d = new Date(parseInt(JDT.substr(6)));
    m = d.getMonth() + 1;
    if (m < 10)
        m = '0' + m
    if (d.getDate() < 10)
        day = '0' + d.getDate()
    else
        day = d.getDate();

    return (day + '/' + m + '/' + d.getFullYear())
}


function fun_JSON_DM(DST) {
    var m, day, MIT;
    JDT = DST;
    var d = new Date(parseInt(JDT.substr(6)));
    m = d.getMonth() + 1;
    if (m < 10)
        m = '0' + m
    if (d.getDate() < 10)
        day = '0' + d.getDate()
    else
        day = d.getDate();

    var HOU = d.getHours();
    var MIN = d.getMinutes();

    if (Number(HOU) > 12) {
        HOU = Number(HOU) - 12;
        if (HOU < 10) { HOU = '0' + HOU }
        MIT = HOU + ':' + MIN + 'PM';
    }
    else {
        if (HOU < 10) { HOU = '0' + HOU }
        MIT = HOU + ':' + MIN + 'AM';
    }
    return (day + '-' + m + '-' + d.getFullYear() + ' ' + MIT)
}