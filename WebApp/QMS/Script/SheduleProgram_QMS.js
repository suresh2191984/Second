function LoadPrgramDetails() {

var lst = getVal('TP');
var dataLst=LoadPlanAndSchedule('T', lst);
BindSchedules(dataLst);

$('#tblProgramList tbody tr').on('click', function(event) {
    LoadPlanIDDetails($(event.target.parentElement).find("td")[0].innerHTML);
});

}

function BindSchedules(dataLst) {

    $('#tblProgramList  tbody > tr').remove();
    $('#tblProgramList').dataTable({
        paging: true,
        "iDisplayLength": 5,
        "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
        data: dataLst,
        "bDestroy": true,
        "searchable": true,
        "sort": true,
        dom: 'Bfrtip',
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
                { 'data': 'PlanScheduleID',
                    "sClass": "hide_Column"
                },
                                        { 'data': 'SNO'
                                        }
                                        ,
                                         { 'data': 'EventName'
                                         }
                                        ,
                                         { 'data': 'Topic'
                                         }
                                        ,
                                         { 'data': 'FromDate1'
                                         }
                                        ,
                                         { 'data': 'Location'
                                         }
                                           ,
                                             { 'data': 'EventTypeCode'
                                             }
                                        ,
                                         { 'data': 'Status'
                                         }
                                     ]
    });
}
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

