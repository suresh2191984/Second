<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RuleMaster.aspx.cs" Inherits="Admin_RuleMaster"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="head1" runat="server">
    <title></title>
    <script type="text/javascript" src="../Scripts/jquery-1.4.1.js"></script>
   <script type="text/javascript" src="../Scripts/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>


    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/handsontable/dist/jquery.handsontable.full.js"></script>

<script type="text/javascript" src="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.js"></script>

<link rel="stylesheet" media="screen" href="../Scripts/handsontable/dist/jquery.handsontable.full.css" />
<link rel="stylesheet" media="screen" href="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.css" />
    
    <style type="text/css">
    .panel-heading {
    color: #fff;
    background-color: #446d87;
    border-color: #446d87;
}

.addIcons
{
	background: url("../Images/Add.png") no-repeat center top!important;
	cursor: pointer!important;
    font-size: 0!important;
    width: 13px;
    height: 16px;
}
.edtIcons
{
	background: url("../Images/edit.png") no-repeat center top!important;
	cursor: pointer!important;
    font-size: 0!important;
    width: 13px;
    height: 16px;
}
.ui-autocomplete
{
	width:250px;
}
    .panel-heading {
        padding: 10px 15px;
        border-bottom: 1px solid transparent;
        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
    }
    .panel-Innerheading
    {
    	color: #fff;
    	 padding: 6px 8px;
    background-color: #526770;
    border-color: #526770;
    }
    .panel-body {
    padding: 15px;
}

