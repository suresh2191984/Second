$(document).ready(function() {
    $('#dvsearch').hide();
    $('#dvsave').hide();
    $('#tblBindDatatable').hide();
    $('#tblBindtable').hide();
    $('#dvBindtable').hide();
    $('#dvBindDatatable').hide();
    
    $("#chkAction").change(function() {
        var checked = $(this).is(':checked');
        if (checked) {
            $('#dvsearch').show();
            $('#dvsave').show();
        }
        else {
            $('#dvsearch').hide();
            $('#dvsave').hide();
        }
    });

    $("#chkLOneAll").change(function() {
        var checked = $(this).is(':checked');
        if (checked) {
            $(".levelone").each(function() {
                $(this).prop("checked", true);
            });
        } else {
            $(".levelone").each(function() {
                $(this).prop("checked", false);
            });
        }
    });

    $('#ddlmean').change(function() {
        var datePeriod = $(this).val();
        $fromDate = $('#txtFromDate');
        $toDate = $('#txtToDate');
        var DateFormat = 'DD/MM/YYYY';
        $dateFilter = $('.dateFilter');
        if (datePeriod == '0' || datePeriod == '2') {
            $dateFilter.hide();
        }
        else {
            $dateFilter.show();
        }
        if (datePeriod == '1') {
            $fromDate.val(moment().subtract(1, 'months').startOf('month').format(DateFormat));
            $toDate.val(moment().subtract(1, 'months').endOf('month').format(DateFormat));
        }
        else if (datePeriod == '3') {
            $fromDate.val('');
            $toDate.val('');
            $fromDate.removeAttr('disabled');
            $toDate.removeAttr('disabled');
        }
    });

    $("#chkLTAll").change(function() {
        var checked = $(this).is(':checked');
        if (checked) {
            $(".leveltwo").each(function() {
                $(this).prop("checked", true);
            });
        } else {
            $(".leveltwo").each(function() {
                $(this).prop("checked", false);
            });
        }

    });

    $("#chkLEAll").change(function() {
        var checked = $(this).is(':checked');
        if (checked) {
            $(".levelthree").each(function() {
                $(this).prop("checked", true);
            });
        } else {
            $(".levelthree").each(function() {
                $(this).prop("checked", false);
            });
        }

    });
});

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


function GetFloatingMeanDetails() {
        var InstrumentID;
        var InvID;
        var LotID;
        var fdate;
        var tdate;
        var fmselect;
        var pOrgID = document.getElementById("hdnOrgID").value;
        InstrumentID = $('#hdnDeviceID').val();
        InvID = $('#hdnInvestigationID').val();
        LotID = $('#hdnSelectedLotID').val();
        fdate = $('#txtFromDate').val();
        tdate = $('#txtToDate').val();
        fmoption = $("#ddlmean").val();
        if (ValidateFilter(InstrumentID, InvID, LotID) == true && fmoption != '0') {
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/GetFloatingMeanDetails",
                data: JSON.stringify({ pOrgID: pOrgID, pInstrumentID: InstrumentID, pInvestigationID: InvID, pLotID: LotID, pFromDate: fdate, pToDate: tdate, pfmOption: fmoption }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    var Items = data.d;
                    var dtDayWCR = Items;
                    if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                        var parseJSONResult = JSON.parse(dtDayWCR);
                        $('#tblBindtable').find("tbody").empty();
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
                                            { 'data': 'InvestigationID', "sClass": "hide_column" },
                                            { 'data': 'InstrumentID', "sClass": "hide_column" },
                                            { 'data': 'LotID', "sClass": "hide_column" },
                                            { 'data': 'SNO' },
                                            { 'data': 'TestName' },
                                            { 'data': 'LOMean' },
                                            { 'data': 'LOSD' },
                                            { 'data': 'LOCV' },
                                             {
                                                 "mRender": function(data, type, full) {
                                                     return '<input type=checkbox class=levelone id=L1_' + full.InvestigationID + ' >';
                                                 }
                                             },
                                            { 'data': 'LTMean' },
                                            { 'data': 'LTSD' },
                                            { 'data': 'LTCV' },
                                             {
                                                 "mRender": function(data, type, full) {
                                                     return '<input type=checkbox class=leveltwo id=L2_' + full.InvestigationID + '>';
                                                 }
                                             },
                                            { 'data': 'LEMean' },
                                            { 'data': 'LESD' },
                                            { 'data': 'LECV' },
                                            {
                                                "mRender": function(data, type, full) {
                                                    return '<input type=checkbox class=levelthree id=L3_' + full.InvestigationID + '>';
                                                }
}]

                        });

                        jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
                        $('#tblBindtable').show();
                        $('#tblBindDatatable').hide();
                        $('#dvBindtable').show();
                        $('#dvBindDatatable').hide();
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


