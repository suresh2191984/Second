$(document).ready(function() {
    ddlDevice();
    GetAnalyzerMappingDetails();
    //Searchtext();
    var arr = [];
    var test;
    var TTable = null;
    $('#FrequencyDay').multiselect();

    $('#ddlFrequencyTime').multiselect();
    $('#btnEdit').click(function() {
        var DeviceName;
        var InstrumentID;
        var DeviceCode;
        var Model;
        var Manufacturer;
        var AssayCode;
        var Analyte;
        var InvestigationID;
        var QCRequired;
        var FrequencyDay;
        var FrequencyTime;
        var Testcode;
        var Table;
        var DeviceMappingId;
        var array = [];
        InstrumentID = $('#ddlDeviceName option:selected').val();
        DeviceName = $('#ddlDeviceName option:selected').text();
        DeviceCode = $('#txtDeviceCode').val();
        Model = $('#txtModel').val();
        Manufacturer = $('#txtManufacturer').val();
        Analyte = $('#AnalyteName').val();
        Testcode = $('#TxtTestcode').val();
        InvestigationID = $('#hdnInvestigationID').val();
        QCRequired = $('#QCRequired option:selected').val();
        // FrequencyDay = $('#FrequencyDay').val();
        // FrequencyTime = $('#ddlFrequencyTime').val();
        FrequencyDay = ($('#FrequencyDay').val() != null) ? $('#FrequencyDay').val() : '';  
        FrequencyTime = ($('#ddlFrequencyTime').val() != null) ? $('#ddlFrequencyTime').val() : '';
        DeviceMappingId = $("#hdnDeviceMappingId").val();
        var FinalFrequencyDay = FrequencyDay.toString();
        var FinalFrequencyTime = FrequencyTime.toString();
        if (InstrumentID == "0") 
        {
            alert(langData.alert_instrumentselect);
            return false;
        }
        else if (Analyte == "") {
            alert(langData.alert_analyte);
            return false;
        }
        else if (Testcode == "") {
            alert(langData.alert_assaycode);
            return false;
        }

        else if ($("#hdnInvestigationID").val() == "") {
            alert(langData.alert_valid_analyte);
            return false;
        }
        array.push({
            Analyte: "",
            AssayCode: Testcode,
            DeviceName: DeviceName,
            DeviceCode: DeviceCode,
            FrequencyDay: FinalFrequencyDay,
            FrequencyTime: FinalFrequencyTime,
            InstrumentID: InstrumentID,
            InvestigationID: InvestigationID,
            QCRequired: QCRequired

        });
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/QMS_UpdateAnalyzermappingDetails",
            data: JSON.stringify({ QCAnalyzerMapping: array, DeviceMappingId: DeviceMappingId, Extras: "" }),
            dataType: "JSON",
            async: false,
            success: function(data) {
                var Result = data.d;
                if (Result > 0) {
                    //                $('#TblDeviceMapping').hide();
                    //                $('#TblDeviceMapping_wrapper').hide();
                    $('#btnEdit').hide();

                    $("#btnAdd").show();
                    GetAnalyzerMappingDetails();
                    clear();
                    alert(langData.alert_done);
                }
            },
            error: function(xhr, status, error) {
                alert(xhr);
            }


        });

    });

    $("#btnClear").click(function() {
        clear();
        ddlDevice();
        $("#btnAdd").show();
        var row = arr.length;

        if (row == 0) {
            $("#btnSave").hide();
        }


        $("#btnEdit").hide();
    });

    $('#btnSave').click(function() {
        var array = [];
        var headers = [];
        var colCount=0;
        $('#TblDeviceMapping th').each(function(index, item) {
        if(index != 10 && index != 11 && index != 12)
            {
            headers[colCount] = $(item).attr('data').split(" ").join("");
             colCount++;
            }
        });
        $('#TblDeviceMapping tr').has('td').each(function() {
            var arrayItem = {};
            $('td', $(this)).each(function(index, item) {
            if(index==10)
            {
            arrayItem[headers[4]] = $(item).html();
            }
            else if(index==11)
            {
            arrayItem[headers[5]] = $(item).html();
            }
             else if(index==12)
             {
            arrayItem[headers[6]] = $(item).html();
            }
            
            else{
                arrayItem[headers[index]] = $(item).html();
                }
            });
            array.push(arrayItem);
        });
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/QMS_SaveAnalyzermappingDetails",
            data: JSON.stringify({ QCAnalyzerMapping: array }),
            dataType: "JSON",
            async: false,
            success: function(data) {
                var Result = data.d;
                if (Result > 0) {
                    var table = $('#TblDeviceMapping').DataTable();
                    table.rows().remove();
                    $("#TblDeviceMapping tbody tr").remove();
                    $("#TblDeviceMapping_wrapper").hide();
                    arr = [];
                    //                $('#TblDeviceMapping').hide();
                    //                $('#TblDeviceMapping_wrapper').hide();
                    //$('#TblDeviceMapping  tbody > tr').remove().draw();
                    GetAnalyzerMappingDetails();
                    clear();
                    ddlDevice();

                    $('#btnSave').hide();
                    alert(langData.alert_done);
                }
            },
            error: function(xhr, status, error) {
                alert(xhr);
            }


        });

    });

    $('#btnAdd').click(function() {
        var DeviceName;
        var InstrumentID;
        var DeviceCode;
        var Model;
        var Manufacturer;
        var AssayCode;
        var Analyte;
        var InvestigationID;
        var QCRequired;
        var FrequencyDay;
        var FrequencyTime;
        var Testcode;

        InstrumentID = $('#ddlDeviceName option:selected').val();
        Analyte = $('#AnalyteName').val();
        Testcode = $('#TxtTestcode').val();
        DeviceCode = $('#txtDeviceCode').val();
        var tInvID;
        var tInstruId;
        var isAvail = true;
        if (TTable != null) {
            debugger;
            $(TTable.fnGetNodes()).has('td').each(function() {
                $('td', $(this)).each(function(index, item) {

                    if (index == 0) {
                        tInstruId = $(item).html();
                        //                        alert($(item).html());

                    }
                    if (index == 7) {
                        tInvID = $(item).html();
                        //                        alert($(item).html());
                        if (tInvID == $("#hdnInvestigationID").val() && InstrumentID == tInstruId) {
                            isAvail = false;
                        }
                    }
                });
            });
        }
        if (InstrumentID == "0") {
         alert(langData.alert_instrumentselect);
            return false;
        }
        else if (Analyte == "") {
           alert(langData.alert_analyte);
            return false;
        }
        else if (Testcode == "") {
           alert(langData.alert_assaycode);
            return false;
        }
        else if (!isAvail) {
            alert(langData.alert_analytealready);
            return false;
        }
        else if ($("#hdnInvestigationID").val() == "") {
            alert(langData.alert_valid_analyte);
            return false;
        }
        DeviceName = $('#ddlDeviceName option:selected').text();

        Model = $('#txtModel').val();
        Manufacturer = $('#txtManufacturer').val();
        InvestigationID = $('#hdnInvestigationID').val();
        QCRequired = $('#QCRequired option:selected').val();
      var QCRequiredText = $('#QCRequired option:selected').text();
     var FrequencyDayText   ="";
     var FrequencyTimeText="";
     var intcount=0;
     
        $("#FrequencyDay option:selected").each(function () {
     
             var $this = $(this);
      
            if(intcount==0)
            {
             FrequencyDayText  = FrequencyDayText+$this.text();
             }
             else
             {FrequencyDayText +=','+ $this.text();
               }
          intcount++;
          
                });
intcount=0;
   $("#ddlFrequencyTime option:selected").each(function () {
     
             var $this = $(this);
      
            if(intcount==0)
            {
             FrequencyTimeText  = FrequencyTimeText+$this.text();
             }
             else
             {FrequencyTimeText +=','+ $this.text();
               }
          intcount++;
          
                });
        FrequencyDay = $('#FrequencyDay').val();
        FrequencyTime = $('#ddlFrequencyTime').val();
        arr.push(
        {
            InstrumentID: InstrumentID,
            DeviceName: DeviceName,
            Testcode: Testcode,
            Analyte: Analyte,
            QCRequired: QCRequired,
            FrequencyDay: FrequencyDay,
            FrequencyTime: FrequencyTime,
            InvestigationID: InvestigationID,
            DeviceCode: DeviceCode,
            QCRequiredText:QCRequiredText,
            FrequencyDayText:FrequencyDayText,
            FrequencyTimeText:FrequencyTimeText
        });
        $('#TblDeviceMapping_wrapper').show();
        $('#TblDeviceMapping').show();
        TTable = $('#TblDeviceMapping').dataTable({
            paging: false,
             "language": {
                                 "url": dataTablePath
                                  },
            data: arr,
            "bDestroy": true,
            "fnDrawCallback": function() {
                $('.deleteIcons').click(function() {
                    var id = this.id;
                    var row = $(this).closest("tr").get(0);
                    TTable.fnDeleteRow(TTable.fnGetPosition(row));
                    arr = $.grep(arr, function(ind, val) {
                        return ind.Testcode != id;

                    });
                })
            },
            columns: [
                                            { 'data': 'InstrumentID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'DeviceName' },
                                             { 'data': 'Testcode' },
                                            {
                                                'data': 'Analyte'
                                            },
                                            {
                                                'data': 'QCRequiredText',
                                                 "mRender": function(data, type, full, meta) {
                                                  return  full.QCRequiredText;
                                                }
                                            },
                                            {
                                                'data': 'FrequencyDayText',
                                                 "mRender": function(data, type, full, meta) {
                                                  return  full.FrequencyDayText;
                                                }
                                            },

                                            { 'data': 'FrequencyTimeText',
                                              "mRender": function(data, type, full, meta) {
                                                  return  full.FrequencyTimeText;
                                                }
                                             },
                                            { 'data': 'InvestigationID',
                                                "sClass": "hide_Column"
                                            },
                                            {
                                                'data': 'DeviceCode',
                                                "sClass": "hide_Column"
                                            },

                                            {
                                                "defaultcontent": 'apple',
                                                "ordering": true,
                                                "mRender": function(data, type, full, meta) {

                                                return '<input id= "' + Testcode + '" type="button" class="deleteIcons"  value ="' + langData.Delete +'" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >'
                                                '<input id= "' + Testcode + '" type="button" class="deleteIcons" value ="'+langData.Delete +'" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >'
                                                }
                                            },
                                            {
                                                'data': 'QCRequired',
                                                "sClass": "hide_Column"
                                            },
                                             {
                                                'data': 'FrequencyDay',
                                                "sClass": "hide_Column"
                                            },
                                              {
                                                'data': 'FrequencyTime',
                                                "sClass": "hide_Column"
                                            }
                                             ]
        });

        $('#btnSave').show();
        //            $('#txtDeviceCode').val("");
        //            $('#ddlDeviceName').val($("#ddlDeviceName option:first").val());
        //            $('#QCRequired').val($("#QCRequired option:first").val());
        //            $('#txtModel').val("");
        $('#AnalyteName').val("");
        $('#TxtTestcode').val("");
        $("#QCRequired").val("NO");
        //            $('#txtManufacturer').val("");
        $("#FrequencyDay").multiselect('destroy');
        for (var i = 0; i <= $("#FrequencyDay option").length - 1; i++) {
            if ($("#FrequencyDay option")[i].selected == true) {
                $("#FrequencyDay option")[i].selected = false;
                //break;
            }
        }
        $("#FrequencyDay").multiselect();
        $("#ddlFrequencyTime").multiselect('destroy');
        for (var i = 0; i <= $("#ddlFrequencyTime option").length - 1; i++) {
            if ($("#ddlFrequencyTime option")[i].selected == true) {
                $("#ddlFrequencyTime option")[i].selected = false;

            }
        }
        $("#ddlFrequencyTime").multiselect();
        $('#Check_Testcode i').addClass('fa fa-question');
    });



    // });

    $('#ddlDeviceName').change(function() {
        var Deviceval;
        Deviceval = $('#ddlDeviceName option:selected').val();
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/QMS_DeviceDetails",
            data: JSON.stringify({ InstrumentID: Deviceval }),
            dataType: "JSON",
            async: false,
            success: function(data) {

            if (data.d.length>0)
            {
                var Result = data.d;
                $('#txtDeviceCode').val(Result[0].ProductCode);
                $('#txtModel').val(Result[0].Model);
                $('#txtManufacturer').val(Result[0].Manufacturer);
                $('#txtDeviceCode').prop("disabled", true);
                $('#txtModel').prop("disabled", true);
                $('#txtManufacturer').prop("disabled", true);
                
             }
                
            },
            error: function(xhr, status, error) {
                alert(xhr);
            }
        });

    });

});
$(function() {
    // var Orgid = document.getElementById("hdnOrgID").value;
    //var count = 0;
var Status = 'AnalyteName~0';

    $("#AnalyteName").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../QMS.asmx/QMS_LoadAnalyte',
                data: JSON.stringify({ Status: Status, prefixText: request.term }),
                dataType: "json",
                success: function(data) {
                if (data.d.length > 0) {
                    response($.map(data.d, function(item) {
                            var rsltvalue = item.InvestigationID;
                            var rsltlable = item.DisplayText;
                            var rslttcode = item.TestCode;
			    $('#TxtTestcode').val('');
                    $('#TxtTestcode').prop("disabled", false);
                        return {
                                label: rsltlable,
                                val: rsltvalue,
                                test: rslttcode
                        }
                    }))
                }
                else {
                    response([{ label: langData.result_notfound, val: -1}]);
                   // Clear();
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
            if (i.item.val == -1) {
                $("#hdnInvestigationID").val("");
            }
            else {
                $("#hdnInvestigationID").val(i.item.val);
                if (i.item.test != '' && i.item.test != undefined) {
                    $('#TxtTestcode').val(i.item.test);
                    $('#TxtTestcode').prop("disabled", true);

                }
                else { $('#TxtTestcode').val('') }
            }
        },
        minLength: 2
    });
});
////////// Check Assay Code  END ////////////////////////////