.ui-autocomplete ,.ui-front ,.ui-menu ,.ui-widget ,.ui-widget-content ,.ui-corner-all
{
	width:250px;
}
    .mytable1 td, .mytable1 th
    {
        border: 1px solid #686868;
        border-bottom: 1px solid #686868;
    }
    .searchBox
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: left;
        height: 15px;
        width: 130px;
        border: 1px solid #999999;
        font-size: 11px;
        margin-left: 0px;
        background-image: url('../Images/magnifying-glass.png');
        background-repeat: no-repeat;
        padding-left: 20px !important;
        background-color: #F3E2A9;
    }
    .mediumList
    {
        min-width: 330px;
    }
    .bigList
    {
        min-width: 800px;
    }
    .listMain
    {
        min-height: 0px;
    }
    h1, h2, h3, h4, h5, h6
    {
        margin: 10px 0;
        font-family: inherit;
        font-weight: bold;
        line-height: 1;
        color: inherit;
        text-rendering: optimizelegibility;
    }
    h1 small, h2 small, h3 small, h4 small, h5 small, h6 small
    {
        font-weight: normal;
        line-height: 1;
        color: #999999;
    }
    h1
    {
        font-size: 36px;
        line-height: 40px;
    }
    h2
    {
        font-size: 30px;
        line-height: 40px;
    }
    h3
    {
        font-size: 24px;
        line-height: 40px;
    }
    h4
    {
        font-size: 18px;
        line-height: 20px;
    }
    h5
    {
        font-size: 14px;
        line-height: 20px;
    }
    h6
    {
        font-size: 12px;
        line-height: 20px;
    }
    h1 small
    {
        font-size: 24px;
    }
    h2 small
    {
        font-size: 18px;
    }
    h3 small
    {
        font-size: 14px;
    }
    h4 small
    {
        font-size: 14px;
    }
    .close
    {
        float: right;
        font-size: 20px;
        font-weight: bold;
        line-height: 20px;
        color: #000000;
        text-shadow: 0 1px 0 #ffffff;
        opacity: 0.2;
        filter: alpha(opacity=20);
    }
    .close:hover
    {
        color: #000000;
        text-decoration: none;
        cursor: pointer;
        opacity: 0.4;
        filter: alpha(opacity=40);
    }
    button.close
    {
        padding: 0;
        cursor: pointer;
        background: transparent;
        border: 0;
        -webkit-appearance: none;
    }

    fieldset
    {
        border: 1px solid black;
        padding: 5px;
        text-align: left;
    }
    legend
    {
        margin-bottom: 0px;
        margin-left: 5px;
        padding: 1px;
        font-size: 12px;
        font-weight: bold;
        color: White;
        text-align: right;
        background-color: #2C88B1;
    }
    .modal-backdrop
    {
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        z-index: 1040;
        background-color: #000000;
    }
    .modal-backdrop.fade
    {
        opacity: 0;
    }
    .modal-backdrop, .modal-backdrop.fade.in
    {
        opacity: 0.8;
        filter: alpha(opacity=80);
    }
    .modal
    {
        font-family: "Helvetica Neue" , Helvetica, Arial, sans-serif;
        font-size: 14px;
        display: none;
        position: fixed;
        top: 45%;
        left: 1%;
        z-index: 1050;
        margin: -250px 0 0 0;
        overflow: auto;
        color: #333333;
        padding: 3px;
        background-color: #e0ebf5;
        border: 1px solid #999;
        border: 1px solid rgba(0, 0, 0, 0.3); *border:1pxsolid#999;-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-webkit-box-shadow:03px7pxrgba(0, 0, 0, 0.3);-moz-box-shadow:03px7pxrgba(0, 0, 0, 0.3);box-shadow:03px7pxrgba(0, 0, 0, 0.3);-webkit-background-clip:padding-box;-moz-background-clip:padding-box;background-clip:padding-box;}
    .modal-header
    {
        padding: 9px 15px;
        border-bottom: 1px solid #eee;
    }
    .modal-header .close
    {
        margin-top: 2px;
    }
    .modal-header h3
    {
        margin: 0;
        line-height: 30px;
    }
    .modal-body
    {
        height: 500px;
        padding: 15px;
        overflow-y: auto;
    }
    .modal-form
    {
        margin-bottom: 0;
    }
    .modal-footer
    {
        padding: 10px 15px 5px;
        margin-bottom: 0;
        text-align: right;
        background-color: #e0ebf5;
        color: #333333;
        border-top: 1px solid #ddd;
        -webkit-border-radius: 0 0 6px 6px;
        -moz-border-radius: 0 0 6px 6px;
        border-radius: 0 0 6px 6px; *zoom:1;-webkit-box-shadow:inset01px0#ffffff;-moz-box-shadow:inset01px0#ffffff;box-shadow:inset01px0#ffffff;}
    .modal-footer:before, .modal-footer:after
    {
        display: table;
        line-height: 0;
        content: "";
    }
    .modal-footer:after
    {
        clear: both;
    }
    .modal-footer .btn + .btn
    {
        margin-bottom: 0;
        margin-left: 5px;
    }
    .modal-footer .btn-group .btn + .btn
    {
        margin-left: -1px;
    }
    </style>
      <script type="text/javascript" language="javascript">
          
           var htmlRenderer = function(instance, td, row, col, prop, value, cellProperties) {
        var escaped = Handsontable.helper.stringify(value);
        td.innerHTML = escaped;
        return td;
    };
          
          function hideHeader() {
              document.getElementById('header').style.display = 'none';
              document.getElementById('Attuneheader_menu').style.display = 'none';
              document.getElementById('imagetd').style.display = 'none';
              $("#navigation").addClass("classNav");
              document.getElementById('Attuneheader_TopHeader1_ImgBtnHome').style.display = 'none';
          }
          function SetPostTrigger(Ctrl) {
              try {

                  if ($("#" + Ctrl.id + " option:selected").text() == 'Medical Remarks Rule') {
                      var ddlTrigger = document.getElementById("ddlTrigger");
                      ddlTrigger.options.length = 0;
                      var lstposttrigger = JSON.parse($('input[id$="hdnlstPostTrigger"]').val());
                      var lstposttriggerfilter = lstposttrigger.filter(function(item) {
                          return item.Name == 'Add Medical Remarks';
                      });


                      $.each(lstposttriggerfilter, function(i, obj) {
                          $('#ddlTrigger').append(
                    $('<option></option>').val(obj.Value).html(obj.Name));

                      });
                      ShowMedRemarks("ddlTrigger");
                  }
                  else if ($("#" + Ctrl.id + " option:selected").text() == 'Auto Certification Rule') {
                      var ddlTrigger = document.getElementById("ddlTrigger");
                      ddlTrigger.options.length = 0;
                      var lstposttrigger = JSON.parse($('input[id$="hdnlstPostTrigger"]').val());
                      var lstposttriggerfilter = lstposttrigger.filter(function(item) {
                          return item.Name == 'Block Auto certification';
                      });


                      $.each(lstposttriggerfilter, function(i, obj) {
                          $('#ddlTrigger').append(
                    $('<option></option>').val(obj.Value).html(obj.Name));

                      });
                      $('#divlblmedremarks').hide();
                      $('#divtxtmedremarks').hide();
                      $('#txtmedRemarks').val('');
                  }
                  else {
                      var ddlTrigger = document.getElementById("ddlTrigger");
                      ddlTrigger.options.length = 0;
                      var lstposttrigger = JSON.parse($('input[id$="hdnlstPostTrigger"]').val());
                      $.each(lstposttrigger, function(i, obj) {
                          $('#ddlTrigger').append(
                    $('<option></option>').val(obj.Value).html(obj.Name));

                      });
                      $('#divlblmedremarks').hide();
                      $('#divtxtmedremarks').hide();
                      $('#txtmedRemarks').val('');
                  }
                 
              
              }
              catch (e) {
                  return false;
              }
          }
              function ShowMedRemarks(Ctrl) {
                    try {
                        if ($("#"+Ctrl+" option:selected").text() == 'Add Medical Remarks') 
                        {
                          $('#divlblmedremarks').show();
                            $('#divtxtmedremarks').show();
                        }
                        else{
                            $('#divlblmedremarks').hide();
                            $('#divtxtmedremarks').hide();
                            $('#txtmedRemarks').val('');
                        }
                    }
                   catch (e) {
                        return false;
                    }
              }
    function ShowResultTypeValue(Ctrl) {
        try {
            ddlid=Ctrl.id.replace('ddlResultType','ddlOperatorRange1');
            txtid=Ctrl.id.replace('ddlResultType','txtAgeRange1');
            $("#"+ddlid+" option").remove();
            if (Ctrl.value == 'RES') {
                   $("#"+ddlid+" option").remove();
                   $('#'+txtid).hide();
                 var lstAbnormal = JSON.parse($('input[id$="hdnAbnormal"]').val());
                 $.each(lstAbnormal, function(i, obj) {
                      $('#'+ddlid).append(
                    $('<option></option>').val(obj.Name).html(obj.Name));
                       
                    });
            }
            else if (Ctrl.value == 'VR') {
                $("#"+ddlid+" option").remove();
                $('#'+txtid).show();
                 var lstAgeRangeOpr = JSON.parse($('input[id$="hdnLstAgeRangeOpr"]').val());
                 $.each(lstAgeRangeOpr, function(i, obj) {
                     $('#'+ddlid).append(
                    $('<option></option>').val(obj.Value).html(obj.Name));
                     
                    });
            }
        }
        catch (e) {
            return false;
        }
    }
    
      function ShowAgeBetween(Ctrl) {
        try {
            divid=Ctrl.id.replace('ddlOperatorRange1','DivAgeRange2');
            txtid=Ctrl.id.replace('ddlOperatorRange1','txtAgeRange2');
            $('#'+divid).hide();
            $('#' + txtid).val('');
            if (Ctrl.value == 'Between') {
                $('#'+divid).show();
            }
        }
        catch (e) {
            return false;
        }
    }
    
   function SelectedCrossTest(Source, eventArgs) {
        try {
            var lstSelectedValue = eventArgs.get_value().split(':');
            $('input[id$="hdnInvID"]').val(lstSelectedValue[0]);
            $('input[id$="hdnInvType"]').val(lstSelectedValue[2]);
            var lstSelectedText = eventArgs.get_text().split(':');
            if (lstSelectedText.length > 1 && lstSelectedText[1] != null) {
                $('input[id$="txtParameter"]').val(lstSelectedText[0].trim());
            }
            LoadRulemaster();
            $('#hdnInvRuleMasterId').val('0');
        }
        catch (e) {
            return false;
        }
    }
    function CrossTestCodeSchemePopulated(Source, eventArgs) {
        try {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('#' + hdnInvID).val('');
                 $('#' + hdnInvType).val('');
                
            }
        }
        catch (e) {
            return false;
        }
    }
   $(document).ready(function() {
   $('#ACERemarks').set_contextKey('');
   });
//        BindControls();
//    });
//    function BindControls() {
//        var Countries = ["ARGENTINA", "AUSTRALIA", "BRAZIL", "BELARUS", "BHUTAN", "CHILE"];

//        // BIND ARRAY OF STRINGS WITH AUTOCOMPLETE FUNCTION.
//        $( "input[name*='txtCondInv']" ).autocomplete({ source: Countries });
//    }
    function BindControls(ctrl) {
        var contextkey=$('#hdnOrgid').val() + "~" + "";
        $( "input[id="+ctrl.id+"]" ).autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: "../WebService.asmx/GetTestCodingScheme",
                    data: "{'prefixText': '" + request.term + "','count':0,'contextKey': '" + contextkey + "' }",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataFilter: function(data) { return data; },
                    success: function(data) {
                        response($.map(data.d, function(item) {
                            return { 
                             label: JSON.parse(item).First,
                             value: JSON.parse(item).Second.split(":")[0]}
                        }))
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        alert(textStatus);
                    }
                });
            },
            minLength: 2,    // MINIMUM 1 CHARACTER TO START WITH.
            select: function (event, ui) {
            $( "input[id="+ctrl.id+"]" ).val(ui.item.label.split(":")[0]);
            $( "input[id="+ctrl.id+"Id]" ).val(ui.item.value);
    return false;
}
        });
    }
    
   function validateOperator(ctrl)
   {
       var strhdr ='Alert';
       var strcon ='Fill all details and then click to add new condition';
       if(ctrl.name=='MachineError')
        {
          txtid=ctrl.id.replace('ddltestOperator','txtMachineErr');
              if($('#' + txtid).val()=='')
              {
                ValidationWindow(strcon,strhdr);
                return false;
              }
        }
        if(ctrl.name=='TestResult')
        {
          ddlOperatorRange=ctrl.id.replace('ddltestOperator','ddlOperatorRange1');
          ddlResultType=ctrl.id.replace('ddltestOperator','ddlResultType');
          txtid=ctrl.id.replace('ddltestOperator','txtCondInv');
           txtAgeRange1=ctrl.id.replace('ddltestOperator','txtAgeRange1');
          txtAgeRange2=ctrl.id.replace('ddltestOperator','txtAgeRange2');
              if(($("#"+ddlResultType+" option:selected").text()=='---Select---') || $('#' + txtid).val()=='')
              {
                ValidationWindow(strcon,strhdr);
                return false;
              }
              
              if($("#"+ddlOperatorRange+" option:selected").text()=='---Select---') 
              {
               ValidationWindow(strcon,strhdr);
                return false;
              }
             if(($("#"+ddlResultType+" option:selected").text()=='Value Range')  && $('#' + txtAgeRange1).val()=='') 
             {
               ValidationWindow(strcon,strhdr);
                return false;
             }
              if(($("#"+ddlOperatorRange+" option:selected").text()=='Between') && $('#' + txtAgeRange2).val()=='')
                  {
                    ValidationWindow(strcon,strhdr);
                    return false;
                  }
        }
        if(ctrl.name=='AgeGender')
        {
          ddlgender=ctrl.id.replace('ddlOperator','ddlGender');
          ddlSubCategory=ctrl.id.replace('ddlOperator','ddlSubCategory');
          ddldate=ctrl.id.replace('ddlOperator','ddlAgeType');
          ddlOperatorRange=ctrl.id.replace('ddlOperator','ddlOperatorRange1');
          txtAgeRange1=ctrl.id.replace('ddlOperator','txtAgeRange1');
          txtAgeRange2=ctrl.id.replace('ddlOperator','txtAgeRange2');
          
              if(($("#"+ddlgender+" option:selected").text()=='---Select---') || ($("#"+ddlSubCategory+" option:selected").text()=='---Select---') 
              || ($("#"+ddldate+" option:selected").text()=='---Select---') || ($("#"+ddlOperatorRange+" option:selected").text()=='---Select---') 
              || $('#' + txtAgeRange1).val()=='')
              {
                   ValidationWindow(strcon,strhdr);
                    return false;
              }
               if($("#"+ddlOperatorRange+" option:selected").text()=='Between' && $('#' + txtAgeRange2).val()=='')
                  {
                    ValidationWindow(strcon,strhdr);
                    return false;
                  }
                    
        }
   }
    
    function AddMachineErrorCondition(name)
    {
    if(name.value=='AddErrorCond')
    {
      ddlid=name.id.replace('btnAddCond','ddltestOperator');
      if($("#"+ddlid+" option:selected").text() == '---Select---')
          //if($('#' + txtid).val()=='')
          {
            ValidationWindow('Select Operator and then proceed to add new condition','Alert');
            return false;
          }
    }
            
    $('#tblMachineError0txtMachineErr').val()
    var rowCount = $("#tblMachineError tr").length;
    var strdel =  "Click here to remove Conditions";
    var stradd =  "Click here to Add Conditions";
    var row = '<tr style="height: 17px;">';
    var OperatorOption="",lblerrorCode="",txtMachineErr="",ddlOperator="";
    var lstOperator = JSON.parse($('input[id$="hdnLstOperator"]').val());
     $.each(lstOperator, function(i, obj) {
          if (obj.Value == '0') {
                    OperatorOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           OperatorOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
    lblerrorCode= '<td align="left"><span id="lblerrorCode"> Error Code </span></td>';
    txtMachineErr = '<div id="tblMachineError' + rowCount + 'DivMachineErr" ><input id="tblMachineError' + rowCount + 'hdnErrorRuleId" type="hidden" value="0" /><input type="text" id="tblMachineError' + rowCount + 'txtMachineErr" name="txtMachineErr" style="height:16px;width:150px;" /></div>';
    ddlOperator = '<div id="tblMachineError' + rowCount + 'divtestOperator><span class="richcombobox" style="width: 120px;"><select id="tblMachineError' + rowCount + 'ddltestOperator" class="ddl" name="MachineError" style="width: 120px;" onclick="validateOperator(this);" title="Select Operator">' + OperatorOption + '</select></span></div>';               
    var btnDeleteCondition = '<input id="tblMachineError' + rowCount + 'btnDeleteCond" class="deleteIcons" value="Delete" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onDelete(this);" title='+strdel+' />';
    var btnAddCondition = '<input id="tblMachineError' + rowCount + 'btnAddCond" class="addIcons"  value="AddErrorCond" type="button" style="background-color:Transparent;color: Blue; border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="AddMachineErrorCondition(this);" title='+stradd+' />';
     row += lblerrorCode;
    row += '<td align="center">' + txtMachineErr +'</td>'; 
    row += '<td align="center">' + ddlOperator +'</td>'; 
    row += '<td align="center">' + btnDeleteCondition + '</td>';
    row += '<td align="center">' + btnAddCondition + '</td>';
        row += "</tr>";
    $("#tblMachineError").append(row)
    }
    
    function AddTestResultsCondition(name)
    {
    if(name.value=='AddResCond')
    {
      ddlid=name.id.replace('btnAddCond','ddltestOperator');
      if($("#"+ddlid+" option:selected").text() == '---Select---')
          {
            ValidationWindow('Select Operator and then proceed to add new condition','Alert');
            return false;
          }
    }
    var rowCount = $("#tblResCondition tr").length;
    var strdel =  "Click here to remove Conditions";
    var stradd =  "Click here to Add Conditions";
    var lblCondInv = "", txtCondInv = "",ddlOperator="",OperatorOption="",ResultTypeOption="";
    var row = '<tr style="height: 17px;">';
                    
                    
    var lstOperator = JSON.parse($('input[id$="hdnLstOperator"]').val());
     $.each(lstOperator, function(i, obj) {
          if (obj.Value == '0') {
                    OperatorOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           OperatorOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
        var lstResultType = JSON.parse($('input[id$="hdnResultType"]').val());
     $.each(lstResultType, function(i, obj) {
          if (obj.Value == '0') {
                    ResultTypeOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           ResultTypeOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
        
    lblCondInv= '<td align="left"><span id="lblCondInv"> Test Name </span></td>';
    var lblResType= '<td align="left"><span id="lblResType"> Result Type </span></td>';
    var lblVR= '<td align="left"><span id="lblVR"> Value Range </span></td>';
    txtCondInv = '<div id="tblResCondition' + rowCount + 'DivCondInv" ><input id="tblResCondition' + rowCount + 'hdnResultRuleId" type="hidden" value="0" /><input type="text" id="tblResCondition' + rowCount + 'txtCondInv" name="txtCondInv" class="searchBox" onkeyup="BindControls(this)" style="height:16px;width:250px;" /><input id="tblResCondition' + rowCount + 'txtCondInvId" type="hidden" value="0" /></div>';
    var ddlResultType = '<div id="tblResCondition' + rowCount + 'divResultType><span class="richcombobox" style="width: 120px;"><select id="tblResCondition' + rowCount + 'ddlResultType" class="ddl" style="width: 120px;" onchange="ShowResultTypeValue(this);" title="Select Result Type">' + ResultTypeOption + '</select></span></div>';
    var ddlValueRange = '<div id="tblResCondition' + rowCount + 'divOperatorRange1><span class="richcombobox" style="width: 120px;"><select id="tblResCondition' + rowCount + 'ddlOperatorRange1" class="ddl" style="width: 120px;" onchange="ShowAgeBetween(this);" title="Select Result value Range"></select></span></div>';
    var txtAgeRange1 = '<div id="tblResCondition' + rowCount + 'DivAgeRange1" ><input type="text"  id="tblResCondition' + rowCount + 'txtAgeRange1"  class="Txtboxsmall" style="height:16px;width:100px;" /></div>';
    var txtAgeRange2 = '<div id="tblResCondition' + rowCount + 'DivAgeRange2" style="display: none;" ><input  type="text"  id="tblResCondition' + rowCount + 'txtAgeRange2"  class="Txtboxsmall" onkeypress="return blockNonNumbers(this, event, true, false);" style="height:16px;width:100px;" /></div>';
    ddlOperator = '<div id="tblResCondition' + rowCount + 'divtestOperator><span class="richcombobox" style="width: 120px;"><select id="tblResCondition' + rowCount + 'ddltestOperator" class="ddl" style="width: 120px;" name="TestResult"  onclick="validateOperator(this);" title="Select Operator">' + OperatorOption + '</select></span></div>';
    var btnDeleteCondition = '<input id="tblResCondition' + rowCount + 'btnDeleteCond" class="deleteIcons" value="Delete" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onDelete(this);" title='+strdel+' />';
    var btnAddCondition = '<input id="tblResCondition' + rowCount + 'btnAddCond" class="addIcons"  value="AddResCond" type="button" style="color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="AddTestResultsCondition(this);" title='+stradd+' />';
    row += lblCondInv;
    row += '<td align="center">' + txtCondInv +'</td>'; 
    row += lblResType;
    row += '<td align="center">' + ddlResultType +'</td>';  
    row += lblVR;
    row += '<td align="center">' + ddlValueRange +'</td>';  
    row += '<td align="center">' + txtAgeRange1 + '</td>';
    row += '<td align="center">' + txtAgeRange2 + '</td>';   
    row += '<td align="center">' + ddlOperator +'</td>';
    row += '<td align="center">' + btnDeleteCondition + '</td>';
    row += '<td align="center">' + btnAddCondition + '</td>';
    row += "</tr>";
    $("#tblResCondition").append(row)
    }
    
    function AddPatientAgeandGenderCondition(name)
    {
    if(name.value=='AddAgeGenderCond')
    {
      ddlid=name.id.replace('btnAddCond','ddlOperator');
      if($("#"+ddlid+" option:selected").text() == '---Select---')
          {
            ValidationWindow('Select Operator and then proceed to add new condition','Alert');
            return false;
          }
    }
    var rowCount = $("#tblConditions tr").length;
       var row = '<tr style="height: 17px;">';
       var lstGender = JSON.parse($('input[id$="hdnLstGender"]').val());
       var lstSubCategory = JSON.parse($('input[id$="hdnLstSubCategory"]').val());
       var lstDateAttributes = JSON.parse($('input[id$="hdnLstDateAttributes"]').val());
       var lstAgeRangeOpr = JSON.parse($('input[id$="hdnLstAgeRangeOpr"]').val());
       var lstOperator = JSON.parse($('input[id$="hdnLstOperator"]').val());
       
       var ddlGender = "", ddlsubcategory = "", ddlDateattr = "", ddlagerange = "", txtAgeRange1="", txtAgeRange1="";
       var GenderOption = "", SubCatOption = "", DateattOption = "", AgerangeOption = "",OperatorOption="";
       var strdel =  "Click here to remove Conditions";
       var stradd =  "Click here to Add Conditions";
       $.each(lstGender, function(i, obj) {
       if (obj.Value == '0') {
                    GenderOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           GenderOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
        $.each(lstSubCategory, function(i, obj) {
         if (obj.Value == '0') {
                    SubCatOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           SubCatOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
        $.each(lstDateAttributes, function(i, obj) {
         if (obj.Value == '0') {
                    DateattOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           DateattOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
        $.each(lstAgeRangeOpr, function(i, obj) {
          if (obj.Value == '0') {
                    AgerangeOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           AgerangeOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
           $.each(lstOperator, function(i, obj) {
          if (obj.Value == '0') {
                    OperatorOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else{
           OperatorOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
           }
        });
        
        
       lblGender= '<td align="left"><span id="lblGender"> Gender </span></td>';
       lblSubCategory= '<td align="left"><span id="lblSubCategory"> Sub Category </span></td>';
       lblAgeType= '<td align="left"><span id="lblAgeType"> Type </span></td>';
       lblddlOperatorRange1= '<td align="left"><span id="lblOperatorRange1"> Age </span></td>';
       ddlGender = '<div id="tblConditions' + rowCount + 'divGender"><span class="richcombobox" style="width: 120px;"><input id="tblConditions' + rowCount + 'hdnAgeGenderRuleId" type="hidden" value="0" /><select id="tblConditions' + rowCount + 'ddlGender" class="ddl" style="width: 120px;" title="Select Gender">' + GenderOption + '</select></span></div>';
       ddlSubCategory = '<div id="tblConditions' + rowCount + 'divSubCategory"><span class="richcombobox" style="width: 120px;"><select id="tblConditions' + rowCount + 'ddlSubCategory" class="ddl" style="width: 120px;" title="Select Sub Category">' + SubCatOption + '</select></span></div>';
       ddlAgeType = '<div id="tblConditions' + rowCount + 'divAgeType"><span class="richcombobox" style="width: 120px;"><select id="tblConditions' + rowCount + 'ddlAgeType" class="ddl" style="width: 120px;" title="Select Date Attributes">' + DateattOption + '</select></span></div>';
       ddlOperatorRange1 = '<div id="tblConditions' + rowCount + 'divOperatorRange1" ><span class="richcombobox" style="width: 120px;"><select id="tblConditions' + rowCount + 'ddlOperatorRange1" onchange="ShowAgeBetween(this);" class="ddl" style="width: 120px;" title="Select Age Range">' + AgerangeOption + '</select></span></div>';
       txtAgeRange1 = '<div id="tblConditions' + rowCount + 'DivAgeRange1" ><input type="text"  maxlength="3" id="tblConditions' + rowCount + 'txtAgeRange1"  class="Txtboxsmall"  style="height:16px;width:25px;" /></div>';
       txtAgeRange2 = '<div id="tblConditions' + rowCount + 'DivAgeRange2" style="display: none;" ><input  type="text" maxlength="3" id="tblConditions' + rowCount + 'txtAgeRange2"  class="Txtboxsmall" onkeypress="return blockNonNumbers(this, event, true, false);" style="height:16px;width:25px;" /></div>';
       ddlOperator = '<div id="tblConditions' + rowCount + 'divOperator><span class="richcombobox" style="width: 120px;"><select id="tblConditions' + rowCount + 'ddlOperator" class="ddl" style="width: 120px;" name="AgeGender"  onclick="validateOperator(this);" title="Select Operator">' + OperatorOption + '</select></span></div>';
       var btnDeleteCondition = '<input id="tblConditions' + rowCount + 'btnDeleteCond" class="deleteIcons" value="Delete" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onDelete(this);" title='+strdel+' />';
       var btnAddCondition = '<input id="tblConditions' + rowCount + 'btnAddCond" class="addIcons" value="AddAgeGenderCond" type="button" style="color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="AddPatientAgeandGenderCondition(this);" title='+stradd+' />';
       row += lblGender;
       row += '<td align="center">' + ddlGender +'</td>';    
       row += lblSubCategory;
       row += '<td align="center">' + ddlSubCategory +'</td>';
       row += lblAgeType;
       row += '<td align="center">' + ddlAgeType +'</td>';
       row += lblddlOperatorRange1;
       row += '<td align="center">' + ddlOperatorRange1 +'</td>';
       row += '<td align="center">' + txtAgeRange1 + '</td>';
       row += '<td align="center">' + txtAgeRange2 + '</td>';
       row += '<td align="center">' + ddlOperator +'</td>';
       row += '<td align="center">' + btnDeleteCondition + '</td>';
       row += '<td align="center">' + btnAddCondition + '</td>';
       row += "</tr>";
        $("#tblConditions").append(row)
    }
    
    function AddConditions(name)
    {
        var AlrtWinHdr = "Alert";
        var UsrAlrtMsg = "Select Rule Type";
         if ($("#ddlRuleType option:selected").text() == '--Select--') 
                {
                    $('#ddlRuleType').focus();
                    ValidationWindow(UsrAlrtMsg,AlrtWinHdr);
                      return false;
                }
           if($.trim($('#txtParameter').val()) == '')
           {
                    UsrAlrtMsg="Enter Investigation Name";
                    $('#txtParameter').focus();
                    ValidationWindow(UsrAlrtMsg,AlrtWinHdr);
                      return false;
            }
           var i=0;
           $('#chkComponent input:checked').each(function() {
                
                if($('#'+this.id)[0].labels[0].innerHTML== "Patient Age and Gender")
                {
                i=1;
                var rowCount = $("#tblConditions tr").length;
                    if(rowCount==0)
                    {
                        $('#divag').show();
                        AddPatientAgeandGenderCondition(name);
                    }
                }
                if($('#'+this.id)[0].labels[0].innerHTML== "Test Result")
                {
                i=1;
                var rowCount1 = $("#tblResCondition tr").length;
                    if(rowCount1==0)
                    {
                       $('#divtestres').show();
                       AddTestResultsCondition(name);
                    }
                }
                if($('#'+this.id)[0].labels[0].innerHTML== "Machine Error")
                {
                i=1;
                    var rowCount2 = $("#tblMachineError tr").length;
                    if(rowCount2==0)
                    {
                       $('#divMachineError').show();
                       AddMachineErrorCondition(name);
                    }
                }
            });
            
            if(i==0)
           {
                    UsrAlrtMsg="Select Component";
                    $('#chkComponent').focus();
                    ValidationWindow(UsrAlrtMsg,AlrtWinHdr);
                      return false;
            }
            return false;
       
    }
    
    
    function onDelete(obj) {
    try {
        var row = $(obj).closest('tr');
        var rowIndex = $(row).index();
        $(row).remove();
    }
    catch (e) {
        return false;
    }
    return false;
}

  function htmlDecode(input) {
        try {
            var e = document.createElement('div');
            e.innerHTML = input;
            return e.childNodes[0].nodeValue;
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function LoadRulemaster()
    {
     try {
            $("#tblConditions > tbody").empty();
            $("#tblResCondition > tbody").empty();
            $("#tblMachineError > tbody").empty();
          

            var InvId=$('#hdnInvID').val() ;
            var InvType=$('#hdnInvType').val() ; 
            var RuleTypeID=$("#ddlRuleType option:selected").val();
            var orgID = $('#hdnOrgid').val();
            if(RuleTypeID>0)
            {
              GetInvRulemasterCondition(RuleTypeID,InvId, orgID,InvType);
              $("#ddlRuleType").prop("disabled", true);
            }
            else{
              ValidationWindow('Select Rule Type','Alert');
              return false;
            }
            
        }
        catch (e) {
            return false;
        }
    }
    function onSave() {
                  try {
                        if ($("#ddlTrigger option:selected").text() == '--Select--') 
                        {
                          ValidationWindow('Select Post Trigger Function','Alert');
                          return false;
                        }
			if($("#ddlTrigger option:selected").text() == 'Add Medical Remarks' && $('#txtmedRemarks').val()=='')
                        {
                         ValidationWindow('Add Medical Remarks','Alert');
                          return false;
                        }
                         var RemarksId= $('#hdnSelectedRemarksID').val();
                        if(TriggerFunction == 'Block Auto certification')
                        {
                        RemarksId=0;
                        }
                        var InvRuleMaster = [];
                        var PatientAgeGenderRule = [];
                        var TestResultsRule = [];
                        var MachineErrorRule = [];
                        var InvRuleMasterId=$('#hdnInvRuleMasterId').val() ;
                        var InvId = $('#hdnInvID').val();
                        var InvestigationType = $('#hdnInvType').val();
                        var RuleTypeID=$("#ddlRuleType option:selected").val();
                        var TriggerId=$("#ddlTrigger option:selected").val();
                        var TriggerFunction=$("#ddlTrigger option:selected").text();
                        var medRemarks=$('#txtmedRemarks').val() ;
                        var testName=$('#txtParameter').val() ;
                        InvRuleMaster.push({
                        RuleMasterId:InvRuleMasterId,
                        RuleTypeID:RuleTypeID,
                        InvestigationID:InvId,
                        investigationName:testName,
                        PostTriggerFunctionId:TriggerId,
                        PostTriggerFunction:TriggerFunction,
                        InvRemarksValue:RemarksId+'~'+medRemarks,
                        OrgId:$('#hdnOrgid').val(),
                        InvType: InvestigationType
                        });
                       //$('#hdnLstInvRuleMaster').val(JSON.stringify(InvRuleMaster));
                       
                        //hdnLstPatientAgeGenderRule
                       
                        //hdnLstPatientAgeGenderRule
                        
                         var hdnAgeGenderRuleId =0;
                         var ddlGender="",ddlSubCategory="",ddlAgeType="",ddlAgeOptr="",AgeValue1=0,AgeValue2=0,ddlOperator="";
                         var Gender="",SubCategory="",AgeType="",AgeOptr="",LogicalOperator="";
                         
                         $('#tblConditions tr').each(function(i, n) {
                           $row = $(n);
                            hdnAgeGenderRuleId = $row.find($('input[id$="hdnAgeGenderRuleId"]')).val();
                            ddlGender = $row.find($('select[id$="ddlGender"] option:selected'));
                            ddlSubCategory = $row.find($('select[id$="ddlSubCategory"] option:selected'));
                            ddlAgeType = $row.find($('select[id$="ddlAgeType"] option:selected'));
                            ddlAgeOptr= $row.find($('select[id$="ddlOperatorRange1"] option:selected'));
                            AgeValue1 = $row.find($('input[id$="txtAgeRange1"]')).val();
                            AgeValue2 = $row.find($('input[id$="txtAgeRange2"]')).val();
                            ddlOperator= $row.find($('select[id$="ddlOperator"] option:selected'));
                             Gender = $(ddlGender).val();
                             SubCategory = $(ddlSubCategory).val();
                             AgeType=$(ddlAgeType).val();
                             AgeOptr=$(ddlAgeOptr).val();
                             LogicalOperator=$(ddlOperator).val();
                                 PatientAgeGenderRule.push({
                                    PatientAgeGenderRuleId:hdnAgeGenderRuleId,
                                    RuleMasterId:InvRuleMasterId,
                                    ComponentName:'Patient Age and Gender',
                                    Gender:Gender,
                                    SubCategory:SubCategory,
                                    AgeType:AgeType,
                                    AgeOptr:AgeOptr,
                                    AgeValue1:AgeValue1 == '' ? 0 : AgeValue1,
                                    AgeValue2:AgeValue2 == '' ? 0 : AgeValue2,
                                    LogicalOperator:LogicalOperator,
                                    RemarksId:RemarksId
                                    });
                         });
                          //$('#hdnLstPatientAgeGenderRule').val(JSON.stringify(PatientAgeGenderRule));
                          //hdnLstTestResultsRule
                          
                          var hdnResultRuleId =0,ResultInvestigationID=0;
                         var ddlOperatorRange1="",ddlResultType="";
                         var ResultInvestigation="",ResultType="",ResultOptr="",ResultValue1="",Resultvalue2="",LogicalOperator="";
                         var resid=1;
                         $('#tblResCondition tr').each(function(i, n) {
                           $row = $(n);
                            hdnResultRuleId = $row.find($('input[id$="hdnResultRuleId"]')).val();
                            ResultInvestigation = $row.find($('input[id$="txtCondInv"]')).val();
                            ResultInvestigationID = $row.find($('input[id$="txtCondInvId"]')).val();
                            ddlResultType = $row.find($('select[id$="ddlResultType"] option:selected'));
                            ddlOperatorRange1 = $row.find($('select[id$="ddlOperatorRange1"] option:selected'));
                            ResultValue1 = $row.find($('input[id$="txtAgeRange1"]')).val();
                            ResultValue2 = $row.find($('input[id$="txtAgeRange2"]')).val();
                            ddlOperator= $row.find($('select[id$="ddltestOperator"] option:selected'));
                             ResultType = $(ddlResultType).val();
                             ResultOptr = $(ddlOperatorRange1).text();
                             LogicalOperator=$(ddlOperator).val();
                             if(ResultInvestigationID == '0')
                             {
                              resid=0;
                             }
                                 TestResultsRule.push({
                                    TestResultsRuleId:hdnResultRuleId,
                                    RuleMasterId:InvRuleMasterId,
                                    ComponentName:'Test Result',
                                    ResultInvestigationID:ResultInvestigationID,
                                    ResultInvestigation:ResultInvestigation,
                                    ResultType:ResultType,
                                    ResultOptr:ResultOptr,
                                    ResultValue1:ResultValue1 == '' ? "0" : ResultValue1,
                                    Resultvalue2:ResultValue2 == '' ? "0" : ResultValue2,
                                    LogicalOperator:LogicalOperator,
                                    RemarksId:RemarksId
                                    });
                         });
                         
                         if(resid==0)
                         {
                          ValidationWindow('Select Investigation','Alert');
                          return false;
                         }
                         
                         // $('#hdnLstTestResultsRule').val(JSON.stringify(TestResultsRule));
                        
                          //hdnLstMachineErrorRule
                           var hdnErrorRuleId =0,txtMachineErr="",ddlOperator="",LogicalOperator="";
                         $('#tblMachineError tr').each(function(i, n) {
                           $row = $(n);
                            hdnErrorRuleId = $row.find($('input[id$="hdnErrorRuleId"]')).val();
                            txtMachineErr = $row.find($('input[id$="txtMachineErr"]')).val();
                            ddlOperator= $row.find($('select[id$="ddltestOperator"] option:selected'));
                             LogicalOperator=$(ddlOperator).val();
                             MachineErrorRule.push({
                                    MachineErrorRuleId:hdnErrorRuleId,
                                    RuleMasterId:InvRuleMasterId,
                                    ComponentName:'Machine Error',
                                    ErrorCode:txtMachineErr,
                                    LogicalOperator:LogicalOperator
                                    });
                           });
                          // $('#hdnLstMachineErrorRule').val(JSON.stringify(MachineErrorRule));  
                                                      
                        saveRulemaster(JSON.stringify(InvRuleMaster),JSON.stringify(PatientAgeGenderRule),JSON.stringify(TestResultsRule),JSON.stringify(MachineErrorRule),RemarksId);
                        return false;
                    }
                   catch (e) {
                        return false;
                    }
    }
    
    function GetInvRulemasterCondition(RuleTypeid,investigationid, orgID,InvType)
    {
    try{
    var orgID = $('#hdnOrgid').val();
     $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetInvRulemasterCondition",
                data: "{'RuleTypeid':'" + RuleTypeid + "','investigationid':'" + investigationid + "', 'orgID': '" + orgID + "','InvType': '" + InvType + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                LoadRuleCondition(data.d);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }
            });
            }
            catch (e) {

        }
    }   
    function ViewRules()
    {
    try{
    $("#tblConditions > tbody").empty();
            $("#tblResCondition > tbody").empty();
            $("#tblMachineError > tbody").empty();
            //$("#tblConditionRule > tbody").empty();
           $('#tblConditionRule tr:gt(0)').remove()
              $('#divag').hide();
            $('#divtestres').hide();
            $('#divMachineError').hide();
            $('#txtmedRemarks').val('');
            $("[id*=chkComponent]").removeAttr("checked");
            var InvId=$('#hdnInvID').val() ;
            var InvType=$('#hdnInvType').val() ; 
            var RuleTypeID=$("#ddlRuleType option:selected").val();
            var orgID = $('#hdnOrgid').val();
     $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetAllRulemasterCondition",
                data: "{'RuleTypeid':'" + RuleTypeID + "','investigationid':'" + InvId + "', 'orgID': '" + orgID + "','InvType': '" + InvType + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded ,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }
            });
            }
            catch (e) {

        }
        return false;
    }
    
    function AjaxGetFieldDataSucceeded(result) {
        var oTable;
        if (result != "[]") {
            oTable = $('#tblViewRules').dataTable({
                "bDestroy": true,
                "bAutoWidth": false,
                "bProcessing": true,
                "aaData": result.d,
                "bSort": false,
                "fnStandingRedraw": function() { //pop.show(); 
                },
                "aoColumns": [
            {"mDataProp": "RuleMasterId", "bVisible": false }, 
            {"mDataProp": "InvestigationID", "bVisible": false  }, 
            {"mDataProp": "InvType", "bVisible": false },
            {"mDataProp": "RemarksId", "bVisible": false  }, 
            {"mDataProp": "Code" }, 
            {"mDataProp": "InvestigationName"}, 
            {"mDataProp": "ComponentName"}, 
            {"mDataProp": "Condition" }, 
            {"mDataProp": "PostTriggerFunction"}, 
            {"mDataProp": "RuleTypeID",
             "mRender": function(data, type, full) {
              return '<input id="btnEdit_' + full.RuleTypeID +'_'+ full.InvestigationID +'_'+ full.InvType +'" class="edtIcons" value="edit" type="button" style="color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="EditRule(this);" />&nbsp;&nbsp;<input id="btnDel_' + full.RuleMasterId +'_'+ full.RuleTypeID +'_'+full.RemarksId+'_'+ full.InvestigationID +'" class="deleteIcons" value="Delete" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onRuleDelete(this);" />'
            }
      },
           ],
                "sPaginationType": "full_numbers",
                "bDestroy": true,
                "bAutoWidth": false,
                "bSort": false,
                "bProcessing": true,
                //"sScrollY": "300px",
                "bPaginate": false,

                "aaSorting": [[1, "asc"]],
                "iDisplayLength": 100
                //  "sScrollY": "302px",
                //  "sScrollXInner": "150%",
                // "bScrollCollapse": true,
                //"bAutoWidth": false,
                // "bAutoHeight": true,
                
            });
//            $(window).bind('resize', function() {
//                oTable.fnAdjustColumnSizing();
//            });
             $('#tblViewRules').show();
             $('#divViewRules').show();
            
        }
    }
    
    function EditRule(name)
    {
    
    RuleTypeID=name.id.split('_')[1];
    InvId=name.id.split('_')[2];
    InvType=name.id.split('_')[3];
    orgID=$('#hdnOrgid').val();
//    $('#hdnInvID').val(InvId);
//    $('#hdnInvType').val(InvType);
//    $("#ddlRuleType").val(RuleTypeID);
      $('#divViewRules').hide();
    GetInvRulemasterCondition(RuleTypeID,InvId, orgID,InvType);
    }
    
    
    function onRuleDelete(name)
    {
       orgID=$('#hdnOrgid').val();
        if(name.value=='DeleteCond')
        {
          ddlid=name.id.replace('tblruleCond','lblRemarksId');
            RemarksId =$("#"+ddlid).text();
            invid=name.id.replace('tblruleCond','lblInvId');
             InvId =$("#"+invid).text();
            
            ruleid=name.id.replace('tblruleCond','lblRuleid');
             RuleMasterId=$("#"+ruleid).text();
             lblinvType=name.id.replace('tblruleCond','lblInvType');
             
            InvType=$("#"+lblinvType).text();
            RuleTypeID=$("#ddlRuleType option:selected").val();
            deleteRuleMaster(RuleMasterId,RuleTypeID,InvId,RemarksId);
            GetInvRulemasterCondition(RuleTypeID,InvId, orgID,InvType)
        
        }
        else{
        RuleMasterId=name.id.split('_')[1];
         RuleTypeID=name.id.split('_')[2];
          RemarksId=name.id.split('_')[3];
          InvId=name.id.split('_')[4];
          deleteRuleMaster(RuleMasterId,RuleTypeID,InvId,RemarksId);
           ViewRules();
        }
        
    }
   
   function deleteRuleMaster(RuleMasterId,RuleTypeID,InvId,RemarksId)
    {
    try{
    var orgID = $('#hdnOrgid').val();
     $.ajax({
                type: "POST",
                url: "../WebService.asmx/deleteRuleMaster",
                data: "{'RuleMasterId':'" + RuleMasterId + "','RuleTypeid':'" + RuleTypeID + "','investigationid':'" + InvId + "', 'orgID': '" + orgID + "', 'RemarksId': '" + RemarksId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }
            });
            }
            catch (e) {

        }
    }
   
  function HideViewRulePopup()
  {
    $('#divViewRules').hide();
   return false;
  }
    function GetInvRulemaster(RuleTypeid,investigationid, orgID,RemarksId)
    {
    try{
    var orgID = $('#hdnOrgid').val();
     $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetInvRulemaster",
                data: "{'RuleTypeid':'" + RuleTypeid + "','investigationid':'" + investigationid + "', 'orgID': '" + orgID + "', 'RemarksId': '" + RemarksId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                BindRuleMaster(data.d);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }
            });
            }
            catch (e) {

        }
    }
    function BindRuleMaster(data)
    {
      if(data[0].length>0)
      {
       // $('#ddlRuleType').val(data[0][0].RuleTypeID);
        $('#txtParameter').val(data[0][0].InvestigationName);
        $('#hdnInvRuleMasterId').val(data[0][0].RuleMasterId) ;
        $('#hdnInvID').val(data[0][0].InvestigationID) ;
        $('#hdnInvType').val(data[0][0].InvType) 
        $('#ddlTrigger').val(data[0][0].PostTriggerFunctionId) ;
        $('#txtmedRemarks').val(data[0][0].InvRemarksValue) ;
        $('input[id$="hdnSelectedRemarksID"]').val(data[0][0].RemarksId)
        
        if(data[0][0].InvRemarksValue.length>0)
        {
          $('#divlblmedremarks').show();
          $('#divtxtmedremarks').show(); 
          $('#txtmedRemarks').show();
        }
        else{
          $('#divlblmedremarks').hide();
          $('#divtxtmedremarks').hide(); 
          $('#txtmedRemarks').hide()
        }
        
        if(data[1].length>0)
        {    
            $('#divag').show();
            $('#chkComponent').find('label:contains("' + data[1][0].ComponentName+ '")').prev().prop('checked', true);
            jQuery.each( data[1], function( i, val1 ) {
            AddPatientAgeandGenderCondition(this);
            $('#tblConditions' + i + 'hdnAgeGenderRuleId').val(val1.PatientAgeGenderRuleId) ;
            $('#tblConditions' + i + 'ddlGender').val(val1.Gender) ;
            $('#tblConditions' + i + 'ddlSubCategory').val(val1.SubCategory) ;
            $('#tblConditions' + i + 'ddlAgeType').val(val1.AgeType) ;
            $('#tblConditions' + i + 'ddlOperatorRange1').val(val1.AgeOptr) ;
            $('#tblConditions' + i + 'txtAgeRange1').val(val1.AgeValue1) ;
            $('#tblConditions' + i + 'ddlOperator').val(val1.LogicalOperator) ;
                if(val1.AgeOptr ==  'Between')
                {
                 $('#tblConditions' + i + 'txtAgeRange2').show();
                 $('#tblConditions' + i + 'DivAgeRange2').show();
                 $('#tblConditions' + i + 'txtAgeRange2').val(val1.Agevalue2) ;

                }
            });
        }
        if(data[2].length>0)
        {
           $('#divtestres').show();
           $('#chkComponent').find('label:contains("' + data[2][0].ComponentName+ '")').prev().prop('checked', true);
            jQuery.each( data[2], function( i, val1 ) {
            AddTestResultsCondition(this);
            $('#tblResCondition' + i + 'hdnResultRuleId').val(val1.TestResultsRuleId) ;
            $('#tblResCondition' + i + 'txtCondInv').val(val1.ResultInvestigation) ;
            $('#tblResCondition' + i + 'txtCondInvId').val(val1.ResultInvestigationID) ;
            $('#tblResCondition' + i + 'ddlResultType').val(val1.ResultType) ;
            $('#tblResCondition' + i + 'txtAgeRange1').val(val1.ResultValue1) ;
            $('#tblResCondition' + i + 'ddltestOperator').val(val1.LogicalOperator) ;            
            if (val1.ResultType == 'RES') {
                   $('#tblResCondition' + i + 'ddlOperatorRange1 option').remove();
                   $('#tblResCondition' + i + 'txtAgeRange1').hide();
                 var lstAbnormal = JSON.parse($('input[id$="hdnAbnormal"]').val());
                 $.each(lstAbnormal, function(j, obj) {
                      $('#tblResCondition' + i + 'ddlOperatorRange1').append(
                    $('<option></option>').val(obj.Name).html(obj.Name));
                       
                    });
            }
            else if (val1.ResultType == 'VR') {
                $("#tblResCondition" + i + "ddlOperatorRange1 option").remove();
                $('#tblResCondition' + i + 'txtAgeRange1').show();
                 var lstAgeRangeOpr = JSON.parse($('input[id$="hdnLstAgeRangeOpr"]').val());
                 $.each(lstAgeRangeOpr, function(j, obj) {
                     $('#tblResCondition' + i + 'ddlOperatorRange1').append(
                    $('<option></option>').val(obj.Value).html(obj.Name));
                     
                    });
            }
           $('#tblResCondition' + i + 'ddlOperatorRange1').val(val1.ResultOptr) ;
            if(val1.ResultOptr ==  'Between')
                {
                 $('#tblResCondition' + i + 'txtAgeRange2').show();
                 $('#tblResCondition' + i + 'DivAgeRange2').show();
                 $('#tblResCondition' + i + 'txtAgeRange2').val(val1.Resultvalue2) ;
                }
                 
            });
        }
         if(data[3].length>0)
        {
            $('#divMachineError').show();
            $('#chkComponent').find('label:contains("' + data[3][0].ComponentName+ '")').prev().prop('checked', true);
            jQuery.each( data[3], function( i, val1 ) {
            AddMachineErrorCondition(this);
            $('#tblMachineError' + i + 'hdnErrorRuleId').val(val1.MachineErrorRuleId) ;
            $('#tblMachineError' + i + 'txtMachineErr').val(val1.ErrorCode) ;
            $('#tblMachineError' + i + 'ddltestOperator').val(val1.LogicalOperator) ;
            });
        }
      }
    }
    function saveRulemaster(InvRuleMaster,PatientAgeGenderRule,TestResultsRule,MachineErrorRule,RemarksId)
    {
    
    try{
    var orgID = $('#hdnOrgid').val();
     $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveInvRulemaster",
                data: "{'StrInvRuleMaster':'" + InvRuleMaster + "','StrPatientAgeGenderRule':'" + PatientAgeGenderRule + "', 'StrTestResultsRule': '" + TestResultsRule + "','StrMachineErrorRule':'" + MachineErrorRule + "','orgID': '" + orgID + "','RemarksId': '" + RemarksId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                ValidationWindow('Saved Successfully','Alert');
                LoadRuleCondition(data.d);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }
            });
            }
            catch (e) {

        }
    }
    
    function LoadRuleCondition(data)
    {
     try {
            $("#tblConditions > tbody").empty();
            $("#tblResCondition > tbody").empty();
            $("#tblMachineError > tbody").empty();
            //$("#tblConditionRule > tbody").empty();
           $('#tblConditionRule tr:gt(0)').remove()
              $('#divag').hide();
            $('#divtestres').hide();
            $('#divMachineError').hide();
            $('#txtmedRemarks').val('');
            $("[id*=chkComponent]").removeAttr("checked");
            $('#hdnInvRuleMasterId').val('0');
            var InvId=$('#hdnInvID').val() ;
            
            
            
            var RuleTypeID=$("#ddlRuleType option:selected").val();
            var orgID = $('#hdnOrgid').val();
            
                    if(data[0].length>0)
                    {   // $('#hdnInvRuleMasterId').val(data[0][0].RuleMasterId);
                        $('#Div1Cond').show();
                       // $('#chkComponent').find('label:contains("' + data[1][0].ComponentName+ '")').prev().prop('checked', true);
                        jQuery.each( data[0], function( i, val1 ) {
                        AddRuleCondition(this);
                        $('#lblRuleid' + i).html(val1.RuleMasterId) ;
                        $('#lblRuleTypeid' + i).html(val1.RuleTypeID) ;
                        $('#lblInvId' + i).html(val1.InvestigationID) ;
                        $('#lblInvType' + i).html(val1.InvType) ;
                        $('#lblRemarksId' + i).html(val1.RemarksId) ;
                        $('#lblInvName' + i).html(val1.InvestigationName) ;
                        $('#lblCode' + i).html(val1.Code) ;
                        $('#lblCompName' + i).html(val1.ComponentName) ;
                        $('#lblPostTrifn' + i).html(val1.PostTriggerFunction) ;
                        $('#lblCondi' + i).html(val1.Condition) ;
                        });
                    }
            
          }
        catch (e) {
            return false;
        }
    }
    
function AddRuleCondition(name)
    {
    
    var rowCount = $("#tblConditionRule tr").length-1;
       var row = '<tr style="height: 17px;">';
        var strdel =  "Click here to remove Conditions";
    var strEdit=  "Click here to Edit Conditions";
       
       lblInvname= '<td align="left"><input id="lblRuleid' + rowCount + '" type="hidden" value="0" /><input id="lblRuleTypeid' + rowCount + '" type="hidden" value="0" /><input id="lblRemarksId' + rowCount + '" type="hidden" value="0" /><input id="lblInvType' + rowCount + '" type="hidden" value="0" /><input id="lblInvId' + rowCount + '" type="hidden" value="0" /><span id="lblInvName' + rowCount + '"></span></td>';
       lblCode= '<td align="left"><span id="lblCode' + rowCount + '"></span></td>';
       lblCompName= '<td align="left"><span id="lblCompName' + rowCount + '"></span></td>';
       lblCondi= '<td align="left"><span id="lblCondi' + rowCount + '"></span></td>';
       lblPostTrifn= '<td align="left"><span id="lblPostTrifn' + rowCount + '"></span></td>';
       var btnDeleteCondition = '<input id="tblruleCond' + rowCount + '" class="deleteIcons" value="DeleteCond" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onRuleDelete(this);" title='+strdel+' />';
       var btnAddCondition = '<input id="tblruleCond' + rowCount + '" class="edtIcons" value="AddAgeGenderCond" type="button" style="color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="EditRuleCondition(this);" title='+strEdit+' />';
       
       row += lblInvname;
       row += lblCode;
       row += lblCompName;
       row += lblCondi;
       row += lblPostTrifn;
       row += '<td align="left">' + btnAddCondition +'&nbsp;&nbsp;&nbsp;'+ btnDeleteCondition + '</td>';
       //row += '<td align="center">' + btnDeleteCondition + '</td>';
       
       row += "</tr>";
        $("#tblConditionRule").append(row)
    }
  function Cleardata()
  {
   $("#ddlRuleType").prop("disabled", false);
     location.reload();
  }
//    var hdnRemarksType = '<%#hdnRemarksType.ClientID %>';
//    var hdnRemarksTypeName = '<%#hdnRemarksTypeName.ClientID %>';
   function SelectedRemarks(Source, eventArgs) {
        try {
            var RemarkCode = eventArgs.get_value().split('~');
            $('input[id$="hdnSelectedRemarksID"]').val(eventArgs.get_value().split('~')[0]);
            $('#' + hdnRemarksContent).val(eventArgs.get_text());
        }
        catch (e) {
            return false;
        }
    }
    function RemarksPopulated(Source, eventArgs) {
        try {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('input[id$="hdnSelectedRemarksID"]').val('0');
                $('#' + hdnRemarksContent).val('');
            }
        }
        catch (e) {
            return false;
        }
    }
    
    function ShowRemarkPopup() {
        $('#divModalAddRemarks').show();
        return false;
    }
    function HideRefRangePopup() {
        $('#divModalAddRemarks').hide();
        return false;
    }
    
    function EditRuleCondition(name){
    $("#tblConditions > tbody").empty();
            $("#tblResCondition > tbody").empty();
            $("#tblMachineError > tbody").empty();
             $('#divag').hide();
            $('#divtestres').hide();
            $('#divMachineError').hide();
            $("[id*=chkComponent]").removeAttr("checked");
          
 
    ddlid=name.id.replace('tblruleCond','lblRemarksId');
    var remarksId =$("#"+ddlid).text();
    var RuletypeID=$('#'+name.id.replace('tblruleCond','lblRuleTypeid'))[0].innerText;
    var InvType=$('#'+name.id.replace('tblruleCond','lblInvType'))[0].innerText;
    var InvId=$('#'+name.id.replace('tblruleCond','lblInvId'))[0].innerText;
        $('#hdnInvID').val(InvId);
     $('#hdnInvType').val(InvType);
     $("#ddlRuleType").val(RuletypeID);
     var InvId=$('#hdnInvID').val();
            var InvType=$('#hdnInvType').val() ; 
           // var RuleTypeID=$("#ddlRuleType option:selected").val();
           var RuleID=$('#'+name.id.replace('tblruleCond','lblRuleid'))[0].innerText;
            var orgID = $('#hdnOrgid').val();
            if(RuleID>0)
            {
              GetInvRulemaster(RuleID,InvId, orgID,remarksId);
              $("#ddlRuleType").prop("disabled", true);
            }
    }
    
    function Validate() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") : "Select Remarks Type";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_12") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_12") : "Enter Remark Code";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") : "Enter New Remark";
        var UsrAlrtMsg3 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_14") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_14") : "Added Successfully";
        var UsrAlrtMsg4 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_15") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_15") : "Code already exists";
        var UsrAlrtMsg5 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_16") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_16") : "Error! Not Inserted";


        try {
            if ($('#TabSave_Tab1Save_ddlType option:selected').val() == '0') {
                // alert("Select Remarks Type");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                $('#TabSave_Tab1Save_ddlType').focus();
                return false;
            }
            else if (document.getElementById('TabSave_Tab1Save_txtremarkCode').value == "") {
                //alert('Enter Remark Code');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                return false;

            }
            else if (document.getElementById('TabSave_Tab1Save_txtremark').value == "") {
                //alert('Enter New Remark');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                return false;

            }
            else {
                var RemarkCode = (document.getElementById('TabSave_Tab1Save_txtremarkCode').value);
                var Remark = (document.getElementById('TabSave_Tab1Save_txtremark').value);
                var RemarkType;
                if ($('#TabSave_Tab1Save_ddlType option:selected').val() == 'M') {
                    RemarkType = 'M';
                }
                else if ($('#TabSave_Tab1Save_ddlType option:selected').val() == 'T') {
                    RemarkType = 'T';
                }
                else if ($('#TabSave_Tab1Save_ddlType option:selected').val() == 'I') {
                    RemarkType = 'I';
                }
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/InsertRemarks",
                    data: "{'RemarkType': '" + RemarkType + "','RemarkCode': '" + RemarkCode + "','Remark': '" + Remark + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        var lstresult = data.d;

                        if (lstresult == 0) {
                            //alert("Added Successfully");
                            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                            $('#TabSave_Tab1Save_ddlType').val('0');
                            document.getElementById('TabSave_Tab1Save_txtremarkCode').value = ""
                            document.getElementById('TabSave_Tab1Save_txtremark').value = ""
                            return false;
                            
                        }
                        else {
                            //alert("Code already exists");
                            ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                            $('#TabSave_Tab1Save_ddlType').val('0');
                            document.getElementById('TabSave_Tab1Save_txtremarkCode').value = ""
                            document.getElementById('TabSave_Tab1Save_txtremark').value = ""
                            return false;
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        //alert("Error! Not Inserted");
                        ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                        $('#TabSave_Tab1Save_ddlType').val('0');
                        document.getElementById('TabSave_Tab1Save_txtremarkCode').value = ""
                        document.getElementById('TabSave_Tab1Save_txtremark').value = ""
                        return false;
                    }
                });
            }

        }
        catch (e) {
            return false;
        }
        return false;
    }

    function ValidateRemarks() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") : "Select Remarks Type";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") : "Select Remarks";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") : "Enter New Remark";

        try {
            if ($('#TabSave_tab2Edit_ddlRtype option:selected').val() == '0') {
                // alert("Select remarks type");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                $('#TabSave_tab2Edit_ddlRtype').focus();
                return false;

            }
            else if (document.getElementById('TabSave_tab2Edit_txttext').value == "") {
                //alert('Select Remark');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                return false;
            }
            else if (document.getElementById('TabSave_tab2Edit_txtRCode').value == "") {
                //alert('Enter New Remark');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                return false;
            }
            else if (document.getElementById('TabSave_tab2Edit_txttextRemark').value == "") {
                //alert('Enter New Remark');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                return false;
            }
            
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function SelectedRemarkID(Source, eventArgs) {

        var RemarkCode = eventArgs.get_value().split('~');
        var contents = $('#TabSave_tab2Edit_txttext').val();
        $('#TabSave_tab2Edit_txttextRemark').val(contents);
        $('#TabSave_tab2Edit_txtRCode').val(RemarkCode[1]);

        try {
            $('input[id$="hdnSelectedRemarksID1"]').val(RemarkCode[0]);
            $('#' + hdnRemarksContent).val(eventArgs.get_text());
        }
        catch (e) {
            return false;
        }
    }
    function Hide() {
        $('#TabSave_tab2Edit_ddlRtype').val('0');
        document.getElementById('TabSave_tab2Edit_txttextRemark').value = ""
        document.getElementById('TabSave_tab2Edit_txttext').value = ""
        document.getElementById('TabSave_tab2Edit_txtRCode').value = ""
    }
    
    function EditFunction() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_34") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_34") : "Updated Successfully";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_35") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_35") : "Already exists";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_36") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_36") : "Oops! Error Occured";
        try {
            var RemarkId = document.getElementById('hdnSelectedRemarksID1').value;
            var Remark = (document.getElementById('TabSave_tab2Edit_txttextRemark').value);
            var RemarkCode = (document.getElementById('TabSave_tab2Edit_txtRCode').value);
            var RemarkType;
            if ($('#TabSave_tab2Edit_ddlRtype option:selected').val() == 'M') {
                RemarkType = 'M';
            }
            else if ($('#TabSave_tab2Edit_ddlRtype option:selected').val() == 'T') {
                RemarkType = 'T';
            }
            else if ($('#TabSave_tab2Edit_ddlRtype option:selected').val() == 'I') {
                RemarkType = 'I';
            }
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/UpdateRemarks",
                data: "{'RemarkType': '" + RemarkType + "',RemarkID:" + RemarkId + ",'Remarktext': '" + Remark + "','RemarkCode': '" + RemarkCode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {

                    var lstresultRemark = data.d;
                    if (lstresultRemark == 0) {
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        //alert("Updated Successfully");
                        $('#TabSave_tab2Edit_ddlRtype').val('0');
                        document.getElementById('TabSave_tab2Edit_txttextRemark').value = ""
                        document.getElementById('TabSave_tab2Edit_txttext').value = ""
                        document.getElementById('TabSave_tab2Edit_txtRCode').value = ""
                        return false;
                    }
                    else {
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        // alert("Already exists");
                        $('#TabSave_tab2Edit_ddlRtype').val('0');
                        document.getElementById('TabSave_tab2Edit_txttextRemark').value = ""
                        document.getElementById('TabSave_tab2Edit_txttext').value = ""
                        document.getElementById('TabSave_tab2Edit_txtRCode').value = ""
                        return false;
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    // alert("Oops! Error Occured");
                   $('#TabSave_tab2Edit_ddlRtype').val('0');
                     document.getElementById('TabSave_tab2Edit_txttextRemark').value = ""
                        document.getElementById('TabSave_tab2Edit_txttext').value = ""
                        document.getElementById('TabSave_tab2Edit_txtRCode').value = ""
                        return false;
                }
            });

        }
        catch (e) {
            return false;
        }
        return false;
    }
    
   function ReLoadRulemaster()
   {
    LoadRulemaster();
    $('#hdnInvRuleMasterId').val('0');
    return false;
   }
  
