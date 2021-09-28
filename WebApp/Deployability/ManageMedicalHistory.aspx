<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageMedicalHistory.aspx.cs" EnableEventValidation="false" Inherits="Deployability_Interdependency" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
    <style>
       
       #processMessage{z-index:9999999998 !important;}
       #progressBackgroundFilter{z-index:9999999999 !important;}
        .marginL370{margin-left:370px  !important;}
        .marginL570{margin-left:570px  !important;}
        .marginL30{margin-left:30px;}
        .marginL50{margin-left:50px;}
        .marginsL20{margin-left: 20px !important; }
        .marginRR20{margin-right:20px;}
        .w-222{width:222px;}
        .h-82{height:82px;}
        .Center{text-align:center !important;}
        .contentdata
        {
            background: #c0c0c0;
        }
        .marginT200
        {
            margin-top: 200px;
        }
        input[type="text"]
        {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .ui-autocomplete
        {
            width: auto !important;
            min-width: 150px;
            max-width: 300px;
            word-break: break-all;
            word-wrap: break-word;
        }
        .o-auto
        {
            overflow: auto;
        }
        .checkboxlist
        {
            overflow: auto;
            border: 2px;
            background: #fff;
            height: 150px;
            width: 220px;
        }
        .checkboxlist2
        {
            overflow: auto;
            border: 2px;
            background: #fff;
            height: 82px;
            width: 220px;
        }
        
        .bg-searchimage
        {
            background: url("../Images/magnifying-glass.png") #FFF no-repeat scroll right top;
        }
        #tblPrinterDetails tbody tr { 
            line-height: 0px;
        }
        
    </style>

    </head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <Attune:Attuneheader ID="Attune_OrgHeader1" runat="server" />
        <div class="contentdata">
        <div id="copyingProgress" style="display:none;">
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                                        </div>

        </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                                        
                            <table class="w-100p " id="tabManageMedicalHistory">
                                <tr class="lh30ss">
                                    <td class="w-12p">
                                        <asp:Label ID="lblSelectTest" runat="server" Text="Test/Group/Package" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:TextBox ID="txtTest" runat="server" CssClass="medium bg-searchimage" />
                                    </td>
                                    <td class="w-12p">
                                        <asp:Label ID="lblSelectTemplate" runat="server" Text="Select Template" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlTemplate" runat="server" class="medium">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-22p">
                                        <asp:CheckBox ID="chkIsMandatory" runat="server" Text="IsMandatory" />
                                    </td>
                                </tr>
                                
                                <tr class="lh30 hide">
                                    <td class="w-12p">
                                        <asp:Label ID="lblMedicalDetailType1" runat="server" Text="Medical DetailType" />                                     
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlMedicalDetailType" runat="server" class="medium">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-12p" colspan="2">
                                        <asp:CheckBox ID="chkIsInternal" runat="server" Text="IsInternal" />                                     
                                    </td>
                                    
                                </tr>
                                <tr class="lh35">
                                <td colspan="4">
                                    <button id="btnCancel" style="margin: 15px 0px 0px 15px;" runat="server" onclick="return Cancel();" class="btn">Cancel</button>
                                </td>
                                <td class="a-right">
                                    <button id="btnAddMedicalHistory" style="margin: 15px 15px 0px 0px;" class="btn" runat="server">
                                    Save</button>
                                </td>
                                </tr>
                                <tr class="lh30">
                                <td colspan="5">
                                    <div class="dynamicgrid a-auto">
                                        <table id="tblManageMedicalHistory" class="w-100p gridView display">
                                            <thead>
                                                <tr class="gridHeader">
                                                    <th>
                                                        <asp:Label ID="lblSNO" runat="server" Text="SNO" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblTestName" runat="server" Text="Test/Group/Package" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblTemplate" runat="server" Text="Template" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblIsMandatory" runat="server" Text="IsMandatory" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblMedicalDetailType" runat="server" Text="Medical DetailType" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblIsInternal" runat="server" Text="IsInternal" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblAction" runat="server" Text="Action" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblTestID" runat="server" Text="TestID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblTemplateID" runat="server" Text="TemplateID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblTestType" runat="server" Text="TestType" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblInvMedMappingID" runat="server" Text="InvMedMappingID" />
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </td>
                                </tr>
                            </table>
                            
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <Attune:Attunefooter ID="Attune_Footer1" runat="server" />
        <input type="hidden" id="hdnIsAdd" runat="server" value="Y" /> 
        <input type="hidden" id="hdnTestID" runat="server" value="0" />
        <input type="hidden" id="hdnInvType" runat="server" value="0" /> 
        <input type="hidden" id="hdnInvMedMappingID" runat="server" value="0" />                                                                                
    </div>
    </form>
</body>

<link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

<link href="../Scripts/test/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/test/jquery.dataTables.min.js" type="text/javascript"></script>

