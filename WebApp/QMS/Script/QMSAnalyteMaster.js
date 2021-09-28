$(document).ready(function() {
    //*************Load All Drop Down*************//
    LoadDropDowns();
    Clear();
    GetAnalyteMasrer(-1);

   // $('#EditAnalyte').hide();
});


function ShowErrToolTip(ID, Content) {
            var tooltipOptions = {
                container: 'body',
                html: true,
                trigger: 'manual',
                title: function() {
                    // here will be custom template
                    var id = 'TEST';

                    return Content;
                },
           placement:"bottom",
            };

            tip = $(ID);
            tip.tooltip(tooltipOptions);
            tip.tooltip('show');
        }
        
        
function LoadDropDowns() {
    //*************Load Dept Drop Down*************//
    var OrgId = document.getElementById("hdnOrgID").value;
    var InvestigationID = 0;
    if (document.getElementById("hdnInvestigationID").value != "") {
        var InvestigationID = document.getElementById("hdnInvestigationID").value;
    }
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
                //ddlAdditive
                var ddlAdditiveArryLst = ArryLst[1];
                var ddlAdditive = $('#ddlAdditive');
                

                ddlAdditive.empty();
                
                $('#ddlAdditive').append($('<option></option>').val(0).html(langData.ddl_select));
                
                $.each(ddlAdditiveArryLst, function(index, Item) {
                    $('#ddlAdditive').append('<option value="' + Item.SampleContainerID + '">' + Item.ContainerName + '</option>');
                    
                });
                //ddlResultValue
                var ddlResultValueArryLst = ArryLst[2];
                var ddlResultValue = $('#ddlResultValue');
                

                ddlResultValue.empty();
                
                $('#ddlResultValue').append($('<option></option>').val(0).html(langData.ddl_select));
                
                $.each(ddlResultValueArryLst, function(index, Item) {
                    $('#ddlResultValue').append('<option value="' + Item.Code + '">' + Item.Value + '</option>');
                    
                });
                //ddlSampleType
                var ddlSampleTypeArryLst = ArryLst[3];
                var ddlSampleType = $('#ddlSampleType');
                

                ddlSampleType.empty();
                
                $('#ddlSampleType').append($('<option></option>').val(0).html(langData.ddl_select));
                
                $.each(ddlSampleTypeArryLst, function(index, Item) {
                    $('#ddlSampleType').append('<option value="' + Item.SampleCode + '">' + Item.SampleDesc + '</option>');
                    
                });
                //ddlMethod
                var ddlMethodArryLst = ArryLst[4];
                var ddlMethod = $('#ddlMethod');
                ddlMethod.empty();
                $('#ddlMethod').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlMethodArryLst, function(index, Item) {
                    $('#ddlMethod').append('<option value="' + Item.MethodID + '">' + Item.MethodName + '</option>');
                });
                //ddlPrinciple
                var ddlPrincipleArryLst = ArryLst[5];
                var ddlPrinciple = $('#ddlPrinciple');
                ddlPrinciple.empty();
                $('#ddlPrinciple').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlPrincipleArryLst, function(index, Item) {
                    $('#ddlPrinciple').append('<option value="' + Item.PrincipleID + '">' + Item.PrincipleName + '</option>');
                });
                //ddlClassification
                var ddlClassificationArryLst = ArryLst[6];
                var ddlClassification = $('#ddlClassification');
                

                ddlClassification.empty();
                
                $('#ddlClassification').append($('<option></option>').val(0).html(langData.ddl_select));
                
                $.each(ddlClassificationArryLst, function(index, Item) {
                    $('#ddlClassification').append('<option value="' + Item.Code + '">' + Item.DisplayText + '</option>');
                    
                });
                //ddlHours
                var ddlHoursArryLst = ArryLst[7];
                var ddlHours = $('#ddlHours');
                ddlHours.empty();
                $('#ddlHours').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlHoursArryLst, function(index, Item) {
                    $('#ddlHours').append('<option value="' + Item.Code + '">' + Item.DisplayText + '</option>');
                });
            }

        },
        failure: function(msg) {
            alert(msg);
        }
    });
}
$(function() {
    var Orgid = document.getElementById("hdnOrgID").value;
    var count = 0;
    var Type = 'Investigations';

    $("[id$=txtAnalyteName]").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../WebService.asmx/GetTestCodingScheme',
                data: "{'prefixText': '" + request.term + "','count': " + count + ",'contextKey':'" + Orgid + '~' + Type + "'}",
                dataType: "json",
                success: function(data) {
                 if (data.d.length > 0) {
                    response($.map(data.d, function(item) {
                    
                    try 
                    {
                        var rsltlable = item.split(',')[0];
                        var rsltvalue = item.split(',')[1];
                        return {
                            label: rsltlable.split(':')[1].slice(1),
                            val: rsltvalue.split(':')[1].slice(1)
                        
                        }
                        }
                        catch(er)
                        {
                        }
                    }
                    
                    
                    )) } else {
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
            $("[id$=hdnAnalyteValue]:selected").val(i.item.val);
            $("#hdnInvestigationID").val(i.item.val);
            LoadDropDowns();
             
            GetAnalyteMasrer(i.item.val);
            $('#btnSave').val(langData.AnalyzerMapping_btnUpdate);
        },
        minLength: 2
    });
});

