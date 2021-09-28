<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OperationNotes.aspx.cs" Inherits="Physician_OperationNotes"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc11" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Operation Notes</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function SelectAll(id) {
            //get reference of GridView control

            var grid = document.getElementById('grdCRCplan');
            //variable to contain the cell of the grid
            var cell;

            if (grid.rows.length > 0) {
                //loop starts from 1. rows[0] points to the header.
                for (i = 1; i < grid.rows.length; i++) {
                    //get the reference of first column
                    cell = grid.rows[i].cells[0];

                    //loop according to the number of childNodes in the cell
                    for (j = 0; j < cell.childNodes.length; j++) {
                        //if childNode type is CheckBox                 
                        if (cell.childNodes[j].type == "checkbox") {
                            //assign the status of the Select All checkbox to the cell checkbox within the grid
                            if (cell.childNodes[j].checked) {

                                document.getElementById('hdnSurgery').value = "Checked";
                                return true;
                            }
                            else {
                                document.getElementById('hdnSurgery').value = "";
                                return false;
                            }
                            //                            cell.childNodes[j].checked = document.getElementById(id).checked;
                        }
                    }
                }
            }
        }

        function checkForValues() {

            if (document.getElementById('hdnIPTreatmentPlanItems').value.trim() == "" && document.getElementById('hdnSurgery').value == "") {
                var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_1");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Provide surgery / procedure  details');
                return false;
            }
                document.getElementById('ddlIPTreatmentPlanMaster').focus();
                return false;
            }
            if (document.getElementById('ddlChiefOperator').value == 0) {
                document.getElementById('ddlChiefOperator').focus();
                 var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_2");
                 if (userMsg != null) {
                     alert(userMsg);
                     return false;
                 }
                 else {
                     alert('Select the chief doctor');
                     return false;
                 }
                return false;
            }
            if (document.getElementById('txtFromTime').value == "") {
                document.getElementById('txtFromTime').focus();
                 var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_3");
                 if (userMsg != null) {
                     alert(userMsg);
                     return false;
                 }
                 else {
                     alert('Provide the from time');
                     return false;
                 }
                return false;
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

        function pValidationTreatment() {

            if (document.getElementById("OPid").value == '') {
 var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_4");
 if (userMsg != null) {
     alert(userMsg);
     return false;
 }
 else {
     alert('Select treatment plan');
     return false;
 }
                return false;
            }
        }

        function onClickAddComplicationItems() {
            var rwNumber = parseInt(220);
            var AddStatus = 0;
            var txtComplicationValue = document.getElementById('txtComplication').value.trim();
            document.getElementById('tblComplicationItems').style.display = 'block';
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnDiagnosisItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[1] != '') {
                        if (DiagnosisList[0] != '') {
                            rwNumber = parseInt(parseInt(DiagnosisList[0]) + parseInt(1));
                        }
                        if (txtComplicationValue != '') {
                            if (DiagnosisList[1] == txtComplicationValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }

            else {

                if (txtComplicationValue != '') {
                    var row = document.getElementById('tblComplicationItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComplicationValue;
                    document.getElementById('hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + txtComplicationValue + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtComplicationValue != '') {
                    var row = document.getElementById('tblComplicationItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickDiagnosis(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComplicationValue;
                    document.getElementById('hdnDiagnosisItems').value += parseInt(rwNumber) + "~" + txtComplicationValue + "^";
                }
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_5");
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 alert('Complication already added');
                 return false;
             }
            }
            document.getElementById('txtComplication').value = '';
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
                document.getElementById('tblComplicationItems').style.display = 'none';
            }
        }
        function LoadDiagnosisItems() {
            var HidValue = document.getElementById('hdnDiagnosisItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnDiagnosisItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var DiagnosisList = list[count].split('~');
                    var row = document.getElementById('tblComplicationItems').insertRow(0);
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



        //Add AssistantOperator

        function onAssistantOperatorClick(id) {

            var rwNumber = parseInt(320);
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var HidValue = document.getElementById('<%= iconHidAssistant.ClientID %>').value;
            var list = HidValue.split('^');

            if (document.getElementById('<%= iconHidAssistant.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var AssistingOperatorList = list[count].split('~');
                    if (AssistingOperatorList[1] != '') {
                        if (AssistingOperatorList[0] != '') {
                            rwNumber = parseInt(parseInt(AssistingOperatorList[0]) + parseInt(1));
                        }
                        if (AssistingOperatorList[1] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
            else {
                document.getElementById('<%= lblChiefOperator.ClientID %>').style.display = "block";
                var row = document.getElementById('tblChiefOperator').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssisting(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%= iconHidAssistant.ClientID %>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('<%= lblChiefOperator.ClientID %>').style.display = 'block';
                var row = document.getElementById('tblChiefOperator').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssisting(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%= iconHidAssistant.ClientID %>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_6");
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 alert("Already Added!");
                 return false;
             }
            }



        }

        function ImgOnclickAssisting(ImgID) {
            //alert(document.getElementById(ImgID).innerHTML);
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('<%= iconHidAssistant.ClientID %>').value;
            var list = HidValue.split('^');
            var newAssistingOperatorList = '';
            if (document.getElementById('<%= iconHidAssistant.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var AssistingOperatorList = list[count].split('~');
                    if (AssistingOperatorList[0] != '') {
                        if (AssistingOperatorList[0] != ImgID) {
                            newAssistingOperatorList += list[count] + '^';
                        }
                    }
                }

                document.getElementById('<%= iconHidAssistant.ClientID %>').value = newAssistingOperatorList;

            }
        }
        function LoadAssistant() {
            var HidValue = document.getElementById('<%= iconHidAssistant.ClientID %>').value;
            var list = HidValue.split('^');
            if (document.getElementById('<%= iconHidAssistant.ClientID %>').value != "") {
                document.getElementById('<%= lblChiefOperator.ClientID %>').style.display = "block";
                for (var count = 0; count < list.length - 1; count++) {
                    var AssistantList = list[count].split('~');
                    var row = document.getElementById('tblChiefOperator').insertRow(0);
                    row.id = AssistantList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    //                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAssisting(" + AssistantList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = AssistantList[2];
                    //                    cell3.innerHTML = InvesList[2];
                    //                    cell3.style.display = "none";
                }
            }

        }
        //Add Anesthetist

        function onAnesthetistClick(id) {
            var rwNumber = parseInt(420);
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var HidValue = document.getElementById('<%=iconHidAnesthetist.ClientID%>').value;
            var list = HidValue.split('^');

            if (document.getElementById('<%=iconHidAnesthetist.ClientID%>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var Anesthetist = list[count].split('~');
                    if (Anesthetist[1] != '') {
                        if (Anesthetist[0] != '') {
                            rwNumber = parseInt(parseInt(Anesthetist[0]) + parseInt(1));
                        }
                        if (Anesthetist[1] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
            else {
                document.getElementById('<%=lblAnesthetist.ClientID%>').style.display = "block";
                var row = document.getElementById('tblAnesthetist').insertRow(0);
                row.id = parseInt(rwNumber);

                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetist(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%=iconHidAnesthetist.ClientID%>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('<%=lblAnesthetist.ClientID%>').style.display = 'block';
                var row = document.getElementById('tblAnesthetist').insertRow(0);
                row.id = parseInt(rwNumber);

                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetist(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%=iconHidAnesthetist.ClientID%>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_6");
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 alert("Already Added!");
                 return false;
             }
            }

        }

        function ImgOnclickAnesthetist(ImgID) {
            //alert(document.getElementById(ImgID).innerHTML);
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('<%=iconHidAnesthetist.ClientID%>').value;
            var list = HidValue.split('^');
            var newAnesthetist = '';
            if (document.getElementById('<%=iconHidAnesthetist.ClientID%>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var Anesthetist = list[count].split('~');
                    if (Anesthetist[0] != '') {
                        if (Anesthetist[0] != ImgID) {
                            newAnesthetist += list[count] + '^';
                        }
                    }
                }
                document.getElementById('<%=iconHidAnesthetist.ClientID%>').value = newAnesthetist;

            }
        }



        function LoadAnesthetist() {
            var HidValue = document.getElementById('<%= iconHidAnesthetist.ClientID %>').value;
            var list = HidValue.split('^');
            if (document.getElementById('<%= iconHidAnesthetist.ClientID %>').value != "") {
                document.getElementById('<%= lblAnesthetist.ClientID %>').style.display = "block";
                for (var count = 0; count < list.length - 1; count++) {
                    var AnesthetistList = list[count].split('~');
                    var row = document.getElementById('tblAnesthetist').insertRow(0);
                    row.id = AnesthetistList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    //                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAnesthetist(" + AnesthetistList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = AnesthetistList[2];
                    //                    cell3.innerHTML = InvesList[2];
                    //                    cell3.style.display = "none";
                }
            }

        }

        //Add Technician

        function onTechnicianClick(id) {
            var rwNumber = parseInt(520);

            var AddStatus = 0;
            var obj = document.getElementById(id);
            var HidValue = document.getElementById('<%=iconHidTechnician.ClientID%>').value;
            var list = HidValue.split('^');

            if (document.getElementById('<%=iconHidTechnician.ClientID%>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var TechnicianList = list[count].split('~');
                    if (TechnicianList[1] != '') {
                        if (TechnicianList[0] != '') {
                            rwNumber = parseInt(parseInt(TechnicianList[0]) + parseInt(1));
                        }
                        if (TechnicianList[1] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
            else {
                document.getElementById('<%=lblTechnician.ClientID%>').style.display = "block";
                var row = document.getElementById('tblTechnician').insertRow(0);
                row.id = parseInt(rwNumber);

                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickTechnician(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%=iconHidTechnician.ClientID%>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('<%=lblTechnician.ClientID%>').style.display = 'block';
                var row = document.getElementById('tblTechnician').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickTechnician(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%=iconHidTechnician.ClientID%>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_6");
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 alert("Already Added!");
                 return false;
             }
            }



        }

        function ImgOnclickTechnician(ImgID) {
            //alert(document.getElementById(ImgID).innerHTML);
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('<%=iconHidTechnician.ClientID%>').value;
            var list = HidValue.split('^');
            var newTechnicianList = '';
            if (document.getElementById('<%=iconHidTechnician.ClientID%>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var TechnicianList = list[count].split('~');
                    if (TechnicianList[0] != '') {
                        if (TechnicianList[0] != ImgID) {
                            newTechnicianList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('<%=iconHidTechnician.ClientID%>').value = newTechnicianList;

            }
        }



        function LoadTechnician() {
            var HidValue = document.getElementById('<%= iconHidTechnician.ClientID %>').value;
            var list = HidValue.split('^');
            if (document.getElementById('<%= iconHidTechnician.ClientID %>').value != "") {
                document.getElementById('<%= lblTechnician.ClientID %>').style.display = "block";
                for (var count = 0; count < list.length - 1; count++) {
                    var TechnicianList = list[count].split('~');
                    var row = document.getElementById('tblTechnician').insertRow(0);
                    row.id = TechnicianList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    //                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickTechnician(" + TechnicianList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = TechnicianList[2];
                    //                    cell3.innerHTML = InvesList[2];
                    //                    cell3.style.display = "none";
                }
            }

        }

        // Add nurse

        function onNurseClick(id) {
            var rwNumber = parseInt(620);
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var HidValue = document.getElementById('<%=iconHidNurse.ClientID%>').value;
            var list = HidValue.split('^');

            if (document.getElementById('<%=iconHidNurse.ClientID%>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var NurseList = list[count].split('~');
                    if (NurseList[1] != '') {
                        if (NurseList[0] != '') {
                            rwNumber = parseInt(parseInt(NurseList[0]) + parseInt(1));
                        }


                        if (NurseList[1] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
            else {
                document.getElementById('<%=lblNurse.ClientID%>').style.display = "block";
                var row = document.getElementById('tblNurse').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclicknurse(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%=iconHidNurse.ClientID%>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('<%=lblNurse.ClientID%>').style.display = 'block';
                var row = document.getElementById('tblNurse').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclicknurse(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //                cell3.innerHTML = type;
                //                cell3.style.display = "none";
                document.getElementById('<%=iconHidNurse.ClientID%>').value += parseInt(rwNumber) + "~" + obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_6");
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 alert("Already Added!");
                 return false;
             }
            }

        }

        function ImgOnclicknurse(ImgID) {
            //alert(document.getElementById(ImgID).innerHTML);
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('<%=iconHidNurse.ClientID%>').value;
            var list = HidValue.split('^');
            var newNurseList = '';
            if (document.getElementById('<%=iconHidNurse.ClientID%>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var NurseList = list[count].split('~');
                    if (NurseList[0] != '') {
                        if (NurseList[0] != ImgID) {
                            newNurseList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('<%=iconHidNurse.ClientID%>').value = newNurseList;

            }
        }

        function LoadNurse() {
            var HidValue = document.getElementById('<%= iconHidNurse.ClientID %>').value;
            var list = HidValue.split('^');
            if (document.getElementById('<%= iconHidNurse.ClientID %>').value != "") {
                document.getElementById('<%= lblNurse.ClientID %>').style.display = "block";
                for (var count = 0; count < list.length - 1; count++) {
                    var NurseList = list[count].split('~');
                    var row = document.getElementById('tblNurse').insertRow(0);
                    row.id = NurseList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    //                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclicknurse(" + NurseList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = NurseList[2];
                    //                    cell3.innerHTML = InvesList[2];
                    //                    cell3.style.display = "none";
                }
            }

        }
        //        //hide show

        //        function showPastMedicalHistoryBlock() {
        //            if (document.getElementById('chkPastMedicalHistory').checked) {
        //                document.getElementById('investigation').style.display = "block";
        ////                document.getElementById('OPNotes').style.display = "none";
        //            }
        //            else {
        //                document.getElementById('investigation').style.display = "none";
        ////                document.getElementById('OPNotes').style.display = "block";
        //            }
        //        }



        //IPTreatmentPlan

        //        function onClickAddIPTreatmentPlan_OLD() {
        //            var rwNumber = parseInt(330);
        //            var AddStatus = 0;
        //            var masterID = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].value;
        //            var masterText = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].text;
        //            var childID = "0";
        //            var childText = "";

        //            var obj = document.getElementById("ddlIPTreatmentPlanMaster").id;
        //            var obj1 = document.getElementById("ddlIPTreatmentPlanChild").id;
        //            var prosthesis = document.getElementById("txtIPTreatmentPlanProsthesis").value;

        //            alert(prosthesis);
        //            if (document.getElementById('chkIPTreatmentPlanOthers').checked) {
        //                childID = "0";
        //                childText = document.getElementById('txtIPTreatmentPlanOthers').value;
        //            }
        //            else {
        //                childID = document.getElementById("ddlIPTreatmentPlanChild").options[document.getElementById("ddlIPTreatmentPlanChild").selectedIndex].value
        //                childText = document.getElementById("ddlIPTreatmentPlanChild").options[document.getElementById("ddlIPTreatmentPlanChild").selectedIndex].text;
        //            }

        //            document.getElementById('tblIPTreatmentPlanItems').style.display = 'block';
        //            var HidValue = document.getElementById('hdnIPTreatmentPlanItems').value;

        //            var list = HidValue.split('^');
        //            var newIPTreatmentPlanList = "";
        //            var iCountNumber = 0;
        //            var cCount = 0;

        //            if (document.getElementById('hdnIPTreatmentPlanItems').value != "") {

        //                for (var count = 0; count < list.length; count++) {
        //                    var IPTreatmentPlanList = list[count].split('~');

        //                    if (IPTreatmentPlanList.length > 0) {
        //                        var Appendprosthesis = "";
        //                        if ((IPTreatmentPlanList[1] == masterID) && (IPTreatmentPlanList[2] == childID)) {
        //                            iCountNumber++;

        //                            if (prosthesis != "") {
        //                                var ListProsthesis = IPTreatmentPlanList[5].split(',');
        //                                for (var count = 0; count < ListProsthesis.length; count++) {
        //                                    if (ListProsthesis[count] == prosthesis) {
        //                                        AddStatus = 1;
        //                                    }
        //                                }
        //                                if (AddStatus == 0) {
        //                                    Appendprosthesis = IPTreatmentPlanList[5] + "," + prosthesis;
        //                                    list[count] = IPTreatmentPlanList[0] + "~" + IPTreatmentPlanList[1] + "~" + IPTreatmentPlanList[2] + "~" + IPTreatmentPlanList[3] + "~" + IPTreatmentPlanList[4] + "~" + Appendprosthesis;
        //                                    newIPTreatmentPlanList += list[count] + '^';
        //                                    document.getElementById('hdnIPTreatmentPlanItems').value = newIPTreatmentPlanList;
        //                                }

        //                            }
        //                        }
        //                        else {
        //                            document.getElementById('hdnIPTreatmentPlanItems').value = HidValue;

        //                        }
        //                    }
        //                }
        //            }
        //            //            else {
        //            //                newIPTreatmentPlanList = document.getElementById('hdnIPTreatmentPlanItems').value;
        //            //                newIPTreatmentPlanList += parseInt(rwNumber) + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "^"
        //            //                alert("else2");
        //            //                alert(newIPTreatmentPlanList);
        //            //            }
        //            alert(document.getElementById('hdnIPTreatmentPlanItems').value);

        //            if (iCountNumber == 0) {
        //                document.getElementById('hdnIPTreatmentPlanItems').value += parseInt(rwNumber) + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "^";
        //            }
        //            //            else {
        //            //                alert("Treatment Plan Already Added!");
        //            //            }
        //            LoadIPTreatmentPlanItems();

        //            document.getElementById("txtIPTreatmentPlanProsthesis").value = "";
        //            if (document.getElementById('chkIPTreatmentPlanOthers').checked) {
        //                document.getElementById('chkIPTreatmentPlanOthers').checked = false;
        //                document.getElementById('txtIPTreatmentPlanOthers').value = "";
        //                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "none";
        //            }
        //            return false;
        //        }


        function onClickAddIPTreatmentPlan() 
        {
            var rowNumber = 1;
            var AddStatus = 0;

            var masterID = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].value;
            var masterText = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].text;

            var childID = "0";
            var childText = "";

            //Newly Added
            var TreatmentDate = "Will be scheduled later";


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


            document.getElementById('tblIPTreatmentPlanItems').style.display = 'block';
            var HidValue = document.getElementById('hdnIPTreatmentPlanItems').value;

            if (HidValue == "") {
                HidValue = rowNumber + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "^"
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

                                if (prosthesis == "") {

                                    prosthesis = prosthesisSplitter[k];
                                }
                                else {
                                    prosthesis = prosthesis + "," + prosthesisSplitter[k];
                                }

                            }
                            colSplitter[5] = prosthesis;
                        }

                        //Check For prosthesis
                        if (blnProsthesisExists) {
                         var userMsg = SListForApplicationMessages.Get("Physician\\OperationNotes.aspx_11");
                         if (userMsg != null) {
                             alert(userMsg);
                             return false;
                         }
                         else {
                             alert('Prosthesis already exist');
                             return false;
                         }
                        }

                    }
                    rowSplitter[i] = rowNumber + "~" + colSplitter[1] + "~" + colSplitter[2] + "~" + colSplitter[3] + "~" + colSplitter[4] + "~" + colSplitter[5] + "^";
                    tempRow = tempRow + rowSplitter[i];
                }

                if (!blnChildExists) {
                    if (childText != "") {

                        newChild = rowNumber + 1 + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "^";
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
            return false;
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


            while (count = document.getElementById('tblIPTreatmentPlanItems').rows.length) {

                for (var j = 0; j < document.getElementById('tblIPTreatmentPlanItems').rows.length; j++) {
                    document.getElementById('tblIPTreatmentPlanItems').deleteRow(j);

                }
            }

            if (document.getElementById('hdnIPTreatmentPlanItems').value != "") {

                var row = document.getElementById('tblIPTreatmentPlanItems').insertRow(0);
                row.id = 0;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var Cell6 = row.insertCell(5);
                var Cell7 = row.insertCell(6);
                cell1.innerHTML = "Delete"
                cell1.width = "6%";
                cell2.innerHTML = 0;
                cell3.innerHTML = 0;
                cell2.style.display = "none";
                cell3.style.display = "none";
                cell4.innerHTML = "Type";
                cell5.innerHTML = "Name";
                Cell6.innerHTML = "Prosthesis ";
                Cell7.innerHTML = "Edit";

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

                    var row = document.getElementById('tblIPTreatmentPlanItems').insertRow(1);
                    row.id = IPTreatmentPlanList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var Cell6 = row.insertCell(5);
                    var Cell7 = row.insertCell(6);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickIPTreatmentPlan(" + parseInt(IPTreatmentPlanList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = IPTreatmentPlanList[1];
                    cell3.innerHTML = IPTreatmentPlanList[2];
                    cell2.style.display = "none";
                    cell3.style.display = "none";
                    cell4.innerHTML = IPTreatmentPlanList[3];
                    cell5.innerHTML = IPTreatmentPlanList[4];
                    Cell6.innerHTML = IPTreatmentPlanList[5];
                    Cell7.innerHTML = "<input onclick='btnEdit_OnClick(name);' name='" + parseInt(rwNumber) + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";


                }
            }

        }


        //IP treatment Plan Edit
        function btnEdit_OnClick(sEditedData) {


            var arrayAlreadyPresentDatas = new Array();
            var iAlreadyPresent = 0;
            var iCount = 0;
            var tempDatas = document.getElementById('<%= hdnIPTreatmentPlanItems.ClientID %>').value;

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

                //                if (arrayGotValue[2] == 0) 
                //                {

                //                    document.getElementById("IPTreatmentPlanOthersBlock").style.display = "block";

                //                    document.getElementById('<%= ddlIPTreatmentPlanMaster.ClientID %>').value = arrayGotValue[1];
                //                    document.getElementById('<%= txtIPTreatmentPlanOthers.ClientID %>').value = arrayGotValue[4];
                //                    document.getElementById('<%= txtIPTreatmentPlanProsthesis.ClientID %>').value = arrayGotValue[5];

                //                }
                //                else
                //                 {

                //                    document.getElementById("IPTreatmentPlanOthersBlock").style.display = "none"
                //                    document.getElementById('<%= ddlIPTreatmentPlanMaster.ClientID %>').value = arrayGotValue[1];
                //                    document.getElementById('<%= ddlIPTreatmentPlanChild.ClientID %>').value = arrayGotValue[2];
                //                    document.getElementById('<%= txtIPTreatmentPlanProsthesis.ClientID %>').value = arrayGotValue[5];
                //                }
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


            }
            document.getElementById('<%= hdnIPTreatmentPlanItems.ClientID %>').value = tempDatas;
            LoadIPTreatmentPlanItems()

        }

        //End IP treatment Plan Edit



        //Bind IPTreatmentPlanChild in DropDown
        //        function showIPTreatmentPlanChild(SelectedMasterID) {

        //            alert(SelectedMasterID);

        //            var HidValue = document.getElementById('hdnIPTreatmentPlanChild').value;

        //            alert(HidValue);
        //            var MasterID = SelectedMasterID;
        //            var list = HidValue.split('^');

        //            

        //            document.getElementById('hdntreatmentMasterID').value = SelectedMasterID;

        //            var ddlTreatmentPlanChild = document.getElementById('ddlIPTreatmentPlanChild');
        //            ddlTreatmentPlanChild.options.length = 0;
        //            
        //            if (document.getElementById('hdnIPTreatmentPlanChild').value != "") {

        //                for (var count = 0; count < list.length; count++) {

        //                    var IPTreatmentPlanChild = list[count].split('~');


        //                    if (MasterID == IPTreatmentPlanChild[2]) {


        //                        var opt = document.createElement("option");
        //                        alert("test");
        //                        document.getElementById("ddlIPTreatmentPlanChild").options.add(opt);
        //                        opt.text = IPTreatmentPlanChild[1];
        //                        opt.value = IPTreatmentPlanChild[0];


        //                    }


        //                }
        //            }
        //        }

        //        
        //            
        //



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


                document.getElementById('tdIPTreatmentPlanChild').style.display = "none";

                document.getElementById('td1').style.display = "block";
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "block";
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


        function closeData() { }

        var ddlText, ddlValue, ddl, lblMesg;
        function CacheItems() {
            ddlText = new Array();
            ddlValue = new Array();
            ddl = document.getElementById('<%=ddlChiefOperator.ClientID %>');
            for (var i = 0; i < ddl.options.length; i++) {
                ddlText[ddlText.length] = ddl.options[i].text;
                ddlValue[ddlValue.length] = ddl.options[i].value;
            }
        }

        window.onload = CacheItems;


        function FilterItems(value) {
            value = value.toLowerCase();
            ddl.options.length = 0;
            for (var i = 0; i < ddlText.length; i++) {
                if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                    AddItem(ddlText[i], ddlValue[i]);
                }
            }

            if (ddl.options.length == 0) {
                AddItem("No Physician Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            ddl.options.add(opt);
        }
        function AddPhysician() {

            var ddlPhy = document.getElementById('<%= ddlChiefOperator.ClientID %>');
            var ddlPhyLength = ddlPhy.options.length;
            for (var i = 0; i < ddlPhyLength; i++) {
                if (ddlPhy.options[i].selected) {


                    if (ddlPhy.options[i].text != '-----Select-----') {

                        document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;

                    }

                }

            }
        }
        
           

    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnFinish">
    <input type="hidden" id="hdnDiagnosisItems" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
   <ContentTemplate>--%>
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
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc11:LeftMenu ID="LeftMenu1" runat="server" />
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
                                    <asp:LinkButton ID="LinkButton1"  runat="server" CssClass="details_label_age" OnClick="lnkHome_Click"
                                        meta:resourcekey="LinkButton1Resource1" Text="Home"><asp:Label ID="Rs_Home" 
                                        Text="Home" runat="server" meta:resourcekey="Rs_HomeResource1"></asp:Label>
</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" runat="server" style="display: block"
                            id="tblSelectOption">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000;" align="right">
                                                <asp:Label ID="Rs_SelectAnOption" Text="Select An Option" runat="server" 
                                                    meta:resourcekey="Rs_SelectAnOptionResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAddEdit" runat="server" CssClass="ddl" OnSelectedIndexChanged="ddlAddEdit_SelectedIndexChanged"
                                                    AutoPostBack="True" meta:resourcekey="ddlAddEditResource1">
                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">Add New Operation Notes</asp:ListItem>
                                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">Edit Operation Notes</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table id="tblTreatment" cellpadding="0" cellspacing="0" border="0" width="100%"
                            style="display: block" runat="server">
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000;" colspan="2" align="center">
                                                <input type="hidden" id="OPid" name="OPid" />
                                                <asp:GridView ID="gvTreatment" runat="server" AutoGenerateColumns="False" DataKeyNames="OperationID"
                                                    OnRowDataBound="gvTreatment_RowDataBound" meta:resourcekey="gvTreatmentResource1">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect"
                                                                    meta:resourcekey="rdSelResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOperationID" runat="server" Text='<%# Bind("IPTreatmentPlanName") %>'
                                                                    meta:resourcekey="lblIPTreatmentPlanNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Treatment Name" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%# Bind("OperationID") %>'
                                                                    meta:resourcekey="lblOperationIDResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Performed By" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhysicianName" runat="server" Text='<%# Bind("PhysicianName") %>'
                                                                    meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Performed Date" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFromTime" runat="server" Text='<%# Bind("FromTime") %>' meta:resourcekey="lblFromTimeResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Type" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblParentName" runat="server" Text='<%# Bind("ParentName") %>' meta:resourcekey="lblParentNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" align="center">
                                                <asp:Button ID="btnEditOperationNotes" runat="server" Text="Edit" CssClass="btn"
                                                    OnClick="btnEditOperationNotes_Click" OnClientClick="return pValidationTreatment()"
                                                    meta:resourcekey="btnEditOperationNotesResource1" />
                                                <asp:Button ID="btnEditOperationCancel" runat="server" Text="Cancel" CssClass="btn"
                                                    OnClick="btnEditOperationCancel_Click" meta:resourcekey="btnEditOperationCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblOperationNotes"
                            runat="server" style="display: block">
                            <tr>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr style="height: 10px;">
                                                        <td style="font-weight: normal; color: #000;">
                                                            <asp:Label ID="Rs_BloodGroup" Text="Blood Group:" runat="server" meta:resourcekey="Rs_BloodGroupResource1"></asp:Label><asp:Label
                                                                ID="lblBloodgroup" runat="server" meta:resourcekey="lblBloodgroupResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;">
                                                            <asp:Label ID="Rs_VitalsDetails" Text="Vitals Details" runat="server" meta:resourcekey="Rs_VitalsDetailsResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Table Width="100%" runat="server" ID="tblVitals" CssClass="dataheaderInvCtrl"
                                                                            CellSpacing="0" BorderWidth="1px" CellPadding="8" GridLines="Both" meta:resourcekey="tblVitalsResource1">
                                                                        </asp:Table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;">
                                                            <asp:Label ID="Rs_ClinicalDiagnosis" Text="Clinical Diagnosis" runat="server" meta:resourcekey="Rs_ClinicalDiagnosisResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <table cellspacing="0" cellpadding="0" border="0">
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Table runat="server" ID="tblDiagnosis" CssClass="colorforcontentborder" CellSpacing="0"
                                                                            BorderWidth="0px" meta:resourcekey="tblDiagnosisResource1">
                                                                        </asp:Table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;" colspan="3">
                                                            <asp:Label ID="Rs_OperationTeam" Text="Operation Team" runat="server" meta:resourcekey="Rs_OperationTeamResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 172px;">
                                                            <asp:Label ID="Rs_Chiefsurgeon" Text="Chief surgeon" runat="server" meta:resourcekey="Rs_ChiefsurgeonResource1"></asp:Label>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txtNew" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)"
                                                                onblur="AddPhysician()" meta:resourcekey="txtNewResource1" />
                                                            <asp:DropDownList ID="ddlChiefOperator" runat="server" CssClass="ddl" meta:resourcekey="ddlChiefOperatorResource1">
                                                            </asp:DropDownList>
                                                            <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                                                                WatermarkText="Type Physician Name" Enabled="True" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 172px;">
                                                            <asp:Label ID="Rs_Assistingsurgeon" Text="Assisting surgeon" runat="server" meta:resourcekey="Rs_AssistingsurgeonResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 272px;">
                                                            <asp:HiddenField ID="iconHidAssistant" runat="server" />
                                                            <asp:ListBox ID="lsAssistingOperator" runat="server" Width="80%" ondblClick="javascript:onAssistantOperatorClick(this.id);"
                                                                meta:resourcekey="lsAssistingOperatorResource1"></asp:ListBox>
                                                        </td>
                                                        <td valign="top">
                                                            <table id="Table1" cellpadding="0px" cellspacing="0" width="96%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblChiefOperator" runat="server" Text="Assisting surgeon " Style="display: none;
                                                                            font-size: 12px; vertical-align: middle; padding: 5px;" CssClass="Duecolor" meta:resourcekey="lblChiefOperatorResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblChiefOperator" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                                                                width="96%">
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 172px;">
                                                            <asp:Label ID="Rs_Anesthetist" Text="Anesthetist" runat="server" meta:resourcekey="Rs_AnesthetistResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 272px;">
                                                            <asp:HiddenField ID="iconHidAnesthetist" runat="server" />
                                                            <asp:ListBox ID="lsAnesthetist" Width="80%" runat="server" ondblClick="javascript:onAnesthetistClick(this.id);"
                                                                meta:resourcekey="lsAnesthetistResource1"></asp:ListBox>
                                                        </td>
                                                        <td valign="top">
                                                            <table id="Table2" cellpadding="0px" cellspacing="0" width="96%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblAnesthetist" runat="server" Text="Anesthetist" Style="display: none;
                                                                            font-size: 12px; vertical-align: middle; padding: 5px;" CssClass="Duecolor" meta:resourcekey="lblAnesthetistResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblAnesthetist" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                                                                width="96%">
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 172px;">
                                                            <asp:Label ID="Rs_Technician" Text="Technician" runat="server" meta:resourcekey="Rs_TechnicianResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 272px;">
                                                            <asp:HiddenField ID="iconHidTechnician" runat="server" />
                                                            <asp:ListBox ID="lsTechnician" Width="80%" runat="server" ondblClick="javascript:onTechnicianClick(this.id);"
                                                                meta:resourcekey="lsTechnicianResource1"></asp:ListBox>
                                                        </td>
                                                        <td valign="top">
                                                            <table id="Table3" cellpadding="0px" cellspacing="0" width="96%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblTechnician" runat="server" Text="Technician" Style="display: none;
                                                                            font-size: 12px; vertical-align: middle; padding: 5px;" CssClass="Duecolor" meta:resourcekey="lblTechnicianResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblTechnician" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                                                                width="96%">
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 172px;">
                                                            <asp:Label ID="Rs_Nurse" Text="Nurse" runat="server" meta:resourcekey="Rs_NurseResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 272px;">
                                                            <asp:HiddenField ID="iconHidNurse" runat="server" />
                                                            <asp:ListBox ID="lsNurse" Width="80%" runat="server" ondblClick="javascript:onNurseClick(this.id);"
                                                                meta:resourcekey="lsNurseResource1"></asp:ListBox>
                                                        </td>
                                                        <td valign="top">
                                                            <table id="Table4" cellpadding="0px" cellspacing="0" width="96%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblNurse" runat="server" Text="Nurse" Style="display: none; font-size: 12px;
                                                                            vertical-align: middle; padding: 5px;" CssClass="Duecolor" meta:resourcekey="lblNurseResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblNurse" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                                                                width="96%">
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;" colspan="6">
                                                            <asp:Label ID="Rs_OperationTime" Text="Operation Time" runat="server" meta:resourcekey="Rs_OperationTimeResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="Rs_FromTime" Text="From Time:" runat="server" meta:resourcekey="Rs_FromTimeResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox runat="server" ID="txtFromTime" CssClass="Txtboxsmall" MaxLength="25" size="25" meta:resourcekey="txtFromTimeResource1"></asp:TextBox>
                                                            <a href="javascript:NewCal('<%=txtFromTime.ClientID %>','ddmmyyyy',true,12)">
                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td align="center">
                                                            <asp:Label ID="Rs_ToTime" Text="To Time :" runat="server" meta:resourcekey="Rs_ToTimeResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox runat="server" ID="txtToTime" CssClass="Txtboxsmall" MaxLength="25" size="25" meta:resourcekey="txtToTimeResource1"></asp:TextBox>
                                                            <a href="javascript:NewCal('<%=txtToTime.ClientID %>','ddmmyyyy',true,12)">
                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;" colspan="6">
                                                            <asp:Label ID="Rs_Operation" Text="Operation" runat="server" meta:resourcekey="Rs_OperationResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_SurgeryType" Text="Surgery Type" runat="server" meta:resourcekey="Rs_SurgeryTypeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlSurgeryType" runat="server" CssClass="ddl" meta:resourcekey="ddlSurgeryTypeResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_OperationType" Text="Operation Type" runat="server" meta:resourcekey="Rs_OperationTypeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlOperationType" runat="server" CssClass="ddl" meta:resourcekey="ddlOperationTypeResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_AnesthesiaType" Text="Anesthesia Type" runat="server" meta:resourcekey="Rs_AnesthesiaTypeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlAnesthesiaType" runat="server" CssClass="ddl" meta:resourcekey="ddlAnesthesiaTypeResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trsurgery" class="defaultfontcolor">
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; height: 20px; color: #000;">
                                                            <asp:Label ID="Rs_SurgeryProcedure" Text="Surgery / Procedure" runat="server" meta:resourcekey="Rs_SurgeryProcedureResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td>
                                                                                    <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                                                        <tr>
                                                                                            <td width="380px;">
                                                                                                <%--<asp:DropDownList ID="ddlIPTreatmentPlanMaster"  OnSelectedIndexChanged="ddlIPTreatmentPlanMaster_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                                                                    </asp:DropDownList>--%>
                                                                                                <asp:DropDownList ID="ddlIPTreatmentPlanMaster" CssClass="ddl" onchange="javascript:showIPTreatmentPlanChild(this.value);"
                                                                                                    runat="server" meta:resourcekey="ddlIPTreatmentPlanMasterResource1">
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_Prosthesis" Text="Prosthesis" runat="server" meta:resourcekey="Rs_ProsthesisResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td width="380px;" id="tdIPTreatmentPlanChild" style="display: block">
                                                                                                <asp:DropDownList ID="ddlIPTreatmentPlanChild" runat="server" CssClass="ddl" onchange="javascript:showIPTreatmentPlanOthersChildBlock(this.value);"
                                                                                                    meta:resourcekey="ddlIPTreatmentPlanChildResource1">
                                                                                                </asp:DropDownList>
                                                                                                <input type="hidden" id="hdnIPTreatmentPlanChild" runat="server" />
                                                                                            </td>
                                                                                            <td width="380px;" id="td1" style="display: None">
                                                                                                &nbsp;
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox runat="server" ID="txtIPTreatmentPlanProsthesis" CssClass="Txtboxsmall" Style="width: 150px;"
                                                                                                    meta:resourcekey="txtIPTreatmentPlanProsthesisResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr style="height: 25px;">
                                                                                <td>
                                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                        <tr>
                                                                                            <%-- <td>
                                                                                <asp:CheckBox ID="chkIPTreatmentPlanOthers" onClick="javascript:showIPTreatmentPlanOthersBlock();"
                                                                                    runat="server" Text="Other Treatment Options" />
                                                                            </td>--%>
                                                                                            <td>
                                                                                                <table id="Table5" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                                    <tr id="IPTreatmentPlanOthersBlock" style="display: none;">
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_TreatmentPlanName" Text="TreatmentPlan Name:" runat="server" meta:resourcekey="Rs_TreatmentPlanNameResource1"></asp:Label>
                                                                                                            <input type="text" id="txtIPTreatmentPlanOthers" runat="server" style="width: 200px;" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr id="IPTreatmentPlanOthersChild" style="display: none;">
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_TreatmentPlanName1" Text="TreatmentPlan Name:" runat="server" meta:resourcekey="Rs_TreatmentPlanName1Resource1"></asp:Label>
                                                                                                            <input type="text" id="txtIPTreatmentPlanOthersChild" runat="server" style="width: 200px;" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td valign="middle">
                                                                        <asp:Button ID="btnIPTreatmentPlanAdd" runat="server" Text="Add" CssClass="btn" OnClientClick="return onClickAddIPTreatmentPlan();" meta:resourcekey="btnIPTreatmentPlanAddResource1"/>
                                                                        <%--<input type="button" name="btnIPTreatmentPlanAdd" id="btnIPTreatmentPlanAdd" onclick="onClickAddIPTreatmentPlan();"
                                                                            value="Add" class="btn" />--%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <input type="hidden" id="hdnIPCaseRecordPlan" runat="server" style="width: 600px;" />
                                                            <input type="hidden" id="hdnPerformed" runat="server" style="width: 600px;" />
                                                            <table class="dataheaderInvCtrl" runat="server" cellpadding="4" cellspacing="0" border="1"
                                                                width="100%">
                                                                <tr>
                                                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                                                        <asp:Label ID="Rs_PlannedSurgeryProcedure" Text="Planned Surgery / Procedure" runat="server"
                                                                            meta:resourcekey="Rs_PlannedSurgeryProcedureResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:HiddenField ID="hdnSurgery" runat="server" />
                                                                        <asp:GridView ID="grdCRCplan" runat="server" AutoGenerateColumns="False" OnRowDataBound="grdCRCplan_RowDataBound"
                                                                            meta:resourcekey="grdCRCplanResource1">
                                                                            <Columns>
                                                                                <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource7">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="chkSelect" runat="server" meta:resourcekey="chkSelectResource1" />
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="5%"></ItemStyle>
                                                                                </asp:TemplateField>
                                                                              
                                                                                <asp:TemplateField HeaderText="Type" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource9">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblParentName" runat="server" Text='<%# Bind("ParentID") %>' meta:resourcekey="lblParentIDResource1"></asp:Label>
                                                                                        <asp:Label ID="lblIPTreatmentPlanID" runat="server" Text='<%# Bind("TreatmentPlanID") %>'
                                                                                            meta:resourcekey="lblIPTreatmentPlanIDResource1"></asp:Label>
                                                                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="14%" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Name" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource10">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%# Bind("IPTreatmentPlanName") %>'
                                                                                            meta:resourcekey="lblIPTreatmentPlanNameResource2"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="14%" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Prosthesis" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource11">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblProsthesis" runat="server" Text='<%# Bind("Prosthesis") %>' meta:resourcekey="lblProsthesisResource1"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="14%" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Plan Date" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource12">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblTreatmentPlanDate" runat="server" Text='<%# Bind("TreatmentPlanDate") %>'
                                                                                            meta:resourcekey="lblTreatmentPlanDateResource1"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle Width="14%" />
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblIPTreatmentPlanItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                                                cellspacing="0" border="1">
                                                            </table>
                                                            <input type="hidden" id="hdnIPTreatmentPlanItems" runat="server" style="width: 600px;" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="width: 25%">
                                                            <asp:Label ID="Rs_PreOperativeFindings" Text="Pre-Operative Findings" runat="server"
                                                                meta:resourcekey="Rs_PreOperativeFindingsResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPreOPF" runat="server" Width="75%" TextMode="MultiLine" meta:resourcekey="txtPreOPFResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_OperativeTechnique" Text="Operative Technique" runat="server" meta:resourcekey="Rs_OperativeTechniqueResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtOPT" runat="server" Width="75%" TextMode="MultiLine" meta:resourcekey="txtOPTResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_OperativeFindings" Text="Operative Findings" runat="server" meta:resourcekey="Rs_OperativeFindingsResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtOPF" runat="server" Width="75%" TextMode="MultiLine" meta:resourcekey="txtOPFResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_PostOperativeFindings" Text="Post Operative Findings" runat="server"
                                                                meta:resourcekey="Rs_PostOperativeFindingsResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPostOPF" runat="server" Width="75%" TextMode="MultiLine" meta:resourcekey="txtPostOPFResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--<input type="hidden" id="hdnDiagnosisItems" runat="server" />--%>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <%-- <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="width: 119px;">
                                                            Complication
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox runat="server" ID="txtComplication" Style="width: 150px;" autocomplete="off"></asp:TextBox>
                                                            &nbsp;&nbsp;
                                                            <cc1:AutoCompleteExtender ID="AutoDescValue" runat="server" TargetControlID="txtComplication"
                                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="10"
                                                                FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getComplicationNames"
                                                                ServicePath="~/WebService.asmx">
                                                            </cc1:AutoCompleteExtender>
                                                            <asp:Button ID="btnaddComplication" OnClientClick="javascript:return onClickAddComplicationItems();"
                                                                runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" />
                                                        </td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td valign="top" style="width: 119px;">
                                                            <table id="tblComplicationItems" runat="server" cellpadding="4" cellspacing="0" border="0"
                                                                width="50%">
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>--%>
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td align="center" colspan="4">
                                                <asp:Button ID="btnFinish" runat="server" Text="Save" CssClass="btn" OnClick="btnFinish_Click"
                                                    OnClientClick="javascript:return checkForValues();" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                                    meta:resourcekey="btnCancelResource1" />
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
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <%-- </ContentTemplate>
      </asp:UpdatePanel>--%>
	<asp:HiddenField ID="hdnMessages" runat="server" />
      
    </form>

    <script language="javascript" type="text/javascript">
        LoadIPTreatmentPlanItems();
        LoadNurse();
        LoadTechnician();
        LoadAnesthetist();
        LoadAssistant();
        //LoadDiagnosisItems();
        showIPTreatmentPlanChild(document.getElementById("ddlIPTreatmentPlanMaster").value);
       
    </script>

</body>
</html>