<link href="../Scripts/CustomAlerts/jquery.alerts.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/CustomAlerts/jquery.alerts.js" type="text/javascript"></script>

<script type="text/javascript">
    var Msg = 'N';
    var OrgId = '<%=OrgID%>';
    $('#tblManageMedicalHistory').dataTable({
        "bFilter": true,
        "bInfo": false,
        "bLengthChange": false,
        "iDisplayLength": 10,
        "bPaginate": true,
        "aaSorting": [],
        "aoColumns": [null, null, null, null, { "bVisible": false }, { "bVisible": false }, null, { "bVisible": false }, { "bVisible": false }, { "bVisible": false }, { "bVisible": false}]
    });
    $('#tblManageMedicalHistory_filter').addClass('hide');
    $('#tblManageMedicalHistory_paginate').addClass('hide');
    $("#tblManageMedicalHistory").hide();

    $(document).ready(function() {
        $('#ddlTemplate').append("<option value='0'>-------Select-------</option>");
        $('#ddlMedicalDetailType').append("<option value='0'>-------Select-------</option>");
    });

    //txtGroupName AutoComplete
    $("#txtTest").autocomplete({
        source: function(request, response) {
            var vdatas = {};
            vdatas.prefixText = $('#txtTest').val();
            vdatas.orgID = OrgId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManageMedicalHistory.aspx/GetTestName",
                data: JSON.stringify(vdatas),
                dataType: "json",
                success: function(data) {
                    var returnedData = JSON.parse(data.d);
                    response($.map(returnedData, function(item) {
                        return {
                            label: item.Name,
                            val: item.ID,
                            description: item.Type
                        }
                    }))
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });
        },
        select: function(e, i) {
            $('#hdnTestID').val(i.item.val);
            $('#hdnInvType').val(i.item.description);
            GetManageMedicalHistoryDetails();
        },
        minLength: 1
    }).data("ui-autocomplete")._renderItem = function(ul, item) {
        if (item.description == 'INV') {
            return $("<li>")
            .attr("value", item.value)
            .append("<a>" + item.label + "</a>")
            .appendTo(ul);
        }
        else if (item.description == 'GRP') {
            return $("<li>")
            .attr("value", item.value)
            .append("<a class='blue'>" + item.label + "</a>")
            .appendTo(ul);
        }
        else {
            return $("<li>")
            .attr("value", item.value)
            .append("<a class='magenta'>" + item.label + "</a>")
            .appendTo(ul);
        }
    };
    
    
    
    $('#btnAddMedicalHistory').click(function() {
        ValidateDetails();
        if (Msg != 'Y') {

            var InputParam = {};
            InputParam.TestID = $('#hdnTestID').val();
            InputParam.TemplateID = $('#ddlTemplate').val();
            InputParam.MedicalDetailType = $('#ddlMedicalDetailType').val() == 0 || $('#ddlMedicalDetailType').val() == null ? 'H' : $('#ddlMedicalDetailType').val();
            InputParam.IsInternal = $('#chkIsInternal').is(":checked") ? 'Y' : 'N';
            InputParam.IsMandatory = $('#chkIsMandatory').is(":checked") ? 'Y' : 'N';
            InputParam.InvType = $('#hdnInvType').val();
            InputParam.InvMedMappingID = $('#hdnInvMedMappingID').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManageMedicalHistory.aspx/SaveInvMedicalDetailsMapping",
                data: JSON.stringify(InputParam),
                dataType: "json",
                success: function(data) {
                    $('#txtTest').prop('disabled', false);

                    //$('#txtTest').val('');
                    $('#ddlTemplate').val(0);
                    $('#ddlMedicalDetailType').val(0);
                    $('#chkIsInternal').prop('checked', false);
                    $('#chkIsMandatory').prop('checked', false);
                    //$('#hdnTestID').val(0);
                    $('#hdnInvType').val(0);
                    $('#hdnInvMedMappingID').val(0);
                    
                    $('#btnAddMedicalHistory').text('Save');
                    if ($('#hdnIsAdd').val() != 'N') {
                        alert('MedicalHistory Added Successfully..');
                    }
                    else {
                        alert('MedicalHistory Updated Successfully..');
                    }
                    $('#hdnIsAdd').val('Y');
                    GetManageMedicalHistoryDetails();
                    return false;
                },
                error: function(result) {

                    jAlert("No Match", 'Alert Box');
                }
            });
            return false;
        }
        Msg = 'N';
        return false;
    });

    function GetManageMedicalHistoryDetails() {
        var oTable = $('#tblManageMedicalHistory').dataTable();
        oTable.fnClearTable();
        $('#tblManageMedicalHistory_paginate').addClass('hide');

        var InputParam = {};
        InputParam.InvType = $('#hdnInvType').val();
        InputParam.OrgID = OrgId;
        InputParam.TestID = $('#hdnTestID').val();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "ManageMedicalHistory.aspx/GetInvMedicalDetailsMapping",
            data: JSON.stringify(InputParam),
            dataType: "json",
            success: function(data) {
                if (data.d.length > 0) {
                    var SNO = 1;
                    var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 PRedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left PRremove" title="Click to Delete" />';
                    var returnedData = JSON.parse(data.d);
                    $.map(returnedData, function(item) {
                    $('#tblManageMedicalHistory').dataTable().fnAddData([
                            SNO,
                            item.TestName,
                            item.TemplateName,
                            item.IsMandatory,
                            item.MedicalDetailType,
                            item.IsInternal,
                            Action,
                            item.InvID,
                            item.MedicalDetailID,
                            item.InvType,
                            item.InvMedMappingID
                            ]);
                        SNO = SNO + 1;
                    })
                    $("#tblManageMedicalHistory").show();
                    $('#tblManageMedicalHistory_filter').removeClass('hide');
                    if (SNO > 10) {
                        $('#tblManageMedicalHistory_paginate').removeClass('hide');
                    }
                }
                else {
                    jAlert("No Matching Records Found", 'Alert Box');
                }
            },
            error: function(result) {
                jAlert("No match", 'Alert Box');
            }
        });
    }
    $(document).on('click', '.PRedit', function() {
        var row = $(this).closest('tr').index();
        var oTable = $('#tblManageMedicalHistory').dataTable();
        var aData = oTable.fnGetData();
        var Data = aData[row];

        $('#txtTest').val(Data[1]);
        $('#hdnTestID').val(Data[7]);
        $('#ddlTemplate').val(Data[8]);
        $('#ddlMedicalDetailType').val(Data[4]);
        if (Data[5] == 'Y') {
            $('#chkIsInternal').prop('checked', true);
        }
        else {
            $('#chkIsInternal').prop('checked', false);
        }
        if (Data[3] == 'Y') {
            $('#chkIsMandatory').prop('checked', true);
        }
        else {
            $('#chkIsMandatory').prop('checked', false);
        }
        $('#hdnInvType').val(Data[9]);
        $('#hdnInvMedMappingID').val(Data[10]);

        $('#hdnIsAdd').val('N');
        $('#btnAddMedicalHistory').text('Update');
        $('#txtTest').prop('disabled', 'disabled');
        
    });
    $(document).on('click', '.PRremove', function() {
        var row = $(this).closest('tr').index();
        var oTable = $('#tblManageMedicalHistory').dataTable();
        var aData = oTable.fnGetData();
        var Data = aData[row];
        
        var InputParam = {};
        InputParam.InvMedMappingID = Data[10];
        InputParam.TestID = Data[7];
        InputParam.TemplateID = Data[8];
        
        jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
            if (ReturnResponse == true) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ManageMedicalHistory.aspx/RemoveInvMedicalDetailsMapping",
                    data: JSON.stringify(InputParam),
                    dataType: "json",
                    success: function(data) {
                        GetManageMedicalHistoryDetails();
                        jAlert("MedicalHistory Removed Successfully..", 'Alert Box');
                    },
                    error: function(result) {
                        jAlert("Not Removed", 'Alert Box');
                    }
                });
            }
        });
    });
        
    function Cancel() {
        jConfirm('Are you sure to Cancel a Event?', 'Confirmation Dialog', function(ReturnResponse) {
        if (ReturnResponse == true) {
            Clear();
            }
        });
        return false;
    }
    function Clear() {
        $('#txtTest').val('');
        $('#ddlTemplate').val(0);
        $('#ddlMedicalDetailType').val(0);
        $('#chkIsInternal').prop('checked', false);
        $('#chkIsMandatory').prop('checked', false);
        $('#hdnTestID').val(0);
        $('#hdnInvType').val(0);
        $('#hdnInvMedMappingID').val(0);

        $('#tblManageMedicalHistory').dataTable().fnClearTable();
        $('#tblManageMedicalHistory_filter').addClass('hide');
        $('#tblManageMedicalHistory_paginate').addClass('hide');
        $("#tblManageMedicalHistory").hide();

    }
    function ValidateDetails() {
        if ($('#txtTest').val() == 0) {
            alert("Select Test Name");
            $('#txtTest').focus();
            Msg = 'Y'
        }
        if ($('#ddlTemplate').val() == 0) {
            alert("Select Template");
            $('#ddlTemplate').focus();
            Msg = 'Y'
        }

        if ($('#hdnIsAdd').val() != 'N') {
            var oTable = $('#tblManageMedicalHistory').dataTable();
            var aData = oTable.fnGetData();
            for (var i = 0; i < aData.length; i++) {
                var Data = aData[i];
                if ($('#hdnTestID').val() == Data[7] && $('#ddlTemplate').val() == Data[8] && $('#hdnInvType').val() == Data[9]) {
                    alert("This MedicalHistory is Already Exists...");
                    Msg = 'Y'
                    break;
                }
            }
        }
    }
</script>

</html>
