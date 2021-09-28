var txtOptionOI = '<div class="form-group"><label class="false-label">Options</label><div class="options"><div class="sortable-options-wrap">\
<ol class="sortable-options ui-sortable">{OpContent}</ol>\
   <div class="option-actions"><a class="add add-opt clickable" onclick="AddOptions(this);">Add Option +</a>\
   </div></div> </div></div><a class="close-field" onclick="editItems(this);">Close</a>';
var txtOptions = '<li class="ui-sortable-handle"><input type="radio" class="option-selected" value="false"  \
  ><input type="text" class="option-label" value="{olabel}" \
   ><input type="text" class="option-value" value="{ovalue}" >\
   <a class="remove btn" title="Remove Element" onclick="RemoveOptions(this);">×</a></li>';

var txtRadioOptions = '<div class="radio" onclick="SetRadio(this);">\
<input  class=""  value="{value}" type="radio">\
<label >{text}</label></div>';

var txtHeaderType = '<div  class="form-group subtype-wrap">\
<label >Type</label>\
<div class="input-wrap">\
<select  class="fld-subtype form-control">{options}</select>\
</div></div>';

var txtpanel = '<div class="panel panel-default" Descr="{labeltext}" ControlType="{ControlType}" onmouseleave="hidebuttons(this);" onmouseover="showbuttons(this)"><div class="panel-heading clearfix"><div class="row"><div  class="col-lg-9 headerType">\
<h3 type="{headertype}" control-type="header" key="" class="panel-title">{desc}</h3></div><div class="col-lg-3 text-right">\
<div style="display:none;" class="btn-group btn-group-sm buttons"><button type="button" class="btn btn-default sedit" onclick="editControl(this);" onmouseleave="onmouseleaveEdit(this);" onmouseover="onmouseoverEdit(this);"><i class="fa fa-pencil-square-o fa-lg iedit" aria-hidden="true"></i></button> <button type="button" class="btn btn-default" onclick="removeControl(this);" onmouseleave="onmouseleaveRemove(this);" onmouseover="onmouseoverRemove(this);"><i class="fa fa-window-close-o fa-lg iremove" aria-hidden="true"></i></button> </div>\
<span class="hide" onmouseleave="onmouseleaveRemove(this);" onmouseover="onmouseoverRemove(this);"\
 onclick="removeControl(this);" class="pull-right clickable"><i class="fa fa-window-close-o fa-lg iremove" aria-hidden="true">\
 </i></span><span class="hide" onmouseleave="onmouseleaveEdit(this);" onmouseover="onmouseoverEdit(this);" onclick="editControl(this);" class="pull-right clickable sedit"><i class="fa fa-pencil-square-o fa-lg iedit" aria-hidden="true">\
 </i></span></div></div></div><div class="panel-body"><div panel-content class="form-group">{content}</div></div><div class="panel-body panel1" style="display:none;"> \
 <div class="form-group"><label>Label</label><input class="form-control" type="text"></div></div> </div></div>';

function getcontrol(ctrl) {
    var descr = $('#txDescription').val();
    var val = $('#ddlControl').val();

    switch (val) {
        case 'input':
            // code block
            gettextarea(descr, 'input', val);
            break;
        case 'select':
            gettextarea(descr, 'select', val);
            // code block
            break;
        case 'number':
            gettextarea(descr, 'number', val);
            // code block
            break;
        case 'textarea':
            gettextarea(descr, 'textarea', val);
            // code block
            break;
        case 'radio-group':
            gettextarea(descr, 'radio-group', val);
            // code block
            break;
        case 'header':
            getheadertext(descr, 'header', val);
            // code block
            break;
        case 'NwithUnits':
            getnumberwithunits(descr, 'NwithUnits', val);
            // code block
            break;
        default:
            // code block
    }
    $('#txDescription').val('');
    $('#ddlControl').val(0);
}

function showbuttons(ctrl) {
    $(ctrl).find('.buttons').show();
}
function hidebuttons(ctrl) {
    $(ctrl).find('.buttons').hide();
}
function editItems(ctrl) {
    var ctrl = $(ctrl).closest('.panel').find('.sedit');
    editControl(ctrl[0]);
}

