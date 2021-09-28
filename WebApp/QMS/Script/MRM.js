var EntityName1 = 'PlanAndSchedule_QMS';
var content = "";
function LoadPlanAndSchedule(AType, psid) {

    var d = "";
    
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/LoadQcPlanAndSchedule",
        data: JSON.stringify({ ActionType: AType, plans: psid }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            if (AType == 'T') {
                if (data.d.length > 0) {
                    d = data.d[0];
                    //d = d[0];
                }

            }
            if (AType == 'P') {
                if (data.d.length > 0) {
                    d = data.d[0];
                    d = d[0];
                }

            }


        },
        error: function(xr) {
            var dS = xr;
        }
    });

    return d;
}


$(function() {

    $("#txtDate").datepicker({
        dateFormat: 'dd/mm/yy',
        yearRange: '1900:2100'
    });
    var str = $('#txtfileupload').Attune_FileUpload({ fileCheck: true }, { fileddl: 'ddlFileType' });
    var path = GetConfigValue('MetaData', 'QMSFilePath', 'hdnFilepath');

    $("#txtFromDate").datepicker({
        dateFormat: 'dd/mm/yy',
        defaultDate: "+1w",
        yearRange: '1900:2100',
        onClose: function(selectedDate) {
            var date = $("#txtFromDate").datepicker('getDate');
            $("#txtToDate").datepicker('option', 'minDate', selectedDate);

        }
    });
    $("#txtToDate").datepicker({
        dateFormat: 'dd/mm/yy',
        defaultDate: "+1w",
        yearRange: '1900:2100'
    });
    $("#txtFromDate").val($.datepicker.formatDate("dd/mm/yy", new Date()));
    $("#txtToDate").val($.datepicker.formatDate("dd/mm/yy", new Date()));
    $("#txtCompletion").datepicker({
        dateFormat: 'dd/mm/yy',
        defaultDate: "+1w",
        yearRange: '1900:2100',
        onClose: function(selectedDate) {
            var date = $("#txtCompletion").datepicker('getDate');
            $("#txtCompletion").datepicker('option', 'minDate', selectedDate);

        }
    });

    $("#btnShowTask").on('click', function() {
        var lits = getVal('MRM');
        var dat = LoadPlanAndSchedule('T', lits);
        BindSchedules(dat);
    });
    var lits = getVal('MRM');
    var dat = LoadPlanAndSchedule('T', lits);
    BindSchedules(dat);
    LoadRole();
    AutoUser();
    $('#cardList').hide();
    //$('#ddlfilterlist').hide();
    $('#tblScheduledList tbody tr').on('click', function(event) {
        LoadPlanIDDetails($(event.target.parentElement).find("td")[0].innerHTML);
    });


    $('#btnBack').on('click', function() {
        $('#cardList').hide();
        $('#filterCard').show();
        //  $('#ddlfilterlist').hide();
        $('#tblSheduleDetails').show();
        var lits = getVal('MRM');
        var dat = LoadPlanAndSchedule('T', lits);
        BindSchedules(dat);
        $('#tblTraining tbody tr').on('click', function(event) {
            LoadPlanIDDetails($(event.target.parentElement).find("td")[0].innerHTML);
        });
    });




});