$('#TxtTestcode').keyup(function(e) {


var DeviceID = $('#ddlDeviceName option:selected').val();

var Testcode = $('#TxtTestcode').val();
var oVal = $('#TxtTestcode').attr('OVal');

    if (DeviceID == 0) {
        $('#Check_Testcode').removeClass('btn-danger');
        $('#Check_Testcode').addClass('btn-success');
        $('#Check_Testcode i').removeClass('fa fa-check');
        $('#Check_Testcode i').addClass('fa fa-question');
        $("#btnAdd").addClass('disabled');
    }
    else if (e.keyCode == 32) {
        e.preventDefault();
    }
    else {
        if (DeviceID != 0) {

            if ($('#btnEdit').is(':visible')) {

                if (Testcode == oVal) {
                    $('#Check_Testcode i').removeClass('fa fa-question');
                    $('#Check_Testcode i').removeClass('fa fa-times');
                    $('#Check_Testcode i').removeClass('NotOk');
                    $('#Check_Testcode i').addClass('fa fa-check');
                    $('#Check_Testcode i').addClass('Ok');
                    $('#Check_Testcode').removeClass('btn-danger');
                    $('#Check_Testcode').addClass('btn-success');
                    $('#Check_Testcode').attr('error', 'N');
                }
//                else {
//                    var ObjClientDevice = {};
//                    ObjClientDevice["DeviceID"] = 'AssayCode~'+ DeviceID;
//                    ObjClientDevice["Testcode"] = Testcode;
//                    var returnCode = CheckDeviceID(ObjClientDevice, "../QMS.asmx/CheckTestCode");
//                }
            
            else {
                var ObjClientDevice = {};
                ObjClientDevice["DeviceID"] = 'AssayCode~'+DeviceID;
                ObjClientDevice["Testcode"] = Testcode;
                var returnCode = CheckDeviceID(ObjClientDevice, "../QMS.asmx/CheckTextCode");

            }
        }

        }
        else {
            $('#TxtTestcode').val('');
        }

    }
});

