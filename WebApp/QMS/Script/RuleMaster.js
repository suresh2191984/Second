$(document).ready(function() {


    //*************Load All Drop Down*************//
    $('#AnalyteName').click(function() {
    var QCLevelID = $('#ddlLevel').val();
    if (QCLevelID == 0) {
        alert(langData.alert_levelselect);
        return false;

    }
    
     });
    LoadDropDowns();
    LoadRuleMaster();
    getEnteredValue();
    return false;
});
function getEnteredValue() {
    $("#txtManufactRefRange").blur(function() {
        //debugger;
        if (IsNumeric($("#txtManufactRefRange").val())) {
            $("#hdnManufacturerRefRange").val($("#txtManufactRefRange").val());
        }
        else {
            $("#txtManufactRefRange").val("");
            alert(langData.alert_manu_validrefrange);
        }
        return false;
    });
    $("#txtManufactMean").blur(function() {
       //debugger;
        $("#hdnManufacturerMean").val($("#txtManufactMean").val());
//        alert($("#hdnManufacturerMean").val());
        return false;
    });
    $("#txtRun").blur(function() {
        //debugger;
        $("#hdnRun").val($("#txtRun").val());
//        alert($("#hdnRun").val());
        return false;
    });
    $("#txtLabRefRange").blur(function() {
        //debugger;
  
            $("#hdnLabRefRange").val($("#txtLabRefRange").val());
      
        //        alert($("#hdnLabRefRange").val());
        return false;
    });
//    $("#txtLabMean").blur(function() {
//        //debugger;
//        $("#hdnLabMean").val($("#txtLabMean").val());
////        alert($("#hdnLabMean").val());
//        return false;
//    });
    $("#txtLabMean").blur(function() {
        $("#hdnLabMean").val($("#txtLabMean").val());
//        alert($("#hdnLabMean").val());
        return false;
    });
    $("#txtLabSD").blur(function() {
        $("#hdnLabSD").val($("#txtLabSD").val());
        return false;
    });

  
}
var QCRID;
var OrgId;
var LotID;
var Analyte;
var ManufacturerRefRange;
var ManufacturerMean;
var Run;
var LabRefRange;
var LabMean;
var LabSD;
var LJChartCalculation;
var CreatedBy = '12';
var CreatedAt = '';
var ModifiedBy = '12';
var ModifiedAt = '';

