$(document).ready(function() {


    $(function() {
        //Date picker
        $('.datepicker').datepicker({
            format: 'dd/mm/yy',
            autoclose: true
        });
    });

    $("#txtDate").datepicker({
    maxDate: 0, 
    dateFormat: 'dd/mm/yy'
});

$("#txtCompDate").datepicker({
    minDate: 1,
    defaultDate: "+1w",
    //minDate: new Date(),
    dateFormat: 'dd/mm/yy'

    });

    
    

    $('#divMainContent').on('change', function(event) {
        var itemId = event.target.id;

        var attr = $(itemId).attr('aria-describedby');




        if (attr != 'undefined') {
            $('#' + itemId).tooltip('destroy');
        }

    });

    $('#txtNPCNO').prop("disabled", true);



    $("#txtPerson").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../QMS.asmx/QMS_LoadAnalyte',
                data: JSON.stringify({ Status: 'RespPerson~0', prefixText: request.term }),
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                    response($.map(data.d, function(item) {
                        var rsltlable = item.DisplayText;
                        var rsltvalue = item.InvestigationID;
                        return {
                            label: rsltlable,
                            val: rsltvalue
                        }
                    }))
                    } else {
                    response([{ label: langData.result_notfound, val: -1}]);
                        $("#txtPerson").val('');
                        $("#txtPerson").focus();

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
            $("#hdnRespPerson").val(i.item.val);
            }
        },
        minLength: 2
    });

    $("#txtPerson").change(function(event) {

        var Value = $("#hdnRespPerson").val();
        if (parseInt(Value) <= 0) {
            $("#txtPerson").val('');
            $("#txtPerson").focus();
        }


    });

    // LoadDropDowns();
    $("#btnSave").click(function() {
        if (ValidateSave() == true) {
            SavePNC();
              
        }

    });
    $("#btnClear").click(function() {
        clear();

    });



    LoadDropDowns();
    LoadPNCDetails();
});

function clearfields() {
    $("#txtPerson").val('');
    $("#txtPerson").focus();

}

function ValidateSave() {
    if ($('#ddlDepartment option:selected').val() == "0") {

        alert(langData.alert_departmentselect);
    }
    else if ($('#txtDate').val() == "") {
    alert(langData.alert_completiondate);
    }
    else if ($("#hdnRespPerson").val() == '' || $("#hdnRespPerson").val() == '0') {
    alert(langData.alert_rperson);

    }
    else if ($('#txtPerson').val() == '') {
        alert(langData.alert_rperson);
    }
    else if ($('#ddlStatus option:selected').val() == "0") {
    alert(langData.alert_status);
    }
    
    else {
        return true;
    }

    return false;

}






function LoadDropDowns() {
    //*************Load Dept Drop Down*************//
    var OrgId = document.getElementById("hdnOrgID").value;
    var InvestigationID = 0;

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/LoadQMSDropDown",
        data: JSON.stringify({ Orgid: OrgId }),
        dataType: "json",
        async: false,
        success: function(data) {

            if (data.d.length >= 0) {
                var ArryLst = data.d;
                //ddlDepartment
                var ddlDepartmentArryLst = ArryLst[0];
                var ddlDepartment = $('#ddlDepartment');


                ddlDepartment.empty();


                $('#ddlDepartment').append($('<option></option>').val(0).html(langData.ddl_select));

                $.each(ddlDepartmentArryLst, function(index, Item) {
                    $('#ddlDepartment').append('<option value="' + Item.DeptID + '">' + Item.DeptName + '</option>');

                    //                        $("#ddlDepartment option:selected").val(Item.DeptID + Item.DeptName);
                });


            }

        },
        failure: function(msg) {
            alert(msg);
        }
    });
}
function SavePNC() {


    OrgId = $("#hdnOrgID").val();
    var ProcessDate = ($("#txtDate").val().length > 1) ? dateformat($("#txtDate").val(), 'MM/DD/YYYY') : '';
    var Description = ($("#txtPNCDescrip").val().length > 1) ? $("#txtPNCDescrip").val() : '';
    var Deparment = ($("#ddlDepartment option:selected").val() > 0) ? $("#ddlDepartment option:selected").val() : 0;
    var PNCNO =$("#txtNPCNO").val();
    if(PNCNO == '')
    {PNCNO=0;}
    var Res_Person = ($("#hdnRespPerson").val() > 0) ? $("#hdnRespPerson").val() : 0;
    var Classify = ($("#ddlClassify  option:selected").val() > 0) ? $("#ddlClassify  option:selected").val() : 0;
    var RCA = ($("#txtRCA").val().length > 1) ? $("#txtRCA").val() : '';
    var correction = ($("#txtCorrection").val().length > 1) ? $("#txtCorrection").val() : '';
    var CorrectiveAction = ($('#txtCorrectiveAction').val().length > 1) ? $('#txtCorrectiveAction').val() : '';
    var PreventiveAction = ($('#txtPAProposed').val().length > 1) ? $('#txtPAProposed').val() : '';
    var CompletionDate = ($('#txtCompDate').val().length > 1) ? dateformat($('#txtCompDate').val(), 'YYYY/MM/DD') : '01-01-1990';  //);
    var actionTaken = ($('#txtAction').val().length > 1) ? $('#txtAction').val() : '';
    var comments = ($('#txtComments').val().length > 1) ? $('#txtComments').val() : ''; 
    var Status = ($("#ddlStatus option:selected").val() != 0) ? $("#ddlStatus option:selected").val() : 0;


    var Object = {}; ;

    Object.ProcessNonConfNo = PNCNO;
    Object.DeptID = Deparment;
    Object.ProcessDate = ProcessDate;
    Object.Description = Description;
    Object.ResponsiblePerson = Res_Person;
    Object.NCClassification = Classify;
    Object.RootCause = RCA;
    Object.Correction = correction;
    Object.Correctiveaction = CorrectiveAction;
    Object.PreventiveAction = PreventiveAction;
    Object.ProposedCompletionDate = CompletionDate;
    Object.ActionTaken = actionTaken;
    Object.Comments= comments;
    Object.Status = Status;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/PNCSave",
        data: JSON.stringify({ orgID: OrgId, PNC: Object }),




        // data: obj,
        dataType: "json",
        async: false,

        success: function(data) {
        alert(langData.alert_save);
            LoadPNCDetails();
            // clearFields();

            clear();
        },
        error: function(xhr, status, error) {
            alert(error);
            return false;
        }
    });
    return false;
}



