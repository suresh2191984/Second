<%@ Control Language="C#" AutoEventWireup="true" CodeFile="History.ascx.cs" Inherits="EMR_History" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="ucAdv5" %>
<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<%@ Register Src="EMRAdvice.ascx" TagName="EMRAdvice" TagPrefix="uc1" %>

<script language="javascript" type="text/javascript">
    function onCalendarShown() {
      //  debugger;
        var cal = $find("tcEMR_tpHistory_ucHistory_CalendarExtender2");
        //Setting the default mode to year
        cal._switchMode("years", true);
        //Iterate every year Item and attach click event to it
        if (cal._yearsBody) {
            for (var i = 0; i < cal._yearsBody.rows.length; i++) {
                var row = cal._yearsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }
    }



    function onCalendarHidden() {
        var cal = $find("tcEMR_tpHistory_ucHistory_CalendarExtender2");
        //Iterate every month Item and remove click event from it
        if (cal._yearsBody) {
            for (var i = 0; i < cal._yearsBody.rows.length; i++) {
                var row = cal._yearsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }
    }


    function call(eventElement) {
        var target = eventElement.target;
        switch (target.mode) {
            case "year":
                var cal = $find("tcEMR_tpHistory_ucHistory_CalendarExtender2");
                cal._visibleDate = target.date;
                cal.set_selectedDate(target.date);
                cal._switchMonth(target.date);
                cal._blur.post(true);
                cal.raiseDateSelectionChanged();
                break;
        }
    }


    function GetText(pName) {
        if (pName != "") {
            var StringSplit = pName.split('~');
            if ("1" in StringSplit) {
                document.getElementById('<%=txtAllergyName.ClientID %>').value = StringSplit[0];
                document.getElementById("tcEMR_tpHistory_ucHistory_hdnHistoryID").value = StringSplit[1];
                WebService.GetAllergyHistory(StringSplit[1], OnLookupComplete);
            }
            else {
                document.getElementById('<%=txtAllergyName.ClientID %>').value = '';
                document.getElementById('<%=txtAllergyName.ClientID %>').focus();
                alert('Select Allergy name from the list');
            }
        }
    }
    function SelectedHistory(source, eventArgs) {
        var HistoryDetail = "";
        var isPatientDetails = "";
        HistoryDetail = eventArgs.get_value();
        document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergyValue').value = HistoryDetail.replace('^', '');
        var StringSplit = HistoryDetail.split('~');
        if ("1" in StringSplit) {
            document.getElementById('<%=txtAllergyName.ClientID %>').value = StringSplit[0];
            document.getElementById("tcEMR_tpHistory_ucHistory_hdnHistoryID").value = StringSplit[1];
            WebService.GetAllergyHistoryDet(StringSplit[1], OnLookupComplete);
        }
        else {
            document.getElementById('<%=txtAllergyName.ClientID %>').value = '';
            document.getElementById('<%=txtAllergyName.ClientID %>').focus();
            alert('Select Allergy name from the list');
        }
    }
    function OnLookupComplete(result) {
            var ddlAllDur = document.getElementById("tcEMR_tpHistory_ucHistory_ddlAllDuration");
            var hdnSel= document.getElementById("tcEMR_tpHistory_ucHistory_hdnSHistory");
            ddlAllDur.innerHTML = "";
            var option = document.createElement("option");
            option.value = 0;
            option.innerHTML = "-----Select-----";
            ddlAllDur.appendChild(option);
            var hid = document.getElementById("tcEMR_tpHistory_ucHistory_hdnHistoryID").value;
            hdnSel.value = hid + '~';
            for (var n = 0; n < result.length; n++) {
                var optionNew = document.createElement("option");
                if (result[n].AttributeName == "Duration") {
                    optionNew.value = result[n].AttributeID +'~' + result[n].AttributevalueID;
                    optionNew.innerHTML = result[n].AttributeValueName;
                    ddlAllDur.appendChild(optionNew);
                    hdnSel.value += '*';
                }
                else {
                    hdnSel.value +=  result[n].AttributeID +'~'+ result[n].AttributeValueName + '~' + result[n].AttributevalueID + '!';
                }
            }
        }
        function onClickAddAller() {
        if (document.getElementById('tcEMR_tpHistory_ucHistory_txtAllergyName').value == "" && document.getElementById('tcEMR_tpHistory_ucHistory_txtAllergyName').value != "Type the name and then add") {
            alert('Provide the Allergy name');
            document.getElementById('tcEMR_tpHistory_ucHistory_txtAllergyName').focus();
            return false;
        }
        else {
            var hdVal = document.getElementById('tcEMR_tpHistory_ucHistory_hdnSHistory').value;
            var ddlAll = document.getElementById("tcEMR_tpHistory_ucHistory_ddlAllDuration");
            if (ddlAll.selectedIndex < 1) {
                alert('Select the Duration');
                return false;
            }
            if(document.getElementById('tcEMR_tpHistory_ucHistory_txtAllDuration').value == "")
            {
                alert('Enter the Duration period');
                return false;
            }
            var ddlS = ddlAll.options[ddlAll.selectedIndex].value;
            var ddlT = ddlAll.options[ddlAll.selectedIndex].text;
            var ddlSAID = ddlS.split('~');
            if (ddlSAID[1] > 0) {
                var strDur = ddlSAID[0] + '~' + document.getElementById('tcEMR_tpHistory_ucHistory_txtAllDuration').value + ' '
                + ddlT + '~' + ddlSAID[1] + '!';
                hdVal = hdVal.replace("****", strDur);
            }
            
            var txRec=document.getElementById('tcEMR_tpHistory_ucHistory_txtAllReaction').value;
            hdVal = hdVal.replace("Reactions", txRec);
            var chkGo = document.getElementById('tcEMR_tpHistory_ucHistory_chkOnGoing');
            if (chkGo.checked) {
                hdVal = hdVal.replace("Ongoing", "Continue");
            }
            else {
                hdVal = hdVal.replace("Ongoing", "No");
            }
            var chkTr = document.getElementById('tcEMR_tpHistory_ucHistory_chkTreatment');
            if (chkTr.checked) {
                hdVal = hdVal.replace("Treatment", "Continue");
            }
            else {
                hdVal = hdVal.replace("Treatment", "No");
            }
            var strHVal = hdVal;
            strHVal = strHVal.substr(0, strHVal.length - 1)+ '^';
            hdVal = strHVal;
            document.getElementById('tcEMR_tpHistory_ucHistory_hdnSHistory').value = hdVal;
            fnCreateAllTab();
        }
    }
    function fnCreateAllTab() {
        var SVal;
        var SList;
        var SAID;
        var SAName;
        var SAVID;
        var SRE;
        var SONAME;
        var STNAME;
        var SDU;
        var SDY;
        var SALL;
        var SADU;
        var SARE;
        var SAO;
        var SAT;
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnSHistory').value != '') {
            SVal = document.getElementById('tcEMR_tpHistory_ucHistory_hdnSHistory').value;
            SList = SVal.split('!');
            SALL = SList[0].split('~');
            SARE = SList[2].split('~');
            SAO = SList[3].split('~');
            SAT = SList[4].split('~');
            SADU = SList[1].split('~');
            SAName = SALL[2];
            SAVID = SALL[3];
            SDU = SADU[1];
            SRE = SARE[1];
            SONAME = SAO[1];
            STNAME = SAT[1];
            var SDY1 = SADU[2].split('^');
            var ddlAll = document.getElementById("tcEMR_tpHistory_ucHistory_ddlAllDuration");
            var ddlS = ddlAll.options[ddlAll.selectedIndex].text;
            SDY = ddlS;
            
        }
        var rwNumber = parseInt(1);
        var AddStatus = 0;
        var HidValue = document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value;
        var list = HidValue.split('^');
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value != "") {
            for (var count = 0; count < list.length - 1; count++) {
                var AllList = list[count].split('!');
                var AllSVID = AllList[0].split('~');
                var AllVID = AllSVID[4];
                var AllName = AllSVID[3];
                if (AllName != '') {
                    if (AllVID != '') {
                        rwNumber = parseInt(parseInt(AllVID) + parseInt(1));
                    }
                    if (SAName != '') {
                        if (AllVID == SAVID) {
                            AddStatus = 1;
                        }
                    }
                }
            }
        }
        else {
            if (SAVID != '') {
                if (document.getElementById('tblAllergyItems').rows.length < 1) {
                    var row = document.getElementById('tblAllergyItems').insertRow(0);
                    row.id = 0;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);

                    cell1.innerHTML = "<b>Delete</b>";
                    cell1.width = "6%";
                    cell2.innerHTML = "<b>Allergy Name</b>";
                    cell3.innerHTML = "<b>Duration</b>";
                    cell4.innerHTML = "<b>Reaction</b>";
                    cell5.innerHTML = "<b>On-going</b>";
                    cell6.innerHTML = "<b>Treatment</b>";
                }
                var row = document.getElementById('tblAllergyItems').insertRow(1);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAll(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = SAName;
                cell3.innerHTML = SDU; 
                cell4.innerHTML =SRE;
                cell5.innerHTML = SONAME;
                cell6.innerHTML = STNAME;
                document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value += rwNumber +'~'+ document.getElementById('tcEMR_tpHistory_ucHistory_hdnSHistory').value;
                document.getElementById('tcEMR_tpHistory_ucHistory_trAllergy').style.display = "block";
                AddStatus = 2;
            }
        }
        if (AddStatus == 0) {
            if (SAVID != '') {
                if (document.getElementById('tblAllergyItems').rows.length < 1) {
                    var row = document.getElementById('tblAllergyItems').insertRow(0);
                    row.id = 0;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);

                    cell1.innerHTML = "<b>Delete</b>";
                    cell1.width = "6%";
                    cell2.innerHTML = "<b>Allergy Name</b>";
                    cell3.innerHTML = "<b>Duration</b>";
                    cell4.innerHTML = "<b>Reaction</b>";
                    cell5.innerHTML = "<b>On-going</b>";
                    cell6.innerHTML = "<b>Treatment</b>";
                }
                var row = document.getElementById('tblAllergyItems').insertRow(1);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAll(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = SAName;
                cell3.innerHTML = SDU; 
                cell4.innerHTML = SRE;
                cell5.innerHTML = SONAME;
                cell6.innerHTML = STNAME;
                document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value +=rwNumber +'~'+ document.getElementById('tcEMR_tpHistory_ucHistory_hdnSHistory').value;
                document.getElementById('tcEMR_tpHistory_ucHistory_trAllergy').style.display = "block";
            }
        }
        else if (AddStatus == 1) {
            alert("This Item Already Added!");
        }
        
        document.getElementById('tcEMR_tpHistory_ucHistory_txtAllergyName').value = "";
        document.getElementById('tcEMR_tpHistory_ucHistory_hdnSHistory').value = "";
        document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergyValue').value = "";
        return false;
    }
    function fnLoadTab() {
        var HidValue = document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value;
        var list = HidValue.split('^');
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value != "") {
            for (var count = 0; count < list.length - 1; count++) {
                var AllList = list[count].split('!');
                var AllHIS = AllList[0].split('~');
                var AllRE = AllList[2].split('~');
                var AllON = AllList[3].split('~');
                var AllTR = AllList[4].split('~');
                var AllDU = AllList[1].split('~');
                var AllName = AllHIS[3];
                var AllVID = AllHIS[4];
                var AllSDU = AllDU[1];
                var AllSRE = AllRE[1];
                var AllSON = AllON[1];
                var AllST = AllTR[1];
                if (AllList[1] != '') {
                    if (AllList[0] != '') {
                        rwNumber = parseInt(parseInt(AllVID) + parseInt(1));
                    }
                }
                if (document.getElementById('tblAllergyItems').rows.length < 1) {
                    var row = document.getElementById('tblAllergyItems').insertRow(0);
                    row.id = 0;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);

                    cell1.innerHTML = "<b>Delete</b>";
                    cell1.width = "6%";
                    cell2.innerHTML = "<b>Allergy Name</b>";
                    cell3.innerHTML = "<b>Duration</b>";
                    cell4.innerHTML = "<b>Reaction</b>";
                    cell5.innerHTML = "<b>On-going</b>";
                    cell6.innerHTML = "<b>Treatment</b>";
                }
                var row = document.getElementById('tblAllergyItems').insertRow(1);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAll(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = AllName;
                cell3.innerHTML = AllSDU;
                cell4.innerHTML = AllSRE;
                cell5.innerHTML = AllSON;
                cell6.innerHTML = AllST;
                
                document.getElementById('tcEMR_tpHistory_ucHistory_trAllergy').style.display = "block";
            }
        }
    }

    function ImgOnclickAll(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value;
        var list = HidValue.split('^');
        var newALList = '';
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value != "") {
            for (var count = 0; count < list.length; count++) {
                var ALList = list[count].split('~');
                if (ALList[0] != '') {
                    if (ALList[0] != ImgID) {
                        newALList += list[count] + '^';
                    }
                }
            }
            document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value = newALList;
        }
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnAllergy').value == '') {
            document.getElementById('tcEMR_tpHistory_ucHistory_trAllergy').style.display = 'none';
        }
    }
