$btnSave = $("#btnSave");
$(function() {

    $("#itxtFromDate").datepicker({
        dateFormat: 'dd/mm/yy',
        defaultDate: "+1w",
        yearRange: '1900:2100',
        onClose: function(selectedDate) {
            var date = $("#itxtFromDate").datepicker('getDate');
            $("#itxtToDate").datepicker('option', 'minDate', selectedDate);

        }
    });
    $("#itxtToDate").datepicker({
        dateFormat: 'dd/mm/yy',
        defaultDate: "+1w",
        yearRange: '1900:2100'
    });
    $("#txtFromDate").val($.datepicker.formatDate("dd/mm/yy", new Date()));
    $("#txtToDate").val($.datepicker.formatDate("dd/mm/yy", new Date()));

    $('#timePair .time').timepicker({
        'minTime': '12:00am',
        'maxTime': '11:30pm',
        'showDuration': true

    });

    $('#timePair .date').datepicker({
        'format': 'm/d/yyyy',
        'autoclose': true

    });

    $('#timePair').datepair();
    $("#btnSave").on('click', function() {
        if ($(this).attr('value') == 'Save') {
            // getVal('I');
            if (getVal('I') != false) {
            ClearControls();
            alert("Audit Saved succesfully");
            }
        }
        else {
            getVal('U');
            ClearControls();
            alert("Audit Updated succesfully");

        }
    });

    $('#btnClear').on('click', function() {
        ClearControls();
    });
    bindInitial();
});
function bindInitial() {
    var obj = {};
    var lst = LoadExternalAuditDetails('S', obj);
    BindAuditDetails(lst);
}
function LoadExternalAuditDetails(AType, obj) {
    var d;
    $.ajax({
        type: "POST",
        url: "../QMS.asmx/LoadExternalAuditDetails",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ lstExAudit: obj, ActionType: AType }),
        async: false,
        success: function(data) {
            dd = data.d;
            if (AType == 'S') {
                if (dd[0].length > 0) {
                    d = dd[0];
                }
            }
            if (AType == 'P') {
                if (dd[0].length > 0) {
                    d = dd[0];
                    d = d[0];
                    
                }
            }

        },
        error: function(result) {
            alert("Error");
        }

    });
    return d;

}
function SaveExternalAuditDetailsDetails(AType, obj) {
    var d;
    $.ajax({
        type: "POST",
        url: "../QMS.asmx/SaveExternalAuditDetails",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ lstExAudit: obj, ActionType: AType }),
        async: false,
        success: function(data) {
            
            if (AType == 'I') {
                FilesAddDelete(DelFiles, data.d, 'ExternalAudit_QMS');
                bindInitial();
            }
            if (AType == 'U') {
                FilesAddDelete(DelFiles, data.d, 'ExternalAudit_QMS');
                bindInitial();
            }

        },
        error: function(result) {
            alert("Error");
        }

    });
    return d;

}

function BindAuditDetails(data) {

    var tbl = '#tblexternalAuditDetails';
    $(tbl + '  tbody > tr').remove();
    $(tbl).show();
    $(tbl).dataTable({
        paging: true,
        data: data,
        "bDestroy": true,
        "searchable": true,
        "sort": true,
        "fnDrawCallback": function() {
            $('#tblexternalAuditDetails input[data="Edit"]').on('click', function() {
                var ctrl = $(this);
                var IAID = $(this).attr('EnternalAuditID');
                var obj = {};
                obj.EnternalAuditID = IAID;
                var lst = LoadExternalAuditDetails('P', obj);
                $.each($('input[Entity]'), function(idx, val) {

                    var eval = $(this).attr('Entity');
                    var vl = lst[eval];
                    if (vl != null)
                    { $(this).val(vl); }


                });
                $.each($('select[Entity]'), function(idx, val) {
                    var eval = $(this).attr('Entity');
                    var vl = lst[eval];
                    if (vl != null)
                    { $(this).val(vl); }

                });
                populateOnEdit(lst.Files);

                $('#btnSave').attr('value', 'Update');

            });
            $('#tblexternalAuditDetails input[data="Delete"]').on('click', function() {
                ClearControls();
                var IAID = $(this).attr('EnternalAuditID');
                var obj = {};
                obj.EnternalAuditID = IAID;
                LoadExternalAuditDetails('D', obj);
                alert("Audit deleted succesfully");
                bindInitial();
            });
        },

        columns: [

                                            { 'data': 'SNO'

                                            },

                                            {
                                                'data': 'AuditNo'
                                            },

                                            {
                                                'data': 'FromDate1'
                                            },
                                            {
                                                'data': 'AuditAgency'
                                            },
                                                  {
                                                      'data': 'MajorNC'
                                                  },
                                                  {
                                                      'data': 'MinorNC'
                                                  },
                                                  {
                                                      'data': 'AuditorsList'
                                                  },
                                                     {
                                                         'data': 'DeptName'
                                                     },


                                            {
                                                'data': 'Status'
                                            },


                                            { 'data': 'Action',
                                                "ordering": true,
                                                "mRender": function(data, type, full, meta) {

                                                    var txt = '<input EnternalAuditID="' + full.AuditNo + '" data="Edit" value = "Edit"  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';
                                                    txt += '/<input EnternalAuditID="' + full.AuditNo + '" data="Delete" value = "Delete" class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"/>';
                                                    return txt;

                                                }

                                            }

                                            ]

    });
    jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
}

