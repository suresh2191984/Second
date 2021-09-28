<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationReportPrint.aspx.cs"
    Inherits="Investigation_InvestigationReportPrint" meta:resourcekey="PageResource1"
    EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="NotesPattern.ascx" TagName="NotesPattern" TagPrefix="uc41" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="DateCtrl" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<%@ Register Src="~/CommonControls/DespatchQueue.ascx" TagName="DespatchQ" TagPrefix="uc11" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
        .notification-bubble
        {
            background-color: #F56C7E;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.17) inset, 0 1px 1px rgba(0, 0, 0, 0.2);
            color: #FFFFFF;
            font-size: 9px;
            font-weight: bold;
            text-align: center;
            text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.2);
            -moz-transition: all 0.1s ease 0s;
            padding: 2px 3px 2px 3px;
        }
        .OutSrce
        {
            background-color: #D0FA58;
        }
        .AddScroll
        {
            height: 370px;
            width: 1200;
            padding-left: 50px;
            padding-top: 50px;
            overflow: auto;
        }
        .RemoveScroll
        {
            height: 370px;
            width: 1200;
        }
    </style>

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script type="text/javascript" src="../Scripts/grid.js"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script type="text/javascript">
        function popupprint1() {
            $('#table_GroupItem').removeClass('AddScroll').addClass('RemoveScroll');
            var prtContent = document.getElementById('dvInvstigationDetails');
            var table_GroupItem = document.getElementById('table_GroupItem');
            table_GroupItem.removeAttribute(scroll);
            var WinPrint = window.open('', '', 'letf=20,top=20,toolbar=0,scrollbars=yes,status=0,width=1524,height=1068');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            // WinPrint.close();
        }
        function WaterMark(txtbox, evt, defaultText) {
            if (txtbox.value.length == 0 && evt.type == "blur") {
                txtbox.style.color = "gray";
                txtbox.value = defaultText;
            }
            if (txtbox.value == defaultText && evt.type == "focus") {
                txtbox.style.color = "black";
                txtbox.value = "";
            }
        }

        function OpenBillPrint1(url) {
            window.open(url, "labelprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
        function ShowAlertMsg(key) {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_01') == null ? "This action cannot be performed for your role in this Organisation" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_01');
            var v2 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_02') == null ? "URL Not Found" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_02');
            var v3 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_03') == null ? "Report dispatched successfully" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_03');
            var v4 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_04') == null ? "Unable to dispatch the report. please contact system administrator" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_04');
            var v5 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_05') == null ? "Unable to get the report. please contact system administrator" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_05');
            var v6 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_06') == null ? "selected Patient Dispatched Investigation Reports" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_06');

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_25") {
                //alert('This action cannot be performed for your role in this Organisation');
                ValidationWindow(v1, AlertType);
            }

            else if (key == "Investigation\\InvestigationReport.aspx_26") {
                //alert('URL Not Found');
                ValidationWindow(v2, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_27") {
                //alert('Report dispatched successfully');
                ValidationWindow(v3, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_28") {
                // alert('Unable to dispatch the report. please contact system administrator');
                ValidationWindow(v4, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_29") {
                // alert('Unable to get the report. please contact system administrator');
                ValidationWindow(v5, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_30") {
                //alert(' selected Patient Dispatched Investigation Reports');
                ValidationWindow(v6, AlertType);
            }
            return true;
        }




        function checkdispatch() {
            //            if (document.getElementById('hdncourierboyid').value == "0") {
            //                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_1');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                }
            //                else {
            //                    alert('Enter the Correct Courier boy name');
            //                    return false;
            //                }
            //            }
            //            if (document.getElementById('txtcoruriersname').value == "") {
            //                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_2');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                } else {
            //                alert('Enter the Courier Boy name');
            //                return false;
            //                }
            //                document.getElementById('txtcoruriersname').focus();
            //               

            //            }
            //            if (document.getElementById('ddlDespatchMode').value == "0") {
            //                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_3');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                } else {
            //                alert('Select Dispatch mode');
            //                return false;
            //                }
            //                document.getElementById('ddlDespatchMode').focus();
            //            }
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_07') == null ? "You select dispatch mode as E-mail , Provide e-mail address" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_07');
            var v2 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_08') == null ? "You select dispatch mode as sms , Provide contact mobile number" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_08');
            var v3 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_09') == null ? "You select dispatch mode as courier , Provide Courier boy name" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_09');


            var elements = document.getElementById('chkDespatchMode1');
            for (i = 0; i < elements.rows[0].cells.length; i++) {
                if (elements.cells[i].childNodes[0].checked) {
                    if (document.getElementById('chkDespatchMode1').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "email") {

                        if (document.getElementById('txtPatientMail').value.trim() == '') {
                            //alert("You select despatch mode as E-mail , Provide e-mail address");
                            ValidationWindow(v1, AlertType);
                            document.getElementById('txtPatientMail').focus();
                            return false;
                        }
                    }
                    if (document.getElementById('chkDespatchMode1').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "sms") {
                        if (document.getElementById('txtPatientMobileNo').value.trim() == '') {
                            //alert('You select despatch mode as sms , Provide contact mobile number');
                            ValidationWindow(v2, AlertType);
                            document.getElementById('txtPatientMobileNo').focus();
                            return false;
                        }
                    }
                    if (document.getElementById('chkDespatchMode1').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "courier") {


                        if (document.getElementById('txtcoruriersname').value.trim() == '') {
                            //alert("You select despatch mode as courier , Provide Courier boy name");
                            ValidationWindow(v3, AlertType);
                            document.getElementById('txtcoruriersname').focus();
                            return false;


                        }

                    }

                }
            }
        }
        function GetEmpIDs(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtcoruriersname').value = eventArgs.get_text();
            document.getElementById('hdncourierboyid').value = strVal.split('~')[0].trim();
            //            document.getElementById('txtPrsnMobile').value = strVal.split('~')[1].trim();
        }

        //------Murali Changes---- //

        function GetDocEmpIDs(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtDRCoruriersname').value = eventArgs.get_text();
            document.getElementById('hdncourierboyid1').value = strVal.split('~')[0].trim();
        }

        function dateselect(ev) {
            var calendarBehavior1 = $find("CalendarExtender3");
            var d = calendarBehavior1._selectedDate;
            var now = new Date();
            calendarBehavior1.get_element().value = d.format("MM/dd/yyyy") + " " + now.format("HH:mm:ss")
        }

        function dateselect1(ev) {
            var calendarBehavior2 = $find("CalendarExtender4");
            var d = calendarBehavior2._selectedDate;
            var now = new Date();
            calendarBehavior2.get_element().value = d.format("MM/dd/yyyy") + " " + now.format("HH:mm:ss")
        }

        //----------Murali Changes End---//

        function GetText(pName) {
            if (pName != "") {
                // var Temp = pName.split('(');
                //if (Temp.length >= 2) {
                document.getElementById('txtName').value = pName;
                // }
            }
        }
        function ShowHideReport() {
            var hdnHideReportTemplate = document.getElementById('hdnHideReportTemplate');
            if (hdnHideReportTemplate != null && typeof hdnHideReportTemplate != 'undefined') {
                if (document.getElementById('hdnHideReportTemplate').value == "1") {
                    showResponses('ACX3plus1', 'ACX3minus1', 'ACX3responses1', 0);
                    showResponses('ACX3plus2', 'ACX3minus2', 'ACX3responses2', 1);
                }
                else {
                    showResponses('ACX3plus1', 'ACX3minus1', 'ACX3responses1', 1);
                    showResponses('ACX3plus2', 'ACX3minus2', 'ACX3responses2', 0);
                }
            }
        }

        //----Murali----//

        function PrintReport(VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {
            try {
                //if (IsGeneralClient == "N" && DueAmount > 0) {
                if (ClientID == 1 && DueAmount > 0) {
                    var ans = window.confirm('This Patient is having due amount,Do you want to print?');
                    if (ans == true) {
                        return onPrintPolicy('batch', VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow);
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return onPrintPolicy('batch', VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow);
                }
            }
            catch (e) {
                return false;
            }
        }

        //-------Murali Ends--//

        function PrintBatchReport(VID, RoleID) {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_10') == null ? "Please install adobe reader to perform print functionality" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_10');

            var browser_info = perform_acrobat_detection();
            if (browser_info.acrobat == null) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Please install adobe reader to perform print functionality");
                    ValidationWindow(v1, AlertType);
                    return false;
                }
            }
            else {
                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + VID + "&roleid=" + RoleID + "&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
            }
        }


        function setInputEnableState(reportViewer) {

            // It is ok to export if the viewer is not loading and is displaying a report.
            var disableInputs = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;


            $get("btnPrint").disabled = disableInputs;
        }

        function onReportViewerLoadingChanged(sender, e) {

            var propertyName = e.get_propertyName();

            if (propertyName === "isLoading" || propertyName === "reportAreaContentType") {
                setInputEnableState(sender);
            }
        }

        function onPrintButtonClicked() {
            var reportViewer = $find("rReportViewer");
            if (reportViewer != null) {
                reportViewer.invokePrintDialog();
            }
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
        function CheckHubName(codeType, TxtID) {
            var txtValue = document.getElementById(TxtID).value.trim();


            if (txtValue != '') {
                if (document.getElementById('hdnHubID').value == '0') {
                    alert('Select the Hub Name From List')
                    document.getElementById('txtHub').focus();
                    document.getElementById('txtHub').value = '';
                    return false;
                }
            }
        }
        function OnHubSelected(source, eventArgs) {
            document.getElementById('txtHub').value = eventArgs.get_text();
            document.getElementById('hdntxtHubID').value = eventArgs.get_value();
        }
        function popupClose() {
            return true;
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
        function SelectVisit(id, vid, pid, patOrgID, email, CreditLimit, ClientBlock, ClientDue, DispatchTypeMode, DispatchType, DispatchValue, IsHealthCheckup, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {
            //debugger;
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            //            var control = document.getElementById("chkSelectAll");
            //            document.getElementById("chkSelectAll").checked = false;
            //            control.disabled = true;

            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPID").value = pid;
            //            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("patOrgID").value = patOrgID;
            document.getElementById("hdnEMail").value = email;
            document.getElementById("hdncreditlimit").value = CreditLimit;
            document.getElementById("hdnclientBlock").value = ClientBlock;
            document.getElementById("hdnclientdue").value = ClientDue;
            document.getElementById("txtPatientMail").value = email;
            document.getElementById("hdnHealthcheckup").value = IsHealthCheckup;
            document.getElementById("hdnIsGeneralClient").value = IsGeneralClient;
            document.getElementById("hdnDue").value = DueAmount;
            document.getElementById("hdnClientID").value = ClientID;

        }
        function SelectDespatchVisit(id, vid, pid, patOrgID, email, pname, DispatchTypeMode, DispatchType, DispatchValue, IsHealthCheckup, DueAmount, ClientID) {
            //debugger;
            chosen = "";
            var len = document.forms[0].elements.length;
            //            for (var i = 0; i < len; i++) {
            //                if (document.forms[0].elements[i].type == "CheckBox") {
            //                    document.forms[0].elements[i].checked = false;
            //                }
            //            }

            document.getElementById("hdnDispatchType").value = DispatchType;
            document.getElementById("hdnDispatchMode").value = DispatchValue;
            document.getElementById("txtPatientMail").value = email;
            document.getElementById("hdnHealthcheckup").value = IsHealthCheckup;
            document.getElementById("hdnDue").value = DueAmount;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnClientID").value = ClientID;

            if (document.getElementById(id).checked == true) {
                document.getElementById("hdndespatchvisit").value += vid + '~' + pid + '~' + pname + '^';

            }
            else {
                if (document.getElementById('hdndespatchvisit').value != "") {
                    var s = document.getElementById('hdndespatchvisit').value.split("^");
                    document.getElementById('hdndespatchvisit').value = "";
                    document.getElementById('lbldespatchnames').value = "";
                    if (s != "") {
                        for (var i in s) {
                            var parts = s[i].split('~')[0];
                            if (vid != parts && parts != "") {
                                document.getElementById('hdndespatchvisit').value += s[i].split('~')[0] + '~' + s[i].split('~')[1] + '~' + s[i].split('~')[2] + '^';
                                document.getElementById('lbldespatchnames').value += s[i].split('~')[2] + '<br/><br/>';

                            }
                        }
                    }

                }
            }

        }


        function CheckVisitID() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_11') == null ? "Selected client patient not having Health Check Up details..." : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_11');
            var v2 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_12') == null ? "Please select the checkbox and dispatch" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_12');
            var v3 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_13') == null ? "Select at least one record" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_13');
            var v4 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_14') == null ? "Select only one record" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_14');
            var v5 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_15') == null ? "Selected client was Blocked" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_15');
            var v6 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_16') == null ? "This Client is Suspended and you will be able to see STAT and Critical Test reports only, Do you wish to Continue ?" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_16');
            var v7 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_17') == null ? "Select any one of the action to proceed" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_17');

            document.getElementById("hdnPDFType").value = 'showreport&invstatus';
            if ($('#ddlVisitActionName option:selected').val() == "Show_HealthReport_Patient") {
                if (document.getElementById('hdnHealthcheckup').value == "N") {
                    //alert('Selected client patient not having Health Check Up details...');
                    ValidationWindow(v1, AlertType);
                    return false;
                }
            }

            var s = document.getElementById('hdnrolename').value;
            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                if (document.getElementById("ddlVisitActionName").value == "Dispatch_Report_InvestigationReport") {
                    var chkboxrowcount = $("#grdResult input:checkbox[id*='chkSel']:checked").size();
                    if (chkboxrowcount == 0) {
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        } else {
                            //alert("Please select the checkbox and dispatch");
                            ValidationWindow(v2, AlertType);
                            return false;
                        }
                    }

                    //                    var grid = document.getElementById('grdResult');
                    //                    var flag = 0;
                    //                    $('[id$="parentgrid"] tbody tr').each(function(i, n) {
                    //                        var $row = $(n);
                    //                        var remarksID = $row.find($('input[id$="chkSel"]')).val();
                    //                        if ($row.find($('input[id$="chkSel"]:checked'))) {
                    //                            flag = flag + 1;
                    //                        }

                    //                    });

                    //                    if (flag == 0) {
                    //                        alert("Select The check Box");
                    //                        return false;
                    //                    }
                    //                    if (document.getElementById("hdnDue").value != "0.00" && document.getElementById("hdnIsGeneralClient").value == "N") {
                    //                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_6');
                    //                        if (userMsg != null) {
                    //                            alert(userMsg);
                    //                            return false;
                    //                        } else {
                    //                            alert('Selected Patient having due amount');

                    //                            return false;
                    //                        }
                    //                    }
                    //                    if (document.getElementById("hdnclientdue").value != "0.00") {
                    //                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
                    //                        if (userMsg != null) {
                    //                            alert(userMsg);
                    //                            return false;
                    //                        } else {
                    //                            alert('Selected client patient having outstanding amount..');
                    //                            return false;
                    //                        }
                    //                    }

                    //                    if (document.getElementById("hdnDue").value != "0.00") {
                    //                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
                    //                        if (userMsg != null) {
                    //                            alert(userMsg);
                    //                            return false;
                    //                        } else {
                    //                            alert('Selected client patient having outstanding amount..');
                    //                            return false;
                    //                        }
                    //                    }

                }

            }



            if ($('#ddlVisitActionName option:selected').val() != "Dispatch_Report_InvestigationReport") {

                var chkboxrowcount1 = $("#grdResult input:radio[id*='rdSel']:checked").size();
                if (chkboxrowcount1 == 0) {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert("Select at least one record");
                        ValidationWindow(v3, AlertType);
                        return false;
                    }
                }

                if (chkboxrowcount1 > 1) {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert("Select only one record");
                        ValidationWindow(v4, AlertType);
                        return false;
                    }
                }



                else {
                    if (document.getElementById("hdnclientBlock").value == 'T') {
                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_11');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        } else {
                            //alert('Selected client was Blocked');
                            ValidationWindow(v5, AlertType);
                            return false;
                        }
                    }
                    if (document.getElementById("hdnclientBlock").value == 'S') {
                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_11');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        }
                        else {
                            var IsContinue = confirm(v6);
                            if (IsContinue == true) {
                                return true;
                            }
                            else {
                                return false;
                            }
                            //alert('Selected Patient client was Blocked');
                            //return false;
                        }
                    }

                    if ($('#ddlVisitActionName option:selected').val() != "0") {
                        $('#hdnVisitDetail').val($('#ddlVisitActionName option:selected').text());
                        if ($('#ddlVisitActionName option:selected').val() == "Show_Report_InvestigationReport") {
                            $('#hdnHideDetails').val('1');
                        }
                        return true;
                    }
                    else {
                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_12');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        } else {
                            //alert('Select any one of the action to proceed');
                            ValidationWindow(v7, AlertType);
                            return false;
                        }
                    }
                }
            }


        }
        function CheckDue() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_18') == null ? "Selected patient having outstanding amount.." : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_18');

            var TrueFalse = "True";

            $("#divgv table tr").each(function() {
                var tr = $(this).closest("tr");
                if ($(tr).find("input:checkbox[id$=chkSel]").val() != undefined) {
                    var chk = $(tr).find("input:checkbox[id$=chkSel]").attr('checked') ? true : true;
                    if (chk == true) {
                        //debugger;
                        var PatClientID;
                        if (document.getElementById("hdnDue") != null) {
                            var hdnDue = document.getElementById("hdnDue").value;
                            if (document.getElementById("hdnClientID") != null) {
                                PatClientID = document.getElementById("hdnClientID").value;
                            }
                            if ((hdnDue != "0.00") && (hdnDue != "0") && (hdnDue != "-1") && (PatClientID == "1")) {
                                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
                                if (userMsg != null) {
                                    alert(userMsg);
                                    TrueFalse = 'False';
                                    return false;
                                } else {
                                    //alert('Selected patient having outstanding amount..');
                                    ValidationWindow(v1, AlertType);
                                    TrueFalse = "False";
                                    return false;
                                }
                            }
                        }
                    }
                }
            });

            if (TrueFalse == "False") {
                return false;
            }

            $("#divgv table tr").each(function() {
                var tr = $(this).closest("tr");
                if ($(tr).find("input:radio[id$=rdSel]").val() != undefined) {
                    var chk = $(tr).find("input:radio[id$=rdSel]").attr('checked') ? true : false;
                    if (chk == true) {
                        var PatClientID;
                        if (document.getElementById("hdnDue") != null) {
                            var hdnDue = document.getElementById("hdnDue").value;
                            if (document.getElementById("hdOrgID") != null) {
                                if (document.getElementById("hdOrgID").value != null) {
                                    document.getElementById("patOrgID").value = document.getElementById("hdOrgID").value;
                                }
                                if (document.getElementById("hdnClientID") != null) {
                                    PatClientID = document.getElementById("hdnClientID").value;
                                }
                            }
                            if ((hdnDue != "0.00") && (hdnDue != "0") && (hdnDue != "-1") && (PatClientID == "1")) {
                                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
                                if (userMsg != null) {
                                    alert(userMsg);
                                    TrueFalse = 'False';
                                    return false;
                                } else {
                                    //alert('Selected patient having outstanding amount..');
                                    ValidationWindow(v1, AlertType);
                                    TrueFalse = "False";
                                    return false;
                                }
                            }
                        }
                    }
                }
            });
            if (TrueFalse == "False") {
                return false;
            }
            if (document.getElementById('hdnpreviousdue').value != "") {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Selected patient having outstanding amount..');
                    ValidationWindow(v1, AlertType);
                    return false;
                }
            }

            if (TrueFalse == "False") {
                return false;
            }
            else {
                return true;
            }

        }

        function CheckVisitID1() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_19') == null ? "Select at least one record" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_19');
            var v2 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_20') == null ? "Select only one record" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_20');

            var s = document.getElementById('hdnrolename').value;
            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                var chkboxrowcount1 = $("#gvIndv input:checkbox[id*='chkSel1']:checked").size();
                if (chkboxrowcount1 == 0) {
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert("please select at least one record");
                        ValidationWindow(vPageNo, AlertType);
                        return false;
                    }
                }
            }
            var TrueFalse = "True";

            //            $("#divIndv table tr").each(function() {
            //                var tr = $(this).closest("tr");
            //                if ($(tr).find("input:checkbox[id$=chkSel1]").val() != undefined) {
            //                    var chk = $(tr).find("input:checkbox[id$=chkSel1]").attr('checked') ? true : false;
            //                    if (chk == true) {
            //                        var hdnDue = $(tr).find("input:hidden[id$=hdnOutSourceDue]") ? $(tr).find("input:hidden[id$=hdnOutSourceDue]").val() : '';
            //                        if (hdnDue != "0.00") {
            //                            var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
            //                            if (userMsg != null) {
            //                                alert(userMsg);
            //                                TrueFalse = 'False';
            //                                return false;
            //                            } else {
            //                                alert('Selected client patient having outstanding amount..');
            //                                TrueFalse = "False";
            //                                return false;
            //                            }
            //                        }
            //                    }
            //                }
            //            });

            //            if (TrueFalse == "False") {
            //                return false;
            //            }
            //            else {
            //                return true;
            //            }

            var chkboxrowcount1 = $("#gvIndv input:checkbox[id*='chkSel1']:checked").size();
            if (chkboxrowcount1 == 0) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Select at least one record");
                    ValidationWindow(v1, AlertType);
                    return false;
                }
            }

            if (chkboxrowcount1 > 1) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Select only one record");
                    ValidationWindow(v2, AlertType);
                    return false;
                }
            }
        }

        function CheckPrint() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v3 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_21') == null ? "please select at least one record" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_21');
            var v4 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_22') == null ? "please select printer location" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_22');

            //            var s = document.getElementById('hdnrolename').value;
            //            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
            var chkboxrowcount1 = $("#grdResult input:checkbox[id*='chkSel']:checked").size();
            //            var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
            if (chkboxrowcount1 == 0) {
                //alert("please select at least one record");
                ValidationWindow(v3, AlertType);
                return false;
            }

            else {
                if (document.getElementById('ddlLocationPrinter').value == '-1') {
                    //alert("please select printer location");
                    ValidationWindow(v4, AlertType);
                    return false;
                }

                else {
                    //                alert('Selected');
                    return true;
                }
            }
        }

        //        }



        function ChechVisitDate() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v3 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_23') == null ? "Provide visit date" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_23');

            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value != '' || document.getElementById('txtTo').value != '') {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_14');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Provide visit date');
                    ValidationWindow(v3, AlertType);
                    return false;

                }
                document.form1.txtFrom.focus();
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

        function ChkIfSelected(obj) {
            // alert(obj);
            if (document.getElementById(obj).checked) {
                document.getElementById('ChkID').value = obj + '^';
            }
            else {
                //alert('else');
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
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v24 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_24') == null ? "Select an investigation to display  report" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_24');

            if (document.getElementById('ChkID').value != '') {
                HideDiv();
                return true;
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_15');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Select an investigation to display  report');
                    ValidationWindow(v24, AlertType);
                    return false;

                }
            }
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
        function EnableAll(IsChecked) {
            var chkArrayMain = new Array();
            var chkArraydisable = new Array();
            var UniqTemplateChkId = IsChecked.substring(0, 19);
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            chkArraydisable = document.getElementById('Hdndisablebox').value.split('~');
            if (document.getElementById(IsChecked).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        document.getElementById(chkArrayMain[i]).disabled = false;
                        document.getElementById(chkArrayMain[i]).checked = true;
                    }
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    //if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                    document.getElementById(chkArrayMain[i]).disabled = false;
                    document.getElementById(chkArrayMain[i]).checked = false;
                    if (chkArraydisable[i] > 0) {
                        document.getElementById(chkArrayMain[i]).disabled = true;
                    }
                    //  }
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
                        //                         var chkid= SpecList[0];
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
            //            document.getElementById('hdndeptid').value = "";

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

        function ValidateCheckBox() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_25') == null ? "Select an investigation" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_25');

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
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_16');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Select an investigation');
                    ValidationWindow(v1, AlertType);
                    return false;
                }

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



        function pdfPrint() {
            document.getElementById("hdnPDFType").value = 'prtpdf';
            //            var prtContent = document.getElementById('Divpdf');
            //            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=1000,height=500');
            //            //alert(WinPrint);
            //            WinPrint.document.write(prtContent.innerHTML);
            //            WinPrint.document.close();
            //            WinPrint.focus();
            //            WinPrint.print();

        }
        function PriorityValidation() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v26 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_26') == null ? "Already generated the priority report for this visit" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_26');

            if (document.getElementById("hdnPriority").value == '1') {
                //alert('Already generated the priority report for this visit');
                ValidationWindow(v26, AlertType);
                return false;
            }
            //            if (document.getElementById("hdnPriority").value == '-1') {
            //                alert('Unable to set the priority for Dispatched Report');
            //                return false;
            //            }
        }


        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";


            document.getElementById('txtFromPeriod').value = "";
            document.getElementById('txtToPeriod').value = "";

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
        function onPrintReport(VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v27 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_27') == null ? "This Patient having due amount" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_27');

            try {
                if (document.getElementById("hdnDue").value != "0.00" && document.getElementById("hdnClientID").value == "1" && document.getElementById("hdnDue").value != "0") {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_6');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert('This Patient having due amount');
                        ValidationWindow(v27, AlertType);
                        return false;
                    }
                } else {

                    //return onPrintPolicy('single', 0, 0, 0);
                    return onPrintPolicy('single', VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow);

                }
            }
            catch (e) {
                return false;
            }
        }
        function onPrintSingleReport() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v28 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_28') == null ? "Unable to print report" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_28');

            var reportViewer = $find("rReportViewer");
            if (reportViewer != null) {
                var disablePrint = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;
                if (!disablePrint) {
                    reportViewer.invokePrintDialog();
                    return true;

                }
                else
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_17');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Unable to print report");
                    ValidationWindow(v28, AlertType);
                    return false;
                }
            }
            return false;
        }
        function PopupClose() {
            document.getElementById('hdnShowReport').value = 'false';
        }
        function CheckMailAddress() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var v1 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_31') == null ? "Provide a valid email address." : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_31');
            var v2 = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_32') == null ? "Provide a email address." : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_32');

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
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_18');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert('Provide a valid email address.');
                        ValidationWindow(v1, AlertType);
                        return false;
                    }
                    txtMailAddress.focus();

                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_19');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Provide a email address.");
                    ValidationWindow(v2, AlertType);
                    return false;
                }
                txtMailAddress.focus();
                return false;
            }
        }
        function SelectedPatient(source, eventArgs) {
            var isPatientDetails = "";
            isPatientDetails = eventArgs.get_value();
            var PatientName = eventArgs.get_text().split(':')[0];
            document.getElementById('txtName').value = PatientName;
        }
        function SelectedClientValue(source, eventArgs) {
            var Name = eventArgs.get_text();
            var ID = eventArgs.get_value();
            document.getElementById('hdnClientID').value = eventArgs.get_value().split('|')[0];
            if (Number(eventArgs.get_value().split('~')[1]) > 0) {
                document.getElementById('tdprevdue').style.display = 'block';
                document.getElementById('hdnpreviousdue').value = eventArgs.get_value().split('~')[1];
                document.getElementById('lblpreviousdue').value = eventArgs.get_value().split('~')[1];
            }
        }
        function GetReferingPhysicianID(source, eventArgs) {
            document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
            document.getElementById('hdnPhysicianValue').value = eventArgs.get_value();
        }
        function GetReferingOrgID(source, eventArgs) {
            document.getElementById('txtReferringHospital').value = eventArgs.get_text();
            var refHospID = eventArgs.get_value();
            document.getElementById('hdfReferalHospitalID').value = refHospID;
        }
        function SelectedTest(source, eventArgs) {

            document.getElementById('txtTestName').value = eventArgs.get_text();
            TestDetails = eventArgs.get_value();
            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('hdnTestID').value = TestID;
            document.getElementById('hdnTestType').value = TestType;
        }
        function Onzoneselected(source, eventArgs) {
            document.getElementById('txtzone').value = eventArgs.get_text();
            document.getElementById('hdntxtzoneID').value = eventArgs.get_value();
        }
        function SetSearchReport(obj) {

            if (obj == "RPT") {
                document.getElementById('hdnSetSearchType').value = "RPT";
            }

            if (obj == "BILL") {
                document.getElementById('hdnSetSearchType').value = "BILL";

            }

        }
        function ClearFields() {

            if (document.getElementById('txtClientName').value.trim() == "") {
                document.getElementById('hdnClientID').value = "";
            }
            if (document.getElementById('txtInternalExternalPhysician').value.trim() == "") {
                document.getElementById('hdnPhysicianValue').value = "0";
            }
            if (document.getElementById('txtReferringHospital').value.trim() == "") {
                document.getElementById('hdfReferalHospitalID').value = "0";
            }
            if (document.getElementById('txtTestName').value.trim() == "") {
                document.getElementById('hdnTestID').value = "0";
                document.getElementById('hdnTestType').value = "";
            }
            if (document.getElementById('txtzone').value.trim() == "") {
                document.getElementById('hdntxtzoneID').value = "0";
            }
            if (document.getElementById('txtHube').value.trim() == "") {
                document.getElementById('hdntxtHubID').value = "0";
            }
            if (document.getElementById('txtPersonName').value.trim() == "") {
                document.getElementById('hdnEmpID').value = "0";
            }
        }
        function GetEmpID(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtPersonName').value = eventArgs.get_text();
            document.getElementById('hdnEmpID').value = strVal.split('~')[0].trim();
        }
        function SetContextKey() {
            var deptName = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].text;
            var deptID = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].value;
            if (deptName == 'COURIER') {
                $find('AutoCompleteExtender3').set_contextKey(deptID);
            }
            return;
        }
        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 45) || (key == 46) || (key == 95) || (key == 37) || (key == 36)) {
                isCtrl = true;
            }

            return isCtrl;
        }
        function validateonoroff() {
            document.getElementById('hdnonoroff').value = "N";
        }
        function checkForValues() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vPage = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_34') == null ? "Provide page number" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_34');
            var vCorrectPage = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_35') == null ? "Provide correct page number" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_35');

            if (document.getElementById('txtpageNo').value == "") {
                //alert('Provide page number');
                ValidationWindow(vPage, AlertType);
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPage, AlertType);
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPage, AlertType);
                return false;
            }
            return true;
        }

        function SelectAllTest(sender) {

            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('hdndespatchClientId').value.split('~');
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                    //                    col_num = document.getElementById("rdSel").value;
                    //                    rows = document.getElementById("grdResult").rows;
                    //                    for(var j = 0; j < rows.count; j++) 
                    //                    {
                    //                    rows[i].cells[col_num].disable=true ;
                    //                    }
                }
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                    //                    col_num = document.getElementById("rdSel").value;
                    //                    rows = document.getElementById("grdResult").rows;
                    //                    for (var j = 0; j < rows.count; j++) {
                    //                        rows[i].cells[col_num].disable = false;
                    //                    }
                }
            }
        }
       
    </script>