</script>

<script language="javascript" type="text/javascript">
    function onClickAddSurgery() {
        var rwNumber = parseInt(110);
        var AddStatus = 0;
        var d = new Date();
       
        var txtSurgeryName = document.getElementById('tcEMR_tpHistory_ucHistory_txtsurgeryName').value.trim();
        var txtDate = document.getElementById('tcEMR_tpHistory_ucHistory_txtDate').value.trim();
        var txtHospital = document.getElementById('tcEMR_tpHistory_ucHistory_txtHospital').value;
        document.getElementById('tcEMR_tpHistory_ucHistory_tblSurgeryItems').style.display = 'block';
        var HidValue = document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value;
        var list = HidValue.split('^');
        d = new Date("01/01" + "/" + txtDate);
        d.getFullYear();
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value != "") {
            for (var count = 0; count < list.length; count++) {
                var HistoryList = list[count].split('~');
                if (HistoryList[1] != '') {
                    if (HistoryList[0] != '') {
                        rwNumber = parseInt(parseInt(HistoryList[0]) + parseInt(1));
                    }
                    if (txtSurgeryName != '') {
                        if (HistoryList[1] == txtSurgeryName) {

                            AddStatus = 1;
                        }
                    }
                }
            }
        }
        else {

            if (txtSurgeryName != '') {
                var row = document.getElementById('tcEMR_tpHistory_ucHistory_tblSurgeryItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSurgery(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = txtSurgeryName;
                cell3.innerHTML = txtDate;
               // cell3.innerHTML = d.getFullYear();
                cell4.innerHTML = txtHospital;
                document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value += parseInt(rwNumber) + "~" + txtSurgeryName + "~" + txtDate + "~" + txtHospital + "^";
                AddStatus = 2;
            }
        }
        if (AddStatus == 0) {
            if (txtSurgeryName != '') {
                var row = document.getElementById('tcEMR_tpHistory_ucHistory_tblSurgeryItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSurgery(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = txtSurgeryName;
                cell3.innerHTML = txtDate;
                //cell3.innerHTML = d.getFullYear();
                cell4.innerHTML = txtHospital;
                document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value += parseInt(rwNumber) + "~" + txtSurgeryName + "~" + txtDate  + "~" + txtHospital + "^";
            }
        }
        else if (AddStatus == 1) {
            alert("Surgery Already Added!");
        }
        document.getElementById('tcEMR_tpHistory_ucHistory_txtsurgeryName').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_txtDate').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_txtHospital').value = '';
        return false;
    }

    function ExacerClick() {
        var obj = document.getElementById('tcEMR_tpHistory_ucHistory_chkExacerbations_18');
        document.getElementById('tcEMR_tpHistory_ucHistory_tdExacer').style.display = "none";
        document.getElementById('tcEMR_tpHistory_ucHistory_tdExacerEMR').style.display = "none";
        if (obj.checked) {
            document.getElementById('tcEMR_tpHistory_ucHistory_tdExacer').style.display = "block";
            document.getElementById('tcEMR_tpHistory_ucHistory_tdExacerEMR').style.display = "block";
        }
    }
    function ddlFHODMChange(id) {
        var e = document.getElementById("tcEMR_tpHistory_ucHistory_ddlFHODM_1083");
        var strID = e.options[e.selectedIndex].text;
        if (strID == "Present" || strID == "Insignificant") {
            document.getElementById('tcEMR_tpHistory_ucHistory_txtFHODM_1083').style.display = "block";
            document.getElementById('tcEMR_tpHistory_ucHistory_txtFHODM_1083').focus();

        }
        else {
            document.getElementById('tcEMR_tpHistory_ucHistory_txtFHODM_1083').value = '';
            document.getElementById('tcEMR_tpHistory_ucHistory_txtFHODM_1083').style.display = "none";
        }
    }
    function ControlValidation() {
        var retval = EMRvalidation();
        if (retval != false) {
            CmdAdd_onclick(retval);
        }
    }
    function CmdAddNew_onclick() {

        CreateTab();
        document.getElementById('tcEMR_tpHistory_ucHistory_txtDisorder_41').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_txtRelation_41').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_txtEvent_41').value = '';
    }
    function CreateTab() {
        var tmpTable;
        var dis = document.getElementById('tcEMR_tpHistory_ucHistory_txtDisorder_41').value.trim();
        var rel = document.getElementById('tcEMR_tpHistory_ucHistory_txtRelation_41').value.trim();
        var eve = document.getElementById('tcEMR_tpHistory_ucHistory_txtEvent_41').value.trim();
        var itemlist = new Array();
        var item = new Array();
        var rownumber = 1;
        var rowno = 0;
        var rs = 1;
        itemlist = document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value.split('^');
        rowno = itemlist.length;
        if (itemlist.length > 1) {
            document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value = '';
            for (var i = 0; i < itemlist.length - 1; i++) {
                rs = parseInt(rs++);
                document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value += itemlist[i] + '^';
            }
        }
        if (dis != '' || rel != '' || eve != '') {
            document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value += rowno + '~' + rel + '~' + dis + '~' + eve + '^';
        }

        itemlist = document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value.split('^');
        var hdnDis = document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value.trim();
        tmpTable = "<table CELLSPACING=1px width=50%  CELLSPACING=0 style = 'border: thin solid #817679;height:50'><tr><td colspan=2 align='center'><b>Family History</b></td></tr>";
        tmpTable += "<tr><td colspan=2><table width=100%  style = 'border:1;border-color:#ffffff;'><tr><td></td><td colspan=1 align='center'><b>Relationship</b></td><td align='center'><b>Disorder</b></td><td align='center'><b>Event</b></td></tr><tr><td>";

        for (var i = 0; i < itemlist.length - 1; i++) {
            var item = itemlist[i].split('~');
            tmpTable += "<tr><td><img id='imgbtn2'  style='cursor:pointer;' OnClick='ImgClick(" + rownumber + ");'";
            tmpTable += " src='../Images/Delete.jpg' /></td><td style='display: none;'>";
            tmpTable += parseInt(rownumber) + "</td><td>" + item[1] + "</td><td>" + item[2] + "</td><td>" + item[3] + "</td></tr>";
            rownumber++;
        }
        tmpTable += "</table></td></tr></table>";
        document.getElementById('tcEMR_tpHistory_ucHistory_divchkFamilyHistory_1085').style.display = "block";
        document.getElementById('tcEMR_tpHistory_ucHistory_divchkFamilyHistory_1085').style.height = "auto";
        var obj = document.getElementById('tcEMR_tpHistory_ucHistory_divTable');
        obj.style.display = "block";
        obj.innerHTML = tmpTable;
    }

    function ImgClick(sEditedData) {
        var i;
        var y = '';
        var x = document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value.split("^");
        document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value = '';
        for (i = 0; i < x.length - 1; i++) {
            y = x[i].split("~");
            if (y[0] != sEditedData) {
                document.getElementById('tcEMR_tpHistory_ucHistory_hdnFamilyHistory').value += x[i] + "^";
            }
        }
        CreateTab();
    }

    function ImgOnclickSurgery(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value;
        var list = HidValue.split('^');
        var newHistoryList = '';
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value != "") {
            for (var count = 0; count < list.length; count++) {
                var HistoryList = list[count].split('~');
                if (HistoryList[0] != '') {
                    if (HistoryList[0] != ImgID) {
                        newHistoryList += list[count] + '^';
                    }
                }
            }
            document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value = newHistoryList;
        }
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value == '') {
            document.getElementById('tcEMR_tpHistory_ucHistory_tblSurgeryItems').style.display = 'none';
        }
    }


    function LoadSurgeryItems() {
        var HidValue = document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value;
        var list = HidValue.split('^');
        if (document.getElementById('tcEMR_tpHistory_ucHistory_hdnSurgeryItems').value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var HistoryList = list[count].split('~');
                var row = document.getElementById('tcEMR_tpHistory_ucHistory_tblSurgeryItems').insertRow(0);
                row.id = HistoryList[0];
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
               // cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickHistory(" + parseInt(HistoryList[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickSurgery(" + parseInt(HistoryList[0]) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = HistoryList[1];
                cell3.innerHTML = HistoryList[2] == "1999" ? "-" : HistoryList[2];
                cell4.innerHTML = HistoryList[3] == "" ? "-" : HistoryList[3];
            }
        }
    }


    // Prior Vaccinations

    function LoadPriorVaccinationsItems() {
        var HidVaccinationsValue = document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value;
        var PriorList = HidVaccinationsValue.split('^');
        if (document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value != "") {

            for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                var PriVacList = PriorList[pvCount].split('~');

                var rowV = document.getElementById('tcEMR_tpHistory_ucHistory_tblPriorVaccinations').insertRow(1);
                var icoutV = document.getElementById('tcEMR_tpHistory_ucHistory_tblPriorVaccinations').rows.length;
                rowV.id = icoutV;

                rowV.id = PriVacList[0];
                var cell1 = rowV.insertCell(0);
                var cell2 = rowV.insertCell(1);
                var cell3 = rowV.insertCell(2);
                var cell4 = rowV.insertCell(3);
                var cell5 = rowV.insertCell(4);
                var cell6 = rowV.insertCell(5);
                var cell7 = rowV.insertCell(6);
                cell1.innerHTML = "<img id='imgbtnLPV' style='cursor:pointer;' OnClick='PriorDeleteclick(" + PriVacList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = PriVacList[1];
                cell3.innerHTML = PriVacList[2];
                cell4.innerHTML = PriVacList[3];
                cell5.innerHTML = PriVacList[4];
                cell6.innerHTML = PriVacList[5];
                document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').value = PriVacList[6];
                var reaction = '';  //document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').options[document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex].text;
                document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex = 0;
                cell7.innerHTML = reaction;
                cell6.style.display = "none";
            }
        }
        return false;
    }


    function PriorVaccinationsItems() {
        var VaccinationStatus = 0;
        var HidVaccinationValue = document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value;
        var Vacclist = HidVaccinationValue.split('^');
        var ddlVaccination = document.getElementById('tcEMR_tpHistory_ucHistory_drpVaccination').options[document.getElementById('tcEMR_tpHistory_ucHistory_drpVaccination').selectedIndex].text;
        var ddlVaccinationid = document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').value;
        var ddlReaction = document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').options[document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex].text;
        var Year = document.getElementById('tcEMR_tpHistory_ucHistory_txtYear').value;
        if (document.getElementById('tcEMR_tpHistory_ucHistory_drpMonth').options[document.getElementById('tcEMR_tpHistory_ucHistory_drpMonth').selectedIndex].text != "---Select---") {

            var ddlMonth = document.getElementById('tcEMR_tpHistory_ucHistory_drpMonth').options[document.getElementById('tcEMR_tpHistory_ucHistory_drpMonth').selectedIndex].text;
        }
        else {
            var ddlMonth = "";
        }

        var Doses = document.getElementById('tcEMR_tpHistory_ucHistory_txtDoses').value;
        if (document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').options[document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex].text != "---Select---") {
            var Booster = document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').options[document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex].text;
        }
        else {
            var Booster = "";
        }
        var vrow = document.getElementById('tcEMR_tpHistory_ucHistory_tblPriorVaccinations').insertRow(1);
        var vrCount = document.getElementById('tcEMR_tpHistory_ucHistory_tblPriorVaccinations').rows.length;
        vrow.id = vrCount;
        var cell1 = vrow.insertCell(0);
        var cell2 = vrow.insertCell(1);
        var cell3 = vrow.insertCell(2);
        var cell4 = vrow.insertCell(3);
        var cell5 = vrow.insertCell(4);
        var cell6 = vrow.insertCell(5);
        var cell7 = vrow.insertCell(6);
        cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
        cell1.width = "5%";
        cell2.innerHTML = ddlVaccination;
        cell3.innerHTML = Year;
        cell4.innerHTML = ddlMonth;
        cell5.innerHTML = Doses;
        cell6.innerHTML = Booster;
        cell7.innerHTML = ddlVaccinationid;
        cell7.style.display = "none";
        document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
        document.getElementById('tcEMR_tpHistory_ucHistory_drpVaccination').selectedIndex = 0;
        document.getElementById('tcEMR_tpHistory_ucHistory_txtYear').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_drpMonth').selectedIndex = 0;
        document.getElementById('tcEMR_tpHistory_ucHistory_txtDoses').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').checked = false;
        document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex = 0;
        VaccinationStatus = 0;
        return false;
        if (VaccinationStatus == 0) {

            var vrowv = document.getElementById('tcEMR_tpHistory_ucHistory_tblPriorVaccinations').insertRow(1);
            var vrCount = document.getElementById('tcEMR_tpHistory_ucHistory_tblPriorVaccinations').rows.length;
            vrowv.id = vrCount;
            var cell1 = vrowv.insertCell(0);
            var cell2 = vrowv.insertCell(1);
            var cell3 = vrowv.insertCell(2);
            var cell4 = vrowv.insertCell(3);
            var cell5 = vrowv.insertCell(4);
            var cell6 = vrowv.insertCell(5);
            var cell7 = vrowv.insertCell(6);
            var cell8 = vrowv.insertCell(7);
            cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = ddlVaccination;
            cell3.innerHTML = Year;
            cell4.innerHTML = ddlMonth;
            cell5.innerHTML = Doses;
            cell6.innerHTML = Booster;
            cell7.innerHTML = ddlVaccinationid;
            cell7.style.display = "none";
            document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
            document.getElementById('tcEMR_tpHistory_ucHistory_drpVaccination').selectedIndex = 0;
            document.getElementById('tcEMR_tpHistory_ucHistory_txtYear').value = '';
            document.getElementById('tcEMR_tpHistory_ucHistory_drpMonth').selectedIndex = 0;
            document.getElementById('tcEMR_tpHistory_ucHistory_txtDoses').value = '';
            document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').checked = false;
            document.getElementById('tcEMR_tpHistory_ucHistory_ddlAnaphylacticReaction').selectedIndex = 0;
            VaccinationStatus = 0;
            return false;
        }
    }

    function PriorDeleteclick(PriorDelItem) {
        document.getElementById(PriorDelItem).style.display = "none";
        var HidVacValue = document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value;
        var pVlist = HidVacValue.split('^');
        var newVaccList = '';
        if (document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value != "") {
            for (var pvCountV = 0; pvCountV < pVlist.length; pvCountV++) {
                var priorListV = pVlist[pvCountV].split('~');
                if (priorListV[0] != '') {
                    if (priorListV[0] != PriorDelItem) {
                        newVaccList += pVlist[pvCountV] + "^";
                    }
                }
            }
            document.getElementById('tcEMR_tpHistory_ucHistory_HdnVaccination').value = newVaccList;
        }
    }


    // BaseLine Histroy ....

    function LoadBaseLineHistroyItems() {
        var HidLoadValue = document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value;
        var list = HidLoadValue.split('^');
        if (document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value != "") {
            for (var count = 0; count < list.length - 1; count++) {
                var BaselineList = list[count].split('~');

                var row = document.getElementById('tcEMR_tpHistory_ucHistory_tblBaseLine').insertRow(1);
                var icout = document.getElementById('tcEMR_tpHistory_ucHistory_tblBaseLine').rows.length;
                row.id = icout;

                row.id = BaselineList[0];
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
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + BaselineList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = BaselineList[1];
                cell3.innerHTML = BaselineList[2];
                cell4.innerHTML = BaselineList[3];
                cell5.innerHTML = BaselineList[4];
                cell6.innerHTML = BaselineList[5];
                cell7.innerHTML = BaselineList[6];
                cell8.innerHTML = BaselineList[7];
                cell9.innerHTML = BaselineList[8];
                cell10.innerHTML = BaselineList[9];
                cell7.style.display = "none";
                cell9.style.display = "none";
                cell10.style.display = "none";
            }
        }
        return false;
    }

    function BaseLineItems() {
        var BaseLineStatus = 0;
        var HidAddValue = document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value;
        var ddlName = document.getElementById('tcEMR_tpHistory_ucHistory_drdSOC').options[document.getElementById('tcEMR_tpHistory_ucHistory_drdSOC').selectedIndex].text;
        var age = document.getElementById('tcEMR_tpHistory_ucHistory_txtAge').value;
        var ddlDeliveryName = document.getElementById('tcEMR_tpHistory_ucHistory_drpMOD').options[document.getElementById('tcEMR_tpHistory_ucHistory_drpMOD').selectedIndex].text;
        var ddlDeliveryNameID = document.getElementById('tcEMR_tpHistory_ucHistory_drpMOD').value;
        var weight = document.getElementById('tcEMR_tpHistory_ucHistory_txtBwt').value;
        var ddlBMaturity = document.getElementById('tcEMR_tpHistory_ucHistory_drpBMaturity').options[document.getElementById('tcEMR_tpHistory_ucHistory_drpBMaturity').selectedIndex].text;
        var ddlBMaturityID = document.getElementById('tcEMR_tpHistory_ucHistory_drpBMaturity').value;
        var gnormal;

        if (document.getElementById('tcEMR_tpHistory_ucHistory_chkIsGrowth').checked == true) {

            gnormal = 'Abnormal';
        }
        else { gnormal = 'Normal'; }
        var grate = 0;
        var row = document.getElementById('tcEMR_tpHistory_ucHistory_tblBaseLine').insertRow(1);
        var icout = document.getElementById('tcEMR_tpHistory_ucHistory_tblBaseLine').rows.length;
        row.id = icout;
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
        cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
        cell1.width = "5%";
        cell2.innerHTML = ddlName;
        cell3.innerHTML = age;
        cell4.innerHTML = ddlDeliveryName;
        cell5.innerHTML = weight;
        cell6.innerHTML = gnormal;
        cell7.innerHTML = grate;
        cell8.innerHTML = ddlBMaturity;
        cell9.innerHTML = ddlDeliveryNameID;
        cell10.innerHTML = ddlBMaturityID;
        cell7.style.display = "none";
        cell9.style.display = "none";
        cell10.style.display = "none";
        document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
        document.getElementById('tcEMR_tpHistory_ucHistory_drdSOC').selectedIndex = 0;
        document.getElementById('tcEMR_tpHistory_ucHistory_txtAge').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_drpMOD').selectedIndex = 0;
        document.getElementById('tcEMR_tpHistory_ucHistory_txtBwt').value = '';
        document.getElementById('tcEMR_tpHistory_ucHistory_drpBMaturity').selectedIndex = 0;
        document.getElementById('tcEMR_tpHistory_ucHistory_chkIsGrowth').checked = false;
        BaseLineStatus = 0;
        return false;
        if (BaseLineStatus == 0) {

            var row = document.getElementById('tcEMR_tpHistory_ucHistory_tblBaseLine').insertRow(1);
            var icout = document.getElementById('tcEMR_tpHistory_ucHistory_tblBaseLine').rows.length;
            row.id = icout;
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
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = ddlName;
            cell3.innerHTML = age;
            cell4.innerHTML = ddlDeliveryName;
            cell5.innerHTML = weight;
            cell6.innerHTML = gnormal;
            cell7.innerHTML = grate;
            cell8.innerHTML = ddlBMaturity;
            cell9.innerHTML = ddlDeliveryNameID;
            cell10.innerHTML = ddlBMaturityID;
            cell7.style.display = "none";
            cell9.style.display = "none";
            cell10.style.display = "none";
            document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
            document.getElementById('tcEMR_tpHistory_ucHistory_drdSOC').selectedIndex = 0;
            document.getElementById('tcEMR_tpHistory_ucHistory_txtAge').value = '';
            document.getElementById('tcEMR_tpHistory_ucHistory_drpMOD').selectedIndex = 0;
            document.getElementById('tcEMR_tpHistory_ucHistory_txtBwt').value = '';
            document.getElementById('tcEMR_tpHistory_ucHistory_drpBMaturity').selectedIndex = 0;
            document.getElementById('tcEMR_tpHistory_ucHistory_chkIsGrowth').checked = false;
            return false;
        }
    }
    function setCursorByID(id, cursorStyle) {
        var elem;
        if (document.getElementById &&
    (elem = document.getElementById(id))) {
            if (elem.style) elem.style.cursor = cursorStyle;
        }
    }


    function ImgDeleteclick(ImgDeleteID) {
        document.getElementById(ImgDeleteID).style.display = "none";
        var HidDeleteValue = document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value;
        var list = HidDeleteValue.split('^');
        var newList = '';
        if (document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value != "") {
            for (var count = 0; count < list.length; count++) {
                var BaseList = list[count].split('~');
                if (BaseList[0] != '') {
                    if (BaseList[0] != ImgDeleteID) {
                        newList += list[count] + "^";
                    }
                }
            }
            document.getElementById('tcEMR_tpHistory_ucHistory_HidBaseLine').value = newList;
        }
    }

    //Only numbers will allowed
    function isNumeric(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 0) {
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
    //only text allowed
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

        if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }

        return isCtrl;
    }

    
