<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpecialRateCard.aspx.cs"
    Inherits="Admin_SpecialRateCard" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
      <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#lblLnk").click(function() {
                $(location).attr('href', '../Invoice/ClientMaster.aspx?IsPopup=Y');
            });
        });
    </script>
    <script type="text/javascript">
        function DisplayTab(tabName) {
            $('#TabsMenu li').removeClass('active');
            if (tabName == 'SPL') {
                document.getElementById('tdSpecial').style.display = 'block';
                $('#li1').addClass('active');
                document.getElementById('tdClient').style.display = 'none';
            }
            if (tabName == 'CLI') {
                document.getElementById('tdSpecial').style.display = 'none';
                $('#li2').addClass('active');
                document.getElementById('tdClient').style.display = 'block';
            }
        }
        var edit = 'N';
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

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 46)) {
                isCtrl = true;
            }

            return isCtrl;
        }
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
        function SelectedInv(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;
            var name;
            var InvType;
            var TestCode;

            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];
                        name = list[1];
                        InvType = list[2];
                        TestCode = list[3];
                        document.getElementById('hdnInvID').value = ID;
                        document.getElementById('hdnInvName').value = name;
                        document.getElementById('hdnInvType').value = InvType;
                        document.getElementById('hdnTestCode').value = TestCode;
                    }
                }
            }
        }

        function Validate() {
            var objVar01 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_01") == null ? "Please enter Special Rate Name" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Alert");
            var objVar02 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_02") == null ? "Please Enter Investigation or Group" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_02");
            var objVar03 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_03") == null ? "Please Enter the Amount" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_03");

            if (document.getElementById('txtRateName').value == '') {
                // alert('Please enter Special Rate Name');
                ValidationWindow(objVar01, objAlert);

                document.getElementById('txtRateName').focus();
                return false;
            }
            if (document.getElementById('txtInvName').value == '') {
                //  alert('Please Enter Investigation or Group');
                ValidationWindow(objVar02, objAlert);
                document.getElementById('txtInvName').focus();
                return false;
            }
            else if (document.getElementById('txtAmount').value == '') {
            //  alert('Please Enter the Amount');
            ValidationWindow(objVar03, objAlert);
                document.getElementById('txtAmount').focus();
                return false;
            }
            else {
                var chk = CreateTable();
                if (chk == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        function CreateTable() {
            var objVar04 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_04") == null ? "Already Added" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_04");
            var objAlert = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Alert");

            var newrateData = document.getElementById('hdnInvID').value + '~' + document.getElementById('hdnInvName').value + '~' + document.getElementById('hdnInvType').value + '~' + document.getElementById('txtAmount').value;
            var existingdata = document.getElementById('hdnAdditems').value.split('^');
            if (newrateData != '') {
                for (var i = 0; i < existingdata.length; i++) {
                    if (existingdata[i].split('~')[0] == newrateData.split('~')[0]) {
                        // alert('Already Added');
                        ValidationWindow(objVar04, objAlert);
                        document.getElementById('txtInvName').value = '';
                        document.getElementById('txtAmount').value = '';
                        document.getElementById('txtInvName').focus();
                        return false;
                    }
                }
            }
            document.getElementById('hdnAdditems').value += newrateData + '^';
            CreateInvTable();
        }
        function EditInvRate(editItems) {
            var objVar08 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06") == null ? "Save Changes" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06");

            edit = 'Y';
            DeleteInv(editItems);
            if (editItems != '') {
                //                document.getElementById('btnAdd').value = 'Save Changes';
                document.getElementById('btnAdd').value = objVar08;
                document.getElementById('txtInvName').value = editItems.split('~')[1];
                document.getElementById('lblI').innerHTML = editItems.split('~')[2];
                document.getElementById('txtAmount').value = editItems.split('~')[3];
                document.getElementById('hdnInvID').value = editItems.split('~')[0];
                document.getElementById('hdnInvName').value = editItems.split('~')[1];
                document.getElementById('hdnInvType').value = editItems.split('~')[2];
            }
        }
        function DeleteInv(deletItem) {
            if (document.getElementById('btnAdd').value == 'Save Changes') {
                CreateTable();
            }
            var existItem = document.getElementById('hdnAdditems').value.split('^');
            document.getElementById('hdnAdditems').value = '';
            var additems = '';
            if (existItem != '') {
                for (var i = 0; i < existItem.length; i++) {
                    if (existItem[i] != "") {
                        if (deletItem != existItem[i]) {
                            additems += existItem[i] + "^";
                        }
                    }
                }
            }
            document.getElementById('hdnAdditems').value = additems;
            if (document.getElementById('hdnAdditems').value == '') {
                if (document.getElementById('btnSave').value == 'Update') {
                    if (edit != 'Y') {
                        var objVar05 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_05") == null ? "Do you want to delete this Special Rate" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_05");

                        //                        var cnfrm = confirm('Do you want to delete this Special Rate');
                        var cnfrm = confirm(objVar05);
                        if (cnfrm == false) {
                            document.getElementById('hdnAdditems').value = existItem[0] + '^';
                        }
                        else {
                            document.getElementById('hdnUpdate').value = '2';
                            javascript: __doPostBack('btnSave', '');
                            ClearInvTable();
                        }
                    }
                    else {
                        if (document.getElementById('hdnAdditems').value == '') {
                            document.getElementById('tdActions').style.display = 'none';
                        }
                    }
                }
            }

            CreateInvTable();
        }

        function CreateInvTable() {
            var objVar05 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_05") == null ? "Add" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_05");

            var items = document.getElementById('hdnAdditems').value.split('^');
            document.getElementById('<%= divCreateInvTable.ClientID %>').innerHTML = '';
            var startTag, bodytag, endtag;
            startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='center' > Investigation Name </th> <th scope='col' align='center'> Type </th><th scope='col' align='center'> Amount </th><th scope='col' align='center' width='10%'>Action</th>";
            endtag = "</TBODY></TABLE>";
            if (items != '') {
                
                bodytag = startTag;
                for (var i = 0; i < items.length; i++) {
                    if (items[i] != '') {
                        bodytag += "<TR><TD STYLE='display:none'>" + items[i].split('~')[0] + "</TD>";
                        bodytag += "<TD align='left'>" + items[i].split('~')[1] + "</TD>";
                        bodytag += "<TD>" + items[i].split('~')[2] + "</TD>";
                        bodytag += "<TD>" + items[i].split('~')[3] + "</TD>";
                        bodytag += "<TD><input name='" + items[i].split('~')[0] + '~' + items[i].split('~')[1] + '~' + items[i].split('~')[2] + '~' + items[i].split('~')[3] + "' onclick='return EditInvRate(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        bodytag += "<input name='" + items[i].split('~')[0] + '~' + items[i].split('~')[1] + '~' + items[i].split('~')[2] + '~' + items[i].split('~')[3] + "' onclick='return DeleteInv(name);' value = 'Delete' class='deleteIcons' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD></TR>";
                    }
                }
                bodytag += endtag;
                document.getElementById('tdInveTable').style.display = 'block';
                document.getElementById('<%= divCreateInvTable.ClientID %>').innerHTML = bodytag;
                document.getElementById('txtInvName').value = '';
                document.getElementById('txtAmount').value = '';
                document.getElementById('txtInvName').focus();
                document.getElementById('hdnInvID').value = '';
                document.getElementById('hdnInvName').value = '';
                document.getElementById('hdnInvType').value = '';
                document.getElementById('hdnTestCode').value = '';
                document.getElementById('lblI').innerHTML = '';
                document.getElementById('tdActions').style.display = 'block';
                //                document.getElementById('btnAdd').value = 'Add';
                document.getElementById('btnAdd').value = objVar05;
                document.getElementById('btnSave').style.display = 'block';
                edit = 'N';
            }
        }
        function clearfn() {

            if (document.getElementById('txtInvName').value.length <= 0) {
                document.getElementById('lblI').innerHTML = '';
            }
            else {
                document.getElementById('lblI').innerHTML = document.getElementById('hdnInvType').value;
            }
        }
        function SelectedTest(source, eventArgs) {
            document.getElementById('hdnSelectedTest').value = eventArgs.get_value();
            var x = document.getElementById('hdnSelectedTest').value.split("~");
            var Type = x[0].split("^");
            var InvType = Type[2];
            document.getElementById('lblI').innerHTML = InvType;
            if (document.getElementById('tdClient').style.display == 'block') {
                document.getElementById('lblT').innerHTML = InvType;
            }
        }

        function GetSpecialRated(id) {
            var objVar07 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_07") == null ? "Update" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_07");

            if (id != '') {
                document.getElementById('hdnRateID').value = id;
                document.getElementById('txtRateName').disabled = true;
                //                document.getElementById('btnSave').value = 'Update';
                document.getElementById('btnSave').value = objVar07;
                document.getElementById('hdnUpdate').value = 1;
                var mappedlist = document.getElementById('hdnSpecialRate').value.split('#');
                for (var i = 0; i < mappedlist.length; i++) {
                    if (mappedlist[i] != '') {
                        if (id == mappedlist[i].split('~')[0]) {
                            document.getElementById('hdnAdditems').value += mappedlist[i].split('~')[1] + '~' + mappedlist[i].split('~')[2] + '~' + mappedlist[i].split('~')[3] + '~' + mappedlist[i].split('~')[4].split('.')[0] + '^';
                        }
                    }
                }
                CreateInvTable();
            }
        }
        function ClearInvTable() {
            var objVar05 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_05") == null ? "Add" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_05");
            var objVar06 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06") == null ? "Save" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06");

