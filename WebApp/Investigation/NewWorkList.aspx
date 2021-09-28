<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewWorkList.aspx.cs" Inherits="Investigation_NewWorkList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>--%>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%--<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Work List From Visit To Visit</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <%--    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />--%>

    <script language="javascript" type="text/javascript">
        function validate100Visits() {
            var VisitNo1 = document.getElementById('txtFromVisit').value;
            var VisitNo2 = document.getElementById('txtToVisit').value;
            var Visitid = (VisitNo2 - VisitNo1);
            if (Visitid > 300) {
                alert('Your selected range exceeds 300 visit');
                return false;
            }
            else {
                //return true;
                LoadWorkList("0");
            }
        }
        //        function WaterMark(txtFromVisit, evt, defaultText) {
        //            if (txtFromVisit.value.length == 0 && evt.type == "blur") {
        //                txtFromVisit.style.color = "gray";
        //                txtFromVisit.value = defaultText;
        //            }
        //            if (txtFromVisit.value == defaultText && evt.type == "focus") {
        //                txtFromVisit.style.color = "black";
        //                txtFromVisit.value = "";
        //            }
        //        }

        function searchKeyPress(e) {
            //debugger;
            // look for window.event in case event isn't passed in
            if (typeof e == 'undefined' && window.event) { e = window.event; }
            if (e.keyCode == 13) {
                document.getElementById('btnSearch').click();
            }
        }
        function ChangeText() {
            if (document.getElementById('btnFinish').value == "Start Scaning") {
                document.getElementById("txtWorklistID").value = '';
            }
        }
        function fnClearWorklistType() {
            try {
                //debugger;
                if (document.getElementById("txtWorklistID").value.trim() != "") {
                    document.getElementById("ddlCultureType").value = "-1";
                }
            } catch (e) {

            }
        }

        function validateVisit() {
            //debugger;
            //            if ((document.getElementById("txtFrom").value.trim() == "") && (document.getElementById("txtFromVisit").value.trim() == "")) {
            //                alert('Provide from Date/Visit No.');
            //                document.getElementById("txtFrom").focus();
            //                return false;
            //            }
            //            if ((document.getElementById("txtTo").value.trim() == "") && (document.getElementById("txtToVisit").value.trim() == "")) {
            //                alert('Provide to Date/Visit No.');
            //                document.getElementById("txtFrom").focus();
            //                return false;
            //            }
            if (document.getElementById("hdnIsScan").value == "N") {
                if (document.getElementById("ddlCultureType").value.trim() == "-1" && document.getElementById("txtWorklistID").value.trim() == "") {
                    alert('Select WorkSheet Type or Enter Worklist ID');
                    document.getElementById("ddlCultureType").focus();
                    return false;
                }
            }
            return LoadWorkList("0");
        }

        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();
            return false;
        }
        var rowLength = 0;
        function LoadWorkList(worklistID) {
            //debugger;
            try {
                worklist = [];
                if (document.getElementById('btnFinish').value == "Start Scaning") {
                    document.getElementById('lblbarcode').style.display = 'block';
                    document.getElementById('txtBarCode').style.display = 'block';
                    document.getElementById('btnSearch').style.display = 'block';
                    if (worklistID == "0") {
                        document.getElementById("txtWorklistID").value = '';
                    }
                }
                else {
                    document.getElementById('lblbarcode').style.display = 'none';
                    document.getElementById('txtBarCode').style.display = 'none';
                    document.getElementById('btnSearch').style.display = 'none';
                }
                var deptID = 0;
                var fromVisit = document.getElementById('txtFromVisit').value == "Lab Number" ? "0" : document.getElementById('txtFromVisit').value
                var toVisit = document.getElementById('txtToVisit').value == "Lab Number" ? "0" : document.getElementById('txtToVisit').value
                var ddlClient = document.getElementById('ddlClients');
                var Client = ddlClient.options[ddlClient.selectedIndex].value;
                var gUID = "";
                var IsIncludevalues = "Y";
                var fromdate = document.getElementById('txtFrom').value;
                var todate = document.getElementById('txtTo').value;
                var drpdptid = document.getElementById('ddlDept');
                deptID = drpdptid.options[drpdptid.selectedIndex].value;
                var sType = document.getElementById('ddlCultureType');
                var searchType = sType.options[sType.selectedIndex].text;
                var OrgID = '<%=Session["OrgID"]%>';
                var LocationID = '<%=Session["LocationID"]%>';
                var LID = '<%=Session["LID"] %>';
                var ddlvisit = document.getElementById('ddlVisitType');
                var VisitType = ddlvisit.options[ddlvisit.selectedIndex].value;
                var ddlpref = document.getElementById('ddlPreference');
                var Preference = ddlpref.options[ddlpref.selectedIndex].value;
                var PriortiyID = 0;
                var InvName = document.getElementById('txtInvName').value;
                var HistoryMode = document.getElementById('ddlMode');
                var intHistoryMode = HistoryMode.options[HistoryMode.selectedIndex].value;
                var View = "View";
                var WorklistID = document.getElementById('txtWorklistID').value;
                if (WorklistID == "" && worklistID == "0") {
                    WorklistID = 0;
                }
                else if (worklistID != "0") {
                    WorklistID = worklistID;
                }
                //if ($('#tblUrinalysis tr').length == 1) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetNewWorkListFromVisitToVisit",
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'fromVisit': '" + fromVisit + "','toVisit': '" + toVisit + "','OrgID': '" + OrgID + "','deptID': '" + deptID + "','orgadd': '" + LocationID + "','clientid': '" + Client + "','LocationID': '" + LocationID + "','searchType': '" + searchType + "','InvestigationName': '" + InvName + "','PriorityID': '" + PriortiyID + "','intVisitType': '" + VisitType + "','FromDate': '" + fromdate + "','Todate': '" + todate + "','pHistoryMode': '" + intHistoryMode + "','pPageMode': '" + View + "','pLoginId': '" + LID + "','IsIncludevalues':'" + IsIncludevalues + "','Preference':'" + Preference + "','WorklistID':'" + WorklistID + "'}",
                    //data: "{ 'visitID': '" + VisitID + "','orgID': '" + OrgID + "','LocationID': '" + LocationID + "','gUID': '" + Guid + "'}",
                    dataType: "json",
                    success: fnAjaxGetNewWorkListFromVisitToVisit,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        return false;
                    }
                });
            }
            catch (e) {

            }
            document.getElementById('btnSubmit').style.display = 'block';
        }

        function fnAjaxGetNewWorkListFromVisitToVisit(result) {
            try {
                //debugger;
                var oTable;
                var WLID;
                //                var t = jQuery.noConflict();
                if (result != "[]" && result.d.length > 0) {
                    spanArray = [];
                    spanArray.push(result);
                    var sType;
                    var searchType;
                    if (document.getElementById("hdnIsScan").value == "N") {
                        sType = document.getElementById('ddlCultureType');
                        searchType = sType.options[sType.selectedIndex].text;
                        if (document.getElementById('txtWorklistID').value.trim() != "") {
                            searchType = result.d[0].SearchType;
                            var LocationName = '<%=Session["LocationName"]%>';
                            var LoginName = '<%=Session["LoginName"] %>';
                            var DateTimeFormat = '<%=Session["DateTimeFormat"] %>';
                            var worklistID = document.getElementById('txtWorklistID').value;
                            var today = new Date();
                            var worklistdatetime = today.format("dd/MM/yyyy HH:mm");
                            document.getElementById('lblPrintHeader').innerHTML = searchType + " Work Sheet";
                            document.getElementById('lblPrintLocation').innerHTML = LocationName;
                            document.getElementById('lblPrintGeneratedBy').innerHTML = LoginName;
                            document.getElementById('lblPrintWorkListID').innerHTML = worklistID;
                            document.getElementById('lblPrintDateTime').innerHTML = worklistdatetime;
                            document.getElementById('tabPrintButton').style.display = 'block';
                            document.getElementById('tblPrint').style.display = 'table';
                        }
                        else {
                            document.getElementById('tblPrint').style.display = 'none';
                            document.getElementById('tabPrintButton').style.display = 'none';
                        }
                    }
                    else {
                        searchType = result.d[0].sType = document.getElementById('ddlCultureType');
                        searchType = sType.options[sType.selectedIndex].text;
                    }
                    rowLength = result.d.length + 1;
                    $('#tblUrinalysis').hide();
                    $('#tblBloodGroup').hide();
                    $('#tblFecalysis').hide();
                    $('#tblMicroSerology').hide();
                    $('#tblWidal').hide();
                    $('#tblVDRL').hide();
                    $('#tblUrineDrug').hide();
                    $('#tblUrinePregnancyTest').hide();
                    $('#tblPapsmear').hide();
                    if (searchType == "Urinalysis") {
                        oTable = $('#tblUrinalysis').dataTable({
                            "bDestroy": true,
                            "bAutoWidth": false,
                            "bProcessing": true,
                            "aaData": result.d,
                            "sDom": '<"H"Tfr>t<ip>',

                            "bFilter": false,
                            "bInfo": false,

                            "aoColumns": [
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "Appearance" },
                    { "mDataProp": "Colour" },
                    { "mDataProp": "SpecificGravity" },
                    { "mDataProp": "pH" },
                    { "mDataProp": "Leucocytes" },
                    { "mDataProp": "Nitrite" },
                    { "mDataProp": "Protein" },
                    { "mDataProp": "Glucose" },
                    { "mDataProp": "Ketones" },
                    { "mDataProp": "Urobilinogen" },
                    { "mDataProp": "Bilirubin" },
                    { "mDataProp": "Blood" },
                    { "mDataProp": "RedBloodCellCount" },
                    { "mDataProp": "WhiteBloodCellCount" },
                    { "mDataProp": "EpithelialCellCount" },
                    { "mDataProp": "Bacteria" },
                            //{ "mDataProp": "Casts" },
                    {"mDataProp": "Others" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                            "aocolumnDefs": [{
                                "aTargets": [0],
                                "mData": null

}],
                                "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                    WLID = aData["WorkListID"];
                                    $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                    $("td:first", nRow).html(iDisplayIndex + 1);
                                    $(nRow).css('text-align', 'center');
                                    if (document.getElementById('btnFinish').value == "Start Scaning") {
                                        if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                            if (nRow.style.display == "") {
                                                $(nRow).css('display', 'none');
                                            }
                                        }
                                    }
                                },
                                "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                    if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                        nHead.getElementsByTagName('th')[20].innerHTML = "Checked By";
                                    }
                                },
                                //                            "aoColumnDefs": [
                                //                            { "sClass": "hide_column", "aTargets": [22, 23, 24, 25]}],

                                "bPaginate": false,
                                "bSort": false,
                                "bJQueryUI": true
                            });
                            if (document.getElementById('btnFinish').value == "Start Scaning") {
                                if (WLID == "0") {
                                    document.getElementById('trdatatables').style.display = 'none';
                                    $('#tblUrinalysis').hide();
                                }
                                else if (WLID == undefined) {
                                    $('#tblUrinalysis').hide();
                                    document.getElementById('trdatatables').style.display = 'none';
                                    document.getElementById('lblbarcode').style.display = 'none';
                                    document.getElementById('txtBarCode').style.display = 'none';
                                    document.getElementById('btnSearch').style.display = 'none';
                                    alert('Data not found for generate worklist');
                                }
                                else {
                                    $('#tblUrinalysis').show();
                                    document.getElementById('trdatatables').style.display = 'table';
                                    document.getElementById('btnSubmit').style.display = 'none';
                                    document.getElementById('Button1').style.display = 'none';
                                    document.getElementById('lblbarcode').style.display = 'none';
                                    document.getElementById('txtBarCode').style.display = 'none';
                                    document.getElementById('btnSearch').style.display = 'none';
                                }
                            }
                            else {
                                $('#tblUrinalysis').show();
                                document.getElementById('trdatatables').style.display = 'table';
                                document.getElementById('btnSubmit').style.display = 'none';
                                if (WLID == "0") {
                                    document.getElementById('Button1').style.display = 'block';
                                }
                                else {
                                    document.getElementById('Button1').style.display = 'none';
                                }
                            }
                            oTable.fnSetColumnVis(21, false);
                            oTable.fnSetColumnVis(22, false);
                            oTable.fnSetColumnVis(23, false);
                            oTable.fnSetColumnVis(24, false);
                            oTable.fnSetColumnVis(25, false);
                            oTable.fnSetColumnVis(26, false);
                            oTable.fnSetColumnVis(27, false);

                        }

                        else if (searchType == "ABO Group") {
                            oTable = $('#tblBloodGroup').dataTable({
                                "bDestroy": true,
                                "bAutoWidth": false,
                                "bProcessing": true,
                                "aaData": result.d,
                                "sDom": '<"H"Tfr>t<ip>',
                                "bFilter": false,
                                "bInfo": false,
                                "aoColumns": [
                             { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "AntiA" },
                    { "mDataProp": "AntiB" },
                    { "mDataProp": "AntiAB" },
                    { "mDataProp": "Rhesus" },
                    { "mDataProp": "ACell" },
                    { "mDataProp": "BCell" },
                    { "mDataProp": "OCell" },
                    { "mDataProp": "ABO" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                                "aocolumnDefs": [{
                                    "aTargets": [0],
                                    "mData": null
}],

                                    "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                        WLID = aData["WorkListID"];
                                        $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                        $("td:first", nRow).html(iDisplayIndex + 1);
                                        $(nRow).css('text-align', 'center');
                                        if (document.getElementById('btnFinish').value == "Start Scaning") {
                                            if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                if (nRow.style.display == "") {
                                                    $(nRow).css('display', 'none');
                                                }
                                            }
                                        }
                                    },
                                    "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                        if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                            nHead.getElementsByTagName('th')[10].innerHTML = "Checked By";
                                        }
                                    },
                                    //                            "aoColumnDefs": [
                                    //                            { "sClass": "hide_column", "aTargets": [12, 13, 14, 15]}],

                                    "bPaginate": false,
                                    "bSort": false,
                                    "bJQueryUI": true

                                });

                                if (document.getElementById('btnFinish').value == "Start Scaning") {
                                    if (WLID == "0") {
                                        document.getElementById('trdatatables').style.display = 'none';
                                        $('#tblBloodGroup').hide();
                                    }
                                    else if (WLID == undefined) {
                                        $('#tblBloodGroup').hide();
                                        document.getElementById('trdatatables').style.display = 'none';
                                        document.getElementById('lblbarcode').style.display = 'none';
                                        document.getElementById('txtBarCode').style.display = 'none';
                                        document.getElementById('btnSearch').style.display = 'none';
                                        alert('Data not found for generate worklist');
                                    }
                                    else {
                                        $('#tblBloodGroup').show();
                                        document.getElementById('trdatatables').style.display = 'table';
                                        document.getElementById('btnSubmit').style.display = 'none';
                                        document.getElementById('Button1').style.display = 'none';
                                        document.getElementById('lblbarcode').style.display = 'none';
                                        document.getElementById('txtBarCode').style.display = 'none';
                                        document.getElementById('btnSearch').style.display = 'none';
                                    }
                                }
                                else {
                                    $('#tblBloodGroup').show();
                                    document.getElementById('trdatatables').style.display = 'table';
                                    document.getElementById('btnSubmit').style.display = 'none';
                                    if (WLID == "0") {
                                        document.getElementById('Button1').style.display = 'block';
                                    }
                                    else {
                                        document.getElementById('Button1').style.display = 'none';
                                    }
                                }
                                oTable.fnSetColumnVis(12, false);
                                oTable.fnSetColumnVis(13, false);
                                oTable.fnSetColumnVis(14, false);
                                oTable.fnSetColumnVis(15, false);
                                oTable.fnSetColumnVis(16, false);
                            }
                            else if (searchType == "Fecalysis") {
                                oTable = $('#tblFecalysis').dataTable({
                                    "bDestroy": true,
                                    "bAutoWidth": false,
                                    "bProcessing": true,
                                    "aaData": result.d,
                                    "sDom": '<"H"Tfr>t<ip>',
                                    "bFilter": false,
                                    "bInfo": false,
                                    "aoColumns": [
                             { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "Colour" },
                    { "mDataProp": "Consistency" },
                    { "mDataProp": "MucusStrands" },
                    { "mDataProp": "YeastCells" },
                    { "mDataProp": "FatGlobules" },
                    { "mDataProp": "Protozoa" },
                    { "mDataProp": "Flagellates" },
                    { "mDataProp": "Ciliates" },
                    { "mDataProp": "Parasites" },
                    { "mDataProp": "LeukocytesPusCell" },
                    { "mDataProp": "RedBloodCells" },
                    { "mDataProp": "UndigestedParticles" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                                    "aocolumnDefs": [{
                                        "aTargets": [0],
                                        "mData": null
}],

                                        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                            WLID = aData["WorkListID"];
                                            $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                            $("td:first", nRow).html(iDisplayIndex + 1);
                                            $(nRow).css('text-align', 'center');
                                            if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                    if (nRow.style.display == "") {
                                                        $(nRow).css('display', 'none');
                                                    }
                                                }
                                            }
                                        },
                                        "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                            if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                                nHead.getElementsByTagName('th')[14].innerHTML = "Checked By";
                                            }
                                        },
                                        //                            "aoColumnDefs": [
                                        //                            { "sClass": "hide_column", "aTargets": [16, 17, 18, 19]}],

                                        "bPaginate": false,
                                        "bSort": false,
                                        "bJQueryUI": true

                                    });
                                    if (document.getElementById('btnFinish').value == "Start Scaning") {
                                        if (WLID == "0") {
                                            document.getElementById('trdatatables').style.display = 'none';
                                            $('#tblFecalysis').hide();
                                        }
                                        else if (WLID == undefined) {
                                            $('#tblFecalysis').hide();
                                            document.getElementById('trdatatables').style.display = 'none';
                                            document.getElementById('lblbarcode').style.display = 'none';
                                            document.getElementById('txtBarCode').style.display = 'none';
                                            document.getElementById('btnSearch').style.display = 'none';
                                            alert('Data not found for generate worklist');
                                        }
                                        else {
                                            $('#tblFecalysis').show();
                                            document.getElementById('trdatatables').style.display = 'table';
                                            document.getElementById('btnSubmit').style.display = 'none';
                                            document.getElementById('Button1').style.display = 'none';
                                            document.getElementById('lblbarcode').style.display = 'none';
                                            document.getElementById('txtBarCode').style.display = 'none';
                                            document.getElementById('btnSearch').style.display = 'none';
                                        }
                                    }
                                    else {
                                        $('#tblFecalysis').show();
                                        document.getElementById('trdatatables').style.display = 'table';
                                        document.getElementById('btnSubmit').style.display = 'none';
                                        if (WLID == "0") {
                                            document.getElementById('Button1').style.display = 'block';
                                        }
                                        else {
                                            document.getElementById('Button1').style.display = 'none';
                                        }
                                    }
                                    oTable.fnSetColumnVis(17, false);
                                    oTable.fnSetColumnVis(18, false);
                                    oTable.fnSetColumnVis(19, false);
                                    oTable.fnSetColumnVis(19, false);
                                    oTable.fnSetColumnVis(20, false);
                                }
                                else if (searchType == "Micro Serology") {
                                    oTable = $('#tblMicroSerology').dataTable({
                                        "bDestroy": true,
                                        "bAutoWidth": false,
                                        "bProcessing": true,
                                        "aaData": result.d,
                                        "sDom": '<"H"Tfr>t<ip>',
                                        "bFilter": false,
                                        "bInfo": false,
                                        "aoColumns": [
                            { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "ChlamydiaIgG" },
                    { "mDataProp": "ChlamydiaIgM" },
                    { "mDataProp": "AntiNuclearFactorANF" },
                    { "mDataProp": "AntistreptolysinOTitreASOT" },
                    { "mDataProp": "DengueIgG" },
                    { "mDataProp": "DengueIgM" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                                        "aocolumnDefs": [{
                                            "aTargets": [0],
                                            "mData": null
}],

                                            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                                WLID = aData["WorkListID"];
                                                $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                                $("td:first", nRow).html(iDisplayIndex + 1);
                                                $(nRow).css('text-align', 'center');
                                                if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                    if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                        if (nRow.style.display == "") {
                                                            $(nRow).css('display', 'none');
                                                        }
                                                    }
                                                }
                                            },
                                            "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                                if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                                    nHead.getElementsByTagName('th')[9].innerHTML = "Checked By";
                                                }
                                            },
                                            //                            "aoColumnDefs": [
                                            //                            { "sClass": "hide_column", "aTargets": [16, 17, 18, 19]}],

                                            "bPaginate": false,
                                            "bSort": false,
                                            "bJQueryUI": true

                                        });
                                        if (document.getElementById('btnFinish').value == "Start Scaning") {
                                            if (WLID == "0") {
                                                document.getElementById('trdatatables').style.display = 'none';
                                                $('#tblMicroSerology').hide();
                                            }
                                            else if (WLID == undefined) {
                                                $('#tblMicroSerology').hide();
                                                document.getElementById('trdatatables').style.display = 'none';
                                                document.getElementById('lblbarcode').style.display = 'none';
                                                document.getElementById('txtBarCode').style.display = 'none';
                                                document.getElementById('btnSearch').style.display = 'none';
                                                alert('Data not found for generate worklist');
                                            }
                                            else {
                                                $('#tblMicroSerology').show();
                                                document.getElementById('trdatatables').style.display = 'block';
                                                document.getElementById('btnSubmit').style.display = 'none';
                                                document.getElementById('Button1').style.display = 'none';
                                                document.getElementById('lblbarcode').style.display = 'none';
                                                document.getElementById('txtBarCode').style.display = 'none';
                                                document.getElementById('btnSearch').style.display = 'none';
                                            }
                                        }
                                        else {
                                            $('#tblMicroSerology').show();
                                            document.getElementById('trdatatables').style.display = 'table';
                                            document.getElementById('btnSubmit').style.display = 'none';
                                            if (WLID == "0") {
                                                document.getElementById('Button1').style.display = 'block';
                                            }
                                            else {
                                                document.getElementById('Button1').style.display = 'none';
                                            }
                                        }
                                        oTable.fnSetColumnVis(10, false);
                                        oTable.fnSetColumnVis(11, false);
                                        oTable.fnSetColumnVis(12, false);
                                        oTable.fnSetColumnVis(13, false);
                                        oTable.fnSetColumnVis(14, false);
                                    }
                                    else if (searchType == "Widal & Weil Felix") {
                                        oTable = $('#tblWidal').dataTable({
                                            "bDestroy": true,
                                            "bAutoWidth": false,
                                            "bProcessing": true,
                                            "aaData": result.d,
                                            "sDom": '<"H"Tfr>t<ip>',
                                            "bFilter": false,
                                            "bInfo": false,
                                            "aoColumns": [
                             { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "STyphiTO" },
                    { "mDataProp": "SParatyphiAO" },
                    { "mDataProp": "SParatyphiBO" },
                    { "mDataProp": "SParatyphiCO" },
                    { "mDataProp": "StyphiTH" },
                    { "mDataProp": "SParatyphiAH" },
                    { "mDataProp": "SParatyphiBH" },
                    { "mDataProp": "SParatyphiCH" },
                    { "mDataProp": "ProteusOXK" },
                    { "mDataProp": "ProteusOX2" },
                    { "mDataProp": "ProteusOX19" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                                            "aocolumnDefs": [{
                                                "aTargets": [0],
                                                "mData": null
}],

                                                "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                                    WLID = aData["WorkListID"];
                                                    $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                                    $("td:first", nRow).html(iDisplayIndex + 1);
                                                    $(nRow).css('text-align', 'center');
                                                    if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                        if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                            if (nRow.style.display == "") {
                                                                $(nRow).css('display', 'none');
                                                            }
                                                        }
                                                    }
                                                },
                                                "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                                    if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                                        nHead.getElementsByTagName('th')[13].innerHTML = "Checked By";
                                                    }
                                                },
                                                //                            "aoColumnDefs": [
                                                //                            { "sClass": "hide_column", "aTargets": [15, 16, 17, 18]}],

                                                "bPaginate": false,
                                                "bSort": false,
                                                "bJQueryUI": true

                                            });
                                            if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                if (WLID == "0") {
                                                    document.getElementById('trdatatables').style.display = 'none';
                                                    $('#tblWidal').hide();
                                                }
                                                else if (WLID == undefined) {
                                                    $('#tblWidal').hide();
                                                    document.getElementById('trdatatables').style.display = 'none';
                                                    document.getElementById('lblbarcode').style.display = 'none';
                                                    document.getElementById('txtBarCode').style.display = 'none';
                                                    document.getElementById('btnSearch').style.display = 'none';
                                                    alert('Data not found for generate worklist');
                                                }
                                                else {
                                                    $('#tblWidal').show();
                                                    document.getElementById('trdatatables').style.display = 'table';
                                                    document.getElementById('btnSubmit').style.display = 'none';
                                                    document.getElementById('Button1').style.display = 'none';
                                                    document.getElementById('lblbarcode').style.display = 'none';
                                                    document.getElementById('txtBarCode').style.display = 'none';
                                                    document.getElementById('btnSearch').style.display = 'none';
                                                }
                                            }
                                            else {
                                                $('#tblWidal').show();
                                                document.getElementById('trdatatables').style.display = 'table';
                                                document.getElementById('btnSubmit').style.display = 'none';
                                                if (WLID == "0") {
                                                    document.getElementById('Button1').style.display = 'block';
                                                }
                                                else {
                                                    document.getElementById('Button1').style.display = 'none';
                                                }
                                            }
                                            oTable.fnSetColumnVis(15, false);
                                            oTable.fnSetColumnVis(16, false);
                                            oTable.fnSetColumnVis(17, false);
                                            oTable.fnSetColumnVis(18, false);
                                        }
                                        else if (searchType == "VDRL (RPR)") {
                                            oTable = $('#tblVDRL').dataTable({
                                                "bDestroy": true,
                                                "bAutoWidth": false,
                                                "bProcessing": true,
                                                "aaData": result.d,
                                                "sDom": '<"H"Tfr>t<ip>',
                                                "bFilter": false,
                                                "bInfo": false,
                                                "aoColumns": [
                   { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "VDRL" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                                                "aocolumnDefs": [{
                                                    "aTargets": [0],
                                                    "mData": null

}],

                                                    "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                                        WLID = aData["WorkListID"];
                                                        $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                                        $("td:first", nRow).html(iDisplayIndex + 1);
                                                        $(nRow).css('text-align', 'center');
                                                        if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                            if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                                if (nRow.style.display == "") {
                                                                    $(nRow).css('display', 'none');
                                                                }
                                                            }
                                                        }
                                                    },
                                                    "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                                        if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                                            nHead.getElementsByTagName('th')[3].innerHTML = "Checked By";
                                                        }
                                                    },
                                                    //                            "aoColumnDefs": [
                                                    //                            { "sClass": "hide_column", "aTargets": [5, 6, 7, 8]}],

                                                    "bPaginate": false,
                                                    "bSort": false,
                                                    "bJQueryUI": true

                                                });
                                                if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                    if (WLID == "0") {
                                                        document.getElementById('trdatatables').style.display = 'none';
                                                        $('#tblVDRL').hide();
                                                    }
                                                    else if (WLID == undefined) {
                                                        $('#tblVDRL').hide();
                                                        document.getElementById('trdatatables').style.display = 'none';
                                                        document.getElementById('lblbarcode').style.display = 'none';
                                                        document.getElementById('txtBarCode').style.display = 'none';
                                                        document.getElementById('btnSearch').style.display = 'none';
                                                        alert('Data not found for generate worklist');
                                                    }
                                                    else {
                                                        $('#tblVDRL').show();
                                                        document.getElementById('trdatatables').style.display = 'table';
                                                        document.getElementById('btnSubmit').style.display = 'none';
                                                        document.getElementById('Button1').style.display = 'none';
                                                        document.getElementById('lblbarcode').style.display = 'none';
                                                        document.getElementById('txtBarCode').style.display = 'none';
                                                        document.getElementById('btnSearch').style.display = 'none';
                                                    }
                                                }
                                                else {
                                                    $('#tblVDRL').show();
                                                    document.getElementById('trdatatables').style.display = 'table';
                                                    document.getElementById('btnSubmit').style.display = 'none';
                                                    if (WLID == "0") {
                                                        document.getElementById('Button1').style.display = 'block';
                                                    }
                                                    else {
                                                        document.getElementById('Button1').style.display = 'none';
                                                    }
                                                }
                                                oTable.fnSetColumnVis(5, false);
                                                oTable.fnSetColumnVis(6, false);
                                                oTable.fnSetColumnVis(7, false);
                                                oTable.fnSetColumnVis(8, false);
                                                oTable.fnSetColumnVis(9, false);


                                            }
                                            else if (searchType == "Urine Drug") {
                                                //debugger;
                                                oTable = $('#tblUrineDrug').dataTable({
                                                    "bDestroy": true,
                                                    "bAutoWidth": false,
                                                    "bProcessing": true,
                                                    "aaData": result.d,
                                                    "sDom": '<"H"Tfr>t<ip>',
                                                    "bFilter": false,
                                                    "bInfo": false,
                                                    "aoColumns": [
                            { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "Amphetamine" },
                    { "mDataProp": "Cannabinoids" },
                    { "mDataProp": "COCCocaine" },
                    { "mDataProp": "Ketamine" },
                    { "mDataProp": "Opiates" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                                                    "aocolumnDefs": [{
                                                        "aTargets": [0],
                                                        "mData": null

}],

                                                        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                                            WLID = aData["WorkListID"];
                                                            $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                                            $("td:first", nRow).html(iDisplayIndex + 1);
                                                            $(nRow).css('text-align', 'center');
                                                            if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                                if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                                    if (nRow.style.display == "") {
                                                                        $(nRow).css('display', 'none');
                                                                    }
                                                                }
                                                            }
                                                        },
                                                        "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                                            if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                                                nHead.getElementsByTagName('th')[7].innerHTML = "Checked By";
                                                            }
                                                        },
                                                        //                            "aoColumnDefs": [
                                                        //                            { "sClass": "hide_column", "aTargets": [15, 16, 17, 18]}],

                                                        "bPaginate": false,
                                                        "bSort": false,
                                                        "bJQueryUI": true

                                                    });

                                                    if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                        if (WLID == "0") {
                                                            document.getElementById('trdatatables').style.display = 'none';
                                                            $('#tblUrineDrug').hide();
                                                        }
                                                        else if (WLID == undefined) {
                                                            $('#tblUrineDrug').hide();
                                                            document.getElementById('trdatatables').style.display = 'none';
                                                            document.getElementById('lblbarcode').style.display = 'none';
                                                            document.getElementById('txtBarCode').style.display = 'none';
                                                            document.getElementById('btnSearch').style.display = 'none';
                                                            alert('Data not found for generate worklist');
                                                        }
                                                        else {
                                                            $('#tblUrineDrug').show();
                                                            document.getElementById('trdatatables').style.display = 'table';
                                                            document.getElementById('btnSubmit').style.display = 'none';
                                                            document.getElementById('Button1').style.display = 'none';
                                                            document.getElementById('lblbarcode').style.display = 'none';
                                                            document.getElementById('txtBarCode').style.display = 'none';
                                                            document.getElementById('btnSearch').style.display = 'none';
                                                        }
                                                    }
                                                    else {
                                                        $('#tblUrineDrug').show();
                                                        document.getElementById('trdatatables').style.display = 'table';
                                                        document.getElementById('btnSubmit').style.display = 'none';
                                                        if (WLID == "0") {
                                                            document.getElementById('Button1').style.display = 'block';
                                                        }
                                                        else {
                                                            document.getElementById('Button1').style.display = 'none';
                                                        }
                                                    }
                                                    oTable.fnSetColumnVis(9, false);
                                                    oTable.fnSetColumnVis(10, false);
                                                    oTable.fnSetColumnVis(11, false);
                                                    oTable.fnSetColumnVis(12, false);
                                                }
                                                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                else if (searchType == "PAP Smear") {
                                                    oTable = $('#tblPapsmear').dataTable({
                                                        "bDestroy": true,
                                                        "bAutoWidth": false,
                                                        "bProcessing": true,
                                                        "aaData": result.d,
                                                        "sDom": '<"H"Tfr>t<ip>',
                                                        "bFilter": false,
                                                        "bInfo": false,
                                                        "aoColumns": [
                             { "mDataProp": "SeqNo" },
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "CYTOREFNO" },
                    { "mDataProp": "LMPDATE" },
                    { "mDataProp": "SSPECI" },
                    { "mDataProp": "SPECADEQ" },
                    { "mDataProp": "ENDOCELL" },
                    { "mDataProp": "HORMON" },
                    { "mDataProp": "CYTOMICROP" },
                    { "mDataProp": "INFLAM" },
                    { "mDataProp": "MICROINFECT" },
                    { "mDataProp": "TRICHO_CAND" },
                    { "mDataProp": "I_D" },
                    { "mDataProp": "RCMMD" },
                    { "mDataProp": "Summary" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],
                                                        "aocolumnDefs": [{
                                                            "aTargets": [0],
                                                            "mData": null

}],

                                                            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                                                WLID = aData["WorkListID"];
                                                                $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                                                $("td:first", nRow).html(iDisplayIndex + 1);
                                                                $(nRow).css('text-align', 'center');
                                                                if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                                    if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                                        if (nRow.style.display == "") {
                                                                            $(nRow).css('display', 'none');
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                                                if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                                                    nHead.getElementsByTagName('th')[13].innerHTML = "Checked By";
                                                                }
                                                            },
                                                            //                            "aoColumnDefs": [
                                                            //                            { "sClass": "hide_column", "aTargets": [15, 16, 17, 18]}],

                                                            "bPaginate": false,
                                                            "bSort": false,
                                                            "bJQueryUI": true

                                                        });
                                                        if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                            if (WLID == "0") {
                                                                document.getElementById('trdatatables').style.display = 'none';
                                                                $('#tblPapsmear').hide();
                                                            }
                                                            else if (WLID == undefined) {
                                                                $('#tblPapsmear').hide();
                                                                document.getElementById('trdatatables').style.display = 'none';
                                                                document.getElementById('lblbarcode').style.display = 'none';
                                                                document.getElementById('txtBarCode').style.display = 'none';
                                                                document.getElementById('btnSearch').style.display = 'none';
                                                                alert('Data not found for generate worklist');
                                                            }
                                                            else {
                                                                $('#tblPapsmear').show();
                                                                document.getElementById('trdatatables').style.display = 'table';
                                                                document.getElementById('btnSubmit').style.display = 'none';
                                                                document.getElementById('Button1').style.display = 'none';
                                                                document.getElementById('lblbarcode').style.display = 'none';
                                                                document.getElementById('txtBarCode').style.display = 'none';
                                                                document.getElementById('btnSearch').style.display = 'none';
                                                            }
                                                        }
                                                        else {
                                                            $('#tblPapsmear').show();
                                                            document.getElementById('trdatatables').style.display = 'table';
                                                            document.getElementById('btnSubmit').style.display = 'none';
                                                            if (WLID == "0") {
                                                                document.getElementById('Button1').style.display = 'block';
                                                            }
                                                            else {
                                                                document.getElementById('Button1').style.display = 'none';
                                                            }
                                                        }
                                                        //oTable.fnSetColumnVis(15, false);
                                                        //oTable.fnSetColumnVis(16, false);
                                                        oTable.fnSetColumnVis(17, false);
                                                        oTable.fnSetColumnVis(18, false);
                                                        oTable.fnSetColumnVis(19, false);
                                                        oTable.fnSetColumnVis(20, false);
                                                        oTable.fnSetColumnVis(21, false);
                                                    }
                                                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                    else if (searchType == "Urine Pregnancy Test") {
                                                        oTable = $('#tblUrinePregnancyTest').dataTable({
                                                            "bDestroy": true,
                                                            "bAutoWidth": false,
                                                            "bProcessing": true,
                                                            "aaData": result.d,
                                                            "sDom": '<"H"Tfr>t<ip>',
                                                            "bFilter": false,
                                                            "bInfo": false,
                                                            "aoColumns": [
                    { "mDataProp": "ExternalVisitId" },
                    { "mDataProp": "Name" },
                    { "mDataProp": "UrinePregnancyTest" },
                    { "mDataProp": "Performed" },
                    { "mDataProp": "Entered" },
                    { "mDataProp": "SeqNo" },
                    { "mDataProp": "AccessionNumber" },
                    { "mDataProp": "PatientVisitId" },
                    { "mDataProp": "WorkListID"}],

                                                            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                                                WLID = aData["WorkListID"];
                                                                $(nRow).attr("id", 'rowNum' + aData["ExternalVisitId"]);
                                                                $("td:first", nRow).html(iDisplayIndex + 1);
                                                                $(nRow).css('text-align', 'center');
                                                                if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                                    if (WLID == "0") {// && WLID == null && WLID == "" && WLID == undefined) {
                                                                        if (nRow.style.display == "") {
                                                                            $(nRow).css('display', 'none');
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            "fnHeaderCallback": function(nHead, aData, iStart, iEnd, aiDisplay) {
                                                                if (document.getElementById("hdnIsScan").value == "N" && document.getElementById('txtWorklistID').value.trim() != "" && document.getElementById('ddlCultureType').value.trim() == "-1") {
                                                                    nHead.getElementsByTagName('th')[3].innerHTML = "Checked By";
                                                                }
                                                            },
                                                            //                            "aoColumnDefs": [
                                                            //                            { "sClass": "hide_column", "aTargets": [5, 6, 7, 8]}],

                                                            "bPaginate": false,
                                                            "bSort": false,
                                                            "bJQueryUI": true

                                                        });
                                                        if (document.getElementById('btnFinish').value == "Start Scaning") {
                                                            if (WLID == "0") {
                                                                document.getElementById('trdatatables').style.display = 'none';
                                                                $('#tblUrinePregnancyTest').hide();
                                                            }
                                                            else if (WLID == undefined) {
                                                                $('#tblUrinePregnancyTest').hide();
                                                                document.getElementById('trdatatables').style.display = 'none';
                                                                document.getElementById('lblbarcode').style.display = 'none';
                                                                document.getElementById('txtBarCode').style.display = 'none';
                                                                document.getElementById('btnSearch').style.display = 'none';
                                                                alert('Data not found for generate worklist');
                                                            }
                                                            else {
                                                                $('#tblUrinePregnancyTest').show();
                                                                document.getElementById('trdatatables').style.display = 'table';
                                                                document.getElementById('btnSubmit').style.display = 'none';
                                                                document.getElementById('Button1').style.display = 'none';
                                                                document.getElementById('lblbarcode').style.display = 'none';
                                                                document.getElementById('txtBarCode').style.display = 'none';
                                                                document.getElementById('btnSearch').style.display = 'none';
                                                            }
                                                        }
                                                        else {
                                                            $('#tblUrinePregnancyTest').show();
                                                            document.getElementById('trdatatables').style.display = 'table';
                                                            document.getElementById('btnSubmit').style.display = 'none';
                                                            if (WLID == "0") {
                                                                document.getElementById('Button1').style.display = 'block';
                                                            }
                                                            else {
                                                                document.getElementById('Button1').style.display = 'none';
                                                            }
                                                        }
                                                        oTable.fnSetColumnVis(5, false);
                                                        oTable.fnSetColumnVis(6, false);
                                                        oTable.fnSetColumnVis(7, false);
                                                        oTable.fnSetColumnVis(8, false);
                                                    }
                                                }
                                                else {
                                                    alert("No Matching records found");
                                                    document.getElementById('tabPrintButton').style.display = 'none';
                                                    document.getElementById('trdatatables').style.display = 'none';
                                                    document.getElementById('Button1').style.display = 'none';
                                                    document.getElementById('tblPrint').style.display = 'none';
                                                    document.getElementById('lblbarcode').style.display = 'none';
                                                    document.getElementById('txtBarCode').style.display = 'none';
                                                    document.getElementById('btnSearch').style.display = 'none';
                                                }
                                            }
                                            catch (e) {
                                                //alert(0);
                                            }
                                        }

                                        function ValidateSamples() {
                                            //debugger;
                                            var rowid;
                                            //var txtBatchNo = document.getElementById('txtBatchNo').value.trim();
                                            var txtSampleBarcode = document.getElementById('txtBarCode').value.trim();
                                            if (txtSampleBarcode == "") {
                                                alert('Provide the Barcode!!!');
                                                return false;
                                            }
                                            if (txtSampleBarcode.length > 9) {
                                                txtSampleBarcode = txtSampleBarcode.substring(0, txtSampleBarcode.length - 2);
                                            }
                                            //var rowindex = $('#tblUrinalysis').dataTable().fnGetData().length;
                                            var TxtBarCode = $('#txtBarCode').val();
                                            TxtBarCode = txtSampleBarcode;
                                            if (TxtBarCode.length > 9) {
                                                TxtBarCode = TxtBarCode.substring(0, TxtBarCode.length - 2);
                                            }


                                            var sType = document.getElementById('ddlCultureType');
                                            var searchType = sType.options[sType.selectedIndex].text;
                                            var table;
                                            var seqNoIndex;
                                            if (searchType == "Urinalysis") {
                                                table = $('#tblUrinalysis').dataTable();
                                                seqNoIndex = 22;
                                            }
                                            else if (searchType == "ABO Group") {
                                                table = $('#tblBloodGroup').dataTable();
                                                seqNoIndex = 13;
                                            }
                                            else if (searchType == "Fecalysis") {
                                                table = $('#tblFecalysis').dataTable();
                                                seqNoIndex = 16;
                                            }
                                            else if (searchType == "Micro Serology") {
                                                table = $('#tblMicroSerology').dataTable();
                                                seqNoIndex = 11;
                                            }
                                            else if (searchType == "Widal & Weil Felix") {
                                                table = $('#tblWidal').dataTable();
                                                seqNoIndex = 15;
                                            }
                                            else if (searchType == "VDRL (RPR)") {
                                                table = $('#tblVDRL').dataTable();
                                                seqNoIndex = 6;
                                            }
                                            else if (searchType == "Urine Drug") {
                                                table = $('#tblUrineDrug').dataTable();
                                                seqNoIndex = 10;
                                            }
                                            else if (searchType == "Urine Pregnancy Test") {
                                                table = $('#tblUrinePregnancyTest').dataTable();
                                                seqNoIndex = 5;
                                            }
                                            else if (searchType == "PAP Smear") {
                                                table = $('#tblPapsmear').dataTable();
                                                seqNoIndex = 18;
                                            }
                                            //var table = $('#tblUrinalysis').dataTable();
                                            var search = "rowNum" + TxtBarCode;  //"rowNum456789123";

                                            var childObj = document.getElementById(search);
                                            if (childObj != null && childObj != "" && childObj != "undefined") {
                                                var childindexes = table.fnGetPosition(childObj);
                                                var rowData = table.fnGetData(childindexes);
                                                var AccesNo = rowData["AccessionNumber"];
                                                var visitid = rowData["PatientVisitId"];
                                                var hdnRowNo = document.getElementById('hdnRowNo').value;
                                                var lstIsAlreadyAdded = $.grep(worklist, function(v) {
                                                    return (v.PatientVisitId == visitid);
                                                });
                                                if (lstIsAlreadyAdded.length == 0) {
                                                    hdnRowNo = Number(hdnRowNo) + 1;
                                                    document.getElementById('hdnRowNo').value = hdnRowNo;
                                                    saveworklist(TxtBarCode, visitid, AccesNo, hdnRowNo);

                                                    table.fnUpdate(hdnRowNo, childindexes, seqNoIndex, true, true);   // seqNoIndex - Represents 20th column(seqno Column) in datatable
                                                }
                                                else {
                                                    alert("This Sample already added");
                                                }
                                                //table.datatable(tr:nth-child(even){'background-color', 'yellow'};
                                                //table.tr.hdnRowNo{'background-color', 'yellow'};
                                                //$(childindexes).css('background-color', 'LightBlue');
                                                //table.childindexes.css
                                                //css('background-color', '#6D6968');
                                                table.fnSort([[seqNoIndex, 'asc']]);
                                                //$(search).hide();

                                                childObj.style.backgroundColor = 'Orange';
                                                childObj.style.display = 'table-row';
                                                document.getElementById('trdatatables').style.display = 'table';
                                                table.show();
                                            }
                                            else {
                                                alert('BarCode is not in the List');
                                            }
                                            document.getElementById('txtBarCode').value = '';
                                            document.getElementById('txtBarCode').focus();
                                            document.getElementById('txtBarCode').select();
                                            table.fnDraw();
                                        }
                                        var worklist = [];
                                        function saveworklist11() {
                                            //debugger;
                                            var lstpatientinvestigation = [];
                                            var sType = document.getElementById('ddlCultureType');
                                            var searchType = sType.options[sType.selectedIndex].text;
                                            var table;
                                            var seqNoIndex;
                                            if (searchType == "Urinalysis") {
                                                $("#tblUrinalysis tbody tr").each(function() {
                                                    var oTable = $("#tblUrinalysis").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "ABO Group") {
                                                debugger;
                                                $("#tblBloodGroup tbody tr").each(function() {
                                                    var oTable = $("#tblBloodGroup").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "Fecalysis") {
                                                $("#tblFecalysis tbody tr").each(function() {
                                                    var oTable = $("#tblFecalysis").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "Micro Serology") {
                                                $("#tblMicroSerology tbody tr").each(function() {
                                                    var oTable = $("#tblMicroSerology").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "Widal & Weil Felix") {
                                                $("#tblWidal tbody tr").each(function() {
                                                    var oTable = $("#tblWidal").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "PAP Smear") {
                                                $("#tblPapsmear tbody tr").each(function() {
                                                    var oTable = $("#tblPapsmear").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "VDRL (RPR)") {
                                                $("#tblVDRL tbody tr").each(function() {
                                                    var oTable = $("#tblVDRL").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "Urine Drug") {
                                                table = $('#tblUrineDrug').dataTable();
                                                seqNoIndex = 9;
                                                $("#tblUrineDrug tbody tr").each(function() {
                                                    var oTable = $("#tblUrineDrug").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        //AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            else if (searchType == "Urine Pregnancy Test") {
                                                $("#tblUrinePregnancyTest tbody tr").each(function() {
                                                    var oTable = $("#tblUrinePregnancyTest").dataTable();
                                                    var pos = oTable.fnGetPosition(this);
                                                    var rowData = oTable.fnGetData(pos);
                                                    worklist.push({
                                                        ExternalVisitId: rowData["ExternalVisitId"],
                                                        PatientVisitId: rowData["PatientVisitId"],
                                                        AccessionNumber: rowData["AccessionNumber"],
                                                        SeqNo: rowData["SeqNo"]
                                                    });
                                                });
                                            }
                                            lstpatientinvestigation = JSON.stringify(worklist);
                                            if (worklist.length > 0) {
                                                $('#hdnLstGrp').val(JSON.stringify(worklist));
                                            }

                                            document.getElementById('btnSubmit').style.display = 'none';
                                        }
                                        function clrhdnRowNo() {
                                            document.getElementById('hdnRowNo').value = '';
                                        }
                                        var worklist = [];
                                        function saveworklist(TxtBarCode, visitid, AccesNo, hdnRowNo) {
                                            //debugger;
                                            var lstIsAlreadyAdded = $.grep(worklist, function(v) {
                                                return (v.PatientVisitId == visitid);
                                            });
                                            if (lstIsAlreadyAdded.length == 0) {
                                                worklist.push({
                                                    ExternalVisitId: TxtBarCode,
                                                    PatientVisitId: visitid,
                                                    AccessionNumber: AccesNo,
                                                    SeqNo: hdnRowNo
                                                });
                                                $('#hdnLstGrp').val(JSON.stringify(worklist));
                                            }
                                            else {
                                                alert("This Sample already added");
                                            }
                                        }
    </script>

    <style type="text/css">
        .hide_column
        {
            display: none;
        }
        .style2
        {
            width: 223px;
        }
        .watermarked
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            color: Gray;
        }
        #btnSearch
        {
            width: 28px;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table cellpadding="4" class="dataheaderInvCtrl searchPanel w-100p">
            <tr class="h-25" style="display: none;">
                <td class="a-right w-20">
                    From Number
                </td>
                <td class="w-50p">
                    <asp:TextBox ID="txtFromVisit" runat="server" CssClass="small"></asp:TextBox>
                    <ajc:TextBoxWatermarkExtender ID="Watermark" runat="server" TargetControlID="txtFromVisit"
                        WatermarkCssClass="watermarked" />
                </td>
                <td class="a-right">
                    To Number
                </td>
                <td class="w-20p">
                    <asp:TextBox ID="txtToVisit" runat="server" CssClass="small"></asp:TextBox>
                    <ajc:TextBoxWatermarkExtender ID="Watermark1" runat="server" TargetControlID="txtToVisit"
                        WatermarkCssClass="watermarked" />
                </td>
                <td class="a-left w-50p">
                    <table>
                        <tr style="display: none">
                            <td class="a-left w-30p">
                                <td class="w-15p a-right">
                                    Visit Type
                                </td>
                                <td class="w-30p a-left">
                                    <asp:DropDownList ID="ddlVisitType" runat="server" CssClass="ddlsmall">
                                        <asp:ListItem Value="-1" Text="Both" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="OP"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="IP"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="display: none">
                <td class="w-20p a-right">
                    From
                </td>
                <td>
                    <table class="w-100p">
                        <tr class="defaultfontcolor">
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="small" TabIndex="4"></asp:TextBox>
                                <a id="txtFromFormat" runat="server">
                                    <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date" class="v-middle" /></a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="w-20p a-right">
                    To
                </td>
                <td>
                    <table class="w-100p">
                        <tr class="defaultfontcolor">
                            <td class="a-left w-20p">
                                <asp:TextBox ID="txtTo" runat="server" CssClass="small" TabIndex="4"></asp:TextBox>
                            </td>
                            <td class="a-left w-30p">
                                <a id="txtToFormat" runat="server">
                                    <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date" class="v-middle"></a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="display: none">
                        <tr>
                            <td class="a-left w-30p">
                                <td class="w-20p a-right">
                                </td>
                                <td class="a-left">
                                </td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="display: none">
                <td class="w-20p a-right">
                    Location
                </td>
                <td>
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall">
                    </asp:DropDownList>
                </td>
                <td class="w-20p a-right">
                    Client Name
                </td>
                <td>
                    <asp:DropDownList ID="ddlClients" ToolTip="Select Client" runat="server" CssClass="ddlsmall">
                    </asp:DropDownList>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="v-top">
                                <asp:Label ID="lblPreference" Text="Preference" runat="server"></asp:Label>
                            </td>
                            <td class="v-top">
                                <span class="richcombobox" class="w-80">
                                    <asp:DropDownList ID="ddlPreference" CssClass="ddlsmall" runat="server">
                                    </asp:DropDownList>
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="display: none">
                <td class="a-right w-27">
                    Test Name
                </td>
                <td>
                    <asp:TextBox ID="txtInvName" class="tb1 small" runat="server"></asp:TextBox>
                </td>
                <td class="w-20p a-right">
                    Department
                </td>
                <td>
                    <asp:DropDownList ID="ddlDept" runat="server" CssClass="ddlsmall">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="w-20p a-right">
                    Work Sheet Type
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlCultureType" runat="server" CssClass="ddlsmall" onchange="ChangeText()">
                                    <asp:ListItem Value="-1" Text="--Select--"></asp:ListItem>
                                    <asp:ListItem Value="0" Text="ABO Group"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Micro Serology"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="PAP Smear"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Urinalysis"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="Urine Drug"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Urine Pregnancy Test"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="VDRL (RPR)"></asp:ListItem>
                                    <%--<asp:ListItem Value="1" Text="Fecalysis"></asp:ListItem>--%>
                                    <%--<asp:ListItem Value="2" Text="Semen Analysis"></asp:ListItem>--%>
                                    <%--<asp:ListItem Value="4" Text="Widal & Weil Felix"></asp:ListItem>--%>
                                </asp:DropDownList>
                            </td>
                            <td class="w-20p a-right " style="display: none;" id="tdwrklst" runat="server">
                                Worklist ID
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMode" runat="server" CssClass="ddlsmall" Style="display: none;">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="txtWorklistID" runat="server" CssClass="small" Style="display: none;"
                                    onkeyup="javascript:return fnClearWorklistType();"></asp:TextBox>
                                <asp:CheckBox ID="chkIsIncludevalues" runat="server" Checked="true" Text="Include Result Values"
                                    TextAlign="Right" Style="display: none;" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="a-left">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblbarcode" runat="server" Text="BarCode" Style="display: none;"></asp:Label>
                            </td>
                            <td>
                                <input type="text" id="txtBarCode" onkeypress="searchKeyPress(event);" style="display: none;" />
                                <%--<asp:TextBox ID="txtBarCode" runat="server" CssClass="Txtboxsmall"></asp:TextBox>onkeypress="searchKeyPress(event);"--%>
                            </td>
                            <td>
                                <input type="button" id="btnSearch" value="..." onclick="ValidateSamples();" class="btn"
                                    style="display: none;" />
                                <%--<asp:Button ID="btnSearch" runat="server" Text="Submit" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" OnClientClick="javascript:ValidateSamples(); return false;" />--%>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="w-20p a-left">
                    <%--<asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Generate Work List"
                                        Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        Text=" Generate Work List " UseSubmitBehavior="true" 
                                        OnClientClick="javascript:return validateVisit();" />--%>
                    <%--OnClick="btnFinish_Click"--%>
                    <input type="button" id="btnFinish" runat="server" style="cursor: pointer;" class="btn"
                        value="Start Scaning" usesubmitbehavior="true" onclick="javascript:return validateVisit();" />
                </td>
                <td>
                </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="lblStatus" Visible="false" runat="server" ForeColor="#333" Text="No Matching Records Found!"></asp:Label>
        <table id="tabPrintButton" class="w-100p a-center" style="display: none;" runat="server">
            <tr class="a-right">
                <td class="a-right paddingR10" style="color: #000000;">
                    <b id="printText" runat="server">
                        <asp:LinkButton ID="lnkPrint" Text="Print Worksheet" Font-Underline="True" OnClientClick="return popupprint(); return false"
                            runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                </td>
                <td class="w-15p" style="display: none;">
                    <asp:Label ID="lblExcel" runat="server" Text="Export To Excel" Font-Bold="true"></asp:Label>
                    <asp:ImageButton ID="btnXL" OnClick="btnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                        ToolTip="Save As Excel" />
                </td>
            </tr>
        </table>

        <asp:Label ID="lbltxtSTR" Visible="false" BackColor="AliceBlue" runat="server" Text="** IS IN CANCEL STATUS"></asp:Label>
        <br />
        <br />
        <div id="prnReport" runat="server" class="w-100p a-center genworkList">
            <table id="tblPrint" class="w-100p a-center searchPanel" runat="server" style="display: none;">
                <tr class="h-35">
                    <td class="a-center" colspan="13">
                        <asp:Label ID="lblPrintHeader" runat="server" CssClass="small bold colorforcontent"></asp:Label>
                    </td>
                </tr>
                <tr class="h-25">
                    <td class="a-right w-20p bold" colspan="3">
                        Location :
                    </td>
                    <td class="a-left w-30p" colspan="3">
                        <asp:Label ID="lblPrintLocation" runat="server" CssClass="small"></asp:Label>
                    </td>
                    <td class="a-right bold w-20p" colspan="3">
                        Worklist ID :
                    </td>
                    <td class="a-left w-30p" colspan="3">
                        <asp:Label ID="lblPrintWorkListID" runat="server" CssClass="small"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="a-right w-20p bold" colspan="3">
                        Generated By :
                    </td>
                    <td class="a-left w-30p" colspan="3">
                        <asp:Label ID="lblPrintGeneratedBy" runat="server" CssClass="small"></asp:Label>
                    </td>
                    <td class="a-right w-20p bold" colspan="3">
                        Date & time :
                    </td>
                    <td class="a-left w-30p" colspan="3">
                        <asp:Label ID="lblPrintDateTime" runat="server" CssClass="small"></asp:Label>
                    </td>
                </tr>
                <tr class="h-15">
                </tr>
            </table>
            <br />
            <table id="trdatatables" class="m-auto w-85p" style="display: none;">
                <tr>
                    <td align="center">
                        <%--<input type="button" id="btnSubmit" runat="server" value="Generate Work List" onclick="javascript:return saveworklist();" style="display:none;" />--%>
                        <asp:Button ID="btnSubmit" runat="server" Text="Generate Work List" CssClass="btn"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return clrhdnRowNo();"
                            OnClick="btnSubmit_Click" Style="display: none;" />
                        <asp:Button ID="Button1" runat="server" Text="Generate Work List" CssClass="btn"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return saveworklist11();"
                            OnClick="Button1_Click" Style="display: none;" />
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <table id="tblUrinalysis" class="bg-row" border="1" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap; text-align: left;">
                            <thead>
                                <tr>
                                    <%--<th><b>S.NO</b></th>--%>
                                    <%--<th><b>RowID:</b></th>--%>
                                    <th class="w-9p">
                                        SI No
                                    </th>
                                    <th class="w-9p">
                                        <b>Lab No: </b>
                                    </th>
                                    <th class="w-9p">
                                        <b>Name </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>APP </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>COL </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>SG </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>PH </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>LEU </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>NIT </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>PRO </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>GLUU </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>KET </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>URO </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>BIL </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>BLD </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>URBC </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>WBC </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>ECC </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>BACT </b>
                                    </th>
                                    <%--<th style="width: 4%">
                                                        <b>CST </b>
                                                    </th>--%>
                                    <th class="w-4p">
                                        <b>OTHR </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>Performed By </b>
                                    </th>
                                    <th class="w-4p">
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblBloodGroup" class="a-left" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th class="w-9p">
                                        SI No
                                    </th>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>ANTIA </b>
                                    </th>
                                    <th>
                                        <b>ANTIB </b>
                                    </th>
                                    <th>
                                        <b>ANTIAB </b>
                                    </th>
                                    <th>
                                        <b>RHESUS </b>
                                    </th>
                                    <th>
                                        <b>CELLA </b>
                                    </th>
                                    <th>
                                        <b>CELLB </b>
                                    </th>
                                    <th>
                                        <b>CELLO </b>
                                    </th>
                                    <th>
                                        <b>ABO </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblFecalysis" border="1" class="a-left" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>CLR </b>
                                    </th>
                                    <th>
                                        <b>CLR </b>
                                    </th>
                                    <th>
                                        <b>MUC </b>
                                    </th>
                                    <th>
                                        <b>YST </b>
                                    </th>
                                    <th>
                                        <b>FAT </b>
                                    </th>
                                    <th>
                                        <b>PRT </b>
                                    </th>
                                    <th>
                                        <b>FLG </b>
                                    </th>
                                    <th>
                                        <b>CIL </b>
                                    </th>
                                    <th>
                                        <b>PRS </b>
                                    </th>
                                    <th>
                                        <b>WBC </b>
                                    </th>
                                    <th>
                                        <b>RBC </b>
                                    </th>
                                    <th>
                                        <b>UDP </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblMicroSerology" border="1" class="a-left" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th class="w-9p">
                                        SI No
                                    </th>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>CHLAMG </b>
                                    </th>
                                    <th>
                                        <b>CHLAMM </b>
                                    </th>
                                    <th>
                                        <b>ANF </b>
                                    </th>
                                    <th>
                                        <b>ASOT </b>
                                    </th>
                                    <th>
                                        <b>DENG </b>
                                    </th>
                                    <th>
                                        <b>DENM </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblWidal" border="1" class="a-left" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th class="w-9p">
                                        SI No
                                    </th>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>STTO </b>
                                    </th>
                                    <th>
                                        <b>SPAO </b>
                                    </th>
                                    <th>
                                        <b>SPBO </b>
                                    </th>
                                    <th>
                                        <b>SPCO </b>
                                    </th>
                                    <th>
                                        <b>STH </b>
                                    </th>
                                    <th>
                                        <b>SPAH </b>
                                    </th>
                                    <th>
                                        <b>SPBH </b>
                                    </th>
                                    <th>
                                        <b>SPCH </b>
                                    </th>
                                    <th>
                                        <b>PROOXK </b>
                                    </th>
                                    <th>
                                        <b>PROOX2 </b>
                                    </th>
                                    <th>
                                        <b>PROOX19 </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblPapsmear" border="1" class="a-left" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th class="w-9p">
                                        SI No
                                    </th>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>CYTOREFNO</b>
                                    </th>
                                    <th>
                                        <b>LMPDATE</b>
                                    </th>
                                    <th>
                                        <b>SSPECI</b>
                                    </th>
                                    <th>
                                        <b>SPECADEQ</b>
                                    </th>
                                    <th>
                                        <b>ENDOCELL</b>
                                    </th>
                                    <th>
                                        <b>HORMON</b>
                                    </th>
                                    <th>
                                        <b>CYTOMICROP</b>
                                    </th>
                                    <th>
                                        <b>INFLAM</b>
                                    </th>
                                    <th>
                                        <b>MICROINFECT</b>
                                    </th>
                                    <th>
                                        <b>TRICHO&amp;CAND</b>
                                    </th>
                                    <th>
                                        <b>I&amp;D</b>
                                    </th>
                                    <th>
                                        <b>RCMMD</b>
                                    </th>
                                    <th>
                                        <b>Summary </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblVDRL" border="1" class="a-left" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th>
                                        SI No
                                    </th>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>VDRL </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblUrineDrug" border="1" class="a-left" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th class="w-9p">
                                        SI No
                                    </th>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>AMPH </b>
                                    </th>
                                    <th>
                                        <b>CAN </b>
                                    </th>
                                    <th>
                                        <b>COC </b>
                                    </th>
                                    <th>
                                        <b>KETA </b>
                                    </th>
                                    <th>
                                        <b>OPI </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <table id="tblUrinePregnancyTest" border="1" class="a-left" style="display: none;
                            border-collapse: collapse; empty-cells: show; white-space: nowrap;">
                            <thead>
                                <tr>
                                    <th class="w-9p">
                                        SI No
                                    </th>
                                    <th>
                                        <b>Lab No: </b>
                                    </th>
                                    <th>
                                        <b>Name </b>
                                    </th>
                                    <th>
                                        <b>Urine Pregnancy Test </b>
                                    </th>
                                    <th>
                                        <b>Performed By </b>
                                    </th>
                                    <th>
                                        <b>Entered By </b>
                                    </th>
                                    <th>
                                        <b>Seq No</b>
                                    </th>
                                    <th>
                                        <b>ACC No</b>
                                    </th>
                                    <th>
                                        <b>Visit No</b>
                                    </th>
                                    <th>
                                        <b>WorkListID</b>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <%--<asp:GridView ID="gvUrinalysis" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvUrinalysis_RowDataBound"
                                            Width="100%" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ExternalVisitId" HeaderText="Episode No:" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="40%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Appearance" HeaderText="App" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Colour" HeaderText="CLR" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SpecificGravity" HeaderText="SG" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="pH" HeaderText="pH" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Leucocytes" HeaderText="LEU" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Nitrite" HeaderText="NIT" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Protein" HeaderText="PRT" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Glucose" HeaderText="GLU" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Ketones" HeaderText="KET" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Urobilinogen" HeaderText="URO" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Bilirubin" HeaderText="BILI" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Blood" HeaderText="BLD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="WhiteBloodCellCount" HeaderText="WBC" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="RedBloodCellCount" HeaderText="RBC" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EpithelialCellCount" HeaderText="EPT" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Bacteria" HeaderText="BAC" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Casts" HeaderText="CST" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Others" HeaderText="OTH" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <%--<asp:BoundField DataField="Performed" HeaderText="PFRMD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Entered" HeaderText="ENTRD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>--%>
                        <%--</Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>--%>
                        <%--<asp:GridView ID="gvBloodGroup" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvBloodGroup_RowDataBound"
                                            Width="100%" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ExternalVisitId" HeaderText="Episode No:" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="AntiA" HeaderText="ANTI A" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="AntiB" HeaderText="ANTI B" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="AntiAB" HeaderText="ANTI AB" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Rhesus" HeaderText="Rhesus" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ACell" HeaderText="A CELL" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="BCell" HeaderText="B CELL" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="OCell" HeaderText="O CELL" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>                                                
                                                <asp:BoundField DataField="ABO" HeaderText="Blood Grp" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>--%>
                        <%--<asp:BoundField DataField="Performed" HeaderText="PFRMD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Entered" HeaderText="ENTRD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>--%>
                        <%--</Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>--%>
                        <%-- <asp:GridView ID="gvFecalysis" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvFecalysis_RowDataBound"
                                            Width="100%" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ExternalVisitId" HeaderText="Episode No:" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Colour" HeaderText="CLR" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Consistency" HeaderText="CLR" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="MucusStrands" HeaderText="MUC" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="YeastCells" HeaderText="YST" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="FatGlobules" HeaderText="FAT" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Protozoa" HeaderText="PRT" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Flagellates" HeaderText="FLG" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Ciliates" HeaderText="CIL" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Parasites" HeaderText="PRS" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="LeukocytesPusCell" HeaderText="WBC" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="RedBloodCells" HeaderText="RBC" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="UndigestedParticles" HeaderText="UDP" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <%--<asp:BoundField DataField="Performed" HeaderText="PFRMD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Entered" HeaderText="ENTRD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>--%>
                        <%-- <asp:GridView ID="gvMicroSerology" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvMicroSerology_RowDataBound"
                                            Width="100%" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ExternalVisitId" HeaderText="Episode No:" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="LeptospiraIgG" HeaderText="LEPTOG" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="LeptospiraIgM" HeaderText="LEPTOM" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HPyloriAntibody" HeaderText="H.PYAb" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="HPyloriStoolAntigen" HeaderText="H.PYAg" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SalmonellaIgG" HeaderText="SALMG" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SalmonellaIgM" HeaderText="SALMM" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DengueNS1Antigen" HeaderText="DEN NS1" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DengueIgG" HeaderText="DENG" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DengueIgM" HeaderText="DENM" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ChikungunyaIgM" HeaderText="CHIKV" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Tpha" HeaderText="TPHA" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="MonospotIM" HeaderText="MONO" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <%--<asp:BoundField DataField="Performed" HeaderText="PFRMD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Entered" HeaderText="ENTRD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>--%>
                        <%-- <asp:GridView ID="gvWidal" runat="server" AutoGenerateColumns="False" Width="100%"
                                            ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ExternalVisitId" HeaderText="Episode No:" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="STyphiTO" HeaderText="STTO" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SParatyphiAO" HeaderText="SPAO" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SParatyphiBO" HeaderText="SPBO" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SParatyphiCO" HeaderText="SPCO" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="StyphiTH" HeaderText="STH" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SParatyphiAH" HeaderText="SPAH" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SParatyphiBH" HeaderText="SPBH" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SParatyphiCH" HeaderText="SPCH" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProteusOXK" HeaderText="PROOXK" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProteusOX2" HeaderText="PROOX2" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProteusOX19" HeaderText="PROOX19" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <%--<asp:BoundField DataField="Performed" HeaderText="PFRMD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Entered" HeaderText="ENTRD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>--%>
                        <%--  <asp:GridView ID="gvVDRL" runat="server" AutoGenerateColumns="False" Width="100%"
                                            ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemStyle />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ExternalVisitId" HeaderText="Episode No:" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="40%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="VDRL" HeaderText="VDRL" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <%--<asp:BoundField DataField="Performed" HeaderText="PFRMD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Entered" HeaderText="ENTRD" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>--%>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
   
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnDept" runat="server" />
    <asp:HiddenField ID="hdnRowNo" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLstGrp" runat="server" Value="" />
    <asp:HiddenField ID="hdnIsScan" runat="server" Value="N" />
<%--
    <script type="text/javascript" src="../Scripts/jquery.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>--%>

    <%--Script for AutoComplete of Investigation Name--%>

    <script type="text/javascript">
        $(function() {
            $("#txtInvName").addClass("Txtboxsmall");
            $(".tb1").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: "../WebService.asmx/FetchInvestigationName",
                        data: "{ 'Name': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function(data) { return data; },
                        success: function(data) {
                            response($.map(data.d, function(item) {
                                return {
                                    value: item.Name
                                }
                            }))
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                },
                minLength: 2
            });
        });


        function reloadauto() {

            $(function() {

                $(".tb").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../WebService.asmx/FetchDrugList",
                            data: "{ 'drug': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.BrandName
                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });
            });
        }
        
	    
	    
    </script>

    </form>
    <%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>--%>
<%--
    <script src="../Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.min.1.8.13.js" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    
</body>
</html>
