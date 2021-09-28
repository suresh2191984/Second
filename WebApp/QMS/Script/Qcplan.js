
var PScheduleEntity;
var EntityName = 'PlanAndSchedule_QMS';
$btnSave=$("#btnSave");
var URL = '../QMS.asmx/QMS_LoadAnalyte';
$(function() {





loadDept();
LoadRole();
$("#btnAddMail").on('click', function() {
var Roleid = $("#hdnRoleID").val();


    var id = $("#hdnParticipants").val();
    var mail = $('#hdnParticipantEmail').val();
    AddGuests(id, mail, Roleid);
    $("#txGuestEmail").val('');
});

$("#ddlTeamMember").on('change', function() {
$("#txGuestEmail").val('');
$('#hdnParticipants').val('');
$('#hdnParticipantEmail').val('');
});
$("#btnClear").on('click', function() {
    clearControls();
});
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
InitialLoad();
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
$("#linkCreate").click(function() {
    clearControls();

    showCard();

});
$("#linkBack").click(function() {
    hideCard();
    clearControls();

});
$('#timePair .time').timepicker({
    //'minTime': '12:00am',
    //'maxTime': '11:30pm',
// , 'showDuration': true
     'showDuration': true,
     'timeFormat': 'g:ia'

});

$('#timePair .date').datepicker({
    'format': 'm/d/yyyy',
    'autoclose': true

});

$('#timePair').datepair();

AutoUser();
if ($("#ddlEventType").val() != "0") {
    var eval = $('#ddlEventType  option:selected').attr('data');
    ShowHideContent(eval);
}
$("#ddlEventType").on('change', function() {
    var eval = $('#ddlEventType  option:selected').attr('data');
    if (eval != "0") {
        clearControls();
        ShowHideContent(eval);
        
    }
});
$("#btnSave").on('click', function() {
    if ($btnSave.attr('value') == 'Save') {
        getVal('I');

    }
    else {
        getVal('U');

    }




});
$("#btnFilter").on('click', function() {

    getFilter();
});

});