//            document.getElementById('btnAdd').value = 'Add';
            //            document.getElementById('btnSave').value = 'Save';
            document.getElementById('btnAdd').value = objVar05;
            document.getElementById('btnSave').value = objVar06;
            document.getElementById('hdnUpdate').value = '0';
            document.getElementById('hdnAdditems').value = '';
            document.getElementById('tdActions').style.display = 'none';
            document.getElementById('tdInveTable').style.display = 'none';
            document.getElementById('txtRateName').value = '';
            document.getElementById('txtRateName').disabled = false;
            document.getElementById('txtInvName').value = '';
            document.getElementById('txtAmount').value = '';
            document.getElementById('<%= divCreateInvTable.ClientID %>').innerHTML = '';
            document.getElementById('txtRateName').focus();
            document.getElementById('hdnRateID').value = '';
            document.getElementById('lblI').innerHTML = '';
            edit = 'N';
            return false;
        }      
    </script>
    <script type="text/javascript" language="javascript">
        function SetClientTypeID() {
            ClearFields1();
            ClearFields2();
            document.getElementById('txtClientName').disabled = false;
            var ClientType = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].value;
            if (ClientType == '0') {
                DisableFunc('F');
            }
            var OrgID = '<%=OrgID %>';
            $find('AutoCompleteExtender1').set_contextKey(ClientType + '^' + OrgID);
        }
        function DisableFunc(obj) {
            var bol = '';
            if (obj == 'T')
                bol = false;
            else
                bol = true;
            document.getElementById('txtClientName').disabled = bol;
            document.getElementById('txtTestName').disabled = bol;
            document.getElementById('drpRefType').disabled = bol;
        }
        function ClearFields1() {
            document.getElementById('txtClientName').value = '';
            document.getElementById('hdnClientID').value = '';
            document.getElementById('<%= divClient.ClientID %>').innerHTML = '';
            document.getElementById('hdnAddClient').value = '';
            document.getElementById('trClient').style.display = 'none';
            document.getElementById('tdDivClient').style.display = 'none';
        }
        function ClearFields2() {
            var objVar05 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_05") == null ? "Add" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_05");

            document.getElementById('txtTestName').value = '';
            document.getElementById('hdnInvID').value = '';
            document.getElementById('hdnInvName').value = '';
            document.getElementById('hdnInvType').value = '';
            document.getElementById('hdnTestCode').value = '';
