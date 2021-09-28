<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BaselineScreeningHistory.aspx.cs"
    Inherits="ANC_BaselineScreeningHistory" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/DateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

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
            for (var i = 0; i < childChkBoxCount; i++) {
                childChkBoxes[i].checked = check;
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


       

    </script>

    <title></title>
    <style type="text/css">
        .style6
        {
            width: 17%;
        }
        .style7
        {
            width: 12%;
        }
        .style8
        {
            width: 168px;
        }
        .style9
        {
            width: 197px;
        }
        .style10
        {
            width: 5%;
            height: 8px;
        }
        .style11
        {
            width: 20%;
            height: 8px;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">

    <script type="text/javascript" language="javascript">

        // BaseLine Histroy ....

        function LoadBaseLineHistroyItems() {
            var HidLoadValue = document.getElementById('<%=HidBaseLine.ClientID %>').value;
            var list = HidLoadValue.split('^');
            if (document.getElementById('<%=HidBaseLine.ClientID %>').value != "") {
                for (var count = 0; count < list.length - 1; count++) {
                    var BaselineList = list[count].split('~');

                    var row = document.getElementById('<%=tblBaseLine.ClientID %>').insertRow(1);
                    row.id = BaselineList[1];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + BaselineList[1] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = BaselineList[1];
                    cell3.innerHTML = BaselineList[2];
                    cell4.innerHTML = BaselineList[3];
                    cell5.innerHTML = BaselineList[4];
                    cell6.innerHTML = BaselineList[5];
                    cell7.innerHTML = BaselineList[6];
                    cell7.style.display = "none";
                }
            }
            return false;
        }

        function BaseLineItems() {
            var BaseLineStatus = 0;
            var HidAddValue = document.getElementById('<%=HidBaseLine.ClientID %>').value;
            var ddlName = document.getElementById('<%=drdSOC.ClientID %>').options[document.getElementById('<%=drdSOC.ClientID %>').selectedIndex].text;
            var age = document.getElementById('<%=txtAge.ClientID %>').value;
            var ddlDeliveryName = document.getElementById('<%=drpMOD.ClientID %>').options[document.getElementById('<%=drdSOC.ClientID %>').selectedIndex].text;
            var weight = document.getElementById('<%=txtBwt.ClientID %>').value;
            var gnormal;
            if (document.getElementById('<%=chkIsGrowth.ClientID %>').checked == true) {

                gnormal = 'Normal';
            }
            else { gnormal = 'Abnormal'; }
            var grate = document.getElementById('<%=txtGrowthRate.ClientID %>').value;
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
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = ddlName;
            cell3.innerHTML = age;
            cell4.innerHTML = ddlDeliveryName;
            cell5.innerHTML = weight;
            cell6.innerHTML = gnormal;
            cell7.innerHTML = grate;
            document.getElementById('<%=HidBaseLine.ClientID %>').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "^";
            document.getElementById('<%=drdSOC.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtAge.ClientID %>').value = '';
            document.getElementById('<%=drpMOD.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtBwt.ClientID %>').value = '';
            document.getElementById('<%=drpBMaturity.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=chkIsGrowth.ClientID %>').checked = false;
            document.getElementById('<%=txtGrowthRate.ClientID %>').value = '';
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
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = ddlName;
                cell3.innerHTML = age;
                cell4.innerHTML = ddlDeliveryName;
                cell5.innerHTML = weight;
                cell6.innerHTML = gnormal;
                cell7.innerHTML = grate;
                document.getElementById('<%=HidBaseLine.ClientID %>').value += icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "^";
                document.getElementById('<%=drdSOC.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtAge.ClientID %>').value = '';
                document.getElementById('<%=drpMOD.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=txtBwt.ClientID %>').value = '';
                document.getElementById('<%=drpBMaturity.ClientID %>').selectedIndex = 0;
                document.getElementById('<%=chkIsGrowth.ClientID %>').checked = false;
                document.getElementById('<%=txtGrowthRate.ClientID %>').value = '';
                return false;
            }
        }
        function ImgDeleteclick(ImgDeleteID) {
            document.getElementById(ImgDeleteID).style.display = "none";
            var HidDeleteValue = document.getElementById('<%=HidBaseLine.ClientID %>').value;
            var list = HidDeleteValue.split('^');
            var newList = '';
            if (document.getElementById('<%=HidBaseLine.ClientID %>').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var BaseList = list[count].split('~');
                    if (BaseList[1] != '') {
                        if (BaseList[1] != ImgDeleteID) {
                            newList += list[count] + "^";
                        }
                    }
                }
                document.getElementById('<%=HidBaseLine.ClientID %>').value = newList;
            }
        }






        // Previous Complicate Function.....


        function LoadPreviousComplicateItems() {
            var HidPreviousCompValue = document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value;
            var PrevList = HidPreviousCompValue.split('^');
            if (document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value != "") {
                for (var Pcount = 0; Pcount < PrevList.length - 1; Pcount++) {
                    var PreviousCompList = PrevList[Pcount].split('~');
                    var row = document.getElementById('<%=tblPreviousComplicate.ClientID %>').insertRow(1);
                    row.id = PreviousCompList;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + PreviousCompList + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = PreviousCompList;
                    cell2.style.display = "none";
                }
            }
            return false;
        }


        function PreviousComplicatedItems() {
            var PreCompStatus = 0;
            var HidPreValue = document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value;
            var Prelist = HidPreValue.split('^');
            var CompName = document.getElementById('<%=txtothers.ClientID %>').value;
            if (document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value != "") {
                for (var count = 0; count < Prelist.length; count++) {
                    var PrelineList = Prelist[count].split('~');
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
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + CompName + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = CompName;
                document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value += CompName + "^";
                document.getElementById('<%=txtothers.ClientID %>').value = '';
                PreCompStatus = 0;
                return false;
            }
            if (PreCompStatus == 0) {
                var row = document.getElementById('<%=tblPreviousComplicate.ClientID %>').insertRow(1);
                row.id = CompName;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtns1' style='cursor:pointer;' OnClick=PreDeleteclick('" + CompName + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = CompName;
                document.getElementById('<%=HdnPreviousComplicate.ClientID %>').value += CompName + "^";
                document.getElementById('<%=txtothers.ClientID %>').value = '';
                return false;
            }
            else if (PreCompStatus == 1) {
                alert('Already added');
                document.getElementById('<%=txtothers.ClientID %>').value = '';
                document.getElementById('<%=txtothers.ClientID %>').focus();
                return false;
            }
        }

        function PreDeleteclick(DeleteItem) {
            document.getElementById(DeleteItem).style.display = "none";
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
                    row.id = DieasesList[1];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn2' style='cursor:pointer;' OnClick=AssDeleteclick('" + DieasesList[1] + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = DieasesList[1];
                    cell3.innerHTML = DieasesList[2];
                    cell3.style.display = "none";
                }
            }
            return false;
        }


        function AssociateDieasesItems() {
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
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn2' style='cursor:pointer;' OnClick=AssDeleteclick('" + AssOther + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = AssOther;
                cell3.innerHTML = AssDesc;
                document.getElementById('<%=HdnAssociate.ClientID %>').value += AssOther + "~" + AssDesc + "^";
                document.getElementById('<%=txtAssocaitedothers.ClientID %>').value = '';
                document.getElementById('<%=txtADDesc.ClientID %>').value = '';
                AssociateStatus = 0;
                return false;
            }
            if (AssociateStatus == 0) {

                var row = document.getElementById('<%=tblAssociate.ClientID %>').insertRow(1);
                row.id = AssOther;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn2' style='cursor:pointer;' OnClick=AssDeleteclick('" + AssOther + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = AssOther;
                cell3.innerHTML = AssDesc;
                document.getElementById('<%=HdnAssociate.ClientID %>').value += AssOther + "~" + AssDesc + "^";
                document.getElementById('<%=txtAssocaitedothers.ClientID %>').value = '';
                document.getElementById('<%=txtADDesc.ClientID %>').value = '';
                return false;
            }
            else if (AssociateStatus == 1) {
                alert('Already added');
                document.getElementById('<%=txtAssocaitedothers.ClientID %>').value = '';
                document.getElementById('<%=txtADDesc.ClientID %>').value = '';
                document.getElementById('<%=txtAssocaitedothers.ClientID %>').focus();
                return false;
            }
        }

        function AssDeleteclick(ADelItem) {
            document.getElementById(ADelItem).style.display = "none";
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
        }



        // Prior Vaccinations

        function LoadPriorVaccinationsItems() {
            var HidVaccinationsValue = document.getElementById('<%=HdnVaccination.ClientID %>').value;
            var PriorList = HidVaccinationsValue.split('^');
            if (document.getElementById('<%=HdnVaccination.ClientID %>').value != "") {
                for (var pvCount = 0; pvCount < PriorList.length - 1; pvCount++) {
                    var PriVacList = PriorList[pvCount].split('~');
                    var row = document.getElementById('<%=tblPriorVaccinations.ClientID %>').insertRow(1);
                    row.id = PriVacList[1];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + PriVacList[1] + "'); src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = PriVacList[1];
                    cell3.innerHTML = PriVacList[2];
                    cell4.innerHTML = PriVacList[3];
                    cell5.innerHTML = PriVacList[4];
                    cell6.innerHTML = PriVacList[5];
                    cell6.style.display = "none";
                }
            }
            return false;
        }


        function PriorVaccinationsItems() {
            var VaccinationStatus = 0;
            var HidVaccinationValue = document.getElementById('<%=HdnVaccination.ClientID %>').value;
            var Vacclist = HidVaccinationValue.split('^');
            var ddlVaccination = document.getElementById('<%=drpVaccination.ClientID %>').options[document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex].text;
            var Year = document.getElementById('<%=txtYear.ClientID %>').value;
            var ddlMonth = document.getElementById('<%=drpMonth.ClientID %>').options[document.getElementById('<%=drpMonth.ClientID %>').selectedIndex].text;
            var Doses = document.getElementById('<%=txtDoses.ClientID %>').value;
            var Booster;
            if (document.getElementById('<%=chkBooster.ClientID %>').checked == true) {

                Booster = 'Yes';
            }
            else { Booster = 'No'; }
            var row = document.getElementById('<%=tblPriorVaccinations.ClientID %>').insertRow(1);
            var vrCount = document.getElementById('<%=tblPriorVaccinations.ClientID %>').rows.length + 100;
            row.id = vrCount;
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
            cell1.width = "5%";
            cell2.innerHTML = ddlVaccination;
            cell3.innerHTML = Year;
            cell4.innerHTML = ddlMonth;
            cell5.innerHTML = Doses;
            cell6.innerHTML = Booster;
            document.getElementById('<%=HdnVaccination.ClientID %>').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "^";
            document.getElementById('<%=drpVaccination.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtYear.ClientID %>').value = '';
            document.getElementById('<%=drpMonth.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtDoses.ClientID %>').value = '';
            document.getElementById('<%=chkBooster.ClientID %>').checked = false;
            VaccinationStatus = 0;
            return false;
            if (VaccinationStatus == 0) {

                var row = document.getElementById('<%=tblPriorVaccinations.ClientID %>').insertRow(1);
                var vrCount = document.getElementById('<%=tblPriorVaccinations.ClientID %>').rows.length + 100;
                row.id = vrCount;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                cell1.innerHTML = "<img id='imgbtn23' style='cursor:pointer;' OnClick=PriorDeleteclick('" + vrCount + "'); src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = ddlVaccination;
                cell3.innerHTML = Year;
                cell4.innerHTML = ddlMonth;
                cell5.innerHTML = Doses;
                cell6.innerHTML = Booster;
                document.getElementById('<%=HdnVaccination.ClientID %>').value += vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "^";
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
            document.getElementById(PriorDelItem).style.display = "none";
            var HidVacValue = document.getElementById('<%=HdnVaccination.ClientID %>').value;
            var pVlist = HidVacValue.split('^');
            var newVaccList = '';
            if (document.getElementById('<%=HdnVaccination.ClientID %>').value != "") {
                for (var pvCount = 0; pvCount < pVlist.length; pvCount++) {
                    var priorList = pVlist[pvCount].split('~');
                    if (priorList[0] != '') {
                        if (priorList[0] != PriorDelItem) {
                            newVaccList += pVlist[pvCount] + "^";
                        }
                    }
                }
                document.getElementById('<%=HdnVaccination.ClientID %>').value = newVaccList;
            }
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
                <uc7:Header ID="UsrHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor" width="100%">
                                    <tr>
                                        <td>
                                            <div>
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
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
                                                                                Text="Pregnancy Details"  runat="server" 
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
                                                                                        <asp:DropDownList ID="drpPregnancy" runat="server"  CssClass ="ddlsmall"  
                                                                                            onchange="toggleDropDownDiv('drpPregnancy','tblPregnancy');" 
                                                                                            meta:resourcekey="drpPregnancyResource1">
                                                                                            <asp:ListItem Text="Select" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                            <asp:ListItem Text="Confirmed" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                            <asp:ListItem Text="To re-confirm" Value="3" 
                                                                                                meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                                            <asp:ListItem Text="Yet to confirm" Value="4" 
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
                                                                                                    <asp:CheckBox ID="chkIsBad" runat="server" Text="Bad Obstretic" 
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
                                                                                        <asp:TextBox ID="tLMP" runat="server"  CssClass ="Txtboxsmall" MaxLength="1" Style="text-align: justify"
                                                                                            TabIndex="4" ValidationGroup="MKE" meta:resourcekey="tLMPResource1" />
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
                                                                                        <asp:Button ID="btnCalcEDD" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                                                            onmouseover="this.className='btn btnhov'" Text="Calculate EDD" 
                                                                                            meta:resourcekey="btnCalcEDDResource1" />
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
                                                                                                <td style="width: 11%">
                                                                                                    &nbsp;<asp:Label ID="lblGravida" runat="server" Text="Gravida" 
                                                                                                        meta:resourcekey="lblGravidaResource1"></asp:Label>
                                                                                                </td>
                                                                                                <td style="width: 11%">
                                                                                                    &nbsp;<asp:TextBox ID="txtGravida" runat="server" CssClass ="Txtboxsmall" Width ="120px" 
                                                                                                        meta:resourcekey="txtGravidaResource1"></asp:TextBox>
                                                                                                </td>
                                                                                                <td style="width: 12%">
                                                                                                    <asp:Label ID="lblPara" runat="server" Text="Para" 
                                                                                                        meta:resourcekey="lblParaResource1"></asp:Label>
                                                                                                </td>
                                                                                                <td style="width: 11%">
                                                                                                    <asp:TextBox ID="txtPara" runat="server" CssClass ="Txtboxsmall" Width ="120px"
                                                                                                        meta:resourcekey="txtParaResource1"></asp:TextBox>
                                                                                                </td>
                                                                                                <td style="width: 19%">
                                                                                                    &nbsp;&nbsp;<asp:Label ID="lblAbortUs" runat="server" Text="Abort Us" 
                                                                                                        meta:resourcekey="lblAbortUsResource1"></asp:Label>
                                                                                                    &nbsp;&nbsp;<asp:TextBox ID="txtAbortUs" runat="server" CssClass ="Txtboxsmall" Width ="100px" 
                                                                                                        meta:resourcekey="txtAbortUsResource1"></asp:TextBox>
                                                                                                </td>
                                                                                                <td style="width: 10%">
                                                                                                    &nbsp;<asp:Label ID="lblLive" runat="server" Text="Live" 
                                                                                                        meta:resourcekey="lblLiveResource1"></asp:Label>
                                                                                                </td>
                                                                                                <td style="width: 13%">
                                                                                                    <asp:TextBox ID="txtLive" runat="server" CssClass ="Txtboxsmall" Width ="120px"
                                                                                                        meta:resourcekey="txtLiveResource1"></asp:TextBox>
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
                                                                                                        <asp:DropDownList ID="drdSOC" runat="server" 
                                                                                                            OnSelectedIndexChanged="drdSOC_SelectedIndexChanged" 
                                                                                                            meta:resourcekey="drdSOCResource1">
                                                                                                            <asp:ListItem Text="Male" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                                                            <asp:ListItem Text="Female" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                                                                        </asp:DropDownList>
                                                                                                    </td>
                                                                                                    <td style="width: 13%">
                                                                                                        <asp:Label ID="lblAge" runat="server" Text="Age (in yrs)" 
                                                                                                            meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td style="width: 13%">
                                                                                                        <asp:TextBox ID="txtAge" runat="server" CssClass="textfield1" 
                                                                                                            meta:resourcekey="txtAgeResource1"></asp:TextBox>
                                                                                                    </td>
                                                                                                    <td style="width: 20%">
                                                                                                        <asp:Label ID="lblMOD" runat="server" Text="Mode Of Delivery" 
                                                                                                            meta:resourcekey="lblMODResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td style="width: 22%">
                                                                                                        <asp:DropDownList ID="drpMOD" runat="server" 
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
                                                                                                        <asp:TextBox ID="txtBwt" runat="server" CssClass="textfield1" 
                                                                                                            meta:resourcekey="txtBwtResource1"></asp:TextBox>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:Label ID="lblBMaturity" runat="server" Text="Birth Maturity" 
                                                                                                            meta:resourcekey="lblBMaturityResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:DropDownList ID="drpBMaturity" runat="server" 
                                                                                                            OnSelectedIndexChanged="drpBMaturity_SelectedIndexChanged" 
                                                                                                            meta:resourcekey="drpBMaturityResource1">
                                                                                                        </asp:DropDownList>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:CheckBox ID="chkIsGrowth" runat="server" Text="IsGrowthNormal?" 
                                                                                                            meta:resourcekey="chkIsGrowthResource1" />
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:Label ID="lblGrowthRate" runat="server" Text="Growth Rate" 
                                                                                                            meta:resourcekey="lblGrowthRateResource1"></asp:Label>
                                                                                                        <asp:TextBox ID="txtGrowthRate" runat="server" CssClass="textfield1" 
                                                                                                            meta:resourcekey="txtGrowthRateResource1"></asp:TextBox>
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
                                                                            <table id="tblBaseLine" class="dataheaderInvCtrl" runat="server" width="50%" cellspacing="0"
                                                                                border="2">
                                                                                <tr class="colorforcontent" runat="server">
                                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;" 
                                                                                        runat="server">
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_SexofChild" Text="Sex of Child" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_Age" Text="Age" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_ModeOfDelivery" Text="Mode Of Delivery" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                                        runat="server">
                                                                                        <asp:Label ID="Rs_BirthWeight" Text="Birth Weight" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                                        runat="server">
                                                                                        <asp:Label ID="Rs_GrowthNormal" Text="Growth Normal" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_GrowthRate" Text="Growth Rate" runat="server"></asp:Label>
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
                                                                        <div id="ACX2plus2" style="display: none">
                                                                            <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);"
                                                                                src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);"
                                                                                style="cursor: pointer">&nbsp;<asp:Label 
                                                                                ID="Rs_PreviousComplicatedPregnancies" Text="Previous Complicated Pregnancies" 
                                                                                runat="server" meta:resourcekey="Rs_PreviousComplicatedPregnanciesResource1"></asp:Label></span>
                                                                        </div>
                                                                        <div id="ACX2minus2" style="display: block">
                                                                            <img align="top" alt="hide" height="15" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);"
                                                                                src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                                                            <span class="dataheader1txt" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);"
                                                                                style="cursor: pointer"><asp:Label ID="Rs_Info" 
                                                                                Text="Previous Complicated Pregnancies" runat="server" 
                                                                                meta:resourcekey="Rs_InfoResource1"></asp:Label></span>
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
                                                                                        <asp:TextBox ID="txtothers" runat="server" CssClass ="Txtboxsmall" 
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
                                                                                                meta:resourcekey="TVHResource2">
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
                                                                                        <asp:TextBox ID="txtAssocaitedothers" runat="server" CssClass ="Txtboxsmall"
                                                                                           meta:resourcekey="txtAssocaitedothersResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td style="width: 12%">
                                                                                        <asp:Label ID="lblADDesc" runat="server" Text="Description" 
                                                                                            meta:resourcekey="lblADDescResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 12%">
                                                                                        <asp:TextBox ID="txtADDesc" runat="server" CssClass ="Txtboxsmall" 
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
                                                                                        <asp:DropDownList ID="drpVaccination" runat="server"  CssClass ="ddlsmall"
                                                                                            meta:resourcekey="drpVaccinationResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td class="style7">
                                                                                        <asp:Label ID="lblYear" runat="server" Text="Year" 
                                                                                            meta:resourcekey="lblYearResource1"></asp:Label>
                                                                                        &nbsp;&nbsp;
                                                                                        <asp:TextBox ID="txtYear" runat="server"  CssClass="Txtboxverysmall" size="5" Height ="20px"
                                                                                            meta:resourcekey="txtYearResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td style="width: 7%">
                                                                                        <asp:Label ID="lblMonth" runat="server" Text="Month" 
                                                                                            meta:resourcekey="lblMonthResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 28%">
                                                                                        <asp:DropDownList ID="drpMonth" runat="server" 
                                                                                          CssClass ="ddlsmall"   meta:resourcekey="drpMonthResource1">
                                                                                            <asp:ListItem Text="January" Value="1" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                                            <asp:ListItem Text="Febrauary" Value="2" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                                            <asp:ListItem Text="March" Value="3" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                                                            <asp:ListItem Text="April" Value="4" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                                                            <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                                                                            <asp:ListItem Text="June" Value="6" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                                                                            <asp:ListItem Text="July" Value="7" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                                                                            <asp:ListItem Text="August" Value="8" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                                                                            <asp:ListItem Text="September" Value="9" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                                                                            <asp:ListItem Text="October" Value="10" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                                                                            <asp:ListItem Text="November" Value="11" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                                                                            <asp:ListItem Text="December" Value="12" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblDoses" runat="server" Text="Doses" 
                                                                                            meta:resourcekey="lblDosesResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td class="style6">
                                                                                        <asp:TextBox ID="txtDoses" runat="server"  CssClass ="Txtboxverysmall" size="5" Height ="22px"
                                                                                            meta:resourcekey="txtDosesResource1"></asp:TextBox>
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
                                                                            <table id="tblPriorVaccinations" class="dataheaderInvCtrl" runat="server" width="50%"
                                                                                cellspacing="0" border="2">
                                                                                <tr class="colorforcontent" runat="server">
                                                                                    <td style="font-weight: bold; font-size: 11px; color: White; " class="style10" 
                                                                                        runat="server">
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; color: White; " class="style11" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_Vaccination" Text="Vaccination" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; color: White; " class="style11" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_Year" Text="Year" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; color: White; " class="style11" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_Month" Text="Month" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; color: White; " class="style11" 
                                                                                        runat="server">
                                                                                       <asp:Label ID="Rs_Doses" Text="Doses" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td style="font-weight: bold; font-size: 11px; color: White; " class="style11" 
                                                                                        runat="server">
                                                                                        <asp:Label ID="Rs_Booster" Text="Booster" runat="server"></asp:Label>
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
                                                                                                    
                                                                                                    <asp:DropDownList ID="drpweeks" runat="server" Width="50px" CssClass ="ddl"
                                                                                                        meta:resourcekey="drpweeksResource1">
                                                                                                        <asp:ListItem Text="1" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                                                                                        <asp:ListItem Text="2" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                                                                                        <asp:ListItem Text="3" meta:resourcekey="ListItemResource21"></asp:ListItem>
                                                                                                        <asp:ListItem Text="4" meta:resourcekey="ListItemResource22"></asp:ListItem>
                                                                                                        <asp:ListItem Text="5" meta:resourcekey="ListItemResource23"></asp:ListItem>
                                                                                                        <asp:ListItem Text="6" meta:resourcekey="ListItemResource24"></asp:ListItem>
                                                                                                        <asp:ListItem Text="7" meta:resourcekey="ListItemResource25"></asp:ListItem>
                                                                                                        <asp:ListItem Text="8" meta:resourcekey="ListItemResource26"></asp:ListItem>
                                                                                                        <asp:ListItem Text="9" meta:resourcekey="ListItemResource27"></asp:ListItem>
                                                                                                        <asp:ListItem Text="10" meta:resourcekey="ListItemResource28"></asp:ListItem>
                                                                                                        <asp:ListItem Text="11" meta:resourcekey="ListItemResource29"></asp:ListItem>
                                                                                                        <asp:ListItem Text="12" meta:resourcekey="ListItemResource30"></asp:ListItem>
                                                                                                        <asp:ListItem Text="13" meta:resourcekey="ListItemResource31"></asp:ListItem>
                                                                                                        <asp:ListItem Text="14" meta:resourcekey="ListItemResource32"></asp:ListItem>
                                                                                                        <asp:ListItem Text="15" meta:resourcekey="ListItemResource33"></asp:ListItem>
                                                                                                        <asp:ListItem Text="16" meta:resourcekey="ListItemResource34"></asp:ListItem>
                                                                                                        <asp:ListItem Text="17" meta:resourcekey="ListItemResource35"></asp:ListItem>
                                                                                                        <asp:ListItem Text="18" meta:resourcekey="ListItemResource36"></asp:ListItem>
                                                                                                        <asp:ListItem Text="19" meta:resourcekey="ListItemResource37"></asp:ListItem>
                                                                                                        <asp:ListItem Text="20" meta:resourcekey="ListItemResource38"></asp:ListItem>
                                                                                                        <asp:ListItem Text="21" meta:resourcekey="ListItemResource39"></asp:ListItem>
                                                                                                        <asp:ListItem Text="22" meta:resourcekey="ListItemResource40"></asp:ListItem>
                                                                                                        <asp:ListItem Text="23" meta:resourcekey="ListItemResource41"></asp:ListItem>
                                                                                                        <asp:ListItem Text="24" meta:resourcekey="ListItemResource42"></asp:ListItem>
                                                                                                        <asp:ListItem Text="25" meta:resourcekey="ListItemResource43"></asp:ListItem>
                                                                                                        <asp:ListItem Text="26" meta:resourcekey="ListItemResource44"></asp:ListItem>
                                                                                                        <asp:ListItem Text="27" meta:resourcekey="ListItemResource45"></asp:ListItem>
                                                                                                        <asp:ListItem Text="28" meta:resourcekey="ListItemResource46"></asp:ListItem>
                                                                                                        <asp:ListItem Text="29" meta:resourcekey="ListItemResource47"></asp:ListItem>
                                                                                                        <asp:ListItem Text="30" meta:resourcekey="ListItemResource48"></asp:ListItem>
                                                                                                        <asp:ListItem Text="31" meta:resourcekey="ListItemResource49"></asp:ListItem>
                                                                                                        <asp:ListItem Text="32" meta:resourcekey="ListItemResource50"></asp:ListItem>
                                                                                                        <asp:ListItem Text="33" meta:resourcekey="ListItemResource51"></asp:ListItem>
                                                                                                        <asp:ListItem Text="34" meta:resourcekey="ListItemResource52"></asp:ListItem>
                                                                                                        <asp:ListItem Text="35" meta:resourcekey="ListItemResource53"></asp:ListItem>
                                                                                                        <asp:ListItem Text="36" meta:resourcekey="ListItemResource54"></asp:ListItem>
                                                                                                        <asp:ListItem Text="37" meta:resourcekey="ListItemResource55"></asp:ListItem>
                                                                                                        <asp:ListItem Text="38" meta:resourcekey="ListItemResource56"></asp:ListItem>
                                                                                                        <asp:ListItem Text="39" meta:resourcekey="ListItemResource57"></asp:ListItem>
                                                                                                        <asp:ListItem Text="40" meta:resourcekey="ListItemResource58"></asp:ListItem>
                                                                                                        <asp:ListItem Text="41" meta:resourcekey="ListItemResource59"></asp:ListItem>
                                                                                                        <asp:ListItem Text="42" meta:resourcekey="ListItemResource60"></asp:ListItem>
                                                                                                        <asp:ListItem Text="43" meta:resourcekey="ListItemResource61"></asp:ListItem>
                                                                                                        <asp:ListItem Text="44" meta:resourcekey="ListItemResource62"></asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                    
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:Label ID="lbldays" runat="server" Text="Days" 
                                                                                                        meta:resourcekey="lbldaysResource1"></asp:Label>
                                                                                                   
                                                                                                    <asp:DropDownList ID="drpDays" runat="server"  CssClass ="ddl" Width ="50px"
                                                                                                        meta:resourcekey="drpDaysResource1">
                                                                                                        <asp:ListItem Text="0" meta:resourcekey="ListItemResource63"></asp:ListItem>
                                                                                                        <asp:ListItem Text="1" meta:resourcekey="ListItemResource64"></asp:ListItem>
                                                                                                        <asp:ListItem Text="2" meta:resourcekey="ListItemResource65"></asp:ListItem>
                                                                                                        <asp:ListItem Text="3" meta:resourcekey="ListItemResource66"></asp:ListItem>
                                                                                                        <asp:ListItem Text="4" meta:resourcekey="ListItemResource67"></asp:ListItem>
                                                                                                        <asp:ListItem Text="5" meta:resourcekey="ListItemResource68"></asp:ListItem>
                                                                                                        <asp:ListItem Text="6" meta:resourcekey="ListItemResource69"></asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:Label ID="lblPlacental" runat="server" Text="Placental Position" 
                                                                                                        meta:resourcekey="lblPlacentalResource1"></asp:Label>
                                                                                                </td>
                                                                                                <td class="style8">
                                                                                                    <asp:DropDownList ID="drpPlacental" runat="server"  CssClass ="ddlsmall"
                                                                                                        meta:resourcekey="drpPlacentalResource1">
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td class="style9">
                                                                                                    <asp:Label ID="lblMultiGest" runat="server" Text="Multiple Gestation" 
                                                                                                        meta:resourcekey="lblMultiGestResource1"></asp:Label>
                                                                                                    <asp:DropDownList ID="drpMultiGest" runat="server" CssClass ="ddl"  Width="72px" 
                                                                                                        meta:resourcekey="drpMultiGestResource1">
                                                                                                        <asp:ListItem Text="None" meta:resourcekey="ListItemResource70"></asp:ListItem>
                                                                                                        <asp:ListItem Text="2" meta:resourcekey="ListItemResource71"></asp:ListItem>
                                                                                                        <asp:ListItem Text="3" meta:resourcekey="ListItemResource72"></asp:ListItem>
                                                                                                        <asp:ListItem Text="4" meta:resourcekey="ListItemResource73"></asp:ListItem>
                                                                                                        <asp:ListItem Text="5" meta:resourcekey="ListItemResource74"></asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:Label ID="lblOther" runat="server" Text="Other" 
                                                                                                        meta:resourcekey="lblOtherResource1"></asp:Label>
                                                                                                    &nbsp;&nbsp;
                                                                                                    <asp:TextBox ID="txtOther1" runat="server"  CssClass ="Txtboxsmall" 
                                                                                                      meta:resourcekey="txtOther1Resource1"></asp:TextBox>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td style="width: 20%">
                                                                                                    <asp:Label ID="Label2" runat="server" Text="Date Of UltraSound" 
                                                                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                                </td>
                                                                                                <td class="style8">
                                                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                                                                                                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                                                                        TargetControlID="txtDateOfUltraSound" InputDirection="RightToLeft" 
                                                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                                                                        CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                                                    <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcDt"
                                                                                                        TargetControlID="txtDateOfUltraSound" Enabled="True" />
                                                                                                    <asp:TextBox ID="txtDateOfUltraSound" runat="server"  CssClass ="Txtboxsmall" Width ="120px" MaxLength="1"
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
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnCheckRoutineLabs" runat="server" CssClass="btn" OnClick="btnCheckRoutineLabs_Click"
                                                                Text="Save" meta:resourcekey="btnCheckRoutineLabsResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="20px">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdComplaint" value="H" runat="server" />
    </div>
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    LoadBaseLineHistroyItems();
    LoadPreviousComplicateItems();
    LoadAssociateDieasesItems();
    LoadPriorVaccinationsItems();
</script>