function getFilter() {

var arr = [];
var PlanandSchedue = getEntity(EntityName);

$.each($('#cardList input[Entity]'), function(idx, val) {

    var value = "";
    var eval = $(this).attr('Entity');
    var vtype = $(this).attr('valType');
    value = $(this).val();
    if (vtype == 'date') {
        value = dateformat($(this).val(), 'YYYY/MM/DD');
    }
    PlanandSchedue[eval] = value;

});

$.each($('#cardList select[Entity]'), function(idx, val) {

    var eval = $(this).attr('Entity');
    PlanandSchedue[eval] = $(this).val();

});
PlanandSchedue['Todate'] = PlanandSchedue.Todate + ' 23:59:59';
arr.push(PlanandSchedue);
LoadPlanAndSchedule('F', arr);
}
function showCard() {
$("#cardCreate").show();
$("#cardList").hide();
}
function hideCard() {
$("#cardList").show();
$("#cardCreate").hide();
}
function ShowHideContent(eventType) {

var arr = ["div", "input", "select","textarea"];
$.each(arr, function(idx, val) {
$('#cardCreate '+val+'[' + eventType + '="show"]').show();
$('#cardCreate '+val+'[' + eventType + '="hide"]').hide();
 });
}
function getVal(type) {

 var arr = [];
 var PlanandSchedue = getEntity(EntityName);
 PlanandSchedue['FromDate'] = "";
 PlanandSchedue['Todate'] = "";
 $.each($('#cardCreate input[Entity]'), function(idx, val) {

     var value = "";
     var eval = $(this).attr('Entity');
     var vtype = $(this).attr('valType');
     value = $(this).val();
     if (vtype == 'date') {
         value = dateformat($(this).val(), 'YYYY/MM/DD');
     }
     PlanandSchedue[eval] = value;

 });

 $.each($('#cardCreate select[Entity]'), function(idx, val) {

     var eval = $(this).attr('Entity');
     PlanandSchedue[eval] = $(this).val();

 });

 $.each($('#cardCreate textarea[Entity]'), function(idx, val) {

     var eval = $(this).attr('Entity');
     PlanandSchedue[eval] = $(this).val();

 });

 var fromtime = $("#fromTime").val();
 var totime = $("#toTime").val();
 if (PlanandSchedue.EventType == 0) {
     alert('Please select Event Type');
     return false;
 }
 if (PlanandSchedue.EventName == '') {
     alert('Please select Event Name');
     return false;
 }
 if (PlanandSchedue.FromDate == '' || PlanandSchedue.FromDate =='Invalid date') {
     alert('Please select FromDate');
     return false;
 }
 if (fromtime == '') {
     alert('Please select From Time');
     return false;
 }
 if (PlanandSchedue.Todate == '' || PlanandSchedue.Todate =='Invalid date') {
     alert('Please select ToDate');
     return false;
 }
 if (totime == '') {
     alert('Please select To Time');
     return false;
 }
 if (PlanandSchedue.Todate == '') {
     alert('Please select ToDate');
     return false;
 }
 
 PlanandSchedue['FromDate'] = PlanandSchedue.FromDate + ' ' + getTime(fromtime);
 PlanandSchedue['Todate'] = PlanandSchedue.Todate + ' ' + getTime(totime);


 if (PlanandSchedue.PlanScheduleID == '' || PlanandSchedue.PlanScheduleID==null)
 {PlanandSchedue.PlanScheduleID = 0; }
 PlanandSchedue.EventTypeCode=$('#ddlEventType  option:selected').attr('data');
 arr.push(PlanandSchedue);
 arr = GetEmails(arr, PlanandSchedue.PlanScheduleID);

 SavePlanAndSchedule(type, arr);

}
function GetEmails(arr,pid) {
 var lst = $("#divGuestMail .MultiFile-label");
 $.each(lst, function() {
     var lstObj = getEntity(EntityName);
     lstObj.UserID = $(this).attr('UserID');
     lstObj.RoleID = $(this).attr('RoleID');
     lstObj.PlanScheduleID = pid;
     arr.push(lstObj);
 });
  return arr;
}
function getTime(tval) {
 var values = tval.split(':');
 var min = values[1].substring(0, 2);
 var format1 = values[1].substring(2, 4);
 if (format1 == 'pm') {
     
     if (values[0] != 12)
     { values[0] = parseInt(values[0]) + parseInt(12);}    
 }
 else
 {
     if (values[0].length == 1) {
         values[0] = '0' + values[0];
     }
     if (values[0] == '12')
     {values[0] = '00'; }
 
 }
 var ftime = values[0] + ':' + min + ':00'

 return ftime;
}

function LoadPlanAndSchedule(AType, LstData) {
 var d = "";
 $.ajax({
     type: "POST",
     contentType: "application/json;charset=utf-8",
     url: "../QMS.asmx/LoadQcPlanAndSchedule",
     data: JSON.stringify({ ActionType: AType, plans: LstData }),
     dataType: "JSON",
     async: false,
     success: function(data) {

         if (AType == 'S') {
             if (data.d.length > 0) {

                 BindSchedules(data.d[0]);
             }
         }
         if (AType == 'F') {
             if (data.d.length > 0) {

                 BindSchedules(data.d[0]);
             }
         }
         if (AType == 'P') {
             d = data.d[0];
             d = d[0];
            
         }


     },
     error: function(xr) {
         var d = xr;
     }
 });

 return d;
}