function GetQCLabMeanDetails() {
    var InstrumentID;
    var InvID;
    var LotID;
    var pOrgID = document.getElementById("hdnOrgID").value;
    InstrumentID = $('#hdnDeviceID').val();
    InvID = $('#hdnInvestigationID').val();
    LotID = $('#hdnSelectedLotID').val();
    if (ValidateFilter(InstrumentID, InvID, LotID) == true) {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/GetQCLabMeanDetails",
            data: JSON.stringify({ pOrgID: pOrgID, pInstrumentID: InstrumentID, pInvestigationID: InvID, pLotID: LotID }),
            dataType: "JSON",
            async: false,
            success: function(data) {
                var Items = data.d;
                var dtDayWCR = Items;
                if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                    var parseJSONResult = JSON.parse(dtDayWCR);
                    $('#tblBindDatatable').find("tbody").empty();
                    $('#tblBindDatatable  tbody > tr').remove();
                    $('#tblBindDatatable').dataTable({
                        paging: true,
                        "language": {
                            "url": dataTablePath
                        },
                        data: parseJSONResult,

                        "bDestroy": true,
                        "searchable": true,
                        "sort": true,

                        columns: [
                                            { 'data': 'InvestigationID', "sClass": "hide_column" },
                                            { 'data': 'InstrumentID', "sClass": "hide_column" },
                                            { 'data': 'SNO' },
                                            { 'data': 'TestName' },
                                            { 'data': 'LOMean' },
                                            { 'data': 'LOSD' },
                                            { 'data': 'LOCV' },
//                                             {
//                                                 "mRender": function(data, type, full) {
//                                                     return '<input type=checkbox class=levelone id=L1_' + full.InvestigationID + ' >';
//                                                 }
//                                             },
                                            { 'data': 'LTMean' },
                                            { 'data': 'LTSD' },
                                            { 'data': 'LTCV' },
//                                             {
//                                                 "mRender": function(data, type, full) {
//                                                     return '<input type=checkbox class=leveltwo id=L2_' + full.InvestigationID + '>';
//                                                 }
//                                             },
                                            { 'data': 'LEMean' },
                                            { 'data': 'LESD' },
                                            { 'data': 'LECV' }
//                                            ,
//                                            {
//                                                "mRender": function(data, type, full) {
//                                                    return '<input type=checkbox class=levelthree id=L3_' + full.InvestigationID + '>';
//                                                }
//                                            }
                                            ]

                    });

                    jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
                    $('#tblBindDatatable').show();
                    $('#tblBindtable').hide();
                    $('#dvBindtable').hide();
                    $('#dvBindDatatable').show();
                    $('#chkAction').prop('checked', false);
                    $('#dvsearch').hide();
                    $('#dvsave').hide();
                }
                else {
                    $('#tblBindDatatable').hide();
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

function ValidateFilter(InstrumentID,InvID,LotID) {
    if ((InstrumentID != 0) || (InvID != 0) || (LotID != 0)) {
        return true;
    }
    else {
        return false;
    }
}



function SaveQCMeanDetails() {
    var lstQCEvaluvationsDetails = [];
    tbl = $('#tblBindtable').DataTable();

    tbl.rows().every(function() {
        var data = this.data();
        var investigationID = data.InvestigationID;
        var instrumentID = data.InstrumentID;
        var lotID = data.LotID;
        var pOrgID = document.getElementById("hdnOrgID").value;
        var levelone = $('#L1_' + investigationID + '').prop("checked");
        if (levelone == true) {
            var mean = data.LOMean;
            var sd = data.LOSD;
            var cv = (!isNaN(data.LOCV) && data.LOCV.length != 0) ? data.LOCV : 0;
            if (!isNaN(mean) && mean.length != 0) {
                lstQCEvaluvationsDetails.push({
                    InvestigationID: investigationID,
                    InstrumentID: instrumentID,
                    LotID: lotID,
                    Mean: mean,
                    StandardDeviation: sd,
                    CoVariation: cv,
                    QCLevel: 'C1',
                    OrgID: pOrgID
                });
            }
        }
        var leveltwo = $('#L2_' + investigationID + '').prop("checked");
        if (leveltwo == true) {
            var mean = data.LTMean;
            var sd = data.LTSD;
            var cv = (!isNaN(data.LTCV) && data.LTCV.length != 0) ? data.LTCV : 0;
            if (!isNaN(mean) && mean.length != 0) {
                lstQCEvaluvationsDetails.push({
                    InvestigationID: investigationID,
                    InstrumentID: instrumentID,
                    LotID: lotID,
                    Mean: mean,
                    StandardDeviation: sd,
                    CoVariation: cv,
                    QCLevel: 'C2',
                    OrgID: pOrgID
                });
            }
        }
        var levelthree = $('#L3_' + investigationID + '').prop("checked");
        if (levelthree == true) {
            var mean = data.LEMean;
            var sd = data.LESD;
            var cv = (!isNaN(data.LECV) && data.LECV.length != 0) ? data.LECV : 0;
            if (!isNaN(mean) && mean.length != 0) {
                lstQCEvaluvationsDetails.push({
                    InvestigationID: investigationID,
                    InstrumentID: instrumentID,
                    LotID: lotID,
                    Mean: mean,
                    StandardDeviation: sd,
                    CoVariation: cv,
                    QCLevel: 'C3',
                    OrgID: pOrgID
                });
            }
        }
    });

    $.ajax({
        type: "POST",
        async: false,
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/SaveQCEvaluvationsDetails",
        data: JSON.stringify({ lstEvaluvations: lstQCEvaluvationsDetails }),
        dataType: "json",
        success: function(msg) {
            if (msg.d > 0) {
                alert('Saved Successfully');
            }
        },
        error: function(Result) {
            alert("Error");
        }
    });
}

