<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LocationTimeCapture.aspx.cs"
    Inherits="Admin_LocationTimeCapture" %> 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<!--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %> -->
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader"
    TagPrefix="uc3" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/Vmultiselcss/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="Scripts/Vmultiselcss/jquery.timepicker.min.css">
    <link href="Scripts/Vmultiselcss/jquery.multiselect.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/Vmultiselcss/jquery.multiselect.filter.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/Vmultiselcss/prettify.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>

    <script src="Scripts/jquery-ui.min.js" language="javascript" type="text/javascript"></script>

    <script src="Scripts/date.js" language="javascript" type="text/javascript"></script>

    <script src="Scripts/Vmultiselcss/jquery.multiselect.min.js" type="text/javascript"></script>

    <script src="Scripts/Vmultiselcss/prettify.js" type="text/javascript"></script>

    <style>
        hide_column
        {
            display: none;
        }
        #DivHoliday .dataTables_filter
        {
            display: none !important;
        }
        #DivHoliday .dataTables_info
        {
            display: none !important;
        }
        #DivHoliday .dataTables_scrollBody
        {
            height: auto !important;
        }
        #DivScheduleday .dataTables_filter
        {
            display: none !important;
        }
        #DivScheduleday .dataTables_info
        {
            display: none !important;
        }
        #DivScheduleday .dataTables_scrollBody
        {
            height: auto !important;
        }
        #DivScheduleWeek .dataTables_filter
        {
            display: none !important;
        }
        #DivScheduleWeek .dataTables_info
        {
            display: none !important;
        }
        #DivScheduleWeek .dataTables_scrollBody
        {
            height: auto !important;
        }
    </style>
    <style type="text/css">
        div.main
        {
            clear: both;
        }
        .up
        {
            float: left;
        }
        .down
        {
            float: left;
        }
        .listMain
        {
            z-index: 9999999999;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
   
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>                                
                                <div style="border: thin solid #FFFFFF">
                                    <table cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td width="28%">
                                                <asp:Label ID="lblOrganization" runat="server" Text="Organization"></asp:Label>
                                                <asp:DropDownList CssClass="ddllarge" Style="width: 220px;" runat="server" ID="ddlOrganization"
                                                    meta:resourcekey="ddLOResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td width="25%" align="left">
                                                <asp:Label ID="lblLocation" runat="server" Text="Location"></asp:Label>
                                                <asp:DropDownList CssClass="ddllarge" Style="width: 180px;" runat="server" ID="ddLO"
                                                    meta:resourcekey="ddLOResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td width="23%">
                                                <asp:Label ID="lblLabStartTime" runat="server" Text="Start Time"></asp:Label>
                                                <input type="text" id="txtLabStartTime" readonly="readonly" style="width: 180px;"
                                                    name="Start Time" />
                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                            </td>
                                            <td width="33%">
                                                <asp:Label ID="lblLabEndTime" runat="server" Text="End Time"></asp:Label>
                                                <input type="text" id="txtLabEndTime" readonly="readonly" style="width: 180px;" name="End Time" />
                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td rowspan="2" valign="middle" colspan="2" id="divDays" runat="server" align="left">
                                                <asp:Label ID="lblFrequencyDays" runat="server" Text="Frequency Days"></asp:Label>
                                                <div id="divFrequencyDays" runat="server">
                                                </div>
                                            </td>
                                            <td rowspan="2" valign="middle" align="center" width="100%" colspan="2">
                                                <div id="divSearch" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tdLocationWorkingHour" style="display: block;">
                                        <thead align="left">
                                            <tr>
                                                <th visible="false">
                                                    ID
                                                </th>
                                                <th visible="false">
                                                    OrgID
                                                </th>
                                                <th visible="false">
                                                    OrgAddressID
                                                </th>
                                                <th>
                                                    Organization Name
                                                </th>
                                                <th>
                                                    Location
                                                </th>
                                                <th>
                                                    Lab Start
                                                </th>
                                                <th>
                                                    Lab End
                                                </th>
                                                <th>
                                                    Frequency Days
                                                </th>
                                                <th>
                                                    Action
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <input type="hidden" id="hdnEditId" value="" />
                                <input type="hidden" id="hdnRowID" value="0" />
                                <input type="hidden" id="hdnLocationID" value="0" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="imgLoadingbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgLoadingResource1" />
                                <asp:Label ID="Rs_Loading" Text="Loading ..." runat="server" meta:resourcekey="Rs_LoadingResource1" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
               
       <Attune:Attunefooter ID="Attunefooter" runat="server" />
     
    </form>
</body>
</html>

<script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>

<script src="Scripts/jquery-ui.min.js" language="javascript" type="text/javascript"></script>

<script src="Scripts/date.js" language="javascript" type="text/javascript"></script>

<script src="Scripts/Vmultiselcss/jquery.multiselect.min.js" type="text/javascript"></script>

<script src="Scripts/Vmultiselcss/prettify.js" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/Common.js"></script>

<link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
<link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<script src="Scripts/jquery.loader.js" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<script src="Scripts/jquery.timepicker.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        BindLocation();

        var LocationID = "0";
        GetLocationWorkingHours(LocationID);
        $('#txtLabStartTime').timepicker({
            timeFormat: 'h:mm p',
            interval: 15,
            minTime: '0',
            defaultTime: '6',
            startTime: '00:00',
            dynamic: false,
            dropdown: true,
            scrollbar: true
        });
        $('#txtLabEndTime').timepicker({
            timeFormat: 'h:mm p',
            interval: 15,
            minTime: '0',
            defaultTime: '18',
            startTime: '00:00',
            dynamic: false,
            dropdown: true,
            scrollbar: true
        });
        var FrequencyDays = "";
        BindMultiSelect(FrequencyDays);
        var AddTr = '<table><tr><td><span></span> </td></tr></table>';
        var btnAdd = '<input type="button" id="btnAdd" title="Add" class="btn1" value="Add" onclick="ValidateResult(this.id)" />';
        var btnClear = '<input type="button" id="btnClear" title="Clear" class="btn1" value=" Clear " onclick="ClearResult(this.id)"  />';
        $('#divSearch').html('');
        $('#divSearch').append(AddTr);
        $('#divSearch').append(btnClear);
        $('#divSearch').append(btnAdd);
    });
    function BindMultiSelect(FrequencyDays) {
        //debugger;
        $('#divFrequencyDays').html('');
        var ddl = $('<select id="ddlselect"/>');
        $(ddl).attr("multiple", 'multiple');
        var option = "";
        var WeekList = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        for (var i = 0; i < WeekList.length; i++) {
            if (WeekList[i] != "") {
                var selected = "";
                for (var s = 0; s < FrequencyDays.length; s++) {
                    if (FrequencyDays[s] != "" && FrequencyDays[s] == WeekList[i]) {
                        selected = "selected";
                    }
                }
                if (selected == "selected") {
                    option += ('<option class="chkOption" selected="selected" value=' + i + '>' + WeekList[i] + '</option>');
                }
                else {
                    option += ('<option class="chkOption" value=' + i + '>' + WeekList[i] + '</option>');
                }
            }
        }
        $(ddl).append($(option));
        $('#divFrequencyDays').append($(ddl));
        $('#ddlselect').addClass("chkselect");
        $('.chkselect').multiselect();

        //         var ddl = $('<select id="ddlselect"/>');
        //        $(ddl).attr("multiple", 'multiple');
        //        var option = "";
        //        var WeekList = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        //        for (var i = 0; i < WeekList.length; i++) {
        //            if (WeekList[i] != "") {
        //                option += ('<option class="chkOption" value=' + i + '>' + WeekList[i] + '</option>');
        //            }
        //        }
        //        $(ddl).append($(option));
        //        $('#divFrequencyDays').html('');
        //        $('#divFrequencyDays').append($(ddl));
        //        $('#ddlselect').addClass("chkselect");
        //        $('.chkselect').multiselect();
    }
    function BindLocation() {
        try {
            var RoleID = "<%= RoleID %>";
            var OrgID = "<%= OrgID %>";
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/BindLocation",
                contentType: "application/json; charset=utf-8",
                data: "{orgID:'" + parseInt(OrgID) + "', RoleID: '" + RoleID + "'}",
                dataType: "json",
                success: OnSuccessBindLocation,
                failure: function(response) {
                    alert(response.d);
                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("error Record Found");
                    return false;
                }
            });
        }
        catch (e) {
            alert("Catch Found");
        }
        return false;
    }

    function OnSuccessBindLocation(data) {
        $('#ddLO').html('');
        var LocationID = "<%= ILocationID%>";
        if (data.d.length > 0) {
            list = data.d;
            var listlength = list.length;
            if (list.length > 0) {
                for (var i = 0; i < list.length; i++) {
                    if (list[i].AddressID == LocationID) {
                        $('#ddLO').append('<option selected="selected" value="' + list[i].AddressID + '">' + list[i].Location + '</option>');
                    }
                    else {
                        $('#ddLO').append('<option value="' + list[i].AddressID + '">' + list[i].Location + '</option>');
                    }
                }
            }
        }
    }
    $('#ddLO').on('change', function() {
        var LocationID = this.value;
        GetLocationWorkingHours(LocationID);
        var FrequencyDays = "";
        BindMultiSelect(FrequencyDays);
    });
    function GetLocationWorkingHours(LocationID) {
        try {
            var RoleID = "<%= RoleID %>";
            var OrgID = "<%= OrgID %>";
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/BindLocationWorkingHoursDetail",
                contentType: "application/json; charset=utf-8",
                data: "{orgID:'" + parseInt(OrgID) + "', RoleID: '" + RoleID + "', LocationID: '" + LocationID + "'}",
                dataType: "json",
                success: OnSuccessBindLocationWorkingHours,
                failure: function(response) {
                    alert(response.d);
                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error Record Found Binding WorkingHours Detail");
                    return false;
                }
            });
        }
        catch (e) {
            alert("Catch Found while BindLocationWorkingHoursDetail");
        }
    }
    function OnSuccessBindLocationWorkingHours(result) {
        try {
            var dataTable = $('#tdLocationWorkingHour').dataTable();
            dataTable.fnClearTable();
            if (result.d.length > 0) {
                var list = '';
                list = result.d;
                var tabledata = list;
                if (result != "[]") {
                    oTable = $('#tdLocationWorkingHour').dataTable({
                        "bDestroy": true,
                        "bAutoWidth": false,
                        "bProcessing": true,
                        "aaData": tabledata,
                        "aoColumns": [
                    { "mDataProp": "ID", "bVisible": false },
                     { "mDataProp": "OrgID", "bVisible": false },
                      { "mDataProp": "OrgAddressId", "bVisible": false },
                    { "mDataProp": "OrganizationName" },
                    { "mDataProp": "Location" },
                    { "mDataProp": "Labstart",
                        "mRender": function(data, type, full) {				  
                            //var oldDate = full.Labstart.slice(0, 5);
                            //var  AmPm  = Number(oldDate) >= 12 ? " PM" : " AM";
                            //var Minutes = Number(oldDate.getMinutes()) == 0 ? Number(oldDate.getMinutes()).toFixed(2).toString().slice(-2) : oldDate.getMinutes().toString();
                            //var DateTime = Number(oldDate.getHours()) > 12 ? (Number(oldDate.getHours()) - Number(12)).toString().slice(-2) + ":" + Minutes + AmPm : oldDate.getHours() == Number(0) ? 12 + ":" + Minutes + AmPm : oldDate.getHours() + ":" + Minutes + AmPm;
                            var id = "jLabstart" + full.ID;
                            return '<label id="' + id + '" >' + full.Labstart + '</label>';
                        }
                    },
                    { "mDataProp": "Labend",
                        "mRender": function(data, type, full) {
                            //var oldDate = new Date(parseInt(full.Labend.slice(6, -2)));
                            //var AmPm = Number(oldDate.getHours()) >= 12 ? " PM" : " AM";
                            //var Minutes = Number(oldDate.getMinutes()) == 0 ? Number(oldDate.getMinutes()).toFixed(2).toString().slice(-2) : oldDate.getMinutes().toString();
                            //var DateTime = Number(oldDate.getHours()) > 12 ? (Number(oldDate.getHours()) - Number(12)).toString().slice(-2) + ":" + Minutes + AmPm : oldDate.getHours() == Number(0) ? 12 + ":" + Minutes + AmPm : oldDate.getHours() + ":" + Minutes + AmPm;
                            //var oldDate = full.Labend.slice(0, 5);
                            //var  AmPm  = Number(oldDate) >= 12 ? " PM" : " AM";
			    var id = "jLabend" + full.ID;
                            return '<label id="' + id + '" >'  + full.Labend + '</label>';
                        }
                    },
                    { "mDataProp": "FrequencyDays",
                        "mRender": function(data, type, full) {
                            var id = "jFrequencyDays" + full.ID;
                            var bndFrequencyDays = full.FrequencyDays;
                            var spltFrequencyDays = bndFrequencyDays.split('#');
                            return '<label id="' + id + '" >' + spltFrequencyDays[0] + '</label>';
                        }
                    },
                     { "mData": "FrequencyDays",
                         "mRender": function(data, type, full) {
                             var id = "btnEdit" + full.ID;
                             return '<input type="button" id="' + id + '" value="Edit" onclick="SetEditedValue(this,' + full.ID + ')"/><label style="display:none" id="jOrgID" >' + full.OrgID + '</label><label  style="display:none" id="jOrgAddressId" >' + full.OrgAddressId + '</label><label  style="display:none" id="jOrganizationName" >' + full.OrganizationName + '</label><label  style="display:none" id="jLocation" >' + full.Location + '</label>';
                         }
                     }
                     ],
                        "sZeroRecords": "No records found",
                        "bPaginate": false,
                        "bSort": false,
                        "bJQueryUI": false,
                         "searching": false
                    });
                }
            }
        }
        catch (e) {
            alert('Error in data table');
        }
    }
    function SetEditedValue(obj,ID) {
       // debugger;
        $('#hdnLocationID').val(ID);
        var objCtrl = $('#divSearch').find('input[id$="btnAdd"]');
        objCtrl.val("Update");
        var $row = $(obj).closest('tr');
        var hdnID = $row.find($('label[id*="jFrequencyDays"]'))[0].innerHTML;
        var jLabstart = $row.find($('label[id*="jLabstart"]'))[0].innerHTML;
        var jLabend = $row.find($('label[id*="jLabend"]'))[0].innerHTML;
        var FrequencyDays = hdnID.split('-');
        $('#txtLabStartTime').val(jLabstart);
        $('#txtLabEndTime').val(jLabend);
        $('#hdnEditId').val();
        $('#hdnRowID').val("1");
      
        var jOrgAddressId = $row.find($('label[id*="jOrgAddressId"]'))[0].innerHTML;
        var jLocation = $row.find($('label[id*="jLocation"]'))[0].innerHTML;
        var selectedOrgAddressId = $('#ddLO option:selected');
        $(selectedOrgAddressId).val(jOrgAddressId);
        $(selectedOrgAddressId).text(jLocation);
        var jOrgID = $row.find($('label[id*="jOrgID"]'))[0].innerHTML;
        var jOrganizationName = $row.find($('label[id*="jOrganizationName"]'))[0].innerHTML;
        var selectedjOrgID = $('#ddlOrganization option:selected');
        $(selectedjOrgID).val(jOrgID);
        $(selectedjOrgID).text(jOrganizationName);
        BindMultiSelect(FrequencyDays);
    }

    function ClearResult(ctrlID) {
        $('#hdnRowID').val("0");
        $('#txtLabStartTime').val("");
        $('#txtLabEndTime').val("");
        var objCtrl = $('#divSearch').find('input[id$="btnAdd"]');
        objCtrl.val("Add");
        var LocationID = "0";
        GetLocationWorkingHours(LocationID);
        BindLocation();
        var FrequencyDays = "";
        BindMultiSelect(FrequencyDays);
    }
    function ValidateResult(ctrlID) {
        // debugger;
        var enableselectval1 = [];
        var OrganizationName = $("#ddlOrganization option:selected").val();
        var Location = $("#ddLO option:selected").val();
        var LabStartTime = document.getElementById('txtLabStartTime').value;
        var LabEndTime = document.getElementById('txtLabEndTime').value;
        var FrequencyDays = "";
        var lstValues = [];
        var flag = 0;
        var Text = document.getElementById('btnAdd').value;
        var LocationID=document.getElementById('hdnLocationID').value;
        $.each($("#ddlselect option:selected"), function() {
            enableselectval1.push($(this).val());

        });

        if (enableselectval1.length > 0) {
            $.each($("#ddlselect option:selected"), function() {
                FrequencyDays += $(this).text() + ",";
            });

        }




        if ($('#txtLabStartTime').val() == "") {
            alert("Provide Lab Start Time");
            return;
        }
        if ($('#txtLabEndTime').val() == "") {
            alert("Provide Lab End Time");
            return;
        }
        var LabStartTime = $('#txtLabStartTime').val();
        var LabEndTime = $('#txtLabEndTime').val();
        if (LabStartTime != "" && LabEndTime != "") {
            if (isNaN(Number(LabStartTime.slice(0, 2)))) {
                StartHour = Number(LabStartTime.slice(0, 1));
                StartMin = Number(LabStartTime.slice(2, 4));
                StartAMPM = LabStartTime.slice(5, 7);
            }
            else {
                StartHour = Number(LabStartTime.slice(0, 2));
                StartMin = Number(LabStartTime.slice(3, 5));
                StartAMPM = LabStartTime.slice(6, 8);

            }
            if (isNaN(Number(LabEndTime.slice(0, 2)))) {
                EndHour = Number(LabEndTime.slice(0, 1));
                EndMin = Number(LabEndTime.slice(2, 4));
                EndAMPM = LabEndTime.slice(5, 7);
            }
            else {
                EndHour = Number(LabEndTime.slice(0, 2));
                EndMin = Number(LabEndTime.slice(3, 5));
                EndAMPM = LabEndTime.slice(6, 8);
            }
            if (StartAMPM == "PM" && EndAMPM == "AM") {
                alert("Lab End Time Can Not Be Less Than Start Time");
                return false;
            }
            else if (StartAMPM == "AM" && EndAMPM == "PM") {
            }
            else {
                if (StartAMPM == EndAMPM) {
                    if (EndHour > StartHour) {

                    }
                    else if (EndHour < StartHour) {
                        if (StartHour == Number(12)) {
                        }
                        else {
                            alert("Lab End Time Can Not Be Less Than Start Time");
                            return false;
                        }
                    }
                    else if (EndHour == StartHour) {
                        if (EndMin > StartMin) {
                        }
                        else if (EndMin < StartMin) {
                            alert("Lab End Time Can Not Be Less Than Start Time");
                            return false;
                        }
                        else {
                            alert("Lab Start And End Time Can Not Be Same");
                            return false;
                        }
                    }
                }
            }
        }
        if ($('#txtLabEndTime').val() == "") {
            alert("Provide Lab End Time");
            return;
        }
        if (enableselectval1.length = "" || enableselectval1.length <= 0) {
            alert("Provide Frequency Days");
            return;
        }
        if ($("#tdLocationWorkingHour").dataTable().fnSettings().aoData.length != 0) {

            $("#tdLocationWorkingHour > tbody > tr").each(function() {

                var oTable = $("#tdLocationWorkingHour").dataTable();
                var pos = oTable.fnGetPosition(this);
                var rowData = oTable.fnGetData(pos);
                if (Text == 'Add') {
                    if (OrganizationName == rowData["OrgID"] && Location == rowData["OrgAddressId"]) {
                        //  debugger;
                        var bndFrequencyDays = rowData["FrequencyDays"];
                        var spltFrequencyDays = bndFrequencyDays.split('#');
                        var spltFrequencyDay = spltFrequencyDays[0].split('-');
                        var Daysfrequency = FrequencyDays.split(',')

                        for (var i = 0; i < Daysfrequency.length; i++) {
                            for (var j = i; j < spltFrequencyDay.length; j++) {
                                if (Daysfrequency[i] == spltFrequencyDay[j]) {
                                    //  debugger;
                                    alert('Same Org and Location Details already Exists with the frquencyday ' + Daysfrequency[i] + '....!');
                                    flag = 1;

                                }
                            }
                        }
                    }
                }
                if (Text == 'Update') {
                    if (OrganizationName == rowData["OrgID"] && Location == rowData["OrgAddressId"] && LocationID != rowData["ID"]) {
                        //  debugger;
                        var bndFrequencyDays = rowData["FrequencyDays"];
                        var spltFrequencyDays = bndFrequencyDays.split('#');
                        var spltFrequencyDay = spltFrequencyDays[0].split('-');
                        var Daysfrequency = FrequencyDays.split(',')

                        for (var i = 0; i < Daysfrequency.length; i++) {
                            for (var j = i; j < spltFrequencyDay.length; j++) {
                                if (Daysfrequency[i] == spltFrequencyDay[j]) {
                                    //  debugger;
                                    alert('Same Org and Location Details already Exists with the frquencyday ' + Daysfrequency[i] + '....!');
                                    flag = 1;

                                }
                            }
                        }
                    }
                }

            });

        }
        if (flag == 1) {
            return false;
        }
        SaveData();
        $('#hdnRowID').val("0");
        var objCtrl = $('#divSearch').find('input[id$="btnAdd"]');
        objCtrl.val("Add");
        $('#txtLabStartTime').val("");
        $('#txtLabEndTime').val("");
        var FrequencyDays = "";
        BindMultiSelect(FrequencyDays);
    }
    function SaveData() {

        var OrgID = "<%= OrgID %>";
        var OrgAddressId = $('#ddLO').val();
        var Labstart = $('#txtLabStartTime').val();
        var Labend = $('#txtLabEndTime').val();
        var FrequencyDays = "";

        var Text = document.getElementById('btnAdd').value;
        $.each($("#ddlselect option:selected"), function() {
            FrequencyDays += $(this).val() + ",";
        });
        var ID = $('#hdnRowID').val();
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/SaveLocationWorkingHoursDetail",
            contentType: "application/json; charset=utf-8",
            data: "{OrgID:'" + parseInt(OrgID) + "', OrgAddressId: '" + OrgAddressId + "', Labstart: '" + Labstart + "', Labend: '" + Labend + "', FrequencyDays: '" + FrequencyDays + "', ID: '" + ID + "'}",
            dataType: "json",
            success: function(data) {

                var result = data.d;
                if (Text == 'Add') {

                    alert("Saved Sucessfully");
                }
                if (Text == 'Update') {
                    alert("Updated Sucessfully");
                }
                //                else if (result == '3') {
                //                }
                return false;

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert("Error in Webservice Calling");
                return false;
            }
        });
        var LocationID = "0";
        GetLocationWorkingHours(LocationID);
    }
 
</script>

