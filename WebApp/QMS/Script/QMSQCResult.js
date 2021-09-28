
$(function() {
    var Orgid = document.getElementById("hdnOrgID").value;
    var count = 0;
    var Type = 'Device';

    $("[id$=txtDeviceName]").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../QMS.asmx/GetQCResultSearchValues',
                data: "{'prefixText': '" + request.term + "','count': " + count + ",'contextKey':'" + Orgid + '~' + Type + "'}",
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function(item) {
                            try {
                                var rsltlable = item.split(',')[0];
                                var rsltvalue = item.split(',')[1];
                                return {
                                    label: rsltlable.split(':')[1].slice(1),
                                    val: rsltvalue.split(':')[1].slice(1)

                                }
                            }
                            catch (er) {
                            }
                        }
                    ))
                    } else {
                        response([{ label: langData.result_notfound, val: -1}]);
                        Clear();
                    }
                },
                error: function(response) {
                    alert(response.responseText);
                },
                failure: function(response) {
                    alert(response.responseText);
                }
            });
        },
        select: function(e, i) {
            $("[id$=hdnDeviceValue]:selected").val(i.item.val);
            $("#hdnDeviceID").val(i.item.val);
        },
        minLength: 2
    });
});


$(function() {
    var Orgid = document.getElementById("hdnOrgID").value;
    var count = 0;
    var Type = 'Investigations';

    $("[id$=txtTestName]").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../QMS.asmx/GetQCResultSearchValues',
                data: "{'prefixText': '" + request.term + "','count': " + count + ",'contextKey':'" + Orgid + '~' + Type + "'}",
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function(item) {
                            try {
                                var rsltlable = item.split(',')[0];
                                var rsltvalue = item.split(',')[1];
                                return {
                                    label: rsltlable.split(':')[1].slice(1),
                                    val: rsltvalue.split(':')[1].slice(1)

                                }
                            }
                            catch (er) {
                            }
                        }
                    ))
                    } else {
                        response([{ label: langData.result_notfound, val: -1}]);
                        Clear();

                    }
                },
                error: function(response) {
                    alert(response.responseText);
                },
                failure: function(response) {
                    alert(response.responseText);
                }
            });
        },
        select: function(e, i) {
        $("[id$=hdnInvestigationValue]:selected").val(i.item.val);
        $("#hdnInvestigationID").val(i.item.val);
        },
        minLength: 2
    });
});

$(function() {
    var Orgid = document.getElementById("hdnOrgID").value;
    var count = 0;
    var Type = 'LotNumber';

    $("[id$=txtLotNumber]").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../QMS.asmx/GetQCResultSearchValues',
                data: "{'prefixText': '" + request.term + "','count': " + count + ",'contextKey':'" + Orgid + '~' + Type + "'}",
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function(item) {
                            try {
                                var rsltlable = item.split(',')[0];
                                var rsltvalue = item.split(',')[1];
                                return {
                                    label: rsltlable.split(':')[1].slice(1),
                                    val: rsltvalue.split(':')[1].slice(1)

                                }
                            }
                            catch (er) {
                            }
                        }
                    ))
                    } else {
                        response([{ label: langData.result_notfound, val: -1}]);
                        Clear();

                    }
                },
                error: function(response) {
                    alert(response.responseText);
                },
                failure: function(response) {
                    alert(response.responseText);
                }
            });
        },
        select: function(e, i) {
        $("[id$=hdnSelectedLotValue]:selected").val(i.item.val);
        $("#hdnSelectedLotID").val(i.item.val);
        },
        minLength: 2
    });
});


function GetQCResultDetails() {
        var InstrumentID;
        var InvID;
        var LotID;
        var fdate;
        var tdate;
        var pOrgID = document.getElementById("hdnOrgID").value;
        InstrumentID = $('#hdnDeviceID').val();
        InvID = $('#hdnInvestigationID').val();
        LotID = $('#hdnSelectedLotID').val();
        fdate = $('#txtFromDate').val();
        tdate = $('#txtToDate').val();
        if (ValidateFilter(InstrumentID, InvID, LotID, fdate, tdate) == true) {
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/GetQCResultDetails",
                data: JSON.stringify({ pOrgID: pOrgID, pInstrumentID: InstrumentID, pInvestigationID: InvID, pLotID: LotID, pFromDate: fdate, pToDate: tdate }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    var Items = data.d;
                    var dtDayWCR = Items;
                    if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                        var parseJSONResult = JSON.parse(dtDayWCR);
                        $('#tblBindtable  tbody > tr').remove();
                        $('#tblBindtable').dataTable({
                            paging: true,
                            "language": {
                                "url": dataTablePath
                            },
                            data: parseJSONResult,

                            "bDestroy": true,
                            "searchable": true,
                            "sort": true,

                            columns: [
                                            { 'data': 'SNO' },
                                            { 'data': 'ResultDate',
                                                'render': function(JsonDate) {
                                                    var date = new Date(parseInt(JsonDate.substr(6)));
                                                    var month = date.getMonth() + 1;
                                                    return date.getDate() + "/" + month + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes();
                                                }
                                            },
                                            { 'data': 'LOValue' },
                                            { 'data': 'LOStatus' },
                                            { 'data': 'LORule' },
                                            { 'data': 'LOZScore' },
                                            { 'data': 'LTValue' },
                                            { 'data': 'LTStatus' },
                                            { 'data': 'LTRule' },
                                            { 'data': 'LTZScore' },
                                            { 'data': 'LEValue' },
                                            { 'data': 'LEStatus' },
                                            { 'data': 'LERule' },
                                            { 'data': 'LEZScore' }
]

                        });

                        jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
                        $('#tblBindtable').show();
                    }
                    else {
                        $('#tblBindtable').hide();
                        alert('No matching record found!');
                    }

                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }
            });
        }
        else {
            alert("Please choose any one option");
        }
}

function ValidateFilter(InstrumentID,InvID,LotID,fdate,tdate) {
    if ((InstrumentID != 0) || (InvID != 0) || (LotID != 0)) {
        if (fdate != '') {
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return false;
    }
}