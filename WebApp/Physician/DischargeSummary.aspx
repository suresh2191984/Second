<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DischargeSummary.aspx.cs"
    Inherits="Physician_DischargeSummary" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc15" %>
<%@ Register Src="~/CommonControls/Advice.ascx" TagName="AdviceControl" TagPrefix="uc7" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/NutritionAdvice.ascx" TagName="Nutrition" TagPrefix="uc16" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Discharge Summary</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>
<script type ="text/javascript" language ="javascript" >
var slist={Type:'<%=Resources.ClientSideDisplayTexts.Physician_Dischargesummary_Type %>',
Name:'<%=Resources.ClientSideDisplayTexts.Physician_Dischargesummary_Name %>',
Prosthesis:'<%=Resources.ClientSideDisplayTexts.Physician_Dischargesummary_Prosthesis %>',
Date:'<%=Resources.ClientSideDisplayTexts.Physician_Dischargesummary_Date %>',
Edit:'<%=Resources.ClientSideDisplayTexts.Common_Edit %>',
Delete:'<%=Resources.ClientSideDisplayTexts.Common_Delete %>'};
</script>
    <script language="javascript" type="text/javascript">

        function checkForValues() {
            if (document.getElementById('txtDischargeDate').value == "") {
                document.getElementById('txtDischargeDate').focus();
                 var userMsg = SListForApplicationMessages.Get('Physician\\DischargeSummary.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the date and time of discharge');
                return false;
                }
            }

            if (document.getElementById('trCIPNo').style.display == "block" && document.getElementById('txtCIPNo').value != "") {

                if (Number(document.getElementById('txtCIPNo').value) == 0) {
                    document.getElementById('txtCIPNo').focus();
                     var userMsg = SListForApplicationMessages.Get('Physician\\DischargeSummary.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                    alert('Provide the valid IP number');
                    return false;
                    }
                }
            }
            if (document.getElementById('<%=hdnuGAdv.ClientID %>').value == 'Y') {
                if (document.getElementById('uGAdv_hdnAdviceNameExists').value == '') {
                 var userMsg = SListForApplicationMessages.Get('Physician\\DischargeSummary.aspx_5');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                    alert('Please Enter General Advice');
                    return false;
                    }
                }
            }
            if (document.getElementById('hdnIcdcode').value == "Y") {
                if (validationICDCode() == false) {
                    return false;
                }

            }
        }
        function expandBox(id) {
            document.getElementById(id).rows = "5";
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1";
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
             var userMsg = SListForApplicationMessages.Get('Physician\\DischargeSummary.aspx_3');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Diagnosis already added');
                return false ;
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




        function showIPTreatmentPlanOthersBlock() {
            if (document.getElementById('IPTreatmentPlanOthersBlock').style.display == "none") {
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "block";
            }
            else {
                document.getElementById('IPTreatmentPlanOthersBlock').style.display = "none";
            }
        }

        //        //Newly Added Probable Treatmet Date By Sami
        //        function showIPTreatmentPlanDateBlock() {
        //            if (document.getElementById('IPTreatmentPlanDateBlock').style.display == "none") {
        //                document.getElementById('IPTreatmentPlanDateBlock').style.display = "block";
        //            }
        //            else {
        //                document.getElementById('IPTreatmentPlanDateBlock').style.display = "none";
        //            }
        //        }
        //End Probable Treatmet Date

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
                row.id = 0;
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
                cell4.innerHTML = slist.Type;
                cell5.innerHTML = slist.Name ;
                Cell6.innerHTML =slist.Prosthesis ;
                Cell7.innerHTML =slist.Date;
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
                    Cell8.innerHTML = "<input onclick='javascript:btnEditOnClick(this.id);' id='" + parseInt(rwNumber) + "~" + masterID + "~" + childID + "~" + masterText + "~" + childText + "~" + prosthesis + "~" + TreatmentDate + "~" + status + "'  value = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";

                }
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


        //Add and Delete IpTreatmentPlan items

        function onClickAddIPTreatmentPlan() {

            var rowNumber = 1;
            var AddStatus = 0;

            var masterID = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].value;
            var masterText = document.getElementById("ddlIPTreatmentPlanMaster").options[document.getElementById("ddlIPTreatmentPlanMaster").selectedIndex].text;

            var childID = "0";
            var childText = "";
            var TreatmentDate;
            //Newly Added
            //            var TreatmentDate = "Will be scheduled later";
            var status = "Planned";


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
                ////                childID = document.getElementById("ddlIPTreatmentPlanChild").options[document.getElementById("ddlIPTreatmentPlanChild").selectedIndex].value
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


            //            if (document.getElementById('chkIPTreatmentPlanDate').checked) {

            //                TreatmentDate = document.getElementById('txtIPTreatmentPlanDate').value;

            //            }


            if (document.getElementById('txtIPTreatmentPlanDate').value == "") {

                TreatmentDate = "Will be scheduled later";
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
                        var userMsg = SListForApplicationMessages.Get('Physician\\DischargeSummary.aspx_4');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                            alert('Prosthesis already exist');
                            return false ;
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

        function DischargeInvNotes(id) {
            var TrID = "tr" + id;
            if (document.getElementById(id).checked == true) {
                document.getElementById(TrID).style.display = 'block';
            }
            else {
                document.getElementById(TrID).style.display = 'none';
            }


        }


    </script>

    <style type="text/css">
        #btnIPTreatmentPlanAdd
        {
            width: 46px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                                    <asp:LinkButton ID="LinkButton1" Text="Home" runat="server" CssClass="details_label_age"
                                        OnClick="lnkHome_Click" meta:resourcekey="LinkButton1Resource1"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_DischargeSummary" Text="Discharge Summary" runat="server" meta:resourcekey="Rs_DischargeSummaryResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000;">
                                                <asp:Label ID="Rs_BloodGroup" Text="Blood Group:" runat="server" meta:resourcekey="Rs_BloodGroupResource1"></asp:Label><asp:Label
                                                    ID="lblBloodgroup" runat="server" meta:resourcekey="lblBloodgroupResource1"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; color: #000;">
                                                <asp:Label ID="Rs_DateofAdmission" Text="Date of Admission:" runat="server" meta:resourcekey="Rs_DateofAdmissionResource1"></asp:Label><asp:Label
                                                    ID="lblDateOfAdmission" runat="server" meta:resourcekey="lblDateOfAdmissionResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <%--  <tr>
                                            <td>
                                                Date of Surgery:<asp:Label ID="lblDateOfSurgery" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>--%>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_SurgeryDetails" Text="Surgery Details" runat="server" meta:resourcekey="Rs_SurgeryDetailsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000;">
                                                <asp:Table runat="server" ID="tblSurgeryDetail" CellPadding="5" CellSpacing="0" GridLines="Both"
                                                    meta:resourcekey="tblSurgeryDetailResource1">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_DishargeDetails" Text="Disharge Details" runat="server" meta:resourcekey="Rs_DishargeDetailsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="2" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td align="center" class="defaultfontcolor">
                                                <asp:Label ID="Rs_DischargeDateAndTime" Text="Discharge Date And Time:" runat="server"
                                                    meta:resourcekey="Rs_DischargeDateAndTimeResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="txtDischargeDate" MaxLength="25" CssClass="Txtboxsmall" size="25" meta:resourcekey="txtDischargeDateResource1"></asp:TextBox>
                                                <a href="javascript:NewCal('<%=txtDischargeDate.ClientID %>','ddmmyyyy',true,12)">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtDischargeDate"
                                                    Mask="99/99/9999 99:99:99" MaskType="DateTime" AcceptAMPM="True" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="MaskedEditExtender6"
                                                    ControlToValidate="txtDischargeDate" IsValidEmpty="False" EmptyValueMessage="Date and time are required"
                                                    InvalidValueMessage="Date and/or time is invalid" Display="Dynamic" TooltipMessage="Input a date and time"
                                                    EmptyValueBlurredText="*" InvalidValueBlurredMessage="*" ValidationGroup="MKE"
                                                    ErrorMessage="MaskedEditValidator6" meta:resourcekey="MaskedEditValidator6Resource1" />
                                            </td>
                                            <td align="center" class="defaultfontcolor">
                                                <asp:Label ID="Rs_TypeofDischarge" Text="Type of Discharge:" runat="server" meta:resourcekey="Rs_TypeofDischargeResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlDischrageType" runat="server" meta:resourcekey="ddlDischrageTypeResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <%-- <td style="font-weight: normal; height: 20px; color: #000; width: 50%;">
                                                Clinical Diagnosis
                                                <asp:TextBox runat="server" ID="txtDiagnosis" Style="width: 150px;" autocomplete="off"></asp:TextBox>
                                                &nbsp;&nbsp;
                                                <cc1:AutoCompleteExtender ID="AutoDescValue" runat="server" TargetControlID="txtDiagnosis"
                                                    CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="10"
                                                    FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                                    ServicePath="~/WebService.asmx">
                                                </cc1:AutoCompleteExtender>
                                                <asp:Button ID="btnDiagnosisAdd" OnClientClick="javascript:return onClickAddDiagnosis();"
                                                    runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" />
                                                <input type="hidden" id="hdnDiagnosisItems" runat="server" />
                                                <table id="tblDiagnosisItems" runat="server" cellpadding="4" cellspacing="0" border="0"
                                                    width="50%">
                                                </table>
                                            </td>--%>
                                            <td>
                                                <asp:Label ID="Rs_Procedure" Text="Procedure" runat="server" meta:resourcekey="Rs_ProcedureResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" Rows="1" ID="txtProcedures" TextMode="MultiLine" Style="width: 220px;
                                                    height: 60px;" meta:resourcekey="txtProceduresResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                                <asp:HiddenField runat="server" ID="hdnIcdcode" Value="N" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="2" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_HistoryOfPresentIllness" Text="History Of Present Illness" runat="server"
                                                    meta:resourcekey="Rs_HistoryOfPresentIllnessResource1"></asp:Label>
                                            </td>
                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_PastMedicalHistory" Text="Past Medical History" runat="server"
                                                    meta:resourcekey="Rs_PastMedicalHistoryResource1"></asp:Label>
                                            </td>
                                            <%-- <td style="font-weight: bold; height: 20px; color: #000;">
                                                Clinical Examination
                                            </td>--%>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <table class="dataheaderInvCtrl" cellspacing="0" border="0" width="50%">
                                                    <tr class="defaultfontcolor">
                                                        <td valign="top">
                                                            <asp:Table runat="server" ID="tbPresentHistory" CssClass="colorforcontentborder"
                                                                CellSpacing="0" BorderWidth="0px" meta:resourcekey="tbPresentHistoryResource1">
                                                            </asp:Table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top">
                                                <table class="dataheaderInvCtrl" cellspacing="0" border="0" width="50%">
                                                    <tr class="defaultfontcolor">
                                                        <td valign="top">
                                                            <asp:Table runat="server" ID="tbPasthistory" CssClass="colorforcontentborder" CellSpacing="0"
                                                                BorderWidth="0px" meta:resourcekey="tbPasthistoryResource1">
                                                            </asp:Table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbtEditHistory" runat="server" Text="Edit History" ForeColor="Black"
                                                    Font-Underline="True" OnClick="lbtEditHistory_Click" meta:resourcekey="lbtEditHistoryResource1"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="tdDischargeInv" runat="server" style="display: none;">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkPreOpInv" Text="Pre-Op Investigation" runat="server" onclick="javascript:DischargeInvNotes(this.id);"
                                                                meta:resourcekey="chkPreOpInvResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trchkPreOpInv" runat="server" style="display: none;">
                                                        <td>
                                                            <asp:TextBox ID="txtPreOpInv" runat="server" TextMode="MultiLine" Rows="1" Style="width: 220px;
                                                                height: 60px;" meta:resourcekey="txtPreOpInvResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkPostOpInv" Text="Post-Op Investigation" runat="server" onclick="javascript:DischargeInvNotes(this.id);"
                                                                meta:resourcekey="chkPostOpInvResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trchkPostOpInv" runat="server" style="display: none;">
                                                        <td>
                                                            <asp:TextBox ID="txtPostOpInv" runat="server" TextMode="MultiLine" Rows="1" Style="width: 220px;
                                                                height: 60px;" meta:resourcekey="txtPostOpInvResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkRoutineInv" Text="Routine Investigation" runat="server" onclick="javascript:DischargeInvNotes(this.id);"
                                                                meta:resourcekey="chkRoutineInvResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trchkRoutineInv" runat="server" style="display: none;">
                                                        <td>
                                                            <asp:TextBox ID="txtRoutineInv" runat="server" TextMode="MultiLine" Rows="1" Style="width: 220px;
                                                                height: 60px;" meta:resourcekey="txtRoutineInvResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_HospitalCourse" Text="Hospital Course" runat="server" meta:resourcekey="Rs_HospitalCourseResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <%--<td style="width: 114px;">
                                                Hospital Course
                                            </td>--%>
                                            <td colspan="2">
                                                <FCKeditorV2:FCKeditor ID="fckHospitalCourse" runat="server" Width="100%" Height="200px">
                                                </FCKeditorV2:FCKeditor>
                                                <%--<asp:TextBox ID="txtHospitalCourse" runat="server" Width="75%" TextMode="MultiLine"></asp:TextBox>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="tbHispitalCourse">
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <td style="color: #000;">
                                                <asp:Label ID="Rs_ConditionOnDischarge" Text="Condition On Discharge:" runat="server"
                                                    meta:resourcekey="Rs_ConditionOnDischargeResource1"></asp:Label>
                                                <asp:TextBox ID="txtConditionOnDischarge" runat="server" CssClass ="Txtboxsmall" meta:resourcekey="txtConditionOnDischargeResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trDischargeVitals" style="display: none" runat="server">
                                <td>
                                    <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_DischargeVitals" Text="Discharge Vitals" runat="server" meta:resourcekey="Rs_DischargeVitalsResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td valign="top">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:Table runat="server" ID="tbClinicalInfo" CssClass="dataheaderInvCtrl" CellSpacing="0"
                                                                BorderWidth="1px" CellPadding="8" GridLines="Both" Width="100%" meta:resourcekey="tbClinicalInfoResource1">
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
                                                <asp:Label ID="Rs_TreatmentPlan" Text="Treatment Plan" runat="server" meta:resourcekey="Rs_TreatmentPlanResource1"></asp:Label>
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
                                                                                    <asp:DropDownList ID="ddlIPTreatmentPlanMaster" onchange="javascript:showIPTreatmentPlanChild(this.value);" CssClass ="ddl"
                                                                                        runat="server" meta:resourcekey="ddlIPTreatmentPlanMasterResource1">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td style="font-weight: bold; color: #000;">
                                                                                    <asp:Label ID="Rs_Prosthesis" Text="Prosthesis" runat="server" meta:resourcekey="Rs_ProsthesisResource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td width="380px;" id="tdIPTreatmentPlanChild" style="display: block">
                                                                                    <asp:DropDownList ID="ddlIPTreatmentPlanChild" runat="server" onchange="javascript:showIPTreatmentPlanOthersChildBlock(this.value);" CssClass="ddl"
                                                                                        meta:resourcekey="ddlIPTreatmentPlanChildResource1">
                                                                                    </asp:DropDownList>
                                                                                    <input type="hidden" id="hdnIPTreatmentPlanChild" runat="server" />
                                                                                </td>
                                                                                <td width="380px;" id="td1" style="display: None">
                                                                                    &nbsp;
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox runat="server" ID="txtIPTreatmentPlanProsthesis"  CssClass="Txtboxsmall"
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
                                                                                    <table id="Table1" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
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
                                                                <tr style="height: 25px;">
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td>
                                                                                    <%--      <asp:CheckBox ID="chkIPTreatmentPlanDate" onClick="javascript:showIPTreatmentPlanDateBlock();"
                                                                                        runat="server" Text="Probable Treatment Date" />--%><asp:Label ID="Rs_ProbableTreatmentDate"
                                                                                            Text="Probable Treatment Date" runat="server" meta:resourcekey="Rs_ProbableTreatmentDateResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <table id="IPTreatmentPlanDateBlock" style="display: block;" runat="server" cellpadding="0"
                                                                                        cellspacing="0" border="0" width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="text" id="txtIPTreatmentPlanDate" runat="server" style="width: 200px;" />
                                                                                                <a href="javascript:NewCal('<%=txtIPTreatmentPlanDate.ClientID %>','ddmmyyyy',true,12)">
                                                                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                                                <%-- &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />--%>
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
                                                            <input type="button" name="btnIPTreatmentPlanAdd" id="btnIPTreatmentPlanAdd" onclick="onClickAddIPTreatmentPlan();"
                                                                value="Add" class="btn" />
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
                            <tr>
                                <td>
                                    <table id="submitTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <uc7:AdviceControl ID="uAd" runat="server" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <uc15:GeneralAdv ID="uGAdv" runat="server" />
                                                <asp:HiddenField runat="server" ID="hdnuGAdv" Value="N" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdNutrition" runat="server">
                                                <uc16:Nutrition ID="uNAdv" runat="server" />
                                                <asp:HiddenField runat="server" ID="hdnNuAdvc" Value="N" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"
                                                    meta:resourcekey="lblTxtResource1"></asp:Label>
                                                <asp:DropDownList ID="ddlNos" CssClass ="ddl" runat="server" meta:resourcekey="ddlNosResource1">
                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource19">0</asp:ListItem>
                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource8">1</asp:ListItem>
                                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource9">2</asp:ListItem>
                                                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource10">3</asp:ListItem>
                                                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource11">4</asp:ListItem>
                                                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource12">5</asp:ListItem>
                                                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource13">6</asp:ListItem>
                                                    <asp:ListItem Value="7" meta:resourcekey="ListItemResource14">7</asp:ListItem>
                                                    <asp:ListItem Value="8" meta:resourcekey="ListItemResource15">8</asp:ListItem>
                                                    <asp:ListItem Value="9" meta:resourcekey="ListItemResource16">9</asp:ListItem>
                                                    <asp:ListItem Value="10" meta:resourcekey="ListItemResource17">10</asp:ListItem>
                                                    <asp:ListItem Value="11" meta:resourcekey="ListItemResource18">11</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddlDMY" runat="server"   CssClass="ddl" meta:resourcekey="ddlDMYResource1">
                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                                    <asp:ListItem Value="Day(s)" meta:resourcekey="ListItemResource2">Day(s)</asp:ListItem>
                                                    <asp:ListItem Value="Week(s)" meta:resourcekey="ListItemResource3">Week(s)</asp:ListItem>
                                                    <asp:ListItem Value="Month(s)" meta:resourcekey="ListItemResource4">Month(s)</asp:ListItem>
                                                    <asp:ListItem Value="Year(s)" meta:resourcekey="ListItemResource5">Year(s)</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:TextBox ID="txtNextReviewDate" runat="server" MaxLength="25" size="25" CssClass ="Txtboxsmall" meta:resourcekey="txtNextReviewDateResource1"></asp:TextBox>
                                                <a href="javascript:NewCal('<%=txtNextReviewDate.ClientID %>','ddmmyyyy',true,12)">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td cssclass="defaultfontcolor">
                                                <asp:Label ID="lblreviewreason" runat="server" Text="Reason For Review: " CssClass="defaultfontcolor"
                                                    meta:resourcekey="lblreviewreasonResource1"></asp:Label>
                                                <asp:TextBox ID="txtReviewReason" runat="server" TextMode="MultiLine" Rows="1" Style="width: 220px;
                                                    height: 60px;" meta:resourcekey="txtReviewReasonResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="Discharge Summary Status: " CssClass="defaultfontcolor"
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                                <asp:DropDownList ID="ddlDisStatus" runat="server" CssClass="Txtboxsmall" meta:resourcekey="ddlDisStatusResource1">
                                                    <asp:ListItem meta:resourcekey="ListItemResource6">InProgress</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource7">Completed</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td cssclass="defaultfontcolor">
                                                <asp:Label ID="Label2" runat="server" Text="Prepared By: " CssClass="defaultfontcolor"
                                                    meta:resourcekey="Label2Resource1"></asp:Label><asp:TextBox ID="txtPreparedBy" runat="server" CssClass ="Txtboxsmall"
                                                        meta:resourcekey="txtPreparedByResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="trCIPNo" runat="server" style="display: none;">
                                            <td cssclass="defaultfontcolor">
                                                <asp:HiddenField ID="hdnCIPNo" runat="server" />
                                                <asp:Label ID="Label3" runat="server" Text="IP Number: " CssClass="defaultfontcolor"
                                                    meta:resourcekey="Label3Resource1"></asp:Label>
                                                <asp:TextBox ID="txtCIPNo" runat="server" CssClass ="Txtboxsmall" meta:resourcekey="txtCIPNoResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkPNE" runat="server" Text="Print With Negative Examination" meta:resourcekey="chkPNEResource1" /><asp:CheckBox
                                                    ID="chkPNH" runat="server" Text="Print With Negative History" meta:resourcekey="chkPNHResource1" /><asp:CheckBox
                                                        ID="chkGAdv" runat="server" Text="Print With General Advice" meta:resourcekey="chkGAdvResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="4">
                                                <asp:Button ID="btnFinish" runat="server" Text="Save" CssClass="btn" OnClick="btnFinish_Click"
                                                    OnClientClick="javascript:return checkForValues();" meta:resourcekey="btnFinishResource1" />
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
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        //   LoadDiagnosisItems();
        LoadIPTreatmentPlanItems();
        showIPTreatmentPlanChild(document.getElementById("ddlIPTreatmentPlanMaster").value);
    </script>

</body>
</html>
