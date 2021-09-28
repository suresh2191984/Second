<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleArchivalMaster.aspx.cs"
    Inherits="Admin_SampleArchivalMaster" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SampleArchival Master</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="Stylesheet" id="StyleSheet1" runat="server" />
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function ShowAlertMsg(key) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_01") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_01") : "Already Exist!";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_02") : "Saved Successfully";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_03") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_03") : "Changes Saved Successfully!";
           
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                ValidationWindow(userMsg, AlrtWinHdr);
               // alert(userMsg);
                return false;
            }
            else if (key == "Admin\\SampleArchivalMaster.aspx.cs_31") {
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                //alert('Already Exist!');
                return false;
            }

            else if (key == "Admin\\SampleArchivalMaster.aspx.cs_32") {
                //alert('Saved Successfully');
            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                return false;
            }
            else if (key == "Admin\\SampleArchivalMaster.aspx.cs_33") {
                //alert('Changes Saved Successfully!');

            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr); 
            return false;
            }
            return true;
        }
        function setSlotableHidden(id) {
            if (document.getElementById(id).checked == true) {
                document.getElementById('hdnIsSlotable').value = 'Y';
                document.getElementById('ChkSlotable').checked = true;
                document.getElementById('CheckBox1').checked = true;
            }
            else {
                document.getElementById('hdnIsSlotable').value = 'N';
                document.getElementById('ChkSlotable').checked = false;
                document.getElementById('CheckBox1').checked = false;
            }
        }
        function setIsAnOTHidden(id) {
            if (document.getElementById(id).checked == true) {
                document.getElementById('hdnIsAnOT').value = 'Y';
                document.getElementById('CheckIsAnOT').checked = true;
                document.getElementById('CheckBox2').checked = true;
            }
            else {
                document.getElementById('hdnIsAnOT').value = 'N';
                document.getElementById('CheckIsAnOT').checked = false;
                document.getElementById('CheckBox2').checked = false;
            }
        }

        function HideDays(id) {
            var Id = id.split('_');
            var checkboxId = Id[0] + '_' + Id[1] + '_' + 'RTCheckBox';
            var e = document.getElementById(id);
            var value = e.options[e.selectedIndex].value;
            //if (document.getElementById(id).selectedIndex.value == "2") {
            if (value == "Batch") {
                for (var i = 0; i < 8; i++) {
                    document.getElementById(checkboxId + '_' + i).disabled = false;
                    document.getElementById(checkboxId).disabled = false;
                }
            }
            else {
                for (var i = 0; i < 8; i++) {
                    document.getElementById(checkboxId + '_' + i).disabled = true;
                    document.getElementById(checkboxId).disabled = true;
                    document.getElementById(checkboxId + '_' + i).checked = false;
                }
            }
        }
        function Checkbox(id) {
            var Id = id.split('_');
            var checkboxId = Id[0] + '_' + Id[1] + '_' + 'RTCheckBox' + '_' + '0';
            var checkboxId1 = Id[0] + '_' + Id[1] + '_' + 'RTCheckBox'
            if (document.getElementById(checkboxId).checked == true) {
                for (var i = 1; i <= 7; i++) {
                    document.getElementById(checkboxId1 + '_' + i).checked = true;
                    
                }
            }

        }
        function OnControlClick() {
            var pCid = document.getElementById("hndControlID").value;
            document.getElementById(pCid).click();
        }

        //            function btnClose() {
        //                var chkStatus = document.getElementById(document.getElementById("hndControlID").value);
        //                alert(document.getElementById("hndControlID").value);
        //                if (chkStatus != undefined && chkStatus != null) {
        //                    chkStatus.checked = false;
        //                }
        //                document.getElementById("hdnRoomValues").value = "";
        //                document.getElementById("hdnID").value = 0;
        //            }
        //            document.getElementById("ddlRoomFeeRate").value = 0;

        function RateChanged() {
            var pddlCnanged = document.getElementById("hdnRoomValues").value.split("^");
            var pRoomTyID = document.getElementById("hdnID").value;
            var pRateID = document.getElementById("ddlRoomFeeRate").value;
            TableRoomType();
        }



        function RoomRowCommon(pControlID, pID, pValue, pBulID, pRoomType, pRateID, IsSlotBooking, IsAnOT) {
            document.getElementById("hndControlID").value = pControlID;
            document.getElementById("hdnControl").value = pControlID + "~" + pID + "~" + pValue + "~" + pBulID;
            document.getElementById("tdDetete").style.display = "none";
            document.getElementById("hdnRoomValues").value = pRoomType;
            document.getElementById("ddlRoomFeeRate").value = 0;
            document.getElementById("hdnID").value = pID;
            if (IsSlotBooking == 'Yes') {
                if (document.getElementById('ChkSlotable') != null && document.getElementById('ChkSlotable') != undefined && document.getElementById('ChkSlotable') != '') {
                    document.getElementById('ChkSlotable').checked = true;
                    document.getElementById('CheckBox1').checked = true;
                    document.getElementById('hdnIsSlotable').value = 'Y';
                }
            }
            else {
                if (document.getElementById('ChkSlotable') != null && document.getElementById('ChkSlotable') != undefined && document.getElementById('ChkSlotable') != '') {
                    document.getElementById('ChkSlotable').checked = false;
                    document.getElementById('CheckBox1').checked = false;
                    document.getElementById('hdnIsSlotable').value = 'N';
                }
            }
            if (IsAnOT == 'Yes') {
                if (document.getElementById('CheckIsAnOT') != null && document.getElementById('CheckIsAnOT') != undefined && document.getElementById('CheckIsAnOT') != '') {
                    document.getElementById('CheckIsAnOT').checked = true;
                    document.getElementById('CheckBox2').checked = true;
                    document.getElementById('hdnIsAnOT').value = 'Y';
                }
            }
            else {
                if (document.getElementById('CheckIsAnOT') != null && document.getElementById('CheckIsAnOT') != undefined && document.getElementById('CheckIsAnOT') != '') {
                    document.getElementById('CheckIsAnOT').checked = false;
                    document.getElementById('CheckBox2').checked = false;
                    document.getElementById('hdnIsAnOT').value = 'N';
                }
            }

            if (document.getElementById(pControlID).checked) {
                document.getElementById("hdnControlValue").value += pControlID + "~" + pID + "~" + pValue + "~" + pBulID + "^";
                //document.getElementById("ddlRoomFeeRate").disabled = true;
            }
            else {
                document.getElementById("hdnID").value = 0;
                var x = document.getElementById("hdnControlValue").value.split("^");
                document.getElementById("hdnControlValue").value = "";
                document.getElementById("hdnRoomValues").value = "";
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (pControlID + "~" + pID + "~" + pValue + "~" + pBulID != x[i]) {
                            document.getElementById("hdnControlValue").value += x[i] + "^";
                        }
                    }
                }
            }

            var plist = document.getElementById("hdnControlValue").value.split("^").length;
            y = "~0~~-1".split("~");
            SetRoomDetailsValues(y, "Add");
            if (plist == 2) {
                var x = document.getElementById("hdnControlValue").value.split("^");

                for (i = 0; i < pValue.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split("~")
                        SetRoomDetailsValues(y, "Update");
                        break;
                    }
                }
            }
        }
        function SetRoomDetailsValues(sVal, pSta) {
            var ddlMaster = document.getElementById("ddlMaster").value;

            var pValue = document.getElementById("hdnControlValue").value.split("^");

            var pDisp = 'block';
            if (pValue.length == 1) {
                pDisp = 'none'
            }
            if (pValue.length > 2) {
                pDisp = 'block'
            }

            switch (ddlMaster) {
                case "BUILDING":
                    document.getElementById("tdDetete").style.display = pDisp;
                    document.getElementById("txtBuilding").value = sVal[2];
                    document.getElementById("hdnValue").value = sVal[1];
                    document.getElementById("btnSave").value = pSta;


                    //document.getElementById("btn").value = pDisp;
                    break;
                case "FLOOR":
                case "WARD":
                    document.getElementById("tdDetete").style.display = pDisp;
                    document.getElementById("ddlBuilding").value = sVal[3];
                    document.getElementById("txtFloor").value = sVal[2];
                    document.getElementById("hdnValue").value = sVal[1];
                    document.getElementById("btnFloor").value = pSta;

                    break;

                case "STORAGE_AREA":
                    document.getElementById("tdDetete").style.display = pDisp;
                    document.getElementById("txtBuilding").value = sVal[2];
                    document.getElementById("hdnValue").value = sVal[1];
                    document.getElementById("btnSave").value = pSta;
                    //-----Shobana----------//
                    //                    TableRoomType();
                    //                    document.getElementById("txtRoomType").value = sVal[2];
                    //                    if (sVal[2] != "") {
                    //                        document.getElementById("btnDummy").click();
                    //                    }
                    if (document.getElementById('hdnRoomValues').value != "")
                    //     document.getElementById('ddlRoomFeeRate').disabled = true;

                        break;
                case "ROOMS":


                    break;
                case "BED":
                    // document.getElementById("btnSaveBeds").style.display = pDisp;
                    break;

                default:

                    break;
            }
        }
        function checkDetails() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
        var UsrAlrtMsg4 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_04") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_04") : "Select the Building";
        var UsrAlrtMsg5 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_05") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_05") : "Enter the Building Name";
        var UsrAlrtMsg6 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_24") : "Enter the";
        var UsrAlrtMsg7 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_25") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_25") : "Name";
        var Vadd = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_29") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_29") : "Add";
        var Vupdate = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_30") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_30") : "Update";
            var x = document.getElementById('hdnControlValue').value;
            var ddlMaster = document.getElementById("ddlMaster").value;
            var pid = 0;
            var pname = '';
            var pbid = 0;
            switch (ddlMaster) {
                case "BUILDING":
                    if (document.getElementById("txtBuilding").value.trim() == '') {
                       // alert("Enter the " + ddlMaster + " Name");
                        ValidationWindow(UsrAlrtMsg6 + ddlMaster + UsrAlrtMsg7);
                        document.getElementById('txtBuilding').focus();
                        return false;
                    }
                    if (document.getElementById("btnSave").value != Vadd) {
                        pid = document.getElementById("hdnControlValue").value.split("^")[0].split("~")[1];
                        pname = document.getElementById('txtBuilding').value.trim();
                        document.getElementById("hdnpSta").value = "Update";
                    }
                    if (document.getElementById("btnSave").value != Vupdate) {
                        pname = document.getElementById('txtBuilding').value.trim();
                        document.getElementById("hdnpSta").value = "Add";
                    }

                    break;
                case "FLOOR":
                    pbid = document.getElementById("ddlBuilding").value;
                    pname = document.getElementById('txtFloor').value.trim();
                    //break;
                    // case "WARD":         

                    if (document.getElementById("ddlBuilding").value == '-1') {
                        //Admin\RoomMasterDetails.aspx_2

                        var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_2');
                        if (userMsg != null) {
                            Validationwindow(userMsg, AlrtWinHdr);
                            //alert(userMsg);
                        }
                        else {
                            Validationwindow(UsrAlrtMsg4, AlrtWinHdr);
                            //    alert('Select the Building');
                        }
                        document.getElementById('ddlBuilding').focus();
                        return false;
                    }
                    if (document.getElementById("txtFloor").value.trim() == '') {
                       ValidationWindow(UsrAlrtMsg6 + ddlMaster + UsrAlrtMsg7);
                        //alert("Enter the " + ddlMaster + "  Name");
                        document.getElementById('txtFloor').focus();
                        return false;
                    }

                    if (document.getElementById("btnFloor").value != Vadd) {
                        pid = document.getElementById("hdnControlValue").value.split("^")[0].split("~")[1];
                        pname = document.getElementById('txtFloor').value.trim();
                        pbid = document.getElementById("ddlBuilding").value;
                        document.getElementById("hdnpSta").value = "Update";
                    }
                    if (document.getElementById("btnFloor").value != Vupdate) {
                        pbid = document.getElementById("ddlBuilding").value;
                        pname = document.getElementById('txtFloor').value.trim();
                        document.getElementById("hdnpSta").value = "Add";
                    }
                    break;

                case "STORAGE_AREA":
                    //debugger;
                    //Commented By Ramki
                    if (document.getElementById("txtBuilding").value.trim() == '') {
                        //alert("Enter the " + ddlMaster + " Name");
                        ValidationWindow(UsrAlrtMsg6 + ddlMaster + UsrAlrtMsg7);
                        document.getElementById('txtBuilding').focus();
                        return false;
                    }
                    if (document.getElementById("btnSave").value != Vadd ) {
                        pid = document.getElementById("hdnControlValue").value.split("^")[0].split("~")[1];
                        pname = document.getElementById('txtBuilding').value.trim();
                        //-----Shobana----------//
                        //document.getElementById("btnDummy").click();
                        //-----Shobana----------//
                        document.getElementById("hdnpSta").value = "Update";
                        // return false;
                    }
                    if (document.getElementById("btnSave").value != Vupdate) {
                        document.getElementById("ddlRoomFeeRate").value = 0;
                        document.getElementById("btnSaveContinue").style.display = "none";
                        document.getElementById("hdnpSta").value = "Add";
                        pname = document.getElementById('txtBuilding').value.trim();
                        document.getElementById("txtRoomType").value = pname;
                        if (document.getElementById("hdnRoomValues").value != null && document.getElementById("hdnRoomValues") != undefined) {
                            document.getElementById("hdnRoomValues").value = "";
                            //                            if (document.getElementById("ddlRoomFeeRate").value)
                            //-----Shobana----------//
                            // TableRoomType();
                            // document.getElementById("btnDummy").click();
                            //return false;
                            //-----Shobana----------//

                        }

                    }


                    break;
                case "ROOMS":
                    break;
                case "BED":
                    break;

                default:

                    break;
            }
            if (pname != "") {
                document.getElementById("hdnCollectedList").value = pid + "~" + pname + "~" + pbid;
            }
            if (document.getElementById('hdnCollectedList').value.trim() == '') {
                //Admin\RoomMasterDetails.aspx_5
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_5');
                if (userMsg != null) {
                    //alert(userMsg);
                    Validationwindow(userMsg, AlrtWinHdr);
                }
                else {
                    Validationwindow(UsrAlrtMsg5, AlrtWinHdr);
                    //alert('Enter the Building Name');
                }
                if (document.getElementById('txtBuilding') != null) {
                    document.getElementById('txtBuilding').focus();
                }
                return false;
            }
            return true;
        }

        function TableRoomType() {
            while (count = document.getElementById('tblOrederedItems').rows.length) {

                for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
                    document.getElementById('tblOrederedItems').deleteRow(j);
                }
            }

            var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);
            // var cell6 = Headrow.insertCell(5);


            cell1.innerHTML = " Room Fee Type";
            cell2.innerHTML = "Amount";
            cell3.innerHTML = "Is Half Day";
            cell4.innerHTML = "Is Optional";
            // cell5.innerHTML = "Rate Name";
            cell5.innerHTML = "Fee based On"
            cell6.innerHTML = "Action";


            document.getElementById("ddlRoomFeeRate").disabled = false;
            var pRoomTyID = document.getElementById("hdnID").value;
            var pRateID = document.getElementById("ddlRoomFeeRate").value;


            var x = document.getElementById('hdnRoomValues').value.split("^");
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    // document.getElementById("ddlRoomFeeRate").disabled = true;
                    if (pRoomTyID == y[0] && pRateID == y[7]) {
                        if (y[8] == 'FULDAY') {
                            y[9] = 'Fully Day';
                        }
                        if (y[8] == 'HLFDAY') {
                            y[9] = 'Half Day';
                        }
                        if (y[8] == 'HOURLY') {
                            y[9] = 'Hour Basic';
                        }
                        var row = document.getElementById('tblOrederedItems').insertRow(1);
                        row.style.height = "13px";
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);
                        var cell6 = row.insertCell(5);
                        //var cell6 = row.insertCell(5);

                        cell1.innerHTML = y[1];
                        cell2.innerHTML = y[4];
                        cell3.innerHTML = y[5];
                        cell4.innerHTML = y[6];
                        cell5.innerHTML = y[9];
                        cell6.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_RoomMasterDetails_Edit%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnDelete(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_RoomMasterDetails_Delete%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                    }
                }
            }
        }

        function btnDelete(sEditedData) {
            var x = document.getElementById('hdnRoomValues').value.split("^");
            document.getElementById('hdnRoomValues').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnRoomValues').value += x[i] + "^";
                    }
                }
            }
            TableRoomType();
        }

        function checkBindRoomList() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var UsrAlrtMsg6 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_06") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_06") : "Select Rate Name";
            var UsrAlrtMsg7 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_07") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_07") : "Select the Room Fee Type";
            var UsrAlrtMsg8 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_08") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_08") : "Enter the Amount";
            var UsrAlrtMsg9 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_09") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_09") : "Room Fee Type Already Exists";
            var pFeeId = document.getElementById('ddlRoomfeestype').value;
            var pRateName = document.getElementById('ddlRoomFeeRate').value;
            if (pRateName == 0) {
                //Admin\RoomMasterDetails.aspx_6
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_6');
                if (userMsg != null) {
                    Validationwindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
                    Validationwindow(UsrAlrtMsg6, AlrtWinHdr);
                   // alert("Select Rate Name");
                }

                document.getElementById('ddlRoomFeeRate').focus();
                return false;
            }

            if (pFeeId == -1) {
                //Admin\RoomMasterDetails.aspx_7
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_7');
                if (userMsg != null) {
                    Validationwindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
                    Validationwindow(UsrAlrtMsg7, AlrtWinHdr);
                   // alert("Select the Room Fee Type ");
                }
                document.getElementById('ddlRoomfeestype').focus();
                return false;
            }
            if (Number(document.getElementById('txtAmount').value) < 0.50) {
                //Admin\RoomMasterDetails.aspx_8
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_8');
                if (userMsg != null) {
                    Validationwindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
                    Validationwindow(UsrAlrtMsg8, AlrtWinHdr);
                   // alert("Enter the Amount ");
                }
                document.getElementById('txtAmount').focus();
                return false;
            }
            var pRateID = document.getElementById("ddlRoomFeeRate").value;

            if (document.getElementById('btnAdd').value != 'Update') {
                var x = document.getElementById('hdnRoomValues').value.split("^");

                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        y = x[i].split('~');
                        if (y[3] == pFeeId && pRateID == y[7]) {
                            //Admin\RoomMasterDetails.aspx_9
                            var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_9');
                            if (userMsg != null) {
                                Validationwindow(userMsg, AlrtWinHdr);
                               // alert(userMsg);
                            }
                            else {
                                Validationwindow(UsrAlrtMsg9, AlrtWinHdr);
                                //alert("Room Fee Type Already Exists ");
                            }
                            document.getElementById('ddlRoomfeestype').focus();
                            return false;
                        }
                    }
                }
            }

            BindRoomList();
            return false;

        }


        function BindRoomList() {
            if (document.getElementById('btnAdd').value == 'Update') {
                Deleterows();
            }
            else {
                var pRoomTypeID = document.getElementById("hdnID").value;
                var pName = document.getElementById('ddlRoomfeestype').options[document.getElementById('ddlRoomfeestype').selectedIndex].text;
                var pID = 0;
                var pFeeId = document.getElementById('ddlRoomfeestype').value;
                var pAmt = document.getElementById('txtAmount').value;
                var pIsvar = document.getElementById('chkIsVariable').checked == true ? 'Y' : 'N';
                var pIsOp = document.getElementById('chkIsOptional').checked == true ? 'Y' : 'N';
                var pFeeLogicID = document.getElementById('ddlFeelogic').value;
                var pFeebasedon = document.getElementById('ddlFeelogic').options[document.getElementById('ddlFeelogic').selectedIndex].text;

                var pRateID = document.getElementById('ddlRoomFeeRate').value;



                document.getElementById('hdnRoomValues').value += pRoomTypeID + "~" + pName + "~" +
                            pID + "~" + pFeeId + "~" + pAmt + "~" + pIsvar + "~" +
                            pIsOp + "~" + pRateID + "~" + pFeeLogicID + "~" + pFeebasedon + "^";

                TableRoomType();
                document.getElementById('ddlRoomfeestype').value = "-1";
                document.getElementById('txtAmount').value = "";
                document.getElementById('chkIsVariable').checked = false;
                document.getElementById('chkIsOptional').checked = false

            }
            document.getElementById('btnAdd').value = 'Add';
        }

        function Deleterows() {
            var RowEdit = document.getElementById('hdnRowEdit').value;
            var x = document.getElementById('hdnRoomValues').value.split("^");
            if (RowEdit != "") {
                var pRoomTypeID = RowEdit.split('~')[0];
                var pName = document.getElementById('ddlRoomfeestype').options[document.getElementById('ddlRoomfeestype').selectedIndex].text;
                var pID = RowEdit.split('~')[2];
                var pFeeId = document.getElementById('ddlRoomfeestype').value;
                var pAmt = document.getElementById('txtAmount').value;
                var pIsvar = document.getElementById('chkIsVariable').checked == true ? 'Y' : 'N';
                var pIsOp = document.getElementById('chkIsOptional').checked == true ? 'Y' : 'N';
                var pFeeLogicID = document.getElementById('ddlFeelogic').value;
                var pFeebasedon = document.getElementById('ddlFeelogic').options[document.getElementById('ddlFeelogic').selectedIndex].text;


                var pRateID = document.getElementById('ddlRoomFeeRate').value;

                document.getElementById('hdnRoomValues').value = pRoomTypeID + "~" + pName + "~" +
                            pID + "~" + pFeeId + "~" + pAmt + "~" + pIsvar + "~" +
                            pIsOp + "~" + pRateID + "~" + pFeeLogicID + "~" + pFeebasedon + "^";


                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != RowEdit) {
                            document.getElementById('hdnRoomValues').value += x[i] + "^";
                        }
                    }
                }
                TableRoomType();
                document.getElementById('ddlRoomfeestype').value = "-1";
                document.getElementById('txtAmount').value = "";
                document.getElementById('chkIsVariable').checked = false;
                document.getElementById('chkIsOptional').checked = false

            }
        }

        function btnEdit_OnClick(sEditedData) {
            var y = sEditedData.split('~');
            document.getElementById('ddlRoomfeestype').value = y[3];
            document.getElementById('txtAmount').value = y[4];
            document.getElementById('chkIsVariable').checked = false;
            document.getElementById('chkIsOptional').checked = false;
            if (y[5] == "Y") {
                document.getElementById('chkIsVariable').checked = true;
            }
            if (y[6] == "Y") {
                document.getElementById('chkIsOptional').checked = true;
            }
            document.getElementById('btnAdd').value = "Update";
            document.getElementById('hdnRowEdit').value = sEditedData;
        }

        function SetFloorWard() {

            var pParID = document.getElementById("ddlRoomBuilding").value;
            var pFloorID = $get("<%=ddlRoomFloor.ClientID %>");
            var pWardID = $get("<%=ddlRoomWard.ClientID %>");
            var pFloorValue = document.getElementById("hdnFloor").value;
            var pWardValue = document.getElementById("hdnWard").value;

            SetValuesForDDL(pParID, pFloorID, pFloorValue);
            SetValuesForDDL(pParID, pWardID, pWardValue);
        }


        function SetValuesForDDL(pParID, pDDlIDs, HidValue) {

            //      if (pDDlIDs.options.length == 0){


            pDDlIDs.options.length = 0;

            var opt1 = document.createElement("option");
            opt1.text = '--Select--';
            opt1.value = -1;
            pDDlIDs.options.add(opt1);
            var flag = true;
            var list = HidValue.split("^");
            if (HidValue != "") {

                for (var count = 0; count < list.length; count++) {

                    var statusCh = list[count].split('~');

                    if (pParID == statusCh[0]) {
                        var opt = document.createElement("option");
                        pDDlIDs.options.add(opt);
                        opt.text = statusCh[2];
                        opt.value = statusCh[1];
                    }
                }
            }
            if (document.getElementById("hdnFloorValue").value.split('~')[1] != -1) {
                document.getElementById("<%=ddlRoomFloor.ClientID %>").value = document.getElementById("hdnFloorValue").value.split('~')[1];

            }
            if (document.getElementById("hdnWardValue").value.split('~')[1] != -1) {
                document.getElementById("<%=ddlRoomWard.ClientID %>").value = document.getElementById("hdnWardValue").value.split('~')[1]; ;
            }
            //}
        }
        function SetFloor() {
            var pVal = document.getElementById('ddlRoomFloor').options[document.getElementById('ddlRoomFloor').selectedIndex].text;
            var pID = document.getElementById('ddlRoomFloor').value;
            document.getElementById("hdnFloorValue").value = pVal + "~" + pID;

        }
        function SetWard() {
            var pVal = document.getElementById('ddlRoomWard').options[document.getElementById('ddlRoomWard').selectedIndex].text;
            var pID = document.getElementById('ddlRoomWard').value;
            document.getElementById("hdnWardValue").value = pVal + "~" + pID;

        }
        //nallan
        function chkRoomDetails() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var UsrAlrtMsg10 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_10") : "Select Building Name";
            var UsrAlrtMsg11 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_11") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_11") : "Select Floor Name";
            var UsrAlrtMsg12 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_12") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_12") : "Select Ward Name";
            var UsrAlrtMsg14 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_14") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_14") : "Enter No Of Storage Units";
            var UsrAlrtMsg13 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_13") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_13") : "Select the Storage Area Name";
             var pBuildingVal = document.getElementById('ddlRoomBuilding').value;
            var pFloorVal = document.getElementById('ddlRoomFloor').value;
            if (document.getElementById('ddlRoomWard') != null) {
                var pWardVal = document.getElementById('ddlRoomWard').value;
            }
            var pRoomType = document.getElementById('ddlRoomRoomType').value;
            var pNoofRoomsVal = document.getElementById('txtNoofRooms').value;
            //var pRoomTypeID = document.getElementById('').value;
            // document.getElementById("hdnRoomValues").value = pBuildingVal + "~" + pFloorVal + "~" + pWardVal + "~" + pRoomType;

            if (pBuildingVal == "-1") {
                //Admin\RoomMasterDetails.aspx_10
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_10');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {

                    ValidationWindow(UsrAlrtMsg10, AlrtWinHdr);
                    //alert("Select Building Name");
                }

                document.getElementById('ddlRoomBuilding').focus();
                return false;
            }
            if (pFloorVal == "-1") {
                //Admin\RoomMasterDetails.aspx_11
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_11');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
                    ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
                   // alert("Select Floor Name");
                }
                document.getElementById('ddlRoomFloor').focus();
                return false;

            }
            if (pWardVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_12');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                   // alert(userMsg);
                }
                else {
                    ValidationWindow(UsrAlrtMsg12, AlrtWinHdr);
                    //alert("Select Ward Name");
                }
                document.getElementById('ddlRoomWard').focus();
                return false;

            }
            if (pRoomType == "-1") {
                //Admin\RoomMasterDetails.aspx_13
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_13');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //alert("Select the Storage Area Name");
                }
                else {
                    ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                    //alert("Select the Storage Area Name");
                }
                document.getElementById('ddlRoomRoomType').focus();
                return false;

            }
            if (pNoofRoomsVal == "") {
                //Admin\RoomMasterDetails.aspx_14
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_14');
                //                if (userMsg != null) {
                //                    alert(userMsg);
                //                }
                //                else {
               // alert("Enter No Of Storage Units");
                ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                // }
                document.getElementById('txtNoofRooms').focus();
                return false;
            }
            return true;

        }
        function CheckRoomddlValues() {
            var pFloorVal = document.getElementById('ddlRoomFloor').value;
            if (document.getElementById('ddlRoomWard') != null) {
                var pWardVal = document.getElementById('ddlRoomWard').value;
            }
            var pRoomType = document.getElementById('ddlRoomRoomType').value;
            var pBuildingVal = document.getElementById('ddlRoomBuilding').value;
            if (document.getElementById('txtNoofRooms') != null) {
                var pNoofRoomsVal = document.getElementById('txtNoofRooms').value;
            }
            if (pBuildingVal == "-1" || pWardVal == "-1" || pRoomType == "-1" || pBuildingVal == "-1") {
                return false;
            }
            return true;
        }
        function chkRoomFeesave() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var UsrAlrtMsg14 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_14") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_14") : "Add Selected Item";
            var x = document.getElementById('hdnRoomValues').value;
            if (x == "") {
                //Admin\RoomMasterDetails.aspx_15
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_15');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                   // alert(userMsg);
                }
                else {
                    ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                    //alert("Add Selected Item");
                }
                return false;
            }


            return true;
        }

        function chknoofbeds() {
            //Admin\RoomMasterDetails.aspx_29
            var UsrAlrtMsg2 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_02") : "Saved Successfully";
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var UsrAlrtMsg15 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_15") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_15") : "Enter Number of Trays";
            var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_29');
            if (userMsg != null) {
                var r = userMsg;
            }
            // var r = confirm("Press ok to continue or Cancle to Enter Number of Beds ");
            if (r == true) {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_16');
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                }
                else {
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                   // alert("Saved Successfully");
                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_17');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
                    ValidationWindow(UsrAlrtMs15, AlrtWinHdr);
                //    alert("Enter Number of Trays");
                }
            }
        }
        function chkbtnFinish1() {
        var UsrAlrtMsg15 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_15") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_15") : "Enter Number of Trays";
            var UsrAlrtMsg16 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_16") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_16") : "StorageUnit Name Can not be Same";
            var UsrAlrtMsg17 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_17") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_17") : "StorageUnit Name Can not be Empty";
            var UsrAlrtMsg18 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_18") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_18") : "Press ok to continue or Cancel to Enter Number of Trays";
            var UsrAlrtMsg19 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_19") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_19") : "Enter number of Rows";
             var UsrAlrtMsg20 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_20") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_20") : "Enter number of columns";
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var RoomRowlist = document.getElementById('hdnRoomName').value.split('~');
            var Noofbeds = document.getElementById('hdnNoofBeds').value.split('~');
            var hdnNoofRows = document.getElementById('hdnNoofRows').value.split('~');
            var hdnNoOfColumns = document.getElementById('hdnNoOfColumns').value.split('~');
            //alert(RoomRowlist);
            var RoomRowAll = RoomRowlist;


            for (var j = 0; j < RoomRowlist.length - 1; j++) {
                for (var i = 0; i < RoomRowAll.length - 1; i++) {
                    if (document.getElementById(RoomRowlist[i]).value == document.getElementById(RoomRowAll[j]).value && i != j) {
                        //Admin\RoomMasterDetails.aspx_18
                        var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_118');
                        if (userMsg != null) {
                            ValidationWindow(userMsg, AlrtWinHdr);
                           // alert(userMsg);
                        }
                        else {
                            ValidationWindow(UsrAlrtMsg16, AlrtWinHdr);
                           // alert('StorageUnit Name Can not be Same');
                        }
                        return false;
                    }
                    if (document.getElementById(RoomRowlist[i]).value == "") {
                        var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_119');
                        if (userMsg != null) {
                            ValidationWindow(userMsg, AlrtWinHdr);
                           // alert(userMsg);
                        }
                        else {
                            ValidationWindow(UsrAlrtMsg17, AlrtWinHdr);
                            //alert('StorageUnit Name Can not be Empty');
                        }
                        return false;
                    }
                }

            }
