<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoomMasterDetails.aspx.cs"
    Inherits="Admin_RoomMasterDetails" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Master</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="Stylesheet" id="StyleSheet1" runat="server" />
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else if (key == "Admin\\RoomMasterDetails.aspx.cs_31") {
            alert('Already Exist!');
                return false;
            }

            else if (key == "Admin\\RoomMasterDetails.aspx.cs_32") {
            alert('Saved Successfully');
                return false;
            }
            else if (key == "Admin\\RoomMasterDetails.aspx.cs_33") {
            alert('Changes Saved Successfully!');
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

                case "ROOM_TYPE":
                    document.getElementById("tdDetete").style.display = pDisp;
                    document.getElementById("txtBuilding").value = sVal[2];
                    document.getElementById("hdnValue").value = sVal[1];
                    document.getElementById("btnSave").value = pSta;
                    TableRoomType();
                    document.getElementById("txtRoomType").value = sVal[2];
                    if (sVal[2] != "") {
                        document.getElementById("btnDummy").click();
                    }
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
            var x = document.getElementById('hdnControlValue').value;
            var ddlMaster = document.getElementById("ddlMaster").value;
            var pid = 0;
            var pname = '';
            var pbid = 0;
            switch (ddlMaster) {
                case "BUILDING":
                    if (document.getElementById("txtBuilding").value.trim() == '') {
                        alert("Enter the " + ddlMaster + " Name");
                        document.getElementById('txtBuilding').focus();
                        return false;
                    }
                    if (document.getElementById("btnSave").value != "Add") {
                        pid = document.getElementById("hdnControlValue").value.split("^")[0].split("~")[1];
                        pname = document.getElementById('txtBuilding').value.trim();
                        document.getElementById("hdnpSta").value = "Update";
                    }
                    if (document.getElementById("btnSave").value != "Update") {
                        pname = document.getElementById('txtBuilding').value.trim();
                        document.getElementById("hdnpSta").value = "Add";
                    }

                    break;
                case "FLOOR":

                case "WARD":

                    if (document.getElementById("ddlBuilding").value == '-1') {
                        //Admin\RoomMasterDetails.aspx_2

                        var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_2');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('Select the Building');
                        }
                        document.getElementById('ddlBuilding').focus();
                        return false;
                    }
                    if (document.getElementById("txtFloor").value.trim() == '') {

                        alert("Enter the " + ddlMaster + "  Name");
                        document.getElementById('txtFloor').focus();
                        return false;
                    }

                    if (document.getElementById("btnFloor").value != "Add") {
                        pid = document.getElementById("hdnControlValue").value.split("^")[0].split("~")[1];
                        pname = document.getElementById('txtFloor').value.trim();
                        pbid = document.getElementById("ddlBuilding").value;
                        document.getElementById("hdnpSta").value = "Update";
                    }
                    if (document.getElementById("btnFloor").value != "Update") {
                        pbid = document.getElementById("ddlBuilding").value;
                        pname = document.getElementById('txtFloor').value.trim();
                        document.getElementById("hdnpSta").value = "Add";
                    }
                    break;

                case "ROOM_TYPE":
                    //debugger;
                    //Commented By Ramki
                                        if (document.getElementById("txtBuilding").value.trim() == '') {
                                            alert("Enter the " + ddlMaster + " Name");
                                            document.getElementById('txtBuilding').focus();
                                            return false;
                                        }
                    if (document.getElementById("btnSave").value != "Add") {
                        pid = document.getElementById("hdnControlValue").value.split("^")[0].split("~")[1];
                        pname = document.getElementById('txtBuilding').value.trim();
                        document.getElementById("btnDummy").click();
                        document.getElementById("hdnpSta").value = "Update";
                        return false;
                    }
                    if (document.getElementById("btnSave").value != "Update") {
                        document.getElementById("ddlRoomFeeRate").value = 0;
                        document.getElementById("btnSaveContinue").style.display = "none";
                        document.getElementById("hdnpSta").value = "Add";
                        pname = document.getElementById('txtBuilding').value.trim();
                        document.getElementById("txtRoomType").value = pname;
                        if (document.getElementById("hdnRoomValues").value != null && document.getElementById("hdnRoomValues") != undefined) {
                            document.getElementById("hdnRoomValues").value = "";
                            //                            if (document.getElementById("ddlRoomFeeRate").value)
                            TableRoomType();
                            document.getElementById("btnDummy").click();
                            return false;
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
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_5');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Enter the Building Name');
                }
                document.getElementById('txtBuilding').focus();
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
            cell5.innerHTML ="Fee based On"
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
            var pFeeId = document.getElementById('ddlRoomfeestype').value;
            var pRateName = document.getElementById('ddlRoomFeeRate').value;
            if (pRateName == 0) {
                //Admin\RoomMasterDetails.aspx_6
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_6');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select Rate Name");
                }
              
                document.getElementById('ddlRoomFeeRate').focus();
                return false;
            }

            if (pFeeId == -1) {
                //Admin\RoomMasterDetails.aspx_7
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select the Room Fee Type ");
                }
                document.getElementById('ddlRoomfeestype').focus();
                return false;
            }
            if (Number(document.getElementById('txtAmount').value) < 0.50) {
                //Admin\RoomMasterDetails.aspx_8
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_8');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Enter the Amount ");
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
                            var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_9');
                            if (userMsg != null) {
                                alert(userMsg);
                            }
                            else {
                                alert("Room Fee Type Already Exists ");
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
                            pIsOp + "~" + pRateID + "~" + pFeeLogicID +"~"+ pFeebasedon + "^";

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
            var pBuildingVal = document.getElementById('ddlRoomBuilding').value;
            var pFloorVal = document.getElementById('ddlRoomFloor').value;
            var pWardVal = document.getElementById('ddlRoomWard').value;
            var pRoomType = document.getElementById('ddlRoomRoomType').value;
            var pNoofRoomsVal = document.getElementById('txtNoofRooms').value;
            //var pRoomTypeID = document.getElementById('').value;
            // document.getElementById("hdnRoomValues").value = pBuildingVal + "~" + pFloorVal + "~" + pWardVal + "~" + pRoomType;

            if (pBuildingVal == "-1") {
                //Admin\RoomMasterDetails.aspx_10
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_10');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select Building Name");
                }
              
                document.getElementById('ddlRoomBuilding').focus();
                return false;
            }
            if (pFloorVal == "-1") {
                //Admin\RoomMasterDetails.aspx_11
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_11');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select Floor Name");
                }
                document.getElementById('ddlRoomFloor').focus();
                return false;

            }
            if (pWardVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_12');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select Ward Name");
                }
                document.getElementById('ddlRoomWard').focus();
                return false;

            }
            if (pRoomType == "-1") {
                //Admin\RoomMasterDetails.aspx_13
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_13');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select RoomType Name");
                }
                document.getElementById('ddlRoomRoomType').focus();
                return false;

            }
            if (pNoofRoomsVal == "") {
                //Admin\RoomMasterDetails.aspx_14
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_14');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Enter No Of Rooms");
                }
                document.getElementById('txtNoofRooms').focus();
                return false;
            }
            return true;

        }
        function CheckRoomddlValues() {
            var pFloorVal = document.getElementById('ddlRoomFloor').value;
            var pWardVal = document.getElementById('ddlRoomWard').value;
            var pRoomType = document.getElementById('ddlRoomRoomType').value;
            var pBuildingVal = document.getElementById('ddlRoomBuilding').value;
            var pNoofRoomsVal = document.getElementById('txtNoofRooms').value;
            if (pBuildingVal == "-1" || pWardVal == "-1" || pRoomType == "-1" || pBuildingVal == "-1") {
                return false;
            }
            return true;
        }
        function chkRoomFeesave() {

            var x = document.getElementById('hdnRoomValues').value;
            if (x == "") {
                //Admin\RoomMasterDetails.aspx_15
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_15');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Add Selected Item");
                }
                return false;
            }


            return true;
        }

        function chknoofbeds() {
            //Admin\RoomMasterDetails.aspx_29
            var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_29');
            if (userMsg != null) {
                var r = userMsg;
            }
           // var r = confirm("Press ok to continue or Cancle to Enter Number of Beds ");
            if (r == true) {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_16');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Saved Successfully");
                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_17');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Enter Number of Beds");
                }
            }
        }
        function chkbtnFinish1() {
            var RoomRowlist = document.getElementById('hdnRoomName').value.split('~');
            var Noofbeds = document.getElementById('hdnNoofBeds').value.split('~');
            //alert(RoomRowlist);
            var RoomRowAll = RoomRowlist;


            for (var j = 0; j < RoomRowlist.length - 1; j++) {
                for (var i = 0; i < RoomRowAll.length - 1; i++) {
                    if (document.getElementById(RoomRowlist[i]).value == document.getElementById(RoomRowAll[j]).value && i != j) {
                        //Admin\RoomMasterDetails.aspx_18
                        var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_18');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('RoomName Can not be Same');
                        }
                        return false;
                    }
                    if (document.getElementById(RoomRowlist[i]).value == "") {
                        var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_19');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('RoomName Can not be Empty');
                        }
                        return false;
                    }
                }

            }
            for (var k = 0; k < Noofbeds.length - 1; k++) {
                if (document.getElementById(Noofbeds[k]).value == 0) {
                    //Admin\RoomMasterDetails.aspx_29
                    var CnfmString;
                    var userMsg = SListForApplicationMessages.Get("Admin\\RoomMasterDetails.aspx.cs_37");
                    if (userMsg != null) {
                        CnfmString = userMsg;
                    }
                    else {
                        CnfmString = 'Press ok to continue or Cancel to Enter Number of Beds';
                    }
//                    if (confirm('Press ok to continue or Cancel to Enter Number of Beds')) {
                        if(confirm(CnfmString)){
                        return true;
                    }
                    else {
                        //Admin\RoomMasterDetails.aspx_20
                        var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_20');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('Enter number of Beds');
                        }
                        document.getElementById(Noofbeds[k]).select();
                        return false;
                    }

                }
            }
            return true;
        }


        function chkbtnFinish() {
            var pBuildingVal = document.getElementById('ddlRoomBuilding').value;
            var pFloorVal = document.getElementById('ddlRoomFloor').value;
            var pWardVal = document.getElementById('ddlRoomWard').value;
            var pRoomType = document.getElementById('ddlRoomRoomType').value;
            var pNoofRoomsVal = document.getElementById('txtNoofRooms').value;
            //var pNoofBedsval = document.getElementById('').value;
            //var pRoomTypeID = document.getElementById('').value;
            // document.getElementById("hdnRoomValues").value = pBuildingVal + "~" + pFloorVal + "~" + pWardVal + "~" + pRoomType;


            if (pBuildingVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_10');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select the Building Name");
                }
                //  //Admin\RoomMasterDetails.aspx_10
                document.getElementById('ddlRoomBuilding').focus();
                return false;
            }
            if (pFloorVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_11');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select the Floor Name");
                }
                document.getElementById('ddlRoomFloor').focus();
                return false;

            }
            if (pWardVal == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_12');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select the Ward Name");
                }
                document.getElementById('ddlRoomWard').focus();
                return false;

            }
            if (pRoomType == "-1") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_13');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Select the RoomType Name");
                }
                document.getElementById('ddlRoomRoomType').focus();
                return false;

            }
            if (pNoofRoomsVal == "") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_14');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert("Enter No Of Rooms");
                }
                document.getElementById('txtNoofRooms').focus();
                return false;
            }
            return true;

        }
        function btnAddMoreBed() {
            var NoofBed = document.getElementById('txtNoOfBeds').value;
            if (NoofBed == "") {
                var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_17');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Enter Number of Beds');
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
            var BedRowList = document.getElementById('hdnBedName').value.split('~');
            var BedRowAll = BedRowList;
            for (var j = 0; j < BedRowList.length - 1; j++) {
                for (var i = 0; i < BedRowAll.length - 1; i++) {
                    if (document.getElementById(BedRowList[i]).value == document.getElementById(BedRowAll[j]).value && i != j) {
                        var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_27');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('Bed Name can not be same');
                        }
                        return false;
                    }
                    if (document.getElementById(BedRowList[i]).value == "") {
                        var userMsg = SListForApplicationMessages.Get('Admin\\RoomMasterDetails.aspx_28');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('Bed Name can not be empty');
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
                                <input type="hidden" runat="server" id="hdnControlValue">
                                    <input id="hdnValue" runat="server" type="hidden"/>
                                    <input id="hdnRoomValues" runat="server" type="hidden"/>
                                    <input id="hdnCollectedList" runat="server" type="hidden"/>
                                    <input id="hdnRowEdit" runat="server" type="hidden"/>
                                    <input id="hdnControl" runat="server" type="hidden"/>
                                    <input id="hdnddlroomrate" runat="server" type="hidden"/>
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="Ussssp1">
                                        
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <%--<uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                                    <table class="w-100p searchPanel">
                                        <tr>
                                            <td class="a-right">
                                                <asp:Label ID="Rs_Selectoption" runat="server" meta:resourcekey="Rs_SelectoptionResource1"
                                                    Text="Select option"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlMaster" runat="server" AutoPostBack="True" meta:resourcekey="ddlMasterResource1"
                                                    OnSelectedIndexChanged="ddlMaster_SelectedIndexChanged" CssClass="ddlsmall">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table id="tbBuilding" runat="server" class="dataheader2 w-100p defaultfontcolor"
                                                    visible="False">
                                                    <tr runat="server">
                                                        <td runat="server" class="a-right w-32p">
                                                            <asp:Label ID="lblbuName" runat="server"></asp:Label>
                                                        </td>
                                                        <td runat="server" class="w-12p">
                                                            <asp:TextBox ID="txtBuilding" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                                        </td>
                                                        <td id="tdChkSlotable" class="w-17p" runat="server" style="display:none">
                                                        <asp:CheckBox ID="ChkSlotable" runat="server" onclick="setSlotableHidden(this.id)" 
                                                                Text="Allow Slot Booking" />
                                                        <asp:CheckBox ID="CheckIsAnOT" runat="server" onclick="setIsAnOTHidden(this.id)" 
                                                                Text="Is An OT" />
                                                        <asp:HiddenField runat="server" ID="hdnIsAnOT" Value="N" />
                                                        <asp:HiddenField runat="server" ID="hdnIsSlotable" Value="N" />
                                                        </td>
                                                        <td runat="server">
                                                            <asp:Button ID="btnSave" runat="server" BorderWidth="0px" CssClass="btn" OnClick="btnSave_Click"
                                                                OnClientClick="return checkDetails();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                Text="Add" Width="120px" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:Panel ID="pnlRoomType" runat="server" CssClass="modalPopup dataheaderPopup w-70p"
                                                    meta:resourcekey="pnlRoomTypeResource1" Style="display: none" >
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-center" colspan="5">
                                                                <strong>
                                                                    <asp:Label ID="Rs_RoomTypeName" runat="server" meta:resourcekey="Rs_RoomTypeNameResource1"
                                                                        Text="Room Type Name"></asp:Label>
                                                                    <asp:TextBox ID="txtRoomType" runat="server" meta:resourcekey="txtRoomTypeResource1"
                                                                        CssClass="Txtboxverysmall"></asp:TextBox>
                                                                </strong><strong>
                                                                    <asp:Label ID="Rs_RateName" runat="server" meta:resourcekey="Rs_RateNameResource1"
                                                                        Text="Rate Name"></asp:Label>
                                                                    <asp:DropDownList ID="ddlRoomFeeRate" runat="server" CssClass="ddl" meta:resourcekey="ddlRoomFeeRateResource1"
                                                                        onchange="javascript:RateChanged();" Width="25%">
                                                                    </asp:DropDownList>
                                                                </strong>
                                                                <strong>
                                                                    <asp:CheckBox ID="CheckBox1" runat="server" 
                                                                    onclick="setSlotableHidden(this.id)" Text="Allow Slot Booking" 
                                                                    meta:resourcekey="CheckBox1Resource3" />
                                                                    <asp:CheckBox ID="CheckBox2" runat="server" 
                                                                    onclick="setIsAnOTHidden(this.id)" Text="Is An OT" 
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
                                                                <asp:Label ID="Label1" runat="server"
                                                                    Text="Fee Based On" meta:resourcekey="Label1Resource3"></asp:Label>
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
                                                                <asp:DropDownList ID="ddlFeelogic" runat="server" 
                                                                    meta:resourcekey="ddlFeelogicResource3">
                                                                <asp:ListItem Text="Fully Day" Value="FULDAY" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                <asp:ListItem Text="Half Day" Value="HLFDAY" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                <asp:ListItem Text="Hour Basic" Value="HOURLY" meta:resourcekey="ListItemResource9"></asp:ListItem>
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
                                                                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn"
                                                                    OnClientClick="return checkBindRoomList();" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" 
                                                                    meta:resourcekey="btnAddResource2"/>
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
                                                                <asp:Button ID="btnpopClose" runat="server" Text="Close" CssClass="btn" 
                                                                    OnClientClick="return ClearControlValues()" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" 
                                                                    meta:resourcekey="btnpopCloseResource2" />
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
                                                        <td runat="server" class="a-right">
                                                            <asp:Label ID="Rs_SelectBuilding" runat="server" Text="Select Building" meta:resourcekey="Rs_SelectBuildingResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:DropDownList ID="ddlBuilding" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBuilding_SelectedIndexChanged"
                                                               CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td runat="server" class="a-right">
                                                            <asp:Label ID="lblName" runat="server"></asp:Label>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:TextBox ID="txtFloor" runat="server" CssClass="Txtboxsmall" AutoComplete="off"></asp:TextBox>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:Button ID="btnFloor" runat="server" BorderWidth="0px" CssClass="btn" OnClick="btnSave_Click"
                                                                OnClientClick="return checkDetails();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                Text="Add" Width="120px" />
                                                        </td>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView w-100p"
                                                    EmptyDataText="No Records Found" meta:resourcekey="gvResultResource1" OnRowDataBound="grdResult_RowDataBound"
                                                    Visible="False">
                                                    <Columns>
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
                                                        <asp:TemplateField HeaderText="Allow Slot Booking" 
                                                            meta:resourcekey="TemplateFieldResource8">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_IsSlotable" runat="server"
                                                                    Text='<%# Eval("IsSlotable") %>' 
                                                                    meta:resourcekey="lbl_IsSlotableResource3"></asp:Label>
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
                                                <input id="hdnFloor" runat="server" type="hidden"/>
                                                <input id="hdnWard" runat="server" type="hidden"/>
                                                <input id="hdnRoomName" runat="server" type="hidden"/>
                                                <input id="hdnID" runat="server" type="hidden" value="0"/>
                                                <input id="hdnpSta" runat="server" type="hidden"/>
                                                <input id="hdnNoofBeds" runat="server" type="hidden"/>
                                                <input id="hdnBedName" runat="server" type="hidden"/>
                                                <table id="tbRooms" runat="server" cellpadding="2" cellspacing="2" class="dataheader2 defaultfontcolor"
                                                    visible="False" width="100%">
                                                    <tr runat="server">
                                                        <th runat="server">
                                                            <asp:Label ID="Rs_Building1" runat="server" Text="Building" meta:resourcekey="Rs_Building1Resource1"></asp:Label>
                                                        </th>
                                                        <th runat="server">
                                                            <asp:Label ID="Rs_Floor" runat="server" Text="Floor" meta:resourcekey="Rs_FloorResource1"></asp:Label>
                                                        </th>
                                                        <th runat="server">
                                                            <asp:Label ID="Rs_Ward" runat="server" Text="Ward" meta:resourcekey="Rs_WardResource1"></asp:Label>
                                                        </th>
                                                        <th runat="server">
                                                            <asp:Label ID="Rs_RoomType1" runat="server" Text="RoomType" meta:resourcekey="Rs_RoomType1Resource1"></asp:Label>
                                                        </th>
                                                        <th runat="server">
                                                            <asp:Label ID="Rs_NoofRooms" runat="server" Text="No of Rooms" meta:resourcekey="Rs_NoofRoomsResource1"></asp:Label>
                                                        </th>
                                                        <th runat="server">
                                                        </th>
                                                    </tr>
                                                    <tr runat="server">
                                                        <td runat="server">
                                                            <asp:DropDownList ID="ddlRoomBuilding" runat="server" AutoPostBack="True" OnSelectedIndexChanged="loadFloorWard_Details"
                                                                CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:DropDownList ID="ddlRoomFloor" runat="server" AutoPostBack="True" onchange="javascript:if(!CheckRoomddlValues()) return false;"
                                                                OnSelectedIndexChanged="loadRoomMaster_Details" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:DropDownList ID="ddlRoomWard" runat="server" AutoPostBack="True" onchange="javascript:if(!CheckRoomddlValues()) return false;"
                                                                OnSelectedIndexChanged="loadRoomMaster_Details" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:DropDownList ID="ddlRoomRoomType" runat="server" AutoPostBack="True" onchange="javascript:if(!CheckRoomddlValues()) return false;"
                                                                OnSelectedIndexChanged="loadRoomMaster_Details" CssClass="ddl">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:TextBox ID="txtNoofRooms" runat="server" MaxLength="3"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                Text='<%# Bind("NoBeds") %>' CssClass="Txtboxverysmall"></asp:TextBox>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:Button ID="btnAddRooms" runat="server" CssClass="btn" OnClick="btnAddRooms_Click"
                                                                OnClientClick="return chkRoomDetails();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                Text="Add" Width="80px" />
                                                        </td>
                                                    </tr>
                                                </table>
                                </td> </tr>
                                <tr>
                                    <td colspan="2">
                                        <tr>
                                            <td id="tdDetete" runat="server" align="center" colspan="2" style="display: block;
                                                margin-left: 40px;">
                                                <asp:Button ID="btnDetete" runat="server" CssClass="btn" meta:resourcekey="btnDeteteResource1"
                                                    OnClientClick="javascript:document.getElementById('hdnControlValue').value=confirm(msgDelPrompt);"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Delete"
                                                    Visible="False" />
                                                <asp:GridView ID="GrdRoomDetails" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView w-100p"
                                                    DataKeyNames="FloorID,WardID,RoomTypeID,RoomID,BedID" meta:resourcekey="GrdRoomDetailsResource1"
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
                                                        <asp:TemplateField HeaderText="RoomName" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRoomName" runat="server" Height="12px" meta:resourcekey="txtRoomNameResource1"
                                                                    Text='<%# Bind("RoomName") %>' Width="60px"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ControlStyle Height="12px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="No of Beds" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBeds" runat="server" Height="12px" meta:resourcekey="txtBedsResource1"
                                                                     onkeypress="return ValidateOnlyNumeric(this);"  Text='<%# Bind("NoBeds") %>' Width="60px"></asp:TextBox>
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
                                                <td id="tdRoomFinish" runat="server" class="a-center" colspan="2" style="display: none;">
                                                    <asp:Button ID="btnSaveRooms" runat="server" CssClass="btn" meta:resourcekey="btnSaveRoomsResource1"
                                                        OnClick="btnSave_Click" OnClientClick="return chkbtnFinish1();" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Finish" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="v-top">
                                                    <table id="TbBed" runat="server" cellpadding="2" cellspacing="2" class="dataheader2 defaultfontcolor w-100p"
                                                        visible="False">
                                                        <tr runat="server">
                                                            <th runat="server">
                                                                <asp:Label ID="Rs_Building" runat="server" Text="Building"></asp:Label>
                                                            </th>
                                                            <th runat="server">
                                                                <asp:Label ID="Rs_RoomType" runat="server" Text="RoomType"></asp:Label>
                                                            </th>
                                                            <th runat="server">
                                                                <asp:Label ID="Rs_ListofRooms" runat="server" Text="List of Rooms"></asp:Label>
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
                                                                <asp:ListBox ID="lstBedRooms" runat="server" Height="57px" ToolTip="Double Click To Select Room"
                                                                    Width="213px"></asp:ListBox>
                                                                <br />
                                                                <font color="red" size="1" style="clip">
                                                                    <asp:Label ID="Rs_DoubleClickToSelectRoom" runat="server" Text="Double Click To Select Room"></asp:Label>
                                                                </font>
                                                            </td>
                                                            <td runat="server" class="a-center" style="display: none;">
                                                                <asp:Button ID="btnAddBed" runat="server" CssClass="btn" OnClick="GetBedDetails"
                                                                    Text="EditBed" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="tdSaveBed" runat="server" class="a-center" colspan="2" style="display: none;"
                                                    valign="top">
                                                    <asp:Label ID="Rs_AddMoreBeds" runat="server" meta:resourcekey="Rs_AddMoreBedsResource1"
                                                        Text="Add More Beds"></asp:Label>
                                                    <asp:TextBox ID="txtNoOfBeds" runat="server" meta:resourcekey="txtNoOfBedsResource1"
                                                       CssClass="Txtboxverysmall"></asp:TextBox>
                                                    <asp:Button ID="btnAddMore" runat="server" CssClass="btn" meta:resourcekey="btnAddMoreResource1"
                                                        OnClick="btnAddMore_Click" OnClientClick="btnAddMoreBed();" Text="ADD" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" colspan="2">
                                                    <asp:GridView ID="GrdBedDetails" runat="server" AutoGenerateColumns="False" DataKeyNames="BuildingID,RoomTypeID,RoomID,ID"
                                                        meta:resourcekey="GrdBedDetailsResource1" CssClass="gridView" Visible="False">
                                                        <Columns>
                                                            <asp:BoundField DataField="BuildingName" HeaderText="Building Name" meta:resourcekey="BoundFieldResource5">
                                                                <ItemStyle Height="12px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="RoomTypeName" HeaderText="RoomType" meta:resourcekey="BoundFieldResource6">
                                                                <ItemStyle Height="12px" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="RoomName" HeaderText="Room Name" meta:resourcekey="BoundFieldResource7">
                                                                <ItemStyle Height="12px" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Bed Name" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtBedName" runat="server" meta:resourcekey="txtBedNameResource1"
                                                                        Text='<%# Bind("BedName") %>'></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ControlStyle Height="12px" />
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
                                        </tr>
                                    </td>
                                </tr>
                                </table>
                                <ajc:ModalPopupExtender ID="mpeRoomType" runat="server"
                                    CancelControlID="btnpopClose" DynamicServicePath="" Enabled="True" PopupControlID="pnlRoomType"
                                    TargetControlID="btnDummy" BackgroundCssClass="modalBackground"> 
                                </ajc:ModalPopupExtender>
                                <input id="btnDummy" runat="server" style="display: none;" type="button"/>
                                <input id="hndControlID" runat="server" type="hidden"/>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />      
        <asp:HiddenField ID="hdnMessages" runat ="server" />
    </form>
</body>
</html>