function CheckDeviceID(ObjClient, URL) {
    var returnCode = true;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        async: false,
        data: JSON.stringify(ObjClient),
        dataType: "json",
        success: function(data) {//On Successfull service call

            if (data.d == 'N') {

                $('#Check_Testcode i').removeClass('fa fa-question');
                $('#Check_Testcode i').removeClass('fa fa-check');
                $('#Check_Testcode i').removeClass('Ok');
                $('#Check_Testcode i').addClass('fa fa-times');
                $('#Check_Testcode i').addClass('NotOk');
                $('#Check_Testcode').removeClass('btn-success');
                $('#Check_Testcode').addClass('btn-danger');
                $('#Check_Testcode').attr('error', 'Y');
                $("#btnAdd").addClass('disabled');
                $("#btnEdit").addClass('disabled');
                
                returnCode = false;
            }
            else if (data.d == 'Y') {
            $('#Check_Testcode i').removeClass('fa fa-question');
            $('#Check_Testcode i').removeClass('fa fa-times');
            $('#Check_Testcode i').removeClass('NotOk');
            $('#Check_Testcode i').addClass('fa fa-check');
            $('#Check_Testcode i').addClass('Ok');
            $('#Check_Testcode').removeClass('btn-danger');
            $('#Check_Testcode').addClass('btn-success');
            $('#Check_Testcode').attr('error', 'N');
            $("#btnAdd").removeClass('disabled');
            $("#btnEdit").removeClass('disabled');
                returnCode = true;
            }


            //  alert(data.GetDDlDataResult[0].StateName);
        },
        error: function(result) {
            alert("Error");
        } // When Service call fails
    });
    return returnCode;
}

