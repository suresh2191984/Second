function TextBoxpressBrowserRefresh(e) {
    var keycode = (window.event) ? event.keyCode : e.keyCode;
    if (keycode == 13) {
        //alert("Doing browser refresh may cause loss or unstable data. Please be sure before continuing");
        event.keyCode = 0;
        event.returnValue = false;
        return false;
    }
}

var ActionType = 'Gross';
var forDrpSelect = 'Gross';
var SaveFlag = '';
var intCount = 0;
var Serverdate = document.getElementById('hdnOrgDate').value;
$(document).ready(function() {
compareBtwDate();
    fnStatusDrpDown(ActionType);
    intCount = 0;
    $('#txtFDate').val(Serverdate);
    $('#txtTDate').val(Serverdate);
    document.getElementById('lblCount').innerHTML = '';
    setTimeout(function() {
        var ContentHeight = $('.contentdata').height() - 12;
        $('#tabs').css("min-height", ContentHeight);
    }, 2000);
    $('#TissueRadiobtns').hide();
    $("#trTissueBlock").hide();
    $("#trTissueSilde").hide();
    $('.stain').hide();
    $('.datebtn').hide();
});
$(function() {
    $("#tabs").tabs();
});

$('.tabdsg').click(function() {
$('#txtFDate').val(Serverdate);
$('#txtTDate').val(Serverdate);
    ActionType = this.id;
    document.getElementById('lblCount').innerHTML = '';
    ClearALL();
    $('.datebtn').hide();
    $('#MainDateTimePicker').val(document.getElementById('hdnOrgDateTime').value);
    $('#txtBlockNo').val('');
    $('#txtBlockTye').val('');
    if (ActionType == "Gross") {
        fnStatusDrpDown(ActionType);
        $('#TissueRadiobtns').hide();
        $("#trTissueBlock").hide();
        $("#trTissueSilde").hide();
        forDrpSelect = "Gross";
        
    }
    else if (ActionType == "Tissue") {
        fnStatusDrpDown(ActionType);
        $("#TissuePre").prop("checked", true);
        $('#TissueRadiobtns').show();
        $("#trTissueBlock").show();
        $("#trTissueSilde").hide();
       
        forDrpSelect = "Tissue Processing";
    }
    else if (ActionType == "Micro") {
    $('.slide').val('');
        fnStatusDrpDown(ActionType);
        $('#TissueRadiobtns').hide();
        $("#trTissueBlock").hide();
        $("#trTissueSilde").hide();
        
        forDrpSelect = "Microscopy";
        $('.stain').show();
        $("#trTissueSilde").show();
    }
    document.getElementById('GrossContent').innerHTML = '';
    document.getElementById('TissueContent').innerHTML = '';
    document.getElementById('MicroContent').innerHTML = '';
});

function ClearALL() {
    $('#txtVisitNos').val('');
    $('#txtPatientNo').val('');
    $('#txtHistopath').val('');
    $('#txtPatientName').val('');
    var InvID = 0;
    $('#hdnSampleID').val('0');
    $('#hdnContainer').val('0');
    $('#txtBarCode').val('');
    $('#txtTissue').val('');
//    $('#txtFDate').val(Serverdate);
//    $('#txtTDate').val(Serverdate);
    // $('#drpStatus').val('Pending');
    $('#txtContainer').val('');
    $('#txtINV').val('');
    $('#txtSpeciman').val('');
    $('#hdnInvID').val('0');
    intCount = 0;
}

function searchData() {
    getdata(ActionType,'');
    //ClearALL();
}
var lstPatHisto = [];

