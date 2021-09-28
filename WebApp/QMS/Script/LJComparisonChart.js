$(document).ready(function() {
         $('#ddlLevel').multiselect();
});

var oTable=0;
var RecursiveFlag = false;
var PrevFailedRule = "";
var PrevFailedPart = "";
 var F1s =0;
 var TenX = 0;

function BindDDL(ControlName, list, Id, text, firstElement) {

    var returnCode = -1;
    if ($(ControlName).length > 0) {
        $(ControlName).empty();
        if (arguments.length == 5) {
            $(ControlName).append(firstElement)
        }
        $.each(list, function(key, value) {
            var option = $('<option/>');
            option.attr('value', value[Id]).text(value[text]);

            $(ControlName).append(option);
        });
        if (list.length == 1) {
            $(ControlName).prop("selectedIndex", 1);
        }
        returnCode = 1;
    }
    returnCode = 1;
}


 function ClearLJFilter() {
            
            $('#ddlLocation').val("-1");
            $('#ddlAnalyzer').val("-1");
            $('#ddlLotNo').val("-1");
            $('#ddlAnalyte').val("-1");
            $('#ddlLevel').val("0");
            $('#txtFromDate').val("");
            $('#txtToDate').val("");
                $('#FilterResult').hide();
        }

function LoadLotDDL() {
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
            $('#ddlLotNo').append('<option value="' + Item.LotID + '~' + Item.LotCode + '~' + Item.LotName + '~' + Item.MetaValueID + '~' + Item.Code + '">' + Item.LotCode + '</option>');
        });

    }
}

function DDLAjaxCall(value, CtrlName, URL) {
    var obj = {};
    obj.Value = value;
    obj.CtrlName = CtrlName;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        data: JSON.stringify(obj),
        dataType: "json",
        success: function(data) {//On Successfull service call
            var data_test = data.d;
            if ($('#' + CtrlName).length > 0) {

                $("#" + CtrlName).empty();
                $('#' + CtrlName).append('<option value="-1">'+langData.ddl_select+'</option>');
                $.each(data_test, function(key, value) {

                    //this refers to the current item being iterated over 

                    var option = $('<option/>');
                    option.attr('value', value.ID).text(value.Name);

                    $('#' + CtrlName).append(option);
                });
            }
            else {
                // BindMachines(data_test);
            }
            //  alert(data.GetDDlDataResult[0].StateName);
        },
        error: function(result) {
            alert(langData.alert_loadunable);
        } // When Service call fails
    });
}


function getddlName(controlname) {
    var ctrlName = null;
    if (controlname == "ddlLocation") {
        ctrlName = "ddlAnalyzer";
        return ctrlName;
    }
    else if (controlname == "ddlAnalyzer") {
        ctrlName = "ddlLotNo";
        return ctrlName;
    }

    else if (controlname == "ddlLotNo") {
        ctrlName = "ddlAnalyte";
        return ctrlName;
    }
    else if (controlname == "VendorList1") {
        ctrlName = "MachineList";
        return ctrlName;
    }
    else
        return 'NO';
}

function BindAutocomplete(CTRL, URL, Prefix, txtSamColPersonid, CtrlTxt) {
    var SelectedID;

    var Resultdata = [];
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        data: JSON.stringify({ "Suggesion": Prefix, "CtrlName": CtrlTxt }),
        dataType: "json",
        async: false,
        success: function(data) {
            $(txtSamColPersonid).val('-1');
            val = data.d;
            var len = data.d.length;
            $.each(val, function(i, Zon) {
                var obj = new Object();
                var value = Zon.Name;
                var id = Zon.UserID;
                obj = { "value": value, "id": id };
                Resultdata.push(obj);

            });
            var availableTags = [
                { "value": "Some Name", "id": 1 }, { "value": "Some Othername", "id": 2}];
            var test = [];

            $('#' + CTRL).autocomplete({
                source: Resultdata, 
                select: function(event, ui) {
                    $(txtSamColPersonid).val(ui.item.id);
           
                },
                minLength: 2,
                max: 6
            });
        }
    });
}