</script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
            <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata" >
                    <div class="panel panel-primary">
      <div class="panel-heading">Rule Master</div>
      <div class="panel-body">
   <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <table class="w-100p">
                <tr>
                        <td style="width: 125px;">
                                    <asp:Label ID="lblruletype" Text="Rule Type" runat="server" meta:resourcekey="lblruletypeResource1"></asp:Label>
                         </td>
                        <td style="width: 220px;">
                            <span class="richcombobox" style="width: 175px;">
                                <asp:DropDownList runat="server" Width="175px" ID="ddlRuleType"  onchange="SetPostTrigger(this);" CssClass="ddl">
                                </asp:DropDownList>
                            </span>
                        </td>
                          <td style="width: 125px;">
                                                <asp:Label ID="lblCode" Text="Name / Code" runat="server" meta:resourcekey="lblCodeResource1"></asp:Label>
                                            </td>
                                            <td style="width: 250px;">
                                                 <asp:TextBox ID="txtParameter" Width="250px" CssClass="searchBox" runat="server"
                                                                            meta:resourcekey="txtCrossParameterResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteCrossParameter" runat="server" TargetControlID="txtParameter"
                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box mediumList"
                                                                            CompletionListItemCssClass="wordWheel itemsMain mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                                                            ServiceMethod="GetTestCodingScheme" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                            DelimiterCharacters="~" Enabled="True" OnClientItemSelected="SelectedCrossTest"
                                                                            OnClientPopulated="CrossTestCodeSchemePopulated">
                                                                        </ajc:AutoCompleteExtender>
                                            </td>
                                           <td class="a-left">
                                                <%--<asp:Button ID="btnLoadTestDetails" runat="server" Text="&nbsp;&nbsp;&nbsp;Load&nbsp;&nbsp;&nbsp;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return LoadRulemaster();"
                                                    meta:resourcekey="btnLoadTestDetailsResource1" TabIndex="2" />--%>
                                                      <asp:Button ID="btnReset1" runat="server" Text="&nbsp;&nbsp;&nbsp;Reset&nbsp;&nbsp;&nbsp;"
                                        ToolTip="Click here to Cancel, View Home Page" Style="cursor: pointer;" class="btn" OnClick="btnReset_Click"
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnCancelResource1"
                                        OnClientClick="Cleardata()" />
                                          <asp:Button ID="btnViewRules" runat="server" Text="&nbsp;&nbsp;&nbsp;View Rules&nbsp;&nbsp;&nbsp;"
                                        ToolTip="Click here to View Rules" Style="cursor: pointer;" class="btn" 
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnViewRulesResource1"
                                        OnClientClick="return ViewRules();return false;" />
                                            </td>
                </tr>
                    <tr>
                        <td style="width: 125px;">
                                    <asp:Label ID="Label1" Text="Component" runat="server" meta:resourcekey="lblcomponentResource1"></asp:Label>
                         </td>
                        <td style="width: 400px;">
                            <span class="richcombobox" style="width: 350px;">
                                <asp:CheckBoxList  runat="server" Width="350px" ID="chkComponent" name="chkComponent" RepeatDirection="Horizontal" CssClass="ddl">
                                </asp:CheckBoxList >
                            </span>
                            <%--<button onclick="AddConditions()" cssclass="btn"  onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" tooltip="Click here to Add">Add</button>--%>
                            <asp:Button ID="btnAdd"  runat="server" Style="cursor: pointer;" ToolTip="Click here to Conditions" 
                OnClientClick="return AddConditions(this);" Text="Add" CssClass="btn" 
                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnAddResource1" />
              
                        </td>
                        
                     
                </tr>
            </table>
   <%--  </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnLoadTestDetails" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>--%>
    <asp:UpdateProgress DynamicLayout="true" ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="a-center w-20p">
                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                    meta:resourcekey="img1Resource1" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
      </div>
    </div> 
           