function editControl(ctrl) {
    var $this = $(ctrl);
    if (!$this.hasClass('panel-collapsed')) {

        var panel = $this.parents('.panel');
        var keyText = $(panel).find('.panel-title').attr('key');
        var ctrlType = $this.parents('.panel').attr('ControlType');
        var ctrlEditText = ''; // = ControlsArray[ctrlType][0].editText
        var prnt = $this.parents('.panel').find('.panel-body');
        //  var opns = $this.parents('.panel').find('.options');
        var description = $(panel[0]).attr('Descr');
        var closeTxt = "";
        switch (ctrlType) {
            case 'select':
                ctrlEditText = onSelectEdit($(prnt[0]).find('[control-type="select"]'));
                break;
            case 'NwithUnits':
                ctrlEditText = onNwithUnitsEdit($(prnt[0]).find('[control-type="select"]'));
                break;
            case 'radio-group':
                ctrlEditText = onRadioEdit($(prnt[0]).find('[control-type="radio-group"]'));
                break;
            case 'header':
                ctrlEditText = onHeaderEdit($this.parents('.panel').find('.panel-title'));
                break;
            default:
                closeTxt = '<a class="close-field" onclick="editItems(this);">Close</a>';
        }
        var IsRequiredF = "";
        if ($(panel).find('.panel-title').attr('IsRequired') == "Y") {
            IsRequiredF = "checked";
        }


        $(prnt[1]).html('');
        var RequiredText = '<div class="form-group"><label>Is Required</label><input Control-Type="checkbox" ' + IsRequiredF + ' style="margin-left:10px" onchange="setCheckedValue(this);" type="checkbox"></div>';
        var inputControl = '<div class="form-group"><label>Label</label><input Control-Type="label" class="form-control" value="' + description + '" type="text"></div><div class="form-group"><label>Key</label><input Control-Type="label" class="form-control" value="' + keyText + '" type="text" onkeyup="setKey(this);"></div>' + RequiredText + closeTxt;
        $(prnt[1]).append(inputControl + ctrlEditText);
        $(prnt[1]).slideDown();
        $(prnt[0]).slideUp();

        $this.addClass('panel-collapsed');

        // $this.find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
    } else {
        var ctrlType = $this.parents('.panel').attr('ControlType');
        var prnt = $this.parents('.panel').find('.panel-body');

        $this.removeClass('panel-collapsed');
        switch (ctrlType) {
            case 'select':
                SetOptions($(prnt[0]).find('[control-type="select"]'), $(prnt[1]).find('li'));
                break;
            case 'NwithUnits':
                SetOptions($(prnt[0]).find('[control-type="select"]'), $(prnt[1]).find('li'));
                break;
            case 'radio-group':
                SetRadioOptions($(prnt[0]).find('[control-type="radio-group"]'), $(prnt[1]).find('li'));
                break;
            case 'header':
                SetHeader($this.parents('.panel').find('.panel-title'), $(prnt[1]).find('.subtype-wrap'),$this.parents('.panel').find('.panel-title').attr('key'));
                break;
            default:
        }
        var lblTxt = $(prnt[1]).find('[control-type="label"]');


        $this.parents('.panel').find('.panel-title').html($(lblTxt).val());
        $this.parents('.panel').attr('Descr', $(lblTxt).val());

        $(prnt[1]).slideUp();
        $(prnt[0]).slideDown();
        //  $this.parents('.panel').find('.panel-title').show();
        // $this.find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
    }
}
function setCheckedValue(ctrl) {

    if ($(ctrl).is(":checked")) {
        $(ctrl).parents('.panel').find('[control-type="header"]').attr('IsRequired', 'Y');
    }
    else {
        $(ctrl).parents('.panel').find('[control-type="header"]').attr('IsRequired', 'N');
    }
}

function onlynumbers(e) {
    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display e rror message
        event.preventDefault();
    }
}
function SetHeader(ctrl1, ctrl2,keyvalue) {
    var type = (ctrl2).find('select');
    var hval = $(type).val();
    var htype = $(ctrl1).parents('.headerType');
    $(htype).html('');
    $(htype).html('<' + hval + ' key=' + keyvalue + ' control-type="header" class="panel-title"><' + hval + '>');
}

