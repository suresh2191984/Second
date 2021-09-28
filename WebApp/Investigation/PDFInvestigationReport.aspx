<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PDFInvestigationReport.aspx.cs"
    Inherits="Investigation_PDFInvestigationReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientAccessHeader.ascx" TagName="AdminHeader"
    TagPrefix="uc100" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="NotesPattern.ascx" TagName="NotesPattern" TagPrefix="uc41" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="DateCtrl" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

   <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript">

        function PrintReport(VID, ReportConfig, InvIDs, PrintConfig) {
            var browser_info = perform_acrobat_detection();
            if (browser_info.acrobat == null) {
                alert("Please install adobe reader to perform print functionality");
            }
            else {
                var pdfConfig = document.getElementById('hdnReportViewerConfig').value;
                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PDFPrintVisitDetails.aspx?vid=" + VID + "&ReportConfig=" + ReportConfig + "&InvIDs=" + InvIDs + "&PDFConfigVal=" + pdfConfig + "&PrintConfig=" + PrintConfig + "' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
            }
        }

        function ShowSelectedReport(VID, ReportConfig, InvIDs, PrintConfig) {
            var browser_info = perform_acrobat_detection();
            if (browser_info.acrobat == null) {
                alert("Please install adobe reader to perform print functionality");
            }
            else {
                var pdfConfig = document.getElementById('hdnReportViewerConfig').value;
                $("#divShowReportIframe").html("<iframe id='myiframe1' name='myname1' src='PDFPrintVisitDetails.aspx?vid=" + VID + "&ReportConfig=" + ReportConfig + "&InvIDs=" + InvIDs + "&PDFConfigVal=" + pdfConfig + "&PrintConfig=" + PrintConfig + "&#toolbar=0&navpanes=1' style='width:1250px; height:450px;border:0px;overfow:none; z-index:-1'></iframe>");
            }
        }

        function setInputEnableState(reportViewer) {

            // It is ok to export if the viewer is not loading and is displaying a report.
            var disableInputs = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;


            $get("PrintButton").disabled = disableInputs;
        }

        function onReportViewerLoadingChanged(sender, e) {

            var propertyName = e.get_propertyName();

            if (propertyName === "isLoading" || propertyName === "reportAreaContentType") {
                setInputEnableState(sender);
            }
        }

        function onPrintButtonClicked() {
            var reportViewer = $find("rReportViewer");
            reportViewer.invokePrintDialog();
        }
        var hookedPropertyChangedEvent = false;

        function ReportLoad() {
            //            if (!hookedPropertyChangedEvent) {

            //                var reportViewer = $find("rReportViewer");
            //                reportViewer.add_propertyChanged(onReportViewerLoadingChanged);

            //                // Make sure the input controls are in the correct state initially
            //                setInputEnableState(reportViewer);

            //                // pageLoad is called after each asynchronous postback.  Only
            //                // hook the property changed event once.
            //                hookedPropertyChangedEvent = true;
            //            }
        }
    </script>

    <script type="text/javascript">
        //        $(document).ready(function() {
        //            var checkboxValues = [];

        //            $('#chkDept input[type=checkbox]').click(function() {
        //                $('input[type=checkbox]:checked').each(function() {
        //                    checkboxValues.push(this.value);
        //                    $("#msg").text(checkboxValues.toString());
        //                });
        //            });

        //            var values = checkboxValues.toString(); //Output Format: 1,2,3
        //        });
        function showInternalExternal(id) {
            if (document.getElementById(id).checked) {
                document.getElementById('tdRPinternal').style.display = "block";
                document.getElementById('tdRPExternal').style.display = "none";
                document.getElementById('ddlPhysician').value = 0;

            }
            else {
                document.getElementById('tdRPinternal').style.display = "none";
                document.getElementById('tdRPExternal').style.display = "block";
                document.getElementById('ddlRefPhysician').value = 0;
            }

        }
        function SelectVisit(id, vid, pid, patOrgID, email) {
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPID").value = pid;
            //            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("patOrgID").value = patOrgID;
            document.getElementById("hdnEMail").value = email;
        }

        function CheckVisitID() {
            if ($('#hdnVID').val() == '') {

                alert('Select visit detail');
                return false;
            }
            else {
                //alert(document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].value);
                if ($('#ddlVisitActionName option:selected').val() != "0") {
                    $('#hdnVisitDetail').val($('#ddlVisitActionName option:selected').text());
                    if ($('#ddlVisitActionName option:selected').val() == "Show_Report_InvestigationReport") {
                        $('#hdnHideDetails').val('1');
                    }
                    return true;
                }
                else {
                    alert('Select any one of the action to proceed');
                    return false;
                }
            }
        }

        function ChechVisitDate() {

            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value != '' || document.getElementById('txtTo').value != '') {
                alert('Provide visit date');
                document.form1.txtFrom.focus();
                return false;
            }
            return true;
        }

        function ChechVisit() {

            //            if (document.getElementById('txtPatientNo').value == '') {
            //                alert('Please Enter Patient No');
            //                document.form1.txtPatientNo.focus();
            //                return false;
            //            }

            //            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value == '' && document.getElementById('txtTo').value == '') {

            //                alert('Please Enter Atlease One Search option');
            //                document.form1.txtPatientNo.focus();
            //                return false;
            //            }
            return true;

        }
        function ShowReportDiv() {

            // alert(document.getElementById('dReport'));
            document.getElementById('dReport').style.display = 'block';
            return false;
        }
        function HideDiv() {
            document.getElementById('dReport').style.display = 'none';
            document.getElementById('imgClick').style.display = 'block';
            document.getElementById('lblHead').style.display = 'block';
            return true;
        }
        function SelectAllInvestigations() {
            document.getElementById('chkSelectAllUnPrinted').checked = document.getElementById('chkSelectAllInv').checked == true ? true : false;
            var boolObj = document.getElementById('chkSelectAllUnPrinted').checked;
            childInv(boolObj);
        }
        function childInv(boolObj) {
            var main = document.getElementById('hdndeptid').value;
            if (main != "") {
                var mainList = main.split('^');
                for (var i = 0; i < mainList.length; i++) {
                    if (mainList[i] != "") {
                        document.getElementById(mainList[i].split('~')[0]).checked = boolObj == true ? true : false;
                    }
                }
            }
        }
        function SelectUnPrintedInvestigation() {
            childInv(false);
            var chkObj = document.getElementById('chkSelectAllUnPrinted').checked;
            document.getElementById('chkSelectAllInv').checked = false;
            if (document.getElementById('chkSelectAllUnPrinted').checked == true) {
                var main = document.getElementById('hdndeptid').value;
                if (main != "") {
                    var mainList = main.split('^');
                    for (var i = 0; i < mainList.length; i++) {
                        if (mainList[i] != "") {
                            var PrintCnt = mainList[i].split('~')[0].substring(0, 60) + "_lblPrintCount";
                            if (document.getElementById(PrintCnt) != null && document.getElementById(PrintCnt).innerHTML != "") {
                                if (Number(document.getElementById(PrintCnt).innerHTML) == 0) {
                                    document.getElementById(mainList[i].split('~')[0]).checked = chkObj == true ? true : false;
                                }
                            }
                        }
                    }
                }
            }
        }
        function chkUnchkAll() {
            var rtrn = true;
            var main = document.getElementById('ChkID').value;
            if (main != "") {
                var mainList = main.split('^');
                for (var i = 0; i < mainList.length; i++) {
                    if (mainList[i] != "") {
                        if (document.getElementById(mainList[i]).checked == false) {
                            rtrn = false;
                            break;
                        }
                    }
                }
                return rtrn
            }
        }
        function ChkIfSelected(obj) {
            if (document.getElementById(obj).checked) {
                document.getElementById('ChkID').value = obj + '^';
            }
            else {
                //                if (chkUnchkAll() == false) {
                //                    document.getElementById('chkSelectAllInv').checked = false;
                //                }
                var chkSelectAllDynamicID = obj.substring(0, 19);
                document.getElementById(chkSelectAllDynamicID + '_chkSelectAll').checked = false;
                var x = document.getElementById('ChkID').value.split('^');
                document.getElementById('ChkID').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != '') {
                        if (x[i] != obj) {
                            document.getElementById('ChkID').value = x[i] + '^';
                        }
                    }
                }
            }
        }
        function IsSelected() {
            if (document.getElementById('ChkID').value != '') {
                HideDiv();
                return true;
            }
            else {
                alert('Select an investigation to display report');
            }
            return false;
        }
        function launchSessionUrl(launchurl) {
            //alert('hello : ' + launchurl);
            window.location.href = launchurl;

        }
        function SelectAll(IsChecked) {
            var chkArrayMain = new Array();
            var UniqTemplateChkId = IsChecked.substring(0, 19);
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            if (document.getElementById(IsChecked).checked) {

                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        if (document.getElementById(chkArrayMain[i]).disabled == false) {
                            document.getElementById(chkArrayMain[i]).checked = true;
                        }
                    }
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        document.getElementById(chkArrayMain[i]).checked = false;
                    }
                }
            }

        }
        function showReports(id) {
            var Obj = document.getElementById('chkDept');
            var chkArrayMain = document.getElementById('hdndeptid').value.split('^');
            if (document.getElementById('hdndeptid').value != "") {
                for (var count = 0; count < chkArrayMain.length; count++) {
                    var SpecList = chkArrayMain[count].split('~');
                    if (SpecList[0] != '' && SpecList[1] != "0") {
                        if (id == SpecList[1]) {
                            document.getElementById(SpecList[0]).checked = true;
                        }


                    }



                }
            }
        }
        function dispTask(id) {
            var lists = "";
            var SpecList = "";
            var cboxObj = document.getElementById(id);
            var cboxList = cboxObj.getElementsByTagName('input');
            var lbList = cboxObj.getElementsByTagName('label');

            if (document.getElementById('hdndeptid').value != "") {
                var chkArrayMain = document.getElementById('hdndeptid').value.split('^');

                for (var count = 0; count < chkArrayMain.length; count++) {
                    SpecList = chkArrayMain[count].split('~');
                    if (SpecList[0] != '' && SpecList[1] != "0") {
                        document.getElementById(SpecList[0]).checked = false;
                    }
                }
            }

            for (var i = 0; i < cboxList.length; i++) {
                if (cboxList[i].checked) {
                    var s = document.getElementById('hdndeptvalues').value.split('^');
                    for (var count = 0; count < s.length; count++) {
                        var SpecLists = s[count].split('~');
                        if (lbList[i].innerHTML == SpecLists[1]) {
                            showReports(SpecLists[0]);
                        }
                    }
                }
            }
        }

        function showfalse(id) {
            var Obj = document.getElementById('chkDept');
            var chkArrayMain = document.getElementById('hdndeptid').value.split('^');
            if (document.getElementById('hdndeptid').value != "") {
                for (var count = 0; count < chkArrayMain.length; count++) {
                    var SpecList = chkArrayMain[count].split('~');
                    if (SpecList[0] != '' && SpecList[1] != "0") {
                        if (id == SpecList[1]) {
                            document.getElementById(SpecList[0]).checked = false;
                        }
                    }
                }
            }
        }

        function ValidateCheckBox(id) {
            document.getElementById('hdnCheckValue').value = document.getElementById(id).value;
            var chkArrayMain = new Array();
            var count = 0;
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            for (var i = 0; i < chkArrayMain.length; i++) {
                if (document.getElementById(chkArrayMain[i]).checked == true) {
                    count++;
                }
            }
            if (count > 0)
            { return true; } else {
                alert('Select an investigation');
                return false;
            }
        }
        function launchexe(ExeName, Path) {
            //            alert('a');
            //            var cmdline1 = "notepad.exe \"c:\\1.txt\"";
            //           var cmdline2 = "taskmgr.exe";
            //            document.apltLaunchExe.launch(cmdline1);
            document.apltLaunchExe.launch(cmdline2);
        }

        function launchexe_mv(patid, studyid, modality, imageserveripaddress, portnumber, loggedinusername) {
            //            alert('ts');
            var exename = 'launch_viewer_mv.exe';
            var args = patid + ' ' + studyid + ' ' + modality + ' ' + imageserveripaddress + ' ' + portnumber + ' ' + loggedinusername;
            var cmdline = exename + ' ' + args;
            document.apltLaunchExe.launch(cmdline);
            //            alert('ts1');
            return false;
            //            alert('ts');
        }


        function popupprint() {
            var prtContent = document.getElementById('printANCCS');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=1024,height=768');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            // WinPrint.close();
        }
        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";

            document.getElementById('hdnTempFrom').value = "";
            document.getElementById('hdnTempTo').value = "";

            document.getElementById('hdnTempFromPeriod').value = "0";
            document.getElementById('hdnTempToPeriod').value = "0";
            if (document.getElementById('ddlRegisterDate').value == "0") {

                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayMonth').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "2") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayYear').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';

            }
            if (document.getElementById('ddlRegisterDate').value == "3") {
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

            }
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }
            if (document.getElementById('ddlRegisterDate').value == "4") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }

            if (document.getElementById('ddlRegisterDate').value == "5") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "6") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastMonthLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "7") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastYearLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
        }
        function onPrintReport() {
            var reportViewer = $find("rReportViewer");
            var disablePrint = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;
            if (!disablePrint) {
                reportViewer.invokePrintDialog();
                return true;

            }
            else
                alert("Unable to print report");
            return false;
        }
        function PopupClose() {
            document.getElementById('hdnShowReport').value = 'false';
        }
        function CheckMailAddress() {
            var txtMailAddress = $('#txtMailAddress');
            var mailAddresses = txtMailAddress.val().replace(' ', '');
            if (mailAddresses.length > 0) {
                var address = mailAddresses.split(',');
                var filter = /^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$/m;
                var isValid = true;
                for (var i = 0; i < address.length; i++) {
                    if (!filter.test(address[i])) {
                        isValid = false;
                    }
                }
                if (!isValid) {
                    alert('Provide a valid email address.');
                    txtMailAddress.focus();
                    return false;
                }
            }
            else {
                alert("Provide a email address.");
                txtMailAddress.focus();
                return false;
            }
        }
        
    </script>

