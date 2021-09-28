<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SurgeryPackage.aspx.cs" Inherits="Admin_SurgeryPackage" meta:resourcekey="PageResource1"%>

<%@ Register Src="../CommonControls/InvestigationControl1.ascx" TagName="InvestigationControl"
    TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PackageProfileControl1.ascx" TagName="PackageProfileControl"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css">
        <style>
            .odd
            {
                background-color: white;
            }
        </style>
    </link>
    <script type="text/javascript" language="javascript">


        function checkIt(evt) {
            evt = (evt) ? evt : window.event
            var charCode = (evt.which) ? evt.which : evt.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                // status = "This field accepts numbers only."
                return false
            }
            // status = ""
            return true
        }
        function surgerycheck() {
            if (document.getElementById('TabContainer1_tab1_txtpackage').value.trim() == "") {
                var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_1");
                if (userMsg != null) {
                    alert(userMsg);
                    //return false;
                }
                else {
                    alert('Provide the package name');
                    //return false;
                }
                document.getElementById('TabContainer1_tab1_txtpackage').focus();
                return false;
            }
            //            else if (document.getElementById('TabContainer1_tab1_txtAmount').value.trim() == "") {
            //                alert('Provide the amount');
            //                document.getElementById('TabContainer1_tab1_txtAmount').focus();
            //                return false;
            //            }
            else if (document.getElementById('TabContainer1_tab1_txtDays').value.trim() == "") {
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_3");
            if (userMsg != null) {
                alert(userMsg);
//                return false;
            }
            else {
                alert('Provide the days');
//                return false;
            }
                
                document.getElementById('TabContainer1_tab1_txtDays').focus();
                return false;
            }
            //            else if (document.getElementById('TabContainer1_tab1_txtBefore').value.trim() == "") {
            //                alert('Provide the number of consultations before using package');
            //                document.getElementById('TabContainer1_tab1_txtBefore').focus();
            //                return false;
            //            }
            //            else if (document.getElementById('TabContainer1_tab1_txtAfter').value.trim() == "") {
            //                alert('Provide the number of consultations after using package');
            //                document.getElementById('TabContainer1_tab1_txtAfter').focus();
            //                return false;
            //            }
            //            else if (document.getElementById('TabContainer1_tab1_txtValidity').value.trim() == "") {
            //                alert('Provide the consultation validity period');
            //                document.getElementById('TabContainer1_tab1_txtValidity').focus();
            //                return false;
            //            }
        }
        function loadsurgerydata(obj) {
            document.getElementById('TabContainer1_tab1_txtpackage').value = obj.cname;
            document.getElementById('TabContainer1_tab1_txtAmount').value = obj.camount;
            document.getElementById('TabContainer1_tab1_txtDays').value = obj.cdays;
            document.getElementById('TabContainer1_tab1_txtBefore').value = obj.cbefore;
            document.getElementById('TabContainer1_tab1_txtAfter').value = obj.cafter;
            document.getElementById('TabContainer1_tab1_txtValidity').value = obj.cvalidity;
            document.getElementById('TabContainer1_tab1_btnSave').value = 'Update';
            document.getElementById('btn').style.display = 'block';
            document.getElementById('hdnid').value = obj.cid;
            document.getElementById('TabContainer1_tab1_btnCancel').style.display = 'none'
        }
        function setSelectedType() {
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Lab Investigation") {
                document.getElementById('TabContainer1_tab2_invCtrlTab').style.display = "block";
                document.getElementById('TabContainer1_tab2_specialityTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_procedureTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_HealthCheckupTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_RoomTypeTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_AmbulanceTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_SurgeryTab').style.display = "none";
            }
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Consultation") {
                document.getElementById('TabContainer1_tab2_invCtrlTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_specialityTab').style.display = "block";
                document.getElementById('TabContainer1_tab2_procedureTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_HealthCheckupTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_RoomTypeTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_AmbulanceTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_SurgeryTab').style.display = "none";
            }
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Treatment Procedure") {
                document.getElementById('TabContainer1_tab2_invCtrlTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_specialityTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_procedureTab').style.display = "block";
                document.getElementById('TabContainer1_tab2_HealthCheckupTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_RoomTypeTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_AmbulanceTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_SurgeryTab').style.display = "none";
            }
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Medical Indents") {
                document.getElementById('TabContainer1_tab2_invCtrlTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_specialityTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_procedureTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_HealthCheckupTab').style.display = "block";
                document.getElementById('TabContainer1_tab2_RoomTypeTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_AmbulanceTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_SurgeryTab').style.display = "none";
            }
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Room Type") {
                document.getElementById('TabContainer1_tab2_invCtrlTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_specialityTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_procedureTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_HealthCheckupTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_RoomTypeTab').style.display = "block";
                document.getElementById('TabContainer1_tab2_AmbulanceTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_SurgeryTab').style.display = "none";
            }
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Ambulance") {
                document.getElementById('TabContainer1_tab2_invCtrlTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_specialityTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_procedureTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_HealthCheckupTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_RoomTypeTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_AmbulanceTab').style.display = "block";
                document.getElementById('TabContainer1_tab2_SurgeryTab').style.display = "none";
            }
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Surgery") {
                document.getElementById('TabContainer1_tab2_invCtrlTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_specialityTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_procedureTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_HealthCheckupTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_RoomTypeTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_AmbulanceTab').style.display = "none";
                document.getElementById('TabContainer1_tab2_SurgeryTab').style.display = "block";
            }
            return false;
        }
        function showEdit(id, value) {
            alert(document.getElementById('TabContainer1_tab2_txt' + id).value);
            document.getElementById('TabContainer1_tab2_txt' + id).style.display = "block";
            document.getElementById('TabContainer1_tab2_txt' + id).value = value;
            document.getElementById('TabContainer1_tab2_lnk' + id).style.display = "none";
        }

        function txtvalue(id) {
            document.getElementById(id).style.display = "none";
        }


        function showHidePKG(id, pkg) {
            //            if (document.getElementById('TabContainer1_tab2_chk' + id).checked) {
            //                document.getElementById('TabContainer1_tab2_chk' + id).checked = false;
            //            }
            //            else {
            //                document.getElementById('TabContainer1_tab2_chk' + id).checked = true;
            //            }        
            //alert("I");
            if (document.getElementById('TabContainer1_tab2_chk' + id + pkg).checked == true) {
                //alert((document.getElementById('TabContainer1_tab2_chk' + id).checked));
                var HidValue = document.getElementById('TabContainer1_tab2_Hdn').value;
                var HidVal = document.getElementById('TabContainer1_tab2_Hdnfld').value;
                //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_Hdn').value);
                var lst = HidValue.split('^');
                if (document.getElementById('TabContainer1_tab2_Hdn').value != "") {
                    for (var count = 0; count < list.length; count++) {
                        var list = lst[count].split('~');
                        if (list[0] != id) {
                            HidVal += list[0] + '~' + list[1] + '^';
                            document.getElementById('TabContainer1_tab2_Hdnfld').value = HidVal;
                        }
                    }
                }
            }
            else {
                //alert("I");
                var HidValue = document.getElementById('TabContainer1_tab2_Hdn').value;
                HidValue += id + '~' + pkg + '^';
                //alert(HidValue);
                document.getElementById('TabContainer1_tab2_Hdn').value = HidValue;
                //alert(document.getElementById('TabContainer1_tab2_Hdn').value);
            }
        }

        function onClickAddConsultation() {
            var obj = document.getElementById('TabContainer1_tab2_listSpeciality');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
            var HealthCheckupText = obj.options[obj.selectedIndex].text;
            document.getElementById('TabContainer1_tab2_tblSpecialityItems').style.display = 'block';
            var HidValue = document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value != "") {
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
                    var Header = document.getElementById('TabContainer1_tab2_tblSpecialityItems').insertRow(0);
                    var Headercell1 = Header.insertCell(0);
                    var Headercell2 = Header.insertCell(1);
                    var Headercell3 = Header.insertCell(2);
                    var Headercell4 = Header.insertCell(3);
                    //                    var Headercell5 = Header.insertCell(4);
                    Header.className = "evenforsurg";
                    Headercell1.width = "6%";
                    Headercell2.style.display = "none";
                    Headercell3.innerHTML = "<b> Values </b> ";
                    Headercell4.innerHTML = "<b> Quantity </b>";
                    //                    Headercell5.innerHTML = "<b> Physician Name </b>";
                    var row = document.getElementById('TabContainer1_tab2_tblSpecialityItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickConsultation(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Consultation)";
                    cell3.width = "12%";
                    cell4.innerHTML = "<input type='text' value='0' id='Contxt' size='4'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetCONCount(" + row.id + ",this.value);' />";
                    ////                    cell5.innerHTML = "<select id='ddl" + rwNumber + "' onclick='bindlist(this.id," + HealthCheckupvalue + ");' onchange='GetPhy(" + row.id + ",this.id)'/>"
                    var value = document.getElementById('Contxt').value;
                    var ddlvalue = '0'
                    document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "~" + ddlvalue + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('TabContainer1_tab2_tblSpecialityItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickConsultation(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Consultation)";
                    cell3.width = "12%";
                    cell4.innerHTML = "<input type='text' value='0' id='Contxt' size='4'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetCONCount(" + row.id + ",this.value);' />";
                    //                    cell5.innerHTML = "<select id='ddl' onclick='bindlist(this.id," + HealthCheckupvalue + ");' onchange='GetPhy(" + row.id + ",this.id)'/>"
                    var value = document.getElementById('Contxt').value;
                    var ddlvalue = '0'
                    document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "~" + ddlvalue + "^";
                }
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_7");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Consultation already added');
                return false;
            }
            }
            //        alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnHealthCheckupItems').value);
           // return false;
        }

        function bindlist(id, val) {
            var ddlobj = document.getElementById(id);
            var check = val;
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdna = document.getElementById('TabContainer1_tab2_hdnphysician');
                var list = hdna.value.split('^');
                var opt = document.createElement("option");
                document.getElementById(id).options.add(opt);
                opt.text = '--Select-->';
                opt.value = 0;
                for (var i = 0; i < list.length - 1; i++) {
                    var value = list[i].split('~');
                    if (check == value[2]) {
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                }
            }
        }
        function editbindlist(id, val, value) {
            var phy = 0;
            var ddlobj = document.getElementById(id);
            var check = val;
            if (ddlobj.options.length == 0) {
                ddlobj.options.length = 0;
                var hdna = document.getElementById('TabContainer1_tab2_hdnphysician');
                var list = hdna.value.split('^');

                var hdn = document.getElementById('TabContainer1_tab2_hdneditSpecialityItems');
                var lst = hdn.value.split('^');
                for (var j = 0; j < lst.length - 1; j++) {
                    var phyval = lst[j].split('~');
                    if (val == phyval[1]) {
                        phy = phyval[4];
                    }
                }
                var opt = document.createElement("option");
                document.getElementById(id).options.add(opt);
                opt.text = '--Select-->';
                opt.value = 0;
                for (var i = 0; i < list.length - 1; i++) {
                    var value = list[i].split('~');
                    if (check == value[2]) {
                        var opt = document.createElement("option");
                        document.getElementById(id).options.add(opt);
                        opt.text = value[1];
                        opt.value = value[0];
                    }
                }
                document.getElementById(id).value = phy;
            }
        }

        function onClickAddAmbulance() {
            var obj = document.getElementById('TabContainer1_tab2_lstambulance');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
            var HealthCheckupText = obj.options[obj.selectedIndex].text;
            document.getElementById('TabContainer1_tab2_tblAmbulance').style.display = 'block';
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAmbulance').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdnAmbulance').value != "") {
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
                    var Header = document.getElementById('TabContainer1_tab2_tblAmbulance').insertRow(0);
                    var Headercell1 = Header.insertCell(0);
                    var Headercell2 = Header.insertCell(1);
                    var Headercell3 = Header.insertCell(2);
                    var Headercell4 = Header.insertCell(3);
                    Header.className = "evenforsurg";

                    Headercell1.width = "6%";

                    Headercell2.style.display = "none";

                    Headercell3.innerHTML = "<b> Values </b> ";

                    Headercell4.innerHTML = "<b> Quantity </b>";
                    var row = document.getElementById('TabContainer1_tab2_tblAmbulance').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAmbulanceItems(" + row.id + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (General Items)";
                    cell4.innerHTML = "<input type='text' value='0' id='AMtxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetAMCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('AMtxt').value;
                    document.getElementById('TabContainer1_tab2_hdnAmbulance').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('TabContainer1_tab2_tblAmbulance').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickAmbulanceItems(" + row.id + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (General Items)";
                    cell4.innerHTML = "<input type='text' value='0' id='AMtxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetAMCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('AMtxt').value;
                    document.getElementById('TabContainer1_tab2_hdnAmbulance').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                }
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_8");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Ambulance already added');
                return false;
            }
            }
            //        alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnHealthCheckupItems').value);
            //return false;
        }
        function onClickAddHealthCheckup() {
            var obj = document.getElementById('TabContainer1_tab2_listHealthCheckup');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
            var HealthCheckupText = obj.options[obj.selectedIndex].text;
            document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').style.display = 'block';
            var HidValue = document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value != "") {
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
                    var Header = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').insertRow(0);
                    var Headercell1 = Header.insertCell(0);
                    var Headercell2 = Header.insertCell(1);
                    var Headercell3 = Header.insertCell(2);
                    var Headercell4 = Header.insertCell(3);
                    Header.className = "evenforsurg";

                    Headercell1.width = "6%";

                    Headercell2.style.display = "none";

                    Headercell3.innerHTML = "<b> Values </b> ";

                    Headercell4.innerHTML = "<b> Quantity </b>";
                    var row = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Medical Indents)";
                    cell4.innerHTML = "<input type='text' value='0' id='MItxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetMICount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('MItxt').value;
                    document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Medical Indents)";
                    cell4.innerHTML = "<input type='text' value='0' id='MItxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetMICount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('MItxt').value;
                    document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                }
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_9");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Medical indents already added');
                return false;
            }
            }
            //        alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnHealthCheckupItems').value);
            //return false;
        }
        function onClickAddRoomType() {
            var obj = document.getElementById('TabContainer1_tab2_lstRoomType');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
            var HealthCheckupText = obj.options[obj.selectedIndex].text;
            document.getElementById('TabContainer1_tab2_tblRoomTypeItems').style.display = 'block';
            var HidValue = document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value != "") {
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
                    var Header = document.getElementById('TabContainer1_tab2_tblRoomTypeItems').insertRow(0);
                    var Headercell1 = Header.insertCell(0);
                    var Headercell2 = Header.insertCell(1);
                    var Headercell3 = Header.insertCell(2);
                    var Headercell4 = Header.insertCell(3);
                    Header.className = "evenforsurg";

                    Headercell1.width = "6%";

                    Headercell2.style.display = "none";

                    Headercell3.innerHTML = "<b> Values </b> ";

                    Headercell4.innerHTML = "<b> Quantity </b>";
                    var row = document.getElementById('TabContainer1_tab2_tblRoomTypeItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickRoomTypeItems(" + row.id + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Room Type)";
                    cell4.innerHTML = "<input type='text' value='0' id='RTtxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetRTCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('RTtxt').value;
                    document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('TabContainer1_tab2_tblRoomTypeItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickRoomTypeItems(" + row.id + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Room Type)";
                    cell4.innerHTML = "<input type='text' value='0' id='RTtxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetRTCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('RTtxt').value;
                    document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                }
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_10");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Room type already added');
                return false;
            }
            }
            //        alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnHealthCheckupItems').value);
            //return false;
        }


        function onClickAddSurgeryType() {
            var obj = document.getElementById('TabContainer1_tab2_lstSurgeryType');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
            var HealthCheckupText = obj.options[obj.selectedIndex].text;
            document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').style.display = 'block';
            var HidValue = document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value != "") {
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
                    var Header = document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').insertRow(0);
                    var Headercell1 = Header.insertCell(0);
                    var Headercell2 = Header.insertCell(1);
                    var Headercell3 = Header.insertCell(2);
                    var Headercell4 = Header.insertCell(3);
                    Header.className = "evenforsurg";

                    Headercell1.width = "6%";

                    Headercell2.style.display = "none";

                    Headercell3.innerHTML = "<b> Values </b> ";

                    Headercell4.innerHTML = "<b> Quantity </b>";
                    var row = document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSurgeryTypeItems(" + row.id + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Surgery Type)";
                    cell4.innerHTML = "<input type='text' value='0' id='SRGtxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetSRGCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('SRGtxt').value;
                    document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (HealthCheckupvalue != '') {
                    var row = document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSurgeryTypeItems(" + row.id + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupvalue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Surgery Type)";
                    cell4.innerHTML = "<input type='text' value='0' id='SRGtxt'    onkeypress='return ValidateOnlyNumeric(this);'   onblur='GetSRGCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('SRGtxt').value;
                    document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
                }
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_11");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Surgery type already added');
                return false;
            }
            }
            //        alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnHealthCheckupItems').value);
           // return false;
        }


        function setItemHealthCheckup(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddHealthCheckup();
            }
        }

        function setItemConsultation(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddConsultation();
            }
        }

        function setItemRoomType(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddRoomType();
            }
        }

        function setItemSurgeryType(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddSurgeryType();
            }
        }

        function setItemAmbulance(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClickAddAmbulance();
            }
        }
        function ImgOnclickHealthCheckup(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value = NewHealthCheckupList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value == '') {
                document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').style.display = 'none';
                var table = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems')
                var len = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').rows.length;
                var lenth = len - 1;
                for (var i = 0; i < lenth; i++) {
                    document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').deleteRow(i);
                }
            }
        }
        function ImgOnclickConsultation(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = NewHealthCheckupList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value == '') {
                document.getElementById('TabContainer1_tab2_tblSpecialityItems').style.display = 'none';
                var table = document.getElementById('TabContainer1_tab2_tblSpecialityItems')
                var len = document.getElementById('TabContainer1_tab2_tblSpecialityItems').rows.length;
                var lenth = len - 1;
                for (var i = 0; i < lenth; i++) {
                    document.getElementById('TabContainer1_tab2_tblSpecialityItems').deleteRow(i);
                }
            }
        }
        function ImgOnclickAmbulanceItems(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAmbulance').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAmbulance').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAmbulance').value = NewHealthCheckupList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAmbulance').value == '') {
                document.getElementById('TabContainer1_tab2_tblAmbulance').style.display = 'none';
                var table = document.getElementById('TabContainer1_tab2_tblAmbulance')
                var len = document.getElementById('TabContainer1_tab2_tblAmbulance').rows.length;
                var lenth = len - 1;
                for (var i = 0; i < lenth; i++) {
                    document.getElementById('TabContainer1_tab2_tblAmbulance').deleteRow(i);
                }
            }
        }

        function ImgOnclickRoomTypeItems(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value = NewHealthCheckupList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value == '') {
                document.getElementById('TabContainer1_tab2_tblRoomTypeItems').style.display = 'none';
                var table = document.getElementById('TabContainer1_tab2_tblRoomTypeItems')
                var len = document.getElementById('TabContainer1_tab2_tblRoomTypeItems').rows.length;
                var lenth = len - 1;
                for (var i = 0; i < lenth; i++) {
                    document.getElementById('TabContainer1_tab2_tblRoomTypeItems').deleteRow(i);
                }
            }
        }

        function ImgOnclickSurgeryTypeItems(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value = NewHealthCheckupList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value == '') {
                document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').style.display = 'none';
                var table = document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems')
                var len = document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').rows.length;
                var lenth = len - 1;
                for (var i = 0; i < lenth; i++) {
                    document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').deleteRow(i);
                }
            }
        }

        function LoadHealthCheckupItems() {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            while (document.getElementById('TabContainer1_tab2_tblAddedHealthCheckupItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedHealthCheckupItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblAddedHealthCheckupItems' + selectPKG).rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblAddedHealthCheckupItems' + selectPKG).deleteRow(j);
                }
            }
            document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + selectPKG).value = document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value;
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('PackageProfileControl_hdnAddedHealthCheckupItems' + selectPKG).value);
            if (document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var HealthCheckupList = list[count].split('~');
                    var row = document.getElementById('TabContainer1_tab2_tblAddedHealthCheckupItems' + selectPKG).insertRow(0);
                    row.id = HealthCheckupList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickHealthPackage1(" + parseInt(HealthCheckupList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = HealthCheckupList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + HealthCheckupList[2] + "</b> (Medical Indents)";
                    cell4.innerHTML = "<b>" + HealthCheckupList[3] + "</b> (Count)";

                }
                document.getElementById('TabContainer1_tab2_tblAddedHealthCheckupItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value = "";
            while (document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblHealthCheckupItems').deleteRow();

                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').deleteRow(j);
                }
            }
        }

        function surgeryclear() {
            document.getElementById('TabContainer1_tab1_btnSave').value = 'Save';
            document.getElementById('TabContainer1_tab1_btnCancel').style.display = 'block'
            document.getElementById('btn').style.display = 'none';
            document.getElementById('hdnid').value = "";
            return false;
        }

        function pChekUserName() {
            var i;
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_14");
            if (userMsg != null) {
                i=confirm(userMsg);
                //return false;
            }
            else {
                i = confirm('Are you sure you wish to delete this Package?');
            }

           // i = confirm('Are you sure you wish to delete this Package?');
            if (i == true) {
                return;
            }
            else {
                return false;
            }
        }
        function showHidePKGContent(id) {
            if (document.getElementById('TabContainer1_tab2_chk' + id).checked) {
                document.getElementById('TabContainer1_tab2_rowHeader' + id).style.display = "block";
                document.getElementById('TabContainer1_tab2_rowContent' + id).style.display = "block";
            }
            else {
                document.getElementById('TabContainer1_tab2_rowHeader' + id).style.display = "none";
                document.getElementById('TabContainer1_tab2_rowContent' + id).style.display = "none";
            }
            setOrderedPKG();
            return false;
        }
        function onClickAddProcedure() {
            // alert("H");
            var obj = document.getElementById('TabContainer1_tab2_listProcedure');
            var i = obj.getElementsByTagName('OPTION');
            var rwNumber = obj.options[obj.selectedIndex].value;
            var AddStatus = 0;
            var ProcedureValue = obj.options[obj.selectedIndex].value;
            var ProcedureText = obj.options[obj.selectedIndex].text;
            document.getElementById('TabContainer1_tab2_tblProcedureItems').style.display = 'block';
            var HidValue = document.getElementById('TabContainer1_tab2_hdnProcedureItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdnProcedureItems').value != "") {
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
                    var Header = document.getElementById('TabContainer1_tab2_tblProcedureItems').insertRow(0);
                    var Headercell1 = Header.insertCell(0);
                    var Headercell2 = Header.insertCell(1);
                    var Headercell3 = Header.insertCell(2);
                    var Headercell4 = Header.insertCell(3);
                    Header.className = "evenforsurg";

                    Headercell1.width = "6%";

                    Headercell2.style.display = "none";

                    Headercell3.innerHTML = "<b> Values </b> ";

                    Headercell4.innerHTML = "<b> Quantity </b>";
                    var row = document.getElementById('TabContainer1_tab2_tblProcedureItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                    cell4.innerHTML = "<input type='text' value='0' id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='GetProCount(" + row.id + ",this.value);' />";
                    //cell4.innerHTML = "<input type='text' value='0' id='txt'    onkeypress="return ValidateOnlyNumeric(this);"   onblur='GetInvCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('txt').value;
                    document.getElementById('TabContainer1_tab2_hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "~" + value + "^";
                    //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnProcedureItems').value);
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (ProcedureValue != '') {
                    var row = document.getElementById('TabContainer1_tab2_tblProcedureItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureValue;
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureText + "</b> (Procedure)";
                    cell4.innerHTML = "<input type='text' value='0' id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='GetProCount(" + row.id + ",this.value);' />";
                    var value = document.getElementById('txt').value;
                    document.getElementById('TabContainer1_tab2_hdnProcedureItems').value += parseInt(rwNumber) + "~" + ProcedureValue + "~" + ProcedureText + "~" + value + "^";
                }
            }
            else if (AddStatus == 1) {
            var userMsg = SListForApplicationMessages.Get("Admin\\SurgeryPackage.aspx_12");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Procedure already added');
                return false;
            }
            }
            //        alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnProcedureItems').value);
            //return false;
        }
        function editRTCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempRTHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdneditRoomTypeItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';
                        // alert(x);
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempRTHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            //document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value = "";
            //document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value = document.getElementById('TabContainer1_tab2_tempRTHid').value;
            document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value += x;
        }

        function GetRTCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempRTHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';
                        // alert(x);
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempRTHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value = "";
            document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value = document.getElementById('TabContainer1_tab2_tempRTHid').value;
            document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value += x;
        }
        function editSRGCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempSRGHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdneditSurgeryTypeItems').value.split('^');

            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');

                if (InvesList != "") {

                    if (InvesList[0] == obj) {

                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';

                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempSurgeryHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }

            document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value += x;
        }
        function GetSRGCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempSRGHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';
                        // alert(x);
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempSRGHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value = "";
            document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value = document.getElementById('TabContainer1_tab2_tempSRGHid').value;
            document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value += x;
        }

        function GetPhy(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempphy').value = "";
            var ddlvalue = document.getElementById(value).value;
            var list = document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + ddlvalue + '^';

                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempphy').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + InvesList[4] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = "";
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = document.getElementById('TabContainer1_tab2_tempphy').value;
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value += x;
        }
        function editPhy(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempphy').value = "";
            var ddlvalue = document.getElementById(value).value;

            var list = document.getElementById('TabContainer1_tab2_hdneditSpecialityItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + ddlvalue + '^';
                        document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = "";

                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempphy').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + InvesList[4] + '^';
                    }
                }
            }

            //document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = document.getElementById('TabContainer1_tab2_tempphy').value;
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value += x;

        }
        function editCONCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempCONHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdneditSpecialityItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {
                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '~' + InvesList[4] + '^';
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempCONHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            //document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = "";
            // document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = document.getElementById('TabContainer1_tab2_tempCONHid').value;
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value += x;
            document.getElementById('TabContainer1_tab2_hdneditSpecialityItems').value = x;
        }

        function GetCONCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempCONHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {
                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '~' + InvesList[4] + '^';
                        // alert(x);
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempCONHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + InvesList[4] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = "";
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = document.getElementById('TabContainer1_tab2_tempCONHid').value;
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value += x;
        }
        function GetMICount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempMIHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {
                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempMIHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value = "";
            document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value = document.getElementById('TabContainer1_tab2_tempMIHid').value;
            document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value += x;
        }
        function editMICount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempMIHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdneditHealthCheckupItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';
                        // alert(x);
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempMIHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            //document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value = "";
            //document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value = document.getElementById('TabContainer1_tab2_tempMIHid').value;
            document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value += x;
        }
        function GetAMCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempAMHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdnAmbulance').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';
                        // alert(x);
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempAMHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnAmbulance').value = "";
            document.getElementById('TabContainer1_tab2_hdnAmbulance').value = document.getElementById('TabContainer1_tab2_tempAMHid').value;
            document.getElementById('TabContainer1_tab2_hdnAmbulance').value += x;
        }
        function editAMCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempAMHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdneditAmbulance').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {

                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';
                        // alert(x);
                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempAMHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            //document.getElementById('TabContainer1_tab2_hdnAmbulance').value = "";
            //document.getElementById('TabContainer1_tab2_hdnAmbulance').value = document.getElementById('TabContainer1_tab2_tempAMHid').value;
            document.getElementById('TabContainer1_tab2_hdnAmbulance').value += x;
        }
        function GetProCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempProHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdnProcedureItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');

                if (InvesList != "") {
                    if (InvesList[0] == obj) {
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';

                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempProHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnProcedureItems').value = "";
            document.getElementById('TabContainer1_tab2_hdnProcedureItems').value = document.getElementById('TabContainer1_tab2_tempProHid').value;
            document.getElementById('TabContainer1_tab2_hdnProcedureItems').value += x;
        }
        function editInvCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempProHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdneditinv').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {
                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '~' + value + '^';

                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempProHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_InvestigationControl1_iconHid').value += x;
        }
        function editProCount(obj, value) {
            var x = '';
            document.getElementById('TabContainer1_tab2_tempProHid').value = "";
            var list = document.getElementById('TabContainer1_tab2_hdneditProcedureItems').value.split('^');
            // alert(list);
            for (var count = 0; count < list.length - 1; count++) {
                var InvesList = list[count].split('~');
                //            alert(InvesList[0]);
                //            alert(obj);
                if (InvesList != "") {
                    if (InvesList[0] == obj) {
                        //InvesList[4] = value;
                        // alert(InvesList[0]);
                        x = InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + value + '^';

                    }
                    else {
                        document.getElementById('TabContainer1_tab2_tempProHid').value += InvesList[0] + '~' + InvesList[1] + '~' + InvesList[2] + '~' + InvesList[3] + '^';
                    }
                }
            }
            document.getElementById('TabContainer1_tab2_hdnProcedureItems').value += x;
        }
        function setOrderedPKG() {
            document.getElementById('TabContainer1_tab2_setOrderedPKG').value = "";
            var pkgID = document.getElementById('TabContainer1_tab2_hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                if (document.getElementById('TabContainer1_tab2_chk' + pkgID[count]).checked) {
                    document.getElementById('TabContainer1_tab2_setOrderedPKG').value += pkgID[count] + "~";
                }
            }
        }
        function LoadOrdItems1() {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            while (document.getElementById('TabContainer1_tab2_tblOrderedInvesAddedTemp' + selectPKG).rows.length > 0) {
                //document.getElementById('PackageProfileControl_TabContainer1_tab2_tblOrderedInvesAddedTemp' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblOrderedInvesAddedTemp' + selectPKG).rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblOrderedInvesAddedTemp' + selectPKG).deleteRow(j);
                }
            }
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_InvestigationControl1_iconHid').value);
            document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + selectPKG).value = document.getElementById('TabContainer1_tab2_InvestigationControl1_iconHid').value;
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + selectPKG).value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + selectPKG).value != "") {
                // alert(HidValue);
                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    var row = document.getElementById('TabContainer1_tab2_tblOrderedInvesAddedTemp' + selectPKG).insertRow(0);
                    row.id = InvesList[0];
                    var txtid = InvesList[4];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickInvestigation1(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    if (InvesList[2] == "INV") {
                        ext = " (Investigation)";
                    }
                    else {
                        ext = " (Group)";
                    }
                    document.getElementById('TabContainer1_tab2_InvestigationControl1_iconHid').value = "";
                    while (document.getElementById('tblOrederedInves').rows.length > 0) {
                        //            document.getElementById('tblOrederedInves').deleteRow();
                        for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                            document.getElementById('tblOrederedInves').deleteRow(j);
                        }
                    }
                    cell2.innerHTML = "<b>" + InvesList[1] + "</b>" + ext;
                    cell3.innerHTML = InvesList[2];
                    cell3.style.display = "none";
                    cell4.innerHTML = "<b>" + txtid + "</b>" + "(Count)";
                }
                document.getElementById('TabContainer1_tab2_tblOrderedInvesAddedTemp' + selectPKG).style.display = 'block';
            }
            document.getElementById('TabContainer1_tab2_InvestigationControl1_iconHid').value = "";

            while (document.getElementById('tblOrederedInves').rows.length > 0) {

                //document.getElementById('tblOrederedInves').deleteRow();
                for (var j = 0; j < document.getElementById('tblOrederedInves').rows.length; j++) {
                    document.getElementById('tblOrederedInves').deleteRow(j);
                }
            }
            return false;
        }
        function LoadProcedureItems() {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;

            while (document.getElementById('TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).deleteRow(j);
                }
            }
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).rows.length);
            document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value = document.getElementById('TabContainer1_tab2_hdnProcedureItems').value;
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value);
            if (document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var ProcedureList = list[count].split('~');
                    var row = document.getElementById('TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).insertRow(0);
                    row.id = ProcedureList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickProcedure1(" + parseInt(ProcedureList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Procedure)";
                    cell4.innerHTML = "<b>" + ProcedureList[3] + "</b> (Count)";
                }
                document.getElementById('TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('TabContainer1_tab2_hdnProcedureItems').value = "";
            while (document.getElementById('TabContainer1_tab2_tblProcedureItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblProcedureItems').deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblProcedureItems').rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblProcedureItems').deleteRow(j);
                }
            }
        }
        function LoadAmbulanceItems() {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;

            while (document.getElementById('TabContainer1_tab2_tblAddedAmbulanceItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblAddedAmbulanceItems' + selectPKG).rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblAddedAmbulanceItems' + selectPKG).deleteRow(j);
                }
            }
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).rows.length);
            document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + selectPKG).value = document.getElementById('TabContainer1_tab2_hdnAmbulance').value;
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value);
            if (document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var ProcedureList = list[count].split('~');
                    var row = document.getElementById('TabContainer1_tab2_tblAddedAmbulanceItems' + selectPKG).insertRow(0);
                    row.id = ProcedureList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickAmbulance1(" + parseInt(ProcedureList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (General Items)";
                    cell4.innerHTML = "<b>" + ProcedureList[3] + "</b> (Count)";
                }
                document.getElementById('TabContainer1_tab2_tblAddedAmbulanceItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('TabContainer1_tab2_hdnAmbulance').value = "";
            while (document.getElementById('TabContainer1_tab2_tblAmbulance').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblProcedureItems').deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblAmbulance').rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblAmbulance').deleteRow(j);
                }
            }
        }
        //        function onClickAddHealthCheckup() {
        //            var obj = document.getElementById('TabContainer1_tab2_listHealthCheckup');
        //            var i = obj.getElementsByTagName('OPTION');
        //            var rwNumber = obj.options[obj.selectedIndex].value;
        //            var AddStatus = 0;
        //            var HealthCheckupvalue = obj.options[obj.selectedIndex].value;
        //            var HealthCheckupText = obj.options[obj.selectedIndex].text;
        //            document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').style.display = 'block';
        //            var HidValue = document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value;
        //            var list = HidValue.split('^');
        //            if (document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value != "") {
        //                for (var count = 0; count < list.length; count++) {
        //                    var HealthCheckupList = list[count].split('~');
        //                    if (HealthCheckupList[1] != '') {
        //                        if (HealthCheckupList[0] != '') {
        //                            rwNumber = parseInt(parseInt(HealthCheckupList[0]) + parseInt(1));
        //                        }
        //                        if (HealthCheckupvalue != '') {
        //                            if (HealthCheckupList[1] == HealthCheckupvalue) {
        //                                AddStatus = 1;
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //            else {
        //                if (HealthCheckupvalue != '') {
        //                    var row = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').insertRow(0);
        //                    row.id = parseInt(rwNumber);
        //                    var cell1 = row.insertCell(0);
        //                    var cell2 = row.insertCell(1);
        //                    var cell3 = row.insertCell(2);
        //                    var cell4 = row.insertCell(3);
        //                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
        //                    cell1.width = "6%";
        //                    cell2.innerHTML = HealthCheckupvalue;
        //                    cell2.style.display = "none";
        //                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Medical Indents)";
        //                    cell4.innerHTML = "<input type='text' value='0' id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='GetMICount(" + row.id + ",this.value);'  />";
        //                    document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
        //                    AddStatus = 2;
        //                }
        //            }
        //            if (AddStatus == 0) {
        //                if (HealthCheckupvalue != '') {
        //                    var row = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').insertRow(0);
        //                    row.id = parseInt(rwNumber);
        //                    var cell1 = row.insertCell(0);
        //                    var cell2 = row.insertCell(1);
        //                    var cell3 = row.insertCell(2);
        //                    var cell4 = row.insertCell(3);
        //                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickHealthCheckup(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
        //                    cell1.width = "6%";
        //                    cell2.innerHTML = HealthCheckupvalue;
        //                    cell2.style.display = "none";
        //                    cell3.innerHTML = "<b>" + HealthCheckupText + "</b> (Medical Indents)";
        //                    cell4.innerHTML = "<input type='text' value='0' id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='GetMICount(" + row.id + ",this.value);'  />";
        //                    document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value += parseInt(rwNumber) + "~" + HealthCheckupvalue + "~" + HealthCheckupText + "~" + value + "^";
        //                }
        //            }
        //            else if (AddStatus == 1) {
        //                alert("Medical Indents Already Added!");
        //            }
        //            //        alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnHealthCheckupItems').value);
        //            return false;
        //        }

        function LoadSpecialityItems() {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;

            while (document.getElementById('TabContainer1_tab2_tblAddedConsultationItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedSpecialityItems' + selectPKG).deleteRow();

                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblAddedConsultationItems' + selectPKG).rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblAddedConsultationItems' + selectPKG).deleteRow(j);
                }
            }
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_tblAddedSpecialityItems' + selectPKG).rows.length);
            if (document.getElementById('TabContainer1_tab2_ddlSelectType').value == "Lab Investigation") {
                document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = document.getElementById('TabContainer1_tab2_InvestigationControl1_iconHid').value;
                //document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedSpecialityItems' + selectPKG).value = document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnSpecialityItems').value;
            }
            else {

                document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + selectPKG).value = document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value;
            }
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnSpecialityItems').value);
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedSpecialityItems' + selectPKG).value);
            if (document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var SpecialityList = list[count].split('~');
                    var row = document.getElementById('TabContainer1_tab2_tblAddedConsultationItems' + selectPKG).insertRow(0);
                    row.id = SpecialityList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickConsultation1(" + parseInt(SpecialityList[1]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = SpecialityList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + SpecialityList[2] + "</b> (Consultation)";
                    cell4.innerHTML = "<b>" + SpecialityList[3] + "</b> (Count)";
                    //cell5.innerHTML = "<b>" + SpecialityList[4] + "</b> (specialityID)";
                }
                document.getElementById('TabContainer1_tab2_tblAddedConsultationItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = "";
            while (document.getElementById('TabContainer1_tab2_tblSpecialityItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblSpecialityItems').deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblSpecialityItems').rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblSpecialityItems').deleteRow(j);
                }
            }
        }

        function LoadRoomTypeItems() {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;

            while (document.getElementById('TabContainer1_tab2_tblAddedRoomTypeItems' + selectPKG).rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblAddedProcedureItems' + selectPKG).deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblAddedRoomTypeItems' + selectPKG).rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblAddedRoomTypeItems' + selectPKG).deleteRow(j);
                }
            }
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).rows.length);
            document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + selectPKG).value = document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value;
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + selectPKG).value;
            var list = HidValue.split('^');
            //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value);
            if (document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + selectPKG).value != "") {
                //alert(list.length);
                for (var count = 0; count < list.length - 1; count++) {
                    var ProcedureList = list[count].split('~');
                    var row = document.getElementById('TabContainer1_tab2_tblAddedRoomTypeItems' + selectPKG).insertRow(0);
                    row.id = ProcedureList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickRoomType1(" + parseInt(ProcedureList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Room Type)";
                    cell4.innerHTML = "<b>" + ProcedureList[3] + "</b> (Day(s))";
                }
                document.getElementById('TabContainer1_tab2_tblAddedRoomTypeItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value = "";
            while (document.getElementById('TabContainer1_tab2_tblRoomTypeItems').rows.length > 0) {
                //            document.getElementById('PackageProfileControl_tblProcedureItems').deleteRow();
                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblRoomTypeItems').rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblRoomTypeItems').deleteRow(j);
                }
            }
        }
        function LoadSurgeryTypeItems() {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;

            while (document.getElementById('TabContainer1_tab2_tblAddedSurgeryTypeItems' + selectPKG).rows.length > 0) {

                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblAddedSurgeryTypeItems' + selectPKG).rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblAddedSurgeryTypeItems' + selectPKG).deleteRow(j);
                }
            }

            document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + selectPKG).value = document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value;
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + selectPKG).value;
            var list = HidValue.split('^');

            if (document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + selectPKG).value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var ProcedureList = list[count].split('~');
                    var row = document.getElementById('TabContainer1_tab2_tblAddedSurgeryTypeItems' + selectPKG).insertRow(0);
                    row.id = ProcedureList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='img2' style='cursor:pointer;' OnClick='ImgOnclickSurgeryType1(" + parseInt(ProcedureList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProcedureList[1];
                    cell2.style.display = "none";
                    cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Surgery Type)";
                    cell4.innerHTML = "<b>" + ProcedureList[3] + "</b> (Count)";
                }
                document.getElementById('TabContainer1_tab2_tblAddedSurgeryTypeItems' + selectPKG).style.display = 'block';
            }
            document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value = "";
            while (document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').rows.length > 0) {

                for (var j = 0; j < document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').rows.length; j++) {
                    document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').deleteRow(j);
                }
            }
        }

        function ImgOnclickInvestigation1(ImgID) {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + selectPKG).value = newProcedureList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + selectPKG).value == '') {
                document.getElementById('TabContainer1_tab2_tblOrderedInvesAddedTemp' + selectPKG).style.display = 'none';
            }
        }
        function ImgOnclickAmbulance1(ImgID) {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + selectPKG).value = newProcedureList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + selectPKG).value == '') {
                document.getElementById('TabContainer1_tab2_tblAddedAmbulanceItems' + selectPKG).style.display = 'none';
            }
        }
        function ImgOnclickRoomType1(ImgID) {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + selectPKG).value = newProcedureList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + selectPKG).value == '') {
                document.getElementById('TabContainer1_tab2_tblAddedRoomTypeItems' + selectPKG).style.display = 'none';
            }
        }
        function ImgOnclickSurgeryType1(ImgID) {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + selectPKG).value = newProcedureList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + selectPKG).value == '') {
                document.getElementById('TabContainer1_tab2_tblAddedSurgeryTypeItems' + selectPKG).style.display = 'none';
            }
        }
        function ImgOnclickHealthPackage1(ImgID) {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + selectPKG).value = newProcedureList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + selectPKG).value == '') {
                document.getElementById('TabContainer1_tab2_tblAddedHealthCheckupItems' + selectPKG).style.display = 'none';
            }
        }

        function ImgOnclickConsultation1(ImgID) {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + selectPKG).value = newProcedureList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + selectPKG).value == '') {
                document.getElementById('TabContainer1_tab2_tblAddedConsultationItems' + selectPKG).style.display = 'none';
            }
        }
        function ImgOnclickProcedure1(ImgID) {
            selectPKG = document.getElementById('TabContainer1_tab2_selectedPackage').value;
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value;
            var list = HidValue.split('^');
            var newProcedureList = '';
            if (document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList[0] != '') {
                        if (ProcedureList[0] != ImgID) {
                            newProcedureList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value = newProcedureList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + selectPKG).value == '') {
                document.getElementById('TabContainer1_tab2_tblAddedProcedureItems' + selectPKG).style.display = 'none';


            }
        }
        function ImgOnclickProcedure(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('TabContainer1_tab2_hdnProcedureItems').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('TabContainer1_tab2_hdnProcedureItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('TabContainer1_tab2_hdnProcedureItems').value = NewHealthCheckupList;
            }
            if (document.getElementById('TabContainer1_tab2_hdnProcedureItems').value == '') {
                document.getElementById('TabContainer1_tab2_tblProcedureItems').style.display = 'none';
                var table = document.getElementById('TabContainer1_tab2_tblProcedureItems')
                var len = document.getElementById('TabContainer1_tab2_tblProcedureItems').rows.length;
                var lenth = len - 1;
                for (var i = 0; i < lenth; i++) {
                    document.getElementById('TabContainer1_tab2_tblProcedureItems').deleteRow(i);
                }
            }
        }
        function editmedicalIndent() {
            var HidValue = document.getElementById('TabContainer1_tab2_hdneditHealthCheckupItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdneditHealthCheckupItems').value != "") {
                var Header = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').insertRow(0);
                var Headercell1 = Header.insertCell(0);
                var Headercell2 = Header.insertCell(1);
                var Headercell3 = Header.insertCell(2);
                var Headercell4 = Header.insertCell(3);
                Header.className = "evenforsurg";
                Headercell1.width = "6%";
                Headercell2.style.display = "none";
                Headercell3.innerHTML = "<b> Values </b> ";
                Headercell4.innerHTML = "<b> Quantity </b>";
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList != "") {
                        rwNumber = parseInt(parseInt(ProcedureList[0]))
                        var row = document.getElementById('TabContainer1_tab2_tblHealthCheckupItems').insertRow(1);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        // cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "6%";
                        cell2.innerHTML = ProcedureList[1];
                        cell2.style.display = "none";
                        cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Medical Indent)";
                        cell4.innerHTML = "<input type='text' value=" + ProcedureList[3] + " id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='editMICount(" + row.id + ",this.value);' />";
                        var value = document.getElementById('txt').value;
                    }
                }
            }
        }

        function editRoomType() {
            var HidValue = document.getElementById('TabContainer1_tab2_hdneditRoomTypeItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdneditRoomTypeItems').value != "") {
                var Header = document.getElementById('TabContainer1_tab2_tblRoomTypeItems').insertRow(0);
                var Headercell1 = Header.insertCell(0);
                var Headercell2 = Header.insertCell(1);
                var Headercell3 = Header.insertCell(2);
                var Headercell4 = Header.insertCell(3);
                Header.className = "evenforsurg";
                Headercell1.width = "6%";
                Headercell2.style.display = "none";
                Headercell3.innerHTML = "<b> Values </b> ";
                Headercell4.innerHTML = "<b> Quantity </b>";
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList != "") {
                        rwNumber = parseInt(parseInt(ProcedureList[0]))
                        var row = document.getElementById('TabContainer1_tab2_tblRoomTypeItems').insertRow(1);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        // cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "6%";
                        cell2.innerHTML = ProcedureList[1];
                        cell2.style.display = "none";
                        cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Room Type)";
                        cell4.innerHTML = "<input type='text' value=" + ProcedureList[3] + " id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='editRTCount(" + row.id + ",this.value);' />";
                        var value = document.getElementById('txt').value;
                    }
                }
            }
        }

        function editSurgeryType() {
            var HidValue = document.getElementById('TabContainer1_tab2_hdneditSurgeryTypeItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdneditSurgeryTypeItems').value != "") {
                var Header = document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').insertRow(0);
                var Headercell1 = Header.insertCell(0);
                var Headercell2 = Header.insertCell(1);
                var Headercell3 = Header.insertCell(2);
                var Headercell4 = Header.insertCell(3);
                Header.className = "evenforsurg";
                Headercell1.width = "6%";
                Headercell2.style.display = "none";
                Headercell3.innerHTML = "<b> Values </b> ";
                Headercell4.innerHTML = "<b> Quantity </b>";
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList != "") {
                        rwNumber = parseInt(parseInt(ProcedureList[0]))
                        var row = document.getElementById('TabContainer1_tab2_tblSurgeryTypeItems').insertRow(1);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        // cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "6%";
                        cell2.innerHTML = ProcedureList[1];
                        cell2.style.display = "none";
                        cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Surgery Type)";
                        cell4.innerHTML = "<input type='text' value=" + ProcedureList[3] + " id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='editSRGCount(" + row.id + ",this.value);' />";
                        var value = document.getElementById('txt').value;
                    }
                }
            }
        }

        function editconsultation() {
            //alert(document.getElementById('TabContainer1_tab2_hdneditSpecialityItems').value);
            var HidValue = document.getElementById('TabContainer1_tab2_hdneditSpecialityItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdneditSpecialityItems').value != "") {
                var Header = document.getElementById('TabContainer1_tab2_tblSpecialityItems').insertRow(0);
                var Headercell1 = Header.insertCell(0);
                var Headercell2 = Header.insertCell(1);
                var Headercell3 = Header.insertCell(2);
                var Headercell4 = Header.insertCell(3);
                //                var Headercell5 = Header.insertCell(4);
                Header.className = "evenforsurg";
                Headercell1.width = "6%";
                Headercell2.style.display = "none";
                Headercell3.innerHTML = "<b> Values </b> ";
                Headercell4.innerHTML = "<b> Quantity </b>";
                //                Headercell5.innerHTML = "<b> Physician Name </b>";
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList != "") {
                        rwNumber = parseInt(parseInt(ProcedureList[0]))
                        var row = document.getElementById('TabContainer1_tab2_tblSpecialityItems').insertRow(1);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        //                        var cell5 = row.insertCell(4);
                        // cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "6%";
                        cell2.innerHTML = ProcedureList[1];
                        cell2.style.display = "none";
                        cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Consultation)";
                        cell4.innerHTML = "<input type='text' value=" + ProcedureList[3] + " id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='editCONCount(" + row.id + ",this.value);' />";
                        //                        cell5.innerHTML = "<select id='ddl" + rwNumber + "' onclick='editbindlist(this.id," + ProcedureList[1] + "," + ProcedureList[4] + ");' onchange='editPhy(" + row.id + ",this.id)'/>"
                        var value = document.getElementById('txt').value;
                    }
                }
            }
        }

        function editambulance() {
            var HidValue = document.getElementById('TabContainer1_tab2_hdneditAmbulance').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdneditAmbulance').value != "") {
                var Header = document.getElementById('TabContainer1_tab2_tblAmbulance').insertRow(0);
                var Headercell1 = Header.insertCell(0);
                var Headercell2 = Header.insertCell(1);
                var Headercell3 = Header.insertCell(2);
                var Headercell4 = Header.insertCell(3);
                Header.className = "evenforsurg";
                Headercell1.width = "6%";
                Headercell2.style.display = "none";
                Headercell3.innerHTML = "<b> Values </b> ";
                Headercell4.innerHTML = "<b> Quantity </b>";
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList != "") {
                        rwNumber = parseInt(parseInt(ProcedureList[0]))
                        var row = document.getElementById('TabContainer1_tab2_tblAmbulance').insertRow(1);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        // cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "6%";
                        cell2.innerHTML = ProcedureList[1];
                        cell2.style.display = "none";
                        cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (General Items)";
                        cell4.innerHTML = "<input type='text' value=" + ProcedureList[3] + " id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='editAMCount(" + row.id + ",this.value);' />";
                        var value = document.getElementById('txt').value;
                    }
                }
            }
        }

        function editprocedure() {
            var HidValue = document.getElementById('TabContainer1_tab2_hdneditProcedureItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdneditProcedureItems').value != "") {
                var Header = document.getElementById('TabContainer1_tab2_tblProcedureItems').insertRow(0);
                var Headercell1 = Header.insertCell(0);
                var Headercell2 = Header.insertCell(1);
                var Headercell3 = Header.insertCell(2);
                var Headercell4 = Header.insertCell(3);
                Header.className = "evenforsurg";
                Headercell1.width = "6%";
                Headercell2.style.display = "none";
                Headercell3.innerHTML = "<b> Values </b> ";
                Headercell4.innerHTML = "<b> Quantity </b>";
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList != "") {
                        rwNumber = parseInt(parseInt(ProcedureList[0]))
                        var row = document.getElementById('TabContainer1_tab2_tblProcedureItems').insertRow(1);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        // cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "6%";
                        cell2.innerHTML = ProcedureList[1];
                        cell2.style.display = "none";
                        cell3.innerHTML = "<b>" + ProcedureList[2] + "</b> (Procedure)";
                        cell4.innerHTML = "<input type='text' value=" + ProcedureList[3] + " id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='editProCount(" + row.id + ",this.value);' />";
                        var value = document.getElementById('txt').value;
                    }
                }
            }
        }

        function editinvestigation() {
            var HidValue = document.getElementById('TabContainer1_tab2_hdneditinv').value;
            var list = HidValue.split('^');
            if (document.getElementById('TabContainer1_tab2_hdneditinv').value != "") {
                //alert(document.getElementById('tblOrederedInves'));
                var Header = document.getElementById('tblOrederedInves').insertRow(0);
                var Headercell1 = Header.insertCell(0);
                var Headercell2 = Header.insertCell(1);
                var Headercell3 = Header.insertCell(2);
                var Headercell4 = Header.insertCell(3);
                Header.className = "evenforsurg";
                Headercell1.width = "6%";
                Headercell2.style.display = "none";
                Headercell3.innerHTML = "<b> Values </b> ";
                Headercell4.innerHTML = "<b> Quantity </b>";
                for (var count = 0; count < list.length; count++) {
                    var ProcedureList = list[count].split('~');
                    if (ProcedureList != "") {
                        rwNumber = parseInt(parseInt(ProcedureList[0]))
                        var row = document.getElementById('tblOrederedInves').insertRow(1);
                        row.id = parseInt(rwNumber);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        // cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickProcedure(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "6%";
                        cell2.innerHTML = ProcedureList[0];
                        cell2.style.display = "none";
                        cell3.innerHTML = "<b>" + ProcedureList[1] + "</b> (" + ProcedureList[2] + ")";
                        cell4.innerHTML = "<input type='text' value=" + ProcedureList[4] + " id='txt' onKeyPress= 'return ValidateOnlyNumeric(event);' onblur='editInvCount(" + row.id + ",this.value);' />";
                        var value = document.getElementById('txt').value;
                    }
                }
            }
        }


        function EditBlock(id) {

            if (document.getElementById('TabContainer1_tab2_swapTR2').style.display == "none") {
                //alert(document.getElementById('TabContainer1_tab2_editINVGRP' + id).value);
                document.getElementById('TabContainer1_tab2_hdneditProcedureItems').value = document.getElementById('TabContainer1_tab2_editProcedure' + id).value;
                document.getElementById('TabContainer1_tab2_hdneditinv').value = document.getElementById('TabContainer1_tab2_editINVGRP' + id).value;
                document.getElementById('TabContainer1_tab2_hdneditHealthCheckupItems').value = document.getElementById('TabContainer1_tab2_editHealth' + id).value;
                document.getElementById('TabContainer1_tab2_hdneditRoomTypeItems').value = document.getElementById('TabContainer1_tab2_editRoomtype' + id).value;
                document.getElementById('TabContainer1_tab2_hdneditSurgeryTypeItems').value = document.getElementById('TabContainer1_tab2_editSurgerytype' + id).value;
                document.getElementById('TabContainer1_tab2_hdneditAmbulance').value = document.getElementById('TabContainer1_tab2_editAmbulance' + id).value;
                document.getElementById('TabContainer1_tab2_hdneditSpecialityItems').value = document.getElementById('TabContainer1_tab2_editspeciality' + id).value;
                // alert(document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems').value);          ;

                if (document.getElementById('TabContainer1_tab2_submitTab')) {
                    document.getElementById('TabContainer1_tab2_submitTab').style.display = "none";
                }
                document.getElementById('TabContainer1_tab2_InvestigationControl1_listINV').disabled = true;
                document.getElementById('TabContainer1_tab2_InvestigationControl1_listGRP').disabled = true;
                document.getElementById('TabContainer1_tab2_lstambulance').disabled = true;
                document.getElementById('TabContainer1_tab2_lstRoomType').disabled = true;
                document.getElementById('TabContainer1_tab2_lstSurgeryType').disabled = true;
                document.getElementById('TabContainer1_tab2_listHealthCheckup').disabled = true;
                document.getElementById('TabContainer1_tab2_listSpeciality').disabled = true;
                document.getElementById('TabContainer1_tab2_listProcedure').disabled = true;
                editprocedure();
                editconsultation();
                editRoomType();
                editSurgeryType();
                editmedicalIndent();
                editambulance();
                editinvestigation();
                document.getElementById('TabContainer1_tab2_swapTR2').style.display = "block";
                document.getElementById('TabContainer1_tab2_swapTR1').style.display = "none";
                document.getElementById('TabContainer1_tab2_selectedPackage').value = id;
            }
            return false;

        }

        function showHideSwapBlock(id) {
            if (document.getElementById('TabContainer1_tab2_swapTR1').style.display == "none") {
                document.getElementById('TabContainer1_tab2_swapTR1').style.display = "block";
                document.getElementById('TabContainer1_tab2_swapTR2').style.display = "none";
                LoadSpecialityItems();
                LoadProcedureItems();
                LoadHealthCheckupItems();
                LoadRoomTypeItems();
                LoadSurgeryTypeItems();
                LoadAmbulanceItems();
                if (document.getElementById('TabContainer1_tab2_submitTab')) {
                    document.getElementById('TabContainer1_tab2_submitTab').style.display = "block";
                }
                LoadOrdItems1();
                SetCollectedItems();
            }
            else if (document.getElementById('TabContainer1_tab2_swapTR2').style.display == "none") {
                document.getElementById('TabContainer1_tab2_hdnProcedureItems').value = document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + id).value;
                document.getElementById('TabContainer1_tab2_InvestigationControl1_iconHid').value = document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + id).value;
                document.getElementById('TabContainer1_tab2_hdnHealthCheckupItems').value = document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + id).value;
                document.getElementById('TabContainer1_tab2_hdnRoomTypeItems').value = document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + id).value;
                document.getElementById('TabContainer1_tab2_hdnSurgeryTypeItems').value = document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + id).value;
                document.getElementById('TabContainer1_tab2_hdnAmbulance').value = document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + id).value;
                document.getElementById('TabContainer1_tab2_hdnSpecialityItems').value = document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + id).value;
                // alert(document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems').value);

                document.getElementById('TabContainer1_tab2_lstambulance').disabled = false;
                document.getElementById('TabContainer1_tab2_lstRoomType').disabled = false;
                document.getElementById('TabContainer1_tab2_lstSurgeryType').disabled = false;
                document.getElementById('TabContainer1_tab2_listHealthCheckup').disabled = false;
                document.getElementById('TabContainer1_tab2_listSpeciality').disabled = false;
                document.getElementById('TabContainer1_tab2_listProcedure').disabled = false;
                document.getElementById('TabContainer1_tab2_InvestigationControl1_listINV').disabled = false;
                document.getElementById('TabContainer1_tab2_InvestigationControl1_listGRP').disabled = false;

                if (document.getElementById('TabContainer1_tab2_submitTab')) {
                    document.getElementById('TabContainer1_tab2_submitTab').style.display = "none";
                }
                document.getElementById('TabContainer1_tab2_swapTR2').style.display = "block";
                document.getElementById('TabContainer1_tab2_swapTR1').style.display = "none";
                document.getElementById('TabContainer1_tab2_selectedPackage').value = id;
            }
            return false;
        }
        function SetCollectedItems() {
            document.getElementById('TabContainer1_tab2_collectedFinalINVGRP').value = "";
            document.getElementById('TabContainer1_tab2_collectedFinalProcedure').value = "";
            document.getElementById('TabContainer1_tab2_collectedFinalHealthCheckUp').value = "";
            document.getElementById('TabContainer1_tab2_collectedFinalRoomType').value = "";
            document.getElementById('TabContainer1_tab2_collectedFinalSurgeryType').value = "";
            document.getElementById('TabContainer1_tab2_collectedFinalAmbulance').value = "";
            document.getElementById('TabContainer1_tab2_collectedFinalSpeciality').value = "";

            var pkgID = document.getElementById('TabContainer1_tab2_hdntotalFinalPKG').value.split('~');
            for (var count = 0; count < pkgID.length - 1; count++) {
                if (document.getElementById('TabContainer1_tab2_chk' + pkgID[count]).checked) {
                    //alert(document.getElementById('PackageProfileControl_TabContainer1_tab2_hdnAddedInvGRP').value);
                    if (document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + pkgID[count]).value != "") {
                        document.getElementById('TabContainer1_tab2_collectedFinalINVGRP').value += pkgID[count] + "$" + document.getElementById('TabContainer1_tab2_hdnAddedInvGRP' + pkgID[count]).value + ":";
                    }
                    if (document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + pkgID[count]).value != "") {
                        document.getElementById('TabContainer1_tab2_collectedFinalProcedure').value += pkgID[count] + "-" + document.getElementById('TabContainer1_tab2_hdnAddedProcedureItems' + pkgID[count]).value + ":";
                    }
                    if (document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + pkgID[count]).value != "") {
                        document.getElementById('TabContainer1_tab2_collectedFinalHealthCheckUp').value += pkgID[count] + "-" + document.getElementById('TabContainer1_tab2_hdnAddedHealthCheckupItems' + pkgID[count]).value + ":";
                    }
                    if (document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + pkgID[count]).value != "") {
                        document.getElementById('TabContainer1_tab2_collectedFinalRoomType').value += pkgID[count] + "-" + document.getElementById('TabContainer1_tab2_hdnAddedRoomTypeItems' + pkgID[count]).value + ":";
                    }
                    if (document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + pkgID[count]).value != "") {
                        document.getElementById('TabContainer1_tab2_collectedFinalSurgeryType').value += pkgID[count] + "-" + document.getElementById('TabContainer1_tab2_hdnAddedSurgeryTypeItems' + pkgID[count]).value + ":";
                    }
                    if (document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + pkgID[count]).value != "") {
                        document.getElementById('TabContainer1_tab2_collectedFinalAmbulance').value += pkgID[count] + "-" + document.getElementById('TabContainer1_tab2_hdnAddedAmbulanceItems' + pkgID[count]).value + ":";
                    }
                    if (document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + pkgID[count]).value != "") {
                        //alert(document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + pkgID[count]).value);
                        document.getElementById('TabContainer1_tab2_collectedFinalSpeciality').value += pkgID[count] + "-" + document.getElementById('TabContainer1_tab2_hdnAddedConsultationItems' + pkgID[count]).value + ":";
                        //alert(document.getElementById('TabContainer1_tab2_collectedFinalSpeciality').value);
                    }
                }
            }
            return false;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table class="searchPanel w-100p">
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hdnid" runat="server" />
                                    <ajc:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" 
                                        meta:resourcekey="TabContainer1Resource1">
                                        <ajc:TabPanel ID="tab1" runat="server" HeaderText="Create New Package" 
                                            meta:resourcekey="tab1Resource1">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblCreateNewPackage" runat="server" Text="Create New Package" 
                                                    meta:resourcekey="lblCreateNewPackageResource1"></asp:Label>
                                            </HeaderTemplate>
                                            <ContentTemplate>
                                                <table class="w-80p">
                                                    <tr>
                                                        <td colspan="2" id="us">
                                                            <asp:Label ID="lblSurgeryPackage" runat="server" Text="Surgery Package" 
                                                                meta:resourcekey="lblSurgeryPackageResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w-15p">
                                                            <asp:Label ID="lblpackage" runat="server" Text="Package Name" 
                                                                meta:resourcekey="lblpackageResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtpackage" runat="server" MaxLength="250" CssClass="Txtboxsmall" 
                                                                meta:resourcekey="txtpackageResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none">
                                                        <td>
                                                            <asp:Label ID="lblAmount" runat="server" Text="Package Amount" 
                                                                meta:resourcekey="lblAmountResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAmount" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                               CssClass="Txtboxsmall" MaxLength="10" meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                            <asp:Label ID="Label3" runat="server" Font-Size="XX-Small" Text="Rs." 
                                                                meta:resourcekey="Label3Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblDays" runat="server" Text="Package Days" 
                                                                meta:resourcekey="lblDaysResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtDays" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                 MaxLength="5" CssClass="Txtboxsmall" meta:resourcekey="txtDaysResource1"></asp:TextBox>
                                                            <asp:Label ID="Label2" runat="server" Font-Size="XX-Small" Text="Days" 
                                                                meta:resourcekey="Label2Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none">
                                                        <td>
                                                            <asp:Label ID="lblNoFreeConsultBefore" runat="server" 
                                                                Text="No. Of Free Consultation Before:" 
                                                                meta:resourcekey="lblNoFreeConsultBeforeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtBefore" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                             MaxLength="4" CssClass="Txtboxsmall" meta:resourcekey="txtBeforeResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none">
                                                        <td>
                                                            <asp:Label ID="lblNoFreeConsultAfter" runat="server" 
                                                                Text="No. Of Free Consultation After:" 
                                                                meta:resourcekey="lblNoFreeConsultAfterResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAfter" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                             MaxLength="4" CssClass="Txtboxsmall" meta:resourcekey="txtAfterResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none">
                                                        <td>
                                                            <asp:Label ID="lblValidity" runat="server" Text="Free Consultation Validity" 
                                                                meta:resourcekey="lblValidityResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtValidity" runat="server" MaxLength="5"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                             CssClass="Txtboxsmall" meta:resourcekey="txtValidityResource1"></asp:TextBox>
                                                            <asp:Label ID="Label1" runat="server" Font-Size="XX-Small" Text="Days" 
                                                                meta:resourcekey="Label1Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" OnClientClick="javascript:return surgerycheck();"
                                                                Text="Save" meta:resourcekey="btnSaveResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                                Text="Cancel" meta:resourcekey="btnCancelResource1" />
                                                            <asp:Button ID="btn" runat="server" Text="Clear" class="btn" OnClientClick="return surgeryclear()" style="display: none"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:Panel ID="grid" runat="server" meta:resourcekey="gridResource1">
                                                    <table>
                                                        <tr>
                                                            <td class="colorforcontent" height="23" align="left">
                                                                <div id="ACX2OPPmt" style="display: block;">
                                                                    <img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                                        onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                                        <asp:Label ID="lblExistingSurgeryPack" runat="server" 
                                                                        Text="Existing Surgery Package" 
                                                                        meta:resourcekey="lblExistingSurgeryPackResource1"></asp:Label></span>
                                                                </div>
                                                                <div id="ACX2minusOPPmt" style="display: none;">
                                                                    <img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                                        <asp:Label ID="lblExistSurgeryPack" runat="server" 
                                                                        Text="Existing Surgery Package" meta:resourcekey="lblExistSurgeryPackResource1"></asp:Label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responsesOPPmt" style="display: table-row;">
                                                            <td>
                                                                <asp:GridView ID="gvSurgery" runat="server" AutoGenerateColumns="False" CssClass="w-100p gridView"
                                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Bold="False" Font-Names="Verdana" Font-Overline="False"
                                                                    Font-Size="8pt" Font-Strikeout="False" Font-Underline="False" DataKeyNames="PackageID"
                                                                    OnRowDeleting="gvSurgery_RowDeleting" 
                                                                    meta:resourcekey="gvSurgeryResource1">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Package Name" 
                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblId" runat="server" Visible="False" 
                                                                                    Text='<%# bind("PackageID") %>' meta:resourcekey="lblIdResource1"></asp:Label>
                                                                                <asp:Label ID="lblpackage" runat="server" Text='<%# bind("PackageName") %>' 
                                                                                    meta:resourcekey="lblpackageResource2"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Amount" 
                                                                            meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblAmount" runat="server" Text='<%# bind("Amount") %>' 
                                                                                    meta:resourcekey="lblAmountResource2"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Package Days" 
                                                                            meta:resourcekey="TemplateFieldResource3">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblPackageDays" runat="server" Text='<%# bind("PackageDays") %>' 
                                                                                    meta:resourcekey="lblPackageDaysResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Consultation Before Package" 
                                                                            meta:resourcekey="TemplateFieldResource4">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblBefore" runat="server" Text='<%# bind("NoFreeConsBefore") %>' 
                                                                                    meta:resourcekey="lblBeforeResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Consultation After Package" 
                                                                            meta:resourcekey="TemplateFieldResource5">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblAfter" runat="server" Text='<%# bind("NoFreeConsAfter") %>' 
                                                                                    meta:resourcekey="lblAfterResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Consultation Validity Period" 
                                                                            meta:resourcekey="TemplateFieldResource6">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblValidity" runat="server" 
                                                                                    Text='<%# bind("FreeConsValidity") %>' meta:resourcekey="lblValidityResource2"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Action" 
                                                                            meta:resourcekey="TemplateFieldResource7">
                                                                            <ItemTemplate>
                                                                                <input id="btnEdit" value="Edit" type="button" cname='<%# Eval("PackageName") %>'
                                                                                    cid='<%# Eval("PackageID") %>' camount='<%# Eval("Amount") %>' cdays='<%# Eval("PackageDays") %>'
                                                                                    cbefore='<%# Eval("NoFreeConsBefore") %>' cafter='<%# Eval("NoFreeConsAfter") %>'
                                                                                    cvalidity='<%# Eval("FreeConsValidity") %>' style='background-color: Transparent;
                                                                                    color: Red; border-style: none; cursor: pointer' size="3" 
                                                                                    onclick="loadsurgerydata(this)" />
                                                                                &#160;
                                                                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return pChekUserName(); "
                                                                                    ForeColor="Red" Font-Size="Small" meta:resourcekey="lnkDeleteResource1"> 
                                                                             Delete</asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <HeaderStyle Font-Size="X-Small" CssClass="grdcolor" Font-Bold="True" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                        <ajc:TabPanel ID="tab2" runat="server" HeaderText="Add content to Package" 
                                            meta:resourcekey="tab2Resource1">
                                            <ContentTemplate>
                                                <table class="w-100p"
                                                    <tr id="swapTR1" runat="server">
                                                        <td class="v-top w-50p" runat="server">
                                                            <asp:Table ID="healthPackagesTab" CssClass="dataheaderInvCtrl w-100p" runat="server">
                                                            </asp:Table>
                                                        </td>
                                                        <td class="v-top w-50p" runat="server">
                                                            <asp:Table ID="healthPackagesContentTab" CssClass="w-100p" runat="server">
                                                            </asp:Table>
                                                            <input type="hidden" id="selectedPackage" runat="server" >
                                                                <input id="tempProHid" runat="server" type="hidden"></input>
                                                                <input id="tempMIHid" runat="server" type="hidden"></input>
                                                                <input id="tempRTHid" runat="server" type="hidden"></input>
                                                                <input id="tempSRGHid" runat="server" type="hidden"></input>
                                                                <input id="tempAMHid" runat="server" type="hidden"></input>
                                                                <input id="tempphy" runat="server" type="hidden"></input>
                                                                <input id="hdntotalFinalPKG" runat="server" type="hidden"></input>
                                                                <input id="collectedFinalINVGRP" runat="server" type="hidden"></input>
                                                                <input id="collectedFinalSpeciality" runat="server" type="hidden"></input>
                                                                <input id="collectedFinalProcedure" runat="server" type="hidden"></input>
                                                                <input id="collectedFinalHealthCheckUp" runat="server" type="hidden"></input>
                                                                <input id="collectedFinalRoomType" runat="server" type="hidden"></input>
                                                                <input id="collectedFinalAmbulance" runat="server" type="hidden"></input>
                                                                <input id="collectedFinalSurgeryType" runat="server" type="hidden"></input>
                                                                <input id="tempCONHid" runat="server" type="hidden"></input>
                                                                <input id="setDefaultPKG" runat="server" type="hidden"></input>
                                                                <input id="setOrderedPKG" runat="server" type="hidden"></input>
                                                                <input id="setOrderedPKGTemp" runat="server" type="hidden"></input>
                                                                <input id="hdnphysician" runat="server" type="hidden"></input>
                                                                </input></input></input></input></input></input></input></input></input></input></input></input></input></input></input></input></input></input></input>
                                                            </input>
                                                        </td></tr><tr id="swapTR2" runat="server" style="display: none;">
                                                        <td colspan="2" runat="server">
                                                             <table id="typeTab" class="dataheaderInvCtrl w-40p" runat="server">
                                                                <tr id="Tr1" runat="server">
                                                                    <td id="Td1" class="a-center w-30p" runat="server">
                                                                        <b>
                                                                            <asp:Label ID="lblSelectType" runat="server" Text="Select Type"  meta:resourcekey="lblSelectTypeResource1"></asp:Label></b></td>
                                                                            <td id="Td2" runat="server">
                                                                        <asp:DropDownList ID="ddlSelectType" onchange="javascript:setSelectedType();" runat="server">
                                                                            <asp:ListItem Selected="True" Text="Lab Investigation" Value="Lab Investigation"></asp:ListItem>
                                                                            <asp:ListItem Text="Consultation" Value="Consultation"></asp:ListItem>
                                                                            <asp:ListItem Text="Treatment Procedure" Value="Treatment Procedure"></asp:ListItem>
                                                                            <asp:ListItem Text="Medical Indents" Value="Medical Indents"></asp:ListItem>
                                                                            <asp:ListItem Text="Room Type" Value="Room Type"></asp:ListItem>
                                                                            <asp:ListItem Text="General Items" Value="Ambulance"></asp:ListItem>
                                                                            <asp:ListItem Text="Surgery intervention" Value="Surgery"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            </td>
                                                                            </tr>
                                                                            </table>
                                                                            <table id="invCtrlTab" runat="server" class="w-100p">
                                                                <tr id="Tr2" runat="server">
                                                                    <td id="Td3" runat="server">
                                                                        <uc1:InvestigationControl ID="InvestigationControl1" runat="server" />
                                                                        <input type="hidden" id="hdneditinv" runat="server" ></input>
                                                                     </td>
                                                                </tr>
                                                            </table>
                                                            <table id="procedureTab" style="display: none;" runat="server" cellpadding="5" cellspacing="0"
                                                                border="0" width="100%">
                                                                <tr id="Tr3" runat="server">
                                                                    <td id="Td4" runat="server">
                                                                        <asp:Label ID="lblProcedure" runat="server" Text="Procedure"></asp:Label></td></tr><tr id="Tr4" runat="server">
                                                                    <td id="Td5" runat="server">
                                                                        <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td style="width: 50%;" valign="top">
                                                                                    <asp:ListBox ID="listProcedure" runat="server" onkeypress="javascript:setItemP(event,this);"
                                                                                        ondblClick="javascript:onClickAddProcedure();" Width="350px" Height="100px">
                                                                                    </asp:ListBox>
                                                                                </td>
                                                                                <td style="width: 50%;" valign="top">
                                                                                    <input type="hidden" id="hdnProcedureItems" runat="server" >