function SaveLJFilter(Value) {
    var OrgID = $("#hdnOrgID").val();
    var DeptID = $("#ddlorg1").val();
    var ScheduledMOMID = "";
    if (Value == "Update") {

        ScheduledMOMID = $("#hdnScheduledMOMID").val();
    }
    else {
        ScheduledMOMID = 0;
    
    }
    var PlanScheduleID = $("#hdnPlanID").val();
    var pointsDiscussed = $("#txtpointsDiscussed").val();
    var ActionProposed = $("#txtToltal").val();
    var ProposedCompDate = $("#txtCompletion").val();
    if (ProposedCompDate != null && ProposedCompDate != '') {
      ProposedCompDate = dateformat($("#txtCompletion").val(), 'YYYY-MM-DD');
    }
    var ResponsiblePerson = $("#hdnParticipants").val();

    if (DeptID == '0') {
        alert('Please Select Department');
        return false;
    }

    if (ProposedCompDate == '') {
        alert('Please Select Proposed Completion Date');
        return false;
    }
    else if (ResponsiblePerson == null || ResponsiblePerson == '') {
    alert('Please Select Responsible Person');
        return false;
    }
   else  if ($('#txtResponsibility').val()== '') {
   alert('Please Select Responsible Person');
        return false;
    }
    var Status = $("#ddlStatus").val();
    if (Status == '0') {
        alert('Please Select Status');
        return false;
    }
    var array = [];
    
    array.push({
        PointsDiscussed: pointsDiscussed,
        ActionProposed: ActionProposed,
        ProposedCompDate: ProposedCompDate,
        ResponsiblePerson:ResponsiblePerson,
        PlanScheduleID: PlanScheduleID,
        Status: Status,
        DeptID: DeptID,
        OrgID: OrgID,
        ScheduledMOMID: ScheduledMOMID

    });

    if (Value == 'Update') {

        LoadMRMDetails(array, 'U');
    }
    else {

        LoadMRMDetails(array, 'I');
    }
    ClearLJFilter();


}



function LoadPlanIDDetails(plan) {


  
    $('#hdnPlanID').val(plan);
    var arr = [];
    var lstObj = {};
    lstObj['PlanScheduleID'] = plan;
    arr.push(lstObj);
    var lst = LoadPlanAndSchedule('P', arr);
    $('#tblSheduleDetails').hide();
    $('#filterCard').hide();
    $('#cardList').show();
    BindDetails(lst);
    var list = [];
    list.push({
    PlanScheduleID: plan
});
var Type = "";
LoadMRMDetails(list, Type);
}

function LoadMRMDetails(list,Type) {

    var d = "";
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/LoadMRMDetails",
        data: JSON.stringify({ list: list, Type: Type }),
        dataType: "JSON",
        async: false,
        success: function(data) {

            var ParticipentDetails = data.d[0];

            $('#tblTraining').show();

            $('#tblTraining  tbody > tr').remove();
            $('#tblTraining').dataTable({
                paging: true,
                "iDisplayLength": 5,
                "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                data: ParticipentDetails,
                "bDestroy": true,
                "searchable": true,
                "sort": true,
                dom: 'Bfrtip',
                "fnDrawCallback": function() {
                    $('#tblTraining input[data="Edit"]').on('click', function() {
                        var pid = $(this).attr('PID');
                        var ID = $(this).attr('ScheduledMOMID');
                        var DeptID = $(this).attr('DeptID');
                        var PointsDiscussed = $(this).attr('PointsDiscussed');
                        var ActionProposed = $(this).attr('ActionProposed');
                        var ResponsiblePerson = $(this).attr('ResponsiblePerson');
                        var ResponsiblePersonName = $(this).attr('ResponsiblePersonName');
                        var Status = $(this).attr('Status');
                        var cdate = GetCorrectdate($(this).attr('ProposedCompDate'));
                        $('#ddlorg1').val(DeptID);
                        $('#txtpointsDiscussed').val(PointsDiscussed);
                        $('#txtToltal').val(ActionProposed);
                        $('#txtResponsibility').val(ResponsiblePersonName);
                        $("#hdnParticipants").val(ResponsiblePerson);
                        $('#ddlStatus').val(Status);
                        $('#txtCompletion').val(cdate);
                        $('#hdnScheduledMOMID').val(ID);
                        $('#Button1').val('Update');



                    });

                    $('#tblTraining input[data="Delete"]').on('click', function() {
                        var pid = $(this).attr('PID');
                        var ID = $(this).attr('ScheduledMOMID');

                        var list = [];
                        list.push({
                            PlanScheduleID: pid,
                            ScheduledMOMID: ID
                        });

                        LoadMRMDetails(list, 'D')

                    });






                },

                buttons: [
            {
                extend: 'copyHtml5',
                exportOptions: {
                    columns: [0, 1, 2, 3, 9, 10, 11, 12, 13, 14]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                    columns: [0, 1, 2, 3, 9, 10, 11, 12, 13, 14]
                }
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: [0, 1, 2, 3, 9, 10, 11, 12, 13, 14]
                }
            }
        ],

                columns: [
                                             { 'data': 'ScheduledMOMID',
                                                 "sClass": "hide_column"

                                             },

                                            { 'data': 'SNO'
                                            }

                                            ,

                                            { 'data': 'PlanScheduleID'
                                            }

                                            ,
                                             { 'data': 'DeptName'
                                             }
                                            ,
                                             { 'data': 'PointsDiscussed'
                                             }
                                            ,

                                             { 'data': 'ActionProposed'
                                             }


                                            ,
                                             { 'data': 'ResponsiblePersonName'
                                             },

                                             { 'data': 'Status'
                                             },

                                              { 'data': 'Action',
                                                  "ordering": true,
                                                  "mRender": function(data, type, full, meta) {

                                                  var txt = '<input ProposedCompDate="' + full.ProposedCompDate + '" ScheduledMOMID="' + full.ScheduledMOMID + '" PID="' + full.PlanScheduleID + '" DeptID="' + full.DeptID + '"  PointsDiscussed="' + full.PointsDiscussed + '"  ActionProposed="' + full.ActionProposed + '" ResponsiblePerson="' + full.ResponsiblePerson + '"  Status="' + full.Status + '" ResponsiblePersonName="'+full.ResponsiblePersonName+'" class="deleteIcons" value="Edit" data="Edit" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';
                                                      txt += '/<input   ScheduledMOMID="' + full.ScheduledMOMID + '" PID="' + full.PlanScheduleID + '" class="deleteIcons" value="Delete" data="Delete" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"/>';
                                                      return txt;
                                                  }
                                              }
                                         ]
            });

        },
        error: function(xr) {
            var dS = xr;
        }
    });
}