</script>

<div id="divRef1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divRef1','tcEMR_tpHistory_ucHistory_divRef2','divRef3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Rs_ReferringPhysician" Text="Medical History" Font-Bold="True" runat="server" />
</div>
<div id="divRef2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divRef1','tcEMR_tpHistory_ucHistory_divRef2','divRef3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Rs_ReferringPhysician1" Text="Medical History" Font-Bold="True" runat="server" />
</div>
<div id="divRef3" style="display: none; width: 100%" title="Medical History">
    <table border="1" cellpadding="0" cellspacing="0" width="98%" class="dataheaderInvCtrl">
        <tr class="defaultfontcolor">
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center"
                colspan="2">
                <asp:Label ID="Label1" runat="server" Text="MEDICAL HISTORY" meta:resourcekey="Label1Resource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td valign="middle" style="width: 20%">
                <asp:Label ID="Label4" runat="server" Text="Present Complaints"></asp:Label>&nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtPresentComplaints" TextMode="MultiLine" Height="68px" Width="221px"
                    runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkDiabetesMellitus_389" runat="server" Text="Diabetes Mellitus"
                                onclick="javascript:showContentHis(this.id);" meta:resourcekey="chkDiabetesMellitus_389Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkDiabetesMellitus_389" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblDuration_5" runat="server" Text="Duration" meta:resourcekey="lblDuration_5Resource1"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:Label ID="lblType_6" runat="server" Text="Type" meta:resourcekey="lblType_6Resource1"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:Label ID="lblTreatment_7" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_7Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:TextBox ID="txtDuration_5" runat="server" Width="50px" onKeyDown="return  isNumeric(event,this.id)" meta:resourcekey="txtDuration_5Resource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlDuration_5" runat="server" meta:resourcekey="ddlDuration_5Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 8%; display:none">
                                <uc8:EMR ID="EMR4" Visible="true" runat="server" />
                            </td>
                            <td style="width: 16%">
                                <asp:DropDownList ID="ddlType_6" runat="server" meta:resourcekey="ddlType_6Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 8%;display:none">
                                <uc8:EMR ID="EMR5" Visible="true" runat="server" />
                            </td>
                            <td style="width: 16%">
                                <asp:DropDownList ID="ddlTreatment_7" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                    meta:resourcekey="ddlTreatment_7Resource1">
                                </asp:DropDownList>
                                <div id="divddlTreatment_7" runat="server" style="display: none">
                                    <asp:TextBox ID="txtothers_68" runat="server"></asp:TextBox>
                                </div>
                            </td>
                            <td style="display:none;">
                                <uc8:EMR ID="EMR6" Visible="true" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label25" runat="server" Text="F/H/O DM"></asp:Label>
                                        </td>
                                        <td colspan="3">
                                            <asp:DropDownList ID="ddlFHODM_1083" onChange="ddlFHODMChange(this.id);" runat="server">
                                            </asp:DropDownList>
                                            &nbsp;
                                            <asp:TextBox ID="txtFHODM_1083" Style="display: none;" OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  runat="server"></asp:TextBox>
                                        </td>
                                        <td style="display:none;">
                                            <uc8:EMR ID="EMR36" Visible="true" runat="server" />
                                        </td>
                                    </tr>
                                    <%--H/O Hypoglycemia--%>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label26" runat="server" Text="H/O Hypoglycemia"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtHOHypoglycemia_1084" runat="server"></asp:TextBox>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR37" Visible="false" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--F/H/O DM --%>
        <tr id="trchkHighBloodPressure_402" runat="server" style="display: block;">
            <td colspan="2">
                <table cellpadding="0">
                    <tr class="defaultfontcolor">
                        <td>
                            <asp:CheckBox ID="chkHighBloodPressure_402" runat="server" Text="Systemic Hypertension"
                                onclick="javascript:showContentHis(this.id);" meta:resourcekey="chkHighBloodPressure_402Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkHighBloodPressure_402" runat="server" style="display: block;">
            <td colspan="2">
                <div id="divchkHighBloodPressure_402" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="lblDuration_1" runat="server" Text="Duration" meta:resourcekey="lblDuration_1Resource1"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:Label ID="lblTreatment_2" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_2Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtDuration_1" runat="server" Width="50px" onKeyDown="return  isNumeric(event,this.id)" meta:resourcekey="txtDuration_1Resource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlDurationt_1" runat="server" meta:resourcekey="ddlDurationt_1Resource1">
                                </asp:DropDownList>
                            </td>
                            <td colspan="3" style="display:none">
                                <uc8:EMR ID="EMR2" Visible="true" runat="server" />
                            </td>
                            <td colspan="3">
                                <asp:CheckBoxList ID="chkTreatment_2" runat="server" RepeatDirection="Horizontal"
                                    RepeatColumns="4" meta:resourcekey="chkTreatment_2Resource1">
                                </asp:CheckBoxList>
                                <asp:CheckBox ID="chkOthers_9" runat="server" Text="Others" onClick="javascript:showOthersChkBox(this.id);"
                                    meta:resourcekey="chkOthers_9Resource1" />
                                <div id="divchkOthers_9" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_9" runat="server" meta:resourcekey="txtOthers_9Resource1"></asp:TextBox>
                                </div>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR1" Visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--Liver Disease--%>
        <tr class="defaultfontcolor" id="trchkRaisedCholestrol_409" runat="server" style="display: block;">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkRaisedCholestrol_409" runat="server" Text="Dyslipidemia" onclick="javascript:showContentHis(this.id);"
                                meta:resourcekey="chkRaisedCholestrol_409Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkRaisedCholestrol_409" runat="server" style="display: block;">
            <td colspan="2">
                <div id="divchkRaisedCholestrol_409" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td>
                                <asp:Label ID="lblDuration_12" runat="server" Text="Duration" meta:resourcekey="lblDuration_12Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtduration_12" onKeyDown="return  isNumeric(event,this.id)" runat="server" Width="50px" meta:resourcekey="txtduration_12Resource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlduration_12" runat="server" meta:resourcekey="ddlduration_12Resource1">
                                    <asp:ListItem Text="Year(s)" Value="37" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Text="Month(s)" Value="38" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    <asp:ListItem Text="Week(s)" Value="39" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--Thyroid Disorder--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkThyroid_207" runat="server" Text="Thyroid Disorder" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkThyroid_207" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td>
                                <asp:Label ID="Label27" runat="server" Text="Duration"></asp:Label>
                            </td>
                            <td style="display: none;">
                            </td>
                            <td>
                                <asp:Label ID="Label20" runat="server" Text="Type"></asp:Label>
                            </td>
                            <td style="display: none;">
                            </td>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text="Treatment"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtDuration_40" onKeyDown="return  isNumeric(event,this.id)" runat="server" Width="50px"></asp:TextBox>
                                <asp:DropDownList ID="ddlDuration_40" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="display: none;">
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlThyroid_40" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td style="display: none;">
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlThyroidTreatment_40" runat="server" onchange="javascript:showOthersBoxHis(this.id);">
                                </asp:DropDownList>
                                <div id="divddlThyroidTreatment_40" runat="server" style="display: none">
                                    <asp:TextBox ID="txtThyroidTreatmentOther_40" runat="server"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--End Thyroid Disorder--%>
        <%--Asthma/COPD--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="3">
                            <asp:CheckBox ID="chkAsthma_246" runat="server" Text="Asthma/COPD" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkAsthma_246" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblDuration_16" runat="server" Text="Duration" meta:resourcekey="lblDuration_16Resource1"></asp:Label>
                            </td>
                            <td colspan="6">
                                <asp:Label ID="lblTreatment_17" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_17Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtDuration_16" runat="server" Width="50px" onKeyDown="return  isNumeric(event,this.id)" meta:resourcekey="txtDuration_16Resource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlDuration_16" runat="server" meta:resourcekey="ddlDuration_16Resource1">
                                </asp:DropDownList>
                            </td>
                            <td colspan="2" style="display:none">
                                <uc8:EMR ID="EMR31" Visible="true" runat="server" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTratment_17" runat="server" meta:resourcekey="ddlTratment_17Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR12" Visible="true" runat="server" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chkExacerbations_18" runat="server" onClick="ExacerClick();" Text="Exacerbations"
                                    meta:resourcekey="chkExacerbations_18Resource1" />
                            </td>
                            <td id="tdExacer" style="display: none;" runat="server">
                                <asp:Label ID="lblTimesper_18" runat="server" Text="Times per" meta:resourcekey="lblTimesper_18Resource1"></asp:Label>
                                <asp:TextBox ID="txtTimes_18" runat="server" meta:resourcekey="txtTimes_18Resource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlExacerbations_18" runat="server" meta:resourcekey="ddlExacerbations_18Resource1">
                                </asp:DropDownList>
                            </td>
                            <td id="tdExacerEMR" style="display: none;" runat="server">
                                <uc8:EMR ID="EMR13" Visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--End Asthma/COPD--%>
        <%--Tuberculosis--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkTuberculosis_946" runat="server" Text="Tuberculosis" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkTuberculosis_946" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="Label21" Visible="false" runat="server" Text="Type"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:TextBox ID="txtTuberculosis_946" runat="server" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--End Tuberculosis--%>
        <%--Heart Disease--%>
        <tr class="defaultfontcolor" id="trchkHeartDisease_332" runat="server" style="display: block;">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkHeartDisease_332" runat="server" Text="Heart Disease" onclick="javascript:showContentHis(this.id);"
                                meta:resourcekey="chkHeartDisease_332Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkHeartDisease_332" runat="server" style="display: block;">
            <td colspan="2">
                <div id="divchkHeartDisease_332" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblDiseaseType_3" runat="server" Text="Disease Type" meta:resourcekey="lblDiseaseType_3Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblDisease_4" runat="server" Text="Disease" meta:resourcekey="lblDisease_4Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%">
                                <asp:DropDownList ID="ddlDiseaseType_3" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                    meta:resourcekey="ddlDiseaseType_3Resource1">
                                </asp:DropDownList>
                                <div id="divddlDiseaseType_3" runat="server" style="display: none">
                                    <asp:TextBox ID="txtothers_16" runat="server" meta:resourcekey="txtothers_16Resource1"></asp:TextBox>
                                </div>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR3" Visible="true" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtDisease_17" runat="server"></asp:TextBox>
                                <div style="display:none">
                                <ajc:AutoCompleteExtender ID="AutoDescValue"  runat="server" TargetControlID="txtDisease_17"
                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--End Heart Disease--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="4">
                            <asp:CheckBox ID="chkStroke_438" runat="server" Text="Stroke" onclick="javascript:showContentHis(this.id);"
                                meta:resourcekey="chkStroke_438Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkStroke_438" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td>
                                <asp:Label ID="lblDate_8" runat="server" Text="Date" meta:resourcekey="lblDate_8Resource1"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:Label ID="lblRecovery_9" runat="server" Text="Recovery" meta:resourcekey="lblRecovery_9Resource1"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:Label ID="lblTypeOfCVA_10" runat="server" Text="TypeOfCVA" meta:resourcekey="lblTypeOfCVA_10Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblLobeaffected_11" runat="server" Text="Area/Lobe affected" meta:resourcekey="lblLobeaffected_11Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtDate_30" runat="server" ValidationGroup="MKE" meta:resourcekey="txtDate_30Resource1"></asp:TextBox>
                                <ajc:MaskedEditExtender ID="MaskedEditExtender4" runat="server" ErrorTooltipEnabled="True"
                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtDate_30" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton2"
                                    TargetControlID="txtDate_30" Enabled="True" />
                                <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    meta:resourcekey="ImageButton2Resource1" />
                                <ajc:MaskedEditValidator ID="MaskedEditValidator4" runat="server" ControlExtender="MaskedEditExtender4"
                                    ControlToValidate="txtDate_30" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator4" meta:resourcekey="MaskedEditValidator4Resource1" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlRecovery_9" runat="server" meta:resourcekey="ddlRecovery_9Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR7" Visible="true" runat="server" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTypeOfCVA_10" runat="server" meta:resourcekey="ddlTypeOfCVA_10Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR8" Visible="true" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtLobeaffected_36" runat="server" meta:resourcekey="txtLobeaffected_36Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--PVD--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkPVD_181" runat="server" Text="PVD" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkPVD_181" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="Label22" Visible="false" runat="server" Text="Type"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:TextBox ID="txtPVD_181" runat="server" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--End PVD--%>
        <%--Renal Disorder--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkRenal_32" runat="server" Text="Renal Disorder" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkRenal_32" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="Label23" Visible="false" runat="server" Text="Type"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:TextBox ID="txtRenal_32" runat="server" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--End Renal Disorder--%>
        <%--Liver Disease--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkLiver_78" runat="server" Text="Liver Disease" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkLiver_78" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="Label24" Visible="false" runat="server" Text="Type"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:TextBox ID="txtLiver_78" runat="server" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="3">
                            <asp:CheckBox ID="chkCancer_372" runat="server" Text="Cancer" onclick="javascript:showContentHis(this.id);"
                                meta:resourcekey="chkCancer_372Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkCancer_372" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblTypeofcancer_13" runat="server" Text="Type Of Cancer" meta:resourcekey="lblTypeofcancer_13Resource1"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:Label ID="lblStageofcancer_14" runat="server" Text="Stage Of Cancer" meta:resourcekey="lblStageofcancer_14Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTreatment_15" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_15Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%">
                                <asp:DropDownList ID="ddlTypeofcancer_13" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                    meta:resourcekey="ddlTypeofcancer_13Resource1">
                                </asp:DropDownList>
                                <div id="divddlTypeofcancer_13" runat="server" style="display: none">
                                    <asp:TextBox ID="txtothers_72" runat="server" meta:resourcekey="txtothers_72Resource1"></asp:TextBox>
                                </div>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR9" Visible="true" runat="server" />
                            </td>
                            <td style="width: 10%">
                                <asp:DropDownList ID="ddlStageofcancer_14" runat="server" meta:resourcekey="ddlStageofcancer_14Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR11" Visible="true" runat="server" />
                            </td>
                            <td style="width: 10%">
                                <td colspan="2">
                                    <asp:DropDownList ID="ddlTreatment_15" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                        meta:resourcekey="ddlTreatment_15Resource1">
                                    </asp:DropDownList>
                                    <div id="divddlTreatment_15" runat="server" style="display: none">
                                        <asp:TextBox ID="txtothers_73" runat="server" meta:resourcekey="txtothers_73Resource1"></asp:TextBox>
                                    </div>
                                </td>
                                <td style="display:none">
                                    <uc8:EMR ID="EMR10" Visible="true" runat="server" />
                                </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkThalassemiaTrait_536" runat="server" Text="Thalassemia Trait"
                                onclick="javascript:showContentHis(this.id);" meta:resourcekey="chkThalassemiaTrait_536Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkThalassemiaTrait_536" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td>
                                <asp:Label ID="lblTrait_19" runat="server" Text="Trait" meta:resourcekey="lblTrait_19Resource1"></asp:Label>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%">
                                <asp:DropDownList ID="ddlTrait_19" runat="server" meta:resourcekey="ddlTrait_19Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR25" Visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkHepatitisBcarrier_537" runat="server" Text="Hepatitis B carrier"
                                onclick="javascript:showContentHis(this.id);" meta:resourcekey="chkHepatitisBcarrier_537Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkHepatitisBcarrier_537" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblDuration_20" runat="server" Text="Duration" meta:resourcekey="lblDuration_20Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTreatment_21" runat="server" Text="Treatment" meta:resourcekey="lblTreatment_21Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:TextBox ID="txtDuration_20" runat="server" onKeyDown="return  isNumeric(event,this.id)" Width="50px" meta:resourcekey="txtDuration_20Resource1"></asp:TextBox>
                                <asp:DropDownList ID="ddlDuration_20" runat="server" meta:resourcekey="ddlDuration_20Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="display:none">
                                <uc8:EMR ID="EMR14" Visible="true" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtTreatment_66" runat="server" meta:resourcekey="txtTreatment_66Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--Other Disease--%>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkOtherDisease_945" runat="server" Text="Other Disease" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkOtherDisease_945" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td colspan="3">
                                <asp:Label ID="Label5" Visible="false" runat="server" Text="Type"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:TextBox ID="txtOtherDisease_945" runat="server" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--End Other Disease--%>
    </table>