//            document.getElementById('txtSCode').value = '';
            //            document.getElementById('btnAddClient').value = 'Add';
            document.getElementById('btnAddClient').value = objVar05;
        }
        function SetClientID(source, eventArgs) {
            ClearFields2();
            
            document.getElementById('<%= divClient.ClientID %>').innerHTML = '';
            document.getElementById('hdnAddClient').value = '';
            document.getElementById('trClient').style.display = 'none';
            document.getElementById('tdDivClient').style.display = 'none';
            document.getElementById('txtClientName').value = eventArgs.get_text();
            document.getElementById('hdnClientID').value = eventArgs.get_value();
            document.getElementById('drpRefType').value = "0";
            document.getElementById('drpRefType').disabled = false;
            SetContextItems();
        }
        function GetClientDetails(ClientDetails) {
            var objVar07 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_07") == null ? "Update" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_07");
            var objVar06 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06") == null ? "Save" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06");

            if (ClientDetails != '') {
                //                document.getElementById('btnSaveClient').value = 'Update';
                document.getElementById('btnSaveClient').value = objVar06;
                document.getElementById('hdnAlertMsg').value = '1';
                var Details = ClientDetails.split('^');
                var newItems = '';
                for (var k = 0; k < Details.length; k++) {
                    if (Details[k] != '') {
                        newItems += Details[k].split('~')[4] + '~' +
                                Details[k].split('~')[5] + '~' +
                                Details[k].split('~')[6] + '~' +
                                Details[k].split('~')[7] + '~' +
                                Details[k].split('~')[8] + '~' +
                                Details[k].split('~')[9] + '^';
                    }
                }
                document.getElementById('hdnAddClient').value = '';
                document.getElementById('hdnAddClient').value = newItems;
                CreateClientTable();
            }
            else {
                document.getElementById('<%= divClient.ClientID %>').innerHTML = '';
                document.getElementById('hdnAddClient').value = '';
                document.getElementById('trClient').style.display = 'none';
                document.getElementById('tdDivClient').style.display = 'none';
                //                document.getElementById('btnSaveClient').value = 'Save';
                document.getElementById('btnSaveClient').value = objVar06;
            }
        }
        function CreateClientTable() {
            var objTName = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_TName") == null ? "Test Name" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_TName");
            var objType = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Type") == null ? "Type" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Type");
            var objRefType = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_RefTy") == null ? "Reference Type" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_RefTy");
            var objDel = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_dlt") == null ? "Delete" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_dlt");
            var objEdit = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Edit") == null ? "Edit" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Edit");
            var objAction = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Act") == null ? "Action" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Act");
            var items = document.getElementById('hdnAddClient').value.split('^');
            document.getElementById('<%= divClient.ClientID %>').innerHTML = '';
            var startTag, bodytag, endtag;
            startTag = "<TABLE ID='tabDrg1' Cellpadding='0' Cellspacing='0' width='80%' class='gridView' style='font-size: 11px;'><TBODY><tr class='gridHeader'><th scope='col' align='center' width='20%'> " + objTName + " </th> <th scope='col' align='center'  width='20%'> " + objType + " </th><th scope='col' align='center'  width='20%'> " + objRefType + " </th>";

            startTag += "<th scope='col' align='center'  width='10%'> Code </th>";
            startTag += "<th scope='col' align='center' width='10%'>" + objAction + "</th>";
            endtag = "</TBODY></TABLE>";
            bodytag = startTag;
            if (items != '') {
                
                for (var i = 0; i < items.length; i++) {
                    if (items[i] != '') {
                        bodytag += "<TR><TD STYLE='display:none'>" + items[i].split('~')[0] + "</TD>";
                        bodytag += "<TD align='left'>" + items[i].split('~')[1] + "</TD>";
                        bodytag += "<TD>" + items[i].split('~')[2] + "</TD>";
                        bodytag += "<TD>" + items[i].split('~')[4] + "</TD>";
                        bodytag += "<TD>" + items[i].split('~')[5] + "</TD>";
//                        if (items[i].split('~')[5] != "" && items[i].split('~')[5] != "undefined") {
//                            bodytag += "<TD>" + items[i].split('~')[5] + "</TD>";

//                        }
//                        else {
//                            bodytag += "<TD STYLE='display:none'>" + items[i].split('~')[5] + "</TD>";
//                        }

                        bodytag += "<TD><input name='" + items[i] + "' onclick='return EditClient(name);' value = 'Edit' type='button' title=" + objEdit + " style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'/>";
                        bodytag += "&nbsp;&nbsp;<input name='" + items[i] + "' onclick='return DeleteClient(name);' class='deleteIcons' value = 'Delete' type='button' title=" + objDel + " style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD></TR>";
                    }
                }
                bodytag += endtag;
                document.getElementById('trClient').style.display = 'table-row';
                document.getElementById('tdDivClient').style.display = 'table-cell';
                document.getElementById('<%= divClient.ClientID %>').innerHTML = bodytag;
                document.getElementById('lblT').innerHTML = "";
                ClearFields2();
                DisplayTab('CLI');
            }
        }
        function AddClient() {
            var objVar06 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_06") == null ? "Please select ClientType" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_06");
            var objAlert = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_Alert");
            var objVar07 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_07") == null ? "Please enter Client Name" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_07");
            var objVar08 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_08") == null ? "Please Enter Test Name" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_08");
            var objVar09 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_09") == null ? "Please Enter Code" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_09");

            if (document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].value == '0') {
                //alert('Please select ClientType');
                ValidationWindow(objVar06, objAlert);

                document.getElementById('ddlClientType').focus();
                return false;
            }
            if (document.getElementById('txtClientName').value == '') {
                //alert('Please enter Client Name');
                ValidationWindow(objVar07, objAlert);

                document.getElementById('txtClientName').focus();
                return false;
            }
            if (document.getElementById('txtTestName').value == '') {
                //alert('Please Enter Test Name');
                ValidationWindow(objVar08, objAlert);

                document.getElementById('txtTestName').focus();
                return false;
            }