function CheckisEmpty()
{

if (document.getElementById('hdnAnalyteValue').value =='')
{
alert (langData.result_notfound);
document.getElementById('hdnAnalyteValue').value =='';
document.getElementById('txtAnalyteName').value='';
document.getElementById('txtAnalyteName').focus();
return false;
}
}

function clearfields()
{

 Clear();
}


$(function() {
    var Orgid = document.getElementById("hdnOrgID").value;
    var count = 0;
    var Type = 'Investigations';

    $("#ddlAnalyteName").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../WebService.asmx/GetTestCodingScheme',
                data: "{'prefixText': '" + request.term + "','count': " + count + ",'contextKey':'" + Orgid + '~' + Type + "'}",
                dataType: "json",
                success: function(data) {
                    response($.map(data.d, function(item) {
                        var rsltlable = item.split(',')[0];
                        var rsltvalue = item.split(',')[1];
                        return {
                            label: rsltlable.split(':')[1].slice(1),
                            val: rsltvalue.split(':')[1].slice(1)
                        }
                    }))
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
        $("ddlAnalyteName").val(i.item.val);
        },
        minLength: 2
    });
});

function LoadAMQCDropDown() {
    var OrgId = document.getElementById("hdnOrgID").value;
    var InvestigationID = 0;
    if (document.getElementById("hdnInvestigationID").value != "") {
        var InvestigationID = document.getElementById("hdnInvestigationID").value;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/LoadQCDropDown",
        data: JSON.stringify({ Orgid: OrgId, InvestigationID: InvestigationID}),
        dataType: "json",
        async: false,
        success: function(data) {

            if (data.d.length >= 0) {
                var ArryLst = data.d;
                //ddlDepartment
                var ddlDepartmentArryLst = ArryLst[0];
                var ddlDepartment = $('#ddlDepartment');
                var ddlDepartmentPopUp = $('#ddlDepartmentPopUp');


                ddlDepartment.empty();
                ddlDepartmentPopUp.empty();

                //$('#ddlDepartment').append($('<option></option>').val(0).html('-- Select --'));
                $('#ddlDepartmentPopUp').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlDepartmentArryLst, function(index, Item) {
                    $('#ddlDepartment').append('<option value="' + Item.DeptID + '">' + Item.DeptName + '</option>');
                    $('#ddlDepartmentPopUp').append('<option value="' + Item.DeptID + '">' + Item.DeptName + '</option>');
                    //                        $("#ddlDepartment option:selected").val(Item.DeptID + Item.DeptName);
                });
                //ddlAdditive
                var ddlAdditiveArryLst = ArryLst[1];
                var ddlAdditive = $('#ddlAdditive');
                var ddlAdditivePopUp = $('#ddlAdditivePopUp');

                ddlAdditive.empty();
                ddlAdditivePopUp.empty();
               // $('#ddlAdditive').append($('<option></option>').val(0).html('-- Select --'));
                $('#ddlAdditivePopUp').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlAdditiveArryLst, function(index, Item) {
                    $('#ddlAdditive').append('<option value="' + Item.SampleContainerID + '">' + Item.ContainerName + '</option>');
                    $('#ddlAdditivePopUp').append('<option value="' + Item.SampleContainerID + '">' + Item.ContainerName + '</option>');
                });
                //ddlResultValue
                var ddlResultValueArryLst = ArryLst[2];
                var ddlResultValue = $('#ddlResultValue');
                var ddlResultValuePopUp = $('#ddlResultValuePopUp');

                ddlResultValue.empty();
                ddlResultValuePopUp.empty();
               // $('#ddlResultValue').append($('<option></option>').val(0).html('-- Select --'));
                $('#ddlResultValuePopUp').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlResultValueArryLst, function(index, Item) {
                    $('#ddlResultValue').append('<option value="' + Item.Code + '">' + Item.Value + '</option>');
                    $('#ddlResultValuePopUp').append('<option value="' + Item.Code + '">' + Item.Value + '</option>');
                });
                //ddlSampleType
                var ddlSampleTypeArryLst = ArryLst[3];
                var ddlSampleType = $('#ddlSampleType');
                var ddlSampleTypePopUp = $('#ddlSampleTypePopUp');

                ddlSampleType.empty();
                ddlSampleTypePopUp.empty();
               // $('#ddlSampleType').append($('<option></option>').val(0).html('-- Select --'));
                $('#ddlSampleTypePopUp').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlSampleTypeArryLst, function(index, Item) {
                    $('#ddlSampleType').append('<option value="' + Item.SampleCode + '">' + Item.SampleDesc + '</option>');
                    $('#ddlSampleTypePopUp').append('<option value="' + Item.SampleCode + '">' + Item.SampleDesc + '</option>');
                });
                //ddlMethod
                var ddlMethodArryLst = ArryLst[4];
                var ddlMethod = $('#ddlMethod');
                ddlMethod.empty();
                //$('#ddlMethod').append($('<option></option>').val(0).html('-- Select --'));
                $.each(ddlMethodArryLst, function(index, Item) {
                    $('#ddlMethod').append('<option value="' + Item.MethodID + '">' + Item.MethodName + '</option>');
                });
                //ddlPrinciple
                var ddlPrincipleArryLst = ArryLst[5];
                var ddlPrinciple = $('#ddlPrinciple');
                ddlPrinciple.empty();
                //$('#ddlPrinciple').append($('<option></option>').val(0).html('-- Select --'));
                $.each(ddlPrincipleArryLst, function(index, Item) {
                    $('#ddlPrinciple').append('<option value="' + Item.PrincipleID + '">' + Item.PrincipleName + '</option>');
                });
                //ddlClassification
                var ddlClassificationArryLst = ArryLst[6];
                var ddlClassification = $('#ddlClassification');
                var ddlClassificationPopUp = $('#ddlClassificationPopUp');

                ddlClassification.empty();
                ddlClassificationPopUp.empty();
               // $('#ddlClassification').append($('<option></option>').val(0).html('-- Select --'));
                $('#ddlClassificationPopUp').append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ddlClassificationArryLst, function(index, Item) {
                    $('#ddlClassification').append('<option value="' + Item.Code + '">' + Item.DisplayText + '</option>');
                    $('#ddlClassificationPopUp').append('<option value="' + Item.Code + '">' + Item.DisplayText + '</option>');
                });
                //ddlHours
                var ddlHoursArryLst = ArryLst[7];
                var ddlHours = $('#ddlHours');
                ddlHours.empty();
                //$('#ddlHours').append($('<option></option>').val(0).html('-- Select --'));
                $.each(ddlHoursArryLst, function(index, Item) {
                    $('#ddlHours').append('<option value="' + Item.Code + '">' + Item.DisplayText + '</option>');
                });
            }

        },
        failure: function(msg) {
            alert(msg);
        }
    });


}
function Clear() {
    //$('#EditAnalyte').hide();
    $("#txtAnalyteName").val('');
    $('#hdnAnalyteValue').val('');
    $("#ddlDepartment").val('0');
    $("#ddlAdditive").val('0');
    $('#ddlResultValue').val('0');
    $("#ddlSampleType").val('0');
    $("#txtDecimalPlaces").val('');
    $('#ddlMethod').val('0');
    $("#ddlPrinciple").val('0');
    $("#ddlClassification").val('0');
    $("#txtProcessingTime").val('');
    $("#ddlHours").val('0');
    $("#chkActive").attr('checked', false);
    $("#chkNABL").attr('checked', false);
    document.getElementById("hdnInvestigationID").value='';
    document.getElementById("hdnAnalyteValue").value='';

    return false;
}