<input id="hdneditProcedureItems" runat="server" type="hidden"/>
<table id="tblProcedureItems" runat="server" border="0" cellpadding="4" 
                                                                                            cellspacing="0" class="dataheaderInvCtrl" width="100%">
</table>
                                                                        
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:HiddenField ID="Hdn" runat="server" />
                                                            <asp:HiddenField ID="Hdnfld" runat="server" />
                                                            <table id="specialityTab" style="display: none;" runat="server" class="w-100p">
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:Label ID="lblSpeciality" runat="server" Text="Speciality"></asp:Label></td></tr><tr runat="server">
                                                                    <td runat="server">
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td class="w-50p v-top">
                                                                                    <asp:ListBox ID="listSpeciality" runat="server" onkeypress="javascript:setItemConsultation(event,this);"
                                                                                        ondblClick="javascript:onClickAddConsultation();" Width="350px" Height="150px">
                                                                                    </asp:ListBox>
                                                                                </td>
                                                                                <td class="w-50p v-top">
                                                                                    <input type="hidden" id="hdnSpecialityItems" runat="server" />
                                                                                        <input id="hdneditSpecialityItems" runat="server" type="hidden"/>
                                                                                        <table id="tblSpecialityItems" runat="server" border="0" cellpadding="4" 
                                                                                            cellspacing="0" class="dataheaderInvCtrl" width="100%">
                                                                                        </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="HealthCheckupTab" style="display: none;" runat="server" class="w-100p">
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:Label ID="lblSpecialiType" runat="server" Text="Medical Indents"></asp:Label></td></tr><tr runat="server">
                                                                    <td runat="server">
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td class="w-50p v-top">
                                                                                    <asp:ListBox ID="listHealthCheckup" runat="server" onkeypress="javascript:setItemHealthCheckup(event,this);"
                                                                                        ondblClick="javascript:onClickAddHealthCheckup();" Width="350px" Height="150px">
                                                                                    </asp:ListBox>
                                                                                </td>
                                                                                <td class="w-50p v-top">
                                                                                    <input type="hidden" id="hdnHealthCheckupItems" runat="server" />
                                                                                        <input id="hdneditHealthCheckupItems" runat="server" type="hidden"/>
                                                                                        <table id="tblHealthCheckupItems" runat="server" border="0" cellpadding="4" 
                                                                                            cellspacing="0" class="dataheaderInvCtrl" width="100%">
                                                                                        </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="RoomTypeTab" style="display: none;" runat="server" class="w-100p">
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:Label ID="lbl_RoomType" runat="server" Text="Room Type"></asp:Label></td></tr><tr runat="server">
                                                                    <td runat="server">
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td class="w-50p v-top">
                                                                                    <asp:ListBox ID="lstRoomType" runat="server" onkeypress="javascript:setItemRoomType(event,this);"
                                                                                        ondblClick="javascript:onClickAddRoomType();" Width="350px" Height="150px"></asp:ListBox>
                                                                                </td>
                                                                                <td class="w-50p v-top">
                                                                                    <input type="Hidden" id="hdnRoomTypeItems" runat="server"/>
                                                                                        <input id="hdneditRoomTypeItems" runat="server" type="Hidden"/>
                                                                                        <table id="tblRoomTypeItems" runat="server" border="0" cellpadding="4" 
                                                                                            cellspacing="0" class="dataheaderInvCtrl" width="100%">
                                                                                        </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="SurgeryTab" style="display: none;" runat="server" class="w-100p">
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:Label ID="lbl_SurgeryType" runat="server" Text="Surgery Type"></asp:Label></td></tr><tr runat="server">
                                                                    <td runat="server">
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td class="w-50p v-top">
                                                                                    <asp:ListBox ID="lstSurgeryType" runat="server" onkeypress="javascript:setItemSurgeryType(event,this);"
                                                                                        ondblClick="javascript:onClickAddSurgeryType();" Width="350px" Height="150px">
                                                                                    </asp:ListBox>
                                                                                </td>
                                                                                <td class="w-50p v-top">
                                                                                    <input type="Hidden" id="hdnSurgeryTypeItems" runat="server" />
                                                                                        <input id="hdneditSurgeryTypeItems" runat="server" type="Hidden"/>
                                                                                        <table id="tblSurgeryTypeItems" runat="server" border="0" cellpadding="4" 
                                                                                            cellspacing="0" class="dataheaderInvCtrl" width="100%">
                                                                                        </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="AmbulanceTab" style="display: none;" runat="server" class="w-100p">
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:Label ID="lbl_Ambulance" runat="server" Text="Ambulance"></asp:Label></td></tr><tr runat="server">
                                                                    <td runat="server">
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td class="w-50p v-top">
                                                                                    <asp:ListBox ID="lstambulance" runat="server" onkeypress="javascript:setItemAmbulance(event,this);"
                                                                                        ondblClick="javascript:onClickAddAmbulance();" Width="350px" Height="150px">
                                                                                    </asp:ListBox>
                                                                                </td>
                                                                                <td class="w-50p v-top">
                                                                                    <input type="Hidden" id="hdnAmbulance" runat="server" />
                                                                                        <input id="hdneditAmbulance" runat="server" type="Hidden"/>
                                                                                        <table id="tblAmbulance" runat="server" border="0" cellpadding="4" 
                                                                                            cellspacing="0" class="dataheaderInvCtrl" width="100%">
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
                                                                            Font-Bold="True" Font-Underline="True" onclick="javascript:return showHideSwapBlock();"
                                                                            Font-Size="14px"></asp:HyperLink></td></tr></table></td></tr><tr style="display: none" runat="server" id="submitTab">
                                                        <td runat="server">
                                                            <asp:Button ID="btnFinish" runat="server" Text="Save" OnClick="btnFinish_Click" CssClass="btn"
                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                            <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                OnClick="Cancel_Click" onmouseout="this.className='btn'" CommandName="Clear" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                    </ajc:TabContainer>
                                </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