//            for (var k = 0; k < Noofbeds.length - 1; k++) {
//                if (document.getElementById(Noofbeds[k]).value == 0) {
//                    //Admin\RoomMasterDetails.aspx_29
//                    var CnfmString;
//                    var userMsg = SListForApplicationMessages.Get("Admin\\SampleArchivalMaster.aspx.cs_37");
//                    if (userMsg != null) {
//                    ValidationWindow(UsrAlrtMsg18, AlrtWinHdr);
//                       // CnfmString = 'Press ok to continue or Cancel to Enter Number of Trays';
//                    }
//                    else {
//                    ValidationWindow(UsrAlrtMsg18, AlrtWinHdr);
//                       // CnfmString = 'Press ok to continue or Cancel to Enter Number of Trays';
//                    }
//                    
//                    if (confirm(CnfmString)) {
//                        return true;
//                    }
//                    else {
//                        //Admin\RoomMasterDetails.aspx_20
//                        var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_20');
//                        if (userMsg != null) {
//                         ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
//                           // alert('Enter number of Trays');
//                        }
//                        else {
//                         ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
//                           // alert('Enter number of Trays');
//                        }
//                        document.getElementById(Noofbeds[k]).select();
//                        return false;
//                    }
//                    

//                }
//            }

            for (var a = 0; a < hdnNoofRows.length - 1; a++) {
                if (document.getElementById(hdnNoofRows[a]).value == 0 || document.getElementById(hdnNoofRows[a]).value =="") {          
                    ValidationWindow(UsrAlrtMsg19, AlrtWinHdr);
                    //alert('Enter number of Rows');
                    document.getElementById(hdnNoofRows[a]).select();
                    return false;
                }
            }

            for (var b = 0; b < hdnNoOfColumns.length - 1; b++) {
                if (document.getElementById(hdnNoOfColumns[b]).value == 0 || document.getElementById(hdnNoOfColumns[b]).value == "") {
                     ValidationWindow(UsrAlrtMsg20, AlrtWinHdr);
                    //alert('Enter number of Columns');
                    document.getElementById(hdnNoOfColumns[b]).select();
                    return false;
                }
            }
            return true;
        }


        function chkbtnFinish() {
        var UsrAlrtMsg15 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_15") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_15") : "Enter Number of Trays";
        var UsrAlrtMsg10 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_10") : "Select Building Name";
            var UsrAlrtMsg11 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_11") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_11") : "Select Floor Name";
            var UsrAlrtMsg12 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_12") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_12") : "Select Ward Name";
            var UsrAlrtMsg14 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_14") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_14") : "Enter No Of Storage Units";
            var UsrAlrtMsg13 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_13") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_13") : "Select the Storage Area Name";
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var pBuildingVal = document.getElementById('ddlRoomBuilding').value;
            var pFloorVal = document.getElementById('ddlRoomFloor').value;
            var pWardVal = document.getElementById('ddlRoomWard').value;
            var pRoomType = document.getElementById('ddlRoomRoomType').value;
            var pNoofRoomsVal = document.getElementById('txtNoofRooms').value;
            //var pNoofBedsval = document.getElementById('').value;
            //var pRoomTypeID = document.getElementById('').value;
            // document.getElementById("hdnRoomValues").value = pBuildingVal + "~" + pFloorVal + "~" + pWardVal + "~" + pRoomType;


            if (pBuildingVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_10');
                if (userMsg != null) {
                 ValidationWindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
                ValidationWindow(UsrAlrtMsg10, AlrtWinHdr);
                    //alert("Select the Building Name");
                }
                //  //Admin\RoomMasterDetails.aspx_10
                document.getElementById('ddlRoomBuilding').focus();
                return false;
            }
            if (pFloorVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_11');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
               ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
                    //alert("Select the Floor Name");
                }
                document.getElementById('ddlRoomFloor').focus();
                return false;

            }
            if (pWardVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_12');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                }
                else {
                ValidationWindow(UsrAlrtMsg12, AlrtWinHdr);
                //    alert("Select the Ward Name");
                }
                document.getElementById('ddlRoomWard').focus();
                return false;

            }
            if (pRoomType == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_13');
                if (userMsg != null) {
                ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                    //alert("Select the Storage Area Name");
                }
                else {
                    ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                    //alert("Select the Storage Area Name");
                }
                document.getElementById('ddlRoomRoomType').focus();
                return false;

            }
            if (pNoofRoomsVal == "") {
                //                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_14');
                //                if (userMsg != null) {
                //                    alert(userMsg);
                //                }
                //                else {
                ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                //alert("Enter No Of Storage Units");
                //}
                document.getElementById('txtNoofRooms').focus();
                return false;
            }
            return true;

        }
        function btnAddMoreBed() {
            var NoofBed = document.getElementById('txtNoOfBeds').value;
            if (NoofBed == "" || NoofBed == 0) {
                var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_44');
                if (userMsg != null) {
                ValidationWindow(userMsg, AlrtWinHdr);
                  // alert(userMsg);
                }
                else {
                ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
                   // alert('Enter Number of Trays!!!');
                }
                document.getElementById('txtNoOfBeds').focus();
                return false;

            }
            return true;
        }
        function ClearControlValues() {
            //Commented By Ramki
            //            var pCid = document.getElementById("hndControlID");

            //            document.getElementById(pCid).checked = false;
            //            document.getElementById(pCid).click();
            //            document.getElementById('<%=hdnControlValue.ClientID %>').value = "";

        }
        function BtnFinishBeddetails() {
         var UsrAlrtMsg13 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_21") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_21") : "Tray Name can not be same";
          var UsrAlrtMsg14 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_22") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_22") : "Tray Name can not be empty";
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
          var Vselect = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_26") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_26") : "--Select--";
            var BedRowList = document.getElementById('hdnBedName').value.split('~');
            var BedRowAll = BedRowList;
            var lstBedInfo = [];
            var sampletype = '';
            var oldhdnlstSampleTypeid = document.getElementById('hdnlstSampleTypeid');
            var hdnlstSampleTypeid = $(oldhdnlstSampleTypeid).attr('id');

            $('#GrdBedDetails tbody tr:not(:first)').each(function(i, n) {
                var $row = $(n);
                var ddlSampleSubType = $row.find($("[id$='ddlSampleSubType']")).attr('id');
                var SampleTypeSelected = $('#' + ddlSampleSubType + 'option:selected');
                var SampleTypeId = $('#' + ddlSampleSubType).val();
                if (SampleTypeId == Vselect) {
                    SampleTypeId = 0;
                }
                if (SampleTypeId != undefined) {
                    if (sampletype == '') {
                        sampletype = SampleTypeId;
                    }
                    else {
                        sampletype += ',' + SampleTypeId;
                    }
                }
            });
            $('#' + hdnlstSampleTypeid).val(sampletype);
            for (var j = 0; j < BedRowList.length - 1; j++) {
                for (var i = 0; i < BedRowAll.length - 1; i++) {
                    if (document.getElementById(BedRowList[i]).value == document.getElementById(BedRowAll[j]).value && i != j) {
                        var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_227');
                        if (userMsg != null) {
                         ValidationWindow(userMsg, AlrtWinHdr);
                            //alert(userMsg);
                        }
                        else {
                        ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                            //alert('Tray Name can not be same');
                        }
                        return false;
                    }
                    if (document.getElementById(BedRowList[i]).value == "") {
                        var userMsg = SListForApplicationMessages.Get('Admin\\SampleArchivalMaster.aspx_228');
                        if (userMsg != null) {
                           ValidationWindow(userMsg, AlrtWinHdr);
                            //alert(userMsg);
                        }
                        else {
                        ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                            //alert('Tray Name can not be empty');
                        }
                        return false;
                    }
                }
            }
            return true;
        }
        
        
    </script>

    <script type="text/javascript" language="javascript">
        function lstBedRooms_dblclick() {

            document.getElementById('<%=btnAddBed.ClientID %>').click();
        }

        function ddlBedValues() {

        }
        
    </script>

    <style type="text/css">
        #TbBed
        {
            height: 98px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="Ussssp1" runat="server">
                            <ContentTemplate>
                                <input type="hidden" runat="server" id="hdnControlValue" />
                                <input id="hdnValue" runat="server" type="hidden" />
                                <input id="hdnRoomValues" runat="server" type="hidden" />
                                <input id="hdnCollectedList" runat="server" type="hidden" />
                                <input id="hdnRowEdit" runat="server" type="hidden" />
                                <input id="hdnControl" runat="server" type="hidden" />
                                <input id="hdnddlroomrate" runat="server" type="hidden" />
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="Ussssp1">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td>
                                            <table id="tblMaster" runat="server" class="dataheader2 defaultfontcolor a-center w-100p">
                                                <tr>
                                                    <td class="a-right w-30p">
                                            <asp:Label ID="Rs_Selectoption" runat="server" meta:resourcekey="Rs_SelectoptionResource1"
                                                            Text="Select Option"></asp:Label>
                                        </td>
                                                    <td class="a-left w-15p">
                                            <asp:DropDownList ID="ddlMaster" runat="server" AutoPostBack="True" meta:resourcekey="ddlMasterResource1"
                                                OnSelectedIndexChanged="ddlMaster_SelectedIndexChanged" CssClass="ddlsmall">
                                            </asp:DropDownList>
                                                    </td>
                                                    <td class="w-55p">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table id="tbBuilding" runat="server"
                                                class="dataheader2 defaultfontcolor w-100p a-center" visible="False">
                                                <tr runat="server">
                                                    <td runat="server" class="a-right w-30p">
                                                        <asp:Label ID="lblbuName" runat="server" meta:resourcekey="lblbuNameResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server" class="a-left w-15p">
                                                        <asp:TextBox ID="txtBuilding" runat="server" CssClass="Txtboxsmall" 
                                                            AutoComplete="off" meta:resourcekey="txtBuildingResource1"></asp:TextBox>
                                                    </td>
                                                    <td id="tdChkSlotable" runat="server" style="display: none">
                                                        <asp:CheckBox ID="ChkSlotable" runat="server" onclick="setSlotableHidden(this.id)"
                                                            Text="Allow Slot Booking" meta:resourcekey="ChkSlotableResource1" />
                                                        <asp:CheckBox ID="CheckIsAnOT" runat="server" onclick="setIsAnOTHidden(this.id)"
                                                            Text="Is An OT" meta:resourcekey="CheckIsAnOTResource1" />
                                                        <asp:HiddenField runat="server" ID="hdnIsAnOT" Value="N" />
                                                        <asp:HiddenField runat="server" ID="hdnIsSlotable" Value="N" />
                                                    </td>
                                                    <td runat="server" class="w-55p a-left">
                                                        <asp:Button ID="btnSave" runat="server" BorderWidth="0px" CssClass="btn" OnClick="btnSave_Click"
                                                            OnClientClick="return checkDetails();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Add" meta:resourcekey="btnSaveResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:Panel ID="pnlRoomType" runat="server" CssClass="modalPopup dataheaderPopup w-70p"
                                                meta:resourcekey="pnlRoomTypeResource1" Style="display: none">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-center">
                                                            <strong>
                                                                <asp:Label ID="Rs_RoomTypeName" runat="server" meta:resourcekey="Rs_RoomTypeNameResource1"
                                                                    Text="Room Type Name"></asp:Label>
                                                                <asp:TextBox ID="txtRoomType" runat="server" meta:resourcekey="txtRoomTypeResource1"
                                                                    CssClass="Txtboxverysmall"></asp:TextBox>
                                                            </strong><strong>
                                                                <asp:Label ID="Rs_RateName" runat="server" meta:resourcekey="Rs_RateNameResource1"
                                                                    Text="Rate Name"></asp:Label>
                                                                <asp:DropDownList ID="ddlRoomFeeRate" runat="server" CssClass="ddl w-25p" meta:resourcekey="ddlRoomFeeRateResource1"
                                                                    onchange="javascript:RateChanged();">
                                                                </asp:DropDownList>
                                                            </strong><strong>
                                                                <asp:CheckBox ID="CheckBox1" runat="server" onclick="setSlotableHidden(this.id)"
                                                                    Text="Allow Slot Booking" meta:resourcekey="CheckBox1Resource3" />
                                                                <asp:CheckBox ID="CheckBox2" runat="server" onclick="setIsAnOTHidden(this.id)" Text="Is An OT"
                                                                    meta:resourcekey="CheckBox2Resource3" />
                                                            </strong>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="h-15">
                                                        </td>
                                                    </tr>
                                                    <tr class="dataheader1">
                                                        <td>
                                                            <asp:Label ID="Rs_RoomFeeType" runat="server" meta:resourcekey="Rs_RoomFeeTypeResource1"
                                                                Text="Room Fee Type"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_Amount" runat="server" meta:resourcekey="Rs_AmountResource1" Text="Amount"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" runat="server" Text="Fee Based On" meta:resourcekey="Label1Resource3"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_IsHalfDay" runat="server" meta:resourcekey="Rs_IsHalfDayResource1"
                                                                Text="Is Half Day"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_IsOptional" runat="server" meta:resourcekey="Rs_IsOptionalResource1"
                                                                Text="Is Optional"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_Action" runat="server" meta:resourcekey="Rs_ActionResource1" Text="Action"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:DropDownList ID="ddlRoomfeestype" CssClass="ddl" runat="server" meta:resourcekey="ddlRoomfeestypeResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:TextBox ID="txtAmount" runat="server" autocomplete="off" meta:resourcekey="txtAmountResource1"
                                                                 onkeypress="return ValidateOnlyNumeric(this);"  CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:DropDownList ID="ddlFeelogic" runat="server" meta:resourcekey="ddlFeelogicResource3">
                                                               <%-- <asp:ListItem Text="Fully Day" Value="FULDAY" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                <asp:ListItem Text="Half Day" Value="HLFDAY" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                <asp:ListItem Text="Hour Basic" Value="HOURLY" meta:resourcekey="ListItemResource9"></asp:ListItem>--%>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:CheckBox ID="chkIsVariable" runat="server" meta:resourcekey="chkIsVariableResource1"
                                                                Text="Is Half Day" />
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:CheckBox ID="chkIsOptional" runat="server" meta:resourcekey="chkIsOptionalResource1"
                                                                Text="Is Optional" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn" OnClientClick="return checkBindRoomList();"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnAddResource2" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="h-15">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5">
                                                            <table id="tblOrederedItems" border="1" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                                                style="text-align: left; font-size: 11px;" width="99%">
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center" colspan="5">
                                                            <asp:Button ID="RFTSave" runat="server" CommandArgument="Save" CssClass="btn" meta:resourcekey="RFTSaveResource1"
                                                                OnClick="btnSave_Click" OnClientClick="return chkRoomFeesave();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Save" />
                                                            <asp:Button ID="btnSaveContinue" runat="server" CommandArgument="Continue" CssClass="btn"
                                                                meta:resourcekey="btnSaveContinueResource1" OnClick="btnSave_Click" OnClientClick="return chkRoomFeesave();"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save &amp; Continue" />
                                                            &nbsp;&nbsp;
                                                            <asp:Button ID="btnpopClose" runat="server" Text="Close" CssClass="btn" OnClientClick="return ClearControlValues()"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnpopCloseResource2" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table id="tbFloor" runat="server" class="dataheader2 defaultfontcolor w-100p"
                                                visible="False">
                                                <tr runat="server">
                                                    <td runat="server" class="a-right w-30p">
                                                        <asp:Label ID="Rs_SelectBuilding" runat="server" Text="Select Building" meta:resourcekey="Rs_SelectBuildingResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server" class="w-20p">
                                                        <asp:DropDownList ID="ddlBuilding" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBuilding_SelectedIndexChanged"
                                                            CssClass="ddlsmall" meta:resourcekey="ddlBuildingResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server" class="a-right w-10p">
                                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server" class="w-15p">
                                                        <asp:TextBox ID="txtFloor" runat="server" CssClass="Txtboxsmall" 
                                                            AutoComplete="off" meta:resourcekey="txtFloorResource1"></asp:TextBox>
                                                    </td>
                                                    <td runat="server" class="w-25p">
                                                        <asp:Button ID="btnFloor" runat="server" BorderWidth="0px" CssClass="btn" OnClick="btnSave_Click"
                                                            OnClientClick="return checkDetails();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Add" meta:resourcekey="btnFloorResource1"/>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView w-100p"
                                                meta:resourcekey="gvResultResource1" OnRowDataBound="grdResult_RowDataBound"
                                                Visible="False">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SlNo." meta:resourcekey="TemplateFieldResource10">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="8%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkStatus" runat="server" meta:resourcekey="chkStatusResource1"
                                                                onclick="chkItem(this)" />
                                                            <asp:HiddenField ID="hdnRoomType" runat="server" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbl_refertext" runat="server" meta:resourcekey="lbl_refertextResource1"
                                                                Text='<%# Eval("Name") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Allow Slot Booking" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbl_IsSlotable" runat="server" Text='<%# Eval("IsSlotable") %>' meta:resourcekey="lbl_IsSlotableResource3"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle CssClass="dataheader1" />
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <RowStyle HorizontalAlign="Left" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <input id="hdnFloor" runat="server" type="hidden" />
                                            <input id="hdnWard" runat="server" type="hidden" />
                                            <input id="hdnRoomName" runat="server" type="hidden" />
                                            <input id="hdnID" runat="server" type="hidden" value="0" />
                                            <input id="hdnpSta" runat="server" type="hidden" />
                                            <input id="hdnNoofBeds" runat="server" type="hidden" />
                                            <input id="hdnBedName" runat="server" type="hidden" />
                                            <input id="hdnDays" runat="server" type="hidden" />
                                            <table id="tbRooms" runat="server" class="dataheader2 defaultfontcolor w-100p bg-row"
                                                visible="False">
                                                <tr runat="server">
                                                    <th runat="server" class="a-left">
                                                        <asp:Label ID="Rs_Building1" runat="server" Text="Building" meta:resourcekey="Rs_Building1Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" class="a-left">
                                                        <asp:Label ID="Rs_Floor" runat="server" Text="Floor" meta:resourcekey="Rs_FloorResource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" class="a-left">
                                                        <asp:Label ID="Rs_Ward" runat="server" Text="Ward" meta:resourcekey="Rs_WardResource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" class="a-left">
                                                        <asp:Label ID="Rs_StorageArea1" runat="server" Text="Storage Area" meta:resourcekey="Rs_StorageArea1Resource1"></asp:Label>
                                                    </th>
                                                    <th runat="server" class="a-left">
                                                        <asp:Label ID="Rs_NoofRooms" runat="server" Text="No of Storage Unit" meta:resourcekey="Rs_NoofTraysResource1"></asp:Label>
                                                    </th>
                                                    <th>
                                                    </th>
                                                    <th runat="server">
                                                        <asp:Label ID="Rs_StorageUnit" runat="server" Text="Storage Unit" meta:resourcekey="Rs_StorageUnitResource1"
                                                            Visible="False"></asp:Label>
                                                    </th>
                                                    <th runat="server">
                                                        <asp:Label ID="Rs_Tray" runat="server" Text="Tray" meta:resourcekey="Rs_TrayResource1"
                                                            Visible="False"></asp:Label>
                                                    </th>
                                                </tr>
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlRoomBuilding" runat="server" AutoPostBack="True" OnSelectedIndexChanged="loadFloorWard_Details"
                                                            CssClass="ddlsmall" meta:resourcekey="ddlRoomBuildingResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlRoomFloor" runat="server" AutoPostBack="True" onchange="javascript:if(!CheckRoomddlValues()) return false;"
                                                            OnSelectedIndexChanged="loadRoomMaster_Details" CssClass="ddlsmall" 
                                                            meta:resourcekey="ddlRoomFloorResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlRoomWard" runat="server" AutoPostBack="True" onchange="javascript:if(!CheckRoomddlValues()) return false;"
                                                            OnSelectedIndexChanged="loadRoomMaster_Details" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlRoomRoomType" runat="server" AutoPostBack="True" onchange="javascript:if(!CheckRoomddlValues()) return false;"
                                                            OnSelectedIndexChanged="loadRoomMaster_Details" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtNoofRooms" runat="server" MaxLength="3"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                            Text='<%# Bind("NoBeds") %>' CssClass="Txtboxverysmall" 
                                                            meta:resourcekey="txtNoofRoomsResource1"></asp:TextBox>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:Button ID="btnAddRooms" runat="server" CssClass="btn" OnClick="btnAddRooms_Click"
                                                            OnClientClick="return chkRoomDetails();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Add" Width="80px" meta:resourcekey="btnAddRoomsResource1" />
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlStorageUnit" runat="server" AutoPostBack="True" Width="100%"
                                                            OnSelectedIndexChanged="loadMaster_Details" CssClass="ddlsmall" Visible="false">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList ID="ddlTrays" runat="server" AutoPostBack="True" Width="100%" CssClass="ddlsmall"
                                                            OnSelectedIndexChanged="ddlTrays_SelectedIndexChanged" Visible="false">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <tr>
                                                <td id="tdDetete" runat="server" class="a-center" 
                                                    style="display: block; margin-left: 40px;">
                                                    <asp:Button ID="btnDetete" runat="server" CssClass="btn" meta:resourcekey="btnDeteteResource1"
                                                        OnClientClick="javascript:document.getElementById('hdnControlValue').value=confirm(msgDelPrompt);"
                                                        onmouseout="this.className='btn'" 
                                                        onmouseover="this.className='btn btnhov'" Text="Delete"
                                                        Visible="False"  />
                                                    <asp:GridView ID="GrdRoomDetails" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView w-100p"
                                                        DataKeyNames="FloorID,WardID,RoomTypeID,RoomID,BedID,NoRows,NoColumns" meta:resourcekey="GrdRoomDetailsResource1"
                                                        OnRowDataBound="GrdRoomDetails_RowDataBound" Style="display: block;" Visible="False">
                                                        <Columns>
                                                            <asp:BoundField DataField="BuildingName" HeaderText="Building" meta:resourcekey="BoundFieldResource1">
                                                                <ItemStyle Height="7px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="FloorName" HeaderText="Floor" meta:resourcekey="BoundFieldResource2">
                                                                <ItemStyle Height="7px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="WardName" HeaderText="Ward" meta:resourcekey="BoundFieldResource3">
                                                                <ItemStyle Height="7px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="RoomTypeName" HeaderText="RoomType" meta:resourcekey="BoundFieldResource4">
                                                                <ItemStyle Height="7px" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Storage Unit Name" meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtRoomName" runat="server" Height="20px" meta:resourcekey="txtRoomNameResource1"
                                                                        Text='<%# Bind("RoomName") %>' Width="150px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ControlStyle Height="18px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Storage Unit Type" meta:resourcekey="TemplateFieldResource11">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList runat="server" Width="205px" ID="ddlSampleCondition" CssClass="ddl"
                                                                        meta:resourcekey="ddlSampleCondition2">
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>
                                                                <ControlStyle Height="22px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="No Of Trays" meta:resourcekey="TemplateFieldTrayResource4">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtBeds" runat="server" Height="12px" meta:resourcekey="txtBedsResource1"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"  Text='<%# Bind("NoBeds") %>' Width="60px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ControlStyle Height="12px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="No Of Rows" 
                                                                meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtRows" runat="server" Height="12px" meta:resourcekey="txtBedsResource1"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"  Text='<%# Bind("NoRows") %>' Width="60px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ControlStyle Height="12px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="No Of Columns" 
                                                                meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtColumns" runat="server" Height="12px" meta:resourcekey="txtBedsResource1"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"  Text='<%# Bind("NoColumns") %>' Width="60px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ControlStyle Height="12px" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                        <RowStyle HorizontalAlign="Left" />
                                                    </asp:GridView>
                                                </td>
                                                <tr>
                                                    <td id="tdRoomFinish" runat="server" align="center" colspan="2" style="display: none;">
                                                        <asp:Button ID="btnSaveRooms" runat="server" CssClass="btn" meta:resourcekey="btnSaveRoomsResource1"
                                                            OnClick="btnSave_Click" OnClientClick="return chkbtnFinish1();" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" Text="Finish" />
                                                        <input id="hdnNoofRows" runat="server" type="hidden" />
                                                        <input id="hdnNoOfColumns" runat="server" type="hidden" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" class="v-top">
                                                        <table id="TbBed" runat="server" class="dataheader2 defaultfontcolor w-100p bg-row"
                                                            visible="False">
                                                            <tr runat="server">
                                                                <th runat="server">
                                                                    <asp:Label ID="Rs_Building" runat="server" Text="Building" 
                                                                        meta:resourcekey="Rs_BuildingResource1"></asp:Label>
                                                                </th>
                                                                <th runat="server">
                                                                    <asp:Label ID="Rs_StorageArea" runat="server" Text="Storage Area" 
                                                                        meta:resourcekey="Rs_StorageAreaResource1"></asp:Label>
                                                                </th>
                                                                <th runat="server">
                                                                    <asp:Label ID="Rs_ListofStorageUnits" runat="server" 
                                                                        Text="List of Storage Units" meta:resourcekey="Rs_ListofStorageUnitsResource1"></asp:Label>
                                                                </th>
                                                            </tr>
                                                            <tr runat="server">
                                                                <td runat="server" class="a-center v-top">
                                                                    <asp:DropDownList ID="ddlBedBuilding" runat="server" AutoPostBack="True" Height="26px"
                                                                        OnSelectedIndexChanged="LoadRoomBedList" CssClass="ddlsmall">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td runat="server" class="a-center v-top">
                                                                    <asp:DropDownList ID="ddlBedRoomType" runat="server" AutoPostBack="True" Height="29px"
                                                                        OnSelectedIndexChanged="LoadRoomBedList" CssClass="ddlsmall">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td runat="server" class="a-center v-top">
                                                                    <asp:ListBox ID="lstBedRooms" runat="server" Height="57px" Width="280px" 
                                                                        ToolTip="Double Click To Select Storage Unit" 
                                                                        meta:resourcekey="lstBedRoomsResource1">
                                                                    </asp:ListBox>
                                                                    <br />
                                                                    <font color="red" size="1" style="clip">
                                                                        <asp:Label ID="Rs_DoubleClickToSelectStorageUnit" runat="server" 
                                                                        Text="Double Click To Select Storage Unit" 
                                                                        meta:resourcekey="Rs_DoubleClickToSelectStorageUnitResource1"></asp:Label>
                                                                    </font>
                                                                </td>
                                                                <td runat="server" class="a-center" style="display: none;">
                                                                    <asp:Button ID="btnAddBed" runat="server" CssClass="btn" OnClick="GetBedDetails"
                                                                        Text="EditBed" meta:resourcekey="btnAddBedResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="tdSaveBed" runat="server" class="a-center v-top" colspan="2" style="display: none;">
                                                        <asp:Label ID="Rs_AddMoreTrays" runat="server" meta:resourcekey="Rs_AddMoreTraysResource1"
                                                            Text="Add More Trays"></asp:Label>
                                                        <asp:TextBox ID="txtNoOfBeds" runat="server" meta:resourcekey="txtNoOfTraysResource1"
                                                            CssClass="Txtboxverysmall"></asp:TextBox>
                                                        <asp:Button ID="btnAddMore" runat="server" CssClass="btn" meta:resourcekey="btnAddMoreResource2"
                                                            OnClientClick="return btnAddMoreBed();" OnClick="btnAddMore_Click" Text="ADD" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center" colspan="2">
                                                        <asp:GridView ID="GrdBedDetails" runat="server" AutoGenerateColumns="False" DataKeyNames="BuildingID,RoomTypeID,RoomID,ID"
                                                            meta:resourcekey="GrdBedDetailsResource2" CssClass="gridView mytable1 w-100p" Visible="False" OnRowDataBound="GrdBedDetails_OnRowDataBound">
                                                            <Columns>
                                                                <asp:BoundField DataField="BuildingName" HeaderText="Building Name" meta:resourcekey="BoundFieldResource5">
                                                                    <ItemStyle Height="12px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="RoomTypeName" HeaderText="Storage Area" meta:resourcekey="BoundFieldResource11">
                                                                    <ItemStyle Height="12px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="RoomName" HeaderText="Room Name" meta:resourcekey="BoundFieldResource7">
                                                                    <ItemStyle Height="12px" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Tray Name" meta:resourcekey="TemplateFieldTraysResource">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtBedName" runat="server" meta:resourcekey="txtBedNameResource1"
                                                                            Text='<%# Bind("WardName") %>' Style="text-align: center"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <ControlStyle Height="15px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText=" Rows " meta:resourcekey="TemplateFieldRowsResource5">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtRows" runat="server" meta:resourcekey="txtRowsResource1" Text='<%# Bind("NoRows") %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <ControlStyle Height="12px" Width="35px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Columns" meta:resourcekey="TemplateFieldColumnsResource5">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtColumns" runat="server" Style="center" meta:resourcekey="txtColumnsResource1"
                                                                        Text='<%# Bind("NoColumns") %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <ControlStyle Height="12px" Width="35px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Tray Type" meta:resourcekey="TemplateFieldTrayTypeResource6">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList runat="server" ID="ddlTrayType" CssClass="ddl" meta:resourcekey="ddlTrayType1"
                                                                            onchange="HideDays(this.id)">
                                                                        </asp:DropDownList>
                                                                    </ItemTemplate>
                                                                    <ControlStyle Height="18px" Width="100px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sample Type" meta:resourcekey="TemplateFieldTrayTypeResource7">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList runat="server" ID="ddlSampleType" CssClass="ddl" onchange="GetSampleSubType(this.id)">
                                                                        </asp:DropDownList>
                                                                    </ItemTemplate>
                                                                    <ControlStyle Height="18px" Width="100px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sample SubType" meta:resourcekey="TemplateFieldTrayTypeResource8">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList runat="server" ID="ddlSampleSubType" CssClass="ddl">
                                                                        </asp:DropDownList>
                                                                    </ItemTemplate>
                                                                    <ControlStyle Height="18px" Width="100px" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Days" meta:resourcekey="TemplateFieldTrayTypeResource5">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBoxList ID="RTCheckBox" runat="server" meta:resourcekey="RTCheckBoxResource1"
                                                                            RepeatColumns="8" RepeatDirection="Horizontal" onclick="Checkbox(this.id)" disabled="true"/>
                                                                    </ItemTemplate>
                                                                    <ControlStyle Height="18px" Width="400px" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center" colspan="2">
                                                        <asp:Button ID="btnSaveNOofBed" runat="server" CssClass="btn" meta:resourcekey="btnSaveNOofBedResource1"
                                                            OnClick="btnSave_Click" OnClientClick="javascript:return BtnFinishBeddetails();"
                                                            Style="display: none;" Text="Finish" />
                                                    </td>
                                                </tr>
                                                <tr id="DepartNme" runat="server" visible="false">
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblDeptName" runat="server" Text="Department Name" meta:resourcekey="Rs_DeptNameResource1"></asp:Label>
                                                                    <asp:DropDownList ID="ddlDeptName" runat="server" Width="200px" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblAnlyName" runat="server" Text="Analyser Name" meta:resourcekey="Rs_AnalNameResource1"></asp:Label>
                                                                    <asp:DropDownList ID="ddlAnalyName" runat="server" Width="200px" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnApply" runat="server" CssClass="btn" Text="Apply" OnClientClick="ApplyDeptAndAnal(); return false;"
                                                                        meta:resourcekey="Rs_btnApplySampleArchivalResource1"  />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="grdSampleArchival" runat="server" Height="100%" Visible ="False"
                                                            CssClass="mytable1 gridView w-100p" 
                                                            OnRowDataBound="grdSampleArchival_RowDataBound" 
                                                            HeaderStyle-CssClass="dataheader1" 
                                                            meta:resourcekey="grdSampleArchivalResource1">
<HeaderStyle CssClass="dataheader1"></HeaderStyle>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center">
                                                        <asp:Button ID="btnSaveSampleArchival" runat="server" CssClass="btn" 
                                                            Text="Finish" Visible="False"
                                                            OnClientClick="SaveSampleArchival();" 
                                                            OnClick="btnSaveSampleArchival_Click" 
                                                            meta:resourcekey="Rs_btnSaveSampleArchivalResource1" />
                                                    </td>
                                                </tr>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>
                                <ajc:ModalPopupExtender ID="mpeRoomType" runat="server" CancelControlID="btnpopClose"
                                    DynamicServicePath="" Enabled="True" PopupControlID="pnlRoomType" TargetControlID="btnDummy"
                                    BackgroundCssClass="modalBackground">
                                </ajc:ModalPopupExtender>
                                <input id="btnDummy" runat="server" style="display: none;" type="button" />
                                <input id="hndControlID" runat="server" type="hidden" />
                                <asp:HiddenField ID="hdnOrgID" runat="server" />
                                <asp:HiddenField ID="hdnlstSampleTypeid" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />        
        <asp:HiddenField ID="hdnMessages" runat="server" />
 
<%--    <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>--%>

    <script type="text/javascript">
        var selectedRowIndex = [];
        var selectedColumnIndex = [];
        var selectedCellIndex = [];
        function SelectRow(rowIndex) {
            $("#grdSampleArchival tr:eq(" + rowIndex + ")").each(function() {
                var checkBox = $(this).find("input[type='checkbox']");
                if (checkBox.is(':checked')) {
                    selectedRowIndex.push(rowIndex);
                    $('td:not(:eq(0))', this).each(function() {
                        $(this).css('background-color', 'white');
                    });
                }
                else {
                    var index = $.inArray(rowIndex, selectedRowIndex);
                    if (index != -1) {
                        selectedRowIndex.pop(index);
                        $('td:not(:eq(0))', this).each(function() {
                            $(this).css('background-color', '');
                        });
                    }
                }
            });
        }
        function SelectColumn(columnIndex) {
            var color = 'white';
            $("#grdSampleArchival tr:eq(0) th:eq(" + columnIndex + ")").each(function() {
                var checkBox = $(this).find("input[type='checkbox']");
                if (checkBox.is(':checked')) {
                    selectedColumnIndex.push(columnIndex);
                }
                else {
                    var index = $.inArray(columnIndex, selectedColumnIndex);
                    if (index != -1) {
                        selectedRowIndex.pop(index);
                        color = '';
                    }
                }
            });
            $("#grdSampleArchival tr:not(:eq(0))").each(function() {
                $('td:eq(' + columnIndex + ')', this).each(function() {
                    $(this).css('background-color', color);
                });
            });
        }
        function SelectAll() {
            var isSelectAllChecked = false;
            $("#grdSampleArchival tr:eq(0) th:eq(0)").each(function(i, val) {
                    var checkBox = $(this).find("input[type='checkbox']");
                    isSelectAllChecked = (checkBox.is(':checked'));
            });
            $("#grdSampleArchival tr:not(:eq(0))").each(function() {
                var checkBox = $(this).find("input[type='checkbox']");
                if (isSelectAllChecked) {
                    $(this).css('background-color', 'white');
                    checkBox.attr('checked', 'checked');
                    selectedRowIndex.push($(this).index());
                }
                else {
                    $(this).css("background-color", "");
                    checkBox.removeAttr('checked');
                }
            });
            if (!isSelectAllChecked) {
                selectedRowIndex = [];
            }
        }
        function SelectCell(rowIndex, columnIndex) {
            var isCellAlreadyChecked = false;
            var index = -1;
            var color = 'white';
            $.each(selectedCellIndex, function(i, item) {
                if (rowIndex == item.rowIndex && columnIndex == item.columnIndex) {
                    isCellAlreadyChecked = true;
                    index = i;
                    color = '';
                }
            });
            $("#grdSampleArchival tr:eq(" + rowIndex + ") td:eq(" + columnIndex + ")").each(function() {
                $(this).css('background-color', color);
            });
            if (isCellAlreadyChecked) {
                selectedCellIndex.pop(index);
            }
            else {
                selectedCellIndex.push({ rowIndex: rowIndex, columnIndex: columnIndex });
            }
        }
        function ApplyDeptAndAnal() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_Alert") : "Alert";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_23") != null ? SListForAppMsg.Get("Admin_SampleArchivalMaster_aspx_23") : "There is no selection to apply the details";
            var SelectedDept = $("#ddlDeptName option:selected");
            var SelectedDevice = $("#ddlAnalyName option:selected");
            var selectedDeptID = 0;
            var selectedDeviceID = 0;
            var selectedDeptName = "";
            var selectedDeviceName = "";
            
            //if (($(SelectedDept).val() != '0' || $(SelectedDevice).val() != '0') && (selectedRowIndex.length > 0 || selectedColumnIndex.length > 0 || selectedCellIndex.length > 0)) {
            if (selectedRowIndex.length > 0 || selectedColumnIndex.length > 0 || selectedCellIndex.length > 0) {
                selectedDeptID = $(SelectedDept).val() == '0' ? 0 : $(SelectedDept).val();
                selectedDeviceID = $(SelectedDevice).val() == '0' ? 0 : $(SelectedDevice).val();
                selectedDeptName = $(SelectedDept).val() == '0' ? "" : $(SelectedDept).text();
                selectedDeviceName = $(SelectedDevice).val() == '0' ? "" : $(SelectedDevice).text();
                $.each(selectedRowIndex, function(i, item) {
                    $("#grdSampleArchival tr:eq(" + item + ") td").each(function(j, val) {
                        var lblGridCellData = $(this).find("span[id$='lblGridCellData']");
                        var lblGridDeptID = $(this).find("span[id$='lblGridDeptID']");
                        var lblGridDeviceID = $(this).find("span[id$='lblGridDeviceID']");
                        lblGridCellData.html(item + "," + j + (selectedDeptName == "" ? "" : "<br/>" + selectedDeptName) + (selectedDeviceName == "" ? "" : "<br/>" + selectedDeviceName));
                        lblGridDeptID.html(selectedDeptID);
                        lblGridDeviceID.html(selectedDeviceID);
                    });
                });
                $.each(selectedColumnIndex, function(i, item) {
                    $("#grdSampleArchival tr:not(:eq(0))").each(function(j, val) {
                        var $column = $(this).find("td:eq(" + item + ")");
                        var lblGridCellData = $column.find("span[id$='lblGridCellData']");
                        var lblGridDeptID = $column.find("span[id$='lblGridDeptID']");
                        var lblGridDeviceID = $column.find("span[id$='lblGridDeviceID']");
                        lblGridCellData.html((j + 1) + "," + item + (selectedDeptName == "" ? "" : "<br/>" + selectedDeptName) + (selectedDeviceName == "" ? "" : "<br/>" + selectedDeviceName));
                        lblGridDeptID.html(selectedDeptID);
                        lblGridDeviceID.html(selectedDeviceID);
                    });
                });
                $.each(selectedCellIndex, function(i, item) {
                    $("#grdSampleArchival tr:eq(" + item.rowIndex + ") td:eq(" + item.columnIndex + ")").each(function(j, val) {
                        var lblGridCellData = $(this).find("span[id$='lblGridCellData']");
                        var lblGridDeptID = $(this).find("span[id$='lblGridDeptID']");
                        var lblGridDeviceID = $(this).find("span[id$='lblGridDeviceID']");
                        lblGridCellData.html(item.rowIndex + "," + item.columnIndex + (selectedDeptName == "" ? "" : "<br/>" + selectedDeptName) + (selectedDeviceName == "" ? "" : "<br/>" + selectedDeviceName));
                        lblGridDeptID.html(selectedDeptID);
                        lblGridDeviceID.html(selectedDeviceID);
                    });
                });
                selectedRowIndex = [];
                selectedColumnIndex = [];
                selectedCellIndex = [];
                $("#grdSampleArchival tr:eq(0)").each(function() {
                    var checkBox = $(this).find("input[type='checkbox']");
                    checkBox.removeAttr('checked');
                });
                $("#grdSampleArchival tr:not(:eq(0))").each(function() {
                    $('td', this).each(function(i, val) {
                        if (i == 0) {
                            var checkBox = $(this).find("input[type='checkbox']");
                            if (checkBox != null && checkBox != undefined)
                                checkBox.removeAttr('checked');
                        }
                        else {
                            $(this).css('background-color', '');
                        }
                    });
                });
                $("#ddlDeptName").val('0');
                $("#ddlAnalyName").val('0');
            }
            else {
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                //alert("There is no selection to apply the details");
            }
        }
        function SaveSampleArchival() {
            var lstSampleArchival = [];
            var selectedTrayID = $("#ddlTrays option:selected").val();
            $("#grdSampleArchival tr:not(:eq(0))").each(function(i, row) {
            $('td:not(:eq(0))', this).each(function(j, column) {
                    var lblGridDeptID = $(this).find("span[id$='lblGridDeptID']").html();
                    var lblGridDeviceID = $(this).find("span[id$='lblGridDeviceID']").html();
                    lstSampleArchival.push({
                        StorageRackID:selectedTrayID,
                        RowNo: i + 1,
                        ColumnNo: j + 1,
                        DeptID: $.trim(lblGridDeptID),
                        InstrumentID: $.trim(lblGridDeviceID)
                    });
                });
            });
            $("#hdnLstSampleArchival").val(JSON.stringify(lstSampleArchival));
        }
        function GetSampleSubType(id) {
            //   debugger;
            var SampleGroupType = document.getElementById(id).value;
            var ddlSampleSubTypes = id.replace("ddlSampleType", "ddlSampleSubType");
            if (SampleGroupType != 0) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/GetSampleSubType",
                    data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, GroupTypeID: SampleGroupType }),
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        if (data.d.length > 0) {
                            var lstSampleType = data.d;
                            if (lstSampleType.length > 0) {
                                $('#' + ddlSampleSubTypes).children('option:not(:first)').remove();
                                for (var i = 0; i < lstSampleType.length; i++) {
                                    $('#' + ddlSampleSubTypes).append($("<option></option>").val(lstSampleType[i].SampleCode).html(lstSampleType[i].SampleDesc));

                                }
                            }
                        }

                    },
                    error: function(result) {
                        alert("Error");
                    }
                });
            }
            else {
                $('#' + ddlSampleSubTypes).children('option:not(:first)').remove();
            }
        }
    </script>

  <%--  <script type="text/javascript" src="../Scripts/jquery-ui-1.8.13.custom.min.js"></script>--%>
    <asp:HiddenField ID="hdnLstSampleArchival" Value="" runat="server" />
    <asp:HiddenField ID="hdnCheckList" Value="" runat="server" />
    </form>
</body>
</html>
