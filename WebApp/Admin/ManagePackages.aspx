<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagePackages.aspx.cs" Inherits="Admin_ManagePackages" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
    
<%@ Register Src="~/CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <title>Manage Packages</title>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var objAlert;
        $(function() {
             objAlert = SListForAppMsg.Get("Admin_ManagePackages_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_ManagePackages_aspx_Alert");
        });
        function GetSpecialRated(id) {
            if (id != '') {
                document.getElementById('testNameHDN').value = id;
                document.getElementById('txtpackagename').disabled = true;
                document.getElementById('trchkbnd').style.display = 'block';
            }
        }
        function validate() {
            var objuser1 = SListForAppMsg.Get("Admin_ManagePackages_aspx_01") == null ? "Enter the Package Name" : SListForAppMsg.Get("Admin_ManagePackages_aspx_01");
            var objuser2 = SListForAppMsg.Get("Admin_ManagePackages_aspx_02") == null ? "Select the Status" : SListForAppMsg.Get("Admin_ManagePackages_aspx_02");
            var objuser3 = SListForAppMsg.Get("Admin_ManagePackages_aspx_11") == null ? "Enter the Billing Name" : SListForAppMsg.Get("Admin_ManagePackages_aspx_11");
            var vTCode = SListForAppMsg.Get('Admin_ManagePackages_aspx_12') == null ? "Please Enter TCode" : SListForAppMsg.Get('Admin_ManagePackages_aspx_12');
            var value = document.getElementById('txtpackagename').value;
            // alert(value);
            var status = document.getElementById('ddlstatus').value;
            var Billname = document.getElementById('txtBillingName').value;
            if (value.trim() == "") {
                // alert('Enter the Package Name');
                ValidationWindow(objuser1, objAlert);
                return false;
            }
            if (Billname.trim() == "") {
                ValidationWindow(objuser3, objAlert);
                //alert('Enter the Billing Name');
                return false;
            }
            else if (status.trim() == "") {
            // alert('Select the Status');
            ValidationWindow(objuser2, objAlert);
               
                return false;
            }
//            var _temp = '';

//            $('#grdInvCodingScheme tbody tr td input:text').each(function() {
//                if ($(this)[0].value == '') {
//                    _temp = 'set';
//                }
//            });
//            if (_temp == 'set') {
//                alert("Please Enter The Coding Scheme Names");
//                _temp = '';
//                return false;
//            }


            var _temp = 0; var flag = 'Correct';
            $('#grdInvCodingScheme tbody tr td input:text').each(function() {
                if ($(this)[0].value == '') {
                    flag = 'Wrong';
                }
                else {
                    _temp = 1;
                    return false;

                }

            });
            if (flag == 'Wrong' && _temp == 0) {
                //alert("Please Enter TCode");
                ValidationWindow(vTCode, objAlert);
                _temp = '';
                return false;
            }


        }
        function validatePageNumber() {
            var AlertType = SListForAppMsg.Get('Admin_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Admin_Header_Alert');
            var vPageNotValid = SListForAppMsg.Get('Admin_ManagePackages_aspx_13') == null ? "The Page is not valid" : SListForAppMsg.Get('Admin_ManagePackages_aspx_13');
            var Totalpage = document.getElementById('<%= hdntotalpage.ClientID %>').value;
            var pageno = document.getElementById('txtpageNo').value;
            
            if (document.getElementById('txtpageNo').value == "" || document.getElementById('txtpageNo').value == 0) {
                // alert("The Page is not valid");
                ValidationWindow(vPageNotValid, AlertType);
                document.getElementById('txtpageNo').value = "";
                return false;
            }
            if (parseInt(pageno) > parseInt(Totalpage)) {
                //alert("The Page is not valid");
                ValidationWindow(vPageNotValid, AlertType);
                document.getElementById('txtpageNo').value = "";
                return false;
            }         
            
            
//            if (document.getElementById('txtpageNo').value == "") {
//                return false;
//            }
        }
        function showHidePKGContent(id) {
            if (document.getElementById('chk' + id).checked) {
                document.getElementById('rowHeader' + id).style.display = "table-row";
                document.getElementById('rowContent' + id).style.display = "block";
                document.getElementById('submitTab').style.display = 'table-row';
                document.getElementById('pnlclose').style.display = 'none';
            }
            else {
                document.getElementById('rowHeader' + id).style.display = "none";
                document.getElementById('rowContent' + id).style.display = "none";
                document.getElementById('submitTab').style.display = 'none';
                document.getElementById('pnlclose').style.display = 'block';
            }
            setOrderedPKG();
            return false;
        }
        function showHidePKG(id) {

            //alert(id);
            if (document.getElementById('chk' + id).checked) {
                //alert((document.getElementById(id)));
                var HidValue = document.getElementById('Hdn').value;
                var HidVal = document.getElementById('Hdnfld').value;
                //alert(document.getElementById('Hdn').value);
                var list = HidValue.split('^');
                if (document.getElementById('Hdn').value != "") {
                    document.getElementById('Hdn').value = '';
                    for (var count = 0; count < list.length; count++) {
                        if (list[count] != id) {
                            HidVal += list[count] + '^';
                            //document.getElementById('Hdnfld').value = HidVal;
                            document.getElementById('Hdn').value = HidVal;
                        }
                    }
                }
            }
            else {
                //alert("I");
                var HidValue = document.getElementById('Hdn').value;

                HidValue += id + '^';
                //alert(HidValue);
                document.getElementById('Hdn').value = HidValue;
            }
        }

        function showHideSwapBlock(id) {
            if (document.getElementById('swapTR1').style.display == "none") {
                document.getElementById('swapTR1').style.display = "table-row";
                document.getElementById('swapTR2').style.display = "none";
                LoadSpecialityItems();
                LoadProcedureItems();
                LoadHealthCheckupItems();
                if (document.getElementById('submitTab')) {
                    document.getElementById('submitTab').style.display = "table-row";
                }

                LoadOrdItems1();

                SetCollectedItems();
                //alert(chkDft);
                // document.getElementById('chkDft').checked;
                // var x = document.getElementById('PackageProfileControl_TabContainer1_tab2_selectedPackage').value;

                //            if ((document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedSpecialityItems' + x).value != "") || (document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + x).value != "") || (document.getElementById('PackageProfileControl_hdnAddedInvGRP' + x).value != "")) {
                //                alert('PackageProfileControl_chkDefault' + x);
                //                document.getElementById('PackageProfileControl_chkDefault' + x).style.display = "block";
                //            }
                //            else {
                //                document.getElementById('PackageProfileControl_chkDefault' + x).style.display = "none";
                //            }

            }

            else if (document.getElementById('swapTR2').style.display == "none") {
                //alert(document.getElementById('hdnProcedureItems' + id).value);
                document.getElementById('hdnSpecialityItems').value = document.getElementById('hdnAddedSpecialityItems' + id).value;
                document.getElementById('hdnProcedureItems').value = document.getElementById('hdnAddedProcedureItems' + id).value;
                document.getElementById('InvestigationControl1_iconHid').value = document.getElementById('hdnAddedInvGRP' + id).value;
                document.getElementById('hdnHealthCheckupItems').value = document.getElementById('hdnAddedHealthCheckupItems' + id).value;

                if (document.getElementById('submitTab')) {
                    document.getElementById('submitTab').style.display = "none";

                }




                //        document.getElementById('submitTab').style.display = "block";
                document.getElementById('swapTR2').style.display = "table-row";
                document.getElementById('swapTR1').style.display = "none";
                document.getElementById('selectedPackage').value = id;
            }
            return false;
        }
        function setSelectedType() {
            if (document.getElementById('ddlSelectType').value == "Lab Investigation") {
                document.getElementById('invCtrlTab').style.display = "block";
                document.getElementById('specialityTab').style.display = "none";
                document.getElementById('procedureTab').style.display = "none";
                document.getElementById('HealthCheckupTab').style.display = "none";
            }
            if (document.getElementById('ddlSelectType').value == "Consultation") {
                document.getElementById('invCtrlTab').style.display = "none";
                document.getElementById('specialityTab').style.display = "block";
                document.getElementById('procedureTab').style.display = "none";
                document.getElementById('HealthCheckupTab').style.display = "none";
            }
            if (document.getElementById('ddlSelectType').value == "Treatment Procedure") {
                document.getElementById('invCtrlTab').style.display = "none";
                document.getElementById('specialityTab').style.display = "none";
                document.getElementById('procedureTab').style.display = "block";
                document.getElementById('HealthCheckupTab').style.display = "none";
            }
            if (document.getElementById('ddlSelectType').value == "General Health Checkup") {
                document.getElementById('invCtrlTab').style.display = "none";
                document.getElementById('specialityTab').style.display = "none";
                document.getElementById('procedureTab').style.display = "none";
                document.getElementById('HealthCheckupTab').style.display = "block";
            }
            return false;
        }


        function onClickAddSpeciality() {

            var obj = document.getElementById('listSpeciality');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var specialityValue = obj.options[obj.selectedIndex].value;
            var specialityText = obj.options[obj.selectedIndex].text;
            document.getElementById('tblSpecialityItems').style.display = 'table';
            var HidValue = document.getElementById('hdnSpecialityItems').value;
            // alert(HidValue);
            var list = HidValue.split('^');
            if (document.getElementById('hdnSpecialityItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[1] != '') {
                        if (SpecialityList[0] != '') {
                            rwNumber = parseInt(parseInt(SpecialityList[0]) + parseInt(1));
                        }
                        if (specialityValue != '') {
                            if (SpecialityList[1] == specialityValue) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {
                if (specialityValue != '') {
                    var row = document.getElementById('tblSpecialityItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpeciality(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = specialityValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + specialityText + "</b> (Consultation)";
                    document.getElementById('hdnSpecialityItems').value += parseInt(rwNumber) + "~" + specialityValue + "~" + specialityText + "^";
                    //alert(document.getElementById('hdnSpecialityItems').value);
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (specialityValue != '') {
                    var row = document.getElementById('tblSpecialityItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpeciality(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = specialityValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + specialityText + "</b> (Consultation)";
                    document.getElementById('hdnSpecialityItems').value += parseInt(rwNumber) + "~" + specialityValue + "~" + specialityText + "^";
                }
            }
            else if (AddStatus == 1) {
            //alert("Consultation Already Added!");
            var objuser3 = SListForAppMsg.Get("Admin_ManagePackages_aspx_03") == null ? "Consultation Already Added!" : SListForAppMsg.Get("Admin_ManagePackages_aspx_03");

            ValidationWindow(objuser3, objAlert);
            }
            //        alert(document.getElementById('hdnSpecialityItems').value);
            return false;
        }
        function ImgOnclickSpeciality(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnSpecialityItems').value;
            var list = HidValue.split('^');
            var newSpecialityList = '';
            if (document.getElementById('hdnSpecialityItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[0] != '') {
                        if (SpecialityList[0] != ImgID) {
                            newSpecialityList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnSpecialityItems').value = newSpecialityList;
            }
            if (document.getElementById('hdnSpecialityItems').value == '') {
                document.getElementById('tblSpecialityItems').style.display = 'none';
            }
        }
        function ImgOnclickSpeciality1(ImgID) {

            document.getElementById('collectedFinalSpeciality').value = '';
            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnAddedSpecialityItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newSpecialityList = '';
            if (document.getElementById('hdnAddedSpecialityItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[0] != '') {
                        if (SpecialityList[0] != ImgID) {
                            newSpecialityList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedSpecialityItems' + selectPKG).value = newSpecialityList;
                document.getElementById('collectedFinalSpeciality').value = newSpecialityList;
            }
            if (document.getElementById('hdnAddedSpecialityItems' + selectPKG).value == '') {
                document.getElementById('tblAddedSpecialityItems' + selectPKG).style.display = 'none';
            }
        }
        function LoadSpecialityItems() {

            selectPKG = document.getElementById('selectedPackage').value;

            while (document.getElementById('tblAddedSpecialityItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).deleteRow();

                for (var j = 0; j < document.getElementById('tblAddedSpecialityItems' + selectPKG).rows.length; j++) {
                    document.getElementById('tblAddedSpecialityItems' + selectPKG).deleteRow(j);
                }
            }
            //alert(document.getElementById('tblAddedSpecialityItems' + selectPKG).rows.length);
            if (document.getElementById('ddlSelectType').value == "Lab Investigation") {
                document.getElementById('hdnSpecialityItems').value = document.getElementById('InvestigationControl1_iconHid').value;
                //document.getElementById('hdnAddedSpecialityItems' + selectPKG).value = document.getElementById('hdnSpecialityItems').value;
            }
            else {

                document.getElementById('hdnAddedSpecialityItems' + selectPKG).value = document.getElementById('hdnSpecialityItems').value;
            }
            //alert(document.getElementById('hdnSpecialityItems').value);
            var HidValue = document.getElementById('hdnAddedSpecialityItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('hdnAddedSpecialityItems' + selectPKG).value);
            if (document.getElementById('hdnAddedSpecialityItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var SpecialityList = list[count].split('~');
                    var row = document.getElementById('tblAddedSpecialityItems' + selectPKG).insertRow(0);
                    row.id = SpecialityList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickSpeciality1(" + parseInt(SpecialityList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = SpecialityList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + SpecialityList[2] + "</b> (Consultation)";
                }
                document.getElementById('tblAddedSpecialityItems' + selectPKG).style.display = 'table';
            }
            document.getElementById('hdnSpecialityItems').value = "";
            while (document.getElementById('tblSpecialityItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblSpecialityItems').deleteRow();
                for (var j = 0; j < document.getElementById('tblSpecialityItems').rows.length; j++) {
                    document.getElementById('tblSpecialityItems').deleteRow(j);

                }
            }
        }
        function setItemS(e, ctl) {
            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddSpeciality();
            }

        }
        function onClickAddProcedure() {

            // alert("H");
            var obj = document.getElementById('listProcedure');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var ProcedureValue = obj.options[obj.selectedIndex].value;
            var ProcedureText = obj.options[obj.selectedIndex].text;
            document.getElementById('tblProcedureItems').style.display = 'table';
            var HidValue = document.getElementById('hdnProcedureItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnProcedureItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[1] != '') {
                        if (ProcedureList[0] != '') {
                            rwNumber = parseInt(parseInt(ProcedureList[0]) + parseInt(1));
                        }
                        if (ProcedureValue != '') {
                            if (ProcedureList[1] == ProcedureValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (ProcedureValue != '') {
                    var row = document.getElementById('tblProcedureItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                    document.getElementById('hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "^";
                    //alert(document.getElementById('hdnProcedureItems').value);
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (ProcedureValue != '') {
                    var row = document.getElementById('tblProcedureItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                    document.getElementById('hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "^";
                }
            }
            else if (AddStatus == 1) {
            //alert("Consultation Already Added!");
            var objuser3 = SListForAppMsg.Get("Admin_ManagePackages_aspx_03") == null ? "Consultation Already Added!" : SListForAppMsg.Get("Admin_ManagePackages_aspx_03");

            ValidationWindow(objuser3, objAlert);
            }
            //        alert(document.getElementById('hdnProcedureItems').value);
            return false;
        }
        function ImgOnclickProcedure(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnProcedureItems').value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('hdnProcedureItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnProcedureItems').value = newProcedureList;
            }
            if (document.getElementById('hdnProcedureItems').value == '') {
                document.getElementById('tblProcedureItems').style.display = 'none';
            }
        }
        function ImgOnclickProcedure1(ImgID) {

            document.getElementById('collectedFinalProcedure').value = '';
            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnAddedProcedureItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('hdnAddedProcedureItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedProcedureItems' + selectPKG).value = newProcedureList;
                document.getElementById('collectedFinalProcedure').value = newProcedureList;
            }
            if (document.getElementById('hdnAddedProcedureItems' + selectPKG).value == '') {
                document.getElementById('tblAddedProcedureItems' + selectPKG).style.display = 'none';
            }
        }
        function LoadProcedureItems() {

            selectPKG = document.getElementById('selectedPackage').value;

            while (document.getElementById('tblAddedProcedureItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('tblAddedProcedureItems' + selectPKG).rows.length; j++) {
                    document.getElementById('tblAddedProcedureItems' + selectPKG).deleteRow(j);
                }

            }
            //alert(document.getElementById('tblAddedProcedureItems' + selectPKG).rows.length);
            document.getElementById('hdnAddedProcedureItems' + selectPKG).value = document.getElementById('hdnProcedureItems').value;
            var HidValue = document.getElementById('hdnAddedProcedureItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('hdnAddedProcedureItems' + selectPKG).value);
            if (document.getElementById('hdnAddedProcedureItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var ProcedureList = list[count].split('~');
                    var row = document.getElementById('tblAddedProcedureItems' + selectPKG).insertRow(0);
                    row.id = ProcedureList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickProcedure1(" + parseInt(ProcedureList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Procedure)";

                }
                document.getElementById('tblAddedProcedureItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('hdnProcedureItems').value = "";
            while (document.getElementById('tblProcedureItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblProcedureItems').deleteRow();
                for (var j = 0; j < document.getElementById('tblProcedureItems').rows.length; j++) {
                    document.getElementById('tblProcedureItems').deleteRow(j);

                }
            }
        }

        function setItemP(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddProcedure();
            }

        }
        function LoadOrdItems1() {

            selectPKG = document.getElementById('selectedPackage').value;


            while (document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).rows.length > 0) {
                //document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).rows.length; j++) {
                    document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).deleteRow(j);
                }
            }


            //alert(document.getElementById('InvestigationControl1_iconHid').value);
            document.getElementById('hdnAddedInvGRP' + selectPKG).value = document.getElementById('InvestigationControl1_iconHid').value;
            var HidValue = document.getElementById('hdnAddedInvGRP' + selectPKG).value;
            var list = HidValue.split('^');

            if (document.getElementById('hdnAddedInvGRP' + selectPKG).value != "") {

                // alert(HidValue);
                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    var row = document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).insertRow(0);
                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick2(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    if (InvesList[2] == "INV") {
                        ext = " (Investigation)";
                    }

                    else {
                        ext = " (Group)";
                    }

                    document.getElementById('InvestigationControl1_iconHid').value = "";

                    while (document.getElementById('tblOrederedInves').rows.length > 0) {
                        //            document.getElementById('tblOrederedInves').deleteRow();
                        for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                            document.getElementById('tblOrederedInves').deleteRow(j);

                        }

                    }
                    cell2.innerHTML = "<b>" + InvesList[1] + "</b>" + ext;
                    cell3.innerHTML = InvesList[2];
                    cell3.style.display = "none";
                }
                document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).style.display = 'block';


            }
            document.getElementById('InvestigationControl1_iconHid').value = "";

            while (document.getElementById('tblOrederedInves').rows.length > 0) {

                //document.getElementById('tblOrederedInves').deleteRow();
                for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                    document.getElementById('tblOrederedInves').deleteRow(j);


                }

            }

            return false;
        }
        function ImgOnclick2(ImgID) {

            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById('collectedFinalINVGRP').value = '';
            document.getElementById(ImgID).style.display = "none";

            var HidValue = document.getElementById('hdnAddedInvGRP' + selectPKG).value;
            var list = HidValue.split('^');
            var newInvGRPList = '';
            if (document.getElementById('hdnAddedInvGRP' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvGRPList = list[count].split('~');
                    if (InvGRPList[0] != '') {
                        if (InvGRPList[0] != ImgID) {
                            newInvGRPList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedInvGRP' + selectPKG).value = newInvGRPList;
                document.getElementById('collectedFinalINVGRP').value = newInvGRPList;
            }
            if (document.getElementById('hdnAddedInvGRP' + selectPKG).value == '') {
                document.getElementById('tblOrderedInvesAddedTemp' + selectPKG).style.display = 'none';
            }
        }

        function SetCollectedItems() {

            document.getElementById('collectedFinalINVGRP').value = "";
            document.getElementById('collectedFinalSpeciality').value = "";
            document.getElementById('collectedFinalProcedure').value = "";
            document.getElementById('collectedFinalHealthCheckUp').value = "";
            var pkgID = document.getElementById('hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                //                if (document.getElementById('chk' + pkgID[count]).checked) {
                //alert(document.getElementById('hdnAddedInvGRP').value);
                if (document.getElementById('hdnAddedInvGRP' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalINVGRP').value += pkgID[count] + "$" + document.getElementById('hdnAddedInvGRP' + pkgID[count]).value + "|";
                }
                if (document.getElementById('hdnAddedSpecialityItems' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalSpeciality').value += pkgID[count] + "-" + document.getElementById('hdnAddedSpecialityItems' + pkgID[count]).value + "|";
                }
                if (document.getElementById('hdnAddedProcedureItems' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalProcedure').value += pkgID[count] + "-" + document.getElementById('hdnAddedProcedureItems' + pkgID[count]).value + "|";
                }
                if (document.getElementById('hdnAddedHealthCheckupItems' + pkgID[count]).value != "") {
                    document.getElementById('collectedFinalHealthCheckUp').value += pkgID[count] + "-" + document.getElementById('hdnAddedHealthCheckupItems' + pkgID[count]).value + "|";
                }

            }
            //}
            //          alert(document.getElementById('collectedFinalINVGRP').value);
            //          alert(document.getElementById('collectedFinalSpeciality').value);
            //          alert(document.getElementById('collectedFinalProcedure').value);
            return false;
        }
        function setDefaultPKG() {
            document.getElementById('setDefaultPKG').value = "";
            var pkgID = document.getElementById('hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                if (document.getElementById('chkDefault' + pkgID[count]).checked) {


                    document.getElementById('setDefaultPKG').value += pkgID[count] + "~";
                }
            }


            if (document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + pkgID[count]).value != "") {

                document.getElementById('PackageProfileControl_collectedFinalHealthCheckUp').value += pkgID[count] + "-" + document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + pkgID[count]).value + "|";
            }
        }

        function setOrderedPKG() {
            document.getElementById('setOrderedPKG').value = "";
            var pkgID = document.getElementById('hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                if (document.getElementById('chk' + pkgID[count]).checked) {
                    document.getElementById('setOrderedPKG').value += pkgID[count] + "~";
                }
            }
        }

        function onClickAddHealthCheckup() {
            var obj = document.getElementById('listHealthCheckup');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
            var HealthCheckupText = obj.options[obj.selectedIndex].text;
            document.getElementById('tblHealthCheckupItems').style.display = 'block';
            var HidValue = document.getElementById('hdnHealthCheckupItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnHealthCheckupItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[1] != '') {
                        if (HealthCheckupList[0] != '') {
                            rwNumber = parseInt(parseInt(HealthCheckupList[0]) + parseInt(1));
                        }
                        if (HealthCheckupvalue != '') {
                            if (HealthCheckupList[1] == HealthCheckupvalue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('tblHealthCheckupItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Health Checkup)";
                    document.getElementById('hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('tblHealthCheckupItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Health Checkup)";
                    document.getElementById('hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "^";
                }
            }
            else if (AddStatus == 1) {
            var objuser4 = SListForAppMsg.Get("Admin_ManagePackages_aspx_04") == null ? "Health Checkup Already Added!" : SListForAppMsg.Get("Admin_ManagePackages_aspx_04");
            ValidationWindow(objuser4, objAlert);
               //alert("Health Checkup Already Added!");
            }
            //        alert(document.getElementById('hdnHealthCheckupItems').value);
            return false;
        }
        function ImgOnclickHealthCheckup(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnHealthCheckupItems').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdnHealthCheckupItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnHealthCheckupItems').value = NewHealthCheckupList;
            }
            if (document.getElementById('hdnHealthCheckupItems').value == '') {
                document.getElementById('tblHealthCheckupItems').style.display = 'none';
            }
        }


        function ImgOnclickHealthCheckup1(ImgID) {
            document.getElementById('collectedFinalHealthCheckUp').value = '';
            selectPKG = document.getElementById('selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value;

            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value = NewHealthCheckupList;
                document.getElementById('collectedFinalHealthCheckUp').value = NewHealthCheckupList;
            }
            if (document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value == '') {
                document.getElementById('tblAddedHealthCheckupItems' + selectPKG).style.display = 'none';
            }
        }
        function LoadHealthCheckupItems() {


            selectPKG = document.getElementById('selectedPackage').value;

            while (document.getElementById('tblAddedHealthCheckupItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('tblAddedHealthCheckupItems' + selectPKG).rows.length; j++) {
                    document.getElementById('tblAddedHealthCheckupItems' + selectPKG).deleteRow(j);
                }

            }
            document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value = document.getElementById('hdnHealthCheckupItems').value;
            var HidValue = document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value);
            if (document.getElementById('hdnAddedHealthCheckupItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var HealthCheckupList = list[count].split('~');
                    var row = document.getElementById('tblAddedHealthCheckupItems' + selectPKG).insertRow(0);
                    row.id = HealthCheckupList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup1(" + parseInt(HealthCheckupList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupList[2] + "</b> (Health Checkup)";

                }
                document.getElementById('tblAddedHealthCheckupItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('hdnHealthCheckupItems').value = "";
            while (document.getElementById('tblHealthCheckupItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblHealthCheckupItems').deleteRow();

                for (var j = 0; j < document.getElementById('tblHealthCheckupItems').rows.length; j++) {
                    document.getElementById('tblHealthCheckupItems').deleteRow(j);

                }
            }

        }

        function setItemHealthCheckup(e, ctl) {
            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddHealthCheckup();
            }

        }


        function chkonchange() {
            var tableBody = document.getElementById('PackageProfileControl_TabContainer1_tab1_chklistpackage').childNodes[0];
            //
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                var objuser5 = SListForAppMsg.Get("Admin_ManagePackages_aspx_05") == null ? "Select the items in group master" : SListForAppMsg.Get("Admin_ManagePackages_aspx_05");

                // alert('Select the items in group master');
                ValidationWindow(objuser5, objAlert);
                return false;
            }
        }
        function SaveDeletedItems() {
            SetCollectedItems();
            return true;
        }


        function popupClose() {
            return true;
        }

        function inputOnlyNumbers(evt) {
            var e = window.event || evt;
            var charCode = e.which || e.keyCode;
            if ((charCode > 47 && charCode < 58) || charCode == 8) {
                return true;
            }
            return false;
        }
        function OnCloseClick(ctrl) {
            $('#GridContent').hide();
            $(ctrl).hide();
            event.preventDefault();
        }
		
		function ShowPopUp() 
        {
              var ReturnValue = window.open("..\\Admin\\LabMaster.aspx?IsPopUp=Y","", "height=800,width=1000,scrollbars=Yes");
        }
            function ShowGroupPopUp() 
            {

                var ReturnValue = window.open("..\\Admin\\AddInvandGroups.aspx?IsPopUp=Y", "", "height=800,width=1000,scrollbars=Yes");
            }
    </script>

    <style type="text/css">
        
        .floatLeft
        {
            width:40%;
            float:left;
        }
        .floatRight
        {
            width:60%;
            float: right;
        }
        .managePackage 
        {
            overflow:hidden;
            padding:10px;
            background:none repeat scroll 0 0 #d8dfd8;
        }
        #ModelPopPackageSearch_backgroundElement 
        {
                z-index: 1001!important;
        }
        #progressBackgroundFilter
        {
                z-index: 10014!important;
        }
        .showing
        {
            width: -webkit-fill-available;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release">
            </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />

                    <div class="contentdata">
                       <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>

                            </asp:UpdateProgress>
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                        
                            <ContentTemplate>
                                <div class="managePackage">
                                    <div class="floatLeft">
                                        <table class="a-left w-80p">
                                            <tr class="w-50p">
                                                <td class="w-30p a-left">
                                                    <asp:Label ID="lblpacname" runat="server" Text="Package Name" 
                                                        meta:resourcekey="lblpacnameResource1"></asp:Label>
                                                </td>
                                                <td class="w-70p a-left">
                                                    <asp:TextBox ID="txtpackagename" runat="server" CssClass="small" 
                                                        AutoComplete="off" meta:resourcekey="txtpackagenameResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                              <tr width="50%">
                                                <td width="30%">
                                                    <asp:Label ID="lblBillingName" runat="server" Text="BillingName" 
                                                        meta:resourcekey="lblBillingNameResource1"></asp:Label>
                                                </td>
                                                <td width="30%" align="left">
                                                    <asp:TextBox ID="txtBillingName" runat="server" CssClass="Txtboxsmall" 
                                                        meta:resourcekey="txtBillingNameResource1" ></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Label2" runat="server" Text="Remarks" 
                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                </td>
                                                <td class="a-left w-30p">
                                                    <asp:TextBox ID="txtremarks" runat="server" CssClass="Txtboxsmall" 
                                                        AutoComplete="off" meta:resourcekey="txtremarksResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="Label1" runat="server" Text="Status" 
                                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td class="a-left w-30p">
                                                    <asp:DropDownList ID="ddlstatus" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblCutoffTime" Text="Processing Time" runat="server" meta:resourcekey="lblCutoffTimeResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <table>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtCutOffValue" runat="server" MaxLength="2" Width="69px" CssClass="small"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    meta:resourcekey="txtCutOffValueResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList runat="server" Width="75px" ID="ddlCutOffType" CssClass="ddl" meta:resourcekey="ddlCutOffTypeResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblGender1" runat="server" meta:resourcekey="lblGenderResource1" Text="Gender"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:DropDownList ID="ddlGender1" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblTestCategory" runat="server"  
                                                        Text="Discount Category" meta:resourcekey="lblTestCategoryResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTestCategory" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                             <td class="a-left">
                                    <asp:Label ID="lblScheduleType" runat="server" Text="Schedule Type" 
                                                     meta:resourcekey="lblScheduleTypeResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlScheduleType" runat="server" CssClass="ddlsmall">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblServiceTaxable" runat="server" meta:resourcekey="lblServiceTaxableResource1"
                                        Text="ServiceTaxable"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:CheckBox ID="chkServiceTax" runat="server" meta:resourcekey="chkServiceTaxResource1"
                                        TextAlign="Left" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblPrintSeparately" runat="server" Text="Print Separately" meta:resourcekey="lblPrintSeparatelyResource1"></asp:Label>
                                </td>
                                                <td class="a-left">
                                                    <asp:CheckBox ID="chkPrintSeparately" runat="server" 
                                                        meta:resourcekey="chkPrintSeparatelyResource1" />
                                                  </td> 
                                                  </tr> 
                                                       <tr>
                                                         <td class="a-left">
                                                    <asp:Label ID="lblIsTransfer" runat="server" Text="package Transfer" 
                                                        meta:resourcekey="lblIsTransferResource1"></asp:Label>
                                               </td>
                                                
                                                <td class="a-left">
                                                    <asp:CheckBox ID="chkIsTransfer" runat="server" 
                                                        meta:resourcekey="chkIsTransferResource1" />
                                               </td> 
                                                </tr> 
                                                <tr>
                                               <td> 
                                    <asp:Button ID="btnsave" runat="server" CssClass="btn" OnClick="btnsave_Click" OnClientClick="javascript:return validate()"
                                        Text="Add" Width="80px" meta:resourcekey="btnsaveResource1" />
                                    <input id="testNameHDN" runat="server" type="hidden" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="floatRight">
                        <table class="a-left w-40p">
                            <tr class="a-left">
                                <td class="a-left">
                                    <asp:GridView ID="grdInvCodingScheme" runat="server" AllowPaging="False" AutoGenerateColumns="False"
                                        CellPadding="0" CellSpacing="0" CssClass="mytable1 gridView" ForeColor="#333333"
                                        OnPageIndexChanging="grdInvCodingScheme_PageIndexChanging" OnRowDataBound="grdInvCodingScheme_OnRowDataBound"
                                        meta:resourcekey="grdInvCodingSchemeResource1">
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <HeaderTemplate>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCodingSchemeNameMaster" runat="server" Text='<%# Eval("CodingSchemaName") %>'
                                                        meta:resourcekey="lblCodingSchemeNameMasterResource1"></asp:Label>
                                                    <asp:Label ID="lblCodingSchemeNameMasterID" runat="server" Style="display: none"
                                                        Text='<%# Eval("CodeTypeID") %>' meta:resourcekey="lblCodingSchemeNameMasterIDResource1"></asp:Label>
                                                    <asp:Label ID="lblCodeMasterID" runat="server" Style="display: none" Text='<%# Eval("CodeMasterID") %>'
                                                        meta:resourcekey="lblCodeMasterIDResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtCodingSchemeNameMaster" runat="server" CssClass="Txtboxsmall"
                                                        Text='<%# Eval("CodeName") %>' Width="123px" meta:resourcekey="txtCodingSchemeNameMasterResource1"></asp:TextBox>
                                                    <asp:ImageButton ID="starbutton" runat="server" ImageUrl="~/Images/starbutton.png"
                                                        Enabled="false" meta:resourcekey="starbuttonResource1" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div>
                    <table class="a-left w-100p">
                        <tr>
                            <td class="a-right w-20p">
                                <asp:Label ID="lblsearchpkg" runat="server" Text="Search Package Name" meta:resourcekey="lblsearchpkgResource1"></asp:Label>
                            </td>
                            <td class="a-center w-20p">
                                <asp:TextBox ID="txtsearchpkg" CssClass="small" AutoComplete="off" runat="server"
                                    meta:resourcekey="txtsearchpkgResource1"></asp:TextBox>
                            </td>
                            <td class="a-left w-10p">
                                <asp:Button ID="btnsearch" runat="server" CssClass="btn" OnClick="btnsearch_Click"
                                    Text="Search" Width="80px" meta:resourcekey="btnsearchResource1" />
                                        
                                            <asp:LinkButton ID="lnkinvestigation" runat="server" style="color:Blue" Text="AddNewInvestigation" Font-Bold="true" Font-Names="Verdana" Font-Size="10pt" meta:resourcekey="lnkinvestigationResource1" OnClientClick="javascript:ShowPopUp();" ></asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;
                                             <asp:LinkButton ID="lnkgroup" runat="server" style="color:Blue" Text="AddNewGroup" Width="80px" Font-Bold="true" Font-Names="Verdana" Font-Size="10pt" meta:resourcekey="lnkinvestigationResource1"  OnClientClick="javascript:ShowGroupPopUp();" ></asp:LinkButton>
                                            
                                        </td>   
                                        <td class="a-right w-30p">
                            </td><td><div id="ExportXL" runat="server">
                              
                                    <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                        Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="lblExportResource1"></asp:Label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:ImageButton ID="ImageBtnExport" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                        meta:resourcekey="imgBtnXLResource1" Style="width: 16px" OnClick="ImageBtnExport_Click" />
                                      
                                </div></td>
                        </tr>
                    </table>
                    <table class="a-left w-100p">
                        <tr>
                            <td>
                                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr class="a-left w-100p">
                            <td class="a-center">
                                <asp:GridView ID="grdpackages" runat="server" AutoGenerateColumns="False" CssClass="mytable1 w-100p gridView"
                                    DataKeyNames="OrgGroupID,DisplayText,Status,Remarks,Packagecode,PrintSeparately,CutOffTimeValue,
                                                CutOffTimeType,Gender,IsServicetaxable,SubCategory,IsTATrandom,BillingName"
                                                OnRowDataBound="grdpackages_RowDataBound" OnPageIndexChanging="grdpackages_PageIndexChanging"
                                                OnRowCommand="grdpackages_RowCommand" 
                                            meta:resourcekey="grdpackagesResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1%>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="8%" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="OrgGroupID" HeaderText="Package ID" Visible="false" 
                                                    meta:resourcekey="BoundFieldResource1" />
                                        <%--<asp:BoundField DataField="DisplayText" ItemStyle-HorizontalAlign="Left" 
                                                    HeaderText="Package Name" meta:resourcekey="BoundFieldResource2" >--%>
                                        <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkpkgname" runat="server" Text='<%# Eval("DisplayText") %>'
                                                    CommandName="Package Name" CommandArgument='<%# Eval("OrgGroupID")+","+ Eval("DisplayText") %>'
                                                    meta:resourcekey="lnkpkgnameResource1"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<ItemStyle HorizontalAlign="Left"></ItemStyle>--%>
                                        <%--</asp:BoundField>--%>
                                        <%-- <asp:BoundField DataField="Packagecode" ItemStyle-HorizontalAlign="Left" 
                                                    HeaderText="Primary Code" meta:resourcekey="BoundFieldResource3" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>--%>
                                                <asp:BoundField DataField="Status" ItemStyle-HorizontalAlign="Left" 
                                                    HeaderText="Status" meta:resourcekey="BoundFieldResource4" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                    <asp:BoundField DataField="Remarks" ItemStyle-HorizontalAlign="Left" HeaderText="Remarks"
                                                        Visible="false" meta:resourcekey="BoundFieldResource5" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                        <asp:BoundField DataField ="CutOffTimeValue" 
                                                    ItemStyle-HorizontalAlign="Left" HeaderText="CutOffTimeValue"
                                                        Visible="false" meta:resourcekey="BoundFieldResource6" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                         <asp:BoundField DataField ="CutOffTimeType" 
                                                    ItemStyle-HorizontalAlign="Left" HeaderText="CutOffTimeType"
                                                        Visible="false" meta:resourcekey="BoundFieldResource7" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                    <asp:BoundField DataField="General" ItemStyle-HorizontalAlign="Left" HeaderText="Gender"
                                                        Visible="false" meta:resourcekey="BoundFieldResource8" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                         <asp:BoundField DataField="IsServicetaxable" 
                                                    ItemStyle-HorizontalAlign="Left" HeaderText="IsServicetaxable"
                                                    Visible="false" meta:resourcekey="BoundFieldResource9" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                    <asp:BoundField DataField ="IsTATrandom" ItemStyle-HorizontalAlign="Left" HeaderText="Random/Batch"
                                                        Visible="false" meta:resourcekey="BoundFieldResource10" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PrintSeparately" ItemStyle-HorizontalAlign="Center" 
                                                    HeaderText="Print Separately" meta:resourcekey="BoundFieldResource11" >
<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Action" 
                                                    meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                        <table class="mytable1 w-100p">
                                                            <tr>
                                                                <td class="w-50p">
                                                                    <asp:LinkButton ID="lnkshow" runat="server" Text="Show" CssClass="viewIcons" 
                                                                        CommandName="Mapping" 
                                                                        CommandArgument='<%# Eval("OrgGroupID")+","+ Eval("DisplayText") %>' 
                                                                        meta:resourcekey="lnkshowResource1"></asp:LinkButton>
                                                                </td>
                                                                <td class="w-50p">
                                                                    <asp:LinkButton ID="lnkEdit" CssClass="editIcons" runat="server" Text="Edit" 
                                                                        CommandName="Select" 
                                                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' 
                                                                        meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                    </td>
                            <td class="showing" style="vertical-align: top;">
                                <table style="vertical-align: top;" id="ShowHideGrid" runat="server" class="showing" >
                                    <tr>
                                        <td>
                                            <asp:GridView ID="GridContent" runat="server" AutoGenerateColumns="False" CssClass="mytable1 w-100p gridView">
                                                <Columns>
                                                    <asp:BoundField DataField="TestCode" HeaderText="TestCode" Visible="true" meta:resourcekey="BoundFieldResource21" />
                                                    <asp:BoundField DataField="TestName" HeaderText="TestName" Visible="true" meta:resourcekey="BoundFieldResource22" />
                                                    <asp:BoundField DataField="Status" HeaderText="Status" Visible="true" meta:resourcekey="BoundFieldResource23" />
                                                    <asp:BoundField DataField="Type" HeaderText="Type" Visible="true" meta:resourcekey="BoundFieldResource24" />
                                                    <asp:BoundField DataField="PrintSeparately" HeaderText="Print Separately" Visible="true"
                                                        meta:resourcekey="BoundFieldResource25" />
                                                  <asp:BoundField DataField="SequenceNo" HeaderText="Sequence No" Visible="true"
                                                        meta:resourcekey="BoundFieldResource26" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                        <td style="vertical-align:top">
                                            <div id="PngClose" runat="server">
                                                <input id="btnclose" type="image" style="float: right; width: 16px; display: none;"
                                                    onclick="OnCloseClick(this);" runat="server" src="~/Images/btncancel.png" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                                <tr>
                                    <td class="a-center">
                                        <table  class="w-100p">
                                            <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                <td class="defaultfontcolor a-center">
                                                    <asp:Label ID="Label3" runat="server" Text="Page" 
                                                        meta:resourcekey="Label3Resource1"></asp:Label>
                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" 
                                                        meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                    <asp:Label ID="Label4" runat="server" Text="Of" 
                                                        meta:resourcekey="Label4Resource1"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" 
                                                        meta:resourcekey="lblTotalResource1"></asp:Label>
                                                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" 
                                                        OnClick="btnPrevious_Click" meta:resourcekey="btnPreviousResource1" />
                                                    <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" 
                                                        OnClick="btnNext_Click" meta:resourcekey="btnNextResource1" />
                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                    <asp:Label ID="Label5" runat="server" Text="Enter The Page To Go:" 
                                                        meta:resourcekey="Label5Resource1"></asp:Label>
                                                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                        AutoComplete="off" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                                                        OnClientClick="javascript:return validatePageNumber();" 
                                                        meta:resourcekey="btnGoResource1" />
                                                    <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                            <td>&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <Ajax:ModalPopupExtender ID="ModelPopPackageSearch" runat="server" TargetControlID="btnR"
                                                        PopupControlID="pnlUserMaster" BackgroundCssClass="modalBackground" OkControlID="btnPnlClose"
                                                        DynamicServicePath="" Enabled="True" />
                                                    <asp:Panel ID="pnlUserMaster" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup w-80p"
                                                        Style="display: none; top: 400px; height: 500px; z-index:9999;" 
                                                        meta:resourcekey="pnlUserMasterResource1">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                                    <tr id="swapTR1" runat="server">
                                                                        <td id="Td1" class="v-top w-50p" runat="server">
                                                                            <asp:Table ID="healthPackagesTab" CssClass="dataheaderInvCtrl w-100p searchPanel" runat="server">
                                                                            </asp:Table>
                                                                        </td>
                                                                        <td id="Td2" class="v-top w-50p" runat="server">
                                                                            <asp:Table ID="healthPackagesContentTab" runat="server" class="w-100p searchPanel">
                                                                            </asp:Table>
                                                                            <input type="hidden" id="selectedPackage" runat="server" >
                                                                                </input>
                                                                                <input id="hdntotalFinalPKG" runat="server" type="hidden"></input>
                                                                                    <input id="collectedFinalINVGRP" runat="server" type="hidden"></input>
                                                                                        <input id="collectedFinalSpeciality" runat="server" type="hidden"></input>
                                                                                            <input id="collectedFinalProcedure" runat="server" type="hidden"></input>
                                                                                                <input id="collectedFinalHealthCheckUp" runat="server" type="hidden"></input>
                                                                                                    <input id="setDefaultPKG" runat="server" type="hidden"></input>
                                                                                                        <input id="setOrderedPKG" runat="server" type="hidden"></input>
                                                                                                            <input id="setOrderedPKGTemp" runat="server" type="hidden"></input>
                                                                                                                <input id="hdnpkgid" runat="server" type="hidden"></input>
                                                                                                                </input>
                                                                                                            </input>
                                                                                                        </input>
                                                                                                    </input>
                                                                                                </input>
                                                                                            </input>
                                                                                        </input>
                                                                                    </input>
                                                                                </input>
                                                                            </input>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="swapTR2" runat="server" style="display: none;">
                                                                        <td id="Td3" colspan="2" runat="server">
                                                                            <table id="typeTab" class="dataheaderInvCtrl w-40p" runat="server">
                                                                                <tr id="Tr1" runat="server">
                                                                                    <td id="Td4" class="a-center" runat="server">
                                                                                       <%-- <b>Select Type</b>--%>
                                                                                          <asp:Label ID="lblSelectType" runat="server" Text="Select Type" 
                                                        meta:resourcekey="lblSelectTypeResource1"></asp:Label>
                                                                                     </td>
                                                                                    <td id="Td5" runat="server">
                                                                                        <asp:DropDownList ID="ddlSelectType" onchange="javascript:setSelectedType();" runat="server">
                                                                                           <%-- <asp:ListItem Selected="True" Text="Lab Investigation" Value="Lab Investigation"></asp:ListItem>
                                                                                            <asp:ListItem Text="Consultation" Value="Consultation"></asp:ListItem>
                                                                                            <asp:ListItem Text="Treatment Procedure" Value="Treatment Procedure"></asp:ListItem>
                                                                                            <asp:ListItem Text="General Health Checkup" Value="General Health Checkup"></asp:ListItem>--%>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table id="invCtrlTab" runat="server" class="w-100p">
                                                                                <tr id="Tr2" runat="server">
                                                                                    <td id="Td6" runat="server">
                                                                                        <uc1:InvestigationControl ID="InvestigationControl1" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <asp:HiddenField ID="Hdn" runat="server" />
                                                                            <asp:HiddenField ID="Hdnfld" runat="server" />
                                                                            <table id="specialityTab" style="display: none;" runat="server" class="w-100p">
                                                                                <tr id="Tr3" runat="server">
                                                                                    <td id="Td7" runat="server">
                                                                                        <asp:Label ID="lblSpeciality" runat="server" Text="Speciality"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr id="Tr4" runat="server">
                                                                                    <td id="Td8" runat="server">
                                                                                        <table class="w-100p">
                                                                                            <tr>
                                                                                                <td  class="w-50p v-top">
                                                                                                    <asp:ListBox ID="listSpeciality" runat="server" onkeypress="javascript:setItemS(event,this);"
                                                                                                        ondblClick="javascript:onClickAddSpeciality();" Width="350px" Height="150px">
                                                                                                    </asp:ListBox>
                                                                                                </td>
                                                                                                <td  class="w-50p v-top">
                                                                                                    <input type="hidden" id="hdnSpecialityItems" runat="server"></input>
                                                                                                        </input>
                                                                                                    <table id="tblSpecialityItems" runat="server" class="dataheaderInvCtrl w-100p">
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table id="procedureTab" style="display: none;" runat="server" class="w-100p">
                                                                                <tr id="Tr5" runat="server">
                                                                                    <td id="Td9" runat="server">
                                                                                        <asp:Label ID="lblProcedure" runat="server" Text="Procedure"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr id="Tr6" runat="server">
                                                                                    <td id="Td10" runat="server">
                                                                                        <table  class="w-100p">
                                                                                            <tr>
                                                                                                <td  class="w-50p">
                                                                                                    <asp:ListBox ID="listProcedure" runat="server" onkeypress="javascript:setItemP(event,this);"
                                                                                                        ondblClick="javascript:onClickAddProcedure();" Width="350px" Height="100px">
                                                                                                    </asp:ListBox>
                                                                                                </td>
                                                                                                <td class="w-50p v-top">
                                                                                                    <input type="hidden" id="hdnProcedureItems" runat="server"></input>
                                                                                                    <table id="tblProcedureItems" runat="server" border="0" cellpadding="4" cellspacing="0"
                                                                                                        class="dataheaderInvCtrl" width="100%">
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table id="HealthCheckupTab" style="display: none;" runat="server" class="w-100p">
                                                                                <tr id="Tr7" runat="server">
                                                                                    <td id="Td11" runat="server">
                                                                                        <asp:Label ID="lblSpecialiType" runat="server" Text="Speciality Type"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr id="Tr8" runat="server">
                                                                                    <td id="Td12" runat="server">
                                                                                        <table class="w-100p">
                                                                                            <tr>
                                                                                                <td class="v-top w-50p">
                                                                                                    <asp:ListBox ID="listHealthCheckup" runat="server" onkeypress="javascript:setItemHealthCheckup(event,this);"
                                                                                                        ondblClick="javascript:onClickAddHealthCheckup();" Width="350px" Height="150px">
                                                                                                    </asp:ListBox>
                                                                                                </td>
                                                                                                <td class="w-50p v-top">
                                                                                                    <input type="hidden" id="hdnHealthCheckupItems" runat="server"></input>
                                                                                                    <table id="tblHealthCheckupItems" runat="server" border="0" cellpadding="4" cellspacing="0"
                                                                                                        class="dataheaderInvCtrl" width="100%">
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table class="w-100p">
                                                                                <tr>
                                                                                    <td class="a-center">
                                                                                        <asp:HyperLink ID="hypLnkFinish" runat="server" Style="cursor: pointer;" Text="Add Contents to Package" 
                                                                                            Font-Bold="True" Font-Underline="True" Font-Size="14px" onclick="javascript:return showHideSwapBlock();" meta:resourcekey="hypLnkFinishResource1"></asp:HyperLink>
                                                                                        <asp:Button ID="btnPnlClose1" runat="server" class="btn" Text="Close" OnClientClick="return popupClose()" meta:resourcekey="btnPnlCloseResource1" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-right" id="pnlclose" runat="server" style="display: none">
                                                                            <asp:Button ID="btnPnlClose" runat="server" class="btn" Text="Close" 
                                                                                meta:resourcekey="btnPnlCloseResource1" />
                                                                        </td>
                                                                    </tr>
                                                        </table>
                                                        <table class="w-100p">
                                                            <tr runat="server" id="submitTab">
                                                                <td class="a-center" runat="server">
                                                                    <asp:Button ID="btnFinish" runat="server" OnClientClick="return SaveDeletedItems()"
                                                                        OnClick="btnFinish_Click" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'"  meta:resourcekey="btnPnlSaveResource1" />
                                                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" CommandName="Clear" meta:resourcekey="btnPnlCancelResource1"  OnClientClick="return popupClose()" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblExtraSamples" runat="server">
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:Label ID="lblExtraTube" runat="server" Text="Select Extra Tubes for this Package"
                                                                            Font-Bold="True" Font-Underline="True"   Style="display: none;" meta:resourcekey="lblExtraTubeResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:CheckBoxList ID="chklstExtraSamples" runat="server">
                                                                        </asp:CheckBoxList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                        <input type="button" id="btnR" runat="server" style="display: none;" />
                                    </td>
                                </tr>
                                </table>
                                <%--  </div>--%>
                            </ContentTemplate>
                              <Triggers>
                                <asp:PostBackTrigger ControlID="ImageBtnExport" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />           
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdntotalpage" runat="server" />
    </form>
</body>
</html>
