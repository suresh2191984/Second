<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationStatusReport.aspx.cs"
    EnableEventValidation="false" Inherits="Investigation_InvestigationStatusReport"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Investigation Status Report</title>
    <style type="text/css">
        .listMain
        {
            min-width: 300px;
        }
        .wordWheel .itemsMain
        {
            min-width: 300px;
        }
    </style>
    <%-- <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>
    <style type="text/css">
        .itemsMainList .listMain
        {
            min-width: 200px;
            position: relative !important;
            width: 200px;
        }
        #VisitWiseSerach
        {
            width: 100%;
            height: auto;
            overflow: auto;
            overflow-y: auto;
            margin: 0 left;
            /*white-space: nowrap;*/
        }
        .orderedServices
        {
            display: block;
            height: 100px;
            overflow-y: auto;
        }
        .pTrackContent1 .ui-state-default, .pTrackContent1 .ui-widget-content .ui-state-default, .pTrackContent1 .ui-widget-header .ui-state-default
        {
            background: #f5f5f5 none repeat scroll 0 0 !important;
            border: 1px solid #ccc;
            color: #1c94c4;
            font-weight: normal;
            margin: 1px;
            padding: 2px;
        }
        .pTrackContent1 .ui-buttonset
        {
            display: inline;
            margin-right: 7px;
            float: left;
        }
        .pTrackContent1 .dataTables_filter
        {
            display: inline;
            float: right;
            color: #000;
        }
        .pTrackContent1 .ui-widget-header
        {
            background: #b7b7b5 none repeat scroll 0 0 !important;
        }
        .pTrackContent1 .dataTable
        {
            width: 100%;
        }
        .pTrackContent1 .dataTable td
        {
            padding: 8px;
            border-bottom: 1px solid #ccc;
        }
        .pTrackContent1 .dataTables_info
        {
            display: inline;
            float: right;
            color: #000;
        }
        .pTrackContent1 .dataTables_paginate
        {
            text-align: left;
        }
        .pTrackContent1 .ui-state-default .ui-icon
        {
            background-image: url(../Themes/IB/start/images/ui-icons_056b93_256x240.png);
        }
        .w-98p
        {
            width: 98%;
        }
        .autocompletehide
        {
            visibility: hidden;
        }
        .ajax__tab_xp .ajax__tab_body 
        { 
            font-size:12px!important;
        }
    </style>