</div>
<%--Family History--%>
<div id="divFH1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divFH1','tcEMR_tpHistory_ucHistory_divFH2','divFH3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label13" Text="Family History" Font-Bold="True" runat="server" />
</div>
<div id="divFH2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divFH1','tcEMR_tpHistory_ucHistory_divFH2','divFH3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label14" Text="Family History" Font-Bold="True" runat="server" />
</div>
<div id="divFH3" style="display: none; width: 100%" title="Family History">
    <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
        <tr class="defaultfontcolor">
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                <asp:Label ID="Label2" runat="server" Text="FAMILY HISTORY"></asp:Label>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr1chkFamilyHistory_1085" runat="server" style="display: block;">
            <td>
                <table cellpadding="0">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkFamilyHistory_1085" runat="server" Text="Family History" onclick="javascript:showContentHis(this.id);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor" id="tr2" runat="server" style="display: block; height: 10">
            <td>
                <div id="divchkFamilyHistory_1085" runat="server" style="display: none;">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                        
                            <td>
                            <asp:Label ID="lblRelationShip_41" runat="server" Text="Relationship"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblDiseaseType_41" runat="server" Text="Disorder"></asp:Label>
                            </td>
                            
                            <td>
                                <asp:Label ID="lblEvent_41" runat="server" Text="Event"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                             <td>
                                <asp:TextBox ID="txtRelation_41" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDisorder_41" runat="server"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoDisoValue" runat="server"  TargetControlID="txtDisorder_41"
                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getDiagnosis"
                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                           
                            <td>
                                <asp:TextBox ID="txtEvent_41" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <input type="button" id="aNew" value="Add" tooltip="Add New Drug" class="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" onclick="CmdAddNew_onclick();return false;" />
                                <input type="hidden" id="did" runat="server">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div id="divTable" runat="server" style="display: none; border: 1; overflow: auto"
                                    align="left">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
