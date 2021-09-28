<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="BaseLineHistory.aspx.cs"
    Inherits="ANC_BaseLineHistory" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/DateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BaseLine Screening history</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
            <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>
    
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">

        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('PatientVitalsControl_txtSBP').value;
                var ctrlDBP = document.getElementById('PatientVitalsControl_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }

        function OnTreeClick(evt) {
            var src = window.event != window.undefined ? window.event.srcElement : evt.target;
            var isChkBoxClick = (src.tagName.toLowerCase() == "input" && src.type == "checkbox");
            if (isChkBoxClick) {
                var parentTable = GetParentByTagName("table", src);
                var nxtSibling = parentTable.nextSibling;
                if (nxtSibling && nxtSibling.nodeType == 1)//check if nxt sibling is not null & is an element node
                {
                    if (nxtSibling.tagName.toLowerCase() == "div") //if node has children
                    {
                        //check or uncheck children at all levels
                        CheckUncheckChildren(parentTable.nextSibling, src.checked);
                    }
                }
                //check or uncheck parents at all levels

                CheckUncheckParents(src, src.checked);
            }
        }

        function CheckUncheckChildren(childContainer, check) {
            var childChkBoxes = childContainer.getElementsByTagName("input");
            var childChkBoxCount = childChkBoxes.length;
            var iID = 0;
            var chkBxNm = 'tCA';
            var txtBxNm = 'tA';
            for (var i = 0; i < childChkBoxCount; i++) {
                iID = childChkBoxes[i].id.substring(3);
                chkBxNm = chkBxNm + iID;
                txtBxNm = txtBxNm + iID;
                childChkBoxes[i].checked = check;
                if (check == true && childChkBoxes[i].id.substring(0, 3) == 'tCA') {
                    ShowUnShowtext(txtBxNm, chkBxNm);
                }
                else if (check == false && childChkBoxes[i].id.substring(0, 3) == 'tCA') {
                    unShowtext(txtBxNm, chkBxNm);
                }
                else {
                }
                chkBxNm = 'tCA';
                txtBxNm = 'tA';
            }
        }

        function CheckUncheckParents(srcChild, check) {
            var parentDiv = GetParentByTagName("div", srcChild);
            var parentNodeTable = parentDiv.previousSibling;
            if (parentNodeTable) {
                var checkUncheckSwitch;
                if (check) //checkbox checked
                {
                    var isAllSiblingsChecked = AreAllSiblingsChecked(srcChild);
                    if (isAllSiblingsChecked)
                        checkUncheckSwitch = true;
                    else
                        return; //do not need to check parent if any child is not checked
                }
                else //checkbox unchecked
                {
                    checkUncheckSwitch = false;
                }
                var inpElemsInParentTable = parentNodeTable.getElementsByTagName("input");
                if (inpElemsInParentTable.length > 0) {
                    var parentNodeChkBox = inpElemsInParentTable[0];
                    parentNodeChkBox.checked = checkUncheckSwitch;

                    //do the same recursively
                    CheckUncheckParents(parentNodeChkBox, checkUncheckSwitch);
                }
            }
        }


        function AreAllSiblingsChecked(chkBox) {
            var parentDiv = GetParentByTagName("div", chkBox);
            var childCount = parentDiv.childNodes.length;
            for (var i = 0; i < childCount; i++) {

                if (parentDiv.childNodes[i].nodeType == 1) //check if the child node is an element node
                {
                    if (parentDiv.childNodes[i].tagName.toLowerCase() == "table") {
                        var prevChkBox = parentDiv.childNodes[i].getElementsByTagName("input")[0];
                        //if any of sibling nodes are not checked, return false
                        if (!prevChkBox.checked) {
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        //utility function to get the container of an element by tagname
        function GetParentByTagName(parentTagName, childElementObj) {
            var parent = childElementObj.parentNode;
            while (parent.tagName.toLowerCase() != parentTagName.toLowerCase()) {
                parent = parent.parentNode;
            }
            return parent;
        }
        // Test Script Ends
        function client_OnTreeNodeChecked() {
            var obj = window.event.srcElement;
            var treeNodeFound = false;
            var checkedState;
            var checkedState1;
            if (obj.tagName == "INPUT" && obj.type == "checkbox") {
                var treeNode = obj;
                checkedState = treeNode.checked;
                checkedState1 = treeNode.unchecked;
                do {
                    obj = obj.parentElement;
                } while (obj.tagName != "TABLE")
                var parentTreeLevel = obj.rows[0].cells.length;
                var parentTreeNode = obj.rows[0].cells[0];
                var tables = obj.parentElement.getElementsByTagName("TABLE");
                var numTables = tables.length
                if (numTables >= 1) {
                    for (i = 0; i < numTables; i++) {
                        if (tables[i] == obj) {
                            treeNodeFound = true;
                            i++;
                            if (i == numTables) {
                                return;
                            }
                        }
                        if (treeNodeFound == true) {
                            var childTreeLevel = tables[i].rows[0].cells.length;
                            if (childTreeLevel > parentTreeLevel) {
                                var cell = tables[i].rows[0].cells[childTreeLevel - 1];
                                var inputs = cell.getElementsByTagName("INPUT");
                                inputs[0].checked = checkedState;

                            }
                            else {
                                return;
                            }
                        }
                        else {
                            var childTreeLevel = tables[i].rows[0].cells.length;
                            if (childTreeLevel > parentTreeLevel) {
                                var cell = tables[i].rows[0].cells[childTreeLevel - 1];
                                var inputs = cell.getElementsByTagName("INPUT");
                                inputs[0].checked = checkedState1;

                            }
                            else {
                                return;
                            }
                        }
                    }
                }
            }
        }
        function ReportsDIV() {
            if (document.getElementById('ddlAnyotherClinic').value == '0') {
                document.getElementById('RepDiv').style.display = 'block';
            }
            else {
                document.getElementById('RepDiv').style.display = 'none';
            }
        }
        function UltrasoundDIV() {
            if (document.getElementById('ddlAnypriorUltrasoundConfirmation').value == '0') {
                document.getElementById('UltraDiv').style.display = 'block';

            }
            else {
                document.getElementById('UltraDiv').style.display = 'none';
            }
        }

        function showPastMedical(chkID, divID) {
            if (document.getElementById(chkID).checked) {
                document.getElementById(divID).style.display = 'block';
            }
            else {
                document.getElementById(divID).style.display = 'none';
            }
        }
        function MenstrualDIV() {
            if (document.getElementById('ddlMenstrualCycles').value == '1' || document.getElementById('ddlMenstrualCycles').value == '3') {
                document.getElementById('CyclesDiv').style.display = 'block';
                document.getElementById('Cycles1Div').style.display = 'none';
            }
            else {
                document.getElementById('Cycles1Div').style.display = 'block';
                document.getElementById('CyclesDiv').style.display = 'none';
            }
            if (document.getElementById('ddlMenstrualCycles').value == '0') {
                document.getElementById('CyclesDiv').style.display = 'none';
                document.getElementById('Cycles1Div').style.display = 'none';
            }
        }
        function UseofContraceptivesDIV() {
            if (document.getElementById('ddlUseofContraceptives').value == '0') {
                document.getElementById('ContraceptivesDiv').style.display = 'block';
            }
            else {
                document.getElementById('ContraceptivesDiv').style.display = 'none';
            }
        }


        function validateBaseLineHistory() {

            if (document.getElementById('drpPregnancy').value == '0') {
                var userMsg = SListForApplicationMessages.Get("ANC\\BaseLineHistory.aspx_1");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Select pregnancy status');
                    return false;
                }
                document.getElementById('drpPregnancy').focus();
                return false;
            }
            else if (document.getElementById('drpPregnancy').value == '1') {
            if (document.getElementById('tLMP').value == '')
                 {
                  var userMsg = SListForApplicationMessages.Get("ANC\\BaseLineHistory.aspx_2");
                  if (userMsg != null)
                   {
                      alert(userMsg);
                      return false;
                  }
                  else {
                      alert('Select LMP date');
                      return false;
                  }
                    document.getElementById('tLMP').focus();
                    return false;
                }
            }
            //                if (document.getElementById('txtGravida').value == '') {
            //                    alert('Enter Gravida');
            //                    document.getElementById('txtGravida').focus();
            //                    return false;
            //                }
            //                if (document.getElementById('txtPara').value == '') {
            //                    alert('Enter Para');
            //                    document.getElementById('txtPara').focus();
            //                    return false;
            //                }
            //                if (document.getElementById('txtAbortUs').value == '') {
            //                    alert('Enter AbortUs');
            //                    document.getElementById('txtAbortUs').focus();
            //                    return false;
            //                }
            //                if (document.getElementById('txtLive').value == '') {
            //                    alert('Enter Live');
            //                    document.getElementById('txtLive').focus();
            //                    return false;
            //                }
            document.getElementById('btnSave').style.display = 'none';
            getAssociatedDiseasesANC();
        }
    </script>

    <script language="javascript" type="text/javascript">

        function calculateANCWeeks() {
            var date1 = new Date();

            //Parsing the value from the text control. The actual date is in dd/mm/yyyy format as per your post.
            var arrDateValue = document.getElementById("tLMP").value.split('/'); // Actual Date is in dd/mm/yyyy

            // Converting to mm/dd/yyyy date format  
            var Date2 = new Date(arrDateValue[1] + '/' + arrDateValue[0] + '/' + arrDateValue[2]); // mm/dd/yyyy

            // one week calculation
            var perWeek = 24 * 60 * 60 * 1000 * 7;

            // calculating total week. FYI the week starts from Monday to Sunday  
            var totalWeeks = Math.round((date1.valueOf() - Date2.valueOf()) / perWeek) + 1;

            if (totalWeeks != "NaN") {
                //alert('if : ' + totalWeeks);
                document.getElementById("lblANCWeeks").style.display = 'block';
                document.getElementById("txtANCWeeks").style.display = 'block';

                document.getElementById("txtANCWeeks").value = totalWeeks;
            }
            else {
                //alert('else : ' + totalWeeks);
                document.getElementById("lblANCWeeks").style.display = 'none';
                document.getElementById("txtANCWeeks").style.display = 'none';
            }
        }
    
    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnNoLog">

    <script language="javascript" type="text/javascript">
        // BaseLine Histroy ....

        function LoadBaseLineHistroyItems() {
            var HidLoadValue = document.getElementById('<%=HidBaseLine.ClientID %>').value;
            //alert(HidLoadValue);
            var list = HidLoadValue.split('^');
            if (document.getElementById('<%=HidBaseLine.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var BaselineList = list[count].split('~');

                    var row = document.getElementById('<%=tblBaseLine.ClientID %>').insertRow(1);
                    var icout = document.getElementById('<%=tblBaseLine.ClientID %>').rows.length;
                    row.id = icout;
                    //alert(icout);

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
                    //alert(BaselineList[0]);
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
            //alert('1');
            var BaseLineStatus = 0;
            var HidAddValue = document.getElementById('<%=HidBaseLine.ClientID %>').value;
            //alert(document.getElementById('<%=drdSOC.ClientID %>').options[document.getElementById('<%=drdSOC.ClientID %>').selectedIndex].text);
            var ddlName = document.getElementById('<%=drdSOC.ClientID %>').options[document.getElementById('<%=drdSOC.ClientID %>').selectedIndex].text;
            var age = document.getElementById('<%=txtAge.ClientID %>').value;
            var ddlDeliveryName = document.getElementById('<%=drpMOD.ClientID %>').options[document.getElementById('<%=drpMOD.ClientID %>').selectedIndex].text;
            var ddlDeliveryNameID = document.getElementById('<%=drpMOD.ClientID %>').value;
            var weight = document.getElementById('<%=txtBwt.ClientID %>').value;
            var ddlBMaturity = document.getElementById('<%=drpBMaturity.ClientID %>').options[document.getElementById('<%=drpBMaturity.ClientID %>').selectedIndex].text;
            var ddlBMaturityID = document.getElementById('<%=drpBMaturity.ClientID %>').value;
            //var ddlBMaturity = document.getElementById('<%=drpBMaturity.ClientID %>').value;
            //alert(ddlBMaturity);
            var gnormal;
            //alert(ddlName);
            //alert(age);

            if (document.getElementById('<%=chkIsGrowth.ClientID %>').checked == true) {

                gnormal = 'Abnormal';
            }
            else { gnormal = 'Normal'; }
            //var grate = document.getElementById('<%=txtGrowthRate.ClientID %>').value;
            var grate = 0;
            var row = document.getElementById('<%=tblBaseLine.ClientID %>').insertRow(1);
            var icout = document.getElementById('<%=tblBaseLine.ClientID %>').rows.length;
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
            //alert(ddlName);
            document.getElementById('<%=HidBaseLine.ClientID %>').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
            //alert(document.getElementById('<%=HidBaseLine.ClientID %>').value);
            document.getElementById('<%=drdSOC.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtAge.ClientID %>').value = '';
            document.getElementById('<%=drpMOD.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtBwt.ClientID %>').value = '';
            document.getElementById('<%=drpBMaturity.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=chkIsGrowth.ClientID %>').checked = false;
            //document.getElementById('<%=txtGrowthRate.ClientID %>').value = '';
            BaseLineStatus = 0;
            return false;
            if (BaseLineStatus == 0) {

                var row = document.getElementById('<%=tblBaseLine.ClientID %>').insertRow(1);
                var icout = document.getElementById('<%=tblBaseLine.ClientID %>').rows.length;
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
                document.getElementById('<%=HidBaseLine.ClientID %>').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
                document.getElementById('<%=drdSOC.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtAge.ClientID %>').value = '';
                document.getElementById('<%=drpMOD.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtBwt.ClientID %>').value = '';
                document.getElementById('<%=drpBMaturity.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=chkIsGrowth.ClientID %>').checked = false;
                //document.getElementById('<%=txtGrowthRate.ClientID %>').value = '';
                return false;
            }
        }
        function ImgDeleteclick(ImgDeleteID) {
            //alert(ImgDeleteID);
            document.getElementById(ImgDeleteID).style.display = "none";
            var HidDeleteValue = document.getElementById('<%=HidBaseLine.ClientID %>').value;
            //alert(HidDeleteValue);
            var list = HidDeleteValue.split('^');
            var newList = '';
            if (document.getElementById('<%=HidBaseLine.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var BaseList = list[count].split('~');
                    if (BaseList[0] != '') {
                        //alert(BaseList[0]);
                        if (BaseList[0] != ImgDeleteID) {
                            newList += list[count] + "^";
                        }
                    }
                }
                document.getElementById('<%=HidBaseLine.ClientID %>').value = newList;
            }
            //alert(newList);
        }






        // Previous Complicate Function.....


        function LoadPreviousComplicateItems() {
            var HidPreviousCompValue = document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value;
            //alert(HidPreviousCompValue);
            var PrevList = HidPreviousCompValue.split('^');
            if (document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value != "") {
                for (var Pcount = 0; Pcount < PrevList.length - 1; Pcount++) {
                    var PreviousCompList = PrevList[Pcount].split('~');
                    var row = document.getElementById('<%=tblPreviousComplicate.ClientID %>').insertRow(1);
                    row.id = PreviousCompList;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + escape(PreviousCompList) + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = PreviousCompList;
                    //cell2.style.display = "none";
                }
            }
            return false;
        }


        function PreviousComplicatedItems() {

            if (document.getElementById('<%=txtothers.ClientID %>').value != '') {
                var PreCompStatus = 0;
                var HidPreValue = document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value;
                //alert(HidPreValue);
                var Prelist = HidPreValue.split('^');
                var CompName = document.getElementById('<%=txtothers.ClientID %>').value;

                //                var CompNameSplit = CompName.split(' ');
                //                var i = 0;
                //                CompName = "";
                //                for (i = 0; i < CompNameSplit.length; i++) {
                //                    if (CompNameSplit[i] != "") {
                //                        CompName += CompNameSplit[i] + '_';
                //                    }
                //                }





                if (document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value != "") {
                    for (var count = 0; count < Prelist.length; count++) {
                        var PrelineList = Prelist[count].split('^');
                        //alert('Prelist : ' + Prelist);
                        //alert('test : ' + PrelineList);
                        if (PrelineList != '') {
                            if (PrelineList == CompName) {
                                PreCompStatus = 1;
                            }
                        }
                    }
                }
                else {
                    var row = document.getElementById('<%=tblPreviousComplicate.ClientID %>').insertRow(1);
                    row.id = CompName;
                    //alert('no : ' + CompName);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + escape(CompName) + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = CompName;
                    document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value += CompName + "^";
                    document.getElementById('<%=txtothers.ClientID %>').value = '';
                    PreCompStatus = 0;
                    return false;
                }
            }
            else 
            {
                userMsg = SListForApplicationMessages.Get('ANC\\BaseLineHistory.aspx_7');
                if (userMsg != null) 
                {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide atleast one complications');
                    return false;
                }
                document.getElementById('<%=txtothers.ClientID %>').focus();
                return false;
            }
            if (PreCompStatus == 0) {
                var row = document.getElementById('<%=tblPreviousComplicate.ClientID %>').insertRow(1);
                row.id = CompName;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + escape(CompName) + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = CompName;
                document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value += CompName + "^";
                document.getElementById('<%=txtothers.ClientID %>').value = '';
                return false;
            }
            else if (PreCompStatus == 1) {
              userMsg = SListForApplicationMessages.Get('ANC\\BaseLineHistory.aspx_10');
              if (userMsg != null) {
                  alert(userMsg);
                  return false;
              }
              else {
                  alert('Already added');
                  return false;
              }
                document.getElementById('<%=txtothers.ClientID %>').value = '';
                document.getElementById('<%=txtothers.ClientID %>').focus();
                return false;
            }
        }

        function PreDeleteclick(DeleteItem) {
            document.getElementById(unescape(DeleteItem)).style.display = "none";
            var HidPreValue = document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value;
            var Prelist = HidPreValue.split('^');
            var newPreList = '';
            if (document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value != "") {
                for (var icount = 0; icount < Prelist.length; icount++) {
                    var ComplicateList = Prelist[icount].split('~');
                    if (ComplicateList != '') {
                        if (ComplicateList != DeleteItem) {
                            newPreList += Prelist[icount] + "^";
                        }
                    }
                }
                document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value = newPreList;
            }
        }


        // AssociateDieasesItems Script...

        function LoadAssociateDieasesItems() {
            var HidAssValue = document.getElementById('<%=HdnAssociate.ClientID %>').value;
            var AscList = HidAssValue.split('^');
            if (document.getElementById('<%=HdnAssociate.ClientID %>').value != "") {
                for (var Adcount = 0; Adcount < AscList.length - 1; Adcount++) {
                    var DieasesList = AscList[Adcount].split('~');
                    var row = document.getElementById('<%=tblAssociate.ClientID %>').insertRow(1);
                    row.id = DieasesList[0];
                    //alert(row.id);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn2' style='cursor:pointer;' OnClick=AssDeleteclick(" + escape(DieasesList[0]) + "); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = DieasesList[1];
                    cell3.innerHTML = DieasesList[2];
                    //cell3.style.display = "none";
                }
            }
            return false;
        }


        function AssociateDieasesItems() {
            if (document.getElementById('<%=txtAssocaitedothers.ClientID %>').value != '' && document.getElementById('<%=txtADDesc.ClientID %>').value != '') {
                var AssociateStatus = 0;
                var HidAssociateValue = document.getElementById('<%=HdnAssociate.ClientID %>').value;
                var Asslist = HidAssociateValue.split('^');
                var AssOther = document.getElementById('<%=txtAssocaitedothers.ClientID %>').value;
                var AssDesc = document.getElementById('<%=txtADDesc.ClientID %>').value;
                if (document.getElementById('<%=HdnAssociate.ClientID %>').value != "") {
                    for (var Acount = 0; Acount < Asslist.length; Acount++) {
                        var DieasesList = Asslist[Acount].split('~');
                        if (DieasesList[0] != '') {
                            if (DieasesList[0] == AssOther) {
                                AssociateStatus = 1;
                            }
                        }
                    }
                }
                else {
                    var row = document.getElementById('<%=tblAssociate.ClientID %>').insertRow(1);
                    row.id = AssOther;
                    //alert(row.id);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn2' style='cursor:pointer;' OnClick=AssDeleteclick('" + escape(AssOther) + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = AssOther;
                    cell3.innerHTML = AssDesc;
                    document.getElementById('<%=HdnAssociate.ClientID %>').value += AssOther + "~" + AssDesc + "^";
                    document.getElementById('<%=txtAssocaitedothers.ClientID %>').value = '';
                    document.getElementById('<%=txtADDesc.ClientID %>').value = '';
                    AssociateStatus = 0;
                    return false;
                }
            }
            else {
             userMsg = SListForApplicationMessages.Get('ANC\\BaseLineHistory.aspx_9');
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 alert('Provide atleast one disease & description');
                 return false;
             }
                if (document.getElementById('<%=txtAssocaitedothers.ClientID %>').value == '') {
                    document.getElementById('<%=txtAssocaitedothers.ClientID %>').focus();
                }
                else {
                    document.getElementById('<%=txtADDesc.ClientID %>').focus();
                }
                return false;
            }
            if (AssociateStatus == 0) {

                var row = document.getElementById('<%=tblAssociate.ClientID %>').insertRow(1);
                row.id = AssOther;
                //alert(row.id);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn2' style='cursor:pointer;' OnClick=AssDeleteclick('" + escape(AssOther) + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = AssOther;
                cell3.innerHTML = AssDesc;
                document.getElementById('<%=HdnAssociate.ClientID %>').value += AssOther + "~" + AssDesc + "^";
                document.getElementById('<%=txtAssocaitedothers.ClientID %>').value = '';
                document.getElementById('<%=txtADDesc.ClientID %>').value = '';
                return false;
            }
            else if (AssociateStatus == 1) {
             userMsg = SListForApplicationMessages.Get('ANC\\BaseLineHistory.aspx_10');
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 alert('Already added');
                 return false;
             }
                document.getElementById('<%=txtAssocaitedothers.ClientID %>').value = '';
                document.getElementById('<%=txtADDesc.ClientID %>').value = '';
                document.getElementById('<%=txtAssocaitedothers.ClientID %>').focus();
                return false;
            }
        }

        function AssDeleteclick(ADelItem) {
            document.getElementById(unescape(ADelItem)).style.display = "none";
            var HidAssValue = document.getElementById('<%=HdnAssociate.ClientID %>').value;
            var Assplist = HidAssValue.split('^');
            var newAssList = '';
            if (document.getElementById('<%=HdnAssociate.ClientID %>').value != "") {
                for (var Asscount = 0; Asscount < Assplist.length; Asscount++) {
                    var AccociateList = Assplist[Asscount].split('~');
                    if (AccociateList[0] != '') {
                        if (AccociateList[0] != ADelItem) {
                            newAssList += Assplist[Asscount] + "^";
                        }
                    }
                }
                document.getElementById('<%=HdnAssociate.ClientID %>').value = newAssList;
            }
            //alert(newAssList);
        }



        // Prior Vaccinations

        function LoadPriorVaccinationsItems() {
            var HidVaccinationsValue = document.getElementById('<%=HdnVaccination.ClientID %>').value;
            //alert(HidVaccinationsValue);
            var PriorList = HidVaccinationsValue.split('^');
            if (document.getElementById('<%=HdnVaccination.ClientID %>').value != "") {

                for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                    var PriVacList = PriorList[pvCount].split('~');

                    var rowV = document.getElementById('<%=tblPriorVaccinations.ClientID %>').insertRow(1);
                    var icoutV = document.getElementById('<%=tblPriorVaccinations.ClientID %>').rows.length;
                    rowV.id = icoutV;

                    rowV.id = PriVacList[0];
                    //alert(PriVacList[0]);
                    var cell1 = rowV.insertCell(0);
                    var cell2 = rowV.insertCell(1);
                    var cell3 = rowV.insertCell(2);
                    var cell4 = rowV.insertCell(3);
                    var cell5 = rowV.insertCell(4);
                    var cell6 = rowV.insertCell(5);
                    var cell7 = rowV.insertCell(6);
                    //alert(PriVacList[0]);
                    cell1.innerHTML = "<img id='imgbtnLPV' style='cursor:pointer;' OnClick='PriorDeleteclick(" + PriVacList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = PriVacList[1];
                    cell3.innerHTML = PriVacList[2];
                    cell4.innerHTML = PriVacList[3];
                    cell5.innerHTML = PriVacList[4];
                    cell6.innerHTML = PriVacList[5];
                    //cell6.style.display = "none";
                    cell7.innerHTML = PriVacList[6];
                    cell7.style.display = "none";
                }
            }
            return false;
        }


        function PriorVaccinationsItems() {
            if (document.getElementById('<%=txtYear.ClientID %>').value != '') {
                var VaccinationStatus = 0;
                var HidVaccinationValue = document.getElementById('<%=HdnVaccination.ClientID %>').value;
                var Vacclist = HidVaccinationValue.split('^');
                var ddlVaccination = document.getElementById('<%=drpVaccination.ClientID %>').options[document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex].text;
                var ddlVaccinationid = document.getElementById('<%=drpVaccination.ClientID %>').value;
                var Year = document.getElementById('<%=txtYear.ClientID %>').value;
                var ddlMonth = document.getElementById('<%=drpMonth.ClientID %>').options[document.getElementById('<%=drpMonth.ClientID %>').selectedIndex].text;
                var Doses = document.getElementById('<%=txtDoses.ClientID %>').value;
                var Booster;
                if (document.getElementById('<%=chkBooster.ClientID %>').checked == true) {

                    Booster = 'Yes';
                }
                else { Booster = 'No'; }
                var vrow = document.getElementById('<%=tblPriorVaccinations.ClientID %>').insertRow(1);
                var vrCount = document.getElementById('<%=tblPriorVaccinations.ClientID %>').rows.length;
                vrow.id = vrCount;
                //alert(row.id);
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
                document.getElementById('<%=HdnVaccination.ClientID %>').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
                document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtYear.ClientID %>').value = '';
                document.getElementById('<%=drpMonth.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtDoses.ClientID %>').value = '';
                document.getElementById('<%=chkBooster.ClientID %>').checked = false;
                VaccinationStatus = 0;
                return false;
            }
            else {
            userMsg = SListForApplicationMessages.Get('ANC\\BaseLineHistory.aspx_11');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Provide the year for corresponding dose');
                return false;
            }
                document.getElementById('<%=txtYear.ClientID %>').focus();
                return false;
            }
            if (VaccinationStatus == 0) {

                var vrowv = document.getElementById('<%=tblPriorVaccinations.ClientID %>').insertRow(1);
                var vrCount = document.getElementById('<%=tblPriorVaccinations.ClientID %>').rows.length;
                vrowv.id = vrCount;
                //alert(row.id);
                var cell1 = vrowv.insertCell(0);
                var cell2 = vrowv.insertCell(1);
                var cell3 = vrowv.insertCell(2);
                var cell4 = vrowv.insertCell(3);
                var cell5 = vrowv.insertCell(4);
                var cell6 = vrowv.insertCell(5);
                var cell7 = vrowv.insertCell(6);
                cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = ddlVaccination;
                cell3.innerHTML = Year;
                cell4.innerHTML = ddlMonth;
                cell5.innerHTML = Doses;
                cell6.innerHTML = Booster;
                cell7.innerHTML = ddlVaccinationid;
                cell7.style.display = "none";
                document.getElementById('<%=HdnVaccination.ClientID %>').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";
                document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtYear.ClientID %>').value = '';
                document.getElementById('<%=drpMonth.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtDoses.ClientID %>').value = '';
                document.getElementById('<%=chkBooster.ClientID %>').checked = false;
                VaccinationStatus = 0;
                return false;
            }
        }

        function PriorDeleteclick(PriorDelItem) {
            //alert(PriorDelItem);
            document.getElementById(PriorDelItem).style.display = "none";
            var HidVacValue = document.getElementById('<%=HdnVaccination.ClientID %>').value;
            //alert(HidVacValue);
            var pVlist = HidVacValue.split('^');
            var newVaccList = '';
            if (document.getElementById('<%=HdnVaccination.ClientID %>').value != "") {
                for (var pvCountV = 0; pvCountV < pVlist.length; pvCountV++) {
                    var priorListV = pVlist[pvCountV].split('~');
                    //alert(priorList[0]);
                    if (priorListV[0] != '') {
                        if (priorListV[0] != PriorDelItem) {
                            newVaccList += pVlist[pvCountV] + "^";
                            //alert('New = ' + newVaccList);
                        }
                    }
                }
                document.getElementById('<%=HdnVaccination.ClientID %>').value = newVaccList;
            }
            //alert(newVaccList);
        }
        
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <%--<uc7:Header ID="UsrHeader1" runat="server" />--%>
                <uc11:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:leftmenu id="LeftMenu1" runat="server" />
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
                    <div class="contentdata" id="dMain">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor" width="100%">
                                    <tr>
                                        <td>
                                            <uc10:PatientVitals ID="PatientVitalsControl" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plus1" style="display: none">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_PregnancyDetails" 
                                                                Text="Pregnancy Details" runat="server" 
                                                                meta:resourcekey="Rs_PregnancyDetailsResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minus1" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_PregnancyDetails1" 
                                                                Text="Pregnancy Details" runat="server" 
                                                                meta:resourcekey="Rs_PregnancyDetails1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses1" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                            <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="100%">
                                                                <tr>
                                                                    <td style="width: 20%">
                                                                        <asp:Label ID="lblPregnancy" runat="server" Text="Pregnancy" 
                                                                            meta:resourcekey="lblPregnancyResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 18%">
                                                                        <asp:DropDownList ID="drpPregnancy" runat="server"
                                                                          CssClass ="ddlsmall"   onchange="toggleDropDownDiv('drpPregnancy','tblPregnancy');" 
                                                                            meta:resourcekey="drpPregnancyResource1">
                                                                            <asp:ListItem Text="Select" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                            <asp:ListItem Text="Confirmed" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                            <asp:ListItem Text="To re-confirm" Value="2" 
                                                                                meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                            <asp:ListItem Text="Yet to confirm" Value="3" 
                                                                                meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td style="width: 62%">
                                                                        <table id="tblPregnancy" border="0" cellpadding="0" cellspacing="0" style="display: none;"
                                                                            width="66%">
                                                                            <tr>
                                                                                <td style="width: 25%">
                                                                                    <asp:CheckBox ID="chkIsPrimipara" runat="server" Text="Primipara" 
                                                                                        meta:resourcekey="chkIsPrimiparaResource1" />
                                                                                </td>
                                                                                <td style="width: 75%">
                                                                                    <asp:CheckBox ID="chkIsBad" runat="server" Text="Bad Obstretic History" 
                                                                                        meta:resourcekey="chkIsBadResource1" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblEnterDateofLMP" runat="server" Text="Date of LMP" 
                                                                            meta:resourcekey="lblEnterDateofLMPResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                            TargetControlID="tLMP" CultureAMPMPlaceholder="" 
                                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                                            TargetControlID="tLMP" Enabled="True" />
                                                                        <asp:TextBox ID="tLMP" runat="server" onblur="calculateANCWeeks()"  CssClass ="Txtboxsmall"
                                                                            MaxLength="1" Style="text-align: justify" TabIndex="4" 
                                                                            ValidationGroup="MKE" meta:resourcekey="tLMPResource1" />
                                                                        <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" 
                                                                            ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                            meta:resourcekey="ImgBntCalcResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="tLMP" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                                            InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                                            meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblCalculatedEDD" runat="server" Text="Calculated EDD" 
                                                                            meta:resourcekey="lblCalculatedEDDResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                            TargetControlID="txtCalculatedEDD" CultureAMPMPlaceholder="" 
                                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc1"
                                                                            TargetControlID="txtCalculatedEDD" Enabled="True" />
                                                                        <asp:TextBox ID="txtCalculatedEDD" runat="server"  CssClass ="Txtboxsmall"
                                                                            meta:resourcekey="txtCalculatedEDDResource1"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImgBntCalc1" runat="server" CausesValidation="False" 
                                                                            ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                            meta:resourcekey="ImgBntCalc1Resource1" />
                                                                    </td>
                                                                    <td>
                                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtCalculatedEDD" Display="Dynamic" EmptyValueBlurredText="*"
                                                                            EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" 
                                                                            ErrorMessage="MaskedEditValidator1" 
                                                                            meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 20%">
                                                                        <asp:Label ID="lblANCWeeks" Style="display: none" Text="Antenatal Weeks" 
                                                                            runat="server" meta:resourcekey="lblANCWeeksResource1"></asp:Label>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:TextBox ID="txtANCWeeks" ReadOnly="True" Style="display: none" Width="30px"
                                                                            runat="server" meta:resourcekey="txtANCWeeksResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label3" Text="Blood Group" runat="server" 
                                                                            meta:resourcekey="Label3Resource1"></asp:Label>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:DropDownList ID="txtBloodGroup"  runat="server" TabIndex="12"
                                                                           CssClass ="ddl" meta:resourcekey="txtBloodGroupResource1">
                                                                            <asp:ListItem Value="-1" meta:resourcekey="ListItemResource5">Select</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource6">O+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource7">A+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource8">B+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource9">O-</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource10">A-</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource11">B-</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource12">A1+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource13">A1-</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource14">AB+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource15">AB-</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource16">A1B+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource17">A1B-</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource18">A2+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource19">A2-</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource20">A2B+</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource21">A2B-</asp:ListItem>
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
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="left" height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plus6" style="display: none">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_BaselineHistory" 
                                                                Text="Baseline History" runat="server" 
                                                                meta:resourcekey="Rs_BaselineHistoryResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minus6" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus6','ACX2minus6','ACX2responses6',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_BaselineHistory1" 
                                                                Text="Baseline History" runat="server" 
                                                                meta:resourcekey="Rs_BaselineHistory1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses6" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                            <table border="0" cellpadding="0" cellspacing="4" width="100%" class="tabletxt">
                                                                <tr>
                                                                    <td>
                                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                <td style="width: 10%">
                                                                                    &nbsp;<asp:Label ID="lblGravida" runat="server" Text="Gravida" 
                                                                                        meta:resourcekey="lblGravidaResource1"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 10%">
                                                                                    &nbsp;<asp:TextBox ID="txtGravida" MaxLength="2" runat="server" width="120px"
                                                                                       CssClass ="Txtboxsmall" meta:resourcekey="txtGravidaResource1"></asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 10%">
                                                                                    <asp:Label ID="lblPara" runat="server" Text="Para" 
                                                                                        meta:resourcekey="lblParaResource1"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 10%">
                                                                                    <asp:TextBox ID="txtPara" runat="server" MaxLength="2"  CssClass ="Txtboxsmall" width="120px"
                                                                                        meta:resourcekey="txtParaResource1"></asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 19%">
                                                                                    &nbsp;&nbsp;<asp:Label ID="lblAbortUs" runat="server" Text="AbortUs" 
                                                                                        meta:resourcekey="lblAbortUsResource1"></asp:Label>
                                                                                    &nbsp;&nbsp;<asp:TextBox ID="txtAbortUs" MaxLength="2" runat="server"  width="120px"
                                                                                        CssClass ="Txtboxsmall" meta:resourcekey="txtAbortUsResource1"></asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 10%">
                                                                                    &nbsp;<asp:Label ID="lblLive" runat="server" Text="Live" 
                                                                                        meta:resourcekey="lblLiveResource1"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 13%">
                                                                                    <asp:TextBox ID="txtLive" runat="server" MaxLength="2"  CssClass ="Txtboxsmall"  width="120px"
                                                                                        meta:resourcekey="txtLiveResource1"></asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 10%">
                                                                                    &nbsp;<asp:Label ID="lblGPALOthers" runat="server" Text="Others" 
                                                                                        meta:resourcekey="lblGPALOthersResource1"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 13%">
                                                                                    <asp:TextBox ID="txtGPALOthers" runat="server" MaxLength="50"  CssClass ="Txtboxsmall"  width="120px"
                                                                                       meta:resourcekey="txtGPALOthersResource1"></asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 9%" align="center">
                                                                                    <a id="hrfMDetails" runat="server" name="More" onclick="toggleDiv('divBaseLine');"
                                                                                        style="cursor: pointer;">More&gt;&gt;</a>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div id="divBaseLine" style="display: none;">
                                                                            <asp:HiddenField ID="HidBaseLine" runat="server" />
                                                                            <table border="0" cellpadding="0" cellspacing="4" width="100%">
                                                                                <tr>
                                                                                    <td style="width: 12%">
                                                                                        <asp:Label ID="lblSexofChild" runat="server" Text="Sex Of Child" 
                                                                                            meta:resourcekey="lblSexofChildResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 11%">
                                                                                        <asp:DropDownList ID="drdSOC" runat="server" CssClass="ddlTheme" 
                                                                                            OnSelectedIndexChanged="drdSOC_SelectedIndexChanged" 
                                                                                            meta:resourcekey="drdSOCResource1">
                                                                                            <asp:ListItem Text="Male" meta:resourcekey="ListItemResource22"></asp:ListItem>
                                                                                            <asp:ListItem Text="Female" meta:resourcekey="ListItemResource23"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td style="width: 13%">
                                                                                        <asp:Label ID="lblAge" runat="server" Text="Age (in yrs)" 
                                                                                            meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 13%">
                                                                                        <asp:TextBox ID="txtAge" MaxLength="3" runat="server" CssClass="textfield1" 
                                                                                            meta:resourcekey="txtAgeResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td style="width: 20%">
                                                                                        <asp:Label ID="lblMOD" runat="server" Text="Mode Of Delivery" 
                                                                                            meta:resourcekey="lblMODResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 22%">
                                                                                        <asp:DropDownList ID="drpMOD" runat="server" CssClass="ddlTheme" 
                                                                                            OnSelectedIndexChanged="drpMOD_SelectedIndexChanged" 
                                                                                            meta:resourcekey="drpMODResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td style="width: 10%">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblBwt" runat="server" Text="Birth Weight" 
                                                                                            meta:resourcekey="lblBwtResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtBwt" MaxLength="3" runat="server" Width="20px" 
                                                                                            CssClass="textfield1" meta:resourcekey="txtBwtResource1"></asp:TextBox>Kg
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblBMaturity" runat="server" Text="Birth Maturity" 
                                                                                            meta:resourcekey="lblBMaturityResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="drpBMaturity" runat="server" CssClass="ddlTheme" 
                                                                                            OnSelectedIndexChanged="drpBMaturity_SelectedIndexChanged" 
                                                                                            meta:resourcekey="drpBMaturityResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:CheckBox ID="chkIsGrowth" runat="server" Text="IsGrowth Ab Normal?" 
                                                                                            meta:resourcekey="chkIsGrowthResource1" />
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblGrowthRate" Visible="False" runat="server" Text="Growth Rate" 
                                                                                            meta:resourcekey="lblGrowthRateResource1"></asp:Label>
                                                                                        <asp:TextBox ID="txtGrowthRate" Text="0" runat="server" Visible="False" 
                                                                                            CssClass="textfield1" meta:resourcekey="txtGrowthRateResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Button ID="btnAddOne" runat="server" CssClass="btn" OnClientClick="return BaseLineItems();"
                                                                                            onmouseout="this.className='btn'" 
                                                                                            onmouseover="this.className='btn btnhov'" Text="Add" 
                                                                                            meta:resourcekey="btnAddOneResource1" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="right" colspan="6">
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <br />
                                                            <br />
                                                            <table id="tblBaseLine" class="dataheaderInvCtrl" runat="server" width="100%" cellspacing="0"
                                                                border="2">
                                                                <tr class="colorforcontent" runat="server">
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;" 
                                                                        runat="server">
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;" 
                                                                        runat="server">
                                                                        <asp:Label ID="Rs_SexofChild" Text="Sex of Child" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;" 
                                                                        runat="server">
                                                                        <asp:Label ID="Rs_Age" Text="Age" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                        runat="server">
                                                                       <asp:Label ID="Rs_MOD" Text="M O D" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 13%;" 
                                                                        runat="server">
                                                                        <asp:Label ID="Rs_BirthWeight" Text="Birth Weight" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 11%;" 
                                                                        runat="server">
                                                                       <asp:Label ID="Rs_GrowthNormal" Text="Growth Normal" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;
                                                                        display: none;" runat="server">
                                                                        <asp:Label ID="Rs_GrowthRate" Text="Growth Rate" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;" 
                                                                        runat="server">
                                                                       <asp:Label ID="Rs_BirthMaturity" Text="Birth Maturity" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 3%;
                                                                        display: none;" runat="server">
                                                                       <asp:Label ID="Rs_MODID" Text="MODID" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 3%;
                                                                        display: none;" runat="server">
                                                                        <asp:Label ID="Rs_BMID" Text="BMID" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="left" height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plus2" style="display: none; width: 350px;">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);"
                                                                style="cursor: pointer">
                                                            <asp:Label ID="Rs_PreviousComplicationsinPregnancies" 
                                                                Text="Previous Complications in Pregnancies" runat="server" 
                                                                meta:resourcekey="Rs_PreviousComplicationsinPregnanciesResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minus2" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);"
                                                                style="cursor: pointer">
                                                            <asp:Label ID="Rs_PreviousComplicationsinPregnancies1" 
                                                                Text="Previous Complications in Pregnancies" runat="server" 
                                                                meta:resourcekey="Rs_PreviousComplicationsinPregnancies1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses2" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                            <asp:HiddenField ID="HdnPreviousComplicate" runat="server" />
                                                            <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="100%">
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:CheckBoxList ID="PCP" runat="server" class="defaultfontcolor"
                                                                            RepeatColumns="4" RepeatDirection="Horizontal" 
                                                                            meta:resourcekey="PCPResource1">
                                                                        </asp:CheckBoxList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 21%">
                                                                        <asp:Label ID="lblothers" runat="server" Text="Others" 
                                                                            meta:resourcekey="lblothersResource1"></asp:Label>
                                                                        <asp:TextBox ID="txtothers" runat="server"  CssClass ="Txtboxsmall"
                                                                            meta:resourcekey="txtothersResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 79%">
                                                                        <asp:Button ID="btnAddPregn" runat="server" CssClass="btn" OnClientClick="return PreviousComplicatedItems();"
                                                                            onmouseout="this.className='btn'" 
                                                                            onmouseover="this.className='btn btnhov'" Text="Add" 
                                                                            meta:resourcekey="btnAddPregnResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <br />
                                                            <br />
                                                            <table id="tblPreviousComplicate" class="dataheaderInvCtrl" runat="server" width="50%"
                                                                cellspacing="0" border="2">
                                                                <tr class="colorforcontent" runat="server">
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;" 
                                                                        runat="server">
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 25%;" 
                                                                        runat="server">
                                                                        <asp:Label ID="Rs_ComplicationName" Text="Complication Name" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plus3" style="display: none">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);"
                                                                src="../Images/showbids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_AssociatedDiseases" 
                                                                Text="Associated Diseases" runat="server" 
                                                                meta:resourcekey="Rs_AssociatedDiseasesResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minus3" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_AssociatedDiseases1" 
                                                                Text="Associated Diseases" runat="server" 
                                                                meta:resourcekey="Rs_AssociatedDiseases1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses3" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                            <asp:HiddenField ID="HdnAssociate" runat="server" />
                                                            <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="100%">
                                                                <tr>
                                                                    <td colspan="5" height="25px">
                                                                        <asp:Panel ID="pnlTVH" runat="server" meta:resourcekey="pnlTVHResource1">
                                                                            <asp:TreeView ID="TVH" runat="server" OnSelectedNodeChanged="TVH_SelectedNodeChanged"
                                                                                OnTreeNodeCheckChanged="TVH_TreeNodeCheckChanged" Width="31px" 
                                                                                NodeIndent="25" meta:resourcekey="TVHResource2">
                                                                                <ParentNodeStyle CssClass="details_value3" />
                                                                                <Nodes>
                                                                                    <asp:TreeNode ImageUrl="~/Images/whitebg.png" SelectAction="None" Value="0" 
                                                                                        meta:resourcekey="TreeNodeResource1"></asp:TreeNode>
                                                                                </Nodes>
                                                                                <RootNodeStyle CssClass="details_value4" />
                                                                            </asp:TreeView>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 8%">
                                                                        <asp:Label ID="lblAssociatedothers" runat="server" Text="Others" 
                                                                            meta:resourcekey="lblAssociatedothersResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 16%">
                                                                        <asp:TextBox ID="txtAssocaitedothers" runat="server"  CssClass ="Txtboxsmall"  width="120px"
                                                                            Style="width: 100px;" meta:resourcekey="txtAssocaitedothersResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 12%">
                                                                        <asp:Label ID="lblADDesc" runat="server" Text="Description" 
                                                                            meta:resourcekey="lblADDescResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 12%">
                                                                        <asp:TextBox ID="txtADDesc" runat="server"  CssClass ="Txtboxsmall"
                                                                             meta:resourcekey="txtADDescResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 52%">
                                                                        <asp:Button ID="btnAssDiseases" runat="server" CssClass="btn" OnClientClick="return AssociateDieasesItems();"
                                                                            onmouseout="this.className='btn'" 
                                                                            onmouseover="this.className='btn btnhov'" Text="Add" 
                                                                            meta:resourcekey="btnAssDiseasesResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <br />
                                                            <br />
                                                            <table id="tblAssociate" class="dataheaderInvCtrl" runat="server" width="50%" cellspacing="0"
                                                                border="2">
                                                                <tr class="colorforcontent" runat="server">
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;" 
                                                                        runat="server">
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 25%;" 
                                                                        runat="server">
                                                                        <asp:Label ID="Rs_Others" Text="Others" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 25%;" 
                                                                        runat="server">
                                                                       <asp:Label ID="Rs_Description" Text="Description" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="left" height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plus4" style="display: none">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_PriorVaccinations" 
                                                                Text="Prior Vaccinations" runat="server" 
                                                                meta:resourcekey="Rs_PriorVaccinationsResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minus4" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus4','ACX2minus4','ACX2responses4',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_PriorVaccinations1" 
                                                                Text="Prior Vaccinations" runat="server" 
                                                                meta:resourcekey="Rs_PriorVaccinations1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses4" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                            <table border="0" cellpadding="0" cellspacing="4" class="tabletxt" width="100%">
                                                                <tr>
                                                                    <td style="width: 12%">
                                                                        <asp:Label ID="lblVacc" runat="server" Text="Vaccination" 
                                                                            meta:resourcekey="lblVaccResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="style6">
                                                                        <asp:DropDownList ID="drpVaccination"  CssClass="ddlsmall" runat="server" 
                                                                            meta:resourcekey="drpVaccinationResource1">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td class="style7">
                                                                        <asp:Label ID="lblYear" runat="server" Text="Year" 
                                                                            meta:resourcekey="lblYearResource1"></asp:Label>
                                                                        &nbsp;&nbsp;
                                                                        <asp:TextBox ID="txtYear" MaxLength="4" runat="server"  CssClass ="Txtboxverysmall"
                                                                            size="5" meta:resourcekey="txtYearResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 7%">
                                                                        <asp:Label ID="lblMonth" runat="server" Text="Month" 
                                                                            meta:resourcekey="lblMonthResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 28%">
                                                                        <asp:DropDownList ID="drpMonth"  CssClass ="ddlsmall" runat="server" 
                                                                            meta:resourcekey="drpMonthResource1">
                                                                            <asp:ListItem Text="January" Value="1" meta:resourcekey="ListItemResource24"></asp:ListItem>
                                                                            <asp:ListItem Text="Febrauary" Value="2" meta:resourcekey="ListItemResource25"></asp:ListItem>
                                                                            <asp:ListItem Text="March" Value="3" meta:resourcekey="ListItemResource26"></asp:ListItem>
                                                                            <asp:ListItem Text="April" Value="4" meta:resourcekey="ListItemResource27"></asp:ListItem>
                                                                            <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource28"></asp:ListItem>
                                                                            <asp:ListItem Text="June" Value="6" meta:resourcekey="ListItemResource29"></asp:ListItem>
                                                                            <asp:ListItem Text="July" Value="7" meta:resourcekey="ListItemResource30"></asp:ListItem>
                                                                            <asp:ListItem Text="August" Value="8" meta:resourcekey="ListItemResource31"></asp:ListItem>
                                                                            <asp:ListItem Text="September" Value="9" meta:resourcekey="ListItemResource32"></asp:ListItem>
                                                                            <asp:ListItem Text="October" Value="10" meta:resourcekey="ListItemResource33"></asp:ListItem>
                                                                            <asp:ListItem Text="November" Value="11" meta:resourcekey="ListItemResource34"></asp:ListItem>
                                                                            <asp:ListItem Text="December" Value="12" meta:resourcekey="ListItemResource35"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblDoses" runat="server" Text="Doses" 
                                                                            meta:resourcekey="lblDosesResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="style6">
                                                                        <asp:TextBox ID="txtDoses" MaxLength="10" runat="server"  CssClass ="Txtboxverysmall"
                                                                            size="5" meta:resourcekey="txtDosesResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td class="style7">
                                                                        <asp:CheckBox ID="chkBooster" runat="server" Text="Is a Booster?" 
                                                                            meta:resourcekey="chkBoosterResource1" />
                                                                    </td>
                                                                    <td colspan="4" align="left">
                                                                        <asp:Button ID="btnAdd" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                                            OnClientClick="return PriorVaccinationsItems();" onmouseover="this.className='btn btnhov'"
                                                                            Text="Add" meta:resourcekey="btnAddResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:HiddenField ID="HdnVaccination" runat="server" />
                                                            <br />
                                                            <br />
                                                            <table id="tblPriorVaccinations" class="dataheaderInvCtrl" runat="server" width="100%"
                                                                cellspacing="0" border="2">
                                                                <tr class="colorforcontent" runat="server">
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;" 
                                                                        runat="server">
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 30%;" 
                                                                        runat="server">
                                                                      <asp:Label ID="Rs_Vaccination" Text="Vaccination" runat="server"></asp:Label>
                                                                    </td>
                                                                    
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;" 
                                                                        runat="server">
                                                                        <asp:Label ID="Rs_Year" Text="Year" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                        runat="server">
                                                                       <asp:Label ID="Rs_Month" Text="Month" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;" 
                                                                        runat="server">
                                                                       <asp:Label ID="Rs_Doses" Text="Doses" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;" 
                                                                        runat="server">
                                                                       <asp:Label ID="Rs_Booster" Text="Booster" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                                                                        display: none;" runat="server">
                                                                        <asp:Label ID="Rs_VaccinationID" Text="Vaccination ID" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="left" height="23" class="colorforcontent" width="25%">
                                                        <div id="ACX2plusInv" style="display: none">
                                                            &nbsp;<img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Investigation" 
                                                                Text="Investigation" runat="server" 
                                                                meta:resourcekey="Rs_InvestigationResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minusInv" style="display: block">
                                                            &nbsp;<img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plusInv','ACX2minusInv','ACX2responsesInv',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Investigation1" 
                                                                Text="Investigation" runat="server" 
                                                                meta:resourcekey="Rs_Investigation1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responsesInv" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                           <asp:Label ID="Rs_InvestigationsOrdered" Text="Investigations Ordered" 
                                                                runat="server" meta:resourcekey="Rs_InvestigationsOrderedResource1"></asp:Label>
                                                            <br />
                                                            <asp:DataList ID="dlInvName" runat="server" CellPadding="4" GridLines="Horizontal"
                                                                RepeatColumns="5" RepeatDirection="Horizontal" 
                                                                meta:resourcekey="dlInvNameResource1">
                                                                <ItemTemplate>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                                            </td>
                                                                            <td>
                                                                                <%# DataBinder.Eval(Container.DataItem, "Status")%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                            <br />
                                                            <asp:CheckBoxList CssClass="defaultfontcolor" ID="chkInvestigation" RepeatColumns="5"
                                                                runat="server" meta:resourcekey="chkInvestigationResource1">
                                                            </asp:CheckBoxList>
                                                            <br />
                                                           <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                                               <asp:Label ID="Rs_Info" Text="Order More Investigations..." runat="server" 
                                                                meta:resourcekey="Rs_InfoResource1"></asp:Label></label>
                                                            <br />
                                                            <br />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="left" height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plusPhy" style="display: none">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusPhy','ACX2minusPhy','ACX2responsesPhy',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plusPhy','ACX2minusPhy','ACX2responsesPhy',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Physiotheraphy" 
                                                                Text="Physiotheraphy" runat="server" 
                                                                meta:resourcekey="Rs_PhysiotheraphyResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minusPhy" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusPhy','ACX2minusPhy','ACX2responsesPhy',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plusPhy','ACX2minusPhy','ACX2responsesPhy',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Physiotheraphy1" 
                                                                Text="Physiotheraphy" runat="server" 
                                                                meta:resourcekey="Rs_Physiotheraphy1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responsesPhy" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                          
                                                            <asp:Label ID="lblPhyOrdered" runat="server" 
                                                                meta:resourcekey="lblPhyOrderedResource1"></asp:Label>
                                                            <br />
                                                            <br />
                                                            <asp:CheckBox ID="chkPHYSIOTHERAPY" Text="Physiotherapy" runat="server" 
                                                                meta:resourcekey="chkPHYSIOTHERAPYResource1" />
                                                            <br />
                                                            <br />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="left" height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plus7" style="display: none">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Ultrasonography" 
                                                                Text="Ultrasonography" runat="server" 
                                                                meta:resourcekey="Rs_UltrasonographyResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minus7" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus7','ACX2minus7','ACX2responses7',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Ultrasonography1" 
                                                                Text="Ultrasonography" runat="server" 
                                                                meta:resourcekey="Rs_Ultrasonography1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses7" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                            <table border="0" cellpadding="0" cellspacing="0" class="tabletxt" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <table border="0" cellpadding="0" cellspacing="4" width="100%">
                                                                            <tr>
                                                                                <td style="width: 18%">
                                                                                    <asp:Label ID="LblGest" runat="server" Text="Gestational Age" 
                                                                                        meta:resourcekey="LblGestResource1"></asp:Label>
                                                                                </td>
                                                                                <td class="style8" valign="middle">
                                                                                    <asp:Label ID="Label1" runat="server" Text="Weeks" 
                                                                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                                    <asp:DropDownList ID="drpweeks" CssClass ="ddl" runat="server" Width="75px" 
                                                                                        meta:resourcekey="drpweeksResource1">
                                                                                        <asp:ListItem Value="0" Text="Select" meta:resourcekey="ListItemResource36"></asp:ListItem>
                                                                                        <asp:ListItem Text="1" meta:resourcekey="ListItemResource37"></asp:ListItem>
                                                                                        <asp:ListItem Text="2" meta:resourcekey="ListItemResource38"></asp:ListItem>
                                                                                        <asp:ListItem Text="3" meta:resourcekey="ListItemResource39"></asp:ListItem>
                                                                                        <asp:ListItem Text="4" meta:resourcekey="ListItemResource40"></asp:ListItem>
                                                                                        <asp:ListItem Text="5" meta:resourcekey="ListItemResource41"></asp:ListItem>
                                                                                        <asp:ListItem Text="6" meta:resourcekey="ListItemResource42"></asp:ListItem>
                                                                                        <asp:ListItem Text="7" meta:resourcekey="ListItemResource43"></asp:ListItem>
                                                                                        <asp:ListItem Text="8" meta:resourcekey="ListItemResource44"></asp:ListItem>
                                                                                        <asp:ListItem Text="9" meta:resourcekey="ListItemResource45"></asp:ListItem>
                                                                                        <asp:ListItem Text="10" meta:resourcekey="ListItemResource46"></asp:ListItem>
                                                                                        <asp:ListItem Text="11" meta:resourcekey="ListItemResource47"></asp:ListItem>
                                                                                        <asp:ListItem Text="12" meta:resourcekey="ListItemResource48"></asp:ListItem>
                                                                                        <asp:ListItem Text="13" meta:resourcekey="ListItemResource49"></asp:ListItem>
                                                                                        <asp:ListItem Text="14" meta:resourcekey="ListItemResource50"></asp:ListItem>
                                                                                        <asp:ListItem Text="15" meta:resourcekey="ListItemResource51"></asp:ListItem>
                                                                                        <asp:ListItem Text="16" meta:resourcekey="ListItemResource52"></asp:ListItem>
                                                                                        <asp:ListItem Text="17" meta:resourcekey="ListItemResource53"></asp:ListItem>
                                                                                        <asp:ListItem Text="18" meta:resourcekey="ListItemResource54"></asp:ListItem>
                                                                                        <asp:ListItem Text="19" meta:resourcekey="ListItemResource55"></asp:ListItem>
                                                                                        <asp:ListItem Text="20" meta:resourcekey="ListItemResource56"></asp:ListItem>
                                                                                        <asp:ListItem Text="21" meta:resourcekey="ListItemResource57"></asp:ListItem>
                                                                                        <asp:ListItem Text="22" meta:resourcekey="ListItemResource58"></asp:ListItem>
                                                                                        <asp:ListItem Text="23" meta:resourcekey="ListItemResource59"></asp:ListItem>
                                                                                        <asp:ListItem Text="24" meta:resourcekey="ListItemResource60"></asp:ListItem>
                                                                                        <asp:ListItem Text="25" meta:resourcekey="ListItemResource61"></asp:ListItem>
                                                                                        <asp:ListItem Text="26" meta:resourcekey="ListItemResource62"></asp:ListItem>
                                                                                        <asp:ListItem Text="27" meta:resourcekey="ListItemResource63"></asp:ListItem>
                                                                                        <asp:ListItem Text="28" meta:resourcekey="ListItemResource64"></asp:ListItem>
                                                                                        <asp:ListItem Text="29" meta:resourcekey="ListItemResource65"></asp:ListItem>
                                                                                        <asp:ListItem Text="30" meta:resourcekey="ListItemResource66"></asp:ListItem>
                                                                                        <asp:ListItem Text="31" meta:resourcekey="ListItemResource67"></asp:ListItem>
                                                                                        <asp:ListItem Text="32" meta:resourcekey="ListItemResource68"></asp:ListItem>
                                                                                        <asp:ListItem Text="33" meta:resourcekey="ListItemResource69"></asp:ListItem>
                                                                                        <asp:ListItem Text="34" meta:resourcekey="ListItemResource70"></asp:ListItem>
                                                                                        <asp:ListItem Text="35" meta:resourcekey="ListItemResource71"></asp:ListItem>
                                                                                        <asp:ListItem Text="36" meta:resourcekey="ListItemResource72"></asp:ListItem>
                                                                                        <asp:ListItem Text="37" meta:resourcekey="ListItemResource73"></asp:ListItem>
                                                                                        <asp:ListItem Text="38" meta:resourcekey="ListItemResource74"></asp:ListItem>
                                                                                        <asp:ListItem Text="39" meta:resourcekey="ListItemResource75"></asp:ListItem>
                                                                                        <asp:ListItem Text="40" meta:resourcekey="ListItemResource76"></asp:ListItem>
                                                                                        <asp:ListItem Text="41" meta:resourcekey="ListItemResource77"></asp:ListItem>
                                                                                        <asp:ListItem Text="42" meta:resourcekey="ListItemResource78"></asp:ListItem>
                                                                                        <asp:ListItem Text="43" meta:resourcekey="ListItemResource79"></asp:ListItem>
                                                                                        <asp:ListItem Text="44" meta:resourcekey="ListItemResource80"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                    &nbsp;&nbsp;
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="lbldays" runat="server" Text="Days " 
                                                                                        meta:resourcekey="lbldaysResource1"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                    &nbsp;&nbsp;&nbsp; &nbsp;
                                                                                    <asp:DropDownList ID="drpDays"  CssClass ="ddl" runat="server" Height="19px" 
                                                                                        Width="67px" meta:resourcekey="drpDaysResource1">
                                                                                        <asp:ListItem Text="0" meta:resourcekey="ListItemResource81"></asp:ListItem>
                                                                                        <asp:ListItem Text="1" meta:resourcekey="ListItemResource82"></asp:ListItem>
                                                                                        <asp:ListItem Text="2" meta:resourcekey="ListItemResource83"></asp:ListItem>
                                                                                        <asp:ListItem Text="3" meta:resourcekey="ListItemResource84"></asp:ListItem>
                                                                                        <asp:ListItem Text="4" meta:resourcekey="ListItemResource85"></asp:ListItem>
                                                                                        <asp:ListItem Text="5" meta:resourcekey="ListItemResource86"></asp:ListItem>
                                                                                        <asp:ListItem Text="6" meta:resourcekey="ListItemResource87"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblPlacental" runat="server" Text="Placental Position" 
                                                                                        meta:resourcekey="lblPlacentalResource1"></asp:Label>
                                                                                </td>
                                                                                <td class="style8">
                                                                                    <asp:DropDownList ID="drpPlacental"  CssClass ="ddl" runat="server" 
                                                                                        meta:resourcekey="drpPlacentalResource1">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td class="style9">
                                                                                    <asp:Label ID="Label2" runat="server" Text="Date Of UltraSound" 
                                                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                                                                                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                                        TargetControlID="txtDateOfUltraSound" InputDirection="RightToLeft" 
                                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                                                        CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                                    <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcDt"
                                                                                        TargetControlID="txtDateOfUltraSound" Enabled="True" />
                                                                                    <asp:TextBox ID="txtDateOfUltraSound" runat="server" CssClass ="Txtboxsmall"  MaxLength="1"
                                                                                        Style="text-align: justify" TabIndex="4" ValidationGroup="MKE" 
                                                                                        meta:resourcekey="txtDateOfUltraSoundResource1" />
                                                                                    <asp:ImageButton ID="ImgBntCalcDt" runat="server" CausesValidation="False" 
                                                                                        ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                                                        meta:resourcekey="ImgBntCalcDtResource1" />
                                                                                    <ajc:MaskedEditValidator ID="M" runat="server" ControlExtender="MaskedEditExtender2"
                                                                                        ControlToValidate="txtDateOfUltraSound" Display="Dynamic" EmptyValueBlurredText="*"
                                                                                        EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                                        TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" ErrorMessage="M" 
                                                                                        meta:resourcekey="MResource1" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="lblOther" runat="server" Text="Other" 
                                                                                        meta:resourcekey="lblOtherResource1"></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                                    <asp:TextBox ID="txtOther1" runat="server"  CssClass ="Txtboxsmall" Width ="120px"
                                                                                        Style="width: 100px;" meta:resourcekey="txtOther1Resource1"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <asp:Label ID="lblMultiGest" runat="server" Text="No of Gestations" 
                                                                                        meta:resourcekey="lblMultiGestResource1"></asp:Label>
                                                                                </td>
                                                                                <td class="style8">
                                                                                    <asp:DropDownList ID="drpMultiGest" CssClass="ddlTheme" runat="server" 
                                                                                        Width="72px" meta:resourcekey="drpMultiGestResource1">
                                                                                        <asp:ListItem Text="Select" meta:resourcekey="ListItemResource88"></asp:ListItem>
                                                                                        <asp:ListItem Text="1" meta:resourcekey="ListItemResource89"></asp:ListItem>
                                                                                        <asp:ListItem Text="2" meta:resourcekey="ListItemResource90"></asp:ListItem>
                                                                                        <asp:ListItem Text="3" meta:resourcekey="ListItemResource91"></asp:ListItem>
                                                                                        <asp:ListItem Text="4" meta:resourcekey="ListItemResource92"></asp:ListItem>
                                                                                        <asp:ListItem Text="5" meta:resourcekey="ListItemResource93"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div id="divShow15" style="display: none">
                                                                            <table border="0" cellpadding="0" cellspacing="0">
                                                                                <tr>
                                                                                    <td height="28px" width="150px">
                                                                                        <asp:Label ID="lblDrugName" runat="server" Text="Drug Name" 
                                                                                            meta:resourcekey="lblDrugNameResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td width="150px">
                                                                                        <asp:Label ID="lblDrugDose" runat="server" Text="Drug Dose" 
                                                                                            meta:resourcekey="lblDrugDoseResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td width="150px">
                                                                                        <asp:Label ID="lblFrequency" runat="server" Text="Frequency" 
                                                                                            meta:resourcekey="lblFrequencyResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td width="150px">
                                                                                        <asp:Label ID="lblTakingSince" runat="server" Text="Taking Since" 
                                                                                            meta:resourcekey="lblTakingSinceResource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td height="28px">
                                                                                        <asp:TextBox ID="txtDrugName" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtDrugNameResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtDrugDose" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtDrugDoseResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtFrequency" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtFrequencyResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtTakingSince" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtTakingSinceResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblmonthsyears" runat="server" Text="months/years" 
                                                                                            meta:resourcekey="lblmonthsyearsResource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td height="28px">
                                                                                        <asp:TextBox ID="txtDrugName1" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtDrugName1Resource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtDrugDose1" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtDrugDose1Resource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtFrequency1" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtFrequency1Resource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtTakingSince1" runat="server" CssClass="textfieldi" 
                                                                                            meta:resourcekey="txtTakingSince1Resource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblmonthyears1" runat="server" Text="months/years" 
                                                                                            meta:resourcekey="lblmonthyears1Resource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="left" height="23" class="colorforcontent" width="30%">
                                                        <div id="ACX2plusObs" style="display: none">
                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusObs','ACX2minusObs','ACX2responsesObs',1);"
                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plusObs','ACX2minusObs','ACX2responsesObs',1);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Observation" Text="Observation" 
                                                                runat="server" meta:resourcekey="Rs_ObservationResource1"></asp:Label></span>
                                                        </div>
                                                        <div id="ACX2minusObs" style="display: block">
                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusObs','ACX2minusObs','ACX2responsesObs',0);"
                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plusObs','ACX2minusObs','ACX2responsesObs',0);"
                                                                style="cursor: pointer"><asp:Label ID="Rs_Observation1"  Text="Observation" 
                                                                runat="server" meta:resourcekey="Rs_Observation1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                    <td align="left" height="23" width="70%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responsesObs" class="tablerow" style="display: block">
                                                    <td colspan="2">
                                                        <div class="dataheader2">
                                                            &nbsp;&nbsp;
                                                            <br />
                                                            <asp:Label ID="lblObservation" runat="server" Text="Observation" 
                                                                CssClass="defaultfontcolor" meta:resourcekey="lblObservationResource1"></asp:Label>:
                                                            <asp:TextBox ID="txtObservation" runat="server" TextMode="MultiLine" 
                                                                meta:resourcekey="txtObservationResource1"></asp:TextBox>
                                                            <br />
                                                            <br />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnSave" Visible="False" runat="server" CssClass="btn" Text="Save"
                                                onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                OnClientClick="return validateBaseLineHistory();" OnClick="btnSave_Click" 
                                                meta:resourcekey="btnSaveResource1" />
                                            &nbsp; &nbsp;
                                            <asp:Button ID="btnCancel" Visible="False" runat="server" CssClass="btn" Text="Cancel"
                                                onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                            &nbsp;&nbsp;
                                            <asp:Button ID="btnPatientDiagnose" Visible="False" runat="server" CssClass="btn"
                                                Text="Patient Diagnose" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                OnClick="btnPatientDiagnose_Click" 
                                                meta:resourcekey="btnPatientDiagnoseResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div id="DivProfile" style="display: none;" class="contentdata">
                        <uc12:InvestigationControl ID="InvestigationControl1" runat="server" />
                        <input type="button" value="OK" id="Button1" runat="server" class="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="ShowProfile('DivProfile')" />
                        <input type="button" id="btnClose" value="Close" class="btn" onclick="ShowProfile('DivProfile')"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
        <input type="hidden" id="hdComplaint" value="H" runat="server" />
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" 
            meta:resourcekey="btnNoLogResource1" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