//            if (document.getElementById('drpRefType').options[document.getElementById('drpRefType').selectedIndex].value == '0') {
 //               alert('Please select the reference type ');
 //               document.getElementById('drpRefType').focus();
//                return false;
//            }

            if (document.getElementById('drpRefType').options[document.getElementById('drpRefType').selectedIndex].value == 'SC') {
                if (document.getElementById('txtSCode').value == '') {
                    // alert('Please Enter Code');
                    ValidationWindow(objVar09, objAlert);
                    document.getElementById('txtSCode').focus();
                    return false;
                }
                else {
                    var chk = checkClientTable();
                    if (chk == true) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
            }

            else {
                var chk = checkClientTable();
                if (chk == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        function checkClientTable() {
            var objVar10 = SListForAppMsg.Get("Admin_SpecialRateCard_aspx_10") == null ? "Already Added" : SListForAppMsg.Get("Admin_SpecialRateCard_aspx_10");
            var objAlert = SListForAppMsg.Get("Admin_SpecialRateCard_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_SpecialRateCard_Alert");

            var Scode = document.getElementById('txtSCode').value;
            if (Scode == "") {
                document.getElementById('txtSCode').value = document.getElementById('hdnTestCode').value;
            }

            var newClientData = document.getElementById('hdnInvID').value + '~' +
                          document.getElementById('hdnInvName').value + '~' +
                          document.getElementById('hdnInvType').value + '~' + 'BIL' + '~' +
                          'Bill' + '~' +
                         // document.getElementById('drpRefType').options[document.getElementById('drpRefType').selectedIndex].value + '~' +
                         // document.getElementById('drpRefType').options[document.getElementById('drpRefType').selectedIndex].innerText + '~' +
                           document.getElementById('txtSCode').value;
            var existingdata = document.getElementById('hdnAddClient').value.split('^');
            if (existingdata != '') {
                if (newClientData != '') {
                    for (var i = 0; i < existingdata.length; i++) {
                        if (existingdata[i].split('~')[0] == newClientData.split('~')[0]) {
                            //alert('Already Added');
                            ValidationWindow(objVar10, objAlert);

                            document.getElementById('txtInvName').value = '';
                            document.getElementById('txtAmount').value = '';
                            document.getElementById('txtInvName').focus();
                            return false;
                        }
                    }
                }
            }
            document.getElementById('hdnAddClient').value += newClientData + '^';
            CreateClientTable();
        }
        function EditClient(editItems) {
            var objVar08 = SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06") == null ? "Save Changes" : SListForAppDisplay.Get("Admin_SpecialRateCard_aspx_06");

            DeleteClient(editItems);
            if (editItems != '') {
                // document.getElementById('btnAddClient').value = 'Save Changes';
                document.getElementById('btnAddClient').value = objVar08;
                document.getElementById('txtTestName').value = editItems.split('~')[1];
                document.getElementById('lblT').innerHTML = editItems.split('~')[2];
                document.getElementById('drpRefType').value = editItems.split('~')[3];
                document.getElementById('hdnInvID').value = editItems.split('~')[0];
                document.getElementById('hdnInvName').value = editItems.split('~')[1];
                document.getElementById('hdnInvType').value = editItems.split('~')[2];
                document.getElementById('txtSCode').value = editItems.split('~')[5];
                if (editItems.split('~')[3] == "SC") {
                    document.getElementById('trCode').style.display = "table-row";
                    document.getElementById('txtSCode').value = editItems.split('~')[5];
                }
//                else {
//                    document.getElementById('trCode').style.display = "none";
//                    document.getElementById('txtSCode').value = "";

                //                }
                document.getElementById('btnSaveClient').value = "Update";
            }
        }
        function DeleteClient(deleteItems) {
            if (document.getElementById('btnAddClient').value == 'Save Changes') {
                checkClientTable();
            }
            var existItem = document.getElementById('hdnAddClient').value.split('^');
            document.getElementById('hdnAddClient').value = '';
            var additems = '';
            if (existItem != '') {
                for (var i = 0; i < existItem.length; i++) {
                    if (existItem[i] != "") {
                        if (deleteItems.split('~')[0] != existItem[i].split('~')[0]) {
                            additems += existItem[i] + "^";
                        }
                    }
                }
            }
            document.getElementById('hdnAddClient').value = additems;
            CreateClientTable();
        }
        function CancelFun() {
            document.getElementById('ddlClientType').value = '0';
            document.getElementById('drpRefType').value = '0';
            DisableFunc('F');
            ClearFields1();
            ClearFields2();
            DisplayTab('CLI');
            return false;
        }
        function SetContextItems() {
            document.getElementById('txtTestName').disabled = false;
            var RefTypeName ="Bill";
            var RefTypeID = "BIL";
            var ClientID = document.getElementById('hdnClientID').value;
            var orgID = '<%=OrgID %>';
            var CIDRID = ClientID + '~' + RefTypeID;
            if (ClientID != '') {
                WebService.GetClientMappingService(CIDRID, GetClientDetails);
            }
            if (RefTypeID == 'INV') {
                $find('AutoCompleteExtender2').set_contextKey(orgID + '~' + 'GEN');
                document.getElementById('trCode').style.display = "none";
            }
            else if (RefTypeID == 'SC') {
                document.getElementById('trCode').style.display = "table-row";
                $find('AutoCompleteExtender2').set_contextKey(orgID + '~' + '');
            }
            else {
                //document.getElementById('trCode').style.display = "none";
                $find('AutoCompleteExtender2').set_contextKey(orgID + '~' + '');
            }
        }
    
</script>

    <style type="text/css">
        .style2
        {
            width: 250px;
        }
    </style>
    </head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" ScriptMode="Release" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>
                                    <table class="w-100p searchPanel">
                                        <tr>
                                            <td class="v-top" colspan="2">
                                                <div id='TabsMenu' class="a-left">
                                                    <ul>
                                                        <li id="li1" onclick="DisplayTab('SPL')" style="display: none;"><a href="#"><span><%=Resources.Admin_ClientDisplay.Admin_SpecialRateCard_aspx_01 %></span></a></li>
                                                        <li id="li2" class="active" onclick="DisplayTab('CLI')"><a href='#'><span><%=Resources.Admin_ClientDisplay.Admin_SpecialRateCard_aspx_02 %> </span></a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="b-tab">
                                            <td>
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdSpecial" style="display: none;">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-center">
                                                            <div>
                                                                <asp:Panel ID="pnlas" runat="server" 
                                                                    CssClass="dataheader2 defaultfontcolor w-80p" meta:resourcekey="pnlasResource1">
                                                                    <table style="font-family: Tahoma; font-size: small" class="w-100p">
                                                                        <tr>
                                                                            <td class="w-20p a-right">
                                                                                <asp:Label ID="lblRateName" runat="server" Text="Rate Card Name" 
                                                                                    meta:resourcekey="lblRateNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="w-80p a-left" colspan="4">
                                                                                <asp:TextBox ID="txtRateName" runat="server" Width="170px" TabIndex="1" 
                                                                                    meta:resourcekey="txtRateNameResource1"></asp:TextBox>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="w-10p a-right">
                                                                                <asp:Label ID="lblName" Text="Name" runat="server" 
                                                                                    meta:resourcekey="lblNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="w-27p a-left">
                                                                                <asp:TextBox ID="txtInvName" runat="server" TabIndex="2" Width="170px" onkeydown="javascript:clearfn();"
                                                                                    CssClass="Txtboxsmall" meta:resourcekey="txtInvNameResource1"></asp:TextBox>
                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtInvName"
                                                                                    EnableCaching="False" MinimumPrefixLength="3" CompletionInterval="0" FirstRowSelected="True"
                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetOrgInvestigationsGroupandPKG"
                                                                                    OnClientItemSelected="SelectedInv" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                    DelimiterCharacters="" Enabled="True" OnClientItemOver="SelectedTest">
                                                                                </ajc:AutoCompleteExtender>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                <asp:Label ID="lblI" runat="server" ForeColor="Red" Font-Bold="True" 
                                                                                    meta:resourcekey="lblIResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="w-5p">
                                                                                <asp:Label Text="Amount" runat="server" ID="lblAmount" 
                                                                                    meta:resourcekey="lblAmountResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="w-10p">
                                                                                <asp:TextBox ID="txtAmount" runat="server" onKeyDown="return  isNumeric(event,this.id)"
                                                                                    Width="50px" TabIndex="3" meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                            <td class="w-48p a-left">
                                                                               <%-- <input id="btnAdd" class="btn" tabindex="4" onclick="javascript:return Validate();"
                                                                                    type="button" value="Add" />--%>
                                                                                     <button id="btnAdd" class="btn" tabindex="4" onclick="javascript:return Validate();"
                                                                                     value="Add" ><%=Resources.Admin_ClientDisplay.Admin_SpecialRateCard_aspx_03 %></button>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="tdInveTable" style="display: none" colspan="5">
                                                                                <div id="divCreateInvTable" runat="server" class="w-99p">
                                                                                    </div>
                                                                            </td>
                                                                        </tr>                                                        
                                                                        <tr style="display: none" id="tdActions">
                                                                            <td class="w-30p a-right" colspan="2">
                                                                                <asp:Button ID="btnSave" runat="server" Text="Save" onmouseover="this.className='btn btnhov'"
                                                                                    CssClass="btn" onmouseout="this.className='btn'" Width="75px" TabIndex="5" 
                                                                                    OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                                                            </td>
                                                                            <td colspan="3" class="w-80p a-left">
                                                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" onmouseover="this.className='btn btnhov'"
                                                                                    CssClass="btn" onmouseout="this.className='btn'" Width="75px" OnClientClick="return ClearInvTable();"
                                                                                    TabIndex="6" meta:resourcekey="btnCancelResource1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </div>
                                                            <hr style="background-color: blue" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center">
                                                            <%--R.RateId,R.RateName,I.InvestigationID AS InvestigationID,I.InvestigationName AS ClientName,IRM.Type AS InvestigationType,IRM.Rate AS OpAmount--%>
                                                            <asp:GridView ID="grdSpecialRates" runat="server" AutoGenerateColumns="False" 
                                                                CssClass="mytable1 gridView w-80p" OnRowCommand="grdSpecialRates_RowCommand" DataKeyNames="RateId,RateName"
                                                                EmptyDataText="There is no Special Rate Card!!" 
                                                                meta:resourcekey="grdSpecialRatesResource1">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <%#Container.DataItemIndex+1%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="8%" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="RateId" Visible="false" 
                                                                        meta:resourcekey="BoundFieldResource1" />
                                                                    <asp:BoundField DataField="RateName" ItemStyle-HorizontalAlign="Left" 
                                                                        HeaderText="Rate Name" meta:resourcekey="BoundFieldResource2" >
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField runat="server" ID="hdnSpecialRated" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action" 
                                                                        meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="View" CommandName="Mapping" 
                                                                                CommandArgument='<%# Eval("RateId")+","+ Eval("RateName") %>' 
                                                                                meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                <HeaderStyle CssClass="dataheader1" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td id="tdClient" class="a-center">
                                                <div>
                                                    <asp:Panel ID="Panel1" runat="server" 
                                                        CssClass="dataheader2 defaultfontcolor w-80p" 
                                                        meta:resourcekey="Panel1Resource1">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="w-15p a-left">
                                                                   <asp:Label ID="lblClientType" Text="Business Type" runat="server" 
                                                                        meta:resourcekey="lblClientTypeResource1"></asp:Label> 
                                                                </td>
                                                                <td class="w-30p a-left">
                                                                    <asp:DropDownList ID="ddlClientType" Width="175px" TabIndex="1" CssClass="ddlmedium"
                                                                        runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlClientType_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td class="w-10p a-left">
                                                                    <asp:Label ID="Label3" Text="Client Name" runat="server" 
                                                                        meta:resourcekey="Label3Resource1"></asp:Label> 
                                                                </td>
                                                                <td colspan="2" class="w-45p a-left">
                                                                    <asp:TextBox CssClass="Txtboxmedium" Enabled="False" ID="txtClientName" Width="300px"
                                                                        TabIndex="2" runat="server" meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientNamebyClientType"
                                                                        OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                        Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>                                                                
                                                            </tr>    
                                                            <tr>
                                                                <td class="w-10p a-left">
                                                                    <asp:Label ID="lblTestName" runat="server" Text="Investigation Name" 
                                                                        meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-30p a-left">
                                                                    <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" Enabled="False"
                                                                        onkeydown="javascript:clearfn();" TabIndex="4" Width="170px" 
                                                                        meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionInterval="0"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="3" OnClientItemOver="SelectedTest"
                                                                        OnClientItemSelected="SelectedInv" ServiceMethod="GetOrgInvestigationsGroupandPKG"
                                                                        ServicePath="~/WebService.asmx" TargetControlID="txtTestName" 
                                                                        UseContextKey="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                    <asp:Label ID="lblT" runat="server" Font-Bold="True" ForeColor="Red" 
                                                                        meta:resourcekey="lblTResource1"></asp:Label>&nbsp;<img
                                                                        src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td class="w-15p a-left" style="display: none">
                                                                    <asp:Label ID="lblReferenceType" runat="server" Text="Reference Type" 
                                                                        meta:resourcekey="lblReferenceTypeResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-35p a-left" style="display: none">
                                                                    <asp:DropDownList ID="drpRefType" runat="server" CssClass="ddlmedium" Enabled="false"
                                                                        onChange="SetContextItems();" TabIndex="3" Width="175px">
                                                                    </asp:DropDownList>
																	&nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>                                                                
                                                            </tr>
                                                            <tr id="trCode" runat="server" style="display: none">
                                                            <td class="a-left">
                                                                    <asp:Label ID="lblservcode" runat="server" Text="Code"></asp:Label>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:TextBox ID="txtSCode" runat="server"  CssClass="Txtboxsmall" Width="70px" MaxLength="9"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-center" colspan="5">
                                                                    <%--<input id="btnAddClient" class="btn" enabled="false" tabindex="5" onclick="javascript:return AddClient();"
                                                                        type="button" value="Add" style="width: 80px;" />--%>
                                                                        <button id="btnAddClient" class="btn" enabled="false" tabindex="5" onclick="javascript:return AddClient();"
                                                                        style="width: 80px;" ><%=Resources.Admin_ClientDisplay.Admin_SpecialRateCard_aspx_03 %></button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td id="tdDivClient" style="display: none" colspan="5">
                                                                    <div id="divClient" runat="server" style="width: 99%;">
                                                                        </div>
                                                                </td>
                                                             </tr>  
                                                            <tr style="display: none" id="trClient">
                                                                <td class="w-30p a-right" colspan="2">
                                                                    <asp:Button ID="btnSaveClient" runat="server" Text="Save" onmouseover="this.className='btn btnhov'"
                                                                        CssClass="btn" onmouseout="this.className='btn'" Width="75px" TabIndex="8" 
                                                                        OnClick="btnSaveClient_Click" meta:resourcekey="btnSaveClientResource1" />
                                                                </td>
                                                                <td colspan="3" class="w-80p a-left">
                                                                    <asp:Button ID="Button3" runat="server" Text="Cancel" onmouseover="this.className='btn btnhov'"
                                                                        CssClass="btn" onmouseout="this.className='btn'" Width="75px" OnClientClick="return CancelFun();"
                                                                        TabIndex="9" meta:resourcekey="Button3Resource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>                                        
                                    </table>
                                    <asp:HiddenField ID="hdnInvID" runat="server" />
                                    <asp:HiddenField ID="hdnInvName" runat="server" />
                                    <asp:HiddenField ID="hdnInvType" runat="server" />
                                    <asp:HiddenField ID="hdnSelectedTest" runat="server" />
                                    <asp:HiddenField ID="hdnAdditems" runat="server" />   
                                    <asp:HiddenField ID="hdnSpecialRate"  runat="server" />  
                                    <asp:HiddenField ID="hdnRateID" runat="server"  />
                                    <asp:HiddenField ID="hdnUpdate" runat="server" Value="0" />  
                                    <asp:HiddenField ID="hdnClientID" runat="server" />
                                    <asp:HiddenField ID="hdnAlertMsg" runat="server" Value="0" />   
                                    <asp:HiddenField ID="hdnAddClient" runat="server" />                                                              
                                    <asp:HiddenField ID="hdnTestCode" runat="server" />                                                                                                 
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>                    
     <Attune:Attunefooter ID="Attunefooter" runat="server" />          
    </form>
</body>
</html>

