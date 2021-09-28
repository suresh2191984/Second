<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Render.aspx.cs" Inherits="PMS_Render" %>

<%@ Register Src="~/PMS/controls/Header.ascx" TagName="Header" TagPrefix="Header" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="css/dashboard.css" rel="stylesheet" />
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="css/dataTables.tableTools.min.css" rel="stylesheet" />
    <link href="css/dataTables.responsive.css" rel="stylesheet" />
    <link href="css/jquery-ui.min.css" rel="stylesheet" />

    <script src="js/jquery-1.11.3.min.js" language="javascript" type="text/javascript"></script>

    <script src="js/bootstrap.min.js" language="javascript" type="text/javascript"></script>

    <script src="js/moment.min.js" language="javascript" type="text/javascript"></script>

    <script src="js/bootstrap-datetimepicker.min.js" language="javascript" type="text/javascript"></script>

    <script src="js/jquery.dataTables.min.js" language="javascript" type="text/javascript"></script>

    <script src="js/dataTables.tableTools.min.js" language="javascript" type="text/javascript"></script>

        <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>


    <%--<script src="js/dataTables.responsive.min.js" language="javascript" type="text/javascript"></script>--%>
    
    <script src="js/dataTables.bootstrap.js" language="javascript" type="text/javascript"></script>

    <script src="js/jquery-ui.min.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
        .DynamicTableov
        {
            overflow-y: auto;
            height: 350px;
        }
        .dataTables_wrapper .top
        {
            position: fixed;
            width: 100%;
            display: block;
            margin: -31px 0 0 -47px;
        }
        .dataTables_wrapper .top .dataTables_info
        {
            margin: 0 0 0 50px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
    <Header:Header ID="ucHeader" runat="server" />
    <div class="container-fluid pf-print-area">
        <div class="page-header">
            <h3>
            </h3>
        </div>
        <div class="row">
            <div class="col-sm-offset-5">
                <h4>
                    <span id="lblPageTitle" />
                </h4>
            </div>
        </div>
        <div id="divSearchFilter" class="row">
        </div>
        <div class="form-group">
            <div class="col-sm-offset-5">
                <asp:Button ID="btnRunReport" CssClass="btn btn-success" Text="Execute" runat="server"
                    OnClientClick="return RunReport()" />

                <script type="text/javascript">
                    //  var Tag = $('span[id$="lblPageTitle"]').html();
                    function getUrlParameter(name) {
                        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
                        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
                        var results = regex.exec(location.search);
                        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
                    };
                    var GetTitle = getUrlParameter('Title');
                    var pfHeaderImgUrl = '';
                    var pfHeaderTagline = GetTitle;
                    var pfdisableClickToDel = 1;
                    var pfHideImages = 0;
                    var pfImageDisplayStyle = 'right';
                    var pfDisablePDF = 0;
                    var pfDisableEmail = 1; var pfDisablePrint = 0; var pfCustomCSS = 'css/printfriendly.css';
                    var pfBtVersion = '1'; (function() {                      
                        var js, pf; pf = document.createElement('script'); pf.type = 'text/javascript'; pf.src = '//cdn.printfriendly.com/printfriendly.js'; document.getElementsByTagName('head')[0].appendChild(pf)
                    })();</script>

                <a href="https://www.printfriendly.com" style="color: #6D9F00; text-decoration: none;"
                    class="printfriendly" onclick="window.print();return false;" title="Printer Friendly and PDF">
                    <img style="border: none; -webkit-box-shadow: none; box-shadow: none;" src="//cdn.printfriendly.com/buttons/printfriendly-button.png"
                        alt="Print Friendly and PDF" /></a>
            </div>
        </div>
    </div>
    <div class="table-responsive DynamicTableov">
        <table id="DynamicTable" class="table tableHover table-bordered table-condensed tableHeaderBG print-only">
        </table>
    </div>
    <asp:HiddenField ID="hdnProcedureID" runat="server" />
    <asp:HiddenField ID="hdnLoginID" runat="server" />
    <asp:HiddenField ID="hdnTitleName" runat="server" />
    <asp:HiddenField ID="hdnLstParams" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
        var TitleInput = "";
        //        $(document).ready(function() {

        //        $('#DynamicTable').dataTable({
        //            "responsive": true,
        //            "bProcessing": true,
        //            "bserverside": true,
        //            "bPaginate": false,
        //            "bSortable": true,
        //            "aaData": rowDataSet,
        //            'bSort': true,
        //            "bFilter": true,
        //            "sZeroRecords": "No records found",
        //            "iDisplayLength": 100,
        //            "aoColumns": resultColumns,
        //            "aaSorting": [[0, "asc"]],
        //            "aoColumnDefs": [{ "sDefaultContent": null,
        //                "aTargets": [0]}],
        //                "sDom": '<"top"iTf>t',
        //                "oTableTools": {
        //                    "sSwfPath": "../PMS/swf/copy_csv_xls_pdf.swf",
        //                    "aButtons": [
        //                             { "sExtends": "csv", "mColumns": "visible" },
        //                              { "sExtends": "print", "mColumns": "visible" },
        //                           { "sExtends": "xls", "mColumns": "visible" },
        //                            { "sExtends": "pdf", "mColumns": "visible" },
        //                          ]
        //                }
        //            });

//        });

        function removeURL() {
            $('#algo-iframe').contents().find('body #pf-src').hide();
        }

        $(function() {
       
            var procID = $('input[id$="hdnProcedureID"]').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "WebService.asmx/GetParametersforProcedure",
                data: JSON.stringify({ ProcedureID: procID }),
                dataType: "json",
                async: false,
                success: function(data) {
                    if (data.d.length > 0) {
                        var list = data.d;
                        if (list[0].length > 0) {
                            $('span[id$="lblPageTitle"]').html($('input[id$="hdnTitleName"]').val());
                            var ListParam = list[0];
                            $('input[id$="hdnLstParams"]').val(JSON.stringify(ListParam));
                            $.each(ListParam, function(i, obj) {

                                var divParent = $(document.createElement('div'));
                                var newDynamicDiv = $(divParent).attr("id", 'DynamicCtrlDiv' + i);
                                $(divParent).addClass("form-group");
                                var CtrlType = obj.InputType;
                                if (CtrlType.toLowerCase() == 'datetime') {
                                    if (!obj.Optional) {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + ' *</label>');
                                    }
                                    else {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + '</label>');
                                    }
                                    var parentDiv = $(document.createElement('div'));
                                    $(parentDiv).addClass("col-sm-3");
                                    $(parentDiv).append('<input type="hidden" id="optional' + obj.ParamName + '" value="' + obj.Optional + '" />');
                                    var dateDiv = $(document.createElement('div'));
                                    $(dateDiv).addClass("input-group date");
                                    $(dateDiv).attr("id", 'div' + obj.ParamName);
                                    $(dateDiv).append('<input type="text" class="form-control" id="' + obj.ParamName + '" value="" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>');
                                    $(dateDiv).datetimepicker({
                                        format: "DD/MM/YYYY HH:mm:ss" ,
                                        sideBySide: true,
                                        showTodayButton: true,
                                        showClose: true
                                    });
                                    $(parentDiv).append($(dateDiv));
                                    $(divParent).append($(parentDiv));
                                }
                                else if (CtrlType.toLowerCase() == 'date') {
                                    if (!obj.Optional) {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + ' *</label>');
                                    }
                                    else {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + '</label>');
                                    }
                                    var parentDiv = $(document.createElement('div'));
                                    $(parentDiv).addClass("col-sm-3");
                                    $(parentDiv).append('<input type="hidden" id="optional' + obj.ParamName + '" value="' + obj.Optional + '" />');
                                    var dateDiv = $(document.createElement('div'));
                                    $(dateDiv).addClass("input-group date");
                                    $(dateDiv).attr("id", 'div' + obj.ParamName);
                                    $(dateDiv).append('<input type="text" class="form-control" id="' + obj.ParamName + '" value="" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>');
                                    $(dateDiv).datetimepicker({
                                        format: "DD/MM/YYYY",
                                        showTodayButton: true,
                                        showClose: true
                                    });
                                    $(parentDiv).append($(dateDiv));
                                    $(divParent).append($(parentDiv));
                                }
                                else if (CtrlType.toLowerCase() == 'time') {
                                    if (!obj.Optional) {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + ' *</label>');
                                    }
                                    else {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + '</label>');
                                    }
                                    var parentDiv = $(document.createElement('div'));
                                    $(parentDiv).addClass("col-sm-3");
                                    $(parentDiv).append('<input type="hidden" id="optional' + obj.ParamName + '" value="' + obj.Optional + '" />');
                                    var dateDiv = $(document.createElement('div'));
                                    $(dateDiv).addClass("input-group date");
                                    $(dateDiv).attr("id", 'div' + obj.ParamName);
                                    $(dateDiv).append('<input type="text" class="form-control" id="' + obj.ParamName + '" value="" /><span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>');
                                    $(dateDiv).datetimepicker({
                                        format: 'LT',
                                        showClose: true
                                    });
                                    $(parentDiv).append($(dateDiv));
                                    $(divParent).append($(parentDiv));
                                }
                                else if (CtrlType.toLowerCase() == 'ddl') {
                                    if (!obj.Optional) {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + ' *</label>');
                                    }
                                    else {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + '</label>');
                                    }
                                    var ddl = $('<select id="' + obj.ParamName + '">');
                                    $(ddl).addClass("form-control");
                                    $(ddl).append('<option value="' + -1 + '">---Select---</option>');
                                    var ParamQueryID = obj.ParamQueryID;
                                    var ddlCtrl = $('#' + obj.ParamName);
                                    var lID = $('input[id$="hdnLoginID"]').val();
                               
                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "WebService.asmx/GetDDLValuesForParameters",
                                        data: JSON.stringify({ ParamQueryID: ParamQueryID, lID: lID }),
                                        dataType: "json",
                                        async: false,
                                        success: function(data) {
                                            if (data.d.length > 0) {
                                                var list = data.d;
                                                if (list[0].length > 0) {
                                                    var ListValues = list[0];
                                                    $.each(ListValues, function(i, objNew) {
                                                        $(ddl).append('<option value="' + objNew.Code + '">' + objNew.DisplayName + '</option>');
                                                    });
                                                }
                                            }
                                        },
                                        error: function(result) {
                                            alert("Error in DDL Method");
                                        }
                                    });
                                    $(divParent).append($('<div class="col-sm-3">').append('<input type="hidden" id="optional' + obj.ParamName + '" value="' + obj.Optional + '" >').append($(ddl)));
                                }
                                else {
                                    if (!obj.Optional) {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label" id="lbl' + obj.ParamName + '">' + obj.DisplayName + ' *</label>');
                                        $(divParent).append('<div class="col-sm-3"><input type="hidden" id="optional' + obj.ParamName + '" value="' + obj.Optional + '" /><input type="text" class="form-control" id="' + obj.ParamName + '" value="" required></div>');
                                    }
                                    else {
                                        $(divParent).append('<label for="' + obj.ParamName + '" class="col-sm-4 control-label"  id="lbl' + obj.ParamName + '">' + obj.DisplayName + '</label>');
                                        $(divParent).append('<div class="col-sm-3"><input type="hidden" id="optional' + obj.ParamName + '" value="' + obj.Optional + '" /><input type="text" class="form-control" id="' + obj.ParamName + '" value="" required></div>');
                                    }
                                }
                                $('#divSearchFilter').append(newDynamicDiv);
                            });
                        }
                    }
                },
                error: function(result) {
                    alert("Error in Json Method");
                }
            });
        });

        function RunReport() {

            var returnValue = true;
            var reqParamName = "";
            var lstParams = [];
            if ($.trim($('input[id$="hdnLstParams"]').val()) != '') {
                lstParams = JSON.parse($('input[id$="hdnLstParams"]').val());
            }
            var GetValue = "";
            var value = '';
            var ctlType = '';
            $.each(lstParams, function(i, obj) {
                ctlType = $('#' + obj.ParamName).prop('tagName');
                var isOptional = $('#optional' + obj.ParamName).val();
                reqParamName = $('#lbl' + obj.ParamName).html();
                if (ctlType == "INPUT") {
                    var txtValue = $.trim($('#' + obj.ParamName).val());
                    GetValue = GetValue + "'" + txtValue + "'" + ",";
                    if (txtValue == "" && isOptional == "false") {
                        returnValue = false;
                    }
                }
                else if (ctlType == "SELECT") {
                    var ddlValue = $('#' + obj.ParamName + ' option:selected').val();
                    var ddlIndex = $('#' + obj.ParamName + ' option:selected').index();

                    if (ddlIndex == 0 && isOptional == "false") {
                        returnValue = false;
                    }
                    if ($.isNumeric(ddlValue)) {
                        GetValue = GetValue + ddlValue + ",";
                    }
                    else {
                        GetValue = GetValue + "'" + ddlValue + "'" + ",";
                    }
                }
                if (!returnValue) {
                    return false;
                }
            });
            if (returnValue) {
                pfHeaderTagline = '';
                TitleInput = pfHeaderTagline;
                var pfHeaderImgUrl = ''; var pfdisableClickToDel = 1; var pfHideImages = 0;
                var pfImageDisplayStyle = 'right'; var pfDisablePDF = 0; var pfDisableEmail = 1; var pfDisablePrint = 0; var pfCustomCSS = '';
                var pfBtVersion = '1'; (function() {
                    var js, pf; pf = document.createElement('script'); pf.type = 'text/javascript';
                    pf.src = '//cdn.printfriendly.com/printfriendly.js'; document.getElementsByTagName('head')[0].appendChild(pf)
         
                })();
                GetValue = GetValue.substring(0, GetValue.length - 1);
                var pProcedureID = $('#hdnProcedureID').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebService.asmx/RenderingReport",
                    data: JSON.stringify({ ProcedureID: pProcedureID, StringParam: GetValue }),
                    dataType: "json",
                    async: false,
                    success: AjaxGetFieldDataSucceeded,
                    error: function(result) {
                        alert("Error in Json Method");
                    }
                });
      
            }
            else {
                reqParamName = reqParamName.replace("*", "");
                alert(reqParamName + " parameter is mandatory");
            }
            return false;
        }
        function AjaxGetFieldDataSucceeded(result) {

            try {

                CreateDynamicGrid(result);

            }
            catch (e) {
                alert("No Data Found");
            }
        }
        var rowDataSet = [];
        var resultColumns = [];
        function CreateDynamicGrid(result) {
            rowDataSet.length = 0;
            if (result.d.length > 0) {
                var list = result.d;
                if (list[0].length > 0) {
                    var tabledata = list[0];
                    var parseJSONResult = JSON.parse(tabledata)
                    var i = 0;
                    $.each(parseJSONResult[0], function(key, value) {
                        var obj = { sTitle: key };
                        resultColumns[i] = obj;
                        i++;
                    });
                    var i = 0;
                    $.each(parseJSONResult, function(key, value) {
                        var rowData = [];
                        var j = 0;
                        $.each(parseJSONResult[i], function(key, value) {
                            rowData[j] = value;
                            j++;
                        });
                        rowDataSet[i] = rowData;
                        i++;
                    });

                    BindValues(true);
                  
                }
            }
            else {
                alert('Execution completed Successfully !!!');
            }

        }

        function BindValues(PageIng) {

            if (rowDataSet != null && resultColumns.length >= 0) {
          

                $('#DynamicTable').dataTable({
                    "responsive": true,
                    "bProcessing": true,
                    "bserverside": true,
                    "bPaginate": false,
                    "bSortable": true,
                    "aaData": rowDataSet,
                    "bDestroy": true,
                    'bSort': true,
                    "bFilter": true,
                    "sZeroRecords": "No records found",
                    "iDisplayLength": 100,
                    "aoColumns": resultColumns,
                    "aaSorting": [[0, "asc"]],
                    "aoColumnDefs": [{ "sDefaultContent": null,
                        "aTargets": [0]}],
                        "sDom": '<"top"iTf>t',
                        "oTableTools": {
                            "sSwfPath": "../PMS/swf/copy_csv_xls_pdf.swf",
                            "aButtons": [
                             { "sExtends": "csv", "mColumns": "visible" },
                              { "sExtends": "print", "mColumns": "visible" },
                           { "sExtends": "xls", "mColumns": "visible" },
                            { "sExtends": "pdf", "mColumns": "visible" },
                          ]
                        }
                    });
                    $('#DynamicTable').show();

                    

                    return false;
                }
            }
            
    </script>

    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

</body>
<link href="css/printfriendly.css" media"print" rel="stylesheet" type="text/css" />
</html>