function fninputGetArea(ActionType) {
    var VisitNumber = $('#txtVisitNos').val();
    var PatientNo = $('#txtPatientNo').val();
    var HistopathNumber = $('#txtHistopath').val();
    var PatientName = $('#txtPatientName').val();
    var InvID = $('#hdnInvID').val();
    var SampleCode = $('#hdnSampleID').val();
    var ContainerID = $('#hdnContainer').val();
    var BarCodeNos = $('#txtBarCode').val();
    var TissueType = $('#txtTissue').val();
    var FromDate = $('#txtFDate').val();
    var ToDate = $('#txtTDate').val();
    var Status = $('#drpStatus').val();
    var BlockNos = $('#txtBlockNo').val();
    var BlockType = $('#txtBlockTye').val();
    var SlideNos = $('#txtSideNo').val();
    var SlideType = $('#txtSlideType').val();
    var Stain = $('#txtStain').val();

    lstPatHisto.push({
        VisitNumber: VisitNumber,
        PatientNumber: PatientNo,
        PatientName: PatientName,
        HistopathNumber: HistopathNumber,
        InvID: InvID,
        SampleCode: SampleCode,
        SampleContainerID: ContainerID,
        TissueType: TissueType,
        BarcodeNumber: BarCodeNos,
        FromDate: FromDate,
        ToDate: ToDate,
        Status: Status,
        BlockNo: BlockNos,
        BlockType: BlockType,
        SlideNo: SlideNos,
        SlideType: SlideType,
        StainType: Stain
    });

}