</head>
<body>
<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

    <script language="javascript" type="text/javascript">

 $(document).ready(function() {
           $('#Export_XL').hide();

            // attach the event binding function to every partial update
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function(evt, args) {
                pageLoad1();
            });
        });

        function pageLoad1() {

            $("#__tab_grouptab_VisitwiseSearch").click(function() {
                $('#Export_XL').hide();
            });

            $("#__tab_grouptab_InvestigationStatusReportTab").click(function() {
                $('#Export_XL').show();
            });

            $("#__tab_grouptab_testStatisticReportTab").click(function() {
                $('#Export_XL').show();
            });

        }

        function SelectedPatient(source, eventArgs) {
            document.getElementById('<%= hdnSelectedPatient.ClientID %>').value = '';
            var SelectedPatientId = "";
            SelectedPatientId = eventArgs.get_value();
            document.getElementById('<%= hdnSelectedPatient.ClientID %>').value = SelectedPatientId;
            var PatientName = eventArgs.get_text();
            document.getElementById('txtPatientName').value = PatientName;
        }
        function SelectedClientID1(source, eventArgs) {
            //            document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = eventArgs.get_value().split('|')[0];
            document.getElementById('<%= hdnClientId.ClientID %>').value = eventArgs.get_value().split('|')[0];
        }
        function setContextValue1() {
            var sval = 'RPH'
            $find('<%= AutoCompleteExtenderRefPhy.ClientID %>').set_contextKey(sval);
            return false;
        } 
        function RefPhysicianSelected(source, eventArgs) {
            var PhysicianID;
            var PhysicianName;
            var PhysicianCode;
            var PhysicianType;
            $('#txtReferringPhysician').value = eventArgs.get_text();
            var PhyType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        PhysicianID = list[1];
                        PhysicianName = list[2];
                        PhysicianCode = list[3];
                        PhysicianType = list[0].trim();
                        PhyType = list[4];
                    }
                }
            }
            $('#hdnReferedPhyID').value = PhysicianID;
            $('#hdnReferedPhyName').value = PhysicianName;
            $('#hdnReferedPhysicianCode').value = PhysicianCode;
            $('#hdnReferedPhyType').value = PhysicianType;
        }

        function RefPhysicianSelected1(source, eventArgs) {
            var PhysicianID;
            var PhysicianName;
            var PhysicianCode;
            var PhysicianType;
            $('#txtrefphy').value = eventArgs.get_text();
            var PhyType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        PhysicianID = list[1];
                        PhysicianName = list[2];
                        PhysicianCode = list[3];
                        PhysicianType = list[0].trim();
                        PhyType = list[4];
                    }
                }
            }
            $('#hdnReferedPhyID').value = PhysicianID;
            $('#hdnReferedPhyName').value = PhysicianName;
            $('#hdnReferedPhysicianCode').value = PhysicianCode;
            $('#hdnReferedPhyType').value = PhysicianType;
        }
        function setContextValue() {
            var sval = document.getElementById('<%= ddlClientType.ClientID %>').value + "^" + document.getElementById('<%= ddlOrg.ClientID %>').value;
            $find('<%= AutoCompleteExtenderClient.ClientID %>').set_contextKey(sval);
            return false;
        }
        function setInvContextValue() {
            var sval = document.getElementById('<%= ddlInvClientType.ClientID %>').value + "^" + document.getElementById('<%= ddlOrganization.ClientID %>').value;
            $find('<%= AutoCompleteExtender3.ClientID %>').set_contextKey(sval);
            return false;
        }
        function SetRefContextValue() {
            var sval = document.getElementById('<%= ddlOrganization.ClientID %>').value;
            $find('<%= AutoCompleteExtenderReferringHospital.ClientID %>').set_contextKey(sval);
            $find('<%= AutoCompleteExtenderReferringPhysician.ClientID %>').set_contextKey("RPH^" + sval);
            return false;
        }
        function ClearFields() {
            if (document.getElementById('<%= txtReferringHospital.ClientID %>').value.trim() == "") {
                document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = "0";
            }
            if (document.getElementById('<%= txtReferringPhysician.ClientID %>').value.trim() == "") {
                document.getElementById('<%= hdnPhysicianID.ClientID %>').value = "0";
            }
        }
        function GetReferingOrgID(source, eventArgs) {
            document.getElementById('<%= txtReferringHospital.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = eventArgs.get_value();
        }
        function GetReferingPhysicianID(source, eventArgs) {
            document.getElementById('<%= txtReferringPhysician.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%= hdnPhysicianID.ClientID %>').value = eventArgs.get_value().split('^')[0];
        }
        function ClearValue(obj) {
            if (document.getElementById(obj).value == "") {
                document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = "0";
            }
        }
        function ClearInvValue(obj) {
            if (document.getElementById(obj).value == "") {
                document.getElementById('<%= hdnInvSelectedClientID.ClientID %>').value = "0";
            }
        }
        function SelectedClientID(source, eventArgs) {
            document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = eventArgs.get_value().split('|')[0];
        }
        function SelectedInvClientID(source, eventArgs) {
            document.getElementById('<%= hdnInvSelectedClientID.ClientID %>').value = eventArgs.get_value().split('|')[0];
        }
        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }
        function checkReportType(obj) {
            document.getElementById('<%=rdoSummary.ClientID %>').checked = false;
            document.getElementById('<%=rdoDetail.ClientID %>').checked = false;
            document.getElementById(obj).checked = true;
        }
        function SelectedStatTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('<%=hdnStatTestName.ClientID %>').value = TestName;
            document.getElementById('<%=hdnStatTestID.ClientID %>').value = TestID;
            document.getElementById('<%=hdnStatTestType.ClientID %>').value = TestType;
        }
        function SelectedStatTesttemp(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('<%=hdnStatTestName.ClientID %>').value = TestName;
            document.getElementById('<%=txtTestStatName.ClientID %>').value = TestName;
            document.getElementById('<%=hdnStatTestID.ClientID %>').value = TestID;
            document.getElementById('<%=hdnStatTestType.ClientID %>').value = TestType;

            AutoTextboxExpand(document.getElementById('<%=txtTestStatName.ClientID %>'));
        }
        function SelectedTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('<%=hdnTestName.ClientID %>').value = TestName;
            document.getElementById('<%=hdnTestID.ClientID %>').value = TestID;
            document.getElementById('<%=hdnTestType.ClientID %>').value = TestType;
        }
        function SelectedTesttemp(source, eventArgs) {

            TestDetails = eventArgs.get_value();

            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('<%=hdnTestName.ClientID %>').value = TestName;
            document.getElementById('<%=txtTestName.ClientID %>').value = TestName;
            document.getElementById('<%=hdnTestID.ClientID %>').value = TestID;
            document.getElementById('<%=hdnTestType.ClientID %>').value = TestType;
            AutoTextboxExpand(document.getElementById('<%=txtTestName.ClientID %>'));
        }
        function onListPopulated() {
            var completionList = $find("AutoCompleteExLstGrp11").get_completionList();
            completionList.style.width = 'auto';
        }
        function ClearTestDetails() {
            document.getElementById('<%=txtTestName.ClientID %>').value = '';
            document.getElementById('<%=hdnTestName.ClientID %>').value = '';
            document.getElementById('<%=hdnTestID.ClientID %>').value = '0';
            document.getElementById('<%=hdnTestType.ClientID %>').value = '';

        }
        function CheckPatientSearch() {

            //        if (document.getElementById('<%=ddlLocation.ClientID %>').value == '------SELECT------') {
            //            alert('Select Location');
            //            return false;
            //        }
        }
        function ChkSearchLocation() {

        }
        function validateToDate() {


        }
        function popupprint() {
            var prtContent = document.getElementById('PrintDuplicatereport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            document.getElementById('<%=hdnPrintState.ClientID %>').value = '1';
            javascript: __doPostBack('btnSearch', '');
            document.getElementById('<%=hdnPrintState.ClientID %>').value = '0';
            // WinPrint.close();
        }
        function popupprintTestStat() {
            var prtContent = "";
            if (document.getElementById('<%=rdoDetail.ClientID %>').checked == true) {
                prtContent = document.getElementById('<%=divTestStatReport.ClientID %>');
            }
            else {
                prtContent = document.getElementById('<%=pnlSummary.ClientID %>');
            }
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
        }

        function ShowColumns(obj) {
            $("#pnlColumns").slideToggle("slow");
            $("#lnkBtnSaveTemplate").slideToggle("slow");
            if (obj.value != "Hide") {
                obj.value = "Hide";
            }
            else {
                obj.value = "Show";
            }
        }
        function checkAll(obj1) {
            var checkboxCollection = document.getElementById('<%=check1.ClientID %>').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function SelectAllDepts(obj1) {
            var checkboxCollection = document.getElementById('<%=chkDept.ClientID %>').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function pageLoad() {

            if (document.getElementById('<%=rdoTS.ClientID %>').checked) {
                document.getElementById('<%=hdnSetSearchType.ClientID %>').value = "TS";
                document.getElementById('<%=dvtestStatus.ClientID %>').disabled = true;
                document.getElementById('<%=Label1.ClientID %>').disabled = false;
                document.getElementById('<%=ddlInvestigationStatus1.ClientID %>').disabled = false;
                document.getElementById('<%=Label2.ClientID %>').disabled = true;
                document.getElementById('<%=ddlSampleStatus.ClientID %>').disabled = true;
            }
            if (document.getElementById('<%=rdoPS.ClientID %>').checked) {
                document.getElementById('<%=hdnSetSearchType.ClientID %>').value = "PS";
                document.getElementById('<%=Label1.ClientID %>').disabled = true;
                document.getElementById('<%=ddlInvestigationStatus1.ClientID %>').disabled = true;
                document.getElementById('<%=Label2.ClientID %>').disabled = true;
                document.getElementById('<%=ddlSampleStatus.ClientID %>').disabled = true;
                document.getElementById('<%=dvtestStatus.ClientID %>').disabled = false;

            }

            if (document.getElementById('<%=rdoSS.ClientID %>').checked) {
                document.getElementById('<%=hdnSetSearchType.ClientID %>').value = "SS";
                document.getElementById('<%=dvtestStatus.ClientID %>').disabled = true;
                document.getElementById('<%=Label1.ClientID %>').disabled = true;
                document.getElementById('<%=ddlInvestigationStatus1.ClientID %>').disabled = true;
                document.getElementById('<%=Label2.ClientID %>').disabled = false;
                document.getElementById('<%=ddlSampleStatus.ClientID %>').disabled = false;
            }

        }
        function ClearPopUp1() {

            //        var otable = document.getElementById('grouptab_InvestigationStatusReportTab_ tblGroupHistory');
            //        while (otable.rows.length > 1) {
            //            otable.deleteRow(otable.rows.length - 1);
            //        }
            var modal = $find('grouptab_InvestigationStatusReportTab_ModalPopupShow');
            modal.hide();
            //        document.getElementById('billPart_btnDummy').click();
        }
        function checkForValues() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vPageNo = SListForAppMsg.Get('Investigation_InvestigationStatusReport_aspx_11') == null ? "Provide page number" : SListForAppMsg.Get('Investigation_InvestigationStatusReport_aspx_11');
            var vCorrectPage = SListForAppMsg.Get('Investigation_InvestigationStatusReport_aspx_12') == null ? "Provide correct page number" : SListForAppMsg.Get('Investigation_InvestigationStatusReport_aspx_12');

            if (document.getElementById('<%=txtpageNo.ClientID %>').value == "") {
            
                //alert('Provide page number');
                ValidationWindow(vPageNo, AlertType);
                return false;
            }
            if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) < Number(1)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPage, AlertType);
                return false;
            }
            if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) > Number(document.getElementById('<%=lblTotal.ClientID %>').innerText)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPage, AlertType);
                return false;
            }
            return true;
        }
        function SetSearchType(obj) {

            if (obj == "PS") {
                document.getElementById('<%=hdnSetSearchType.ClientID %>').value = "PS";
                document.getElementById('<%=dvtestStatus.ClientID %>').disabled = false;
                document.getElementById('<%=Label1.ClientID %>').disabled = true;
                document.getElementById('<%=ddlInvestigationStatus1.ClientID %>').disabled = true;
                document.getElementById('<%=Label2.ClientID %>').disabled = true;
                document.getElementById('<%=ddlSampleStatus.ClientID %>').disabled = true;
                //            document.getElementById('<%=Label7.ClientID %>').disabled = true;
                //            document.getElementById('<%=ddlSTATStatus.ClientID %>').disabled = true;
            }

            if (obj == "TS") {
                document.getElementById('<%=hdnSetSearchType.ClientID %>').value = "TS";

                document.getElementById('<%=dvtestStatus.ClientID %>').disabled = true;
                document.getElementById('<%=Label1.ClientID %>').disabled = false;
                document.getElementById('<%=ddlInvestigationStatus1.ClientID %>').disabled = false;
                document.getElementById('<%=Label2.ClientID %>').disabled = true;
                document.getElementById('<%=ddlSampleStatus.ClientID %>').disabled = true;
                //            document.getElementById('<%=Label7.ClientID %>').disabled = true;
                //            document.getElementById('<%=ddlSTATStatus.ClientID %>').disabled = true;
            }
            if (obj == "SS") {
                document.getElementById('<%=hdnSetSearchType.ClientID %>').value = "SS";

                document.getElementById('<%=dvtestStatus.ClientID %>').disabled = true;
                document.getElementById('<%=Label1.ClientID %>').disabled = true;
                document.getElementById('<%=ddlInvestigationStatus1.ClientID %>').disabled = true;
                document.getElementById('<%=Label2.ClientID %>').disabled = false;
                document.getElementById('<%=ddlSampleStatus.ClientID %>').disabled = false;
                //            document.getElementById('<%=Label7.ClientID %>').disabled = true;
                //            document.getElementById('<%=ddlSTATStatus.ClientID %>').disabled = true;
            }
            //        if (obj == "STAT") {
            //            document.getElementById('<%=hdnSetSearchType.ClientID %>').value = "STAT";
            //            document.getElementById('<%=dvtestStatus.ClientID %>').disabled = true;
            //            document.getElementById('<%=Label1.ClientID %>').disabled = true;
            //            document.getElementById('<%=ddlInvestigationStatus1.ClientID %>').disabled = true;
            //            document.getElementById('<%=Label2.ClientID %>').disabled = true;
            //            document.getElementById('<%=ddlSampleStatus.ClientID %>').disabled = true;
            //            document.getElementById('<%=Label7.ClientID %>').disabled = false;
            //            document.getElementById('<%=ddlSTATStatus.ClientID %>').disabled = false;
            //        }
        }
        function SetSearchReport(obj) {

            if (obj == "AR") {
                document.getElementById('<%=hdnSetSearchReport.ClientID %>').value = "AR";
            }

            if (obj == "PR") {
                document.getElementById('<%=hdnSetSearchReport.ClientID %>').value = "PR";

            }

        }


        function printPopUp(DivPrintID) {
            var objDivPrint = document.getElementById(DivPrintID);
            var testwindow = window.open("", "mywindow", "location=no, directories=no, status=no, menubar=no, scrollbars=1, resizable=no, copyhistory=no,width=" + screen.width.toString() + ",height=" + screen.height + "");
            testwindow.document.write(objDivPrint.innerHTML);
            testwindow.document.close();
            testwindow.moveTo(0, 0);
            testwindow.focus();
            testwindow.print();
            //testwindow.close();


        }
        function setContextClientNameValue() {
            var sval = '0' + "^" + document.getElementById('<%= ddlorgan.ClientID %>').value;
            $find('<%= AutoCompleteExtenderClientName.ClientID %>').set_contextKey(sval);
            return false;
        }
        function ConvertToTable(attXML) {
            var divAttribute = document.getElementById(id);
            // var lblAction = document.getElementById(actionID);

            if (document.getElementById(actionID).value != "[-]") {
                if (window.DOMParser) {
                    parser = new DOMParser();
                    xmlDoc = parser.parseFromString(attXML, "text/xml");
                }
                else {
                    xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                    xmlDoc.async = "false";
                    xmlDoc.loadXML(attXML);
                }
                var str = "<table border='1px' class='dataheaderInvCtrl'>";
                var x = xmlDoc.getElementsByTagName("AttributeValues");
                str += "<thead><th>ProductNo</th><th>SerialNo</th><th>OtherValue</th><th style='width:75px'>Usage</th><th>UsedSoFor</th></thead>";
                for (i = 0; i < x.length; i++) {
                    for (j = 0; j < x[i].childNodes.length; j++) {

                        str += "<tr><td>" + x[i].getElementsByTagName("Units")[j].getAttribute("ProductNo") + "</td>";
                        str += "<td>" + x[i].getElementsByTagName("Units")[j].getAttribute("SerialNo") + "</td>";
                        str += "<td>" + x[i].getElementsByTagName("Units")[j].getAttribute("OtherValue") + "</td>";
                        if (x[i].getElementsByTagName("Units")[j].getAttribute("IsIssued") == 'Y') {
                            str += "<td style='width:100px'>" + "EXCEEDED" + "</td>";
                        } else {
                            str += "<td style='width:100px'>" + "NOTEXCEEDED" + "</td>";
                        }
                        str += "<td>" + x[i].getElementsByTagName("Units")[j].getAttribute("UsedSoFor") + "</td></tr>";
                    }
                }
                str += "</table>";
                divAttribute.innerHTML = str;
                document.getElementById(actionID).value = "[-]";
                document.getElementById(actionID).innerText = "[-]";
                document.getElementById(id).style.display = "block";
            }
            else {
                document.getElementById(id).style.display = "none";
                document.getElementById(actionID).value = "[+]";
                document.getElementById(actionID).innerText = "[+]";
            }
        }
        function doToggle(id, actionID) {
            var divAttribute = document.getElementById(id);
            if (document.getElementById(actionID).value != "[-]") {
                document.getElementById(actionID).value = "[-]";
                document.getElementById(actionID).innerText = "[-]";
                document.getElementById(id).style.display = "block";
            }
            else {
                document.getElementById(id).style.display = "none";
                document.getElementById(actionID).value = "[+]";
                document.getElementById(actionID).innerText = "[+]";
            }
        }
        function ClearValues() {
            //$('#ddlorgan').val();
            $('#ddlLocation :selected').val('0');
            $('#ddlVisitType :selected').val('0');
            $('#ddlVisitStatus :selected').val('0');
            $('#txtPatientName').val('');
            $('#hdnSelectedPatient').val('');
            $('#txtVisitNo').val('');
            $('#txtReferenceNo').val('');
            $('#txtIdentityNumber').val('');
            $('#txtClientName').val('');
            $('#hdnClientId').val('0');
            $('#txtReferringPhysician').val('');
            $('#hdnReferedPhyID').val('0');

            var m_names = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");

            var d = new Date();
            var curr_date = d.getDate();
            var curr_month = d.getMonth();
            var curr_year = d.getFullYear();
            //document.write(curr_date + "-" + m_names[curr_month]+ "-" + curr_year);
            $('#txtFrom').val(curr_date + "-" + m_names[curr_month] + "-" + curr_year + ' 12:00AM');
            $('#txtTo').val(curr_date + "-" + m_names[curr_month] + "-" + curr_year + ' 11:59PM');
            $('#tdVisitWiseSerach').hide();
            $('#VisitWiseSerach').hide();

            $('#statusProgess').hide();
        }
        function ShowPopUp(visitnumber) {
            var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
        }
        //    Showmenu(); Showhide();
    </script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="Export_XL" runat="server" style="margin-top: 40px;text-align:left;">
            <asp:Label ID="Label3" Text="Export To Excel" Font-Bold="True" ForeColor="#000333"
                runat="server" Style="z-index: 1; left: 1176px; position: absolute" meta:resourcekey="Export_XLResource1"></asp:Label>
            <asp:ImageButton ID="ImageButton2" runat="server"  ImageUrl="~/Images/ExcelImage.GIF"
                Style="z-index: 1; left: 1266px; top: 146px; position: absolute" OnClick="btnConverttoXL_Click" />
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <cc1:TabContainer ID="grouptab" ActiveTabIndex="0" AutoPostBack="true" runat="server"
                    OnActiveTabChanged="grouptab_ActiveTabChanged" meta:resourcekey="grouptabResource1">
                    <cc1:TabPanel ID="InvestigationStatusReportTab" runat="server" HeaderText="Investigation Status Report"
                        meta:resourcekey="InvestigationStatusReportTabResource1">
                        <ContentTemplate>
                            <table id="tblCollectionOPIP" class="a-center w-98p">
                                <tr>
                                    <td>
                                        <table id="tblPatient" runat="server" class="w-100p">
                                            <tr>
                                                <td class="a-center">
                                                    <div style="display: block" class="dataheader2">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                                    <table class="w-100p itemsMainList">
                                                                        <tr>
                                                                            <td class="v-top a-left w-8p">
                                                                                <asp:Label ID="lblOrg" Text="Organization : " runat="server" meta:resourcekey="lblOrgResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left w-18p">
                                                                                <asp:DropDownList ID="ddlOrg" runat="server" CssClass="ddlsmall" OnSelectedIndexChanged="ddlOrg_SelectedIndexChanged"
                                                                                    AutoPostBack="True" meta:resourcekey="ddlOrgResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="v-top a-left w-10p">
                                                                                <asp:Label ID="lblLoc" Text="Location : " runat="server" meta:resourcekey="lblLocResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left w-20p">
                                                                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlLocationResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="v-top a-left w-10p">
                                                                                <asp:Label runat="server" ID="lblPatientNo" Text="Visit No : " meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left w-20p">
                                                                                <asp:TextBox ID="txtPatientNo" CssClass="small" onKeyPress="onEnterKeyPress(event);"
                                                                                    MaxLength="16" runat="server" meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td class="v-top a-left w-12p">
                                                                                <asp:Label ID="lblName" Text="Name : " runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left w-17p">
                                                                                <asp:TextBox ID="txtName" CssClass="small" runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="lblVisitType" Text="Visit Type : " runat="server" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:DropDownList ID="ddlVisitType" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlVisitTypeResource1">
                                                                                   <%-- <asp:ListItem Value="-1" Text="Both" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                    <asp:ListItem Value="0" Text="OP" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                    <asp:ListItem Value="1" Text="IP" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="lblFrom" Text="From : " runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:TextBox Width="70px" size="25" ID="txtFrom" CssClass="Txtboxsmall" runat="server"
                                                                                    meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="lblTo" Text="To : " runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:TextBox ID="txtTo" CssClass="Txtboxsmall" Width="70px" size="25" runat="server"
                                                                                    meta:resourcekey="txtToResource1"></asp:TextBox>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="lblTestName" Text="Test Name : " runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:TextBox ID="txtTestName" CssClass="small" runat="server" onchange="AutoTextboxExpand(this);"
                                                                                    onfocus="javascript:ClearTestDetails();" meta:resourcekey="txtTestNameResource1"></asp:TextBox><cc1:AutoCompleteExtender
                                                                                        ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server" TargetControlID="txtTestName"
                                                                                        ServiceMethod="FetchInvestigationNameForOrg" ServicePath="~/WebService.asmx"
                                                                                        EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                                                        OnClientItemSelected="SelectedTest" OnClientItemOver="SelectedTesttemp">
                                                                                    </cc1:AutoCompleteExtender>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="Label1" Text="Test Status : " runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:DropDownList ID="ddlInvestigationStatus1" runat="server" CssClass="ddlsmall"
                                                                                    meta:resourcekey="ddlInvestigationStatus1Resource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="Label2" Text="Sample Status : " runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:DropDownList ID="ddlSampleStatus" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlSampleStatusResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="Label7" Text="STAT Status : " runat="server" meta:resourcekey="Label7Resource1"  Visible="True"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:DropDownList ID="ddlSTATStatus" runat="server" CssClass="ddlsmall" AppendDataBoundItems="True"
                                                                                    meta:resourcekey="ddlSTATStatusResource1" Visible="True">
                                                                                    <%--<asp:ListItem Text="------SELECT------" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                    <asp:ListItem Text="STAT" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="lblClientType" runat="server" Text="Client type : " meta:resourcekey="lblClientTypeResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:DropDownList ID="ddlClientType" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlClientTypeResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="v-top a-left" colspan="3">
                                                                                <asp:Panel ID="pnlSerachType" runat="server" GroupingText="Search Type : " Width="350px" meta:resourcekey="pnlSerachTypeResource1">
                                                                                    <input cssclass="bilddltb" type="radio" value="PS" name="SearchType" runat="server"
                                                                                        id="rdoPS" onclick="Javascript:SetSearchType('PS');" tabindex="0" />
                                                                                    <asp:Label ID="RS_PS" runat="server" Font-Bold="false" Text="Visit Status" meta:resourcekey="RS_PSResource1"></asp:Label><input
                                                                                        cssclass="bilddltb" type="radio" value="TS" name="SearchType" runat="server"
                                                                                        id="rdoTS" onclick="Javascript:SetSearchType('TS');" tabindex="2" checked="true" />
                                                                                    <asp:Label ID="RS_TS" runat="server" Font-Bold="false" Text="Test Status" meta:resourcekey="RS_TSResource1"></asp:Label><input
                                                                                        cssclass="bilddltb" type="radio" value="SS" name="SearchType" runat="server"
                                                                                        id="rdoSS" onclick="Javascript:SetSearchType('SS');" tabindex="2" />
                                                                                    <asp:Label ID="RS_SS" runat="server" Font-Bold="false" Text="Sample Status" meta:resourcekey="RS_SSResource1"></asp:Label></asp:Panel>
                                                                            </td>
                                                                            <td class="v-top a-left" colspan="3">
                                                                                <asp:Panel ID="dvtestStatus" GroupingText="Report Status : " runat="server" meta:resourcekey="dvtestStatusResource1">
                                                                                    <input cssclass="bilddltb" type="radio" value="AR" name="SearchReport" runat="server"
                                                                                        id="rdoALL" onclick="Javascript:SetSearchReport('AR');" tabindex="0" checked="true" />
                                                                                    <asp:Label ID="RS_AllReport" runat="server" Font-Bold="false" Text="All Report" meta:resourcekey="RS_AllReportResource1"></asp:Label><input
                                                                                        cssclass="bilddltb" type="radio" value="PR" name="SearchReport" runat="server"
                                                                                        id="rdoPending" onclick="Javascript:SetSearchReport('PR');" tabindex="2" />
                                                                                    <asp:Label ID="RS_PendingReport" runat="server" Font-Bold="false" Text="Pending Report" meta:resourcekey="RS_PendingReportResource1"></asp:Label>&#160;</asp:Panel>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="lblClient" Style="display: block;" Text="Client Name : " runat="server"
                                                                                    meta:resourcekey="lblClientResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:TextBox ID="txtClient" onfocus="setContextValue();" Style="display: block;"
                                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);"
                                                                                    autocomplete="off" CssClass="small" runat="server" meta:resourcekey="txtClientResource1"></asp:TextBox><cc1:AutoCompleteExtender
                                                                                        ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClient" CompletionListCssClass="wordWheel listMain .box"
                                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                                                                        ServiceMethod="GetClientList" OnClientItemSelected="SelectedClientID" ServicePath="~/WebService.asmx"
                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                    </cc1:AutoCompleteExtender>
                                                                            </td>
                                                                            <td class="v-top a-left">
                                                                                <asp:Label ID="lblTestCategory" Visible="False" Text="Test category : " runat="server"
                                                                                    meta:resourcekey="lblTestCategoryResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="v-top a-left"">
                                                                                <asp:DropDownList ID="ddlTestCategory" Visible="False" runat="server" CssClass="ddlsmall"
                                                                                    meta:resourcekey="ddlTestCategoryResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="v-top a-left w-100p">
                                                                    <asp:Panel ID="Panel1" runat="server" Font-Bold="True" GroupingText="Departments:"
                                                                        meta:resourcekey="Panel1Resource1">
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:CheckBox ID="chkCheckAll" runat="server" Text="Select All" onclick="checkAll(this);"
                                                                                        Checked="True" meta:resourcekey="chkCheckAllResource1" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:CheckBoxList ID="check1" Font-Size="Smaller" AutoPostBack="false" TextAlign="Right"
                                                                                        DataTextField="DeptName" DataValueField="DeptID" runat="server" RepeatColumns="7"
                                                                                        meta:resourcekey="check1Resource1">
                                                                                    </asp:CheckBoxList>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="a-center">
                                                                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                                                        OnClientClick="return CheckPatientSearch();" onmouseout="this.className='btn1'"
                                                                                        onmouseover="this.className='btn1 btnhov'" Text="Search" meta:resourcekey="btnSearchResource1" />&#160;&nbsp;
                                                                                </td>
                                                                                <td class="a-right">
                                                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                                                        meta:resourcekey="lnkBackResource1" Text="Back&amp;nbsp;&amp;nbsp;&amp;nbsp;"></asp:LinkButton>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <div id="divPrint1" style="display: block;" runat="server">
                                <table class="w-100p">
                                    <tr>
                                        <td class="a-right paddingR10" style="color: #000000;">
                                            <b id="B1" runat="server"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_004%></b>&nbsp;&nbsp;
                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                OnClick="btnConverttoPrint_Click" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="prnReport" style="font-family: Arial; text-decoration: none; font-size: 10px;
                                position: absolute; width: 100%; overflow: auto;">
                                <table class="w-100p">
                                    <tr>
                                        <td id="tdPatientStatus" runat="server" style="display: none;">
                                            <asp:GridView ID="gvStatusReport" runat="server" AutoGenerateColumns="False" HeaderStyle-Height="25px"
                                                FooterStyle-Height="25px" AllowPaging="True" PageSize="10" CellPadding="1" EmptyDataText="Collection Details Not Available"
                                                Font-Names="verdana" Font-Size="11px" ShowFooter="True" Width="100%" OnPageIndexChanging="gvStatusReport_PageIndexChanging"
                                                meta:resourcekey="gvStatusReportResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.NO" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient no" SortExpression="PatientNumber"
                                                        meta:resourcekey="BoundFieldResource1" ItemStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="PatientName" HeaderText="Patient name" SortExpression="PatientName"
                                                        meta:resourcekey="BoundFieldResource2" />
                                                    <asp:BoundField DataField="ExternalVisitid" HeaderText="Visit No" SortExpression="ExternalVisitID"
                                                        meta:resourcekey="BoundFieldResource3" />
                                                    <asp:BoundField DataField="RegistrationDTTM" HeaderText="Visit on" SortExpression="RegistrationDTTM"
                                                        ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                        meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField DataField="SampleCollection" HeaderText="Sample collection" SortExpression="SampleCollection"
                                                        meta:resourcekey="BoundFieldResource5" />
                                                    <asp:BoundField DataField="ResultCapture" HeaderText="Result capture" SortExpression="ResultCapture"
                                                        meta:resourcekey="BoundFieldResource6" />
                                                    <asp:BoundField DataField="Approval" Visible="False" HeaderText="Approval" SortExpression="Approval"
                                                        meta:resourcekey="BoundFieldResource7" />
                                                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"
                                                        meta:resourcekey="BoundFieldResource8" />
                                                    <asp:BoundField DataField="ClientTypeName" HeaderText="Client type" SortExpression="ClientTypeName"
                                                        meta:resourcekey="BoundFieldResource9" />
                                                    <asp:BoundField DataField="ClientName" HeaderText="Client name" SortExpression="ClientName"
                                                        meta:resourcekey="BoundFieldResource10" />
                                                    <asp:BoundField DataField="TestCategory" Visible="False" HeaderText="Test Classification"
                                                        SortExpression="TestCategory" meta:resourcekey="BoundFieldResource11" />
                                                    <asp:BoundField DataField="TATLeft" HeaderText="DelayLogger" Visible="False" SortExpression="TATLeft"
                                                        meta:resourcekey="BoundFieldResource12" />
                                                    <asp:BoundField DataField="AccessionNumber" Visible="False" HeaderText="AccessionNumber"
                                                        SortExpression="TATLeft" meta:resourcekey="BoundFieldResource13" />
                                                    <asp:BoundField DataField="ModifiedUser" HeaderText="UpdateUser" SortExpression="TATLeft" Visible="true"
                                                        meta:resourcekey="BoundFieldResource14" />
                                                    <asp:BoundField DataField="PatientVisitID" Visible="False" HeaderText="PatientVisitID"
                                                        SortExpression="TATLeft" meta:resourcekey="BoundFieldResource15" />
                                                </Columns>
                                                <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" />
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                            &nbsp;
                                        </td>
                                        <td id="tdTestStatus" runat="server" style="display: none;">
                                            <asp:Label ID="clrstatus" runat="server" Text="&nbsp;" Width="10px" BackColor="Orange"
                                                meta:resourcekey="clrstatusResource1" />
                                            <asp:Label ID="clrstatustxt" runat="server" Text="Investigations Performed In Other Centers"
                                                meta:resourcekey="clrstatustxtResource1" />
                                            <asp:GridView ID="gvTestStatusReport" runat="server" AutoGenerateColumns="False"
                                                HeaderStyle-Height="10px" FooterStyle-Height="10px" AllowPaging="True" PageSize="10"
                                                                CellPadding="1" EmptyDataText="Collection Details Not Available" Font-Names="verdana"  CssClass="gridView w-100p"
                                                                 ShowFooter="True"  OnPageIndexChanging="gvTestStatusReport_PageIndexChanging"
                                                OnRowDataBound="gvTestStatusReport_RowDataBound" DataKeyNames="PatientVisitID,AccessionNumber"
                                                OnRowCommand="Test" meta:resourcekey="gvTestStatusReportResource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.NO" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("RowID") %>' meta:resourcekey="lblSNoResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ReadOnly="True"
                                                        SortExpression="PatientNumber" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="8%"
                                                        meta:resourcekey="BoundFieldResource16" />
                                                    <asp:TemplateField HeaderText=" PatientName " meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkshow" runat="server" Text='<%#Eval("PatientName")%>' CommandName="Mapping"
                                                                Style="color: Black; text-decoration: underline" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                meta:resourcekey="lnkshowResource1"></asp:LinkButton></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ExternalVisitid" HeaderText="VisitNo" ReadOnly="True"
                                                        SortExpression="ExternalVisitID" meta:resourcekey="BoundFieldResource17" />
                                                    <asp:BoundField DataField="RegistrationDTTM" HeaderText="Registration On" ReadOnly="True"
                                                        SortExpression="RegistrationDTTM" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="2%"
                                                        DataFormatString="{0:dd/MM/yyyy hh:mm tt}" meta:resourcekey="BoundFieldResource18" />
                                                    <asp:BoundField DataField="InvestigationName" HeaderText="Test Name" SortExpression="InvestigationName"
                                                        meta:resourcekey="BoundFieldResource19" />
                                                    <asp:BoundField DataField="DeptName" HeaderText="Department " SortExpression="DeptName"
                                                        meta:resourcekey="BoundFieldResource20" />
                                                    <asp:BoundField DataField="SampleCollection" HeaderText="Sample Status" SortExpression="SampleCollection"
                                                        meta:resourcekey="BoundFieldResource21" ItemStyle-Width="8%" />
                                                    <asp:BoundField DataField="ResultCapture" HeaderText="Test Status" SortExpression="ResultCapture"
                                                        meta:resourcekey="BoundFieldResource22" ItemStyle-Width="8%" />
                                                    <asp:BoundField DataField="Approval" Visible="False" HeaderText="Approval" SortExpression="Approval"
                                                        meta:resourcekey="BoundFieldResource23" />
                                                    <asp:BoundField DataField="Location" HeaderText="RegLocation" SortExpression="Location"
                                                        meta:resourcekey="BoundFieldResource24" />
                                                    <asp:BoundField DataField="PerformLocation" HeaderText="Processing Location" SortExpression="PerformLocation"
                                                        meta:resourcekey="BoundFieldResource25" ItemStyle-Width="12%" />
                                                    <asp:BoundField DataField="ClientTypeName" HeaderText="Client type" SortExpression="ClientTypeName"
                                                        meta:resourcekey="BoundFieldResource26" />
                                                    <asp:BoundField DataField="ClientName" HeaderText="Client name" SortExpression="ClientName"
                                                        meta:resourcekey="BoundFieldResource27" />
                                                    <asp:TemplateField HeaderText="TAT closing time" Visible="true" ItemStyle-HorizontalAlign="Center"
                                                        meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTATclosingTime" ItemStyle-Width="10%" Visible="true" runat="server"
                                                                Text='<%# Eval("TATClosingTime").ToString()=="01/01/0001 00:00:00"? "N/A" : Eval("TATClosingTime")%>'
                                                                meta:resourcekey="lblTATclosingTimeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="DelayTime" Visible="true" HeaderText="ModifiedAt" SortExpression="DelayTime"
                                                        meta:resourcekey="BoundFieldResource28" />
                                                    <asp:BoundField DataField="TATLeft" HeaderText="DelayLogger" SortExpression="TATLeft"
                                                        meta:resourcekey="BoundFieldResource29" />
                                                    <asp:BoundField DataField="AccessionNumber" Visible="False" HeaderText="AccessionNumber"
                                                        SortExpression="TATLeft" meta:resourcekey="BoundFieldResource30" />
                                                    <asp:BoundField DataField="ModifiedUser" HeaderText="UpdateUser" SortExpression="TATLeft"
                                                        meta:resourcekey="BoundFieldResource31" />
                                                    <asp:BoundField DataField="PatientVisitID" Visible="False" HeaderText="VisitID" SortExpression="VisitID"
                                                        meta:resourcekey="BoundFieldResource32" />
                                                </Columns>
                                                <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" />
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr id="GrdFooter" runat="server" class="dataheaderInvCtrl" style="display: none;">
                                        <td class="defaultfontcolor a-center">
                                            <asp:Label ID="Label4" runat="server" Text="Page" meta:resourcekey="Label4Resource1"></asp:Label>
                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                            <asp:Label ID="Label5" runat="server" Text="Of" meta:resourcekey="Label5Resource1"></asp:Label>
                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                            <asp:Button ID="btnPrevious" runat="server" CssClass="btn" OnClick="btnPrevious_Click"
                                                Text="Previous" meta:resourcekey="btnPreviousResource1" />
                                            <asp:Button ID="btnNext" runat="server" CssClass="btn" OnClick="btnNext_Click" Text="Next"
                                                meta:resourcekey="btnNextResource1" />
                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                            <asp:Label ID="Label6" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label6Resource1"></asp:Label>
                                            <asp:TextBox ID="txtpageNo" runat="server" AutoComplete="off" Width="30px" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                            <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="btnGo1_Click" OnClientClick="javascript:return checkForValues();"
                                                Text="Go" meta:resourcekey="Button1Resource2" />
                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="dvInvstigationDetails" style="display: block;">
                                                <asp:Panel ID="PanelGroup" runat="server" Style="height: 300px; width: 650px;" CssClass="modalPopup dataheaderPopup"
                                                    meta:resourcekey="PanelGroupResource1">
                                                    <asp:Panel ID="table_GroupItem" runat="server" Style="height: 260px; width: 650px;"
                                                        ScrollBars="Auto" meta:resourcekey="table_GroupItemResource1">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                                    <asp:Table ID="tblEvents" runat="server" class='dataheaderInvCtrl w-100p font11 a-center'
                                                                        nowrap='nowrap' Style='border: none' meta:resourcekey="tblEventsResource1">
                                                                    </asp:Table>
                                                                </td>
                                                                <td>
                                                                    <asp:Table ID="tblDateTime" runat="server" nowrap='nowrap' class='dataheaderInvCtrl w-100p font11 a-center'
                                                                        Style='border: none' meta:resourcekey="tblDateTimeResource1">
                                                                    </asp:Table>
                                                                </td>
                                                                <td>
                                                                    <asp:Table ID="tblUser" runat="server" nowrap='nowrap' class='dataheaderInvCtrl w-100p font11 a-center'
                                                                        Style='border: none' meta:resourcekey="tblUserResource1">
                                                                    </asp:Table>
                                                                </td>
                                                                <td>
                                                                    <asp:Table ID="tblINV" runat="server" nowrap='nowrap' class='dataheaderInvCtrl w-100p font11 a-center'
                                                                        Style='border: none' meta:resourcekey="tblINVResource1">
                                                                    </asp:Table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                    <table class="a-center">
                                                        <tr>
                                                            <td class="a-center">
                                                                <asp:Button ID="btnPnlClose1" runat="server" class="btn" Text="Close" OnClientClick="return popupClose()"
                                                                    meta:resourcekey="btnPnlClose1Resource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <cc1:ModalPopupExtender ID="InvStatusPopup" runat="server" BackgroundCssClass="modalBackground"
                                                    DropShadow="false" PopupControlID="PanelGroup" Enabled="True" TargetControlID="btnDummy">
                                                </cc1:ModalPopupExtender>
                                                <asp:Button type="button" ID="btnDummy" runat="server" Style="display: none;" meta:resourcekey="btnDummyResource1" />
                                            </div>
                                        </td>
                                    </tr>
                                    <asp:HiddenField ID="hdnSetSearchType" runat="server" Value="TS" />
                                    <asp:HiddenField ID="hdnSetSearchReport" runat="server" Value="AR" />
                                    <asp:HiddenField ID="hdnTestName" runat="server" />
                                    <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
                                    <asp:HiddenField ID="hdnTestType" runat="server" />
                                </table>
                            </div>
                            <div id="PrintDuplicatereport" style="font-family: Arial; text-decoration: none;
                                font-size: 10px; position: absolute; width: 98%; overflow: auto; display: none;">
                                <table class="w-100p">
                                    <tr>
                                        <td id="tdduplipat" runat="server" style="display: none;">
                                            <asp:GridView ID="gvDuplicate1" runat="server" AutoGenerateColumns="False" HeaderStyle-Height="25px"
                                                FooterStyle-Height="25px" AllowPaging="false" PageSize="10" CellPadding="1" EmptyDataText=" "
                                                Font-Names="verdana" Font-Size="11px" ShowFooter="True" Width="100%" meta:resourcekey="gvDuplicate1Resource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.NO" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" SortExpression="PatientNumber"
                                                        meta:resourcekey="BoundFieldResource33" ItemStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" SortExpression="PatientName"
                                                        meta:resourcekey="BoundFieldResource34" />
                                                    <asp:BoundField DataField="ExternalVisitid" HeaderText="Visit No" SortExpression="ExternalVisitID"
                                                        meta:resourcekey="BoundFieldResource35" />
                                                    <asp:BoundField DataField="RegistrationDTTM" HeaderText="Registration On" SortExpression="RegistrationDTTM"
                                                        DataFormatString="{0:dd/MM/yyyy hh:mm tt}" meta:resourcekey="BoundFieldResource36" />
                                                        <asp:BoundField DataField="SampleCollection" HeaderText="Sample Collection" SortExpression="SampleCollection"
                                                            meta:resourcekey="BoundFieldResource37" />
                                                        <asp:BoundField DataField="ResultCapture" HeaderText="Result Capture" SortExpression="ResultCapture"
                                                            meta:resourcekey="BoundFieldResource38" />
                                                        <asp:BoundField DataField="Approval" Visible="false" HeaderText="Approval" SortExpression="Approval"
                                                            meta:resourcekey="BoundFieldResource39" />
                                                        <%--  <asp:BoundField DataField="CreatedAT" HeaderText="Created At" 
                                                            SortExpression="CreatedAT" />--%>
                                                        <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"
                                                            meta:resourcekey="BoundFieldResource40" />
                                                        <asp:BoundField DataField="ClientTypeName" HeaderText="Client type" SortExpression="ClientTypeName"
                                                            meta:resourcekey="BoundFieldResource41" />
                                                        <asp:BoundField DataField="ClientName" HeaderText="Client name" SortExpression="ClientName"
                                                            meta:resourcekey="BoundFieldResource42" />
                                                        <asp:BoundField DataField="TestCategory" Visible="False" HeaderText="Test Classification"
                                                            SortExpression="TestCategory" meta:resourcekey="BoundFieldResource43" />
                                                        <asp:TemplateField HeaderText="TAT closing time" meta:resourcekey="TemplateFieldResource6">
                                                            <itemtemplate>
                                                            <asp:Label ID="lblTATclosingTime" runat="server" Text='<%# Eval("TATClosingTime").ToString()=="01/01/0001 00:00:00"? "N/A" : Eval("TATClosingTime") %>'
                                                                meta:resourcekey="lblTATclosingTimeResource2"></asp:Label>
                                                                        </itemtemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="TATLeft" HeaderText="TAT left" SortExpression="TATLeft"
                                                            meta:resourcekey="BoundFieldResource44" />
                                                        <asp:BoundField DataField="TATLeft" HeaderText="DelayLogger" Visible="False" SortExpression="TATLeft"
                                                            meta:resourcekey="BoundFieldResource45" />
                                                        <asp:BoundField DataField="AccessionNumber" Visible="False" HeaderText="AccessionNumber"
                                                            SortExpression="TATLeft" meta:resourcekey="BoundFieldResource46" />
                                                        <asp:BoundField DataField="ModifiedUser" HeaderText="UpdateUser" SortExpression="TATLeft"
                                                            meta:resourcekey="BoundFieldResource47" />
                                                </Columns>
                                                <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" />
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                            &nbsp;
                                        </td>
                                        <td id="tdduplitest" runat="server" style="display: none;">
                                            <asp:GridView ID="gvDuplicate2" runat="server" AutoGenerateColumns="False" HeaderStyle-Height="25px"
                                                FooterStyle-Height="25px" AllowPaging="False" PageSize="10" CellPadding="1" EmptyDataText=" "
                                                Font-Names="verdana" Font-Size="11px" ShowFooter="True" Width="100%" meta:resourcekey="gvDuplicate2Resource1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.NO" meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ReadOnly="True"
                                                        SortExpression="PatientNumber" ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource48" />
                                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" ReadOnly="True"
                                                        SortExpression="PatientName" meta:resourcekey="BoundFieldResource49" />
                                                    <asp:BoundField DataField="ExternalVisitid" HeaderText="Visit No" ReadOnly="True"
                                                        SortExpression="ExternalVisitID" meta:resourcekey="BoundFieldResource50" />
                                                    <asp:BoundField DataField="RegistrationDTTM" HeaderText="Registration On" ReadOnly="True"
                                                        SortExpression="RegistrationDTTM" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                        meta:resourcekey="BoundFieldResource51" />
                                                    <asp:BoundField DataField="InvestigationName" HeaderText="Test Name" SortExpression="InvestigationName"
                                                        meta:resourcekey="BoundFieldResource52" />
                                                    <asp:BoundField DataField="DeptName" HeaderText="Department Name" SortExpression="DeptName"
                                                        meta:resourcekey="BoundFieldResource53" />
                                                    <asp:BoundField DataField="SampleCollection" HeaderText="Sample Collection" SortExpression="SampleCollection"
                                                        meta:resourcekey="BoundFieldResource54" />
                                                    <asp:BoundField DataField="ResultCapture" HeaderText="Result Capture" SortExpression="ResultCapture"
                                                        meta:resourcekey="BoundFieldResource55" />
                                                    <asp:BoundField DataField="Approval" Visible="false" HeaderText="Approval" SortExpression="Approval"
                                                        meta:resourcekey="BoundFieldResource56" />
                                                    <%--  <asp:BoundField DataField="CreatedAT" HeaderText="Created At" 
                                                            SortExpression="CreatedAT" />--%>
                                                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"
                                                        meta:resourcekey="BoundFieldResource57" />
                                                    <asp:BoundField DataField="PerformLocation" HeaderText="Processed Location" SortExpression="PerformLocation" />
                                                    <asp:BoundField DataField="ClientTypeName" HeaderText="Client type" SortExpression="ClientTypeName"
                                                        meta:resourcekey="BoundFieldResource58" />
                                                    <asp:BoundField DataField="ClientName" HeaderText="Client name" SortExpression="ClientName"
                                                        meta:resourcekey="BoundFieldResource59" />
                                                    <asp:BoundField DataField="TestCategory" Visible="False" HeaderText="Test Classification"
                                                        SortExpression="TestCategory" meta:resourcekey="BoundFieldResource60" />
                                                    <asp:TemplateField HeaderText="TAT closing time" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTATclosingTime" runat="server" Text='<%# Eval("TATClosingTime").ToString()=="01/01/0001 00:00:00"? "N/A" : Eval("TATClosingTime") %>'
                                                                meta:resourcekey="lblTATclosingTimeResource3"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientVisitID" Visible="False" HeaderText="VisitID" SortExpression="VisitID"
                                                        meta:resourcekey="BoundFieldResource61" />
                                                    <asp:BoundField DataField="TATLeft" HeaderText="DelayLogger" SortExpression="TATLeft"
                                                        meta:resourcekey="BoundFieldResource62" />
                                                </Columns>
                                                <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" />
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value="PS" />
                                    <asp:HiddenField ID="HiddenField2" runat="server" Value="AR" />
                                </table>
                            </div>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="testStatisticReportTab" runat="server" HeaderText="Test Statistics Report"
                        meta:resourcekey="testStatisticReportTabResource1">
                        <HeaderTemplate>
                            <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_02 %>
                        </HeaderTemplate>
                        <ContentTemplate>
                            <table id="Table1" class="w-100p itemsMainList">
                                <tr>
                                    <td class="a-center">
                                        <div id="divTestStatReport1" runat="server">
                                            <table id="tblTestStatReport" runat="server" class="w-100p">
                                                <tr id="Tr1" runat="server">
                                                    <td id="Td1" class="a-left v-top w-12p" runat="server">
                                                        <asp:Label ID="lblFromDate" runat="server" Font-Size="Small" Text="From :" meta:resourcekey="lblFromDateResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td22" class="a-left v-top w-9p" runat="server">
                                                        <asp:TextBox runat="server" Width="70px" size="25" CssClass="Txtboxsmall" ID="txtFromDate"
                                                            MaxLength="10" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="Td3" class="a-left v-top w-12p" runat="server">
                                                        <asp:Label ID="lblToDate" runat="server" Font-Size="Small" Text="To :" meta:resourcekey="lblToDateResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td4" class="a-left v-top w-10p" runat="server">
                                                        <asp:TextBox ID="txtToDate" Width="70px" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="TdOrgDropDown1" class="a-left v-top w-16p" runat="server">
                                                        <asp:Label ID="lblOrgDropDown" Text="Organization :" runat="server" meta:resourcekey="lblOrgDropDownResource1"></asp:Label>
                                                    </td>
                                                    <td id="TdOrgDropDown2" class="a-left v-top w-12p" runat="server">
                                                        <asp:DropDownList ID="ddlOrganization" runat="server" CssClass="ddlsmall" OnSelectedIndexChanged="ddlOrganization_SelectedIndexChanged"
                                                            AutoPostBack="True" meta:resourcekey="ddlOrganizationResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="Td5" class="a-left v-top w-16p" runat="server">
                                                        <asp:Label ID="lblLocation" Text="Location :" runat="server" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td6" class="a-left v-top w-13p" runat="server">
                                                        <asp:DropDownList ID="drpLocation" runat="server" CssClass="ddlsmall" meta:resourcekey="drpLocationResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="Tr2" runat="server">
                                                    <td id="Td9" class="a-left v-top" runat="server">
                                                        <asp:Label ID="lblInvClientType" runat="server" Text="Client type :" meta:resourcekey="lblInvClientTypeResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td10" class="a-left v-top" runat="server">
                                                        <asp:DropDownList ID="ddlInvClientType" AutoPostBack="True" runat="server" CssClass="ddlsmall"
                                                            OnSelectedIndexChanged="ddlInvClientType_SelectedIndexChanged1" meta:resourcekey="ddlInvClientTypeResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="Td13" valign="top" align="left" runat="server">
                                                        <asp:Label ID="lblInvClientName" Style="display: block;" Text="Client Name :" runat="server"
                                                            meta:resourcekey="lblInvClientNameResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td14" class="a-left v-top" runat="server">
                                                        <asp:TextBox ID="txtInvClientName" onfocus="setInvContextValue();" Style="display: block;"
                                                              OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ClearInvValue(this.id);ConverttoUpperCase(this.id);"
                                                            autocomplete="off" CssClass="Txtboxsmall" runat="server" Width="120px" meta:resourcekey="txtInvClientNameResource1"></asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtInvClientName"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                            OnClientItemSelected="SelectedInvClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                            Enabled="True">
                                                        </cc1:AutoCompleteExtender>
                                                    </td>
                                                    <td runat="server" class="a-left v-top">
                                                        <asp:Label ID="lblReferingOrg" Text="Reference Hospital :" runat="server" meta:resourcekey="lblReferingOrgResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server" class="a-left v-top">
                                                        <asp:TextBox ID="txtReferringHospital" runat="server" CssClass="Txtboxsmall" onfocus="return SetRefContextValue();"
                                                            onBlur="return ClearFields();" Width="120px" meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                            TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                                            CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingOrgID"
                                                            DelimiterCharacters="" Enabled="True">
                                                        </cc1:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnReferringHospitalID" runat="server" Value="0" />
                                                    </td>
                                                    <td runat="server" class="a-left v-top">
                                                        <asp:Label ID="lblReferringPhysician" Text="Referring Physician :" runat="server"
                                                            meta:resourcekey="lblReferringPhysicianResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server" class="a-left v-top">
                                                        <asp:TextBox ID="txtReferringPhysician" Width="120px" runat="server" onfocus="return SetRefContextValue();"
                                                            CssClass="Txtboxsmall" onBlur="return ClearFields();" meta:resourcekey="txtReferringPhysicianResource1"></asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtenderReferringPhysician" runat="server"
                                                            TargetControlID="txtReferringPhysician" EnableCaching="False" FirstRowSelected="True"
                                                            CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="GetReferingPhysicianID"
                                                            DelimiterCharacters="" Enabled="True">
                                                        </cc1:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnPhysicianID" Value="0" runat="server"></asp:HiddenField>
                                                        <asp:HiddenField ID="hdnMessages" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left v-top" runat="server">
                                                        <asp:Label ID="lblInvTestcategory" Text="Test category :" runat="server" meta:resourcekey="lblInvTestcategoryResource1"></asp:Label>
                                                    </td>
                                                    <td valign="top" runat="server" align="left">
                                                        <asp:DropDownList ID="ddlInvTestcategory" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlInvTestcategoryResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="Td7" class="a-left v-top" runat="server">
                                                        <asp:Label ID="lblStatTestName" Text="Test Name :" runat="server" meta:resourcekey="lblStatTestNameResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td8" class="a-left v-top" runat="server">
                                                        <asp:TextBox ID="txtTestStatName" CssClass="Txtboxsmall" Width="120px" runat="server"
                                                            meta:resourcekey="txtTestStatNameResource1"></asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                                            TargetControlID="txtTestStatName" ServiceMethod="FetchInvestigationNameForOrg"
                                                            ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                            OnClientItemSelected="SelectedStatTest" OnClientItemOver="SelectedStatTesttemp"
                                                            DelimiterCharacters="">
                                                        </cc1:AutoCompleteExtender>
                                                    </td>
                                                    <td id="Td11" class="a-left v-top" runat="server" colspan="2">
                                                        <asp:Label ID="lblReportType" runat="server" Text=" Report Type :" meta:resourcekey="lblReportTypeResource1"></asp:Label>
                                                        <asp:RadioButton ID="rdoSummary" onclick="checkReportType(this.id);" runat="server"
                                                            Text="Summary" meta:resourcekey="rdoSummaryResource1" />
                                                        &nbsp;<asp:RadioButton ID="rdoDetail" onclick="checkReportType(this.id);" runat="server"
                                                            Text="Detailed" meta:resourcekey="rdoDetailResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="Table2" runat="server" class="w-100p">
                                                <tr id="Tr5" runat="server">
                                                    <td id="Td15" class="a-left" runat="server">
                                                        <asp:Panel ID="pnlDepts" runat="server" CssClass="w-100p" GroupingText="Departments :"
                                                            Font-Bold="true" meta:resourcekey="Panel1Resource1">
                                                            <table id="tblDepts" runat="server" class="w-100p">
                                                                <tr id="Tr6" runat="server">
                                                                    <td id="Td16" runat="server">
                                                                        <asp:CheckBox ID="chkSelAll" runat="server" Text="Select All" onclick="SelectAllDepts(this);"
                                                                            Checked="True" meta:resourcekey="chkSelAllResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr id="Tr7" runat="server">
                                                                    <td id="Td17" runat="server">
                                                                        <asp:CheckBoxList ID="chkDept" Font-Size="Smaller" DataTextField="DeptName" DataValueField="DeptID"
                                                                            runat="server" RepeatColumns="7">
                                                                        </asp:CheckBoxList>
                                                                    </td>
                                                                </tr>
                                                                <tr id="Tr8" runat="server">
                                                                    <td id="Td18" class="a-center" runat="server">
                                                                        <asp:Button ID="btnSearchStat" runat="server" CssClass="btn" OnClick="btnSearchStat_Click"
                                                                            OnClientClick="return ChkSearchLocation();" onmouseout="this.className='btn'"
                                                                            onmouseover="this.className='btn btnhov'" Text="Search" meta:resourcekey="btnSearchResource1"/>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td2" class="a-right v-top w-10p" runat="server">
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click" Text="Back" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center">
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_35%>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr id="trLabTestStatReportDetail" runat="server">
                                    <td id="Td20" runat="server" style="display: block;">
                                    </td>
                                </tr>
                                <tr id="trLabTestStatReportSummary" runat="server">
                                    <td id="Td21" runat="server">
                                        <asp:Panel ID="pnlSummary" runat="server" meta:resourcekey="pnlSummaryResource1">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <tbody>
                                                            <asp:Repeater ID="rptSummary" runat="server">
                                                                <ItemTemplate>
                                                                    <asp:Panel ID="Panel2" Direction="NotSet" HorizontalAlign="Center" Font-Bold="False"
                                                                        runat="server" meta:resourcekey="Panel2Resource1">
                                                                        <table class="dataheader2 w-100p">
                                                                            <tr>
                                                                                <td colspan="2" class="a-center w-100p v-top">
                                                                                    <asp:Label ID="lblLoc" runat="server" Font-Bold="true" meta:resourcekey="lblLocResource1"></asp:Label>
                                                                                    <asp:Label ID="lblLoc1" Font-Bold="true" runat="server" Text='<%#Eval("Location")%>'></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" class="a-right w-100p v-top">
                                                                                <asp:Label ID="lbltotalT" runat="server" Text="Total Test Count  : " meta:resourcekey="lbltotalTResource1"></asp:Label>
                                                                                    <asp:Label ID="lblTotalCount" runat="server" Font-Bold="true" Text='<%# (Convert.ToInt32(Eval("NormalTestCount").ToString()) +
                                                                                                        Convert.ToInt32(Eval("AbnormalTestCount").ToString()) +
                                                                                                        Convert.ToInt32(Eval("CriticalTestCount").ToString()) +
                                                                                                        Convert.ToInt32(Eval("UnSpecifiedTestCount").ToString())) %>'
                                                                                        meta:resourcekey="lblTotalCountResource1"></asp:Label>
                                                                                    <br />
                                                                                    <br />
                                                                                </td>
                                                                            </tr>
                                                                            <caption>
                                                                                <tr class="h-17">
                                                                                    <td class="v-top a-left" align="left w-80p" rowspan="6">
                                                                                        <asp:Label ID="lblResultValueType" runat="server" Font-Bold="True" Font-Size="Small"
                                                                                            Text="Result Value Type " meta:resourcekey="lblResultValueTypeResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-right w-20p" colspan="2" rowspan="6">
                                                                                    <asp:Label ID="lblNormT" runat="server" Text="Test with Normal/WNL Results  :  " meta:resourcekey="lblNormTResource1"></asp:Label>
                                                                                        <asp:Label ID="lblNormalCount" runat="server" Text='<%#Eval("NormalTestCount") %>'
                                                                                            meta:resourcekey="lblNormalCountResource1"></asp:Label>
                                                                                        <br />
                                                                                        <asp:Label ID="lblAbnorT" runat="server" Text="Test with Abnormal Results  :  " meta:resourcekey="lblAbnorTResource1"></asp:Label>
                                                                                        <asp:Label ID="lblAbnormalCount" runat="server" Text='<%#Eval("AbnormalTestCount") %>'
                                                                                            meta:resourcekey="lblAbnormalCountResource1"></asp:Label>
                                                                                        <br />
                                                                                        <asp:Label ID="lblCriCountT" runat="server" Text="Test with Critical Results  :  " meta:resourcekey="lblCriCountTResource1"></asp:Label>
                                                                                        <asp:Label ID="lblCriticalCount" runat="server" Text='<%# Eval("CriticalTestCount") %>'
                                                                                            meta:resourcekey="lblCriticalCountResource1"></asp:Label>
                                                                                        <br />
                                                                                        <asp:Label ID="lblTestUnT" runat="server" Text="Test with Unspecified Results  : " meta:resourcekey="lblTestUnTResource1"></asp:Label>
                                                                                        <asp:Label ID="lblUnspecifiedCount" runat="server" Text='<%#  Eval("UnSpecifiedTestCount") %>'
                                                                                            meta:resourcekey="lblUnspecifiedCountResource1"></asp:Label>
                                                                                        <br />
                                                                                        <br />
                                                                                    </td>
                                                                                </tr>
                                                                            </caption>
                                                                            <caption>
                                                                                <tr class="h-17">
                                                                                    <td rowspan="5" class="v-top a-left" align="left w-80p">
                                                                                        <asp:Label ID="lblAdditionalTesting" runat="server" Font-Bold="True" Font-Size="Small"
                                                                                            Text="Additional Testing " meta:resourcekey="lblAdditionalTestingResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-right w-20p" rowspan="5">
                                                                                     <asp:Label ID="lblRetestCount1" runat="server" Text="Retest Count  : "  meta:resourcekey="lblRetestCount1Resource1"></asp:Label>
                                                                                        <asp:Label ID="lblRetestCount" runat="server" Text='<%#  Eval("ReTestCount") %>'
                                                                                            meta:resourcekey="lblRetestCountResource1"></asp:Label>
                                                                                        <br />
                                                                                         <asp:Label ID="lblReflectTestCount1" runat="server" Text="Reflex Test Count  :  " meta:resourcekey="lblReflectTestCount1Resource1"></asp:Label>
                                                                                        <asp:Label ID="lblReflectTestCount" runat="server" Text='<%#  Eval("ReflexTestCount") %>'
                                                                                            meta:resourcekey="lblReflectTestCountResource1"></asp:Label>
                                                                                        <br />
                                                                                         <asp:Label ID="lblDilutionTestCount1" runat="server" Text="Dilution Test Count  :  " meta:resourcekey="lblDilutionTestCount1Resource1"></asp:Label>
                                                                                        <asp:Label ID="lblDilutionTestCount" runat="server" Text='<%# Eval("DilutionTestCount") %>'
                                                                                            meta:resourcekey="lblDilutionTestCountResource1"></asp:Label>
                                                                                        <br />
                                                                                        <asp:Label ID="lblQCTestCount1" runat="server" Text="QC Test Count  :  " meta:resourcekey="lblQCTestCount1Resource1"></asp:Label>
                                                                                        <asp:Label ID="lblQCTestCount" runat="server" Text='<%# Eval("QCTestCount") %>'
                                                                                            meta:resourcekey="lblQCTestCountResource1"></asp:Label>
                                                                                        <br />
                                                                                        <br />
                                                                                    </td>
                                                                                </tr>
                                                                            </caption>
                                                                            <caption>
                                                                                <tr class="h-17">
                                                                                    <td rowspan="3" class="v-top a-left" align="left w-80p">
                                                                                        <asp:Label ID="lblTestingProcess" runat="server" Font-Bold="True" Font-Size="Small"
                                                                                            Text="Testing Process" meta:resourcekey="lblTestingProcessResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-right w-20p" rowspan="3">
                                                                                    <asp:Label ID="lblManualProcessedTest1" runat="server" Text="Manual Processed Test  :  " meta:resourcekey="lblManualProcessedTest1Resource1"></asp:Label>
                                                                                        <asp:Label ID="lblManualProcessedTest" runat="server" Text='<%#  Eval("ManualTestCount") %>'
                                                                                            meta:resourcekey="lblManualProcessedTestResource1"></asp:Label>
                                                                                        <br />
                                                                                        <asp:Label ID="lblInterfacedTest1" runat="server" Text="Interfaced Test  :  " meta:resourcekey="lblInterfacedTest1Resource1"></asp:Label>
                                                                                        <asp:Label ID="lblInterfacedTest" runat="server" Text='<%# Eval("InterfacedTestCount") %>'></asp:Label>
                                                                                        <br />
                                                                                        <br />
                                                                                    </td>
                                                                                </tr>
                                                                            </caption>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </tbody>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="hdnNormalTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnAbnormalTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnCriticalTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnUnSpecifiedTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnReTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnReflexTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnDilutionTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnQCTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnManualTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnInterfacedTestCount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnGrandTot" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnInvSelectedClientID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnStatTestName" runat="server" />
                            <asp:HiddenField ID="hdnStatTestID" Value="0" runat="server" />
                            <asp:HiddenField ID="hdnStatTestType" runat="server" />
                            <asp:HiddenField ID="hdnPrintState" runat="server" />
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="VisitwiseSearch" runat="server" HeaderText="Visitwise Search" meta:resourcekey="VisitwiseSearchResource1">
                        <%--<HeaderTemplate>
                            Visitwise Search
                        </HeaderTemplate>--%>
                        <ContentTemplate>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <table id="Visitwise" runat="server" class="w-98p searchPanel">
                                        <tr id="Tr3" runat="server">
                                            <td id="Td12" runat="server" class="v-top w-13p a-left">
                                                <asp:Label ID="lblOrganization" runat="server" Text="Organization : " meta:resourcekey="lblOrgResource1"></asp:Label>
                                            </td>
                                            <td id="Td19" runat="server" class="v-top w-14p a-left">
                                                <asp:DropDownList ID="ddlorgan" runat="server" AutoPostBack="True" CssClass="ddl"
                                                    OnSelectedIndexChanged="ddlOrgan_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td id="Td23" runat="server" class="v-top w-15p a-left">
                                                <asp:Label ID="Label8" runat="server" Text="Location : " meta:resourcekey="lblLocResource1"></asp:Label>
                                            </td>
                                            <td id="Td24" runat="server" class="v-top w-14p a-left">
                                                <asp:DropDownList ID="ddlloca" runat="server" CssClass="ddl">
                                                </asp:DropDownList>
                                            </td>
                                            <td id="Td25" runat="server" class="v-top a-left">
                                                <asp:Label ID="Label9" runat="server" Text="Visit Type : " meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                            </td>
                                            <td id="Td26" runat="server" class="v-top a-left">
                                                <asp:DropDownList ID="DropDownList3" runat="server" CssClass="ddl">
                                                  <%--  <asp:ListItem Selected="True" Text="ALL" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Stat" Value="1"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </td>
                                            <td id="Td27" runat="server" class="v-top a-left">
                                                <asp:Label ID="lblVisitStatus" runat="server" Text="Visit Status : " meta:resourcekey="lblVisitStatusResource1" ></asp:Label>
                                            </td>
                                            <td id="Td28" runat="server" class="v-top a-left">
                                                <asp:DropDownList ID="ddlVisitStatus" runat="server" CssClass="ddl">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="Tr4" runat="server">
                                            <td id="Td29" runat="server" class="v-top w-12p a-left">
                                                <asp:Label ID="lblPatientName" runat="server" Text="Patient Name : " meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                            </td>
                                            <td id="Td30" runat="server" class="v-top w-17p a-left">
                                                <asp:TextBox ID="txtPatientName" runat="server" onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);"
                                                    OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                    CssClass="AutoCompletesearchBox" Style="width: 132px;"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                                    FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box autocompletehide"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    EnableCaching="False" MinimumPrefixLength="1" ServiceMethod="GetPatientListWithDetails"
                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" OnClientItemSelected="SelectedPatient">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td id="Td31" runat="server" class="v-top w-12p a-left">
                                                <asp:Label ID="lblVisitNo" runat="server" Text="Lab Number : " meta:resourcekey="lblVisitNoResource1" ></asp:Label>
                                            </td>
                                            <td id="Td32" runat="server" class="v-top w-14p a-left">
                                                <asp:TextBox ID="txtVisitNo" runat="server" CssClass="Txtboxsmall" MaxLength="16"
                                                    onkeypress="return ValidateOnlyNumeric(this);"></asp:TextBox>
                                            </td>
                                            <td id="Td33" runat="server" class="v-top w-12p a-left">
                                                <asp:Label ID="lblReferenceNo" runat="server" Text="PatientNo : " meta:resourcekey="lblReferenceNoResource1"></asp:Label>
                                            </td>
                                            <td id="Td34" runat="server" class="v-top w-14p a-left">
                                                <asp:TextBox ID="txtReferenceNo" runat="server" CssClass="Txtboxsmall" MaxLength="16"
                                                    onkeypress="return ValidateOnlyNumeric(this);"></asp:TextBox>
                                            </td>
                                            <td id="Td35" runat="server" class="v-top w-12p a-left">
                                                <asp:Label ID="lblIdentityNumber" runat="server" Text="Mobile Number : " meta:resourcekey="lblIdentityNumberResource1"></asp:Label>
                                            </td>
                                            <td id="Td36" runat="server" class="v-top w-14p a-left">
                                                <asp:TextBox ID="txtIdentityNumber" runat="server" CssClass="Txtboxsmall" MaxLength="16"
                                                    onkeypress="return ValidateOnlyNumeric(this);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="Tr9" runat="server">
                                            <td id="Td37" runat="server" class="a-left v-top">
                                                <asp:Label ID="lblClientName" runat="server" Style="display: block;" Text="Client Name : " meta:resourcekey="lblClientNameResource1"></asp:Label>
                                            </td>
                                            <td id="Td38" runat="server" class="a-left v-top">
                                                <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox"
                                                    onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" onfocus="setContextClientNameValue();"
                                                    OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                    Style="display: block; width: 132px;"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientName" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain .box autocompletehide" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="SelectedClientID1"
                                                    ServiceMethod="GetClientList" ServicePath="~/WebService.asmx" TargetControlID="txtClientName">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td id="Td39" runat="server" class="a-left v-top">
                                                <asp:Label ID="Label10" runat="server" Style="display: block;" Text="Ref. Physician : " meta:resourcekey="Label10Resource1"></asp:Label>
                                            </td>
                                            <td id="Td40" runat="server" class="a-left v-top">
                                                <asp:TextBox ID="txtrefphy" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox"
                                                    onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" onfocus="setContextValue1();"
                                                    OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                    Style="display: inline; width: 132px;"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain .box autocompletehide" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="RefPhysicianSelected1"
                                                    ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtrefphy">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td id="Td41" runat="server" class="v-top a-left">
                                                <asp:Label ID="Label11" runat="server" Text="From : " meta:resourcekey="Label11Resource1"></asp:Label>
                                            </td>
                                            <td id="Td42" runat="server" class="v-top a-left">
                                                <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True" CssClass="Txtboxsmall"
                                                    size="25" Width="126px"></asp:TextBox>
                                                <a href="javascript:NewCssCall('<%=TextBox2.ClientID %>','ddMMMyyyy','arrow',true,12,'Y','Y','Y')">
                                                    <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                            </td>
                                            <td id="Td43" runat="server" class="v-top a-left">
                                                <asp:Label ID="Label12" runat="server" Text="To : " meta:resourcekey="Label12Resource1"></asp:Label>
                                            </td>
                                            <td id="Td44" runat="server" class="v-top a-left">
                                                <asp:TextBox ID="TextBox3" runat="server" ReadOnly="True" CssClass="Txtboxsmall"
                                                    size="25" Width="126px"></asp:TextBox>
                                                <a href="javascript:NewCssCall('<%=TextBox3.ClientID %>','ddMMMyyyy','arrow',true,12,'Y','Y','Y')">
                                                    <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                            </td>
                                        </tr>
                                        <tr id="Tr10" runat="server">
                                            <td id="Td45" runat="server" class="a-center" colspan="8">
                                                <asp:Button ID="btnSrarch" runat="server" CssClass="btn" OnClientClick="javascript:return GetResult();"
                                                    onmouseout="this.className='btn1'" onmouseover="this.className='btn1 btnhov'"
                                                    Text="Search" meta:resourcekey="btnSrarchResource1" />
                                                <asp:Button ID="btnClear" runat="server" Width="50px" CssClass="btn" OnClientClick="return ClearValues();"
                                                    onmouseout="this.className='btn1'" onmouseover="this.className='btn1 btnhov'"
                                                    Text="Clear" meta:resourcekey="btnClearResource1"  />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%">
                                        <tr>
                                            <td id="tdVisitWiseSerach" runat="server" style="display: none;" >
                                                <div>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <input id="txtNormal" name="Normal" type="text" style="background-color: #FFFFFF;
                                                                    width: 10px;" /><span><%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_30%></span>
                                                                <input id="txtLowerHigher" name="LowerHigher" type="text" style="background-color: #FFFF00;
                                                                    width: 10px;" /><span><%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_31%></span>
                                                                <input id='txtPanic" ' name="Panic" type="text" style="background-color: #FF0000;
                                                                    width: 10px;" /><span><%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_32%></span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="VisitWiseSerach" style="overflow-y: scroll; height: 440px;">
                                                    <ajc:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                                        PopupControlID="pnlPopup" DynamicServicePath="" Enabled="True" />
                                                    <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Width="95%" 
                                                        BackImageUrl="~/Images/Loader.gif">
                                                    </asp:Panel>
                                                    
                                                    <table id="ReportDetails" style="display: none; font-family:verdana;border-collapse:collapse; font-size:small" cellspacing="0" cellpadding="1" rules="all" border="1" >
                                                        <thead>
                                                            <tr>
                                                                <th class="a-center">
                                                                    <%--S No--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_11%>
                                                                </th>
                                                                <th class="a-center">
                                                                   <%-- Patient Name--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_12%>
                                                                </th>
                                                                <th class="a-center">
                                                                   <%-- Age/Gender--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_13 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Number--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_14 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Location--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_15%>
                                                                </th>
                                                                <th class="a-center">
                                                                   <%-- Ref Physician--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_16%>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Client Name--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_17%>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Test Requested--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_18%>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Receipt No--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_18 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Total Amount--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_19 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Receipt Status--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_20%>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--E-Mail--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_21 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--SMS--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_22 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Printed--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_23%>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Print--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_24 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--PDF--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_25%>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--Mail--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_26 %>
                                                                </th>
                                                                <th class="a-center">
                                                                    <%--OrderedServices--%>
                                                                    <%= Resources.Investigation_ClientDisplay.Investigation_InvestigationStatusReport_aspx_27 %>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
                                    <input id="hdnReferedPhyName" runat="server" type="hidden" />
                                    <input id="hdnReferedPhysicianCode" runat="server" type="hidden" value="0" />
                                    <input id="hdnReferedPhyType" runat="server" type="hidden" />
                                    <input id="hdnClientId" runat="server" type="hidden" value="0" />
                                    <input id="hdnSelectedPatient" runat="server" type="hidden" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                                    <ajc:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                                        TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                                        CancelControlID="img1" DynamicServicePath="" Enabled="True">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                                        runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                                        <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label13" runat="server" Text="Email Report"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                            style="cursor: pointer;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="vertical-align: middle;">
                                                    <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                                        runat="server" />
                                                    <asp:TextBox ID="txtorgid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                                    <asp:TextBox ID="txtLocid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                                    <asp:TextBox ID="txtvisitid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                                    <asp:TextBox ID="txtroleid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                                    <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                                        <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                                            meta:resourcekey="lblMailAddressHintResource1" />
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="Send" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return CheckEmpty();" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                          </asp:Panel>
                                        <asp:Button ID="btnTarget" runat="server" Style="display: none;" />
                                        
        <asp:panel id="pnlOthers" runat="server" style="display: none; height: 600px; width: 1050px;
            vertical-align: bottom; top: 80px;">
	
            <div id="divFullImage">
                <table border="0" cellpadding="2" cellspacing="1" width="100%">
                    <tr id="trPDF">
		<td>
                            <iframe id="ifPDF" style="display: none; border: 1;" width="1000" height="550"></iframe>
                        </td>
	</tr>
	
                    <tr>
                        <td align="center">
                            <input name="btnClose" type="button" id="btnClose" class="btn" value="Close" />
                        </td>
                    </tr>
                </table>
            </div>
            </asp:panel>
        
                                  
                                    <cc1:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
            BackgroundCssClass="modalBackground" DropShadow="false" PopupControlID="pnlOthers"
            CancelControlID="btnClose" TargetControlID="btnTarget" Enabled="True">
        </cc1:ModalPopupExtender>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </cc1:TabPanel>
                </cc1:TabContainer>
                <div id="divTestStatReport" runat="server">
                    <asp:GridView ID="grdLabTestStatReport" runat="server" AutoGenerateColumns="False"
                        AllowPaging="false" CellPadding="1" EmptyDataText="Details Not Available" Font-Names="verdana"
                        Font-Size="11px" ShowFooter="True" Width="100%" OnRowDataBound="grdLabTestStatReport_RowDataBound"
                        meta:resourcekey="grdLabTestStatReportResource1">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource9">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="3%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Test name" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:Label ID="lblTestName" runat="server" Text='<%# Eval("InvestigationName") %>'
                                        meta:resourcekey="lblTestNameResource2"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="22%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Department" meta:resourcekey="TemplateFieldResource11">
                                <ItemTemplate>
                                    <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("DeptName") %>' meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="11%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Location" meta:resourcekey="TemplateFieldResource12">
                                <FooterTemplate>
                                    <asp:Label ID="lblGrandRowTot" runat="server" Text="Grand Total" meta:resourcekey="lblGrandRowTotResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>' meta:resourcekey="lblLocationResource2"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="8%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ClientName" meta:resourcekey="TemplateFieldResource13">
                                <ItemTemplate>
                                    <asp:Label ID="lblClientName" runat="server" Text='<%# Eval("ClientName") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="8%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ref Hospital" meta:resourcekey="TemplateFieldResource14">
                                <ItemTemplate>
                                    <asp:Label ID="lblRefHospital" runat="server" Text='<%# Eval("RefHospital") %>' meta:resourcekey="lblRefHospitalResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="8%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ref Physician" meta:resourcekey="TemplateFieldResource15">
                                <ItemTemplate>
                                    <asp:Label ID="lblRefPhysician" runat="server" Text='<%# Eval("RefPhysician") %>'
                                        meta:resourcekey="lblRefPhysicianResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="8%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Normal" meta:resourcekey="TemplateFieldResource16">
                                <FooterTemplate>
                                    <asp:Label ID="lblNormalTest" runat="server" Text="0" meta:resourcekey="lblNormalTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblNormalTestCount" runat="server" Text='<%# Eval("NormalTestCount") %>'
                                        meta:resourcekey="lblNormalTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Abnormal" meta:resourcekey="TemplateFieldResource17">
                                <FooterTemplate>
                                    <asp:Label ID="lblAbnormalTest" runat="server" Text="0" meta:resourcekey="lblAbnormalTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAbnormalTestCount" runat="server" Text='<%# Eval("AbnormalTestCount") %>'
                                        meta:resourcekey="lblAbnormalTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Critical" meta:resourcekey="TemplateFieldResource18">
                                <FooterTemplate>
                                    <asp:Label ID="lblCriticalTest" runat="server" Text="0" meta:resourcekey="lblCriticalTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCriticalTestCount" runat="server" Text='<%# Eval("CriticalTestCount") %>'
                                        meta:resourcekey="lblCriticalTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Unspecified" meta:resourcekey="TemplateFieldResource19">
                                <FooterTemplate>
                                    <asp:Label ID="lblUnSpecifiedTest" runat="server" Text="0" meta:resourcekey="lblUnSpecifiedTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblUnSpecifiedTestCount" runat="server" Text='<%# Eval("UnSpecifiedTestCount") %>'
                                        meta:resourcekey="lblUnSpecifiedTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Retest" meta:resourcekey="TemplateFieldResource20">
                                <FooterTemplate>
                                    <asp:Label ID="lblReTest" runat="server" Text="0" meta:resourcekey="lblReTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblReTestCount" runat="server" Text='<%# Eval("ReTestCount") %>' meta:resourcekey="lblReTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reflex" meta:resourcekey="TemplateFieldResource21">
                                <FooterTemplate>
                                    <asp:Label ID="lblReflexTest" runat="server" Text="0" meta:resourcekey="lblReflexTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblReflexTestCount" runat="server" Text='<%# Eval("ReflexTestCount") %>'
                                        meta:resourcekey="lblReflexTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dilution" meta:resourcekey="TemplateFieldResource22">
                                <FooterTemplate>
                                    <asp:Label ID="lblDilutionTest" runat="server" Text="0" meta:resourcekey="lblDilutionTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDilutionTestCount" runat="server" Text='<%# Eval("DilutionTestCount") %>'
                                        meta:resourcekey="lblDilutionTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="QC" meta:resourcekey="TemplateFieldResource23">
                                <FooterTemplate>
                                    <asp:Label ID="lblQCTest" runat="server" Text="0" meta:resourcekey="lblQCTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblQCTestCount" runat="server" Text='<%# Eval("QCTestCount") %>' meta:resourcekey="lblQCTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Manual" meta:resourcekey="TemplateFieldResource24">
                                <FooterTemplate>
                                    <asp:Label ID="lblManualTest" runat="server" Text="0" meta:resourcekey="lblManualTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblManualTestCount" runat="server" Text='<%# Eval("ManualTestCount") %>'
                                        meta:resourcekey="lblManualTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Interfaced" meta:resourcekey="TemplateFieldResource25">
                                <FooterTemplate>
                                    <asp:Label ID="lblInterfacedTest" runat="server" Text="0" meta:resourcekey="lblInterfacedTestResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblInterfacedTestCount" runat="server" Text='<%# Eval("InterfacedTestCount") %>'
                                        meta:resourcekey="lblInterfacedTestCountResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total" meta:resourcekey="TemplateFieldResource26">
                                <FooterTemplate>
                                    <asp:HiddenField ID="hdnRowTotal" runat="server" Value="0" />
                                    <asp:Label ID="lblGrandRowTotal" runat="server" Text="0" meta:resourcekey="lblGrandRowTotalResource1"></asp:Label>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblRowTotal" Font-Bold="true" runat="server" Text='<%# GetRowTotal(Eval("NormalTestCount"),Eval("AbnormalTestCount"),
                                                                            Eval("CriticalTestCount"),Eval("UnSpecifiedTestCount"),Eval("ReTestCount"),Eval("ReflexTestCount"),
                                                                            Eval("DilutionTestCount"),Eval("QCTestCount"),Eval("ManualTestCount"),Eval("InterfacedTestCount")) %>'
                                        meta:resourcekey="lblRowTotalResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="15%" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" Height="25px" />
                        <HeaderStyle CssClass="dataheader1" Height="25px" />
                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="iframeplaceholder">
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnhidegrid" runat="server" Value="N" />
    <asp:HiddenField ID="HdnOrgZoneTime" runat="server" Value="" />
    </form>
