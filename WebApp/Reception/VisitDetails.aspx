<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitDetails.aspx.cs" Inherits="Reception_VisitDetails"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/TRFUpload.ascx" TagName="TRFUpload" TagPrefix="TRF" %>
<%@ Register Src="~/CommonControls/PhotoUpload.ascx" TagName="PhotoUpload" TagPrefix="PHOTO" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Visit Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .dataheaderPopup
        {
            background-image: url(../Images/whitebg.png);
            background-repeat: repeat;
            width: auto;
            margin-left: 0px;
            margin-top: 0px;
            margin-bottom: 10px;
            border-color: #f17215;
            border-style: solid;
            border-width: 5px;
            color: #000000;
        }
        .invscrol01
        {
            display: block;
            height: 70px;
            overflow-x: hidden;
            overflow-y: scroll;
        }
        .invscrol
        {
            display: table;
            width: 100% !important;
        }
        .invscrol td
        {
            background: none !important;
            color: #000 !important;
            display: table-cell !important;
        }
        .invscrol tr
        {
            display: table-row;
            width: 100%;
        }
    </style>

    <script type="text/javascript">
        //changes by arun - reprint trfbarcode--
        if ($('#ddlVisitActionName :selected').val() == 'Reprint_TRFBarcode_SampleSearch') {
            document.getElementById("txtprintCnt").style.display = "inherit";
        }
        else {
            document.getElementById("txtprintCnt").style.display = "none";
        }
        //changes by arun - reprint trfbarcode
        //added by jegan start
        function CheckFromDateToDate() {
            alert('To date can not be less than the From date.');
        }
         //end
        function WaterMark(txttext, evt, defaultText) {
            if (txttext.value.length == 0 && evt.type == "blur") {
                txttext.style.color = "gray";
                txttext.value = defaultText;
            }
            if (txttext.value == defaultText && evt.type == "focus") {
                txttext.style.color = "black";
                txttext.value = "";
            }
        }
        //Date Validation
        function ValidDateTime(obj1, obj2) {
            var obj = document.getElementById(obj1);
            var obj1 = document.getElementById(obj2);
            var objMsg02 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_02") == null ? "ValidTo Must be Greater than or Equalto ValidFrom Date" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_02");
            var objAlert = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_Alert");
            var objMsg21 = SListForAppMsg.Get("Admin_ClientRateMapping_aspx_21") == null ? "Please Select Valid From Date" : SListForAppMsg.Get("Admin_ClientRateMapping_aspx_21");
            if (obj.value == '') {
                ValidationWindow(objMsg21, objAlert);
                obj1.value = '';
                obj.focus();
            }
            var currentTime;
            if (obj.value != '' && obj.value != '__/__/____') {
                dobDt = obj.value.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                var mMonth = (dobDtTime.getMonth() + 1).toString();
                var mDay = dobDt[0];
                var mYear = dobDt[2];
            }
            if (obj1.value != '' && obj1.value != '__/__/____') {
                dobDt1 = obj1.value.split('/');
                var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
                var month = (dobDtTime.getMonth() + 1).toString();
                var day = dobDt1[0];
                var year = dobDt1[2];
            }
            if (mYear > year) {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_1");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                else {
                    //alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
                    ValidationWindow(objMsg02, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if (mYear == year && mMonth > month) {

                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_1");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                else {
                    //alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
                    ValidationWindow(objMsg02, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }

                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if (mYear == year && mMonth == month && mDay > day) {
                var userMsg = SListForApplicationMessages.Get("Admin\\ClientRateMapping.aspx_1");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                else {
                    //alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
                    ValidationWindow(objMsg02, objAlert);
                    document.getElementById('txtValidTo').value = '';
                    return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }

        }
        //Added By Arivalagan.k//
        var AlertType;
        function ShowPopUp(visitnumber,Type) {
            //  var visitnovalue = visitnumber.innerText;

            if (Type == 'Visit') {
                var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
            }
            else if(Type=='Lab') {
            var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&LabNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
            }
        }
        //End Added By Arivalagan.k//
        //Added bt Thamilselvan to Call the Print Screen Popup While Clicking the PrintBill Button.... Changing same as Billing Page....
        function OpenIframe(FinalBillID, patientVisitID) {

            $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&finalBillID=" + FinalBillID + "&actionType=POPUP&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");

        }
        function OpenIframe1() {
            var PVisitIDS = $('#hdnPVisitID').val();
            var PBillIDS = $('#hdnFinalBillID').val()

            $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + PVisitIDS + "&finalBillID=" + PBillIDS + "&actionType=DefaultPrint&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
        }


        function CheckHubName(codeType, TxtID) {
            /* Added By Venkatesh S */
            var vSelectHubName = SListForAppMsg.Get('Reception_VisitDetails_aspx_01') == null ? "Select the Hub Name From List" : SListForAppMsg.Get('Reception_VisitDetails_aspx_01');
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            var txtValue = document.getElementById(TxtID).value.trim();


            if (txtValue != '') {
                if (document.getElementById('hdnHubID').value == '0') {
                    ValidationWindow(vSelectHubName, AlertType);
                    document.getElementById('txtHub').focus();
                    document.getElementById('txtHub').value = '';
                    return false;
                }
            }
        }
        function CheckZoneName(codeType, TxtID) {
            /* Added By Venkatesh S */
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            var vSelectHubName = SListForAppMsg.Get('Reception_VisitDetails_aspx_02') == null ? "Select the Zone Name From List" : SListForAppMsg.Get('Reception_VisitDetails_aspx_02');
            var txtValue = document.getElementById(TxtID).value.trim();


            if (txtValue != '') {
                if (document.getElementById('hdntxtzoneID').value == '0') {
                    ValidationWindow(vSelectHubName, AlertType);
                    document.getElementById('txtzone').focus();
                    document.getElementById('txtzone').value = '';
                    return false;
                }
            }
        }
        function OnHubSelected(source, eventArgs) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            document.getElementById('txtHub').value = eventArgs.get_text();
            document.getElementById('hdnHubID').value = eventArgs.get_value();
            if (document.getElementById('hdnHubID').value != "0") {
                $find('AutoCompleteExtender2').set_contextKey('zone' + '~' + document.getElementById('hdnHubID').value);
            }
            else {
                $find('AutoCompleteExtender2').set_contextKey('');
            }
        }
        function ClearFields(Name) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            if (Name == 'ZON') {
                document.getElementById('hdntxtzoneID').value = '0';
            }
        }
        function Onzoneselected(source, eventArgs) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            document.getElementById('txtzone').value = eventArgs.get_text();
            document.getElementById('hdntxtzoneID').value = eventArgs.get_value();
            if (document.getElementById('hdntxtzoneID').value != "0") {
                $find('AutoCompleteExtender2').set_contextKey('route' + '~' + document.getElementById('hdntxtzoneID').value);
            }
            else {
                $find('AutoCompleteExtender2').set_contextKey('');
            }
        }
        function isSpclChar(e) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
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
        function setLoginID()
        {
            if (document.getElementById('txtUserName').value == "")
                document.getElementById('hdnApprovedByID').value = "0";
        
        }
        function DiscountAuthSelectedOver(source, eventArgs) {
            document.getElementById('hdnApprovedByID').value = "0";
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            $find('AutoUser')._onMethodComplete = function(result, context) {
                /* Added By Venkatesh S */
                var vSelectUserForm = SListForAppMsg.Get('Reception_VisitDetails_aspx_03') == null ? "Please select user from the list" : SListForAppMsg.Get('Reception_VisitDetails_aspx_03');
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoUser')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    
                    ValidationWindow(vSelectUserForm, AlertType);
                    document.getElementById('txtUserName').value = '';
                }
                
            };
        }
        function DiscountAuthSelected(source, eventArgs) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            if (eventArgs != undefined) {
                document.getElementById('hdnApprovedByID').value = eventArgs.get_value();
            }
            else {
                document.getElementById('hdnApprovedByID').value = "0";
            }
			 document.getElementById('txtUserName').value = eventArgs.get_text();
            document.getElementById('hdnUserId').value = eventArgs.get_value();
            if (document.getElementById('hdnUserId').value != "0") {
                $find('AutoUser').set_contextKey('route' + '~' + document.getElementById('hdnUserId').value);
            }
            else {
                $find('AutoUser').set_contextKey('');
            }
			
        }
        var userMsg;
        function ShowAlertMsg(key) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            /* Added By Venkatesh S */
            var vProceedPatientLink = SListForAppMsg.Get('Reception_VisitDetails_aspx_04') == null ? "Please Proceed via Todays Patient Link" : SListForAppMsg.Get('Reception_VisitDetails_aspx_04');
            var vNewBornBaby = SListForAppMsg.Get('Reception_VisitDetails_aspx_05') == null ? "This action cannot be performed for New born baby" : SListForAppMsg.Get('Reception_VisitDetails_aspx_05');
            var vUrl = SListForAppMsg.Get('Reception_VisitDetails_aspx_06') == null ? "URL Not Found" : SListForAppMsg.Get('Reception_VisitDetails_aspx_06');
            var vMustChek = SListForAppMsg.Get('Reception_VisitDetails_aspx_07') == null ? "Munst CheckIn the Mrd File" : SListForAppMsg.Get('Reception_VisitDetails_aspx_07');
            var vVisitState = SListForAppMsg.Get('Reception_VisitDetails_aspx_08') == null ? "Visit State Already Closed" : SListForAppMsg.Get('Reception_VisitDetails_aspx_08');
            var vTaskStatus = SListForAppMsg.Get('Reception_VisitDetails_aspx_09') == null ? "Task Status Can not be Pending" : SListForAppMsg.Get('Reception_VisitDetails_aspx_09');
            var vOPVisit = SListForAppMsg.Get('Reception_VisitDetails_aspx_10') == null ? "OP Visit Closed successfully" : SListForAppMsg.Get('Reception_VisitDetails_aspx_10');
            var vOPPatient = SListForAppMsg.Get('Reception_VisitDetails_aspx_11') == null ? "Which is not OP Patient" : SListForAppMsg.Get('Reception_VisitDetails_aspx_11');
            var vCaseSheet = SListForAppMsg.Get('Reception_VisitDetails_aspx_12') == null ? "There is no CaseSheet for this Patient" : SListForAppMsg.Get('Reception_VisitDetails_aspx_12');
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlertType);
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_7") {
                ValidationWindow(vProceedPatientLink, AlertType);
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_8") {
                ValidationWindow(vNewBornBaby, AlertType);
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_9") {
                ValidationWindow(vUrl, AlertType);
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_10") {
                ValidationWindow(vMustChek, AlertType);
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_11") {
                ValidationWindow(vVisitState, AlertType);
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_12") {
                ValidationWindow(vTaskStatus, AlertType);
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_13") {
                ValidationWindow(vOPVisit, AlertType);
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_14") {
                ValidationWindow(vOPPatient, AlertType);
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_15") {
                ValidationWindow(vCaseSheet, AlertType);
                return false;
            }
            return true;
        }

        function CheckValidation_alert() {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var vMandatory = SListForAppMsg.Get('Reception_VisitDetails_aspx_13') == null ? "Please Select Any One" : SListForAppMsg.Get('Reception_VisitDetails_aspx_13');
            var vProToDate = SListForAppMsg.Get('Reception_VisitDetails_aspx_14') == null ? "Provide To date" : SListForAppMsg.Get('Reception_VisitDetails_aspx_14');
            if (document.getElementById("hdnspecdept").value == 'Y') {
                if (document.getElementById("txtPname").value == "" && document.getElementById("txtFrom").value == "" && document.getElementById("txtTo").value == "" && document.getElementById("txtPatientNumber").value == "" && document.getElementById("ddlocations").value == "0" && document.getElementById("txtSRFNumber").value == "" ) {
                    // alert(vMandatory);
                    ValidationWindow(vMandatory, AlertType);
                    return false;
                }
                var StartDate = document.getElementById('txtFrom').value;
                var EndDate = document.getElementById('txtTo').value;
                var eDate = new Date(EndDate);
                var sDate = new Date(StartDate);
                //                if (StartDate != '' && StartDate != '' && sDate > eDate) {
                //                    alert("Please ensure that the To Date is greater than or equal to the From Date.");
                //                    return false;
                //                }
                //                else {
                //                    return true;
                //                }
                if (document.getElementById('txtFrom').value != '' && document.getElementById('txtTo').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_7');
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                    }
                    else {
                        ValidationWindow(vProToDate, AlertType);
                    }
                    document.form1.txtTo.focus();
                    return false;
                }

                else {
                    return true;
                }
            }

            else {
                if (document.getElementById("txtPname").value == "" && document.getElementById("ddlDepartment").value == "0" && document.getElementById("ddlspeciality").value == "0" && document.getElementById("txtFrom").value == "" && document.getElementById("txtTo").value == "" && document.getElementById("txtPatientNumber").value == "" && document.getElementById("ddlocations").value == "0") {
                    ValidationWindow(vMandatory, AlertType);
                    return false;
                }

                else {
                    return true;
                }
            }
        }
        function isNumericss(e, Id) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 1) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
        function PrintBill(obj) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=no,height=600,width=800";
            // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
            strFeatures = strFeatures + ",left=0,top=0,";
            var PrintWindow = window.open(obj, "", strFeatures);
            PrintWindow.focus();
            PrintWindow.print();

        }
        function loaddrop(id) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            var ddlobj = document.getElementById('ddlVisitActionName');
            var HidValue = document.getElementById('hdnvisit').value;
            var MasterID = id;
            var list = HidValue.split('^');

            if (ddlobj.Count <= 0) {
                if (document.getElementById('hdnvisit').value != "") {
                    ddlobj.options.length = 0;
                    for (var count = 0; count < list.length; count++) {
                        var Rate = list[count].split('~');
                        if (MasterID == Rate[0]) {
                            // var drp = eval(document.getElementById('ddlVisitActionName'));
                            var opt = document.createElement("option");
                            document.getElementById("ddlVisitActionName").options.add(opt);
                            opt.text = Rate[2];
                            opt.value = Rate[1];

                            //drp.appendChild(opt);

                            //document.getElementById("ddlVisitActionName").Items.Add(Rate[1]);
                            //document.getElementById("ddlVisitActionName").DataTextField = Rate[2];
                            //document.getElementById("ddlVisitActionName").DataValueField = Rate[1];
                            //document.getElementById("ddlVisitActionName").options[count] = new Option(Rate[2], Rate[1]);

                            //document.getElementById("ddlVisitActionName").Items.Add(Rate[2], Rate[1]);

                        }
                    }
                }
            }

        }

        function Select_Visit(id, vid, pid, PName, vtype, vstid, vs, PNo) {

            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');


            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }

            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPNO").value = PNo;
            document.getElementById("hdnPID").value = pid;
            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("visitState").value = vstid;
            document.getElementById("visittype").value = vtype;
            document.getElementById("isCredit").value = vs; //iscredit
            if (document.getElementById('ddlType').value == "Both") {
                loaddrop(vtype);
            }
        }

        function CheckVisitID() {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            //arun - Zero should not allow in the text box to reprint barcode - fixes
            if ($('#ddlVisitActionName :selected').val() == 'Reprint_TRFBarcode_SampleSearch') {
                if (parseInt(document.getElementById("txtprintCnt").value) > 0) {
                }
                else {
                    var vReprintAlert = SListForAppMsg.Get('Reception_VisitDetails_aspx_40') == null ? "Reprint count should be greater than zero" : SListForAppMsg.Get('Reception_VisitDetails_aspx_40');
                    ValidationWindow(vReprintAlert, AlertType);
                    return false;
                }
            }
            //arun           
            var vOpPatient = SListForAppMsg.Get('Reception_VisitDetails_aspx_15') == null ? "This is OP patient. So you can not Edit" : SListForAppMsg.Get('Reception_VisitDetails_aspx_15');
            var vDischargePatient = SListForAppMsg.Get('Reception_VisitDetails_aspx_16') == null ? "This  is not a Discharged/Credit patient. So you can not Edit" : SListForAppMsg.Get('Reception_VisitDetails_aspx_16');
            var vVisitDetails = SListForAppMsg.Get('Reception_VisitDetails_aspx_17') == null ? "Select visit detail" : SListForAppMsg.Get('Reception_VisitDetails_aspx_17');
            //alert(document.getElementById('hdnVID').value);
            if (document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML == 'Edit Admission Patient Details') {


                if (document.getElementById("visitState").value == 'Discharged' && document.getElementById("isCredit").value == 'Y' && document.getElementById("visittype").value == 1) {
                    document.getElementById('hdnVisitDetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML;
                    return true;
                }
                else if (document.getElementById("visittype").value == 0) {
                    // Reception\VisitDetails.aspx_1
                    var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_1');
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                        return false;

                    }
                    else {
                        ValidationWindow(vOpPatient, AlertType);

                        return false;
                    }
                }
                else {
                    //Reception\VisitDetails.aspx_2
                    var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_2');
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                        return false;

                    }
                    else {
                        //   alert('This  is not a Discharged/Credit patient. So you can not Edit');
                        ValidationWindow(vDischargePatient, AlertType);
                        return false;
                    }
                }
            }
            if (document.getElementById('hdnVID').value == '') {
                //Reception\VisitDetails.aspx_3
                ValidationWindow(vVisitDetails, AlertType);
                return false;
            }


            else {

                document.getElementById('hdnVisitDetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML;
                //document.getElementById('hdndrpdowndetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedValue].innerTEXT;
                //destElement = document.getElementById("hdndrpdowndetail");

                //sourceElement = document.getElementById("ddlVisitActionName").options.text;

                //destElement.value = sourceElement(sourceElement.text);
                //                var e = document.getElementById("ddlVisitActionName"); // select element
                //                var strUser = e.options[e.selectedIndex].text;
                //                document.getElementById('hdndrpdowndetail').value = document.getElementById('ctl00_mainContent_ctl02_ddlVisitActionName')[document.getElementById('ctl00_mainContent_ctl02_ddlVisitActionName').selectedIndex].innerText
                //                alert(hdndrpdowndetail.value);
                //                alert(strUser);               ;

                var action = document.getElementById("ddlVisitActionName");

                var Actionname = action.options[action.selectedIndex].value;
                if (Actionname == "TRF_Upload") {
                    document.getElementById('divUpload').style.display = 'block';
                    document.getElementById('divphoto').style.display = 'none';
                }
                else if (Actionname == "Photo_Upload") {
                    document.getElementById('divUpload').style.display = 'none';
                    document.getElementById('divphoto').style.display = 'block';
                }
                else {
                    document.getElementById('divUpload').style.display = 'none';
                    document.getElementById('divphoto').style.display = 'none';
                }
                return true;


            }


        }

        function CheckVisitDate() {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            /* Added By Venkatesh S */
            var vProFromDate = SListForAppMsg.Get('Reception_VisitDetails_aspx_18') == null ? "Provide From date" : SListForAppMsg.Get('Reception_VisitDetails_aspx_18');

            if (document.getElementById('txtFrom').value == '') {
                //Reception\VisitDetails.aspx_5
                var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_6');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlertType);
                    // alert(userMsg);


                }
                else {
                    ValidationWindow(vProFromDate, AlertType);


                }
                document.form1.txtFrom.focus();
                return false;
            }

            return true;

        }
        function storevalue() {
        //changes by arun - reprint trfbarcode--
            if ($('#ddlVisitActionName :selected').val() == 'Reprint_TRFBarcode_SampleSearch') {
                document.getElementById("txtprintCnt").style.display = "inherit";
            }
            else {
                document.getElementById("txtprintCnt").style.display = "none";
            }
            //changes by arun - reprint trfbarcode
        
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var e = document.getElementById("ddlVisitActionName"); // select element
            var strUser = e.options[e.selectedIndex].text;

            document.getElementById('hdndrpdowndetail').value = strUser;
            //alert(document.getElementById('hdndrpdowndetail').value);
        }
        function PrintCaseSheet(vid, pid, vType) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            window.open("../Physician/ViewIPCaseSheet.aspx?vid=" + vid + "&pid=" + pid + "&vType=" + vType + "&IsPopup=Y&Prt=Y" + "", '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            return false;
        }
        function OpenPopUp(patientVisitID, FinalBillID, BillNumber) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            window.open("../Reception/ViewPrintPage.aspx?vid=" + patientVisitID + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + FinalBillID + "&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y", '', 'height=900,width=1000,left=0,top=30,resizable=No,scrollbars=No,toolbar=no,menubar=no,location=no,directories=no, status=No');
        }
        
    </script>

    <script type="text/javascript">


        function PrintOpCard() {
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write($('#divGenerateVisit').html());
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <div style="display: none;">
        <ul>
            <li class="dataheader">
                <asp:Label ID="lbvisitdets" runat="server" Text="Visit Details :" meta:resourcekey="lbvisitdetsResource1"></asp:Label>
                (<asp:Label ID="lblPName" runat="server" meta:resourcekey="lblPNameResource1"></asp:Label>)
            </li>
        </ul>
    </div>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div>
            <asp:UpdatePanel ID="pnl_Client" runat="server">
                <Triggers>
                    <asp:PostBackTrigger ControlID="imgBtnXL" />
                </Triggers>
                <Triggers>
                    <asp:PostBackTrigger ControlID="imgbtnxls" />
                </Triggers>
                <ContentTemplate>
                    <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <div id="progressBackgroundFilter" class="a-center">
                            </div>
                            <div id="processMessage" class="a-center w-20p">
                                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                    meta:resourcekey="img1Resource1" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <table border="0" cellpadding="0" cellspacing="0" class="searchPanel w-100p">
                        <tr>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="5" class="w-100p">
                                    <tr>
                                        <td class="defaultfontcolor">
                                            <asp:Label runat="server" ID="lblPatientNumber" Text="Patient Number" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:TextBox ID="txtPatientNumber" runat="server" CssClass="Txtboxsmall" TabIndex="1"
                                                onblur="javascript:return CearetxtDate();" meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
                                        </td>
                                        <td class="defaultfontcolor" width="7%">
                                            <asp:Label runat="server" ID="lblPatientname" Text="Patient Name" meta:resourcekey="lblPatientnameResource1"></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <asp:TextBox ID="txtPname" runat="server" TabIndex="2" CssClass="Txtboxsmall" onblur="javascript:return CearetxtDate();"
                                                meta:resourcekey="txtPnameResource1"></asp:TextBox>
                                        </td>
                                        <td class="w-10p">
                                            <asp:Label ID="lblClientname" runat="server" Text="Client Name" meta:resourcekey="lblClientnameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" Width="130px" CssClass="AutoCompletesearchBox"
                                                TabIndex="3" onblur="javascript:return CearetxtDate();"  
                                                meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                OnClientItemOver="SelectedOver" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="defaultfontcolor">
                                            <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" TabIndex="4" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                            <%--<a href="javascript:NewCssCal('txtFrom','ddmmyyyy','arrow',true,12,'','past')">
                                                <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date"></a>--%>
                                            <a href="javascript:NewCssCall('<%=txtFrom.ClientID %>','ddMMyyyy','arrow',true,12,'','N','Y')">
                                                <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                            <%--<asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                CultureTimePlaceholder="" Enabled="True" />
                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />--%>
                                        </td>
                                        <td class="defaultfontcolor">
                                            <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTo" onChange="ValidDateTime('txtFrom', 'txtTo');" runat="server"
                                                TabIndex="5" CssClass="Txtboxsmall" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                 <a href="javascript:NewCssCall('<%=txtTo.ClientID %>','ddMMyyyy','arrow',true,12,'','N','Y')">
                                                <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                            <%--<a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,12,'','past')">
                                                <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>--%>
                                            <%-- <a href="javascript:NewCssCall('<%=txtTo.ClientID %>','ddMMyyyy','arrow',true,12,'Y','N','Y')">
                                                <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>--%>
                                            <%--<asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                OnClientClick="CheckVisitDate();" CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                CultureTimePlaceholder="" Enabled="True" />
                                                            <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />--%>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lbl" Text="Doctor Name" meta:resourcekey="lblResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox"
                                                onchange="SetPhysicianID()" Width="130px" meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                FirstRowSelected="true" MinimumPrefixLength="1" ServiceMethod="GetPhysician"
                                                OnClientItemSelected="SetPhysicianID" OnClientItemOver="SelectedOverPhy" ServicePath="~/Webservice.asmx"
                                                TargetControlID="txtInternalExternalPhysician">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr id="HideSpec" runat="server">
                                        <td>
                                            <asp:Label ID="lblDepartment" runat="server" Text="Department" meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddl" meta:resourcekey="ddlDepartmentResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_Speciality" Text="Speciality" runat="server" meta:resourcekey="Rs_SpecialityResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlspeciality" runat="server" CssClass="ddl" meta:resourcekey="ddlspecialityResource1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="defaultfontcolor">
                                            <asp:Label runat="server" ID="lblVisitType" Text="Visit Type" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlType" runat="server" TabIndex="5" CssClass="ddlsmall" meta:resourcekey="ddlTypeResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblloc" Text="Location" runat="server" meta:resourcekey="lbllocResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlocations" runat="server" TabIndex="5" CssClass="ddlsmall"
                                                meta:resourcekey="ddlocationsResource1">
                                            </asp:DropDownList>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblUserName" Text="Registered User" runat="server" meta:resourcekey="lblUserNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUserName" autocomplete="off" CssClass="AutoCompletesearchBox"
                                                runat="server" Width="130px" onchange="DiscountAuthSelected()" meta:resourcekey="txtUserNameResource1" />
                                            <cc1:AutoCompleteExtender ID="AutoUser" runat="server" CompletionInterval="1" FirstRowSelected="true"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandID"
                                                ServicePath="~/WebService.asmx" TargetControlID="txtUserName" OnClientItemOver="DiscountAuthSelectedOver"
                                                OnClientItemSelected="DiscountAuthSelected">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <%--<td class="style3">
                                                            <asp:Label ID="lblHub" Text="Hub" runat="server" meta:resourcekey="Label7Resource9"></asp:Label>
                                                        </td>
                                                        <td class="style4">
                                                            <asp:TextBox ID="txtHub" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox"
                                                                Width="130px" onBlur="CheckHubName('HUB',this.id);"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                                onchange="javascript:return ClearFields('HUB');" meta:resourcekey="txtHubResource1"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" TargetControlID="txtHub"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHubDetails"
                                                                OnClientItemSelected="OnHubSelected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>--%>
                                        <td>
                                            <asp:Label ID="lblZone" Text="Zone" runat="server" meta:resourcekey="Label5Resource9"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtzone" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox"
                                                Width="130px" onBlur="CheckZoneName('Zone',this.id);" OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                               
                                                 meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                                OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td id="tdlblsrfid" runat="server" style="display:none;">
                                            <asp:Label ID="lblSRFNumber" Text="SRFID" runat="server" ></asp:Label>
                                            <asp:HiddenField ID="hdnissrfidsearch" runat="server" Value="N" />
                                        </td>
                                         <td class="w-20p" id="tdtxtsrfid" runat="server" style="display:none;">
                                            <asp:TextBox ID="txtSRFNumber" runat="server" TabIndex="2" CssClass="Txtboxsmall" onblur="javascript:return CearetxtDate();"
                                               ></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1"
                                    OnClientClick="javascript:return CheckValidation_alert();" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                    meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td>
                                <asp:Panel ID="pHeader" runat="server" CssClass="cpHeader" meta:resourcekey="pHeaderResource1">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Image ID="ImgCollapse" runat="server" meta:resourcekey="ImgCollapseResource1" />
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblText" runat="server" meta:resourcekey="lblTextResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="pBody" runat="server" CssClass="cpBody" meta:resourcekey="pBodyResource1" style="display: none;" >
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:CheckBoxList ID="ChkLstColumns" runat="server" meta:resourcekey="ChkLstColumnsResource1">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Button ID="btnUpdateFilter" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="Ok" OnClick="btnUpdateFilter_Click"
                                                    meta:resourcekey="btnUpdateFilterResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                                    CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="True" TextLabelID="lblText"
                                    CollapsedText="Show Result Customization" ExpandedText="Hide Result Customization"
                                    ImageControlID="ImgCollapse" ExpandedImage="../images/collapse.jpg" CollapsedImage="../images/expand.jpg"
                                    Enabled="True" meta:resourcekey="CollapsiblePanelExtender1Resource1">
                                </cc1:CollapsiblePanelExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <table id="PatientDetails" runat="server">
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblTotalPatient" Text="Total Patient Count:" runat="server" Style="font-weight: 400"
                                                meta:resourcekey="lblTotalPatientResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblpatientCount" runat="server" meta:resourcekey="lblpatientCountResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblPatientVisitCount" Text="PatientVisitCount:" runat="server" Style="font-weight: 400"
                                                meta:resourcekey="lblPatientVisitCountResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblPatientTotalVisitCount" runat="server" meta:resourcekey="lblPatientTotalVisitCountResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="LblPdf" Text="Registeration Checklist" runat="server" meta:resourcekey="LblPdfResource1"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="~/Images/pdf.ico" ToolTip="Save As Pdf"
                                                Style="width: 26px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                            <asp:ImageButton ID="imgbtnxls" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                ToolTip="Save As XL" OnClick="imgbtnxls_Click" meta:resourcekey="imgXLsResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                    DataKeyNames="PatientVisitID,Name" CssClass="gridView w-100p" AlternatingRowStyle-CssClass="trEven"
                                    OnRowDataBound="grdResult_RowDataBound" OnRowCommand="grdResult_RowCommand" OnPageIndexChanging="grdResult_PageIndexChanging"
                                    class="mytable1" meta:resourcekey="grdResultResource1">
                                    <%-- <PagerStyle HorizontalAlign="Center" />--%>
                                    <%-- <HeaderStyle CssClass="dataheader1" />--%>
                                    <%--  <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                PageButtonCount="5" PreviousPageText="&lt;&lt;" />--%>
                                    <Columns>
                                        <asp:BoundField DataField="PatientVisitID" Visible="false" HeaderText="PatientVisitID"
                                            meta:resourcekey="BoundFieldResource1" />
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect"
                                                    meta:resourcekey="rdSelResource1" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" HtmlEncode="False"
                                            meta:resourcekey="BoundFieldResource3" />
                                        <asp:BoundField DataField="PatientVisitId" HeaderText="Patient VisitId" Visible="false"
                                            meta:resourcekey="BoundFieldResource4" />
                                        <%--  <asp:TemplateField HeaderText="Visit Number"  SortExpression="VisitType" ItemStyle-Width="5%">
                                                            <ItemTemplate >
                                                           <asp:LinkButton ID="lnkvisitno" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color:Blue"
                                                                     />
                                                                
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Visit Number" SortExpression="VisitType" ItemStyle-Width="5%"
                                            meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <%--<asp:LinkButton ID="lnkvisitno" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                    OnClientClick='<%# String.Format("ShowPopUp(this);return false;",Eval("VisitNumber"))%> ' />--%>
                                                <asp:LinkButton ID="lnkvisitno" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                    meta:resourcekey="lnkvisitnoResource1" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        
                                        
                                        
                                        
                                        
                                         <asp:TemplateField HeaderText="Lab Number"  ItemStyle-Width="5%">
                                           
                                            <ItemTemplate>
                                                <%--<asp:LinkButton ID="lnkvisitno" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                    OnClientClick='<%# String.Format("ShowPopUp(this);return false;",Eval("VisitNumber"))%> ' />--%>
                                                <asp:LinkButton ID="lnklabno" runat="server" Text='<%#Eval("ExternalVisitID") %>' Style="color: Blue"
                                                    meta:resourcekey="lnkvisitnoResource1" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        
                                        
                                        
                                        
                                        <%--<asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" HtmlEncode="False" />--%>
                                      <%--  <asp:BoundField DataField="ExternalVisitID" HeaderText="Lab No" meta:resourcekey="lobNoResource" Visible ="false"  />--%>
                                        <asp:BoundField DataField="age" HeaderText="Age/Gender" meta:resourcekey="BoundFieldResource5" />
                                        <asp:BoundField DataField="PhoneNumber" HeaderText="Contact No" meta:resourcekey="contactNoResource" />
                                        <asp:TemplateField HeaderText="Visit Type" SortExpression="VisitType" ItemStyle-Width="5%"
                                            meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGrdVisitType" runat="server" Text='<%# Bind("VisitType") %>' meta:resourcekey="lblGrdVisitTypeResource1"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("VisitType") %>' meta:resourcekey="TextBox2Resource1"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                            HeaderText="Visit DateTime" meta:resourcekey="BoundFieldResource7" />
                                        <asp:BoundField DataField="VisitPurposeName" HeaderText="Visit Purpose" meta:resourcekey="BoundFieldResource8" />
                                        <asp:BoundField DataField="Location" HeaderText="Registered Location" HtmlEncode="False"
                                            meta:resourcekey="BoundFieldResource9" />
                                        <asp:BoundField DataField="URNO" HeaderText="URNNO" Visible="false" meta:resourcekey="BoundFieldResource10" />
                                        <asp:BoundField DataField="VisitState" HeaderText="Visit Status" meta:resourcekey="BoundFieldResource11" />
                                        <asp:BoundField DataField="wardNo" HeaderText="IsCreatedBill" meta:resourcekey="BoundFieldResource6" />
                                        <asp:TemplateField HeaderText="Investigation Details" Visible="false" meta:resourcekey="investigationDetailsResource">
                                            <ItemTemplate>
                                                <asp:GridView ID="ChildGrd" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                    ForeColor="#333333" BorderColor="ActiveCaption" PageSize="10" CssClass="mytable1"
                                                    meta:resourcekey="ChildGrdResource1" OnPageIndexChanging="ChildGrd_PageIndexChanging">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:BoundField DataField="InvestigationName" HeaderText="InvestigationList/MiscellaneousList" meta:resourcekey="BoundFieldResource12">
                                                        </asp:BoundField>
                                                        <asp:BoundField Visible="False" DataField="AccessionNumber" HeaderText="AccessionNumber"
                                                            meta:resourcekey="BoundFieldResource13" />
                                                        <asp:BoundField Visible="False" DataField="PerformingPhysicain" HeaderText="PerformingPhysicain"
                                                            meta:resourcekey="BoundFieldResource14" />
                                                        <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource15" />
                                                    </Columns>
                                                </asp:GridView>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="FinalBillID" HeaderText="FinalBillID" meta:resourcekey="BoundFieldResource11"
                                            Visible="false" />
                                        <asp:BoundField DataField="BillNumber" HeaderText="BillNumber" meta:resourcekey="BoundFieldResource12"
                                            Visible="false" />
                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourcekey="BoundFieldResource16" />
                                        <asp:BoundField DataField="ClientAddress" HeaderText="Client Address " meta:resourcekey="BoundFieldResource17" />
                                        <asp:BoundField DataField="PhysicianName" HeaderText="Ref.Dr" meta:resourcekey="BoundFieldResource18" />
                                        <asp:BoundField DataField="Zone" HeaderText="Zone" meta:resourcekey="BoundFieldResource19" />
                                        <asp:BoundField DataField="UserName" HeaderText="Registered Username" HtmlEncode="False"
                                            meta:resourcekey="BoundFieldResource20" />
                                        <asp:BoundField DataField="CollectedDatetime" HeaderText="Sample CollectionDate" DataFormatString="{0:dd/MM/yyyy HH:mm}"
                                            />
                                        <asp:TemplateField meta:resourcekey="TemplateViewBillFieldResource" HeaderText="View Details"
                                            ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LnkViewBill" ForeColor="#0000FF" CommandArgument='<%#Eval("PatientVisitId")+","+ Eval("FinalBillID")+","+Eval("BillNumber")+","+Eval("Due")%>'
                                                    runat="server" CommandName="ViewBill">
                                                    <asp:Image ID="BillImage" runat="server" ImageUrl="~/Images/BillIcon.jpg" Style="border-width: 0px;"
                                                        ToolTip="View Details" meta:resourcekey="BillImageResource1" />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ICDCodeStatus" HeaderText="Test Description" meta:resourcekey="BoundFieldResource22" />
                                        <asp:BoundField DataField="VersionNo" HeaderText="Status" meta:resourcekey="BoundFieldResource23" />
                                        <asp:BoundField DataField="Due" HeaderText="HealthCouponNo" Visible="false" meta:resourcekey="BoundFieldResource24" />
                                        <asp:BoundField DataField="EMail" HeaderText="Patient EMailID" Visible="False"  />
                                        <%--Added by Thamilselvan.R for showing SSRS Report...,"+Eval("Creditvalue")+".--%>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr id="GrdFooter" runat="server" class="dataheaderInvCtrl">
                            <td align="center" colspan="10" class="defaultfontcolor">
                                <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click"
                                    meta:resourcekey="Btn_PreviousResource1" />
                                <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click"
                                    meta:resourcekey="Btn_NextResource1" />
                                <asp:HiddenField ID="hdnCurrent" runat="server" />
                                <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxsmall" Width="30px" autocomplete="off"
                                    onkeypress="return ValidateOnlyNumeric(this);" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo1_Click"
                                    onmouseover="this.className='btn btnhov'" meta:resourcekey="btnGo1Resource1"
                                    OnClientClick="return checkForValues()" />
                                <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                                <asp:HiddenField ID="hdnvisit" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblnote" runat="server" Font-Size="X-Small" ForeColor="Red" Text="*If You have select type is both, then visit action will load after you select patient"
                                    meta:resourcekey="lblnoteResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trSelectVisit" runat="server" visible="false">
                            <td class="defaultfontcolor">
                                <asp:Label ID="Rs_Info" Text="Select a Patient and Choose one of the following" runat="server"
                                    meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                <asp:DropDownList onchange="return storevalue();" ID="ddlVisitActionName" CssClass="ddlmedium"
                                    runat="server" meta:resourcekey="ddlVisitActionNameResource1">
                                </asp:DropDownList>
								<%--changes by arun - reprint trfbarcode--%>
                                <asp:TextBox Style="display: none;" ID="txtprintCnt" runat="server"  Width="25px" MaxLength="1" Text="1"   onkeypress="return ValidateOnlyNumeric(this);"  
                               meta:resourcekey="txtprintCntResource1"></asp:TextBox>
                                
                                <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    OnClientClick="return CheckVisitID()" onmouseout="this.className='btn'" OnClick="btnGo_Click"
                                    meta:resourcekey="btnGoResource1" />
                            </td>
                        </tr>
                    </table>
                    <div>
                        <br />
                        <br />
                        <br />
                    </div>
                    <%--changes by arun - reprint trfbarcode--%>
                    <div id="iframeplaceholder">
                        <iframe runat="server" id="iframeBarcode" name="iframeBarcode" style="position: absolute;
                            top: 0px; left: 0px; width: 0px; height: 0px; border: 0px; overfow: none; z-index: -1">
                        </iframe>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div id="divUpload" runat="server" style="display: none">
                <table cellpadding="0" style="border: 0px; border-color: Red" border="0" cellspacing="0"
                    class="w-75p">
                    <tr>
                        <td>
                            <table cellpadding="0" style="border: 0px; border-color: Red" border="0" cellspacing="0"
                                class="w-100p">
                                <tr>
                                    <td colspan="4">
                                        <TRF:TRFUpload ID="TRFImageUpload" runat="server" OnClick="TRFImageUpload_Click"
                                            Rows="6" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divphoto" runat="server" style="display: none">
                <table cellpadding="0" style="border: 0px; border-color: Red" border="0" cellspacing="0"
                    class="w-70p">
                    <tr>
                        <td>
                            <table cellpadding="0" style="border: 0px; border-color: Red" border="0" cellspacing="0"
                                class="w-100p">
                                <tr>
                                    <td>
                                        <PHOTO:PhotoUpload ID="PatientPhoto" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <%--Added by Thamilselvan for showing the IFrame in Model Popup...............--%>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
            <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                CancelControlID="btnCancels" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
            <asp:Panel ID="pnlMailReports" BorderWidth="1px" Width="70%" CssClass="modalPopup dataheaderPopup"
                runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" Width="100%" Height="500px"
                    meta:resourcekey="Panel1Resource1">
                    <table width="100%">
                        <tr>
                            <td height="100%" align="center">
                                <iframe id="CouponCardBillFrame" runat="server" name="myname" style="width: 100%;
                                    height: 470px; border: 0px; overflow: auto;"></iframe>
                                <%--<input type="button" id="btnBillPrint" style='background-color: Transparent; color: white;
                                    border-style: solid; border-width: thin; border-color: White; font-size: 14px;
                                    height: 25px; width: 45px; text-align: center' value="Print" onclick="javascript:return OpenIframe1();" />--%>
                                <asp:Button ID="btnCancels" CssClass="btn" runat="server" OnClick="btn_DisableIframSRC"
                                    Text="Close" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="hidden" id="hdnFinalBillID" runat="server" />
                                <input type="hidden" id="hdnPVisitID" runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--Added by Thamilselvan for showing the IFrame in Model Popup...............--%>
    <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
    <input type="hidden" id="hdnPID" name="pid" runat="server" />
    <input type="hidden" id="hdnPNO" name="pno" runat="server" />
    <input type="hidden" id="hdnVID" name="vid" runat="server" />
    <input type="hidden" id="hdnVisitDetail" runat="server" />
    <input type="hidden" id="hdndrpdowndetail" runat="server" />
    <input type="hidden" id="visitState" runat="server" />
    <input type="hidden" id="isCredit" runat="server" />
    <input type="hidden" id="visittype" runat="server" />
    <input type="hidden" id="hdnspecdept" runat="server" />
    <input type="hidden" id="hdnPhysicianID" runat="server" value="0" />
    <input type="hidden" id="hdnHubID" runat="server" value="0" />
    <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
    <asp:HiddenField ID="hdnApprovedByID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input type="hidden" id="hdnUserId" runat="server" value="0" />
    <div style="display: none" id="divGenerateVisit">
        <asp:Xml ID="XmlOP" runat="server"></asp:Xml>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

    <script type="text/javascript" language="javascript">
        function checkForValues() {

            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            /* Added By Venkatesh S */
            var vEnterPgaeNo = SListForAppMsg.Get('Reception_VisitDetails_aspx_19') == null ? "Please Enter Page No" : SListForAppMsg.Get('Reception_VisitDetails_aspx_19');
            var vEnterCorrectPageNo = SListForAppMsg.Get('Reception_VisitDetails_aspx_20') == null ? "Please Enter Correct Page No" : SListForAppMsg.Get('Reception_VisitDetails_aspx_20');

            if (document.getElementById('txtpageNo').value == "") {
                ValidationWindow(vEnterPgaeNo, AlertType);
                document.getElementById('txtpageNo').focus();
                return false;
            }

            if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) < Number(1)) {
                ValidationWindow(vEnterCorrectPageNo, AlertType);
                document.getElementById('txtpageNo').value = "";
                document.getElementById('txtpageNo').focus();
                return false;
            }

            if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) > Number(document.getElementById('<%= lblTotal.ClientID %>').innerText)) {
                ValidationWindow(vEnterCorrectPageNo, AlertType);
                document.getElementById('txtpageNo').value = "";
                document.getElementById('txtpageNo').focus();
                return false;
            }
        }
        function SelectedOver(source, eventArgs) {

            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            /* Added By Venkatesh S */
            var vSelectFormList = SListForAppMsg.Get('Reception_VisitDetails_aspx_21') == null ? "Please select from the list" : SListForAppMsg.Get('Reception_VisitDetails_aspx_21');
            $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    ValidationWindow(vSelectFormList, AlertType);
                    document.getElementById('txtClientName').value = '';

                }
            };
        }
        function SetClientID(source, eventArgs) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');
            var ClientID = 0;
            if (eventArgs != undefined) {
                ClientID = eventArgs.get_value();
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID.split('|')[0];
            }
            else {
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID;
            }
        }
        function SelectedOverPhy(source, eventArgs) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            /* Added By Venkatesh S */
            var vSelectFormList = SListForAppMsg.Get('Reception_VisitDetails_aspx_21') == null ? "Please select from the list" : SListForAppMsg.Get('Reception_VisitDetails_aspx_21');
            $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
                $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    ValidationWindow(vSelectFormList, AlertType);
                    document.getElementById('txtInternalExternalPhysician').value = '';
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                }
            };
        }
        function SetPhysicianID(source, eventArgs) {
            AlertType = SListForAppMsg.Get('Reception_AddressBook_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reception_AddressBook_aspx_02');

            /* Added By Venkatesh S */
            var vSelectFormList = SListForAppMsg.Get('Reception_VisitDetails_aspx_21') == null ? "Please select from the list" : SListForAppMsg.Get('Reception_VisitDetails_aspx_21');

            if (eventArgs != undefined) {
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = eventArgs.get_value();
            }
            if (document.getElementById('txtInternalExternalPhysician').value == '') {
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0'
            }
            else if (document.getElementById('hdnPhysicianID') != null) {
                if (document.getElementById('<%=hdnPhysicianID.ClientID %>').value == '') {
                    ValidationWindow(vSelectFormList, AlertType);
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                    document.getElementById('txtInternalExternalPhysician').value = '';
                }
            }
        }
        function CearetxtDate() {
            // document.getElementById('txtFrom').value = '';
            //document.getElementById('txtTo').value = '';

        }
    </script>

    <%--Added by Thamilselvan R for Visit Search details showing SSRS Report...--%>
    <div id="iframeBill1">
    </div>
    </form>
</body>
</html>

 <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