<%--End Family History--%>
<%-- Surgical History --%>
<div id="divSUH1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divSUH1','tcEMR_tpHistory_ucHistory_divSUH2','divSUH3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label15" Text="Surgical History" Font-Bold="True" runat="server" />
</div>
<div id="divSUH2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divSUH1','tcEMR_tpHistory_ucHistory_divSUH2','divSUH3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label16" Text="Surgical History" Font-Bold="True" runat="server" />
</div>
<div id="divSUH3" style="display: none; width: 100%" title="Surgical History">
    <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
        <tr class="defaultfontcolor">
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                <asp:Label ID="Label12" runat="server" Text="SURGICAL HISTORY" meta:resourcekey="Label12Resource1"></asp:Label>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <table cellpadding="0">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkSurgicalHistory_0" runat="server" Text="Surgical History" onclick="javascript:showContentHis(this.id);"
                                meta:resourcekey="chkSurgicalHistory_0Resource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <div id="divchkSurgicalHistory_0" runat="server" style="display: none">
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td>
                                <asp:Label ID="lblSurgeryName_22" runat="server" Text="Surgery Name" meta:resourcekey="lblSurgeryName_22Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblDate_23" runat="server" Text="Date" meta:resourcekey="lblDate_23Resource1" Visible="false" ></asp:Label>
                                 <asp:Label ID="lblYear_23" runat="server" Text="Year" meta:resourcekey="lblYear_23Resource1"></asp:Label>
                                
                            </td>
                            <td>
                                <asp:Label ID="LblHospital_24" runat="server" Text="Hospital/Centre" meta:resourcekey="LblHospital_24Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtsurgeryName" runat="server" meta:resourcekey="txtsurgeryNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtsurgeryName"
                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" FirstRowSelected="True"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" ServiceMethod="getSurgeryName"
                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDate" runat="server" ValidationGroup="MKE" meta:resourcekey="txtDateResource1" Width="30px"></asp:TextBox>
                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                                    Mask="9999" MaskType="none" TargetControlID="txtDate" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" 
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy" PopupButtonID="ImageButton3"
                                    TargetControlID="txtDate" Enabled="True" OnClientHidden="onCalendarHidden"  OnClientShown="onCalendarShown" />
                                <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    meta:resourcekey="ImageButton3Resource1" />
                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                    ControlToValidate="txtDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                    InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(yyyy)"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtHospital" runat="server" meta:resourcekey="txtHospitalResource1"></asp:TextBox>
                                <input type="button" name="btnIPTreatmentPlanAdd" id="btnSurgeryAdd" onclick="onClickAddSurgery();"
                                    value="Add" class="btn" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <input type="hidden" id="hdnSurgeryItems" runat="server" />
                                <table id="tblSurgeryItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                    cellspacing="0" border="0" width="97%">
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
<%-- End Surgical History --%>
<%--Social History --%>
<div id="divSH1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divSH1','tcEMR_tpHistory_ucHistory_divSH2','divSH3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label17" Text="Social History" Font-Bold="True" runat="server" />
</div>
<div id="divSH2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divSH1','tcEMR_tpHistory_ucHistory_divSH2','divSH3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label18" Text="Social History" Font-Bold="True" runat="server" />
</div>
<div id="divSH3" style="display: none; width: 100%" title="Social History">
    <table cellpadding="0" width="98%" class="dataheaderInvCtrl">
        <tr class="defaultfontcolor">
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                <asp:Label ID="Label7" runat="server" Text="SOCIAL HISTORY" meta:resourcekey="Label7Resource1"></asp:Label>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkTS_476" runat="server" Text="Tobacco Smoking" onclick="javascript:showContentHis(this.id);"
                    meta:resourcekey="chkTS_476Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkTS_476" runat="server" style="display: none">
                    <table class="dataheaderInvCtrl" style="width: 100%;">
                        <tr>
                            <td>
                                <table style="width: 75%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTypeTS_1" runat="server" CssClass="defaultfontcolor" Text="Type"
                                                meta:resourcekey="lblTypeTS_1Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTypeTS_4" onchange="javascript:showOthersBoxHis(this.id);"
                                                runat="server" meta:resourcekey="ddlTypeTS_4Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR15" Visible="true" runat="server" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQtyTS_3" CssClass="defaultfontcolor" runat="server" Text="Qty"
                                                meta:resourcekey="lblQtyTS_3Resource1"></asp:Label>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtPacksTS_9" Width="35px" onKeyDown="return  isNumeric(event,this.id)" runat="server" meta:resourcekey="txtPacksTS_9Resource1"></asp:TextBox>
                                            <asp:Label ID="lblPacksTS" CssClass="defaultfontcolor" runat="server" Text="Sticks/Day"
                                                meta:resourcekey="lblPacksTSResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <div id="divddlTypeTS_4" runat="server" style="display: none">
                                                <asp:TextBox ID="txtOthersTypeTS" runat="server" meta:resourcekey="txtOthersTypeTSResource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDurationTS_2" runat="server" CssClass="defaultfontcolor" Text="Duration"
                                                meta:resourcekey="lblDurationTS_2Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDurationTS" Width="35px" runat="server" onKeyDown="return  isNumeric(event,this.id)" meta:resourcekey="txtDurationTSResource1"></asp:TextBox>
                                            <asp:DropDownList ID="ddlDurationTS" runat="server" meta:resourcekey="ddlDurationTSResource1">
                                                <asp:ListItem Value="8" meta:resourcekey="ListItemResource4">year(s)</asp:ListItem>
                                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource5">day(s)</asp:ListItem>
                                                <asp:ListItem Value="6" meta:resourcekey="ListItemResource6">week(s)</asp:ListItem>
                                                <asp:ListItem Value="7" meta:resourcekey="ListItemResource7">month(s)</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <%-- <asp:Button ID="btnAddTS" runat="server" Text="Add" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkQuitSmk_4" runat="server" Text="Quit" onclick="javascript:showQuitDet(this.id);" />
                                        </td>
                                        <td id="tdchkQuitSmk_4" style="display: none;" colspan="9" runat="server">
                                            <asp:Label ID="Label11" CssClass="defaultfontcolor" runat="server" Text="Since"></asp:Label>
                                            <asp:TextBox ID="txtQuitSmk_4" onKeyDown="return  isNumeric(event,this.id)" Width="35px" runat="server"></asp:TextBox>
                                            <asp:DropDownList ID="ddlQuitSmkDuration" runat="server">
                                                <asp:ListItem Value="8">year(s)</asp:ListItem>
                                                <asp:ListItem Value="5">day(s)</asp:ListItem>
                                                <asp:ListItem Value="6">week(s)</asp:ListItem>
                                                <asp:ListItem Value="7">month(s)</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td colspan="11">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkAC_369" runat="server" Text="Alcohol Consumption" onclick="javascript:showContentHis(this.id);"
                    meta:resourcekey="chkAC_369Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkAC_369" runat="server" style="display: none">
                    <table class="dataheaderInvCtrl" style="width: 100%;">
                        <tr>
                            <td>
                                <table style="width: 75%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTypeAC_4" runat="server" CssClass="defaultfontcolor" Text="Type"
                                                meta:resourcekey="lblTypeAC_4Resource1"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:DropDownList ID="ddlTypesAC_12" onchange="javascript:showOthersBoxHis(this.id);"
                                                runat="server" meta:resourcekey="ddlTypesAC_12Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR16" Visible="true" runat="server" />
                                        </td>
                                        <td>
                                            <div id="divddlTypesAC_12" runat="server" style="display: none">
                                                <asp:TextBox ID="txtOthersTypeAC_17" runat="server" meta:resourcekey="txtOthersTypeAC_17Resource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblQtyAC_6" runat="server" CssClass="defaultfontcolor" Text="Qty"
                                                meta:resourcekey="lblQtyAC_6Resource1"></asp:Label>
                                        </td>
                                        <td colspan="4">
                                            <asp:TextBox ID="txtQtyAC" Width="35px" runat="server" onKeyDown="return  isNumeric(event,this.id)" meta:resourcekey="txtQtyACResource1"></asp:TextBox>
                                            <asp:Label ID="lblMlLtr" runat="server" CssClass="defaultfontcolor" Text="ml/day"
                                                meta:resourcekey="lblMlLtrResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDurationAC_5" runat="server" CssClass="defaultfontcolor" Text="Duration"
                                                meta:resourcekey="lblDurationAC_5Resource1"></asp:Label>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtDurationAC" Width="35px" runat="server" onKeyDown="return  isNumeric(event,this.id)" meta:resourcekey="txtDurationACResource1"></asp:TextBox>
                                            <asp:DropDownList ID="ddlDurationAC" runat="server" meta:resourcekey="ddlDurationACResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR17" Visible="false" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <asp:CheckBox ID="chkQuitAlc_4" runat="server" Text="Quit" onclick="javascript:showQuitDet(this.id);" />
                                        </td>
                                        <td id="tdchkQuitAlc_4" style="display: none;" colspan="8" runat="server">
                                            <asp:Label ID="Label10" CssClass="defaultfontcolor" runat="server" Text="Since"></asp:Label>
                                            <asp:TextBox ID="txtQuitAlc_4" onKeyDown="return  isNumeric(event,this.id)" Width="35px" runat="server"></asp:TextBox>
                                            <asp:DropDownList ID="ddlQuitAlcDuration" runat="server">
                                                <asp:ListItem Value="8">year(s)</asp:ListItem>
                                                <asp:ListItem Value="5">day(s)</asp:ListItem>
                                                <asp:ListItem Value="6">week(s)</asp:ListItem>
                                                <asp:ListItem Value="7">month(s)</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkPA_1059" runat="server" Text="Physical  Activity" onclick="javascript:showContentHis(this.id);"
                    meta:resourcekey="chkPA_1059Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkPA_1059" runat="server" style="display: none">
                    <table class="dataheaderInvCtrl" style="width: 100%;">
                        <tr>
                            <td>
                                <table style="width: 75%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPhysicialExercise" runat="server" CssClass="defaultfontcolor" Text="Physicial Exercise"
                                                meta:resourcekey="lblPhysicialExerciseResource1"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:DropDownList ID="ddlPhysicialActivity_22" onchange="javascript:showOthersBoxHis(this.id);"
                                                runat="server" meta:resourcekey="ddlPhysicialActivity_22Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR26" Visible="true" runat="server" />
                                        </td>
                                        <td colspan="3">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td colspan="4">
                                            <div id="divddlPhysicialActivity_22" runat="server" style="display: none;">
                                                <table style="width: 90%;">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkAerobic" runat="server" CssClass="defaultfontcolor" Text="Aerobic"
                                                                meta:resourcekey="chkAerobicResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAerobic_22" runat="server" meta:resourcekey="txtAerobic_22Resource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkAnaerobic" runat="server" CssClass="defaultfontcolor" Text="Anaerobic"
                                                                meta:resourcekey="chkAnaerobicResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAnaerobic_23" runat="server" meta:resourcekey="txtAnaerobic_23Resource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;&nbsp;
                                                            <asp:Label ID="lblPhysicialExerciseDuration" runat="server" CssClass="defaultfontcolor"
                                                                Text="Duration" meta:resourcekey="lblPhysicialExerciseDurationResource1"></asp:Label>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:TextBox ID="txtNos" runat="server" Width="30px" onKeyDown="return  isNumeric(event,this.id)" meta:resourcekey="txtNosResource1"></asp:TextBox>
                                                            <asp:DropDownList ID="ddlHrs" runat="server" meta:resourcekey="ddlHrsResource1">
                                                                <asp:ListItem Value="24" meta:resourcekey="ListItemResource8">Min</asp:ListItem>
                                                                <asp:ListItem Value="25" meta:resourcekey="ListItemResource9">Hrs</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="ddldays" runat="server" meta:resourcekey="ddldaysResource1">
                                                                <asp:ListItem Value="29" meta:resourcekey="ListItemResource10">year(s)</asp:ListItem>
                                                                <asp:ListItem Value="26" meta:resourcekey="ListItemResource11">day(s)</asp:ListItem>
                                                                <asp:ListItem Value="27" meta:resourcekey="ListItemResource12">week(s)</asp:ListItem>
                                                                <asp:ListItem Value="28" meta:resourcekey="ListItemResource13">month(s)</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
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
        <%--Diet--%>
     <%--   <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkDiet_1071" runat="server" Text="Diet Habits" onclick="javascript:showContentHis(this.id);"
                    meta:resourcekey="chkDiet_1071Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="divchkDiet_1071" runat="server" style="display: none;">
                    <table class="dataheaderInvCtrl" border="1" style="width: 100%;">
                        <tr>
                            <td>
                                <asp:Label ID="lblTypeDiet" runat="server" CssClass="defaultfontcolor" Text="Description"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:DropDownList ID="ddlDietType_84" Visible="false" onchange="javascript:showOthersBoxHis(this.id);"
                                    runat="server" meta:resourcekey="ddlDietType_84Resource1">
                                </asp:DropDownList>
                                <asp:TextBox ID="txtOthersTypeDiet_84" runat="server" TextMode="MultiLine" Width="221px"
                                    Height="68px" meta:resourcekey="txtOthersTypeDiet_84Resource1"></asp:TextBox>
                                <div id="divddlDietType_84" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthersTypeDiet1_84" runat="server" meta:resourcekey="txtOthersTypeDiet_84Resource1"></asp:TextBox>
                                </div>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR32" Visible="false" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>--%>
        <%--Bladder habits--%>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkBladder_1072" runat="server" Text="Bladder habits" onclick="javascript:showContentHis(this.id);"
                    meta:resourcekey="chkBladder_1072Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="divchkBladder_1072" runat="server" style="display: none;">
                    <table class="dataheaderInvCtrl" border="1" style="width: 100%;">
                        <tr>
                            <td style="width: 10%">
                                <asp:Label ID="lblTypeBladder" runat="server" CssClass="defaultfontcolor" Text="Type"></asp:Label>
                            </td>
                            <td style="width: 20%">
                                <asp:DropDownList ID="ddlBladderType_92" onchange="javascript:showOthersBoxHis(this.id);"
                                    runat="server">
                                </asp:DropDownList>
                                <div id="divddlBladderType_92" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthersTypeBladder_92" runat="server"></asp:TextBox>
                                </div>
                            </td>
                            <td style="width:70%;display:none;">
                                <uc8:EMR ID="EMR33" Visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--Bowel habits--%>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkBowel_1073" runat="server" Text="Bowel habits" onclick="javascript:showContentHis(this.id);" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="divchkBowel_1073" runat="server" style="display: none;">
                    <table class="dataheaderInvCtrl" border="1" style="width: 100%;">
                        <tr>
                            <td style="width: 10%">
                                <asp:Label ID="lblTypeBowel" runat="server" CssClass="defaultfontcolor" Text="Type"></asp:Label>
                            </td>
                            <td style="width: 20%">
                                <asp:DropDownList ID="ddlBowelType_100" onchange="javascript:showOthersBoxHis(this.id);"
                                    runat="server">
                                </asp:DropDownList>
                                <div id="divddlBowelType_100" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthersTypeBowel_100" runat="server"></asp:TextBox>
                                </div>
                            </td>
                            <td style="width: 70%;display:none">
                                <uc8:EMR ID="EMR35" Visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%--Drug / Substance abuse--%>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkDrugSub_1074" runat="server" Text="Drug / Substance abuse" onclick="javascript:showContentHis(this.id);" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="divchkDrugSub_1074" runat="server" style="display: none;">
                    <table class="dataheaderInvCtrl" border="1" style="width: 100%;">
                        <tr>
                            <td style="width: 10%">
                                <asp:Label ID="lblTypeDrugSub" runat="server" CssClass="defaultfontcolor" Text="Type"></asp:Label>
                            </td>
                            <td style="width: 20%">
                                <asp:DropDownList ID="ddlDrugSubType_101" Visible="false" onchange="javascript:showOthersBoxHis(this.id);"
                                    runat="server">
                                </asp:DropDownList>
                                <asp:TextBox ID="txtOthersTypeDrugSub_101" runat="server"></asp:TextBox>
                                <div id="divddlDrugSubType_101" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthersTypeDrugSub1_101" runat="server"></asp:TextBox>
                                </div>
                            </td>
                            <td style="width: 70%;display:none">
                                <uc8:EMR ID="EMR34" Visible="false" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