function getdata(ActionType, SaveFlag) {
    var FromDate = $('#txtFDate').val();
    var ToDate = $('#txtTDate').val();
    if (FromDate == '' || ToDate == '') {
        ValidationWindow("Please Enter FromDate & ToDate!!", "Alert");
        return false;
    }
    fninputGetArea(ActionType);
    $('#TissueContent').show();
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/GetHistopathSpecimenDetailsEntrySearch",
        data: JSON.stringify({ lstPatHisto: lstPatHisto[0], ActionType: ActionType }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(msg) {
            document.getElementById('lblCount').innerHTML = '';
            lstPatHisto = [];
            //            fnDate();

            var Serverdate = document.getElementById('hdnOrgDate').value;
            var DrpStatusContent = document.getElementById('drpStatus').innerHTML;
            data = JSON.parse(msg.d);
            if (data.length == 0 && SaveFlag != 'S') {
                ValidationWindow("No Matching Records Found!!!", "Alert");
                document.getElementById('GrossContent').innerHTML = '';
                document.getElementById('TissueContent').innerHTML = '';
                document.getElementById('MicroContent').innerHTML = '';
                $('.datebtn').hide();
                ClearALL();
                return false;
            }
            else {
                if (ActionType == "Gross") {
                    $('#TissueRadiobtns').hide();

                 tblStruct = "<div class='w-100p'><table  class='display'  id='tblEnterTissue'> <thead><tr ><th><input type='checkbox' onclick='SelectALL();' id='selectall' class='chkall'>Select</th><th >Visit No</th><th >Patient No</th><th > Histo No</th><th  > Patient Name</th><th > Investigations</th><th > Sample Name</th><th > Container</th><th > BarCode No</th><th> Tissue Type</th><th> Completion Time</th><th> Status</th></tr></thead><tbody>";
                $.each(data, function(i, item) {

                    var iddd = "  id= datergr" + i++ + ""

                    tblStruct += "<tr><td><input type='checkbox' id='" + i++ + "'  class='ckh' >" + "</td><td><span class='vistnos'>" + item.VisitNumber + "</span></td><td>" + item.PatientNumber + "</td><td>" + item.Histo + "</td><td>" + item.PatientName + "</td><td>" + item.Name + "</td><td>" + item.Speciman + "</td><td>" + item.Container + "</td><td><span class='lblBarcode'>" + item.BarcodeNumber + "</span></td><td>" + item.TissueType + "</td><td>" + '<Input type="text" class="dateTimePicker" value="' + item.CompletionTime + '" ></Input>' + "</td><td><select id='drpStatus' class='drp'>" + DrpStatusContent + " </select> </td></tr>";

                });

                tblStruct += "</tbody></table></div>";

                document.getElementById('GrossContent').innerHTML = '';
                document.getElementById('GrossContent').innerHTML = tblStruct;
 bindscroll();

            }
            else if (ActionType == "Tissue") {
                $('#TissueRadiobtns').show();
                tblStruct = "<div class='w-100p'><table  class='display'  id='tblEnterTissue'><thead><tr><th><input type='checkbox' onclick='SelectALL();' id='selectall' class='chkall'>Select</th><th>Visit No</th><th>Patient No</th><th> Histo No</th><th> Patient Name</th><th> Investigations</th><th> Sample Name</th><th> Container</th><th> BarCode No</th><th> Tissue Type</th><th> Block No</th><th> Block Type</th><th> Completion Time</th><th> Status</th></tr></thead><tbody>";
                $.each(data, function(i, item) {

                    tblStruct += "<tr><td><input type='checkbox' id='" + i++ + "'  class='ckh' >" + "</td><td><span class='vistnos'>" + item.VisitNumber + "</span></td><td>" + item.PatientNumber + "</td><td>" + item.Histo + "</td><td>" + item.PatientName + "</td><td>" + item.Name + "</td><td>" + item.Speciman + "</td><td>" + item.Container + "</td><td><span class='lblBarcode'>" + item.BarcodeNumber + "</span></td><td>" + item.TissueType + "</td><td><span class='blockNos'>" + item.BlockNumber + "</span></td><td>" + item.BlockType + "</td><td>" + '<Input type="text" class="dateTimePicker" value="' + item.CompletionTime + '" ></Input>' + "</td><td><select id='drpStatus' class='drp'>" + DrpStatusContent + " </select> </td></tr>";

                });
                tblStruct += "</tbody></table></div>";
                document.getElementById('TissueContent').innerHTML = '';
                document.getElementById('TissueContent').innerHTML = tblStruct;
 bindscroll();
            }
            else if (ActionType == "Slide") {
                $('#TissueRadiobtns').show();
                tblStruct = "<div class='w-100p'> <table class='display' id='tblEnterTissue'><thead><tr><th><input type='checkbox' onclick='SelectALL();' id='selectall' class='chkall'>Select</th><th>Visit No</th><th>Patient No</th><th> Histo No</th><th> Patient Name</th><th> Investigations</th><th> Sample Name</th><th> Container</th><th> BarCode No</th><th> Tissue Type</th><th> Slide No</th><th> Slide Type</th><th> Completion Time</th><th> Status</th></tr></thead><tbody>";
                $.each(data, function(i, item) {

                        tblStruct += "<tr><td><input type='checkbox' id='" + i++ + "'  class='ckh' >" + "</td><td><span class='vistnos'>" + item.VisitNumber + "</span></td><td>" + item.PatientNumber + "</td><td>" + item.Histo + "</td><td>" + item.PatientName + "</td><td>" + item.Name + "</td><td>" + item.Speciman + "</td><td>" + item.Container + "</td><td><span class='lblBarcode'>" + item.BarcodeNumber + "</span></td><td>" + item.TissueType + "</td><td><span class='slidenos'>" + item.SlideNo + "</span></td><td>" + item.SlideType + "</td><td>" + '<Input type="text" class="dateTimePicker" value="' + item.CompletionTime + '" ></Input>' + "</td><td><select id='drpStatus' class='drp'>" + DrpStatusContent + " </select> </td></tr>";

                });
                tblStruct += "</tbody></table></div>";
                document.getElementById('TissueContent').innerHTML = '';
                document.getElementById('TissueContent').innerHTML = tblStruct;
 bindscroll();
            }
            else if (ActionType == "Stain") {
                $('#TissueRadiobtns').show();
                tblStruct = "<div class='w-100p'><table border=1 style='width: 1340px;padding: 10px;margin:auto;' id='tblEnterTissue'><thead><tr><th><input type='checkbox' onclick='SelectALL();' id='selectall' class='chkall'>Select</th><th>Visit No</th><th>Patient No</th><th> Histopathlogy No</th><th> Patient Name</th><th> Investigations</th><th> Sample Name</th><th> Container</th><th> BarCode No</th><th> Tissue Type</th><th> Slide No</th><th> Slide Type</th><th> Staining Type</th><th> Completion Time</th><th> Status</th></tr></thead><tbody>";
                $.each(data, function(i, item) {

                        tblStruct += "<tr><td><input type='checkbox' id='" + i++ + "'  class='ckh' >" + "</td><td><span class='vistnos'>" + item.VisitNumber + "</span></td><td>" + item.PatientNumber + "</td><td>" + item.Histo + "</td><td>" + item.PatientName + "</td><td>" + item.Name + "</td><td>" + item.Speciman + "</td><td>" + item.Container + "</td><td><span class='lblBarcode'>" + item.BarcodeNumber + "</span></td><td>" + item.TissueType + "</td><td><span class='slidenos'>" + item.SlideNo + "</span></td><td>" + item.SlideType + "</td><td>" + item.StainType + "</td><td>" + '<Input type="text" class="dateTimePicker" value="' + item.CompletionTime + '" ></Input>' + "</td><td><select id='drpStatus' class='drp'>" + DrpStatusContent + " </select> </td></tr>";

                });
                tblStruct += "</tbody></table></div>";
                document.getElementById('TissueContent').innerHTML = '';
                document.getElementById('TissueContent').innerHTML = tblStruct;
 bindscroll();
            }
            else if (ActionType == "Micro") {
                $('#TissueRadiobtns').hide();

                tblStruct = "<div class='w-100p'><table border=1 class='w-100p display' id='tblEnterTissue'><thead><tr><th><input type='checkbox' onclick='SelectALL();' id='selectall' class='chkall'>Select</th><th>Visit No</th><th>Patient No</th><th> Histopathlogy No</th><th> Patient Name</th><th> Investigations</th><th> Sample Name</th><th> Container</th><th> Slide No</th><th> Slide Type</th><th> Staining Type</th><th> Completion Time</th><th> Status</th></tr></thead><tbody>";
                $.each(data, function(i, item) {

                        tblStruct += "<tr><td><input type='checkbox' id='" + i++ + "'  class='ckh' >" + "</td><td><span class='vistnos'>" + item.VisitNumber + "</span></td><td>" + item.PatientNumber + "</td><td>" + item.Histo + "</td><td>" + item.PatientName + "</td><td>" + item.Name + "</td><td>" + item.Speciman + "</td><td>" + item.Container + "</td><td><span class='slidenos'>" + item.SlideNo + "</span></td><td>" + item.SlideType + "</td><td>" + item.StainType + "</td><td>" + '<Input type="text" class="dateTimePicker" value="' + item.CompletionTime + '" ></Input>' + "</td><td><select id='drpStatus' class='drp'>" + DrpStatusContent + " </select> </td></tr>";

                });
                tblStruct += "</tbody></table></div>";
                    document.getElementById('GrossContent').innerHTML = '';
                document.getElementById('MicroContent').innerHTML = '';
                    document.getElementById('TissueContent').innerHTML = '';
                document.getElementById('MicroContent').innerHTML = tblStruct;
 bindscroll();
            }
            // deal();
            //$('#tblEnterTissue').fixedHeaderTable({ footer: false, cloneHeadToFoot: true, fixedColumn: false });
            $('.datebtn').show();
            if ($('#drpStatus').val() != 'Pending') {
                $(".drp").attr("disabled", "true");
            }
            $(".drp option[value='" + $('#drpStatus').val() + "']").attr("selected", "selected");
                if (data.length == 0) {
                    document.getElementById('GrossContent').innerHTML = '';
                    document.getElementById('MicroContent').innerHTML = '';
                    document.getElementById('TissueContent').innerHTML = '';
                    document.getElementById('MicroContent').innerHTML = '';
                    $('.datebtn').hide();
                }
            }
            SelectALL();
            ChkClick();
        },
        error: function(msg) {
           // alert(msg.d);
        }

    });



}