////////// Check Assay Code  END ////////////////////////////
function ddlDevice() {
    var obj = {};
    var Status = "Device~0"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/QMS_LoadDevices",
        data: JSON.stringify({ Status: Status }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            if (data.d.length >= 0) {
                var ArryLst = data.d;
                $("#ddlDeviceName").empty();
                $("#ddlDeviceName").append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ArryLst, function(ind, val) {
                    $('#ddlDeviceName').append('<option value="' + val.InstrumentID + '">' + val.InstrumentName + '</option>');
                    //$('#ddlDeviceName').append('option value="'+val.InstrumentID+'">'+val.InstrumentName+'</option>');
                });

            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}
    function clear() {
        $('#txtDeviceCode').val("");
      $('#ddlDeviceName').val($("#ddlDeviceName option:first").val());
      $("#QCRequired").val("NO");
      $('#txtModel').val("");
      $('#AnalyteName').val("");
      $('#TxtTestcode').val("");
      $('#txtManufacturer').val("");
      $("#FrequencyDay").multiselect('destroy');
      for (var i = 0; i <= $("#FrequencyDay option").length - 1; i++) {
          if ($("#FrequencyDay option")[i].selected == true) {
              $("#FrequencyDay option")[i].selected = false;
              //break;
          }
      }
       $("#FrequencyDay").multiselect();
       
       $("#ddlFrequencyTime").multiselect('destroy');
       for (var i = 0; i <= $("#ddlFrequencyTime option").length - 1; i++) {
           if ($("#ddlFrequencyTime option")[i].selected == true) {
               $("#ddlFrequencyTime option")[i].selected = false;
              
           }
       }
       $("#ddlFrequencyTime").multiselect();
   }
 
function GetAnalyzerMappingDetails()    
{
 var obj = {};
  var Activestatus = {};
    //var Status = "Device"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/LoadAnalyzerMappingDetails",
        data: JSON.stringify(obj),
        dataType: "JSON",
        async: false,
        success: function(data) {
                    var Items = data.d;
                    var dtDayWCR = Items;
                    if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                        var parseJSONResult = JSON.parse(dtDayWCR);
                        $('#DeviceList').show();
                        $('#tblAnalyzermappingDetails  tbody > tr').remove();
                        $('#tblAnalyzermappingDetails').show();
                        $('#tblAnalyzermappingDetails').dataTable({
                            paging: true,
                             "language": {
                                 "url": dataTablePath
                                  },
                            data: parseJSONResult,
                                "fnDrawCallback": function () {
                                $('.rgr').bootstrapToggle();
                                $('.rgr').change(function () {
                                    $('.rgr').bootstrapToggle();
                                   
                                    //alert('Toggle: ' + $(this).prop('checked') + this.id)
                                  
                                    if ($(this).prop('checked') == true) 
                                    {
                                        var arr=[];
                                        var TestID=this.id;
                                        arr=TestID.split(",");
                                        Activestatus.Active = 'Y';
                                        Activestatus.DeviceID = arr[1];
                                        Activestatus.Testcode=arr[0];
                                        Activeuser(Activestatus);
                                    }
                                    else 
                                    {
                                                var arr=[];
                                                var TestID=this.id;
                                                arr=TestID.split(",");
                                                Activestatus.Active = 'N';
                                                Activestatus.DeviceID = arr[1];
                                                Activestatus.Testcode=arr[0];
                                                Activeuser(Activestatus);
                                    }
                                    

                                })
                            },
                            "bDestroy": true,
                            "searchable": true,
                            "sort": true,
                            dom: 'Bfrtip',
                            buttons: [
            {
                extend: 'copyHtml5',
                exportOptions: {
                columns: [1, 2, 7, 8, 9, 10]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                columns: [1, 2, 7, 8, 9, 10]
                }
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: [1, 2, 7, 8, 9, 10]
                }
            }
        ],
                            columns: [
                                            { 'data': 'InstrumentID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'InstrumentName' },
                                             { 'data': 'TestCode' },
                                            {
                                            'data':'DeviceID',
                                            "sClass":"hide_Column"
                                            },
                                            {
                                            'data':'Model',
                                            "sClass":"hide_Column"
                                            },
                                            {
                                            'data':'Manufacturer',
                                            "sClass":"hide_Column"
                                            },
                                           
                                            { 'data': 'InvestigationID',
                                                "sClass": "hide_Column" },
                                            { 'data': 'DisplayText' },
                                            { 'data': 'QCRequiredText' },
                                            {'data': 'Frequencyday'},
                                            { 'data': 'FrequencyTime' },
                                            {'data':'Edit',
                                            "mRender": function (data, type, full, meta) {
                                            return '<input value = "'+langData.Edit+'" '+full.Edit+' class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                            }
                                            },
                                            { 'data': 'Delete', "sClass": "hide_Column" },
                                            {'data':'IsActive',
                                            "ordering": true,
                                    "mRender": function (data, type, full, meta) {

                                        if (full.IsActive == 'Y') {

                                            // your code as is
                                            return '<input id= "' + full.TestCode + "," + full.DeviceID + '" type="checkbox" class="rgr" data-on="' + langData.Active + '" data-width="70" checked data-onstyle="success" data-offstyle="danger" data-off="' + langData.InActive + '" name="chk" disabled="true">';

                                        }
                                        else {
                                            return '<input id= "' + full.TestCode + "," + full.DeviceID + '" type="checkbox" class="rgr" data-on="' + langData.Active + '" data-width="70" unchecked data-onstyle="success" data-offstyle="danger" data-off="' + langData.InActive + '" name="chk" disabled="true" >';

                                        }

                                    }
                                            
                                                        },
                                                        { 'data': 'QCRequired',
                                                        "sClass": "hide_Column"  }

]

                        });

                        jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

                        $('#DeviceList').addClass('show');
                    }
                    else {
                        $('#tblDeviceDetails').hide();
                        $('#DeviceList').hide();
                        $("#btnSave").hide();
                        //alert('No matching record found!');

                    }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}

function Edit_OnClick(values) {
    debugger;
    var RowData = values.split('~');
    $("#hdnDeviceMappingId").val(RowData[0]);
    var InstrumentID = RowData[1];
    var InstrumentName = RowData[2];
    var DeviceCode = RowData[3];
    var Model = RowData[4];
    var Manufacturer = RowData[5];
    var Testcode = RowData[6];
    var InvestigationID = RowData[7];
    var Analyte = RowData[8];
    var FrequencyDays = RowData[9];
    var Frequencytime = RowData[10];
    var QCRequired = RowData[11];
    $("#ddlDeviceName").val(InstrumentID);
    $("#TxtTestcode").attr('OVal', Testcode);
    var btn = 'update';
//    $("#ddlDeviceName option").each(function() {
//    if ($(this).text() == InstrumentName) {
//                            $(this).attr('selected', 'selected');
//                        }
//                    });
                    $("#txtDeviceCode").val(DeviceCode);
                    $("#txtModel").val(Model);
                    $("#txtManufacturer").val(Manufacturer);
                    $("#AnalyteName").val(Analyte);
                    $("#TxtTestcode").val(Testcode);
					 $("#QCRequired").val(QCRequired);
                    $("#hdnInvestigationID").val(InvestigationID);
                    var selectedOptions = [];
                    selectedOptions = FrequencyDays.split(",");
                    var arr = [];

                    $("#FrequencyDay option").removeAttr('selected');
                    $.each(selectedOptions, function(key, value) {
                    //arr=$("#FrequencyDay").next().find('input');

                    $("#FrequencyDay").multiselect('destroy');
                    //arr = $('.multiselect-container li a label').find("input");
                    for (var i = 0; i <= $("#FrequencyDay option").length - 1; i++) {
                    if ($("#FrequencyDay option")[i].value == value) {
                        $("#FrequencyDay option")[i].selected = true;
                        break;
                        }
                    }
                    $("#FrequencyDay").multiselect();
                });

                var selectedDays = [];
                selectedDays = Frequencytime.split(",");
                $("#ddlFrequencyTime option").removeAttr('selected');
                $.each(selectedDays, function(key, value) {
                //arr=$("#FrequencyDay").next().find('input');

                $("#ddlFrequencyTime").multiselect('destroy');
                //arr = $('.multiselect-container li a label').find("input");
                for (var i = 0; i <= $("#ddlFrequencyTime option").length - 1; i++) {
                if ($("#ddlFrequencyTime option")[i].value == value) {
                $("#ddlFrequencyTime option")[i].selected = true;
                break;
                }
                }
                $("#ddlFrequencyTime").multiselect();
                });

            
    $('#btnEdit').show();
    $("#btnSave").hide();
    $("#btnAdd").hide();
}
function Delete_OnClick(DeviceID,Testcode)
{
 var Activationstatus="N";
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/QMS_DeleteAnalyzermappingDetails",
        data: JSON.stringify({ DeviceID: DeviceID ,TestCode:Testcode,Activationstatus:Activationstatus}),
        dataType: "JSON",
        async: false,
        success: function(data) {
        GetAnalyzerMappingDetails();
            alert(langData.alert_delete);
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}

 function Activeuser(Activestatus)
        {
            var obj = {};
            obj.Activationstatus = Activestatus.Active;
            obj.DeviceID= Activestatus.DeviceID;
            obj.TestCode = Activestatus.Testcode;

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../QMS.asmx/QMS_DeleteAnalyzermappingDetails",
                data: JSON.stringify(obj),
                dataType: "json",
                success: function (data) {
                    if (data.d > 0)
                    {

                        GetAnalyzerMappingDetails();
                        if (obj.Activationstatus == 'N') {
                            alert(langData.alert_deactivate);
                        }
                        else {
                            alert(langData.alert_activate);
                        }
                        
                    }
                    

                },
                error: function(xhr, status, error) {
            alert(xhr);
        }



            });
        }
