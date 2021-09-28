<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageSchedule.aspx.cs" Inherits="Admin_ManageSchedule"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %> -->
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage TAT Schedule</title>
    <link type="text/css" href="StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <style>
        .WidthClass
        {
            width:50px !important;
        }
        th
        {
            vertical-align:middle !important;
        }
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
        .dataTables_info
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
        .fg-toolbar ui-toolbar ui-widget-header ui-helper-clearfix ui-corner-bl ui-corner-br
        {
            display: none !important;
        }
        table.dataTable tbody td
        {
            padding: 3px 10px;
            color: #323232;
            border: 1px solid #e8e8e8;
            border-style: solid;
        }
        table.dataTable tr.odd
        {
            background: none repeat scroll 0 0 #f1f8f1 !important;
        }
        .tblStyle td,th
        {
        	border:1px solid silver;
        }
        table.dataTable 
        {
        	border:1px solid silver;
        }
        <%-- #normalSchedule thead
        {
            display: none !important;
        }--%>
        
         #normalSchedule thead
         {
             vertical-align:middle;
                 padding: 3px 10px;
         }
        #tblHoliday thead
        {
            display: none !important;
        }
        #ScheduleWeekgrd thead
        {
            display: none !important;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function WaterMark(txtProcessingHours, evt, defaultTextHH) {

            if (txtProcessingHours.value.length == 0 && evt.type == "blur") {
                txtProcessingHours.style.color = "gray";
                txtProcessingHours.value = defaultTextHH;
            }
            if (txtProcessingHours.value == defaultTextHH && evt.type == "focus") {
                txtProcessingHours.style.color = "black";
                txtProcessingHours.value = "";
            }
        }
        function WaterMark(txtProcessingMins, evt, defaultTextMM) {

            if (txtProcessingMins.value.length == 0 && evt.type == "blur") {
                txtProcessingMins.style.color = "gray";
                txtProcessingMins.value = defaultTextMM;
            }
            if (txtProcessingMins.value == defaultTextMM && evt.type == "focus") {
                txtProcessingMins.style.color = "black";
                txtProcessingMins.value = "";
            }
        }
        function minmax(value, min, max) {
            if (parseInt(value) < min || isNaN(value))
                return 0;
            else if (parseInt(value) > max) {
                alert("Please Enter Valid Mins");
                return '';
            }

            else return value;
        }
    </script>

</head>
<body oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%--<ul>
            <li>
                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
            </li>
        </ul>--%>
        <table class="w-100p a-left">
            <tr>
                <td>
                    <table cellpadding="2" class="dataheaderInvCtrl w-100p searchPanel" cellspacing="2">
                        <tr>
                            <td>
                                <asp:Label ID="lblScheduleCode" Text="Schedule Code" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtScheduleCode" runat="server"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                <asp:Label ID="lblScheduleName" Text="Schedule Name" runat="server"></asp:Label>
                                <asp:TextBox ID="txtScheduleName" runat="server"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblReportedOn" Text="Reported On" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtReportedOn" runat="server"></asp:TextBox>
                                <asp:Label ID="lblTATDate" Text="TAT Date Calculation Based On" runat="server"></asp:Label>
                                <asp:DropDownList ID="ddlTATDate" runat="server">
                                </asp:DropDownList>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblProcessingDuration" Text="Processing Duration" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtProcessingHours" Width="20px"></asp:TextBox>
                                <asp:Label ID="lblHours" Text="Hours" runat="server"></asp:Label>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                <asp:TextBox runat="server" ID="txtProcessingMins" Width="22px" MaxLength="2" onkeyup="this.value = minmax(this.value, 0, 60)"></asp:TextBox>
                                <asp:Label ID="lblMin" Text="Minutes" runat="server"></asp:Label>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEarlyReportTime" Text="Early Report Time" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" class="time_element" ID="txtEarlyReportTime" Width="80px"></asp:TextBox>
                                <img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTATProcessType" Text="Frequency" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlTATProcessType" runat="server" onchange="ScheduleDayHide();">
                                </asp:DropDownList>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td align="left">
                                <div id="DivScheduleday" runat="server" style="display: none; overflow: auto; height: 100px;
                                    width: 40%;">
                                    <table id="Scheduledaygrd" style="display: none;">
                                        <thead align="left">
                                            <tr>
                                                <th>
                                                    Select
                                                </th>
                                                <th width="408px">
                                                    Scheduleday
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="DivScheduleWeek" runat="server" style="display: none; overflow: auto; height: 100px;
                                    width: 40%;">
                                    <table id="ScheduleWeekgrd" style="display: none;">
                                        <thead align="left">
                                            <tr>
                                                <th>
                                                    Select
                                                </th>
                                                <th width="408px">
                                                    Scheduleday
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <asp:DropDownList ID="ddlScheduleMonthly" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlScheduleDaily" runat="server">
                                </asp:DropDownList>
                                <input type="button" id="btnAddWeek" style="cursor: pointer;" class="btn1" title="Add"
                                    value="Add" onclick="AddSlotScheduleDay()" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1">
                            </td>
                            <td colspan="6">
                                <table id="ScheduleDaytbl" class="tblStyle" style="width: 30%; border: 1px solid black;
                                    border-collapse: collapse; display: none" border="1">
                                    <tr>
                                        <th class=".thCss" id="tblday">
                                            Schedule Day
                                        </th>
                                        <th class=".thCss" id="tbldayvalue" style="display: none;">
                                            ScheduleDay Value
                                        </th>
                                        <th class=".thCss" id="tblDelete">
                                            Delete
                                        </th>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblScheduleHolidays" Text="Schedule Custom Holidays" runat="server"></asp:Label>
                            </td>
                            <td>
                                <div id="DivHoliday" runat="server" style="display: none; overflow: auto; height: 100px;
                                    width: 40%;">
                                    <table id="tblHoliday" style="display: none;">
                                        <thead align="left">
                                            <tr>
                                                <th>
                                                    Select
                                                </th>
                                                <th width="408px">
                                                    Holidayname
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTATMode" Text="Mode" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlTATMode" runat="server" onchange="TATModeHide()">
                                </asp:DropDownList>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblCutOffTime" Text="CutOff Interval" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" onkeypress="return isNumber(event);" ID="txtCutOffTime"
                                                Style="width: 38px;"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTransitTime" runat="server" CssClass="small" Height="18px">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" id="imgstar" align="middle" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblStartTime" Text="Start Time" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" class="time_element" ID="txtStartTime" Width="80px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <input type="button" id="btnAdd" onclick="AddSlot();" style="cursor: pointer;" class="btn1"
                                                title="Add" value="Add" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1">
                            </td>
                            <td colspan="6">
                                <table id="Slottbl" class="tblStyle" style="width: 40%;
                                    border-collapse: collapse; display: none" border="1">
                                    <tr>
                                        <th class=".thCss" id="tblStartTime">
                                            Start Time
                                        </th>
                                        <th class=".thCss" id="tblCutoffTime">
                                            Cut Off Time
                                        </th>
                                        <th class=".thCss" id="tblDelete">
                                            Delete
                                        </th>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <input type="button" id="btnSave" style="width: 60px;" class="btn" value="Save" onclick="Save()" />
                                <input type="button" id="btnCancel" style="width: 60px;" class="btn" value="Cancel"
                                    onclick="FinalClear()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="dtManageSchedule">
                        <tr style="display:none">
                            <td align="Right">
                                <asp:Label ID='lblSearchSchedulecode' Text="Enter Schedule Code:" runat="server"></asp:Label>
                                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                                <input type="button" id="btnSearch" value="Search" class="btn" onclick="return BindNormalSearch();" />
                                <input type="button" id="btnSearchClear" value="ClearSearch" class="btn" onclick="return clearTextbox();" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div>
                                    <table id="normalSchedule" cssclass="mytable1 gridView w-100p" runat="server" width="100%">
                                    <tr>
                                            <th>SNO12</th>
                                            <th>Schedule Code</th>
                                            <th>Schedule Name</th>
                                            <th>Reported On</th>
                                            <th>Processing HH:MM</th>
                                            <th>Early Report Time</th>
                                            <th>Frequency</th>
                                            <th class="WidthClass">Schedule Day</th>
                                            <th>Schedule Holiday (Processing Day)</th>
                                            <th>Tat Calculation Base</th>
                                            <th>Mode</th>
                                            <th>CutOff and Batch StartTime</th>
                                            <th>Edit</th>
                                            </tr>
                                    
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr style ="display:none;">
                            <td colspan="8">
                                <table id="tt" style="width: 1100px;">
                                </table>
                                <asp:Panel ID="pnlFooter" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                    <table width="100%">
                                        <tr id="pagination" runat="server" class="dataheaderInvCtrl">
                                            <td align="center" colspan="10" class="defaultfontcolor">
                                                <label id="lblPage">
                                                    Page</label>
                                                <label id="lblCurrent">
                                                </label>
                                                <label>
                                                    of</label>
                                                <label id="lblTotal">
                                                </label>
                                                <input type="button" id="btnFirst" value="First" class="btn" onclick="return btnGoFirst();" />
                                                <input type="button" id="btnPrev" value="Previous" class="btn" onclick="return btnPrevious();" />
                                                <input type="button" id="btnNext" value="Next" class="btn" onclick="return btnGoNext();" />
                                                <input type="button" id="btnLast" value="Last" class="btn" onclick="return btnGoLast();" />
                                                <label>
                                                    Enter the Page to Go</label>
                                                <input type="text" id="txtPageNo" class="Txtboxsmall" style="width: 30px;" onkeydown="return isNumericss(event,this.id)" />
                                                <input type="button" id="btnGo" value="GO" class="btn" onmouseover="this.className='ben btnhov'"
                                                    onclick="return btnGoPage();" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnCurrent" value="" />
        <input type="hidden" id="hdnTotal" />
        <asp:HiddenField ID="hdnorgid" runat="server" />
        <asp:HiddenField ID="hdnScheduleId" runat="server" />
        <asp:HiddenField ID="hdnHolidayid" runat="server" />
        <asp:HiddenField ID="hdnTATDate" runat="server" />
        <asp:HiddenField ID="hdnTATProcessType" runat="server" />
        <asp:HiddenField ID="hdnTATMode" runat="server" />
        <asp:HiddenField ID="hdnScheduleDay" runat="server" />
        <input type="hidden" id="hdnflag" value="0" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>

<script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>

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

<script src="../Scripts/jquery.loader.js" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<link href="StyleSheets/timepicki.css" rel="stylesheet" type="text/css" />
<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
<script src="Scripts/timepicki.js" type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $(".time_element").timepicki();
        GetHoliday();
        BindNormal(normalpagesize, 1, orgId);
        SlabHide();
        FrequencyHide();
        GetScheduleDay();
        GetScheduleWeek();
        ScheduleDayHide();
        TATModeHide();
    });
 
