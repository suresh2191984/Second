<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReprintReportDispatch.aspx.cs" Inherits="Investigation_ReportDispatch"
    meta:resourcekey="PageResource1" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Report Dispatch</title>
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
        table.gridView.paddgridView td
        {
            padding: 0;
        }
    </style>

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript">
        function ClosePopUp() {
            $find('modalPopUp').hide();
        }
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceDiv').style.width = 'auto';
        }
        function setZoneWidth(source, eventArgs) {
            document.getElementById('ZoneDiv').style.width = 'auto';
        }
        function popupprint1() {
            //document.getElementById('divdispatchdetails').style.display = "none";
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
            ChangeLabel();
            // WinPrint.close();
        }
        function ShowdispatchList() {

            document.getElementById('divdispatchdetails').style.display = "block";

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

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_25") {
                alert('This action cannot be performed for your role in this Organisation');
            }

            else if (key == "Investigation\\InvestigationReport.aspx_26") {
                alert('URL Not Found');
            }
            else if (key == "Investigation\\InvestigationReport.aspx_27") {
                alert('Report dispatched successfully');
            }
            else if (key == "Investigation\\InvestigationReport.aspx_28") {
                alert('Unable to dispatch the report. please contact system administrator');
            }
            else if (key == "Investigation\\InvestigationReport.aspx_29") {
                alert('Unable to get the report. please contact system administrator');
            }
            else if (key == "Investigation\\InvestigationReport.aspx_30") {
                alert(' selected Patient Dispatched Investigation Reports');
            }
            return true;
        }


        function GetText(pName) {
            if (pName != "") {
                // var Temp = pName.split('(');
                //if (Temp.length >= 2) {
                document.getElementById('txtName').value = pName;
                // }
            }
        }


        function PrintBatchReport(VID, RoleID) {
            var browser_info = perform_acrobat_detection();
            if (browser_info.acrobat == null) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert("Please install adobe reader to perform print functionality");
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
            HubDetails();
        }
        function popupClosed() {

            document.getElementById('divdispatchdetails').style.display = "none";
            ChangeLabel();

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
                document.getElementById('tdRPinternal').style.display = "table-cell";
                document.getElementById('tdRPExternal').style.display = "none";
                document.getElementById('ddlPhysician').value = 0;

            }
            else {
                document.getElementById('tdRPinternal').style.display = "none";
                document.getElementById('tdRPExternal').style.display = "table-cell";
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
            //debugger;
            document.getElementById("hdnPDFType").value = 'showreport&invstatus';
            if ($('#ddlVisitActionName option:selected').val() == "Show_HealthReport_Patient") {
                if (document.getElementById('hdnHealthcheckup').value == "N") {

                    alert('Selected client patient not having Health Check Up details...');
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
                            alert("Please select the checkbox and dispatch");
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
                        alert("Select at least one record");
                        return false;
                    }
                }

                if (chkboxrowcount1 > 1) {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        alert("Select only one record");
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

                            alert('Selected client was Blocked');
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
                            var IsContinue = confirm('This Client is Suspended and you will be able to see STAT and Critical Test reports only, Do you wish to Continue ?');
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
                            alert('Select any one of the action to proceed');
                            return false;
                        }
                    }
                }
            }


        }
        function CheckDue() {

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
                                    alert('Selected patient having outstanding amount..');
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
                                    alert('Selected patient having outstanding amount..');
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
                    alert('Selected patient having outstanding amount..');
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
            var s = document.getElementById('hdnrolename').value;
            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                var chkboxrowcount1 = $("#gvIndv input:checkbox[id*='chkSel1']:checked").size();
                if (chkboxrowcount1 == 0) {
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        alert("please select at least one record");
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
                    alert("Select at least one record");
                    return false;
                }
            }

            if (chkboxrowcount1 > 1) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert("Select only one record");
                    return false;
                }
            }
        }

        function CheckPrint() {

            //            var s = document.getElementById('hdnrolename').value;
            //            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
            var chkboxrowcount1 = $("#grdResult input:checkbox[id*='chkSel']:checked").size();
            //            var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
            if (chkboxrowcount1 == 0) {
                alert("please select at least one record");
                return false;
            }

            else {
                if (document.getElementById('ddlLocationPrinter').value == '-1') {
                    alert("please select printer location");
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

            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value != '' || document.getElementById('TextTo').value != '') {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_14');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    alert('Provide visit date');
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
                    alert('Select an investigation to display  report');
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
                    alert('Select an investigation');
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
            if (document.getElementById("hdnPriority").value == '1') {
                alert('Already generated the priority report for this visit');
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
            document.getElementById('Txtfrom').value = "";
            document.getElementById('TextTo').value = "";

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

                if (document.getElementById('ddlPrintType').value == 'BILL' || document.getElementById('ddlPrintType').value == 'RPT') {


                    document.getElementById('ImgBntCalcTo').style.display = 'inline';
                    document.getElementById('ImgBntCalcFrom').style.display = 'inline';
                    document.getElementById('img3').style.display = 'none';
                    document.getElementById('img1').style.display = 'none';
                    document.getElementById('Txtfrom').style.display = 'table-cell';
                    document.getElementById('TextTo').style.display = 'table-cell';
                    document.getElementById('txtFromPeriod').style.display = 'none';
                    document.getElementById('txtToPeriod').style.display = 'none';


                }
                else {

                    document.getElementById('ImgBntCalcTo').style.display = 'none';
                    document.getElementById('ImgBntCalcFrom').style.display = 'none';
                    document.getElementById('img3').style.display = 'block';
                    document.getElementById('img1').style.display = 'block';
                    document.getElementById('Txtfrom').style.display = 'none';
                    document.getElementById('TextTo').style.display = 'none';
                    document.getElementById('txtFromPeriod').style.display = 'table-cell';
                    document.getElementById('txtToPeriod').style.display = 'table-cell';
                }
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

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
            //            if (document.getElementById('ddlRegisterDate').value == "5") {
            //                document.getElementById('txtFromDate').disabled = true;
            //                document.getElementById('txtToDate').disabled = true;
            //                document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
            //                document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
            //                document.getElementById('hdnTempFrom.ClientID ').value = document.getElementById('hdnLastWeekFirst').value;
            //                document.getElementById('hdnTempTo.ClientID').value = document.getElementById('hdnLastWeekLast').value;

            //                document.getElementById('divRegDate').style.display = 'block';
            //                document.getElementById('divRegDate').style.display = 'block';
            //                document.getElementById('divRegDate').style.display = 'inline';
            //                document.getElementById('divRegDate').style.display = 'inline';
            //                document.getElementById('divRegCustomDate').style.display = 'none';
            //                document.getElementById('divRegCustomDate').style.display = 'none';
            //            }
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

        function ShowPatientSts() {
            if ($('#ddlPatientPaytype :selected').text() != '--Select--') {
                document.getElementById('txtPatientStatus').value = "DISCHARGED";
            } else {
            document.getElementById('txtPatientStatus').value = "";
            }
        }
        function onPrintSingleReport() {
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
                    alert("Unable to print report");
                    return false;
                }
            }
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
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_18');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {

                        alert('Provide a valid email address.');
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
                    alert("Provide a email address.");
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
            ZoneDetails();

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
            if (document.getElementById('txtTestName').value.trim() == "") {
                document.getElementById('hdnTestID').value = "0";
                document.getElementById('hdnTestType').value = "";
            }
            if (document.getElementById('txtzone').value.trim() == "") {
                document.getElementById('hdntxtzoneID').value = "0";
            }
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

            if (document.getElementById('txtpageNo').value == "") {
                alert('Provide page number');
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                alert('Provide correct page number');
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                alert('Provide correct page number');
                return false;
            }
            return true;
        }

         
       
    </script>

</head>
<body id="oneColLayout">
    <form id="form1" runat="server" defaultbutton="btnSearch">

    <script type="text/jscript">

        function ShowPopUp(visitnumber) {
            // var ReturnValue = window.showModalDialog("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "dialogWidth=1000px;dialogHeight=750px;scroll:yes; status:yes;")
            var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
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
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UP" runat="server">
            <ContentTemplate>
                <table id="tblPatient" runat="server" class="w-100p">
                    <tr>
                        <td>
                            <asp:Panel ID="Panel3" CssClass="w-100p searchPanel" DefaultButton="btnSearch" runat="server"
                                meta:resourcekey="Panel3Resource1">
                                <div style="display: block;" class="dataheader2 w-100p">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblVisitNo" Text="Visit No" runat="server" meta:resourcekey="lblVisitNoaResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtVisitNo" CssClass="small" runat="server" meta:resourcekey="txtVisitNoResource1"></asp:TextBox>
                                            </td>
                                            <td class="w-15p">
                                                <asp:Label ID="lblName" Text="Patient Name" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                            </td>
                                            <td class="w-15p">
                                                <asp:TextBox ID="txtName" CssClass="small" OnChange="javascript:GetText(document.getElementById('txtName').value);"
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
                                                <asp:TextBox ID="txtMobile" CssClass="small" runat="server" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblclient" Text="Client" runat="server" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="small" ID="txtClientName" runat="server" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                <div id="aceDiv">
                                                </div>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                    BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                                    ServiceMethod="GetClientList" OnClientItemSelected="SelectedClientValue" ServicePath="~/WebService.asmx"
                                                    DelimiterCharacters="" Enabled="True" CompletionListElementID="aceDiv" OnClientShown="setAceWidth">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblReferringPhysician" Text="Ref.Dr" runat="server" meta:resourcekey="lblReferPhysicianResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="small" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
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
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlocation" onchange="LocationDetails()" CssClass="ddlsmall"
                                                        runat="server" meta:resourcekey="ddlocationResource2">
                                                    </asp:DropDownList>
                                                    <input type="hidden" runat="server" id="Hdnlocation" value="" />
                                                    <input type="hidden" runat="server" id="HdnlocationId" value="" />
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label10" Text="Department" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="drpdepartment" CssClass="ddlsmall" runat="server" meta:resourcekey="drpdepartmentResource1">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTestName" Text="Test Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtTestName" runat="server" CssClass="small" onBlur="return ClearFields();"
                                                    meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                                <div id="aceDiv1">
                                                </div>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderTestName" MinimumPrefixLength="2"
                                                    runat="server" TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg"
                                                    ServicePath="~/WebService.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11"
                                                    CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                    OnClientItemSelected="SelectedTest" DelimiterCharacters="" CompletionListElementID="aceDiv1"
                                                    OnClientShown="setAceWidth1">
                                                </cc1:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnTestID" Value="0" runat="server"></asp:HiddenField>
                                                <asp:HiddenField ID="hdnTestType" runat="server"></asp:HiddenField>
                                            </td>
                                            <td class="style3">
                                                <asp:Label ID="Label23" Text="Hub" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                            </td>
                                            <td class="style4">
                                                <asp:TextBox ID="txtHub" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox1 small"
                                                    OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                      meta:resourcekey="txtHubResource1"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" TargetControlID="txtHub"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHubDetails"
                                                    OnClientItemSelected="OnHubSelected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                    Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <input type="hidden" id="hdntxtHubID" runat="server" value="0" />
                                                <input type="hidden" id="HdnHub" runat="server" value="" />
                                                <input type="hidden" id="HdnHubId" runat="server" value="" />
                                            </td>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label7" Text="Zone" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtzone" runat="server" CssClass="small" AutoComplete="off" OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                          meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                                    <div id="ZoneDiv">
                                                    </div>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                                        OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                        Enabled="True" CompletionListElementID="ZoneDiv" OnClientShown="setZoneWidth">
                                                    </cc1:AutoCompleteExtender>
                                                    <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
                                                    <input type="hidden" id="HdnZone" runat="server" value="" />
                                                    <input type="hidden" id="HdnZoneId" runat="server" value="" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblddlPrintLocation" Text="Print.Location" runat="server" meta:resourcekey="lblddlPrintLocationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlPrintLocation" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlPrintLocationResource2">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPrintType" Text="Printable Type" runat="server" meta:resourcekey="lblddlPrintLocationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlPrintType" CssClass="ddlsmall" runat="server" onchange="javascript:ChangeLabel();"
                                                            meta:resourcekey="ddlPrintLocationResource2">
                                                            <%--<asp:ListItem Text="Report Dispatch" Value="RPT" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Report Checklist" Value="RPTCHK"></asp:ListItem>
                                                            <asp:ListItem Text="Receipt Dispatch" Value="BILL"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblStatus" Text="Visit Status" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddstatus" runat="server" CssClass="ddlsmall" meta:resourcekey="ddstatusResource1">
                                                            <%--<asp:ListItem Text="Non Printed" Value="Non Printed" meta:resourcekey="ListItemResource5"></asp:ListItem>
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
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlRegisterDate" CssClass="ddlsmall" onChange="javascript:return ShowRegDate();"
                                                            runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                                            <%--<asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource12" Text="--Select--"></asp:ListItem>
                                                            <asp:ListItem Value="0" meta:resourcekey="ListItemResource13" Text="This Week"></asp:ListItem>
                                                            <asp:ListItem Value="1" meta:resourcekey="ListItemResource14" Text="This Month"></asp:ListItem>
                                                            <asp:ListItem Value="2" meta:resourcekey="ListItemResource15" Text="This Year"></asp:ListItem>
                                                          <asp:ListItem Value="2" meta:resourcekey="ListItemResource16" Text="Custom Period"></asp:ListItem>
                                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource17" Text="Today"></asp:ListItem>
                                                            <asp:ListItem Value="4" meta:resourcekey="ListItemResource18" Text="Last Week"></asp:ListItem>
                                                            <asp:ListItem Value="5" meta:resourcekey="ListItemResource19" Text="Last Month"></asp:ListItem>
                                                           <asp:ListItem Value="7" meta:resourcekey="ListItemResource20" Text="Last Year"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                 <td>
                                                    <asp:Label ID="lblDispatch" Text="Dispatch Type" runat="server" ></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlDispatchMode" CssClass="ddlsmall" runat="server">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <%--<td colspan="2" style="display: block;" rowspan="2">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td nowrap="nowrap">
                                                                                <asp:Label ID="lblFromDate" runat="server" AssociatedControlID="txtSFromDate" Text="From Date"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtSFromDate" runat="server" CssClass="Txtboxsmall" Width="50%"></asp:TextBox>
                                                                                <a href="javascript:NewCssCal('txtSFromDate','ddmmyyyy','arrow',true,12);document.getElementById('txtSFromDate').focus();">
                                                                                    <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td nowrap="nowrap">
                                                                                <asp:Label ID="lblToDate" runat="server" AssociatedControlID="txtSToDate" Text="To Date"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtSToDate" runat="server" CssClass="Txtboxsmall" Width="50%"></asp:TextBox>
                                                                                <a href="javascript:NewCssCal('txtSToDate','ddmmyyyy','arrow',true,12);document.getElementById('txtSToDate').focus();">
                                                                                    <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>--%>
                                            </tr>
                                        </tr>
                                        <tr>
                                        <td><asp:Label ID="lblReportType" Text="Report Type" runat="server" ></asp:Label></td>
                                        <td> <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlReportType" CssClass="ddlsmall" runat="server">
                                                           <%-- <asp:ListItem Text="Fully Authorized Report" Value="FAR" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Partially Authorized Report A" Value="PAR"></asp:ListItem>
                                                            <asp:ListItem Text="Partially Authorized Report B(Recollect/Reflex)" Value="PARB"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </span></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:CheckBox ID="chhprintall" runat="server" Text="Print All" meta:resourcekey="chhprintallResource1" />
                                            </td>
                                            <td colspan="2">
                                                <asp:CheckBox ID="ChkColorPrint" runat="server" Text="Color Print" meta:resourcekey="ChkColorPrintResource1" />
                                            </td>
                                            <td colspan="2">
                                                <div id="divRegDate" style="display: none" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-50p">
                                                                <asp:TextBox CssClass="small" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-50p">
                                                                <asp:TextBox CssClass="small" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divRegCustomDate" runat="server" style="display: none;">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-50p">
                                                                <asp:TextBox CssClass="small" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                <a href="javascript:NewCssCal('txtFromPeriod','ddmmyyyy','arrow',true,12);document.getElementById('txtFromPeriod').focus();">
                                                                    <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                                    Mask="99/99/9999 99:99:99" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                                    CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <asp:TextBox CssClass="small" ID="Txtfrom" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender51" runat="server" TargetControlID="Txtfrom"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender51"
                                                                    ControlToValidate="Txtfrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="Txtfrom"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-50p">
                                                                <asp:TextBox CssClass="small" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                <asp:TextBox CssClass="small" ID="TextTo" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                <a href="javascript:NewCssCal('txtToPeriod','ddmmyyyy','arrow',true,12);document.getElementById('txtToPeriod').focus();">
                                                                    <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date"></a>
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                                    Mask="99/99/9999 99:99:99" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                                    CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender11" runat="server" TargetControlID="TextTo"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender11"
                                                                    ControlToValidate="TextTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditExtender11" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="TextTo"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                        <td colspan="2" > 



                                         <asp:HiddenField ID="hdnTempFrom1" runat="server" />
                                          <asp:HiddenField ID="hdnTempTo1" runat="server" />
                                           <asp:HiddenField ID="hdnTempFromPeriod1" runat="server" />
                                            <asp:HiddenField ID="hdnTempToPeriod1" runat="server" />
                                            <div id="mTPAFilter">
                                        <table class="w-100p" id="mTPAFilter" runat="server" style="display:none">
                                                                <tr>
                                                                <td width="150px"><asp:Label ID="IPOPNumber" Text="IP/OP Number" runat="server" ></asp:Label> </td><td>
                                                                <asp:TextBox CssClass="small" ID="txtIPOPNumber" runat="server"></asp:TextBox>
                                                                 </td>
                                                                </tr>
                                                                <tr>
                                                                <td><asp:Label runat="server" ID="PatientpayType" Text="Patient Pay Type" ></asp:Label> </td><td>
                                                                <asp:DropDownList CssClass="ddlsmall" ID="ddlPatientPaytype" runat="server" onChange="javascript:return ShowPatientSts();">
                                                                </asp:DropDownList></td>
                                                                </tr>
                                                                <tr>
                                                                <td><asp:Label runat="server" ID="PatientStatus" Text="Patient Status"></asp:Label></td><td>
                                                                <asp:TextBox CssClass="small" runat="server" ID="txtPatientStatus" ></asp:TextBox></td>
                                                                </tr>
                                                               <%-- <tr>
                                                                <td><asp:Label runat="server" ID="DischargedDate" Text="Discharged Date"></asp:Label> </td><td>
                                                                   <asp:DropDownList runat="server" ID="ddlDischargedate"  CssClass="ddlsmall" onChange="javascript:return ShowRegDate1();"
                                                                    EnableViewState="true"></asp:DropDownList></td>
                                                                </tr>--%>
                                                                </table>
                                         </div>
                                         </td><td colspan="2">
                                                <div id="divRegDate1" style="display: none" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_FromDate11" runat="server" Text="From Date" ></asp:Label></td><td class="w-50p">
                                                                <asp:TextBox CssClass="small" ID="txtFromDate1" runat="server"></asp:TextBox></td></tr><tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_ToDate11" runat="server" Text="To Date" ></asp:Label></td><td class="w-50p">
                                                                <asp:TextBox CssClass="small" runat="server" ID="txtToDate1" ></asp:TextBox></td></tr></table></div><div id="divRegCustomDate1" runat="server" style="display: none;">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_FromDate12" runat="server" Text="From Date" ></asp:Label></td><td class="w-50p">
                                                                <asp:TextBox CssClass="small" ID="txtFromPeriod1" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox><a href="javascript:NewCssCal('txtFromPeriod1','ddmmyyyy','arrow',true,12);document.getElementById('txtFromPeriod1').focus();"><img src="../images/Calendar_scheduleHS.png" id="img4" alt="Pick a date"></a>
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender511" runat="server" TargetControlID="txtFromPeriod1"
                                                                    Mask="99/99/9999 99:99:99" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                                    CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <asp:TextBox CssClass="small" ID="Txtfrom1" runat="server" ></asp:TextBox><asp:ImageButton ID="ImgBntCalcFrom1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False"  />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender512" runat="server" TargetControlID="Txtfrom1"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator51" runat="server" ControlExtender="MaskedEditExtender511"
                                                                    ControlToValidate="Txtfrom1" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator51"  />
                                                                <cc1:CalendarExtender ID="CalendarExtender11" runat="server" TargetControlID="Txtfrom1"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom1" Enabled="True" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-50p">
                                                                <asp:Label ID="Rs_ToDate12" runat="server" Text="To Date" ></asp:Label></td><td class="w-50p">
                                                                <asp:TextBox CssClass="small" runat="server" ID="txtToPeriod1" ></asp:TextBox><asp:TextBox CssClass="small" ID="TextTo1" runat="server" ></asp:TextBox><a href="javascript:NewCssCal('txtToPeriod1','ddmmyyyy','arrow',true,12);document.getElementById('txtToPeriod1').focus();"><img src="../images/Calendar_scheduleHS.png" id="img5" alt="Pick a date"></a>
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender121" runat="server" TargetControlID="txtToPeriod1"
                                                                    Mask="99/99/9999 99:99:99" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                                    CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <asp:ImageButton ID="ImgBntCalcTo1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" />
                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender111" runat="server" TargetControlID="TextTo1"
                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator11" runat="server" ControlExtender="MaskedEditExtender111"
                                                                    ControlToValidate="TextTo1" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditExtender111"  />
                                                                <cc1:CalendarExtender ID="CalendarExtender21" runat="server" TargetControlID="TextTo1"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo1" Enabled="True" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>                     
                                                               
                                        </tr>
                                        <tr id="trDetails" runat="server" style="display: table-row;">
                                            <td class="w-100p" colspan="6">
                                                <%-- <asp:UpdatePanel ID="updatePanel2" runat="server">
                                                                    <ContentTemplate>--%>
                                                <table class="w-100p h-90 v-top">
                                                    <tr>
                                                        <td colspan="6" class="w-33p">
                                                            <div id="divZone" runat="server" class="w-100p h-10" style="overflow: auto; overflow-x: hidden;
                                                                width: auto">
                                                            </div>
                                                        </td>
                                                        <td colspan="6" class="w-33p">
                                                            <div id="divHub" runat="server" class="w-100p h-90" style="overflow: auto; overflow-x: hidden;
                                                                width: auto">
                                                            </div>
                                                        </td>
                                                        <td colspan="6" class="w-34p">
                                                            <div id="divLocation" runat="server" class="w-100p h-90" style="overflow: auto; overflow-x: hidden;
                                                                width: auto">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--</ContentTemplate>
                                                                </asp:UpdatePanel>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-100p" colspan="6">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="w-90p a-center v-middle">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnSearch_Click" TabIndex="13" meta:resourcekey="btnSearchResource1" />
                                                        </td>
                                                        <td class="w-10p">                                                            <asp:Label ID="lbltotalrow" runat="server" CssClass="btn" Visible="false" Text="TotalCount" meta:resourcekey="lbltotalrowResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="8" class="a-center v-middle">
                                                <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                                    <ProgressTemplate>
                                                        <div id="progressBackgroundFilter" class="a-center">
                                                        </div>
                                                        <div id="processMessage" class="a-center w-20p">
                                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                                meta:resourcekey="img1Resource1" />
                                                        </div>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tblgrdview" class="w-100p" runat="server" style="display: none;">
                                        <tr class="tablerow" id="ACX2responses3" style="display: table-row;">
                                            <td>
                                                <table border="1" id="GrdHeader" class="w-100p" runat="server" style="display: table">
                                                    <tr class="dataheader1">
                                                        <td class="a-center w-5p">
                                                            <asp:Label ID="RdSel" runat="server" Text="Select" meta:resourcekey="RdSelResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-center w-6p">
                                                            <asp:Label ID="Rs_Select" runat="server" Text="Print" meta:resourcekey="Rs_SelectResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-center w-10p">
                                                            <asp:Label ID="Rs_PatientNo1" runat="server" Text="Visit Number" meta:resourcekey="Rs_PatientNo12vResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" class="a-center w-10p" id ="thlabnumber" >
                                                            <asp:Label ID="lblLabNumber" runat="server" Text="Lab Number" meta:resourcekey="DispgridLabNumberResource"></asp:Label>
                                                        </td>
                                                        <td  class="a-center w-14p">
                                                            <asp:Label ID="Rs_Name" runat="server" Text="Patient Name" meta:resourcekey="Rs_NameResources1"></asp:Label>
                                                        </td>
                                                        <td class="a-center w-8p">
                                                            <asp:Label ID="Rs_Age" runat="server" Text="Gender/Age" meta:resourcekey="Rs_Age1aResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-center w-10p">
                                                            <asp:Label ID="Rs_URNNo" runat="server" Text="VisitDate" meta:resourcekey="Rs_URNNoResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" class="a-center w-15p" id="tdorg">
                                                            <asp:Label ID="Rs_ToBePerformStatus" runat="server" Text="RefPhysicianName" meta:resourcekey="Rs_ToBePerformStatusResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" id="td12" class="a-center w-15p">
                                                            <asp:Label ID="Label9" runat="server" Text="Reg.Location" meta:resourcekey="Label9lResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" id="td17" class="a-center w-12p">
                                                            <asp:Label ID="Label22" runat="server" Text="Client" meta:resourcekey="LabelclResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server" class="a-center w-3p" id="tdActionse">
                                                            <asp:CheckBox ID="chkAll" runat="server" ToolTip="Select Row" Checked="false"></asp:CheckBox>
                                                        </td>
                                                        <td style="display: none;">
                                                            <asp:Label ID="Rs_TrackId" runat="server" Text="Select" meta:resourcekey="Rs_TrackIdResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table class="w-100p">
                                                    <tr class="w-100p">
                                                        <td>
                                                            <div id="divgv">
                                                                <asp:GridView ID="grdResult" runat="server" AllowPaging="false" CellPadding="1" AutoGenerateColumns="False"
                                                                    DataKeyNames="PatientVisitID,Name" CssClass="gridView w-100p m-auto paddgridView"
                                                                    OnRowDataBound="grdResult_RowDataBound" OnItemCommand="grdResult_ItemCommand"
                                                                    OnRowCommand="grdResult_RowCommand" ItemStyle-VerticalAlign="Top" RepeatDirection="Horizontal"
                                                                    OnPageIndexChanging="grdResult_PageIndexChanging" meta:resourcekey="grdResultResource1">
                                                                    <PagerStyle HorizontalAlign="Center" />
                                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                        PageButtonCount="5" PreviousPageText="" />
                                                                    <Columns>
                                                                        <asp:BoundField Visible="false" DataField="VisitNumber" HeaderText="VID" meta:resourcekey="BoundFieldResource1" />
                                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <table id="parentgrid" runat="server" class="w-100p a-left">
                                                                                    <tr id="Tr1" runat="server">
                                                                                        <td id="Td1" class="w-5p a-center" nowrap="nowrap" runat="server">
                                                                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                                                        </td>
                                                                                        <td id="printimage" class="a-center w-3p" runat="server">
                                                                                            <img id="imgPrintReport" title="Print" runat="server" alt="Print" visible="false"
                                                                                                src="~/Images/printer.gif" style="cursor: pointer;" />
                                                                                            <asp:ImageButton ID="Image1" ImageUrl="../Images/WithStationary.ico" runat="server"
                                                                                                ToolTip="WithStationary" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                CommandName="ShowWithStationary" Style="cursor: pointer; margin-left: 10px" />
                                                                                        </td>
                                                                                        <td id="printimage1" class="a-center w-3p" runat="server">
                                                                                            <asp:ImageButton ID="ImageButton1" ImageUrl="../Images/printer.gif" runat="server"
                                                                                                ToolTip="WithoutStationary" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                                                CommandName="ShowWithoutStationary" Style="cursor: pointer; margin-left: 10px" />
                                                                                        </td>
                                                                                        <td id="PatientNumber" class="a-center" style="display: none" nowrap="nowrap" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                                                        </td>
                                                                                        <td id="Td16" class="a-center w-10p" nowrap="nowrap" runat="server">
                                                                                            <asp:LinkButton ID="Button1" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                                                                OnClientClick='<%# String.Format("ShowPopUp({0});return false;",Eval("VisitNumber"))%> ' />
                                                                                        </td>
                                                                                        <td id="LabNubmer" class="a-center w-10p" nowrap="nowrap" runat="server">
                                                                                            <asp:Label ID="lblgrdLabnumer" runat="server" Text='<%# Bind("ExternalVisitID") %>'></asp:Label>
                                                                                        </td>
                                                                                        <td id="PatientName" class="a-left w-14p" runat="server">
                                                                                            <%--<asp:ImageButton ID="imgClick" ToolTip="Click here To View Visit details" runat="server"
                                                                                                                ImageUrl="~/Images/plus.png" CommandName="ShowChild" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />--%>
                                                                                            <%# DataBinder.Eval(Container.DataItem, "PatientName")%>
                                                                                        </td>
                                                                                        <td id="Age" class="a-left w-8p" runat="server">
                                                                                            <asp:Label ID="lblAge" runat="server" Text='<%# Bind("PatientAge") %>'></asp:Label>
                                                                                        </td>
                                                                                        <td id="VisitDate" class="a-left w-10p" nowrap="nowrap" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "VisitDate")%>
                                                                                        </td>
                                                                                        <td id="ReferingPhysicianName" class="a-left w-15p" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "ReferingPhysicianName")%>
                                                                                        </td>
                                                                                        <td id="Location" class="a-left w-15p" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "Location")%>
                                                                                        </td>
                                                                                        <td id="due" class="a-center" style="display: none;" nowrap="nowrap" runat="server">
                                                                                            <asp:HiddenField ID="hdOrgID" runat="server" Value='<%#Eval("OrgID") %>' />
                                                                                        </td>
                                                                                        <td id="Client" class="a-left w-15p" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "ClientName")%>
                                                                                        </td>
                                                                                        <td id="tdDespatch" class="a-center w-3p" nowrap="nowrap" runat="server">
                                                                                            <asp:CheckBox ID="chkSel" runat="server" ToolTip="Select Row" AutoPostBack="false" />
                                                                                        </td>
                                                                                        <td id="PatientVisitId" class="a-left" style="display: none" runat="server">
                                                                                            <asp:TextBox ID="txtPatientvisitId" Text='<%# Bind("PatientVisitId") %>' runat="server"></asp:TextBox>
                                                                                            <asp:TextBox ID="FinalURN" Text='<%# Bind("URNofId") %>' runat="server" Style="display: none" />
                                                                                            <asp:TextBox ID="txtDispatch" Text='<%# Bind("Remarks") %>' runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                        <td id="Td14" class="a-left" style="display: none" runat="server">
                                                                                            <asp:TextBox ID="txtpatientId" Text='<%# Bind("PatientID") %>' runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                        <td id="tddespatchstatus" class="a-left w-10p" runat="server" style="display: none;">
                                                                                            <asp:Label ID="lbldespatchstatus" runat="server" Text='<%# Bind("ReferralType") %>'></asp:Label>
                                                                                        </td>
                                                                                        <td id="td13" class="a-left w-10p" runat="server" style="display: none;">
                                                                                            <asp:Label ID="lblIsstat" runat="server" Text='<%# Bind("IsSTAT") %>'></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <ajc:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                                                    BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                                                </ajc:ModalPopupExtender>
                                                                <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
                                                                    vertical-align: bottom; top: 80px;">
                                                                    <table class="w-100p a-center">
                                                                        <tr>
                                                                            <td class="a-right">
                                                                                <img src="../Images/Close_Red_Online_small.png" alt="Close" id="img2" onclick="ClosePopUp()"
                                                                                    style="width: 20px; height: 20px; cursor: pointer; margin: 0 22px -2px 0" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table class="w-100p">
                                                    <div id="tblpage" runat="server" class="w-100p">
                                                        <tr id="trFooter" runat="server" class="dataheaderInvCtrl">
                                                            <td colspan="2" class="defaultfontcolor a-center">
                                                                <div id="divFooterNav" runat="server">
                                                                    <asp:Label ID="Label12" runat="server" Text="Page" meta:resourcekey="Label12Resource1"></asp:Label>
                                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                                    <asp:Label ID="Label13" runat="server" Text="Of" meta:resourcekey="Label13Resource1"></asp:Label>
                                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                                                        CssClass="btn w-71" meta:resourcekey="Btn_PreviousResource1" />
                                                                    <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                                                                        meta:resourcekey="Btn_NextResource1" />
                                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                    <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                                    <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                                    <asp:Label ID="Label14" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                                    <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30" onkeypress="return ValidateOnlyNumeric(this);"
                                                                        meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                                    <asp:Button ID="Button1" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                                                                        OnClick="btnGo_Click1" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                                                    <asp:Button Visible="false" type="button" ID="Button2" runat="server" Style="display: block;"
                                                                        OnClick="btnGo_Click2" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </div>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trSelectVisit" runat="server" class="a-center">
                                            <td class="defaultfontcolor w-100p">
                                                <asp:Label ID="lblLocationPrinter" runat="server" Text=" Select Printer" meta:resourcekey="lblLocationPrinterResource1"></asp:Label>
                                                <asp:DropDownList ID="ddlLocationPrinter" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlVisitActionNameResource1">
                                                </asp:DropDownList>
                                                <asp:Label ID="lblSelectapatientvisit" runat="server" Text=" Select Action" meta:resourcekey="lblSelectapatientvisitResource1"></asp:Label>
                                                <asp:DropDownList ID="ddlVisitActionName" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlVisitActionNameResource1">
                                                </asp:DropDownList>
                                                <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    OnClientClick="javascript:return CheckPrint();" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                                <asp:Button ID="Button3" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    OnClientClick="return ShowdispatchList();" onmouseout="this.className='btn'"
                                                    meta:resourcekey="btnGoResource1" OnClick="btnGo_ClickP" />
                                                <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divdispatchdetails" style="display: none;">
                                    <asp:Panel ID="PanelGroup" runat="server" Style="height: 420px; width: 1200px;" CssClass="modalPopup dataheaderPopup">
                                        <div id="dvInvstigationDetails" runat="server" style="display: block;">
                                            <asp:Panel ID="table_GroupItem" runat="server" class="AddScroll">
                                                <table class="a-center">
                                                    <tr>
                                                        <td class="a-center">
                                                            <%--  <asp:Label Font-Size="19px" ID="Label25" Style="font-family: Trebuchet MS" Height="30px"
                                                                                Font-Bold="true" Width="450px" runat="server" Text="ZONEWISE REPORT PRINTING STATUS BETWEEN" />
                                                                           --%>
                                                            <%--<asp:Label Font-Size="19px" Style="font-family: Trebuchet MS" ID="lblprintingperiod"
                                                                                Height="30px" Font-Bold="true" runat="server" Text="" />
                                                                            <br />--%>
                                                            <asp:Label CssClass="font16 h-30" Style="font-family: Trebuchet MS" ID="lblZOneName"
                                                                Font-Bold="true" Width="400px" runat="server" Text="" />
                                                            <%-- <br />
                                                                            <asp:Label Font-Size="16px" Style="font-family: Trebuchet MS" ID="lblPrintedAt" Height="30px"
                                                                                Font-Bold="true" Width="250px" runat="server" Text="" />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:DataList ID="ZoneDatList" runat="server" OnItemDataBound="ZoneDatList_ItemDataBound">
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td class="a-center">
                                                                    <asp:Label CssClass="font19 h-30" ID="Label25" Style="font-family: Trebuchet MS"
                                                                        Font-Bold="true" Width="450px" runat="server" Text="REPORT PRINTING STATUS BETWEEN -- " />
                                                                    <asp:Label CssClass="font19 h-30" Style="font-family: Trebuchet MS" ID="lblprintingperiod"
                                                                        Font-Bold="true" runat="server" Text="" />
                                                                    <br />
                                                                    <asp:Label CssClass="font16 h-30" Style="font-family: Trebuchet MS" ID="lblPrintedAt"
                                                                        Font-Bold="true" Width="250px" runat="server" Text="" />
                                                                    <br />
                                                                    <asp:Label Font-Bold="true" CssClass="font20" Style="page-break-before: always" ID="ZoneName"
                                                                        runat="server" Text='<%# Eval("Zone") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <br />
                                                                    <asp:DataList ID="outerDataList" runat="server" OnItemDataBound="outerRep_ItemDataBound">
                                                                        <HeaderTemplate>
                                                                            <asp:Label CssClass="font12 h-3" Font-Bold="true" ID="Label26" Width="1200px" runat="server"
                                                                                Text="---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" />
                                                                            <br />
                                                                            <asp:Label CssClass="font16 h-20" Style="font-family: Trebuchet MS" FontBold="true"
                                                                                ID="lblPatientVisitId" Font-Bold="true" Width="170px" runat="server" Text="Visit No." />
                                                                            <asp:Label CssClass="font16 h-20" Style="font-family: Trebuchet MS" ID="lblVisitDate"
                                                                                Font-Bold="true" runat="server" Width="170px" Text="Visit Date & Time" />
                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblpatientname" CssClass="font16 h-20"
                                                                                Font-Bold="true" runat="server" Width="250px" Text="Patient Name" />
                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblPrintedTime" CssClass="font16 h-20"
                                                                                Font-Bold="true" runat="server" Width="170px" Text="Printed Date & Time" />
                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblDeliveryTime" CssClass="font16 h-20"
                                                                                Font-Bold="true" runat="server" Width="170px" Text="Delivery Date & Time" />
                                                                            <asp:Label Style="font-family: Trebuchet MS" ID="lblStampSign" CssClass="font16 h-20"
                                                                                Font-Bold="true" runat="server" Width="170px" Text="Stamp & Sign" />
                                                                            <br />
                                                                            <asp:Label CssClass="font11 h-15" ID="Label27" Font-Bold="true" Width="1200px" runat="server"
                                                                                Text="---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" />
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <br />
                                                                            <asp:Label Font-Bold="true" CssClass="font20" Style="page-break-before: always" ID="ClientName"
                                                                                runat="server" Text='<%# Eval("ClientName") %>' />
                                                                            <br />
                                                                            <asp:Label Font-Size="11px" ID="Label27" CssClass="h-20" Font-Bold="true" Width="1200px"
                                                                                runat="server" Text="--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" />
                                                                            <asp:DataList ID="dlstDispatchList" runat="server">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblPatientVisitId" CssClass="font16 h-20" Width="170px" Style="font-family: Trebuchet MS"
                                                                                        runat="server" Text='<%# bind("VisitNumber") %>' />
                                                                                    <asp:Label ID="lblVisitDate" CssClass="font16 h-20" Width="170px" Style="font-family: Trebuchet MS"
                                                                                        runat="server" Text='<%# bind("ICDCodeStatus") %>' />
                                                                                    <asp:Label ID="lblpatientname" CssClass="font16 h-20" Width="250px" Style="font-family: Trebuchet MS"
                                                                                        runat="server" Text='<%# bind("PatientName") %>' />
                                                                                    <asp:Label ID="lblPrintedTime" CssClass="font16 h-20" Width="170px" Style="font-family: Trebuchet MS"
                                                                                        runat="server" Text='<%# bind("TPAName") %>' />
                                                                                </ItemTemplate>
                                                                            </asp:DataList>
                                                                        </ItemTemplate>
                                                                    </asp:DataList>
                                                                    <%--<p style="page-break-before: always">
                                                                    </p>--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </asp:Panel>
                                        </div>
                                        <table class="a-center">
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnPnlClose1" runat="server" class="btn" Text="Close" OnClientClick="return popupClosed()" />
                                                </td>
                                                <td class="a-center">
                                                    <asp:Button ID="btndispatchSheetprint" runat="server" class="btn" Text="Print" OnClientClick="return popupprint1();" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <cc1:ModalPopupExtender ID="InvStatusPopup" runat="server" BackgroundCssClass="modalBackground"
                                        DropShadow="false" PopupControlID="PanelGroup" Enabled="True" TargetControlID="Button3">
                                    </cc1:ModalPopupExtender>
                                    <%-- <asp:Button type="button" ID="btnDummy" runat="server" Style="display: block;" />--%>
                                </div>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <input type="hidden" id="Hidden1" name="PType" runat="server" />
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
    <asp:HiddenField ID="HiddenField1" runat="server" Value="RPT" />
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
    <asp:HiddenField ID="hdnSetSearchType" runat="server" Value="RPT" />
    <input type="hidden" id="hdnPDFType" name="PType" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

    <script type="text/javascript">
        $(document).ready(function() {
            ChangeDDLItemListWidth();
        });

        function ChangeLabel() {
            if (document.getElementById('ddlPrintType').value == 'RPT') {

                document.getElementById('Rs_RegisteredDate').innerHTML = 'Approved Date';

                document.getElementById('Rs_RegisteredDate').innerHTML = 'Approved Date/Discharge Date';

                document.getElementById('ImgBntCalcTo').style.display = 'inline';
                document.getElementById('ImgBntCalcFrom').style.display = 'inline';
                document.getElementById('img3').style.display = 'none';
                document.getElementById('img1').style.display = 'none';
                document.getElementById('Txtfrom').style.display = 'table-cell';
                document.getElementById('TextTo').style.display = 'table-cell';
                document.getElementById('txtFromPeriod').style.display = 'none';
                document.getElementById('txtToPeriod').style.display = 'none';

            }
            else if (document.getElementById('ddlPrintType').value == 'RPTCHK') {

                document.getElementById('Rs_RegisteredDate').innerHTML = 'Report Dipatched Date';

                document.getElementById('ImgBntCalcTo').style.display = 'none';
                document.getElementById('ImgBntCalcFrom').style.display = 'none';
                document.getElementById('img3').style.display = 'block';
                document.getElementById('img1').style.display = 'block';
                document.getElementById('Txtfrom').style.display = 'none';
                document.getElementById('TextTo').style.display = 'none';
                document.getElementById('txtFromPeriod').style.display = 'table-cell';
                document.getElementById('txtToPeriod').style.display = 'table-cell';
            }
            else if (document.getElementById('ddlPrintType').value == 'BILL') {

                document.getElementById('Rs_RegisteredDate').innerHTML = 'Billed Date';

                document.getElementById('ImgBntCalcTo').style.display = 'inline';
                document.getElementById('ImgBntCalcFrom').style.display = 'inline';
                document.getElementById('img3').style.display = 'none';
                document.getElementById('img1').style.display = 'none';
                document.getElementById('Txtfrom').style.display = 'block';
                document.getElementById('TextTo').style.display = 'block';
                document.getElementById('txtFromPeriod').style.display = 'none';
                document.getElementById('txtToPeriod').style.display = 'none';
            }
            else if (document.getElementById('ddlPrintType').value == 'BILLCHK') {

                document.getElementById('Rs_RegisteredDate').innerHTML = 'Bill Dipatched Date';

                document.getElementById('ImgBntCalcTo').style.display = 'none';
                document.getElementById('ImgBntCalcFrom').style.display = 'none';
                document.getElementById('img3').style.display = 'block';
                document.getElementById('img1').style.display = 'block';
                document.getElementById('Txtfrom').style.display = 'none';
                document.getElementById('TextTo').style.display = 'none';
                document.getElementById('txtFromPeriod').style.display = 'table-cell';
                document.getElementById('txtToPeriod').style.display = 'table-cell';
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        function setAceWidth1(source, eventArgs) {
            document.getElementById('aceDiv1').style.width = 'auto';
        }
    </script>

    <script type="text/javascript" language="javascript">
        //Added By Arivalagan K Reg.Locatopn//
        function clearLocation() {
            document.getElementById('ddlocation').value = "-1";
            return true;
        }
        function LocationDetails() {
            if (document.getElementById('ddlocation').options[document.getElementById('ddlocation').selectedIndex].text != "") {
                var LocationType = document.getElementById('ddlocation').options[document.getElementById('ddlocation').selectedIndex].text;
                var LocationId = document.getElementById('ddlocation').options[document.getElementById('ddlocation').selectedIndex].value;
            }
            if (LocationType != "--Select--" && LocationId != '-1') {
                var flag = 0;
                if (flag == 0) {
                    var secFlag = 0;
                    if (document.getElementById('Hdnlocation').value != '') {
                        var ExistsItem = document.getElementById('Hdnlocation').value.split('^');
                        for (var i = 0; i < ExistsItem.length; i++) {
                            if (ExistsItem[i] != '') {
                                var Msg = '';
                                var Count = 0;
                                if (ExistsItem[i].split('|')[0] == LocationType) {
                                    Count++;
                                    Msg += Count + '. ' + LocationType + ' is already added \n';
                                    document.getElementById('ddlocation').value = "-1";
                                }
                                if (Msg != '') {

                                    userMsg = Msg;
                                    if (userMsg != null) {
                                        alert(userMsg);
                                        return false;
                                    }
                                    else {
                                        alert(Msg);
                                        return false;
                                    }
                                    secFlag = 1;
                                    return false;
                                }
                            }
                        }
                    }
                    if (secFlag == 0) {
                        document.getElementById('Hdnlocation').value += LocationType + "|" + LocationId + ',' + "^";
                        document.getElementById('HdnlocationId').value += LocationId + ',';
                        CreateLocation();
                        clearLocation();
                        return false;
                    }
                }
                return false;
            }
            return false;
        }

        function CreateLocation() {
            debugger;
            var objLoc = SListForAppDisplay.Get("Investigation_ReportDispatch_aspx_02") != null ? SListForAppDisplay.Get("Investigation_ReportDispatch_aspx_02") : "Reg.Location";
            var objAction = SListForAppDisplay.Get("Investigation_ReportDispatch_aspx_03") != null ? SListForAppDisplay.Get("Investigation_ReportDispatch_aspx_03") : "Action";
            var objDel = SListForAppDisplay.Get("Investigation_ReportDispatch_aspx_04") != null ? SListForAppDisplay.Get("Investigation_ReportDispatch_aspx_04") : "Delete";
            var items = '';
            document.getElementById('divLocation').innerHTML = "";
            if (document.getElementById('Hdnlocation').value != '') {
                items = document.getElementById('Hdnlocation').value.split('^');
            }
            if (items != "") {
                var startTag, bodyTag, endTag;
                startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl bg-row' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='left' width='90%'>" + objLoc + "</th> <th scope='col' align='left' width='10%'>" + objAction + "</th></tr>";
                endTag = "</TBODY></TABLE>";
                bodyTag = startTag;
                for (var i = 0; i < items.length; i++) {
                    if (items[i] != "") {
                        bodyTag += "<TR><TD>" + items[i].split('|')[0] + "</TD>";
                        bodyTag += "<TD><input name='" + items[i] + "'<input name='" + items[i] + "' onclick='return DeleteLocation(name);' value = '" + objDel + "' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD>";
                        bodyTag += "</TR>";
                    }
                }

                bodyTag += endTag;
                document.getElementById('trDetails').style.display = 'table-row';
                document.getElementById('divLocation').innerHTML = bodyTag;
            }
        }
        function DeleteLocation(DeleteId) {
            var i;
            var objApp01 = SListForAppMsg.Get("Investigation_ReportDispatch_aspx_01") == null ? " Confirm to delete!!" : SListForAppMsg.Get("Investigation_ReportDispatch_aspx_01");
            var confirmmsg = objApp01;
            var IsDelete = confirm(confirmmsg);
            if (IsDelete == true) {
                var x = document.getElementById('Hdnlocation').value.split("^");
                document.getElementById('Hdnlocation').value = '';
                document.getElementById('HdnlocationId').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != DeleteId) {
                            document.getElementById('Hdnlocation').value += x[i] + "^";
                            document.getElementById('HdnlocationId').value += x[i].split('|')[1];
                        }
                    }


                }
                CreateLocation();
            }
            else {
                return false;
            }
        }
        //Added By Arivalagan K End Reg.Location//
    </script>

    <script type="text/javascript" language="javascript">
        //Added By Arivalagan K Zone//
        function clearZone() {
            document.getElementById('txtzone').value = "";
            return true;
        }
        function ZoneDetails() {
            if (document.getElementById('txtzone').value != '' && document.getElementById('hdntxtzoneID').value != '') {
                var ZoneName = document.getElementById('txtzone').value;
                var ZoneId = document.getElementById('hdntxtzoneID').value;
            }
            if (ZoneName != "" && ZoneId != '') {
                var flag = 0;
                if (flag == 0) {
                    var secFlag = 0;
                    if (document.getElementById('HdnZone').value != '') {
                        var ExistsItem = document.getElementById('HdnZone').value.split('^');
                        for (var i = 0; i < ExistsItem.length; i++) {
                            if (ExistsItem[i] != '') {
                                var Msg = '';
                                var Count = 0;
                                if (ExistsItem[i].split('|')[0] == ZoneName) {
                                    Count++;
                                    Msg += Count + '. ' + ZoneName + ' is already added \n';
                                    document.getElementById('txtzone').value = "";
                                }
                                if (Msg != '') {

                                    userMsg = Msg;
                                    if (userMsg != null) {
                                        alert(userMsg);
                                        return false;
                                    }
                                    else {
                                        alert(Msg);
                                        return false;
                                    }
                                    secFlag = 1;
                                    return false;
                                }
                            }
                        }
                    }
                    if (secFlag == 0) {
                        document.getElementById('HdnZone').value += ZoneName + "|" + ZoneId + ',' + "^";
                        document.getElementById('HdnZoneId').value += ZoneId + ',';
                        CreateZone();
                        clearZone();
                        return false;
                    }
                }
                return false;
            }
            return false;
        }

        function CreateZone() {

            var items = '';
            document.getElementById('divZone').innerHTML = "";
            if (document.getElementById('HdnZone').value != '') {
                items = document.getElementById('HdnZone').value.split('^');
            }
            if (items != "") {
                var startTag, bodyTag, endTag;
                startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl bg-row' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='left' width='90%'> Zone </th> <th scope='col' align='left' width='10%'>Action</th></tr>";
                endTag = "</TBODY></TABLE>";
                bodyTag = startTag;
                for (var i = 0; i < items.length; i++) {
                    if (items[i] != "") {
                        bodyTag += "<TR><TD>" + items[i].split('|')[0] + "</TD>";
                        bodyTag += "<TD><input name='" + items[i] + "'<input name='" + items[i] + "' onclick='return DeleteZone(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD>";
                        bodyTag += "</TR>";
                    }
                }

                bodyTag += endTag;
                document.getElementById('trDetails').style.display = 'table-row';
                document.getElementById('divZone').innerHTML = bodyTag;
            }
        }
        function DeleteZone(DeleteId) {
            var i;
            var confirmmsg = "Confirm to delete!!";
            var IsDelete = confirm(confirmmsg);
            if (IsDelete == true) {
                var x = document.getElementById('HdnZone').value.split("^");
                document.getElementById('HdnZone').value = '';
                document.getElementById('HdnZoneId').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != DeleteId) {
                            document.getElementById('HdnZone').value += x[i] + "^";
                            document.getElementById('HdnZoneId').value += x[i].split('|')[1];
                        }
                    }
                }
                CreateZone();
            }
            else {
                return false;
            }
        }
        //Added By Arivalagan K End Zone//
    </script>

    <script type="text/javascript" language="javascript">
        //Added By Arivalagan K Hub//
        function clearHub() {
            document.getElementById('txtHub').value = "";
            return true;
        }
        function HubDetails() {
            if (document.getElementById('txtHub').value != '') {
                var HubName = document.getElementById('txtHub').value;
            }
            if (document.getElementById('hdntxtHubID').value != '') {
                var HubId = document.getElementById('hdntxtHubID').value;
            }
            if (HubName != "" && HubId != '') {
                var flag = 0;
                if (flag == 0) {
                    var secFlag = 0;
                    if (document.getElementById('HdnHub').value != '') {
                        var ExistsItem = document.getElementById('HdnHub').value.split('^');
                        for (var i = 0; i < ExistsItem.length; i++) {
                            if (ExistsItem[i] != '') {
                                var Msg = '';
                                var Count = 0;
                                if (ExistsItem[i].split('|')[0] == HubName) {
                                    Count++;
                                    Msg += Count + '. ' + HubName + ' is already added \n';
                                    document.getElementById('txtHub').value = "";
                                }
                                if (Msg != '') {

                                    userMsg = Msg;
                                    if (userMsg != null) {
                                        alert(userMsg);
                                        return false;
                                    }
                                    else {
                                        alert(Msg);
                                        return false;
                                    }
                                    secFlag = 1;
                                    return false;
                                }
                            }
                        }
                    }
                    if (secFlag == 0) {
                        document.getElementById('HdnHub').value += HubName + "|" + HubId + ',' + "^";
                        document.getElementById('HdnHubId').value += HubId + ',';
                        CreateHub();
                        clearHub();
                        return false;
                    }
                }
                return false;
            }
            return false;
        }

        function CreateHub() {

            var items = '';
            document.getElementById('divHub').innerHTML = "";
            if (document.getElementById('HdnHub').value != '') {
                items = document.getElementById('HdnHub').value.split('^');
            }
            if (items != "") {
                var startTag, bodyTag, endTag;
                startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl bg-row' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='left' width='90%'> Hub </th> <th scope='col' align='left' width='10%'>Action</th></tr>";
                endTag = "</TBODY></TABLE>";
                bodyTag = startTag;
                for (var i = 0; i < items.length; i++) {
                    if (items[i] != "") {
                        bodyTag += "<TR><TD>" + items[i].split('|')[0] + "</TD>";
                        bodyTag += "<TD><input name='" + items[i] + "'<input name='" + items[i] + "' onclick='return DeleteHub(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD>";
                        bodyTag += "</TR>";
                    }
                }

                bodyTag += endTag;
                document.getElementById('trDetails').style.display = 'table-row';
                document.getElementById('divHub').innerHTML = bodyTag;
            }
        }
        function DeleteHub(DeleteId) {
            var i;
            var confirmmsg = "Confirm to delete!!";
            var IsDelete = confirm(confirmmsg);
            if (IsDelete == true) {
                var x = document.getElementById('HdnHub').value.split("^");
                document.getElementById('HdnHub').value = '';
                document.getElementById('HdnHubId').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != DeleteId) {
                            document.getElementById('HdnHub').value += x[i] + "^";
                            document.getElementById('HdnHubId').value += x[i].split('|')[1];
                        }
                    }
                }
                CreateHub();
            }
            else {
                return false;
            }
        }


        function ReCallAll() {
            CreateLocation();
            CreateZone();
            CreateHub();
        }
        //Added By Arivalagan K End Hub//
    </script>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hndBillprintHide" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    </form>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

</body>
</html>