</head>
<body id="oneColLayout">
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
                <uc100:AdminHeader ID="Header1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblPatient" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <div style="display: block" class="dataheader2">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label runat="server" ID="lblPatientNo" Text="PatientNo" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtPatientNo" Width="142px" onKeyPress="onEnterKeyPress(event);"
                                                        MaxLength="16" runat="server" meta:resourcekey="txtPatientNoResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                </td>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="lblName" Text="Name" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:TextBox ID="txtName" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label ID="lblMobile" Text="Phone" runat="server" meta:resourcekey="lblMobileResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtMobile" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                                </td>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="lblLabNo" Text="LabNo" runat="server" meta:resourcekey="lblLabNoResource1"></asp:Label>
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:TextBox ID="txtLabNo" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtLabNoResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label ID="lblddlocation" Text="Location" runat="server" meta:resourcekey="lblddlocationResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlocation" runat="server" meta:resourcekey="ddlocationResource2" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="lblwardName" Text="WardName" runat="server" meta:resourcekey="lblwardNameResource1"></asp:Label>
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:TextBox ID="txtWardName" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtWardNameResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label ID="lblddVisittype" Text="VisitType" runat="server" meta:resourcekey="lblddVisittypeResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddVisitType" runat="server" meta:resourcekey="ddVisitTypeResource1" CssClass="ddlsmall">
                                                        <asp:ListItem Text="--Select--" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="lblStatus" Text="Status" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:DropDownList ID="ddstatus" runat="server" meta:resourcekey="ddstatusResource1" CssClass="ddlsmall">
                                                        <asp:ListItem Text="--Select--" Value="-1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                        <asp:ListItem Text="Approve" Value="0" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                        <asp:ListItem Text="Completed" Value="1" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                        <asp:ListItem Text="Pending" Value="2" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label ID="lblclient" Text="ClientName" runat="server" meta:resourcekey="lblclientResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddClientName" runat="server" CssClass="ddlsmall" meta:resourcekey="ddClientNameResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="Label4" Text="Priority Type" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:DropDownList ID="drpPriority" runat="server" meta:resourcekey="drpPriorityResource1" CssClass="ddlsmall">
                                                        <asp:ListItem Value="0" Text="--Select--" Selected="True" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                        <asp:ListItem Value="1" Text="Normal" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                        <asp:ListItem Text="Emergency" Value="2" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                        <asp:ListItem Text="VIP" Value="3" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Registered Date" meta:resourcekey="Rs_RegisteredDateResource1"></asp:Label>
                                                    <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                                                    <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                                                    <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                                                    <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                                                    <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                                                    <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                                                    <asp:HiddenField ID="hdnDateImage" runat="server" />
                                                    <asp:HiddenField ID="hdnTempFrom" runat="server" />
                                                    <asp:HiddenField ID="hdnTempTo" runat="server" />
                                                    <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                    <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                    <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                                                    <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                                                    <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                                                    <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                                                    <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                                                    <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                                                    <asp:HiddenField ID="hdnActionCount" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                                                         runat="server" meta:resourcekey="ddlRegisterDateResource1" CssClass="ddlsmall">
                                                        <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource12">--Select--</asp:ListItem>
                                                        <asp:ListItem Value="0" meta:resourcekey="ListItemResource13">This Week</asp:ListItem>
                                                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource14">This Month</asp:ListItem>
                                                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource15">This Year</asp:ListItem>
                                                        <asp:ListItem Value="3" meta:resourcekey="ListItemResource16">Custom Period</asp:ListItem>
                                                        <asp:ListItem Value="4" meta:resourcekey="ListItemResource17">Today</asp:ListItem>
                                                        <asp:ListItem Value="5" meta:resourcekey="ListItemResource18">Last Week</asp:ListItem>
                                                        <asp:ListItem Value="6" meta:resourcekey="ListItemResource19">Last Month</asp:ListItem>
                                                        <asp:ListItem Value="7" meta:resourcekey="ListItemResource20">Last Year</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div id="divRegDate" style="display: none" runat="server">
                                                        <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                        <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    </div>
                                                    <div id="divRegCustomDate" runat="server" style="display: none;">
                                                        <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                        <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                        <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                        <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                    </div>
                                                </td>
                                                <td align="right" colspan="2">
                                                    <asp:Label ID="lblURNNo" Text="URN No" runat="server" meta:resourcekey="lblURNNoResource1"></asp:Label>
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:TextBox ID="txtURNo" runat="server" CssClass="Txtboxsmall" MaxLength="50" meta:resourcekey="txtURNoResource1"></asp:TextBox>
                                                    &nbsp;
                                                    <asp:DropDownList CssClass="ddl" ID="ddlUrnType" runat="server" meta:resourcekey="ddlUrnTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label ID="Label2" Text="DepartmentName" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="drpdepartment" CssClass="ddlsmall" runat="server" meta:resourcekey="drpdepartmentResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="lblReferringPhysician" Text="Referring Physician" runat="server" meta:resourcekey="lblReferringPhysicianResource1"></asp:Label>
                                                </td>
                                                <td align="left" id="tdRPinternal" runat="server" style="display: block">
                                                    <asp:DropDownList ID="ddlPhysician" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlPhysicianResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="left" id="tdRPExternal" CssClass="ddlsmall" runat="server" style="display: none">
                                                    <asp:DropDownList CssClass="ddl" ID="ddlRefPhysician" runat="server" meta:resourcekey="ddlRefPhysicianResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td id="tdchkReferalType" runat="server" style="display: none" align="right">
                                                    <asp:CheckBox ID="chkReferalType" Text="Internal" Checked="True" onclick="javascript:showInternalExternal(this.id);"
                                                        runat="server" meta:resourcekey="chkReferalTypeResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="right">
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnSearch_Click" TabIndex="13" meta:resourcekey="btnSearchResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="tblgrdview" runat="server" style="display: none;">
                            <%-- <tr>
                                <td class="colorforcontent" style="width: 30%;" height="23" align="left">
                                    <div id="ACX2plus3" style="display: none;">
                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                            style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">
                                            &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Investigation Report" meta:resourcekey="lblinvfilterResource1"></asp:Label></span></div>
                                    <div id="ACX2minus3" style="display: block;">
                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                            style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);">
                                            <asp:Label ID="lblinvfilters" runat="server" Text="Investigation Report" meta:resourcekey="lblinvfiltersResource1"></asp:Label></span></div>
                                </td>
                            </tr>--%>
                            <tr class="tablerow" id="ACX2responses3" style="display: block;">
                                <td>
                                    <table style="width: 100%;">
                                        <tr style="width: 100%;">
                                            &nbsp;
                                            <td>
                                                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                                    DataKeyNames="PatientVisitID,Name" Width="100%" OnRowDataBound="grdResult_RowDataBound"
                                                    ForeColor="#333333" CssClass="mytable1" OnItemCommand="grdResult_ItemCommand"
                                                    ItemStyle-VerticalAlign="Top" RepeatDirection="Horizontal" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                    meta:resourcekey="grdResultResource1">
                                                    <HeaderStyle CssClass="dataheader1" HorizontalAlign="Left" />
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                        PageButtonCount="5" PreviousPageText="" />
                                                    <Columns>
                                                        <asp:BoundField Visible="false" DataField="PatientVisitID" HeaderText="PatientVisitID"
                                                            meta:resourcekey="BoundFieldResource1" />
                                                        <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect"
                                                                    meta:resourcekey="rdSelResource1" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Print" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <img id="imgPrintReport" title="Print" runat="server" alt="Print" src="~/Images/printer.gif"
                                                                    style="cursor: pointer;" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2" />
                                                        <asp:BoundField DataField="PatientAge" Visible="true" HeaderText="Age" meta:resourcekey="BoundFieldResource3" />
                                                        <asp:BoundField DataField="URNO" HeaderText="URN No" meta:resourcekey="BoundFieldResource4" />
                                                        <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" HeaderText="Visit Date"
                                                            meta:resourcekey="BoundFieldResource5" />
                                                        <asp:BoundField DataField="VisitPurposeName" HeaderText="Visit Purpose" meta:resourcekey="BoundFieldResource6" />
                                                        <asp:TemplateField HeaderText="Physician Name" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhysicianName" runat='server' Text='<%# Bind("PhysicianName") %>'
                                                                    meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Location" HeaderText="Location" meta:resourcekey="BoundFieldResource7" />
                                                        <asp:BoundField DataField="ReferingPhysicianName" HeaderText="ReferingPhysician Name"
                                                            meta:resourcekey="BoundFieldResource9" />
                                                        <asp:BoundField DataField="OrganizationName" HeaderText="Org Name" Visible="false" />
                                                        <asp:BoundField DataField="OrgID" Visible="false" HeaderText="OrgID" />
                                                        <%-- <asp:BoundField DataField="ReferralType" HeaderText="ReferralType(Internal/External)" />--%>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr id="trSelectVisit" runat="server" visible="false">
                                            <td class="defaultfontcolor">
                                                Select a patient visit
                                                <asp:DropDownList ID="ddlVisitActionName" runat="server" Visible="False" meta:resourcekey="ddlVisitActionNameResource1">
                                                </asp:DropDownList>
                                                <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    OnClientClick="return CheckVisitID()" onmouseout="this.className='btn'" OnClick="btnGo_Click"
                                                    meta:resourcekey="btnGoResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMessage1" runat="server" meta:resourcekey="lblMessage1Resource1"></asp:Label>
                                                <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" id="tblPayments" visible="false" runat="server" border="0" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td>
                                    This Bill has pending payments kindly make payment to view report
                                    <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        OnClick="btnPayNow_Click" onmouseout="this.className='btn'" meta:resourcekey="btnPayNowResource1" />
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                                meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                            <cc1:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                                TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                                CancelControlID="btnCnl" DynamicServicePath="" Enabled="True">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlAttrib" BorderWidth="1px" ScrollBars="Both" Height="95%" Width="90%"
                                                CssClass="modalPopup dataheaderPopup" runat="server">
                                                <table width="100%" style="height: 100%">
                                                    <tr style="height: 6px;">
                                                        <td align="right">
                                                            <asp:Button ID="btnCnl" runat="server" Text=" X " BackColor="Red" ForeColor="White"
                                                                Font-Bold="true" OnClientClick="PopupClose();return false;" />
                                                        </td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td>
                                                            <table id="tblReport" runat="server" width="100%">
                                                                <tr>
                                                                    <td id="chdept" runat="server" style="display: none;">
                                                                        <asp:CheckBoxList ID="chkDept" runat="server" RepeatColumns="5" onclick="javascript:dispTask(this.id);"
                                                                            meta:resourcekey="chkDeptResource1">
                                                                        </asp:CheckBoxList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td id="lnkshwrpt" runat="server" style="display: none; color: Black;">
                                                                        Click Here !
                                                                        <asp:LinkButton ID="lnkShowRecord" runat="server" ForeColor="White" OnClick="lnkShowRecord_Click"
                                                                            meta:resourcekey="lnkShowRecordResource1">DepartmentWise Filter Report </asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <table width="100%" id="tblResults" runat="server" border="0" cellpadding="0" cellspacing="0">
                                                                            <tr valign="top">
                                                                                <td style="display: none;">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="width: 5%">
                                                                                                <img src="../Images/collapse_blue.jpg" id="imgClick" title="Show Report Template"
                                                                                                    style="display: none;" runat="server" onclick="javascript:return ShowReportDiv();" />
                                                                                            </td>
                                                                                            <td style="width: 95%">
                                                                                                <asp:Label runat="server" ID="lblHead" Text="Show Report Template" Style="display: none;"
                                                                                                    meta:resourcekey="lblHeadResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <ucPatientdet:PatientDetails ID="uctPatientDetail" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="right">
                                                                                    <asp:CheckBox ID="chkSelectAllInv" runat="server" onclick="javascript:return SelectAllInvestigations(this.checked);"
                                                                                        Text="Select all Investigations" ForeColor="Blue" TextAlign="Right" Width="200px"
                                                                                        Font-Bold="true" />
                                                                                    <asp:CheckBox ID="chkSelectAllUnPrinted" runat="server" Text="Select new Investigations(Yet to print)"
                                                                                        onclick="javascript:return SelectUnPrintedInvestigation();" TextAlign="Right"
                                                                                        ForeColor="Blue" Width="250px" Font-Bold="true" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr valign="top" style="border: 1;">
                                                                                <td style="width: 100%;">
                                                                                    <div id="dReport" runat="server" class="dataheaderInvCtrl" style="overflow: scroll;
                                                                                        height: 150px;">
                                                                                        <asp:DataList ID="grdResultTemp" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                            RepeatColumns="2" OnItemDataBound="grdResultTemp_ItemDataBound" ItemStyle-VerticalAlign="Top"
                                                                                            RepeatDirection="Horizontal" OnItemCommand="grdResultTemp_ItemCommand" meta:resourcekey="grdResultTempResource1">
                                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                            <ItemTemplate>
                                                                                                <table cellpadding="0" style="border-collapse: collapse; vertical-align: top;" cellspacing="0"
                                                                                                    border="2" width="100%">
                                                                                                    <tr style="display: none; vertical-align: top; width: 100%;">
                                                                                                        <td valign="top">
                                                                                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;
                                                                                                                vertical-align: top" cellspacing="0" border="0" width="100%">
                                                                                                                <tr style="vertical-align: top;">
                                                                                                                    <td style="height: 20px;">
                                                                                                                        <table width="100%">
                                                                                                                            <tr style="vertical-align: top;">
                                                                                                                                <td align="left">
                                                                                                                                    Report
                                                                                                                                </td>
                                                                                                                                <td align="right">
                                                                                                                                    &nbsp<asp:CheckBox ID="chkSelectAll" runat="server" onclick="javascript:dispTask(this.id);" />Select
                                                                                                                                    all<asp:Label runat="server" ID="lblReportID" Visible="false" Text='<%# Eval("TemplateID") %>'
                                                                                                                                        meta:resourcekey="lblReportIDResource1"></asp:Label>
                                                                                                                                    <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                        meta:resourcekey="lblReportnameResource1"></asp:Label>
                                                                                                                                </td>
                                                                                                                            </tr>
                                                                                                                        </table>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr valign="top">
                                                                                                        <td>
                                                                                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;
                                                                                                                vertical-align: top;" cellspacing="0" border="0" width="100%">
                                                                                                                <tr style="vertical-align: top;">
                                                                                                                    <td style="font-weight: normal;">
                                                                                                                        <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                                                            OnItemDataBound="grdResultDate_ItemDataBound" OnItemCommand="grdResultDate_ItemCommand"
                                                                                                                            RepeatColumns="3" RepeatDirection="Horizontal" meta:resourcekey="grdResultDateResource1">
                                                                                                                            <ItemStyle VerticalAlign="Top" />
                                                                                                                            <ItemTemplate>
                                                                                                                                <table style="vertical-align: top">
                                                                                                                                    <tr style="display: none; vertical-align: top;">
                                                                                                                                        <td>
                                                                                                                                            <asp:Label runat="server" Font-Bold="True" Visible="False" ID="Label1" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                                                                                                                            <asp:Label runat="server" ID="lblDtReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                                                                meta:resourcekey="lblDtReportIDResource1"></asp:Label>
                                                                                                                                            <asp:Label runat="server" ID="lbldtReportname" Visible="false" Font-Bold="true" Font-Italic="true"
                                                                                                                                                Font-Underline="true" Text='<%# Eval("ReportTemplateName") %>'></asp:Label>
                                                                                                                                        </td>
                                                                                                                                    </tr>
                                                                                                                                    <tr style="vertical-align: top">
                                                                                                                                        <td style="font-weight: normal;">
                                                                                                                                            <asp:DataList ID="dlChildInvName" RepeatColumns="2" runat="server" OnItemCommand="dlChildInvName_ItemCommand"
                                                                                                                                                Width="100%" meta:resourcekey="dlChildInvNameResource1">
                                                                                                                                                <ItemStyle VerticalAlign="Top" />
                                                                                                                                                <ItemTemplate>
                                                                                                                                                    <table style="vertical-align: top;">
                                                                                                                                                        <tr>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:CheckBox ID="ChkBox" onclick="javascript:return ChkIfSelected(this.id);" runat="server" />
                                                                                                                                                                <asp:Label runat="server" ID="lblInvname" Text='<%# Eval("PrintCount").ToString()=="0" ? Eval("InvestigationName").ToString() : GetInvName(Eval("InvestigationName").ToString()) %> '></asp:Label>
                                                                                                                                                                <asp:Label runat="server" Visible="False" ID="lblInvID" Text='<%# Eval("InvestigationID") %>'
                                                                                                                                                                    meta:resourcekey="lblInvIDResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                                                                                    meta:resourcekey="lblReportIDResource2"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                                                    meta:resourcekey="lblReportnameResource2"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblAccessionNo" Visible="False" Text='<%# Eval("AccessionNumber") %>'
                                                                                                                                                                    meta:resourcekey="lblAccessionNoResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblPatientID" Visible="False" Text='<%# Eval("PatientID") %>'
                                                                                                                                                                    meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lbldeptid" Visible="False" Text='<%# Eval("DeptID") %>'
                                                                                                                                                                    meta:resourcekey="lbldeptidResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblStatus" Visible="False" Text='<%# Eval("Status") %>'
                                                                                                                                                                    meta:resourcekey="lblStatusResource2"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblPrintCount" Style="display: none;" Text='<%# Eval("PrintCount") %>'></asp:Label>
                                                                                                                                                            </td>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                                                                                                                                    runat="server" Visible="False" Text="Show" CommandName="ShowReport" meta:resourcekey="lnkShowResource1"></asp:LinkButton>
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                    </table>
                                                                                                                                                </ItemTemplate>
                                                                                                                                            </asp:DataList>
                                                                                                                                        </td>
                                                                                                                                    </tr>
                                                                                                                                </table>
                                                                                                                            </ItemTemplate>
                                                                                                                        </asp:DataList>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr style="display: none;">
                                                                                                                    <td style="color: #000000; height: 20px;" align="center">
                                                                                                                        <asp:LinkButton ID="lnkShowReport" ForeColor="Black" runat="server" Visible="false"
                                                                                                                            Text="ShowReport" CommandName="ShowReport" Font-Underline="True"></asp:LinkButton>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </ItemTemplate>
                                                                                        </asp:DataList>
                                                                                    </div>
                                                                                </td>
                                                                                <td valign="top">
                                                                                    <table runat="server" border="0" visible="false" style="background-color: #fcecb6"
                                                                                        id="tblcontent">
                                                                                        <tr>
                                                                                            <td class="alterimg">
                                                                                            </td>
                                                                                            <td>
                                                                                                <b>If you are viewing the images for the first time, please install the viewer.</b>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                &nbsp;
                                                                                            </td>
                                                                                            <td>
                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <img src="../Images/box_menu_bullet.png" runat="server" id="imgInstallExe" alt="error"
                                                                                                                visible="true" /><asp:HyperLink Font-Bold="True" ForeColor="Black" runat="server"
                                                                                                                    ID="lnkInstall" Text="Click to download & install Viewer" meta:resourcekey="lnkInstallResource1"></asp:HyperLink>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgInsGuide"
                                                                                                                visible="true" />
                                                                                                            <asp:LinkButton runat="server" Font-Bold="True" OnClick="lnkInsguide_Click" ForeColor="Black"
                                                                                                                ID="lnkInsguide" Text="Click to view the Installation Guide" meta:resourcekey="lnkInsguideResource1"></asp:LinkButton>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgUserGuide"
                                                                                                                visible="true" />
                                                                                                            <asp:LinkButton runat="server" OnClick="lnkUserGuide_Click" Font-Bold="True" ForeColor="Black"
                                                                                                                ID="lnkUserGuide" Text="Click to view the Viewer User Guide" meta:resourcekey="lnkUserGuideResource1"></asp:LinkButton>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:HiddenField runat="server" ID="hdnInstallationGuidePath" />
                                                                                    <asp:HiddenField runat="server" ID="hnUserGuidePath" />
                                                                                    <asp:HiddenField runat="server" ID="hdnIpaddress" />
                                                                                    <asp:HiddenField runat="server" ID="hdnPortNumber" />
                                                                                    <asp:HiddenField runat="server" ID="hdnPath" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                                                        <ProgressTemplate>
                                                                                            <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/Images/working.gif" />
                                                                                            <asp:Label ID="Rs_Pleasewait1" Text="Please wait...." runat="server" />
                                                                                        </ProgressTemplate>
                                                                                    </asp:UpdateProgress>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:Button ID="btnShowReport" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return ValidateCheckBox(this.id);"
                                                                                        Text="Show Report" OnClick="btnShowReport_Click" />
                                                                                    <asp:Button ID="btnPrintReport" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                        onmouseout="this.className='btn'" Text="Print" OnClientClick="javascript:return ValidateCheckBox(this.id);"
                                                                                        OnClick="btnShowReport_Click" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr style="width: 100%">
                                                                                <td>
                                                                                    <div id="divShowReportIframe" style="width: 100%; height: 100%;">
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: block;">
                                                        <td align="right">
                                                            <asp:Button ID="btnPrint" OnClick="btnPrint_Click" runat="server" Text="Print Report"
                                                                OnClientClick="return onPrintReport();" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" Visible="false" />
                                                            <asp:HiddenField ID="hdnShowReport" runat="server" Value="false" />
                                                            <asp:HiddenField ID="hdnPrintbtnInReportViewer" runat="server" />
                                                            <asp:HiddenField ID="hdnReportViewerConfig" runat="server" />
                                                            <asp:Button ID="btnSendMail" runat="server" Text="Send Mail" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnSendMail_Click" Style="display: none;"
                                                                meta:resourcekey="btnSendMailResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                                                Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                                                                <ServerReport ReportServerUrl="" />
                                                            </rsweb:ReportViewer>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="hiddenTargetControlForModalPopup2" runat="server" Style="display: none"
                                                meta:resourcekey="hiddenTargetControlForModalPopup2Resource1" />
                                            <cc1:ModalPopupExtender ID="rptMdlPopup2" runat="server" PopupControlID="pnlAttrib2"
                                                TargetControlID="hiddenTargetControlForModalPopup2" BackgroundCssClass="modalBackground"
                                                CancelControlID="btnCnl2" DynamicServicePath="" Enabled="True">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlAttrib2" BorderWidth="1px" Height="98%" Width="72%" CssClass="modalPopup dataheaderPopup"
                                                runat="server" meta:resourcekey="pnlAttrib2Resource1">
                                                <table width="100%" style="height: 100%">
                                                    <tr>
                                                        <td align="center">
                                                            <input type="button" id="btnClientAttributes" value="Print" class="btn" onclick="return popupprint();" />
                                                            <asp:Button ID="btnCnl2" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" meta:resourcekey="btnCnl2Resource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <div style="overflow: auto; width: 900px; height: 550px;">
                                                                <div id="printANCCS">
                                                                    <uc41:NotesPattern ID="FckEdit1" runat="server" />
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="upMailReport" runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                                <cc1:ModalPopupExtender ID="modelPopExtMailReport" runat="server" PopupControlID="pnlMailReport"
                                    TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                                    CancelControlID="imgPopupClose" DynamicServicePath="" Enabled="True">
                                </cc1:ModalPopupExtender>
                                <asp:Panel ID="pnlMailReport" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                                    runat="server" meta:resourcekey="pnlMailReportResource1">
                                    <asp:Panel ID="Panel1" runat="server" Style="background-color: #2C88B1; color: white;
                                        font-size: 13px; font-weight: bold; padding: 5px; height: 20px;" meta:resourcekey="Panel1Resource1">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Dispatch Report" meta:resourcekey="Label1Resource2"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <img id="imgPopupClose" src="../Images/close_button.gif" runat="server" alt="Close"
                                                        style="cursor: pointer;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <ul>
                                        <li>
                                            <uc5:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                                        </li>
                                    </ul>
                                    <table width="100%">
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
                                                    runat="server" meta:resourcekey="txtMailAddressResource1" />
                                                <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                                    <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                                        meta:resourcekey="lblMailAddressHintResource1" />
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:Button ID="btnSendMailReport" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClientClick="return CheckMailAddress();"
                                                    OnClick="btnSendMailReport_Click" meta:resourcekey="btnSendMailReportResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
                    <input type="hidden" id="hdnPID" name="pid" runat="server" />
                    <input type="hidden" id="hdnVID" name="vid" runat="server" />
                    <input type="hidden" id="hdnVisitDetail" runat="server" />
                    <input type="hidden" id="patOrgID" runat="server" name="patOrgID" />
                    <input type="hidden" id="ChkID" runat="server" />
                    <input type="hidden" id="hdndeptid" runat="server" />
                    <input type="hidden" id="hdndeptvalues" runat="server" />
                    <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
                    <asp:HiddenField ID="hdnHideDetails" Value="0" runat="server" />
                    <asp:HiddenField ID="hdnReferralType" runat="server" />
                    <asp:HiddenField ID="hdnTemplateId" runat="server" />
                    <asp:HiddenField ID="hdnEMail" runat="server" />
                    <asp:HiddenField ID="hdnCheckValue" runat="server" />
                </td>
            </tr>
        </table>
        <%-- <applet archive="launchexe_signed.jar" code="launchexe.class" id="apltLaunchExe"
            name="apltLaunchExe" width="1" height="1">
        </applet>--%>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>

    <script type="text/javascript" language="javascript">
        if (document.getElementById('hdnHideDetails').value == "1") {
            //showResponses('ACX2plus3', 'ACX2minus3', 'ACX2responses3', 0);
        }
        if (document.getElementById('hdnReferralType').value == "I") {
            document.getElementById('tdRPinternal').style.display = 'block';
            document.getElementById('tdRPExternal').style.display = 'none';
        }
        if (document.getElementById('hdnReferralType').value == "E") {
            document.getElementById('tdRPExternal').style.display = 'block';
            document.getElementById('tdRPinternal').style.display = 'none';
        }
    </script>

    <div id="iframeplaceholder">
    </div>
    </form>
</body>
</html>
