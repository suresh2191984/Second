<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientServiceMapping.aspx.cs" Inherits="Deployability_ClientServiceMapping" %>

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
                   
                    <br />
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
                                                        <asp:Label ID="lblsno" runat="server" Text="S.NO" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblclientnames" runat="server" Text="Client Name" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblCltCode" runat="server" Text="Client Code" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblSerType" runat="server" Text="Service Type" />
                                                    </th>
                                                    <th>
                                                        <asp:Label ID="lblSerCode" runat="server" Text="Service (Code)" />
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
                                                        <asp:Label ID="lblscodes" runat="server" Text="SCode" />
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
        
    </div>
    </form>
</body>

<link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
<script type="text/javascript">
    $(function() {
        $('[id^="tabContent"]').hide();
        $('#tabCSM').addClass('active');
        $('#tabContentCSM').show();
    });
   
</script>
<link href="../Scripts/test/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/test/jquery.dataTables.min.js" type="text/javascript"></script>

<link href="../Scripts/CustomAlerts/jquery.alerts.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/CustomAlerts/jquery.alerts.js" type="text/javascript"></script>

<script type="text/javascript">

    var OrgId = '<%=OrgID%>';
    var LId = '<%=LID%>';
    
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
        "aoColumns": [null, null, null, null, null, null, {
            "bVisible": false
        }, {
            "bVisible": false
        }, {
            "bVisible": false
}]
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
                url: "ClientServiceMapping.aspx/GetClientNamebyClientType",
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
            vdatas.contextKey = $('#ddlServiceType :selected').val() + '~' + $('#hdnClientID').val();
            vdatas.orgID = OrgId;
            vdatas.LocationID = LId;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ClientServiceMapping.aspx/GetOrgInvestigationsGroupandPKGs",
                data: JSON.stringify(vdatas),
                dataType: "json",
                success: function(data) {
                    var returnedData = JSON.parse(data.d);
                    response($.map(returnedData, function(item) {
                        return {
                            label: item.Descrip,
                            val: item.ID
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
            url: "ClientServiceMapping.aspx/GetClientMappingService",
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
        
        var Action = '<a class="ui-icon ui-icon-trash marginsL20 pull-left CDremove" title="Click to Delete" />';
        var Values;
        var Data = $('#hdnClientDetails').val();
        var sData = Data.split('^');
        if (sData.length > 10) {
            $('#tblCSMDetails_paginate').removeClass('hide');        
        }
        for (var i = 0; i < sData.length - 1; i++) {
            var Value = sData[i].split('~');
            if (sData[i].split('~').length == 9) {
                Value[9] = '';
            }
            var CltNameAndCode = Value[2] + ' (' + Value[3] + ')';
            Values = [i+1,Value[2], Value[3], Value[6], Value[5], Action, Value[1], Value[4], Value[9]];
            $('#tblCSMDetails').dataTable().fnAddData(Values);
            
        }
    }

    $('#btnAddCSM').click(function() {
        if (ValidateDetails() == true) {
            AddCSMDetailsRow();
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
        var Action = '<a class="ui-icon ui-icon-trash marginsL20 pull-left CDremove" title="Click to Delete" />';
                var Msg = 'N';
                var oTable = $('#tblCSMDetails').dataTable();
                var aData = oTable.fnGetData();
                for (var i = 0; i < aData.length; i++) {
                    var Data = aData[i];
                    if ($('#hdnClientID').val() == Data[6] && $('#ddlServiceType :selected').val() == Data[3] && $('#hdnServiceID').val() == Data[7]) {
                        Msg = 'Y'
                        break;
                    }
                }
                if (Msg != 'Y') {
                    var InvCodeAndName = $('#txtServiceName').val();
                    var INV = '';
                    var INVCODE = '';
                    if (InvCodeAndName.indexOf(":") >= 0) {
                        if (InvCodeAndName.split(':')[0] != " ") {
                            INV = InvCodeAndName.split(':')[1] + ' (' + InvCodeAndName.split(':')[0] + ')';
                            INVCODE = InvCodeAndName.split(':')[0];
                        }
                        else {
                            INV = InvCodeAndName.split(':')[1];
                        }
                    }
                    else {
                        INV = InvCodeAndName;
                    }

                    var clientname = $('#txtClientName').val();
                    var clientcode = '';
                    var test_str = $('#txtClientName').val();
                    var start_pos = test_str.indexOf('(') + 1;
                    var end_pos = test_str.indexOf(')', start_pos);
                    clientcode = test_str.substring(start_pos, end_pos)
                    clientname = clientname.substring(0, clientname.indexOf('('));
                    
                    $('#tblCSMDetails').dataTable().fnAddData([aData.length+1,
                clientname,clientcode,
                $('#ddlServiceType :selected').val(),
                INV,
                Action,
                $('#hdnClientID').val(),
                $('#hdnServiceID').val(),
                INVCODE
                ]);
                }
                else {
                    jAlert("Duplicate..", 'Alert Box');
                }                                                     
        $('#ddlServiceType').val(0);
        $('#txtServiceName').val('');
        $('#hdnServiceID').val(0);
    }

    $(document).on('click', '.CDremove', function() {
        var row = $(this).closest('tr');
        var nRow = row[0];
        jConfirm('Are you sure to delete a record?', 'Confirmation Dialog', function(ReturnResponse) {
        if (ReturnResponse == true) $('#tblCSMDetails').dataTable().fnDeleteRow(nRow);
        });
    });

    var jsonStringCSMDetails = [];
    $('#btnFinalSave').click(function() {
        jsonStringCSMDetails.length = 0;
        GenerateUTD();


        var parameters = {
            lstRateMaster: jsonStringCSMDetails,
            OrgID: OrgId,
            LID: LId,
            ClientID: $('#hdnClientID').val()
        };

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "ClientServiceMapping.aspx/SaveSpecialRateMasters",
            data: JSON.stringify(parameters),
            dataType: "json",
            success: function(data) {
                if (jsonStringCSMDetails.length == 0) {
                    jAlert("Client Service Mapping deleted Successfully", 'Alert Box');
                    Clear();
                }
                else if (data.d != 1001) {
                    jAlert("Client Service Mapping Saved Successfully", 'Alert Box');
                    Clear();
                }
                else {
                    jAlert("The records are not saved.", 'Alert Box');
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
            tmpCSMDetails['ClientID'] = data[6];
            tmpCSMDetails['InvestigationID'] = data[7];
            tmpCSMDetails['InvestigationType'] = data[3];
            tmpCSMDetails['ReferenceType'] = 'BIL';
            tmpCSMDetails['SCode'] = data[8];
            jsonStringCSMDetails.push(tmpCSMDetails);

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
