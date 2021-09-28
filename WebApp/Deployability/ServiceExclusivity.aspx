<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ServiceExclusivity.aspx.cs" Inherits="Deployability_ServiceExclusivity" %>

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
                    <%--<div id="TabsMenu" class="TabsMenu ">
                        <ul id="ulTabsMenu">
                            <li id="tabCSM" class="active"><a href="#">
                                <asp:Label ID="lblClientServiceExclusivity" Font-Size="10px" runat="server" Text="Client Service Exclusivity" /></a></li>
                            <%--<li id="tabConfig"><a href="#">
                                <asp:Label ID="lbltabConfig" runat="server" Text="Configuration" /></a></li>
                        </ul>
                    </div>
                    <br />--%>
                    <asp:UpdatePanel ID="updatePanel2" runat="server">
                        <ContentTemplate>
                            <table class="w-100p " id="tabContentCSM">
                                <tr class="lh25">
                                    <td class="w-12p">
                                        <%--<asp:Label ID="lblClientType" runat="server" Text="Client Type" />--%>
                                        <asp:Label ID="lblBusinessType" runat="server" Text="Business Type" />                                        
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlClientType" runat="server" class="medium">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" id="img5">
                                    </td>
                                    <td>
                                        <asp:Label ID="lblClientName" runat="server" Text="Client Name" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtClientName" runat="server" Placeholder="Enter Client name or code" 
                                        Width="227px" CssClass="medium bg-searchimage paddingR10" ToolTip="Enter Client name or code"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-12p">
                                        <asp:Label ID="lblServiceType" runat="server" Text="Service Type" />
                                    </td>
                                    <td class="w-22p">
                                        <asp:DropDownList ID="ddlServiceType" runat="server" class="medium">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" id="img2">
                                    </td>
                                    <td>
                                        <asp:Label ID="lblServiceName" runat="server" Text="Service Name" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtServiceName" runat="server" Placeholder="Enter Service name or code"
                                        Width="227px" CssClass="medium bg-searchimage paddingR10" ToolTip="Enter Service name or code"></asp:TextBox>
                                        <img id="btnAddCSM" alt="ADD Button" class="v-middle" src="../Images/Add.png"
                                        title="Add this Client Service Mapping" />
                                    </td>
                                </tr>
                                <tr>
                                <td colspan="4">
                                    <div class="dynamicgrid a-auto">
                                        <table id="tblCSMDetails" class="w-100p gridView display">
                                            <thead>
                                                <tr class="gridHeader">
                                                    <th>
                                                        <asp:Label ID="lblCltName" runat="server" Text="Business Type" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblCltCode" runat="server" Text="Client Name (Code)" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblSerType" runat="server" Text="Service Type" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblSerCode" runat="server" Text="Service (Code)" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblIsExclusive" runat="server" Text="IsExclusive" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblAction" runat="server" Text="Action" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblCltID" runat="server" Text="ClientID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblSerID" runat="server" Text="ServiceID" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblExclusiveFlag" runat="server" Text="ExclusiveFlag" />
                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </td>
                                </tr>
                                <tr class="lh35">
                                <td colspan="2">
                                    <button id="btnCancel" style="margin: 15px 0px 0px 15px;" runat="server" onclick="return Cancel();" class="btn hide">Clear</button>
                                </td>
                                <td class="a-right" colspan="2">
                                    <asp:Button ID="btnFinalSave" style="margin-right:15px;" runat="server" class="btn hide" Text="Save" />
                                </td>
                                </tr>
                            </table>
                            <%--<table class="w-100p hide paddingL1" id="tabContentConfig">
                                <tr>
                                    <td class="a-left v-top">
                                        <asp:Label runat="server" ID="Label2" Text="Masters"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                
                            </table>--%>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <Attune:Attunefooter ID="Attune_Footer1" runat="server" />
        
        <input type="hidden" id="hdnClientID" runat="server" value="0" />
        <input type="hidden" id="hdnServiceID" runat="server" value="0" />
        <input type="hidden" id="hdnClientDetails" runat="server" value="0" />
        <input type="hidden" id="hdnIsExists" runat="server" value="N" />
        
    </div>
    </form>
