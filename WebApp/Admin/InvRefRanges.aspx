<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="InvRefRanges.aspx.cs"
    Inherits="Admin_InvRefRanges" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Reference Range</title>

    <script type="text/javascript" src="../Scripts/jquery-1.4.1.js"></script>

    <script language="javascript" type="text/javascript">

        function FCKeditor_OnComplete(editorInstance) {
            editorInstance.Events.AttachEvent('OnFocus', FCKeditor_OnFocus);
            editorInstance.Events.AttachEvent('OnBlur', FCKeditor_OnBlur);
        }
        function FCKeditor_OnFocus(editorInstance) {
            // var oFCKeditor = FCKeditor(editorInstance.Name)
            // oFCKeditor.Width = 150;
            // oFCKeditor.Height = 70;
        }
        function FCKeditor_OnBlur(editorInstance) {
            var rtn = updatedFckEdit(editorInstance.Name);
        }
        function updatedFckEdit(id) {
            var invID = id.substring(12);
            var alreadyExists = 0;
            var list = document.getElementById("hdnUpdatedTest").value.split("~");
            for (var count = 0; count < list.length - 1; count++) {
                if (list[count] == invID) {
                    alreadyExists = 1;
                }
            }
            if (alreadyExists == 0) {
                document.getElementById("hdnUpdatedTest").value += invID + "~";
            }
            var x = document.getElementById("row" + invID);
            if (x != null) {
                x.className = "divrowcolor";
            }
            return true;
        }

        $(document).ready(function() {
        var objSuccInsert = SListForAppMsg.Get("Admin_InvRefRanges_aspx_01") == null ? "Successfully inserted !" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_01");
        var objAlert = SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");

            $('#hlnkSaveClosePc').click(function() {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/InvSaveDefProcCentre",
                    data: '{ColCentreList:"' + $('#hdnCCFinalList').val() + '",ProcCentreList:"' + $('#hdnPCFinalList').val() + '",InvestigationID:"' + $('#hdnInvestigationID').val() + '",strAllInvestigations:"' + $('#hdnPCchkAllFinalList').val() + '"}',
                    contentType: "application/json; charset=utf-8",
                    success: OnSuccess,
                    failure: function(response) {
                        alert(response.d);
                    }
                });
                function OnSuccess(response) {
                    if (response.d) {
                        //  alert("Successfully inserted !");
                        ValidationWindow(objSuccInsert, objAlert);
                    }
                }
            });
        });

        function SingleCheckAlert(chkID) {
            var objVar02 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_03") == null ? "Select One Location only" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_03");
            var objAlert = SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");

            var varPCchklist = new Array();
            varPCchklist = document.getElementById('hdnPCchkAllControls').value.split('~');
            if (varPCchklist.length > 0) {
                for (i = 0; i < varPCchklist.length; i++) {
                    if ((varPCchklist[i] != chkID) && document.getElementById(varPCchklist[i]).checked == true) {
                        // alert("Select One Location only");
                        ValidationWindow(objVar02, objAlert);
                        document.getElementById(chkID).checked = false;
                        return;
                    }
                }
            }
        }
        function RRAlert(id) {
            var objVar01 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_02") == null ? "If You Edit Directly in TextBox The Intelligence will not work" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_02");
            var objid = id;
            //            var i_p = confirm('If You Edit Directly in TextBox The Intelligence will not work');
            var i_p = confirm(objVar01);
            if (i_p == true) {
                document.getElementById(objid.id).readonly = false;
            }
            else {
                document.getElementById(objid.id).innerHTML = objid.value;
            }

        }

        function SetFinalChkValues(sender) {
            SingleCheckAlert(sender);
            document.getElementById('hdnPCchkAllFinalList').value = "";
            var varPCchklist = document.getElementById('hdnPCchkAllControls').value.split('~');
            if (varPCchklist != null && varPCchklist.length > 0) {
                for (i = 0; i < varPCchklist.length; i++) {
                    if (document.getElementById('hdnPCchkAllFinalList').value == "") {
                        if (document.getElementById(varPCchklist[i]).checked == true) {
                            document.getElementById('hdnPCchkAllFinalList').value = "1";
                        }
                        else {
                            document.getElementById('hdnPCchkAllFinalList').value = "0";
                        }
                    }
                    else {
                        if (document.getElementById(varPCchklist[i]).checked == true) {
                            document.getElementById('hdnPCchkAllFinalList').value += "~" + "1";
                        }
                        else {
                            document.getElementById('hdnPCchkAllFinalList').value += "~" + "0";
                        }
                    }
                }
            }
        }

        function SetChangedPCValue(ddlPC, hdnPC) {
            document.getElementById('hdnPCFinalList').value = "";
            document.getElementById(hdnPC).value = document.getElementById(ddlPC).options[document.getElementById(ddlPC).selectedIndex].value;

            var PCControlList = document.getElementById('hdnPCControls').value.split('~');
            if (PCControlList != null && PCControlList.length > 0) {
                for (i = 0; i < PCControlList.length; i++) {
                    if (document.getElementById('hdnPCFinalList').value == "") {
                        document.getElementById('hdnPCFinalList').value = document.getElementById(PCControlList[i]).value;
                    }
                    else {
                        document.getElementById('hdnPCFinalList').value += document.getElementById(PCControlList[i]).value;
                    }
                }
            }
        }

        function SaveClosePc() {
            document.getElementById('chkAllInvProcLocMapping').checked = false;
            document.getElementById("divPCpopup").style.display = "none";
        }

        function ClosePCPopUp() {
            document.getElementById("divPCpopup").style.display = "none";
            document.getElementById("chkAllInvProcLocMapping").checked = false;
        }

        function ClearSetMappedLocations() {
            var varCtrls = new Array();
            varCtrls = document.getElementById('hdnPCddlControls').value.split('~');
            if (varCtrls != null && varCtrls.length > 0) {
                for (var i = 0; i < varCtrls.length; i++) {
                    document.getElementById("lblMappedLoc" + varCtrls[i].substring(3)).innerHTML = "";
                }
            }
        }

        function SetMappedLocations(InvestigationID) {
            ClearSetMappedLocations();
            if (InvestigationID != "-1") {
                var varCtrls = new Array();
                varCtrls = document.getElementById('hdnPCddlControls').value.split('~');
                var varInvMapLoc = new Array();
                varInvMapLoc = document.getElementById("hdnInvMappedLocations" + InvestigationID).value.split('^');
                if (varCtrls != null && varCtrls.length > 0) {
                    for (var i = 0; i < varCtrls.length; i++) {
                        if (varInvMapLoc.length > 0) {
                            for (var j = 0; j < varInvMapLoc.length; j++) {
                                if (varInvMapLoc[j] != '') {
                                    var arrTemp = new Array();
                                    arrTemp = varInvMapLoc[j].split('~');
                                    if (arrTemp != null && arrTemp.length > 0) {
                                        if (varCtrls[i].substring(3) == arrTemp[0]) {
                                            var ddlTemp = document.getElementById('DDL' + varCtrls[i].substring(3));
                                            document.getElementById("lblMappedLoc" + varCtrls[i].substring(3)).value = "";
                                            for (var m = 0; m < ddlTemp.length; m++) {
                                                var xTemp = ddlTemp.options[m].value.substring(0, ddlTemp.options[m].value.indexOf('~'));
                                                if (xTemp == arrTemp[1]) {
                                                    //ddlTemp.options[m].selected = true;
                                                    //document.getElementById('DDL' + varCtrls[i].substring(6)).options[m].selected = true;
                                                    // document.getElementById('DDL' + varCtrls[i].substring(3)).selectedIndex  = m;
                                                    document.getElementById('DDL' + varCtrls[i].substring(3)).selectedIndex = m;
                                                    document.getElementById("lblMappedLoc" + varCtrls[i].substring(3)).innerHTML = ddlTemp.options[m].text;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        function ShowPCPopUp(id, Name, ctrlID, InvestigationID) {
            updatedInvs(id);
            if (InvestigationID != "-1") {
                document.getElementById('cellAllInv').innerHTML = "";
            }
            else {
                document.getElementById('cellMappedCentres').innerHTML = "";
            }

            //
            var varPcDdls = document.getElementById('hdnPCddlControls').value.split('~');
            if (varPcDdls != null && varPcDdls.length > 0) {
                for (i = 0; i < varPcDdls.length; i++) {
                    document.getElementById(varPcDdls[i]).selectedIndex = 0;
                }
            }
            //

            SetMappedLocations(InvestigationID);

            var varCtrls = document.getElementById('hdnPCchkAllControls').value.split('~');
            if (varCtrls != null && varCtrls.length > 0) {
                for (i = 0; i < varCtrls.length; i++) {
                    document.getElementById(varCtrls[i]).checked = false;
                    if (InvestigationID != "-1") {
                        document.getElementById(varCtrls[i]).style.display = "none";
                    }
                    else {
                        document.getElementById(varCtrls[i]).style.display = "block";
                    }
                }
            }

            //

            if (ctrlID == 'Add') {
                if (document.getElementById('chkAllInvProcLocMapping').checked == false) {
                    document.getElementById("divPCpopup").style.display = "block";
                    document.getElementById("pcTitle").innerHTML = "<b> &nbsp;" + Name + "</b> ";
                    document.getElementById('hdnInvestigationID').value = InvestigationID;
                }
                else {
                    if (document.getElementById('chkAllInvProcLocMapping').checked == true) {
                        document.getElementById("divPCpopup").style.display = "block";
                        document.getElementById("pcTitle").innerHTML = "<b> &nbsp;" + Name + "</b> ";
                        document.getElementById('hdnInvestigationID').value = InvestigationID;
                    }
                }
            }
        }

        function setUOM(id) {
            document.getElementById('hdnSelUOMInvID').value = id;
            window.open('ChangeUOM.aspx', '', 'width=800,height=600');
        }
        function SelectUOMCode1(id, uomID, uomCode) {
            id = document.getElementById('hdnSelUOMInvID').value.substring(5);
            document.getElementById("hdnUI" + id).value = uomID;
            document.getElementById("hdnUC" + id).value = uomCode;
            document.getElementById("hypUM" + id).innerHTML = uomCode;
            fillValues(document.getElementById("hdnUI" + id).id);
            var rtn = updatedInvs(document.getElementById("hdnUI" + id).id);
        }
    </script>

    <script language="javascript" type="text/javascript">
        function RestrictChar(id) {

            var exp = String.fromCharCode(window.event.keyCode)
            var r = new RegExp("[0-9a-zA-Z \r]", "g");
            if (exp.match(r) == null) {
                window.event.keyCode = 0
                return false;
            }
        }

        function validate() {
            var chkInv = document.getElementById("rdbInvestigaion");
            var chkGrp = document.getElementById("rdbGroup");
            if (!chkInv.checked) {

                document.getElementById('pnlSerch').style.display = "none";
                document.getElementById('Inves').style.display = "none";
                document.getElementById('Inv').style.display = "none";
            }


        }

        function validatesearch() {
            var objVar03 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_04") == null ? "Provide investigation name to search" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_04");
            var objAlert = SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");

            var searchText = document.getElementById("txtInvestigationName").value.trim();
            if (searchText == "") {
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_1");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    // alert('Provide investigation name to search');
                    ValidationWindow(objVar03, objAlert);
                    return false;
                }

                return false;
            }
        }

        function expandGrpBox(id) {
            document.getElementById(id).rows = "5";
            document.getElementById(id).cols = "30";
        }
        function collapseGrpBox(id) {
            document.getElementById(id).rows = "1";
            document.getElementById(id).cols = "7";
            var rtn = updatedGrps(id);
        }
        function expandBox(id) {
            document.getElementById(id).rows = "5";
            document.getElementById(id).cols = "30";
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1";
            document.getElementById(id).cols = "5";
            fillValues(id);
            var rtn = updatedInvs(id);
        }

        function expandList(id) {
            document.getElementById(id).style.width = "300px";
            buildList(id);
        }
        function collapseList(id) {
            document.getElementById(id).style.width = "50px";
            fillValues(id);
            var rtn = updatedInvs(id);
        }
        function checkClick(id) {
            var rtn = fillValues(id);
            updatedInvs(id);
        }
        function updatedGrps(id) {
            var invID = id.substring(5);
            var alreadyExists = 0;
            var list = document.getElementById("hdnGrpUpdatedTest").value.split("~");
            for (var count = 0; count < list.length - 1; count++) {
                if (list[count] == invID) {
                    alreadyExists = 1;
                }
            }
            if (alreadyExists == 0) {
                document.getElementById("hdnGrpUpdatedTest").value += invID + "~";
            }
            // document.getElementById("row" + invID).style.backgroundColor = "#d7d7d7";
            return true;
        }
        function updatedInvs(id) {
            var invID = id.substring(5);
            var alreadyExists = 0;
            var list = document.getElementById("hdnUpdatedTest").value.split("~");
            for (var count = 0; count < list.length - 1; count++) {
                if (list[count] == invID) {
                    alreadyExists = 1;
                }
            }
            if (alreadyExists == 0) {
                document.getElementById("hdnUpdatedTest").value += invID + "~";
            }
            // document.getElementById("row" + invID).style.backgroundColor = "#d7d7d7";
            var x = document.getElementById("row" + invID);
            if (x != null) {
                x.className = "divrowcolor";
            }
            return true;
        }
        function updatedGrpList() {
            var objVar04 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_05") == null ? "There are no changes to group details" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_05");
            var objAlert = SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");

            var list = document.getElementById("hdnGrpUpdatedTest").value.split("~");
            for (var count = 0; count < list.length - 1; count++) {
                if (list[count] != "") {
                    displayText = document.getElementById("txtDT" + list[count]).value;
                    document.getElementById("hdnGrpUpdatedList").value += list[count] + "~" + displayText + "^";
                }
            }
            if (document.getElementById("hdnGrpUpdatedTest").value == "") {
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_2");
                if (userMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    // alert('There are no changes to group details');
                    ValidationWindow(objVar04, objAlert);
                    return false;
                }

                return false;
            }
            else {
                return true;
            }
        }
        String.prototype.ReplaceAll = function(stringToFind, stringToReplace) {
            var temp = this;
            var index = temp.indexOf(stringToFind);
            while (index != -1) {
                temp = temp.replace(stringToFind, stringToReplace);
                index = temp.indexOf(stringToFind);
            }
            return temp;
        }
        function ShowAlert(id1, id2) {
            var objVar05 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_06") == null ? "This Reference Range is Formed As XML,If you want to Edit Use Add Link" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_06");

            document.getElementById(id2.id).innerHTML = "<br/>'" + objVar05 + "'";
        }
        function HideAlert(id1, id2) {
            document.getElementById(id2.id).innerHTML = "";
        }

        function updatedList() {
            var list = document.getElementById("hdnUpdatedTest").value.split("~");
            for (var count = 0; count < list.length - 1; count++) {
                if (list[count] != "") {
                    displayText = document.getElementById("txtDT" + list[count]).value;
                    referenceRange = document.getElementById("hdnRRXML" + list[count]).value == "" ? document.getElementById("txtRR" + list[count]).value : document.getElementById("hdnRRXML" + list[count]).value;
                    //                    referenceRangeXMLFormat = document.getElementById("hdnRRXML" + list[count]).value;
                    referenceRangeStringFormat = document.getElementById("hdnRRstr" + list[count]).value;
                    sample = document.getElementById("ddlSL" + list[count]).value;
                    container = document.getElementById("ddlSC" + list[count]).value;
                    method = document.getElementById("ddlMT" + list[count]).value;
                    principle = document.getElementById("ddlPR" + list[count]).value;
                    kit = document.getElementById("ddlKT" + list[count]).value;
                    instrument = document.getElementById("ddlIT" + list[count]).value;
                    Processcenter = document.getElementById("ddlPC" + list[count]).value;
                    panicRange = document.getElementById("txtPR" + list[count]).value;
                    var ProcesssCenterID = Processcenter;
                    if (document.getElementById("chkQD" + list[count]).checked == true) {
                        qcData = "Y";
                    }
                    else {
                        qcData = "N";
                    }
                    var oEditor1 = '';
                    oEditor1 = FCKeditorAPI.GetInstance("fckInterPret" + list[count]);
                    if (oEditor1.GetHTML(true).trim() != "") {
                        interpretation = oEditor1.GetHTML(true);
                    }
                    else {
                        interpretation = '';
                    }
                    uomID = document.getElementById("hdnUI" + list[count]).value;
                    uomCode = document.getElementById("hdnUC" + list[count]).value;
                    ApplrovalLoginID = document.getElementById("txtAA" + list[count]).value == "" ? 0 : document.getElementById("txtAA" + list[count]).value;
                    IsCheckApproval = document.getElementById("chkAA" + list[count]).checked; // == true ? 0 : document.getElementById("chkAA" + list[count]).value;
                    referenceRangeStringFormat = referenceRangeStringFormat.ReplaceAll('~', '#');
                    referenceRangeStringFormat = referenceRangeStringFormat.ReplaceAll('^', '$');
                    referenceRangeStringFormat = referenceRangeStringFormat.ReplaceAll('|', '@');
                    document.getElementById("hdnUpdatedList").value += list[count] + "~" + displayText + "~" + referenceRange + "~" + sample + "~" + container + "~" + method + "~" + principle + "~" + kit + "~" + instrument + "~" + qcData + "~" + interpretation + "~" + uomID + "~" + uomCode + "~" + ProcesssCenterID + "~" + panicRange + "~" + ApplrovalLoginID + "~" + IsCheckApproval + "~" + referenceRangeStringFormat + "^";
                }
            }
            if (document.getElementById("hdnUpdatedList").value == "") {
                var objVar06 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_07") == null ? "No changes to investigations details" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_07");
                var objAlert = SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");

                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_3");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('No changes to investigations details ');
                    ValidationWindow(objVar06, objAlert);
                    return false;
                }

                return false;
            }
            else {

                return true;
            }
        }


        function NextupdatedList() {
            var objVar07 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_08") == null ? "Do you wish to continue without saving?" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_08");

            var list = document.getElementById("hdnUpdatedTest").value.split("~");
            if (list != "") {
                if (confirm(objVar07)) {
                    document.getElementById("hdnUpdatedTest").value = "";
                    return true;
                }
                else {

                    return false;
                }
            }
            else {

                return true;
            }

        }
        function PreviousupdatedList() {
            var objVar07 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_08") == null ? "Do you wish to continue without saving?" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_08");

            var list = document.getElementById("hdnUpdatedTest").value.split("~");
            if (list != "") {
                if (confirm(objVar07)) {
                    document.getElementById("hdnUpdatedTest").value = "";
                    return true;
                }
                else {

                    return false;
                }
            }
            else {

                return true;
            }
        }

        function NextupdatedListTop() {
            var objVar07 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_08") == null ? "Do you wish to continue without saving?" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_08");
            var list = document.getElementById("hdnUpdatedTest").value.split("~");
            if (list != "") {
                if (confirm(objVar07)) {
                    document.getElementById("hdnUpdatedTest").value = "";
                    return true;
                }
                else {

                    return false;
                }
            }
            else {

                return true;
            }

        }

        function PreviousupdatedListTop() {
            var objVar07 = SListForAppMsg.Get("Admin_InvRefRanges_aspx_08") == null ? "Do you wish to continue without saving?" : SListForAppMsg.Get("Admin_InvRefRanges_aspx_08");

            var list = document.getElementById("hdnUpdatedTest").value.split("~");
            if (list != "") {
                if (confirm(objVar07)) {
                    document.getElementById("hdnUpdatedTest").value = "";
                    return true;
                }
                else {

                    return false;
                }
            }
            else {

                return true;
            }

        }

        function fillValues(id) {
            var x;
            var testID = id.substring(5);
            x = bindList("ddlSL" + testID);
            x = bindList("ddlSC" + testID);
            x = bindList("ddlMT" + testID);
            x = bindList("ddlPR" + testID);
            x = bindList("ddlKT" + testID);
            x = bindList("ddlIT" + testID);
            x = bindList("ddlPC" + testID);
        }

        function bindList(id) {
            var ddlObj = document.getElementById(id);
            if (ddlObj.options.length == 0) {
                ddlObj.options.length = 0;
                var appendID = id.substring(3, 5);
                var testID = id.substring(5);
                var HidValue = document.getElementById('hdn' + appendID).value;
                var SelectedID;
                var list = HidValue.split('^');
                if (HidValue != "") {
                    for (var count = 0; count < list.length - 1; count++) {
                        var listID = list[count].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = listID[1];
                        opt.value = listID[0];
                    }
                    var testList = document.getElementById('hdnTest').value.split("^");
                    for (var count = 0; count < testList.length; count++) {
                        var testList1 = testList[count].split("~");
                        if (testList1[0] == testID) {
                            if (appendID == "SL") {
                                SelectedID = testList1[1];
                            }
                            if (appendID == "SC") {
                                SelectedID = testList1[2];
                            }
                            if (appendID == "MT") {
                                SelectedID = testList1[3];
                            }
                            if (appendID == "PR") {
                                SelectedID = testList1[4];
                            }
                            if (appendID == "KT") {
                                SelectedID = testList1[5];
                            }
                            if (appendID == "IT") {
                                SelectedID = testList1[6];
                            }
                            if (appendID == "PC") {
                                SelectedID = testList1[7];
                            }
                            document.getElementById(id).value = SelectedID;
                        }
                    }
                    //document.getElementById("row" + testID).style.backgroundColor = "#d7d7d7";
                }
            }
            return true;
        }

        function buildList(id) {
            var ddlObj = document.getElementById(id);
            if (ddlObj.options.length == 0) {
                ddlObj.options.length = 0;
                var appendID = id.substring(3, 5);
                var testID = id.substring(5);
                var HidValue = document.getElementById('hdn' + appendID).value;
                var SelectedID;
                var list = HidValue.split('^');
                if (HidValue != "") {
                    for (var count = 0; count < list.length - 1; count++) {
                        var listID = list[count].split('~');
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = listID[1];
                        opt.value = listID[0];
                    }
                    var testList = document.getElementById('hdnTest').value.split("^");
                    for (var count = 0; count < testList.length; count++) {
                        var testList1 = testList[count].split("~");
                        if (testList1[0] == testID) {
                            if (appendID == "SL") {
                                SelectedID = testList1[1];
                            }
                            if (appendID == "SC") {
                                SelectedID = testList1[2];
                            }
                            if (appendID == "MT") {
                                SelectedID = testList1[3];
                            }
                            if (appendID == "PR") {
                                SelectedID = testList1[4];
                            }
                            if (appendID == "KT") {
                                SelectedID = testList1[5];
                            }
                            if (appendID == "IT") {
                                SelectedID = testList1[6];
                            }
                            if (appendID == "PC") {
                                SelectedID = testList1[7];
                            }
                            document.getElementById(id).value = SelectedID;
                        }
                    }
                    //document.getElementById("row" + testID).style.backgroundColor = "#d7d7d7";
                }
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        function ShowRRPopUp1(id, Name,hdnRRStrid,hdnRRXMLid,ctrlID) {
            ////debugger;
            if (ctrlID == 'Add') {
                document.getElementById("trRoleUser").style.display = "none";
                document.getElementById("trChkAA").style.display = "none";
                document.getElementById("divAASave").style.display = "none";
                var targetRRBox = "txtRR" + id;
                document.getElementById("headerTitle").innerHTML = "<b> &nbsp;" + Name + "</b> ";
                document.getElementById('hdnSenderRangeBox').value = id;
                document.getElementById('hdnSenderRRString').value = hdnRRStrid;
                document.getElementById('hdnSenderRRXML').value = hdnRRXMLid;
                if (document.getElementById(document.getElementById('hdnSenderRRString').value).value != '') {
                    LoadRR(document.getElementById(document.getElementById('hdnSenderRRString').value).value);
                }
                else {
                    CloseRRPopUp();
                }
                document.getElementById("trMainCat").style.display = "block";
                document.getElementById("divRRSave").style.display = "block";
                document.getElementById("divRRPopUp").style.display = "block";

            }
        }
		function ShowRRPopUp(id, Name, hdnPRStrid, hdnPRXMLid, ctrlID) {



            if (ctrlID == 'Add') {
                document.getElementById("trRoleUser").style.display = "none";
                document.getElementById("trChkAA").style.display = "none";
                document.getElementById("trMainCat").style.display = "block";
                document.getElementById("divRRSave").style.display = "block";
                document.getElementById("divAASave").style.display = "none";
                var targetRRBox = "txtRR" + id;
                document.getElementById("divRRPopUp").style.display = "block";
                document.getElementById("headerTitle").innerHTML = "<b> &nbsp;" + Name + "</b> ";
                document.getElementById('hdnSenderRangeBox').value = id;
                   document.getElementById('hdnSenderPRString').value = hdnPRStrid;
                document.getElementById('hdnSenderPRXML').value = hdnPRXMLid;
                if (document.getElementById(document.getElementById('hdnSenderPRString').value).value != '') {
                    LoadRR(document.getElementById(document.getElementById('hdnSenderPRString').value).value);
                }
                else {
                    CloseRRPopUp();
                }

            } else {
                document.getElementById("trRoleUser").style.display = "block";
                document.getElementById("trChkAA").style.display = "block";
                document.getElementById("trMainCat").style.display = "none";
                document.getElementById("divRRSave").style.display = "none";
                document.getElementById("divAASave").style.display = "block";
                document.getElementById('chkExistingRR').checked = false;
                document.getElementById('chkDefineAA').checked = false;

                if (document.getElementById(ctrlID).checked == true) {
                    var targetRRBox = "txtRR" + id;
                    document.getElementById("divRRPopUp").style.display = "block";
                    document.getElementById("headerTitle").innerHTML = "<b> &nbsp;" + Name + "</b> ";
                    document.getElementById('hdnSenderRangeBox').value = id;
                }
            }
        }
        function LoadRR(RefRangeStr) {
            RefRangeStr = RefRangeStr.ReplaceAll('#', '~');
            RefRangeStr = RefRangeStr.ReplaceAll('$', '^');
            RefRangeStr = RefRangeStr.ReplaceAll('@', '|');
            var tempRR = RefRangeStr.split('|');
            if (tempRR.length > 1) {
                if (tempRR[1] == "Age") {
                    document.getElementById("hdnAgeRangeAdd").value = tempRR[0];
                    document.getElementById("hdnGenderRangeAdd").value = '';
                    document.getElementById("hdnOtherReferenceRangeAdd").value = '';
                    document.getElementById("divValueReferenceRangeTable").innerHTML = '';
                    document.getElementById("divOtherReferenceRangeTable").innerHTML = '';
                    
                    CreateReferenceRangeTable();

                    document.getElementById("divValueBetween").style.display = "none";
                    document.getElementById('txtValueRange2').value = '';

                    document.getElementById("divAgeBetween").style.display = "none";
                    document.getElementById('txtAgeRange2').value = '';
                }
                else if (tempRR[1] == "Common") {
                document.getElementById("hdnGenderRangeAdd").value = tempRR[0];
                document.getElementById("hdnAgeRangeAdd").value = '';
                document.getElementById("hdnOtherReferenceRangeAdd").value = '';
                document.getElementById("divAgeReferenceRangeTable").innerHTML = '';
                document.getElementById("divOtherReferenceRangeTable").innerHTML = '';
                CreateReferenceRangeTableGender();
                document.getElementById("divGenderValueBetween").style.display = "none";
                document.getElementById('txtGenderValueEnd').value = '';
                }
                else if (tempRR[1] == "Other") {
                document.getElementById("hdnOtherReferenceRangeAdd").value = tempRR[0];
                document.getElementById("hdnGenderRangeAdd").value = '';
                document.getElementById("hdnAgeRangeAdd").value = '';
                document.getElementById("divValueReferenceRangeTable").innerHTML = '';
                document.getElementById("divAgeReferenceRangeTable").innerHTML = '';
                CreateReferenceRangeTableOther();
                document.getElementById("divOtherValueBetween").style.display = "none";
                document.getElementById('txtOtherRange2').value == ''
                }
            }
        }

        function resetDDL() {
            document.getElementById("ddlCategory").selectedIndex = 0;
            document.getElementById("ddlSubCategory").selectedIndex = 0;
            document.getElementById("ddlAgeType").selectedIndex = 0;
            document.getElementById("ddlOperatorRange1").selectedIndex = 0;
            document.getElementById("ddlOperatorRange2").selectedIndex = 0;
            document.getElementById("ddlGenderValueOpt").selectedIndex = 0;
            document.getElementById("ddlOtherRangeOpt").selectedIndex = 0;
        }

        function ShowAAPopUp(id, Name, chkid,idName) {
            ////debugger;
            if (document.getElementById(chkid).checked == true) {

                document.getElementById("trRoleUser").style.display = "block";
                document.getElementById("trChkAA").style.display = "none"; //temp its not use here
                document.getElementById("trMainCat").style.display = "none";
                document.getElementById("divRRSave").style.display = "none";
                document.getElementById("divAASave").style.display = "block";
                document.getElementById('chkExistingRR').checked = false;
                document.getElementById('chkDefineAA').checked = false;

                var targetRRBox = "txtRR" + id;
                document.getElementById("divRRPopUp").style.display = "block";
                document.getElementById("headerTitle").innerHTML = "<b> &nbsp;" + Name + "</b> ";

                document.getElementById('hdnApprovalLoginIdBox').value = id;
                document.getElementById('hdnApprovalLoginNamelbl').value = idName;
            }
            else {
//                document.getElementById('hdnApprovalLoginIdBox').value = id;
//                document.getElementById(document.getElementById('hdnApprovalLoginIdBox').value).value = '';
//                document.getElementById('hdnApprovalLoginNamelbl').value = idName;
//                document.getElementById(document.getElementById('hdnApprovalLoginNamelbl').value).value = '';
                document.getElementById("divRRPopUp").style.display = "none";
                updatedInvs(id);
            }

        }

        function ShowAAMainCat(chkid) {

            if (document.getElementById(chkid).checked == true) {
                document.getElementById('chkExistingRR').checked = false;
                document.getElementById("trMainCat").style.display = "block";
                document.getElementById("divSubCategory").style.display = "none";
                document.getElementById("divAgeCategory").style.display = "none";
                document.getElementById("divGenderGeneralCategory").style.display = "none";
                document.getElementById("divGenderOtherCategory").style.display = "none";
                resetDDL();


            } else {
                document.getElementById("trMainCat").style.display = "none";
                document.getElementById("divSubCategory").style.display = "none";
                document.getElementById("divAgeCategory").style.display = "none";
                document.getElementById("divGenderGeneralCategory").style.display = "none";
                document.getElementById("divGenderOtherCategory").style.display = "none";
                resetDDL();

            }
        }

        function HideAAMainCat(chkid) {

            if (document.getElementById(chkid).checked == true) {
                document.getElementById('chkDefineAA').checked = false;
                document.getElementById("trMainCat").style.display = "none";
                document.getElementById("divSubCategory").style.display = "none";
                document.getElementById("divAgeCategory").style.display = "none";
                document.getElementById("divGenderGeneralCategory").style.display = "none";
                document.getElementById("divGenderOtherCategory").style.display = "none";
                resetDDL();

            }
        }


        function ShowUserForRole(ID) {

            var ddl = document.getElementById('ddlRole');
            var seletedRole = ddl.options[ddl.selectedIndex].value;
            var rawdata = new Array();
            var ddldata = new Array();

            rawdata = document.getElementById('hdnRoleUser').value.split('^');

            var ddlUser = document.getElementById('ddlUsers');

            for (i = ddlUser.length - 1; i >= 0; i--) {
                ddlUser.options[i] = null;
            }


            var opt = document.createElement("option");
            opt.text = 'Select';
            opt.value = 0;

            document.getElementById('ddlUsers').options.add(opt);

            for (var i = 0; i < rawdata.length; i++) {
                ddldata = rawdata[i].split('~');

                if (ddldata[0] == seletedRole) {


                    AddItem(ddldata[2], ddldata[1])
                }

            }



        }

        function AddItem(Text, Value) {

            var opt = document.createElement("option");
            opt.text = Text;
            opt.value = Value;

            document.getElementById('ddlUsers').options.add(opt);


        }

        function ChangeUserLogin(ID) {
            var ddl = document.getElementById('ddlUsers');
            var seletedLoginID = ddl.options[ddl.selectedIndex].value;
            document.getElementById('hdnddlUsers').value = seletedLoginID;
            document.getElementById('hdnddlUsersName').value = ddl.options[ddl.selectedIndex].innerHTML;
            

        }
        function SaveCloseAAPopUp() {

            if (document.getElementById('hdnddlUsers').value != "") {
                document.getElementById(document.getElementById('hdnApprovalLoginIdBox').value).value = document.getElementById('hdnddlUsers').value;
                document.getElementById(document.getElementById('hdnApprovalLoginNamelbl').value).innerHTML = document.getElementById('hdnddlUsersName').value;
                updatedInvs(document.getElementById('hdnApprovalLoginIdBox').value);
            }


            document.getElementById("hdnddlUsers").value = '';
            document.getElementById("divRRPopUp").style.display = "none";

            document.getElementById("divSubCategory").style.display = "none";
            document.getElementById("divAgeCategory").style.display = "none";
            document.getElementById("divGenderGeneralCategory").style.display = "none";
            document.getElementById("divGenderOtherCategory").style.display = "none";




            var ddlUsers = document.getElementById('ddlUsers');
            if (ddlUsers.length > 0) {
                ddlUsers.options[0].selected = true;
            }

            var ddlRole = document.getElementById('ddlRole');
            if (ddlRole.length > 0) {
                ddlRole.options[0].selected = true;
            }

            document.getElementById("divRRPopUp").style.display = "none";
        }

        function CategoryChange(ddlId) {

            //document.getElementById("divSubCategory").style.display = "none";
            //document.getElementById("divAgeCategory").style.display = "none";
            //document.getElementById("divGenderGeneralCategory").style.display = "none";
            //document.getElementById("divGenderOtherCategory").style.display = "none";

            var SubCatogoryDDL = document.getElementById('ddlSubCategory');
            var CategoryDDL = document.getElementById(ddlId);
            var CategoryDDLlength = CategoryDDL.options.length;

            for (var i = 0; i < CategoryDDLlength; i++) {

                if (CategoryDDL.options[i].selected) {

                    if (CategoryDDL.options[i].text == "Male" || CategoryDDL.options[i].text == "Female" || CategoryDDL.options[i].text == "Both") {
                        document.getElementById("divSubCategory").style.display = "block";
                        //SubCatogoryDDL.options[0].selected = true;
                    }
                    else {
                        document.getElementById("divSubCategory").style.display = "none";
                        document.getElementById("divAgeCategory").style.display = "none";
                        document.getElementById("divGenderGeneralCategory").style.display = "none";
                        document.getElementById("divGenderOtherCategory").style.display = "none";

                    }




                }
            }


        }

        function ConfirmChange() {
        var objVar07=SListForAppMsg.Get("Admin_InvRefRanges_aspx_08")== null ?"Do you wish to continue without saving?":SListForAppMsg.Get("Admin_InvRefRanges_aspx_08");
        var UserAccept;
        var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_29");
                if (userMsg != null) {
                    UserAccept=confirm(userMsg);    
                   // return false;
                                  
                }
                else {
                    UserAccept = confirm(objVar07);
                    //return false;
                    }

           // var UserAccept = confirm('Data not Saved. Do you wish to Continue ?');
            if (UserAccept == true) { CategoryChange('ddlCategory'); }
        }

        function SubCategoryChange(ddlId) {

            var SubCategoryDDL = document.getElementById(ddlId);
            var SubCategoryDDLlength = SubCategoryDDL.options.length;

            for (var i = 0; i < SubCategoryDDLlength; i++) {

                if (SubCategoryDDL.options[i].selected) {

                    if (SubCategoryDDL.options[i].text == "Age") {
                        document.getElementById("divAgeCategory").style.display = "block";
                    }
                    else {
                        document.getElementById("divAgeCategory").style.display = "none";

                    }

                    if (SubCategoryDDL.options[i].text == "Common") {
                        document.getElementById("divGenderGeneralCategory").style.display = "block";
                    }
                    else {
                        document.getElementById("divGenderGeneralCategory").style.display = "none";
                    }



                    if (SubCategoryDDL.options[i].text == "Other") {
                        document.getElementById("divGenderOtherCategory").style.display = "block";
                    }
                    else {
                        document.getElementById("divGenderOtherCategory").style.display = "none";
                    }

                }
            }


        }

        function ShowAgeBetween(ddlId) {


            var AgeOperatorDDL = document.getElementById(ddlId);
            var AgeOperatorDDLlength = AgeOperatorDDL.options.length;

            for (var i = 0; i < AgeOperatorDDLlength; i++) {


                if (AgeOperatorDDL.options[i].selected) {

                    if (AgeOperatorDDL.options[i].text == "Between") {

                        document.getElementById("divAgeBetween").style.display = "inline";
                    }
                    else {
                        document.getElementById("divAgeBetween").style.display = "none";
                        document.getElementById('txtAgeRange2').value = '';

                    }

                }
            }
        }


        function ShowValueBetween(ddlId) {


            var ValueOperatorDDL = document.getElementById(ddlId);
            var ValueOperatorDDLlength = ValueOperatorDDL.options.length;

            for (var i = 0; i < ValueOperatorDDLlength; i++) {


                if (ValueOperatorDDL.options[i].selected) {

                    if (ValueOperatorDDL.options[i].text == "Between") {

                        document.getElementById("divValueBetween").style.display = "inline";
                    }
                    else {
                        document.getElementById("divValueBetween").style.display = "none";
                        document.getElementById('txtValueRange2').value = '';
                    }

                }
            }
        }

        function ShowGenderValueBetween(ddlId) {


            var ValueOperatorDDL = document.getElementById(ddlId);
            var ValueOperatorDDLlength = ValueOperatorDDL.options.length;

            for (var i = 0; i < ValueOperatorDDLlength; i++) {


                if (ValueOperatorDDL.options[i].selected) {

                    if (ValueOperatorDDL.options[i].text == "Between") {

                        document.getElementById("divGenderValueBetween").style.display = "inline";
                    }
                    else {
                        document.getElementById("divGenderValueBetween").style.display = "none";
                        document.getElementById('txtGenderValueEnd').value = '';

                    }

                }
            }
        }
        function ShowOtherValueBetween(ddlId) {

            var ValueOperatorDDL = document.getElementById(ddlId);
            var ValueOperatorDDLlength = ValueOperatorDDL.options.length;

            for (var i = 0; i < ValueOperatorDDLlength; i++) {


                if (ValueOperatorDDL.options[i].selected) {

                    if (ValueOperatorDDL.options[i].text == "Between") {

                        document.getElementById("divOtherValueBetween").style.display = "inline";
                        document.getElementById('txtOtherRange2').value == ''
                    }
                    else {
                        document.getElementById("divOtherValueBetween").style.display = "none";
                        document.getElementById('txtOtherRange2').value = ''
                    }

                }
            }
        }

        function AddAgeReferenceRange(gender, ageRangeOptr, startAgeRange, endAgeRange, valueRangeOptr, startValueRange, endValueRange, ageType) {
var objAlert=SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert")== null ?"Alert":SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");
var objVar09=SListForAppMsg.Get("Admin_InvRefRanges_aspx_09")== null ?"Select age type":SListForAppMsg.Get("Admin_InvRefRanges_aspx_09");
var objVar10=SListForAppMsg.Get("Admin_InvRefRanges_aspx_10")== null ?"Select value operator":SListForAppMsg.Get("Admin_InvRefRanges_aspx_10");
var objVar11=SListForAppMsg.Get("Admin_InvRefRanges_aspx_11")== null ?"Value end range cannot be blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_11");
var objVar12=SListForAppMsg.Get("Admin_InvRefRanges_aspx_12")== null ?"Select age operator":SListForAppMsg.Get("Admin_InvRefRanges_aspx_12");
var objVar13=SListForAppMsg.Get("Admin_InvRefRanges_aspx_13")== null ?"Age end range cannot be blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_13");
var objVar14=SListForAppMsg.Get("Admin_InvRefRanges_aspx_14")== null ?"Age Range Cannot be Blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_14");

            var genderType = document.getElementById(gender);
            var selectedGender;
            var selectedValueDDL;
            var selectedAgeDDL;
            var selectedAgeType
            var age;
            var value;
            var ageType;
            var ageTypeDDL = document.getElementById(ageType);
            var ageTypeDDLLength = ageTypeDDL.options.length;
            var ValueOperatorDDL = document.getElementById(valueRangeOptr);
            var ValueOperatorDDLlength = ValueOperatorDDL.options.length;

            var validationCount = 0;



            for (var i = 0; i < ageTypeDDLLength; i++) {
                if (ageTypeDDL.options[i].selected) {
                    if (ageTypeDDL.options[i].text == 'Select Type') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_4");
                        if (userMsg != null) {
                            ///alert(userMsg);
                             ValidationWindow(userMsg, objAlert);
                            return false;
                        }
                        else {
                            //alert('Select age type');
                             ValidationWindow(objVar09, objAlert);
                            return false;
                        }
                        validationCount++;
                    }
                    else {


                        selectedAgeType = ageTypeDDL.options[i].text;
                    }

                }
            }
            for (var i = 0; i < genderType.options.length; i++) {
                if (genderType.options[i].selected) {
                    selectedGender = genderType.options[i].text;
                }
            }
            for (var i = 0; i < ValueOperatorDDLlength; i++) {
                if (ValueOperatorDDL.options[i].selected) {

                    if (ValueOperatorDDL.options[i].text == 'Select') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_5");
                        if (userMsg != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg, objAlert);
                            return false;
                        }
                        else {
                           // alert('Select value operator');
                           ValidationWindow(objVar10, objAlert);
                            return false;
                        }
                        
                        validationCount++;
                    } else {

                        if (ValueOperatorDDL.options[i].text == 'Between' && document.getElementById(endValueRange).value == '') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_6");
                if (userMsg != null){
                    //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_6");
                if (userMsg != null){
                  //  alert(userMsg);
                   ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_6");
                if (userMsg != null){
                    //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
//                    alert('Value end range cannot be blank');
                   ValidationWindow(objVar11, objAlert);
                    return false;
                }
                   
                    return false;
                }
                    
                    return false;
                }
                           
                            validationCount++;
                        } else {

                            selectedValueDDL = ValueOperatorDDL.options[i].text;
                        }
                    }
                }
            }
            var AgeOperatorDDL = document.getElementById(ageRangeOptr);
            var AgeOperatorDDLlength = AgeOperatorDDL.options.length;

            for (var i = 0; i < AgeOperatorDDLlength; i++) {
                if (AgeOperatorDDL.options[i].selected) {

                    if (AgeOperatorDDL.options[i].text == 'Select') {
                    var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_7");
                if (userMsg != null){
                    //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                   // alert('Select age operator');
                    ValidationWindow(objVar12, objAlert);
                    return false;
                }
                       
                        validationCount++;
                    } else {


                        if (AgeOperatorDDL.options[i].text == 'Between' && document.getElementById(endAgeRange).value == '') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_8");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                  // alert('Age end range cannot be blank');
                  ValidationWindow(objVar13, objAlert);
                    return false;
                }
                            
                            validationCount++;
                        } else {

                            selectedAgeDDL = AgeOperatorDDL.options[i].text;
                        }
                    }
                }
            }
            if (document.getElementById(endAgeRange).value != '') {
                if (document.getElementById(startAgeRange).value == '') { 
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_9");
                if (userMsg != null) {
//                    alert(userMsg);
ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                     //alert('Age Range Cannot be Blank');
                      ValidationWindow(objVar14, objAlert);
                    return false;
                }
               
                 validationCount++;
                }

                else { age = document.getElementById(startAgeRange).value + "-" + document.getElementById(endAgeRange).value; }
            } else {
                if (document.getElementById(startAgeRange).value == '') {
                 var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_9");
                if (userMsg != null) {
                   // alert(userMsg);
                   ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    // alert('Age Range Cannot be Blank');
                     ValidationWindow(objVar14, objAlert);
                    return false;
                }
                
                  validationCount++; }
                else { age = document.getElementById(startAgeRange).value; }

            }
            if (document.getElementById(endValueRange).value != '') {
                if (document.getElementById(startValueRange).value == '') {
                 var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_9");
                if (userMsg != null) {
                    //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                     //alert('Age Range Cannot be Blank');
                      ValidationWindow(objVar14, objAlert);
                    return false;
                }
                  validationCount++; }
                else { value = document.getElementById(startValueRange).value + " - " + document.getElementById(endValueRange).value; }
            } else {
                if (document.getElementById(startValueRange).value == '') { 
                 var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_9");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    // alert('Age Range Cannot be Blank');
                     ValidationWindow(objVar14, objAlert);
                    return false;
                } 
                validationCount++; }
                else { value = document.getElementById(startValueRange).value; }
            }






            if (validationCount <= 0) {

                document.getElementById("hdnAgeRangeAdd").value += selectedGender + "~" + selectedAgeDDL + "~" + age + "~" + selectedAgeType + "~" + selectedValueDDL + "~" + value + "^";
                CreateReferenceRangeTable();

                document.getElementById("divValueBetween").style.display = "none";
                document.getElementById('txtValueRange2').value = '';

                document.getElementById("divAgeBetween").style.display = "none";
                document.getElementById('txtAgeRange2').value = '';

            }






        }

        function AddGenderReferenceRange(gender, genderRangeOptr, startGenderRange, endGenderRange, SubCatagoryType) {
var objVar16=SListForAppMsg.Get("Admin_InvRefRanges_aspx_16")== null ?"Select Value Operator":SListForAppMsg.Get("Admin_InvRefRanges_aspx_16");
var objAlert=SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert")== null ?"Alert":SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");
var objVar17=SListForAppMsg.Get("Admin_InvRefRanges_aspx_17")== null ?"Value End Range Cannot be Blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_17");
var objVar19=SListForAppMsg.Get("Admin_InvRefRanges_aspx_19")== null ?"Value Range Cannot be Blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_19");

            var genderType = document.getElementById(gender);
            var selectedGender;
            var subCatagory;
            var selectedValueRange
            var value;
            var subCatagoryType = document.getElementById(SubCatagoryType);
            var subCatagoryTypeLength = subCatagoryType.options.length;
            var validationCount = 0;


            var selectedValueDDL = document.getElementById(genderRangeOptr);
            var selectedValueDDLlength = selectedValueDDL.options.length;
            for (var i = 0; i < subCatagoryTypeLength; i++) {
                if (subCatagoryType.options[i].selected) {
                    subCatagory = subCatagoryType.options[i].text;
                }
            }
            for (var i = 0; i < genderType.options.length; i++) {
                if (genderType.options[i].selected) {
                    selectedGender = genderType.options[i].text;
                }
            }
            for (var i = 0; i < selectedValueDDLlength; i++) {
                if (selectedValueDDL.options[i].selected) {
                    if (selectedValueDDL.options[i].text == 'Select')
                    var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_5");
                        if (userMsg != null) {
                            //alert(userMsg);
                             ValidationWindow(userMsg, objAlert);
                            return false;
                        }
                        else {
                           // alert('Select value operator');
                            ValidationWindow(objvar16, objAlert);
                            return false;
                        }
                       
                    else {

                        if (selectedValueDDL.options[i].text == 'Between' && document.getElementById(endGenderRange).value == '') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_6");
                if (userMsg != null){
                  //  alert(userMsg);
                   ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_6");
                if (userMsg != null){
                   // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Value end range cannot be blank');
                     ValidationWindow(objvar17, objAlert);
                    return false;
                }
                   
                    return false;
                }
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_6");
                if (userMsg != null){
                    //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Value end range cannot be blank');
                     ValidationWindow(objVar17, objAlert);
                    return false;
                }
                          
                            validationCount++;
                        } else {
                            selectedValueRange = selectedValueDDL.options[i].text;
                        }
                    }
                }
            }
            if (document.getElementById(endGenderRange).value != '') {
                if (document.getElementById(startGenderRange).value == '') { 
                 var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_11");
                if (userMsg != null){
                   // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                   // return false;
                }
                else {
                    // alert('Value Range Cannot be Blank'); 
                    ValidationWindow(objVar19, objAlert);
                    //return false;
                }
                 return false;
               
                validationCount++; } else { 
                value = document.getElementById(startGenderRange).value + " - " + document.getElementById(endGenderRange).value; 
                }

            } else {
                if (document.getElementById(startGenderRange).value == '') { 
                 var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_11");
                if (userMsg != null){
                   // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                   // alert('Value Range Cannot be Blank'); 
                     ValidationWindow(objVar19, objAlert);
                    return false;
                }
                validationCount++; } else { value = document.getElementById(startGenderRange).value; }
            }



            if (validationCount <= 0) {
                document.getElementById("hdnGenderRangeAdd").value += selectedGender + "~" + selectedValueRange + "~" + value + "^";
                CreateReferenceRangeTableGender();
                document.getElementById("divGenderValueBetween").style.display = "none";
                document.getElementById('txtGenderValueEnd').value = '';
            }
        }

        function AddOtherReferenceRange(Catagory, other, otherRangeOptr, startOtherRange, endOtherRange, otherNormalFlag) {

var objAlert=SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert")== null ?"Alert":SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");
var objVar16=SListForAppMsg.Get("Admin_InvRefRanges_aspx_16")== null ?"Select Value Operator":SListForAppMsg.Get("Admin_InvRefRanges_aspx_16");
var objVar17=SListForAppMsg.Get("Admin_InvRefRanges_aspx_17")== null ?"Value End Range Cannot be Blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_17");

            var Catagory;
            var ReferenceName;
            var value;
            var selectedValueRange
            var CatagoryType = document.getElementById(Catagory);
            var CatagoryTypeLength = CatagoryType.options.length;
            var selectedValueDDL = document.getElementById(otherRangeOptr);
            var selectedValueDDLlength = selectedValueDDL.options.length;
            var validationCount = 0;
            var rdoNumericText = document.getElementsByName('rdoResultType');
            var ResultType;
            ResultType = null;
            var NormalFlag;

            if (document.getElementById(otherNormalFlag).checked == true) {
                NormalFlag = 'Y';
            } else {
                NormalFlag = 'N';
            }




            for (var i = 0; i < rdoNumericText.length; i++) {
                if (rdoNumericText[i].checked) {
                    ResultType = rdoNumericText[i].value;


                }
            };



            for (var i = 0; i < CatagoryTypeLength; i++) {
                if (CatagoryType.options[i].selected) {
                    Catagory = CatagoryType.options[i].text;
                }
            }
            for (var i = 0; i < selectedValueDDLlength; i++) {
                if (selectedValueDDL.options[i].selected) {

                    if (selectedValueDDL.options[i].text == 'Select' && ResultType == 'Numeric') 
                    { 
                    //alert('Select Value Operator');
                     ValidationWindow(objVar16, objAlert);
                     validationCount++; 
                     } 
                    else 
                    { 
                    if 
                    (selectedValueDDL.options[i].text == 'Between' && document.getElementById(endOtherRange).value == '' && ResultType == 'Numeric')
                     { 
                    // alert('Value End Range Cannot be Blank');
                     validationCount++; 
                      ValidationWindow(objVar17, objAlert);
                     }
                      else
                       { 
                       if 
                       (ResultType == 'Numeric')
                        { selectedValueRange = selectedValueDDL.options[i].text; } else { selectedValueRange = ""; } } }

                }
            }
            if (document.getElementById(other).value != '') {

                ReferenceName = document.getElementById(other).value;

            } else 
            {
            var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_18");
            var objVar18=SListForAppMsg.Get("Admin_InvRefRanges_aspx_18")== null ?"Reference Name Cannot be Blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_18");
                if (userMsg != null) {
                    //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                   // alert('Reference Name Cannot be Blank'); 
                  ValidationWindow(objVar18, objAlert);
                    return false;
                }
             
            validationCount++;
             }

