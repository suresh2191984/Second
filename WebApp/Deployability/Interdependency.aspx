<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Interdependency.aspx.cs" EnableEventValidation="false" Inherits="Deployability_Interdependency" %>

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
                                        
                            <table class="w-100p " id="tabInterdependency">
                                <tr class="lh25">
                                    <td class="w-12p">
                                        <asp:Label ID="lblSelectGroup" runat="server" Text="Select Group" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:TextBox ID="txtGroupName" runat="server" CssClass="medium bg-searchimage" />
                                    </td>
                                </tr>
                                <tr class="lh30">    
                                    <td class="w-12p">
                                        <asp:Label ID="lblPrimaryInv" runat="server" Text="Select Primary Investigation" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlPrimaryInv" runat="server" class="medium">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="lh30">    
                                    <td class="w-12p">
                                        <asp:Label ID="lblDependentInv" runat="server" Text="Select Dependent Investigation" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlDependentInv" runat="server" class="medium">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="lh30">
                                    <td class="w-12p">
                                        <asp:Label ID="lblDependentTypes" runat="server" Text="Dependent Type" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlDependentType" runat="server" class="medium">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="lh35">
                                <td>
                                    <button id="btnCancel" style="margin: 15px 0px 0px 15px;" runat="server" onclick="return Cancel();" class="btn">Cancel</button>
                                </td>
                                <td class="a-right" colspan="2">
                                    <button id="btnAddDependency" class="btn" runat="server">
                                    Save</button>
                                </td>
                                </tr>
                                <tr class="lh30">
                                <td colspan="2">
                                    <div class="dynamicgrid a-auto">
                                        <table id="tblInterdependencyDetails" class="w-100p gridView display">
                                            <thead>
                                                <tr class="gridHeader">
                                                    <th>
                                                        <asp:Label ID="lblSNO" runat="server" Text="SNO" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblGroupName" runat="server" Text="Group Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblPrimaryInvName" runat="server" Text="PrimaryTest Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblDependentInvName" runat="server" Text="DependentTest Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblDependentType" runat="server" Text="Dependent Type" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblAction" runat="server" Text="Action" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblGroupID" runat="server" Text="GroupID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblPrimaryInvID" runat="server" Text="PrimaryInvID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblDependentInvID" runat="server" Text="DependentInvID" />
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
        <input type="hidden" id="hdnGroupID" runat="server" value="0" />
        <input type="hidden" id="hdnPrimaryInvID" runat="server" value="0" />                                      
        <input type="hidden" id="hdnDependentInvID" runat="server" value="0" />                                      
        <input type="hidden" id="hdnDependentType" runat="server" value="" /> 
        <input type="hidden" id="hdnOldPrimaryInvID" runat="server" value="0" />                                      
        <input type="hidden" id="hdnOldDependentInvID" runat="server" value="0" />                                       
                                              
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
    $('#tblInterdependencyDetails').dataTable({
        "bFilter": true,
        "bInfo": false,
        "bLengthChange": false,
        "iDisplayLength": 10,
        "bPaginate": true,
        "aaSorting": [],
        "aoColumns": [null, null, null, null, null, null, { "bVisible": false }, { "bVisible": false }, { "bVisible": false}]
    });
    $('#tblInterdependencyDetails_filter').addClass('hide');
    $('#tblInterdependencyDetails_paginate').addClass('hide');
    $("#tblInterdependencyDetails").hide();

    $(document).ready(function() {
        $('#ddlPrimaryInv').append("<option value='0'>-------Select-------</option>");
        $('#ddlDependentInv').append("<option value='0'>-------Select-------</option>");
    });

    //txtGroupName AutoComplete
    $("#txtGroupName").autocomplete({
        source: function(request, response) {
            var vdatas = {};
            vdatas.prefixText = $('#txtGroupName').val();
            vdatas.orgID = OrgId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Interdependency.aspx/GetGroupName",
                data: JSON.stringify(vdatas),
                dataType: "json",
                success: function(data) {
                    var returnedData = JSON.parse(data.d);
                    response($.map(returnedData, function(item) {
                        return {
                            label: item.GroupName,
                            val: item.GroupID
                        }
                    }))
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });
        },
        select: function(e, i) {
            $('#hdnGroupID').val(i.item.val);
            LoadInvestigationByGroup();
            GetInterDependencyDetails();
        },
        minLength: 1
    });
    
    function LoadInvestigationByGroup() {
        var InputParam = {};
        InputParam.GroupID = $('#hdnGroupID').val();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Interdependency.aspx/LoadInvestigationByGroup",
            data: JSON.stringify(InputParam),
            dataType: "json",
            success: function(data) {
                var jsdata = JSON.parse(data.d);
                $('#ddlPrimaryInv').empty();
                $('#ddlPrimaryInv').append("<option value='0'>-------Select-------</option>");
                $.each(jsdata, function(key, value) {
                    $('#ddlPrimaryInv').append($("<option></option>").val(value["InvestigationID"]).html(value["InvestigationName"]));
                });

                $('#ddlDependentInv').empty();
                $('#ddlDependentInv').append("<option value='0'>-------Select-------</option>");
                $.each(jsdata, function(key, value) {
                    $('#ddlDependentInv').append($("<option></option>").val(value["InvestigationID"]).html(value["InvestigationName"]));
                });
                if ($('#btnAddDependency').text() == 'Update') {
                    $('#ddlPrimaryInv').val($('#hdnPrimaryInvID').val());
                    $('#ddlDependentInv').val($('#hdnDependentInvID').val());
                    $('#ddlDependentType').val($('#hdnDependentType').val());
                }
            },
            error: function(result) {
                jAlert("No Match", 'Alert Box');
            }
        });
    }

    $('#btnAddDependency').click(function() {
        ValidateDetails();
        if (Msg != 'Y') {

            var InputParam = {};
            InputParam.OrgID = OrgId;
            InputParam.GroupID = $('#hdnGroupID').val();
            InputParam.PrimaryInvID = $('#ddlPrimaryInv').val();
            InputParam.DependentInvID = $('#ddlDependentInv').val();
            InputParam.DependentType = $('#ddlDependentType').val();
            InputParam.OldPrimaryInvID = $('#hdnOldPrimaryInvID').val();
            InputParam.OldDependentInvID = $('#hdnOldDependentInvID').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Interdependency.aspx/AddInterdependency",
                data: JSON.stringify(InputParam),
                dataType: "json",
                success: function(data) {
                    $('#txtGroupName').prop('disabled', false);
                    $('#ddlDependentType').prop('disabled', false);
                    $('#hdnOldPrimaryInvID').val(0);
                    $('#hdnOldDependentInvID').val(0);
                    $('#ddlPrimaryInv').val(0);
                    $('#ddlDependentInv').val(0);
                    $('#btnAddDependency').text('Save');
                    if ($('#hdnIsAdd').val() != 'N') {
                        jAlert('Interdependency Added Successfully..');
                    }
                    else {
                        jAlert('Interdependency Updated Successfully..');
                    }
                    $('#hdnIsAdd').val('Y');
                    GetInterDependencyDetails();
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

    function GetInterDependencyDetails() {
        var oTable = $('#tblInterdependencyDetails').dataTable();
        oTable.fnClearTable();
        $('#tblInterdependencyDetails_paginate').addClass('hide');

        var InputParam = {};
        InputParam.OrgID = OrgId;
        InputParam.GroupID = $('#hdnGroupID').val();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Interdependency.aspx/GetInterdependencyDetails",
            data: JSON.stringify(InputParam),
            dataType: "json",
            success: function(data) {
                if (data.d.length > 0) {
                    var SNO = 1;
                    var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 PRedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left PRremove" title="Click to Delete" />';
                    var returnedData = JSON.parse(data.d);
                    $.map(returnedData, function(item) {
                    $('#tblInterdependencyDetails').dataTable().fnAddData([
                            SNO,
                            item.GroupName,
                            item.PrimaryInvName,
                            item.DependentInvName,
                            item.DependentType,
                            Action,
                            item.GroupID,
                            item.InvestigationID,
                            item.DependentInvestigationID
                            ]);
                        SNO = SNO + 1;
                    })
                    $("#tblInterdependencyDetails").show();
                    $('#tblInterdependencyDetails_filter').removeClass('hide');
                    if (SNO > 10) {
                        $('#tblInterdependencyDetails_paginate').removeClass('hide');
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
        var oTable = $('#tblInterdependencyDetails').dataTable();
        var aData = oTable.fnGetData();
        var Data = aData[row];
        
        $('#hdnPrimaryInvID').val(Data[7]);
        $('#hdnDependentInvID').val(Data[8]);
        $('#hdnOldPrimaryInvID').val(Data[7]);
        $('#hdnOldDependentInvID').val(Data[8]);
        $('#hdnDependentType').val(Data[4]);
                
        $('#hdnGroupID').val(Data[6]);
        LoadInvestigationByGroup();
        $('#hdnIsAdd').val('N');
        $('#btnAddDependency').text('Update');
        $('#txtGroupName').prop('disabled', 'disabled');
        $('#ddlDependentType').prop('disabled', 'disabled');

    });
    $(document).on('click', '.PRremove', function() {
        var row = $(this).closest('tr').index();
        var oTable = $('#tblInterdependencyDetails').dataTable();
        var aData = oTable.fnGetData();
        var Data = aData[row];
        
        var InputParam = {};
        InputParam.OrgId = OrgId;
        InputParam.GroupID = Data[6];
        InputParam.PrimaryInvID = Data[7];
        InputParam.DependentInvID = Data[8];
        InputParam.DependentType = Data[4];
        
        jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
            if (ReturnResponse == true) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Interdependency.aspx/RemoveInterdependencyDetails",
                    data: JSON.stringify(InputParam),
                    dataType: "json",
                    success: function(data) {
                        GetInterDependencyDetails();
                        jAlert("Interdependency Removed Successfully..", 'Alert Box');
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
        $('#txtGroupName').val('');
        $('#ddlPrimaryInv').val(0);
        $('#ddlDependentInv').val(0);
        $('#ddlDependentType').val(0);

        $('#hdnGroupID').val(0);
        $('#hdnPrimaryInvID').val(0);
        $('#hdnDependentInvID').val(0);
        $('#hdnOldPrimaryInvID').val(0);
        $('#hdnOldDependentInvID').val(0);
        $('#hdnDependentType').val('');

        $('#tblInterdependencyDetails').dataTable().fnClearTable();
        $('#tblInterdependencyDetails_filter').addClass('hide');
        $('#tblInterdependencyDetails_paginate').addClass('hide');
        $("#tblInterdependencyDetails").hide();

    }
    function ValidateDetails() {
        if ($('#ddlPrimaryInv').val() == 0) {
            jAlert("Select primary Investigation.");
            $('#ddlPrimaryInv').focus();
            Msg = 'Y'
        }
        if ($('#ddlDependentInv').val() == 0) {
            jAlert("Select Dependent Investigation.");
            $('#ddlDependentInv').focus();
            Msg = 'Y'
        }
        if ($('#ddlDependentType').val() == 0) {
            jAlert("Select Dependent Type.");
            $('#ddlDependentType').focus();
            Msg = 'Y'
        }
        var oTable = $('#tblInterdependencyDetails').dataTable();
        var aData = oTable.fnGetData();
        for (var i = 0; i < aData.length; i++) {
            var Data = aData[i];
            if ($('#ddlPrimaryInv').val() == Data[7] && $('#ddlDependentInv').val() == Data[8] && $('#ddlDependentType').val() == Data[4]) {
                jAlert("This Interdependency is Already Exists...");
                Msg = 'Y'
                break;
            }
        }
    }
</script>

</html>