function getVal(type) {

    var arr = [];
    var PlanandSchedue = {};
    $.each($('#divProgramFilter input[Entity]'), function(idx, val) {

        var value = "";
        var eval = $(this).attr('Entity');
        var vtype = $(this).attr('valType');
        value = $(this).val();
        if (vtype == 'date') {
            value = dateformat($(this).val(), 'YYYY/MM/DD');
        }
        PlanandSchedue[eval] = value;

    });

    $.each($('#divProgramFilter select[Entity]'), function(idx, val) {

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

function LoadPlanIDDetails(PlanID) {
Clearfilter();
$('#divProgramFilter').hide();
$('#divTriningProgram').show();
$('#btnBack').show();
var ParticipentDetails = "";


$.ajax({
    type: "POST",
    contentType: "application/json;charset=utf-8",
    url: "../QMS.asmx/QMS_GetTrainingProgramDetails",
    data: JSON.stringify({ ScheduledID: parseInt(PlanID) }),
    dataType: "JSON",
    async: false,
    success: function(data) {

        var PlanDetials = data.d[0][0];
        var ParticipentDetails = data.d[1];

        var ParticipantsEmail = new Array();
        if (PlanDetials.Agenda != null && PlanDetials.Agenda != '') {
            ParticipantsEmail = PlanDetials.Agenda.split(',');
        }
        var i = 0;
        var EmailID;
        var Role;
        var UserName;
        var userID;
        $("#divGuestMail").html('');
        $('#ddlParticipant').empty();
        $('#ddlParticipant').append($('<option></option>').val(0).html('---select---'));
        for (i = 0; i < ParticipantsEmail.length; i++) {
            userID = ParticipantsEmail[i].split('~')[0]
            EmailID = ParticipantsEmail[i].split('~')[1];
            Role = ParticipantsEmail[i].split('~')[2];
            UserName = ParticipantsEmail[i].split('~')[3];


            var d = '<div  class="MultiFile-label">\
                            <span class="MultiFile-title" >' + EmailID + '</span>\
                            <span >&nbsp;&nbsp;</span>\
                            <span class="MultiFile-title" >' + Role + '</span>\
                            </div>';
            $("#divGuestMail").append(d);
            $('#ddlParticipant').append('<option value="' + userID + '">' + UserName + '</option>');
         
            EmailID = "";
            Role = "";

        }




        $('#lblTraining').html(PlanDetials.EventName);
        $('#lblDateTime').html(PlanDetials.AuditScope);
        $('#lblVenue').html(PlanDetials.Venue);
        $('#lblTopic').html(PlanDetials.EventName);
        $('#hdnScheduleID').val(PlanID);
        $('#ddlStatus').val(PlanDetials.Status);



        var TraingProgList = 0;
        if (TraingProgList.length > 0 && TraingProgList != "[]") {


            $('#tblTraining').show();

            $('#tblProgramList  tbody > tr').remove();
            $('#tblProgramList').dataTable({
                paging: true,
                "iDisplayLength": 5,
                "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                data: TraingProgList,
                "bDestroy": true,
                "searchable": true,
                "sort": true,
                dom: 'Bfrtip',
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
                { 'data': 'PlanScheduleID',
                    "sClass": "hide_Column"

                },

                                        { 'data': 'RowNum'
                                        }

                                        ,
                                         { 'data': 'EventName'
                                         }
                                        ,
                                         { 'data': 'AuditScope'

                                         }
                                        ,
                                         { 'data': 'FromDate'
                                         }
                                        ,

                                         { 'data': 'Location'
                                         }
                                           ,
                                             { 'data': 'Agenda'
                                             }

                                        ,
                                         { 'data': 'Status'
                                         }

                                     ]
            });


        }
        else {

        }
        if (ParticipentDetails != "") {
            LoadpartcipentTable(ParticipentDetails);
        }
        else {

            $('#tblTraining').hide();
        }


    },
    error: function(xhr, status, error) {
        alert(xhr);
    }


});



}

function SaveLJFilter(Action) {
debugger;

var ScheduleID = $('#hdnScheduleID').val();
var Type = Action;
var TrainingProgramID = "";
var OrgID=$('#hdnOrgID').val();
if (Action == 'Update') {

    TrainingProgramID = $('#hdnTrainingprogramID').val();

}
else {
    TrainingProgramID = 0;


}
var ExamType = $("#ddlExamType").val();
if (ExamType == 0) {
    alert('Select Exam Type');
    return false;
}
var Participant = $("#ddlParticipant").val();
if (Participant == 0) {
    alert('Select Participant');
    return false;
}
var Toltal = $("#txtToltal").val(); 
var MarksObtained = $("#txtMarksObtained").val();
var Remarks = $("#txtRemarks").val();
if (MarksObtained == '') {MarksObtained = 0; }
if (Toltal == '') {Toltal = 0; }
// var Status = $("#ddlStatus").val(); 
var array = [];
   array.push({
        ExamType: ExamType,
        Participant: Participant,
        TotalMarks: Toltal,
        MarksObtained: MarksObtained,
        Remarks: Remarks,
        PlanScheduleID: ScheduleID,
        TrainingProgramID:TrainingProgramID,
        OrgID:OrgID
    });


    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/SaveTrainingProgramDetails",
        data: JSON.stringify({ QCAnalyzerMapping: array, ScheduleID: ScheduleID, Type: Type }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            var Result = data.d[0];

            LoadpartcipentTable(Result);
            ClearLJFilter();

        },
        error: function(xhr, status, error) {
            alert(xhr);
        }


    });

    return false;

}
function Delete_OnClick(Details,PlanScheduleID,Orgid){

var TrainingProgramID=Details;
var PlanScheduleID=PlanScheduleID;
var Orgid = Orgid;
var Type = "Delete";


$.ajax({
    type: "POST",
    contentType: "application/json;charset=utf-8",
    url: "../QMS.asmx/DeleteTrainingProgramDetails",
    data: JSON.stringify({ TrainingProgramID: TrainingProgramID, PlanScheduleID: PlanScheduleID, Orgid: Orgid, Type: Type }),
    dataType: "JSON",
    async: false,
    success: function(data) {
    //var Result = data.d[0];
    ClearLJFilter();
        LoadPlanIDDetails(PlanScheduleID);
        
        //LoadpartcipentTable(Result);



    },
    error: function(xhr, status, error) {
        alert(xhr);
    }


});


}