$('.Histo').change(function() {
//alert(this.id);
$('#MainDateTimePicker').val(document.getElementById('hdnOrgDateTime').value);
    $('.slide').val('');
    ActionType = this.value;
    $('#TissueContent').hide();
    $('.datebtn').hide();
    if (ActionType == "Tissue") {
        $("#trTissueBlock").show();
        $("#trTissueSilde").hide();
        $('.stain').hide();
        fnStatusDrpDown(ActionType);
        forDrpSelect = "Tissue Processing";
    }
    else if (ActionType == "Slide") {
        $("#trTissueSilde").show();
        $("#trTissueBlock").hide();
        $('.stain').hide();
        fnStatusDrpDown(ActionType);
        forDrpSelect = "Slide Preparation";

    }
    else if (ActionType == "Stain") {
        $('.stain').show();
        $("#trTissueSilde").show();
        $("#trTissueBlock").hide();
        fnStatusDrpDown(ActionType);
        forDrpSelect = "Staining";
    }
    document.getElementById('lblCount').innerHTML = '';
});
function deal() {
    $('#tblEnterTissue').Scrollable({
        ScrollHeight: 150
    });
}

$(document).ready(
 function() {


     fnDate();
     $('#MainDateTimePicker').val(document.getElementById('hdnOrgDateTime').value);

 });