//************Comman SaveAnalyteMasrer Fields*************//
var txtAnalyteName;
var AnalyteValue;
var Investigationid;
var DepartmentID;
var ContatinerID;
var ResultValueType;
var SampleID;
var DecimalPlaces;
var MethodID;
var PrinclipleID;
var Classification;
var CutOffTimeValue;
var CutOffTimeType;
var chkActive;
var chkNABL;
var InvID;

//var LstAnalyteMasrer = [];
var CommandFlag = 1;
var orgID = $('#hdnOrgID').val();
var ID = 0;
var AnalyteMaster = [];

function SaveAnalyteMasrer() {

  


    txtAnalyteName = $('#txtAnalyteName').val();
    AnalyteValue = $("#hdnInvestigationID").val();
    Investigationid = $("#hdnInvestigationID").val();
    DepartmentID = $("#ddlDepartment").val();
    ContatinerID = $("#ddlAdditive").val();
    ResultValueType = $('#ddlResultValue').val();
    SampleID = $("#ddlSampleType").val();
    DecimalPlaces = $("#txtDecimalPlaces").val();
    MethodID = $('#ddlMethod').val();
    PrinclipleID = $("#ddlPrinciple").val();
    Classification = $("#ddlClassification").val();
    CutOffTimeValue = $("#txtProcessingTime").val();
    CutOffTimeType = $("#ddlHours").val();
    if (txtAnalyteName != null && AnalyteValue != null) {
        if (AnalyteValue != '' && txtAnalyteName != '') {
            if ($("#chkActive").prop('checked') == true) {
                chkActive = "Y";
            }
            else {
                chkActive = "N";
            }
            if ($("#chkNABL").prop('checked') == true) {
                chkNABL = "Y";
            }
            else {
                chkNABL = "N";
            }
            AnalyteMaster.push({
                Investigationid: Investigationid,
                DepartmentID: DepartmentID,
                ContatinerID: ContatinerID,
                ResultValueType: ResultValueType,
                SampleID: SampleID,
                DecimalPlaces: DecimalPlaces,
                MethodID: MethodID,
                PrinclipleID: PrinclipleID,
                Classification: Classification,
                CutOffTimeValue: CutOffTimeValue,
                CutOffTimeType: CutOffTimeType,
                IsActive: chkActive,
                IsNABL: chkNABL,
                ID: ID,
                OrgId: orgID
            });
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/SaveAnalyteMasrer",
                data: JSON.stringify({ orgID: orgID, CommandFlag: CommandFlag, lstAnalyteMaster: AnalyteMaster }),
                // data: obj,
                dataType: "json",
                async: false,

                success: function(data) {
                    alert(langData.alert_save);
                    Clear();
                    GetAnalyteMasrer(-1);
                    //Clear();
                    
                },
                error: function(xhr, status, error) {
                    alert(error);
                    return false;
                }

            });

        }
        else {
            $("#txtAnalyteName").focus();
            alert(langData.alert_analytename);
            return false;
        }
    }
    return false;
}