</script>

<script type="text/javascript">
    function FrequencyHide() {
        $('#DivScheduleday').hide();
        $('#DivScheduleWeek').hide();
        $('#ddlScheduleMonthly').hide();
        $('#ddlScheduleDaily').hide();
        $('#btnAddWeek').hide();
        $('#ScheduleDaytbl').hide();

    }
    function ScheduleDayHide() {

        var Frequency = $("#<%=ddlTATProcessType.ClientID %>").val();
        if (Frequency == "0") {
            FrequencyHide();
        }
        if (Frequency == "1") {
            $('#ddlScheduleMonthly').hide();
            $('#ddlScheduleDaily').hide();
            $('#DivScheduleday').show();
            $('#DivScheduleWeek').hide();
            $('#ScheduleDaytbl').hide();
            $('#btnAddWeek').hide();
            //Dayvalidate();

        }

        if (Frequency == "2") {
            $('#ddlScheduleMonthly').hide();
            $('#ddlScheduleDaily').hide();
            $('#DivScheduleday').hide();
            $('#DivScheduleWeek').show();
            $('#ScheduleDaytbl').hide();
            $('#btnAddWeek').hide();

            $("#ScheduleDaytbl").empty();
            var Constant = '<tr><th class=".thCss">Schedule Day</th><th class=".thCss">Delete</th></tr>';
            $("#ScheduleDaytbl").append(Constant);

            document.getElementById("ScheduleDaytbl").disabled = false;
        }
        if (Frequency == "3") {
            $('#ddlScheduleMonthly').show();
            $('#ddlScheduleDaily').show();
            $('#DivScheduleday').hide();
            $('#DivScheduleWeek').hide();
            $('#btnAddWeek').show();
        }

    }
    function Dayvalidate() {
        var Frequency = $("#<%=ddlTATProcessType.ClientID %>").val();
        if (Frequency == "1") {
            $("#Scheduledaygrd tr:not(:first)").each(function(i, n) {
                $("#tblHoliday > tbody > tr").each(function() {
                    var oTable = $("#tblHoliday").dataTable();
                    var pos = oTable.fnGetPosition(this);
                    var rowData = oTable.fnGetData(pos);


                    var $row = $(n);
                    var chkschedule = $row.find('#hdnIdentifyingType').val();
                    var RowScheduleday = $row.find('#hdnRowScheduleday').val();
                    var chkid = 'chkScheduleday' + chkschedule;
                    var HolidayName = $.trim($('input[id$="hdnRowHolidayName"]').val());
                    var HolidayVal = '';
                    switch (HolidayName) {
                        case "Monday":
                            HolidayVal = "Mon";
                            break;
                        case "Tuesday":
                            HolidayVal = "Tue";
                            break;
                        case "Wednesday":
                            HolidayVal = "Wed";
                            break;
                        case "Thursday":
                            HolidayVal = "Thu";
                            break;
                        case "Friday":
                            HolidayVal = "Fri";
                            break;
                        case "Saturday":
                            HolidayVal = "Sat";
                            break;
                        case "Sunday":
                            HolidayVal = "Sun";
                            break;

                    }

                    if (RowScheduleday == HolidayVal) {
                        $("input[id$='" + chkid + "']").prop('checked', false);
                        return false;
                    }
                    else {
                        $("input[id$='" + chkid + "']").prop('checked', true);
                        return false;
                    }
                });
            });
        }

    }
    function SlabHide() {
        $('#lblStartTime').hide();
        $('#txtStartTime').hide();
        $('#lblCutOffTime').hide();
        $('#txtCutOffTime').hide();
        document.getElementById("ddlTransitTime").style.display = "none";
        document.getElementById("imgstar").style.display = "none";
        $('#btnAdd').hide();
        $('#Slottbl').hide();

    }
    function TATModeShow() {
        var TATMode = $("#<%=ddlTATMode.ClientID %>").val();
        if (TATMode == "0") {
            SlabHide();
        }
        if (TATMode == "1") {
            $('#lblStartTime').hide();
            $('#txtStartTime').hide();
            $('#lblCutOffTime').show();
            $('#txtCutOffTime').show();
            document.getElementById("ddlTransitTime").style.display = "block";
            document.getElementById("imgstar").style.display = "block";
            
            $('#btnAdd').show();

        }
        else if (TATMode == "2" || TATMode == "3") {
            $('#lblStartTime').show();
            $('#txtStartTime').show();
            $('#lblCutOffTime').show();
            $('#txtCutOffTime').show();
            document.getElementById("ddlTransitTime").style.display = "block";
            document.getElementById("imgstar").style.display = "block";
            $('#btnAdd').show();
        }

    }
    function TATModeHide() {

        var TATMode = $("#<%=ddlTATMode.ClientID %>").val();
        if (TATMode == "0") {
            SlabHide();
        }
        if (TATMode == "1") {
            $('#lblStartTime').hide();
            $('#txtStartTime').hide();
            $('#lblCutOffTime').show();
            $('#txtCutOffTime').show();
            document.getElementById("ddlTransitTime").style.display = "block";
            document.getElementById("imgstar").style.display = "block";
            $('#btnAdd').show();

            $('#txtStartTime').val("");
            $('#txtCutOffTime').val("");
            $('#ddlTransitTime').val('0');

            $('#Slottbl').hide();
            $("#Slottbl").empty();
            var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Delete</th></tr>';
            $("#Slottbl").append(Constant);

            document.getElementById("txtStartTime").disabled = false;
            document.getElementById("txtCutOffTime").disabled = false;
            document.getElementById("ddlTransitTime").disabled = false;
            document.getElementById("Slottbl").disabled = false;
        }
        else if (TATMode == "2" || TATMode == "3") {
            $('#lblStartTime').show();
            $('#txtStartTime').show();
            $('#lblCutOffTime').show();
            $('#txtCutOffTime').show();
            document.getElementById("ddlTransitTime").style.display = "block";
            document.getElementById("imgstar").style.display = "block";
            $('#btnAdd').show();

            $('#txtStartTime').val("");
            $('#txtCutOffTime').val("");
            $('#ddlTransitTime').val('0');

            $('#Slottbl').hide();
            $("#Slottbl").empty();
            var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
            $("#Slottbl").append(Constant);

            document.getElementById("txtStartTime").disabled = false;
            document.getElementById("txtCutOffTime").disabled = false;
            document.getElementById("ddlTransitTime").disabled = false;
            
            document.getElementById("Slottbl").disabled = false;
        }
    }

    /* Add Table StartTime and CutOffTime */
    function AddSlot() {
        try {
           
            var TATMode = $("#<%=ddlTATMode.ClientID %>").val();
            var Batchstarttime = $('#txtStartTime').val();
            var Cutofftime = $('#txtCutOffTime').val();
            var Transittimetype = $("#ddlTransitTime option:selected").val();
            if (Transittimetype == 0 || Transittimetype == '') {
                alert('Please Give details for Time Duration');
                return false;
            }
//            
//            var Batchstarttimeval = convertTo24Hour($("#txtStartTime").val().toLowerCase());
//            var Cutofftimeval = convertTo24Hour($("#txtCutOffTime").val().toLowerCase());
            
            var cunt;
            var grdSlotRows = $("#Slottbl tr");

            var rowCount = document.getElementById('Slottbl').rows.length;
           
            if (rowCount > 1 && TATMode == 3) {

                for (var i = 0; i < grdSlotRows.length; i++) {
                    var value = $(grdSlotRows).eq(i).find("#lblStartTime").text();
                    if (value == Batchstarttime) {
                        alert('Same Start time Should not be allowed');
                        return false;
                    }
                }


            }

            if (TATMode == "1") {
                if ($('#txtCutOffTime').val() == "") {
                    alert('Please Select CutoffTime');
                    ("#Slottbl").empty();
                    var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Delete</th></tr>';
                    $("#Slottbl").append(Constant);
                    document.getElementById("Slottbl").disabled = false;
                    $("#Slottbl").hide();
                    return false;
                }
                for (var k = 0; k < grdSlotRows.length; k++) {
                    $("#Slottbl").empty();
                    var Constant = '<tr class="trCss"><th class=".thCss">CutOff Interval</th><th class=".thCss">Delete</th></tr>';
                    $("#Slottbl").append(Constant);
                    document.getElementById('Slottbl').style.display = 'block';

                    document.getElementById("Slottbl").disabled = false;
                    $('#Slottbl').hide();

                    var value = '<tr class="trCss"><td class="tdCss" align="left"><label id="lblCutOffTime">' + Cutofftime + ' '+ Transittimetype + '</label></td><td class="tdCss" align="left"><input type="button" title="Delete" class="btn1" onclick="DeleteRow(this)" value="X" /></td></tr>';
                    SlabHide();
                    $('#tblStartTime').hide();
                    if ($(grdSlotRows).eq(k).find("#lblCutOffTime").text() == Cutofftime + ' '+ Transittimetype) {

                        cunt = 1;

                    }
                    else {
                        cunt = 0;
                    }
                }
                if (cunt == 0) {
                    $("#Slottbl").append(value);
                    $('#Slottbl').show();
                    ClearControlTable();
                }
            }
            if (TATMode == "2") {
                if ($('#txtCutOffTime').val() == "") {
                    alert('Please Select CutoffTime');
                    ("#Slottbl").empty();
                    var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
                    $("#Slottbl").append(Constant);
                    document.getElementById("Slottbl").disabled = false;
                    $("#Slottbl").hide();
                    return false;
                }
                if ($('#txtStartTime').val() == "") {
                    alert('Please Select StartTime');
                    ("#Slottbl").empty();
                    var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
                    $("#Slottbl").append(Constant);
                    document.getElementById("Slottbl").disabled = false;
                    $("#Slottbl").hide();
                    return false;
                }
                for (var k = 0; k < grdSlotRows.length; k++) {
                    $("#Slottbl").empty();
                    var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
                    $("#Slottbl").append(Constant);

                    document.getElementById("Slottbl").disabled = false;
                    $('#Slottbl').hide();

                    var value = '<tr class="trCss"><td class="tdCss" align="left"><label id="lblCutOffTime">' + Cutofftime + ' ' + Transittimetype + '</label></td><td class="tdCss" align="left"><label id="lblStartTime">' + Batchstarttime + '</label></td><td class="tdCss" align="left"><input type="button" title="Delete" class="btn1" onclick="DeleteRow(this)" value="X" /></td></tr>';
                    SlabHide();
                    if ($(grdSlotRows).eq(k).find("#lblCutOffTime").text() == Cutofftime + ' '+ Transittimetype && $(grdSlotRows).eq(k).find("#lblStartTime").text() == Batchstarttime) {

                        cunt = 1;

                    }
                    else {
                        cunt = 0;
                    }
                }
                if (cunt == 0) {
                    $("#Slottbl").append(value);
                    $('#Slottbl').show();
                    ClearControlTable();
                }
            }

            if (TATMode == "3") {
                if ($('#txtCutOffTime').val() == "") {
                    alert('Please Select CutoffTime');
                    ("#Slottbl").empty();
                    var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
                    $("#Slottbl").append(Constant);
                    document.getElementById("Slottbl").disabled = false;
                    $("#Slottbl").hide();
                    return false;
                }
                if ($('#txtStartTime').val() == "") {
                    alert('Please Select StartTime');
                    ("#Slottbl").empty();
                    var Constant = '<tr><th class=".thCss">CutOff Interval</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
                    $("#Slottbl").append(Constant);
                    document.getElementById("Slottbl").disabled = false;
                    $("#Slottbl").hide();
                    return false;
                }
                for (var k = 0; k < grdSlotRows.length; k++) {
                    var value = '<tr class="trCss"><td class="tdCss" align="left"><label id="lblCutOffTime">' + Cutofftime + ' ' + Transittimetype + '</label></td><td class="tdCss" align="left"><label id="lblStartTime">' + Batchstarttime + '</label></td><td class="tdCss" align="left"><input type="button" title="Delete" class="btn1" onclick="DeleteRow(this)" value="X" /></td></tr>';
                    if ($(grdSlotRows).eq(k).find("#lblCutOffTime").text() == Cutofftime + ' ' + Transittimetype && $(grdSlotRows).eq(k).find("#lblStartTime").text() == Batchstarttime) {

                        cunt = 1;
                        alert('Already added Slot');
                        $('#btnAdd').show();
                        ClearControlTable();
                        return false;
                    }
                    else {
                        cunt = 0;
                    }
                }
                if (cunt == 0) {
                    $("#Slottbl").append(value);
                    $('#Slottbl').show();
                    ClearControlTable();
                }
//                else {
//                    alert('Already added Slot');
//                    $('#btnAdd').show();
//                    ClearControlTable();
//                }
            }
        }

        catch (ex) {
            console.log(ex);
        }
        return false;
    }


    /* Delete Table StartTime and CutOffTime */
    function DeleteRow(obj) {
        try {
            $(obj).parent().parent().remove();
            TATModeShow();
        }
        catch (ex) {
            console.log(ex);
        }
    }

    /* Clear Control StartTime and CutOffTime */
    function ClearControlTable() {
        try {
            $('#txtStartTime').val("");
            $('#txtCutOffTime').val("");
             $('#ddlTransitTime').val('0');
            
        }
        catch (ex) {
            console.log(ex);
        }
    }

    /* Validate the Control */
    function Validate() {
        var TATDate = $('#<%=ddlTATDate.ClientID %>').val();
        var TATFrequency = $('#<%=ddlTATProcessType.ClientID %>').val();
        var TATMode = $('#<%=ddlTATMode.ClientID %>').val();
        var ScheduleMonthly = $('#<%=ddlScheduleMonthly.ClientID %>').val();
        var ScheduleDaily = $('#<%=ddlScheduleDaily.ClientID %>').val(); 
        var grdSlotRows = $("#Slottbl tr"); 
        var rowCount = document.getElementById('Slottbl').rows.length;



        if (grdSlotRows.length > 1) {
            for (var i = 1; i <= grdSlotRows.length - 1; i++) {
                var value = $(grdSlotRows).eq(i).find("#lblCutOffTime").text();
                if (value == "") {
                    alert('kindly Provide Cutoff Interval');
                    return false;
                }
            }
        }
        else {
            alert('kindly Provide Cutoff Interval');
        }
        
        if ($('#txtScheduleCode').val() == "") {
            alert("Please fill the Schedule Code");
            document.getElementById('txtScheduleCode').focus();
            return false;
        }
        if ($('#txtScheduleName').val() == "") {
            alert("Please fill the Schedule Name");
            document.getElementById('txtScheduleName').focus();
            return false;
        }
        if (TATDate == "0") {
            alert("Please Select the Tat Calculation Base");
            document.getElementById('ddlTATDate').focus();
            return false;
        }

        if ($('#txtProcessingHours').val() == "HH") {
            alert("Please fill the Processing Hours");
            document.getElementById('txtProcessingHours').focus();
            return false;
        }

        if ($('#txtProcessingMins').val() == "MM") {
            alert("Please fill the Processing Minutes");
            document.getElementById('txtProcessingMins').focus();
            return false;
        }
        if ($('#txtEarlyReportTime').val() == "") {
            alert("Please fill the Early Report Time");
            document.getElementById('txtEarlyReportTime').focus();
            return false;
        }
        if (TATFrequency == "0") {
            alert("Please Select the Frequency");
            document.getElementById('ddlTATProcessType').focus();
            return false;
        }
//        if ($('#txtCutOffTime').val() == "") {
//            alert("Please Give the Cutoff Time and Start Time");
//            document.getElementById('txtCutOffTime').focus();
//            return false;
//        }
        
          if (TATFrequency == "1") {
            var Ischk = 0;
            $("#Scheduledaygrd tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                
                    var chkschedule = $row.find('#hdnIdentifyingType').val();
                    var RowScheduleday = $row.find('#hdnRowScheduleday').val();
                    var chkid = 'chkScheduleday' + chkschedule;
                    
                //var chkscheduleweek = $row.find('#hdnRowScheduleWeekId').val();
                //var chkweekid = 'chkScheduleWeek' + chkscheduleweek;
                var isChecked = $row.find("input[id$='" + chkid + "']").is(":checked");
                if (isChecked) {
                    Ischk = 1
                    return false;
                }

            });
            if (Ischk == 0) {
                alert("Please Select the Scheduleday");
                return false;
            }
        }
        
        if (TATFrequency == "2") {
            var Ischk = 0;
            $("#ScheduleWeekgrd tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var chkscheduleweek = $row.find('#hdnRowScheduleWeekId').val();
                var chkweekid = 'chkScheduleWeek' + chkscheduleweek;
                var isChecked = $row.find("input[id$='" + chkweekid + "']").is(":checked");
                if (isChecked) {
                    Ischk = 1
                    return false;
                }

            });
            if (Ischk == 0) {
                alert("Please Select the Scheduleday");
                return false;
            }
        }
         if (TATFrequency == "3") {
         if($("#ScheduleDaytbl tr").length == 1) {
             alert("Please Select the Scheduleday");
         return false;
         }
    }
        if (TATMode == "0") {
            alert("Please Select the Mode");
            document.getElementById('ddlTATMode').focus();
            return false;
        }
        else {
            return true;
        }
    }

    function convertTo24Hour(time) {
        if (time.indexOf('pm') != -1 && time.substr(0, 1) == 0) {
            var index = 0;
            time=time.substr(0, index) + '' + time.substr(index + 1);
        }
        var hours = parseInt(time.substr(0, 2));
        if (time.indexOf('am') != -1 && hours == 12) {
            time = time.replace('12', '0');
        }
        if (time.indexOf('pm') != -1 && hours < 12) {
            time = time.replace(hours, (hours + 12));
        }
        return time.replace(/(am|pm)/, '');
    }
    function ValidateTime() {

        var Batchstarttime = convertTo24Hour($("#txtStartTime").val().toLowerCase());
        var Cutofftime = convertTo24Hour($("#txtCutOffTime").val().toLowerCase());


        var TATMode = $("#<%=ddlTATMode.ClientID %>").val();
        if (TATMode == "2" || TATMode == "3") {
            if (Cutofftime > Batchstarttime) {
                alert("Start Time Should be Greater than or Equal to Cutoff Time");
                $('#txtStartTime').val("");
                return false;
            }

        }

    }

    /* Clear control after final save */
    function FinalClear() {

        $('#txtScheduleName').val("");
        $('#txtScheduleCode').val("");
        $('#txtReportedOn').val("");
        $('#txtEarlyReportTime').val("");
        $("#<%=ddlTATDate.ClientID %>").val("0");
        $("#<%=ddlTATProcessType.ClientID %>").val("0");
        $("#<%=ddlTATMode.ClientID %>").val("0");
        $("#<%=ddlScheduleMonthly.ClientID %>").val("0");
        $("#<%=ddlScheduleDaily.ClientID %>").val("0");
        $('#txtStartTime').val("");
        $('#txtCutOffTime').val("");
         $('#ddlTransitTime').val('0');
        
        
        $('#Slottbl').hide();
        $('#DivHoliday').show();
        $('#tblHoliday').show();
        $('#dtManageSchedule').show();
        $('#normalSchedule').show();
        $('#DivScheduleday').hide();
        $('#DivScheduleWeek').hide();
        $("#ScheduleDaytbl").hide();
        if ($('#txtProcessingHours').val() == "HH" || $('#txtProcessingMins').val() == "MM") {

            $('#txtProcessingHours').val("HH");
            $('#txtProcessingMins').val("MM");
        }
        else if ($('#txtProcessingHours').val() != "HH" || $('#txtProcessingMins').val() != "MM") {
            $('#txtProcessingHours').val("HH");
            $('#txtProcessingMins').val("MM");
        }
        $("#Slottbl").empty();
        var Constant = '<tr><th class=".thCss">Start Time</th><th class=".thCss">CutOff Interval</th><th class=".thCss">Delete</th></tr>';
        $("#Slottbl").append(Constant);

        $("#ScheduleDaytbl").empty();
        var Constant = '<tr><th class=".thCss">Schedule Day</th><th class=".thCss">Delete</th></tr>';
        $("#ScheduleDaytbl").append(Constant);


        document.getElementById("txtScheduleName").disabled = false;
        document.getElementById("txtScheduleCode").disabled = false;
        document.getElementById("txtReportedOn").disabled = false;
        document.getElementById("txtProcessingHours").disabled = false;
        document.getElementById("txtProcessingMins").disabled = false;
        document.getElementById("txtEarlyReportTime").disabled = false;

        document.getElementById("txtStartTime").disabled = false;
        document.getElementById("txtCutOffTime").disabled = false;
        document.getElementById("ddlTransitTime").disabled = false;
        
        document.getElementById("Slottbl").disabled = false;
        document.getElementById("ScheduleDaytbl").disabled = false;

        document.getElementById("btnSave").disabled = false;
        document.getElementById("btnAdd").disabled = false;
        FrequencyHide();
        SlabHide();
        Dayvalidate();
        uncheckdata();
        $('#hdnflag').val("0");
    }

    /* Add Table ScheduleDay */
    function AddSlotScheduleDay() {
        try {
            
            var rowCount = document.getElementById('ScheduleDaytbl').rows.length;
            var TATProcessTypeval = $('#<%=ddlTATProcessType.ClientID %>').val();
            var ScheduleMonthlyval = $('#<%=ddlScheduleMonthly.ClientID %>').val();
            var ScheduleDailyval = $('#<%=ddlScheduleDaily.ClientID %>').val();
            var ScheduleMonthly = $("#ddlScheduleMonthly").find("option:selected").text();
            var ScheduleDaily = $("#ddlScheduleDaily").find("option:selected").text();

            var cunt;
            var grdDaySlotRows = $("#ScheduleDaytbl tr");
            if (rowCount > 1 && TATProcessTypeval == 3) {
                var monthlydaily = ScheduleMonthlyval + ScheduleDailyval;
                for (var i = 0; i < grdDaySlotRows.length; i++) {
                    var value = $(grdDaySlotRows).eq(i).find("#lblScheduleDailyval").text();
                    if (value == monthlydaily) {
                        alert('Same Schedule already added');
                        return false;
                    }
                }
                
               
            }

            if ($('#<%=ddlScheduleMonthly.ClientID %>').val() == "0" || $('#<%=ddlScheduleDaily.ClientID %>').val() == "0") {
                alert('Please Select Schedule day');
                $("#ScheduleDaytbl").empty();
                var Constant = '<tr><th class=".thCss">Schedule Day</th><th class=".thCss">Delete</th></tr>';
                $("#ScheduleDaytbl").append(Constant);
                document.getElementById("ScheduleDaytbl").disabled = false;
                $("#ScheduleDaytbl").hide();
                return false;

            }
                  
            for (var k = 0; k < grdDaySlotRows.length; k++) {
                var value = '<tr class="trCss"><td class="tdCss" align="left"><label id="lblScheduleDaily">' + ScheduleMonthly + '-' + ScheduleDaily + '</label></td><td class="tdCss" align="left"  style="display:none;"><label id="lblScheduleDailyval">' + ScheduleMonthlyval + ScheduleDailyval + '</label></td><td class="tdCss" align="left"><input type="button" title="Delete" class="btn1" onclick="DeleteWeekRow(this)" value="X" /></td></tr>';

                if ($(grdDaySlotRows).eq(k).find("#lblScheduleDaily").text() == ScheduleMonthly + ScheduleDaily && $(grdDaySlotRows).eq(k).find("#lblScheduleDailyval").text() == ScheduleMonthlyval + ScheduleDailyval) {

                    cunt = 1;
                }
                else {
                    cunt = 0;
                }
            }

            if (cunt == 0) {
                $("#ScheduleDaytbl").append(value);
                $('#hdnScheduleDay').val(value);

                $('#ScheduleDaytbl').show();
                ClearControlWeekTable();
            }
            else {
                alert('Already added Slot');
                $('#btnAddWeek').show();

            }
        }

        catch (ex) {
            console.log(ex);
        }
        return false;
    }

    /* Delete Table ScheduleDay */
    function DeleteWeekRow(obj) {
        try {
            $(obj).parent().parent().remove();
        }
        catch (ex) {
            console.log(ex);
        }
    }

    /* Clear Control StartTime and CutOffTime */
    function ClearControlWeekTable() {
        try {
            $("#<%=ddlScheduleMonthly.ClientID %>").val("0");
            $("#<%=ddlScheduleDaily.ClientID %>").val("0");
        }
        catch (ex) {
            console.log(ex);
        }
    }


    function Save() {
        try {
            if (Validate()) {
                Dayvalidate();
                var lstResultValues = [];
                var lstRowHolidayName = [];
                $("#tblHoliday > tbody > tr").each(function() {
                    var oTable = $("#tblHoliday").dataTable();
                    var pos = oTable.fnGetPosition(this);
                    var rowData = oTable.fnGetData(pos);

                    if ($(this).find("[id*=chkSelCategory]").is(':checked') == true) {

                        if ($.trim($('input[id$="hdnRowHolidayName"]').val()) != '') {
                            lstRowHolidayName.push({
                                RowHolidayName: $.trim($('input[id$="hdnRowHolidayName"]').val())
                            });
                        }

                        lstResultValues.push({
                            Holidayid: rowData["Holidayid"]

                        });
                    }

                });

                var lstrelease;
                if (JSON.stringify(lstResultValues) == "[]") {
                    lstrelease = '';
                }
                else {
                    lstrelease = JSON.stringify(lstResultValues);
                }

                var Schedulecode = $('#txtScheduleCode').val();
                var Schedulename = $('#txtScheduleName').val();
                var Reportedon = $('#txtReportedOn').val();
                var Tatcalculationbase = $('#<%=ddlTATDate.ClientID %>').val();
                var Processinghours = $('#txtProcessingHours').val();
                var Processingmins = $('#txtProcessingMins').val();
                var Earlyreporttime = $('#txtEarlyReportTime').val();
                var Tatprocesstype = $('#<%=ddlTATProcessType.ClientID %>').val();
                var Tatmode = $('#<%=ddlTATMode.ClientID %>').val();

                var tableJson2 = "";
                var tableJson = "";

                if (Tatmode == "1") {
                    var tableValue = $('#Slottbl tr:has(td)').map(function(i, v) {
                        var $td = $('td', this);
                        return {
                            Batchstarttime: '',
                            Cutofftime: $td.eq(0).text()
                        }
                    }).get();
                    tableJson = JSON.stringify(tableValue);
                }

                if (Tatmode == "2" || Tatmode == "3") {
                    var tableValue = $('#Slottbl tr:has(td)').map(function(i, v) {
                        var $td = $('td', this);
                        return {
                            Cutofftime: $td.eq(0).text(),
                            Batchstarttime: $td.eq(1).text()

                        }
                    }).get();
                    tableJson = JSON.stringify(tableValue);
                }

                var strlstScheduledayValues = '';
                var strlstScheduledayName = '';
                if (Tatprocesstype == "1") {
                    $("#Scheduledaygrd > tbody > tr").each(function() {
                        var oTable = $("#Scheduledaygrd").dataTable();
                        var pos = oTable.fnGetPosition(this);
                        var rowData = oTable.fnGetData(pos);

                        if ($(this).find("[id*=chkScheduleday]").is(':checked') == true) {
                            strlstScheduledayValues += rowData["IdentifyingType"] + ',';
                            strlstScheduledayName += rowData["CodeName"] + ',';
                        }

                    });
                }

                var strlstScheduleWeekValues = '';
                var strlstScheduleWeekName = '';
                if (Tatprocesstype == "2") {
                    $("#ScheduleWeekgrd > tbody > tr").each(function() {
                        var oTable = $("#ScheduleWeekgrd").dataTable();
                        var pos = oTable.fnGetPosition(this);
                        var rowData = oTable.fnGetData(pos);

                        if ($(this).find("[id*=chkScheduleWeek]").is(':checked') == true) {
                            strlstScheduleWeekValues += rowData["IdentifyingType"] + ',';
                            strlstScheduleWeekName += rowData["CodeName"] + ',';
                        }

                    });
                }

                if (Tatprocesstype == "3") {
                    var tableDayValue = $('#ScheduleDaytbl tr:has(td)').map(function(i, v) {
                        
                        var $td = $('td', this);
                        return {
                            Scheduleday: $td.eq(1).text()

                        }
                    }).get();
                    var value = '';
                    for (var i = 0; i < tableDayValue.length; i++) {
                        value += tableDayValue[i].Scheduleday + ',';
                    }
                    tableJson2 = value;
                }

                var orgId = $('#hdnorgid').val();
                var Scheduleid = $('#hdnScheduleId').val();
                var flag = document.getElementById('hdnflag').value 
				
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/SaveManageSchedule",
                    contentType: "application/json; charset=utf-8",
                    data: "{'Schedulecode': '" + Schedulecode + "','Schedulename': '" + Schedulename + "','Reportedon': '" + Reportedon + "',Tatcalculationbase: '" + Tatcalculationbase + "',Processinghours:'" + Processinghours + "',Processingmins:'" + Processingmins + "','Earlyreporttime':'" + Earlyreporttime + "',Tatprocesstype:'" + Tatprocesstype + "',Tatmode:'" + Tatmode + "','tableJson': '" + tableJson + "',Orgid: '" + orgId + "',Scheduleid: '" + Scheduleid + "',Flag: '" + flag + "','lstHolidaymaster':'" + lstrelease + "','tableJson2': '" + tableJson2 + "','strlstScheduledayValues':'" + strlstScheduledayValues + "','strlstScheduleWeekValues':'" + strlstScheduleWeekValues + "'}",

                    dataType: "json",
                    success: function(data) {
                        var result = data.d;
                        if (result == '1') {
                            alert("Saved Sucessfully");
                            BindNormal(normalpagesize, 1, orgId);
                            FinalClear();
                            uncheckdata();
                        }
                        if (result == '2') {
                            alert("Updated Sucessfully");
                            BindNormal(normalpagesize, 1, orgId);
                            FinalClear();
                            uncheckdata();
                        }
                        else if (result == '3') {
                            alert("Schedule Name or Code is already Exists");
                        }

                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error in Webservice Calling");
                        $('#Slottbl').hide();

                        return false;
                    }
                });
                return false;
            }

        }

        catch (e) {
            alert("Unable to Save");
            return false;
        }
    }


    function GetHoliday() {
        try {
            var orgId = $('#hdnorgid').val();
             
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetHolidayMaster",
                contentType: "application/json;charset=utf-8",
                data: "{'pOrgID': " + orgId + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice tblHoliday calling");

                    return false;
                }
            });
            $('#DivHoliday').show();
            $('#tblHoliday').show();


        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false
    }
    function AjaxGetFieldDataSucceeded(result) {
        try {
            
            var oTable;
            var dataRes;
            dataRes = result.d;

            var i = 1;
            if (result != "") {

                oTable = $('#tblHoliday').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,
                    "aaData": result.d,
                    "fnStandingRedraw": function() {
                    },
                    "aoColumns": [
                     { "mDataProp": "Holidayid", // Select Checkbox
                         "mRender": function(data, type, full) {
                             if (data != null) {
                                 return '<input type="checkbox" class="Select"  id="chkSelCategory' + full.Holidayid + '">'
                                 + '<input type="hidden" runat="server" id="hdnRowHolidayId" value="' + full.Holidayid + '">'
                                 + '<input type="hidden" runat="server" id="hdnRowHolidayName" value="' + full.Holidayname + '">';
                             }
                             return data;
                         }
                     },

            { "mDataProp": "Holidayname"} //Holidayname



],
                    "sPaginationType": "full_numbers",
                    "bPaginate": false,

                    "iDisplayLength": 50,
                    "sScrollY": "323px",
                    "bScrollCollapse": true,
                    "bAutoWidth": false

                });



            }
        }
        catch (e) {

            alert('Error in Test List Values');

        }
    }


    function GetScheduleDay() {
        try {
            var OrgID = $('#hdnorgid').val();
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetScheduleDay",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID': " + OrgID + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceededScheduleDay,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice Scheduledaygrd calling");

                    return false;
                }
            });
            $('#DivScheduleday').show();
            $('#Scheduledaygrd').show();


        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false
    }
    function AjaxGetFieldDataSucceededScheduleDay(result) {
        try {

            var oTable;
            var dataRes;
            dataRes = result.d;

            var i = 1;
            if (result != "") {

                oTable = $('#Scheduledaygrd').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,
                    "aaData": result.d,
                    "fnStandingRedraw": function() {
                    },
                    "aoColumns": [
                     { "mDataProp": "IdentifyingType", // Select Checkbox
                         "mRender": function(data, type, full) {
                             if (data != null) {
                                 return '<input type="checkbox" class="Select" id="chkScheduleday' + full.IdentifyingType + '">'
                                 + '<input type="hidden" runat="server" id="hdnIdentifyingType" value="' + full.IdentifyingType + '">'
                                  + '<input type="hidden" runat="server" id="hdnRowScheduleday" value="' + full.CodeName + '">';
                             }
                             return data;
                         }
                     },

            { "mDataProp": "CodeName"} //ScheduleDay



],
                    "sPaginationType": "full_numbers",
                    "bPaginate": false,

                    "iDisplayLength": 50,
                    "sScrollY": "323px",
                    "bScrollCollapse": true,
                    "bAutoWidth": false

                });

            }
        }
        catch (e) {

            alert('Error in Test List Values');
        }
    }


    function GetScheduleWeek() {
        try {
            var OrgID = $('#hdnorgid').val();
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetScheduleDay",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID': " + OrgID + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceededScheduleWeek,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice Scheduledaygrd calling");

                    return false;
                }
            });
            $('#DivScheduleWeek').show();
            $('#ScheduleWeekgrd').show();


        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false
    }
    function AjaxGetFieldDataSucceededScheduleWeek(result) {
        try {

            var oTable;
            var dataRes;
            dataRes = result.d;

            var i = 1;
            if (result != "") {

                oTable = $('#ScheduleWeekgrd').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,
                    "aaData": result.d,
                    "fnStandingRedraw": function() {
                    },
                    "aoColumns": [
                     { "mDataProp": "IdentifyingType", // Select Checkbox
                         "mRender": function(data, type, full) {
                             if (data != null) {
                                 return '<input type="checkbox" class="Select"  id="chkScheduleWeek' + full.IdentifyingType + '">'
                                 + '<input type="hidden" runat="server" id="hdnRowScheduleWeekId" value="' + full.IdentifyingType + '">'
                                  + '<input type="hidden" runat="server" id="hdnRowScheduleWeek" value="' + full.CodeName + '">';
                             }
                             return data;
                         }
                     },

            { "mDataProp": "CodeName"} //ScheduleDay



],
                    "sPaginationType": "full_numbers",
                    "bPaginate": false,

                    "iDisplayLength": 50,
                    "sScrollY": "323px",
                    "bScrollCollapse": true,
                    "bAutoWidth": false

                });

            }
        }
        catch (e) {

            alert('Error in Test List Values');
        }
    }
   
