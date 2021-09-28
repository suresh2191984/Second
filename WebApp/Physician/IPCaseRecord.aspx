<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPCaseRecord.aspx.cs" Inherits="Physician_IPCaseRecord"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/OrthoEMR.ascx" TagName="OrthoEMR" TagPrefix="uc4" %>
<%--<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>--%>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/DoctorSchedule.ascx" TagName="DoctorSchedule"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="AdviceControl" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc12" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="../CommonControls/ComplaintICDCodeBP.ascx" TagName="ComplaintICDCodeBP"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Nutrition.ascx" TagName="Nutrition" TagPrefix="uc10" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Case Sheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
<script type ="text/javascript"  language ="javascript" >
var slist={Delete:'<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Delete %>',Type:'<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Type %>',Name:'<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Name %>',Prosthesis:'<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Prosthesis %>',Date:'<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Date %>',Edit:'<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Edit_4 %>',Status:'<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Status %>'};
</script>

    <script language="javascript" type="text/javascript">

        function SelectVisit(id, vid, pid, vtype) {
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(id).checked = true;
            document.getElementById("hdnpVID").value = vid;
            document.getElementById("hdnpPID").value = pid;
            document.getElementById("hdnpVType").value = vtype;
        }

        function CheckVisitID() {
            if (document.getElementById('hdnpVID').value == '') {
                //Reception\PatientVisit.aspx_1
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Select visit detail');
                }
                return false;
            }
            else {
                var vid = document.getElementById("hdnpVID").value;
                var pid = document.getElementById("hdnpPID").value;
                var vType = document.getElementById("hdnpVType").value;
                if (vType == '0')
                { vType = 'OP'; } else { vType = 'IP'; }
                vType = 'IP';
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800,left=0,top=0";
                window.open("../Physician/ViewIPCaseSheet.aspx?vid=" + vid + "&pid=" + pid + "&vType=" + vType + "&IsPopup=Y" + "", "", strFeatures);
                return false;
            }
        }

        function ShowAll() {
            var pid = document.getElementById("hdnPatientID").value;
            var vid = document.getElementById("hdnVisitID").value;
            vType = 'IP';
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=No,resizable=yes,height=600,width=800,left=0,top=0";
            window.open("../Physician/ViewConsolidateCaseSheet.aspx?vid=" + vid + "&pid=" + pid + "&vType=" + vType + "&IsPopup=Y" + "", "", strFeatures);
            return false;
        }

        function showPreviousVisitBlock() {
            if (document.getElementById('trPrevVisits1').style.display == "none") {
                document.getElementById('trPrevVisits1').style.display = "block";
            }
            else {
                document.getElementById('trPrevVisits1').style.display = "none";
            }
        }

        function CallCancelMessage(sender) {
            if (confirm("Are you sure you wish to cancel?")) {

                return true;
            }
            else {

                return false;
            }
        }
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('uctlPatientVitals_txtSBP').value;
                var ctrlDBP = document.getElementById('uctlPatientVitals_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }
        function checkForValues(bid) {
            //---------------------------------------------che
            var OnBeId = document.getElementById('hdnOnBehalfID').value;
            if (OnBeId == '1') {
                if (document.getElementById('drpPhysician').selectedIndex == '0') {
                    //Physician\IPCaseRecord.aspx_10
                    var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_10');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert("Provide 'On Behalf of'");
                    }
                    document.getElementById('drpPhysician').focus();
                    return false;
                }
                //drpPhysician
            }
            if (ValidateActualDate() == false) {
                return false;
            }
            //            if (document.getElementById('hdnHistoryItems').value.trim() == "" && document.getElementById('hdnDiagnosisItems').value.trim() == "") {

            //                alert("Please enter History / Diagnosis details.");
            //                document.getElementById('txtHistory').focus();
            //                return false;
            //            }
            if (document.getElementById('chkRTA').checked) {

                if (document.getElementById('txtRTADate').value == "") {
                    //Physician\IPCaseRecord.aspx_2
                    var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Provide event date');
                    }
                    document.getElementById('txtRTADate').focus();
                    return false;
                }
                else {
                    if (document.getElementById('txtRTALocation').value == "") {
                        var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_3');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('Provide event  location');
                        }
                        document.getElementById('txtRTALocation').focus();
                        return false;
                    }
                }
            }
            $get(bid).disabled = true;
            javascript: __doPostBack(bid, '');


        }
        function expandBox(id) {
            document.getElementById(id).rows = "5";
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1";
        }

        function showRTABlock() {
            //   document.getElementById('chkRTAInfluenceOfDrugs').checked = false;
            //            document.getElementById('txtRTADate').value = "";
            //            document.getElementById('txtRTAFIRNo').value = "";
            //            document.getElementById('txtRTALocation').value = "";
            if (document.getElementById('trRTABlock').style.display == "none") {
                document.getElementById('trRTABlock').style.display = "block";
            }
            else {
                document.getElementById('trRTABlock').style.display = "none";
            }
        }

        function showIPTreatmentPlanOthersBlock() {
            if (document.getElementById('IPTreatmentPlanOthersBlock').style.display == "none") {
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "block";
            }
            else {
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "none";
            }
        }

        function showPastMedicalHistoryBlock() {
            if (document.getElementById('trPastMedicalHistory').style.display == "none") {
                document.getElementById('trPastMedicalHistory').style.display = "block";
            }
            else {
                document.getElementById('trPastMedicalHistory').style.display = "none";
            }
        }
        function showSwollenLymphNodes() {
            if (document.getElementById('trSwollenLymphNodes').style.display == "none") {
                document.getElementById('trSwollenLymphNodes').style.display = "block";
            }
            else {
                document.getElementById('trSwollenLymphNodes').style.display = "none";
            }
        }
        function showInvestigationCtrlintaskbased() {
            if (document.getElementById('hdnInvestigationtaskstastusID').value == "0"
        || document.getElementById('hdnInvestigationtaskstastusID').value == "1") {
                return true;
            }
            else if (document.getElementById('hdnInvestigationtaskstastusID').value == "2") {
            //Physician\IPCaseRecord.aspx_11
            var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_11');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert("The ordered investigation part cannot be altered as the task in lab is already finsh.Go to Make Visit.");
            }
                return false;
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_12');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("The ordered investigation part cannot be altered as the task in lab is already picked.");
                }
                return false;
            }
        }
        function showInvestigationCtrl1() {
            document.getElementById('tabInvCtrlBlock').style.display = "none";
            document.getElementById('tblTreatmentplan').style.display = "none";
            document.getElementById('tabPageBlock').style.display = "block";
            document.getElementById('submitTab').style.display = "block";
            document.getElementById('tbldiagnosis1').style.display = "block";
            document.getElementById('tblCICD').style.display = "block";
            document.getElementById('tblOrtho').style.display = "block";
            document.getElementById('submitTab1').style.display = "block";
            document.getElementById('tbldiagnosis1')
            document.getElementById('Grdplus').style.display = "block"; 
            return false;
        }
        function showInvestigationCtrl() {
            SetValues();
            var TTId = showInvestigationCtrlintaskbased();
            if (TTId == true) {
                if (document.getElementById('tabInvCtrlBlock').style.display == "none") {
                    document.getElementById('tabInvCtrlBlock').style.display = "block";
                    document.getElementById('tabPageBlock').style.display = "none";
                    document.getElementById('submitTab').style.display = "none";
                    document.getElementById('tblTreatmentplan').style.display = "none";
                    document.getElementById('tbldiagnosis1').style.display = "none";
                    document.getElementById('tblCICD').style.display = "none";
                    document.getElementById('tblOrtho').style.display = "none";
                    document.getElementById('submitTab1').style.display = "none";
                    document.getElementById('tbldiagnosis1')
                    document.getElementById('tbMainProc').style.display = "none";  
                }
                else {
                    document.getElementById('tabInvCtrlBlock').style.display = "none";
                    document.getElementById('tabPageBlock').style.display = "block";
                    document.getElementById('submitTab').style.display = "block";
                    document.getElementById('submitTab1').style.display = "block";
                    if (document.getElementById('hdnIscorprateorg').value == "Y") {
                        document.getElementById('tblTreatmentplan').style.display = "none";
                        document.getElementById('tbMainProc').style.display = "block"; 
                    }
                    else {
                        document.getElementById('tblTreatmentplan').style.display = "block";
                        document.getElementById('tbMainProc').style.display = "none"; 
                    }
                    document.getElementById('tbldiagnosis1').style.display = "block";
                    document.getElementById('tblCICD').style.display = "block";
                    document.getElementById('tblOrtho').style.display = "block";

                    //                LoadOrdItems1();
                }
                return false;
            }
        }



        function showMusculoskeletalCtrl() {
            if (document.getElementById('trOrtho').style.display == "none") {
                document.getElementById('trOrtho').style.display = "block";
            }
            else {
                document.getElementById('trOrtho').style.display = "none";
            }
            return false;
        }



        function onClickAddHistory() {
            var rwNumber = parseInt(110);
            var AddStatus = 0;
            var txtHistoryValue = document.getElementById('txtHistory').value.trim();
            var txtHistoryDuration = document.getElementById('txtHistoryDuration').value.trim();
            var txtHistoryDurationType = document.getElementById('ddlHistoryDuration').value;
            if (txtHistoryValue == '') {
                //Physician\IPCaseRecord.aspx_13
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_13');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Enter History");
                }
                document.getElementById('txtHistory').focus();  
                return false;
            }
            if (txtHistoryDuration == '') {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_14');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Enter Duration");
                }
                document.getElementById('txtHistoryDuration').focus(); 
                return false;
            }
            if (txtHistoryDurationType == '') {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_15');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select Duration Type");
                }  
                return false;
            }
            if (document.getElementById('ddlHistoryDuration').value == '0') {
                alert("Select Duration Type");
                document.getElementById('ddlHistoryDuration').focus();
                return false;
            }
            document.getElementById('tblHistoryItems').style.display = 'block';
            var HidValue = document.getElementById('hdnHistoryItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnHistoryItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HistoryList = list[count].split('~');
                    if (HistoryList[1] != '') {
                        if (HistoryList[0] != '') {
                            rwNumber = parseInt(parseInt(HistoryList[0]) + parseInt(1));
                        }
                        if (txtHistoryValue != '') {
                            if (HistoryList[1] == txtHistoryValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (txtHistoryValue != '') {
                    var row = document.getElementById('tblHistoryItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHistory(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtHistoryValue;
                    cell3.innerHTML = txtHistoryDuration;
                    cell4.innerHTML = txtHistoryDurationType;
                    cell5.innerHTML = "<input onclick='btnEditHis_OnClick(name);' name='" + parseInt(rwNumber) + "~" + txtHistoryValue + "~" + txtHistoryDuration + "~" + txtHistoryDurationType + "'  value = '<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Edit_1 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('hdnHistoryItems').value += parseInt(rwNumber) + "~" + txtHistoryValue + "~" + txtHistoryDuration + "~" + txtHistoryDurationType + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtHistoryValue != '') {
                    var row = document.getElementById('tblHistoryItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHistory(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtHistoryValue;
                    cell3.innerHTML = txtHistoryDuration;
                    cell4.innerHTML = txtHistoryDurationType;
                    cell5.innerHTML = "<input onclick='btnEditHis_OnClick(name);' name='" + parseInt(rwNumber) + "~" + txtHistoryValue + "~" + txtHistoryDuration + "~" + txtHistoryDurationType + "'  value = '<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Edit_2 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('hdnHistoryItems').value += parseInt(rwNumber) + "~" + txtHistoryValue + "~" + txtHistoryDuration + "~" + txtHistoryDurationType + "^";
                }
            }
            else if (AddStatus == 1) {
            //Physician\IPCaseRecord.aspx_4
            var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_4');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('History already added');
            }
            }
            document.getElementById('txtHistory').value = '';
            document.getElementById('txtHistoryDuration').value = '';
            return false;
        }

        function ImgOnclickHistory(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnHistoryItems').value;
            var list = HidValue.split('^');
            var newHistoryList = '';
            if (document.getElementById('hdnHistoryItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HistoryList = list[count].split('~');
                    if (HistoryList[0] != '') {
                        if (HistoryList[0] != ImgID) {
                            newHistoryList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnHistoryItems').value = newHistoryList;
            }
            if (document.getElementById('hdnHistoryItems').value == '') {
                document.getElementById('tblHistoryItems').style.display = 'none';
            }
        }



        function btnEditHis_OnClick(sEditedData) {


            var arrayAlreadyPresentDatas = new Array();
            var iAlreadyPresent = 0;
            var iCount = 0;
            var tempDatas = document.getElementById('hdnHistoryItems').value;

            arrayAlreadyPresentDatas = tempDatas.split('^');
            if (arrayAlreadyPresentDatas.length > 0) {
                for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {

                    if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase()) {
                        arrayAlreadyPresentDatas[iCount] = "";

                    }
                }
            }


            tempDatas = "";
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount] != "") {
                    tempDatas += arrayAlreadyPresentDatas[iCount] + "^";

                }
            }

            var arrayGotValue = new Array();

            arrayGotValue = sEditedData.split('~');


            if (arrayGotValue.length > 0) {

                document.getElementById('txtHistory').value = arrayGotValue[1];
                document.getElementById('txtHistoryDuration').value = arrayGotValue[2];
                document.getElementById('ddlHistoryDuration').value = arrayGotValue[3];

            }

            document.getElementById('hdnHistoryItems').value = tempDatas;
            LoadHistoryItems();




        }



        function LoadHistoryItems() {
            var HidValue = document.getElementById('hdnHistoryItems').value;

            var list = HidValue.split('^');

            while (count = document.getElementById('tblHistoryItems').rows.length) {

                for (var j = 0; j < document.getElementById('tblHistoryItems').rows.length; j++) {
                    document.getElementById('tblHistoryItems').deleteRow(j);

                }
            }
            if (document.getElementById('hdnHistoryItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var HistoryList = list[count].split('~');
                    var row = document.getElementById('tblHistoryItems').insertRow(0);
                    row.id = HistoryList[0];
                    var rwNumber = HistoryList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickHistory(" + parseInt(HistoryList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HistoryList[1];
                    cell3.innerHTML = HistoryList[2];
                    cell4.innerHTML = HistoryList[3];
                    cell5.innerHTML = "<input onclick='btnEditHis_OnClick(name);' name='" + parseInt(rwNumber) + "~" + HistoryList[1] + "~" + HistoryList[2] + "~" + HistoryList[3] + "'  value = '<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Edit_3 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                }
            }
        }


        function onClickAddDiagnosis() {
            var rwNumber = parseInt(220);
            var AddStatus = 0;
            var txtDiagnosisValue = document.getElementById('txtDiagnosis').value.trim();
            document.getElementById('tblDiagnosisItems').style.display = 'block';
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnDiagnosisItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[1] != '') {
                        if (DiagnosisList[0] != '') {
                            rwNumber = parseInt(parseInt(DiagnosisList[0]) + parseInt(1));
                        }
                        if (txtDiagnosisValue != '') {
                            if (DiagnosisList[1] == txtDiagnosisValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (txtDiagnosisValue != '') {
                    var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtDiagnosisValue;
                    document.getElementById('hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + txtDiagnosisValue + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtDiagnosisValue != '') {
                    var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtDiagnosisValue;
                    document.getElementById('hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + txtDiagnosisValue + "^";
                }
            }
            else if (AddStatus == 1) {
            //Physician\IPCaseRecord.aspx_5
            var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_5');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Diagnosis already added');
            }
            }
            document.getElementById('txtDiagnosis').value = '';
            return false;
        }

        function ImgOnclickDiagnosis(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            var newDiagnosisList = '';
            if (document.getElementById('hdnDiagnosisItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[0] != '') {
                        if (DiagnosisList[0] != ImgID) {
                            newDiagnosisList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnDiagnosisItems').value = newDiagnosisList;
            }
            if (document.getElementById('hdnDiagnosisItems').value == '') {
                document.getElementById('tblDiagnosisItems').style.display = 'none';
            }
        }

        function LoadDiagnosisItems() {
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnDiagnosisItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var DiagnosisList = list[count].split('~');
                    var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                    row.id = DiagnosisList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(DiagnosisList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = DiagnosisList[1];
                }
            }
        }


        //Newly Added Probable Treatmet Date By Sami
        //        function showIPTreatmentPlanDateBlock() {
        //            if (document.getElementById('IPTreatmentPlanDateBlock').style.display == "none") {
        //                document.getElementById('IPTreatmentPlanDateBlock').style.display = "block";
        //            }
        //            else {
        //                document.getElementById('IPTreatmentPlanDateBlock').style.display = "none";
        //            }
        //        }
        //End Probable Treatmet Date



        function onClickAddIPTreatmentPlan() {

            var rowNumber = 1;
            var AddStatus = 0;

            var masterID = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].value;
            var masterText = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].text;

            var childID = "0";
            var childText = "";

            var status = "Planned";
            var TreatmentDate;


            //Newly Added
            //            var TreatmentDate = "Will be scheduled later";



            var rowSplitter = "";
            var colSplitter = "";
            var prosthesisSplitter = "";

            var obj = document.getElementById("ddlIPTreatmentPlanMaster").id;
            var obj1 = document.getElementById("ddlIPTreatmentPlanChild").id;

            var prosthesis = document.getElementById("txtIPTreatmentPlanProsthesis").value;

            if (masterText == "Medical") {

                childID = "0";
                childText = document.getElementById('txtIPTreatmentPlanOthers').value;
            }
            else {

                childText = document.getElementById("ddlIPTreatmentPlanChild").options[document.getElementById("ddlIPTreatmentPlanChild").selectedIndex].text;
                if (childText == "Others") {
                    childID = "0";
                    childText = document.getElementById('txtIPTreatmentPlanOthersChild').value;
                }
                else {
                    childID = document.getElementById("ddlIPTreatmentPlanChild").options[document.getElementById("ddlIPTreatmentPlanChild").selectedIndex].value
                    childText = document.getElementById("ddlIPTreatmentPlanChild").options[document.getElementById("ddlIPTreatmentPlanChild").selectedIndex].text;
                }
            }


            if (document.getElementById('txtIPTreatmentPlanDate').value == "") {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_19');
                if (userMsg != null) {
                    TreatmentDate = userMsg;
                }
                else {

                    TreatmentDate = "Will be scheduled later";
                }
            }
            else {
                TreatmentDate = document.getElementById('txtIPTreatmentPlanDate').value
            }

            document.getElementById('tblIPTreatmentPlanItems').style.display = 'block';
            var HidValue = document.getElementById('hdnIPTreatmentPlanItems').value;

            if (HidValue == "") {
                //                HidValue = rowNumber + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + TreatmentDate + "^";

                HidValue = rowNumber + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + TreatmentDate + "~" + status + "^"
                document.getElementById('hdnIPTreatmentPlanItems').value = HidValue;

                //return;
            }
            else {
                var colCount = 0;
                var prosthesisCount = 0;
                var blnChildExists = false;
                var blnProsthesisExists = false;
                var tempRow = "";
                var newChild = "";

                rowSplitter = HidValue.split('^');
                //loop through every row
                for (var i = 0; i < rowSplitter.length - 1; i++) {
                    colSplitter = rowSplitter[i].split('~');
                    rowNumber = i + 1
                    if (colSplitter[4] == childText) {
                        blnChildExists = true;
                        prosthesisSplitter = colSplitter[5].split(',');
                        for (k = 0; k <= prosthesisSplitter.length - 1; k++) {
                            if (prosthesisSplitter[k] == prosthesis)
                                blnProsthesisExists = true;

                        }
                        if (!blnProsthesisExists) {
                            for (k = 0; k <= prosthesisSplitter.length - 1; k++) {
                                prosthesis = prosthesis + "," + prosthesisSplitter[k];
                            }
                            colSplitter[5] = prosthesis;
                        }

                        //Check For prosthesis
                        if (blnProsthesisExists) {
                            //Physician\IPCaseRecord.aspx_6
                            var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_6');
                            if (userMsg != null) {
                                alert(userMsg);
                            }
                            else {
                                alert('Prosthesis already exist');
                            }
                        }
                    }


                    //                    rowSplitter[i] = rowNumber + "~" + colSplitter[1] + "~" + colSplitter[2] + "~" + colSplitter[3] + "~" + colSplitter[4] + "~" + colSplitter[5] + "~" + colSplitter[6] + "^";
                    rowSplitter[i] = rowNumber + "~" + colSplitter[1] + "~" + colSplitter[2] + "~" + colSplitter[3] + "~" + colSplitter[4] + "~" + colSplitter[5] + "~" + colSplitter[6] + "~" + colSplitter[7] + "^";
                    tempRow = tempRow + rowSplitter[i];
                }

                if (!blnChildExists) {
                    if (childText != "") {
                        //                    newChild = rowNumber + 1 + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + TreatmentDate + "^";
                        newChild = rowNumber + 1 + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + TreatmentDate + "~" + status + "^";
                    }
                }

                HidValue = tempRow + newChild;
                document.getElementById('hdnIPTreatmentPlanItems').value = HidValue;


                //return;
            }

            LoadIPTreatmentPlanItems();

            document.getElementById("txtIPTreatmentPlanProsthesis").value = "";

            if (masterText == "Medical") {

                document.getElementById('txtIPTreatmentPlanOthers').value = "";
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "none";
                document.getElementById('ddlIPTreatmentPlanMaster').value = 1;

                showIPTreatmentPlanChild(document.getElementById('ddlIPTreatmentPlanMaster').value);
            }
            if (childID == 0) {

                document.getElementById('txtIPTreatmentPlanOthersChild').value = "";
                //                document.getElementById('IPTreatmentPlanOthersChild').style.display = "none";

            }


            //            if (document.getElementById('chkIPTreatmentPlanDate').checked) {
            //                document.getElementById('chkIPTreatmentPlanDate').checked = false;
            //                document.getElementById('txtIPTreatmentPlanDate').value = "";
            ////                document.getElementById('IPTreatmentPlanDateBlock').style.display = "none";
            //            }
            document.getElementById('txtIPTreatmentPlanDate').value = "";
            return false;
        }



        function LoadIPTreatmentPlanItems() {
            var HidValue = document.getElementById('hdnIPTreatmentPlanItems').value;
            var count = 0;
            var list = HidValue.split('^');

            var masterID;
            var masterText;
            var childID;
            var childText;
            var rwNumber;
            var prosthesis;
            var TreatmentDate;
            var status;

            while (count = document.getElementById('tblIPTreatmentPlanItems').rows.length) {

                for (var j = 0; j < document.getElementById('tblIPTreatmentPlanItems').rows.length; j++) {
                    document.getElementById('tblIPTreatmentPlanItems').deleteRow(j);

                }
            }



            if (document.getElementById('hdnIPTreatmentPlanItems').value != "") {

                var row = document.getElementById('tblIPTreatmentPlanItems').insertRow(0);

                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var Cell6 = row.insertCell(5);
                var Cell7 = row.insertCell(6);
                var Cell8 = row.insertCell(7);
                cell1.innerHTML = slist.Delete;
                cell1.width = "6%";
                cell2.innerHTML = 0;
                cell3.innerHTML = 0;
                cell2.style.display = "none";
                cell3.style.display = "none";
                cell4.innerHTML =slist.Type;
                cell5.innerHTML =slist.Name;
                Cell6.innerHTML =slist.Prosthesis;
                Cell7.innerHTML = slist.Date;
                Cell8.innerHTML = slist.Edit;
            }



            if (document.getElementById('hdnIPTreatmentPlanItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {

                    var IPTreatmentPlanList = list[count].split('~');

                    rwNumber = IPTreatmentPlanList[0];
                    masterID = IPTreatmentPlanList[1];
                    childID = IPTreatmentPlanList[2];
                    masterText = IPTreatmentPlanList[3];
                    childText = IPTreatmentPlanList[4];
                    prosthesis = IPTreatmentPlanList[5];
                    TreatmentDate = IPTreatmentPlanList[6];
                    status = IPTreatmentPlanList[7];

                    if (status == "") {

                        status = "Planned";
                    }

                    var row = document.getElementById('tblIPTreatmentPlanItems').insertRow(1);
                    row.id = IPTreatmentPlanList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var Cell6 = row.insertCell(5);
                    var Cell7 = row.insertCell(6);
                    var Cell8 = row.insertCell(7);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickIPTreatmentPlan(" + parseInt(IPTreatmentPlanList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = IPTreatmentPlanList[1];
                    cell3.innerHTML = IPTreatmentPlanList[2];
                    cell2.style.display = "none";
                    cell3.style.display = "none";
                    cell4.innerHTML = IPTreatmentPlanList[3];
                    cell5.innerHTML = IPTreatmentPlanList[4];
                    Cell6.innerHTML = IPTreatmentPlanList[5];
                    Cell7.innerHTML = IPTreatmentPlanList[6];
                    Cell8.innerHTML = "<input onclick='javascript:btnEditOnClick(this.id);' id='" + parseInt(rwNumber) + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + TreatmentDate + "~" + status + "'  value = '<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Edit_4 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";

                }
            }
        }

        function ImgOnclickIPTreatmentPlan(ImgID) {


            document.getElementById(ImgID).style.display = "none";


            var HidValue = document.getElementById('hdnIPTreatmentPlanItems').value;
            var list = HidValue.split('^');
            var newIPTreatmentPlanList = '';
            if (document.getElementById('hdnIPTreatmentPlanItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var IPTreatmentPlanList = list[count].split('~');
                    if (IPTreatmentPlanList[0] != '') {
                        if (IPTreatmentPlanList[0] != ImgID) {
                            newIPTreatmentPlanList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnIPTreatmentPlanItems').value = newIPTreatmentPlanList;
            }
            if (document.getElementById('hdnIPTreatmentPlanItems').value == '') {
                document.getElementById('tblIPTreatmentPlanItems').style.display = 'none';
            }
        }
        //Edit IP TreatMentplanItems
        function btnEditOnClick(sEditedData) {


            var arrayAlreadyPresentDatas = new Array();
            var iAlreadyPresent = 0;
            var iCount = 0;
            var tempDatas = document.getElementById('hdnIPTreatmentPlanItems').value;
            arrayAlreadyPresentDatas = tempDatas.split('^');

            if (arrayAlreadyPresentDatas.length > 0) {
                for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {


                    if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase()) {
                        arrayAlreadyPresentDatas[iCount] = "";
                    }
                }
            }


            tempDatas = "";
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount] != "") {
                    tempDatas += arrayAlreadyPresentDatas[iCount] + "^";
                }
            }

            var arrayGotValue = new Array();

            arrayGotValue = sEditedData.split('~');
            if (arrayGotValue.length > 0) {


                showIPTreatmentPlanChild(arrayGotValue[1]);

                if (arrayGotValue[1] == 0) {

                    //                    document.getElementById('chkIPTreatmentPlanOthers').checked = true;
                    document.getElementById('IPTreatmentPlanOthersBlock').style.display = "block";
                    document.getElementById('IPTreatmentPlanOthersChild').style.display = "none";
                    document.getElementById('ddlIPTreatmentPlanMaster').value = arrayGotValue[1];
                    document.getElementById('txtIPTreatmentPlanOthers').value = arrayGotValue[4];
                    document.getElementById('txtIPTreatmentPlanProsthesis').value = arrayGotValue[5];
                }
                else {
                    if (arrayGotValue[2] == 0) {

                        showIPTreatmentPlanChild(arrayGotValue[1]);
                        document.getElementById('IPTreatmentPlanOthersChild').style.display = "block";
                        document.getElementById('IPTreatmentPlanOthersBlock').style.display = "none";
                        document.getElementById('ddlIPTreatmentPlanMaster').value = arrayGotValue[1];
                        document.getElementById('ddlIPTreatmentPlanChild').value = arrayGotValue[2];
                        document.getElementById('txtIPTreatmentPlanOthersChild').value = arrayGotValue[4];
                        document.getElementById('txtIPTreatmentPlanProsthesis').value = arrayGotValue[5];


                    }
                    else {


                        showIPTreatmentPlanChild(arrayGotValue[1]);

                        document.getElementById('txtIPTreatmentPlanOthers').value = "";
                        document.getElementById('txtIPTreatmentPlanOthersChild').value = "";
                        document.getElementById('IPTreatmentPlanOthersBlock').style.display = "none";
                        document.getElementById('IPTreatmentPlanOthersChild').style.display = "none";
                        document.getElementById('ddlIPTreatmentPlanMaster').value = arrayGotValue[1];
                        document.getElementById('ddlIPTreatmentPlanChild').value = arrayGotValue[2];
                        document.getElementById('txtIPTreatmentPlanProsthesis').value = arrayGotValue[5];

                    }
                }
                //                document.getElementById('chkIPTreatmentPlanDate').checked = true;
                //                document.getElementById('IPTreatmentPlanDateBlock').style.display = "block";
                document.getElementById('txtIPTreatmentPlanDate').value = arrayGotValue[6];

            }

            document.getElementById('hdnIPTreatmentPlanItems').value = tempDatas;
            LoadIPTreatmentPlanItems()

        }

        function showIPTreatmentPlanOthersChildBlock(SelectedChildID) {

            if (SelectedChildID == 0) {

                document.getElementById('IPTreatmentPlanOthersChild').style.display = "block";
            }

            else {
                document.getElementById('IPTreatmentPlanOthersChild').style.display = "none";
            }
        }


        //Bind IPTreatmentPlanChild in DropDown


        function showIPTreatmentPlanChild(SelectedMasterID) {


            //            var masterIDOther = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].value;
            //            var MasterTextOther = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].text;

            if (SelectedMasterID == 0) {

                document.getElementById('txtIPTreatmentPlanOthers').value = "";
                document.getElementById('tdIPTreatmentPlanChild').style.display = "none";

                document.getElementById('td1').style.display = "block";
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "block";
                document.getElementById('IPTreatmentPlanOthersChild').style.display = "none";
                document.getElementById("ddlIPTreatmentPlanChild").options.length = 0;
            }
            else {

                document.getElementById('tdIPTreatmentPlanChild').style.display = "block";

                document.getElementById('td1').style.display = "none";
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "none";
                document.getElementById('IPTreatmentPlanOthersChild').style.display = "none";
                var HidValue = document.getElementById('hdnIPTreatmentPlanChild').value;
                var MasterID = SelectedMasterID;


                var list = HidValue.split('^');
                var ddlTreatmentPlanChild = document.getElementById("ddlIPTreatmentPlanChild");
                ddlTreatmentPlanChild.options.length = 0;
                if (document.getElementById('hdnIPTreatmentPlanChild').value != "") {


                    for (var count = 0; count < list.length; count++) {

                        var IPTreatmentPlanChild = list[count].split('~');

                        if (MasterID == IPTreatmentPlanChild[2]) {

                            var opt = document.createElement("option");
                            document.getElementById("ddlIPTreatmentPlanChild").options.add(opt);
                            opt.text = IPTreatmentPlanChild[1];
                            opt.value = IPTreatmentPlanChild[0];

                        }
                    }

                }
            }
        }



        //        function LoadOrdItems1() {



        //            var rowCount = document.getElementById('tblOrederedInvesTemp').rows.length;

        //            for (var i = 0; i < rowCount; i++) {
        //                var row = document.getElementById('tblOrederedInvesTemp').rows[i];

        //                document.getElementById('tblOrederedInvesTemp').deleteRow(i);
        //                rowCount--;
        //                i--;

        //            }


        //            var HidValue = document.getElementById('InvestigationControl1_iconHid').value;
        //            var list = HidValue.split('^');
        //            if (document.getElementById('InvestigationControl1_iconHid').value != "") {

        //                for (var count = 0; count < list.length - 1; count++) {
        //                    var InvesList = list[count].split('~');
        //                    var row = document.getElementById('tblOrederedInvesTemp').insertRow(0);
        //                    row.id = parseInt(InvesList[0]) + parseInt(1);
        //                    var cell1 = row.insertCell(0);
        //                    var cell2 = row.insertCell(1);
        //                    var cell3 = row.insertCell(2);
        //                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + parseInt(InvesList[0]) + parseInt(1) + ");' src='../Images/Delete.jpg' />";
        //                    cell1.width = "5%";
        //                    cell2.innerHTML = InvesList[1];
        //                    cell3.innerHTML = InvesList[2];
        //                    cell3.style.display = "none";
        //                    cell1.style.display = "none";
        //                }
        //            }
        //            return false;
        //        }

        //Performed Ip TreatMent plan

        function LoadPerformedIPTreatmentPlanItems() {
            var HidValue = document.getElementById('hdnPerformedTreatment').value;
            var count = 0;
            var list = HidValue.split('^');


            var masterText;
            var childText;
            var prosthesis;
            var status;

            while (count = document.getElementById('tblPerformedTreatment').rows.length) {

                for (var j = 0; j < document.getElementById('tblPerformedTreatment').rows.length; j++) {
                    document.getElementById('tblPerformedTreatment').deleteRow(j);

                }
            }
            if (document.getElementById('hdnPerformedTreatment').value != "") {

                var row = document.getElementById('tblPerformedTreatment').insertRow(0);

                var cell1 = row.insertCell(0);

                cell1.innerHTML = "Performed Surgery / Procedure";


            }
            if (document.getElementById('hdnPerformedTreatment').value != "") {

                var row = document.getElementById('tblPerformedTreatment').insertRow(1);


                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var Cell3 = row.insertCell(2);
                var Cell4 = row.insertCell(3);


                cell1.innerHTML =slist.Type;  
                cell2.innerHTML =slist.Name; 
                Cell3.innerHTML =slist.Prosthesis; 
                Cell4.innerHTML =slist.Status;


            }

            if (document.getElementById('hdnPerformedTreatment').value != "") {

                for (var count = 0; count < list.length - 1; count++) {

                    var IPTreatmentPlanList = list[count].split('~');


                    masterText = IPTreatmentPlanList[0];
                    childText = IPTreatmentPlanList[1];
                    prosthesis = IPTreatmentPlanList[2];
                    status = IPTreatmentPlanList[3];
                    if (status == "") {

                        status = "Planned";
                    }
                    var row = document.getElementById('tblPerformedTreatment').insertRow(2);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var Cell3 = row.insertCell(2);
                    var Cell4 = row.insertCell(3);

                    cell1.innerHTML = IPTreatmentPlanList[0];
                    cell2.innerHTML = IPTreatmentPlanList[1];
                    Cell3.innerHTML = IPTreatmentPlanList[2];
                    Cell4.innerHTML = IPTreatmentPlanList[3];

                }
            }
        }


        //Other Backround problem



        function onClickOtherBackroundProblems() {
            var rwNumber = parseInt(500);
            var AddStatus = 0;
            var txtOBP = document.getElementById('txtOBP').value.trim();
            var txtDES = document.getElementById('txtDES').value.trim();

            if (document.getElementById('txtOBP').value == "") {
                //Physician\IPCaseRecord.aspx_7
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Provide other backround problem');
                }
                return false;
            }


            document.getElementById('tblOBP').style.display = 'block';
            var HidValue = document.getElementById('hdnOBP').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnOBP').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var OBPList = list[count].split('~');
                    if (OBPList[1] != '') {
                        if (OBPList[0] != '') {
                            rwNumber = parseInt(parseInt(OBPList[0]) + parseInt(1));
                        }
                        if (txtOBP != '') {
                            if (OBPList[1] == txtOBP) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (txtOBP != '') {
                    var row = document.getElementById('tblOBP').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtOBP;
                    cell3.innerHTML = txtDES;
                    document.getElementById('hdnOBP').value += parseInt(rwNumber) + "~" + txtOBP + "~" + txtDES + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtOBP != '') {
                    var row = document.getElementById('tblOBP').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOBP(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtOBP;
                    cell3.innerHTML = txtDES;
                    document.getElementById('hdnOBP').value += parseInt(rwNumber) + "~" + txtOBP + "~" + txtDES + "^";
                }
            }
            else if (AddStatus == 1) {

            var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_8');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Other backround problem already added');
            }
            }
            document.getElementById('txtOBP').value = '';
            document.getElementById('txtDES').value = '';
            return false;

        }

        function ImgOnclickOBP(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnOBP').value;
            var list = HidValue.split('^');
            var newOBPList = '';
            if (document.getElementById('hdnOBP').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var OBPList = list[count].split('~');
                    if (OBPList[0] != '') {
                        if (OBPList[0] != ImgID) {
                            newOBPList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnOBP').value = newOBPList;
            }
            if (document.getElementById('hdnOBP').value == '') {
                document.getElementById('tblOBP').style.display = 'none';
            }
        }

        function LoadOtherBackroundproblem() {
            var HidValue = document.getElementById('hdnOBP').value;

            var list = HidValue.split('^');
            if (document.getElementById('hdnOBP').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var OBPList = list[count].split('~');
                    var row = document.getElementById('tblOBP').insertRow(0);
                    row.id = OBPList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOBP(" + OBPList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = OBPList[1];
                    cell3.innerHTML = OBPList[2];
                }
            }
        }

        function setActualDay() {

            var dtToday = new Date();
            if (document.getElementById('ddlDMY').value == 'Day(s)') {
                dtToday.setDate(dtToday.getDate() + parseInt(document.getElementById('ddlNos').value));
                document.getElementById('txtActualDate').value = dtToday.getDate() + '/' + (dtToday.getMonth() + 1) + '/' + dtToday.getFullYear();
            }
            else if (document.getElementById('ddlDMY').value == 'Week(s)') {
                dtToday.setDate(dtToday.getDate() + parseInt(document.getElementById('ddlNos').value) * 7);
                document.getElementById('txtActualDate').value = dtToday.getDate() + '/' + (dtToday.getMonth() + 1) + '/' + dtToday.getFullYear();
            }
            else if (document.getElementById('ddlDMY').value == 'Month(s)') {
                dtToday.setMonth(dtToday.getMonth() + parseInt(document.getElementById('ddlNos').value));
                strMonth = parseInt(dtToday.getMonth()) + 1;
                document.getElementById('txtActualDate').value = dtToday.getDate() + '/' + (dtToday.getMonth() + 1) + '/' + dtToday.getFullYear();
            }
            if (document.getElementById('ddlDMY').value == 'Year(s)') {
                dtToday.setFullYear(dtToday.getFullYear() + parseInt(document.getElementById('ddlNos').value));
                document.getElementById('txtActualDate').value = dtToday.getDate() + '/' + (dtToday.getMonth() + 1) + '/' + dtToday.getFullYear();
            }
            ValidateNextRwDay();
        }

        function ValidateNextRwDay() {

            document.getElementById('lblDay').innerHTML = '';
            //                        ValidateActualDate();
            if (ValidateActualDate() == false) {
                return false;
            }
            var strDate = document.getElementById('txtActualDate').value;
            strSplit = strDate.split('/');
            strDate = strSplit[1] + '/' + strSplit[0] + '/' + strSplit[2];
            strDate = new Date(eval('"' + strDate + '"'));
            var intDay = strDate.getDay();
            var strDay = '';
            switch (intDay) {
                case (0):
                    strDay = "Sunday";
                    break;
                case (1):
                    strDay = "Monday";
                    break;
                case (2):
                    strDay = "Tuesday";
                    break;
                case (3):
                    strDay = "Wednesday";
                    break;
                case (4):
                    strDay = "Thursday";
                    break;
                case (5):
                    strDay = "Friday";
                    break;
                case (6):
                    strDay = "Saturday";
                    break;
            }
            if (strDay != '') {
                document.getElementById('lblDay').innerHTML = '(' + strDay + ')';
            }
            else {
                document.getElementById('lblDay').innerHTML = '';
            }
        }

        function ValidateActualDate() {

            var sArr = document.getElementById('txtActualDate').value.split("/");
            if (sArr[0] == '' || parseInt(sArr[0], 10) < 1 || parseInt(sArr[0], 10) > 31) {
                //Physician\IPCaseRecord.aspx_16
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_16');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Enter valid Next Review Date');
                }
                document.getElementById('lblDay').innerHTML = '';
                document.getElementById('txtActualDate').focus();
                return false;
            }
            if (sArr[1] == '' || parseInt(sArr[1], 10) < 1 || parseInt(sArr[1], 10) > 12) {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_16');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Enter valid Next Review Date');
                }
                document.getElementById('lblDay').innerHTML = '';
                document.getElementById('txtActualDate').focus();
                return false;
            }
            if (sArr[2] == '' || parseInt(sArr[2], 10) < 1900) {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_16');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Enter valid Next Review Date');
                }
                document.getElementById('lblDay').innerHTML = '';
                document.getElementById('txtActualDate').focus();
                return false;
            }

            //Selected date should not be Lesser than Today
            var selDate = new Date(parseInt(sArr[2], 10), parseInt(sArr[1], 10) - 1, parseInt(sArr[0], 10));
            var today = new Date();
            var today1 = today.format("dd/MM/yyyy");
            today.setHours(0);
            today.setMinutes(0);
            today.setSeconds(0);
            if (selDate <= today) {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_17');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Enter valid Next Review Date, it should be greater than Today.');
                }
                return false;
            }
            var days = dateDiff2(today, selDate)
            if (document.getElementById('ddlDMY').value == 'Day(s)') {
                document.getElementById('ddlNos').value = days;
            }
            else if (document.getElementById('ddlDMY').value == 'Week(s)') {
                document.getElementById('ddlNos').value = document.getElementById('ddlNos').value;
            }
            else if (document.getElementById('ddlDMY').value == 'Month(s)') {
                document.getElementById('ddlNos').value = document.getElementById('ddlNos').value;
            }
            else {
                document.getElementById('ddlNos').value = document.getElementById('ddlNos').value;
            }
            return true;
        }
        function FnIsvalidTask(obj) {
            if (obj = 5) {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_18');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("The prescription part cannot be altered as the task in pharmacy is already picked.");
                }
                document.getElementById('btnCancel').click();

            }

        }
        function dateDiff2(startDate, endDate) {
            var one_day = 1000 * 60 * 60 * 24
            return (Math.round((endDate.getTime() - startDate.getTime()) / one_day));
        }
        function HideProcedure() {
            document.getElementById('GrdResponse').style.display = 'none';
        }
        function counttxt(txt) {
            var lbl = document.getElementById("lblCount");
            lbl.innerHTML = 0 + txt.value.length;
        }
    </script>

    <style type="text/css">
        #tbAddProc
        {
            width: 101%;
        }
    </style>

