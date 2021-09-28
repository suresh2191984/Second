
        function ClosePopUp() {
            $find('modalPopUp').hide();
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
 
        //----------Murali Changes End---//

        function GetText(pName) {
            if (pName != "") {
                document.getElementById('txtName').value = pName;
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
                if (DueAmount > 0) {
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
        }
    

    
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
            document.getElementById("patOrgID").value = patOrgID;
            document.getElementById("hdnEMail").value = email;
            document.getElementById("hdncreditlimit").value = CreditLimit;
            document.getElementById("hdnclientBlock").value = ClientBlock;
            document.getElementById("hdnclientdue").value = ClientDue;
            document.getElementById("hdnHealthcheckup").value = IsHealthCheckup;
            document.getElementById("hdnIsGeneralClient").value = IsGeneralClient;
            document.getElementById("hdnDue").value = DueAmount;
            document.getElementById("hdnClientID").value = ClientID;

        }
        function SelectDespatchVisit(id, vid, pid, patOrgID, email, pname, DispatchTypeMode, DispatchType, DispatchValue, IsHealthCheckup, DueAmount, ClientID) {

            chosen = "";
            var len = document.forms[0].elements.length;

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
                    var chk = $(tr).find("input:checkbox[id$=chkSel]").attr('checked') ? true : false;
                    if (chk == true) {

                        var PatClientID;
                        if (document.getElementById("hdnDue") != null) {
                            var hdnDue = document.getElementById("hdnDue").value;
                            if (document.getElementById("hdnClientID") != null) {
                                PatClientID = document.getElementById("hdnClientID").value;
                            }
                            if ((hdnDue != "0.00") && (hdnDue != "0") && (hdnDue != "-1")) {
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
                            if ((hdnDue != "0.00") && (hdnDue != "0") && (hdnDue != "-1")) {
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

        function ChechVisitDate() {

            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value != '' || document.getElementById('txtTo').value != '') {
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
        function ShowReportDiv() {
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
            if (document.getElementById(obj).checked) {
                document.getElementById('ChkID').value = obj + '^';
            }
            else {
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
                    document.getElementById(chkArrayMain[i]).disabled = false;
                    document.getElementById(chkArrayMain[i]).checked = false;
                    if (chkArraydisable[i] > 0) {
                        document.getElementById(chkArrayMain[i]).disabled = true;
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
            document.apltLaunchExe.launch(cmdline2);
        }

        function launchexe_mv(patid, studyid, modality, imageserveripaddress, portnumber, loggedinusername) {
            var exename = 'launch_viewer_mv.exe';
            var args = patid + ' ' + studyid + ' ' + modality + ' ' + imageserveripaddress + ' ' + portnumber + ' ' + loggedinusername;
            var cmdline = exename + ' ' + args;
            document.apltLaunchExe.launch(cmdline);
            return false;
        }


        function popupprint() {
            var prtContent = document.getElementById('printANCCS');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=1024,height=768');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
        }



        function pdfPrint() {
            document.getElementById("hdnPDFType").value = 'prtpdf';
        }
        function PriorityValidation() {
            if (document.getElementById("hdnPriority").value == '1') {
                alert('Already generated the priority report for this visit');
                return false;
            }
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
        function onPrintReport(VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {

            try {
                if (document.getElementById("hdnDue").value != "0.00" && document.getElementById("hdnDue").value != "0") {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_6');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        alert('This Patient having due amount');

                        return false;
                    }
                } else {
                    return onPrintPolicy('single', VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow);
                }
            }
            catch (e) {
                return false;
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

        function SelectPatientName(source, eventArgs) {
            var Name = eventArgs.get_text();
            var ID = eventArgs.get_value();
            document.getElementById('hdnPatientID').value = ID;


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
            if (document.getElementById('txtPersonName').value.trim() == "") {
                document.getElementById('hdnEmpID').value = "0";
            }
        }
        function ClearSearchFields() {
            document.getElementById('txtVisitNo').value = "";
            document.getElementById('txtName').value = "";
            document.getElementById('txtMobile').value = "";
            document.getElementById('txtClientName').value = "";
            document.getElementById('txtInternalExternalPhysician').value = "";
            document.getElementById('ddlocation').value = "-1";
            document.getElementById('drpdepartment').value = "0";
            document.getElementById('txtTestName').value = "";
            document.getElementById('hdnTestID').value = "0";
            document.getElementById('txtzone').value = "";
            document.getElementById('hdntxtzoneID').value = "0";
            document.getElementById('ddstatus').value = "---Select---";
            document.getElementById('ddlRegisterDate').value = "-1";
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }
            document.getElementById('txtLabNo').value = "";
            document.getElementById('ddVisitType').value = "-1";
            document.getElementById('drplstPerson').value = "";
            document.getElementById('drpPriority').value = "0";
            document.getElementById('txtWardName').value = "";
            document.getElementById('chkDespatchMode').value = "";
            document.getElementById('ddlPriority').value = "";
            document.getElementById('txtReferringHospital').value = "";
            document.getElementById('hdfReferalHospitalID').value = "0";
            document.getElementById('txtPatientNo').value = "";
            window.location.href("../Investigation/InvestigationReport.aspx?IsPopup=Y");
            return false;
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

        function SelectAllTest(sender) {

            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('hdndespatchClientId').value.split('~');
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                }
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                }
            }
        }
       
    

    
        function onPrintPolicy(printType, VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {

            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                window.open(url, "labelprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
            }
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
                if (isExceeded == true) {
                    var userMsg = SListForApplicationMessages.Get("Investigation\\InvestigationReport.aspx_40");
                    if (userMsg != null) {
                        confirm(userMsg);
                        return false;
                    }
                    else {
                        var result = confirm("You exceeded the maximum number of print(s). Are you sure you want to continue?");
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
                    }
                    else {
                        onPrintSingleReport();
                    }
                }
            }
            catch (e) {
                return false;
            }
            return isPrintable;
        }
    

    

        function ShowPopUp(visitnumber) {
            var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
        }

        jQuery(function($) {

            var allCkBoxSelector = 'input[id*="chkAll"]:checkbox';
            var checkBoxSelector; //comments'#=grdResulinput[id*="chkSel"]:checkbox';
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
            document.getElementById('trhide1').style.display = 'block';
            document.getElementById('trhide3').style.display = 'block';
            document.getElementById('Div5').style.display = 'none';
            document.getElementById('Div6').style.display = 'block';

        }
        function Hidesearch() {
            document.getElementById('trhide1').style.display = 'none';
            document.getElementById('trhide3').style.display = 'none';
            document.getElementById('Div5').style.display = 'block';
            document.getElementById('Div6').style.display = 'none';

        }

    

   
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

            return true;
        }
    

    
        $(document).ready(function() {
            ChangeDDLItemListWidth();
        });
    

    
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceDiv').style.width = 'auto';
            document.getElementById('aceClient').style.width = 'auto';
            document.getElementById('aceReferDR').style.width = 'auto';
            document.getElementById('DivPatientName').style.width = 'auto';
            document.getElementById('Divzone').style.width = 'auto';
        }
    

    
        function cancelclick() {
            $find("mdlPatientData").hide();
            return false;
        }

        function GetData(obj) {
            try {
                var $row = $(obj).closest('tr');
                var rowIndex = $row.index();
                var hdnVisitID = parseInt($row.find($('input[id$="txtPatientvisitId"]')).val());
                $.ajax({

                    type: "POST",
                    url: "../WebService.asmx/GetPatientdetailsForInvestigation",
                    data: "{ visitid: " + hdnVisitID + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");

                        $find("mdlPatientData").hide();

                        return false;
                    }
                });
            }
            catch (e) {

            }
            return false;
        }
        function GetDataForPrint(obj) {

            try {

                var $row = $(obj).closest('tr');
                var rowIndex = $row.index();
                var hdnVisitID = parseInt($row.find($('input[id$="txtPatientvisitId"]')).val());
                var inputType = obj.title;
                var OrgID = $('#hdnOrgID1').val();
                var ILocationID = $('#hdnLocationID').val();
                $.ajax({

                    type: "POST",
                    url: "../WebService.asmx/GetPatientdetailsForInvestigationPrint",
                    data: "{ pVisitID: " + parseInt(hdnVisitID) + ",ILocationID: " + parseInt(ILocationID) + ",OrgID: " + parseInt(OrgID) + ",inputType:'" + inputType + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceededForPrint,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        return false;
                    }
                });
            }
            catch (e) {

            }
            return false;
        }
        function AjaxGetFieldDataSucceededForPrint(result) {

            if (result.d == "Report is not ready" || result.d == "") {
                alert('Report is not ready');
            }
            else {
        $find('modalPopUp').show();
        // $('#ifPDF').attr('src', result.d);
        document.getElementById('pnlOthers').style.display = 'block';
        document.getElementById('ifPDF').src = '../Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=' + result.d;
            }
            return false;
        }
        function AjaxGetFieldDataSucceeded(result) {



            var oTable;
            if (result != "[]") {

                var tableData = "<table id='tableBorder'  cellpadding='0' cellspacing='0' width='550px'  style='border:solid 6px #f17215;'><tr style='color:white; height:40px;background-color:#2c88b1'><td>Investigation List</td><td>Report Status</td></tr>";
                var rowdata = "";
                var lstProcessLocation = result.d;
                if (lstProcessLocation.length > 0) {
                    for (var i = 0; i < lstProcessLocation.length; i++) {
                        rowdata = '<tr style="color:black;height:35px;background-color:#fff"><td>' + lstProcessLocation[i].InvestigationName + '</td>';
                        rowdata = rowdata + '<td>' + lstProcessLocation[i].DisplayStatus + '</td></tr>';
                    }
                }
                tableData = tableData + rowdata + "<tr styel='padding-top:5px;'><td colspan='2' align='center'><input id='btnClose' class='btn'  onclick='javascript:return cancelclick();' type='submit' value='Close'/></td></tr></table>";
                $('#lblPatientData').html(tableData);

                $find("mdlPatientData").show();

            }
        }
        function hidemdlPatientData() {
            $find("mdlPatientData").hide();
            return false;
        }
   