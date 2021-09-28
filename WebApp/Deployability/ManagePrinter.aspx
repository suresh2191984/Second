<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagePrinter.aspx.cs" Inherits="Deployability_ManagePrinter" %>

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
        .copylist
        {
            border: 2px;
            border-color: #fff;
            height: 390px;
            width: 420px;
        }
        #ddldptname
        {
            width: 222px;
        }
        .finalcopylist
        {
            overflow: auto;
            border: 2px;
            border-color: #fff;
            height: 83px;
            width: 225px;
        }
        .w-300
        {
            width: 300px;
        }
        .w-420
        {
            width: 420px;
        }
        .h-400
        {
            height: 360px !important;
        }
        .h-300
        {
            height: 300px;
        }
        .w-350
        {
            width: 350px;
        }
        .h-450
        {
            height: 450px !important;
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
                                        
                            <table class="w-100p " id="tabContentPrinter">
                                <tr class="lh25">
                                    <td class="w-12p">
                                        <asp:Label ID="lblSelectOrg" runat="server" Text="Select Organisation" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlSelectOrg" runat="server" class="medium">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-12p">
                                        <asp:Label ID="lblLocation" runat="server" Text="Select Location" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlLocation" runat="server" class="medium">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-12p">
                                        <asp:Label ID="lblPrinterName" runat="server" Text="Printer Name" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:TextBox ID="txtPrinterName" runat="server" CssClass="medium" />
                                    </td>
                                </tr>
                                <tr class="lh30">
                                    <td colspan="4"></td>
                                    <td>
                                    <asp:CheckBox ID="chkColorPrinter" runat="server" Text="Color Printer" />
                                    </td>
                                    <td>
                                    <asp:CheckBox ID="chkIsActive" runat="server" Text="Active" />
                                    </td>
                                </tr>
                                <tr class="lh35">
                                <td colspan="4">
                                    <button id="btnCancel" style="margin: 15px 0px 0px 15px;" runat="server" onclick="return Cancel();" class="btn">Cancel</button>
                                </td>
                                <td class="a-right" colspan="2">
                                    <button id="btnAddLocation" class="btn" runat="server">
                                    Save</button>
                                </td>
                                </tr>
                                <tr class="lh30">
                                <td colspan="6">
                                    <div class="dynamicgrid a-auto">
                                        <table id="tblPrinterDetails" class="w-100p gridView display">
                                            <thead>
                                                <tr class="gridHeader">
                                                    <th>
                                                        <asp:Label ID="lblSNO" runat="server" Text="SNO" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblOrgName" runat="server" Text="Organisation Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblLocationName" runat="server" Text="Location Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblPrinterNames" runat="server" Text="Printer Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblIsColorPrinter" runat="server" Text="Color Printer" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblIsActive" runat="server" Text="Active" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblPrinterID" runat="server" Text="Printer ID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblAction" runat="server" Text="Action" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblOrgID" runat="server" Text="OrgID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblOrgAddrID" runat="server" Text="Org AddrID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblAutoID" runat="server" Text="AutoPrinterID" />
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
        <input type="hidden" id="hdnAutoPrinterID" runat="server" value="0" /> 
        <input type="hidden" id="hdnIsAdd" runat="server" value="Y" />                                       
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
    $('#tblPrinterDetails').dataTable({
        "bFilter": true,
        "bInfo": false,
        "bLengthChange": false,
        "iDisplayLength": 10,
        "bPaginate": true,
        "aaSorting": [],
        "aoColumns": [null, null, null, null, null, null, null, null, { "bVisible": false }, { "bVisible": false }, { "bVisible": false}]
    });
    $('#tblPrinterDetails_filter').addClass('hide');
    $('#tblPrinterDetails_paginate').addClass('hide');
    $("#tblPrinterDetails").hide();

    $('#ddlSelectOrg').change(function(event) {
        GetPrinterDetails();
    });

    $('#btnAddLocation').click(function() {
        ValidateDetails();
        if (Msg != 'Y') {
            var IsColorPrinter;
            var IsActive;

            if ($('#chkColorPrinter').is(':checked')) IsColorPrinter = true;
            else IsColorPrinter = false;
            if ($('#chkIsActive').is(':checked')) IsActive = true;
            else IsActive = false;

            var InputParam = {};
            InputParam.OrgID = $('#ddlSelectOrg').val();
            InputParam.OrgAddressID = $('#ddlLocation').val();
            InputParam.PrinterName = $('#txtPrinterName').val();
            InputParam.IsColorPrinter = IsColorPrinter;
            InputParam.IsActive = IsActive;
            InputParam.AutoPrinterID = $('#hdnAutoPrinterID').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManagePrinter.aspx/AddNewPrinter",
                data: JSON.stringify(InputParam),
                dataType: "json",
                success: function(data) {
                    $('#ddlSelectOrg').val(InputParam.OrgID);
                    $('#ddlLocation').val(0);
                    $('#txtPrinterName').val('');
                    $('#hdnAutoPrinterID').val(0);
                    $('#chkColorPrinter').prop('checked', false);
                    $('#chkIsActive').prop('checked', false);
                    $('#btnAddLocation').text('Save');
                    if ($('#hdnIsAdd').val() != 'N') {
                        jAlert('Printer Added Successfully..');
                    }
                    else {
                        jAlert('Printer Updated Successfully..');
                    }
                    $('#hdnIsAdd').val('Y');
                    GetPrinterDetails();
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

    function GetPrinterDetails() {
        var oTable = $('#tblPrinterDetails').dataTable();
        oTable.fnClearTable();
        $('#tblPrinterDetails_paginate').addClass('hide');
        
        var OrgID = $('#ddlSelectOrg').val();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "ManagePrinter.aspx/GetPrinterLocation",
            data: "{'OrgID':'" + OrgID + "'}",
            dataType: "json",
            success: function(data) {
                if (data.d.length > 0) {
                    var SNO = 1;
                    var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 PRedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left PRremove" title="Click to Delete" />';
                    var returnedData = JSON.parse(data.d);
                    $.map(returnedData, function(item) {
                        $('#tblPrinterDetails').dataTable().fnAddData([
                            SNO,
                            item.Name,
                            item.Location,
                            item.PrinterName,
                            item.IsColorPrinter == true ? 'Yes' : 'No',
                            item.IsActive == true ? 'Yes' : 'No',
                            item.Code,
                            Action,
                            item.OrgID,
                            item.OrgAddressID,
                            item.AutoID
                            ]);
                        SNO = SNO + 1;
                    })
                    $("#tblPrinterDetails").show();
                    $('#tblPrinterDetails_filter').removeClass('hide');
                    if (SNO > 10) {
                        $('#tblPrinterDetails_paginate').removeClass('hide');
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
        var oTable = $('#tblPrinterDetails').dataTable();
        var aData = oTable.fnGetData();
        var Data = aData[row];
        $('#ddlSelectOrg').val(Data[8]);
        $('#ddlLocation').val(Data[9]);
        if (Data[4] == 'Yes') {
            $('#chkColorPrinter').prop('checked', true);
        }
        if (Data[5] == 'Yes') {
            $('#chkIsActive').prop('checked', true);
        }
        $('#txtPrinterName').val(Data[3]);
        $('#hdnAutoPrinterID').val(Data[10]);
        $('#hdnIsAdd').val('N'); 
        $('#btnAddLocation').text('Update');

    });
    $(document).on('click', '.PRremove', function() {
        var row = $(this).closest('tr').index();
        var oTable = $('#tblPrinterDetails').dataTable();
        var aData = oTable.fnGetData();
        var Data = aData[row];
        
        var InputParam = {};
        InputParam.OrgId = Data[8];
        InputParam.OrgAddressID = Data[9];
        InputParam.PrinterName = Data[3];
        
        jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
            if (ReturnResponse == true) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ManagePrinter.aspx/RemovePrinterLocation",
                    data: JSON.stringify(InputParam),
                    dataType: "json",
                    success: function(data) {
                        GetPrinterDetails();
                        jAlert("Printer Removed Successfully..", 'Alert Box');
                    },
                    error: function(result) {
                        jAlert("Not Removed", 'Alert Box');
                    }
                });
            }
        });
    });
    //new changes
        
    function Cancel() {
        jConfirm('Are you sure to Cancel a Event?', 'Confirmation Dialog', function(ReturnResponse) {
        if (ReturnResponse == true) {
            Clear();
            }
        });
        return false;
    }
    function Clear() {
        $('#txtPrinterName').val('');
        $('#ddlLocation').val(0);
        $('#ddlSelectOrg').val(0);
        $('#hdnAutoPrinterID').val(0);
        $('#chkColorPrinter').prop('checked', false);
        $('#chkIsActive').prop('checked', false);
        $('#tblPrinterDetails').dataTable().fnClearTable();
        $('#tblPrinterDetails_filter').addClass('hide');
        $('#tblPrinterDetails_paginate').addClass('hide');
        $("#tblPrinterDetails").hide();

    }
    function ValidateDetails() {
        if ($('#txtPrinterName').val() == "") {
            jAlert("This Printer Name is required");
            $('#txtPrinterName').focus();
            Msg = 'Y'
        }
        if ($('#ddlLocation').val() == 0) {
            jAlert("This Location is required");
            $('#ddlLocation').focus();
            Msg = 'Y'
        }
        if ($('#ddlSelectOrg').val() == 0) {
            jAlert("This Organisation is required");
            $('#ddlSelectOrg').focus();
            Msg = 'Y'
        }
        if ($('#hdnIsAdd').val() != 'N') {
            var oTable = $('#tblPrinterDetails').dataTable();
            var aData = oTable.fnGetData();
            for (var i = 0; i < aData.length; i++) {
                var Data = aData[i];
                if ($('#ddlSelectOrg').val() == Data[8] && $('#ddlLocation').val() == Data[9] && $('#txtPrinterName').val() == Data[3]) {
                    jAlert("This Printer is Already Exists...");
                    Msg = 'Y'
                    break;
                }
            }
        }
    }
</script>

</html>