<%--End Social History --%>
<%--BEGIN PERSONAL HISTORY --%>
<div id="divPH1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divPH1','tcEMR_tpHistory_ucHistory_divPH2','divPH3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label38" Text="Personal History" Font-Bold="True" runat="server" />
</div>
<div id="divPH2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divPH1','tcEMR_tpHistory_ucHistory_divPH2','divPH3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label39" Text="PERSONAL HISTORY" Font-Bold="True" runat="server" />
</div>
<div id="divPH3" style="display: none; width: 100%" title="Personal History">
    <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
        <tr class="defaultfontcolor">
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center"
                colspan="2">
                <asp:Label ID="Label40" runat="server" Text="Personal History"></asp:Label>
                <hr />
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td valign="middle" style="width: 20%">
                <asp:Label ID="Label41" runat="server" Text="Education"></asp:Label>&nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtEducation" TextMode="SingleLine" runat="server"></asp:TextBox>
                <asp:CheckBox ID="chkEducation" runat="server" Text="Confidential" />
            </td>           
        </tr>
        <tr class="defaultfontcolor">
            <td valign="middle" style="width: 20%">
                <asp:Label ID="Label42" runat="server" Text="Occupation"></asp:Label>&nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtOccupation" TextMode="SingleLine" runat="server"></asp:TextBox>
                <asp:CheckBox ID="chkOccupation" runat="server" Text="Confidential" />
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td valign="middle" style="width: 20%">
                <asp:Label ID="Label43" runat="server" Text="Income"></asp:Label>&nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtIncome" onKeyDown="return  isNumeric(event,this.id)" TextMode="SingleLine" runat="server"></asp:TextBox>
                <asp:CheckBox ID="chkIncome" runat="server" Text="Confidential" />
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td valign="middle" style="width: 20%">
                <asp:Label ID="Label44" runat="server" Text="Marital History"></asp:Label>&nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtMarital" TextMode="SingleLine" runat="server"></asp:TextBox>
                <asp:CheckBox ID="chkMarital" runat="server" Text="Confidential" />
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td valign="middle" style="width: 20%">
                <asp:Label ID="Label45" runat="server" Text="Other Detail"></asp:Label>&nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtOthers" TextMode="SingleLine" runat="server"></asp:TextBox>
                <asp:CheckBox ID="chkOthersDetails" runat="server" Text="Confidential" />
            </td>
        </tr>
    </table>