</head>
<body id="oneColLayout">
    <form id="form1" runat="server" defaultbutton="btnSearch">

    <script type="text/jscript">

        function ShowPopUp(visitnumber) {
            var ReturnValue = window.showModalDialog("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "dialogWidth=1000px;dialogHeight=750px;scroll:yes; status:yes;")
        }

        jQuery(function($) {
            //debugger;
            var allCkBoxSelector = 'input[id*="chkAll"]:checkbox';
            var checkBoxSelector = '#<%=grdResult.ClientID%> input[id*="chkSel"]:checkbox';
            function ToggleCheckUncheckAllOptionAsNeeded() {
                var totalCkboxes = $(checkBoxSelector),
                    checkedCheckboxes = totalCkboxes.filter(":checked"),
                    noCheckboxesAreChecked = (checkedCheckboxes.length == 0),
                    allCkboxesAreChecked = (totalCkboxes.length == checkedCheckboxes.length);
                $(allCkBoxSelector).attr('checked', allCkboxesAreChecked);
            }

            $(allCkBoxSelector).live('click', function() {
                $(checkBoxSelector).attr('checked', $(this).is(':checked'));
                ToggleCheckUncheckAllOptionAsNeeded();
            });
            $(checkBoxSelector).live('click', ToggleCheckUncheckAllOptionAsNeeded);
            ToggleCheckUncheckAllOptionAsNeeded();
        });

        function showsearch() {
            document.getElementById('trhide1').style.display = 'table-row';
            document.getElementById('trhide2').style.display = 'table-row';
            document.getElementById('trhide3').style.display = 'table-row';
            document.getElementById('Div5').style.display = 'none';
            document.getElementById('Div6').style.display = 'block';

        }
        function Hidesearch() {
            document.getElementById('trhide1').style.display = 'none';
            document.getElementById('trhide2').style.display = 'none';
            document.getElementById('trhide3').style.display = 'none';
            document.getElementById('Div5').style.display = 'block';
            document.getElementById('Div6').style.display = 'none';

        }

    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UP" runat="server">
        <ContentTemplate>
            <Attune:Attuneheader ID="Attuneheader" runat="server" />
            <div class="contentdata">
                <table cellpadding="2" style="display: none" cellspacing="1" width="100%">
                    <tr id="tdAberrant" runat="server">
                        <td class="a-right w-100p">
                            <uc11:DespatchQ ID="DespatchQueue" runat="server" />
                        </td>
                    </tr>
                </table>
                <table id="tblPatient" runat="server" class="w-100p searchPanel">
                    <tr>
                        <td>
                            <asp:Panel ID="Panel3" DefaultButton="btnSearch" BorderWidth="0px" runat="server"
                                meta:resourcekey="Panel3Resource1" CssClass="w-100p">
                                <div style="display: block;" class="dataheader2 w-100p">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblVisitNo" Text="Visit No" runat="server" meta:resourcekey="lblVisitNoaResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtVisitNo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtVisitNoResource1"></asp:TextBox>
                                            </td>
                                            <td class="w-15p">
                                                <asp:Label ID="lblName" Text="Patient Name" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                            </td>
                                            <td class="w-15p">
                                                <asp:TextBox ID="txtName" CssClass="Txtboxsmall" OnChange="javascript:GetText(document.getElementById('txtName').value);"
                                                    runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtName"
                                                    FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="1" ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                                                    DelimiterCharacters="" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td class="w-15p">
                                                <asp:Label ID="lblMobile" Text="Contact No" runat="server" meta:resourcekey="lblconResource1"></asp:Label>
                                            </td>
                                            <td class="w-15p">
                                                <asp:TextBox ID="txtMobile" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblclient" Text="Client" runat="server" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtClientName" runat="server" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                    BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                                    ServiceMethod="GetClientList" OnClientItemSelected="SelectedClientValue" ServicePath="~/WebService.asmx"
                                                    DelimiterCharacters="" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblReferringPhysician" Text="Ref.Dr" runat="server" meta:resourcekey="lblReferPhysicianResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="Txtboxsmall"
                                                    onBlur="return ClearFields();" meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" TargetControlID="txtInternalExternalPhysician"
                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                    ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="GetReferingPhysicianID"
                                                    DelimiterCharacters="" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnPhysicianValue" Value="0" runat="server"></asp:HiddenField>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblddlocation" Text="Reg.Location" runat="server" meta:resourcekey="lblddreglocationResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <span class="richcombobox" style="width: 155px;">
                                                    <asp:DropDownList ID="ddlocation" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddlocationResource2">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label10" Text="Department" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <span class="richcombobox" style="width: 155px;">
                                                    <asp:DropDownList ID="drpdepartment" CssClass="ddl" Width="155px" runat="server"
                                                        meta:resourcekey="drpdepartmentResource1">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTestName" Text="Test Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderTestName" MinimumPrefixLength="2"
                                                    runat="server" TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg"
                                                    ServicePath="~/WebService.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11"
                                                    CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                    OnClientItemSelected="SelectedTest" DelimiterCharacters="">
                                                </cc1:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnTestID" Value="0" runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="hdnTestType" runat="server"></asp:HiddenField>
                                            </td>
                                            <td class="style3">
                                                <asp:Label ID="Label23" Text="Hub" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                            </td>
                                            <td class="style4">
                                                <asp:TextBox ID="txtHub" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox1"
                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onchange="javascript:return ClearFields('HUB');"
                                                    meta:resourcekey="txtHubResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" TargetControlID="txtHub"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHubDetails"
                                                    OnClientItemSelected="OnHubSelected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                    Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                                <input type="hidden" id="hdntxtHubID" runat="server" value="0" />
                                            </td>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label7" Text="Zone" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtzone" runat="server" CssClass="Txtboxsmall" AutoComplete="off"
                                                          OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onBlur="return ClearFields();"
                                                        meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                                        OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                        Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                    <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblddlPrintLocation" Text="Print.Location" runat="server" meta:resourcekey="lblddlPrintLocationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox" style="width: 155px;">
                                                        <asp:DropDownList ID="ddlPrintLocation" CssClass="ddl" Width="155px" runat="server"
                                                            meta:resourcekey="ddlPrintLocationResource2">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPrintType" Text="Printable Type" runat="server" meta:resourcekey="lblddlPrintLocationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox" style="width: 155px;">
                                                        <asp:DropDownList ID="ddlPrintType" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddlPrintLocationResource2">
                                                            <%--<asp:ListItem Text="Investigation Report" Value="RPT" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="Dispatch Checklist" Value="RPTCHK" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="Receipt" Value="BILL" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStatus" Text="Visit Status" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox" style="width: 155px;">
                                                        <asp:DropDownList ID="ddstatus" runat="server" CssClass="ddl" Width="155px" meta:resourcekey="ddstatusResource1">
                                                            <%--<asp:ListItem Text="---Select---" Value="---Select---" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                            <asp:ListItem Text="Non Printed" Value="Non Printed" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                            <asp:ListItem Text="Printed" Value="Printed" meta:resourcekey="ListItemResource6"></asp:ListItem>--%>
                                                            <%--<asp:ListItem Text="Pending" Value="Pending" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="v-top">
                                                    <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Approved Date" meta:resourcekey="Rs_RegisteredDateResource1"></asp:Label>
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
                                                    <span class="richcombobox" style="width: 155px;">
                                                        <asp:DropDownList ID="ddlRegisterDate" CssClass="ddl" Width="155px" onChange="javascript:return ShowRegDate();"
                                                            runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                                           <%-- <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource12" Text="--Select--"></asp:ListItem>
                                                            <asp:ListItem Value="0" meta:resourcekey="ListItemResource13" Text="This Week"></asp:ListItem>
                                                            <asp:ListItem Value="1" meta:resourcekey="ListItemResource14" Text="This Month"></asp:ListItem>
                                                            <asp:ListItem Value="2" meta:resourcekey="ListItemResource15" Text="This Year"></asp:ListItem>
                                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource16" Text="Custom Period"></asp:ListItem>
                                                            <asp:ListItem Value="4" meta:resourcekey="ListItemResource17" Text="Today"></asp:ListItem>
                                                            <asp:ListItem Value="5" meta:resourcekey="ListItemResource18" Text="Last Week"></asp:ListItem>
                                                            <asp:ListItem Value="6" meta:resourcekey="ListItemResource19" Text="Last Month"></asp:ListItem>
                                                            <asp:ListItem Value="7" meta:resourcekey="ListItemResource20" Text="Last Year"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </span>
                                                    <div id="divRegDate" style="display: none" runat="server">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="divRegCustomDate" runat="server" style="display: none;">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                                </td>
                                                                <td>
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
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                                </td>
                                                                <td>
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
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <asp:CheckBox ID="chhprintall" runat="server" Text="Print All" meta:resourcekey="chhprintallResource1" />
                                            </td>
                                        </tr>
                                        <tr id="trhide1" runat="server">
                                            <td class="w-15p">
                                                <asp:Label runat="server" ID="lblPatientNo" Text="Patient No" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                            </td>
                                            <td class="w-15p">
                                                <asp:TextBox ID="txtPatientNo" onKeyPress="onEnterKeyPress(event);" MaxLength="16"
                                                    runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblLabNo" Text="Lab No" runat="server" meta:resourcekey="lblLabNoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtLabNo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtLabNoResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblddVisittype" Text="Visit Type" runat="server" meta:resourcekey="lblddVisittypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <span class="richcombobox" style="width: 155px;">
                                                    <asp:DropDownList ID="ddVisitType" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddVisitTypeResource1">
                                                       <%-- <asp:ListItem Text="---Select---" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr id="trhide2" runat="server">
                                            <td style="display: none">
                                                <asp:Label ID="lblContactType" Text="Courier Person" runat="server" meta:resourcekey="lblContactTypeResource1"></asp:Label>
                                            </td>
                                            <td id="tdCourier" runat="server" style="display: none">
                                                <span class="richcombobox" style="width: 55px; display: none;">
                                                    <asp:DropDownList runat="server" ID="drplstPerson" CssClass="ddl" Width="55px" meta:resourcekey="drplstPersonResource1">
                                                    </asp:DropDownList>
                                                </span>
                                                <asp:TextBox ID="txtPersonName" runat="server" CssClass="Txtboxsmall" AutoComplete="off"
                                                    onBlur="return ClearFields();" meta:resourcekey="txtPersonNameResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtPersonName"
                                                    EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                    OnClientItemSelected="GetEmpID" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                    DelimiterCharacters="" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <input type="hidden" id="hdnEmpID" value="0" runat="server" />
                                            </td>
                                            <td style="display: none">
                                                <asp:Label ID="Label21" Text="Priority Type" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                            </td>
                                            <td style="display: none">
                                                <span class="richcombobox" style="width: 155px;">
                                                    <asp:DropDownList ID="drpPriority" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="drpPriorityResource1">
                                                        <%--<asp:ListItem Value="0" Text="--Select--" Selected="True" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                        <asp:ListItem Value="1" Text="Normal" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                        <asp:ListItem Text="Emergency" Value="2" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                        <asp:ListItem Text="VIP" Value="3" meta:resourcekey="ListItemResource11"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                            <td style="display: none">
                                                <asp:Label ID="lblwardName" Text="Ward Name" runat="server" meta:resourcekey="lblwardNameResource1"></asp:Label>
                                            </td>
                                            <td style="display: none">
                                                <asp:TextBox ID="txtWardName" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtWardNameResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="display: none">
                                                <asp:Label ID="lblDespatchType" runat="server" Text="Dispatch Type" meta:resourcekey="lblDespatchTypeResource1"></asp:Label>
                                            </td>
                                            <td style="display: none">
                                                <asp:Panel ID="panelDispatchType" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="True"
                                                    meta:resourcekey="panelDispatchTypeResource1">
                                                    <asp:CheckBoxList ID="chkDisPatchType" RepeatDirection="Vertical" runat="server"
                                                        Font-Size="10px" Font-Bold="true" meta:resourcekey="chkDisPatchTypeResource1">
                                                    </asp:CheckBoxList>
                                                </asp:Panel>
                                            </td>
                                            <td style="display: none">
                                                <asp:Label ID="lbldispatchmode" runat="server" Text="Dispatch Mode" meta:resourcekey="lbldispatchmodeResource1"></asp:Label>
                                            </td>
                                            <td style="display: none">
                                                <asp:Panel ID="panelDispatchMode" runat="server" CssClass="dataheaderInvCtrl" Width="47%"
                                                    Font-Bold="true">
                                                    <asp:CheckBoxList ID="chkDespatchMode" RepeatDirection="Horizontal" RepeatColumns="1"
                                                        runat="server" Font-Size="10px" Font-Bold="True" meta:resourcekey="chkDespatchModeResource1">
                                                    </asp:CheckBoxList>
                                                    <asp:DropDownList ID="DropDownList1" Style="display: none;" Width="86%" CssClass="ddl"
                                                        runat="server" meta:resourcekey="DropDownList1Resource1">
                                                    </asp:DropDownList>
                                                </asp:Panel>
                                            </td>
                                            <td class="v-top" style="display: none">
                                                <asp:Label ID="lblPreference" Text="Preference" runat="server" meta:resourcekey="lblPreferenceResource1"></asp:Label>
                                            </td>
                                            <td class="v-top" style="display: none">
                                                <span class="richcombobox" style="width: 80px;">
                                                    <asp:DropDownList ID="ddlPriority" CssClass="ddl" runat="server" Width="80px" meta:resourcekey="ddlPriorityResource1">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr id="trhide3" runat="server">
                                            <td>
                                                <asp:Label ID="lblRefOrg" Text="Referring Organization" runat="server" meta:resourcekey="lblRefOrgResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtReferringHospital" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                    TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                                    CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingOrgID"
                                                    DelimiterCharacters="" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="Chkoutsource" Visible="false" runat="server" Text="OUTSOURCE" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <%-- <tr>--%>
                                            <td class="colorforcontent">
                                                <div id="Div5" runat="server">
                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                        onclick="showsearch()" style="cursor: pointer" />
                                                    <span class="dataheader1txt" style="cursor: pointer">&nbsp;<asp:Label ID="Label2"
                                                        runat="server" Text="More Search Options" onclick="showsearch()" meta:resourcekey="lblinvfilter1Resource1"></asp:Label></span></div>
                                                <div id="Div6" style="display: none;" runat="server">
                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                        onclick="Hidesearch()" style="cursor: pointer" />
                                                    <span class="dataheader1txt" style="cursor: pointer">
                                                        <asp:Label ID="Label4" runat="server" Text="Hide Search Options" onclick="Hidesearch()"
                                                            meta:resourcekey="lblinvfilters1Resource1"></asp:Label></span></div>
                                            </td>
                                            <%--</tr>--%>
                                            <td colspan="2" class="a-right v-middle">
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnSearch_Click" TabIndex="13" meta:resourcekey="btnSearchResource1" />
                                            </td>
                                            <td colspan="3" class="a-left">
                                                <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                                    <ProgressTemplate>
                                                        <div id="progressBackgroundFilter">
                                                        </div>
                                                        <asp:Image ID="imgProgressbar2" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                        <asp:Label ID="Rs_Pleasewait2" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <table id="tblgrdview" class="w-100p" runat="server" style="display: none;">
                    <tr>
                        <td class="colorforcontent w-100p h-23 a-left">
                            <div id="ACX2plus3" style="display: none;">
                                &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                    style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">
                                    &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Investigation Report Print"
                                        meta:resourcekey="lblinvfilterResource1"></asp:Label></span></div>
                            <div id="ACX2minus3" style="display: block;">
                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                    style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);">
                                    <asp:Label ID="lblinvfilters" runat="server" Text="Investigation Report Print" meta:resourcekey="lblinvfiltersResource1"></asp:Label></span></div>
                        </td>
                    </tr>
                    <tr class="a-center">
                        <td id="tdprevdue" runat="server" style="display: table-cell;" colspan="5">
                            <asp:Label ID="lblpreviousdue" runat="server" ForeColor="Red" Text="0" meta:resourcekey="lblpreviousdueResource1" />
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses3" style="display: table-row;">
                        <td>
                            <table border="1" id="GrdHeader" runat="server" style="display: block" width="100%">
                                <tr class="dataheader1">
                                    <td class="w-5p a-center">
                                        <asp:Label ID="RdSel" runat="server" Text="Select" meta:resourcekey="RdSelResource1"></asp:Label>
                                    </td>
                                    <td class="w-6p a-center">
                                        <asp:Label ID="Rs_Select" runat="server" Text="Print" meta:resourcekey="Rs_SelectResource1"></asp:Label>
                                    </td>
                                    <td class="w-10p a-center">
                                        <asp:Label ID="Rs_PatientNo1" runat="server" Text="Visit Number" meta:resourcekey="Rs_PatientNo12vResource1"></asp:Label>
                                    </td>
                                    <td class="w-13p a-center">
                                        <asp:Label ID="Rs_Name" runat="server" Text="Patient Name" meta:resourcekey="Rs_NameResources1"></asp:Label>
                                    </td>
                                    <td class="w-8p a-center">
                                        <asp:Label ID="Rs_Age" runat="server" Text="Gender/Age" meta:resourcekey="Rs_Age1aResource1"></asp:Label>
                                    </td>
                                    <td class="w-18p a-center">
                                        <asp:Label ID="Rs_URNNo" runat="server" Text="VisitDate" meta:resourcekey="Rs_URNNoResource1"></asp:Label>
                                    </td>
                                    <%-- <td align="center" visible="false">
                                                        <asp:Label ID="Rs_MobileNumber" runat="server" Text="VisitPurposeName" meta:resourcekey="Rs_MobileNumberResource1"></asp:Label>
                                                    </td>--%>
                                    <%-- <td visible="false">
                                                        <asp:Label ID="Rs_Address" runat="server" Text="PhysicianName" meta:resourcekey="Rs_AddressResource1"></asp:Label>
                                                    </td>--%>
                                    <td runat="server" id="tdorg" class="w-15p a-center">
                                        <asp:Label ID="Rs_ToBePerformStatus" runat="server" Text="RefPhysicianName" meta:resourcekey="Rs_ToBePerformStatusResource1"></asp:Label>
                                    </td>
                                    <td runat="server" id="td12" class="w-15p a-center">
                                        <asp:Label ID="Label9" runat="server" Text="Reg.Location" meta:resourcekey="Label9lResource1"></asp:Label>
                                    </td>
                                    <td runat="server" id="td17" class="w-12p a-center">
                                        <asp:Label ID="Label22" runat="server" Text="Client" meta:resourcekey="LabelclResource1"></asp:Label>
                                    </td>
                                    <%--  <td runat="server" align="center" id="tddue" style="width: 10%">
                                                        <asp:Label ID="Label10" runat="server" Text="DueAmount" meta:resourcekey="Label10Resource1"></asp:Label>
                                                    </td>--%>
                                    <td runat="server" class="w-3p a-center" id="tdActionse">
                                        <asp:CheckBox ID="chkAll" runat="server" ToolTip="Select Row" meta:resourcekey="chkAllResource1">
                                        </asp:CheckBox>
                                    </td>
                                    <td style="display: none;">
                                        <asp:Label ID="Rs_TrackId" runat="server" Text="Select" meta:resourcekey="Rs_TrackIdResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <div id="divgv">
                                            <asp:GridView ID="grdDispatchList" EmptyDataText="No Record Found" runat="server"
                                                AllowPaging="True" CellPadding="1" AutoGenerateColumns="False" DataKeyNames="PatientVisitId"
                                                ForeColor="White" CssClass="mytable1 gridView w-100p" meta:resourcekey="grdDispatchListResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="PatientVisitID" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblVisitDate1" runat="server" Text='<%# bind("PatientVisitId") %>'
                                                                meta:resourcekey="lblVisitDate1Resource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="False" HeaderText="Patient No." meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblpatientno" runat="server" Text='<%# bind("PatientNumber") %>' meta:resourcekey="txtPatientvisitIdResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="txtPatientvisitId" Text='<%# Bind("PatientVisitId") %>' runat="server"
                                                                Style="display: none" />
                                                            <asp:Label ID="FinalURN" Text='<%# Bind("URNofId") %>' runat="server" Style="display: none" />
                                                            <asp:Label ID="txtDispatch" runat="server" Text='<%# bind("Remarks") %>' Style="display: none" />
                                                            <asp:Label ID="txtpatientId" Text='<%# Bind("PatientID") %>' runat="server" Style="display: none" />
                                                            <input id="hdnOutSourceDue" type="hidden" runat="server" value='<%# Eval("Due ")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Visit Date" meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblVisitDate" runat="server" Text='<%# bind("VisitDate") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Patient Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblpatientname" runat="server" Text='<%# bind("PatientName") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="false" CellPadding="1" AutoGenerateColumns="False"
                                                DataKeyNames="PatientVisitID,Name" OnRowDataBound="grdResult_RowDataBound" OnItemCommand="grdResult_ItemCommand"
                                                OnRowCommand="grdResult_RowCommand" ItemStyle-VerticalAlign="Top" RepeatDirection="Horizontal"
                                                OnPageIndexChanging="grdResult_PageIndexChanging" meta:resourcekey="grdResultResource1"
                                                CssClass="gridView w-100p">
                                                <PagerStyle HorizontalAlign="Center" />
                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                    PageButtonCount="5" PreviousPageText="" />
                                                <Columns>
                                                    <asp:BoundField Visible="false" DataField="VisitNumber" HeaderText="VID" meta:resourcekey="BoundFieldResource1" />
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <table id="parentgrid" runat="server" border="0" class="w-100p a-left">
                                                                <tr id="Tr1" runat="server">
                                                                    <td id="Td1" nowrap="nowrap" class="w-5p a-center" runat="server">
                                                                        <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                                    </td>
                                                                    <td id="printimage" class="w-3p a-center" runat="server">
                                                                        <img id="imgPrintReport" title="Print" runat="server" alt="Print" visible="false"
                                                                            src="~/Images/printer.gif" style="cursor: pointer;" />
                                                                        <asp:ImageButton ID="Image1" ImageUrl="../Images/WithStationary.ico" runat="server"
                                                                            ToolTip="WithStationary" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            CommandName="ShowWithStationary" Style="cursor: pointer; margin-left: 10px" />
                                                                    </td>
                                                                    <td id="printimage1" class="w-3p a-center" runat="server">
                                                                        <asp:ImageButton ID="ImageButton1" ImageUrl="../Images/printer.gif" runat="server"
                                                                            ToolTip="WithoutStationary" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            CommandName="ShowWithoutStationary" Style="cursor: pointer; margin-left: 10px" />
                                                                    </td>
                                                                    <td id="PatientNumber" class="a-center" style="display: none" nowrap="nowrap" runat="server">
                                                                        <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                                    </td>
                                                                    <td id="Td16" class="w-11p a-center" nowrap="nowrap" runat="server">
                                                                        <asp:LinkButton ID="Button1" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                                            OnClientClick='<%# String.Format("ShowPopUp({0});return false;",Eval("VisitNumber"))%> ' />
                                                                    </td>
                                                                    <td id="PatientName" class="w-14p a-left" runat="server">
                                                                        <asp:ImageButton ID="imgClick" ToolTip="Click here To View Visit details" runat="server"
                                                                            ImageUrl="~/Images/plus.png" CommandName="ShowChild" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                                        <%# DataBinder.Eval(Container.DataItem, "PatientName")%>
                                                                    </td>
                                                                    <td id="Age" class="w-9p a-left" runat="server">
                                                                        <asp:Label ID="lblAge" runat="server" Text='<%# Bind("PatientAge") %>'></asp:Label>
                                                                    </td>
                                                                    <td id="VisitDate" class="w-11p a-left" nowrap="nowrap" runat="server">
                                                                        <%# DataBinder.Eval(Container.DataItem, "VisitDate")%>
                                                                    </td>
                                                                    <%--<td id="VisitPurposeName" align="left" style="width: 10%" nowrap="nowrap" runat="server" visible="false">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "VisitPurposeName")%>
                                                                                </td>--%>
                                                                    <%-- <td id="PhysicianName" align="left" style="width: 10%" nowrap="nowrap" runat="server" visible="false">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "PhysicianName")%>
                                                                                </td>--%>
                                                                    <td id="ReferingPhysicianName" class="w-15p a-left" runat="server">
                                                                        <%# DataBinder.Eval(Container.DataItem, "ReferingPhysicianName")%>
                                                                    </td>
                                                                    <td id="Location" class="w-16p a-left" runat="server">
                                                                        <%# DataBinder.Eval(Container.DataItem, "Location")%>
                                                                    </td>
                                                                    <td id="due" class="a-center" style="display: none;" nowrap="nowrap" runat="server">
                                                                        <asp:HiddenField ID="hdOrgID" runat="server" Value='<%#Eval("OrgID") %>' />
                                                                    </td>
                                                                    <td id="Client" class="w-15p a-left" runat="server">
                                                                        <%# DataBinder.Eval(Container.DataItem, "ClientName")%>
                                                                    </td>
                                                                    <td id="tdDespatch" nowrap="nowrap" runat="server" class="w-3p a-center">
                                                                        <asp:CheckBox ID="chkSel" runat="server" ToolTip="Select Row" AutoPostBack="false" />
                                                                    </td>
                                                                    <td id="PatientVisitId" class="a-left" style="display: none" runat="server">
                                                                        <asp:TextBox ID="txtPatientvisitId" Text='<%# Bind("PatientVisitId") %>' runat="server"></asp:TextBox>
                                                                        <asp:Label ID="FinalURN" Text='<%# Bind("URNofId") %>' runat="server" Style="display: none" />
                                                                        <asp:TextBox ID="txtDispatch" Text='<%# Bind("Remarks") %>' runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td id="Td14" class="a-left" style="display: none" runat="server">
                                                                        <asp:TextBox ID="txtpatientId" Text='<%# Bind("PatientID") %>' runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td id="tddespatchstatus" class="w-10p a-left" runat="server" style="display: none;">
                                                                        <asp:Label ID="lbldespatchstatus" runat="server" Text='<%# Bind("ReferralType") %>'></asp:Label>
                                                                    </td>
                                                                    <td id="td13" class="w-10p a-left" runat="server" style="display: none;">
                                                                        <asp:Label ID="lblIsstat" runat="server" Text='<%# Bind("IsSTAT") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr id="Tr2" runat="server" class="a-center">
                                                                    <td id="Td2" colspan="11" runat="server" class="a-center">
                                                                        <asp:TemplateField HeaderText="Questions" HeaderStyle-HorizontalAlign="Center">
                                                                            <itemtemplate>
                                                                                   
                                                                                    <div class="w-100p">
                                                                                            <div runat="server"  id="DivChild" style="display:none;" class="evenforsurg"  >
                                                                                               
                                                                                                    <asp:GridView ID="ChildGrid" EmptyDataText="No Record Found" runat="server" 
                                                                                                        AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"  OnRowDataBound="ChildGrid_RowDataBound"
                                                                                                        DataKeyNames="VisitID" 
                                                                                                        ForeColor="White"  PageSize="10"
                                                                                                        CssClass="mytable1 w-98p gridView">
                                                                                                       
                                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                                        <Columns>
                                                                                                            <asp:BoundField Visible="False" DataField="PatientVisitID" 
                                                                                                                HeaderText="PatientVisitID" />
                                                                                                            <asp:TemplateField HeaderText="Select">
                                                                                                                <ItemTemplate>
                                                                                                                    <%--<asp:RadioButton ID="rdSelect" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />--%>
                                                                                                                    <asp:CheckBox ID="Chkselectinv" runat="server" ToolTip="Select Row"  />
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:BoundField DataField="InvestigationNAme" HeaderText="Investigation List" /> 
                                                                                                            <asp:TemplateField HeaderText="Report Status">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# bind("Status") %>'/>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                           <asp:BoundField  HeaderText="Received Date" DataField="ModifiedAt" DataFormatString="{0:dd/MM/yy hh:mm tt}" />
                                                                                                        </Columns>
                                                                                                       </asp:GridView>
                                                                                                                                                                                                          
                                                                                                   </div>
                                                                                         </div>
                                                                                 </itemtemplate>
                                                                        </asp:TemplateField>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div id="divdispatchdetails" style="display: block;">
                                            <asp:Panel ID="PanelGroup" runat="server" Style="height: 420px; width: 1200px;" CssClass="modalPopup dataheaderPopup"
                                                meta:resourcekey="PanelGroupResource1">
                                                <div id="dvInvstigationDetails" runat="server" style="display: block;">
                                                    <asp:Panel ID="table_GroupItem" runat="server" class="AddScroll" meta:resourcekey="table_GroupItemResource1">
                                                        <table class="a-center">
                                                            <tr>
                                                                <td class="a-center">
                                                                    <asp:Label Font-Size="20px" ID="Label25" Style="font-family: Trebuchet MS" Height="30px"
                                                                        Font-Bold="True" Width="450px" runat="server" Text="ZONEWISE REPORT PRINTING STATUS BETWEEN"
                                                                        meta:resourcekey="Label25Resource1" />
                                                                    <asp:Label Font-Size="18px" Style="font-family: Trebuchet MS" ID="lblprintingperiod"
                                                                        Height="30px" Font-Bold="True" Width="250px" runat="server" meta:resourcekey="lblprintingperiodResource1" />
                                                                    <br />
                                                                    <asp:Label Font-Size="16px" Style="font-family: Trebuchet MS" ID="lblZOneName" Height="30px"
                                                                        Font-Bold="True" Width="200px" runat="server" meta:resourcekey="lblZOneNameResource1" />
                                                                    <asp:Label Font-Size="16px" Style="font-family: Trebuchet MS" ID="lblPrintedAt" Height="30px"
                                                                        Font-Bold="True" Width="250px" runat="server" meta:resourcekey="lblPrintedAtResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <asp:DataList ID="outerDataList" runat="server" OnItemDataBound="outerRep_ItemDataBound"
                                                            meta:resourcekey="outerDataListResource1">
                                                            <HeaderTemplate>
                                                                <asp:Label Font-Size="12px" Font-Bold="True" ID="Label26" Height="3px" Width="1500px"
                                                                    runat="server" Text="---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
                                                                    meta:resourcekey="Label26Resource1" />
                                                                <br />
                                                                <asp:Label Style="font-family: Trebuchet MS" Font-Size="16px" FontBold="true" ID="lblPatientVisitId"
                                                                    Height="20px" Font-Bold="True" Width="170px" runat="server" Text="Visit No."
                                                                    meta:resourcekey="lblPatientVisitIdResource1" />
                                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblVisitDate" Font-Size="16px" Font-Bold="true"
                                                                    runat="server" Height="20px" Width="170px" Text="Visit Date & Time" />
                                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblpatientname" Font-Size="16px"
                                                                    Font-Bold="True" runat="server" Height="20px" Width="250px" Text="Patient Name"
                                                                    meta:resourcekey="lblpatientnameResource2" />
                                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblPrintedTime" Font-Size="16px"
                                                                    Font-Bold="True" runat="server" Height="20px" Width="170px" Text="Printed Date & Time"
                                                                    meta:resourcekey="lblPrintedTimeResource1" />
                                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblDeliveryTime" Font-Size="16px"
                                                                    Font-Bold="True" runat="server" Height="20px" Width="170px" Text="Delivery Date & Time"
                                                                    meta:resourcekey="lblDeliveryTimeResource1" />
                                                                <asp:Label Style="font-family: Trebuchet MS" ID="lblStampSign" Font-Size="16px" Font-Bold="True"
                                                                    runat="server" Height="20px" Width="170px" Text="Stamp & Sign" meta:resourcekey="lblStampSignResource1" />
                                                                <br />
                                                                <asp:Label Font-Size="11px" ID="Label27" Font-Bold="True" Height="15px" Width="1500px"
                                                                    runat="server" Text="---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
                                                                    meta:resourcekey="Label27Resource1" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label Font-Bold="true" Font-Size="20px" Style="font-family: Trebuchet MS" ID="ClientName"
                                                                    runat="server" Text='<%# Eval("ClientName") %>' />
                                                                <br />
                                                                <asp:Label Font-Size="11px" ID="Label27" Height="20px" Font-Bold="true" Width="1500px"
                                                                    runat="server" Text="---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" />
                                                                <asp:DataList ID="dlstDispatchList" runat="server" meta:resourcekey="dlstDispatchListResource1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPatientVisitId" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                            runat="server" Text='<%# bind("VisitNumber") %>' />
                                                                        <asp:Label ID="lblVisitDate" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                            runat="server" Text='<%# bind("ICDCodeStatus") %>' />
                                                                        <asp:Label ID="lblpatientname" Font-Size="16px" Height="20px" Width="250px" Style="font-family: Trebuchet MS"
                                                                            runat="server" Text='<%# bind("PatientName") %>' />
                                                                        <asp:Label ID="lblPrintedTime" Font-Size="16px" Height="20px" Width="170px" Style="font-family: Trebuchet MS"
                                                                            runat="server" Text='<%# bind("TPAName") %>' />
                                                                    </ItemTemplate>
                                                                </asp:DataList>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    </asp:Panel>
                                                </div>
                                                <table class="a-center">
                                                    <tr>
                                                        <td class="a-center">
                                                            <asp:Button ID="btnPnlClose1" runat="server" class="btn" Text="Close" OnClientClick="return popupClose()"
                                                                meta:resourcekey="btnPnlClose1Resource1" />
                                                        </td>
                                                        <td class="a-center">
                                                            <asp:Button ID="btndispatchSheetprint" runat="server" class="btn" Text="Print" OnClientClick="return popupprint1();"
                                                                meta:resourcekey="btndispatchSheetprintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <cc1:ModalPopupExtender ID="InvStatusPopup" runat="server" BackgroundCssClass="modalBackground"
                                                DropShadow="false" PopupControlID="PanelGroup" Enabled="True" TargetControlID="Button3">
                                            </cc1:ModalPopupExtender>
                                            <%-- <asp:Button type="button" ID="btnDummy" runat="server" Style="display: block;" />--%>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table id="Table1" runat="server" class="w-100p">
                    <tr id="tblindv" style="display: none;">
                        <td class="colorforcontent">
                            <div id="divIndv">
                                <asp:GridView ID="gvIndv" EmptyDataText="No Record Found" runat="server" AllowPaging="True"
                                    CellPadding="1" AutoGenerateColumns="False" DataKeyNames="PatientVisitId" ForeColor="White"
                                    PageSize="10" OnRowDataBound="gvIndv_RowDataBound" CssClass="mytable1 w-100p gridView"
                                    meta:resourcekey="gvIndvResource1">
                                    <HeaderStyle CssClass="dataheader1" />
                                    <Columns>
                                        <asp:BoundField Visible="False" DataField="PatientVisitId" HeaderText="PatientVisitID"
                                            meta:resourcekey="BoundFieldResource2" />
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource6">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSel1" runat="server" ToolTip="Select Row" meta:resourcekey="chkSel1Resource1" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField HeaderText="Print">
                                                        <ItemTemplate>
                                                            <img id="imgPrintReport" title="Print" runat="server" alt="Print" src="~/Images/printer.gif"
                                                                style="cursor: pointer;" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Patient No." meta:resourcekey="TemplateFieldResource7">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpatientno" runat="server" Text='<%# bind("PatientNumber") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource8">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpatientname" runat="server" Text='<%# bind("PatientName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource9">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpatientAge" runat="server" Text='<%# bind("PatientAge") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Visit Date" meta:resourcekey="TemplateFieldResource10">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVisitDate" runat="server" Text='<%# bind("VisitDate") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Investigation Name" meta:resourcekey="TemplateFieldResource11">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvestigationname" runat="server" Text='<%# bind("Investigation") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Report Status" meta:resourcekey="TemplateFieldResource12">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReportStatus" runat="server" Text='<%# bind("Status") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Location" meta:resourcekey="TemplateFieldResource13">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLocation" runat="server" Text='<%# bind("Location") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource14">
                                            <ItemTemplate>
                                                <asp:Label ID="txtPatientvisitId" Text='<%# Bind("PatientVisitId") %>' runat="server"
                                                    Style="display: none" />
                                                <asp:Label ID="FinalURN" Text='<%# Bind("URNofId") %>' runat="server" Style="display: none" />
                                                <asp:Label ID="txtDispatch" runat="server" Text='<%# bind("Remarks") %>' Style="display: none" />
                                                <asp:Label ID="txtpatientId" Text='<%# Bind("PatientID") %>' runat="server" Style="display: none" />
                                                <input id="hdnOutSourceDue" type="hidden" runat="server" value='<%# Eval("Due ")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                </table>
                <table class="w-100p">
                    <div id="tblpage" runat="server" class="w-100p">
                        <tr id="trFooter" runat="server" class="dataheaderInvCtrl">
                            <td class="defaultfontcolor a-center">
                                <div id="divFooterNav" runat="server">
                                    <asp:Label ID="Label12" runat="server" Text="Page" meta:resourcekey="Label12Resource1"></asp:Label>
                                    <%--meta:resourcekey="Label1Resource1"--%>
                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                    <asp:Label ID="Label13" runat="server" Text="Of" meta:resourcekey="Label13Resource1"></asp:Label>
                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                        CssClass="btn" meta:resourcekey="Btn_PreviousResource1" Style="width: 71px" />
                                    <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                                        meta:resourcekey="Btn_NextResource1" />
                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                    <asp:HiddenField ID="hdnPostBack" runat="server" />
                                    <asp:HiddenField ID="hdnOrgID" runat="server" />
                                    <asp:Label ID="Label14" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                        meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                    <asp:Button ID="Button1" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                                        OnClick="btnGo_Click1" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                    <asp:Button Visible="False" ID="Button2" runat="server" Style="display: block;" OnClick="btnGo_Click2"
                                        meta:resourcekey="Button2Resource1" />
                                </div>
                            </td>
                        </tr>
                    </div>
                    <tr id="trOutSource" runat="server" visible="false" class="a-center">
                        <td class="defaultfontcolor">
                            <asp:Button ID="btnOutSouce" runat="server" Text="OutSourceDispatch" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" OnClientClick="return CheckVisitID1()"
                                onmouseout="this.className='btn'" OnClick="btnOutSouce_Click" meta:resourcekey="btnOutSouceResource1" />
                        </td>
                    </tr>
                    <tr id="trSelectVisit" runat="server" visible="false" class="a-center">
                        <td class="defaultfontcolor w-100p">
                            <asp:Label ID="lblLocationPrinter" runat="server" Text=" Select a Printer" meta:resourcekey="lblSelectapatientvisitResource1"></asp:Label>
                            <asp:DropDownList ID="ddlLocationPrinter" runat="server" meta:resourcekey="ddlVisitActionNameResource1">
                            </asp:DropDownList>
                            <asp:Label ID="lblSelectapatientvisit" runat="server" Text=" Select a patient visit"
                                meta:resourcekey="lblSelectapatientvisitResource1"></asp:Label>
                            <asp:DropDownList ID="ddlVisitActionName" runat="server" Visible="False" meta:resourcekey="ddlVisitActionNameResource1">
                            </asp:DropDownList>
                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                OnClientClick="javascript:return CheckPrint();" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                            <asp:Button ID="Button3" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" meta:resourcekey="btnGoResource1" />
                            <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                            <ajc:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                                TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                                CancelControlID="imgPDFReportPreview" DynamicServicePath="" Enabled="True">
                            </ajc:ModalPopupExtender>
                            <asp:Panel ID="pnlReportPreview" BorderWidth="1px" Height="500px" Width="1000px"
                                CssClass="modalPopup dataheaderPopup" runat="server" meta:resourcekey="pnlShowReportPreviewResource1"
                                Style="display: none">
                                <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="defaultfontcolor v-middle a-right">
                                                <asp:Button ID="btnpdf" runat="server" Text="Print" OnClientClick="return pdfPrint();"
                                                    CssClass="btn" Height="18px" OnClick="btnGo_Click" meta:resourcekey="btnpdfResource1" />
                                                &nbsp;&nbsp;
                                                <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" runat="server"
                                                    alt="Close" style="cursor: pointer; height: 18Px;" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table class="w-100p">
                                    <tr>
                                        <td class="v-top">
                                            <table id="Table2" runat="server" class="w-100p">
                                                <tr id="Tr8" runat="server">
                                                    <td id="Td15" class="colorforcontent w-30p h-23 a-left" runat="server">
                                                        <div id="Div3" style="display: block;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',1);
                                                                                    showResponses('Div55','Div66','ACX3responses22',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',1);
                                                                                showResponses('Div55','Div66','ACX3responses22',0);">&nbsp;<asp:Label ID="Label16"
                                                                                    runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                        <div id="Div4" style="display: none;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',0);showResponses('Div55','Div66','ACX3responses22',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',0);
                                                                                showResponses('Div55','Div66','ACX3responses22',1);">
                                                                <asp:Label ID="Label17" runat="server" Text=" Lab Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label>
                                                            </span>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tblReportDetails" style="display: none;" class="w-100p">
                                                <tr>
                                                    <td>
                                                        <ucPatientdet:PatientDetails ID="uctPatientDetail1" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center">
                                                        <asp:GridView ID="grdPatientView" runat="server" CellSpacing="1" CellPadding="1"
                                                            AllowPaging="True" PageSize="5" AutoGenerateColumns="False" ForeColor="#333333"
                                                            CssClass="mytable1 gridView w-70p" OnRowDataBound="grdPatientView_RowDataBound"
                                                            DataKeyNames="PatientID,PatientVisitID" meta:resourcekey="grdPatientViewResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Patient Report" meta:resourcekey="TemplateFieldResource16">
                                                                    <ItemTemplate>
                                                                        <div class="a-center">
                                                                            <table class="dataheaderInvCtrl w-100p">
                                                                                <tr>
                                                                                    <td class="a-right w-25p" style="background-color: #3a86da;">
                                                                                        <asp:Label ID="lblVisitDate" runat="server" ForeColor="White" meta:resourcekey="lblVisitDateResource5"
                                                                                            Text="Visit Date"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left w-25p" style="background-color: #3a86da;">
                                                                                        <asp:Label ID="lblDate" runat="server" Text='<%#  Eval("VisitDate")%>' ForeColor="White"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" class="a-center">
                                                                                        <asp:GridView ID="grdOrderedinv" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                            CssClass="mytable1 gridView w-99p" ForeColor="Black" meta:resourcekey="grdOrderedinvResource1"
                                                                                            PageSize="100">
                                                                                            <Columns>
                                                                                                <asp:TemplateField HeaderText="Test Name">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblTestName" runat="server" Text='<%# bind("Name") %>' />
                                                                                                        <asp:Label CssClass="notification-bubble" runat="server" ID="lblPrintCount1" Text='<%# Eval("RoundNo").ToString()=="0" ? "0" : Eval("RoundNo").ToString() %> '></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:BoundField DataField="Status" HeaderText="Test Status" meta:resourcekey="BoundFieldResource3" />
                                                                                                <asp:BoundField DataField="ReportStatus" HeaderText="Report Status" meta:resourcekey="BoundFieldResource4" />
                                                                                                <asp:BoundField DataField="Priority" HeaderText="Priority" meta:resourcekey="BoundFieldResource5"
                                                                                                    Visible="False" />
                                                                                            </Columns>
                                                                                        </asp:GridView>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Priority Report"
                                                            CssClass="btn" onmouseover="this.className='btn btnhov'" OnClientClick="return PriorityValidation();"
                                                            OnClick="btnGenerateReport_Click" onmouseout="this.className='btn'" meta:resourcekey="btnGenerateReportResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="v-top">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="colorforcontent w-30p h-23 a-left">
                                                        <div id="Div55" style="display: none;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                &nbsp;<asp:Label ID="Label18" runat="server" Text="Show PDF" meta:resourcekey="Label18Resource1"></asp:Label></span></div>
                                                        <div id="Div66" style="display: block;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                <asp:Label ID="Label20" runat="server" Text="PDF Viewer" meta:resourcekey="Label20Resource1"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="ACX3responses22">
                                                <tr>
                                                    <td class="a-left">
                                                        <div id="Divpdf" runat="server" style="height: auto;" class="w-99p">
                                                            <iframe runat="server" id="frameReportPreview" name="myname" style="width: 985px;
                                                                height: 400px; border: 0px; overflow:auto;"></iframe>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage1" runat="server" meta:resourcekey="lblMessage1Resource1"></asp:Label>
                            <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                        </td>
                    </tr>
                    <%--   <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    Select a patient and one of the following  
                                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlTheme" onselectedindexchanged="dList_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="return pValidation()" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" />
                                </td>
                            </tr>--%>
                </table>
                </td> </tr> </table>
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table class="w-100p" id="tblPayments" visible="false" runat="server">
                    <tr>
                        <td>
                            <asp:Label ID="lblThisBillhaspendingpaymentskindlymakepaymenttoviewreport" runat="server"
                                Text=" This Bill has pending payments kindly make payment to view report" meta:resourcekey="lblThisBillhaspendingpaymentskindlymakepaymenttoviewreportResource1"></asp:Label>
                            <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                OnClick="btnPayNow_Click" onmouseout="this.className='btn'" meta:resourcekey="btnPayNowResource1" />
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="updatePanel1" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                        meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                    <cc1:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                        TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                        CancelControlID="imgCloseReport" DynamicServicePath="" Enabled="True">
                                    </cc1:ModalPopupExtender>
                                    <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" Width="90%" ScrollBars="Vertical"
                                        CssClass="modalPopup dataheaderPopup" runat="server" meta:resourcekey="pnlAttribResource1"
                                        Style="display: none">
                                        <asp:Panel ID="Panel2" runat="server" CssClass="padding2 h-25" meta:resourcekey="Panel1Resource1">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-center">
                                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                            <ProgressTemplate>
                                                                <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                                <asp:Label ID="Rs_Pleasewait1" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblHint" runat="server" Font-Bold="True" Text="Hint: " meta:resourcekey="lblHintResource1" />
                                                        <span class="notification-bubble">&nbsp;&nbsp;</span>
                                                        <asp:Label ID="lblPrintCountHint" runat="server" Font-Bold="True" Text=" => Report print count"
                                                            meta:resourcekey="lblPrintCountHintResource1" />
                                                    </td>
                                                    <td class="a-right">
                                                        <img id="imgCloseReport" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                            class="pointer" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="v-top">
                                                    <table id="tblReport" runat="server" class="w-90p">
                                                        <tr id="Tr3" runat="server">
                                                            <td id="Td3" class="colorforcontent w-30p h-23 a-left" runat="server">
                                                                <div id="ACX3plus1" style="display: none;">
                                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);">
                                                                        &nbsp;<asp:Label ID="lblReportTemplate" runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                                <div id="ACX3minus1" style="display: block;">
                                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);">
                                                                        <asp:Label ID="Label5" runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="ACX3responses1" style="display: table;" class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <ucPatientdet:PatientDetails ID="uctPatientDetail" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td id="chdept" runat="server" style="display: none;">
                                                                <asp:CheckBoxList ID="chkDept" runat="server" RepeatColumns="5" onclick="javascript:dispTask(this.id);"
                                                                    meta:resourcekey="chkDeptResource1">
                                                                </asp:CheckBoxList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td id="lnkshwrpt" runat="server" style="display: none; color: Black;">
                                                                <asp:Label ID="lblClickHere" runat="server" Text="Click Here !" meta:resourcekey="lblClickHereResource1"></asp:Label>
                                                                <asp:LinkButton ID="lnkShowRecord" runat="server" ForeColor="Black" Font-Bold="True"
                                                                    Font-Underline="True" OnClick="lnkShowRecord_Click" meta:resourcekey="lnkShowRecordResource1"
                                                                    Text="DepartmentWise Filter Report "></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="w-100p" id="tblResults" runat="server">
                                                                    <tr id="Tr4" runat="server">
                                                                        <td id="Td4" runat="server">
                                                                            <table>
                                                                                <tr>
                                                                                    <td sclass="w-5p">
                                                                                        <img src="../Images/collapse_blue.jpg" id="imgClick" title="Show Report Template"
                                                                                            style="display: none;" runat="server" onclick="javascript:return ShowReportDiv();" />
                                                                                    </td>
                                                                                    <td class="w-95p">
                                                                                        <asp:Label runat="server" ID="lblHead" Text="Show Report Template" Style="display: none;"
                                                                                            meta:resourcekey="lblHeadResource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="Tr5" runat="server">
                                                                        <td id="Td5" runat="server">
                                                                            <div id="dReport" runat="server">
                                                                                <asp:DataList ID="grdResultTemp" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                    RepeatColumns="2" OnItemDataBound="grdResultTemp_ItemDataBound" RepeatDirection="Horizontal"
                                                                                    OnItemCommand="grdResultTemp_ItemCommand" meta:resourcekey="grdResultTempResource1">
                                                                                    <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                    <ItemTemplate>
                                                                                        <table class="dataheaderInvCtrl">
                                                                                            <tr>
                                                                                                <td class="v-top">
                                                                                                    <table class="colorforcontentborder w-100p">
                                                                                                        <tr>
                                                                                                            <td class="Duecolor h-20">
                                                                                                                <table class="w-100p">
                                                                                                                    <tr>
                                                                                                                        <td class="a-left">
                                                                                                                            <asp:Label ID="lblReport" runat="server" Text=" Report" meta:resourcekey="lblReportResource1"></asp:Label>
                                                                                                                        </td>
                                                                                                                        <td>
                                                                                                                            <asp:CheckBox ID="chkEnableAll" runat="server" meta:resourcekey="chkEnableAllResource1" />
                                                                                                                            <asp:Label ID="lblEnableALL" runat="server" Text="Reprint" meta:resourcekey="lblEnableALLResource1"></asp:Label>
                                                                                                                        </td>
                                                                                                                        <td class="a-right">
                                                                                                                            &nbsp<asp:CheckBox ID="chkSelectAll" runat="server" meta:resourcekey="chkSelectAllResource1" />
                                                                                                                            <asp:Label ID="lblSelectALL" runat="server" Text="Selectall" meta:resourcekey="lblSelectALLResource1"></asp:Label>
                                                                                                                            <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
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
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <table class="colorforcontentborder w-100p">
                                                                                                        <tr>
                                                                                                            <td style="font-weight: normal;">
                                                                                                                <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                                                    OnItemDataBound="grdResultDate_ItemDataBound" OnItemCommand="grdResultDate_ItemCommand"
                                                                                                                    RepeatColumns="2" RepeatDirection="Horizontal" meta:resourcekey="grdResultDateResource1">
                                                                                                                    <ItemStyle VerticalAlign="Top" />
                                                                                                                    <ItemTemplate>
                                                                                                                        <table>
                                                                                                                            <tr>
                                                                                                                                <td>
                                                                                                                                    <asp:Label runat="server" Font-Bold="True" ID="lblCreatedAt" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                                                                                                                    <asp:Label runat="server" ID="lblDtReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                                                        meta:resourcekey="lblDtReportIDResource1"></asp:Label>
                                                                                                                                    <asp:Label runat="server" ID="lbldtReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                        meta:resourcekey="lbldtReportnameResource1"></asp:Label>
                                                                                                                                </td>
                                                                                                                            </tr>
                                                                                                                            <tr>
                                                                                                                                <td style="font-weight: normal;">
                                                                                                                                    <asp:DataList ID="dlChildInvName" RepeatColumns="1" runat="server" OnItemCommand="dlChildInvName_ItemCommand"
                                                                                                                                        OnItemDataBound="dlChildInvName_ItemDataBound" Width="100%" meta:resourcekey="dlChildInvNameResource1">
                                                                                                                                        <ItemStyle VerticalAlign="Top" />
                                                                                                                                        <ItemTemplate>
                                                                                                                                            <table>
                                                                                                                                                <tr>
                                                                                                                                                    <td>
                                                                                                                                                        <asp:CheckBox ID="ChkBox" onclick="javascript:return ChkIfSelected(this.id);" runat="server"
                                                                                                                                                            meta:resourcekey="ChkBoxResource1" />
                                                                                                                                                    </td>
                                                                                                                                                    <td>
                                                                                                                                                        <asp:Label runat="server" ID="lblInvname" Text='<%# Eval("InvestigationName") %> '
                                                                                                                                                            meta:resourcekey="lblInvnameResource1"></asp:Label>
                                                                                                                                                        <asp:Label CssClass="notification-bubble" runat="server" ID="lblPrintCount" Text='<%# Eval("PrintCount").ToString()=="0" ? "0" : Eval("PrintCount").ToString() %> '></asp:Label>
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
                                                                                                                                                        <asp:Label ID="lblPackageName" runat="server" Text=""></asp:Label>
                                                                                                                                                    </td>
                                                                                                                                                    <td>
                                                                                                                                                        <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                                                                                                                            runat="server" Visible="False" Text="Show" CommandName="ShowReport" meta:resourcekey="lnkShowResource1"
                                                                                                                                                            OnClientClick="return ShowHideReport();"></asp:LinkButton>
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
                                                                                                        <tr>
                                                                                                            <td style="color: #000000;" class="h-20 a-center">
                                                                                                                <asp:LinkButton ID="lnkShowReport" OnClientClick="javascript:return ValidateCheckBox();ShowHideReport();"
                                                                                                                    ForeColor="Black" runat="server" Text="ShowReport" CommandName="ShowReport" Font-Underline="True"
                                                                                                                    meta:resourcekey="lnkShowReportResource1"></asp:LinkButton>
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
                                                                        <td id="Td6" runat="server">
                                                                            <table runat="server" border="0" visible="False" style="background-color: #fcecb6"
                                                                                id="tblcontent">
                                                                                <tr id="Tr6" runat="server">
                                                                                    <td id="Td7" class="alterimg" runat="server">
                                                                                    </td>
                                                                                    <td id="Td8" runat="server">
                                                                                        <b>
                                                                                            <asp:Label ID="lblinstallviewer" runat="server" Text="If you are viewing the images for the first time, please install the viewer."
                                                                                                meta:resourcekey="lblinstallviewerResource1"></asp:Label>
                                                                                        </b>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr id="Tr7" runat="server">
                                                                                    <td id="Td9" runat="server">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                    <td id="Td10" runat="server">
                                                                                        <table>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <img src="../Images/box_menu_bullet.png" runat="server" id="imgInstallExe" alt="error" />
                                                                                                    <asp:HyperLink Font-Bold="True" ForeColor="Black" runat="server" ID="lnkInstall"
                                                                                                        Text="Click to download & install Viewer" meta:resourcekey="lnkInstallResource1"></asp:HyperLink>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgInsGuide" />
                                                                                                    <asp:LinkButton runat="server" Font-Bold="True" OnClick="lnkInsguide_Click" ForeColor="Black"
                                                                                                        ID="lnkInsguide" Text="Click to view the Installation Guide" meta:resourcekey="lnkInsguideResource1"></asp:LinkButton>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgUserGuide" />
                                                                                                    <asp:LinkButton runat="server" OnClick="lnkUserGuide_Click" Font-Bold="True" ForeColor="Black"
                                                                                                        ID="lnkUserGuide" Text="Click to view the Viewer User Guide" meta:resourcekey="lnkUserGuideResource1"></asp:LinkButton>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td id="Td11" runat="server">
                                                                            <asp:HiddenField runat="server" ID="hdnInstallationGuidePath" />
                                                                            <asp:HiddenField runat="server" ID="hnUserGuidePath" />
                                                                            <asp:HiddenField runat="server" ID="hdnIpaddress" />
                                                                            <asp:HiddenField runat="server" ID="hdnPortNumber" />
                                                                            <asp:HiddenField runat="server" ID="hdnPath" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="v-top">
                                                    <table class="w-90p">
                                                        <tr>
                                                            <td class="colorforcontent w-30p h-23 a-left">
                                                                <div id="ACX3plus2" style="display: none;">
                                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                        &nbsp;<asp:Label ID="Label3" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                                <div id="ACX3minus2" style="display: block;">
                                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                        <asp:Label ID="Label6" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="ACX3responses2" style="display: table;" class="w-100p">
                                                        <tr>
                                                            <td class="a-right">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Button ID="btnPrint" OnClick="btnPrint_Click" runat="server" Text="Print Report"
                                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                                Style="display: none;" meta:resourcekey="btnPrintResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button ID="btnSendMail" runat="server" Text="Send Mail" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                onmouseout="this.className='btn'" OnClick="btnSendMail_Click" Style="display: none;"
                                                                                meta:resourcekey="btnSendMailResource1" />
                                                                            <asp:HiddenField ID="hdnShowReport" runat="server" Value="false" />
                                                                            <asp:HiddenField ID="hdnPrintbtnInReportViewer" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="v-top w-95p">
                                                                <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                                                    Font-Size="8pt" meta:resourcekey="rReportViewerResource1" WaitMessageFont-Names="Verdana"
                                                                    WaitMessageFont-Size="14pt">
                                                                    <ServerReport ReportServerUrl="" />
                                                                </rsweb:ReportViewer>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnHideReportTemplate" Value="0" runat="server" />
                        <asp:HiddenField ID="hdnTemplateId" runat="server" />
                        <asp:HiddenField ID="hdnlstInvSelected" runat="server" />
                        <asp:HiddenField ID="hdnSelectedMailButton" runat="server" />
                        <input type="hidden" id="hdnDue" runat="server" value="0.00" />
                        <asp:HiddenField ID="hdOrgID" runat="server" />
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
                                    <asp:Panel ID="pnlAttrib2" BorderWidth="1px" Height="95%" Width="80%" CssClass="modalPopup dataheaderPopup"
                                        runat="server" meta:resourcekey="pnlAttrib2Resource1" Style="display: none; background-color: White;">
                                        <table class="w-100p" style="height: 100%">
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnClientAttributes" runat="server" Text="Print" OnClientClick="return popupprint();"
                                                        CssClass="btn" meta:resourcekey="btnClientAttributesResource1" />
                                                    <%--<input type="button" id="btnClientAttributes" value="Print" class="btn" onclick="return popupprint();" />--%>
                                                    <asp:Button ID="btnCnl2" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" meta:resourcekey="btnCnl2Resource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="v-top">
                                                    <div style="overflow: auto; width: 100%; height: 500px;">
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
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                        <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                            TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                            CancelControlID="img1" DynamicServicePath="" Enabled="True">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                            runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                            <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                class="pointer" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <%--<ul>
                                <li>
                                    <uc5:errordisplay id="ErrorDisplay3" runat="server" />
                                </li>
                            </ul>--%>
                            <table class="w-100p">
                                <tr>
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-right v-middle">
                                        <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                                    </td>
                                    <td class="a-left">
                                        <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                            runat="server" meta:resourcekey="txtMailAddressResource1" />
                                        <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                            <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                                meta:resourcekey="lblMailAddressHintResource1" />
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="a-center">
                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                            <ProgressTemplate>
                                                <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center" colspan="2">
                                        <asp:Button ID="btnSendMailReport" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClientClick="return CheckMailAddress();"
                                            OnClick="btnSendMailReport_Click" meta:resourcekey="btnSendMailReportResource1" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="upMailReport" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <cc1:ModalPopupExtender ID="modelPopExtMailReport" runat="server" PopupControlID="pnlMailReport"
                            TargetControlID="HiddenField1" BackgroundCssClass="modalBackground" CancelControlID="imgPopupClose"
                            DynamicServicePath="" Enabled="True">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnlMailReport" BorderWidth="1px" Height="65%" Width="55%" CssClass="modalPopup dataheaderPopup"
                            runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                            <asp:Panel ID="Panel1" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text="Dispatch Report" meta:resourcekey="Label1Resource2"></asp:Label>
                                        </td>
                                        <td class="a-right">
                                            <img id="imgPopupClose" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <%--<ul>
                                <li>
                                    <uc5:errordisplay id="ErrorDisplay2" runat="server" />
                                </li>
                            </ul>--%>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <table class="w-80p">
                                            <tr>
                                                <td style="display: none">
                                                    <asp:Label ID="lbldisptch" runat="server" Text="Dispatch Type" meta:resourcekey="lbldisptchResource1" />
                                                </td>
                                                <td style="display: none">
                                                    <asp:Panel ID="panelDispatchType1" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="True"
                                                        meta:resourcekey="panelDispatchType1Resource1">
                                                        <asp:CheckBoxList ID="ChckdespatchType" RepeatDirection="Vertical" runat="server"
                                                            Font-Size="10px" Font-Bold="true">
                                                        </asp:CheckBoxList>
                                                        <%--    <asp:DropDownList ID="ddldespatch" runat="server" CssClass="ddl" Width="155px" 
                                                                meta:resourcekey="ddldespatchResource1" />--%></asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="display: none">
                                                    <asp:Label ID="lbldespatchmode" runat="server" Text="Dispatch Mode" meta:resourcekey="lbldispatchmodeResource1" />
                                                </td>
                                                <td style="display: none">
                                                    <asp:Panel ID="panelDispatchMode1" runat="server" CssClass="dataheaderInvCtrl" Width="98%"
                                                        Font-Bold="True" meta:resourcekey="panelDispatchMode1Resource1">
                                                        <asp:CheckBoxList ID="chkDespatchMode1" RepeatDirection="Horizontal" runat="server"
                                                            Font-Size="10px" Font-Bold="True" meta:resourcekey="chkDespatchMode1Resource1">
                                                        </asp:CheckBoxList>
                                                        <%-- <asp:DropDownList ID="ddlDespatchMode" runat="server" CssClass="ddl" 
                                                                Width="155px" meta:resourcekey="ddlDespatchModeResource1">
                                                            </asp:DropDownList>--%></asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblCourierBoyName" runat="server" Text="Courier Boy Name" meta:resourcekey="lblCourierBoyNameResource1" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtcoruriersname" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtcoruriersnameResource1" />
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="txtcoruriersname"
                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                        OnClientItemSelected="GetEmpIDs" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                        DelimiterCharacters="" Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                    <asp:HiddenField ID="hdncourierboyid" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label116" runat="server" Text="Dr Courier" meta:resourcekey="lblCourierBoyNameResource1" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDRCoruriersname" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtcoruriersnameResource1" />
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" TargetControlID="txtDRCoruriersname"
                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                        OnClientItemSelected="GetDocEmpIDs" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                        DelimiterCharacters="" Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                    <asp:HiddenField ID="hdncourierboyid1" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbldespatchdate" runat="server" Text="Dispatch Home Date" AssociatedControlID="txtdispatchdate"
                                                        meta:resourcekey="lbldespatchdateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtdispatchdate" ToolTip="Home Delivery Date" runat="server" CssClass="txtboxps"
                                                        meta:resourcekey="txtdispatchdateResource1" />
                                                    <asp:ImageButton ID="imgbtnCalendar" runat="server" ImageUrl="../Images/Calendar_scheduleHS.png"
                                                        meta:resourcekey="imgbtnCalendarResource1" />
                                                    <cc1:CalendarExtender ID="CalendarExtender3" TargetControlID="txtdispatchdate" Format="MM/dd/yyyy"
                                                        OnClientDateSelectionChanged="dateselect" PopupButtonID="imgbtnCalendar" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label117" runat="server" Text="Dispatch Dr Delivery Date" meta:resourcekey="Label117Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtdispatchdate1" ToolTip="Dr Delivery Date" runat="server" CssClass="txtboxps"
                                                        meta:resourcekey="txtdispatchdate1Resource1" />
                                                    <asp:ImageButton ID="imgbtnCalendar1" runat="server" ImageUrl="../Images/Calendar_scheduleHS.png"
                                                        meta:resourcekey="imgbtnCalendar1Resource1" />
                                                    <cc1:CalendarExtender ID="CalendarExtender4" TargetControlID="txtdispatchdate1" Format="MM/dd/yyyy"
                                                        OnClientDateSelectionChanged="dateselect1" PopupButtonID="imgbtnCalendar1" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="display: none">
                                                    <asp:Label ID="lblPatientMobileNo" runat="server" Text="Mobile No" meta:resourcekey="lblPatientMobileNoResource1" />
                                                </td>
                                                <td style="display: none">
                                                    <asp:TextBox ID="txtPatientMobileNo" runat="server" meta:resourcekey="txtPatientMobileNoResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="display: none">
                                                    <asp:Label ID="lblPatientMail" runat="server" Text="Mail To" meta:resourcekey="lblPatientMailResource1" />
                                                </td>
                                                <td style="display: none">
                                                    <asp:TextBox ID="txtPatientMail" runat="server" TextMode="MultiLine" Columns="50"
                                                        meta:resourcekey="txtPatientMailResource1" />
                                                    &nbsp; &nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblcomments" runat="server" Text="Comments" meta:resourcekey="lblcommentsResource1" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtcomments" runat="server" TextMode="MultiLine" Columns="50" meta:resourcekey="txtcommentsResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="a-center">
                                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                                        <ProgressTemplate>
                                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="a-left v-top" style="display: none;">
                                        <asp:Label ID="lbldespatches" runat="server" Text="Dispatch Patients Investigations"
                                            Font-Bold="True" meta:resourcekey="lbldespatchesResource1" /><br />
                                        <br />
                                        <asp:Label ID="lbldespatchnames" runat="server" ForeColor="Red" meta:resourcekey="lbldespatchnamesResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center" colspan="2">
                                        <asp:Button ID="btndespatch" runat="server" Text="Dispatch" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btndispatch_Click" OnClientClick="return checkdispatch();"
                                            meta:resourcekey="btndespatchResource1" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <%--<asp:AsyncPostBackTrigger ControlID="btndespatch" EventName="btndispatch_Click" />--%>
                        <asp:PostBackTrigger ControlID="btndespatch" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdateLabelPrintPanel" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="pnlPatientDetail" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                            runat="server" meta:resourcekey="pnlPatientDetailResource1" ScrollBars="Auto"
                            Style="display: none">
                            <table>
                                <tr>
                                    <td class="a-right">
                                        <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                            <ProgressTemplate>
                                                <asp:Image ID="imgProgressbar3" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbar3Resource1" />
                                                <asp:Label ID="Rs_Pleasewait3" Text="Please wait...." runat="server" meta:resourcekey="Rs_Pleasewait3Resource1" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-right">
                                        <%-- <img id="imgCloseLabelReport" src="../Images/dialog_close_button.png" runat="server"
                                                        alt="Close" style="cursor: pointer;" />--%>
                                        <input id="imgCloseLabelReport" type="button" value="Close" name="Close" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <ucPatientdet:PatientDetails ID="PatientDetailsLabel" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="w-80p">
                                                        <tr>
                                                            <td>
                                                                <asp:Label nowrap="nowrap" ID="LabelDispatchType" runat="server" Text="Dispatch Type"
                                                                    meta:resourcekey="LabelDispatchTypeResource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="chkDispatchTypeLabelPanel" runat="server" CssClass="dataheaderInvCtrl"
                                                                    Font-Bold="True" meta:resourcekey="chkDispatchTypeLabelPanelResource1">
                                                                    <asp:CheckBoxList ID="chkDispatchTypeLabel" RepeatDirection="Vertical" runat="server"
                                                                        Font-Size="10px" Font-Bold="true">
                                                                    </asp:CheckBoxList>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Label nowrap="nowrap" ID="LabelDispatchMode" runat="server" Text="Dispatch Mode"
                                                                    meta:resourcekey="lLabelDispatchModeResource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="chkDespatchModeLabelPanel" runat="server" CssClass="dataheaderInvCtrl"
                                                                    Width="98%" Font-Bold="True" meta:resourcekey="chkDespatchModeLabelPanelResource1">
                                                                    <asp:CheckBoxList ID="chkDespatchModeLabel" RepeatDirection="Horizontal" runat="server"
                                                                        Font-Size="10px" Font-Bold="true">
                                                                    </asp:CheckBoxList>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="ViewLabelPanel" runat="server" CssClass="dataheaderInvCtrl w-100p"
                                                        Font-Bold="True" meta:resourcekey="ViewLabelPanelResource1">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td colspan="8">
                                                                    <%-- <input id="rdViewAllLabel" type="checkbox" name="label" runat="server" /><label id="Label16"
                                                                                        runat="server"><asp:Label ID="Label17" Text="View Label" runat="server" meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>--%>
                                                                    <input id="rdLabel1" type="radio" name="label" runat="server" /><label id="lblLabel1"
                                                                        runat="server">
                                                                        <asp:Label ID="Rs_CaseNoteSticker" Text="Case Note/ File Label" runat="server" meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>
                                                                    <input id="rdLabel2" type="radio" name="label" runat="server" value="2" />
                                                                    <label id="lblLabel2" runat="server">
                                                                        <asp:Label ID="Rs_AddressSticker" Text="Patient Address Label" runat="server" meta:resourcekey="Rs_AddressStickerResource1"></asp:Label></label><%-- <input id="rdHomeDispatch" type="radio" name="label" runat="server" value="7" /><label
                                                                                        id="Label18" runat="server"><asp:Label ID="Rs_HomeDispatchSticker" Text="Home Dispatch Label"
                                                                                            runat="server" meta:resourcekey="Rs_HomeDispatchStickerResource1"></asp:Label></label>--%>
                                                                    <input id="rdDoctorDispatch" type="radio" name="label" runat="server" value="8" /><label
                                                                        id="Label19" runat="server"><asp:Label ID="Rs_DoctorDispatchSticker" Text="Doctor Dispatch Label"
                                                                            runat="server" meta:resourcekey="Rs_DoctorDispatchStickerResource1"></asp:Label></label><span
                                                                                style="white-space: nowrap"><%--  <input id="rdLabel3" type="radio" name="label" runat="server" value="3" /><label
                                                                                        id="lblLabel3" runat="server"><asp:Label ID="Rs_LabSticker" Text="Lab Label" runat="server"
                                                                                            meta:resourcekey="Rs_LabStickerResource1"></asp:Label></label>
                                                                                         <input id="rdDispatchSticker" type="radio" name="label" runat="server" value="4" /><label
                                                        id="Label4" runat="server"><asp:Label ID="Rs_DispatchSticker" 
                                                        Text="Dispatch Sticker" runat="server" meta:resourcekey="Rs_DispatchStickerResource1"></asp:Label></label>
                                                 
                                                  <input id="rdRadiology" type="radio" name="label" runat="server" value="5" /><label
                                                        id="Label5" runat="server"><asp:Label ID="Rs_RadiologySticker" 
                                                        Text="Radiology / Sonology  Sticker" runat="server" 
                                                        meta:resourcekey="Rs_RadiologyStickerResource1"></asp:Label></label>
                                                  <span style="white-space:nowrap">--%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="8">
                                                                    <%--        <input id="rdHealthCheckUp" type="radio" name="label" runat="server" value="6" /><label
                                                        id="Label16" runat="server"><asp:Label ID="Rs_HealthCheckUpSticker"  
                                                        Text="Health Check Up Sticker" runat="server" 
                                                        meta:resourcekey="Rs_HealthCheckUpStickerResource1"></asp:Label></label> </span>--%>
                                                                    <%--     <input id="rdECGorStress" type="radio" name="label" runat="server" value="9" /><label
                                                        id="Label9" runat="server"><asp:Label ID="Rs_ECGorStress" 
                                                        Text="ECG / Stress Test Sticker" runat="server" meta:resourcekey="Rs_ECGorStressResource1"></asp:Label></label></span>
                                                 <input id="Checkbox1" type="checkbox" name="label" runat="server" checked value="1" /><label
                                                        id="Label3" runat="server"><asp:Label ID="Label6" 
                                                        Text="Case Note Sticker" runat="server" 
                                                        meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnPrintLabel" runat="server" Text="View Label" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnPrintLabel_Click" meta:resourcekey="btnPrintLabelResource1" />
                                                    <asp:HiddenField ID="hdnShowLabelReport" runat="server" Value="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-top">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="colorforcontent w-30p h-23 a-left">
                                                    <div id="Div1" style="display: none;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                            &nbsp;<asp:Label ID="Label8" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                    <div id="Div2" style="display: block;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                            <asp:Label ID="Label15" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <rsweb:ReportViewer ID="rReportViewer2" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                            Font-Size="8pt" meta:resourcekey="rReportViewer2Resource1">
                                            <ServerReport ReportServerUrl="" />
                                        </rsweb:ReportViewer>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:HiddenField ID="hdnModelPopupPrintLabel" runat="server" />
                        <cc1:ModalPopupExtender ID="ModalPopupLabelPrintExtender1" runat="server" PopupControlID="pnlPatientDetail"
                            TargetControlID="hdnModelPopupPrintLabel" BackgroundCssClass="modalBackground"
                            CancelControlID="imgCloseLabelReport" DynamicServicePath="" Enabled="True">
                        </cc1:ModalPopupExtender>
                        <asp:HiddenField ID="HiddenField3" runat="server" />
                    </ContentTemplate>
                    <Triggers>
                        <%-- <asp:PostBackTrigger ControlID="btnPrintLabel" />--%>
                        <asp:AsyncPostBackTrigger ControlID="btnPrintLabel" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <input type="hidden" id="hdnPDFType" name="PType" runat="server" />
            <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
            <input type="hidden" id="hdnPID" name="pid" runat="server" />
            <input type="hidden" id="hdnVID" name="vid" runat="server" />
            <input type="hidden" id="hdnVisitDetail" runat="server" />
            <input type="hidden" id="patOrgID" runat="server" name="patOrgID" />
            <input type="hidden" id="ChkID" runat="server" />
            <input type="hidden" id="hdndeptid" runat="server" />
            <input type="hidden" id="hdndeptvalues" runat="server" />
            <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
            <asp:HiddenField ID="Hdndisablebox" runat="server" />
            <asp:HiddenField ID="hdnHideDetails" Value="0" runat="server" />
            <asp:HiddenField ID="hdnReferralType" runat="server" />
            <asp:HiddenField ID="hdnEMail" runat="server" />
            <asp:HiddenField ID="hdnClientID" runat="server" />
            <asp:HiddenField ID="HdnID" runat="server" />
            <asp:HiddenField ID="hdncreditlimit" runat="server" Value="0.00" />
            <asp:HiddenField ID="hdnclientBlock" runat="server" />
            <asp:HiddenField ID="hdnrolename" runat="server" />
            <asp:HiddenField ID="hdndespatchvisit" runat="server" />
            <asp:HiddenField ID="hdnSetSearchType" runat="server" Value="RPT" />
            <asp:HiddenField ID="hdndespatchClientId" runat="server" />
            <asp:HiddenField ID="hdnpreviousdue" runat="server" />
            <asp:HiddenField ID="hdnonoroff" runat="server" Value="N" />
            <asp:HiddenField ID="hdnclientdue" runat="server" Value="0.00" />
            <asp:HiddenField ID="hdnDispatchType" runat="server" Value="" />
            <asp:HiddenField ID="hdnDispatchMode" runat="server" Value="" />
            <input type="hidden" id="hdnHealthcheckup" runat="server" value="N" />
            <asp:HiddenField ID="hdnDispatch" runat="server" Value="" />
            <asp:HiddenField ID="hdnHomeList" runat="server" Value="" />
            <asp:HiddenField ID="hdnDoctorList" runat="server" Value="" />
            <asp:HiddenField ID="hdnPartial" runat="server" Value="" />
            <asp:HiddenField ID="hdnPending" runat="server" Value="" />
            <asp:HiddenField ID="hdnZonetext" runat="server" Value="" />
            <input type="hidden" id="hdnIsGeneralClient" runat="server" value="" />
            <input type="hidden" id="hdnPriority" name="Priority" runat="server" />
            <%-- <applet archive="launchexe_signed.jar" code="launchexe.class" id="apltLaunchExe"
            name="apltLaunchExe" width="1" height="1">
        </applet>--%>
            <div id="iframeplaceholder">
            </div>
            <asp:HiddenField ID="hdnMessages" runat="server" />
            <asp:HiddenField ID="hndBillprintHide" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
            <Attune:Attunefooter ID="Attunefooter" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript">
        function onPrintPolicy(printType, VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {
            //debugger;
            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                window.open(url, "labelprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
            }

            // window.open(url, "labelprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
            if (document.getElementById('hndBillprintHide').value == "N") {
                window.open(BillPrintUrl, "BillPrint", "letf=0,top=-20,toolbar=0,scrollbars=yes,status=0");
            }
            var isPrintable = true;
            var isExceeded = false;
            var lstReportPrintHistory = [];
            var orgid = 0;
            var visitid = 0;
            try {
                if ($("#hdnlstInvSelected").val() != '') {
                    lstReportPrintHistory = JSON.parse($("#hdnlstInvSelected").val());
                    $.each(lstReportPrintHistory, function(i, obj) {
                        obj.CreatedAt = Date.parseLocale(obj.CreatedAt, 'dd-MM-yyyy hh:mm:sstt');
                        if (obj.CreatedAt == null) {
                            obj.CreatedAt = new Date();
                        }
                    });
                }
                else {
                    var AccessionNumber = 0;
                    var InvestigationID = 0;
                    lstReportPrintHistory.push({
                        AccessionNumber: AccessionNumber,
                        InvestigationID: InvestigationID
                    });
                }
                if (printType == 'batch') {
                    orgid = patOrgID;
                    visitid = VID;
                }
                else {
                    orgid = $("#patOrgID").val();
                    visitid = $("#hdnVID").val()
                }
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetPrintPolicy",
                    data: "{patOrgID: " + orgid + ",VisitID: " + visitid + ",PrintReport: '" + JSON.stringify(lstReportPrintHistory) + "',PrintType: '" + printType + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function Success(data) {
                        isExceeded = data.d;
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        return true;
                    }
                });

                var vExceeded = SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_35') == null ? "You exceeded the maximum number of print(s). Are you sure you want to continue?" : SListForAppMsg.Get('Investigation_InvestigationReportPrint_aspx_35');
                if (isExceeded == true) {
                    var userMsg = SListForApplicationMessages.Get("Investigation\\InvestigationReport.aspx_40");
                    if (userMsg != null) {
                        confirm(userMsg);
                        return false;
                    }
                    else {
                        var result = confirm(vExceeded);
                    }
                    if (result == true) {
                        isPrintable = true;
                    }
                    else {
                        isPrintable = false;
                    }
                }
                else {
                    isPrintable = true;
                }
                if (isPrintable) {
                    if (printType == 'batch') {
                        PrintBatchReport(VID, RoleID);
                        //                        var browser_info = perform_acrobat_detection();
                        //                        if (browser_info.acrobat == null) {
                        //                            alert("Please install adobe reader to perform print functionality");
                        //                        }
                        //                        else {
                        //                            $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + VID + "&roleid=" + RoleID + "' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
                        //                        }








                    }
                    else {
                        onPrintSingleReport();
                        //                        var reportViewer = $find("rReportViewer");
                        //                        if (reportViewer != null) {
                        //                            var disablePrint = reportViewer.get_isLoading() ||
                        //                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;
                        //                            if (!disablePrint) {
                        //                                reportViewer.invokePrintDialog();
                        //                                return true;
                        //                            }
                        //                            else {
                        //                                alert("Unable to print report");
                        //                                return false;
                        //                            }
                        //                        }
                    }
                }
            }
            catch (e) {
                return false;
            }
            return isPrintable;
        }
    </script>

    <script type="text/javascript" language="javascript">
        //        if (document.getElementById('hdnHideDetails').value == "1") {
        //            showResponses('ACX2plus3', 'ACX2minus3', 'ACX2responses3', 0);
        //        }
        if (document.getElementById('hdnReferralType').value == "I") {
            document.getElementById('tdRPinternal').style.display = 'block';
            document.getElementById('tdRPExternal').style.display = 'none';
        }
        if (document.getElementById('hdnReferralType').value == "E") {
            document.getElementById('tdRPExternal').style.display = 'block';
            document.getElementById('tdRPinternal').style.display = 'none';
        }
        ShowHideReport();
        function SetToDate() {
            NewCal('<%=txtdispatchdate.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function() {
            ChangeDDLItemListWidth();
        });
    </script>

    </form>
</body>
</html>