function LoadLJComparisonChart() {
    $('#FilterResult').hide();
    var obj = {};
    
    obj.LocationID = $('#ddlLocation').val();
    obj.InstrumentID = $('#ddlAnalyzer').val(); 
    obj.AnalyteID = $('#ddlAnalyte').val(); 
    //obj.Level = $('#ddlLevel').val();
    obj.LotID = $('#ddlLotNo').val(); 
    obj.FromDate = $('#txtFromDate').val();
    obj.ToDate = $('#txtToDate').val(); ;

    var LevelText = "";
    var intcount = 0;

    $("#ddlLevel option:selected").each(function() {
        var $this = $(this);
        if (intcount == 0) {
            LevelText = LevelText + $this.text();
        }
        else {
            LevelText += ',' + $this.text();
        }
        intcount++;
    });
    obj.Level = LevelText;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '../QMS.asmx/QMS_LJComparisonChartFilter',
        data: JSON.stringify(obj),
        dataType: "json",
        success: function(data) {//On Successfull service call           
            var LevelDataOne = [];
            var LevelDataTwo = [];
            var LevelDataThree = [];
            var boollvlone = false;
            var boollvltwo = false;
            var boollvlthree = false;

            var LevelOne = [];
            LevelOne = data.d[0];
            var lstlvlonedata = LevelOne.split(';');
            if (lstlvlonedata.length > 0) {
                boollvlone = true;
                for (var i = 0; i < lstlvlonedata.length - 1; i++) {
                    if (lstlvlonedata[i].split(',')[2] == 1) {
                        LevelDataOne.push({ label: lstlvlonedata[i].split(',')[0], y: parseFloat(lstlvlonedata[i].split(',')[1]) });
                    }
                    else if (lstlvlonedata[i].split(',')[2] == 2) {
                        LevelDataOne.push({ label: lstlvlonedata[i].split(',')[0], y: parseFloat(lstlvlonedata[i].split(',')[1]), color: "#ffdb99" });
                    }
                    else if (lstlvlonedata[i].split(',')[2] == 0) {
                        LevelDataOne.push({ label: lstlvlonedata[i].split(',')[0], y: parseFloat(lstlvlonedata[i].split(',')[1]), color: "red" });
                    }
                }
            }

            var LevelTwo = [];
            LevelTwo = data.d[1];
            var lstlvltwodata = LevelTwo.split(';');
            if (lstlvltwodata.length > 0) {
                boollvltwo = true;
                for (var i = 0; i < lstlvltwodata.length - 1; i++) {
                    if (lstlvltwodata[i].split(',')[2] == 1) {
                        LevelDataTwo.push({ label: lstlvltwodata[i].split(',')[0], y: parseFloat(lstlvltwodata[i].split(',')[1]) });
                    }
                    else if (lstlvltwodata[i].split(',')[2] == 2) {
                        LevelDataTwo.push({ label: lstlvltwodata[i].split(',')[0], y: parseFloat(lstlvltwodata[i].split(',')[1]), color: "#ffdb99" });
                    }
                    else if (lstlvltwodata[i].split(',')[2] == 0) {
                        LevelDataTwo.push({ label: lstlvltwodata[i].split(',')[0], y: parseFloat(lstlvltwodata[i].split(',')[1]), color: "red" });
                    }
                }
            }

            var LevelThree = [];
            LevelThree = data.d[2];
            var lstlvlthreedata = LevelThree.split(';');
            if (lstlvlthreedata.length > 0) {
                boollvlthree = true;
                for (var i = 0; i < lstlvlthreedata.length - 1; i++) {
                    if (lstlvlthreedata[i].split(',')[2] == 1) {
                        LevelDataThree.push({ label: lstlvlthreedata[i].split(',')[0], y: parseFloat(lstlvlthreedata[i].split(',')[1]) });
                    }
                    else if (lstlvlthreedata[i].split(',')[2] == 2) {
                        LevelDataThree.push({ label: lstlvlthreedata[i].split(',')[0], y: parseFloat(lstlvlthreedata[i].split(',')[1]), color: "#ffdb99" });
                    }
                    else if (lstlvlthreedata[i].split(',')[2] == 3) {
                        LevelDataThree.push({ label: lstlvlthreedata[i].split(',')[0], y: parseFloat(lstlvlthreedata[i].split(',')[1]), color: "red" });
                    }
                }
            }

            $('#OuterGraph').show();
            DrawLJComparisonChart(LevelDataOne, LevelDataTwo, LevelDataThree, boollvlone, boollvltwo, boollvlthree);

        },
        error: function(result) {
            alert(langData.alert_loadunable);
        }
    });
}


function DrawLJComparisonChart(LevelDataOne, LevelDataTwo, LevelDataThree, boollvlone, boollvltwo, boollvlthree) {
    var chart = new CanvasJS.Chart("chartContainer", {
//        theme: "light1",
        animationEnabled: true,
        title: {
            text: "LJ Comparison Chart"
        },
        axisY: {
            includeZero: false,
            suffix: "SD"
        },
        toolTip: {
            shared: "true"
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
        type: "spline",
            color:"Blue",
            showInLegend: true,
            visible: boollvlone,
            name: "Level 1",
            dataPoints: LevelDataOne
        },
	{
	    type: "spline",
	    color: "Brown",
	    showInLegend: true,
	    visible: boollvltwo,
	    name: "Level 2",
	    dataPoints: LevelDataTwo
	},
	{
	    type: "spline",
	    color: "Purple",
	    showInLegend: true,
	    visible: boollvlthree,
	    name: "Level 3",
	    dataPoints: LevelDataThree
}]
    });
    chart.render();
}

function toggleDataSeries(e) {
    if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
        e.dataSeries.visible = false;
    } else {
        e.dataSeries.visible = true;
    }
    chart.render();
}