function SavePlanAndSchedule(AType, LstData) {
 var d = "";
 $.ajax({
     type: "POST",
     contentType: "application/json;charset=utf-8",
     url: "../QMS.asmx/SaveQcPlanAndSchedule",
     data: JSON.stringify({ ActionType: AType, plans: LstData }),
     dataType: "JSON",
     async: false,
     success: function(data) {

         if (AType == 'S') {
             if (data.d.length > 0) {

                 BindSchedules(data.d[0]);
             }
         }
         if (AType == 'P') {
             d = data.d[0];
         }
         else if (AType == 'I') {
             if (data.d.length > 0) {
                 var id = data.d[0];
                 FilesAddDelete(DelFiles, id[0].PlanScheduleID, 'PlanAndSchedule_QMS');
             }

             alert('Scheduled successfully');
             InitialLoad();
             clearControls();
             hideCard();
             
         }
          else if (AType == 'U') {
             if (data.d.length > 0) {
                 var id = data.d[0];
                 FilesAddDelete(DelFiles, id[0].PlanScheduleID, 'PlanAndSchedule_QMS');
             }
           
            
              alert('Updated successfully');
              InitialLoad();
              clearControls();
              hideCard();
                      }


     },
     error: function(xr) {
         var d = xr;
     }
 });

 return d;
}
function loadDept() {
 var dd;
 var resdata = [];
 $.ajax({
     type: "POST",
     url: "../QMS.asmx/QMS_LoadInvPrincipleMaster",
     contentType: "application/json; charset=utf-8",
     dataType: "json",
     async: true,
     success: function(data) {
         dd = data.d;
         if (dd[2].length > 0) {
             BindDDL('#ddlDepartment', dd[2], 'DeptID', 'DeptName');             
         }
  
     },
     error: function(result) {
         alert("Error");
     }

 });

}

