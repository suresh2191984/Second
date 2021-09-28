var EntityName1 = 'PlanAndSchedule_QMS';
var content = '';
$(function() {

    $("#txtDate").datepicker({
        dateFormat: 'dd/mm/yy',
        yearRange: '1900:2100'
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

    $("#txtCompletionDate").datepicker({
        dateFormat: 'dd/mm/yy',
        defaultDate: "+1w",
        minDate: 1,
        yearRange: '1900:2100'
    });
    $("#btnShowTask").on('click', function() {
        filterLoad();


    });
    $('#linkBack').on('click', function() {
        filterLoad();
        hideCard();
    });
    filterLoad();
    $('#btnAdd').on('click', function() {
        if ($(this).attr('value') == 'Add') {
            SaveObservation('I');

        }
        if ($(this).attr('value') == 'Update') {
            SaveObservation('U');

        }
        clearobservation();
    });

    $('#btnClearNC').on('click', function() {

        clearNcControls();
    });
    $('#btnSaveNC').on('click', function() {
        if ($(this).attr('value') == 'Save') {
            SaveNcs('I');
            
        }
        else {
            SaveNcs('U');
            
        }
        
    });


});

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
function LoadSaveInternalObservation(AType, lstObservation) {

    var d = "";
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/InternalAuditObservation",
        data: JSON.stringify({ ActionType: AType, observations: lstObservation }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            if (AType == 'S') {
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
            $('#tblScheduledList input[data="view"]').on('click', function() {
                var pid = $(this).attr('PID');
                var code = $(this).attr('Code');

                var arr = [];
                var lstObj = getEntity();
                lstObj['PlanScheduleID'] = pid;
                arr.push(lstObj);
                var lst = LoadPlanAndSchedule('P', arr);

                $.each($('#cardList label[Entity]'), function(idx, val) {

                    var eval = $(this).attr('Entity');
                    var vtype = $(this).attr('valType');
                    value = lst[eval];
                    if (vtype == 'date') {
                        value = GetCorrectdate(value);
                    }

                    $(this).text(value);

                });

                $('#divGuestMail').html('');
                if (lst.Email != null && lst.Email != '') {

                    var mailList = lst.Email.split(',');

                    if (mailList != '' || mailList != null) {
                        $.each(mailList, function(idx, val) {
                            var mails = val.split('~');
                            AddGuests(mails[0], mails[1], mails[2]);

                        });
                    }
                }

                populateOnEdit(lst.Files);
                bindObservation();
                bindNCs();
                showCard();


            });





        },

        columns: [

                                            { 'data': 'SNO'



                                            },


                                            {
                                                'data': 'EventName'

                                            },
                                            {
                                                'data': 'FromDate1'

                                            },

                                            { 'data': 'Location'

                                            },
                                            { 'data': 'Auditor'

                                            },
                                            { 'data': 'Status' },

                                            { 'data': 'Action',
                                                "ordering": true,
                                                "mRender": function(data, type, full, meta) {
                                                    var cclass = "";
                                                    // var disabled = 'disabled=disabled';
                                                    var ctrl = "Edit";
                                                    //                                                    if (full.CreatedBy != null && full.CreatedBy == lid) {
                                                    disabled = '';
                                                    //                                                        ctrl = 'Edit';
                                                    //                                                    }
                                                    var txt = '<input Code="' + full.Code + '" PID="' + full.PlanScheduleID + '" data="view" value = "' + ctrl + '" ' + disabled + '  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';
                                                    //  txt += '/<input Code="' + full.Code + '" PID="' + full.PlanScheduleID + '" data="Delete" value = "Delete" ' + disabled + '  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"/>';
                                                    return txt;

                                                }

                                            }

                                            ]

    });

    jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
}
function getVal(type) {

    var arr = [];
    var PlanandSchedue = getEntity(EntityName1);
    PlanandSchedue['FromDate'] = "";
    PlanandSchedue['Todate'] = "";
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

    if(PlanandSchedue.PlanScheduleID=="")
    { PlanandSchedue.PlanScheduleID = 0; }

    PlanandSchedue.EventTypeCode = type;
    PlanandSchedue['Todate'] = PlanandSchedue.Todate + ' 23:59:59';
    arr.push(PlanandSchedue);
    return arr;


}
function AddGuests(id, mail, roleid) {



            var d = '<div id="U-' + id + '" UserID="' + id + '" RoleID="' + roleid + '" class="MultiFile-label">\
                     <span class="MultiFile-title" >' + mail + '</span>\
                     </div>';
            $("#divGuestMail").append(d);


        }

function bindObservation() {
    var lbl = $('#cardList label[Entity="PlanScheduleID"]').text();

        var obj = GetObservationEntiy();
        obj.PlanScheduleID = lbl;
        var Lst = LoadSaveInternalObservation('S', obj);
        BindObservationTable(Lst);
    }
    function bindNCs() {
        var lbl = $('#cardList label[Entity="PlanScheduleID"]').text();

        var obj = {};
        obj.PlanScheduleID = lbl;
        var Lst = LoadSaveInternalNCs('S', obj);
        BindNCTable(Lst);
        
    }
function SaveObservation(Atype) 
     {
          var lbl = $('#cardList label[Entity="PlanScheduleID"]').text();
          var obj = GetObservationEntiy();
          $.each($('#cardList select[Entity]'), function(idx, val) {

              var eval = $(this).attr('Entity');
              obj[eval] = $(this).val();

          });
          $.each($('#cardList input[Entity]'), function(idx, val) {

              var eval = $(this).attr('Entity');
              obj[eval] = $(this).val();

          });

          if (obj.AuditType == 0) {
              alert('Please select Audit Type');
              return false;
          }
          if (obj.Observation == '') {
              alert('Please fill observation');
              return false;
          }
          if (obj.Category == 0) {
              alert('Please select Category');
              return false;
          }
          obj.PlanScheduleID = lbl;
          LoadSaveInternalObservation(Atype, obj);
          var Lst = LoadSaveInternalObservation("S", obj);
          BindObservationTable(Lst);
      }
      

   function BindObservationTable(data) {
       
       var tbl = '#tblObservationList';
       $(tbl + '  tbody > tr').remove();
       $(tbl).show();
       $(tbl).dataTable({
           paging: true,
           data: data,
           "bDestroy": true,
           "searchable": true,
           "sort": true,
           "fnDrawCallback": function() {
               $('#tblObservationList input[data="Edit"]').on('click', function() {
                   var ctrl = $(this);

                   $.each($('#tab_2 input[Entity]'), function(idx, val) {

                       var eval = $(this).attr('Entity');
                       var vl = $(ctrl).attr(eval);
                       if (vl != null)
                       { $(this).val(vl); }


                   });
                   $.each($('#tab_2 select[Entity]'), function(idx, val) {
                       var eval = $(this).attr('Entity');
                       var vl = $(ctrl).attr(eval);
                       if (vl != null)
                       { $(this).val(vl); }

                   });

                   $('#btnAdd').attr('value', 'Update');

               });
               $('#tblObservationList input[data="Delete"]').on('click', function() {
               var Iaid = $(this).attr('InternalAuditID');
               var pid =$(this).attr('PlanScheduleID');
               
                   var obj = {};
                   obj.InternalAuditID = Iaid;
                   obj.PlanScheduleID=pid;
                   LoadSaveInternalObservation('D', obj);
                   var Lst = LoadSaveInternalObservation("S", obj);
                   BindObservationTable(Lst);
               });
           },

           columns: [

                                            { 'data': 'SNO'

                                            },
                                            {
                                                'data': 'AuditType'
                                            },

                                            { 'data': 'Observation'


                                            },
                                            { 'data': 'Category' },

                                            { 'data': 'Action',
                                                "ordering": true,
                                                "mRender": function(data, type, full, meta) {

                                                    var txt = '<input Category="' + full.Category + '" Observation="' + full.Observation + '" AuditType="' + full.AuditType + '"  InternalAuditID="' + full.InternalAuditID + '"  PlanScheduleID="' + full.PlanScheduleID + '" data="Edit" value = "Edit"  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';
                                                    txt += '/<input  InternalAuditID="' + full.InternalAuditID + '"  PlanScheduleID="' + full.PlanScheduleID + '" data="Delete" value = "Delete" class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"/>';
                                                    return txt;

                                                }

                                            }

                                            ]

       });
                                        jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
   }
   function GetObservationEntiy() {
      // var arr = [];
       var obj = {};
       obj.InternalAuditID=0;
       obj.PlanScheduleID=0;
       obj.AuditType="";
       obj.Observation="";
       obj.Category="";
      
      //  arr.push(arr);

       return obj;
   }

   function clearobservation() 
   {

       $.each($('#tab_2 select[Entity]'), function(idx, val) {

       var id = $(this).attr('id');
       var val = $('#' + id + " option:first").val();
       $(this).val(val);

       });
       $.each($('#tab_2 input[Entity]'), function(idx, val) {

    
           if ($(this).attr('type') == 'hidden') {
           $(this).val('0');
       }
       else
       { $(this).val(''); }
       });

   

       $('#btnAdd').attr('value', 'Add');
   }
   function BindNCTable(data) {

       var tbl = '#tblNCList';
       $(tbl + '  tbody > tr').remove();
       $(tbl).show();
       $(tbl).dataTable({
           paging: true,
           data: data,
           "bDestroy": true,
           "searchable": true,
           "sort": true,
           "fnDrawCallback": function() {
               $('#tblNCList input[data="Edit"]').on('click', function() {
                   var ctrl = $(this);
                   var IAID = $(this).attr('InternalAuditNCID');
                   var obj = {};
                   obj.InternalAuditNCID = IAID;
                   var lst = LoadSaveInternalNCs('P', obj);
                   $.each($('#tab_3 input[Entity]'), function(idx, val) {  

                   var eval = $(this).attr('Entity');
                   var vtype = $(this).attr('valType');
                       var vl = lst[eval];
                       if (vl != null) {
                           if (vtype == 'date' && vl != '' && vl !=null) {
                               vl =GetCorrectdate(vl);
                           }
                           $(this).val(vl);
                       
                        }


                   });
                   $.each($('#tab_3 select[Entity]'), function(idx, val) {
                       var eval = $(this).attr('Entity');
                       var vl = lst[eval];
                       if (vl != null)
                       { $(this).val(vl); }

                   });

                   $('#btnSaveNC').attr('value', 'Update');

               });
               $('#tblNCList input[data="Delete"]').on('click', function() {
                   var IAID = $(this).attr('InternalAuditNCID');
                   var obj = {};
                   obj.InternalAuditNCID = IAID;
                   LoadSaveInternalNCs('D', obj);
                   bindNCs();
               });
           },

           columns: [

                                            { 'data': 'SNO',
                                                'test': 'SNO'
                                            },

                                            {
                                                'data': 'NABLClause'
                                            },

                                            {
                                                'data': 'ISOClause'
                                            },
                                                  {
                                                      'data': 'InternalAuditNCID'
                                                  },
                                                  {
                                                      'data': 'Description'
                                                  },
                                                  {
                                                      'data': 'Classification'
                                                  },
                                                     {
                                                         'data': 'ProposedAction'
                                                     },


                                            {
                                                'data': 'ActionVerified'
                                            },

                                             {
                                                 'data': 'Status'
                                             },

                                            { 'data': 'Action',
                                                "ordering": true,
                                                "mRender": function(data, type, full, meta) {

                                                var txt = '<input InternalAuditNCID="' + full.InternalAuditNCID + '" data="Edit" value = "Edit"  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';
                                                txt += '/<input InternalAuditNCID="' + full.InternalAuditNCID + '" data="Delete" value = "Delete" class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"/>';
                                                    return txt;

                                                }

                                            }

                                            ]

       });
       jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
   }

   function LoadSaveInternalNCs(AType, lstObservation) {

       var d = "";
       $.ajax({
           type: "POST",
           contentType: "application/json;charset=utf-8",
           url: "../QMS.asmx/InternalAuditNCs",
           data: JSON.stringify({ ActionType: AType, ncs: lstObservation }),
           dataType: "JSON",
           async: false,
           success: function(data) {
               if (AType == 'S') {
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
   function SaveNcs(Atype) {
   var obj={};
       var lbl = $('#cardList label[Entity="PlanScheduleID"]').text();
   
       $.each($('#cardList select[Entity]'), function(idx, val) {

           var eval = $(this).attr('Entity');
           obj[eval] = $(this).val();

       });
       $.each($('#cardList input[Entity]'), function(idx, val) {

           var eval = $(this).attr('Entity');
           var vtype = $(this).attr('valType');
           value = $(this).val();
           if (vtype == 'date') {
               if (value != '' && value != null) {
                   value = dateformat(value, 'YYYY/MM/DD');
               }
           }
           obj[eval] = value;

       });
       if(obj.NABLClause == '') {
           alert('Please Enter NABL Clause');
           return false;
       }
       else if (obj.ISOClause == '') {
           alert('Please Enter ISO Clause');
            return false;
       }
       
         else if (obj.Classification == '0') {
           alert('Please Select Classification');
            return false;
       }
        else if (obj.CompletionDate == '') {
           alert('Please Select Proposed Completion Date');
           return false;
       }
       
          else if (obj.ActionVerified == '0') {
           alert('Please Select Corrective Action Verified');
           return false;
       }
       
       
       obj.PlanScheduleID = lbl;
       //obj.CompletionDate = "2017-02-15";
       LoadSaveInternalNCs(Atype, obj);
       clearNcControls();
       var Lst = LoadSaveInternalNCs("S", obj);
       BindNCTable(Lst)
   }

   function showCard() {
       $("#filterCard").hide();
       $("#cardList").show();
    }
   function hideCard() {

       $("#cardList").hide();
       $("#filterCard").show();
   }

   function clearNcControls() 
   {

       $.each($('#tab_3 select[Entity]'), function(idx, val) {

       var id = $(this).attr('id');
       var val = $('#' + id + " option:first").val();
       $(this).val(val);

       });
       $.each($('#tab_3 input[Entity]'), function(idx, val) {

             if ($(this).attr('type') == 'hidden') {
              $(this).val('0');
               }
                  else
                   { $(this).val(''); }
       

       });

       $('#btnSaveNC').attr('value', 'Save');

   }

   function filterLoad() {

       var lits = getVal('IA');
       var dat = LoadPlanAndSchedule('T', lits);
       BindSchedules(dat);
   }