<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CorpoRatePackageProfileControl.ascx.cs" Inherits="CommonControls_CorpoRatePackageProfileControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="InvestigationControl.ascx" TagName="InvestigationControl" TagPrefix="uc1" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

<script language="javascript" type="text/javascript">
    function showHidePKGContent(id) {
        if (document.getElementById('PackageProfileControl_chk' + id).checked) {
            document.getElementById('PackageProfileControl_rowHeader' + id).style.display = "block";
            document.getElementById('PackageProfileControl_rowContent' + id).style.display = "block";
        }
        else {
            document.getElementById('PackageProfileControl_rowHeader' + id).style.display = "none";
            document.getElementById('PackageProfileControl_rowContent' + id).style.display = "none";
        }
        setOrderedPKG();
        return false;
    }
    function showHideAddedItems(id, sVals) {
        if (document.getElementById('PackageProfileControl_' + id).checked) {
            if (document.getElementById('<%= hdnAddSevices.ClientID %>').value == "") {
                CmdAddBillItemsType_onclick("PKG",
                                            sVals.split('~')[0],
                                            0, sVals.split('~')[1],
                                            1, sVals.split('~')[2],
                                            sVals.split('~')[2]);
            }
        }
        else {
            if (document.getElementById('<%= hdnAddSevices.ClientID %>').value == "") {
                btnPaymentDeleteFeeID_OnClick("PKG",
                                            sVals.split('~')[0],
                                            0, sVals.split('~')[1],
                                            1, sVals.split('~')[2],
                                            sVals.split('~')[2]);
            }
        }
        return false;
    }
    function showorHidechkBox(id) {
        document.getElementById('PackageProfileControl_chk' + id).checked = false;
        showHidePKGContent(id);
    }
    function showHidePKG(id) {
        if (document.getElementById('PackageProfileControl_chk' + id).checked) {
            var HidValue = document.getElementById('PackageProfileControl_Hdn').value;
            var HidVal = document.getElementById('PackageProfileControl_Hdnfld').value;
            var list = HidValue.split('^');
            if (document.getElementById('PackageProfileControl_Hdn').value != "") {
                for (var count = 0; count < list.length; count++) {
                    if (list[count] != id) {
                        HidVal += list[count] + '^';
                        document.getElementById('PackageProfileControl_Hdnfld').value = HidVal;
                    }
                }
            }
        }
        else {
            var HidValue = document.getElementById('PackageProfileControl_Hdn').value;
            HidValue += id + '^';
            document.getElementById('PackageProfileControl_Hdn').value = HidValue;
        }
    }

    function showHideSwapBlock(id) {
        if (document.getElementById('PackageProfileControl_swapTR1').style.display == "none") {
            document.getElementById('PackageProfileControl_swapTR1').style.display = "block";
            document.getElementById('PackageProfileControl_swapTR2').style.display = "none";
            LoadSpecialityItems();
            LoadProcedureItems();
            LoadHealthCheckupItems();
            LoadOrdItems1();
            SetCollectedItems();
            var x = document.getElementById('PackageProfileControl_selectedPackage').value;

            if (document.getElementById('submitTab')) {
                document.getElementById('submitTab').style.display = "block";
            }
            //            if ((document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + x).value != "") || (document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + x).value != "") || (document.getElementById('PackageProfileControl_hdnAddedInvGRP' + x).value != "")) {
            //                alert('PackageProfileControl_chkDefault' + x);
            //                document.getElementById('PackageProfileControl_chkDefault' + x).style.display = "block";
            //            }
            //            else {
            //                document.getElementById('PackageProfileControl_chkDefault' + x).style.display = "none";
            //            }

        }
        else if (document.getElementById('PackageProfileControl_swapTR2').style.display == "none") {
            document.getElementById('PackageProfileControl_hdnSpecialityItems').value = document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + id).value;
            document.getElementById('PackageProfileControl_hdnProcedureItems').value = document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + id).value;
            document.getElementById('PackageProfileControl_InvestigationControl1_iconHid').value = document.getElementById('PackageProfileControl_hdnAddedInvGRP' + id).value;
            document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value = document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + id).value;

            if (document.getElementById('submitTab')) {
                document.getElementById('submitTab').style.display = "none";
            }
            document.getElementById('PackageProfileControl_swapTR2').style.display = "block";
            document.getElementById('PackageProfileControl_swapTR1').style.display = "none";
            document.getElementById('PackageProfileControl_selectedPackage').value = id;
        }
        return false;
    }
    function setSelectedType() {
        if (document.getElementById('PackageProfileControl_ddlSelectType').value == "Lab Investigation") {
            document.getElementById('PackageProfileControl_invCtrlTab').style.display = "block";
            document.getElementById('PackageProfileControl_specialityTab').style.display = "none";
            document.getElementById('PackageProfileControl_procedureTab').style.display = "none";
            document.getElementById('PackageProfileControl_HealthCheckupTab').style.display = "none";
        }
        if (document.getElementById('PackageProfileControl_ddlSelectType').value == "Consultation") {
            document.getElementById('PackageProfileControl_invCtrlTab').style.display = "none";
            document.getElementById('PackageProfileControl_specialityTab').style.display = "block";
            document.getElementById('PackageProfileControl_procedureTab').style.display = "none";
            document.getElementById('PackageProfileControl_HealthCheckupTab').style.display = "none";
        }
        if (document.getElementById('PackageProfileControl_ddlSelectType').value == "Treatment Procedure") {
            document.getElementById('PackageProfileControl_invCtrlTab').style.display = "none";
            document.getElementById('PackageProfileControl_specialityTab').style.display = "none";
            document.getElementById('PackageProfileControl_procedureTab').style.display = "block";
            document.getElementById('PackageProfileControl_HealthCheckupTab').style.display = "none";
        }
        if (document.getElementById('PackageProfileControl_ddlSelectType').value == "General Health Checkup") {
            document.getElementById('PackageProfileControl_invCtrlTab').style.display = "none";
            document.getElementById('PackageProfileControl_specialityTab').style.display = "none";
            document.getElementById('PackageProfileControl_HealthCheckupTab').style.display = "block";
            document.getElementById('PackageProfileControl_procedureTab').style.display = "none";

        }


        return false;
    }


    function onClickAddSpeciality() {
        var obj = document.getElementById('PackageProfileControl_listSpeciality');
        var i = obj.getElementsByTagName('OPTION');
        var rwNumber = obj.options[obj.selectedIndex].value;
        var AddStatus = 0;
        var specialityValue = obj.options[obj.selectedIndex].value;
        var specialityText = obj.options[obj.selectedIndex].text;
        document.getElementById('PackageProfileControl_tblSpecialityItems').style.display = 'block';
        var HidValue = document.getElementById('PackageProfileControl_hdnSpecialityItems').value;
        var list = HidValue.split('^');
        if (document.getElementById('PackageProfileControl_hdnSpecialityItems').value != "") {
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
                var row = document.getElementById('PackageProfileControl_tblSpecialityItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpeciality(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = specialityValue;
                cell2.style.display = "none";
                cell3.innerHTML = "<b>" + specialityText + "</b> (Consultation)";
                document.getElementById('PackageProfileControl_hdnSpecialityItems').value += parseInt(rwNumber) + "~" + specialityValue + "~" + specialityText + "^";
                AddStatus = 2;
            }
        }
        if (AddStatus == 0) {
            if (specialityValue != '') {
                var row = document.getElementById('PackageProfileControl_tblSpecialityItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);

                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpeciality(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = specialityValue;
                cell2.style.display = "none";
                cell3.innerHTML = "<b>" + specialityText + "</b> (Consultation)";
                document.getElementById('PackageProfileControl_hdnSpecialityItems').value += parseInt(rwNumber) + "~" + specialityValue + "~" + specialityText + "^";
            }
        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\CorpoRatePackageProfileControl.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert("Consultation Already Added!");
        }
        }
        //        alert(document.getElementById('PackageProfileControl_hdnSpecialityItems').value);
        return false;
    }
    function ImgOnclickSpeciality(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('PackageProfileControl_hdnSpecialityItems').value;
        var list = HidValue.split('^');
        var newSpecialityList = '';
        if (document.getElementById('PackageProfileControl_hdnSpecialityItems').value != "") {
            for (var count = 0; count < list.length; count++) {
                var SpecialityList = list[count].split('~');
                if (SpecialityList[0] != '') {
                    if (SpecialityList[0] != ImgID) {
                        newSpecialityList += list[count] + '^';
                    }
                }
            }
            document.getElementById('PackageProfileControl_hdnSpecialityItems').value = newSpecialityList;
        }
        if (document.getElementById('PackageProfileControl_hdnSpecialityItems').value == '') {
            document.getElementById('PackageProfileControl_tblSpecialityItems').style.display = 'none';
        }
    }
    function ImgOnclickSpeciality1(ImgID) {
        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value;
        var list = HidValue.split('^');
        var newSpecialityList = '';
        if (document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value != "") {
            for (var count = 0; count < list.length; count++) {
                var SpecialityList = list[count].split('~');
                if (SpecialityList[0] != '') {
                    if (SpecialityList[0] != ImgID) {
                        newSpecialityList += list[count] + '^';
                    }
                }
            }
            document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value = newSpecialityList;
        }
        if (document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value == '') {
            document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).style.display = 'none';
        }
    }
    function LoadSpecialityItems() {
        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;

        while (document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).rows.length > 0) {
            //            document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).deleteRow();

            for (var j = 0; j < document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).rows.length; j++) {
                document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).deleteRow(j);
            }
        }
        //alert(document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).rows.length);
        document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value = document.getElementById('PackageProfileControl_hdnSpecialityItems').value;
        var HidValue = document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value;
        var list = HidValue.split('^');
        //alert(document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value);
        if (document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + selectPKG).value != "") {
            //alert(list.length);
            for (var count = 0; count < list.length - 1; count++) {
                var SpecialityList = list[count].split('~');
                var row = document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).insertRow(0);
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
            document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).style.display = 'block';
        }
        document.getElementById('PackageProfileControl_hdnSpecialityItems').value = "";

        while (document.getElementById('PackageProfileControl_tblSpecialityItems').rows.length > 0) {
            //            document.getElementById('PackageProfileControl_tblSpecialityItems').deleteRow();
            for (var j = 0; j < document.getElementById('PackageProfileControl_tblSpecialityItems').rows.length; j++) {
                document.getElementById('PackageProfileControl_tblSpecialityItems').deleteRow(j);

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
        var obj = document.getElementById('PackageProfileControl_listProcedure');
        var i = obj.getElementsByTagName('OPTION');
        var rwNumber = obj.options[obj.selectedIndex].value;
        var AddStatus = 0;
        var ProcedureValue = obj.options[obj.selectedIndex].value;
        var ProcedureText = obj.options[obj.selectedIndex].text;

        document.getElementById('PackageProfileControl_tblProcedureItems').style.display = 'block';
        var HidValue = document.getElementById('PackageProfileControl_hdnProcedureItems').value;
        var list = HidValue.split('^');
        if (document.getElementById('PackageProfileControl_hdnProcedureItems').value != "") {
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
                var row = document.getElementById('PackageProfileControl_tblProcedureItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ProcedureValue;
                cell2.style.display = "none";
                cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                document.getElementById('PackageProfileControl_hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "^";
                AddStatus = 2;
            }
        }
        if (AddStatus == 0) {
            if (ProcedureValue != '') {
                var row = document.getElementById('PackageProfileControl_tblProcedureItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);

                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = ProcedureValue;
                cell2.style.display = "none";
                cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                document.getElementById('PackageProfileControl_hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "^";
            }
        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\CorpoRatePackageProfileControl.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        } else {

            alert("Consultation Already Added!");
        }
        }
        //        alert(document.getElementById('PackageProfileControl_hdnProcedureItems').value);
        return false;
    }
    function ImgOnclickProcedure(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('PackageProfileControl_hdnProcedureItems').value;
        var list = HidValue.split('^');
        var newProcedureList = '';
        if (document.getElementById('PackageProfileControl_hdnProcedureItems').value != "") {
            for (var count = 0; count < list.length; count++) {
                var ProcedureList = list[count].split('~');
                if (ProcedureList[0] != '') {
                    if (ProcedureList[0] != ImgID) {
                        newProcedureList += list[count] + '^';
                    }
                }
            }
            document.getElementById('PackageProfileControl_hdnProcedureItems').value = newProcedureList;
        }
        if (document.getElementById('PackageProfileControl_hdnProcedureItems').value == '') {
            document.getElementById('PackageProfileControl_tblProcedureItems').style.display = 'none';
        }
    }
    function ImgOnclickProcedure1(ImgID) {
        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value;
        var list = HidValue.split('^');
        var newProcedureList = '';
        if (document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value != "") {
            for (var count = 0; count < list.length; count++) {
                var ProcedureList = list[count].split('~');
                if (ProcedureList[0] != '') {
                    if (ProcedureList[0] != ImgID) {
                        newProcedureList += list[count] + '^';
                    }
                }
            }
            document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value = newProcedureList;
        }
        if (document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value == '') {
            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).style.display = 'none';
        }
    }
    function LoadProcedureItems() {
        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;

        while (document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).rows.length > 0) {
            //            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).deleteRow();
            for (var j = 0; j < document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).rows.length; j++) {
                document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).deleteRow(j);
            }

        }
        //alert(document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).rows.length);
        document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value = document.getElementById('PackageProfileControl_hdnProcedureItems').value;
        var HidValue = document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value;
        var list = HidValue.split('^');
        //alert(document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value);
        if (document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + selectPKG).value != "") {
            //alert(list.length);
            for (var count = 0; count < list.length - 1; count++) {
                var ProcedureList = list[count].split('~');
                var row = document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).insertRow(0);
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
            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).style.display = 'block';
        }
        document.getElementById('PackageProfileControl_hdnProcedureItems').value = "";
        while (document.getElementById('PackageProfileControl_tblProcedureItems').rows.length > 0) {
            //            document.getElementById('PackageProfileControl_tblProcedureItems').deleteRow();
            for (var j = 0; j < document.getElementById('PackageProfileControl_tblProcedureItems').rows.length; j++) {
                document.getElementById('PackageProfileControl_tblProcedureItems').deleteRow(j);

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


        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;


        while (document.getElementById('PackageProfileControl_tblOrderedInvesAddedTemp' + selectPKG).rows.length > 0) {
            //            document.getElementById('PackageProfileControl_tblOrderedInvesAddedTemp' + selectPKG).deleteRow();
            for (var j = 0; j < document.getElementById('PackageProfileControl_tblOrderedInvesAddedTemp' + selectPKG).rows.length; j++) {
                document.getElementById('PackageProfileControl_tblOrderedInvesAddedTemp' + selectPKG).deleteRow(j);
            }
        }



        document.getElementById('PackageProfileControl_hdnAddedInvGRP' + selectPKG).value = document.getElementById('PackageProfileControl_InvestigationControl1_iconHid').value;
        var HidValue = document.getElementById('PackageProfileControl_hdnAddedInvGRP' + selectPKG).value;
        var list = HidValue.split('^');



        if (document.getElementById('PackageProfileControl_hdnAddedInvGRP' + selectPKG).value != "") {

            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                var row = document.getElementById('PackageProfileControl_tblOrderedInvesAddedTemp' + selectPKG).insertRow(0);
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
                cell2.innerHTML = "<b>" + InvesList[1] + "</b>" + ext;
                cell3.innerHTML = InvesList[2];
                cell3.style.display = "none";

            }
            document.getElementById('PackageProfileControl_tblOrderedInvesAddedTemp' + selectPKG).style.display = 'block';


        }
        document.getElementById('PackageProfileControl_InvestigationControl1_iconHid').value = "";

        while (document.getElementById('tblOrederedInves').rows.length > 0) {
            //            document.getElementById('tblOrederedInves').deleteRow();
            for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                document.getElementById('tblOrederedInves').deleteRow(j);

            }
        }

        return false;

    }
    function ImgOnclick2(ImgID) {
        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;

        document.getElementById(ImgID).style.display = "none";

        var HidValue = document.getElementById('PackageProfileControl_hdnAddedInvGRP' + selectPKG).value;
        var list = HidValue.split('^');
        var newInvGRPList = '';
        if (document.getElementById('PackageProfileControl_hdnAddedInvGRP' + selectPKG).value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvGRPList = list[count].split('~');
                if (InvGRPList[0] != '') {
                    if (InvGRPList[0] != ImgID) {
                        newInvGRPList += list[count] + '^';
                    }
                }
            }
            document.getElementById('PackageProfileControl_hdnAddedInvGRP' + selectPKG).value = newInvGRPList;
        }
        if (document.getElementById('PackageProfileControl_hdnAddedInvGRP' + selectPKG).value == '') {
            document.getElementById('PackageProfileControl_tblOrderedInvesAddedTemp' + selectPKG).style.display = 'none';
        }
    }

    function SetCollectedItems() {
        document.getElementById('PackageProfileControl_collectedFinalINVGRP').value = "";
        document.getElementById('PackageProfileControl_collectedFinalSpeciality').value = "";
        document.getElementById('PackageProfileControl_collectedFinalProcedure').value = "";
        document.getElementById('PackageProfileControl_collectedFinalHealthCheckUp').value = "";

        var pkgID = document.getElementById('PackageProfileControl_hdntotalFinalPKG').value.split('~');
        for (var count = 0; count < pkgID.length - 1; count++) {
            if (document.getElementById('PackageProfileControl_chk' + pkgID[count]).checked) {
                if (document.getElementById('PackageProfileControl_hdnAddedInvGRP' + pkgID[count]).value != "") {
                    document.getElementById('PackageProfileControl_collectedFinalINVGRP').value += pkgID[count] + "$" + document.getElementById('PackageProfileControl_hdnAddedInvGRP' + pkgID[count]).value + ":";
                }
                if (document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + pkgID[count]).value != "") {
                    document.getElementById('PackageProfileControl_collectedFinalSpeciality').value += pkgID[count] + "-" + document.getElementById('PackageProfileControl_hdnAddedSpecialityItems' + pkgID[count]).value + ":";
                }
                if (document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + pkgID[count]).value != "") {
                    document.getElementById('PackageProfileControl_collectedFinalProcedure').value += pkgID[count] + "-" + document.getElementById('PackageProfileControl_hdnAddedProcedureItems' + pkgID[count]).value + ":";
                }

                if (document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + pkgID[count]).value != "") {

                    document.getElementById('PackageProfileControl_collectedFinalHealthCheckUp').value += pkgID[count] + "-" + document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + pkgID[count]).value + ":";
                }


            }
        }
        //          alert(document.getElementById('PackageProfileControl_collectedFinalINVGRP').value);
        //          alert(document.getElementById('PackageProfileControl_collectedFinalSpeciality').value);
        //          alert(document.getElementById('PackageProfileControl_collectedFinalProcedure').value);
        return false;
    }
    function setDefaultPKG() {
        document.getElementById('PackageProfileControl_setDefaultPKG').value = "";
        var pkgID = document.getElementById('PackageProfileControl_hdntotalFinalPKG').value.split('~');
        for (var count = 0; count < pkgID.length - 1; count++) {
            if (document.getElementById('PackageProfileControl_chkDefault' + pkgID[count]).checked) {

                document.getElementById('PackageProfileControl_setDefaultPKG').value += pkgID[count] + "~";
            }
        }
    }

    function setOrderedPKG() {
        document.getElementById('PackageProfileControl_setOrderedPKG').value = "";
        var pkgID = document.getElementById('PackageProfileControl_hdntotalFinalPKG').value.split('~');
        for (var count = 0; count < pkgID.length - 1; count++) {
            if (document.getElementById('PackageProfileControl_chk' + pkgID[count]).checked) {
                document.getElementById('PackageProfileControl_setOrderedPKG').value += pkgID[count] + "~";
            }
        }
    }


    //          if (document.getElementById(id).checked) {
    //          
    //              var pkgID = document.getElementById(id).value.split('~');
    //              if (pkgID!="")
    //{
    //              for (var count = 0; count < pkgID.length - 1; count++) {
    //              }
    //              }

    //          }
    //          else {
    //              alert('unchecked');
    //          }



    function onClickAddHealthCheckup() {
        var obj = document.getElementById('PackageProfileControl_listHealthCheckup');
        var i = obj.getElementsByTagName('OPTION');
        var rwNumber = obj.options[obj.selectedIndex].value;
        var AddStatus = 0;
        var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
        var HealthCheckupText = obj.options[obj.selectedIndex].text;

        document.getElementById('PackageProfileControl_tblHealthCheckupItems').style.display = 'block';
        var HidValue = document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value;
        var list = HidValue.split('^');
        if (document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value != "") {
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
                var row = document.getElementById('PackageProfileControl_tblHealthCheckupItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = HealthCheckupvalue;
                cell2.style.display = "none";
                cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Health Checkup)";
                document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "^";
                AddStatus = 2;
            }
        }
        if (AddStatus == 0) {
            if (HealthCheckupvalue != '') {
                var row = document.getElementById('PackageProfileControl_tblHealthCheckupItems').insertRow(0);
                row.id = parseInt(rwNumber);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);

                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                cell1.width = "6%";
                cell2.innerHTML = HealthCheckupvalue;
                cell2.style.display = "none";
                cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Health Checkup)";
                document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "^";
            }
        }
        else if (AddStatus == 1) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\CorpoRatePackageProfileControl.ascx_2');
        if (userMsg != null) {
            alert(userMsg);
        } else {

            alert("Health Checkup Already Added!");
        }
        }
        //        alert(document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value);
        return false;
    }
    function ImgOnclickHealthCheckup(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value;
        var list = HidValue.split('^');
        var NewHealthCheckupList = '';
        if (document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value != "") {
            for (var count = 0; count < list.length; count++) {
                var HealthCheckupList = list[count].split('~');
                if (HealthCheckupList[0] != '') {
                    if (HealthCheckupList[0] != ImgID) {
                        NewHealthCheckupList += list[count] + '^';
                    }
                }
            }
            document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value = NewHealthCheckupList;
        }
        if (document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value == '') {
            document.getElementById('PackageProfileControl_tblHealthCheckupItems').style.display = 'none';
        }
    }


    function ImgOnclickHealthCheckup1(ImgID) {
        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value;
        var list = HidValue.split('^');
        var NewHealthCheckupList = '';
        if (document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value != "") {
            for (var count = 0; count < list.length; count++) {
                var HealthCheckupList = list[count].split('~');
                if (HealthCheckupList[0] != '') {
                    if (HealthCheckupList[0] != ImgID) {
                        NewHealthCheckupList += list[count] + '^';
                    }
                }
            }
            document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value = NewHealthCheckupList;
        }
        if (document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value == '') {
            document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).style.display = 'none';
        }
    }
    function LoadHealthCheckupItems() {


        selectPKG = document.getElementById('PackageProfileControl_selectedPackage').value;

        while (document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).rows.length > 0) {
            //            document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).deleteRow();
            for (var j = 0; j < document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).rows.length; j++) {
                document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).deleteRow(j);
            }

        }
        document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value = document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value;
        var HidValue = document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value;
        var list = HidValue.split('^');
        //alert(document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value);
        if (document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value != "") {
            //alert(list.length);
            for (var count = 0; count < list.length - 1; count++) {
                var HealthCheckupList = list[count].split('~');
                var row = document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).insertRow(0);
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
            document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).style.display = 'block';
        }
        document.getElementById('PackageProfileControl_hdnHealthCheckupItems').value = "";
        while (document.getElementById('PackageProfileControl_tblHealthCheckupItems').rows.length > 0) {
            //            document.getElementById('PackageProfileControl_tblHealthCheckupItems').deleteRow();

            for (var j = 0; j < document.getElementById('PackageProfileControl_tblHealthCheckupItems').rows.length; j++) {
                document.getElementById('PackageProfileControl_tblHealthCheckupItems').deleteRow(j);

            }
        }

    }

    function setItemHealthCheckup(e, ctl) {

        var key = window.event ? e.keyCode : e.which;
        if (key == 13) {
            onClickAddHealthCheckup();
        }

    }
     