function setKey(ctrl) {
    $(ctrl).parents('.panel').find('[control-type="header"]').attr('key', $(ctrl).val());
}

function SetOptions(ctrl, ctrl2) {
    $(ctrl).empty();
    $.each(ctrl2, function(id, val) {
        var inpts = $(val).find('input');
        $(ctrl).append('<option value="' + inpts[2].value + '">' + inpts[1].value + '</option>');
    });

}

function SetRadioOptions(ctrl, ctrl2) {


    $(ctrl).html('');
    $.each(ctrl2, function(id, val) {
        var rtxt = txtRadioOptions;
        var inpts = $(val).find('input');
        $(ctrl).append(rtxt.replace('{value}', inpts[2].value).replace('{text}', inpts[1].value));
    });

}

function removeControl(ctrl) {
    ctrl.closest('.panel').remove();
}

function onmouseoverRemove(ctrl) {
    var pnl = ctrl.closest('.panel');
    $(ctrl).attr('style', 'background-color: #e34242c4;color:#ffffff;');
    $(pnl).addClass('closeBack');

}

function onmouseleaveRemove(ctrl) {
    var pnl = ctrl.closest('.panel');
    $(ctrl).removeAttr('style');
    $(pnl).removeClass('closeBack');
}

function onmouseoverEdit(ctrl) {
    $(ctrl).attr('style', 'background-color: #337ab7;color:#ffffff;');
}

function onmouseleaveEdit(ctrl) {
    $(ctrl).removeAttr('style');
}

function gettextarea(descr, ctrl, type) {
    var fulltxt = txtpanel;
    var conarr = ControlsArray[ctrl];
    txt = conarr[0].html;
    txt = fulltxt.replace('{content}', txt).replace('{desc}', descr).replace('{ControlType}', type).replace('{labeltext}', descr);
    //  txt = fulltxt.replace('{desc}', descr);
    $('#controls-content').append(txt);
}
function getnumberwithunits(descr, ctrl, type) {
    var fulltxt = txtpanel;
    var conarr = ControlsArray[ctrl];
    txt = conarr[0].html;
    txt = fulltxt.replace('{content}', txt).replace('{desc}', descr).replace('{ControlType}', type).replace('{labeltext}', descr);
    //  txt = fulltxt.replace('{desc}', descr);
    $('#controls-content').append(txt);
}

function getheadertext(descr, ctrl, type) {
    var fulltxt = txtpanel;
    var conarr = ControlsArray[ctrl];
    txt = conarr[0].html;
    txt = fulltxt.replace('{content}', '').replace('{desc}', descr).replace('{ControlType}', type).replace('{labeltext}', descr).replace('{headertype}', txt).replace('h3', 'h1'); ;
    // txt = txt.replace('h3', 'h1');
    $('#controls-content').append(txt);
}

function getinput(descr) {
    var txt = "<div><label>" + descr + "</label>";
    var conarr = ControlsArray['input'];
    txt = txt + conarr[0].html + '</div>';
    $('#controls-content').append(txt);

}

function getselect(descr) {
    var txt = "<div><label>" + descr + "</label>";
    var conarr = ControlsArray['select'];
    txt = txt + conarr[0].html + '</div>';
    $('#controls-content').append(txt);
}

function AddOptions(ctrl) {
    var li = $(ctrl).closest('.options').find('ol li');
    var count = li.length + 1;
    var txt = '<li class="ui-sortable-handle"><input type="radio" class="option-selected" value="false"  \
  ><input type="text" class="option-label" value="Option ' + count + '" \
   ><input type="text" class="option-value" value="option-' + count + '" >\
   <a class="remove btn" title="Remove Element" onclick="RemoveOptions(this);">×</a></li>';
    var opti = $(ctrl).closest('.options').find('ol');
    var li = $(ctrl).closest('.options').find('ol li');
    $(opti[0]).append(txt);
}

function RemoveOptions(ctrl) {

    $(ctrl).closest('li').remove();

}