<div id="Conditions" class="panel panel-primary">
      <div class="panel-heading">Conditions</div>
      <div class="panel-body">
      
      <div id="divag" class="panel-Innerheading" style="display: none;">Patient Age and Gender</div>
        <table id="tblConditions" class="searchPanel" cellpadding="3">
        </table>
        <div id="divtestres" class="panel-Innerheading" style="display: none;">Test Results</div>
        <table id="tblResCondition" class="searchPanel" cellpadding="3">
         </table>
         <div id="divMachineError" class="panel-Innerheading" style="display: none;">Machine Error</div>
        <table id="tblMachineError" class="searchPanel" cellpadding="9">
         </table>
        </div>
      
      </div>
         <div class="panel panel-primary">
              <div class="panel-heading">Trigger/Post Function</div>
              <div class="panel-body">
                <table id="tblTrigger" class="searchPanel" cellpadding="9">
                 <tr>
                        <td style="width: 50px;">
                                    <asp:Label ID="lblSelect" Text="Select" runat="server" meta:resourcekey="lblSelectResource1"></asp:Label>
                         </td>
                        <td style="width: 300px;">
                            <span class="richcombobox" style="width: 275px;">
                                <asp:DropDownList runat="server" Width="275px" ID="ddlTrigger" onchange="ShowMedRemarks(this.id);" CssClass="ddl">
                                </asp:DropDownList>
                            </span>
                        </td>
                        <td>
                        <asp:Button ID="btnAddRule" ToolTip="Click here to Save Remarks Rule" Style="cursor: pointer;"
                                        runat="server" Text="&nbsp;&nbsp;&nbsp;Add&nbsp;&nbsp;&nbsp;" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" meta:resourcekey="btnSaveResource1"
                                        OnClientClick="return onSave()"  />
                                         <asp:Button ID="Button1" runat="server" Text="Add NewRemarks" Style="background-color: Transparent;
                                                                color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                font-size: 11px;" meta:resourcekey="btnAddNewRemarksResource1" OnClientClick="return ShowRemarkPopup();" />
                        </td>
                   </tr>
                   <tr>
                        <td style="width: 50px;">
                         <div id="divlblmedremarks" style="display:none">    
                                    <asp:Label ID="lblmedRem" Text="Medical Remarks" runat="server" meta:resourcekey="lblmedRemResource1"></asp:Label>
                                    </div>
                         </td>
                        <td style="width: 300px;">
                         <div id="divtxtmedremarks" style="display:none">
                          
                            <asp:TextBox ID="txtmedRemarks" runat="server" MaxLength="50" Width="250px" CssClass="searchBox"
                                                                meta:resourcekey="txtRemarksResource1" TabIndex="1" onfocus="return onFocusRemarks();"></asp:TextBox>
                                                            &nbsp;
                            <ajc:AutoCompleteExtender ID="ACERemarks" runat="server" TargetControlID="txtmedRemarks"
                                                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box bigList"
                                                                CompletionListItemCssClass="wordWheel itemsMain bigList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 bigList"
                                                                ServiceMethod="GetRemarkDetails" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                DelimiterCharacters="" Enabled="True" OnClientItemSelected="SelectedRemarks"
                                                                OnClientPopulated="RemarksPopulated">
                                                                </ajc:AutoCompleteExtender>
                             </div>
                            
                        </td>
                   </tr>
                   <tr>
                   <td></td>
                   <td class="a-left">
                                                <asp:Button ID="btnSave" ToolTip="Click here to Save Details" Style="cursor: pointer;"
                                        runat="server" Text="&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" meta:resourcekey="btnSaveResource1"
                                        OnClientClick="return onSave()" />
                                        <asp:Button ID="btnReset" runat="server" Text="&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;"
                                        ToolTip="Click here to Cancel, View Home Page" Style="cursor: pointer;" class="btn" 
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnCancelResource1"
                                        OnClientClick="return ReLoadRulemaster()" />
                                       
                                 </td>
                   </tr>
                 </table>
              </div>
              </div>
             
             <div id="Div1Cond" style="display: none;" class="panel panel-primary">
                    <table id="tblConditionRule" class="searchPanel" cellpadding="3">
                    <thead>
                     <tr class="dataheader1 h-17">
                        <th align="left">
                            <asp:Label runat="server" ID="lblTestName" Text="TestName" meta:resourcekey="lblTestNameResource1" />
                        </th>
                        <th align="left">
                            <asp:Label runat="server" ID="lblRuleTyp" Text="RuleType" meta:resourcekey="lblRuleTypResource1" />
                        </th >
                        <th align="left">
                            <asp:Label runat="server" ID="lblComponent" Text="Component" meta:resourcekey="lblComponentResource1" />
                        </th>
                        <th align="left">
                            <asp:Label runat="server" ID="lblCondition" Text="Condition" meta:resourcekey="lblConditionResource1" />
                        </th>
                        <th align="left">
                            <asp:Label runat="server" ID="lblPostFn" Text="PostFunction" meta:resourcekey="lblPostFnResource1" />
                        </th>
                         <th align="left">
                            <asp:Label runat="server" ID="lblAction" Text="Action" meta:resourcekey="lblActionResource1" />
                        </th>
                    </tr>
                    </thead>
                     </table>
                      </div>
    