function GetAnalyteMasrer(Invid) {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/GetAnalyteMasterDetails",
        data: JSON.stringify({ orgID: orgID, InvID: Invid }),
        dataType: "json",
        async: false,

        success: function(data) {
Clear();
            if (Invid != -1) {

                var Items = data.d;
                var dtDayWCR = Items;
                var parseJSONResult;
                if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                    parseJSONResult = JSON.parse(dtDayWCR)[0];
               


                
                $("#txtAnalyteName").val((parseJSONResult.DisplayText.length>1)?parseJSONResult.DisplayText:'');
                $('#hdnAnalyteValue').val((parseJSONResult.DeptID>0)?parseJSONResult.InvestigationID:0);
                $("#ddlDepartment").val((parseJSONResult.DeptID>0)?parseJSONResult.DeptID:0);
                $("#ddlAdditive").val((parseJSONResult.SampleContainerID>0)?parseJSONResult.SampleContainerID:0);
                
                if(parseJSONResult.Value!=null)
                {
                $('#ddlResultValue').val((parseJSONResult.Value!="")?parseJSONResult.Value:'0');
                }
                else
                {
                $('#ddlResultValue').val('0');
                }
                
                $("#ddlSampleType").val( (parseJSONResult.SampleCode>0)?parseJSONResult.SampleCode:0);
                $("#txtDecimalPlaces").val((parseJSONResult.DecimalPlaces>0)?parseJSONResult.DecimalPlaces:0);
                $('#ddlMethod').val((parseJSONResult.MethodID>0)?parseJSONResult.MethodID:0);
                $("#ddlPrinciple").val((parseJSONResult.PrincipleID>0)?parseJSONResult.PrincipleID:0);
                if(parseJSONResult.Classification!=null)
                {
                $("#ddlClassification").val((parseJSONResult.Classification!="")?parseJSONResult.Classification.toUpperCase():'0');
                }
                else
                {
                $("#ddlClassification").val('0');
                }
                
                
                $("#txtProcessingTime").val((parseJSONResult.CutOffTimeValue!="")?parseJSONResult.CutOffTimeValue:'');
                if(parseJSONResult.CutOffTimeType ==null || parseJSONResult.CutOffTimeType=='')
                {$("#ddlHours").val(0);}
                else
                {
                $("#ddlHours").val(parseJSONResult.CutOffTimeType);
                }

                if (parseJSONResult.IsActive == 'Y') {
                    $("#chkActive").prop('checked', true);
                }
                else {
                    $("#chkActive").prop('checked', false);
                }

                if (parseJSONResult.IsNABL == 'Y') {
                    $("#chkNABL").prop('checked', true);
                }
                else {
                    $("#chkNABL").prop('checked', false);
                }

}

              $('#btnSave').val(langData.Update);  
             $('#btnSave').show();  
            }
            else {
                var Items = data.d;
                var dtDayWCR = Items;
                if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                    var parseJSONResult = JSON.parse(dtDayWCR);
                    $('#Bindtable').show();
                    $('#tblBindtable').show();
                    $('#tblBindtable').dataTable({
                        paging: true,
                        "language": {
                "url": dataTablePath
            },
                        data: parseJSONResult,
                        "bDestroy": true,
                        "searchable": true,
                        "sort": true,

dom: 'Bfrtip',
        buttons: [
            {
                extend: 'copyHtml5',
                exportOptions: {
                columns:[1, 2,4, 6, 7,11]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                columns: [1, 2,4, 6, 7,11]
                }
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: [1, 2,4, 6, 7,11]
                }
            }
        ],
                        columns: [
                                            { 'data': 'InvestigationID', "sClass": "hide_column" },
                                            { 'data': 'DisplayText' },
                                            { 'data': 'DeptName' },
                                            { 'data': 'DeptID', "sClass": "hide_column" },
                                            { 'data': 'ContainerName' },
                                            { 'data': 'SampleContainerID', "sClass": "hide_column" },
                                            { 'data': 'Value' },
                                            { 'data': 'SampleDesc'},
                                            { 'data': 'DecimalPlaces', "sClass": "hide_column" },
                                            { 'data': 'MethodID', "sClass": "hide_column" },
                                            { 'data': 'PrincipleID', "sClass": "hide_column" },
                                            { 'data': 'Classification',
                                              "mRender": function (data, type, full, meta) {
                                              var txt="";
                                              if(full.Classification !=null && full.Classification !='')
                                              {
                                              txt=full.Classification.split('~')[1];
                                              }
                                              return txt;
                                            }
                                             },
                                            { 'data': 'CutOffTimeType', "sClass": "hide_column" },
                                            { 'data': 'CutOffTimeValue', "sClass": "hide_column" },
                                            { 'data': 'IsActive', "sClass": "hide_column" },
                                            { 'data': 'IsNABL', "sClass": "hide_column" },
                                            { 'data': 'FileEdit',
                                              "mRender": function (data, type, full, meta) {
                                              return '<input value = "'+langData.Edit+'" '+full.FileEdit+' class="editIcons" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                            }
                                            

                                            
                                             
                                            
                                            }]

                    });

                    jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

                    $('#Bindtable').addClass('show');
                }
                else {
                    $('#tblBindtable').hide();
                    $('#Bindtable').hide();
                    alert(langData.record_notfound);

                }
            }

        },
        error: function(jqXHR, textStatus, errorThrown) {

        }
    });
    return false;

}