function BindDetails(arr) {
    $('#lblMRMNo1').html(arr.PlanScheduleID);
    $('#lblDateTime1').html(arr.FromDate1);
    $('#lblVenue1').html(arr.Venue);

    var ParticipantsEmail = new Array();
    ParticipantsEmail = arr.Email.split(',');
    var i = 0;
    var EmailID;
    var Role;
    var UserName;
    var userID;
    $("#divGuestMail1").html('');
    $('#lblParticipant').empty();
    $('#lblPartcipants').append($('<option></option>').val(0).html('---select---'));
    for (i = 0; i < ParticipantsEmail.length; i++) {
        userID = ParticipantsEmail[i].split('~')[0]
        EmailID = ParticipantsEmail[i].split('~')[1];
        Role = ParticipantsEmail[i].split('~')[2];
        UserName = ParticipantsEmail[i].split('~')[3];


        var d = '<div  class="MultiFile-label">\
                                <span class="MultiFile-title" >' + EmailID + '</span>\
                                <span >&nbsp;&nbsp;</span>\
                                <span class="MultiFile-title" >' + UserName + '</span>\
                                </div>';
        $("#divGuestMail1").append(d);
        $('#lblParticipant').append('<option value="' + userID + '">' + UserName + '</option>');
       
        EmailID = "";
        Role = "";

    }
    populateOnEdit(arr.Files);
    $('#lblAgenda1').html(arr.Agenda);
   // $('#ddlfilterlist').show();

}