</head>
<body oncontextmenu="return false;" onload="setActualDay();HideProcedure();">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
        </Services>
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:DocHeader ID="docHeader" runat="server" />--%>
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc13:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" OnClick="lnkHome_Click"
                                        meta:resourcekey="LinkButton1Resource1" Text="Home&amp;nbsp;&amp;nbsp;&amp;nbsp;"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table id="tabPageBlock" cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr class="defaultfontcolor">
                                <td style="width: 60%;" valign="top">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table id="tbAssPhy" runat="server" style="display: none">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;">
                                                            <asp:Label ID="lblPrescription" runat="server" Text="On Behalf Of  :" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="drpPhysician" runat="server" meta:resourcekey="drpPhysicianResource1">
                                                            </asp:DropDownList>
                                                            <asp:Label ID="lblOnbehalf" runat="server" ForeColor="Red" Text="*" meta:resourcekey="lblOnbehalfResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_History" Text="History" runat="server" meta:resourcekey="Rs_HistoryResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr style="height: 10px;">
                                                        <td style="width: 40%;">
                                                            <asp:Label ID="Rs_History1" Text="History" runat="server" meta:resourcekey="Rs_History1Resource1"></asp:Label>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:Label ID="Rs_Duration" Text="Duration" runat="server" meta:resourcekey="Rs_DurationResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 40%;">
                                                            <input type="hidden" id="hdnHistoryItems" runat="server" />
                                                            <asp:TextBox runat="server" ID="txtHistory"  CssClass ="Txtboxlarge" autocomplete="off"
                                                                meta:resourcekey="txtHistoryResource1"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteHistory" runat="server" TargetControlID="txtHistory"
                                                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="gethistory"
                                                                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>
                                                        <td align="left">
                                                            <input type="text" id="txtHistoryDuration"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                runat="server" maxlength="3" style="width: 40px;" />
                                                            &nbsp;
                                                            <asp:DropDownList ID="ddlHistoryDuration" runat="server" CssClass="ddl" meta:resourcekey="ddlHistoryDurationResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Button ID="btnHistoryAdd" OnClientClick="javascript:return onClickAddHistory();"
                                                                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" meta:resourcekey="btnHistoryAddResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tblHistoryItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                                    cellspacing="0" border="0" width="97%">
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_DetailHistory" Text="History Detail" runat="server" meta:resourcekey="Rs_DetailHistoryResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td colspan="2">
                                                            <FCKeditorV2:FCKeditor ID="fckHospitalCourse" runat="server" Width="100%" Height="200px">
                                                            </FCKeditorV2:FCKeditor>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_Admissionvitals" Text="Collect vitals" runat="server" meta:resourcekey="Rs_AdmissionvitalsResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <%-- examination block starts--%>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl" width="100%">
                                                                            <tr>
                                                                                <td>
                                                                                    <uc2:PatientVitalsControl ID="uctlPatientVitals" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <%--<tr>
                        <td style="width:5%;">
                            Pulse
                        </td><td align="left" style="width:5%;"><input type="text" id="txtExaminationPulse"   onkeypress="return ValidateOnlyNumeric(this);"   maxlength="3" style="width:30px" runat="server" /></td><td align="left" style="width:5%;">
                            bpm</td>
                        <td style="width:5%;"  align="right">SBP/DBP</td><td style="width:5%;"><input type="text" id="txtExaminationSBP"   onkeypress="return ValidateOnlyNumeric(this);"  " maxlength="3" style="width:30px" runat="server" />&nbsp;/&nbsp;<input type="text" onkeydown="javascript:return validatenumber(event);" id="txtExaminationDBP" maxlength="3" style="width:30px" runat="server" /></td><td style="width:5%;" align="left">
                            mmHg</td>
                        <td style="width:5%;" align="right">RR</td><td style="width:5%;"><input type="text" id="txtExaminationRR"   onkeypress="return ValidateOnlyNumeric(this);"   maxlength="3" style="width:30px" runat="server" /></td ><td style="width:10%;">
                            breaths/min</td>
                        </tr>--%>
                                                                <tr>
                                                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                                                        <asp:Label ID="Rs_Examination" Text="Examination" runat="server" meta:resourcekey="Rs_ExaminationResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td valign="top">
                                                                                    <table cellpadding="3" cellspacing="0" border="0" width="100%" class="dataheaderInvCtrl">
                                                                                        <tr>
                                                                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                                                                <asp:Label ID="Rs_GeneralExamination" Text="General Examination" runat="server" meta:resourcekey="Rs_GeneralExaminationResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkPallor" runat="server" Text="Pallor" meta:resourcekey="chkPallorResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkIcterus" runat="server" Text="Icterus" meta:resourcekey="chkIcterusResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkOedema" runat="server" Text="Oedema" meta:resourcekey="chkOedemaResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkFever" runat="server" Text="Febrile" meta:resourcekey="chkFeverResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkUnconscious" runat="server" Text="Unconsciousness" meta:resourcekey="chkUnconsciousResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkStuporous" runat="server" Text="Stuporous" meta:resourcekey="chkStuporousResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkDisorientation" runat="server" Text="Disorientation" meta:resourcekey="chkDisorientationResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkSwollenLymphNodes" onclick="javascript:showSwollenLymphNodes();"
                                                                                                    runat="server" Text="Swollen Lymph Nodes" meta:resourcekey="chkSwollenLymphNodesResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr id="trSwollenLymphNodes" runat="server" style="display: none;">
                                                                                            <td>
                                                                                                <table cellpadding="1" class="dataheaderInvCtrl" cellspacing="0" width="100%" border="0">
                                                                                                    <tr class="defaultfontcolor">
                                                                                                        <td colspan="3">
                                                                                                            <b>
                                                                                                                <asp:Label ID="Rs_SwollenLymphNodes" Text="Swollen Lymph Nodes" runat="server" meta:resourcekey="Rs_SwollenLymphNodesResource1"></asp:Label></b>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:CheckBox ID="chkCervical" runat="server" Text="Cervical" meta:resourcekey="chkCervicalResource1" />
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:CheckBox ID="chkInguinal" runat="server" Text="Inguinal" meta:resourcekey="chkInguinalResource1" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:CheckBox ID="chkAxillary" runat="server" Text="Axillary" meta:resourcekey="chkAxillaryResource1" />
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:CheckBox ID="chkSubmandibular" runat="server" Text="Submandibular" meta:resourcekey="chkSubmandibularResource1" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:CheckBox ID="chkAbdominal" runat="server" Text="Abdominal" meta:resourcekey="chkAbdominalResource1" />
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:CheckBox ID="chkAuricular" runat="server" Text="Auricular" meta:resourcekey="chkAuricularResource1" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td valign="top">
                                                                                    <table cellpadding="4" cellspacing="0" border="0" class="dataheaderInvCtrl" style="height: 250px">
                                                                                        <tr>
                                                                                            <td style="font-weight: bold; height: 20px; color: #000;" colspan="2">
                                                                                                <asp:Label ID="Rs_SystemicExamination" Text="Systemic Examination" runat="server"
                                                                                                    meta:resourcekey="Rs_SystemicExaminationResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkCVS" runat="server" meta:resourcekey="chkCVSResource1" />
                                                                                                <asp:Label ID="Rs_CVS" Text="CVS" runat="server" meta:resourcekey="Rs_CVSResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtCVS" Text="S1, S2 normal. No murmurs or thrills. No additional sounds heard."
                                                                                                    TextMode="MultiLine" Style="width: 200px;" meta:resourcekey="txtCVSResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkRS" runat="server" meta:resourcekey="chkRSResource1" />
                                                                                                <asp:Label ID="Rs_RS" Text="RS" runat="server" meta:resourcekey="Rs_RSResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtRS" Text="Bilateral lung expansion and air entry are equal. NVBS heard. No adventitious sounds."
                                                                                                    TextMode="MultiLine" Style="width: 200px;" meta:resourcekey="txtRSResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="ChkABD" runat="server" meta:resourcekey="ChkABDResource1" />
                                                                                                <asp:Label ID="Rs_ABD" Text="ABD" runat="server" meta:resourcekey="Rs_ABDResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtABD" Text="Soft, non-tender.Normal bowel sounds. No abnormally palpable organs."
                                                                                                    TextMode="MultiLine" Style="width: 200px;" meta:resourcekey="txtABDResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="ChkCNS" runat="server" meta:resourcekey="ChkCNSResource1" />
                                                                                                <asp:Label ID="Rs_CNS" Text="CNS" runat="server" meta:resourcekey="Rs_CNSResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtCNS" Text="Alert, conscious, oriented. Higher functions, cranial nerves, sensory and motor system are normal with NFND."
                                                                                                    TextMode="MultiLine" Style="width: 200px;" meta:resourcekey="txtCNSResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="ChkPR" runat="server" meta:resourcekey="ChkPRResource1" />
                                                                                                <asp:Label ID="Rs_PR" Text="P/R" runat="server" meta:resourcekey="Rs_PRResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtPR" Text="Normal. No hard masses or nodules. No prolapses on straining. No impacted stools, blood or mucus."
                                                                                                    TextMode="MultiLine" Style="width: 200px;" meta:resourcekey="txtPRResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="ChkGenitalia" runat="server" meta:resourcekey="ChkGenitaliaResource1" />
                                                                                                <asp:Label ID="Rs_Genitalia" Text="Genitalia" runat="server" meta:resourcekey="Rs_GenitaliaResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtGenitalia" Text="External examination of the genitalia is normal."
                                                                                                    TextMode="MultiLine" Style="width: 200px;" meta:resourcekey="txtGenitaliaResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="ChkMusculoskeletal" runat="server" meta:resourcekey="ChkMusculoskeletalResource1" />
                                                                                                <asp:Label ID="Rs_Musculoskeletal" Text="Musculoskeletal" runat="server" meta:resourcekey="Rs_MusculoskeletalResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtMusculoskeletal" TextMode="MultiLine" Style="width: 200px;" meta:resourcekey="txtMusculoskeletalResource1"></asp:TextBox>
                                                                                                <asp:Label ID="lblMEAR" Style="cursor: pointer;" Font-Underline="True" Text="AddMore"
                                                                                                    onclick="javascript:return showMusculoskeletalCtrl();" runat="server" Font-Bold="True"
                                                                                                    meta:resourcekey="lblMEARResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="ChkOthers" runat="server" meta:resourcekey="ChkOthersResource1" />
                                                                                                <asp:Label ID="Rs_Others" Text="Others" runat="server" meta:resourcekey="Rs_OthersResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                                                                    Rows="1" ID="txtExaminationOthers" TextMode="MultiLine" Style="width: 200px;"
                                                                                                    Text="Local Examination" meta:resourcekey="txtExaminationOthersResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <%--  examination block ends--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top">
                                    <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                        <tr>
                                            <td valign="top" style="width: 100%;">
                                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                    <tr id="trPrevVisits" runat="server" style="display: none">
                                                        <td>
                                                            <asp:CheckBox ID="chkPrevVisits" runat="server" onClick="javascript:showPreviousVisitBlock();"
                                                                Text="Previous Visits" Font-Bold="True" meta:resourcekey="chkPrevVisitsResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trPrevVisits1" runat="server" style="display: none">
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td align="right" style="font-weight: bold; height: 20px; color: #000;">
                                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <div style="overflow: scroll; border: 2px; border-color: #fff; height: 120px;" class="ancCSviolet">
                                                                        <asp:GridView ID="grdResult" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                                                                class="mytable1" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Select" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource1">
                                                                                        <ItemTemplate>
                                                                                            <div style="text-align: center;">
                                                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect"
                                                                                                    meta:resourcekey="rdSelResource1" />
                                                                                            </div>
                                                                                            <asp:HiddenField ID="hdnPID" Value='<%# Bind("PatientID") %>' runat="server" />
                                                                                            <asp:HiddenField ID="hdnVID" Value='<%# Bind("PatientVisitId") %>' runat="server" />
                                                                                            <asp:HiddenField ID="hdnVType" Value='<%# Bind("VisitType") %>' runat="server" />
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Visit Date" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource2">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblVisitDate" Text='<%# Bind("VisitDate") %>' runat="server" meta:resourcekey="lblVisitDateResource1" />
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            OnClientClick="return CheckVisitID()" onmouseout="this.className='btn'" meta:resourcekey="btnGoResource1" />
                                                                        <asp:Button ID="btnShowAll" runat="server" Text="Show All" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            OnClientClick="return ShowAll()" onmouseout="this.className='btn'" meta:resourcekey="btnShowAllResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkRTA" runat="server" onClick="javascript:showRTABlock();" Text="RTA / MLC"
                                                                Font-Bold="True" meta:resourcekey="chkRTAResource1" />
                                                        </td>
                                                    </tr>
                                                    <%--  <tr id="trRTABlock" runat="server" style="display: none;">--%>
                                                    <tr id="trRTABlock" runat="server" style="display: none;">
                                                        <td>
                                                            <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:CheckBox ID="chkRTAInfluenceOfDrugs" runat="server" Text="Under the influence of Alcohol / Drugs"
                                                                            meta:resourcekey="chkRTAInfluenceOfDrugsResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%;">
                                                                        <asp:Label ID="Rs_EventLocation" Text="Event Location:" runat="server" meta:resourcekey="Rs_EventLocationResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRTALocation" runat="server" meta:resourcekey="txtRTALocationResource1"></asp:TextBox>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_EventDate" Text="Event Date:" runat="server" meta:resourcekey="Rs_EventDateResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRTADate" runat="server" CssClass="txtboxps" meta:resourcekey="txtRTADateResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtRTADate"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtRTADate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtRTADate"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_FIRNo" Text="FIR No:" runat="server" meta:resourcekey="Rs_FIRNoResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRTAFIRNo" runat="server" meta:resourcekey="txtRTAFIRNoResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_FIRDate" Text="FIR Date:" runat="server" meta:resourcekey="Rs_FIRDateResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFIRDate" runat="server" CssClass="txtboxps" meta:resourcekey="txtFIRDateResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalcFIR" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFIRResource1" />
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFIRDate"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender1"
                                                                            ControlToValidate="txtFIRDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="txtFIRDate"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFIR" Enabled="True" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_PoliceStation" Text="Police Station:" runat="server" meta:resourcekey="Rs_PoliceStationResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtPoliceStation" runat="server" meta:resourcekey="txtPoliceStationResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_PoliceContact" Text="Police Contact:" runat="server" meta:resourcekey="Rs_PoliceContactResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtPoliceContact" runat="server" meta:resourcekey="txtPoliceContactResource1"></asp:TextBox>
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
                                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <%--<asp:CheckBox ID="chkPastMedicalHistory" onClick="javascript:showPastMedicalHistoryBlock();"
                                                                        Text="Past Medical History" runat="server" Font-Bold="true" />--%>
                                                            <asp:CheckBox ID="chkPastMedicalHistory" onClick="javascript:showPastMedicalHistoryBlock();"
                                                                Text="Background Problems" runat="server" Font-Bold="True" meta:resourcekey="chkPastMedicalHistoryResource1" />
                                                        </td>
                                                    </tr>
                                                    <%-- <tr id="trPastMedicalHistory" runat="server" style="display: none;">--%>
                                                    <tr id="trPastMedicalHistory" runat="server" style="display: block;">
                                                        <td>
                                                            <input type="hidden" id="hdnPastMedicalHistoryItems" runat="server" />
                                                            <asp:Table ID="PastMedicalHistoryTab" CssClass="dataheaderInvCtrl" runat="server"
                                                                CellPadding="4" CellSpacing="0" BorderWidth="1px" Width="100%" meta:resourcekey="PastMedicalHistoryTabResource1">
                                                            </asp:Table>
                                                            <asp:Table ID="PastMedicalHistoryStrokeTab" CssClass="dataheaderInvCtrl" runat="server"
                                                                CellPadding="4" CellSpacing="0" BorderWidth="1px" Width="100%" meta:resourcekey="PastMedicalHistoryStrokeTabResource1">
                                                                <asp:TableRow meta:resourcekey="TableRowResource7">
                                                                    <asp:TableCell Width="100%" meta:resourcekey="TableCellResource14">
                                                                        <asp:CheckBox ID="chkPMHStroke" runat="server" Text="Stroke (CVA)" meta:resourcekey="chkPMHStrokeResource1" />
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow meta:resourcekey="TableRowResource8">
                                                                    <asp:TableCell Width="100%" meta:resourcekey="TableCellResource15">
                                                                        <asp:Label ID="Rs_Date" Text="Date:" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                                        <asp:TextBox ID="txtPMHStroke" runat="server" CssClass="txtboxps" meta:resourcekey="txtPMHStrokeResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalc1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" meta:resourcekey="ImgBntCalc1Resource1" />
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtPMHStroke"
                                                                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                            ErrorTooltipEnabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender6"
                                                                            ControlToValidate="txtPMHStroke" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtPMHStroke"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc1" />
                                                                    </asp:TableCell></asp:TableRow><asp:TableRow meta:resourcekey="TableRowResource9">
                                                                    <asp:TableCell meta:resourcekey="TableCellResource16">
                                                                        <asp:Label ID="Rs_Condition" Text="Condition" runat="server" meta:resourcekey="Rs_ConditionResource1"></asp:Label>
                                                                        <asp:DropDownList ID="ddlPMHStroke" runat="server" meta:resourcekey="ddlPMHStrokeResource1">
                                                                        </asp:DropDownList>
                                                                    </asp:TableCell></asp:TableRow></asp:Table><table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                <tr class="defaultfontcolor">
                                                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                                                        <asp:Label ID="Rs_OtherBackgroundProblems" Text="Other Background Problems" runat="server"
                                                                            meta:resourcekey="Rs_OtherBackgroundProblemsResource1"></asp:Label></td></tr><%-- <tr>
                                                                        <td>
                                                                            <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                                                <tr>
                                                                                    <td>
                                                                                        Other Problem </td><td>
                                                                                        Description </td><td>
                                                                                        &nbsp; </td></tr><tr>
                                                                                    <td style="width: 179px;">
                                                                                        <asp:TextBox runat="server" ID="txtOBP" Style="width: 150px;" autocomplete="off"></asp:TextBox>&nbsp;&nbsp; <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtOBP"
                                                                                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="10"
                                                                                            FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                                                                            ServicePath="~/WebService.asmx">
                                                                                        </cc1:AutoCompleteExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox runat="server" ID="txtDES" Style="width: 75px;" autocomplete="off"></asp:TextBox>&nbsp;&nbsp; </td><td>
                                                                                        <input type="button" name="btnOBP" id="btnOBP" onclick="return onClickOtherBackroundProblems();"
                                                                                            value="Add" class="btn" /> </td></tr><tr>
                                                                                    <td colspan="3">
                                                                                        <table id="tblOBP" runat="server" cellpadding="4" cellspacing="0" border="0" width="100%">
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <input type="hidden" id="hdnOBP" runat="server" />
                                                                        </td>
                                                                    </tr>--%> <tr>
                                                                    <td>
                                                                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td>
                                                                                    <uc10:ComplaintICDCodeBP ID="ComplaintICDCodeBP1" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:Table ID="obstretricHistoryTab" runat="server" CssClass="dataheaderInvCtrl"
                                                                CellPadding="4" CellSpacing="0" BorderWidth="1px" Width="100%" meta:resourcekey="obstretricHistoryTabResource1">
                                                                <asp:TableRow meta:resourcekey="TableRowResource1">
                                                                    <asp:TableCell Width="100%" meta:resourcekey="TableCellResource1">
                                                                        <asp:CheckBox ID="chkObstretricHistory" Style="display: none;" runat="server" Text="Obstretric History"
                                                                            meta:resourcekey="chkObstretricHistoryResource1" />
                                                                        <b>
                                                                            <asp:Label ID="Rs_ObstretricHistory" Text="Obstretric History" runat="server" meta:resourcekey="Rs_ObstretricHistoryResource1"></asp:Label>
                                                                        </b>
                                                                    </asp:TableCell></asp:TableRow><asp:TableRow meta:resourcekey="TableRowResource3">
                                                                    <asp:TableCell Width="100%" meta:resourcekey="TableCellResource2">
                                                                        <asp:Table ID="Table1" runat="server" CellPadding="2" CellSpacing="0" BorderWidth="0"
                                                                            Width="100%" meta:resourcekey="Table1Resource1">
                                                                            <asp:TableRow meta:resourcekey="TableRowResource2">
                                                                                <asp:TableCell HorizontalAlign="Right" meta:resourcekey="TableCellResource3">G</asp:TableCell>
                                                                                <asp:TableCell meta:resourcekey="TableCellResource4">
                                                                                    <asp:TextBox ID="txtGravida" MaxLength="2" runat="server" CssClass="textfield1" meta:resourcekey="txtGravidaResource1"></asp:TextBox>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell HorizontalAlign="Right" meta:resourcekey="TableCellResource5">P</asp:TableCell>
                                                                                <asp:TableCell meta:resourcekey="TableCellResource6">
                                                                                    <asp:TextBox ID="txtPara" runat="server" MaxLength="2" CssClass="textfield1" meta:resourcekey="txtParaResource1"></asp:TextBox>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell HorizontalAlign="Right" meta:resourcekey="TableCellResource7">A</asp:TableCell>
                                                                                <asp:TableCell meta:resourcekey="TableCellResource8">
                                                                                    <asp:TextBox ID="txtAbortUs" MaxLength="2" runat="server" CssClass="textfield1" meta:resourcekey="txtAbortUsResource1"></asp:TextBox>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell HorizontalAlign="Right" meta:resourcekey="TableCellResource9">L</asp:TableCell>
                                                                                <asp:TableCell meta:resourcekey="TableCellResource10">
                                                                                    <asp:TextBox ID="txtLive" runat="server" MaxLength="2" CssClass="textfield1" meta:resourcekey="txtLiveResource1"></asp:TextBox>
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell></asp:TableRow><asp:TableRow meta:resourcekey="TableRowResource4">
                                                                    <asp:TableCell Width="100%" meta:resourcekey="TableCellResource11">
                                                                        <asp:Label ID="Rs_LMP" Text="LMP" runat="server" meta:resourcekey="Rs_LMPResource1"></asp:Label>
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" AcceptNegative="Left"
                                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                            MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                                            TargetControlID="tLMP" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc3"
                                                                            TargetControlID="tLMP" />
                                                                        <asp:TextBox ID="tLMP" runat="server" CssClass="textfield" MaxLength="1" Style="text-align: justify"
                                                                            TabIndex="4" ValidationGroup="MKE" meta:resourcekey="tLMPResource1" />
                                                                        <asp:ImageButton ID="ImgBntCalc3" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            meta:resourcekey="ImgBntCalc3Resource1" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender3"
                                                                            ControlToValidate="tLMP" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                                            InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                                            ValidationGroup="MKE" meta:resourcekey="MaskedEditValidator3Resource1" />
                                                                    </asp:TableCell></asp:TableRow><asp:TableRow meta:resourcekey="TableRowResource5">
                                                                    <asp:TableCell Width="100%" meta:resourcekey="TableCellResource12">
                                                                        <asp:Label ID="Rs_EDD" Text="EDD" runat="server" meta:resourcekey="Rs_EDDResource1"></asp:Label>
                                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" AcceptNegative="Left"
                                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                            MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                                            TargetControlID="txtCalculatedEDD" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc4"
                                                                            TargetControlID="txtCalculatedEDD" />
                                                                        <asp:TextBox ID="txtCalculatedEDD" runat="server" CssClass="textfield" meta:resourcekey="txtCalculatedEDDResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalc4" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            meta:resourcekey="ImgBntCalc4Resource1" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator4" runat="server" ControlExtender="MaskedEditExtender4"
                                                                            ControlToValidate="txtCalculatedEDD" Display="Dynamic" EmptyValueBlurredText="*"
                                                                            EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" meta:resourcekey="MaskedEditValidator4Resource1" />
                                                                    </asp:TableCell></asp:TableRow><asp:TableRow Style="display: none;" meta:resourcekey="TableRowResource6">
                                                                    <asp:TableCell Width="100%" meta:resourcekey="TableCellResource13">
                                                                        <asp:Label ID="Rs_TypeOfDelivery" Text="Type Of Delivery" runat="server" meta:resourcekey="Rs_TypeOfDeliveryResource1"></asp:Label>
                                                                        &nbsp;<asp:DropDownList ID="ddlModeOfDelivery" runat="server" meta:resourcekey="ddlModeOfDeliveryResource1">
                                                                        </asp:DropDownList>
                                                                    </asp:TableCell></asp:TableRow></asp:Table></td></tr></table></td></tr></table></td></tr></table><table id="tblOrtho" style="display: block;" runat="server" cellpadding="0" cellspacing="0"
                            border="0" class="dataheaderInvCtrl" width="100%">
                            <tr style="display: none;" runat="server" id="trOrtho">
                                <td>
                                    <%--<asp:GridView ID="grdResult" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                                                                class="mytable1" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Select" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource1">
                                                                                        <ItemTemplate>
                                                                                            <div style="text-align: center;">
                                                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect"
                                                                                                    meta:resourcekey="rdSelResource1" />
                                                                                            </div>
                                                                                            <asp:HiddenField ID="hdnPID" Value='<%# Bind("PatientID") %>' runat="server" />
                                                                                            <asp:HiddenField ID="hdnVID" Value='<%# Bind("PatientVisitId") %>' runat="server" />
                                                                                            <asp:HiddenField ID="hdnVType" Value='<%# Bind("VisitType") %>' runat="server" />
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Visit Date" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource2">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblVisitDate" Text='<%# Bind("VisitDate") %>' runat="server" meta:resourcekey="lblVisitDateResource1" />
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>--%> <uc4:OrthoEMR ID="OrthoEMR1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table id="tbldiagnosis1" border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr class="defaultfontcolor">
                                <td style="width: 100%;">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <%--<td valign="top" style="width: 25%;">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                                Diagnosis
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                               
                                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox runat="server" ID="txtDiagnosis" Style="width: 150px;" autocomplete="off"></asp:TextBox>&nbsp;&nbsp;
                                                                            <cc1:AutoCompleteExtender ID="AutoDescValue" runat="server" TargetControlID="txtDiagnosis"
                                                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="10"
                                                                                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                                                                ServicePath="~/WebService.asmx">
                                                                            </cc1:AutoCompleteExtender>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button ID="btnDiagnosisAdd" OnClientClick="javascript:return onClickAddDiagnosis();"
                                                                                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                onmouseout="this.className='btn'" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table id="tblDiagnosisItems" runat="server" cellpadding="4" cellspacing="0" border="0"
                                                                                width="100%">
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <input type="hidden" id="hdnDiagnosisItems" runat="server" />
                                                              
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 1%;">
                                                </td>--%> <td valign="top" style="width: 25%;">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;">
                                                            <asp:Label ID="Rs_Info" Text="Order Investigation" runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label></td></tr><tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;">
                                                            <table cellpadding="4" cellspacing="0" border="0" width="100%" class="dataheaderInvCtrl">
                                                                <tr>
                                                                    <td>
                                                                        <%--<table id="tblOrederedInvesTemp" style="font-weight: normal;" cellpadding="4px" cellspacing="0">
                                                                        </table>--%> </td></tr><tr>
                                                                    <td align="left">
                                                                        <asp:Label ID="lblAddInvDetails" Style="cursor: pointer;" Font-Underline="True" Text="Add / Change Investigation"
                                                                            onclick="javascript:return showInvestigationCtrl();" runat="server" meta:resourcekey="lblAddInvDetailsResource1"></asp:Label></td></tr></table></td></tr></table></td><td style="width: 1%;">
                                            </td>
                                            <%--<td valign="top" style="width: 35%;">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" style="display: none"
                                                    id="tblPerformedInvestigation" runat="server">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;">
                                                            <asp:Label ID="Rs_OrderedInvestigation" Text="Ordered Investigation" runat="server"
                                                                meta:resourcekey="Rs_OrderedInvestigationResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
                                                                <tr>
                                                                    <td>
                                                                        <asp:DataList ID="dlInvName" runat="server" CellPadding="4" GridLines="Horizontal"
                                                                            RepeatColumns="1" RepeatDirection="Horizontal" meta:resourcekey="dlInvNameResource1">
                                                                            <ItemTemplate>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <%# DataBinder.Eval(Container.DataItem, "Name")%>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>--%> </tr></table></td></tr></table><table width="80%" id="tbMainProc" runat="server" style="display:none">
                            <tr>
                                <td>
                                    <div class="colorforcontent" style="display: none;" id="Grdplus" runat="server">
                                        <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                            onclick="showResponses('Grdplus','Grdminus','GrdResponse',1);" /> <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Grdplus','Grdminus','GrdResponse',1); "><asp:Label ID="Label3" Font-Bold="true" Text="Order Procedure" Height="20" runat="server" onclick="CreateTabl1()"></asp:Label></span></div><div class="colorforcontent" style="display: none" id="Grdminus">
                                        <img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top" style="cursor: pointer"
                                            onclick="showResponses('Grdplus','Grdminus','GrdResponse',0);" /> <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Grdplus','Grdminus','GrdResponse',0);"><asp:Label ID="Label4" Font-Bold="true" Text="Order Procedure" Height="20" runat="server"></asp:Label></span></div><div id="GrdResponse">
                                        <table id="tabProc" runat="server" width="100%" style="display: none">
                                            <tr>
                                                <td>
                                                    <table id="tbAddProc" class="dataheaderInvCtrl" width="100%">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblProc" runat="server" Text="Enter Procedure Name"></asp:Label></td><td>
                                                                <asp:TextBox CssClass="biltextb" ID="txtName" onKeyDown="chkPros();" runat="server"></asp:TextBox><ajc:AutoCompleteExtender
                                                                    ID="AutoCompleteExtender3" runat="server" TargetControlID="txtName" EnableCaching="False"
                                                                    MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True" OnClientItemSelected="IAmSelected"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="GetQuickBillItems"
                                                                    ServicePath="~/OPIPBilling.asmx" UseContextKey="True" DelimiterCharacters=""
                                                                    Enabled="True">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblSiting" runat="server" Text="Enter No. of Sitting"></asp:Label></td><td>
                                                                <asp:TextBox CssClass="biltextb" MaxLength="3"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                    ID="txtQty" Width="25px" Style="text-align: right;" runat="server" Text="1"></asp:TextBox></td><td style="word-wrap: break-word">
                                                                <asp:Label ID="lblComments" Text="Comments" runat="server"></asp:Label><asp:TextBox
                                                                    runat="server" onKeydown="counttxt(this)" onKeyup="counttxt(this)" Rows="5" ID="txtComments"
                                                                    TextMode="MultiLine" Style="width: 220px;"></asp:TextBox><asp:Label ID="lblCount"
                                                                        runat="server" Text="0"></asp:Label><asp:Label ID="lblM" runat="server" Text=" /2000"></asp:Label>&nbsp;Chars. </td><td>
                                                                <input type="button" id="btnAdd" onclick="return addItems();" style="width: 70px;" class="btn"
                                                                    value="Add" /> </td></tr><tr>
                                                            <td style="display: none" id="tdDivCreateProc" colspan="7">
                                                                <div id="divCreateProc" runat="server" style="width: 99%;">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="tblCICD" border="0" cellpadding="0" cellspacing="0" width="100%" class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor" style="padding-left: 10px;">
                                <td>
                                    <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table runat="server" id="tblTreatmentplan" border="0" cellpadding="0" cellspacing="0"
                            width="100%" style="display: none">
                            <tr>
                                <td style="font-weight: bold; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_TreatmentPlan" Text="Treatment Plan" runat="server" meta:resourcekey="Rs_TreatmentPlanResource1"></asp:Label></td></tr><tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <%-- Treatment block starts--%> <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td width="380px;">
                                                                                    <%--<asp:DropDownList ID="ddlIPTreatmentPlanMaster"  OnSelectedIndexChanged="ddlIPTreatmentPlanMaster_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                                                                    </asp:DropDownList>--%> <asp:DropDownList ID="ddlIPTreatmentPlanMaster" onchange="javascript:showIPTreatmentPlanChild(this.value);"
                                                                                        runat="server" meta:resourcekey="ddlIPTreatmentPlanMasterResource1">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="Rs_Prosthesis" Text="Prosthesis" runat="server" meta:resourcekey="Rs_ProsthesisResource1"></asp:Label></td></tr><tr>
                                                                                <td width="380px;" id="tdIPTreatmentPlanChild" style="display: block">
                                                                                    <asp:DropDownList ID="ddlIPTreatmentPlanChild" runat="server" onchange="javascript:showIPTreatmentPlanOthersChildBlock(this.value);"
                                                                                        meta:resourcekey="ddlIPTreatmentPlanChildResource1">
                                                                                    </asp:DropDownList>
                                                                                    <input type="hidden" id="hdnIPTreatmentPlanChild" runat="server" />
                                                                                </td>
                                                                                <td width="380px;" id="td1" style="display: None">
                                                                                    &nbsp; </td><td>
                                                                                    <asp:TextBox runat="server" ID="txtIPTreatmentPlanProsthesis" Style="width: 150px;"
                                                                                        meta:resourcekey="txtIPTreatmentPlanProsthesisResource1"></asp:TextBox></td></tr></table></td></tr><tr style="height: 25px;">
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <%-- <td>
                                                                                <asp:CheckBox ID="chkIPTreatmentPlanOthers" onClick="javascript:showIPTreatmentPlanOthersBlock();"
                                                                                    runat="server" Text="Other Treatment Options" />
                                                                            </td>--%> <td>
                                                                                    <table id="Table2" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                        <tr id="IPTreatmentPlanOthersBlock" style="display: none;">
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_TreatmentPlanName" Text="TreatmentPlan Name:" runat="server" meta:resourcekey="Rs_TreatmentPlanNameResource1"></asp:Label><input type="text" id="txtIPTreatmentPlanOthers" runat="server" style="width: 200px;" /> </td></tr><tr id="IPTreatmentPlanOthersChild" style="display: none;">
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_TreatmentPlanName1" Text="TreatmentPlan Name:" runat="server" meta:resourcekey="Rs_TreatmentPlanName1Resource1"></asp:Label><input type="text" id="txtIPTreatmentPlanOthersChild" runat="server" style="width: 200px;" /> </td></tr></table></td></tr></table></td></tr><tr style="height: 25px;">
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td>
                                                                                    <%-- <asp:CheckBox ID="chkIPTreatmentPlanDate" onClick="javascript:showIPTreatmentPlanDateBlock();"
                                                                                    runat="server" Text="Probable Treatment Date" />--%><asp:Label ID="Rs_ProbableTreatmentDate"
                                                                                        Text="Probable Treatment Date" runat="server" meta:resourcekey="Rs_ProbableTreatmentDateResource1"></asp:Label></td><td>
                                                                                    <table id="IPTreatmentPlanDateBlock" style="display: block;" runat="server" cellpadding="0"
                                                                                        cellspacing="0" border="0" width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="text" id="txtIPTreatmentPlanDate" runat="server" style="width: 200px;" /> <a href="javascript:NewCal('<%=txtIPTreatmentPlanDate.ClientID %>','ddmmyyyy',true,12)"><img src="../Images/Calendar_scheduleHS.png" /> </td></tr></table></td></tr></table></td></tr></table></td><td valign="middle">
                                                            <input type="button" name="btnIPTreatmentPlanA" /> </td></tr></table><table id="tblIPTreatmentPlanItems" class="dataheaderInvCtrl" runat="server" cellpadding="8"
                                                    cellspacing="0" border="1">
                                                </table>
                                                <input type="hidden" id="hdnIPTreatmentPlanItems" runat="server" />
                                                <table id="tblPerformedTreatment" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                                    cellspacing="0" border="1" width="100%">
                                                </table>
                                                <input type="hidden" id="hdnPerformedTreatment" runat="server" />
                                                <%-- Treatment block ends--%> </td></tr></table></td></tr></table><table id="tabInvCtrlBlock" style="display: none;" cellpadding="0" cellspacing="0"
                            border="0" width="100%" runat="server">
                            <tr>
                                <td>
                                    <%-- Investigation block starts--%> <uc9:InvestigationControl ID="InvestigationControl1" runat="server" />
                                    <%-- Investigation block ends--%> </td></tr><tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <asp:Button ID="btnInvCtrlFinish" OnClientClick="javascript:return showInvestigationCtrl();"
                                                runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnInvCtrlFinishResource1" /><asp:Button
                                                    ID="btnPayment" runat="server" Text="Send For Payment" CssClass="btn" OnClick="btnPayment_Click"
                                                    meta:resourcekey="btnPaymentResource1" /><asp:Button ID="btnDueChart" runat="server"
                                                        Text="Add To Dues" CssClass="btn" OnClick="btnDueChart_Click" meta:resourcekey="btnDueChartResource1" />
                                            <asp:Button ID="btnCorOk" runat="server" Text="OK" Visible="False" CssClass="btn"
                                                OnClientClick="javascript:return showInvestigationCtrl();" meta:resourcekey="btnCorOkResource1" /></ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                            <ContentTemplate>
                                <table id="submitTab1" runat="server" cellpadding="0" cellspacing="0" border="0"
                                    width="100%">
                                    <tr runat="server">
                                        <td runat="server">
                                            <asp:CheckBox ID="chkPriviousvisitdrug" Text="Show drugs from previous visit" runat="server"
                                                AutoPostBack="True" OnCheckedChanged="chkPriviousvisitdrug_CheckedChanged" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <table id="submitTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <uc12:InvenAdv ID="uIAdv" runat="server" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc9:GeneralAdv ID="uGAdv" runat="server" />
                                    <br />
                                    <br />
                                    <asp:Panel ID="pnlMiscellaneous" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlMiscellaneousResource1">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td class="colorforcontent" width="35%" height="23" align="left">
                                                    <div style="display: none" id="ACX2plusM">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);" /> <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);"><asp:Label ID="Rs_Miscellaneous" Text="Miscellaneous" runat="server" meta:resourceKey="Rs_MiscellaneousResource1"></asp:Label></span></div><div style="display: block; height: 18px;" id="ACX2minusM">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);" /> <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);"><asp:Label ID="Rs_Miscellaneous1" Text="Miscellaneous" runat="server" meta:resourceKey="Rs_Miscellaneous1Resource1"></asp:Label></span></div></td><td width="75%" height="23" align="left">
                                                    &nbsp; </td></tr><tr class="tablerow" id="ACX2responsesM">
                                                <td colspan="2">
                                                    <div class="dataheader2">
                                                        <br />
                                                        <asp:CheckBox ID="chkReview" runat="server" meta:resourcekey="chkReviewResource1" />&nbsp;<asp:Label
                                                            ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"
                                                            meta:resourceKey="lblTxtResource1"></asp:Label><asp:TextBox ID="ddlNos" runat="server"
                                                                Text="1" Width="25px"  meta:resourcekey="ddlNosResource1"></asp:TextBox><asp:DropDownList
                                                                    ID="ddlDMY" runat="server" CssClass ="ddl" meta:resourceKey="ddlDMYResource1">
                                                                </asp:DropDownList>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtActualDate" runat="server" meta:resourceKey="txtActualDateResource1" CssClass="Txtboxsmall"
                                                            TabIndex="3"></asp:TextBox><asp:ImageButton ID="ImgBntCalcFrom" runat="server" CausesValidation="False"
                                                                ImageUrl="~/images/Calendar_scheduleHS.png" meta:resourceKey="ImgBntCalcFromResource1" /><cc1:MaskedEditExtender
                                                                    ID="mskActualDate" runat="server" AcceptNegative="Left" CultureAMPMPlaceholder=""
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                    DisplayMoney="Left" Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999"
                                                                    MaskType="Date" TargetControlID="txtActualDate">
                                                                </cc1:MaskedEditExtender>
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="mskActualDate"
                                                            ControlToValidate="txtActualDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                            EmptyValueMessage="Date is required" ErrorMessage="mskActualDate" InvalidValueBlurredMessage="*"
                                                            InvalidValueMessage="Date is invalid" meta:resourceKey="MaskedEditValidator6Resource1"
                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE"></cc1:MaskedEditValidator><cc1:CalendarExtender
                                                                ID="CalendarExtender6" runat="server" Enabled="True" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom"
                                                                TargetControlID="txtActualDate">
                                                            </cc1:CalendarExtender>
                                                        &nbsp;<asp:Label ID="lblDay" runat="server" CssClass="defaultfontcolor" ForeColor="Red"
                                                            meta:resourcekey="lblDayResource1"></asp:Label><br clear="all" />
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <uc10:Nutrition ID="ucNutrition" runat="server" />
                                               </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <%--    <asp:Panel ID="pnlMiscellaneous" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlMiscellaneousResource1">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td class="colorforcontent" width="35%" height="23" align="left">
                                                            <div style="display: none" id="ACX2plusM">
                                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                    style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);" /> <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);"><asp:Label ID="Rs_Miscellaneous" Text="Miscellaneous" runat="server" meta:resourceKey="Rs_MiscellaneousResource1"></asp:Label></span></div><div style="display: block; height: 18px;" id="ACX2minusM">
                                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                                    style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);" /> <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);"><asp:Label ID="Rs_Miscellaneous1" Text="Miscellaneous" runat="server" meta:resourceKey="Rs_Miscellaneous1Resource1"></asp:Label></span></div></td><td width="75%" height="23" align="left">
                                                            &nbsp; </td></tr><tr class="tablerow" id="ACX2responsesM">
                                                        <td colspan="2">
                                                            <div class="dataheader2">
                                                                <br />
                                                                <asp:CheckBox ID="chkReview" runat="server" meta:resourcekey="chkReviewResource1" />&nbsp; <asp:Label ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"
                                                                    meta:resourceKey="lblTxtResource1"></asp:Label><asp:TextBox ID="ddlNos"  runat="server"  Width="25px" meta:resourcekey="ddlNosResource1"></asp:TextBox><asp:DropDownList ID="ddlDMY" runat="server" meta:resourceKey="ddlDMYResource1"></asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox  ID="txtActualDate" runat="server" meta:resourceKey="txtActualDateResource1" TabIndex="3"></asp:TextBox><asp:ImageButton ID="ImgBntCalcFrom" 
                                                                        runat="server" CausesValidation="False" 
                                                                        ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                        meta:resourceKey="ImgBntCalcFromResource1" />
                                                                        <cc1:MaskedEditExtender ID="mskActualDate" runat="server" AcceptNegative="Left" 
                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                                        CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" DisplayMoney="Left" 
                                                                        Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" 
                                                                        TargetControlID="txtActualDate"></cc1:MaskedEditExtender>
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="mskActualDate" 
                                                                        ControlToValidate="txtActualDate" Display="Dynamic" EmptyValueBlurredText="*" 
                                                                        EmptyValueMessage="Date is required" ErrorMessage="mskActualDate" 
                                                                        InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" 
                                                                        meta:resourceKey="MaskedEditValidator6Resource1" TooltipMessage="(dd-mm-yyyy)" 
                                                                        ValidationGroup="MKE"></cc1:MaskedEditValidator><cc1:CalendarExtender ID="CalendarExtender6" runat="server" Enabled="True" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom"
                                                                        TargetControlID="txtActualDate">
                                                                     </cc1:CalendarExtender>
                                                                    &nbsp;<asp:Label ID="lblDay" runat="server" CssClass="defaultfontcolor" ForeColor="Red"
                                                                    meta:resourcekey="lblDayResource1"></asp:Label><br clear="all" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>--%> <br />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnFinish" Enabled="False" runat="server" OnClick="btnFinish_Click"
                                        Text="Save" CssClass="btn" OnClientClick="javascript:return checkForValues(this.id);"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClientClick="javascript:if(!CallCancelMessage(this)) return false;" CommandName="Clear"
                                        meta:resourcekey="btnCancelResource1" />
                                        <div style="display:none;">
                                        <asp:Button runat="server" ID="btnInvisible"
                                            Width="0px" OnClientClick="javascript:return checkForValues(this.id);" meta:resourcekey="btnInvisibleResource1" />
                                            </div>
                                </td>
                            </tr>
                        </table>
                        <%-- </ContentTemplate>
                        </asp:UpdatePanel>--%> </div></td></tr></table><asp:HiddenField ID="hdnOnBehalfID" runat="server" />
        <input type="hidden" id="hdnpPID" name="pid" runat="server" />
        <input type="hidden" id="hdnpVID" name="vid" runat="server" />
        <input type="hidden" id="hdnpVType" runat="server" />
        <input type="hidden" id="hdnToPreviousPage" runat="server" />
        <input type="hidden" id="hdnInvestigationtaskstastusID" runat="server" />
        <input type="hidden" id="hdnInentorytaskstastusID" runat="server" />
        <input type="hidden" id="hdnPatientID" name="pid" runat="server" />
        <input type="hidden" id="hdnVisitID" name="pvid" runat="server" />
        <asp:HiddenField ID="hdnIscorprateorg" runat="server" />
        <asp:HiddenField ID="hdnProcedureID" runat="server" />  
        <asp:HiddenField ID="hdnAddItems" runat="server" />
        <asp:HiddenField ID="hdnOrdered" runat="server" /> 
        <asp:HiddenField ID="hdnComments" runat="server" /> 
        <asp:HiddenField ID="hdnMessages" runat ="server" />
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>

    <script language="javascript" type="text/javascript">
        LoadHistoryItems();
        //  LoadDiagnosisItems();
        LoadIPTreatmentPlanItems();
        //       LoadOrdItems1();
        showIPTreatmentPlanChild(document.getElementById("ddlIPTreatmentPlanMaster").value);
        LoadPerformedIPTreatmentPlanItems();
        //  LoadOtherBackroundproblem();
        function chkPros() {
            var sval = 'PRO';
            var sRateID = -1;
            var pvalue = -1;
            var pVisitID = -1;
            var IsMapped;
            var OrgID = '<%= OrgID%>';
            var IsMapped = 'N';
            var BillPage = '';
            sval = sval + '~' + OrgID + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped + '~' + BillPage;
            $find('AutoCompleteExtender3').set_contextKey(sval);
        }
        function IAmSelected(source, eventArgs) {
            var list = eventArgs.get_value();
            if (list.length > 0) {
                document.getElementById('hdnProcedureID').value = list;
            }
        }
        function addItems() {
            var sit = document.getElementById('<%= txtQty.ClientID %>').value;
            if (document.getElementById('<%= txtName.ClientID %>').value == "") {
                alert('Please Enter Procedure Name');
                document.getElementById('<%= txtName.ClientID %>').focus();
                return false;
            }
            else if (sit == '' || sit < 1) {
            if (sit == '') {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_23');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Enter the Sitting');
                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Physician\\IPCaseRecord.aspx_22');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Enter Atleast One Sitting');
                }
            }
                document.getElementById('<%= txtQty.ClientID %>').focus();
                return false;
            }
            else {
            
                var totalItem = document.getElementById('hdnProcedureID').value;
                //24^WAX BATH^PRO^0.00^0^0^Y^0.00^0.00^0^0^0.00^0.00
                var procID = totalItem.split('^')[0];
                var procName = totalItem.split('^')[1];
                if (procID != '') {
                    var OrgID = '<%= OrgID%>';
                    var PatientID = document.getElementById('hdnPatientID').value;
                    OPIPBilling.GetProcedureStatus(OrgID, PatientID, procID, Duelist);
                }
                else {
                    alert('Invalid Procedure Name');
                    document.getElementById('<%= txtName.ClientID %>').value = "";
                    document.getElementById('<%= txtName.ClientID %>').focus();
                    document.getElementById('<%= txtComments.ClientID %>').value = "";
                    document.getElementById('<%= txtQty.ClientID %>').value = 1;
                    document.getElementById('hdnProcedureID').value = '';
                    return false;
                }
            }
            return true;
        }
        function CreateTable(additems) {
            document.getElementById('hdnAddItems').value += additems;
            var items = document.getElementById('hdnAddItems').value.split('^');
            document.getElementById('<%= divCreateProc.ClientID %>').innerHTML = "";
            var startTag, bodyTag, endTag;
            if (items != "") {
                startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='center' >" + "<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_ProcedureName %>" + "</th> <th scope='col' align='center'>" + "<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_NoofSittings %>" + "</th><th scope='col' align='center'>" + "<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Comments %>" + "</th><th scope='col' align='center'>" + "<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Delete_1 %>" + "</th></tr>";
                endTag = "</TBODY></TABLE>";
                bodyTag = startTag;
                for (var i = 0; i < items.length; i++) {
                    if (items[i] != "") {
                        bodyTag += "<TR><TD style='display:none'>" + items[i].split('~')[0] + "</TD>";
                        bodyTag += "<TD style='padding-left:5px' align='left'>" + items[i].split('~')[1] + "</TD>";
                        bodyTag += "<TD style='padding-left:5px' align='left'>" + items[i].split('~')[2] + "</TD>";
                        bodyTag += "<TD style='padding-left:5px' align='left'>" + items[i].split('~')[3] + "</TD>";
                        bodyTag += "<TD><input name='" + items[i].split('~')[0] + '~' + items[i].split('~')[1] + '~' + items[i].split('~')[2] + '~' + items[i].split('~')[3] + "' onclick='deleteRow(name);' value = '<%#Resources.ClientSideDisplayTexts.Physician_IPCaseRecord_Delete_2 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD> </TR>";
                    }
                }
                bodyTag += endTag;
                document.getElementById('tdDivCreateProc').style.display = 'block';
                document.getElementById('<%= divCreateProc.ClientID %>').innerHTML = bodyTag;
                document.getElementById('<%= txtName.ClientID %>').value = "";
                document.getElementById('<%= txtName.ClientID %>').focus();
                document.getElementById('<%= txtQty.ClientID %>').value = 1;
                document.getElementById('<%= txtComments.ClientID %>').value = '';
                document.getElementById('hdnProcedureID').value = '';
            }
        }
        function deleteRow(deletedata) {
            var existitems = document.getElementById('hdnAddItems').value.split('^');
            document.getElementById('hdnAddItems').value = "";
            var additems = "";
            if (existitems != '') {
                for (var i = 0; i < existitems.length; i++) {
                    if (existitems[i] != "") {
                        if (deletedata != existitems[i]) {
                            additems += existitems[i] + "^";
                        }
                    }
                }
            }
            CreateTable(additems);
        }
        function ShowProcedure() {
            document.getElementById('tbAddProc').style.display = 'block';
            var additems = document.getElementById('hdnOrdered').value;
            document.getElementById('hdnOrdered').value = '';
            CreateTable(additems);
        }

        function CreateTabl1() {
            var additem = document.getElementById('hdnOrdered').value;
            if (additem != '') {
                document.getElementById('hdnOrdered').value = '';
                CreateTable(additem);
            }
        }

        function Duelist(tmpValue) {
            if (tmpValue == 'Open') {
                alert('Procedure already in progress..! You cannot order this procedure');
                document.getElementById('<%= txtQty.ClientID %>').value = "1";
                document.getElementById('<%= txtName.ClientID %>').value = "";
                document.getElementById('<%= txtName.ClientID %>').focus();
                document.getElementById('<%= txtComments.ClientID %>').value = '';
            }
            else {
                var totalItem = document.getElementById('hdnProcedureID').value;
                //24^WAX BATH^PRO^0.00^0^0^Y^0.00^0.00^0^0^0.00^0.00               
                var procID = totalItem.split('^')[0];
                var procName = totalItem.split('^')[1];
                if (procID != '') {
                    var siting = document.getElementById('<%= txtQty.ClientID %>').value;
                    var comments = document.getElementById('<%= txtComments.ClientID %>').value;
                    var additems = procID + '~' + procName + '~' + siting + '~' + comments + '^';
                    if (document.getElementById('hdnAddItems').value == '') {
                        CreateTable(additems);
                    }
                    else {
                        var existItem = document.getElementById('hdnAddItems').value.split('^');
                        if (existItem != '') {
                            for (var j = 0; j < existItem.length; j++) {
                                if (existItem[j] != "") {
                                    if (additems.split('~')[0] == existItem[j].split('~')[0]) {
                                        alert('Already this procedure was added');
                                        document.getElementById('<%= txtName.ClientID %>').value = '';
                                        document.getElementById('<%= txtName.ClientID %>').focus();
                                        document.getElementById('<%= txtQty.ClientID %>').value = 1;
                                        return false;
                                    }
                                }
                            }
                        }
                        CreateTable(additems);
                    }
                }                
            }            
        }
        
    </script>

</body>
</html>