function onSelectEdit(ctrl) {


    var otext = '';
    $(ctrl).find('option').each(function(id, val) {
        otext = otext + txtOptions.replace('{olabel}', val.text).replace('{ovalue}', val.value);
    });
    return txtOptionOI.replace('{OpContent}', otext);

}
function onNwithUnitsEdit(ctrl) {


    var otext = '';
    $(ctrl).find('option').each(function(id, val) {
        otext = otext + txtOptions.replace('{olabel}', val.text).replace('{ovalue}', val.value);
    });
    return txtOptionOI.replace('{OpContent}', otext);

}

function onRadioEdit(ctrl) {


    var otext = '';
    $(ctrl).find('.radio').each(function(id, val) {

        otext = otext + txtOptions.replace('{olabel}', $(val).find('label').html()).replace('{ovalue}', $(val).find('input').val());
    });
    return txtOptionOI.replace('{OpContent}', otext);

}

function onHeaderEdit(ctrl) {

    var txt = '';
    var htext = txtHeaderType;
    for (i = 1; i <= 3; i++) {
        if ($(ctrl).attr('type') == i)

            txt = txt + '<option  selected  value="h' + i + '">h' + i + '</option>';
        else
            txt = txt + '<option   value="h' + i + '">h' + i + '</option>';
    }
    return htext.replace('{options}', txt) + '<a class="close-field" onclick="editItems(this);">Close</a>';
}

function onpreviewclick() {
    $('#preview-content').html('')
    $('#preview-content').append(getTemplateText());
}
function viewtemplate(ctrl) {
    var TemplateID = $(ctrl).attr('TemplateID');

    getTemplates(TemplateID, 0, '', 'TemplateWithID');

}

function getTemplateText() {
    var txt = "";
    $.each($('#controls-content .panel'), function(id, val) {

        var label = $(val).find('.panel-title').html();
        var keyText = $(val).find('.panel-title').attr('key');
        var IsRequired = $(val).find('.panel-title').attr('IsRequired');
        var Mandatorysymbol = ""
        if (IsRequired == "Y") {
            Mandatorysymbol = '<font color="red">*</font>';
        }

        var control = $(val).find('.panel-body');
        var type = $(val).attr('controltype');
        switch (type) {
            case 'input':
                var sel = $(val).find('[control-type="input"]');
                var htmlString = $(sel).prop('outerHTML');
                txt = txt + '<div class="form-group"><label IsRequired="' + IsRequired + '"  key="' + keyText + '">' + label +' '+ Mandatorysymbol+'</label>' + htmlString + '</div>';
                //   <input type="input" control-type="input" class="form-control"></div>';
                break;
            case 'select':
                var sel = $(val).find('[control-type="select"]');
                var htmlString = $(sel).prop('outerHTML');
                txt = txt + '<div class="form-group"><label IsRequired="' + IsRequired + '"  key="' + keyText + '">' + label +' '+ Mandatorysymbol+'</label>' + htmlString + '</div>';
                break;
            case 'textarea':
                var sel = $(val).find('[control-type="textarea"]');
                var htmlString = $(sel).prop('outerHTML');
                txt = txt + '<div class="form-group"><label IsRequired="' + IsRequired + '"  key="' + keyText + '">' + label + ' ' + Mandatorysymbol + '</label>' + htmlString + '</div>';
                break;
            case 'radio-group':
                var sel = $(val).find('[control-type="radio-group"]');
                var htmlString = $(sel).prop('outerHTML');
                txt = txt + '<div class="form-group"><label IsRequired="' + IsRequired + '"  key="' + keyText + '">' + label + ' ' + Mandatorysymbol + '</label>\
                <div class="fb-radio-group form-group">' + htmlString + '</div></div>';
                break;
            case 'header':
                var sel = $(val).find('[control-type="header"]');
                var htmlString = $(sel).prop('outerHTML');
                txt = txt + '<div class="form-group">' + htmlString + '</div>';
                break;
            case 'number':
                var sel = $(val).find('[control-type="number"]');
                var htmlString = $(sel).prop('outerHTML');
                txt = txt + '<div class="form-group"><label IsRequired="' + IsRequired + '" key="' + keyText + '">' + label + ' ' + Mandatorysymbol + '</label>' + htmlString + '</div>';
                break;
            case 'NwithUnits':
                var tbox = $(val).find('[control-type="NwithUnits"]');
                var sel = $(val).find('[control-type="select"]');
                var htmlString = $(tbox).prop('outerHTML');
                var selString = $(sel).prop('outerHTML');
                txt = txt + '<div class="form-group"><label IsRequired="' + IsRequired + '"  key="' + keyText + '">' + label + ' ' + Mandatorysymbol + '</label>' + htmlString + selString + '</div>';
                break;
            default:

        }
    });
    return txt;
}