<div class="modal" id="divModalAddRemarks" style="width: 750px;">
    <ajc:TabContainer ID="TabSave" runat="server" ActiveTabIndex="1" meta:resourcekey="TabSaveResource1">
        <ajc:TabPanel runat="server" HeaderText="Add Remarks" ID="Tab1Save" CssClass="dataheadergroup"
            meta:resourcekey="Tab1SaveResource1">
            <HeaderTemplate>
               Add Remarks
            </HeaderTemplate>
            <ContentTemplate>
                <div class="dialogHeader">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="lbladdReamrks" runat="server" Text="Add Remarks" meta:resourcekey="lbladdReamrksResource1"></asp:Label>
                            </td>
                            <td align="right">
                                <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                    style="cursor: pointer;" onclick="return HideRefRangePopup();" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-body" style="overflow: hidden; height: 300px;">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lbltype" Text="Select Type" runat="server" meta:resourcekey="lbltypeResource2"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlType" runat="server" meta:resourcekey="ddlTypeResource1">
                                         
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblremarkcode" Text="Remark Code" runat="server" meta:resourcekey="lblremarkcodeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtremarkCode" runat="server" meta:resourcekey="txtremarkCodeResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblremarks" Text="Remarks" runat="server" meta:resourcekey="lblremarksResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtremark" runat="server" MaxLength="1000" TextMode="MultiLine"
                                                Width="250px" Height="100px" meta:resourcekey="txtremarkResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                  
                    <asp:Button ID="btnSubmit" runat="server" Text="Add" CssClass="btn" OnClientClick="return Validate();return false;"
                        meta:resourcekey="btnSubmitResource1" />
                    <asp:Button ID="btnRemarkCancel" runat="server" Text="&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;"
                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                        OnClientClick="return HideRefRangePopup()" meta:resourcekey="btnRemarkCancelResource1" />
                </div>
            </ContentTemplate>
        </ajc:TabPanel>
        <ajc:TabPanel runat="server" HeaderText="Edit Remarks" ID="tab2Edit" CssClass="dataheadergroup"
            meta:resourcekey="tab2EditResource1">
            <HeaderTemplate>
                Edit Remarks
            </HeaderTemplate>
            <ContentTemplate>
                <div class="dialogHeader">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="Label13" runat="server" Text="Edit Remarks" meta:resourcekey="Label13Resource1"></asp:Label>
                            </td>
                            <td align="right">
                                <img id="img2" runat="server" alt="Close" onclick="return HideRefRangePopup();" src="../Images/dialog_close_button.png"
                                    style="cursor: pointer;"></img>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-body" style="overflow: hidden; height: 300px;">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="Label10" runat="server" Text="Select Type" meta:resourcekey="Label10Resource2"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlRtype" runat="server" onchange="return onChangeRemarksType1();"
                                                meta:resourcekey="ddlRtypeResource1">
                                         
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblRemarkText" runat="server" Text="Remark Text" meta:resourcekey="lblRemarkTextResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txttext" runat="server" CssClass="searchBox" MaxLength="1000" onfocus="return onFocusRemarks1();"
                                                TabIndex="1" Width="500px" meta:resourcekey="txttextResource1"></asp:TextBox>
                                            &nbsp;
                                            <ajc:AutoCompleteExtender ID="ACEAddRemarks1" runat="server" CompletionInterval="0"
                                                CompletionListCssClass="wordWheel listMain .box bigList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 bigList"
                                                CompletionListItemCssClass="wordWheel itemsMain bigList" DelimiterCharacters=""
                                                EnableCaching="False" Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="SelectedRemarkID"
                                                OnClientPopulated="RemarksPopulated" ServiceMethod="GetRemarkDetails" ServicePath="~/WebService.asmx"
                                                TargetControlID="txttext" UseContextKey="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblRcode" runat="server" Text="Remark Code" meta:resourcekey="lblRcodeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRCode" runat="server" meta:resourcekey="txtRCodeResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblRemarkss" runat="server" Text="Remarks" meta:resourcekey="lblRemarkssResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txttextRemark" runat="server" Height="100px" MaxLength="1000" onfocus="return onFocusRemarksText();"
                                                TextMode="MultiLine" Width="250px" meta:resourcekey="txttextRemarkResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnEdit" runat="server" OnClientClick="ValidateRemarks();return EditFunction();return false;"
                        CssClass="btn" Text="Update" meta:resourcekey="btnEditResource1" />
                    <asp:Button ID="btnClear" runat="server" OnClientClick="return Hide();" CssClass="btn"
                        Text="Clear" meta:resourcekey="btnClearResource1" />
                    <asp:Button ID="btnClose" runat="server" Text="&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;"
                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                        OnClientClick="return HideRefRangePopup()" meta:resourcekey="btnCloseResource1" />
                </div>
            </ContentTemplate>
        </ajc:TabPanel>
    </ajc:TabContainer>