</div>
<%--END PERSONAL HISTORY --%>
<%--Allergic History--%>
<div id="divAH1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divAH1','tcEMR_tpHistory_ucHistory_divAH2','divAH3',1);"
    style="cursor: pointer; display: none;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label19" Text="Allergic History" Font-Bold="True" runat="server" />
</div>
<div id="divAH2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divAH1','tcEMR_tpHistory_ucHistory_divAH2','divAH3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label28" Text="Allergic History" Font-Bold="True" runat="server" />
</div>
<div id="divAH3" style="display: none; width: 100%" title="Allergic History">
    <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
        <tr class="defaultfontcolor">
            <td colspan="2" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                align="center">
                <asp:Label ID="Label6" runat="server" Text="ALLERGIC HISTORY" meta:resourcekey="Label6Resource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="tblAllergy" border="0" style="border-color:Red;width:90%" runat="server">
                    <tr>
                        <td align="center" style="width: 28%;font-weight: bold; height: 6px; color: #000; font-size: 12px;">
                            <asp:Label ID="Label33" runat="server" Text="Allergy"></asp:Label>
                        </td>
                        <td align="center" style="width: 25%;font-weight: bold; height: 6px; color: #000; font-size: 12px;">
                            <asp:Label ID="Label35" runat="server" Text="Duration"></asp:Label>
                        </td>
                        <td align="center" style="width: 27%;font-weight: bold; height: 6px; color: #000; font-size: 12px;">
                            <asp:Label ID="Label34" runat="server" Text="Reaction"></asp:Label>
                        </td>
                        
                        <td align="left" style="width: 10%;font-weight: bold; height: 6px; color: #000; font-size: 12px;">
                            <asp:Label ID="Label36" runat="server" Text="On-going"></asp:Label>
                        </td>
                        <td align="left" colspan="2" style="width: 10%;font-weight: bold; height: 6px; color: #000; font-size: 12px;">
                            <asp:Label ID="Label37" runat="server" Text="Treatment"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td id="Td2" style="width: 28%" align="left" runat="server">
                            <asp:TextBox ID="txtAllergyName" MaxLength="255" runat="server" ></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoAllergyName" runat="server" TargetControlID="txtAllergyName"
                                EnableCaching="False" MinimumPrefixLength="2" BehaviorID="AutoCompleteExAll" CompletionInterval="10" DelimiterCharacters=";,:" FirstRowSelected="True"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected" OnClientItemSelected="SelectedHistory"
                                ServiceMethod="GetAllergyHistory" ServicePath="~/WebService.asmx" Enabled="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td style="width: 25%">
                            <asp:TextBox ID="txtAllDuration" runat="server" onKeyDown="return  isNumeric(event,this.id)" Width="50px" meta:resourcekey="txtDuration_5Resource1"></asp:TextBox>
                            <asp:DropDownList ID="ddlAllDuration" runat="server">
                                            </asp:DropDownList>
                            
                        </td>
                        <td style="width: 27%">
                            <asp:TextBox ID="txtAllReaction" MaxLength="255" runat="server"></asp:TextBox>
                        </td>
                        
                        <td style="width: 10%">
                            <asp:CheckBox ID="chkOnGoing" runat="server" Text="" />
                        </td>
                        <td style="width: 5%">
                            <asp:CheckBox ID="chkTreatment" runat="server" Text="" />
                        </td>
                        <td align="right">
                            <input type="button" name="btnAddPC" id="btnAllergyHistoryAdd" onclick="onClickAddAller();"
                                value="Add" class="btn" tabindex="42"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr runat="server" id="trAllergy" style="display: none;">
            <td id="Td1" valign="top" colspan="2" runat="server">
                <table id="tblAllergyItems" class="dataheaderInvCtrl" cellpadding="4px" cellspacing="0"
                    width="80%">
                </table>
            </td>
        </tr>
    </table>
</div>
<%-- End Allergic History --%>
<%-- Other History --%>
<div id="divOH1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divOH1','tcEMR_tpHistory_ucHistory_divOH2','divOH3',1);"
    style="cursor: pointer; display: none;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label29" Text="Others" Font-Bold="True" runat="server" />