function LoadpartcipentTable(ParticipentDetails)
{
$('#tblProgramList').hide();
$('#tblTraining').show();
var Result=ParticipentDetails;
$('#tblTraining  tbody > tr').remove();
                $('#tblTraining').dataTable({
                    paging: true,
                    "iDisplayLength": 5,
                    "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                    data: Result,
                    "bDestroy": true,
                    "searchable": false,
                    "sort": true,
                    dom: 'Bfrtip',
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
                    { 'data': 'TrainingProgramID'
                    //"sClass": "hide_Column"

                },

                                        { 'data': 'Participant'
                                        }

                                        ,
                                         { 'data': 'ExamType'
                                         }
                                        ,
                                         { 'data': 'TotalMarks'

                                         }
                                        ,
                                         { 'data': 'MarksObtained'
                                         }
                                        ,

                                          { 'data': 'Edit'
                                         }  
                                         
                                     ]

                });


            }

            function btnEdit_OnClick(Details) {


                $("#ddlExamType").val($(Details).attr('ExamType'));
                var part = $(Details).attr('Participant');
                $("#ddlParticipant").val(part);
                $("#txtToltal").val($(Details).attr('TotalMarks'));
                $("#txtMarksObtained").val($(Details).attr('MarksObtained'));
                $("#txtRemarks").val($(Details).attr('Remarks'));
                $("#Button1").val('Update');
                $("#hdnTrainingprogramID").val($(Details).attr('TrainingProgramID'));


            }


            function ClearLJFilter() {

                $('#ddlExamType').val(0);
                $('#ddlParticipant').val(0);
                $('#txtToltal').val('');
                $('#txtMarksObtained').val('');
                $('#txtRemarks').val('');
                //$('#ddlStatus').val('0');
                $("#Button1").val('Save');

            }

            function Clearfilter() {
                $('#dllOrg').val('0');
                $('#txtDate').val('');
                $('#txtTopic').val('');
                $('#txtName').val('');
                $('#txtTriner').val('');
                $('#txtStatus').val('0');



            }


            function SaveTrainingStatus() {
                debugger;

                var ScheduleID = $('#hdnScheduleID').val();
                var ActionType = 'T';
                var EventTypeCode = 'TP';
                
                var Status = $('#ddlStatus').val();
                var OrgID = $('#hdnOrgID').val();
               
                var array = [];
                array.push({
                EventTypeCode: EventTypeCode,
                PlanScheduleID: ScheduleID,
                    Status: Status,
                    OrgID: OrgID
                });


                $.ajax({
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    url: "../QMS.asmx/SaveQcPlanAndSchedule",
                    data: JSON.stringify({ ActionType: ActionType, plans: array }),
                    dataType: "JSON",
                    async: false,
                    success: function(data) {
                        //                            var Result = data.d[0];

                        //                            LoadpartcipentTable(Result);
                        //                            ClearLJFilter();
                        alert("Saved Successfully.");

                    },
                    error: function(xhr, status, error) {
                        alert(xhr);
                    }


                });

                return false;

            }


            function AutoTrainer() {
                var obj = {};
               

                $("#txtTriner").autocomplete({
                    source: function(request, response) {

                       // var id = $("#ddlTeamMember").val();
                         obj.Value = $('#txtTriner').val();
                obj.CtrlName = 'Trainer';
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: '../QMS.asmx/QMS_LoadCascadingDDL',
                            data: JSON.stringify(obj),
                            dataType: "json",
                            success: function(data) {
                                if (data.d.length > 0) {
                                    response($.map(data.d, function(item) {

                                    var rsltlable = item.Name;
                                        var rsltvalue = item.ID;
                                        return {
                                            label: rsltlable,
                                            val: rsltvalue
                                            
                                        }
                                    }))
                                } else {
                                    $("#hdntrainingID").val(0);
                                    response([{ label: 'No results found.', val: -1}]);
                                    $("#txtTriner").val('');
                                    $('#hdnParticipantEmail').val('');
                                    $('#hdnRoleID').val('');
                                    $("#txtTriner").focus();

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
                          $("#hdntrainingID").val(i.item.val);

                        }
                    },
                    minLength: 2
                });
            }
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