</div>

      <div class="modal" id="divViewRules" style="width: 1200px; height:580px;">
    <ajc:TabContainer ID="TabiewRules" runat="server" ActiveTabIndex="0" meta:resourcekey="TabSaveResource1">
        <ajc:TabPanel runat="server" HeaderText="View Rules" ID="TabPanel1" CssClass="dataheadergroup"
            meta:resourcekey="Tab1SaveResource1">
            <HeaderTemplate>
               ViewRules
            </HeaderTemplate>
            <ContentTemplate>
              <div class="dialogHeader">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="Label8" runat="server" Text="View Rules" meta:resourcekey="lblviewrulesResource1"></asp:Label>
                            </td>
                            <td align="right">
                                <img id="img3" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                    style="cursor: pointer;" onclick="return HideViewRulePopup();" />
                            </td>
                        </tr>
                    </table>
                </div>
                  <div id="tblViewRulesSearch" class="modal-body"  style="height: 450px;">
                                                    
                                                    <table id="tblViewRules" style="display: none;font-family:verdana;border-collapse:collapse;"  rules="all" border="1" >
                                                        <thead>
                                                        <tr>
                                                       
                               <th align="left">
                                RuleMasterId
                        </th >
                        <th align="left">
                        InvestigationID
                        </th >
                        <th align="left">
                            InvType
                        </th >
                        <th align="left">
                            RemarksId
                        </th >
                        <th align="left">
                           RuleType
                        </th >
                         <th align="left">
                            TestName
                        </th>
                        <th align="left">
                            Component
                        </th>
                        <th align="left">
                            Condition
                        </th>
                        <th align="left">
                            PostFunction
                        </th>
                         <th align="left">
                            Action
                        </th>
                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
            </ContentTemplate>
        </ajc:TabPanel>
        </ajc:TabContainer>
        </div>                
                      

   

    </div>

            <Attune:Attunefooter ID="Attunefooter" runat="server" />       
            <input id="hdnLstGender" runat="server" type="hidden" />