</script>

<script type="text/javascript" language="javascript">
    var pagesize = 200;
    var normalpagesize = 200;
    var startpageindex = 1;
    var reasonpagesize = 200;
    var orgId = $('#hdnorgid').val();
    $(document).ready(function() {
        var pageNumber = 1;
        BindNormal(normalpagesize, startpageindex);

    });

    function uncheckdata() {
        $("#tblHoliday tr:not(:first)").each(function(i, n) {
            var $row = $(n);
            var Holidayid = $row.find('#hdnRowHolidayId').val();
            var chkid = 'chkSelCategory' + Holidayid;
            var isChecked = $row.find("input[id$='" + chkid + "']").is(":checked");
            if (isChecked) {

                $("input[id$='" + chkid + "']").attr('checked', false);
            }
        });


        $("#Scheduledaygrd tr:not(:first)").each(function(i, n) {
            var $row = $(n);
            var chkschedule = $row.find('#hdnIdentifyingType').val();
            var chkid = 'chkScheduleday' + chkschedule;
            var isChecked = $row.find("input[id$='" + chkid + "']").is(":checked");
            if (isChecked) {

                $("input[id$='" + chkid + "']").attr('checked', false);
            }
        });

        $("#ScheduleWeekgrd tr:not(:first)").each(function(i, n) {
            var $row = $(n);
            var chkscheduleweek = $row.find('#hdnRowScheduleWeekId').val();
            var chkweekid = 'chkScheduleWeek' + chkscheduleweek;
            var isChecked = $row.find("input[id$='" + chkweekid + "']").is(":checked");
            if (isChecked) {

                $("input[id$='" + chkweekid + "']").attr('checked', false);
            }
        });
    }


             function clearTextbox() {
                  $('#txtSearch').val('');
                    BindNormal(200, 1);
                  
                     }
    function BindNormal(pagesize, startpageindex) {
       var search = $('#txtSearch').val();
        if (search == '') {
             search="";
        }
       else
           search = $('#txtSearch').val();
        
       
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetManageSchedule",
            contentType: "application/json; charset=utf-8",
            data: "{ pagesize: '" + pagesize + "',pageindex: '" + startpageindex + "',search: '" + search + "' }", 
            dataType: "json",
            success: function(data) {
                var lstTATSchedule;
                var lstHolidaymaster;

                ArrayItems = data.d;

                lstTATSchedule = ArrayItems[0];
                lstHolidaymaster = ArrayItems[1];
                var totalRows = 0; // = lstTATSchedule.length;
                $('#normalSchedule').dataTable({
                     "searching": false,
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,

                    "aaData": lstTATSchedule,

                    "aoColumns": [
                          { "sTitle": "SNO", "mData": "SNO",
                              "mRender": function(data, type, full) {
                                  totalRows = full.TotalRows;
                                  return '<label>' + full.SNO + '</label>';
                              }
                          },
                          { "sTitle": "Schedule Code", "mData": "Schedulecode",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Schedulecode + '</label>';

                              }
                          },
                          { "sTitle": "Schedule Name", "mData": "Schedulename",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Schedulename + '</label>';
                              }
                          },
                          { "sTitle": "Reported On", "mData": "Reportedon",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Reportedon + '</label>';
                              }
                          },

                          { "sTitle": "Processing HH:MM", "mData": "THolidayName",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.THolidayName + '</label>';
                              }
                          },
                          { "sTitle": "Early Report Time", "mData": "Earlyreporttime",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Earlyreporttime + '</label>';
                              }
                          },
                           { "sTitle": "Frequency", "mData": "Tatcalculationbasecode",
                               "mRender": function(data, type, full) {
                                   return '<label>' + full.Tatcalculationbasecode + '</label>';
                               }
                           },
                            { "sTitle": "Schedule Day", "mData": "Scheduleday",
                                "mRender": function(data, type, full) {
                                    return '<label>' + full.Scheduleday + '</label>';
                                }
                            },
                             { "sTitle": "Schedule Holiday (Processing Day)", "mData": "Holidayname",
                                 "mRender": function(data, type, full) {

                                     var Holidayname = '';
                                     var Scheduleid = '';
                                     var Holidayid = '';

                                     for (var i = 0; i < lstHolidaymaster.length; i++) {
                                         if (lstHolidaymaster[i].Scheduleid == full.Scheduleid) {
                                             Holidayname += lstHolidaymaster[i].Holidayname + ',';
                                             Holidayid += lstHolidaymaster[i].Holidayid + ',';
                                         }
                                     }
                                     $('#hdnHolidayid').val(Holidayid);
                                     return '<label>' + Holidayname + '</label>';
                                 }

                             },
                             { "sTitle": "Tat Calculation Base", "mData": "TatprocesstypeCode",
                                 "mRender": function(data, type, full) {
                                     return '<label>' + full.TatprocesstypeCode + '</label>';
                                 }
                             },

                          { "sTitle": "Mode", "mData": "Tatmodecode",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Tatmodecode + '</label>';
                              }
                          },
                          { "sTitle": "CutOff and Batch StartTime", "mData": "SlotValue",
                              "mRender": function(data, type, full) {
                                  if (data != '') {
                                      var value = '';
                                      if (full.SlotValue != '') {
                                          if (full.SlotValue.length > 0) {
                                              for (var j = 0; j < full.SlotValue.length; j++) {
                                                  if (full.SlotValue[j].Batchstarttime != '' && full.SlotValue[j].Batchstarttime != '-') {
                                                      value = '<table border="1"><thead><th>CutOff Interval</th><th>Start Time</th></thead>';
                                                      for (var i = 0; i < full.SlotValue.length; i++) {
                                                          value += '<tr><td>' + full.SlotValue[i].Cutofftime + '</td><td>' + full.SlotValue[i].Batchstarttime + '</td></tr>'

                                                      }
                                                  }
                                                  else if (full.SlotValue[j].Batchstarttime == '-') {
                                                      value = '<table border="1"><thead><th>CutOff Interval</th></thead>';
                                                      for (var i = 0; i < full.SlotValue.length; i++) {
                                                          value += '<tr><td>' + full.SlotValue[i].Cutofftime + '</td></tr>'
                                                      }
                                                  }
                                              }

                                              value += '</table>';
                                          }

                                      }

                                      return value;
                                  }
                                  else {
                                      return '<label>' + "" + '</label>';
                                  }
                              }
                          },

                          { "sTitle": "Edit", "mData": "Scheduleid",
                              "mRender": function(data, type, full) {
                                  return '<input type="button" id="btnEdit"' + full.Scheduleid + ' value="Edit" onclick="clicksample(' + full.Scheduleid + ')"/> ';
                              }
                          }



                          ],

                    "sPaginationType": "full_numbers",
                    "bPaginate": false,

                    "bJQueryUI": false,
                  
                    "sScrollY": "323px",
                    "bInfo": false,
                    "bScrollCollapse": false,
                    "bAutoWidth": false,
                    "bFilter": false

                });
                paging(totalRows);

            },
            error: function(result) {
                alert("Erorr");
            }
        });

        $('#lblCurrent').html(startpageindex);
        $('#hdnCurrent').val(startpageindex);

    }

    function BindNormalSearch() {
    
        var searchtext = $('#txtSearch').val();
        if (searchtext == '') {
            alert('Kindly Enter text to search');
            return false;
        }
        var pagesize = 200;
        var startpageindex = 1;
        
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetManageSchedule",
            contentType: "application/json; charset=utf-8",
            data: "{ pagesize: '" + pagesize + "',pageindex: '" + startpageindex + "',search: '" + searchtext + "'}",
            dataType: "json",
            success: function(data) {
                var lstTATSchedule;
                var lstHolidaymaster;

                ArrayItems = data.d;

                lstTATSchedule = ArrayItems[0];
                lstHolidaymaster = ArrayItems[1];
                var totalRows = 0; // = lstTATSchedule.length;
                $('#normalSchedule').dataTable({

                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,

                    "aaData": lstTATSchedule,

                    "aoColumns": [
                          { "sTitle": "SNO", "mData": "SNO",
                              "mRender": function(data, type, full) {
                                  totalRows = full.TotalRows;
                                  return '<label>' + full.SNO + '</label>';

                              }
                          },
                          { "sTitle": "Schedule Code", "mData": "Schedulecode",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Schedulecode + '</label>';

                              }
                          },
                          { "sTitle": "Schedule Name", "mData": "Schedulename",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Schedulename + '</label>';
                              }
                          },
                          { "sTitle": "Reported On", "mData": "Reportedon",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Reportedon + '</label>';
                              }
                          },

                          { "sTitle": "Processing HH:MM", "mData": "THolidayName",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.THolidayName + '</label>';
                              }
                          },
                          { "sTitle": "Early Report Time", "mData": "Earlyreporttime",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Earlyreporttime + '</label>';
                              }
                          },
                           { "sTitle": "Frequency", "mData": "Tatcalculationbasecode",
                               "mRender": function(data, type, full) {
                                   return '<label>' + full.Tatcalculationbasecode + '</label>';
                               }
                           },
                            { "sTitle": "Schedule Day", "mData": "Scheduleday",
                                "mRender": function(data, type, full) {
                                    return '<label>' + full.Scheduleday + '</label>';
                                }
                            },
                             { "sTitle": "Schedule Holiday (Processing Day)", "mData": "Holidayname",
                                 "mRender": function(data, type, full) {

                                     var Holidayname = '';
                                     var Scheduleid = '';
                                     var Holidayid = '';

                                     for (var i = 0; i < lstHolidaymaster.length; i++) {
                                         if (lstHolidaymaster[i].Scheduleid == full.Scheduleid) {
                                             Holidayname += lstHolidaymaster[i].Holidayname + ',';
                                             Holidayid += lstHolidaymaster[i].Holidayid + ',';
                                         }
                                     }
                                     $('#hdnHolidayid').val(Holidayid);
                                     return '<label>' + Holidayname + '</label>';
                                 }

                             },
                             { "sTitle": "Tat Calculation Base", "mData": "TatprocesstypeCode",
                                 "mRender": function(data, type, full) {
                                     return '<label>' + full.TatprocesstypeCode + '</label>';
                                 }
                             },

                          { "sTitle": "Mode", "mData": "Tatmodecode",
                              "mRender": function(data, type, full) {
                                  return '<label>' + full.Tatmodecode + '</label>';
                              }
                          },
                          { "sTitle": "CutOff and Batch StartTime", "mData": "SlotValue",
                              "mRender": function(data, type, full) {
                                  if (data != '') {
                                      var value = '';
                                      if (full.SlotValue != '') {
                                          if (full.SlotValue.length > 0) {
                                              for (var j = 0; j < full.SlotValue.length; j++) {
                                                  if (full.SlotValue[j].Batchstarttime != '' && full.SlotValue[j].Batchstarttime != '-') {
                                                      value = '<table border="1"><thead><th>CutOff Interval</th><th>Start Time</th></thead>';
                                                      for (var i = 0; i < full.SlotValue.length; i++) {
                                                          value += '<tr><td>' + full.SlotValue[i].Cutofftime + '</td><td>' + full.SlotValue[i].Batchstarttime + '</td></tr>'

                                                      }
                                                  }
                                                  else if (full.SlotValue[j].Batchstarttime == '-') {
                                                      value = '<table border="1"><thead><th>CutOff Interval</th></thead>';
                                                      for (var i = 0; i < full.SlotValue.length; i++) {
                                                          value += '<tr><td>' + full.SlotValue[i].Cutofftime + '</td></tr>'
                                                      }
                                                  }
                                              }

                                              value += '</table>';
                                          }

                                      }

                                      return value;
                                  }
                                  else {
                                      return '<label>' + "" + '</label>';
                                  }
                              }
                          },

                          { "sTitle": "Edit", "mData": "Scheduleid",
                              "mRender": function(data, type, full) {
                                  return '<input type="button" id="btnEdit"' + full.Scheduleid + ' value="Edit" onclick="clicksample(' + full.Scheduleid + ')"/> ';
                              }
                          }



                          ],

                    "sPaginationType": "full_numbers",
                    "bPaginate": false,
                    

                    "bJQueryUI": true,
                    "iDisplayLength": 200,
                    "sScrollY": "323px",

                    "bScrollCollapse": true,
                    "bAutoWidth": false,
                    "bFilter": true

                });
                paging(totalRows);

            },
            error: function(result) {
                alert("Erorr");
            }
        });

        $('#lblCurrent').html(startpageindex);
        $('#hdnCurrent').val(startpageindex);

    }
    