function LoadRole() {
 var dd;
 var resdata = [];
 $.ajax({
     type: "POST",
     url: URL,
     data: JSON.stringify({ Status: 'Role~0', prefixText:"fdg" }),
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

function AutoUser() {
 $("#txGuestEmail").autocomplete({
     source: function(request, response) {

         var id = $("#ddlTeamMember").val();
         $.ajax({
             type: "POST",
             contentType: "application/json; charset=utf-8",
             url: URL,
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
                     $("#txGuestEmail").val('');
                     $('#hdnParticipantEmail').val('');
                     $('#hdnRoleID').val('');
                     $("#txGuestEmail").focus();

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
              $('#hdnParticipantEmail').val(i.item.data);
             
             $('#hdnRoleID').val($("#ddlTeamMember").val());
         }
     },
     minLength: 2
 });
}

var mails = [];
function AddGuests(id,mail,roleid) {
 

if (id != '' && mail != '') {

    if (!checkMailExists(id)) {
        var lst = {};
        lst['id'] = id;
        lst['mail'] = mail;
        mails.push(lst);

        var d = '<div id="U-' + id + '" UserID="' + id + '" RoleID="' + roleid + '" class="MultiFile-label">\
                 <a class="MultiFile-remove" href="#txtfileupload_wrap" style="color:red;font-size:large;font-weight:900">x</a>\
                 <span class="MultiFile-title" >' + mail + '</span>\
                 </div>';
        $("#divGuestMail").append(d);
        $('#divGuestMail .MultiFile-remove').click(function() {
            var id=$(this).parent('div').attr('userid');
            var found_names = $.grep(mails, function(v) {
                return v.id != id;
            });
            mails = found_names;
            var div = $(this).parent('div');
            $(div).remove();
        });
    }
 }

}
function checkMailExists(id)
{
var fl=false;
 var found_names = $.grep(mails, function(v) {
     return v.id == id;
 });
 if (found_names.length > 0) {
     fl = true;
 }
 return fl;
}
var cnt = 1;

function BindSchedules(data) {
 cnt = 1;
 var tbl = '#tblScheduledList';
             $(tbl+'  tbody > tr').remove();
             $(tbl).show();
             $(tbl).dataTable({
                 paging: true,
                 data: data,
                 "bDestroy": true,
                 "searchable": true,
                 "sort": true,
                 "fnDrawCallback": function() {
                     $('#tblScheduledList input[data="Edit"]').on('click', function() {

                         var pid = $(this).attr('PID');
                         var code = $(this).attr('Code');
                         ShowHideContent(code);
                         var arr = [];
                         var lstObj = getEntity(EntityName);
                         lstObj['PlanScheduleID'] = pid;
                         arr.push(lstObj);
                         var lst = LoadPlanAndSchedule('P', arr);
                         $.each($('#cardCreate input[Entity]'), function(idx, val) {

                             var value = "";
                             var eval = $(this).attr('Entity');
                             var vtype = $(this).attr('valType');
                             value = lst[eval];
                             if (vtype == 'date') {
                                 if (value != null) {
                                     var date = new Date(parseInt(value.substr(6)));
                                     var month = date.getMonth() + 1;
                                     value = date.getDate() + "/" + month + "/" + date.getFullYear();
                                 }
                                 else
                                 { value = ""; }
                             }
                             $(this).val(value);

                         });

                         $.each($('#cardCreate select[Entity]'), function(idx, val) {

                             var eval = $(this).attr('Entity');
                             var vl = lst[eval];
                             $(this).val(vl);

                         });
                         $.each($('#cardCreate textarea[Entity]'), function(idx, val) {

                             var eval = $(this).attr('Entity');
                             var vl = lst[eval];
                             $(this).val(vl);
                             // PlanandSchedue[eval] = $(this).val();

                         });
                         populateOnEdit(lst.Files);

                         if (lst.Email != null && lst.Email != '') {
                             var mailList = lst.Email.split(',');
                             $.each(mailList, function(idx, val) {
                                 var mails = val.split('~');
                                 AddGuests(mails[0], mails[1], mails[2]);

                             });

                         }
                         showCard();
                         if ($(this).attr('value') == "View") {

                             $("#cardCreate *").prop('disabled', true);
                         }
                         else {


                         }
                         $btnSave.attr('value', 'Update');

                     });

                     $('#tblScheduledList input[data="Delete"]').on('click', function() {

                         if (DeleteConfirm()) {
                             var arr = [];
                             var lstObj = getEntity(EntityName);
                             var pid = $(this).attr('PID');
                             lstObj['PlanScheduleID'] = pid;
                             arr.push(lstObj);
                             var lst = SavePlanAndSchedule('D', arr);
                             //   var dd = LoadPlanAndSchedule('S', arr);
                             InitialLoad();
                         }

                     });



                 },

                 columns: [
                                        { 'data': 'PlanScheduleID',
                                            "sClass": "hide_Column"

                                        },
                                        { 'data': 'SNO'

                                        },

                                        {
                                            'data': 'EventType',
                                            "sClass": "hide_Column"

                                        },
                                        {
                                            'data': 'EventTypeName'

                                        },
                                        {
                                            'data': 'EventName'

                                        },
                                        {
                                            'data': 'StartTime1'

                                        },

                                        { 'data': 'Location'

                                        },
                                        { 'data': 'Status' },

                                        { 'data': 'Action',
                                            "ordering": true,
                                            "mRender": function(data, type, full, meta) {
                                                var cclass = "";
                                                var disabled = 'disabled=disabled';
                                                var ctrl = "View";
                                                if (full.CreatedBy != null && full.CreatedBy == lid) {
                                                    disabled = '';
                                                    ctrl = 'Edit';
                                                }
                                                var txt = '<input Code="' + full.Code + '" PID="' + full.PlanScheduleID + '" data="Edit" value = "' + ctrl + '" ' + disabled + '  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';
                                                txt += '/<input Code="' + full.Code + '" PID="' + full.PlanScheduleID + '" data="Delete" value = "Delete" ' + disabled + '  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"/>';
                                                return txt;

                                            }

                                        }

                                        ]

             });

             jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
}

function clearControls() {

    var eval = $('#ddlEventType  option:selected').attr('data');
    var id = $('#ddlEventType').val();

    $.each($('#cardCreate input:not([type="button"])'), function(idx, val) {

    if ($(this).attr('id') !== 'hdnFilepath') {
            $(this).val("");
        }

    });

 $.each($('#cardCreate select'), function(idx, val) {

     var id = $(this).attr('id')
     var val = $('#' + id + " option:first").val();
     $(this).val(val);

 });
 $.each($('#cardCreate textarea[Entity]'), function(idx, val) {

   $(this).val("");

});
$('#ddlEventType').val(id);
mails = [];
$('#divGuestMail').html('');
$('#txtfileupload_wrap_list').html('');
DelFiles = [];
$("#txtfileupload").Attune_RemoveFiles();

ShowHideContent(eval);
 $btnSave.attr('value', 'Save');

}

function DeleteConfirm() {
 var objConfirm = "Are you sure you want to delete?";
 if (confirm(objConfirm)) {
     return true;
 }
 return;
}

function InitialLoad()
{

 getFilter();
}