function fnDate() {

    $('.dateTimePicker').datetimepicker({
        dateFormat: 'dd/mm/yy',
        timeFormat: "hh:mm tt",
        defaultDate: "+1w",
        changeMonth: true,
        showAnim: "slide",
        changeYear: true,
        showOn: "both",
        buttonImage: "../StyleSheets/start/images/calendar.gif",
        //  buttonImageOnly: true,
       // minDate: 0,

        yearRange: '1900:2100',

        onSelect: function(dateText, inst) {
            $(".ckh:checked").each(function(i, n) {
                $(this).closest("tr").find('.dateTimePicker').val(dateText);

                // alert(res + '  ' + resBarCode);
            });
        }


    })
}

$('body').on('focus', ".dateTimePicker", function() {

    $('.dateTimePicker').datetimepicker({
        dateFormat: 'dd/mm/yy',
        timeFormat: "hh:mm tt",
        defaultDate: "+1w",
        changeMonth: true,
        showAnim: "slide",
        changeYear: true,
        // showOn: "both",
        //  buttonImage: "../StyleSheets/start/images/calendar.gif",
        //  buttonImageOnly: true,
       // minDate: 0,

        yearRange: '1900:2100',

        onSelect: function(dateText, inst) {
            // alert(dateText);
        }


    })

});

//function ChkClick() {
//    $('input[type="checkbox"]').click(function() {
//        if (this.checked) {
//            $(this).closest("tr").find('.dateTimePicker').attr('readOnly', false);
//            $(this).closest("tr").find('.dateTimePicker').css('background-color', 'white');
//        }
//        else {
//            $(this).closest("tr").find('.dateTimePicker').attr('readOnly', true);
//            $(this).closest("tr").find('.dateTimePicker').css('background-color', '#ebf6f8');
//        }
//    });
//}