function LoadPNCDetails() {
    var OrgId = $("#hdnOrgID").val();
    $('#pnlPNCDetails').show();
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/GetPNCList",
        data: JSON.stringify({ orgID: OrgId }),
        dataType: "JSON",
        async: false,
        success: function(data) {

            var PNCList = data.d[0];
            if (PNCList.length > 0 && PNCList != "[]") {



                var parseJSONResult = PNCList;
                $('#pnlPNCDetails').show();

                $('#tblPNCDetails  tbody > tr').remove();
                $('#tblPNCDetails').show();
                $('#tblPNCDetails').dataTable({
                    paging: true,
                    "iDisplayLength": 5,
                    "language": {
                        "url": dataTablePath
                    },
                    "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                    data: parseJSONResult,

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
                                            { 'data': 'ProcessNonConfNo'
                                            }

                                            ,
                                             { 'data': 'DeptName'
                                             }
                                            ,
                                             { 'data': 'Pdate',
                                                 'mRender': function(data) {
                                                     var formatdate = moment(data, "MM/DD/YYYY").format("DD/MM/YYYY");
                                                     //return date_string;
                                                     return formatdate;
                                                 }

                                             }
                                            ,
                                             { 'data': 'Description'
                                             }
                                            ,

                                             { 'data': 'NCClassification',

                                                 "sClass": "hide_Column"
                                             }
                                               ,
                                                 { 'data': 'RootCause',

                                                     "sClass": "hide_Column"
                                                 }

                                            ,
                                             { 'data': 'Correction',

                                                 "sClass": "hide_Column"
                                             }


                                            ,
                                             { 'data': 'Correctiveaction',

                                                 "sClass": "hide_Column"
                                             }


                                            ,
                                             { 'data': 'PreventiveAction',

                                                 "sClass": "hide_Column"
                                             }
                                             ,

                                             { 'data': 'PCompDate',
                                                 'mRender': function(date) {
                                                     if (date != null) {
                                                         var formatdate = moment(date, "MM/DD/YYYY").format("DD/MM/YYYY");
                                                         //return date_string;
                                                         return formatdate;
                                                     }
                                                     else {
                                                         return "";
                                                     }
                                                 }
                                             }
                                              ,


                                             { 'data': 'Comments' }
                                            ,
                                             { 'data': 'CreatedBy'
                                             },
                                             { 'data': 'RepPersonName'
                                             }
                                            ,
                                             { 'data': 'ActionTaken'
                                             }
                                             ,
                                            { 'data': 'Status',
                                                "mRender": function(data) {
                                                    if (data == "0") {
                                                        return '';
                                                    }
                                                    else {
                                                        return data;
                                                    }
                                                }
                                            }
                                            ,
                                            {

                                                "mRender": function(data, type, full) {
                                                    return '<input type=button class="btn btn-info btn-sm"  onclick=Edit_OnClick($(this).attr("id1")) id=Edit' + full.ProcessNonConfNo + '  value= "' + langData.Edit + '"   ID1=' + full.ProcessNonConfNo + ' >';
                                                }
                                            }

                                            ,
                                            {

                                                "mRender": function(data, type, full) {
                                                    return '<input type=button class="btn btn-danger btn-sm" onclick=btnDelete_OnClick($(this).attr("id1")) id=Delete' + full.ProcessNonConfNo + '  value="' + langData.Delete + '" ID1=' + full.ProcessNonConfNo + ' >';

                                                }
                                            }




                                         ]

                });

                //   jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

                // $('#DeviceList').addClass('show');
                //$('#SaveBtnDiv').show();
            }
            else {
                $('#pnlPNCDetails').hide();

                //alert('No matching record found!');
                $('#SaveBtnDiv').hide();

            }


        },
        error: function(xhr, status, error) {
            alert(xhr);
        }
    });



}