<input id="hdnLstSubCategory" runat="server" type="hidden" />
<input id="hdnLstDateAttributes" runat="server" type="hidden" />
<input id="hdnLstAgeRangeOpr" runat="server" type="hidden" />
<input id="hdnLstOperator" runat="server" type="hidden" />
<input id="hdnResultType" runat="server" type="hidden" />
<input id="hdnAbnormal" runat="server" type="hidden" />
<asp:HiddenField ID="hdnInvID" runat="server" Value="0" />
<asp:HiddenField ID="hdnInvType" runat="server" Value="" />
<asp:HiddenField ID="hdnInvRuleMasterId" runat="server" Value="0" />
<asp:HiddenField ID="hdnOrgid" runat="server" Value="0" />
<asp:HiddenField ID="hdnLstInvRuleMaster" runat="server" Value="" />
<asp:HiddenField ID="hdnLstPatientAgeGenderRule" runat="server" Value="" />
<asp:HiddenField ID="hdnLstTestResultsRule" runat="server" Value="" />
<asp:HiddenField ID="hdnLstMachineErrorRule" runat="server" Value="" />
<asp:HiddenField ID="hdnlstPostTrigger" runat="server" Value="" />
<asp:HiddenField ID="hdnSelectedRemarksID" runat="server" Value="0" />
<asp:HiddenField ID="hdnRemarksContent" runat="server" />
<asp:HiddenField ID="hdnRemarksType" runat="server" />
<asp:HiddenField ID="hdnRemarksTypeName" runat="server" />
<asp:HiddenField ID="hdnSelectedRemarksID1" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>


