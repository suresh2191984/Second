<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddInvGroups.aspx.cs" Inherits="Admin_AddInvGroups"
    EnableEventValidation="false" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Add Investigation Groups</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function show(id) {
            //var Hdngrp = document.getElementById('HdnGrp').value;            
            // Hdngrp = id;
            window.open("MappingInvtoGrp.aspx?gid=" + id + "&IsPopup=Y" + "", "Recommendation", "height=400,width=700,left=0,top=0,scrollbars=yes");
        }
        function chkonchange() {
            var tableBody = document.getElementById('Chklst').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in investigation master');
                return false;
            }
        }
        function chkGrponchange() {
            var tableBody = document.getElementById('chklstGrp').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in group master');
                return false;
            }
        }
        function chklstonchange() {

            var table = document.getElementById('chklstInvmap').childNodes[0];
            var k = 0;
            for (var i = 0; i < table.childNodes.length; i++) {
                var currentTd = table.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    k = k + 1;
                }
            }
            if (k == 0) {
                alert('Select the items in investigation mapping');
                return false;
            }
        }
        function chklstGrponchange() {

            var table = document.getElementById('chkGrpMap').childNodes[0];
            var k = 0;
            for (var i = 0; i < table.childNodes.length; i++) {
                var currentTd = table.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    k = k + 1;
                }
            }
            if (k == 0) {
                alert('Select the items in group mapping');
                return false;
            }
        }
        function validateAddInv(sDept, sheader) {
            //            var ctlDept = document.getElementById(sDept);
            //            var ctlHeader = document.getElementById(sheader);
            //            if (ctlDept.options[ctlDept.selectedIndex].value == "0" || ctlHeader.options[ctlHeader.selectedIndex].value == "0") {
            //                alert('Please select both department and header');
            //                return false;
            //            }
            //            return true;
        }
        function validateAddGrp() {
            var ctlGrpNm = document.getElementById('txtGrpName');

            if (ctlGrpNm.value == '') {
                alert('Provide a name for the group');
                return false;
            }
            return true;
        }

        //Venkat added here  for add list of investigation on dblClick

        function onClick1(id) {
            //alert(id);
            var type;
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            var HidValue = document.getElementById('hInvName').value;
            var list = HidValue.split('^');
            if (document.getElementById('hInvName').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (obj.selectedIndex >= 0) {
                            if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {
                document.getElementById('tblInvestigation').style.display = 'block';
                var row = document.getElementById('tblInvestigation').insertRow(1);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //            var cell3 = row.insertCell(2);
                //            var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //            cell3.innerHTML = type;
                //            cell3.style.display = "none";
                //            cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
                //            cell4.width = "30%";
                document.getElementById('hInvName').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('tblInvestigation').style.display = 'block';
                var row = document.getElementById('tblInvestigation').insertRow(1);

                row.id = obj.options[obj.selectedIndex].value;
                //alert("row:" + row.id);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //            var cell3 = row.insertCell(2);
                //            var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //            cell3.innerHTML = type;
                //            cell3.style.display = "none";
                //            cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
                //            cell4.width = "30%";
                document.getElementById('hInvName').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
            }
            else if (AddStatus == 1) {
                alert('Investigation already added');
            }
        }


        function ImgOnclick(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hInvName').value;
            var list = HidValue.split('^');

            var newInvList = '';
            if (document.getElementById('hInvName').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {

                            newInvList += list[count] + '^';

                        }
                    }
                }
                document.getElementById('hInvName').value = newInvList;

            }

        }

        function LoadOrdItems() {

            var HidValue = document.getElementById('hInvName').value;
            var list = HidValue.split('^');
            if (document.getElementById('InvestigationControl1_iconHid').value != "") {
                document.getElementById('InvestigationControl1_lblHeader').style.display = "block";
                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    var row = document.getElementById('tblInvestigation').insertRow(0);
                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = InvesList[1];
                    cell3.innerHTML = InvesList[2];
                    cell3.style.display = "none";
                    cell4.innerHTML = addPhyFeeList(InvesList[0]);
                    cell4.width = "30%";
                    if (InvesList[2] == "NEW") {
                        document.getElementById(InvesList[0]).style.display = "none";
                    }
                }
            }

        }

        function setItem(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClick1(ctl.id);
            }
        }
        function deselectLists(id) {
            var obj1 = document.getElementById('InvestigationControl1_listINV');
            var obj2 = document.getElementById('InvestigationControl1_listGRP');
            var obj3 = document.getElementById('InvestigationControl1_listPKG');
            var obj4 = document.getElementById('InvestigationControl1_listLCON');
            if (id == "InvestigationControl1_listGRP") {
                if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = 0; }
                if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
                if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
                if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
            }
            else if (id == "InvestigationControl1_listPKG") {
                if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = 0; }
                if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
                if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
                if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
            }
            else if (id == "InvestigationControl1_listINV") {
                if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = 0; }
                if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
                if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
                if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = -1; }
            }
            else if (id == "InvestigationControl1_listLCON") {
                if (obj4) { document.getElementById('InvestigationControl1_listLCON').selectedIndex = 0; }
                if (obj2) { document.getElementById('InvestigationControl1_listGRP').selectedIndex = -1; }
                if (obj3) { document.getElementById('InvestigationControl1_listPKG').selectedIndex = -1; }
                if (obj1) { document.getElementById('InvestigationControl1_listINV').selectedIndex = -1; }
            }
        }

        //-------------------------------------------

        function onGrpClick(id) {
            // alert(id);
            var type;
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            var HidValue = document.getElementById('hgroupName').value;
            var list = HidValue.split('^');
            if (document.getElementById('hgroupName').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (obj.selectedIndex >= 0) {
                            if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {
                document.getElementById('tblGroup').style.display = 'block';
                var row = document.getElementById('tblGroup').insertRow(1);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //            var cell3 = row.insertCell(2);
                //            var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImggrpOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //            cell3.innerHTML = type;
                //            cell3.style.display = "none";
                //            cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
                //            cell4.width = "30%";
                document.getElementById('hgroupName').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('tblGroup').style.display = 'block';
                var row = document.getElementById('tblGroup').insertRow(1);
                row.id = obj.options[obj.selectedIndex].value;
                //alert("row:" + row.id);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                //            var cell3 = row.insertCell(2);
                //            var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImggrpOnclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                //            cell3.innerHTML = type;
                //            cell3.style.display = "none";
                //            cell4.innerHTML = addPhyFeeList(obj.options[obj.selectedIndex].value);
                //            cell4.width = "30%";
                document.getElementById('hgroupName').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
            }
            else if (AddStatus == 1) {
                alert('Investigation already added');
            }
        }
        function ImggrpOnclick(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hgroupName').value;
            var list = HidValue.split('^');
            var newInvList = '';
            if (document.getElementById('hgroupName').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {
                            newInvList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hgroupName').value = newInvList;
            }
        }
        function ddlValidation() {
            if (document.getElementById('ddlInves').value == "0") {
                alert('Select type');
                document.getElementById('ddlInves').focus();
                return false;
            }
        }


        // -------------------------------Delete Inv------


        function onClickInvDel(id) {
            var type;
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            var HidValue = document.getElementById('hInvDel').value;
            var list = HidValue.split('^');
            if (document.getElementById('hInvDel').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (obj.selectedIndex >= 0) {
                            if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {
                document.getElementById('tblInvDel').style.display = 'block';
                var row = document.getElementById('tblInvDel').insertRow(1);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnDelclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                document.getElementById('hInvDel').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('tblInvDel').style.display = 'block';
                var row = document.getElementById('tblInvDel').insertRow(1);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnDelclick(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                document.getElementById('hInvDel').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
            }
            else if (AddStatus == 1) {
                alert('Investigation already added');
            }
        }


        function ImgOnDelclick(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hInvDel').value;
            var list = HidValue.split('^');
            var newInvList = '';
            if (document.getElementById('hInvDel').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {
                            newInvList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hInvDel').value = newInvList;
            }
        }

        var atLeast = 1;
        function ValidateInv() {
            var LstItems = document.getElementById("<%=lstEditGp.ClientID%>").value;
            if (LstItems == '') {
                alert('Select list of investigation');
                document.getElementById("<%=lstEditGp.ClientID%>").focus();
                return false;
            }

            var CHK = document.getElementById("<%=chkLstInv.ClientID%>");
            var checkbox = CHK.getElementsByTagName("input");
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }
            if (atLeast > counter) {
                alert('Select atleast one investigation item');
                return false;
            }
            var btntxt = document.getElementById('btnDeleteGp').value;
            if (btntxt == "Update") {
                return true;
            }
var txtCancel = confirm('Are you sure you wish to delete the record');
            if (txtCancel == false) {
                return false;
            }
            return true;
        }

        function ValidateDelete() {
            var HidValue = document.getElementById('hInvDel').value;
            if (HidValue == '') {
                alert('Select investigation items');
                return false;
            }
confirm('Are you sure you wish to delete the record');
            return true;
        }

        function bindlist(id) {

            var ddlobj = document.getElementById(id);
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdn = document.getElementById('HdnDept').value;
                var hdnload = document.getElementById('HdnLoaddata').value;
                var list = hdn.split('^');
                var count = 0;
                var hdndept = document.getElementById('HdnCntDept').value;
                if (hdn != "") {
                    var hdndept = hdndept + hdn + "$";
                    document.getElementById('HdnCntDept').value = hdndept;
                    for (var i = 0; i < list.length - 1; i++) {
                        var value = list[i].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                }
                var ddl = document.getElementById('ddlInves').options[document.getElementById('ddlInves').selectedIndex].text;
                if (ddl == "Mapping Investigation to Detail and Header Name") {
                    var hdn = document.getElementById('HdnLoad').value;
                    var hdnvalid = document.getElementById('HdnDeptvalid').value;
                    if (hdn != "") {
                        var list = hdn.split('^');
                        var listvalid = hdnvalid.split('^');
                        for (var j = 0; j <= list.length - 1; j++) {
                            var value = list[j].split('~');
                            for (var i = 0; i < listvalid.length - 1; i++) {
                                var valuevalid = listvalid[i].split('~');
                                if (id == valuevalid[0]) {
                                    var check = document.getElementById(valuevalid[2]).value
                                    if (value[0] == check) {
                                        document.getElementById(valuevalid[0]).value = value[1];

                                    }
                                }
                            }
                        }

                    }


                }
            }

        }
        function bind(id) {
            var ddlobj = document.getElementById(id);
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdn = document.getElementById('Hdnheader').value;
                var hdnhead = document.getElementById('HdnCntHeader').value;
                if (hdn != "") {
                    var hdnhead = hdnhead + hdn + "$";
                    document.getElementById('HdnCntHeader').value = hdnhead;
                    var list = hdn.split('^');
                    for (var i = 0; i < list.length - 1; i++) {
                        var value = list[i].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                    var ddl = document.getElementById('ddlInves').options[document.getElementById('ddlInves').selectedIndex].text;
                    if (ddl == "Mapping Investigation to Detail and Header Name") {
                        var hdn = document.getElementById('HdnLoad').value;
                        var hdnvalid = document.getElementById('HdnDeptvalid').value;
                        if (hdn != "") {
                            var list = hdn.split('^');
                            var listvalid = hdnvalid.split('^');
                            for (var j = 0; j <= list.length - 1; j++) {
                                var value = list[j].split('~');
                                for (var i = 0; i < listvalid.length - 1; i++) {
                                    var valuevalid = listvalid[i].split('~');
                                    if (id == valuevalid[1]) {
                                        var check = document.getElementById(valuevalid[2]).value
                                        if (value[0] == check) {
                                            document.getElementById(valuevalid[1]).value = value[2];

                                        }
                                    }
                                }
                            }

                        }

                    }

                }
            }

        }
        function checkdept(id) {

            var ddlTxt = document.getElementById(id).options[document.getElementById(id).selectedIndex].text;
            if (ddlTxt == "Select") {
                alert('Select');
            }
        }
        function loaddata() {

            var ddlobj = document.getElementById(id);
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdn = document.getElementById('Hdnheader').value;
                var hdnhead = document.getElementById('HdnCntHeader').value;
                if (hdn != "") {
                    var hdnhead = hdnhead + hdn + "$";
                    document.getElementById('HdnCntHeader').value = hdnhead;
                    var list = hdn.split('^');
                    for (var i = 0; i < list.length - 1; i++) {
                        var value = list[i].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                    var ddl = document.getElementById('ddlInves').options[document.getElementById('ddlInves').selectedIndex].text;
                    if (ddl == "Mapping Investigation to Detail and Header Name") {
                        var hdn = document.getElementById('HdnLoad').value;
                        var hdnvalid = document.getElementById('HdnDeptvalid').value;
                        if (hdn != "") {
                            var list = hdn.split('^');
                            var listvalid = hdnvalid.split('^');
                            for (var j = 0; j <= list.length - 1; j++) {
                                var value = list[j].split('~');
                                for (var i = 0; i < listvalid.length - 1; i++) {
                                    var valuevalid = listvalid[i].split('~');
                                    if (id == valuevalid[1]) {
                                        var check = document.getElementById(valuevalid[2]).value
                                        if (value[0] == check) {
                                            document.getElementById(valuevalid[1]).value = value[2];

                                        }
                                    }
                                }
                            }

                        }

                    }

                }
            }
            var ddlobj = document.getElementById(id);
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdn = document.getElementById('Hdnheader').value;
                var hdnhead = document.getElementById('HdnCntHeader').value;
                if (hdn != "") {
                    var hdnhead = hdnhead + hdn + "$";
                    document.getElementById('HdnCntHeader').value = hdnhead;
                    var list = hdn.split('^');
                    for (var i = 0; i < list.length - 1; i++) {
                        var value = list[i].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                    var ddl = document.getElementById('ddlInves').options[document.getElementById('ddlInves').selectedIndex].text;
                    if (ddl == "Mapping Investigation to Detail and Header Name") {
                        var hdn = document.getElementById('HdnLoad').value;
                        var hdnvalid = document.getElementById('HdnDeptvalid').value;
                        if (hdn != "") {
                            var list = hdn.split('^');
                            var listvalid = hdnvalid.split('^');
                            for (var j = 0; j <= list.length - 1; j++) {
                                var value = list[j].split('~');
                                for (var i = 0; i < listvalid.length - 1; i++) {
                                    var valuevalid = listvalid[i].split('~');
                                    if (id == valuevalid[1]) {
                                        var check = document.getElementById(valuevalid[2]).value
                                        if (value[0] == check) {
                                            document.getElementById(valuevalid[1]).value = value[2];
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        //                                function pageLoad() {
        //                                    $addHandler($get("showModalPopupClientButton"), 'click', showModalPopupViaClient);
        //                                    $addHandler($get("hideModalPopupViaClientButton"), 'click', hideModalPopupViaClient);
        //                                }

        //                                function showModalPopupViaClient(ev) {
        //                                    ev.preventDefault();
        //                                    var modalPopupBehavior = $find('programmaticModalPopupBehavior');
        //                                    modalPopupBehavior.show();
        //                                }

        //                                function hideModalPopupViaClient(ev) {
        //                                    ev.preventDefault();
        //                                    var modalPopupBehavior = $find('programmaticModalPopupBehavior');
        //                                    modalPopupBehavior.hide();
        //                                }

        function validateinves() {

            var ddl = document.getElementById('ddlInves').options[document.getElementById('ddlInves').selectedIndex].text;
            //var ddl = document.getElementById('ddlInves').value;
            //alert(ddl);
            if (ddl == "Mapping Investigation to Detail and Header Name") {
                //alert("HI");
                var hdn = document.getElementById('HdnDeptvalid').value;

                var basegrid = document.getElementById('grdResult');
                if (basegrid != null) {
                    var grid = document.getElementById('grdResult').rows.length;
                    var btn = document.getElementById('btnSave').value;
                    var hdnupdate = document.getElementById('HdnUpdateDept').value;
                    var hdnheader = document.getElementById('HdnHeadvalid').value;
                    var hdndept = document.getElementById('HdnCntDept').value;

                    var hdnhead = document.getElementById('HdnCntHeader').value;
                    if (hdndept != "") {
                        var checkdept = hdndept.split('$');
                        var countdept = checkdept.length - 1;
                    }
                    if (hdnhead != "") {
                        var checkhead = hdnhead.split('$');
                        var counthead = checkhead.length - 1;
                    }
                    if (hdn != "") {
                        var list = hdn.split('^');
                        for (var j = 0; j < list.length - 1; j++) {
                            var cnt = list.length - 1;
                            //alert(cnt);
                            // alert(countdept);
                            if (btn == "Save & Continue") {
                                if (countdept < cnt) {
                alert('Select atleast one department name');
                                    return false;
                                }
                                if (counthead < cnt) {
                alert('Select atleast one header name');
                                    return false;
                                }
                            }
                            var value = list[j].split('~');
                            if (j < grid - 1) {
                                if ((document.getElementById(value[0]).selectedIndex >= 0) && (document.getElementById(value[1]).selectedIndex >= 0)) {
                                    //var ddlde = document.getElementById(value[0]).options[document.getElementById(value[0]).selectedIndex];
                                    var ddldept = document.getElementById(value[0]).options[document.getElementById(value[0]).selectedIndex].text;
                                    //var ddldeptdup=document.getElementById(value[0]);
                                    var ddldeptvalue = document.getElementById(value[0]).options[document.getElementById(value[0]).selectedIndex].value;
                                    var ddlhead = document.getElementById(value[1]).options[document.getElementById(value[1]).selectedIndex].text;
                                    //var ddlheaddup = document.getElementById(value[1]);
                                    var ddlheadvalue = document.getElementById(value[1]).options[document.getElementById(value[1]).selectedIndex].value;
                                    var lblinv = document.getElementById(value[2]).value;
                                    if (ddldept == "Select") {
                alert('Select the department name');
                                        return false;
                                    }
                                    if (ddlhead == "Select") {
                alert('Select the header name');
                                        return false;
                                    }
                                    if ((ddldept != "Select") && (ddlhead != "Select") && (btn == "Update")) {
                                        hdnupdate += lblinv + "~" + ddldeptvalue + "~" + ddlheadvalue + "^";
                                        document.getElementById('HdnUpdateDept').value = hdnupdate;
                                    }
                                    if ((ddldept != "Select") && (ddlhead != "Select") && (btn == "Save & Continue")) {
                                        // alert("hhhh");
                                        hdnheader += lblinv + "~" + ddldeptvalue + "~" + ddlheadvalue + "^";
                                        document.getElementById('HdnHeadvalid').value = hdnheader;
                                    }
                                }

                            }

                        }
                    }
                }
                else {
                alert('There are no records to save');
                }

            }
        }
        
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel ID="Panel3" CssClass="dataheader2" BorderWidth="1px" runat="server">
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap">
                                        Select an option
                                    </td>
                                    <td nowrap="nowrap" valign="middle" style="font-weight: normal; font-size: 12px;
                                        height: 20px; color: #000; width: 20%;">
                                        <asp:DropDownList ID="ddlInves" runat="server" Height="20px" Width="273px">
                                            <asp:ListItem Value="0">----Select----</asp:ListItem>
                                            <asp:ListItem>Add Investigation</asp:ListItem>
                                            <asp:ListItem>Add Investigation Group</asp:ListItem>
                                            <%-- <asp:ListItem>Delete Investigation</asp:ListItem>
                                           <asp:ListItem>Edit\Delete Investigation Group</asp:ListItem>--%>
                                            <asp:ListItem>Mapping Investigation to Detail and Header Name</asp:ListItem>
                                            <%-- <asp:ListItem>Creating New Groups</asp:ListItem>--%>
                                        </asp:DropDownList>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td style="width: 8%">
                                        <asp:Button ID="btnGo" Text="Go" runat="server" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClientClick="javascript:return ddlValidation();"
                                            OnClick="btnGo_Click" />
                                    </td>
                                    <td style="font-weight: normal; font-size: 11px; height: 1px; color: #000; width: 20%;">
                                        <input type="hidden" id="hInvName" runat="server" />
                                        <input type="hidden" id="hgroupName" runat="server" />
                                        <input type="hidden" id="hInvDel" runat="server" />
                                    </td>
                                    <td style="width: 10%">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlGRP" CssClass="dataheader2" BorderWidth="1px" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div id="divInvGp" runat="server">
                                        <ajc:ModalPopupExtender ID="MPE" runat="server" TargetControlID="lnk" X="225" Y="50"
                                            PopupControlID="pnl" BackgroundCssClass="modalBackground" DropShadow="true" PopupDragHandleControlID="pnl" />
                                        <table width="100%">
                                            <tr>
                                                <td valign="top">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton ID="lnk" runat="server" Text="CLICK HERE " ForeColor="#3399FF" OnClick="lnk_Click"></asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                &nbsp;TO CREATE NEW GROUPS
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Find Group
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtgrp" runat="server"></asp:TextBox>
                                                                <asp:Button ID="btngrp" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" OnClick="btngrp_Click" />
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td align="right">
                                                                Find Group for Mapping
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtgrpmap" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btngrpmap" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" OnClick="btngrpmap_Click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table border="0">
                                            <tr>
                                                <td class="ancCSbg">
                                                    Master Group
                                                </td>
                                                <td>
                                                </td>
                                                <td class="ancCSbg">
                                                    Group Mapped to Lab
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 51px;">
                                                    <div style="overflow: scroll; border: 2px; border-color: #fff; height: 180px;" class="ancCSviolet">
                                                        <asp:CheckBoxList ID="chklstGrp" runat="server" Height="51px" Width="320px">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                                <asp:Button ID="btnGrpAdd" runat="server" class="btn" Height="40px" Text="&gt;&gt;"
                                                                    Width="40px" OnClientClick="javascript:chkGrponchange();" OnClick="btnGrpAdd_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" style="height: 15px">
                                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                                    <ProgressTemplate>
                                                                        <asp:Image ID="Image1" ImageUrl="~/Images/ajax-loader.gif" runat="server" Height="33px"
                                                                            Width="50px" /><%=Resources.ReportsLims_AppMsg.ReportsLims_BillWiseDeptCollectionReportLims_aspx_05%>
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnGrpRemove" runat="server" class="btn" Height="40px" Text="&lt;&lt;"
                                                                    Width="40px" OnClientClick="javascript:chklstGrponchange();" OnClick="btnGrpRemove_Click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top">
                                                    <div style="overflow: scroll; height: 180px;">
                                                        <asp:CheckBoxList ID="chkGrpMap" runat="server" Height="51px" Width="320px">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        <asp:Panel ID="pnlINV" CssClass="dataheader2" BorderWidth="1px" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div id="divInv" runat="server">
                                        <table width="100%">
                                            <tr>
                                                <td valign="top">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlDept" runat="server" Visible="False">
                                                                </asp:DropDownList>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlHeader" runat="server" Visible="False">
                                                                </asp:DropDownList>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                UnMapped Investigation
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtInvestigationName" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnSearch" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" OnClick="btnSearch_Click" />
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                                Mapped Investigation
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtInvname" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnfind" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" OnClick="btnfind_Click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table border="0">
                                            <tr>
                                                <td class="ancCSbg">
                                                    Master Investigation
                                                </td>
                                                <td>
                                                </td>
                                                <td class="ancCSbg">
                                                    Investigation Mapped to Lab
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 51px;">
                                                    <div style="overflow: auto; border: 2px; border-color: #fff; height: 180px;">
                                                        <asp:CheckBoxList ID="Chklst" runat="server" Height="51px" Width="320px">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:HiddenField ID="hdnInv" runat="server" />
                                                                <asp:Button ID="btnAdd" runat="server" class="btn" Height="40px" Text="&gt;&gt;"
                                                                    Width="50px" OnClientClick="javascript:return chkonchange();" OnClick="btnAdd_Click1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" style="height: 15px">
                                                                <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                                                    <ProgressTemplate>
                                                                        <asp:Image ID="Img" ImageUrl="~/Images/ajax-loader.gif" runat="server" Height="33px"
                                                                            Width="50px" /><%=Resources.ReportsLims_AppMsg.ReportsLims_BillWiseDeptCollectionReportLims_aspx_05%>
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnRemove" runat="server" class="btn" Height="40px" Text="&lt;&lt;"
                                                                    Width="50px" OnClientClick="javascript:return chklstonchange();" OnClick="btnRemove_Click1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top">
                                                    <div style="overflow: auto; height: 180px;">
                                                        <asp:CheckBoxList ID="chklstInvmap" runat="server" Height="51px" Width="304px">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        <asp:Panel ID="pnlHeader" CssClass="dataheader2" BorderWidth="1px" runat="server"
                            Height="500px">
                            <div id="div1" runat="server">
                                <table>
                                    <tr align="center" style="width: 12px">
                                        <asp:Panel ID="pnl_search" runat="server">
                                            <td align="centre" style="font-weight: normal; height: 20px; color: #000; width: 50%;">
                                                <asp:Label ID="lblSearch" runat="server" Text="Enter Investigation to Search"></asp:Label>
                                                <asp:TextBox ID="txtinvestigation" runat="server" ToolTip="Investigation Name"></asp:TextBox>
                                                <asp:Button ID="btninves" runat="server" class="btn" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Style="cursor: pointer;" Text="Search"
                                                    OnClick="btninves_Click" ToolTip="Click here to Search the Investigation" />
                                            </td>
                                        </asp:Panel>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" Height="12%"
                                                OnPageIndexChanging="grdResult_PageIndexChanging" OnRowCancelingEdit="grdResult_RowCancelingEdit"
                                                OnRowDataBound="grdResult_RowDataBound" OnRowEditing="grdResult_RowEditing" PageSize="15"
                                                Style="margin-left: 0px" Width="101%" AllowPaging="True">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.NO" Visible="false"></asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Investigation Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInvestigation" runat="server" Text='<%#bind("Investigationname")%>'></asp:Label>
                                                            <asp:HiddenField ID="lblInvestigationId" runat="server" Value='<%# bind("Investigationid") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Department Name">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlDept" runat="server" Height="22px" onfocus="javascript:return bindlist(this.id)"
                                                                Width="100px">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Header Name">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlHeader" runat="server" Height="22px" onfocus="javascript:return bind(this.id)"
                                                                Width="99px">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="14" />
                                                <HeaderStyle CssClass="dataheader1" Width="14" />
                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                    PageButtonCount="5" PreviousPageText="" />
                                            </asp:GridView>
                                            <asp:HiddenField ID="HdnCntHeader" runat="server" />
                                            <asp:HiddenField ID="HdnDeptvalid" runat="server" />
                                            <asp:HiddenField ID="HdnHeadvalid" runat="server" />
                                            <asp:HiddenField ID="HdnLoaddata" runat="server" />
                                            <asp:HiddenField ID="HdnLoad" runat="server" />
                                            <asp:HiddenField ID="HdnDept" runat="server" />
                                            <asp:HiddenField ID="Hdnheader" runat="server" />
                                            <asp:HiddenField ID="HdnCntDept" runat="server" />
                                            <asp:HiddenField ID="HdnUpdateDept" runat="server" />
                                            <asp:HiddenField ID="HdnGrp" runat="server" />
                                            <asp:HiddenField ID="HdnNewGrp" runat="server" />
                                            <asp:HiddenField ID="HdnRemoveGrp" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <asp:UpdatePanel ID="uppanel" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnl" runat="server" CssClass="modalPopup">
                                    <table width="100%">
                                        <tr align="center">
                                            <td>
                                                <asp:Label ID="lblGrpName" runat="server" Text="Enter the Group Name">
                                                </asp:Label>
                                                <asp:TextBox ID="txtGrpName" runat="server"> </asp:TextBox>
                                                <asp:Button ID="btnGrpCheck" runat="server" CssClass="btn" Text="Check" OnClientClick="javascript:return validateAddGrp()"
                                                    OnClick="btnGrpCheck_Click" />
                                            </td>
                                        </tr>
                                        <tr align="center">
                                            <td>
                                                <asp:Button ID="btnGrpSave" runat="server" CssClass="btn" Text="Save" OnClientClick="javascript:return validateAddGrp()"
                                                    OnClick="btnGrpSave_Click" />
                                                <asp:Button ID="btnGrpCancel" runat="server" CssClass="btn" Text="Cancel" OnClick="btnGrpCancel_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblstatus" runat="server" ForeColor="Red">
                                                </asp:Label>
                                                <asp:GridView ID="gvGrp" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                    ForeColor="#333333" AllowPaging="True" OnPageIndexChanging="gvGrp_PageIndexChanging"
                                                    OnRowCancelingEdit="gvGrp_RowCancelingEdit" OnRowDataBound="gvGrp_RowDataBound"
                                                    OnRowEditing="gvGrp_RowEditing">
                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.NO"></asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Group Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGrpname" runat="server" Text='<%#bind("GroupName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtGrpname" runat="server" Text='<%#bind("GroupName") %>'>
                                                                </asp:TextBox>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="14" />
                                                    <HeaderStyle CssClass="dataheader1" Width="14" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:Panel ID="pnlinvmap" CssClass="dataheader2" BorderWidth="1px" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <div id="div2" runat="server">
                                        <table border="0">
                                            <tr>
                                                <td class="ancCSbg">
                                                    Un Mapped Investigation
                                                </td>
                                                <td>
                                                </td>
                                                <td class="ancCSbg">
                                                    Mapped Investigation
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 51px; width: 10%;">
                                                    <div style="overflow: auto; border: 2px; border-color: #fff; height: 180px;">
                                                        <asp:CheckBoxList ID="chklstinvmaster" runat="server" Height="51px" Width="330px">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:HiddenField ID="HidGrp" runat="server" />
                                                                <asp:Button ID="btnInvGrpadd" runat="server" class="btn" Height="40px" Text="&gt;&gt;"
                                                                    Width="50px" OnClick="btnInvGrpadd_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" style="height: 15px">
                                                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                                    <ProgressTemplate>
                                                                        <asp:Image ID="Img1" ImageUrl="~/Images/ajax-loader.gif" runat="server" Height="33px"
                                                                            Width="50px" /><%=Resources.ReportsLims_AppMsg.ReportsLims_BillWiseDeptCollectionReportLims_aspx_05%>
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnInvGrpRemove" runat="server" class="btn" Height="40px" Text="&lt;&lt;"
                                                                    Width="50px" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top">
                                                    <div style="overflow: auto; height: 180px;">
                                                        <asp:CheckBoxList ID="chklstinvgrp" runat="server" Height="51px" Width="280px">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        <asp:Panel ID="PnlINVdel" CssClass="dataheader2" BorderWidth="1px" runat="server">
                            <div id="divInvDel" runat="server">
                                <table width="100%">
                                    <tr>
                                        <td valign="top">
                                            <table>
                                                <tr>
                                                    <td>
                                                        Find Investigation
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFndInvDel" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSearchInvDel" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" OnClick="btnSearch_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td valign="top">
                                            <asp:ListBox ID="lstInvDel" Font-Size="11px" runat="server" Rows="3" Height="237px"
                                                Width="336px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClickInvDel(this.id);"
                                                SelectionMode="Single"></asp:ListBox>
                                        </td>
                                        <td valign="top">
                                            <table id="tblInvDel" class="dataheaderInvCtrl" runat="server" cellpadding="4" cellspacing="0"
                                                width="100%" style="display: none;">
                                                <tr class="colorforcontent">
                                                    <td style="font-weight: bold; font-size: 10px; height: 8px; color: White; width: 5%;">
                                                        Delete
                                                    </td>
                                                    <td style="font-weight: bold; font-size: 10px; height: 8px; color: White; width: 20%;">
                                                        InvestigationName
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="PnlEditGp" CssClass="dataheader2" BorderWidth="1px" runat="server">
                            <div id="divEditGp" runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            Find GroupName
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEditGp" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnEditGp" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" OnClick="btnSearch_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="rdoBtnShow" runat="server" Checked="true" Text="Show Investigation"
                                                GroupName="GpSh" AutoPostBack="True" OnCheckedChanged="rdoBtnShow_CheckedChanged" />
                                        </td>
                                        <td>
                                            <asp:RadioButton ID="rdoBtnAddInv" runat="server" AutoPostBack="True" Text="Add New Investigation"
                                                GroupName="GpSh" OnCheckedChanged="rdoBtnShow_CheckedChanged" />
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td valign="top">
                                            <asp:ListBox ID="lstEditGp" Font-Size="11px" runat="server" Rows="3" Height="237px"
                                                Width="298px" SelectionMode="Single" OnSelectedIndexChanged="lstEditGp_SelectedIndexChanged"
                                                AutoPostBack="True"></asp:ListBox>
                                        </td>
                                        <td valign="top">
                                            <div style="height: 237px; width: 350px; overflow: auto;">
                                                <asp:CheckBoxList ID="chkLstInv" runat="server" Font-Size="11px">
                                                </asp:CheckBoxList>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <br />
                        <asp:Panel ID="pnlSave" CssClass="dataheader2" Visible="false" BorderWidth="1px"
                            runat="server">
                            <table width="100%">
                                <tr align="center">
                                    <td>
                                        <asp:Button ID="btnSave" runat="server" Text="Save & Continue" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClientClick="javascript:return validateinves() "
                                            OnClick="btnSave_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClick="btnCancel_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="PnlDelBtn" CssClass="dataheader2" Visible="false" BorderWidth="1px"
                            runat="server">
                            <table width="100%">
                                <tr align="center">
                                    <td>
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClick="btnDelete_Click" OnClientClick="return ValidateDelete();" />
                                        &nbsp;
                                        <asp:Button ID="btnDelCancel" runat="server" Text="Cancel" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClick="btnDelCancel_Click1" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="PnlUpGp" CssClass="dataheader2" Visible="false" BorderWidth="1px"
                            runat="server">
                            <table width="100%">
                                <tr align="center">
                                    <td>
                                        <asp:Button ID="btnDeleteGp" runat="server" Text="Delete" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClientClick="return ValidateInv();"
                                            OnClick="btnDeleteGp_Click" />
                                        &nbsp;
                                        <asp:Button ID="btnUpCancel" runat="server" Text="Cancel" class="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" OnClick="btnUpCancel_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
