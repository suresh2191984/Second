var oTable;
$(document).ready(function() {
   
    var now = new Date();
    $('#txtTime').timepicker({ 'timeFormat': 'H:i:s' });
    var day = ("0" + now.getDate()).slice(-2);
    var month = ("0" + (now.getMonth() + 1)).slice(-2);
    autoComplete();
    var today = now.getFullYear() + "-" + (month) + "-" + (day);
    $('input[type="time"][value="now"]').each(function() {
        var d = new Date(),
        h = d.getHours(),
        m = d.getMinutes();
        if (h < 10) h = '0' + h;
        if (m < 10) m = '0' + m;
        $(this).attr({
            'value': h + ':' + m
        });
    }); 
	//$('#txtDate').val(today);
    $("#ddlLotName").change(function() {
        if ($('#ddlLotName').val() == '-1') {
            $('#txtAnalyzers').attr("disabled", "disabled");

        }
        else {
            $('#txtAnalyzers').removeAttr("disabled");
        }

    });
    $('#TblDeviceMapping').hide();
   $('#SaveBtnDiv').hide();
    $('#FrequencyDay').multiselect();
    $('#ddlFrequencyTime').multiselect();
   $('#btnEdit').click(function(){
     // $('input[box="value"]').removeAttr('disabled');
      $(oTable.fnGetNodes()).has('td').each(function() {
         //var arrayItem = {};
       $('td', $(this)).each(function(index, item) {
            if (index==6)
       {
       $(item).find('input').removeAttr('disabled');
       }
       });
       });
   });

   $('#btnClear').click(function(){
      //$('input[box="value"]').val('');
       $(oTable.fnGetNodes()).has('td').each(function() {
         //var arrayItem = {};
       $('td', $(this)).each(function(index, item) {
            if (index==6)
       {
       $(item).find('input').val('');
       }
       });
       });
   });
   var insID='';
   var dateval='';
    var LotID = '';
    var LotName = '';
    $('#btnSave').click(function() {
        var array = [];
        var headers = [];
        var id = $('#hdnInstrumentID').val();
        headers[0] = 'InvestigationID'
        headers[1] = 'TestCode'
        headers[2] = 'InvestigationName'
        headers[3] = 'InstrumentID';
        headers[4] = 'QCValueID';
        headers[5] = 'QCLevel';
        headers[6] = 'OrgAddressID';
        headers[7] = 'Value1';
        headers[8] = 'Value2';
        headers[9] = 'Value3';
        headers[10] = 'Value4';
        headers[11] = 'ProcessedAt';
        headers[12] = 'IsUpdate';
        headers[13] = 'LotID';
        headers[14] = 'LotName';
        LotID = $('#ddlLotName option:selected').val();    
        LotName = $('#ddlLotName option:selected').text();
        Level = $('#ddlLevel option:selected').val();
        var update = true;
        //$('#TblDeviceMapping tr').has('td').each(function() {
        $(oTable.fnGetNodes()).has('td').each(function() {
            var arrayItem = {};
            $('td', $(this)).each(function(index, item) {

                if (index == 0) {
                    arrayItem[headers[0]] = $(item).html();
                }
                else if (index == 1) {
                    dateval = $(item).html();
                    arrayItem[headers[1]] = '';
                }
                else if (index == 2) {
                    var v = $(item).html();
                    //arrayItem[headers[2]] = '';
                    arrayItem[headers[11]] = dateformat(dateval, "YYYY-MM-DD") + ' ' + v + '.000';
                }
                else if (index == 3) {
                    arrayItem[headers[3]] = insID;

                }
                else if (index == 4) {
                arrayItem[headers[4]] = Level;
                    arrayItem[headers[5]] = $(item).html();
                }
                else if (index == 5) {

                    arrayItem[headers[2]] = $(item).html();
                }
                else if (index == 6) {
                    var newval = $(item).find('input').val();
                    arrayItem[headers[7]] = newval;
                    arrayItem[headers[6]] = 0;
                    arrayItem[headers[8]] = 0;
                    arrayItem[headers[9]] = 0;
                    arrayItem[headers[10]] = 0;
                    arrayItem[headers[13]] = parseInt(LotID);
                    arrayItem[headers[14]] = LotName;
                    var up = $(item).find('input').attr('IsUpdate');

                    arrayItem[headers[12]] = up
                    if (up == 'N' || newval == '' || newval == null)
                    { update = false; }
                    else
                    { update = true; }

                }
                else {
                    arrayItem[headers[index]] = $(item).html();
                }
            });
            //arrayItem[LotID]=
            if (update) {
                array.push(arrayItem);
            }
            update = true;

        });

        if (array.length > 0) {
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/QMS_SaveQcValues",
                data: JSON.stringify({ QCAnalyzerMapping: array }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    AddAnalyteforAnalyzer(insID)
                    alert(langData.alert_save);
                    // }
                },
       error: function(xhr, status, error) {
                alert(xhr);
            }
   
   
    });
    }
    else
    {
     $(oTable.fnGetNodes()).has('td').each(function() {
         //var arrayItem = {};
       $('td', $(this)).each(function(index, item) {
            if (index==6)
       {
       $(item).find('input').attr('disabled','disabled');
       }
       });
       });
       alert(langData.alert_save); 
     AddAnalyteforAnalyzer(insID);
    }
      
  });

    $('#btnAdd').click(function() {
        var id = $('#hdnInstrumentID').val();
        insID = id;
        var date = $('#txtDate').val();
        var time = $('#txtTime').val();
        var InstumentName = $('#txtAnalyzers').val();
        var vel = $('#ddlLevel option:selected').val();
        var LotName = $('#ddlLotName option:selected').val()
        if (date == "") {
            alert(langData.alert_pdate);
            return false;
        }
        else if (time == "") {
        alert(langData.alert_ptime);
            return false;
        }
        else if (LotName == "0") {
        alert(langData.alert_lotselect);
            return false;
        }
        else if (vel == '0') {
        alert(langData.alert_levelselect);
            return false;

        }
        else if (id == "") {

        alert(langData.alert_validanalyzer);
  
            return false;


        }
        else if(InstumentName=='') {
        alert(langData.alert_analyzerselect);

        
        $('#DeviceList').hide();
        $('.table-responsive').hide();
        $('#SaveBtnDiv').hide();
        $('#TblDeviceMapping').hide();

        $('#TblDeviceMapping  tbody > tr').remove();
        $('.table-responsive').hide();
            return false;
        }

        else {
            AddAnalyteforAnalyzer(id);
        }


    });



});
function autoComplete() {
    var Status = 'Analyte';
    $("#txtAnalyzers").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../QMS.asmx/QMS_AnalyzerAutoComplete',
                data: JSON.stringify({ Status: Status + '~' + $("#ddlLotName").val(), prefixText: request.term }),
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function(item) {
                            var rsltlable = item.InstrumentName;
                            var rsltvalue = item.InstrumentID;
                            return {
                                label: rsltlable,
                                val: rsltvalue
                            }
                        }))
                    }
                    else {
                        response([{ label: langData.result_notfound, val: -1}]);
                        
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
                $("#hdnInstrumentID").val("");
            }
            else {
                $("#hdnInstrumentID").val(i.item.val);
            }
        },
        minLength: 2
    });
}



