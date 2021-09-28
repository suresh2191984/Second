var LoadCascadingDDL_URL = '../QMS.asmx/QMS_LoadCascadingDDL';

$(function() {
   
    loadLotLevel();
    AjaxCall('', 'ddlLotName', LoadCascadingDDL_URL, false, '');
    var Deptctrl = $('select[data="Department"]');
    var Orgctrl = $('select[data="Organization"]');
    var LocationCtrl = $('select[data="Location"]');

    if (Orgctrl.length > 0) {
        GetOrganization(Orgctrl, LocationCtrl);
    }
    if (LocationCtrl.length > 0) {
        GetLocation(Orgctrl, LocationCtrl);
    }
    if (Deptctrl.length > 0) {
        GetDepartment(Orgctrl, Deptctrl);
    }
    var chngDDL = $(LocationCtrl).attr('change');
    if (chngDDL != "" || chngDDL != null) {
        $('#' + chngDDL).on('change', function() {

            GetLocation(Orgctrl, LocationCtrl);
        });

    }
    var chngDDL1 = $(Deptctrl).attr('change');
    if (chngDDL1 != "" || chngDDL1 != null) {
        $('#' + chngDDL1).on('change', function() {

            GetDepartment(Orgctrl, Deptctrl);
        });

    }

});
function GetDepartment(Orgctrl, Deptctrl) {
    if ($(Orgctrl).val() > 0) {
//        ddlLocation(Deptctrl, $(Orgctrl).val());

        GetValues($(Orgctrl).val(), Deptctrl, 'Department');
    }
    else {
        $(Deptctrl).empty();
        $(Deptctrl).append($('<option></option>').val(0).html(langData.ddl_select));
    }
}
function GetLocation(Orgctrl,LocationCtrl) {
    if ($(Orgctrl).val() > 0) {
        ddlLocation(LocationCtrl, $(Orgctrl).val());
       
    }
    else {
        $(LocationCtrl).empty();
        $(LocationCtrl).append($('<option></option>').val(0).html(langData.ddl_select));
    } 
}
function GetValues(value, ctrl,GetID) {

   
    var obj = {};
    obj.Value = value;
    obj.CtrlName = GetID;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url:LoadCascadingDDL_URL,
        data: JSON.stringify(obj),
        dataType: "json",
        async: false,
        success: function(data) {//On Successfull service call
            var data_test = data.d;
     
            if ($(ctrl).length > 0) {

                if ($(ctrl).attr('multiple') == 'multiple') {
                    var arr = revereseArray(data_test);
                    $(ctrl).multiselect('dataprovider', arr);
                }
                else {
                    $(ctrl).empty();
                    $(ctrl).append('<option value="0">'+langData.ddl_select+'</option>');
                    $.each(data_test, function(key, value) {

                        //this refers to the current item being iterated over 

                        var option = $('<option/>');
                        option.attr('value', value.ID).text(value.Name);

                        $(ctrl).append(option);
                    });
                }
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
function loadLotLevel()
{
var ddlLevel='ddlLevel';
var LevelCtrl = '#ddlLevel';
var ddlLevelLot = 'ddlLevelLot';
var change = $(LevelCtrl).attr('change');
var lotName = $('#' + change);
if (change != null && change != '') {
    $(lotName).change(function() {
        var lotid = $(this).val();
        if (lotid != 0) {
            AjaxCall(lotid, ddlLevelLot, LoadCascadingDDL_URL, true, ddlLevel);
        }
    });
}
else 
{
    AjaxCall('', ddlLevel, LoadCascadingDDL_URL,false,'');
}
}
function GetConfigValue(ControKey,configKey,control) {

    var data_test;
    var obj = {};
    obj.Value = configKey;
    obj.CtrlName = ControKey;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: LoadCascadingDDL_URL,
        data: JSON.stringify(obj),
        dataType: "json",
        async:false,
        success: function(data) {//On Successfull service call

        if (data.d.length > 0) 
            {
                data_test = data.d[0].Name;

                $('#' + control).val(data_test);
            }

        },
        error: function(result) {
        alert(langData.alert_loadunable);
        }
    });

    return data_test;

}
function AjaxCall(value, CtrlName, URL,flag,ToControlName) {

//svar multi=$(
   // $('#ddlAnalyte').multiselect('dataprovider', resdata);
    var obj = {};
    obj.Value = value;
    obj.CtrlName = CtrlName;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        data: JSON.stringify(obj),
        dataType: "json",
        async: false,
        success: function(data) {//On Successfull service call
            var data_test = data.d;
            var ctrl = '#' + CtrlName;
            if (flag) {
                ctrl = '#' + ToControlName;
            }
            if ($(ctrl).length > 0) {

                if ($(ctrl).attr('multiple') == 'multiple') {
                    var arr = revereseArray(data_test);
                    $(ctrl).multiselect('dataprovider', arr);
                }
                else {
                    $(ctrl).empty();
                    $(ctrl).append('<option value="0">' + langData.ddl_select + '</option>');
                    $.each(data_test, function(key, value) {

                        //this refers to the current item being iterated over 

                        var option = $('<option/>');
                        option.attr('value', value.ID).text(value.Name);

                        $(ctrl).append(option);
                    });
                }
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


function LimitTextValidation(limitField, limitNum) {
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } else {
        // limitCount.value = limitNum - limitField.value.length;
    }

}


function SpecialCharRestriction(e) {
    var regex = new RegExp("^[a-zA-Z0-9-]+$");
    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    if (regex.test(str)) {
        return true;
    }

    e.preventDefault();
    return false;
}


function FilesAddDelete(DelFiles,IdentifyingID,IdentifyingType) 
{

    if (DelFiles.length > 0) {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/QMS_Filemanager_Delete",
            data: JSON.stringify({ Filedata: DelFiles }),
            dataType: "json",
            success: function(data) {
            },
            error: function(xhr, status, error) {
                alert(error);
            }
        });
    }
    var data = new FormData();
    var FormFiles = $("#txtfileupload").Attune_GetFiles();
    if (FormFiles.length > 0) {
        for (var i = 0; i < FormFiles.length; i++) {

            var ke = $("#hdnFilepath").val() + '~' + IdentifyingType + '~' + FormFiles[i][1] + '~' + IdentifyingID;
            data.append(ke, FormFiles[i][0]);
        }

        var options = {};
        options.url = "FileHandlerforQMS.ashx";
 
 
        options.type = "POST";
        options.data = data;
        options.contentType = false;
        options.processData = false;
        options.success = function(result) {
        };
        options.error = function(err) { alert(err.statusText); };
        $.ajax(options);

        $('#txtfileupload_wrap_list').html('');
        
        $("#txtfileupload").Attune_RemoveFiles();
    }
    DelFiles = [];

}
function dateformat(Date, format) {
    var date_string = moment(Date, "DD/MM/YYYY").format(format);
    return date_string;
}
function revereseArray(lst) {

    var resdata = [];
    $.each(lst, function(idx, val) {
        var obj = new Object();
        var label = val.Name;
        var value = val.ID;
        obj = { label: label, value: value };
        resdata.push(obj);

    });
    return resdata;
}

function checkMultiselect(text, control) {
    var ctrl = '#' + control + ' option';
    if (text != null && text != '') {
        var sOptions = [];
        sOptions = text.split(",");
        $(ctrl).removeAttr('selected');
        $.each(sOptions, function(key, value) {
            $("#" + control).multiselect('destroy');

            for (var i = 0; i <= $(ctrl).length - 1; i++) {
                if ($(ctrl)[i].text == value) {
                    $(ctrl)[i].selected = true;
                    break;
                }
            }

            $("#" + control).multiselect();
        });
    }
}
function showFile(file) {

    var fileName = $(file).attr('href');
    $("#dialog").dialog({
        modal: true,
        title: fileName,
        width: 540,
        height: 450,
        buttons: {
            Close: function() {
                $(this).dialog('close');
            }
        },
        open: function() {
            var object = "<object data=\"{FileName}\" type=\"application/pdf\" width=\"500px\" height=\"300px\">";
            object += "If you are unable to view file, you can download from <a href = \"{FileName}\">here</a>";
            object += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
            object += "</object>";
            object = object.replace(/{FileName}/g,fileName);
            $("#dialog").html(object);
        }
    });
}
var email='1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.@_'
var bksp = 'backspace'
var alt = 'alt'


function alpha(e,allow) {
var k;
k=document.all?parseInt(e.keyCode): parseInt(e.which);
return (allow.indexOf(String.fromCharCode(k))!=-1);
}
function GetOrganization(OrgCtrl,LocCtrl) {
    var obj = {};
    var Status = "Device"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/GetOrganizationsDashboard",
        // data: JSON.stringify({ Status: Status }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            $(OrgCtrl).empty();
            if (data.d.length >= 0) {
                var ArryLst = data.d;
                $(OrgCtrl).append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ArryLst, function(ind, val) {
                    $(OrgCtrl).append('<option value="' + val.OrgID + '">' + val.OrgName + '</option>');

                });
                if (data.d.length > 0) {

                    var oid = CurrentOrgID;
                    // $(OrgCtrl).val(data.d[0].OrgID);
                    $(OrgCtrl).val(oid);
                  
                }

            }
            else {
                $(OrgCtrl).append($('<option></option>').val(0).html(langData.ddl_select));
            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}

function ddlLocation(LocationCtrl,orgid) {
    var obj = {};
    var Status = "Device"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/GetLocationsForOrgDashboard",
        data: JSON.stringify({ OrgID: orgid }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            locCount = data.d.length;
            $(LocationCtrl).empty();
            if (data.d.length >= 0) {
                var ArryLst = data.d;
                $(LocationCtrl).append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ArryLst, function(ind, val) {
                $(LocationCtrl).append('<option value="' + val.AddressID + '">' + val.Location + '</option>');

                });
                if (data.d.length > 0) {
                    $(LocationCtrl).val(ILocationID);

                }
            }
            else {
                $(LocationCtrl).append($('<option></option>').val(0).html(langData.ddl_select));
            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}


function BindDDL(ctrl, lst, id, text)
{
    $(ctrl).append($('<option></option>').val(0).html(langData.ddl_select));
    $.each(lst, function(ind, val) {

    $(ctrl).append('<option value="' + val[id] + '">' + val[text] + '</option>');

    });
}
function getEntity(EntityName) {
    var d = "";
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/GetEntity",
        data: JSON.stringify({ t: "PlanAndSchedule_QMS" }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            d = data.d;
            d['FromDate'] = '2017/01/01 00:00:00';
            d['Todate'] = '2017/01/01 00:00:00';
            d['CreatedAt'] = '2017/01/01 00:00:00';
            d['ModifiedAt'] = '2017/01/01 00:00:00';
            d['UserID'] = 0;
            d['PlanScheduleID'] = 0;
        }

    });

    return d;
}
function GetCorrectdate(value) {

    if (value != null && value != '') {
        var date = new Date(parseInt(value.substr(6)));
        var month = date.getMonth() + 1;
        value = date.getDate() + "/" + month + "/" + date.getFullYear();
    }
    else
    { value = ""; }
    return value;
}