var objVar19=SListForAppMsg.Get("Admin_InvRefRanges_aspx_19")== null ?"Value Range Cannot be Blank":SListForAppMsg.Get("Admin_InvRefRanges_aspx_19");

            if (document.getElementById(endOtherRange).value != '' && ResultType == 'Numeric') {
                if (document.getElementById(startOtherRange).value == '') {
                 var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_11");
                if (userMsg != null){
                   // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                     //alert('Value Range Cannot be Blank'); 
                      ValidationWindow(objVar19, objAlert);
                    return false;
                }
                 
                  validationCount++; } else { value = document.getElementById(startOtherRange).value + " - " + document.getElementById(endOtherRange).value; }
            } else {
                if (document.getElementById(startOtherRange).value == '' && ResultType == 'Numeric') { 
                var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_11");
                if (userMsg != null){
                    //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                     //alert('Value Range Cannot be Blank'); 
                      ValidationWindow(objVar19, objAlert);
                    return false;
                }
                 validationCount++; } else { value = document.getElementById(startOtherRange).value; }
            }



            if (validationCount <= 0) {
                document.getElementById("hdnOtherReferenceRangeAdd").value += Catagory + "~" + ReferenceName + "~" + selectedValueRange + "~" + value + "~" + NormalFlag + "~" + ResultType + "^";
                CreateReferenceRangeTableOther();
                document.getElementById("divOtherValueBetween").style.display = "none";
                document.getElementById('txtOtherRange2').value == ''
            }

        }

        function ShowResultType(ResultType) {
            document.getElementById("hdnOtherReferenceRangeAdd").value = "";
            CreateReferenceRangeTableOther();
            if (ResultType == 'Numeric') {
                document.getElementById('trOtherRangeDetail').style.display = 'block';
                document.getElementById('tblOtherRange').style.display = 'block';
                document.getElementById('ddlOtherRangeOpt').style.display = 'block';

            }
            else {
                document.getElementById('trOtherRangeDetail').style.display = 'block';
                document.getElementById('tblOtherRange').style.display = 'none';
                document.getElementById('ddlOtherRangeOpt').style.display = 'none';
            }


        }


        function CreateReferenceRangeTable() {
            VerifyDataExists();
            var addedvalue = document.getElementById("hdnAgeRangeAdd").value;

            if (document.getElementById("hdnAgeRangeAdd").value != '') {

                var headerTag = "<table id='tblAgeRange' Cellpadding='1' Cellspacing='1' Border='1' width='100%' Class='popupcolor'>";
                headerTag += "<tbody><tr style='height:20px;' Class='evenforsurg'><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Gender %></td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_AgeRange %></td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Age%></td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Type %> </td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_ValueRange %></td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Value%></td><td><%=Resources.ClientSideDisplayTexts.Common_Delete %></td></tr>";
                var bodyTag = '';


                var dataarray = new Array();
                var datasubarray = new Array();
                var ageopt, agerange, valueopt, valuerange;

                dataarray = addedvalue.split('^');

                for (var i = 0; i < dataarray.length - 1; i++) {

                    datasubarray = dataarray[i].split('~');

                    bodyTag += "<tr>"
                    for (var j = 0; j < datasubarray.length; j++) {


                        bodyTag += "<td>" + datasubarray[j] + "</td>";

                    }
                    bodyTag += "<td><input name='" + dataarray[i] + "' onclick='javascript:DeleteReferenceRange(name);' value =<%=Resources.ClientSideDisplayTexts.Common_Delete %> type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:hand'  /></td></tr>"


                }
                var endTag = "</tbody></table>";




                document.getElementById("hdnAgeRangeTable").value = headerTag + bodyTag + endTag;

                //alert(document.getElementById("hdnAgeRangeTable").value);



                document.getElementById("divAgeReferenceRangeTable").innerHTML = document.getElementById("hdnAgeRangeTable").value;



                document.getElementById('txtValueRange1').value = '';
                document.getElementById('txtValueRange2').value = '';
                document.getElementById('txtAgeRange1').value = '';
                document.getElementById('txtAgeRange2').value = '';


                var AgeOperatorDDL = document.getElementById('ddlOperatorRange1');
                var ValueOperatorDDL = document.getElementById('ddlOperatorRange2');
                AgeOperatorDDL.options[0].selected = true;
                ValueOperatorDDL.options[0].selected = true;
                document.getElementById("divAgeReferenceRangeTable").style.display = "block";

            } else {
                document.getElementById("divAgeReferenceRangeTable").style.display = "none";




            }

        }


        function CreateReferenceRangeTableGender() {
            VerifyDataExists();
            var addedvalue = document.getElementById("hdnGenderRangeAdd").value;

            if (document.getElementById("hdnGenderRangeAdd").value != '') {
                var headerTag = "<table id='tblGenderRange' Cellpadding='1' Cellspacing='1' Border='1' width='100%' Class='divtablePop'>";
                headerTag += "<tbody><tr style='height:20px;' class='evenforsurg'><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Gender_1%></td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_ValueRange_1%> </td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Value_1%></td><td><%=Resources.ClientSideDisplayTexts.Common_Delete %></td></tr>";
                var bodyTag = '';


                var dataarray = new Array();
                var datasubarray = new Array();
                var ageopt, agerange, valueopt, valuerange;

                dataarray = addedvalue.split('^');

                for (var i = 0; i < dataarray.length - 1; i++) {

                    datasubarray = dataarray[i].split('~');

                    bodyTag += "<tr>"
                    for (var j = 0; j < datasubarray.length; j++) {


                        bodyTag += "<td>" + datasubarray[j] + "</td>";

                    }
                    bodyTag += "<td><input name='" + dataarray[i] + "' onclick='javascript:DeleteReferenceRangeGender(name);' value = '<%=Resources.ClientSideDisplayTexts.Common_Delete %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:hand'  /></td></tr>"


                }
                var endTag = "</tbody></table>";




                document.getElementById("hdnGenderRangeTable").value = headerTag + bodyTag + endTag;

                //alert(document.getElementById("hdnAgeRangeTable").value);



                document.getElementById("divValueReferenceRangeTable").innerHTML = document.getElementById("hdnGenderRangeTable").value;



                document.getElementById('txtGenderValueStart').value = '';
                document.getElementById('txtGenderValueEnd').value = '';




                var ValueOperatorDDL = document.getElementById('ddlGenderValueOpt');

                ValueOperatorDDL.options[0].selected = true;
                document.getElementById("divValueReferenceRangeTable").style.display = "block";

            }
            else {
                document.getElementById("divValueReferenceRangeTable").style.display = "none";

            }


        }


        function CreateReferenceRangeTableOther() {

            VerifyDataExists();
            var addedvalue = document.getElementById("hdnOtherReferenceRangeAdd").value;
            if (document.getElementById("hdnOtherReferenceRangeAdd").value != '') {
                var headerTag = "<table id='tblGenderRange' Cellpadding='1' Cellspacing='1' Border='1' width='100%' class='tableINVRef' >";
                headerTag += "<tbody><tr style='height:20px;'class='evenforsurg'><td> <%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Catagory%></td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Name%> </td><td><%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Range%> </td><td> <%=Resources.ClientSideDisplayTexts.Admin_InvRefRanges_Value_2%></td><td><%=Resources.ClientSideDisplayTexts.Common_Delete %></td></tr>";
                var bodyTag = '';


                var dataarray = new Array();
                var datasubarray = new Array();
                var ageopt, agerange, valueopt, valuerange;

                dataarray = addedvalue.split('^');

                for (var i = 0; i < dataarray.length - 1; i++) {

                    datasubarray = dataarray[i].split('~');

                    bodyTag += "<tr>"
                    for (var j = 0; j < datasubarray.length; j++) {


                        bodyTag += "<td>" + datasubarray[j] + "</td>";

                    }
                    bodyTag += "<td><input name='" + dataarray[i] + "' onclick='javascript:DeleteReferenceRangeOther(name);' value = '<%=Resources.ClientSideDisplayTexts.Common_Delete %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:hand'  /></td></tr>"


                }
                var endTag = "</tbody></table>";




                document.getElementById("hdnOtherRangeTable").value = headerTag + bodyTag + endTag;

                //alert(document.getElementById("hdnAgeRangeTable").value);



                document.getElementById("divOtherReferenceRangeTable").innerHTML = document.getElementById("hdnOtherRangeTable").value;



                document.getElementById('txtGenderOther').value = '';
                document.getElementById('txtOtherRange1').value = '';
                document.getElementById('txtOtherRange2').value = '';
                document.getElementById('chkNormalValue').checked = false;

                var ValueOperatorDDL = document.getElementById('ddlOtherRangeOpt');
                ValueOperatorDDL.options[0].selected = true;

                document.getElementById("divOtherReferenceRangeTable").style.display = "block";

            }
            else {
                document.getElementById("divOtherReferenceRangeTable").style.display = "none";


            }



        }


        function VerifyDataExists() {

            if (document.getElementById("hdnOtherReferenceRangeAdd").value != '' || document.getElementById("hdnGenderRangeAdd").value != '' || document.getElementById("hdnAgeRangeAdd").value != '') {
                document.getElementById("divScrolling").style.display = "block";
            } else {
                document.getElementById("divScrolling").style.display = "none";
            }
        }


        function DeleteReferenceRange(id) {

            var addedvalue = document.getElementById("hdnAgeRangeAdd").value;
            document.getElementById("hdnAgeRangeAdd").value = '';
            var dataarray = new Array();
            var datasubarray = new Array();
            var ageopt, agerange, valueopt, valuerange;

            dataarray = addedvalue.split('^');

            for (var i = 0; i < dataarray.length - 1; i++) {

                datasubarray = dataarray[i];

                if (id == datasubarray) {

                    //alert('Selected Item will be Deleted !');

                } else {

                    document.getElementById("hdnAgeRangeAdd").value += datasubarray + "^";
                }
            }

            CreateReferenceRangeTable();

        }


        function DeleteReferenceRangeGender(id) {

            var addedvalue = document.getElementById("hdnGenderRangeAdd").value;
            document.getElementById("hdnGenderRangeAdd").value = '';
            var dataarray = new Array();
            var datasubarray = new Array();
            var ageopt, agerange, valueopt, valuerange;

            dataarray = addedvalue.split('^');

            for (var i = 0; i < dataarray.length - 1; i++) {

                datasubarray = dataarray[i];

                if (id == datasubarray) {

                    //alert('Selected Item will be Deleted !');

                } else {

                    document.getElementById("hdnGenderRangeAdd").value += datasubarray + "^";
                }
            }

            CreateReferenceRangeTableGender();

        }

        function DeleteReferenceRangeOther(id) {

            var addedvalue = document.getElementById("hdnOtherReferenceRangeAdd").value;
            document.getElementById("hdnOtherReferenceRangeAdd").value = '';
            var dataarray = new Array();
            var datasubarray = new Array();
            var ageopt, agerange, valueopt, valuerange;

            dataarray = addedvalue.split('^');

            for (var i = 0; i < dataarray.length - 1; i++) {

                datasubarray = dataarray[i];

                if (id == datasubarray) {

                    //alert('Selected Item will be Deleted !');

                } else {

                    document.getElementById("hdnOtherReferenceRangeAdd").value += datasubarray + "^";
                }
            }

            CreateReferenceRangeTableOther();

        }

        function CloseRRPopUp() {
            document.getElementById("hdnAgeRangeAdd").value = '';
            document.getElementById("hdnGenderRangeAdd").value = '';
            document.getElementById("hdnOtherReferenceRangeAdd").value = '';
            document.getElementById("divRRPopUp").style.display = "none";

            document.getElementById("divSubCategory").style.display = "none";
            document.getElementById("divAgeCategory").style.display = "none";
            document.getElementById("divGenderGeneralCategory").style.display = "none";
            document.getElementById("divGenderOtherCategory").style.display = "none";


            CreateReferenceRangeTableOther();
            CreateReferenceRangeTableGender();
            CreateReferenceRangeTable();

            var MainCatagoryDDL = document.getElementById('ddlCategory');
            MainCatagoryDDL.options[0].selected = true;

            var ValueOperatorDDL = document.getElementById('ddlOtherRangeOpt');
            ValueOperatorDDL.options[0].selected = true;


            var ValueOperatorDDL = document.getElementById('ddlGenderValueOpt');
            ValueOperatorDDL.options[0].selected = true;


            var AgeOperatorDDL = document.getElementById('ddlOperatorRange1');
            var ValueOperatorDDL = document.getElementById('ddlOperatorRange2');
            AgeOperatorDDL.options[0].selected = true;
            ValueOperatorDDL.options[0].selected = true;


        }

        function CloseAAPopUp() {
            document.getElementById("hdnAgeRangeAdd").value = '';
            document.getElementById("hdnGenderRangeAdd").value = '';
            document.getElementById("hdnOtherReferenceRangeAdd").value = '';
            document.getElementById("divAAPopUp").style.display = "none";

            document.getElementById("divSubCategory").style.display = "none";
            document.getElementById("divAgeCategory").style.display = "none";
            document.getElementById("divGenderGeneralCategory").style.display = "none";
            document.getElementById("divGenderOtherCategory").style.display = "none";


            CreateReferenceRangeTableOther();
            CreateReferenceRangeTableGender();
            CreateReferenceRangeTable();

            var MainCatagoryDDL = document.getElementById('ddlCategory');
            MainCatagoryDDL.options[0].selected = true;

            var ValueOperatorDDL = document.getElementById('ddlOtherRangeOpt');
            ValueOperatorDDL.options[0].selected = true;


            var ValueOperatorDDL = document.getElementById('ddlGenderValueOpt');
            ValueOperatorDDL.options[0].selected = true;


            var AgeOperatorDDL = document.getElementById('ddlOperatorRange1');
            var ValueOperatorDDL = document.getElementById('ddlOperatorRange2');
            AgeOperatorDDL.options[0].selected = true;
            ValueOperatorDDL.options[0].selected = true;


        }

        function SaveCloseRRPopUp() {

var objAlert=SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert")== null ?"Alert":SListForAppMsg.Get("Admin_InvRefRanges_aspx_Alert");
var objVar20=SListForAppMsg.Get("Admin_InvRefRanges_aspx_20")== null ?"Multiple Sub Catagory Not Allowed":SListForAppMsg.Get("Admin_InvRefRanges_aspx_20");


            var count = 0;
            if (document.getElementById("hdnAgeRangeAdd").value != '') { count += 1; } if (document.getElementById("hdnGenderRangeAdd").value != '') { count += 1; } if (document.getElementById("hdnOtherReferenceRangeAdd").value) { count += 1; }


            if (count > 1) {
            var userMsg = SListForApplicationMessages.Get("Admin\\InvRefRanges.aspx_24");
                if (userMsg != null) {
                   // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                   //alert('Multiple Sub Catagory Not Allowed'); 
                    ValidationWindow(objVar20, objAlert);
                    return false;
                }
             
             }

            else {


var objVar21=SListForAppDisplay.Get("Admin_InvRefRanges_aspx_05")== null ?"Enter ReferenceRange":SListForAppDisplay.Get("Admin_InvRefRanges_aspx_05");

                if (document.getElementById("hdnAgeRangeAdd").value != '') {
                    if (document.getElementById('hdnSenderRRString').value != '') {
                        document.getElementById(document.getElementById('hdnSenderRRString').value).value = document.getElementById("hdnAgeRangeAdd").value + '|Age';
                    }
                    ConvertToXml(document.getElementById("hdnAgeRangeAdd").value + '|Age');
                }
                else if (document.getElementById("hdnGenderRangeAdd").value != '') {
                if (document.getElementById('hdnSenderRRString').value != '') {
                    document.getElementById(document.getElementById('hdnSenderRRString').value).value = document.getElementById("hdnGenderRangeAdd").value + '|Common';
                }
                    ConvertToXml(document.getElementById("hdnGenderRangeAdd").value + '|Common');
                }
                else if (document.getElementById("hdnOtherReferenceRangeAdd").value != '') {
                if (document.getElementById('hdnSenderRRString').value != '') {
                    document.getElementById(document.getElementById('hdnSenderRRString').value).value = document.getElementById("hdnOtherReferenceRangeAdd").value + '|Other';
                }
                    ConvertToXml(document.getElementById("hdnOtherReferenceRangeAdd").value + '|Other');
                }
                else {
                    document.getElementById(document.getElementById('hdnSenderRangeBox').value).removeAttribute("readonly", 0);
                    document.getElementById(document.getElementById('hdnSenderRangeBox').value).value = '';
//                    document.getElementById(document.getElementById('hdnSenderRangeBox').value).title = 'Enter ReferenceRange';
 document.getElementById(document.getElementById('hdnSenderRangeBox').value).title = objVar21;
                    document.getElementById(document.getElementById('hdnSenderRRXML').value).value = '';
                    document.getElementById(document.getElementById('hdnSenderRRString').value).value = '';
                    updatedInvs(document.getElementById('hdnSenderRangeBox').value);
                }
                document.getElementById("hdnAgeRangeAdd").value = '';
                document.getElementById("hdnGenderRangeAdd").value = '';
                document.getElementById("hdnOtherReferenceRangeAdd").value = '';
                document.getElementById("divRRPopUp").style.display = "none";

                CloseRRPopUp();


            }
        }
        function ReceiveXmlData(arg) {

            document.getElementById(document.getElementById('hdnSenderRangeBox').value).disabled = false;
            document.getElementById(document.getElementById('hdnSenderRangeBox').value).value = arg;
            document.getElementById(document.getElementById('hdnSenderRangeBox').value).focus();
            document.getElementById('hdnSenderRangeBox').value = '';
            if (document.getElementById('hdnSenderRRXML').value != '') {
                document.getElementById(document.getElementById('hdnSenderRRXML').value).value = arg;
            }
            document.getElementById('hdnSenderRRXML').value = '';

        }
        function ProcessCallBackError(arg) {
            //document.getElementById("txtdummy").value = arg;
        }
        function ConvertTexttoPredefinedText(id) {
            var text = document.getElementById(document.getElementById(id).id).value;
            text.search("Male");
        }





        function extractNumber(obj, decimalPlaces, allowNegative) {
            var temp = obj.value;

            // avoid changing things if already formatted correctly
            var reg0Str = '[0-9]*';
            if (decimalPlaces > 0) {
                reg0Str += '\\.?[0-9]{0,' + decimalPlaces + '}';
            } else if (decimalPlaces < 0) {
                reg0Str += '\\.?[0-9]*';
            }
            reg0Str = allowNegative ? '^-?' + reg0Str : '^' + reg0Str;
            reg0Str = reg0Str + '$';
            var reg0 = new RegExp(reg0Str);
            if (reg0.test(temp)) return true;

            // first replace all non numbers
            var reg1Str = '[^0-9' + (decimalPlaces != 0 ? '.' : '') + (allowNegative ? '-' : '') + ']';
            var reg1 = new RegExp(reg1Str, 'g');
            temp = temp.replace(reg1, '');

            if (allowNegative) {
                // replace extra negative
                var hasNegative = temp.length > 0 && temp.charAt(0) == '-';
                var reg2 = /-/g;
                temp = temp.replace(reg2, '');
                if (hasNegative) temp = '-' + temp;
            }

            if (decimalPlaces != 0) {
                var reg3 = /\./g;
                var reg3Array = reg3.exec(temp);
                if (reg3Array != null) {
                    // keep only first occurrence of .
                    //  and the number of places specified by decimalPlaces or the entire string if decimalPlaces < 0
                    var reg3Right = temp.substring(reg3Array.index + reg3Array[0].length);
                    reg3Right = reg3Right.replace(reg3, '');
                    reg3Right = decimalPlaces > 0 ? reg3Right.substring(0, decimalPlaces) : reg3Right;
                    temp = temp.substring(0, reg3Array.index) + '.' + reg3Right;
                }
            }

            obj.value = temp;
        }
        function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
            var key;
            var isCtrl = false;
            var keychar;
            var reg;

            if (window.event) {
                key = e.keyCode;
                isCtrl = window.event.ctrlKey
            }
            else if (e.which) {
                key = e.which;
                isCtrl = e.ctrlKey;
            }

            if (isNaN(key)) return true;

            keychar = String.fromCharCode(key);

            // check for backspace or delete, or if Ctrl was pressed
            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }
    
    </script>

    <style type="text/css">
        .style1
        {
            width: 35%;
        }
        .style2
        {
            height: 20px;
            width: 35%;
        }
        .style3
        {
            width: 209px;
        }
       table.gridView .Duecolor.gridHeader td{ color:#fff;}
    </style>
</head>
<body oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server" defaultbutton="btnSave">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <input type="hidden" id="hdnSelUOMInvID" value="" runat="server" />
        <asp:Label runat="server" ID="lblMessage" Font-Bold="True" ForeColor="#000333" meta:resourcekey="lblMessageResource1"></asp:Label>
        <%--<uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
        <table class="w-100p searchPanel">
            <tr>
                <td>
                    <table class="w-100p">
                        <tr>
                            <td class="a-center">
                                <asp:Label ID="lbltest" runat="server" Text="Select One Type: " Font-Bold="True"
                                    meta:resourcekey="lbltestResource1"></asp:Label>
                                <asp:RadioButton ID="rdbInvestigaion" Text="Investigation" runat="server" GroupName="INVGRP"
                                    OnCheckedChanged="rdbInvestigaion_CheckedChanged" AutoPostBack="True" Font-Bold="True"
                                    meta:resourcekey="rdbInvestigaionResource1" />
                                <asp:RadioButton ID="rdbGroup" Text="Group or Package" runat="server" GroupName="INVGRP"
                                    OnCheckedChanged="rdbGroup_CheckedChanged" AutoPostBack="True" Font-Bold="True"
                                    meta:resourcekey="rdbGroupResource1" />
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnlSerch" CssClass="dataheader2 w-100p" BorderWidth="1px" runat="server"
                        meta:resourcekey="pnlSerchResource1">
                        <table id="searchTab" runat="server" class="w-100p bg-row">
                            <tr runat="server">
                                <td class="h-20 w-15p a-left" style="color: #000;" runat="server">
                                    <asp:Label ID="lblSearch" Text="Enter Investigation to Search" runat="server"></asp:Label>
                                </td>
                                <td class="h-20 w-20p a-left style2" style="color: #000;" runat="server">
                                    <asp:TextBox ID="txtInvestigationName" ToolTip="Investigation Name" CssClass="Txtboxsmall"
                                        runat="server"></asp:TextBox>
                                </td>
                                <td class="a-left w-10p" runat="server">
                                    <asp:Button ID="btnSearch" ToolTip="Click here to Search the Investigation" Style="cursor: pointer;"
                                        runat="server" Text="Search" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        OnClick="btnSearch_Click" OnClientClick="javascript:return validatesearch();" />
                                </td>
                                <td runat="server">
                                    <img src="../Images/ExcelImage.GIF" style="cursor: pointer;" onclick="imgPrint_Click"
                                        id="imgPrint" runat="server" />
                                    <asp:LinkButton ID="printReferenceRange" Text="Export Master Data" Font-Underline="True"
                                        OnClick="print_Click" ForeColor="#000333" runat="server"></asp:LinkButton>
                                </td>
                                <td class="a-left" runat="server">
                                    <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" />
                                    <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" ForeColor="#000333"
                                        ToolTip="Save As Excel">
                                        <u>
                                            <asp:Label ID="lblExportUnmappedSampleMethod" runat="server" Text="Export Unmapped Sample/Method"
                                                meta:resourcekey="lblExportUnmappedSampleMethodResource1"></asp:Label>
                                        </u>
                                    </asp:LinkButton>
                                </td>
                                <td class="a-left" runat="server">
                                    <asp:FileUpload ID="FileUpload1" runat="server"/>
                                    <asp:Button ID="hBtnUpload" runat="server" meta:resourcekey="hBtnUpload1" Text="Upload Excel"
                                        class="btn" OnClick="hBtnUpload_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="pnlGrpSearch" CssClass="dataheader2 w-100p"
                        runat="server" meta:resourcekey="pnlGrpSearchResource1">
                        <table border="0" id="Table1" runat="server" class="w-100p">
                            <tr runat="server">
                                <td class="w-15p a-left h-20" runat="server">
                                    <asp:Label ID="lblGrpSearch" Text="Enter Group or Package to Search" runat="server"></asp:Label>
                                </td>
                               <td id="Td1" class="w-14p a-left h-20" runat="server">
                                    <asp:TextBox ID="txtGroupName" ToolTip="Group Name" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                </td>
                                <td class="w-10p a-left" runat="server">
                                    <asp:Button ID="btnGrpSearch" ToolTip="Click here to Search the Group" Style="cursor: pointer;"
                                        runat="server" Text="Search" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        OnClick="btnGrpSearch_Click" />
                                </td>
                                <td class="w-60p" runat="server">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                        meta:resourcekey="lblStatusResource1"></asp:Label>
                    <input type="hidden" id="hdnSL" runat="server" />
                    <input type="hidden" id="hdnSC" runat="server" />
                    <input type="hidden" id="hdnMT" runat="server" />
                    <input type="hidden" id="hdnPR" runat="server" />
                    <input type="hidden" id="hdnKT" runat="server" />
                    <input type="hidden" id="hdnIT" runat="server" />
                    <input type="hidden" id="hdnTest" runat="server" />
                    <input type="hidden" id="hdnGrpTest" runat="server" />
                    <input type="hidden" id="hdnUpdatedTest" runat="server" />
                    <input type="hidden" id="hdnUpdatedList" runat="server" />
                    <input type="hidden" id="hdnGrpUpdatedTest" runat="server" />
                    <input type="hidden" id="hdnGrpUpdatedList" runat="server" />
                    <input type="hidden" id="hdnStartIndex" runat="server" />
                    <input type="hidden" id="hdnEndIndex" runat="server" />
                    <input type="hidden" id="hdnGrpStartIndex" runat="server" />
                    <input type="hidden" id="hdnGrpEndIndex" runat="server" />
                    <input type="hidden" id="hdnTotalCount" runat="server" />
                    <input type="hidden" id="hdnGrpTotalCount" runat="server" />
                    <input type="hidden" id="hdnSearchTotalCount" runat="server" />
                    <input type="hidden" id="hdnSearchGrpTotalCount" runat="server" />
                    <input type="hidden" id="hdnPC" runat="server" />
                    <input type="hidden" id="hdnPCActual" runat="server" />
                    <table class="w-100p" runat="server" id="btnTabTop">
                        <tr id="Inves" runat="server" align="center">
                            <td>
                                <asp:Button ID="btnSave1" ToolTip="Click here to Save Details" Style="cursor: pointer;"
                                    runat="server" Text="Save" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                    OnClick="btnSave_Click" OnClientClick="javascript:return updatedList();" meta:resourcekey="btnSave1Resource1" />
                                <asp:Button ID="btnPreviousTop" ToolTip="Click here to move Previous" Style="cursor: pointer;"
                                    runat="server" Text="Previous" class="btn" onmouseout="this.className='btn'"
                                    onmouseover="this.className='btn btnhov'" OnClick="btnPreviousTop_Click" OnClientClick="javascript:if(! PreviousupdatedListTop(this))return false;"
                                    meta:resourcekey="btnPreviousTopResource1" />&nbsp;
                                <asp:Button ID="btnNextTop" ToolTip="Click here to move Next" Style="cursor: pointer;"
                                    runat="server" Text="Next" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                    OnClick="btnNextTop_Click" OnClientClick="javascript:if(! NextupdatedListTop(this))return false;"
                                    meta:resourcekey="btnNextTopResource1" />&nbsp;
                                <asp:Button ID="btnCancel1" runat="server" Text="Cancel" ToolTip="Click here to Cancel, View Home Page"
                                    Style="cursor: pointer;" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                    OnClick="btnCancel_Click" meta:resourcekey="btnCancel1Resource1" />
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p" runat="server" id="Table2">
                        <tr id="Tr1" runat="server" class="a-left">
                            <td>
                                <asp:CheckBox ID="chkAllInvProcLocMapping" Text="All Investigation - Processing Centre Mapping"
                                    runat="server" meta:resourcekey="chkAllInvProcLocMappingResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div id="divPCpopup" runat="server" class="divRRpopup" style="overflow-y: auto; height: 250px">
            <asp:Table ID="tblPCpopup" CssClass="divtablePop w-36p" runat="server" CellPadding="2"
                CellSpacing="0" BorderWidth="1px" meta:resourcekey="tblPCpopupResource1">
                <asp:TableRow meta:resourcekey="TableRowResource1">
                    <asp:TableCell CssClass="w-80p h-23 a-left" ColumnSpan="2" meta:resourcekey="TableCellResource1">
                                            <span id="pcTitle"></span>
                    </asp:TableCell>
                    <asp:TableCell meta:resourcekey="TableCellResource2"></asp:TableCell>
                    <asp:TableCell Width="20%" align="right" meta:resourcekey="TableCellResource3">
                                            <img id="img1" onclick="javascript:ClosePCPopUp();" src="../Images/Delete.jpg" class="pointer" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <asp:Table ID="masterTab" CssClass="dataheaderInvCtrl w-100p gridView" runat="server" CellPadding="2"
            CellSpacing="0" BorderWidth="1px"  meta:resourcekey="masterTabResource1">
        </asp:Table>
        <div id="divRRPopUp" runat="server" class="divRRpopup">
            <table class="divtablePop w-100p">
                <tr style="height: 20px;" class="evenforsurg">
                    <td class="w-80p h-23 a-left">
                        <span id="headerTitle"></span>
                    </td>
                    <td class="a-right w-20p">
                        <img id="img2" onclick="javascript:CloseRRPopUp();" src="../Images/Delete.jpg" class="pointer" />
                    </td>
                </tr>
                <%--Auto Autorize Merge Begins--%>
                <tr id="trRoleUser" class="h-20" style="display: none;">
                    <td colspan="2" class="a-left">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="lblRoleName" runat="server" Text="Role" meta:resourcekey="lblRoleNameResource1" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="ddl">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblUsers" runat="server" Text="User" meta:resourcekey="lblUsersResource1" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlUsers" runat="server" CssClass="ddl">
                                    </asp:DropDownList>
                                    <asp:HiddenField ID="hdnddlUsers" runat="server" />
                                    <asp:HiddenField ID="hdnApprovalLoginIdBox" runat="server" />
                                    <asp:HiddenField ID="hdnddlUsersName" runat="server" />
                                    <asp:HiddenField ID="hdnApprovalLoginNamelbl" runat="server" />
                                </td>
                                <td class="a-right">
                                    <div id="divAASave" style="display: none;">
                                        <asp:HyperLink class="btn" ID="hlnksaveCloseAA" runat="server" meta:resourcekey="hlnksaveCloseAAResource1"
                                            Text="Save/Close"></asp:HyperLink>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr class="h-20" id="trChkAA" style="display: none;">
                    <td colspan="2" class="a-left">
                        <table class="w-70p">
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkExistingRR" runat="server" Text="Existing Reference Range" onclick="HideAAMainCat(this.id)"
                                        meta:resourcekey="chkExistingRRResource1" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkDefineAA" runat="server" Text="Define Reference Range" onclick="ShowAAMainCat(this.id)"
                                        meta:resourcekey="chkDefineAAResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--Auto Autorize Merge Ends--%>
                <tr  class="h-20" id="trMainCat" style="display: none;">
                    <td colspan="2" class="a-left">
                        <table class="w-100p">
                            <tr>
                                <td class="w-16p">
                                    <asp:Label ID="Rs_Gender" Text="Gender" runat="server" meta:resourcekey="Rs_GenderResource1"></asp:Label>
                                </td>
                                <td class="w-50p a-left">
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="ddl" >
                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                        <asp:ListItem meta:resourcekey="ListItemResource2">Male</asp:ListItem>
                                        <asp:ListItem meta:resourcekey="ListItemResource3">Female</asp:ListItem>
                                        <asp:ListItem meta:resourcekey="ListItemResource4">Both</asp:ListItem>--%>
                                    </asp:DropDownList>
                                </td>
                                <td class="w-10p a-center">
                                    <table>
                                        <tr>
                                            <%--<td align="right">
            <asp:HyperLink  class="btn" ID="hlnkSave" runat="server">Save</asp:HyperLink>

                
            </td>--%>
                                            <td class="a-right">
                                                <div id="divRRSave" style="display: none;">
                                                    <asp:HyperLink class="btn" ID="hlnksaveClose" runat="server" meta:resourcekey="hlnksaveCloseResource1"
                                                        Text="Save/Close"></asp:HyperLink>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="a-left">
                        <div id="divSubCategory" style="display: none;">
                            <table class="w-50p">
                                <tr>
                                    <td class="w-20p">
                                        <asp:Label ID="Rs_SubCategory" Text="Sub Category" runat="server" meta:resourcekey="Rs_SubCategoryResource1"></asp:Label>
                                    </td>
                                    <td class="w-30p h-23 a-left">
                                        <asp:DropDownList ID="ddlSubCategory" runat="server" >
                                            <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource5">Select</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource6">Age</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource7">Common</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource8">Other</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="a-center">
                        <div id="divAgeCategory" style="display: none;">
                            <table class="w-100p">
                                <tr class="evenforsurg h-20">
                                    <td class="a-left" colspan="5">
                                        <b>
                                            <asp:Label ID="Rs_AgeRange" Text="Age Range" runat="server" meta:resourcekey="Rs_AgeRangeResource1"></asp:Label></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:DropDownList ID="ddlAgeType" runat="server" >
                                            <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource9">Select Type</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource10">Years</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource11">Months</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource12">Weeks</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="a-left">
                                        <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                    </td>
                                    <td class="a-left">
                                    </td>
                                    <td class="a-left">
                                        <asp:Label ID="Rs_value" Text="value" runat="server" meta:resourcekey="Rs_valueResource1"></asp:Label>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:DropDownList ID="ddlOperatorRange1" runat="server" >
                                            <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource13">Select</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource14">&lt;</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource15">&lt;=</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource16">=</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource17">&gt;</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource18">=&gt;</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource19">Between</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="a-left">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtAgeRange1" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                        onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        meta:resourcekey="txtAgeRange1Resource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <div id="divAgeBetween" style="display: none;">
                                                        -&nbsp;
                                                        <asp:TextBox ID="txtAgeRange2" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                            onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                            meta:resourcekey="txtAgeRange2Resource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlOperatorRange2" runat="server">
                                           <%-- <asp:ListItem Value="0" meta:resourcekey="ListItemResource20">Select</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource21">&lt;</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource22">&lt;=</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource23">=</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource24">&gt;</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource25">=&gt;</asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource26">Between</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="a-left">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtValueRange1" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                        onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        meta:resourcekey="txtValueRange1Resource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <div id="divValueBetween" style="display: none;">
                                                        -&nbsp;<asp:TextBox ID="txtValueRange2" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                            onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                            meta:resourcekey="txtValueRange2Resource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="a-left">
                                        <asp:HyperLink ID="hlnkAddAge" runat="server" meta:resourcekey="hlnkAddAgeResource1"
                                            Text="Add"></asp:HyperLink>
                                    </td>
                                </tr>
                            </table>
                            <%-- <div id="divAgeReferenceRangeTable" style="display:block;">
            
             
            </div>--%>
                        </div>
                        <div id="divGenderGeneralCategory" style="display: none;">
                            <table class="w-100p">
                                <tr class="evenforsurg h-20">
                                    <td class="a-left">
                                        <b>
                                            <asp:Label ID="Rs_ValueRange" Text="Value Range" runat="server" meta:resourcekey="Rs_ValueRangeResource1"></asp:Label></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-70p">
                                            <tr>
                                                <td class="a-left">
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_Value1" Text="Value" runat="server" meta:resourcekey="Rs_Value1Resource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlGenderValueOpt" runat="server" >
                                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource27">Select</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource28">&lt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource29">&lt;=</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource30">=</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource31">&gt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource32">=&gt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource33">Between</asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtGenderValueStart" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                    onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                    meta:resourcekey="txtGenderValueStartResource1"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <div id="divGenderValueBetween" style="display: none;">
                                                                    -&nbsp;<asp:TextBox ID="txtGenderValueEnd" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                        onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                        meta:resourcekey="txtGenderValueEndResource1"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-left">
                                                    <asp:HyperLink ID="hlnkGenderValueAdd" runat="server" Text="Add" meta:resourcekey="hlnkGenderValueAddResource1"></asp:HyperLink>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divGenderOtherCategory" style="display: none;">
                            <table class="w-100p">
                                <tr class="h-20 evenforsurg">
                                    <td class="a-left">
                                        <b>
                                            <asp:Label ID="Rs_Other" Text="Other" runat="server" meta:resourcekey="Rs_OtherResource1"></asp:Label></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-30p">
                                                                <%--Result Type :--%><%= Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_01%>
                                                            </td>
                                                            <td class="w-15p">
                                                                <input value="Numeric" type="radio" name="rdoResultType" onclick="ShowResultType('Numeric');" />
                                                            </td>
                                                            <td class="w-15p">
                                                                <%--Numeric--%><%= Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_02%>
                                                            </td>
                                                            <td class="w-15p">
                                                                <input value="Text" type="radio" name="rdoResultType" onclick="ShowResultType('Text');" />
                                                            </td>
                                                            <td class="w-15p">
                                                                <%--Text--%><%= Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_03%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr id="trOtherRangeDetail" style="display: none;">
                                                <td>
                                                    <asp:Label ID="Rs_ReferenceName" Text="Reference Name" runat="server" meta:resourcekey="Rs_ReferenceNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtGenderOther" runat="server" Width="70px" meta:resourcekey="txtGenderOtherResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlOtherRangeOpt" runat="server" 
                                                        Style="display: none;">
                                                       <%-- <asp:ListItem Value="0" meta:resourcekey="ListItemResource34">Select</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource35">&lt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource36">&lt;=</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource37">=</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource38">&gt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource39">=&gt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource40">Between</asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left">
                                                    <table id="tblOtherRange" style="display: none;">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtOtherRange1" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                    onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                    meta:resourcekey="txtOtherRange1Resource1"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <div id="divOtherValueBetween" style="display: none;">
                                                                    -&nbsp;<asp:TextBox ID="txtOtherRange2" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                        onkeyup="extractNumber(this,-1,false);"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                        meta:resourcekey="txtOtherRange2Resource1"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-left">
                                                    <table>
                                                        <tr>
                                                            <td style="border: 1px solid #92CD00;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:CheckBox ID="chkNormalValue" runat="server" 
                                                                                meta:resourcekey="chkNormalValueResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <%--Normal--%><%=Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_04 %>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td>
                                                                <%--<asp:HyperLink ID="hlnkGenderGeneralOther" runat="server"  ></asp:HyperLink>--%>
                                                                <asp:HyperLink ID="hlnkGenderGeneralOther" runat="server" Text="Add" 
                                                                    meta:resourcekey="hlnkGenderGeneralOtherResource1"></asp:HyperLink>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <%--<div id="divOtherReferenceRangeTable" style="display:block;"> 
            </div>--%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="2">
                        <div id="divScrolling" runat="server" class="divRRpopup1">
                            <table width="95%">
                                <tr>
                                    <td>
                                        <div id="divAgeReferenceRangeTable" style="display: none;">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="divValueReferenceRangeTable" style="display: none;">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="divOtherReferenceRangeTable" style="display: none;">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr class="evenforsurg h-20">
                    <td colspan="2">
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdnAgeRangeTable" runat="server" />
            <asp:HiddenField ID="hdnAgeRangeAdd" runat="server" />
            <asp:HiddenField ID="hdnGenderRangeTable" runat="server" />
            <asp:HiddenField ID="hdnGenderRangeAdd" runat="server" />
            <asp:HiddenField ID="hdnOtherRangeTable" runat="server" />
            <asp:HiddenField ID="hdnOtherReferenceRangeAdd" runat="server" />
            <asp:HiddenField ID="hdnSenderRangeBox" runat="server" />
            <asp:HiddenField ID="hdnSenderRRString" runat="server" />
            <asp:HiddenField ID="hdnSenderRRXML" runat="server" />
            <asp:HiddenField ID="hdnSenderPRString" runat="server" />
            <asp:HiddenField ID="hdnSenderPRXML" runat="server" />
            <asp:HiddenField ID="hdnRoleUser" runat="server" />
            <asp:HiddenField ID="hdnCCControls" runat="server" />
            <asp:HiddenField ID="hdnPCControls" runat="server" />
            <asp:HiddenField ID="hdnPCddlControls" runat="server" />
            <asp:HiddenField ID="hdnCCFinalList" runat="server" />
            <asp:HiddenField ID="hdnPCFinalList" runat="server" />
            <asp:HiddenField ID="hdnInvestigationID" runat="server" />
            <asp:HiddenField ID="hdnPCchkAllControls" runat="server" />
            <asp:HiddenField ID="hdnPCchkAllFinalList" runat="server" />
        </div>
        <asp:Table ID="masterGrpTab" CssClass="dataheaderInvCtrl w-100p gridView" runat="server" CellPadding="2"
            CellSpacing="0" BorderWidth="1px" meta:resourcekey="masterGrpTabResource1">
        </asp:Table>
        <table class="w-100p" runat="server" id="btnTab">
            <tr id="Inv" runat="server" class="a-center">
                <td>
                    <asp:Button ID="btnSave" ToolTip="Click here to Save Details" Style="cursor: pointer;"
                        runat="server" Text="Save" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClick="btnSave_Click" OnClientClick="javascript:return updatedList();" meta:resourcekey="btnSaveResource1" />
                    <asp:Button ID="btnPrevious" ToolTip="Click here to move Previous" Style="cursor: pointer;"
                        runat="server" Text="Previous" class="btn" onmouseout="this.className='btn'"
                        onmouseover="this.className='btn btnhov'" OnClick="btnPrevious_Click" OnClientClick="javascript:if(! PreviousupdatedList(this))return false;"
                        meta:resourcekey="btnPreviousResource1" />&nbsp;
                    <asp:Button ID="btnNext" ToolTip="Click here to move Next" Style="cursor: pointer;"
                        runat="server" Text="Next" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClick="btnNext_Click" OnClientClick="javascript:if(! NextupdatedList(this))return false;"
                        meta:resourcekey="btnNextResource1" />&nbsp;
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" ToolTip="Click here to Cancel, View Home Page"
                        Style="cursor: pointer;" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                </td>
            </tr>
            <tr id="Grp" class="a-center">
                <td>
                    <asp:Button ID="btnGrpSave" ToolTip="Click here to Save Details" Style="cursor: pointer;"
                        runat="server" Text="Save" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClientClick="javascript:return updatedGrpList();" OnClick="btnGrpSave_Click"
                        meta:resourcekey="btnGrpSaveResource1" />
                    <asp:Button ID="btnGrpPrevious" ToolTip="Click here to move Previous" Style="cursor: pointer;"
                        runat="server" Text="Previous" class="btn" onmouseout="this.className='btn'"
                        onmouseover="this.className='btn btnhov'" OnClick="btnGrpPrevious_Click" meta:resourcekey="btnGrpPreviousResource1" />
                    &nbsp;
                    <asp:Button ID="btnGrpNext" ToolTip="Click here to move Next" Style="cursor: pointer;"
                        runat="server" Text="Next" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClick="btnGrpNext_Click" meta:resourcekey="btnGrpNextResource1" />&nbsp;
                    <asp:Button ID="btnGrpCancel" runat="server" Text="Cancel" ToolTip="Click here to Cancel, View Home Page"
                        Style="cursor: pointer;" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClick="btnGrpCancel_Click" meta:resourcekey="btnGrpCancelResource1" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