function getTemplates(TemplateID, InvestigationID, Invtype, stype) {
    var obj = {};
    obj.TemplateID = TemplateID;
    obj.InvestigationID = InvestigationID;
    obj.Invtype = Invtype;
    obj.SType = stype;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/GetAllQuestionaryTemplates",
        data: JSON.stringify(obj),
        dataType: "JSON",
        async: false,
        success: function(data) {
            if (stype == "All") {
                BindTemplates(data.d[0]);
                BindMappedTemplates(data.d[1]);
                binddllTemplate(data.d[0]);
            }
            if (stype == 'Template') {
                BindTemplates(data.d[0]);
                binddllTemplate(data.d[0]);
            }
            if (stype == 'TemplateMap')
            { BindMappedTemplates(data.d[0]); }
            if (stype == 'TemplateWithID') {
                $('#preview-content').html('')
                $('#preview-content').append(data.d[0][0].TemplateText);
                $('#myModal').modal();
            }

        },
        error: function(xr) {
            var dS = xr;
        }
    });
}


function BindTemplates(data) {
    cnt = 1;
    var tbl = '#tblTemplates';
    $(tbl + '  tbody > tr').remove();
    $(tbl).show();
    var oTable = $(tbl).dataTable({
        paging: true,
        data: data,
        "bDestroy": true,
        "searchable": true,
        fixedHeader: true,
        "sort": true,
        columns: [
            {
                "data": "id",
                "mRender": function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            {
                'data': 'TemplateName'

            },

            {
                'data': 'Action',
                "ordering": true,
                "mRender": function(data, type, full, meta) {
                    return '<input type="button" TemplateID="' + full.TemplateID + '" data="view" value ="View"  class="" type="button" onclick="viewtemplate(this);" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';

                }

            }

        ]

    });

    jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
    //  oTable.columns.adjust().draw();
}
function BindMappedTemplates(data) {
    cnt = 1;
    var tbl = '#tblMappedList';
    $(tbl + '  tbody > tr').remove();
    $(tbl).show();
    var oTable = $(tbl).dataTable({
        paging: true,
        data: data,
        "bDestroy": true,
        "searchable": true,
        "sort": true,
        columns: [
            {
                "data": "id",
                "mRender": function(data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            {
                'data': 'TemplateName'

            },
             {
                 'data': 'Investigation'

             },
             {
                 'data': 'InvType'

             },

            {
                'data': 'Action',
                "ordering": true,
                "mRender": function(data, type, full, meta) {
                    return '<input type="button" TemplateID="' + full.TemplateID + '" data="view" value ="View"  class="" type="button" onclick="viewtemplate(this);" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" />';

                }

            }

        ]

    });

    jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');
    // oTable.columns.adjust().draw();
}

function addTemplates(ctrl) {

    if ($(ctrl).attr('action') == "add") {
        $("#divlist").slideUp();
        $("#divCreate").slideDown();
    }
    else {
        $("#divlist").slideDown();
        $("#divCreate").slideUp();
    }

    event.preventDefault();

}
function addMapping(ctrl) {

    if ($(ctrl).attr('action') == "add") {
        $("#divMapList").slideUp();
        $("#divmap").slideDown();
    }
    else {
        $("#divMapList").slideDown();
        $("#divmap").slideUp();
    }

    event.preventDefault();

}

function binddllTemplate(data) {
    $('#ddlTemplate').empty();
    $('#ddlTemplate').append('<option value="0">--Select--</option>');
    $.each(data, function(id, val) {

        $('#ddlTemplate').append('<option value="' + val.TemplateID + '">' + val.TemplateName + '</option>');

    });
}
function SaveTemplateMapping() {
    var TemplateID = $('#ddlTemplate').val();
    var invId = $('#hdnInvID').val();
    if (TemplateID == '0') {
        ValidationWindow('Please Select Template', 'Alert');
        return false;
    }
    if (invId == '' || invId == '0') {
        ValidationWindow('Please Select Investigation', 'Alert');
        return false;
    }
    var obj = {};
    obj.TemplateID = TemplateID;
    obj.TemplateName = '';
    obj.TemplateText = '';
    obj.InvestigationID = invId;
    obj.Invtype = $('#hdnInvType').val();
    saveTemplatesAll(obj);
}
function SaveTemplates() {
    var TemplateName = $('#txtTemplate').val();

    if (TemplateName == "") {
        ValidationWindow('Please Enter TemplateName', 'Alert');
        return false;
    }
    var TemplteText = getTemplateText();
    if (TemplteText == "")
    { ValidationWindow('Please Add atleast a Control to Template', 'Alert'); return false; }
    var obj = {};
    obj.TemplateID = 0;
    obj.TemplateName = TemplateName;
    obj.TemplateText = TemplteText;
    obj.InvestigationID = 0;
    obj.Invtype = '';
    saveTemplatesAll(obj);
    clearTemplateControls();
    //location.reload(true);
    return false;
}



function saveTemplatesAll(obj) {
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/SaveQuestionaryTemplate",
        data: JSON.stringify(obj),
        dataType: "JSON",
        async: false,
        success: function(data) {
        ValidationWindow('Saved Successfully', 'Alert');
        location.reload(true);
            //clearMappingControls();
            //clearTemplateControls();
            //
            getTemplates(0, 0, '', 'Template');
            $('#controls-content').empty();
        },
        error: function(xr) {
            var dS = xr;
        }
    });
}

function SetRadio(ctrl) {
    var rgroup = $(ctrl).closest('.radio-group');
    $(rgroup).find('input[type="radio"]').prop('checked', false);
    $(rgroup).attr('value', $(ctrl).find('input[type="radio"]').val());
    $(ctrl).find('input[type="radio"]').prop('checked', true);
}

function clearTemplateControls() {
    $('#txtTemplate').val('');
    $('#txDescription').val('');
    $('#ddlControl').val(0);
    $('#controls - content').empty();
    // $('#btnCancelTemplate').click();
    //  addTemplates('#btnCancelTemplate');
}
function clearMappingControls() {
    $('#ddlTemplate').val(0);
    $('#txtTestName').val('');

    ('#hdnInvID').val(0);
    ('#hdnInvType').val('');
}
function InvAutoComplete() {
    var AutoInvList = [];
    var objj = {};
    objj.ID = 0;
    objj.Type = '';
    AutoInvList.push(objj);
    $('#txtTestName').autocomplete({


        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../OPIPBilling.asmx/GetBillingItemsForBillEdit",
                data: JSON.stringify({ prefixText: request.term, contextKey: 'Tem~0~~~~', lstOrderedInvestigations: AutoInvList }),
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        $('#hdnInvID').val(0);
                        $('#hdnInvType').val("");
                        // var lst=   JSON.parse(data.d)
                        response($.map(data.d, function(item) {
                            var rsltlable = item.Descrip;
                            var rsltvalue = item.ProcedureName;
                            return {
                                label: rsltlable,
                                val: rsltvalue
                            }
                        }))
                    }
                    else {
                        response([{ label: "No Records Found", val: -1}]);
                        $('#hdnInvID').val(0);
                        $('#hdnInvType').val("");
                    }
                },
                error: function(response) {
                    // alert(response.responseText);
                },
                failure: function(response) {
                    // alert(response.responseText);
                }
            });
        },


        select: function(e, i) {
            if (i.item.val == -1) {
                //$("#hdnInstrumentID").val("");
            }
            else {

                var val = i.item.val.split(":");
                var value = val[0].split("^");
                var value1 = val[1].split("^");
                $('#hdnInvID').val(value[0]);
                $('#hdnInvType').val(value1[1]);

            }
        },
        minLength: 3

    });
}