function btnEdit_OnClick(InvestigationID) {

    // LoadDropDowns();
 //   $('#EditAnalyte').show();
Clear();
 document.getElementById("hdnInvestigationID").value=InvestigationID;
    InvID = InvestigationID;
    var oTable = $("#tblBindtable").DataTable();
    var rowCount = $('#tblBindtable tr').length;
    var indexes = oTable.rows().eq(0).filter(function(rowIdx) {
        if (oTable.cell(rowIdx, 0).data() == InvID) {
            var aData = oTable.rows(rowIdx).data();
            
            var InvestigationID = InvID;
            var AnalyteName = aData[0].DisplayText;
            $("#txtAnalyteName").val((aData[0].DisplayText.length>1)?aData[0].DisplayText:'');
                $('#hdnAnalyteValue').val((aData[0].InvestigationID>0)?aData[0].InvestigationID:0);
                $("#ddlDepartment").val((aData[0].DeptID>0)?aData[0].DeptID:0);
                $("#ddlAdditive").val((aData[0].SampleContainerID>0)?aData[0].SampleContainerID:0);
                
                if(aData[0].Value!=null)
                {
                $('#ddlResultValue').val((aData[0].Value!="")?aData[0].Value:'0');
                }
                else
                {
                $('#ddlResultValue').val('0');
                }
                
                
                $("#ddlSampleType").val( (aData[0].SampleCode>0)?aData[0].SampleCode:0);
                $("#txtDecimalPlaces").val((aData[0].DecimalPlaces>0)?aData[0].DecimalPlaces:0);
                $('#ddlMethod').val((aData[0].MethodID>0)?aData[0].MethodID:0);
                $("#ddlPrinciple").val((aData[0].PrincipleID>0)?aData[0].PrincipleID:0);
                
                if(aData[0].Classification!=null && aData[0].Classification !="")
                {
                 $("#ddlClassification").val(aData[0].Classification.split('~')[0].toUpperCase());
                }
                else
                {
                 $("#ddlClassification").val('0');
                }
                
                $("#txtProcessingTime").val((aData[0].CutOffTimeValue!="" && aData[0].CutOffTimeValue!=null)?aData[0].CutOffTimeValue:'0');
                $("#ddlHours").val(aData[0].CutOffTimeType);

                if (aData[0].IsActive == 'Y') {
                    $("#chkActive").prop('checked', true);
                }
                else {
                    $("#chkActive").prop('checked', false);
                }

                if (aData[0].IsNABL == 'Y') {
                    $("#chkNABL").prop('checked', true);
                }
                else {
                    $("#chkNABL").prop('checked', false);
                }
              $('#btnSave').val(langData.Update);  
             $('#btnSave').show(); 
            

            //            $("#myModal").on("shown.bs.modal", function() {
            //                $(this).find('.modal-body').append(resultview1);
            //            }).modal('show');
        }
    });
  }

  function PopUpSave()
  
   {
   
   if ($('#txtAnalyteName').val()=='' && document.getElementById("hdnInvestigationID").value!=-1)
  {
  alert(langData.alert_valid_analyte);
  return false;
  
  }
  
  else if($('#ddlHours').val()==0 || $('#ddlHours').val()==null)
  {
  alert(langData.alert_processingtime);
  return false;
  }
  else if($('#txtProcessingTime').val()==null || $('#txtProcessingTime').val()=='' )
  {
    alert(langData.alert_processingtime);
  return false;
  }
   
   
   
                
       var pOrgID = document.getElementById("hdnOrgID").value;
       var pAnalyteName = $('#txtAnalyteName').val();
       var pDepatmentID =($('#ddlDepartment').val()>0)?$('#ddlDepartment').val():0 ;
       var pContatinerID =($('#ddlAdditive').val()>0)?$('#ddlAdditive').val():0 ;
       var pResultValueType =($('#ddlResultValue').val().length>1)?$('#ddlResultValue').val():''  ;
       var pSampleID =  ($('#ddlSampleType').val()>0)?$('#ddlSampleType').val():0 ;
       var pDecimalPlaces =  ($('#txtDecimalPlaces').val()>0)?$('#txtDecimalPlaces').val():0 ;
       var pMethodID =  ($('#ddlMethod').val()>0)?$('#ddlMethod').val():0;
       var pPrincipleID =  ($('#ddlPrinciple').val()>0)?$('#ddlPrinciple').val():0 ;
       var pClassfication =  ($('#ddlClassification').val().length>1)?$('#ddlClassification').val():'';
       
       var pCutOffTimeValue = ($('#txtProcessingTime').val().length>0)?$('#txtProcessingTime').val(): 0 ;
       var pCutOffTimeType = $('#ddlHours').val();
          if ($("#chkActive").prop('checked') == true) {
              pIsActive = "Y";
          }
          else {
              pIsActive = "N";
          }
          if ($("#chkNABL").prop('checked') == true) {
              pIsNABL = "Y";
          }
          else {
              pIsNABL = "N";
          }
          var InvestigationID = $("#hdnAnalyteValue").val();
          
         
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "../QMS.asmx/pUpdateAnalyteMasrer",
              //data: JSON.stringify(obj),
              data: JSON.stringify({ pOrgID: pOrgID, pAnalyteName: pAnalyteName, pDepatmentID: pDepatmentID, pContatinerID: pContatinerID,
              pResultValueType: pResultValueType, pSampleID: pSampleID, pDecimalPlaces: pDecimalPlaces, pMethodID: pMethodID, pPrincipleID: pPrincipleID,
              pClassfication: pClassfication, pCutOffTimeValue: pCutOffTimeValue, pCutOffTimeType: pCutOffTimeType, pIsActive: pIsActive, pIsNABL: pIsNABL, InvestigationID: InvestigationID
              }),
              dataType: "json",
              async: false,
              success: function(data) {
              GetAnalyteMasrer(-1);
                  Clear();
                  alert(langData.alert_update);
                  
              },
              error: function(xhr, status, error) {
               Clear();
                  alert(langData.alert_wentwrong);
                  return false;
                 
              }

          });

        } 