function LoadDropDowns() {
     OrgId = document.getElementById("hdnOrgID").value;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/GetLotDetails",
        data: "{'orgId': '" + OrgId + "'}",
        dataType: "json",
        async: false,
        success: function(data) {
            loaDropDownOnSuccess(data);
        },
        failure: function(msg) {
            alert(msg);
        }
    });
}
function loaDropDownOnSuccess(data) {
    
    if (data.d.length >= 0) {
        var ArryLst = data.d;
        //ddlDepartment
        var ddlLotItemsArrLst = ArryLst[0];
        
        var ddlLotNo = $('#ddlLotNo');
        ddlLotNo.empty();

        $('#ddlLotNo').append('<option value="0~0~0~0~0~0">'+langData.ddl_select+'</option>');
        $.each(ddlLotItemsArrLst, function(index, Item) {
        $('#ddlLotNo').append('<option value="' + Item.LotID + '" data="' + Item.LotID + '~' + Item.LotCode + '~' + Item.LotName + '">' + Item.LotCode + '</option>');
    });
//    $('#ddlLevel').empty();
//    $('#ddlLevel').append('<option value="0~0~0~0~0~0">-- Select --</option>');
//    $.each(ddlLotItemsArrLst, function(index, Item) {
//    $('#ddlLevel').append('<option value="' + Item.LotID + '~' + Item.LotCode + '~' + Item.LotName + '~' + Item.MetaValueID + '~' + Item.Code + '">' + Item.Code + '</option>');
//    });
        
    }
}
//Click And Change Events
$('#btnSave').click(
    function() {
        debugger;
        if ($('#btnSave').attr('data') == "save") {
            SaveQcRuleMaster();
        }
        else {
           // debugger;
            UpdateQcRuleMaster();
        }
        return false;
    });
    $('#btnClear').click(
    function() {
        
        clearFields();
        return false;
    });




    $('#ddlLotNo').change(
    function() {
      //  debugger;
        var ddlLotNo = $('#ddlLotNo');
        var value = $('#ddlLotNo option:selected').val();
        var name = $('#ddlLotNo option:selected').attr('data');
        if (value == "0~0~0~0~0~0") {
            $("#txtLotName").val("");
            $('#hdnSelectedLotID').val('0');
            $('#ddlLevel').attr('disabled', 'disabled');
        }
        else {
            var res = name.split("~");
            $("#txtLotName").val(res[2]);
            $('#hdnSelectedLotID').val(res[0]);
            $('#ddlLevel').removeAttr('disabled');
        }
        return false;
    }

);
    function clearFields() {
        $("#hdnSelectedLotID").val('');
        $("#hdnInvestigationID").val('');
        $("#hdnManufacturerRefRange").val('');
        $("#hdnManufacturerMean").val('');
        $("#hdnRun").val('');
        $("#hdnLabRefRange").val('');
        $("#hdnLabMean").val('');
        $("#hdnLabSD").val('');
        $("#hdnLJChartCalculation").val('');

        $('#ddlLotNo').val("0~0~0~0~0~0");
        
        $('#ddlLevel').empty();
         $('#ddlLevel').append('<option value="0">'+langData.ddl_select+'</option>');
        $('#txtChartCalc').val(0).change();
        
        $("#txtLotName").val('');
        $("#AnalyteName").val('');
        $('#AnalyteName').attr('disabled', 'disabled');
        $("#txtManufactMean").val('');
        $("#txtRun").val('');
        $("#txtManufactRefRange").val('');
        $("#txtLabRefRange").val('');
        $("#txtLabMean").val('');
        $("#txtLabSD").val('');
        $("#ddlLotNo").removeAttr('disabled');
        $("#AnalyteName").removeAttr('disabled');
        $('#btnSave').val(langData.save);
        $('#btnSave').attr('data', 'save');
    }

    function SaveQcRuleMaster() {
        
        OrgId = $("#hdnOrgID").val();

        if ($("#hdnSelectedLotID").val() == "0" || $("#hdnSelectedLotID").val() == "") {
            alert(langData.alert_lotno_select);
            return false;
        }
        var QCLevelID = $('#ddlLevel').val();
        var QCLevel = $("#ddlLevel option:selected").text();
        if (QCLevelID == 0)
         {
             alert(langData.alert_levelselect);
             return false;
        
        }
        LotID = $("#hdnSelectedLotID").val();
        
        if ($("#hdnInvestigationID").val() == "") {
            alert(langData.alert_analyte);
            return false;
        }
        Analyte = $("#hdnInvestigationID").val();
        if ($('#txtChartCalc').val() == "--Select--" || $('#txtChartCalc').val() == "") {
            alert(langData.alert_ljchartype_select);
            return false;
        }
        LJChartCalculation = $('#txtChartCalc').val();
        LabRefRange = $("#hdnLabRefRange").val();
        LabMean = ($("#hdnLabMean").val().length > 0) ? $('#hdnLabMean').val() :0;
        ManufacturerRefRange = $("#hdnManufacturerRefRange").val();
        ManufacturerMean = ($("#hdnManufacturerMean").val().length > 0) ? $('#hdnManufacturerMean').val() :0;
        if (LJChartCalculation == "Lab") {
            
            if (LabRefRange == "") {
                alert(langData.alert_labrefrange);
                return false;
            }
            else if (LabMean == "") {
            alert(langData.alert_labmean);
                return false;
            }
            else if (LabMean <= 0) {
            alert(langData.alert_labmeanvalue);
                return false;
            }


        }
        else if (LJChartCalculation == "Manufacturer") {
       
            if (ManufacturerRefRange == "") {
                alert(langData.alert_manu_refrange);
                return false;
            }
            else if (ManufacturerMean == "") {
            alert(langData.alert_manumean);
                return false;
            }
            else if (ManufacturerMean <= 0) {
            alert(langData.alert_manumeanvalue);
                return false;
            }

        }
        Run = $("#hdnRun").val();
        if ((Run == '') || (Run == " ")) {
            Run = 0;
        }
        else if (Run <= 0) {
        alert(langData.alert_runvalue);
            return false;
        }
        LabSD = $("#hdnLabSD").val();
        if ((LabSD == '') || (LabSD == " ")) {
            alert(langData.alert_labsd);
			return false;
            //LabSD = 0;
        }
        else if (LabSD <= 0) {
        alert(langData.alert_labsdvalue);
            return false;
        }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../QMS.asmx/SaveQcRuleMaster",
                    data: JSON.stringify({
                    LotId:LotID,
                    Analyte:Analyte,
                    ManufacturerRefRange:ManufacturerRefRange,
                    ManufacturerMean:ManufacturerMean,
                    Run:Run,
                    LabRefRange:LabRefRange,
                    LabMean:parseFloat(LabMean),
                    LabSD:parseFloat(LabSD),
                    LJChartCalc:LJChartCalculation,
                    OrgId:OrgId,
                    CreatedBy:CreatedBy,
                    CreatedAt:CreatedAt,
                    ModifiedBy:ModifiedBy,
                    ModifiedAt:ModifiedAt,
                    QCLevelID:QCLevelID,
                    QCLevel:QCLevel}),
                    // data: obj,
                    dataType: "json",
                    async: false,

                    success: function(data) {

            	   // if (data.d.length > 0) {
                        clearFields();
	                LoadRuleMaster();
	                alert(langData.alert_save);
	               
                   // }
                    },
                    error: function(xhr, status, error) {
LoadRuleMaster();
                    alert(error);
                    
                        return false;
                    }
                });
                
                return false;
            }

            function UpdateQcRuleMaster() {
              //  debugger;
                OrgId = $("#hdnOrgID").val();

                if ($("#hdnSelectedLotID").val() == "0" || $("#hdnSelectedLotID").val() == "") {
                    alert(langData.alert_lotno_select);
                    return false;
                }
                LotID = $("#hdnSelectedLotID").val();
                var QCLevelID = $('#ddlLevel').val();
                var QCLevel = $("#ddlLevel option:selected").text();
                if (QCLevelID == 0) {
                    alert(langData.alert_levelselect);
                    return false;

                }
                if ($("#hdnInvestigationID").val() == "") {
                    alert(langData.alert_lotno_select);
                    return false;
                }
                Analyte = $("#hdnInvestigationID").val();

                ManufacturerRefRange = $("#hdnManufacturerRefRange").val();
                ManufacturerMean = ($("#hdnManufacturerMean").val().length > 0) ? $('#hdnManufacturerMean').val() : 0;
                LabRefRange = $("#hdnLabRefRange").val();
                LabMean = ($("#hdnLabMean").val().length > 0) ? $('#hdnLabMean').val() : 0;
                if ($('#txtChartCalc').val() == "--Select--" || $('#txtChartCalc').val() == "") {
                    alert("Any One LJ Chart type should be selected");
                    return false;
                }
                LJChartCalculation = $('#txtChartCalc').val();

                if (LJChartCalculation == "Lab") {

                    if (LabRefRange == "") {
                        alert(langData.alert_labrefrange);
                        return false;
                    }
                    else if (LabMean == "") {
                    alert(langData.alert_labmean);
                        return false;
                    }
                    else if (LabMean <= 0) {
                    alert(langData.alert_labmeanvalue);
                        return false;
                    }



                }
                else if (LJChartCalculation == "Manufacturer") {

                    if (ManufacturerRefRange == "") {
                        alert(langData.alert_manu_refrange);
                        return false;
                    }
                    else if (ManufacturerMean == "") {
                    alert(langData.alert_manumean);
                        return false;
                    }

                    else if (ManufacturerMean <= 0) {
                    alert(langData.alert_manumeanvalue);
                        return false;
                    }

                }
                Run = $("#hdnRun").val();
                if ((Run == '') || (Run == " ")) {
                    Run = 0;
                }
                else if (Run <= 0) {
                alert(langData.alert_runvalue);
                return false;
                }
                LabSD = $("#hdnLabSD").val();
                if ((LabSD == '') || (LabSD == " ")) {
                    alert(langData.alert_labsd);
					return false;
                }
                else if (LabSD <= 0) {
                alert(langData.alert_labsdvalue);
                    return false;
                }
                if ($("#hdnQCRID").val() == "") {
                    alert(langData.alert_wentwrong);
                    return false;
                }
                QCRID = $("#hdnQCRID").val();
               
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../QMS.asmx/UpdateQcRuleMaster",
                    data: JSON.stringify({
                        QCRID:QCRID,
                        LotId: LotID,
                        Analyte: Analyte,
                        ManufacturerRefRange: ManufacturerRefRange,
                        ManufacturerMean: ManufacturerMean,
                        Run: Run,
                        LabRefRange: LabRefRange,
                        LabMean: parseFloat(LabMean),
                        LabSD: parseFloat(LabSD),
                        LJChartCalc: LJChartCalculation,
                        OrgId: OrgId
                    }),
                    // data: obj,
                    dataType: "json",
                    async: false,

                    success: function(data) {
                    alert(langData.alert_update);
                        clearFields();
                    },
                    error: function(xhr, status, error) {
                        alert(error);
                        return false;
                    }
                });
                LoadRuleMaster();
                return false;
            }

            $(function() {
                // var Orgid = document.getElementById("hdnOrgID").value;
                //            //var count = 0;
                //                alert($("#hdnSelectedLotID").val());
                //            var Status = 'Analyte~' + $("#hdnSelectedLotID").val();

                $("#AnalyteName").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: '../QMS.asmx/QMS_LoadAnalyte',
                            data: JSON.stringify({ Status: 'Analyte~' + $("#hdnSelectedLotID").val(), prefixText: request.term }),
                            dataType: "json",
                            success: function(data) {
                            $("#hdnInvestigationID").val("")
                                if (data.d.length > 0) {
                                    response($.map(data.d, function(item) {
                                        var rsltlable = item.DisplayText;
                                        var rsltvalue = item.InvestigationID;
                                        return {
                                            label: rsltlable,
                                            val: rsltvalue
                                        }

                                    }))
                                }
                                else {
                                    response([{ label: langData.result_notfound, val: -1}]);
                                    $('#AnalyteName').val("");
                                    //Clear();
                                }
                            },
                            error: function(response) {
                            $("#hdnInvestigationID").val("")
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
                            BindFilteredRuleMaster();
                        }
                    },
                    minLength: 2
                });
            });
 function BindFilteredRuleMaster() {
                //  debugger;
                var LotID = $("#hdnSelectedLotID").val();
                var InvID = $("#hdnInvestigationID").val();
                var QCLevelID = $("#ddlLevel").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../QMS.asmx/GetRuleMasters",
                    data: JSON.stringify({ orgId: OrgId, LotId: LotID, InvId: InvID, QCLevelID: QCLevelID }),
                    dataType: "json",
                    async: false,

                    success: function(data) {
                        if (data.d.length > 0) {
                            var Items = data.d[0].Actions;

                            var dtDayWCR = Items.substring(1, data.d[0].Actions.length - 1);
                            if (dtDayWCR.length > 0) {
                                Edit_OnClick(dtDayWCR);
                            }
                            else {

                                alert(langData.record_notfound);

                            }
                        }

                    },
                    error: function(jqXHR, textStatus, errorThrown) {

                    }
                });
                return false;

            }
            
            

            function LoadRuleMaster() {
                //  debugger;
                var lotid = 0;
                var invid = 0;
                var levelid = 0;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../QMS.asmx/GetRuleMasters",
                    data: JSON.stringify({ orgId: OrgId, LotId: lotid, InvId: invid, QCLevelID: levelid }),
                    dataType: "json",
                    async: false,

                    success: function(data) {
                        var Items = data.d;
                       // debugger;
                        var dtDayWCR = Items;
                        if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
//                            var parseJSONResult = JSON.parse(dtDayWCR);
                            $('#Bindtable').show();
                            $('#tblBindtable').show();
                            $('#tblBindtable').dataTable({
                                paging: true,
                                data: dtDayWCR,
                                "bDestroy": true,
                                  "language": {
                "url": dataTablePath
            },
                                "searchable": true,
                                "sort": true,
                                columns: [
                                            { 'data': 'LotCode' } ,
                                            { 'data': 'LotName' } ,
                                            { 'data': 'LevelCode' },
                                            { 'data': 'AnalyteName' },
                                            { 'data': 'ManufacturerRefRange' },
                                            //  { 'data': 'ManufacturerMean' },
                                           {'data': 'ManufacturerMean',

                                           "mRender": function(data, type, full) {
                                           if (full.ManufacturerMean > 0) {
                                               return full.ManufacturerMean;
                                               }
                                               else {
                                                   return "";
                                               }
                                           }

                                       },
                                          
                                            { 'data': 'LabRefRange' },
                                            {'data': 'LabMean',
                                           "mRender": function(data, type, full) {
                                                if (full.LabMean > 0) {
                                                    return full.LabMean;
                                                }
                                                else {
                                                    return "";
                                                }
                                            }

                                        },
                                        { 'data': 'LJChartCalc' },
                                        { 'data': 'LabSD' },
                                        
                                       { 'data': 'Actions',
                                                  "Default Content": 'Actions',
                                                  "mRender": function(data, type, full, meta) {
                                             var txt=  '<input value = "'+langData.Edit+'" '+full.Actions+' class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                              txt = txt+ '/' +'<input value = "' + langData.Delete + '" ' + full.Descriptions + '  class="deleteIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                 return txt;
                                           }
                                       }
                                //                                            { 'data': 'Descriptions' }
                                            ]

                            });

                            jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

                            $('#Bindtable').addClass('show');
                        }
                        else {
                            $('#tblBindtable').hide();
                            $('#Bindtable').hide();
//                            BootstrapDialog.alert('No matching record found!');

                        }

                    },
                    error: function(jqXHR, textStatus, errorThrown) {

                    }
                });
                return false;

            }
            function Delete_OnClick(QCRID) {
                
                if (confirm(langData.delete_confirm) == true) {
                    var Activationstatus = "N";
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "../QMS.asmx/DeleteRuleMaster",
                        data: JSON.stringify({ QCRID: QCRID }),
                        dataType: "JSON",
                        async: false,
                        success: function(data) {
                        LoadRuleMaster();
                        alert(langData.alert_delete);
                        },
                        error: function(xhr, status, error) {
                            alert(xhr);
                        }
                    });
                    
                } else {
                return false;
                }
                
                
            }
            function Edit_OnClick(QCRID) {
               // debugger;
                
                var SpliArray = QCRID.split('~');
                $("#hdnQCRID").val(SpliArray[0]);
                $("#hdnSelectedLotID").val(SpliArray[1]);
                $("#hdnInvestigationID").val(SpliArray[6]);
                $("#hdnManufacturerRefRange").val(SpliArray[8]);
                $("#hdnManufacturerMean").val(SpliArray[9]);
                if (SpliArray[10] == "0") {
                    $("#hdnRun").val(' ');
                }
                else {
                    $("#hdnRun").val(SpliArray[10]);
                }
                $("#hdnLabRefRange").val(SpliArray[11]);
                $("#hdnLabMean").val(SpliArray[12]);
                if (SpliArray[13] == "0.000") {
                    $("#hdnLabSD").val(' ');
                }
                else {
                    $("#hdnLabSD").val(SpliArray[13]);
                }
                $("#hdnLJChartCalculation").val(SpliArray[14]);
                
                var LotIDLotCodeLotNameMetaValueIDCode = SpliArray[1] + '~' + SpliArray[2] + '~' + SpliArray[3] + '~' + SpliArray[4] + '~' + SpliArray[5];
                $('#ddlLotNo').val(SpliArray[1]).change();
                $('#ddlLevel').val(SpliArray[4]);
                $('#txtChartCalc').val(SpliArray[14]);
                $("#txtLotName").val(SpliArray[3]);

                $("#AnalyteName").val(SpliArray[7]);
                $("#txtManufactMean").val(SpliArray[9]);
                if (SpliArray[10] == "0") {
                    $("#txtRun").val(' ');
                }
                else {
                    $("#txtRun").val(SpliArray[10]);
                }
                $("#txtManufactRefRange").val(SpliArray[8]);
                $("#txtLabRefRange").val(SpliArray[11]);
                $("#txtLabMean").val(SpliArray[12]);
                if (SpliArray[13] == "0.000") {
                    $("#txtLabSD").val(' ');
                }
                else {
                    $("#txtLabSD").val(SpliArray[13]);
                }
                $("#AnalyteName").attr('disabled', 'disabled');
                $("#ddlLevel").attr('disabled', 'disabled');
                $("#ddlLotNo").attr('disabled', 'disabled');
                $('#btnSave').val(langData.Update);
                $('#btnSave').attr('data', '');
                return false;
            }

            
            $('.Deci').keypress(function(event) {
                //                if (event.which == 45) {
                //                    if ($(this).val().length == 2) {
                //                        event.preventDefault();
                //                    }
                //                }
                //                else {
                if ((event.which != 46) && (event.which < 48 || event.which > 57)) {
                    event.preventDefault();
                }
                else if (($(this).val() == "" && event.which == 46) || ($(this).val().indexOf('.') != -1 && event.which == 46)) {
                    event.preventDefault();
                }
                //                }

            });
            $('.OnlyAlpha').keypress(function(event) {
                if (event.which == 45) {
                    if ($(this).val().indexOf('-') != -1 ) {
                        event.preventDefault();
                    }
                }
                else {
                    if ((event.which != 46) && (event.which < 48 || event.which > 57)) {
                        event.preventDefault();
                    }
//                    else if (($(this).val() == "" && event.which == 46) || ($(this).val().indexOf('.') != -1 && event.which == 46)) {
//                        event.preventDefault();
//                    }
                }

            });
            $('.Integer').keypress(function(event) {
                
                if ((event.which < 48 || event.which > 57)) {
                    event.preventDefault();
                }
//                else if (($(this).val() == "" && event.which == 46) || ($(this).val().indexOf('.') != -1 && event.which == 46)) {
//                    event.preventDefault();
//                }
            });

            function IsNumeric(input) {
//                var input = $("#txtLabRefRange").val();
                var DeciArr = input.split('-');
                var IsNumeric = true;
                if (DeciArr.length != 2) {
                    IsNumeric = false;
                }
                else {
                    var FirstPart = "";
                    var SecondPart = "";

                    FirstPart = DeciArr[0];
                    SecondPart = DeciArr[1];
                    if (parseInt(FirstPart) == NaN || parseInt(SecondPart) == NaN) {
                        IsNumeric = false;
                    }
                }
//                if (!IsNumeric) {
//                    alert("Please enter valid reference range");
//                }
                return IsNumeric;
            }