function AddAnalyteforAnalyzer(id)
{

    var date=$('#txtDate').val(); 
    var time=$('#txtTime').val();
    var dtime = dateformat(date, "YYYY-MM-DD") + ' ' + time + '.000';
    var InstumentName=$('#txtAnalyzers').val();
    Level = $('#ddlLevel option:selected').val();
    var leveltext = $('#ddlLevel option:selected').text();
    LotID = $('#ddlLotName option:selected').val();
    LotName = $('#ddlLotName option:selected').text();
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/QMS_LoadAnalyteForAnalyzer",
        data: JSON.stringify({ InstrumentID: id, Time: dtime, Level: Level }),
        dataType: "JSON",
        async: false,
        success: function(data) {

            var dtDayWCR = data.d;
            if (dtDayWCR.length > 0 && dtDayWCR != "[]") {


                var parseJSONResult = dtDayWCR;
                $('#TblDeviceMapping').show();

                $('#TblDeviceMapping  tbody > tr').remove();
                $('.table-responsive').show();

                $('#TblDeviceMapping').show();
                oTable = $('#TblDeviceMapping').dataTable({
                    paging: true,
                    stateSave: true,
                    "language": {
                        "url": dataTablePath
                    },
                    "iDisplayLength": 5,
                    "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                    data: parseJSONResult,
//                            "sDom": '<"H"Tfr>t<"F"ip>',
//                            "oTableTools": {
//                                "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
//                                "aButtons": [
//                                                  "copy", "xls", //"pdf",
//                                                    {
//                                                        "sExtends": "collection",
//                                                        "sButtonText": "Save",
//                                                        "aButtons": ["csv", "xls"]//, "pdf"]
//                                                    }
//                                ]
//                            },
                    "fnDrawCallback": function() {

                        $('.capture').keyup(function() {

                            var i = 0;
                            var val = $(this).val();
                            var IsUpdate = $(this).attr('IsUpdate');
                            if (IsUpdate != 'I') {
                                var val1 = $(this).attr('data');
                                if (val != val1) {
                                    $(this).attr('IsUpdate', 'U');
                                }
                                else {

                                    $(this).attr('IsUpdate', 'N');
                                }
                            }
                        });
                        $('.capture').keypress(function(event) {


                            var txtVal = $(this).val();
                            var decLen = $(this).attr('decPlaces');
                            var decIdx = txtVal.indexOf('.');

                            if (txtVal.length < 15) {
                                if (decIdx != -1 && decLen != '') {
                                    var diff = (txtVal.length - 1)-decIdx;
                                    if (diff >= decLen) {
                                        event.preventDefault();
                                    }
                                }

                                if (event.which == 45) {

                                    if (txtVal.length == 1) {
                                        if (txtVal.indexOf('-') == -1) {
                                            event.preventDefault();
                                        }
                                    }
                                    if (txtVal.length > 1) {
                                        event.preventDefault();
                                    }
                                }
                                else {
//                                    if (txtVal.indexOf('-') >= 0) {
//                                        event.preventDefault();
//                                    }
//                                    else {
                                        if ((event.which != 46) && (event.which < 48 || event.which > 57)) {
                                            event.preventDefault();
                                        }
                                        else if ((txtVal == "" && event.which == 46) || (txtVal.indexOf('.') != -1 && event.which == 46)) {
                                            event.preventDefault();
                                        }
//                                    }
                                }
                            }
                            else {
                                event.preventDefault();
                            }
                        });


                    },

                    "bDestroy": true,
                    "searchable": true,
                    "sort": true,

                    columns: [
                                            { 'data': 'InvestigationID',
                                                "sClass": "hide_Column"

                                            },

                                                 {
                                                     "data": "office", // can be null or undefined
                                                     "defaultContent": date
                                                 },
                                              {
                                                  "data": "office", // can be null or undefined
                                                  "defaultContent": time
                                              },
                                            {
                                                "data": "office", // can be null or undefined
                                                "defaultContent": InstumentName
                                            },

                                                 {
                                                     "data": "office", // can be null or undefined
                                                     "defaultContent": leveltext
                                                 },


                                             { 'data': 'InvestigationName' },


                                            {
                                                // "data": "office", // can be null or undefined
                                                "defaultContent": Level,
                                            "orderDataType": "dom-text-numeric",
                                                "mRender": function(data, type, full, meta) {
                                                    if (full.Value1 != "") {
                                                        return '<input id= "' + id + "," + full.InvestigationID + '" type="text" box="value" class="capture" Val-Key="QCValue" disabled="disabled" IsUpdate="' + full.IsUpdate + '" decPlaces="' + full.Value2 + '" data="' + full.Value1 + '" value="' + full.Value1 + '" >';
                                                    }
                                                    else {
                                                        return '<input id= "' + id + "," + full.InvestigationID + '" type="text" box="value" class="capture" Val-Key="QCValue" IsUpdate="' + full.IsUpdate + '" decPlaces="' + full.Value2 + '"   data="' + full.Value1 + '" value="' + full.Value1 + '" >';
                                                    }



                                                }

                                            },




                                         ]

                });

                jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
                // $('#DeviceList').find('input[Val-Key]').maxLength();
                $('#DeviceList').addClass('show');
                $('#SaveBtnDiv').show();
            }
            else {
                $('#TblDeviceMapping').hide();
                $('#DeviceList').hide();
                alert('No matching record found!');
                $('.table-responsive').hide();
                $('#SaveBtnDiv').hide();
            }


        },
        error: function(xhr, status, error) {
            alert(xhr);
        }
    });



}