</body>
</html>

<script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

<script type="text/javascript" language="javascript">

    function expandDropDownList1(elementRef) {
        elementRef.style.width = '400px';
    }

    function collapseDropDownList(elementRef) {
        elementRef.style.width = elementRef.normalWidth;
    }
</script>

<%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>
--%>
<%--<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>
--%>

<script language="javascript" type="text/javascript">

    function pageLoad() {
        $("#grouptab_InvestigationStatusReportTab_txtFrom").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        }); // Will run at every postback/AsyncPostback
        $("#grouptab_InvestigationStatusReportTab_txtTo").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });

        $("#grouptab_testStatisticReportTab_txtFromDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        }); // Will run at every postback/AsyncPostback
        $("#grouptab_testStatisticReportTab_txtToDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });

    }
    function popupClose() {
        return true;
    }
    $(function() {
        $("#grouptab_InvestigationStatusReportTab_txtFrom").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });
        $("#grouptab_InvestigationStatusReportTab_txtTo").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        })

        $("#grouptab_testStatisticReportTab_txtFromDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        });
        $("#grouptab_testStatisticReportTab_txtToDate").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '2008:2050'
        })
    }); 

    function GetResult() {
        //debugger;
        try {
            var pop = $find("grouptab_VisitwiseSearch_mdlPopup");
             pop.show();
             $('#grouptab_VisitwiseSearch_statusProgess').show();
            var Orgid = $('#grouptab_VisitwiseSearch_ddlorgan').val();
            var Location = $('#grouptab_VisitwiseSearch_ddlloca').val();
            var VisitType = $('#grouptab_VisitwiseSearch_DropDownList3').val();
            var VisitStatus = $('#grouptab_VisitwiseSearch_ddlVisitStatus option:selected').text();
            var PatientId = '0';
            if ($('#grouptab_VisitwiseSearch_txtPatientName').val() != '') {
                PatientId = $('#grouptab_VisitwiseSearch_hdnSelectedPatient').val();
            }
            var VisitNo = $('#grouptab_VisitwiseSearch_txtVisitNo').val();
            var ReferenceNo = $('#grouptab_VisitwiseSearch_txtReferenceNo').val();
            var MobileNumber = $('#grouptab_VisitwiseSearch_txtIdentityNumber').val();
            var ClientID = '0';
            if ($('#grouptab_VisitwiseSearch_txtClientName').val() != '') {
                ClientID = $('#grouptab_VisitwiseSearch_hdnClientId').val();
            }
            var RefPhyID = '0';
            if ($('#grouptab_VisitwiseSearch_txtReferringPhysician').val() != '') {
                RefPhyID = $('#grouptab_VisitwiseSearch_hdnReferedPhyID').val();
            }
            var FromDate = $('#grouptab_VisitwiseSearch_TextBox2').val();
            var ToDate = $('#grouptab_VisitwiseSearch_TextBox3').val();

            if (VisitNo == 'Visit Number') {
                VisitNo = '';
            }
            if (MobileNumber == '' || MobileNumber == 'Mobile Number') {
                MobileNumber = 0;
            }

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetVisitWiseSearchMISReport",
                contentType: "application/json; charset=utf-8",
                // data: "{ Orgid: '" + Orgid + "',Location: '" + Location + "',VisitType: " + VisitType + "}",
                data: "{ Orgid: '" + Orgid + "',Location: '" + Location + "',VisitType: '" + VisitType +
                 "',VisitStatus: '" + VisitStatus + "',PatientId: '" + PatientId + "',VisitNo: '" + VisitNo + "',ReferenceNo: '"
                 + ReferenceNo + "',MobileNumber: '" + MobileNumber + "',ClientID: '" + ClientID + "',RefPhyID: '" + RefPhyID + "',FromDate: '"
                 + FromDate + "',ToDate: '" + ToDate + "'}",
                dataType: "json",
                success: AjaxDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    $('#grouptab_VisitwiseSearch_ReportDetails').hide();
                     pop.hide();
                    // Watermark();
                    $('#grouptab_VisitwiseSearch_tdVisitWiseSerach').hide();
                    $('#grouptab_VisitwiseSearch_statusProgess').hide();

                    return false;
                }
            });

        }
        catch (e) {
            pop.hide();
            $('#grouptab_VisitwiseSearch_statusProgess').hide();
            $('#tdVisitWiseSerach').hide();
        }

        return false;
    }
    function AjaxDataSucceeded(result) {
        // debugger;
        var strMonth = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_062") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_062") : "Month(s)";
        var strWeek = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_063") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_063") : "Week(s)";
        var strYear = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_064") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_064") : "Year(s)";
        var strDay = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_061") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_061") : "Day(s)";
        $('#VisitWiseSerach').show();
       // $('#Export_XL').hide(); 
        $('#grouptab_VisitwiseSearch_tdVisitWiseSerach').show();
        var pop = $find("grouptab_VisitwiseSearch_mdlPopup");
        var oTableTools;
        var countR = result.d.length;
        //Vijayalakshmi.M
        for (i = 0; i < result.d.length; i++) {
            if (result.d[i].Age != '' && result.d[i].Age != null) {
                var age = result.d[i].Age.split('/');
                var age1 = age[0].split(' ');
                if (age1[1] == "Year(s)") {
                    result.d[i].Age = age1[0] + ' ' + strYear + '/' + age[1];
                }
                else if (age1[1] == "Month(s)") {
                    result.d[i].Age = age1[0] + ' ' + strMonth + '/' + age[1];
                }
                else if (age1[1] == "Week(s)") {
                    result.d[i].Age = age1[0] + ' ' + strWeek + '/' + age[1];
                }
                else if (age1[1] == "Day(s)") {
                    result.d[i].Age = age1[0] + ' ' + strDay + '/' + age[1];
                }
                else {
                    result.d[i].Age = age1[0] + ' ' + strYear + '/' + age[1];
                }
            }
        }
        //End

        if (countR > 0 && result != "[]") {

            oTableTools = $('#ReportDetails').dataTable({
           oLanguage: {
                "sUrl": getLanguage()
    },
                "bDestroy": true,
                "bAutoWidth": false,
                "bProcessing": true,
                //  "bRetrieve": true,
                //  "serverSide": true,
                "aaData": result.d,
                "scrollX": true,
                "scrollY": true,
                //sScrollX: "100%",
                //sScrollX: "500px",
                //"aoColumnDefs": [
                // { bSortable: false, aTargets: [4, 5, 6] },
                //{ sWidth: "7%", aTargets: [1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13] },
                //],

                "fnStandingRedraw": function() { }, //pop.show();
                "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {

                    if (aData.IsAbnormal == "N") {
                        $('td:eq(0)', nRow).css("background-color", "#FFFFFF");
                    }
                    if (aData.IsAbnormal == "L") {
                        $('td:eq(0)', nRow).css("background-color", "#FFFF00");
                    }
                    if (aData.IsAbnormal == "A") {
                        $('td:eq(0)', nRow).css("background-color", "#FFFF00");
                    }
                    if (aData.IsAbnormal == "P") {
                        $('td:eq(0)', nRow).css("background-color", "#FF0000");
                    }
                    if (aData.VisitNumber != '') {
                        $('td:eq(3)', nRow).css("color", "#0000FF");
                    }
                    return nRow;
                },

                "aoColumns": [
                                { "mDataProp": "SNO" },
                                { "mDataProp": "PatientName" },
                                { "mDataProp": "Age" },
                                { "mDataProp": "VisitNumber" },
                                { "mDataProp": "Location" },
                                { "mDataProp": "PhysicianName" },
                                { "mDataProp": "ClientName" },
                                { "mDataProp": "TestDescription" },
                                { "mDataProp": "BillNumber", "bVisible": false },
                                { "mDataProp": "Amount", "bVisible": false },
                                { "mDataProp": "ReceiptStatus", "bVisible": false },
                                { "mDataProp": "EmailStatus" },
                                { "mDataProp": "SmsStatus" },
                                { "mDataProp": "PrintStatus" },
                                { "mDataProp": "Printpdf" },
                                { "mDataProp": "Pdf" },
                                { "mDataProp": "Col1" },
                                { "mDataProp": "OrderedServices", "bVisible": false },
                                ],
                "sPaginationType": "full_numbers",
                "sZeroRecords": "No records found",
                "bSort": true,
                "bJQueryUI": true,
                "iDisplayLength": 30,
                "sDom": '<"H"Tfr>t<"F"ip>',
                "oTableTools": {
                    "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                    "aButtons": [
                                {
                                    "sExtends": "csv",
                                    "sButtonText": "Excel",
                                    "mColumns": [0, 1, 2, 3, 4, 5, 6, 11, 12, 13, 17]
                                }

                        ]

                }
            });
            $('#ReportDetails').show();
            $('#grouptab_VisitwiseSearch_statusProgess').hide();
             pop.hide();
        }
        else {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var Records = SListForAppMsg.Get('Investigation_InvestigationStatusReport_aspx_01') == null ? "No Records Found" : SListForAppMsg.Get('Investigation_InvestigationStatusReport_aspx_01');
            //alert('No Records Found');
            ValidationWindow(Records, AlertType);
            $('#ReportDetails').hide();
            $('#grouptab_VisitwiseSearch_statusProgess').hide();
            pop.hide();
            $('#tdVisitWiseSerach').hide();
           // $('#Export_XL').show(); 
        }

        return false;
    }

    function ShowPopUp(visitnumber) {
        var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
    }
    function ViewPdf(name) {

        if (name != 'Empty') {
            $("[id$='grouptab_VisitwiseSearch_btnTarget']").click();            
            $('[id$="ifPDF"]').show();
            $("[id$='ifPDF']").attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=' + name + '")%>');
        }
        else {

            alert('Report is not ready');

        }
        return false;
    }

    
    function Printpdf(OrgId, Locationid, Visitid, RoleID, pdfCreated) {
        if (pdfCreated != 'No') {
            if (confirm("Do you want to print?")) {

                var Type = 'Print';
                var Emailaddress = '';
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/InsertNotificationManual",
                    contentType: "application/json; charset=utf-8",
                    data: "{ OrgId: '" + OrgId + "',Locationid: '" + Locationid + "',Visitid: '" + Visitid + "',Type: '" + Type + "',Emailaddress: '" + Emailaddress + "'}",
                    dataType: "json",

                    error: function (xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        return false;
                    }
                });
                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + Visitid + "&roleid=" + RoleID + "&type=ROUNDBPDF&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
            }
        }
        else {
            alert('Report is not ready');
        }
        //return false;
    }

    function EmailPopup(OrgId, Locationid, Visitid, RoleID, Email) {
        document.getElementById("grouptab_VisitwiseSearch_txtorgid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtLocid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtvisitid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtroleid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtMailAddress").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtorgid").value = OrgId;
        document.getElementById("grouptab_VisitwiseSearch_txtLocid").value = Locationid;
        document.getElementById("grouptab_VisitwiseSearch_txtvisitid").value = Visitid;
        document.getElementById("grouptab_VisitwiseSearch_txtroleid").value = RoleID;
        var modalPopupBehavior = $find('grouptab_VisitwiseSearch_modalpopupsendemail');
        modalPopupBehavior.show();

        //return false;
    }
    function CheckEmpty() {
       // debugger;
        var Check = document.getElementById("grouptab_VisitwiseSearch_txtMailAddress").value;
        if (Check == "") {
            alert("Enter Email Address");
            return false;

        }
        else {
            var OrgId = '';
            var Locationid = '';
            var Visitid = '';
            var RoleID = '';

            var Type = 'ManualMail';
            var Emailaddress = '';
            OrgId = document.getElementById("grouptab_VisitwiseSearch_txtorgid").value;
            Locationid = document.getElementById("grouptab_VisitwiseSearch_txtLocid").value;
            Visitid = document.getElementById("grouptab_VisitwiseSearch_txtvisitid").value;
            RoleID = document.getElementById("grouptab_VisitwiseSearch_txtroleid").value;
            Emailaddress = document.getElementById("grouptab_VisitwiseSearch_txtMailAddress").value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/InsertNotificationManual",
                contentType: "application/json; charset=utf-8",
                data: "{ OrgId: '" + OrgId + "',Locationid: '" + Locationid + "',Visitid: '" + Visitid + "',Type: '" + Type + "',Emailaddress: '" + Emailaddress + "'}",
                dataType: "json",
                success: OKsssss,
                error: function (xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }
            });
            return false;
        }
        document.getElementById("grouptab_VisitwiseSearch_txtorgid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtLocid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtvisitid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtroleid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtMailAddress").value = '';
        var modalPopupBehavior = $find('grouptab_VisitwiseSearch_modalpopupsendemail');
        modalPopupBehavior.hide();
        return false;

    }


    function OKsssss() {
        alert('Email Sent Successfully');
        document.getElementById("grouptab_VisitwiseSearch_txtorgid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtLocid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtvisitid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtroleid").value = '';
        document.getElementById("grouptab_VisitwiseSearch_txtMailAddress").value = '';
        var modalPopupBehavior = $find('grouptab_VisitwiseSearch_modalpopupsendemail');
        modalPopupBehavior.hide();
        return false;
    }

                      
</script>