</script>

<table class="w-100p">
    <tr id="swapTR1" runat="server">
        <td class="w-50p v-top">
            <asp:Table ID="healthPackagesTab" CssClass="dataheaderInvCtrl w-100p" runat="server"
                meta:resourcekey="healthPackagesTabResource1">
            </asp:Table>
        </td>
        <td class="w-50p v-top">
            <asp:Table ID="healthPackagesContentTab" CssClass="w-100p" runat="server" meta:resourcekey="healthPackagesContentTabResource1">
            </asp:Table>
            <input type="hidden" id="selectedPackage" runat="server" />
            <input type="hidden" id="hdntotalFinalPKG" runat="server" />
            <input type="hidden" id="collectedFinalINVGRP" runat="server" />
            <input type="hidden" id="collectedFinalSpeciality" runat="server" />
            <input type="hidden" id="collectedFinalProcedure" runat="server" />
            <input type="hidden" id="collectedFinalHealthCheckUp" runat="server" />
            <input type="hidden" id="setDefaultPKG" runat="server" />
            <input type="hidden" id="setOrderedPKG" runat="server" />
            <input type="hidden" id="setOrderedPKGTemp" runat="server" />
        </td>
    </tr>
    <tr id="swapTR2" runat="server" style="display: none;">
        <td colspan="2">
            <table id="typeTab" class="dataheaderInvCtrl w-40p" runat="server">
                <tr>
                    <td class="w-30p a-center">
                        <b>
                            <asp:Label ID="RS_SelectType" runat="server" Text="Select Type" meta:resourcekey="RS_SelectTypeResource1"></asp:Label></b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSelectType" CssClass="ddlsmall" onchange="javascript:setSelectedType();"
                            runat="server" meta:resourcekey="ddlSelectTypeResource1">
                            <asp:ListItem Selected="True" Text="Lab Investigation" Value="Lab Investigation"
                                meta:resourcekey="ListItemResource1"></asp:ListItem>
                            <asp:ListItem Text="Consultation" Value="Consultation" meta:resourcekey="ListItemResource2"></asp:ListItem>
                            <asp:ListItem Text="Treatment Procedure" Value="Treatment Procedure" meta:resourcekey="ListItemResource3"></asp:ListItem>
                            <asp:ListItem Text="General Health Checkup" Value="General Health Checkup" meta:resourcekey="ListItemResource4"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <table id="invCtrlTab" runat="server" class="w-100p">
                <tr>
                    <td>
                        <uc1:InvestigationControl ID="InvestigationControl1" runat="server" />
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="Hdn" runat="server" />
            <asp:HiddenField ID="Hdnfld" runat="server" />
            <table id="specialityTab" class="w-100p" style="display: none;" runat="server">
                <tr>
                    <td>
                        <asp:Label ID="lblSpeciality" runat="server" Text="Speciality" meta:resourcekey="lblSpecialityResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="w-50p v-top">
                                    <asp:ListBox ID="listSpeciality" runat="server" onkeypress="javascript:setItemS(event,this);"
                                        ondblClick="javascript:onClickAddSpeciality();" Width="350px" Height="150px"
                                        meta:resourcekey="listSpecialityResource1"></asp:ListBox>
                                </td>
                                <td class="w-50p v-top">
                                    <input type="hidden" id="hdnSpecialityItems" runat="server" />
                                    <table id="tblSpecialityItems" class="dataheaderInvCtrl w-100p" runat="server">
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table id="procedureTab" class="w-100p" style="display: none;" runat="server">
                <tr>
                    <td>
                        <asp:Label ID="lblProcedure" runat="server" Text="Procedure" meta:resourcekey="lblProcedureResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="w-50p v-top">
                                    <asp:ListBox ID="listProcedure" runat="server" onkeypress="javascript:setItemP(event,this);"
                                        ondblClick="javascript:onClickAddProcedure();" Width="350px" CssClass="h-100"
                                        meta:resourcekey="listProcedureResource1"></asp:ListBox>
                                </td>
                                <td class="w-50p v-top">
                                    <input type="hidden" id="hdnProcedureItems" runat="server" />
                                    <table id="tblProcedureItems" class="dataheaderInvCtrl w-100p" runat="server">
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table id="HealthCheckupTab" class="w-100p" style="display: none;" runat="server">
                <tr>
                    <td>
                        <asp:Label ID="lblSpecialiType" runat="server" Text="Speciality Type" meta:resourcekey="lblSpecialiTypeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="w-50p v-top">
                                    <asp:ListBox ID="listHealthCheckup" runat="server" onkeypress="javascript:setItemHealthCheckup(event,this);"
                                        ondblClick="javascript:onClickAddHealthCheckup();" Width="350px" Height="150px"
                                        meta:resourcekey="listHealthCheckupResource1"></asp:ListBox>
                                </td>
                                <td class="w-50p v-top">
                                    <input type="hidden" id="hdnHealthCheckupItems" runat="server" />
                                    <table id="tblHealthCheckupItems" class="dataheaderInvCtrl w-100p" runat="server"
                                        cellpadding="4">
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
                        <asp:HyperLink ID="hypLnkFinish" runat="server" Style="cursor: pointer;" Text="Finish"
                            Font-Bold="True" Font-Underline="True" CssClass="font14" onclick="javascript:return showHideSwapBlock();"
                            meta:resourcekey="hypLnkFinishResource1"></asp:HyperLink>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnAddSevices" runat="server" />