function btnDelete_OnClick(ID) {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/DeleteAnalyteMasrer",
        data: JSON.stringify({ ID: ID }),
        dataType: "json",
        async: false,
        success: function(data) {
            alert(langData.alert_analytedelete);
            Clear();
            return false;
        },
        error: function(xhr, status, error) {
            alert(error);
            return false;
        }
    });
    return false;
}


function LoadAnalyteMasrer() {
    if (txtAnalyteName != null && AnalyteValue != null) {
        if (AnalyteValue != '' && txtAnalyteName != '') {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/SearchAnalyteMasrer",
                data: "{ 'Orgid':'" + OrgId + "'})",
                dataType: "json",
                async: false,
                success: function(data) {
                    alert(langData.alert_save);
                    Clear();
                    return false;
                },
                failure: function(msg) {
                    alert(msg);
                }
            });
        }
        else {
            $("#txtAnalyteName").focus();
            alert(langData.alert_analytename);
            return false;
        }
    }
}

//function OnlyNumbers(e) {
//    var regex = new RegExp("^[0-9.]+$");
//    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
//    if (regex.test(str)) {
//        return true;
//    }

//    e.preventDefault();
//    return false;
//}

function OnlyNumbers(elementRef) {  
  
    var keyCodeEntered = (event.which) ? event.which : (window.event.keyCode) ?    window.event.keyCode : -1;  
  
    if ((keyCodeEntered >= 48) && (keyCodeEntered <= 57)) {  
  
    return true;  
  
}  
  
// '.' decimal point...  
  
else if (keyCodeEntered == 46) {  
  
// Allow only 1 decimal point ('.')...  
  
if ((elementRef.value) && (elementRef.value.indexOf('.') >= 0))  
  
    return false;  
  
else  
  
    return true;  
  
}  
  
    return false;  
  
}  