</script>

<script type="text/javascript">

    function clicksample(va) {
        var Scheduleid = va;
        $('#hdnScheduleId').val(Scheduleid);
        EditManageSchedule($('#hdnScheduleId').val());
        uncheckdata();

    }

    function EditManageSchedule(Scheduleid) {
        try {
            var flag = 1;
            document.getElementById('hdnflag').value = flag;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/EditManageSchedule",
                contentType: "application/json; charset=utf-8",
                data: "{ Scheduleid: '" + Scheduleid + "'}",
                dataType: "json",
                success: function GetEditData(data) {
                    try {
                        var lstTATSchedule;
                        var lstHolidaymaster;

                        var x = 0;

                        ArrayItems = data.d;
                        lstTATSchedule = ArrayItems[0];
                        lstHolidaymaster = ArrayItems[1];

                        if (ArrayItems.length > 0) {


                            $("#ScheduleDaytbl").empty();
                            var Constantday = '<tr class="trCss"><th class=".thCss">Schedule Day</th><th class=".thCss">Delete</th></tr>';
                            $("#ScheduleDaytbl").append(Constantday);
                            document.getElementById('ScheduleDaytbl').style.display = 'block';

                            var lstScheduledays = lstTATSchedule[0].Scheduleday.split(',');

                            var dataTableday = "";
                            $.each(lstScheduledays, function(key, val) {
                                var week = '';
                                var day = '';

                                switch (val[0]) {
                                    case "1":
                                        week = "1st";
                                        break;
                                    case "2":
                                        week = "2nd";
                                        break;
                                    case "3":
                                        week = "3rd";
                                        break;
                                    case "4":
                                        week = "4th";
                                        break;
                                    case "5":
                                        week = "5th";
                                        break;

                                } switch (val[1]) {
                                    case "1":
                                        day = "Mon";
                                        break;
                                    case "2":
                                        day = "Tue";
                                        break;
                                    case "3":
                                        day = "Wed";
                                        break;
                                    case "4":
                                        day = "Thu";
                                        break;
                                    case "5":
                                        day = "Fri";
                                        break;
                                    case "6":
                                        day = "Sat";
                                        break;
                                    case "7":
                                        day = "Sun";
                                        break;

                                }
                                dataTableday += '<tr class="trCss"><td class="tdCss"><label id="lblScheduleday">' + week + '-' + day + '</label></td><td class="tdCss" align="left"  style="display:none;"><label id="lblScheduleDailyval">' + val + '</label></td><td class="tdCss"><input type="button" Class="btn1" title="Delete" onclick="DeleteWeekRow(this)" value="X" /></td></tr>';
                            });

                            $("#ScheduleDaytbl").append(dataTableday);


                            var dataTable = "";
                            $.each(lstTATSchedule[0].SlotValue, function(key, val) {
                                if (val.Batchstarttime != '-') {
                                    $("#Slottbl").empty();
                                    var Constant = '<tr class="trCss"><th class=".thCss">CutOff Time</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
                                    $("#Slottbl").append(Constant);
                                    document.getElementById('Slottbl').style.display = 'block';
                                }
                                else {
                                    $("#Slottbl").empty();
                                    var Constant = '<tr class="trCss"><th class=".thCss">CutOff Time</th><th class=".thCss">Delete</th></tr>';
                                    $("#Slottbl").append(Constant);
                                    document.getElementById('Slottbl').style.display = 'block';

                                }
                                if (val.Batchstarttime != '-') {
                                    dataTable += '<tr class="trCss"><td class="tdCss"><label id="lblCutOffTime">' + val.Cutofftime + '</label></td><td class="tdCss"><label id="lblStartTime">' + val.Batchstarttime + '</label></td><td class="tdCss"><input type="button" Class="btn1" title="Delete" onclick="DeleteRow(this)" value="X" /></td></tr>';
                                }
                                else {
                                    dataTable += '<tr class="trCss"><td class="tdCss"><label id="lblCutOffTime">' + val.Cutofftime + '</label></td><td class="tdCss"><input type="button" Class="btn1" title="Delete" onclick="DeleteRow(this)" value="X" /></td></tr>';
                                    $('#tblStartTime').hide();
                                }
                            });
                            $("#Slottbl").append(dataTable);


                            var Schedulecode = lstTATSchedule[0].Schedulecode;
                            $('#txtScheduleCode').val(Schedulecode);

                            var Schedulename = lstTATSchedule[0].Schedulename;
                            $('#txtScheduleName').val(Schedulename);

                            var Reportedon = lstTATSchedule[0].Reportedon;
                            $('#txtReportedOn').val(Reportedon);

                            var Processinghours = lstTATSchedule[0].Processinghours;
                            $('#txtProcessingHours').val(Processinghours);

                            var Processingmins = lstTATSchedule[0].Processingmins;
                            $('#txtProcessingMins').val(Processingmins);

                            var Earlyreporttime = lstTATSchedule[0].Earlyreporttime;
                            $('#txtEarlyReportTime').val(Earlyreporttime);

                            var Tatcalculationbase = lstTATSchedule[0].Tatcalculationbase;
                            $("#<%=ddlTATDate.ClientID %>").val(Tatcalculationbase);

                            var Tatprocesstype = lstTATSchedule[0].Tatprocesstype;
                            $("#<%=ddlTATProcessType.ClientID %>").val(Tatprocesstype);


                            var Tatmode = lstTATSchedule[0].Tatmode;
                            $("#<%=ddlTATMode.ClientID %>").val(Tatmode);
                            TATModeShow();

                            for (var i = 0; i < lstHolidaymaster.length; i++) {
                                var x = lstHolidaymaster[i].Holidayid;
                                var chk = 'chkSelCategory' + x;
                                $("input[id$='" + chk + "']").prop('checked', true);

                            }
                            for (var i = 1; i <= 7; i++) {
                                var chkscheduleday = 'chkScheduleday' + i;
                                $("input[id$='" + chkscheduleday + "']").prop('checked', false);
                            }

                            $.each(lstScheduledays, function(key, val) {
                                var chkscheduleday = 'chkScheduleday' + val;
                                $("input[id$='" + chkscheduleday + "']").prop('checked', true);
                            });

                            $.each(lstScheduledays, function(key, val) {
                                var chkScheduleWeek = 'chkScheduleWeek' + val;
                                $("input[id$='" + chkScheduleWeek + "']").prop('checked', true);
                            });



                            var dataTable = "";
                            $.each(lstTATSchedule[0].SlotValue, function(key, val) {
                                if (val.Batchstarttime != '-') {
                                    $("#Slottbl").empty();
                                    var Constant = '<tr class="trCss"><th class=".thCss">CutOff Interval</th><th class=".thCss">Start Time</th><th class=".thCss">Delete</th></tr>';
                                    $("#Slottbl").append(Constant);
                                    document.getElementById('Slottbl').style.display = 'block';
                                }
                                else {
                                    $("#Slottbl").empty();
                                    var Constant = '<tr class="trCss"><th class=".thCss">CutOff Interval</th><th class=".thCss">Delete</th></tr>';
                                    $("#Slottbl").append(Constant);
                                    document.getElementById('Slottbl').style.display = 'block';

                                }
                                if (val.Batchstarttime != '-') {
                                    dataTable += '<tr class="trCss"><td class="tdCss"><label id="lblCutOffTime">' + val.Cutofftime + '</label></td><td class="tdCss"><label id="lblStartTime">' + val.Batchstarttime + '</label></td><td class="tdCss"><input type="button" Class="btn1" title="Delete" onclick="DeleteRow(this)" value="X" /></td></tr>';
                                }
                                else {
                                    dataTable += '<tr class="trCss"><td class="tdCss"><label id="lblCutOffTime">' + val.Cutofftime + '</label></td><td class="tdCss"><input type="button" Class="btn1" title="Delete" onclick="DeleteRow(this)" value="X" /></td></tr>';
                                    $('#tblStartTime').hide();
                                }
                            });
                            $("#Slottbl").append(dataTable);

                        }
                        ScheduleDayHide();
                        //Dayvalidate();

                    }

                    catch (ex) {
                    }

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error EditManageSchedule");
                    return false;

                }
            });
        }

        catch (ex) {
            alert('Error EditManageSchedule');
        }
    }
   