function fnStatusDrpDown(input) {
    $.ajax({

        type: "POST",

        contentType: "application/json; charset=utf-8",

        url: "../WebService.asmx/GetDropDownHistoStatus",

        data: JSON.stringify({ ActinType: input }),

        dataType: "json",
        async: false,
        success: function(Result) {
         if (Result.d.length > 0) {
            $('#drpStatus').empty();
            $.each(Result.d, function(key, value) {

                $("#drpStatus").append($("<option></option>").val(value.Name).html(value.Name));

            });
            }
        },

        error: function(Result) {

            alert("Error");

        }

    });


}
function SaveStatusTime() {
    var lstPatientHistoStatusDetails = [];
    var BarCode = '';
    $(".ckh:checked").each(function(i, n) {
        var CompletionTime = $(this).closest("tr").find('.dateTimePicker').val();
        var Status = $(this).closest("tr").find('#drpStatus').val();
        if (ActionType == 'Tissue') {
            BarCode = $(this).closest("tr").find('.blockNos')[0].innerHTML;
        }
        else if (ActionType == 'Slide' || ActionType == 'Stain' || ActionType == 'Micro') {
            BarCode = $(this).closest("tr").find('.slidenos')[0].innerHTML;
        }

        else {
            BarCode = $(this).closest("tr").find('.lblBarcode')[0].innerHTML;
        }

        // BarCode = $(this).closest("tr").find('.lblBarcode')[0].innerHTML;
        var PatientVisitID = $(this).closest("tr").find('.vistnos')[0].innerHTML;
        //alert(CompletionTime + '  ' + Status + '  ' + ActionType + ' ' + PatientVisitID);
        if (Status != "Pending") {
            lstPatientHistoStatusDetails.push({
            VisitNumber: PatientVisitID,
                BarcodeNumber: BarCode,
                CompletionTime: yyyymmdd(CompletionTime),
                Status: Status
            });
        }

        // alert(res + '  ' + resBarCode);
    });
    if (lstPatientHistoStatusDetails.length > 0) {
        intCount = 0;
        $.ajax({

            type: "POST",

            contentType: "application/json; charset=utf-8",

            url: "../WebService.asmx/SaveHistoSpecimenDetailsEntry",

            data: JSON.stringify({ lstPatientHistoStatusDetails: lstPatientHistoStatusDetails, ActionType: ActionType }),

            dataType: "json",

  async: false,
            success: function(Result) {
                if (Result.d > 0) {
                    //  alert('rgr');
                   
                    ValidationWindow("Saved Successfully !! ", "Alert");
                    getdata(ActionType,'S');

                }

            },

            error: function(Result) {

                alert("Error");

            }

        });
    }
    else {
        ValidationWindow("Please Select Aleast One Record !! ", "Alert");
    }
}