function Edit_OnClick(ID) {

    var oTable = $("#tblPNCDetails").DataTable();
    var rowCount = $('#tblPNCDetails tr').length;
    var indexes = oTable.rows().eq(0).filter(function(rowIdx) {
        if (oTable.cell(rowIdx, 0).data() == ID) {
            var aData = oTable.rows(rowIdx).data();

            if (aData[0].Pdate != null) {
                 var txtdate = moment(aData[0].Pdate, "MM/DD/YYYY").format("DD/MM/YYYY");
            $("#txtDate").val(txtdate)
            }
          
            $("#txtPNCDescrip").val(aData[0].Description);
            $("#txtNPCNO").val(aData[0].ProcessNonConfNo);
            $("#txtPerson").val(aData[0].RepPersonName);
            $("#hdnRespPerson").val(aData[0].ResponsiblePerson);
            $("#ddlClassify").val(aData[0].NCClassification);

            $("#ddlDepartment").val(aData[0].DeptID);
            $("#txtRCA").val(aData[0].RootCause);
            $("#txtCorrection").val(aData[0].Correction);
            $('#txtCorrectiveAction').val(aData[0].Correctiveaction);
            $('#txtPAProposed').val(aData[0].PreventiveAction);
            if (aData[0].PCompDate != null) {
              var txtCompDate = moment(aData[0].PCompDate, "MM/DD/YYYY").format("DD/MM/YYYY");
            $('#txtCompDate').val(txtCompDate); 
            }
            
            
            $('#txtAction').val(aData[0].ActionTaken);
            $('#txtComments').val(aData[0].Comments);
            var sts = aData[0].Status;
            if (sts == "Closed") {
                $("#ddlStatus").val($("#ddlStatus option:eq(2)").val());
            } else {
                $('#ddlStatus').val(sts);
            }








            //            $("#ddlCountry option").each(function() {
            //                if ($(this).val() == CountryID) {
            //                    $(this).attr('selected', 'selected');
            //                    $(this).trigger("change");
            //                }
            //            });

        }
    });
}

function DeleteConfirm() {
    var objConfirm = langData.delete_confirm;
    if (confirm(objConfirm)) {
        return true;
    }
    return;
}

function btnDelete_OnClick(ID) {


    OrgId = $("#hdnOrgID").val();
    
    var Object = {}; ;

    if (DeleteConfirm())
   {
    Object.ProcessNonConfNo = ID;
    Object.DeptID = 0;
    Object.ProcessDate = new Date();
    Object.Description = '';
    Object.ResponsiblePerson = 0;
    Object.NCClassification = '';
    Object.RootCause = '';
    Object.Correction = '';
    Object.Correctiveaction = '';
    Object.PreventiveAction = '';
    Object.ProposedCompletionDate = new Date();
    Object.ActionTaken = '';
    Object.Comments = '';
    Object.Status = 'Delete';
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/PNCSave",
        data: JSON.stringify({ orgID: OrgId, PNC: Object }),
        dataType: "json",
        async: false,
        success: function(data) {
        alert(langData.alert_delete);
            clear();
            LoadPNCDetails()
            return false;
        },
        error: function(xhr, status, error) {
            alert(error);
            return false;
        }
    });
    return false;
    }
}

function clear() {
    $("#txtDate").val('');
    $("#txtPNCDescrip").val('');
    $("#txtNPCNO").val('');
    $("#txtPerson").val('');
    $("#hdnRespPerson").val('');
    $("#ddlDepartment").val(0);
    $("#txtRCA").val('');
    $("#txtCorrection").val('');
    $('#txtCorrectiveAction').val('');
    $('#txtPAProposed').val('');
    $('#txtCompDate').val('');
    $('#txtAction').val('');
    $('#txtComments').val('');
      $('#ddlStatus').val($('#ddlClassify option:first').val());
    $('#ddlClassify').val($('#ddlClassify option:first').val());
    
    
  

}