function getVal(type) {

    var arr = [];
    var PlanandSchedue = {};
    $.each($('#filterCard input[Entity]'), function(idx, val) {

        var value = "";
        var eval = $(this).attr('Entity');
        var vtype = $(this).attr('valType');
        value = $(this).val();
        if (vtype == 'date') {
            value = dateformat($(this).val(), 'YYYY/MM/DD');
        }
        PlanandSchedue[eval] = value;

    });

    $.each($('#filterCard select[Entity]'), function(idx, val) {

        var eval = $(this).attr('Entity');
        PlanandSchedue[eval] = $(this).val();

    });
    PlanandSchedue.Todate = PlanandSchedue.Todate + ' 23:59:59'; 
    if (PlanandSchedue.PlanScheduleID == "")
    { PlanandSchedue.PlanScheduleID = 0; }

    PlanandSchedue.EventTypeCode = type;
    arr.push(PlanandSchedue);
    return arr;


}

function BindSchedules(data) {
    cnt = 1;
    var tbl = '#tblScheduledList';
    $(tbl + '  tbody > tr').remove();
    $(tbl).show();
    $(tbl).dataTable({
        paging: true,
        data: data,
        "bDestroy": true,
        "searchable": true,
        "sort": true,
        "fnDrawCallback": function() {


        $('#tblScheduledList tbody tr').on('click', function(event) {
        LoadPlanIDDetails($(event.target.parentElement).find("td")[0].innerHTML);



     
        });


        },

        columns: [

         { 'data': 'PlanScheduleID',
             "sClass": "hide_column"

         },

                                            { 'data': 'SNO'



                                            },


                                            {
                                                'data': 'EventName'

                                            },
                                             {
                                                 'data': 'PlanScheduleID'

                                             },
                                            {
                                                'data': 'FromDate1'
//                                                ,
//                                                'render': function(JsonDate) {
//                                                    if (JsonDate != null) {
//                                                        var date = new Date(parseInt(JsonDate.substr(6)));
//                                                        var month = date.getMonth() + 1;
//                                                        return date.getDate() + "/" + month + "/" + date.getFullYear();
//                                                    }
//                                                    else
//                                                    { return ''; }
//                                                }
                                            },

//                                            { 'data': 'Location'

//                                            },
                                            { 'data': 'Location',
                                                'defaultContent': content

                                            },
                                            { 'data': 'Status' }



                                            ]

    });

    jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
}

function ClearLJFilter() {

    $('#ddlorg1').val("0");
    $('#txtpointsDiscussed').val("");
    $('#txtToltal').val("");
    $('#txtCompletion').val("");
    $('#txtResponsibility').val("");
    $('#ddlStatus').val("0");
    $('#Button1').val('Save');

}
function AutoUser() {
    $("#txtResponsibility").autocomplete({
        source: function(request, response) {

            var id = $("#ddlTeamMember").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../QMS.asmx/QMS_LoadAnalyte',
                data: JSON.stringify({ Status: 'Participants~' + id, prefixText: request.term }),
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function(item) {
                            var data1 = "";
                            var slist = item.DisplayText.split('~');
                            if (slist.length > 1) {
                                data1 = slist[1];
                            }
                            var rsltlable = slist[0];
                            var rsltvalue = item.InvestigationID;
                            return {
                                label: rsltlable,
                                val: rsltvalue,
                                data: data1
                            }
                        }))
                    } else {
                        response([{ label: 'No results found.', val: -1}]);
                      //  $("#txGuestEmail").val('');
                        $('#hdnParticipants').val('');
                        $('#hdnRoleID').val('');
                        $("#txtResponsibility").focus();

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
            if (i.item.val != -1) {
                $("#hdnParticipants").val(i.item.val);
              //  $('#hdnParticipantEmail').val(i.item.data);
                $('#hdnRoleID').val($("#ddlTeamMember").val());
            }
        },
        minLength: 2
    });
}
function LoadRole() {
    var dd;
    var resdata = [];
    $.ajax({
        type: "POST",
        url: '../QMS.asmx/QMS_LoadAnalyte',
        data: JSON.stringify({ Status: 'Role~0', prefixText: "fdg" }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function(data) {
            dd = data.d;
            if (data.d.length > 0) {
                BindDDL('#ddlTeamMember', dd, 'InvestigationID', 'DisplayText');
            }

        },
        error: function(result) {
            alert("Error");
        }

    });

}