</body>

<link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
<%--<script type="text/javascript">
    $(function() {
        $('[id^="tabContent"]').hide();
        $('#tabCSM').addClass('active');
        $('#tabContentCSM').show();
    });
    function ShowTabContent(tabId, DivId) {
        $('#TabsMenu li').removeClass('active');
        $('#' + tabId).addClass('active');
        $('[id^="tabContent"]').hide();
        $('#' + DivId).show();
        return false;
    }
</script>--%>
<link href="../Scripts/test/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/test/jquery.dataTables.min.js" type="text/javascript"></script>

<link href="../Scripts/CustomAlerts/jquery.alerts.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/CustomAlerts/jquery.alerts.js" type="text/javascript"></script>

<script type="text/javascript">

    var OrgId = '<%=OrgID%>';
    var LId = '<%=LID%>';
    var btnUpdateCSMDetails = false;
    var UpdateCSMDetailsID = '';

    $('#txtServiceName').attr('disabled', true);
    $('#ddlClientType').change(function() {
            $('#txtClientName').val('');
            $('#txtServiceName').val('');
            $('#tblCSMDetails').dataTable().fnClearTable();
            $('#tblCSMDetails_filter').addClass('hide');
            $('#tblCSMDetails_paginate').addClass('hide');            
            $("#tblCSMDetails").hide();
    });

    $('#ddlServiceType').change(function() {
        if ($('#ddlServiceType :selected').val() != 0) {
            $('#txtServiceName').val('');
            $('#txtServiceName').attr('disabled', false);
        }
        else {
            $('#txtServiceName').val('');
            $('#txtServiceName').attr('disabled', true);
        }
    });

        
    $('#tblCSMDetails').dataTable({
        "bFilter": true,
        "bInfo": false,
        "bLengthChange": false,
        "iDisplayLength": 10,
        "bPaginate": true,
        "aaSorting": [],
        "aoColumns": [{ "bVisible": false }, null, null, null, null, null, { "bVisible": false }, { "bVisible": false }, { "bVisible": false}]
    });
    $('#tblCSMDetails_filter').addClass('hide');
    $('#tblCSMDetails_paginate').addClass('hide');    
    $("#tblCSMDetails").hide();

    $("#txtClientName").focus(function() {
    if (!($('#tblCSMDetails tbody tr td').hasClass("dataTables_empty"))) {
        jConfirm('Are you sure to Change a Client?', 'Confirmation Dialog', function(ReturnResponse) {
            if (ReturnResponse == true) {
                $("#txtClientName").val('');
                $('#tblCSMDetails').dataTable().fnClearTable();
                $('#tblCSMDetails_filter').addClass('hide');
                $('#tblCSMDetails_paginate').addClass('hide');
                $("#tblCSMDetails").hide();
                $("#txtClientName").focus();
            }
        });
    } 
    });

    //txtClientName AutoComplete
    $("#txtClientName").autocomplete({
        source: function(request, response) {
            var vdatas = {};
            vdatas.prefixText = $('#txtClientName').val();
            vdatas.contextKey = $('#ddlClientType :selected').val();
            vdatas.orgID = OrgId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ServiceExclusivity.aspx/GetClientNamebyClientType",
                data: JSON.stringify(vdatas),
                dataType: "json",
                success: function(data) {
                    var returnedData = JSON.parse(data.d);
                    response($.map(returnedData, function(item) {
                        return {
                            label: item.ClientName,
                            val: item.ClientID
                        }
                    }))
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });
        },
        select: function(e, i) {
            $('#hdnClientID').val(i.item.val);
            LoadPrevClientServices();
            $('#ddlServiceType').focus();
        },
        minLength: 1
    });


    //txtServiceName AutoComplete
    $("#txtServiceName").autocomplete({
        source: function(request, response) {
            var vdatas = {};
            vdatas.prefixText = $('#txtServiceName').val();
            vdatas.contextKey = $('#ddlServiceType :selected').val()+'~'+$('#hdnClientID').val();
            vdatas.orgID = OrgId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ServiceExclusivity.aspx/GetOrgInvestigationsGroupandPKG",
                data: JSON.stringify(vdatas),
                dataType: "json",
                success: function(data) {
                    var returnedData = JSON.parse(data.d);
                    response($.map(returnedData, function(item) {
                        return {
                            label: item.Descrip,
                            val: item.ID,
                            description: item.IsHistoryMandatory
                        }
                    }))
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });
        },
        select: function(e, i) {
            $('#hdnServiceID').val(i.item.val);
            $('#hdnIsExists').val(i.item.description);
        },
        minLength: 1
    });

    function LoadPrevClientServices() {
        $('#txtServiceName').val('');
        $('#ddlServiceType').val(0);

        $('#tblCSMDetails').dataTable().fnClearTable();
        $('#tblCSMDetails_paginate').addClass('hide');            
                
        var vdatas = {};
        vdatas.CidAndRefID = $('#hdnClientID').val();
        vdatas.OrgID = OrgId;
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "ServiceExclusivity.aspx/GetClientMappingServiceExclusivity",
            data: JSON.stringify(vdatas),
            dataType: "json",
            success: function(data) {
                if (data.d.length > 0) {
                    $('#hdnClientDetails').val(data.d);
                    LoadCSMDetails();
                }
            },
            error: function(result) {
                jAlert("No Match", 'Alert Box');
            }
        });
    }


    function LoadCSMDetails() {
        $("#btnCancel").show();
        $("#btnFinalSave").show();
    
        $("#tblCSMDetails").show();
        $('#tblCSMDetails_filter').removeClass('hide');
        

        
        //var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 CDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left CDremove" title="Click to Delete" />';
        var Action = '<a class="ui-icon ui-icon-trash marginsL20 pull-left CDremove" title="Click to Delete" />';
        var Values;
        var Data = $('#hdnClientDetails').val();
        var sData = Data.split('^');
        if (sData.length > 10) {
            $('#tblCSMDetails_paginate').removeClass('hide');        
        }
        for (var i = 0; i < sData.length - 1; i++) {
            var ID = 'IsExclusive_' + i;
            var Value = sData[i].split('~');
            if (Value[8] == 1) {
                var ChkBox = '<input type="checkbox" id="' + ID + '" name="' + ID + '" class="chkCheck" checked/>';
            }
            else {
                var ChkBox = '<input type="checkbox" id="' + ID + '" name="' + ID + '" class="chkCheck"/>';
            }   
            //var CltNameAndCode = Value[1] + ' : ' + Value[2];
            var CltNameAndCode = Value[2] + ' (' + Value[1] + ')';
            Value[8] = Value[8] == 1 ? true : false;
            Values = [Value[6], CltNameAndCode, Value[7], Value[5], ChkBox, Action, Value[0], Value[4], Value[8]];
            $('#tblCSMDetails').dataTable().fnAddData(Values);
            $('#tblCSMDetails tbody tr:eq(' + i + ') td:eq(3)').addClass('Center');
            
        }
        var oTable = $('#tblCSMDetails').dataTable();
        oTable.fnAdjustColumnSizing();
    }

    $('#btnAddCSM').click(function() {
        if ($('#hdnIsExists').val() != 'Y') {
            if (ValidateDetails() == true) {
                AddCSMDetailsRow();
            }
        }
        else {
            alert("Duplicate Details...");
            $('#ddlServiceType').val(0);
            $('#txtServiceName').val('');
            $('#hdnServiceID').val(0);
            $('#hdnIsExists').val('N')
        }
    });
    function AddCSMDetailsRow() {
        $("#btnCancel").show();
        $("#btnFinalSave").show();
        
        $("#tblCSMDetails").show();
        $('#tblCSMDetails_filter').removeClass('hide');
        if ($('#tblCSMDetails tbody tr').length > 9) {
            $('#tblCSMDetails_paginate').removeClass('hide');
        }       

        var len = $('#tblCSMDetails tbody tr').length;        
        if ($('#tblCSMDetails tbody tr td').hasClass("dataTables_empty")) {
            len = 0;
        }
        var chkID = 'IsExclusive_' + len;
        var ChkBox = '<input type="checkbox" id="' + chkID + '" name="' + chkID + '" class="chkCheck"/>';
        //var Action = '<a class="ui-icon ui-icon-pencil marginL5 pull-left marginR10 CDedit" title="Click to Edit" /><a class="ui-icon ui-icon-trash marginL5 pull-left CDremove" title="Click to Delete" />';
        var Action = '<a class="ui-icon ui-icon-trash marginsL20 pull-left CDremove" title="Click to Delete" />';
        if (btnUpdateCSMDetails == true) {
            $('#tblCSMDetails').dataTable().fnUpdate([
                $('#ddlClientType :selected').text(),
                $('#txtClientName').val(),
                $('#ddlServiceType :selected').val(),
                $('#txtServiceName').val(),
                ChkBox,
                Action,
                $('#hdnClientID').val(),
                $('#hdnServiceID').val(),
                false
                ], UpdateCSMDetailsID);
            btnUpdateCSMDetails = false;
            UpdateCSMDetailsID = '';
        }
        else {
                var Msg = 'N';
                var oTable = $('#tblCSMDetails').dataTable();
                var aData = oTable.fnGetData();
                for (var i = 0; i < aData.length; i++) {
                    var Data = aData[i];
                    if ($('#ddlClientType :selected').text() == Data[0] && $('#hdnClientID').val() == Data[6] && $('#ddlServiceType :selected').val() == Data[2] && $('#hdnServiceID').val() == Data[7]) {
                        Msg = 'Y'
                        break;
                    }
                }
                if (Msg != 'Y') {
                    var InvCodeAndName = $('#txtServiceName').val();
                    var INV = '';
                    if (InvCodeAndName.indexOf(":") >= 0) {
                        if (InvCodeAndName.split(':')[0] != " ") {
                            INV = InvCodeAndName.split(':')[1] + ' (' + InvCodeAndName.split(':')[0] + ')';
                        }
                        else {
                            INV = InvCodeAndName.split(':')[1];
                        }
                    }
                    else {
                        INV = InvCodeAndName;
                    }
                    $('#tblCSMDetails').dataTable().fnAddData([
                $('#ddlClientType :selected').text(),
                $('#txtClientName').val(),
                $('#ddlServiceType :selected').val(),
                INV,
                ChkBox,
                Action,
                $('#hdnClientID').val(),
                $('#hdnServiceID').val(),
                false
                ]);
                }
                else {
                    jAlert("Duplicate..", 'Alert Box');
                }
                oTable.fnAdjustColumnSizing();                
            }

            $('#tblCSMDetails tbody tr:eq(' + len + ') td:eq(3)').addClass('Center');
                                                                    
        $('#ddlServiceType').val(0);
        $('#txtServiceName').val('');
        $('#hdnServiceID').val(0);
    }
    $(document).on('click', '.CDedit', function() {
        var row = $(this).closest('tr').index();
        btnUpdateCSMDetails = true;
        UpdateCSMDetailsID = row;
        var oTable = $('#tblCSMDetails').dataTable();
        var aData = oTable.fnGetData();
        var Data = aData[row];
        $("#ddlClientType option:contains(" + Data[0] + ")").attr('selected', 'selected');
        $('#txtClientName').val(Data[1]);
        //$("#ddlServiceType option:contains(" + Data[2] + ")").attr('selected', 'selected');
        $('#ddlServiceType').val(Data[2]);
        $('#txtServiceName').val(Data[3]);
        $('#hdnClientID').val(Data[6]);
        $('#hdnServiceID').val(Data[7]);

    });
    $(document).on('click', '.CDremove', function() {
        var row = $(this).closest('tr');
        var nRow = row[0];
        jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
        if (ReturnResponse == true) $('#tblCSMDetails').dataTable().fnDeleteRow(nRow);
        });
    });

    $(document).on('click', '.chkCheck', function() {
        var rowID = $(this).closest('tr').index();
        var chkID = $(this).attr('id');
        var Flag = $('#' + chkID).is(":checked") ? true : false;
        
        var oTable = $('#tblCSMDetails').dataTable();
        oTable.fnUpdate(Flag, rowID, 8);
    });

    var jsonStringCSMDetails = [];
    $('#btnFinalSave').click(function() {
        jsonStringCSMDetails.length = 0;
        GenerateUTD();
        var parameters = {
            lstCSMDetails: jsonStringCSMDetails,
            OrgID: OrgId,
            LID: LId,
            ClientID: $('#hdnClientID').val()
        };
        $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ServiceExclusivity.aspx/btnFinalSaveContents",
                    data: JSON.stringify(parameters),
                    dataType: "json",
                    success: function(data) {
                        if (data.d != 1001) {
                            jAlert("Client Service Exclusivity Saved Successfully", 'Alert Box');
                            Clear();
                        }
                        else {
                            jAlert("Details was not saved.\n Some thing went Wrong.", 'Alert Box');
                        }
                    },
                    error: function(result) {
                        jAlert("Error", 'Alert Box');
                    }
            });
            return false;
    });
    function GenerateUTD() {
        var datatable = $('#tblCSMDetails').DataTable();
        datatable.rows().every(function(rowIdx, tableLoop, rowLoop) {
            data = this.data();
            var tmpCSMDetails = new Object();
            if (data[8] == true) {
                tmpCSMDetails['ClientId'] = data[6];
                tmpCSMDetails['FeeID'] = data[7];
                tmpCSMDetails['FeeType'] = data[2];
                tmpCSMDetails['ReferenceType'] = 'BIL';
                tmpCSMDetails['SCode'] = '';
                tmpCSMDetails['IsExclusive'] = data[8];
                jsonStringCSMDetails.push(tmpCSMDetails);
            }
        });
    }
    
    function Cancel() {
        jConfirm('Are you sure to Cancel a Event?', 'Confirmation Dialog', function(ReturnResponse) {
        if (ReturnResponse == true) {
            Clear();
            }
        });
        return false;
    }
    function Clear() {
        $('#ddlClientType').val(0);
        $('#txtClientName').val('');
        $('#ddlServiceType').val(0);
        $('#txtServiceName').val('');
        $('#hdnClientID').val(0);
        $('#hdnServiceID').val(0);
        $('#tblCSMDetails').dataTable().fnClearTable();
        $('#tblCSMDetails_filter').addClass('hide');
        $('#tblCSMDetails_paginate').addClass('hide');        
        $("#tblCSMDetails").hide();

        $("#btnCancel").hide();
        $("#btnFinalSave").hide();
    }
    function ValidateDetails() {
//        if ($('#ddlClientType').val() == 0) {
//            jAlert("This ClientType is required", 'Alert Box');
//            $('#txtAttributes').focus();
//            return false;
//        }
        if ($('#txtClientName').val() == "") {
            jAlert("This ClientName is required", 'Alert Box');
            $('#txtAttributes').focus();
            return false;
        }
        if ($('#ddlServiceType').val() == 0) {
            jAlert("This ServiceType is required", 'Alert Box');
            $('#txtAttributes').focus();
            return false;
        }
        if ($('#txtServiceName').val() == "") {
            jAlert("This ServiceName is required", 'Alert Box');
            $('#txtAttributes').focus();
            return false;
        }
        return true;
    }
</script>

</html>