function ContainerAutoCom(eve) {
    var Cont = '';
    var SampleName = '';
    var Name = '';
    // var GetCtrlID = eve.target.id;
    if (eve == 'txtContainer') {
        Cont = $('#txtContainer').val();
        $('#hdnContainer').val('0');
        SampleName = '';
        Name = '';
        GetCtrlID = '';

    }
    else if (eve == 'txtSpeciman') {
        Cont = '';
        SampleName = $('#txtSpeciman').val();
        $('#hdnSampleID').val('0');
        Name = '';
        GetCtrlID = '';
    }
    else if (eve == 'txtINV') {
        Cont = '';
        SampleName = '';
        Name = $('#txtINV').val();
        $('#hdnInvID').val('0');
        GetCtrlID = '';
    }

    $(function() {
    var DoctorName = '';
        GetCtrlID = '';
        $("#" + eve).autocomplete({
            source: function(request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: '../WebService.asmx/GetINVandSampleandContainerDetails',
                    data: "{'Name': '" + Name + "','SampleName': '" + SampleName + "','ContainerName':'" + Cont + "','DoctorName':'" + DoctorName + "'}",
                    dataType: "json",
                      async: false,
                    success: function(data) {
                        if (data.d.length > 0) {
                            response($.map(data.d, function(item) {

                                try {

                                    return {
                                        label: item.Name,
                                        val: item.ID

                                    }
                                }
                                catch (er) {
                                }
                            }


                    ))
                        } else {
                            response([{ label: 'No results found.', val: -1}]);
                            //Clear();

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

                if (eve == 'txtContainer') {
                    // alert(i.item.val);
                    // hdnContainer
                    $('#hdnContainer').val(i.item.val);
                } else if (eve == 'txtSpeciman') {
                    //alert(i.item.val);
                    $('#hdnSampleID').val(i.item.val);
                } else if (eve == 'txtINV') {
                    $('#hdnInvID').val(i.item.val);
                }

            },
            minLength: 2
        });
    });
}

function ChkClick() {


    $('.ckh').click(function() {

        if (this.checked) {
            intCount += 1;
            if ($(this).closest("tr").find('.drp')[0].disabled == false) {
                $(this).closest("tr").find('.drp').val(forDrpSelect);

            }

        }
        else {
            if (intCount != 0) {
                intCount -= 1;
            }
            if ($(this).closest("tr").find('.drp')[0].disabled == false) {
                $(this).closest("tr").find('.drp').val("Pending");
            }
            $('#selectall').prop('checked', false);
        }
        document.getElementById('lblCount').innerHTML = intCount;
    });
}

function SelectALL() {

    $("#tblEnterTissue tr:not(:first)").each(function(i, n) {
        var $row = $(n);
        //debugger;
        intCount = $("#tblEnterTissue tr:not(:first)").length;
        if ($('#selectall').is(':checked')) {
            $row.find("input[class$='ckh']").prop('checked', true);
            document.getElementById('lblCount').innerHTML = intCount;
            if ($('.drp')[0].disabled == false) {
                $('.drp').val(forDrpSelect);
            }

          
        }
        else {
            $row.find("input[class$='ckh']").prop('checked', false);
            document.getElementById('lblCount').innerHTML = 0;
            intCount = 0;
            if ($('.drp')[0].disabled == false) {
                $('.drp').val("Pending");
            }
           
        }
    });

}

function Search_Gridview(strKey, strGV) {
    var strData = strKey.value.toLowerCase().split(" ");
    var tblData = document.getElementById(strGV);
    var rowData;
    for (var i = 1; i < tblData.rows.length; i++) {
        rowData = tblData.rows[i].innerHTML;

        // x = "grdPendingDetails_ctl" + i + "_chkreport";
        //document.getElementById(x).checked = false;
        var styleDisplay = 'none';
        for (var j = 0; j < strData.length; j++) {
            if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                styleDisplay = '';
            else {
                styleDisplay = 'none';
                break;
            }
        }
        tblData.rows[i].style.display = styleDisplay;

    }
}

function yyyymmdd(date) {
    var getdatetime = [];
    getdatetime = date.split(' ');
    var d = new Date(getdatetime[0].split("/").reverse().join("-"));
    var dd = d.getDate();
    if (dd.toString().length <= 1) {
        dd = '0' + dd;
    }
    var mm = d.getMonth() + 1;
    var mlen = mm.toString().length;
    if (mlen <= 1) {
        mm = '0' + mm;
    }
    var yy = d.getFullYear();
    var newdate = yy + "/" + mm + "/" + dd + ' ' + getdatetime[1] + ' ' + getdatetime[2];
    return newdate;
}

function compareBtwDate() {
    $(".dateTimePicker").blur(function() {
    var DateIn = $('#MainDateTimePicker').val();
    $(".ckh:checked").each(function(i, n) {
    $(this).closest("tr").find('.dateTimePicker').val(DateIn);

        // alert(res + '  ' + resBarCode);
    });
      //  fnDate();
//        var DateIn = $('#MainDateTimePicker').val();
//        var getdatetime = [];
//        getdatetime = DateIn.split(' ');
//        var DateGet = new Date(getdatetime[0].split("/").reverse().join("-"));
//        var SeverDateGet = new Date(Serverdate.split("/").reverse().join("-"));

//        var serverdate = SeverDateGet.getDate();
//        var DateGetdd = DateGet.getDate();

//        //        if (dd.toString().length <= 1) {
//        //            dd = '0' + dd;
//        //        }

//        var DateGetmm = DateGet.getMonth() + 1;
//        var serverdatemm = SeverDateGet.getMonth() + 1;



//        var DateGetyy = DateGet.getFullYear();
//        var SeverDateGetyy = SeverDateGet.getFullYear();

//        if (DateGetyy == SeverDateGetyy || DateGetmm < serverdatemm) {


//        }

//        if (DateGetyy < SeverDateGetyy) {
//            alert('Years');
//            if (DateGetmm < serverdatemm) {
//                alert('Month');
//                if (DateGetdd < SeverDateGet) {
//                    alert('day');
//                }

//            }

//        }
//        else {
//            fnDate();
//        }

//        alert($('#MainDateTimePicker').val());
    });

}