</script>

<script type="text/javascript">
    function paging(totalRowCount) {
        var totalpages;
        pagesize = normalpagesize;
        if ((totalRowCount % pagesize) == 0) {
            totalpages = parseInt((totalRowCount / pagesize));
        }
        else {
            totalpages = parseInt((totalRowCount / pagesize)) + 1;
        }

        $('#lblTotal').text(totalpages);
        $('#hdnTotal').val(totalpages);


        $('#txtPageNo').val('');
        if (($('#hdnCurrent').val()) == 1) {
            $('#btnFirst').attr('disabled', "true");
            $('#btnPrev').attr('disabled', "true");
            if (totalpages == 1) {
                $('#btnNext').attr('disabled', "true");
                $('#btnLast').attr('disabled', "true")
                $('#btnGo').attr('disabled', "true");
            }
            else {
                $('#btnNext').removeAttr('disabled');
                $('#btnGo').removeAttr('disabled');
                $('#btnLast').removeAttr('disabled');
            }
        }
        else {
            $('#btnPrev').removeAttr('disabled');
            $('#btnFirst').removeAttr('disabled');
            var currentPage = parseInt($('#lblCurrent').html());
            if (currentPage == totalpages) {
                $('#btnNext').attr('disabled', "true");
                $('#btnLast').attr('disabled', "true");
            }
            else {
                $('#btnNext').removeAttr('disabled');
                $('#btnLast').removeAttr('disabled');
            }
        }


    }


    function btnGoFirst() {

        var pageindex = 1;
        BindNormal(normalpagesize, pageindex, orgId);
        return false;
    }

    function btnPrevious() {

        var pageindex = parseInt($('#hdnCurrent').val() == "" ? ($('#lblCurrent').html() == "" ? 1 : $('#lblCurrent').html()) : $('#hdnCurrent').val()) - 1;
        BindNormal(normalpagesize, pageindex, orgId);
        return false;
    }

    function btnGoNext() {

        var pageindex = parseInt($('#hdnCurrent').val() == "" ? ($('#lblCurrent').html() == "" ? 1 : $('#lblCurrent').html()) : $('#hdnCurrent').val()) + 1;
        BindNormal(normalpagesize, pageindex, orgId);

        return false;
    }

    function btnGoLast() {

        var pageindex = parseInt($('#hdnTotal').val())
        BindNormal(normalpagesize, pageindex, orgId);
        return false;
    }
    function btnGoPage() {

        if (checkForValues()) {
            var pageindex = $('#txtPageNo').val();
            BindNormal(normalpagesize, pageindex, orgId);
        }
        return false;
    }
    function checkForValues() {

        var pageNo = document.getElementById('txtPageNo').value;
        if (pageNo == "") {
            alert('Provide page number');
            return false;
        }
        else if (isNaN(pageNo)) {
            alert('Provide number as page number');
            return false;
        }
        if (Number(pageNo) < Number(1)) {
            alert('Provide correct page number');
            return false;
        }
        if (Number(pageNo) > Number(document.getElementById('lblTotal').innerText)) {
            alert('Provide correct page number');
            return false;
        }
        return true;
    }
    function isNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
</script>