function getVal(type) {

 var obj = {};

 $.each($('input[Entity]'), function(idx, val) {

     var value = "";
     var eval = $(this).attr('Entity');
     var vtype = $(this).attr('valType');
     value = $(this).val();
     if (vtype == 'date') {
         value = dateformat($(this).val(), 'YYYY/MM/DD');
     }
     obj[eval] = value;

 });

 $.each($('select[Entity]'), function(idx, val) {

     var eval = $(this).attr('Entity');
     obj[eval] = $(this).val();

 });


 var fromtime = $("#fromTime").val();
 var totime = $("#toTime").val();

 if (obj.OrgID == '0') {
     alert('Please select Event Name');
     return false;
 }
  if (obj.AddressID == 0) {
     alert('Please select Event Type');
     return false;
 }
 if (obj.FromTime == '' || obj.FromDate =='Invalid date') {
     alert('Please select FromDate');
     return false;
 }
 if (fromtime == '') {
     alert('Please select From Time');
     return false;
 }
 if (obj.ToTime == '' || obj.Todate =='Invalid date') {
     alert('Please select ToDate');
     return false;
 }
 if (totime == '') {
     alert('Please select To Time');
     return false;
 }
 if (obj.Todate == '') {
     alert('Please select ToDate');
     return false;
 }
 obj['FromDate'] = obj.FromDate + ' ' + getTime(fromtime);
 obj['Todate'] = obj.Todate + ' ' + getTime(totime);
 
 if (obj.MajorNC == '')
 {obj.MajorNC = 0; }
 if (obj.MinorNC == '')
 { obj.MinorNC = 0; }
 if (obj.EnternalAuditID == '')
 { obj.EnternalAuditID = 0; }
 SaveExternalAuditDetailsDetails(type, obj);
}
function getTime(tval) {
    var values = tval.split(':');
    var min = values[1].substring(0, 2);
    var format1 = values[1].substring(2, 4);
    if (format1 == 'pm') {

        if (values[0] != 12)
        { values[0] = parseInt(values[0]) + parseInt(12); }
    }
    else {
        if (values[0].length == 1) {
            values[0] = '0' + values[0];
        }
        if (values[0] == '12')
        { values[0] = '00'; }

    }
    var ftime = values[0] + ':' + min + ':00'

    return ftime;
}



function ClearControls() 
{


    $.each($('#filterCard input:not([type="button"])'), function(idx, val) {

        if ($(this).attr('id') !== 'hdnFilepath') {
            $(this).val("");
        }

    });

    $.each($('#filterCard select'), function(idx, val) {

        var id = $(this).attr('id')
        var val = $('#' + id + " option:first").val();
        $(this).val(val);

    });
    $.each($('#filterCard textarea[Entity]'), function(idx, val) {

        $(this).val("");

    });
    $('#txtfileupload_wrap_list').html('');
    DelFiles = [];
    $("#txtfileupload").Attune_RemoveFiles();
   
    $btnSave.attr('value', 'Save');

}