</div>
<div id="divOH2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divOH1','tcEMR_tpHistory_ucHistory_divOH2','divOH3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label30" Text="Others" Font-Bold="True" runat="server" />
</div>
<div id="divOH3" style="display: none; width: 100%" title="Others">
    <table cellpadding="0" width="98%" class="dataheaderInvCtrl">
        <tr>
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                &nbsp;
                <asp:Label ID="Label9" runat="server" Text="Others" meta:resourcekey="Label9Resource1"></asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkDrugsHistory_1063" runat="server" Text="Drug History" onclick="javascript:showContentHis(this.id);"
                    meta:resourcekey="chkDrugsHistory_1063Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkDrugsHistory_1063" runat="server" style="display: none">
                    <uc1:EMRAdvice ID="uAd" runat="server" />
                </div>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkVaccHis_1064" runat="server" Text="Vaccination History" onclick="javascript:showContentHis(this.id);"
                    meta:resourcekey="chkVaccHis_1064Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkVaccHis_1064" runat="server" style="display: none">
                    <div class="dataheader2" style="width: 75%;">
                        <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="100%">
                            <tr>
                                <td style="width: 12%">
                                    <asp:Label ID="lblVacc" runat="server" Text="Vaccination" meta:resourcekey="lblVaccResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="drpVaccination" runat="server" CssClass="ddlTheme" meta:resourcekey="drpVaccinationResource1">
                                        <asp:ListItem Value="8" meta:resourcekey="ListItemResource14">OPV</asp:ListItem>
                                        <asp:ListItem Value="11" meta:resourcekey="ListItemResource15">MMR</asp:ListItem>
                                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource16">Hepatitis B</asp:ListItem>
                                        <asp:ListItem Value="3" meta:resourcekey="ListItemResource17">Hepatitis A</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="display:none">
                                    <uc8:EMR ID="EMR20" Visible="false" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblYear" runat="server" Text="Year" meta:resourcekey="lblYearResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                    <asp:TextBox ID="txtYear" runat="server" CssClass="textfield1" MaxLength="4" size="5"
                                           onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtYearResource1"></asp:TextBox>
                                </td>
                                <td style="width: 7%">
                                    <asp:Label ID="lblMonth" runat="server" Text="Month" meta:resourcekey="lblMonthResource1"></asp:Label>
                                </td>
                                <td style="width: 28%">
                                    <asp:DropDownList ID="drpMonth" runat="server" CssClass="ddlTheme" meta:resourcekey="drpMonthResource1">
                                        <asp:ListItem Text="Sel" Value="0" meta:resourcekey="ListItemResource18">---Select---</asp:ListItem>
                                        <asp:ListItem Text="Jan" Value="1" meta:resourcekey="ListItemResource19">January</asp:ListItem>
                                        <asp:ListItem Text="Feb" Value="2" meta:resourcekey="ListItemResource20">Febrauary</asp:ListItem>
                                        <asp:ListItem Text="Mar" Value="3" meta:resourcekey="ListItemResource21">March</asp:ListItem>
                                        <asp:ListItem Text="Apr" Value="4" meta:resourcekey="ListItemResource22">April</asp:ListItem>
                                        <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource23">May</asp:ListItem>
                                        <asp:ListItem Text="Jun" Value="6" meta:resourcekey="ListItemResource24">June</asp:ListItem>
                                        <asp:ListItem Text="Jul" Value="7" meta:resourcekey="ListItemResource25">July</asp:ListItem>
                                        <asp:ListItem Text="Aug" Value="8" meta:resourcekey="ListItemResource26">August</asp:ListItem>
                                        <asp:ListItem Text="Sep" Value="9" meta:resourcekey="ListItemResource27">September</asp:ListItem>
                                        <asp:ListItem Text="Oct" Value="10" meta:resourcekey="ListItemResource28">October</asp:ListItem>
                                        <asp:ListItem Text="Nov" Value="11" meta:resourcekey="ListItemResource29">November</asp:ListItem>
                                        <asp:ListItem Text="Dec" Value="12" meta:resourcekey="ListItemResource30">December</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDoses" runat="server" Text="Doses" meta:resourcekey="lblDosesResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDoses" runat="server" CssClass="textfield1" MaxLength="10" size="5"
                                        meta:resourcekey="txtDosesResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblReaction" runat="server" Text="Reaction" meta:resourcekey="lblReactionResource1"></asp:Label>
                                    <asp:DropDownList ID="ddlAnaphylacticReaction" runat="server" meta:resourcekey="ddlAnaphylacticReactionResource1">
                                    </asp:DropDownList>
                                </td>
                                <td style="display:none">
                                    <uc8:EMR ID="EMR21" Visible="true" runat="server" />
                                </td>
                                <td align="left" colspan="2">
                                    <asp:Button ID="btnAdd" runat="server" CssClass="btn" OnClientClick="return PriorVaccinationsItems();"
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Add"
                                        meta:resourcekey="btnAddResource1" />
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="HdnVaccination" runat="server" />
                        <br />
                        <br />
                        <table id="tblPriorVaccinations" runat="server" border="2" cellspacing="0" class="dataheaderInvCtrl"
                            width="75%">
                            <tr class="colorforcontent">
                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                                </td>
                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 30%;">
                                    Vaccination
                                </td>
                                 <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;">
                                 Year
                                </td>
                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                                    Month
                                </td>
                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                    Doses
                                </td>
                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                                    AnaphylacticReaction
                                </td>
                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                    display: none;">
                                    Vaccination ID
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</div>
<%-- End Other History --%>
<%-- Gynaecological History--%>
<div id="divGH1" onclick="showResponses('tcEMR_tpHistory_ucHistory_divGH1','tcEMR_tpHistory_ucHistory_divGH2','divGH3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label31" Text="Gynaecological History" Font-Bold="True" runat="server" />
</div>
<div id="divGH2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpHistory_ucHistory_divGH1','tcEMR_tpHistory_ucHistory_divGH2','divGH3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label32" Text="Gynaecological History" Font-Bold="True" runat="server" />
</div>
<div id="divGH3" style="display: none; width: 100%" title="Gynaecological History">
    <table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl" id="tblGynacHis"
        runat="server">
        <tr class="defaultfontcolor">
            <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
                <asp:Label ID="Label8" runat="server" Text="GYNAECOLOGICAL HISTORY" meta:resourcekey="Label8Resource1"></asp:Label>
                <asp:HiddenField runat="server" ID="hdnSex" />
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkGynacHis_1065" runat="server" Text="Gynaecological History"
                    onclick="javascript:showContentHis(this.id);" meta:resourcekey="chkGynacHis_1065Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkGynacHis_1065" runat="server" style="display: none">
                    <table class="dataheaderInvCtrl" style="width: 100%;">
                        <tr>
                            <td>
                                <table style="width: 75%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLMPDate" runat="server" CssClass="defaultfontcolor" Text="LMP Date"
                                                meta:resourcekey="lblLMPDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tLMP_38" runat="server" CssClass="textfield" MaxLength="1" Style="text-align: justify"
                                                TabIndex="4" ValidationGroup="MKE" meta:resourcekey="tLMP_38Resource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" ErrorTooltipEnabled="True"
                                                Mask="99/99/9999" MaskType="Date" TargetControlID="tLMP_38" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                TargetControlID="tLMP_38" Enabled="True" />
                                            <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                meta:resourcekey="ImgBntCalcResource1" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                ControlToValidate="tLMP_38" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblMenstrualCycle" runat="server" CssClass="defaultfontcolor" Text="Menstrual Cycle"
                                                meta:resourcekey="lblMenstrualCycleResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlMenstrualCycle" runat="server" meta:resourcekey="ddlMenstrualCycleResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR22" Visible="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblCycleLength" runat="server" CssClass="defaultfontcolor" Text="Cycle Length(approx)"
                                                meta:resourcekey="lblCycleLengthResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCycleLength_45" runat="server" Width="50px" meta:resourcekey="txtCycleLength_45Resource1"></asp:TextBox>
                                            <asp:Label ID="lblCyclelengthDays" runat="server" CssClass="defaultfontcolor" Text="days"
                                                meta:resourcekey="lblCyclelengthDaysResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblLastPapSmear" runat="server" CssClass="defaultfontcolor" Text="Last Pap Smear"
                                                meta:resourcekey="lblLastPapSmearResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLastPapSmearDt_46" runat="server" CssClass="textfield" MaxLength="1"
                                                Style="text-align: justify" TabIndex="4" ValidationGroup="MKE" meta:resourcekey="txtLastPapSmearDt_46Resource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtLastPapSmearDt_46" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton1"
                                                TargetControlID="txtLastPapSmearDt_46" Enabled="True" />
                                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                meta:resourcekey="ImageButton1Resource1" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender3"
                                                ControlToValidate="txtLastPapSmearDt_46" Display="Dynamic" EmptyValueBlurredText="*"
                                                EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" ErrorMessage="MaskedEditValidator3"
                                                meta:resourcekey="MaskedEditValidator3Resource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblAgeofMenarchy" runat="server" CssClass="defaultfontcolor" Text="Age of Menarchy"
                                                meta:resourcekey="lblAgeofMenarchyResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAgeofMenarchy_47" runat="server" Width="50px" meta:resourcekey="txtAgeofMenarchy_47Resource1"></asp:TextBox>
                                            <asp:Label ID="lblAgeofMenarchyYears" runat="server" CssClass="defaultfontcolor"
                                                Text="years" meta:resourcekey="lblAgeofMenarchyYearsResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblResult" runat="server" CssClass="defaultfontcolor" Text="Result"
                                                meta:resourcekey="lblResultResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlLastPapSmearResult" runat="server" meta:resourcekey="ddlLastPapSmearResultResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR23" Visible="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblContraception" runat="server" CssClass="defaultfontcolor" Text="Contraception"
                                                meta:resourcekey="lblContraceptionResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlContraception_50" onchange="javascript:showOthersBoxHis(this.id);"
                                                runat="server" meta:resourcekey="ddlContraception_50Resource1">
                                            </asp:DropDownList>
                                            <div id="divddlContraception_50" runat="server" style="display: none">
                                                <asp:TextBox ID="txtContraceptionOthers_50" runat="server" Width="75px" meta:resourcekey="txtContraceptionOthers_50Resource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR24" Visible="true" runat="server" />
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLastMamogram" runat="server" CssClass="defaultfontcolor" Text="Last Mammogram"
                                                meta:resourcekey="lblLastMamogramResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLastMammogramResultDt_55" runat="server" meta:resourcekey="txtLastMammogramResultDt_55Resource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLastMamogramResult" runat="server" CssClass="defaultfontcolor"
                                                Text="Result" meta:resourcekey="lblLastMamogramResultResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLastMammogramResult_56" runat="server" meta:resourcekey="txtLastMammogramResult_56Resource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td>
                <asp:CheckBox ID="chkHRT_1066" runat="server" Text="Hormone Replacement Theraphy"
                    onclick="javascript:showContentHis(this.id);" meta:resourcekey="chkHRT_1066Resource1" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr class="defaultfontcolor">
            <td colspan="2">
                <div id="divchkHRT_1066" runat="server" style="display: none">
                    <table class="dataheaderInvCtrl" style="width: 100%;">
                        <tr>
                            <td>
                                <table style="width: 75%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTypeofHRT" runat="server" CssClass="defaultfontcolor" Text="Type of HRT"
                                                meta:resourcekey="lblTypeofHRTResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTypeofHRT_59" onchange="javascript:showOthersBoxHis(this.id);"
                                                runat="server" meta:resourcekey="ddlTypeofHRT_59Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR27" Visible="true" runat="server" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblHRTDelivery" runat="server" CssClass="defaultfontcolor" Text="HRT Delivery"
                                                meta:resourcekey="lblHRTDeliveryResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlHRTDelivery_66" onchange="javascript:showOthersBoxHis(this.id);"
                                                runat="server" meta:resourcekey="ddlHRTDelivery_66Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="display:none">
                                            <uc8:EMR ID="EMR28" Visible="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <div id="divddlTypeofHRT_59" runat="server" style="display: none">
                                                <asp:TextBox ID="txtOthersTypeofHRT_59" runat="server" meta:resourcekey="txtOthersTypeofHRT_59Resource1"></asp:TextBox>
                                            </div>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <div id="divddlHRTDelivery_66" runat="server" style="display: none">
                                                <asp:TextBox ID="txtOthersHRTDelivery_66" runat="server" meta:resourcekey="txtOthersHRTDelivery_66Resource1"></asp:TextBox>
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
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</div>
<%-- End Gynaecological History--%>
<asp:HiddenField ID="hdnFamilyHistory" runat="server" />
<asp:HiddenField ID="hdnTempFamilyHistory" runat="server" />
<asp:HiddenField ID="hdnFamilyHistoryExists" runat="server" />
<asp:HiddenField ID="hdnAllergy" runat="server" />
<asp:HiddenField ID="hdnAllergyValue" runat="server" />
<asp:HiddenField ID ="hdnAllergyDet" runat ="server" />
<asp:HiddenField ID ="hdnHistoryID" runat ="server" />
<asp:HiddenField ID="hdnSHistory" runat ="server" />