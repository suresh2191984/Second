<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysiotherapyNotes.aspx.cs"
    Inherits="InPatient_PhysiotherapyNotes" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Physiotherapy Notes</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

	
    <script language="javascript" type="text/javascript">

        function showdiv() {


            if (document.getElementById('tblPrevVisit').style.display == "none") {
                document.getElementById('tblPrevVisit').style.display = "block";
            }
            else {
                document.getElementById('tblPrevVisit').style.display = "none";
            }

        }

        function showdivone() {

            if (document.getElementById('tblPPDT').style.display == "none") {
                document.getElementById('tblPPDT').style.display = "block";
            }
            else {
                document.getElementById('tblPPDT').style.display = "none";
            }

        }

        function showdivs() {

            if (document.getElementById('tblPrevSOI').style.display == "none") {
                document.getElementById('tblPrevSOI').style.display = "block";
            }
            else {
                document.getElementById('tblPrevSOI').style.display = "none";
            }

        }

        function showdivsbp() {

            if (document.getElementById('tblBP').style.display == "none") {
                document.getElementById('tblBP').style.display = "block";
            }
            else {
                document.getElementById('tblBP').style.display = "none";
            }

        }


        //        function checkForValues() {



        //            //            if (document.getElementById('ddlPhysio').value == "--Select--") {
        //            //                alert("Please Select The Physiotheraphy.");
        //            //                return false;
        //            //            }

        //            //            if (document.getElementById('txtAdVNoSitting').value == 0) {
        //            //                alert("Please Enter The Advised No of sitting.");
        //            //                return false;
        //            //            }

        //            //            if (document.getElementById('txtDutation').value == 0) {
        //            //                alert("Please Enter The Dutation.");
        //            //                return false;
        //            //            }

        //        }
        function HsPending(pCName) {
            if (pCName != "") {

                if (Number(pCName) > 0) {


                    if (Number(pCName) > Number(document.getElementById('txtCurrentNoSitting').value)) {
                        document.getElementById('chkPendingSitting').checked = true;
                    }
                    else {
                        if (Number(pCName) == Number(document.getElementById('txtCurrentNoSitting').value)) {
                            document.getElementById('chkPendingSitting').checked = false;
                            //                            document.getElementById('tdAddMore').style.display = 'block';
                        }

                    }

                }
            }
        }



        function getPhysioDetails() {

            document.getElementById('txtCurrentNoSitting').value = "";
            document.getElementById('hdnProcID').value = "";
            document.getElementById('txtAdVNoSitting').value = "";
            document.getElementById('txtDutation').value = "";
            document.getElementById('txtSCV').value = "";
            document.getElementById('txtRemarks').value = "";
            if (document.getElementById('ddlPhysio').options[document.getElementById('ddlPhysio').selectedIndex].text != "--Select--") {
                var PhysioValue = document.getElementById('ddlPhysio').value
                var ProcID = PhysioValue.split('|')[0];
                document.getElementById('hdnProcID').value = PhysioValue;
                var Current = PhysioValue.split('|')[1];
                var Advised = PhysioValue.split('|')[2];

                var comments = PhysioValue.split('|')[3];
                document.getElementById('hdnComments').value = comments;
                document.getElementById('txtComments').value = comments;
                if (Number(Advised) > 0) {
                    document.getElementById('txtAdVNoSitting').value = Advised;
                }
                document.getElementById('txtCurrentNoSitting').value = Number(Current) + 1;
                //                if (document.getElementById('txtCurrentNoSitting').value == 1) {
                //                    document.getElementById('tbVtype').style.display = "none";
                //                }
                //                else {
                //                    document.getElementById('tbVtype').style.display = "block";
                //                }


                if (Number(Advised) > 0) {

                    if (Number(Advised) == Number(document.getElementById('txtCurrentNoSitting').value)) {

                        document.getElementById('chkPendingSitting').checked = false;
                        document.getElementById('chkPendingSitting').disabled = true;
                        //                        document.getElementById('tdAddMore').style.display = 'block';
                    }
                    else {
                        document.getElementById('chkPendingSitting').checked = true;
                        document.getElementById('chkPendingSitting').disabled = false;
                        //                        document.getElementById('tdAddMore').style.display = 'none';
                    }

                }

            }

        }

        function onClickAddPhysioItems() {

            //hdnPhysioItems
            if (document.getElementById('ddlPhysio').value == "--Select--") {
                document.getElementById('ddlPhysio').focus();
                alert('Select the Procedure');
                return false;
            }
            if (document.getElementById('txtAdVNoSitting').value == 0) {
                document.getElementById('txtAdVNoSitting').focus();
                alert("Provide the advised number of sittings");
                return false;
            }
            if (document.getElementById('txtDutation').value == 0) {
                document.getElementById('txtDutation').focus();
                alert("Provide duration");
                return false;
            }

            var Procname = document.getElementById('ddlPhysio').options[document.getElementById('ddlPhysio').selectedIndex].text;
            var ProcID = document.getElementById('hdnProcID').value;
            var Current = document.getElementById('txtCurrentNoSitting').value;
            var Advised = document.getElementById('txtAdVNoSitting').value;
            var Duration = document.getElementById('txtDutation').value;
            var DurationUnits = document.getElementById('ddlDurationUnits').options[document.getElementById('ddlDurationUnits').selectedIndex].text;
            var SCV = document.getElementById('txtSCV').value;
            var Notes = document.getElementById('txtRemarks').value;
            var Comments = document.getElementById('txtComments').value;
            var HasPending;
            var lbl = document.getElementById("lblCount");
            lbl.innerHTML = 0;
            document.getElementById('tblPhysioItems').disabled = false;
            document.getElementById('tblPhysioItems').style.visibility = "visible";
            document.getElementById('AddMore').disabled = false;
            document.getElementById('btnFinish').disabled = false;
            document.getElementById('txtComments').value = '';
            if (Number(Advised) < Number(Current)) {
                alert("Advise of Sitting Is Not Less Than Current Sitting");
                return false;
            }

            if (Advised == Current) {
                document.getElementById("AddMore").disabled = true;
            }
            else {
                document.getElementById("AddMore").disabled = false;
            }

            if (document.getElementById('chkPendingSitting').checked) {
                HasPending = "Yes";
            }
            else {
                HasPending = "No";
            }
            document.getElementById('tblPhysioItems').style.display = 'block';
            var rwNumber = parseInt(110);
            var AddStatus = 0;

            var HidValue = document.getElementById('hdnPhysioItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnPhysioItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var PList = list[count].split('~');
                    if (PList[1] != '') {
                        if (PList[0] != '') {
                            rwNumber = parseInt(parseInt(PList[0]) + parseInt(1));
                        }
                        if (Procname != '') {
                            if (PList[1] == Procname) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (Procname != '') {

                    if (document.getElementById('tblPhysioItems').rows.length < 1) {


                        var row = document.getElementById('tblPhysioItems').insertRow(0);
                        row.style.color = "white";
                        row.style.backgroundColor = "#2c88b1";
                        row.id = 0;
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);
                        var cell6 = row.insertCell(5);
                        var cell7 = row.insertCell(6);
                        var cell8 = row.insertCell(7);
                        var cell9 = row.insertCell(8);
                        var cell10 = row.insertCell(9);
                        var cell11 = row.insertCell(10);
                        var cell12 = row.insertCell(11);
                        cell1.innerHTML = "<b>Delete</b>";
                        cell1.width = "6%";
                        cell1.height = "2px";
                        cell2.innerHTML = "<b>Physiotherapy</b>";
                        cell2.height = "2px";
                        cell3.innerHTML = "<b>ProcID</b>";
                        cell3.style.display = "none";
                        cell3.height = "2px";
                        cell4.innerHTML = "<b>Current Duration</b>";
                        cell4.height = "2px";
                        cell5.innerHTML = "<b>DurationUnits</b>";
                        cell5.height = "2px";
                        cell5.style.display = "none";
                        cell6.innerHTML = "<b>Adviced Sitting's</b>";
                        cell6.height = "2px";
                        cell7.innerHTML = "<b>Current Sitting</b>";
                        cell7.height = "2px";
                        cell8.innerHTML = "<b>SCV</b>";
                        cell8.height = "2px";
                        cell8.style.display = "none";
                        cell9.innerHTML = "<b>Notes</b>";
                        cell9.height = "2px";
                        cell10.innerHTML = "<b>Pending Status</b>";
                        cell10.height = "2px";
                        cell11.innerHTML = "<b>Comments</b>";
                        cell11.style.display = "none";
                        cell11.height = "2px";
                        cell12.innerHTML = "<b>Action</b>";
                        cell12.height = "2px";

                    }


                    var row = document.getElementById('tblPhysioItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);
                    var cell11 = row.insertCell(10);
                    var cell12 = row.insertCell(11);

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPhysio(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = Procname;
                    cell3.innerHTML = ProcID;
                    cell3.style.display = "none";
                    cell4.innerHTML = Duration + ' ' + DurationUnits;
                    cell5.innerHTML = DurationUnits;
                    cell5.style.display = "none";
                    cell6.innerHTML = Advised;
                    cell7.innerHTML = Current;
                    cell8.innerHTML = SCV;
                    cell8.style.display = "none";
                    cell9.innerHTML = Notes;
                    cell10.innerHTML = HasPending;
                    cell11.innerHTML = Comments;
                    cell11.style.display = "none";
                    cell12.innerHTML = "<input onclick='btnEditP_OnClick(name);' name='" + parseInt(rwNumber) + "~" + Procname + "~" + ProcID + "~" + Duration + "~" + DurationUnits + "~" + Advised + "~" + Current + "~" + SCV + "~" + Notes + "|" + Comments + "~" + HasPending + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('hdnPhysioItems').value += parseInt(rwNumber) + "~" + Procname + "~" + ProcID + "~" + Duration + "~" + DurationUnits + "~" + Advised + "~" + Current + "~" + SCV + "~" + Notes + "|" + Comments + "~" + HasPending + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (Procname != '') {


                    if (document.getElementById('tblPhysioItems').rows.length < 1) {


                        var row = document.getElementById('tblPhysioItems').insertRow(0);
                        row.style.color = "white";
                        row.style.backgroundColor = "#2c88b1";
                        row.id = 0;
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);
                        var cell6 = row.insertCell(5);
                        var cell7 = row.insertCell(6);
                        var cell8 = row.insertCell(7);
                        var cell9 = row.insertCell(8);
                        var cell10 = row.insertCell(9);
                        var cell11 = row.insertCell(10);
                        var cell12 = row.insertCell(11);
                        cell1.innerHTML = "<b>Delete</b>";
                        cell1.width = "6%";
                        cell1.height = "2px";
                        cell2.innerHTML = "<b>Physiotherapy</b>";
                        cell2.height = "2px";
                        cell3.innerHTML = "<b>ProcID</b>";
                        cell3.height = "2px";
                        cell3.style.display = "none";
                        cell4.innerHTML = "<b>Duration</b>";
                        cell4.height = "2px";
                        cell5.innerHTML = "<b>DurationUnits</b>";
                        cell5.style.display = "none";
                        cell5.height = "2px";
                        cell6.innerHTML = "<b>Adviced Sitting's</b>";
                        cell6.height = "2px";
                        cell7.innerHTML = "<b>Current Sitting</b>";
                        cell7.height = "2px";
                        cell8.innerHTML = "<b>SCV</b></center>";
                        cell8.height = "2px";
                        cell9.innerHTML = "<b>Notes</b>";
                        cell9.height = "2px";
                        cell10.innerHTML = "<b>Pending Status</b>";
                        cell10.height = "2px";
                        cell11.innerHTML = "<b>Comments</b>";
                        cell11.height = "2px";
                        cell11.style.display = "none";
                        cell12.innerHTML = "<b>Action</b>";
                        cell12.height = "2px";
                        cell8.style.display = "none";
                    }


                    var row = document.getElementById('tblPhysioItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);
                    var cell11 = row.insertCell(10);
                    var cell12 = row.insertCell(11);

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPhysio(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = Procname;
                    cell3.innerHTML = ProcID;
                    cell3.style.display = "none";
                    cell4.innerHTML = Duration + ' ' + DurationUnits;
                    cell5.innerHTML = DurationUnits;
                    cell5.style.display = "none";
                    cell6.innerHTML = Advised;
                    cell7.innerHTML = Current;
                    cell8.innerHTML = SCV;
                    cell9.innerHTML = Notes;
                    cell10.innerHTML = HasPending;
                    cell11.innerHTML = Comments;
                    cell11.style.display = "none";
                    cell8.style.display = "none";
                    cell12.innerHTML = "<input onclick='btnEditP_OnClick(name);' name='" + parseInt(rwNumber) + "~" + Procname + "~" + ProcID + "~" + Duration + "~" + DurationUnits + "~" + Advised + "~" + Current + "~" + SCV + "~" + Notes + "|" + Comments + "~" + HasPending + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    document.getElementById('hdnPhysioItems').value += parseInt(rwNumber) + "~" + Procname + "~" + ProcID + "~" + Duration + "~" + DurationUnits + "~" + Advised + "~" + Current + "~" + SCV + "~" + Notes + "|" + Comments + "~" + HasPending + "^";
                }
            }
            else if (AddStatus == 1) {
                alert("Procedure Already Added! Please Save and Add Again");
            }

            document.getElementById('txtCurrentNoSitting').value = "";
            document.getElementById('hdnProcID').value = "";
            document.getElementById('txtAdVNoSitting').value = "";
            document.getElementById('txtDutation').value = "";
            document.getElementById('txtSCV').value = "";
            document.getElementById('txtRemarks').value = "";
            document.getElementById('txtComments').value = "";
            document.getElementById('ddlPhysio').options[0].selected = true;
            document.getElementById('ddlDurationUnits').options[0].selected = true;
            //            document.getElementById('tdAddMore').style.display = 'none';
            document.getElementById('chkPendingSitting').checked = false;

            return false;

        }

        function ImgOnclickPhysio(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnPhysioItems').value;
            var list = HidValue.split('^');
            var newCList = '';
            if (document.getElementById('hdnPhysioItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var PList = list[count].split('~');
                    if (PList[0] != '') {
                        if (PList[0] != ImgID) {
                            newCList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnPhysioItems').value = newCList;
            }
            if (document.getElementById('hdnPhysioItems').value == '') {
                var tbLen = document.getElementById('tblPhysioItems').rows.length;
                for (var i = 0; i < tbLen; i++) {
                    document.getElementById('tblPhysioItems').deleteRow(i);
                    tbLen--;
                    i--;
                }
                document.getElementById('tblPhysioItems').style.display = 'none';
            }
        }


        function btnEditP_OnClick(sEditedData) {

            document.getElementById('ddlPhysio').focus();
            var arrayAlreadyPresentDatas = new Array();
            var iAlreadyPresent = 0;
            var iCount = 0;
            var tempDatas = document.getElementById('hdnPhysioItems').value;
            document.getElementById('tblPhysioItems').disabled = true;
            var comments = document.getElementById('hdnComments').value;
            document.getElementById('txtComments').value = comments;
            if (document.getElementById('tblPhysioItems').rows.length < 3) {
                document.getElementById('tblPhysioItems').style.visibility = "hidden";
            }
            else {
                document.getElementById('tblPhysioItems').style.visibility = "visible";
            }

            document.getElementById('AddMore').disabled = true;
            document.getElementById('btnFinish').disabled = true;
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



                // parseInt(rwNumber) + "~" + Procname + "~" + ProcID + "~" +;
                //Duration + "~" + DurationUnits + "~" + Advised + "~" + Current ;
                // + "~" + SCV + "~" + Notes + "~" + HasPending;

                document.getElementById('txtCurrentNoSitting').value = arrayGotValue[6];
                document.getElementById('hdnProcID').value = arrayGotValue[2];
                document.getElementById('txtAdVNoSitting').value = arrayGotValue[5];
                document.getElementById('txtDutation').value = arrayGotValue[3];
                document.getElementById('txtSCV').value = arrayGotValue[7];
                document.getElementById('txtRemarks').value = arrayGotValue[8].split('|')[0];
                document.getElementById('ddlPhysio').value = arrayGotValue[2];
                var lbl = document.getElementById("lblCount");
                //                if (arrayGotValue[6] == arrayGotValue[5]) {
                //                    document.getElementById('tdAddMore').style.display = 'block';
                //                }
                lbl.innerHTML = document.getElementById('txtRemarks').value.length;
                if (arrayGotValue[4] == "Hour(s)") {
                    document.getElementById('ddlDurationUnits').value = 1;
                }
                else if (arrayGotValue[4] == "Min(s)") {
                    document.getElementById('ddlDurationUnits').value = 2;
                }
                else {
                    document.getElementById('ddlDurationUnits').value = 3;

                }
                if (arrayGotValue[9] == "Yes") {
                    document.getElementById('chkPendingSitting').checked = true;
                }
                else {
                    document.getElementById('chkPendingSitting').checked = false;
                }


            }

            document.getElementById('hdnPhysioItems').value = tempDatas;
            LoadPhysioItems();
        }

        function LoadPhysioItems() {
            var HidValue = document.getElementById('hdnPhysioItems').value;

            var list = HidValue.split('^');

            while (count = document.getElementById('tblPhysioItems').rows.length) {

                for (var j = 0; j < document.getElementById('tblPhysioItems').rows.length; j++) {
                    document.getElementById('tblPhysioItems').deleteRow(j);

                }
            }

            if (document.getElementById('tblPhysioItems').rows.length < 1) {


                var row = document.getElementById('tblPhysioItems').insertRow(0);
                row.style.color = "white";
                row.style.backgroundColor = "#2c88b1";
                row.id = 0;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                var cell11 = row.insertCell(10);
                var cell12 = row.insertCell(11);
                cell1.innerHTML = "<b>Delete</b></center>";
                cell1.width = "6%";
                cell1.height = "2px";
                cell2.innerHTML = "<b>Physiotherapy</b>";
                cell2.height = "2px";
                cell3.innerHTML = "<b>ProcID</b>";
                cell3.height = "2px";
                cell3.style.display = "none";
                cell4.innerHTML = "<b>Current Duration</b>";
                cell4.height = "2px";
                cell5.innerHTML = "<b>DurationUnits</b>";
                cell5.style.display = "none";
                cell5.height = "2px";
                cell6.innerHTML = "<b>Adviced Sitting's</b>";
                cell6.height = "2px";
                cell7.innerHTML = "<b>Current Sitting</b>";
                cell7.height = "2px";
                cell8.innerHTML = "<b>SCV</b>";
                cell8.height = "2px";
                cell9.innerHTML = "<b>Notes</b>";
                cell9.height = "2px";
                cell10.innerHTML = "<b>Pending Status</b>";
                cell10.height = "2px";
                cell11.innerHTML = "<b>Comments</b>";
                cell11.height = "2px";
                cell11.style.display = "none";
                cell12.innerHTML = "<b>Action</b>";
                cell12.height = "2px";
                cell8.style.display = "none";
            }


            if (document.getElementById('hdnPhysioItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var PList = list[count].split('~');
                    var row = document.getElementById('tblPhysioItems').insertRow(1);
                    row.id = PList[0];
                    var rwNumber = PList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);
                    var cell11 = row.insertCell(10);
                    var cell12 = row.insertCell(11);

                    // parseInt(rwNumber) + "~" + Procname + "~" + ProcID + "~" +;
                    //Duration + "~" + DurationUnits + "~" + Advised + "~" + Current ;
                    // + "~" + SCV + "~" + Notes + "~" + HasPending;

                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickPhysio(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = PList[1];
                    cell3.innerHTML = PList[2];
                    cell3.style.display = "none";
                    cell4.innerHTML = PList[3] + ' ' + PList[4];
                    cell5.innerHTML = PList[4];
                    cell5.style.display = "none";
                    cell6.innerHTML = PList[5];
                    cell7.innerHTML = PList[6];
                    cell8.innerHTML = PList[7];
                    cell9.innerHTML = PList[8].split('|')[0];
                    cell10.innerHTML = PList[9];
                    cell11.innerHTML = PList[8].split('|')[1];
                    cell12.innerHTML = "<input onclick='btnEditP_OnClick(name);' name='" + parseInt(rwNumber) + "~" + PList[1] + "~" + PList[2] + "~" + PList[3] + "~" + PList[4] + "~" + PList[5] + "~" + PList[6] + "~" + PList[7] + "~" + PList[8] + "~" + PList[9] + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                    cell8.style.display = "none";

                }
            }
        }



        function ShowhideTable() {

            //0(Add physio)  1(Edit Physio)
            if (document.getElementById('ddlType').value == 0) {

                document.getElementById('tblAddPhysiotherophy').style.display = "block";
                document.getElementById('tblPhysioItems').style.display = "block";
                document.getElementById('tblPPDT').style.display = "none";
                document.getElementById('btnFinish').value = "Save";
                document.getElementById('hdnType').value = "Save";
                document.getElementById('trNxtReview').style.display = "block";
                document.getElementById('AddMore').style.display = "block";



            }
            else {
                document.getElementById('trNxtReview').style.display = "none";
                document.getElementById('tblAddPhysiotherophy').style.display = "none";
                document.getElementById('tblPhysioItems').style.display = "none";
                document.getElementById('tblPPDT').style.display = "block";
                document.getElementById('btnFinish').value = "Update";
                document.getElementById('hdnType').value = "Update";
                document.getElementById('AddMore').style.display = "None";

            }



        }

        function checkForValues() {
            var phyCom = document.getElementById('FCKeditorRef');
            var text = null; var oEditor = FCKeditorAPI.GetInstance('FCKeditorRef');
            if (document.getElementById('ddlPhysio').value != "--Select--") {
                document.getElementById('ddlPhysio').focus();
                alert('Add Procedure Notes');
                return false;
            }
            if (document.getElementById('btnFinish').value == "Update") {
                var HidValue = document.getElementById('hdnChkValues').value;
                var list = HidValue.split('^');
                if (document.getElementById('hdnChkValues').value != "") {
                    for (var count = 0; count < list.length; count++) {
                        var gridItems = list[count].split('~');
                        if (gridItems.length > 2) {
                            if (document.getElementById(gridItems[0]).value == '' && document.getElementById(gridItems[0]).value != "0") {
                                alert("Enter The Duration");
                                document.getElementById(gridItems[0]).focus();
                                return false;
                            }


                            if (Number(document.getElementById(gridItems[1]).value) < Number(document.getElementById(gridItems[2]).value)) {
                                alert("Adviced Sitting Is Less Than Performed");
                                document.getElementById(gridItems[1]).focus();
                                return false;
                            }
                        }
                    }
                }
            }


            if (document.getElementById('btnFinish').value != "Update") {
                if (document.getElementById('hdnPhysioItems').value == "") {
                    alert("Select any Procedure");
                    document.getElementById('btnPhysioAdd').focus();
                    return false;
                }
            }

            //19/7/2012"
            //17/07/2012

            var chooseDate = document.getElementById('txtActualDate').value;
            var id = document.getElementById('txtActualDate').id;          
            if (chooseDate != '') {
                if (chooseDate.split('/')[2] >= dtToday.getFullYear()) {
                    if (chooseDate.split('/')[1] >= (dtToday.getMonth() + 1)) {
                        if (chooseDate.split('/')[0] > dtToday.getDate()) {
                            return true;
                        }
                        else {
                            AlertMsg(id);
                            return false;
                        }
                    }
                    else {
                        AlertMsg(id);
                        return false;
                    }
                }
                else {
                    AlertMsg(id);
                    return false;
                }
            }
        }
        function ValidatePrevDate(id) {
            var chooseDate = document.getElementById(id).value;
            if (chooseDate != '') {
                if (chooseDate.split('/')[2] >= dtToday.getFullYear()) {
                    if (chooseDate.split('/')[1] >= (dtToday.getMonth() + 1)) {
                        if (chooseDate.split('/')[0] > dtToday.getDate()) {
                            return true;
                        }
                        else {
                            AlertMsg(id);
                            return false;
                        }
                    }
                    else {
                        AlertMsg(id);
                        return false;
                    }
                }
                else {
                    AlertMsg(id);
                    return false;
                }
            }
        }
        function AlertMsg(id) {
            alert("Please Select Future Date.!");
            document.getElementById(id).value = '';
            document.getElementById(id).focus();  
        }
        function expandBox(id) {
            document.getElementById(id).rows = "5";
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1";
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
                alert('Enter valid next review date');
                document.getElementById('lblDay').innerHTML = '';
                document.getElementById('txtActualDate').focus();
                return false;
            }
            if (sArr[1] == '' || parseInt(sArr[1], 10) < 1 || parseInt(sArr[1], 10) > 12) {
                alert('Enter valid next review date');
                document.getElementById('lblDay').innerHTML = '';
                document.getElementById('txtActualDate').focus();
                return false;
            }
            if (sArr[2] == '' || parseInt(sArr[2], 10) < 1900) {
                alert('Enter valid next review date');
                document.getElementById('lblDay').innerHTML = '';
                document.getElementById('txtActualDate').focus();
                return false;
            }

            //Selected date should not be Lesser than Today
            var selDate = new Date(parseInt(sArr[2], 10), parseInt(sArr[1], 10) - 1, parseInt(sArr[0], 10));
            var today = new Date();
            today.setHours(0);
            today.setMinutes(0);
            today.setSeconds(0);
            if (selDate <= today) {
                alert('Invalid date. Date should be greater than the system date.');
                return false;
            }
            return true;
        }

        function count(txt) {
            var lbl = document.getElementById("lblCount");
            lbl.innerHTML = 0 + txt.value.length;
        }

        function ShowPop() {
            document.getElementById('lblProcName').innerHTML = document.getElementById('ddlPhysio').options[document.getElementById('ddlPhysio').selectedIndex].text;
            //            document.getElementById('lblProcName').setAttribute('display', 'block');
            document.getElementById('divAddMore').style.display = 'block';
            document.getElementById('txtSitting').value = '';
            document.getElementById('hdnAddProcID').value = document.getElementById('ddlPhysio').options[document.getElementById('ddlPhysio').selectedIndex].value;
        }

        function ClosePop() {
            document.getElementById('divAddMore').style.display = 'none';
        }

        //        function onFocus() {
        //            document.getElementById('txtRemarks').focus();
        //        }

        function HideProcedure() {
            document.getElementById('GrdResponse').style.display = 'none';
        }

        function AddMoreSittings() {
            if (document.getElementById('txtSitting').value == '') {
                document.getElementById('txtSitting').focus();
                alert("Provide the advised number of sittings");
                return false;
            }
            else {
                var HidValue = document.getElementById('hdnAddMoreItems').value;
                var ProcName = document.getElementById('lblProcName').innerHTML;
                var ProcValue = document.getElementById('hdnAddProcID').value;
                var ProcID = ProcValue.split('|')[0];
                var temp = '';
                var Extended = document.getElementById('txtSitting').value;
                if (HidValue != '') {
                    var list = HidValue.split('^');
                    var newCList = '';
                    if (document.getElementById('hdnAddMoreItems').value != "") {
                        for (var count = 0; count < list.length; count++) {
                            var PList = list[count].split('~');
                            if (PList[2] != '') {
                                if (PList[1] == ProcID) {
                                    alert('Sitting Already Add to this Procedure');
                                    document.getElementById('divAddMore').style.display = 'none';
                                    document.getElementById('txtSitting').value = '';
                                }
                                else {
                                    temp = ProcName + '~' + ProcID + '~' + Extended + '^';
                                }
                            }
                        }
                    }
                }
                else {
                    if (temp == '') {
                        document.getElementById('hdnAddMoreItems').value += ProcName + '~' + ProcID + '~' + Extended + '^';
                        alert('Service Ordered sucessfully');
                        document.getElementById('divAddMore').style.display = 'none';

                    }
                    else {
                        document.getElementById('hdnAddMoreItems').value += ProcName + '~' + ProcID + '~' + Extended + '^' + temp;
                        alert('Service Ordered sucessfully');
                        document.getElementById('divAddMore').style.display = 'none';
                    }
                }
            }
        }
        function fnSelectedItem(source, eventArgs) {
            var list = eventArgs.get_value();
            if (list.length > 0) {
                document.getElementById('hdnProcedureID').value = list;

            }
        }

        function OnlyOrderProc(chkBox) {
            if (chkBox.checked == true) {
                document.getElementById('tbVtype').disabled = true;
                document.getElementById('tblAddPhysiotherophy').disabled = true;
                document.getElementById('trNxtReview').disabled = true;
                document.getElementById('tdContinue').style.display = 'none';
                document.getElementById('tdSave').style.display = 'none';
                document.getElementById('tdOrder').style.display = 'block';
                document.getElementById('hdnOnlyOrderProc').value = "1";
            }
            else {
                document.getElementById('tbVtype').disabled = false;
                document.getElementById('tblAddPhysiotherophy').disabled = false;
                document.getElementById('trNxtReview').disabled = false;
                document.getElementById('tdContinue').style.display = 'block';
                document.getElementById('tdSave').style.display = 'block';
                document.getElementById('tdOrder').style.display = 'none';
                document.getElementById('hdnOnlyOrderProc').value = "0";
            }
        }

        function ShowPopUp() {
            $find("ModelPopPrevVisitDetail").show();
            return false;
        }
    </script>

</head>
<body oncontextmenu="return false;" onload="HideProcedure();">
    <form id="form2" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
        </Services>
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
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" height="5%" runat="server"
                            style="display: block" id="tblSelectOption">
                            <tr>
                                <td style="display: none">
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    <asp:HiddenField runat="server" ID="hdnType" />
                                </td>
                            </tr>
                        </table>
                        <table id="Table1" cellpadding="0" cellspacing="0" border="0" width="100%" runat="server"
                            class="dataheaderInvCtrl">
                            <tr>
                                <td>
                                    <table width="100%" class="defaultfontcolor">
                                        <tr>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblNameT" runat="server" Text="NAME" Font-Bold="True" meta:resourcekey="lblNameTResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblNameV" runat="server" meta:resourcekey="lblNameVResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblAgeSexT" runat="server" Text="AGE/SEX" Font-Bold="True" meta:resourcekey="lblAgeSexTResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblAgeSexV" runat="server" meta:resourcekey="lblAgeSexVResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblPIDT" runat="server" Text="PATIENT NO" Font-Bold="True" meta:resourcekey="lblPIDTResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblPIDV" runat="server" meta:resourcekey="lblPIDVResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblConsultantT" runat="server" Text="CONSULTANT" Font-Bold="True"
                                                    meta:resourcekey="lblConsultantTResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblConsultantV" runat="server" meta:resourcekey="lblConsultantVResource1"></asp:Label>
                                                <div id="dvConsultant" runat="server" style="display: none">
                                                    <asp:DropDownList ID="ddlConsultant" runat="server" meta:resourcekey="ddlConsultantResource1">
                                                    </asp:DropDownList>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="display: none;" runat="server" id="trCS">
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblUnitT" runat="server" Text="Clinical Sotting" Font-Bold="True"
                                                    meta:resourcekey="lblUnitTResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lblCS" runat="server" meta:resourcekey="lblCSResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width="40%" id="tblSOIH" runat="server" style="display: none;">
                            <tr>
                                <td class="colorforcontent" style="width: 15%;" height="23" align="left">
                                    <img id="img3" src="../images/showbids.gif" alt="show" width="15" height="15" align="top"
                                        runat="server" style="cursor: pointer" onclick="javascript:showdivs()" />
                                    <span style="cursor: pointer; color: White;" onclick="javascript:showdivs()">&nbsp;<asp:Label
                                        ID="Rs_ViewProceduresSurgeriesperformed" Text="View Procedures / Surgeries performed"
                                        runat="server" meta:resourcekey="Rs_ViewProceduresSurgeriesperformedResource1"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                        <table id="tblPrevSOI" cellpadding="2" cellspacing="0" border="0" width="100%" runat="server"
                            class="dataheaderInvCtrl" style="display: none;">
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="font-weight: normal; color: #000;">
                                                <asp:Table runat="server" ID="tblSurgeryDetail" CellPadding="5" CellSpacing="0" GridLines="Both"
                                                    meta:resourcekey="tblSurgeryDetailResource1">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width="40%" id="tblBPH" runat="server" style="display: none;">
                            <tr>
                                <td class="colorforcontent" style="width: 15%;" height="23" align="left">
                                    <img id="img4" src="../images/showbids.gif" alt="show" width="15" height="15" align="top"
                                        runat="server" style="cursor: pointer" onclick="javascript:showdivsbp()" />
                                    <span style="cursor: pointer; color: White;" onclick="javascript:showdivsbp()">&nbsp;<asp:Label
                                        ID="Rs_ViewPatientBackgroundproblems" Text="View Patient Background problems"
                                        runat="server" meta:resourcekey="Rs_ViewPatientBackgroundproblemsResource1"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                        <table id="tblBP" cellpadding="2" cellspacing="0" border="0" width="100%" runat="server"
                            class="dataheaderInvCtrl" style="display: none;">
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="font-weight: normal; color: #000;">
                                                <asp:Table runat="server" ID="tblproblems" CellPadding="5" CellSpacing="0" GridLines="Both"
                                                    meta:resourcekey="tblproblemsResource1">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:HiddenField runat="server" ID="hdnvistType" />
                                <asp:HiddenField runat="server" ID="hdnPatientPhysioDtlID" />
                                <table width="40%" id="tblPrevVisitH" runat="server" style="display: none;">
                                    <tr id="Tr1" runat="server">
                                        <td id="Td1" class="colorforcontent" style="width: 15%;" height="10%" align="left"
                                            runat="server">
                                            <img id="img1" src="../images/showbids.gif" alt="show" width="15" height="15" align="top"
                                                runat="server" style="cursor: pointer" onclick="javascript:showdiv()" />
                                            <span style="cursor: pointer; color: White;" onclick="javascript:showdiv()">&nbsp;<asp:Label
                                                ID="Rs_ViewVisitDetails" Text="View Visit Details" runat="server"></asp:Label>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                                <%--<table id="tblPrevVisit" cellpadding="2" cellspacing="0" border="0" width="100%"
                                    runat="server" class="dataheaderInvCtrl" style="display: none;">
                                    <tr id="Tr2" class="defaultfontcolor" runat="server">
                                        <td id="Td2" runat="server">
                                            <asp:GridView ID="gvPrevVisit" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                AutoGenerateColumns="False" DataKeyNames="VisitDate,PatientID" ForeColor="#333333"
                                                HorizontalAlign="Left" OnRowCommand="gvPrevVisit_RowCommand" AllowPaging="True"
                                                AllowSorting="True" OnPageIndexChanging="gvPrevVisit_PageIndexChanging" PageSize="5">
                                                <HeaderStyle CssClass="dataheader1" HorizontalAlign="Left" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Performed Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCreatedAt" Text='<%#Eval("VisitDate") %>' runat="server" Width="74px"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Performed Procedure Count">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAdvisedNoOfSitting" Text='<%#Eval("AdvisedNoOfSitting") %>' runat="server"
                                                                Width="74px"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="OView" Text="View Visit Details" Font-Underline="true"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <PagerStyle CssClass="dataheaderInvCtrl" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>--%>
                                <table width="100%">
                                    <tr>
                                        <td width="85%">
                                        </td>
                                        <td height="15" width="15%" align="left" valign="top">
                                            &nbsp;&nbsp;
                                            <asp:Button ID="btnShow" runat="server" CssClass="btn" OnClientClick="return ShowPopUp()"
                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Enabled="false"
                                                Text="View Previous Visit" />
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="pnlPrevVisitDetail" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup"
                                    Width="80%" Style="display: none; top: 400px; height: 400px" meta:resourcekey="pnlPrevVisitDetailResource1">
                                    <table id="tblPrevVisitDetail" cellpadding="2" cellspacing="0" border="0" width="100%"
                                        runat="server" class="dataheaderInvCtrl" style="display: block;">
                                        <tr id="Tr3" class="defaultfontcolor" runat="server">
                                            <td id="Td3" runat="server">
                                                <asp:GridView ID="gvPrevVisitDetail" EmptyDataText="No Record Found" runat="server"
                                                    Width="100%" CellPadding="4" CssClass="mytable1" AutoGenerateColumns="False"
                                                    ForeColor="#333333" HorizontalAlign="Left" OnRowDataBound="gvPrevVisitDetail_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Date">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNextReview" Text='<%#Eval("NextReview") %>' runat="server" Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Procedure Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblProcedureNames" Text='<%#Eval("ProcedureName") %>' runat="server"
                                                                    Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sitting">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAdvisedNoOfSitting" Text='<%#Eval("HasPending") %>' runat="server"
                                                                    Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--<asp:TemplateField HeaderText="Performed Sitting(s)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCurrentNoOfSitting" Text='<%#Eval("CurrentNoOfSitting") %>' runat="server"
                                                                    Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Duration">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDuration" Text='<%#Eval("Duration") %>' runat="server" Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--<asp:TemplateField HeaderText="ScoreCardValue" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblScoreCardValue" Text='<%#Eval("ScoreCardValue") %>' runat="server"
                                                                    Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Physiotherapy Notes">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhysioNote" Text='<%#Eval("Remarks") %>' runat="server" Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Location">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRemarks" Text='<%#Eval("Status") %>' runat="server" Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Symptoms / History">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSymptoms" Text='<%#Eval("Symptoms") %>' runat="server" Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Referring Physician Comments">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhysicianComments" Text='<%#Eval("PhysicianComments") %>' runat="server"
                                                                    Width="74px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr id="Tr4" runat="server">
                                            <td id="Td4" runat="server">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="Tr5" runat="server">
                                            <td id="Td5" runat="server">
                                                <asp:GridView ID="gvPrevDiagnose" EmptyDataText="No Record Found" runat="server"
                                                    Width="100%" CellPadding="4" CssClass="mytable1" AutoGenerateColumns="False"
                                                    ForeColor="#333333" HorizontalAlign="Left">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Clinical Diagnosis ">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblComplaintNamePrev" Text='<%#Eval("ComplaintName") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICDCode" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblICDCodePrev" Text='<%#Eval("ICDCode") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ICD 10 Description" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblICDDescription" Text='<%#Eval("ICDDescription") %>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr id="Tr6" runat="server">
                                            <td id="Td6" align="center" runat="server">
                                                <asp:Button ID="BtnClosePaymentDetail" runat="server" Text="Close" CssClass="btn" />
                                            </td>
                                        </tr>
                                    </table>
                                    <ajc:ModalPopupExtender ID="ModelPopPrevVisitDetail" runat="server" TargetControlID="btnR"
                                        PopupControlID="pnlPrevVisitDetail" BackgroundCssClass="modalBackground" OkControlID="BtnClosePaymentDetail"
                                        DynamicServicePath="" Enabled="True" />
                                    <input type="button" id="btnR" runat="server" style="display: none;" />
                                </asp:Panel>
                                <table id="Table2" runat="server" border="0" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                    width="100%">
                                    <tr id="Tr7" runat="server">
                                        <td id="Td7" runat="server" align="center">
                                            <asp:DropDownList ID="ddlType" runat="server" onChange="javascript:ShowhideTable();">
                                                <asp:ListItem Text="Add Physiotherapy" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Edit Physiotherapy" Value="1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <table id="Table3" runat="server" border="0" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                    width="100%">
                                    <tr id="Tr8" runat="server">
                                        <td id="Td8" runat="server" class="defaultfontcolor" colspan="2">
                                            <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                       <td valign="top" width="45%">
                                            <table cellpadding="0" cellspacing="0" width="550px">
                                                <tr>
                                                    <td align="left" class="colorforcontent" colspan="2" height="15" valign="top" width="100%">
                                                        <div id="Fckplus1" style="display: none; width: 100%;">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',1);"
                                                                style="width: 100%; cursor: pointer">
                                                                <asp:Label ID="Label6" runat="server" Text="Symptoms / Hisotry"></asp:Label>
                                                            </span>
                                                        </div>
                                                        <div id="Fckminus2" style="display: block; width: 100%;">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('Fckplus1','Fckminus2','Fckresponse',0);"
                                                                style="width: 100%; cursor: pointer">
                                                                <asp:Label ID="Label7" runat="server" Text="Symptoms / History"></asp:Label>
                                                            </span>
                                                        </div>
                                                        <div id="Fckresponse" style="display: block;">
                                                            <FCKeditorV2:FCKeditor ID="fckPhysio" runat="server" Height="80px" ToolbarStartExpanded="false"
                                                                Width="100%">
                                                            </FCKeditorV2:FCKeditor>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td valign="top">
                                            <table cellpadding="0" cellspacing="0" width="550px">
                                                <tr>
                                                    <td align="left" class="colorforcontent" colspan="2" height="15" valign="top" width="100%">
                                                        <div id="Div1" style="display: none; width: 100%;">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('Div1','Div2','Div3',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('Div1','Div2','Div3',1);" style="width: 100%;
                                                                cursor: pointer">
                                                                <asp:Label ID="Label8" runat="server" Text="Referring Physician Comments"></asp:Label>
                                                            </span>
                                                        </div>
                                                        <div id="Div2" style="display: block; width: 100%;">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('Div1','Div2','Div3',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('Div1','Div2','Div3',0);" style="width: 100%;
                                                                cursor: pointer">
                                                                <asp:Label ID="Label9" runat="server" Text="Referring Physician Comments"></asp:Label>
                                                            </span>
                                                        </div>
                                                        <div id="Div3" style="display: block;">
                                                            <FCKeditorV2:FCKeditor ID="FCKeditorRef" runat="server" Height="80px" ToolbarStartExpanded="false"
                                                                Width="100%">
                                                            </FCKeditorV2:FCKeditor>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <input name="ChkOrder" onclick="OnlyOrderProc(this)" type="checkbox" />Only If 
                                you want to Order Procedure
                                <table id="tbVtype" runat="server" align="center" class="dataheaderInvCtrl" style="display: block"
                                    width="100%">
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="lblVisitType" runat="server" Text="Visit Type"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlVisitType" runat="server">
                                                <asp:ListItem Selected="False" Value="0">--Select--</asp:ListItem>
                                                <asp:ListItem Value="1">Review</asp:ListItem>
                                                <asp:ListItem Value="2">Recurrent</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblPPDT" runat="server" border="0" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                    style="display: none;" width="100%">
                                    <tr id="Tr9" runat="server" class="defaultfontcolor">
                                        <td id="Td9" runat="server">
                                            <asp:GridView ID="gvPPDT" runat="server" AutoGenerateColumns="False" CellPadding="0"
                                                DataKeyNames="PatientPhysioDtlID,ProcedureID" ForeColor="#333333" HorizontalAlign="Left"
                                                OnRowDataBound="gvPPDT_RowDataBound" Width="100%">
                                                <PagerStyle Height="30" HorizontalAlign="Right" />
                                                <HeaderStyle Height="30" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Performed Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCreatedAtE" runat="server" Text='<%#Eval("CreatedAt") %>' Width="120px"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProcedureNameE" runat="server" Text='<%#Eval("ProcedureName") %>'
                                                                Width="100px"></asp:Label>
                                                            <asp:Label ID="lblPatientPhysioDtlIDE" runat="server" Text='<%#Eval("PatientPhysioDtlID") %>'
                                                                Visible="false"></asp:Label>
                                                            <asp:Label ID="lblProcedureIDE" runat="server" Text='<%#Eval("ProcedureID") %>' Visible="false">&gt;</asp:Label>
                                                            <asp:Label ID="lblHasPending" runat="server" Text='<%#Eval("HasPending") %>' Visible="false">&gt;</asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Duration">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtDutationE" runat="server"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                Text='<%#Eval("DurationValue") %>' Width="30px"></asp:TextBox>
                                                            <asp:DropDownList ID="ddlDurationUnitsE" runat="server">
                                                                <asp:ListItem Text="Hour(s)" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Min(s)" Value="2"></asp:ListItem>
                                                                <asp:ListItem Text="Sec(s)" Value="3"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Adviced Sitting's">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtAdVNoSittingE" runat="server" Enabled="false"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                Text='<%#Eval("AdvisedNoOfSitting") %>' Width="50px"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Current Sitting">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtCurrentNoSittingE" runat="server" Enabled="false" ReadOnly="true"
                                                                Text='<%#Eval("CurrentNoOfSitting") %>' Width="50px"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Score" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtSCVE" runat="server"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                Text='<%#Eval("ScoreCardValue") %>' Width="50px"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Physiotherapy Notes">
                                                        <ItemTemplate>
                                                            <%--<asp:TextBox ID="txtRemarksE" runat="server" Text='<%#Eval("Remarks") %>'></asp:TextBox>--%>
                                                            <asp:TextBox ID="txtRemarksE" runat="server" onblur="javascript: return collapseBox(this.id);"
                                                                onfocus="javascript:expandBox(this.id);" Rows="1" Style="width: 220px;" TextMode="MultiLine"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Comments">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtCommentsE" runat="server" ReadOnly="true" Rows="1" Style="width: 180px;"
                                                                TextMode="MultiLine"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Next Review Date">
                                                        <ItemTemplate>
                                                        <asp:TextBox ID="txtNextReviewDateE" runat="server"></asp:TextBox>
                                                                <asp:ImageButton ID="imgBtn" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"/>
                                                                <cc1:MaskedEditExtender ID="mskNextReview" runat="server" AcceptNegative="Left" CultureAMPMPlaceholder=""
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                    DisplayMoney="Left" Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999"
                                                                    MaskType="Date" TargetControlID="txtNextReviewDateE">
                                                                </cc1:MaskedEditExtender>
                                                                <cc1:MaskedEditValidator ID="mskEditNxtReview" runat="server" ControlExtender="mskNextReview"
                                                                    ControlToValidate="txtNextReviewDateE" Display="Dynamic" EmptyValueBlurredText="*"
                                                                    EmptyValueMessage="Input Date and Time" ErrorMessage="mskNextReview" InvalidValueBlurredMessage="*"
                                                                    InvalidValueMessage="Inputted date time not valid" TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE">
                                                                </cc1:MaskedEditValidator>
                                                                &nbsp;<cc1:CalendarExtender ID="CalendarExtender7" runat="server" Enabled="True"
                                                                    Format="dd/MM/yyyy" PopupButtonID="imgBtn" TargetControlID="txtNextReviewDateE">
                                                                </cc1:CalendarExtender>
                                                            <%--<asp:TextBox ID="txtNextReviewDateE" runat="server" MaxLength="25" Width="120px"></asp:TextBox>
                                                            <a id="ahrImgBtnfrm" runat="server">
                                                                <img alt="Pick a date" border="0" height="16" src="../Images/Calendar_scheduleHS.png"
                                                                    width="16"></img></a>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                            </asp:GridView>
                                            <asp:HiddenField ID="hdnChkValues" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblAddPhysiotherophy" runat="server" border="0" cellpadding="2" cellspacing="0"
                                    class="dataheaderInvCtrl" width="100%">
                                    <tr>
                                        <td>
                                            <table>
                                                <tr id="Tr10" runat="server" class="defaultfontcolor">
                                                    <td id="Td10" runat="server" style="width: 25%">
                                                        <asp:Label ID="Rs_Physiotherapy" runat="server" Text="Physiotherapy"></asp:Label>
                                                    </td>
                                                    <td id="Td11" runat="server" style="width: 25%">
                                                        <asp:DropDownList ID="ddlPhysio" runat="server" onChange="javascript:getPhysioDetails();"
                                                            Width="115px">
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblstr" runat="server" Font-Size="Medium" ForeColor="Red" Text="*"></asp:Label>
                                                    </td>
                                                    <td id="Td12" runat="server" style="width: 25%">
                                                        <asp:Label ID="Rs_Duration" runat="server" Text="Duration for Current Sitting"></asp:Label>
                                                    </td>
                                                    <td id="Td13" runat="server" style="width: 25%">
                                                        <asp:TextBox ID="txtDutation" runat="server"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Width="50px"></asp:TextBox>
                                                        <asp:DropDownList ID="ddlDurationUnits" runat="server">
                                                            <asp:ListItem Text="Hour(s)" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Min(s)" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="Sec(s)" Value="3"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="Label1" runat="server" Font-Size="Medium" ForeColor="Red" Text="*"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="Tr11" runat="server" class="defaultfontcolor">
                                                    <td id="Td14" runat="server" style="width: 25%">
                                                        <asp:Label ID="Rs_AdvisedNoOfSittings" runat="server" Text="Adviced No Of Sittings"></asp:Label>
                                                    </td>
                                                    <td id="Td15" runat="server" style="width: 25%">
                                                        <asp:TextBox ID="txtAdVNoSitting" runat="server" Enabled="false" OnChange="javascript:HsPending(this.value);"
                                                              onkeypress="return ValidateOnlyNumeric(this);"   Width="50px"></asp:TextBox>
                                                        <asp:Label ID="Label2" runat="server" Font-Size="Medium" ForeColor="Red" Text="*"></asp:Label>
                                                    </td>
                                                    <td id="Td16" runat="server" style="width: 25%">
                                                        <asp:Label ID="Rs_CurrentNoOfSittings" runat="server" Text="Current Sitting"></asp:Label>
                                                    </td>
                                                    <td id="Td17" runat="server" style="width: 25%">
                                                        <asp:TextBox ID="txtCurrentNoSitting" runat="server" Enabled="false" Width="50px"></asp:TextBox>
                                                        <asp:Label ID="Label3" runat="server" Font-Size="Medium" ForeColor="Red" Text="*"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="Tr12" runat="server" class="defaultfontcolor">
                                                    <td id="Td20" runat="server" style="width: 25%; vertical-align: top">
                                                        <asp:Label ID="Rs_PhysiotherapyNotes" runat="server" Text="Physiotherapy Notes"></asp:Label>
                                                    </td>
                                                    <td id="Td21" runat="server" style="width: 25%">
                                                        <table>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:Label ID="lblMax" runat="server" Text="Max 2000 Chars."></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 25%; vertical-align: top">
                                                                    <asp:TextBox ID="txtRemarks" runat="server" onKeydown="count(this)" onKeyup="count(this)"
                                                                        Rows="5" Style="width: 220px;" TextMode="MultiLine"></asp:TextBox>
                                                                    <asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>
                                                                    <asp:Label ID="lblM" runat="server" Text=" /2000"></asp:Label>
                                                                    &nbsp;Chars.
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td id="Td18" runat="server" style="width: 25%; vertical-align: top; display: none;">
                                                        <asp:Label ID="Rs_ScoreCardValue" runat="server" Text="Score Card Value"></asp:Label>
                                                    </td>
                                                    <td id="Td19" runat="server" colspan="2" style="width: 25%; vertical-align: top;
                                                        display: none;">
                                                        <asp:TextBox ID="txtSCV" runat="server"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Width="50px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="Tr13" runat="server" class="defaultfontcolor">
                                                    <td id="Td22" runat="server">
                                                        <asp:CheckBox ID="chkPendingSitting" runat="server" Text="Add To Pending Sitting" />
                                                    </td>
                                                    <td id="tdAddMore" runat="server" style="display: none;">
                                                        <asp:Label ID="lblAddMore" runat="server" Font-Bold="true" OnClick="javascript:ShowPop();"
                                                            Style="cursor: pointer;" Text="Add More Sitting"></asp:Label>
                                                    </td>
                                                    <td id="Td23" runat="server" style="display: block">
                                                        <input id="btnPhysioAdd" class="btn" name="btnPhysioAdd" onclick="javascript:return onClickAddPhysioItems();"
                                                            style="width: 75px" type="button" value="Add" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <asp:Label ID="lblComments" runat="server" Font-Bold="true" Text="Comments"></asp:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtComments" runat="server" Enabled="false" Rows="5" Style="width: 220px;"
                                                TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblPhysioItems" runat="server" border="1" cellpadding="8" cellspacing="0"
                                    class="dataheaderInvCtrl" height="50%" style="font-family: Tahoma" width="100%">
                                </table>
                                <table id="tbMainProc" runat="server" style="display: none" width="80%">
                                    <tr>
                                        <td>
                                            <div id="Grdplus" runat="server" class="colorforcontent" style="display: none;">
                                                <img align="top" alt="Show" height="15" onclick="showResponses('Grdplus','Grdminus','GrdResponse',1);"
                                                    src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                <span class="dataheader1txt" onclick="showResponses('Grdplus','Grdminus','GrdResponse',1); "
                                                    style="cursor: pointer">
                                                    <asp:Label ID="Label10" runat="server" Font-Bold="true" Height="20" onclick="CreateTabl1()"
                                                        Text="Order Procedure"></asp:Label>
                                                </span>
                                            </div>
                                            <div id="Grdminus" class="colorforcontent" style="display: none">
                                                <img align="top" alt="hide" height="15" onclick="showResponses('Grdplus','Grdminus','GrdResponse',0);"
                                                    src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                <span class="dataheader1txt" onclick="showResponses('Grdplus','Grdminus','GrdResponse',0);"
                                                    style="cursor: pointer">
                                                    <asp:Label ID="Label11" runat="server" Font-Bold="true" Height="20" Text="Order Procedure"></asp:Label>
                                                </span>
                                            </div>
                                            <div id="GrdResponse">
                                                <table id="tabProc" runat="server" style="display: none" width="100%">
                                                    <tr>
                                                        <td>
                                                            <table id="tbAddProc" class="dataheaderInvCtrl" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label12" runat="server" Text="Enter Procedure Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtName" runat="server" CssClass="biltextb" onKeyDown="chkPros();"></asp:TextBox>
                                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionInterval="0"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                            Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="fnSelectedItem"
                                                                            ServiceMethod="GetQuickBillItems" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtName"
                                                                            UseContextKey="True">
                                                                        </cc1:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblSiting" runat="server" Text="Enter No. of Sitting"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtQty" runat="server" CssClass="biltextb" MaxLength="3"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                            Style="text-align: right;" Text="1" Width="25px"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <input id="btnAdd" class="btn" onclick="addItems();" style="width: 70px;" type="button"
                                                                            value="Add" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td id="tdDivCreateProc" colspan="6" style="display: none">
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
                                <table border="0" cellpadding="4" cellspacing="0" class="dataheaderInvCtrl" width="100%">
                                    <tr id="trNxtReview" runat="server" style="display: block;">
                                        <td>
                                            <asp:Panel ID="pnlMiscellaneous" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlMiscellaneousResource1">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td align="left" class="colorforcontent" height="23" width="35%">
                                                            <div id="ACX2plusM" style="display: none">
                                                                &nbsp;<img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);"
                                                                    src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                                <span class="dataheader1txt" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);"
                                                                    style="cursor: pointer">
                                                                    <asp:Label ID="Rs_Miscellaneous" runat="server" meta:resourceKey="Rs_MiscellaneousResource1"
                                                                        Text="Miscellaneous"></asp:Label>
                                                                </span>
                                                            </div>
                                                            <div id="ACX2minusM" style="display: block; height: 18px;">
                                                                &nbsp;<img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);"
                                                                    src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                                <span class="dataheader1txt" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);"
                                                                    style="cursor: pointer">
                                                                    <asp:Label ID="Rs_Miscellaneous1" runat="server" meta:resourceKey="Rs_Miscellaneous1Resource1"
                                                                        Text="Miscellaneous"></asp:Label>
                                                                </span>
                                                            </div>
                                                        </td>
                                                        <td align="left" height="23" width="75%">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr id="ACX2responsesM" class="tablerow">
                                                        <td colspan="2">
                                                            <div class="dataheader2">
                                                                <br />
                                                                &nbsp;<asp:Label ID="lblTxt" runat="server" CssClass="defaultfontcolor" meta:resourceKey="lblTxtResource1"
                                                                    Text="Next Review After"></asp:Label>
                                                                <asp:DropDownList ID="ddlNos" runat="server" meta:resourceKey="ddlNosResource1">
                                                                    <asp:ListItem meta:resourceKey="ListItemResource12" Value="1">1</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource13" Value="2">2</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource14" Value="3">3</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource15" Value="4">4</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource16" Value="5">5</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource17" Value="6">6</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource18" Value="7">7</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource19" Value="8">8</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource20" Value="9">9</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource21" Value="10">10</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource22" Value="11">11</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource23" Value="0">0</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:DropDownList ID="ddlDMY" runat="server" meta:resourceKey="ddlDMYResource1">
                                                                    <asp:ListItem meta:resourceKey="ListItemResource24" Value="Day(s)">Day(s)</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource25" Value="Week(s)">Week(s)</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource26" Value="Month(s)">Month(s)</asp:ListItem>
                                                                    <asp:ListItem meta:resourceKey="ListItemResource27" Value="Year(s)">Year(s)</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <%--<br clear="all" />--%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                <asp:TextBox ID="txtActualDate" runat="server" meta:resourcekey="txtActualDateResource1"
                                                                    TabIndex="3"></asp:TextBox>
                                                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    meta:resourcekey="ImgBntCalcFromResource1" />
                                                                <cc1:MaskedEditExtender ID="mskActualDate" runat="server" AcceptNegative="Left" CultureAMPMPlaceholder=""
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                    DisplayMoney="Left" Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999"
                                                                    MaskType="Date" TargetControlID="txtActualDate">
                                                                </cc1:MaskedEditExtender>
                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="mskActualDate"
                                                                    ControlToValidate="txtActualDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                                    EmptyValueMessage="Input Date and Time" ErrorMessage="mskActualDate" InvalidValueBlurredMessage="*"
                                                                    InvalidValueMessage="Inputted date time not valid" meta:resourcekey="MaskedEditValidator6Resource1"
                                                                    TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE">
                                                                </cc1:MaskedEditValidator>
                                                                &nbsp;<cc1:CalendarExtender ID="CalendarExtender6" runat="server" Enabled="True"
                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" TargetControlID="txtActualDate">
                                                                </cc1:CalendarExtender>
                                                                &nbsp;<asp:Label ID="lblDay" runat="server" CssClass="defaultfontcolor" ForeColor="Red"
                                                                    meta:resourcekey="lblDayResource1"></asp:Label>
                                                                <br clear="all" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    Please wait....</ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <table>
                                                <tr>
                                                    <td id="tdContinue" style="display: block;">
                                                        <asp:Button ID="AddMore" runat="server" CssClass="btn" meta:resourcekey="AddMoreResource1"
                                                            OnClick="AddMore_Click" OnClientClick="javascript:return checkForValues();" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" Text="Save &amp; Continue" />
                                                    </td>
                                                    <td id="tdSave" style="display: block;">
                                                        <asp:Button ID="btnFinish" runat="server" CssClass="btn" meta:resourcekey="btnFinishResource1"
                                                            OnClick="btnFinish_Click" OnClientClick="javascript:return checkForValues();"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save" />
                                                    </td>
                                                    <td id="tdOrder" style="display: none;">
                                                        <asp:Button ID="btnOrder" runat="server" CssClass="btn" OnClick="btnOrder_Click"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Order Procedure" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn" meta:resourcekey="btnCancelResource1"
                                                            OnClick="btnCancel_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Cancel" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnProcID" runat="server" />
                                <asp:HiddenField ID="hdnPhysioItems" runat="server" />
                                <asp:HiddenField ID="hdnProcIDDes" runat="server" />
                                <asp:HiddenField ID="hdnSymptoms" runat="server" />
                                <asp:HiddenField ID="hdnComments" runat="server" />
                                <asp:HiddenField ID="hdnValidateValue" runat="server" Value="0" />
                                <div id="divAddMore" runat="server" style="border-width: 1px; border-color: #000;
                                    display: none; position: static; z-index: 2; top: -2px; bottom: -10px; left: 296px;">
                                    <table border="0" cellpadding="3" cellspacing="0" style="background-color: #333;
                                        border-color: #000; color: #fff;">
                                        <tr class="colorforcontent" style="height: 20px;">
                                            <td>
                                                <asp:Label ID="lblHeader" runat="server" Text="Order Service For This Procedure"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblProc" runat="server" Text="Procedure Name:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblProcName" runat="server" Visible="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSitting" runat="server" ForeColor="#ffffff" Text="Enter Sitting"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSitting" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:Label ID="Label5" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:return AddMoreSittings();"
                                                    Style="cursor: pointer;">Add</asp:Label>
                                                &nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="Label4" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:ClosePop();"
                                                    Style="cursor: pointer;">Close</asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField ID="hdnAddMoreItems" runat="server" Value="" />
                                    <asp:HiddenField ID="hdnAddProcID" runat="server" Value="" />
                                    <asp:HiddenField ID="hdnProcedureID" runat="server" />
                                    <asp:HiddenField ID="hdnAddItems" runat="server" />
                                    <asp:HiddenField ID="hdnOrdered" runat="server" />
                                    <asp:HiddenField ID="hdnNewProc" runat="server" />
                                    <asp:HiddenField ID="hdnPatientID" runat="server" />
                                    <asp:HiddenField ID="hdnOnlyOrderProc" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnCurrentDate" runat="server" />
                                </div>
                                </input>
                            </ContentTemplate>
                        </asp:UpdatePanel>
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
        //   LoadDiagnosisItems();
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
        function fnSelectedItem(source, eventArgs) {
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
                    alert('Please Enter the Sitting');
                }
                else {
                    alert('Please Enter Atleast One Sitting');
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
                }
            }
        }
        function CreateTable(additems) {

            document.getElementById('hdnAddItems').value += additems;
            var items = document.getElementById('hdnAddItems').value.split('^');
            document.getElementById('<%= divCreateProc.ClientID %>').innerHTML = "";
            var startTag, bodyTag, endTag;
            if (items != "") {
                startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='center' > Procedure Name </th> <th scope='col' align='center'>  No. of Sitting's </th><th scope='col' align='center'>Delete</th></tr>";
                endTag = "</TBODY></TABLE>";
                bodyTag = startTag;
                for (var i = 0; i < items.length; i++) {
                    if (items[i] != "") {
                        bodyTag += "<TR><TD style='display:none'>" + items[i].split('~')[0] + "</TD>";
                        bodyTag += "<TD style='padding-left:10px' align='center'>" + items[i].split('~')[1] + "</TD>";
                        bodyTag += "<TD align='right'>" + items[i].split('~')[2] + "</TD>";
                        bodyTag += "<TD><input name='" + items[i].split('~')[0] + '~' + items[i].split('~')[1] + '~' + items[i].split('~')[2] + "' onclick='return deleteRow(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD>";
                        bodyTag += "</TR>";
                    }
                }
                bodyTag += endTag;
                document.getElementById('tdDivCreateProc').style.display = 'block';
                document.getElementById('<%= divCreateProc.ClientID %>').innerHTML = bodyTag;
                document.getElementById('<%= txtName.ClientID %>').value = "";
                document.getElementById('<%= txtName.ClientID %>').focus();
                document.getElementById('<%= txtComments.ClientID %>').value = "";
                document.getElementById('<%= txtQty.ClientID %>').value = 1;
                document.getElementById('hdnProcedureID').value = '';
            }
        }
        function deleteRow(deletedata) {
            var existitems = document.getElementById('hdnAddItems').value.split('^');
            //var NewProc = document.getElementById('hdnNewProc').value.split('^');
            document.getElementById('hdnAddItems').value = "";
            //document.getElementById('hdnNewProc').value = "";
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
            //            if (NewProc != '') {
            //                for (var i = 0; i < NewProc.length; i++) {
            //                    if (NewProc[i] != "") {
            //                        if (deletedata != NewProc[i]) {
            //                            document.getElementById('hdnNewProc').value += NewProc[i] + "^";
            //                        }
            //                    }
            //                }
            //            }
            CreateTable(additems);
        }

        function CreateTabl1() {
            var additem = document.getElementById('hdnOrdered').value;
            if (additem != '') {
                document.getElementById('hdnOrdered').value = "";
                CreateTable(additem);
            }
        }
        function Duelist(tmpVal) {
            if (tmpVal == 'Open') {
                alert('Procedure already in progress..! You cannot order this procedure');
                document.getElementById('<%= txtQty.ClientID %>').value = "1";
                document.getElementById('<%= txtName.ClientID %>').value = "";
                document.getElementById('<%= txtName.ClientID %>').focus();
                document.getElementById('<%= txtComments.ClientID %>').value = "";
            }
            else {
                var totalItem = document.getElementById('hdnProcedureID').value;
                //24^WAX BATH^PRO^0.00^0^0^Y^0.00^0.00^0^0^0.00^0.00
                var procID = totalItem.split('^')[0];
                var procName = totalItem.split('^')[1];
                if (procID != '') {
                    var siting = document.getElementById('<%= txtQty.ClientID %>').value;
                    var additems = procID + '~' + procName + '~' + siting + '^';
                    var flag = -1;
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
                                        document.getElementById('<%= txtName.ClientID %>').value = "";
                                        document.getElementById('<%= txtName.ClientID %>').focus();
                                        document.getElementById('<%= txtComments.ClientID %>').value = '';
                                        document.getElementById('<%= txtQty.ClientID %>').value = "1";
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
