<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PasswordPolicy.aspx.cs" Inherits="Admin_PasswordPolicy"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="OrgHeaderForChangePass"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Policy Master</title>
        <script type="text/javascript" src="../Scripts/jquery.min.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/ddaccordion.js" language="javascript"></script>

    <link href="../StyleSheets/tooltip.css" rel="stylesheet" type="text/css" media="all" />
    
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
        #tblPrintPolicy
        {
            border-collapse: collapse;
            width: 100%;
        }
        #tblPrintPolicy td, #tblPrintPolicy th
        {
            border: 1px solid white;
            padding: 5px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        window.history.forward(1);
    </script>

    <script type="text/javascript" language="javascript">
        var objAlert = "";
        var objEqual = "";
        var objPassLen = "";
        var objvar18 = "";
        var objvar19 = "";
        var objvar20 = "";
        var objvar21 = "";
        var objvar22 = "";
        var objvar23 = "";
        $(document).ready(function() {
            objAlert = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_Alert");
            objEqual = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_01") == null ? "Greater than or Equal Password Length" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_01");
            objPassLen = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_02") == null ? "Greater than Password Length" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_02");
            objvar18 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_11") == null ? "Maximum 365 Days" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_11");
            objvar19 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_12") == null ? "Maximum 52 Weeks" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_12");
            objvar20 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_13") == null ? "Maximum 1 Year" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_13");
            objvar21 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_14") == null ? "Maximum 12 Months" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_14");
            objvar22 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_15") == null ? "Max Length 12" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_15");
            objvar23 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_16") == null ? "Min Length 6" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_16");

        });
        function checklength() {
            var passlen = document.getElementById("txtpasswordlength").value;
            if (document.getElementById('Chkspl').checked == true) {
                var splchar = document.getElementById("Txtsplchar").value;
            }
            if (Number(passlen) <= Number(splchar)) {
                //                alert('Greater than or Equal Password Length');
                ValidationWindow(objEqual, objAlert);
                document.getElementById("Txtsplchar").value = '0';
                document.getElementById("Txtsplchar").focus();
                return false;
            }

        }




        function checklength1() {
            var passlen = document.getElementById("txtpasswordlength").value;
            var splchar = document.getElementById("Txtsplchar").value;
            var numchar = document.getElementById("txttransnum").value;


            if (document.getElementById('Chknumber').checked == true && document.getElementById('Chkspl').checked == true) {
                var Totalcount = Number(splchar) + Number(numchar);
                if (Number(passlen) <= Number(Totalcount)) {
                    // alert('Greater than or Equal Password Length');
                    ValidationWindow(objEqual, objAlert);
                    document.getElementById("txttransnum").value = '0';
                    document.getElementById("Txtsplchar").value = '0';
                    document.getElementById("Txtsplchar").focus();
                    return false;
                }

            }

            else {


                if (Number(passlen) <= Number(numchar)) {
                    //alert('Greater than or Equal Password Length');
                    ValidationWindow(objEqual, objAlert);
                    document.getElementById("txttransnum").value = '0';
                    return false;
                }
            }

        }

        //---------------------------------------------------------------------------------
        function transchecklength() {
            var passlen = document.getElementById("txttranspwdlen").value;
            if (document.getElementById('Chktransspl').checked == true) {
                var splchar = document.getElementById("txttransspl").value;
            }
            if (Number(passlen) < Number(splchar)) {
                // alert('Greater than Password Length');
                ValidationWindow(objPassLen, objAlert);
                document.getElementById("txttransspl").value = '0';
                document.getElementById("txttransspl").focus();
                return false;
            }

        }




        function transchecklength1() {
            var passlen = document.getElementById("txttranspwdlen").value;
            var splchar = document.getElementById("txttransspl").value;
            var numchar = document.getElementById("txttransnum").value;


            if (document.getElementById('Chktransspl').checked == true && document.getElementById('Chktransnum').checked == true) {
                var Totalcount = Number(splchar) + Number(numchar);
                if (Number(passlen) < Number(Totalcount)) {
                    //alert('Greater than Password Length');
                    ValidationWindow(objPassLen, objAlert);
                    document.getElementById("txttransnum").value = '0';
                    document.getElementById("txttransspl").value = '0';
                    document.getElementById("txttransspl").focus();
                    return false;
                }

            }

            else {


                if (Number(passlen) < Number(numchar)) {
                    //alert('Greater than Password Length');
                    ValidationWindow(objPassLen, objAlert);
                    document.getElementById("txttransnum").value = '0';
                    return false;
                }
            }

        }

        //-----------------------------------------------------------------------------------

        function ChildGridList() {
            while (count = document.getElementById('tblPasswordPolicy').rows.length) {
                for (var j = 0; j < document.getElementById('tblPasswordPolicy').rows.length; j++) {
                    document.getElementById('tblPasswordPolicy').deleteRow(j);
                }
            }
            var objvar01 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_01") == null ? "Type" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_01");
            var objvar02 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_02") == null ? "PasswordLength" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_02");
            var objvar03 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_03") == null ? "SplcharLength" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_03");
            var objvar04 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_04") == null ? "NumcharLength" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_04");
            var objvar05 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_05") == null ? "ValidityPeriodType" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_05");
            var objvar06 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_06") == null ? "ValidityPeriod" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_06");
            var objvar07 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_07") == null ? "PreviousPwdcount" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_07");
            var objvar08 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_08") == null ? "Action" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_08");
            var objEdit = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_26") == null ? "Edit" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_26");
            var objDel = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_27") == null ? "Delete" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_27");
            var pParentProIDs = document.getElementById('hdnRecords').value.split("^");

            var Headrow = document.getElementById('tblPasswordPolicy').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1";


            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);
            var cell7 = Headrow.insertCell(6);
            var cell8 = Headrow.insertCell(7);


            //            cell1.innerHTML = "Type";
            //            cell2.innerHTML = "PasswordLength";
            //            cell3.innerHTML = "SplcharLength";
            //            cell4.innerHTML = "NumcharLength";
            //            cell5.innerHTML = "ValidityPeriodType";
            //            cell6.innerHTML = "ValidityPeriod";
            //            cell7.innerHTML = "PreviousPwdcount";
            //            cell8.innerHTML = "Action";

            cell1.innerHTML = objvar01;
            cell2.innerHTML = objvar02;
            cell3.innerHTML = objvar03;
            cell4.innerHTML = objvar04;
            cell5.innerHTML = objvar05;
            cell6.innerHTML = objvar06;
            cell7.innerHTML = objvar07;
            cell8.innerHTML = objvar08;


            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var test = pParentProIDs[j].split('~');
                    var row = document.getElementById('tblPasswordPolicy').insertRow(1);
                    row.style.height = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);

                    if (test != "") {
                        cell1.innerHTML = test[0];
                        cell2.innerHTML = test[1];
                        cell3.innerHTML = test[2];
                        cell4.innerHTML = test[3];
                        cell5.innerHTML = test[4];
                        cell6.innerHTML = test[5];
                        cell7.innerHTML = test[6];
                        cell8.innerHTML = "<input name='" + test[0] + "~" + test[1] + "~" + test[2] + "~" + test[3] + "~" + test[4] + "~" + test[5] + "~" + test[6] + "~" + test[7] + "' onclick='btnEdit_OnClick(name);' value = " + objEdit + " type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + test[0] + "~" + test[1] + "~" + test[2] + "~" + test[3] + "~" + test[4] + "~" + test[5] + "~" + test[6] + "~" + test[7] + "' onclick='btnDelete(name);' class='deleteIcons' value =" + objDel+ " type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                    }
                }
            }
            if (document.getElementById('tblPasswordPolicy').rows.length > 0 && document.getElementById("btnadd").value != 'Update') {
                //document.getElementById('divSave').style.display = 'none';
            }
        }


        var fflag = "0";
        var Tflag = "0";
        var hdnEditedVal = "";
        var hdnEditedVal1 = "";
        function btnEdit_OnClick(sEditedData) {
            var objupdate = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_24") == null ? "Update" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_24");
            if (document.getElementById('tblPasswordPolicy').rows.length > 0) {
               // document.getElementById('divSave').style.display = 'none';
            }
            var y = sEditedData.split('~');
            if (y[0] == "T") {
                Tflag = "T";
                hdnEditedVal1 = sEditedData;
            }
            if (y[0] == "L") {
                fflag = "L";
                hdnEditedVal = sEditedData;
            }
            document.getElementById('btnadd').value = objupdate;
            var drppasslen = document.getElementById("txtpasswordlength");
            var chkspl = document.getElementById("Chkspl");
            var drpsplchar = document.getElementById("Txtsplchar");
            var Chknumber = document.getElementById("Chknumber");
            var drpnumchar = document.getElementById("txtnum");
            var chkvltypd = document.getElementById("chkvltypd");
            var ddlvlty = document.getElementById("ddlvlty");
            var txtvltypd = document.getElementById("txtvltypd");
            var chkprepass = document.getElementById("chkprepass");
            var drpprepass = document.getElementById("txtprepwd");
            var transdrppasslen = document.getElementById("txttranspwdlen");
            var transchkspl = document.getElementById("Chktransspl");
            var transdrpsplchar = document.getElementById("txttransspl");
            var transChknumber = document.getElementById("Chktransnum");
            var transdrpnumchar = document.getElementById("txttransnum");
            var transchkvltypd = document.getElementById("chktransvltypd");
            var transddlvlty = document.getElementById("drptransvltypd");
            var transtxtvltypd = document.getElementById("txttransvltypd");
            var transchkprepass = document.getElementById("chktransprepass");
            var transdrpprepass = document.getElementById("txttransprepwd");

            if (y[0] == 'L') {
                drppasslen.value = y[1];
                if (y[2] != '' && y[2] != '0') {
                    chkspl.checked = true;
                    document.getElementById('tdsplchar').style.display = 'table-cell';
                    drpsplchar.value = y[2];
                }
                if (y[3] != '' && y[3] != '0') {
                    Chknumber.checked = true;
                    document.getElementById('tdchknumber').style.display = 'table-cell';
                    drpnumchar.value = y[3];
                }
                if (y[4] != '' && y[4] != '0') {
                    chkvltypd.checked = true;
                    document.getElementById('tdvltyprd').style.display = 'table-cell';
                    ddlvlty.value = y[4];
                    txtvltypd.value = y[5];
                }
                if (y[6] != '' && y[6] != '0') {
                    chkprepass.checked = true;
                    document.getElementById('tdprepass').style.display = 'table-cell';
                    drpprepass.value = y[6];
                }
                if (y[7] != '' && y[7] != '0') {
                    document.getElementById('hdnRowID1').value = y[7];
                }
            }

            //==========================================================================================

            if (y[0] == 'T') {
                transdrppasslen.value = y[1];
                if (y[2] != '' && y[2] != '0') {
                    transchkspl.checked = true;
                    document.getElementById('tdtransspl').style.display = 'table-cell';
                    transdrpsplchar.value = y[2];
                }
                if (y[3] != '' && y[3] != '0') {
                    transChknumber.checked = true;
                    document.getElementById('tdtransnum').style.display = 'table-cell';
                    transdrpnumchar.value = y[3];
                }

                if (y[4] != '' && y[4] != '0') {
                    transchkvltypd.checked = true;
                    document.getElementById('tdtransvltypd').style.display = 'table-cell';
                    var len3 = transddlvlty.length;
                    for (var i = 0; i < len3; i++) {
                        if (transddlvlty.options[i].innerHTML == y[4]) {
                            transddlvlty.options[i].selected = true;
                            transddlvlty.options[i].disabled = false;
                        }
                    }
                    transtxtvltypd.value = y[5];
                }
                if (y[6] != '' && y[6] != '0') {
                    transchkprepass.checked = true;
                    document.getElementById('tdtransprepass').style.display = 'table-cell';
                    transdrpprepass.value = y[6];
                }
                if (y[7] != '' && y[7] != '0') {
                    document.getElementById('hdnRowID2').value = y[7];
                }
            }

            //================================================================================================ 
            //            var x = document.getElementById('hdnRecords').value.split("^");
            //            document.getElementById('hdnRecords').value = '';
            //            for (var i = 0; i < x.length; i++) {
            //                if (x[i] != "") {
            //                    if (x[i] != sEditedData) {
            //                        document.getElementById('hdnRecords').value += x[i] + "^";
            //                    }
            //                }
            //            }

            ChildGridList();
        }
        function btnDelete(sEditedData) {
            var objvar09 = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_09") == null ? "Confirm to delete!!" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_09");
            var i;
            //            var IsDelete = confirm("Confirm to delete!!");
            var IsDelete = confirm(objvar09);
            if (IsDelete == true) {
                var x = document.getElementById('hdnRecords').value.split("^");
                document.getElementById('hdnRecords').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnRecords').value += x[i] + "^";
                        }
                    }
                }
                ChildGridList();
            }
            else {
                return false;
            }
        }

        function CheckToAssign() {
            var objvar10 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_03") == null ? "Enter Special Character" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_03");
            var objvar11 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_04") == null ? "Enter Number Character" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_04");
            var objvar12 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_05") == null ? "Enter Validity Period" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_05");
            var objvar13 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_06") == null ? "Select Validity Period" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_06");
            var objvar14 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_07") == null ? "Enter Previous Password Count" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_07");
            var objvar15 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_08") == null ? "Provide Validity Period" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_08");
            var objadd = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_10") == null ? "ADD" : SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_10");

            var flag = 1;
            if (document.getElementById('hdnConfigid').value == "Y") {

                if (document.getElementById('Chkspl').checked == true) {
                    if (document.getElementById('Txtsplchar').value == '0' || document.getElementById('Txtsplchar').value == "") {
                        // alert('Enter Special Character');
                        ValidationWindow(objvar10, objAlert);
                        document.getElementById('Txtsplchar').focus();
                        return false;
                    }
                }
                if (document.getElementById('Chknumber').checked == true) {
                    if (document.getElementById('txtnum').value == '0' || document.getElementById('txtnum').value == "") {
                        //alert('Enter Number Character');
                        ValidationWindow(objvar11, objAlert);
                        document.getElementById('txtnum').focus();
                        return false;
                    }
                }
                if (document.getElementById('chkvltypd').checked == true) {
                    if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML != 'Select') {

                        if (document.getElementById('txtvltypd').value == '0' || document.getElementById('txtvltypd').value == "") {
                            //alert('Enter Validity Period');
                            ValidationWindow(objvar12, objAlert);
                            document.getElementById('txtvltypd').focus();
                            return false;
                        }
                    }
                    else {
                        //alert('Select Validity Period');
                        ValidationWindow(objvar13, objAlert);
                        document.getElementById('ddlvlty').focus();
                        return false;
                    }
                }

                if (document.getElementById('chkprepass').checked == true) {
                    if (document.getElementById('txtprepwd').value == '0' || document.getElementById('txtprepwd').value == "") {
                        //alert('Enter Previous Password Count');
                        ValidationWindow(objvar14, objAlert);
                        document.getElementById('txtprepwd').focus();
                        return false;

                    }
                }
            }


            //======================================================================================

            if (document.getElementById('hdnConfigid').value == "Y") {

                //                if (document.getElementById('drptranspasslen').options[document.getElementById('drptranspasslen').selectedIndex].innerHTML == '') {
                //                    alert('Select Password Length');
                //                    document.getElementById('drptranspasslen').focus();
                //                    return false;

                //                }

                if (document.getElementById('Chktransspl').checked == true) {
                    if (document.getElementById('txttransspl').value == '0' || document.getElementById('txttransspl').value == "") {
                        //alert('Enter Special Character');
                        ValidationWindow(objvar10, objAlert);
                        document.getElementById('txttransspl').focus();
                        return false;
                    }
                }

                if (document.getElementById('Chktransnum').checked == true) {
                    if (document.getElementById('txttransnum').value == '0' || document.getElementById('txttransnum').value == "") {
                        // alert('Enter Number Character');
                        ValidationWindow(objvar11, objAlert);
                        document.getElementById('txttransnum').focus();
                        return false;
                    }
                }

                if (document.getElementById('chktransvltypd').checked == true) {
                    if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML != 'Select') {

                        if (document.getElementById('txttransvltypd').value == '0' || document.getElementById('txttransvltypd').value == "") {
                            // alert('Provide Validity Period');
                            ValidationWindow(objvar15, objAlert);
                            document.getElementById('txttransvltypd').focus();
                            return false;
                        }
                    }
                    else {
                        //alert('Select Validity Period');
                        ValidationWindow(objvar13, objAlert);
                        document.getElementById('drptransvltypd').focus();
                        return false;
                    }
                }

                if (document.getElementById('chktransprepass').checked == true) {
                    if (document.getElementById('txttransprepwd').value == '0' || document.getElementById('txttransprepwd').value == "") {
                        // alert('Enter Previous Password Count');
                        ValidationWindow(objvar14, objAlert);
                        document.getElementById('txttransprepwd').focus();
                        return false;

                    }
                }
            }

            if (document.getElementById('hdnConfigid').value != "Y") {


                //                if (document.getElementById('drppasslen').options[document.getElementById('drppasslen').selectedIndex].innerHTML == '') {
                //                    alert('Select Password Length');
                //                    document.getElementById('drppasslen').focus();
                //                    return false;

                //                }

                if (document.getElementById('Chkspl').checked == true) {
                    if (document.getElementById('Txtsplchar').value == '0' || document.getElementById('Txtsplchar').value == "") {
                        //alert('Enter Special Character');
                        ValidationWindow(objvar10, objAlert);
                        document.getElementById('Txtsplchar').focus();
                        return false;
                    }
                }
                if (document.getElementById('Chknumber').checked == true) {
                    if (document.getElementById('txtnum').value == '0' || document.getElementById('txtnum').value == "") {
                        //alert('Enter Number Character');
                        ValidationWindow(objvar11, objAlert);
                        document.getElementById('txtnum').focus();
                        return false;
                    }
                }

                if (document.getElementById('chkvltypd').checked == true) {
                    if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML != 'Select') {

                        if (document.getElementById('txtvltypd').value == '0' || document.getElementById('txtvltypd').value == "") {
                            //alert('Provide Validity Period');
                            ValidationWindow(objvar15, objAlert);
                            document.getElementById('txtvltypd').focus();
                            return false;
                        }
                    }
                    else {
                        //alert('Select Validity Period');
                        ValidationWindow(objvar13, objAlert);
                        document.getElementById('ddlvlty').focus();
                        return false;
                    }
                }

                if (document.getElementById('chkprepass').checked == true) {
                    if (document.getElementById('txtprepwd').value == '0' || document.getElementById('txtprepwd').value == "") {
                        // alert('Enter Previous Password Count');
                        ValidationWindow(objvar14, objAlert);
                        document.getElementById('txtprepwd').focus();
                        return false;

                    }
                }
            }



            getVal();
            getValTrans();
            document.getElementById('btnadd').value = objadd;
            document.getElementById('txtpasswordlength').value = "";
            document.getElementById('Txtsplchar').value = "";
            document.getElementById('txtnum').value = "";
            document.getElementById('ddlvlty').selectedIndex = 0;
            document.getElementById('txtvltypd').value = "";
            document.getElementById('txtprepwd').value = "";
            document.getElementById('txttranspwdlen').value = "";
            document.getElementById('txttransspl').value = "";
            document.getElementById('txttransnum').value = "";
            document.getElementById('drptransvltypd').selectedIndex = 0;
            document.getElementById('txttransvltypd').value = "";
            document.getElementById('txttransprepwd').value = "";
            document.getElementById('Chkspl').checked = false;
            document.getElementById('Chknumber').checked = false;
            document.getElementById('chkvltypd').checked = false;
            document.getElementById('chkprepass').checked = false;
            document.getElementById('Chktransspl').checked = false;
            document.getElementById('Chktransnum').checked = false;
            document.getElementById('chktransvltypd').checked = false;
            document.getElementById('chktransprepass').checked = false;
            document.getElementById('tdsplchar').style.display = 'none';
            document.getElementById('tdchknumber').style.display = 'none';
            document.getElementById('tdvltyprd').style.display = 'none';
            document.getElementById('tdprepass').style.display = 'none';
            document.getElementById('tdtransspl').style.display = 'none';
            document.getElementById('tdtransnum').style.display = 'none';
            document.getElementById('tdtransvltypd').style.display = 'none';
            document.getElementById('tdtransprepass').style.display = 'none';
            ChildGridList();
            document.getElementById('hdnRowID1').value = "0";
            document.getElementById('hdnRowID2').value = "0";
        }
        function getValTrans() {
            var objvar16 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_09") == null ? "Transaction Password Policy Already exists" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_09");

            if (document.getElementById('txttranspwdlen').value != '' && document.getElementById('txttranspwdlen').value != '0') {
                var flag = 1;
                var TransType = "T";
                var transdrppasslen = document.getElementById("txttranspwdlen");
                var transchkspl = document.getElementById("Chktransspl");
                var transdrpsplchar = document.getElementById("txttransspl");
                var transChknumber = document.getElementById("Chktransnum");
                var transdrpnumchar = document.getElementById("txttransnum");
                var transchkvltypd = document.getElementById("chktransvltypd");
                var transddlvlty = document.getElementById("drptransvltypd");
                var transtxtvltypd = document.getElementById("txttransvltypd");
                var transchkprepass = document.getElementById("chktransprepass");
                var transdrpprepass = document.getElementById("txttransprepwd");
                var rowID = document.getElementById("hdnRowID2");
                if (document.getElementById('hdnRecords').value != "") {
                    if (document.getElementById('btnadd').value != 'Update') {
                        var str = document.getElementById('hdnRecords').value.split('^');
                        for (var s = 0; s < str.length; s++) {
                            if (str[s] != "") {
                                var eValue = str[s].split('~')[0];
                                if (Type == eValue) {
                                    //alert('Transaction Password Policy Already exists');
                                    ValidationWindow(objvar16, objAlert);
                                    flag = 0;
                                    return false;
                                }
                            }
                        }
                    }
                    else {
                        if (Tflag == "T") {
                            var list = document.getElementById('hdnRecords').value;
                            var x = list.split('^');
                            document.getElementById('hdnRecords').value = "";
                            for (i = 0; i < x.length; i++) {
                                if (x[i] != "") {
                                    if (x[i] != hdnEditedVal1) {
                                        document.getElementById('hdnRecords').value += x[i] + "^";
                                    }
                                }
                            }
                        }
                    }
                }
                if (flag == 1) {
                    document.getElementById('hdnRecords').value += TransType + "~" + transdrppasslen.value + "~" + transdrpsplchar.value + "~" + transdrpnumchar.value + "~" + transddlvlty.options[transddlvlty.options.selectedIndex].value + "~" + transtxtvltypd.value + "~" + transdrpprepass.value + "~" + rowID.value + "^";
                    hdnEditedVal1 = "";
                }
            }
        }
        function getVal() {
            var objvar17 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_10") == null ? "Password Policy Already exists" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_10");

            if (document.getElementById('txtpasswordlength').value != '' && document.getElementById('txtpasswordlength').value != '0') {
                var flag = 1;
                var Type = "L";
                var drppasslen = document.getElementById("txtpasswordlength");
                var chkspl = document.getElementById("Chkspl");
                var drpsplchar = document.getElementById("Txtsplchar");
                var Chknumber = document.getElementById("Chknumber");
                var drpnumchar = document.getElementById("txtnum");
                var chkvltypd = document.getElementById("chkvltypd");
                var ddlvlty = document.getElementById("ddlvlty");
                var txtvltypd = document.getElementById("txtvltypd");
                var chkprepass = document.getElementById("chkprepass");
                var drpprepass = document.getElementById("txtprepwd");
                var rowID = document.getElementById("hdnRowID1");
                if (document.getElementById('hdnRecords').value != "") {
                    if (document.getElementById('btnadd').value != 'Update') {
                        var str = document.getElementById('hdnRecords').value.split('^');
                        for (var s = 0; s < str.length; s++) {
                            if (str[s] != "") {
                                var eValue = str[s].split('~')[0];
                                if (Type == eValue) {
                                    //alert('Password Policy Already exists');
                                    ValidationWindow(objvar17, objAlert);
                                    flag = 0;
                                    return false;
                                }
                            }
                        }
                    }
                    else {
                        if (fflag == "L") {
                            var list = document.getElementById('hdnRecords').value;
                            var x = list.split('^');
                            document.getElementById('hdnRecords').value = "";
                            for (i = 0; i < x.length; i++) {
                                if (x[i] != "") {
                                    if (x[i] != hdnEditedVal) {
                                        document.getElementById('hdnRecords').value += x[i] + "^";
                                    }
                                }
                            }
                        }
                    }
                }
                if (flag == 1) {
                    document.getElementById('hdnRecords').value += Type + "~" + drppasslen.value + "~" + drpsplchar.value + "~" + drpnumchar.value + "~" + ddlvlty.options[ddlvlty.options.selectedIndex].value + "~" + txtvltypd.value + "~" + drpprepass.value + "~" + rowID.value + "^";
                    hdnEditedVal = "";
                }

            }

        }



        function transdropclear() {

            document.getElementById('lblTVP').innerHTML = "";
            document.getElementById('txttransvltypd').value = "";
            if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Days') {
                //                document.getElementById('lblTVP').innerHTML = "Maximum 365 Days";
                document.getElementById('lblTVP').innerHTML = objvar18;
            }
            else if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Weeks') {

                //                document.getElementById('lblTVP').innerHTML = "Maximum 52 Weeks";
                document.getElementById('lblTVP').innerHTML = objvar19;
            }
            else if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Year') {
                //                document.getElementById('lblTVP').innerHTML = "Maximum 1 Year";
                document.getElementById('lblTVP').innerHTML = objvar20;
            }

            else if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Months') {
                // document.getElementById('lblTVP').innerHTML = "Maximum 12 Months";
                document.getElementById('lblTVP').innerHTML = objvar21;
            }


        }

        function dropclear() {

            document.getElementById('lblVP').innerHTML = "";
            document.getElementById('txtvltypd').value = "";
            if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Days') {
                //                document.getElementById('lblVP').innerHTML = "Maximum 365 Days";
                document.getElementById('lblVP').innerHTML = objvar18;
            }
            else if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Weeks') {
                //                document.getElementById('lblVP').innerHTML = "Maximum 52 Weeks";
                document.getElementById('lblVP').innerHTML = objvar19;
            }
            else if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Year') {
                //                document.getElementById('lblVP').innerHTML = "Maximum 1 Year";
                document.getElementById('lblVP').innerHTML = objvar20;

            }
            else if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Months') {
                //                document.getElementById('lblVP').innerHTML = "Maximum 12 Months";
                document.getElementById('lblVP').innerHTML = objvar21;

            }
        }

        function dropvalidation() {
            document.getElementById('lblVP').innerHTML = "";
            if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Days') {
                number = document.getElementById('txtvltypd').value;
                if (number > 365) {

                    document.getElementById('txtvltypd').value = "365";


                }
            }
            else if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Weeks') {
                number = document.getElementById('txtvltypd').value;
                if (number > 52) {

                    document.getElementById('txtvltypd').value = "52";


                }

            }

            else if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Year') {
                number = document.getElementById('txtvltypd').value;
                if (number > 1) {

                    document.getElementById('txtvltypd').value = "1";


                }

            }

            else if (document.getElementById('ddlvlty').options[document.getElementById('ddlvlty').selectedIndex].innerHTML == 'Months') {
                number = document.getElementById('txtvltypd').value;
                if (number > 12) {

                    document.getElementById('txtvltypd').value = "12";


                }
            }
        }

        function Transdropvalidation() {
            document.getElementById('lblTVP').innerHTML = "";
            if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Days') {
                number = document.getElementById('txttransvltypd').value;
                if (number > 365) {

                    document.getElementById('txttransvltypd').value = "365";


                }

            }

            else if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Weeks') {
                number = document.getElementById('txttransvltypd').value;
                if (number > 52) {

                    document.getElementById('txttransvltypd').value = "52";


                }

            }

            else if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Year') {
                number = document.getElementById('txttransvltypd').value;
                if (number > 1) {

                    document.getElementById('txttransvltypd').value = "1";


                }

            }

            else if (document.getElementById('drptransvltypd').options[document.getElementById('drptransvltypd').selectedIndex].innerHTML == 'Months') {
                number = document.getElementById('txttransvltypd').value;
                if (number > 12) {

                    document.getElementById('txttransvltypd').value = "12";


                }
            }
        }

        function txtvalidate() {
            document.getElementById("lbltxtpasslen").innerHTML = '';
            var passlen = document.getElementById("txtpasswordlength");
            var number = passlen.value;
            if (number > 12) {
                document.getElementById("txtpasswordlength").value = 12;
                //                document.getElementById("lbltxtpasslen").innerHTML = "Max Length 12";
                document.getElementById("lbltxtpasslen").innerHTML = objvar22;
            }
            else if (number < 6) {
                document.getElementById("txtpasswordlength").value = 6;
                //document.getElementById("lbltxtpasslen").innerHTML = "Min Length 6";
                document.getElementById("lbltxtpasslen").innerHTML = objvar23;
            }
        }

        function txttransvalidate() {

            document.getElementById("lbltranspasslen").innerHTML = '';
            var transpasslen = document.getElementById("txttranspwdlen");
            var transnumber = transpasslen.value;
            if (transnumber > 12) {
                document.getElementById("txttranspwdlen").value = 12;
                //document.getElementById("lbltranspasslen").innerHTML = "Max Length 12";
                document.getElementById("lbltranspasslen").innerHTML = objvar22;
            }
            else if (transnumber < 6) {
                document.getElementById("txttranspwdlen").value = 6;
                //document.getElementById("lbltranspasslen").innerHTML = "Min Length 6";
                document.getElementById("lbltranspasslen").innerHTML = objvar23;
            }
        }

        function validate() {

            if (document.getElementById('txtpasswordlength').value != '' && document.getElementById('txtpasswordlength').value != '0') {
                //----------------------------------------------------------------------------------------------------
                if (document.getElementById('Chkspl').checked == true) {

                    document.getElementById('tdsplchar').style.display = 'table-cell';

                }
                else {
                    document.getElementById('Txtsplchar').value = '';
                    document.getElementById('tdsplchar').style.display = 'none';
                }
                if (document.getElementById('Chknumber').checked == true) {

                    document.getElementById('tdchknumber').style.display = 'table-cell';

                }
                else {
                    document.getElementById('txtnum').value = '';
                    document.getElementById('tdchknumber').style.display = 'none';

                }
                if (document.getElementById('chkvltypd').checked == true) {

                    document.getElementById('tdvltyprd').style.display = 'table-cell';
                }
                else {
                    document.getElementById('tdvltyprd').style.display = 'none';
                    document.getElementById('ddlvlty').selectedIndex = 0;
                    document.getElementById('txtvltypd').value = '';

                }

                if (document.getElementById('chkprepass').checked == true) {

                    document.getElementById('tdprepass').style.display = 'table-cell';
                }
                else {
                    document.getElementById('tdprepass').style.display = 'none';
                    document.getElementById('txtprepwd').value = '';

                }
            }
            else {
                var objPassword = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_25") == null ? "Enter Password Length" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_25");

                ValidationWindow(objPassword, objAlert);

                //alert('Enter Password Length');
                document.getElementById('txtpasswordlength').value = '';
                document.getElementById('txtpasswordlength').focus();
                document.getElementById('Chkspl').checked = false;
                document.getElementById('Chknumber').checked = false;
                document.getElementById('chkvltypd').checked = false;
                document.getElementById('chkprepass').checked = false;


            }

            //----------------------------------------------------------------------------------------------------

        }

        function validate1() {
            if (document.getElementById('txttranspwdlen').value != '' && document.getElementById('txttranspwdlen').value != '0') {

                if (document.getElementById('Chktransspl').checked == true) {

                    document.getElementById('tdtransspl').style.display = 'table-cell';

                }
                else {
                    document.getElementById('txttransspl').value = '';
                    document.getElementById('tdtransspl').style.display = 'none';
                }
                if (document.getElementById('Chktransnum').checked == true) {

                    document.getElementById('tdtransnum').style.display = 'table-cell';

                }
                else {
                    document.getElementById('txttransnum').value = '';
                    document.getElementById('tdtransnum').style.display = 'none';

                }
                if (document.getElementById('chktransvltypd').checked == true) {

                    document.getElementById('tdtransvltypd').style.display = 'table-cell';
                }
                else {

                    document.getElementById('drptransvltypd').selectedIndex = 0;
                    document.getElementById('txttransvltypd').value = '';
                    document.getElementById('tdtransvltypd').style.display = 'none';

                }

                if (document.getElementById('chktransprepass').checked == true) {

                    document.getElementById('tdtransprepass').style.display = 'table-cell';
                }
                else {
                    document.getElementById('txttransprepwd').value = '';
                    document.getElementById('tdtransprepass').style.display = 'none';

                }
            }
            else {
                var objvar24 = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_11") == null ? "Select Transaction Password Length" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_11");

                //alert('Select Transaction Password Length');
                ValidationWindow(objvar24, objAlert);
                document.getElementById('txttranspwdlen').value = '';
                document.getElementById('txttranspwdlen').focus();
                document.getElementById('Chktransspl').checked = false;
                document.getElementById('Chktransnum').checked = false;
                document.getElementById('chktransvltypd').checked = false;
                document.getElementById('chktransprepass').checked = false;
            }

        }


        function getElementWidth(objectId) {
            x = document.getElementById(objectId);
            return x.offsetWidth;
        }
        function getAbsoluteLeft(objectId) {
            // Get an object left position from the upper left viewport corner
            o = document.getElementById(objectId)
            oLeft = o.offsetLeft            // Get left position from the parent object
            while (o.offsetParent != null) {   // Parse the parent hierarchy up to the document element
                oParent = o.offsetParent    // Get parent object reference
                oLeft += oParent.offsetLeft // Add parent left position
                o = oParent
            }
            return oLeft
        }

        function getAbsoluteTop(objectId) {
            // Get an object top position from the upper left viewport corner
            o = document.getElementById(objectId)
            oTop = o.offsetTop            // Get top position from the parent object
            while (o.offsetParent != null) { // Parse the parent hierarchy up to the document element
                oParent = o.offsetParent  // Get parent object reference
                oTop += oParent.offsetTop // Add parent top position
                o = oParent
            }
            return oTop
        }
        function showPopup(linkId) {
            var arrowOffset = getElementWidth(linkId) + 11;
            var clickElementx = getAbsoluteLeft(linkId) + arrowOffset; //set x position
            var clickElementy = getAbsoluteTop(linkId) - 3; //set y position
            $('#divLpwdHint').css({ left: clickElementx + "px", top: clickElementy + "px" });
            var pParentProIDs = document.getElementById('hdnRecords').value.split("^");
            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var test = pParentProIDs[j].split('~');

                    if (test[0] == "L" && test[0] != "") {
                        $('#divLpwdHint').show();
                    }

                }
                else {
                    $('#divLpwdHint').show();
                }
            }

        }

        function showTPopup(linkId) {
            var arrowOffset = getElementWidth(linkId) + 11;
            var clickElementx = getAbsoluteLeft(linkId) + arrowOffset; //set x position
            var clickElementy = getAbsoluteTop(linkId) - 3; //set y position
            $('#divTpwdHint').css({ left: clickElementx + "px", top: clickElementy + "px" });

            var pParentProIDs = document.getElementById('hdnRecords').value.split("^");
            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var test = pParentProIDs[j].split('~');

                    if (test[0] == "T" && test[0] != "") {
                        $('#divTpwdHint').show();
                    }

                }

                else {
                    $('#divTpwdHint').show();
                }
            }



        }
        
        
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="w-100p searchPanel">
                            <tr>
                                <td>
                               
                                <div id="TabsMenu" class="TabsMenu">
                                    <ul id="ulTabsMenu">
                                        <li id="tabPasswordPolicy" onclick="ShowTabContent('tabPasswordPolicy','tabContentPasswordPolicy')"
                                            class="active"><a href="#">
                                    <asp:Label ID="lblPasswordPolicy" runat="server" Text="Password Policy" meta:resourcekey="lblPasswordPolicyResource1" /></a></li>
                                        <li id="tabPrintPolicy" onclick="ShowTabContent('tabPrintPolicy', 'tabContentPrintPolicy')">
                                            <a href="#">
                                    <asp:Label ID="lblPrintPolicy" runat="server" Text="Print Policy" meta:resourcekey="lblPrintPolicyResource1" /></a></li>
                                    </ul>
                                </div>
                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:UpdateProgress ID="Progressbar" runat="server">
                                            <ProgressTemplate>
                                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                        <div id="tabContentPasswordPolicy" style="display: none;">
                                            <table class="w-100p" style="display:inline-table">
                                                <tr>
                                                    <td>
                                                        <div id="DivLpwd" runat="server" style="display: none; background-image: url(../Images/whitebg.png);
                                                            width: 500px">
                                                            <table class="w-100p a-center">
                                                                <tr>
                                                                    <td colspan="3" class="a-center">
                                                                        <strong>
                                                                            <br />
                                                                <asp:Label ID="lblMsg" Text="Login Password" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
                                                                        </strong>
                                                                    </td>
                                                                    <td colspan="1" class="a-right">
                                        <a href="#" class="jTip" id="one" name="Password must follow these rules:" onmouseover="showPopup(this.id);"
                                                    onmouseout="$('#divLpwdHint').hide();">
                                                    <asp:Label ID="lblHint" runat="server" Text="Hint" ForeColor="Red" 
                                                Font-Bold="True" meta:resourcekey="lblHintResource2"></asp:Label></a>
                                                    </td>
                                                                    
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left w-20p h-35" nowrap="nowrap">
                                                                        &nbsp;<asp:Label ID="lblpl" runat="server" Text="Password Length" meta:resourcekey="lbltranspasslengthResource1"></asp:Label>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        &nbsp;<asp:TextBox ID="txtpasswordlength" runat="server" onchange="txtvalidate()"
                                                                Width="30px" MaxLength="2" meta:resourcekey="txtpasswordlengthResource1"></asp:TextBox>
                                                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtpasswordlength"
                                                                FilterType="Numbers" Enabled="True">
                                                                        </cc1:FilteredTextBoxExtender>
                                                            <asp:Label ID="lblno1" runat="server" Text="(Nos)" meta:resourcekey="lblno1Resource1"></asp:Label>
                                                            &nbsp;<asp:Label ID="lbltxtpasslen" runat="server" ForeColor="Red" meta:resourcekey="lbltxtpasslenResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left w-20p h-35" nowrap="nowrap">
                                                            <asp:Label ID="lblaspch" runat="server" Text="Allow Special Character" meta:resourcekey="lblaspchResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-20p h-35" nowrap="nowrap">
                                                            <asp:CheckBox ID="Chkspl" runat="server" Text="YES" onclick="validate()" TabIndex="1"
                                                                meta:resourcekey="ChksplResource1" />
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="tdsplchar" runat="server" style="display: none">
                                                                        <asp:TextBox ID="Txtsplchar" runat="server" MaxLength="2" Width="30px" TabIndex="2"
                                                                onchange="checklength();" meta:resourcekey="TxtsplcharResource1"></asp:TextBox>
                                                                        <cc1:FilteredTextBoxExtender ID="Numbers" runat="server" TargetControlID="Txtsplchar"
                                                                FilterType="Numbers" Enabled="True">
                                                                        </cc1:FilteredTextBoxExtender>
                                                            <asp:Label ID="lblno2" runat="server" Text="(Nos)" meta:resourcekey="lblno2Resource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td  class="a-left w-20p h-35" nowrap="nowrap">
                                                            <asp:Label ID="lblnumchar" runat="server" Text="Allow Number Character" meta:resourcekey="lblnumcharResource1"></asp:Label>
                                                                    </td>
                                                                    <td  class="w-20p h-35" nowrap="nowrap">
                                                            <asp:CheckBox ID="Chknumber" runat="server" Text="YES" onclick="validate()" TabIndex="3"
                                                                meta:resourcekey="ChknumberResource1" />
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="tdchknumber" runat="server" style="display: none">
                                                            <asp:TextBox ID="txtnum" runat="server" TabIndex="4" MaxLength="2" Width="30px" onchange="return checklength1()"
                                                                meta:resourcekey="txtnumResource1"></asp:TextBox>
                                                                        <cc1:FilteredTextBoxExtender ID="Numbers1" runat="server" TargetControlID="txtnum"
                                                                FilterType="Numbers" Enabled="True">
                                                                        </cc1:FilteredTextBoxExtender>
                                                            <asp:Label ID="lblno3" runat="server" Text="(Nos)" meta:resourcekey="lblno3Resource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left w-20p h-35" nowrap="nowrap">
                                                            <asp:Label ID="lblvldtypd" runat="server" Text="Validity Period" meta:resourcekey="lblvldtypdResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-20p h-35" nowrap="nowrap">
                                                            <asp:CheckBox ID="chkvltypd" runat="server" Text="YES" onclick="validate()" TabIndex="5"
                                                                meta:resourcekey="chkvltypdResource1" />
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="tdvltyprd" runat="server" style="display: none">
                                                                        <asp:DropDownList ID="ddlvlty" runat="server" onchange="dropclear()" TabIndex="6">
                                                                <%--<asp:ListItem Value="" meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource2">Days</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource3">Weeks</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource4">Months</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource5">Year</asp:ListItem>--%>
                                                                        </asp:DropDownList>
                                                                        &nbsp;
                                                                        <asp:TextBox ID="txtvltypd" runat="server" MaxLength="3" Width="30px" onchange="dropvalidation()"
                                                                TabIndex="7" meta:resourcekey="txtvltypdResource1"></asp:TextBox>
                                                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtvltypd"
                                                                FilterType="Numbers" Enabled="True">
                                                                        </cc1:FilteredTextBoxExtender>
                                                                        &nbsp;
                                                            <asp:Label ID="lblVP" runat="server" ForeColor="Red" meta:resourcekey="lblVPResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                            <asp:Label ID="lblPrepass" runat="server" Text="Don't Allow Previous Passwords "
                                                                meta:resourcekey="lblPrepassResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-20p h-35" nowrap="nowrap">
                                                            <asp:CheckBox ID="chkprepass" runat="server" Text="YES" onclick="validate()" TabIndex="8"
                                                                meta:resourcekey="chkprepassResource1" />
                                                                    </td>
                                                                    <td id="tdprepass" runat="server" style="display: none">
                                                            <asp:TextBox ID="txtprepwd" runat="server" MaxLength="2" Width="30px" TabIndex="9"
                                                                meta:resourcekey="txtprepwdResource1"></asp:TextBox>
                                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" TargetControlID="txtprepwd"
                                                                FilterType="Numbers" Enabled="True">
                                                                        </cc1:FilteredTextBoxExtender>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3" class="a-center" id="tdbtnadd" runat="server" style="display: none">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" height="15px" class="h-15 a-left">
                                                                       <%-- <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                                  <div>
                                    <div id='divLpwdHint' style='width: 300px; height: 150px; display: none;'>
                                        <div id='divLpwdHint_arrow_left'>
                                        </div>
                                        <div id='divLpwdHint_close_left'>
                                            <asp:Label ID="lblRules" runat="server" 
                                                Text="Password must follow these rules:" meta:resourcekey="lblRulesResource2"></asp:Label>
                                        </div>
                                        <div id='divLpwdHint_copy'>
                                            <strong>
                                                <asp:Label ID="lblMinimumPasswordLength2" runat="server" 
                                                Text=" 1)  Minimum Password Length - 6" 
                                                meta:resourcekey="lblMinimumPasswordLength2Resource1"></asp:Label>
                                           
                                            <br />
                                            <br />
                                            <asp:Label ID="lblMaximumPasswordLength2" runat="server" 
                                                Text="2) Maximum Password Length -" 
                                                meta:resourcekey="lblMaximumPasswordLength2Resource1"></asp:Label>
                                                            <asp:Label ID="lblLpwdHintLenth" runat="server" Text="12" meta:resourcekey="lblLpwdHintLenthResource2"></asp:Label>
                                                <br />
                                                <br />
                                                
                                                <asp:Label ID="lblNumberCharacterLength" runat="server" Text="3) Number Character Length -" meta:resourcekey="lblNumberCharacterLengthResource1"></asp:Label>
                                                                                  
                                                <asp:Label ID="lblLpwdHintnumchar" runat="server" Text="1" 
                                                meta:resourcekey="lblLpwdHintnumcharResource2"></asp:Label>
                                                <br />
                                                <br />
                                                <asp:Label ID="lblSpecialCharacterLength2" runat="server" 
                                                Text="4) Special Character Length -" 
                                                meta:resourcekey="lblSpecialCharacterLength2Resource1"></asp:Label>
                                                
                                                <asp:Label ID="lblLpwdHintsplchar" runat="server" Text="1" 
                                                meta:resourcekey="lblLpwdHintsplcharResource2"></asp:Label>
                                                <asp:Label ID="lbletc" runat="server" Text="(@, %, etc)" 
                                                meta:resourcekey="lbletcResource1"></asp:Label>
                                                 
                                                
                                                
                                                </strong>
                                        </div>
                                    </div>
                                </div>
                                                    </td>
                                                    <td>
                                                        <div id="DivTpwd" runat="server" style="display: none; background-image: url(../Images/whitebg.png);
                                                            width: 500px">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td colspan="3" class="a-center">
                                                                        <strong>
                                                                            <br />
                                                                <asp:Label ID="lbltranspwd" Text="Transaction Password" runat="server" meta:resourcekey="lbltranspwdResource1"></asp:Label>
                                                                        </strong>
                                                                    </td>
                                                                    <td colspan="3" class="a-right">
                                                 <a href="#" class="jTip" id="two" name="Transaction Password must follow these rules:"
                                                    onmouseover="showTPopup(this.id);" onmouseout="$('#divTpwdHint').hide();">
                                                    <asp:Label ID="lblTpp" runat="server" Text="Hint" ForeColor="Red" 
                                                     Font-Bold="True" meta:resourcekey="lblTppResource2"></asp:Label></a> 
                                            </td>
                                                                </tr>
                                                                <tr>
                                                                    <td  class="a-left w-20p h-35" nowrap="nowrap">
                                                            &nbsp;<asp:Label ID="lbltranspasslength" runat="server" Text="Password Length" meta:resourcekey="lbltranspasslengthResource1"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:TextBox ID="txttranspwdlen" runat="server" onchange="txttransvalidate()" TabIndex="10"
                                                                Width="30px" MaxLength="2" meta:resourcekey="txttranspwdlenResource1"></asp:TextBox>
                                                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txttranspwdlen"
                                                                FilterType="Numbers" Enabled="True">
                                                                        </cc1:FilteredTextBoxExtender>
                                                            <asp:Label ID="lblno5" runat="server" Text="(Nos)" meta:resourcekey="lblno5Resource1"></asp:Label>
                                                                        &nbsp;
                                                            <asp:Label ID="lbltranspasslen" runat="server" ForeColor="Red" meta:resourcekey="lbltranspasslenResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left w-20p h-35" nowrap="nowrap">
                                                            <asp:Label ID="lbltransspchar" runat="server" Text="Allow Special Character" meta:resourcekey="lbltransspcharResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-20p h-35" nowrap="nowrap">
                                                            <asp:CheckBox ID="Chktransspl" runat="server" Text="YES" onclick="validate1()" TabIndex="11"
                                                                meta:resourcekey="ChktranssplResource1" />
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="display: none" id="tdtransspl" runat="server">
                                                                        <asp:TextBox ID="txttransspl" runat="server" MaxLength="2" Width="30px" TabIndex="12"
                                                                onchange="transchecklength();" meta:resourcekey="txttranssplResource1"></asp:TextBox>
                                                            <asp:Label ID="lblno6" runat="server" Text="(Nos)" meta:resourcekey="lblno6Resource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left w-20p h-35" nowrap="nowrap">
                                                            <asp:Label ID="lbltransnumchar" runat="server" Text="Allow Number Character" meta:resourcekey="lbltransnumcharResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-20p h-35" nowrap="nowrap">
                                                            <asp:CheckBox ID="Chktransnum" runat="server" Text="YES" onclick="validate1()" TabIndex="13"
                                                                meta:resourcekey="ChktransnumResource1" />
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="display: none" id="tdtransnum" runat="server">
                                                            <asp:TextBox ID="txttransnum" runat="server" TabIndex="14" MaxLength="2" Width="30px"
                                                                onchange="transchecklength1();" meta:resourcekey="txttransnumResource1"></asp:TextBox>
                                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txttransnum"
                                                                FilterType="Numbers" Enabled="True">
                                                            </cc1:FilteredTextBoxExtender>
                                                            <asp:Label ID="lblno7" runat="server" Text="(Nos)" meta:resourcekey="lblno7Resource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left w-20p h-35" nowrap="nowrap">
                                                            <asp:Label ID="lblTransvpass" runat="server" Text="Validity Period" meta:resourcekey="lblTransvpassResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-20p h-35" nowrap="nowrap">
                                                            <asp:CheckBox ID="chktransvltypd" runat="server" Text="YES" onclick="validate1()"
                                                                TabIndex="15" meta:resourcekey="chktransvltypdResource1" />
                                                                    </td>
                                                                    <td style="display: none" id="tdtransvltypd" runat="server">
                                                            <asp:DropDownList ID="drptransvltypd" runat="server" onchange="transdropclear()"
                                                                TabIndex="16" meta:resourcekey="drptransvltypdResource1">
                                                                <%--<asp:ListItem Value="" meta:resourcekey="ListItemResource6">Select</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource7">Days</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource8">Weeks</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource9">Months</asp:ListItem>
                                                                <asp:ListItem meta:resourcekey="ListItemResource10">Year</asp:ListItem>--%>
                                                            </asp:DropDownList>
                                                                        &nbsp;
                                                            <asp:TextBox ID="txttransvltypd" runat="server" MaxLength="3" Width="30px" onchange="Transdropvalidation()"
                                                                TabIndex="17" meta:resourcekey="txttransvltypdResource1"></asp:TextBox>
                                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" TargetControlID="txttransvltypd"
                                                                FilterType="Numbers" Enabled="True">
                                                            </cc1:FilteredTextBoxExtender>
                                                                        &nbsp;
                                                                        <asp:Label ID="lblTVP" runat="server" ForeColor="Red"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                            <asp:Label ID="lbltransdappass" runat="server" Text="Don't Allow Previous Passwords"
                                                                meta:resourcekey="lbltransdappassResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                            <asp:CheckBox ID="chktransprepass" runat="server" Text="YES" onclick="validate1()"
                                                                TabIndex="18" meta:resourcekey="chktransprepassResource1" />
                                                                    </td>
                                                        <td id="tdtransprepass" runat="server" style="display: none">
                                                            <asp:TextBox ID="txttransprepwd" runat="server" MaxLength="2" Width="30px" TabIndex="19"
                                                                meta:resourcekey="txttransprepwdResource1"></asp:TextBox>
                                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server" TargetControlID="txttransprepwd"
                                                                FilterType="Numbers" Enabled="True">
                                                            </cc1:FilteredTextBoxExtender>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3" class="a-center" id="tdsaveall" runat="server" style="display: none">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" height="15px" class="a-left">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                         <div id='divTpwdHint' style='width: 450px; display: none;'>
                                        <div id='divTpwdHint_arrow_left'>
                                        </div>
                                        <div id='divTpwdHint_close_left'>
                                            <asp:Label ID="lblTRules" runat="server" 
                                                Text="Transaction Password must follow these rules:" 
                                                meta:resourcekey="lblTRulesResource2"></asp:Label>
                                        </div>
                                        <div id='divTpwdHint_copy'>
                                            <strong>
                                            
                                            <asp:Label ID="lblMinimumPasswordLength1" runat="server" 
                                                Text="1)  Minimum Password Length - 6" 
                                                meta:resourcekey="lblMinimumPasswordLength1Resource1"></asp:Label>
                                            
                                              
                                            <br />
                                            <br />
                                            
                                            <asp:Label ID="lblMaximumPasswordLength1" runat="server" 
                                                Text=" 2) Maximum Password Length -" 
                                                meta:resourcekey="lblMaximumPasswordLength1Resource1"></asp:Label>
                                            
                                          
                                                <asp:Label ID="lblTpwdHintLenth" runat="server" Text="12" 
                                                meta:resourcekey="lblTpwdHintLenthResource2"></asp:Label>
                                                <br />
                                                <br />
                                                <asp:Label ID="lblSpecialCharacter1" runat="server" 
                                                Text="3) Special Character Length -" 
                                                meta:resourcekey="lblSpecialCharacter1Resource1"></asp:Label>
                                                <asp:Label ID="lblTpwdHintsplchar" runat="server" Text="1" 
                                                meta:resourcekey="lblTpwdHintsplcharResource2"></asp:Label>
                                                
                                                <asp:Label ID="lbletc1" runat="server" Text="(@, %, etc)" 
                                                meta:resourcekey="lbletc1Resource1"></asp:Label>
                                                
                                                
                                                <br />
                                                <br />
                                                
                                                <asp:Label ID="lblNumberCharacter1" runat="server" 
                                                Text=" 4) Number Character Length - " 
                                                meta:resourcekey="lblNumberCharacter1Resource1"></asp:Label>
                                               
                                                
                                                <asp:Label ID="lblTpwdHintnumchar" runat="server" Text="1" 
                                                meta:resourcekey="lblTpwdHintnumcharResource2"></asp:Label>
                                            </strong>
                                        </div>
                                    </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div class="a-center">
                                    <asp:Button ID="btnadd" runat="server" Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" Text="ADD" TabIndex="20" OnClientClick="Javascript:CheckToAssign();return false"
                                        meta:resourcekey="btnaddResource1" />
                                    &nbsp;<asp:Button ID="btnsaveall" runat="server" CssClass="btn" TabIndex="21" Text="SAVE"
                                        OnClick="btnsaveall_Click" meta:resourcekey="btnsaveallResource1" />
                                                &nbsp;<asp:Button ID="btnclose" runat="server" CssClass="btn" OnClick="btnclose_Click"
                                        Text="CANCEL" TabIndex="22" meta:resourcekey="btncloseResource1" />
                                            </div>
                                            <div class="a-center">
                                                <br />
                                                <br />
                                                <br />
                                                <br />
                                                <asp:Table ID="tblPasswordPolicy" runat="server" class="dataheaderInvCtrl w-80p a-center b-grey"
                                        Style="display: table; padding-left: 60;" TabIndex="23" meta:resourcekey="tblPasswordPolicyResource1">
                                                </asp:Table>
                                            </div>
                                            <asp:HiddenField ID="hdnConfigid" runat="server" Value="false" />
                                            <asp:HiddenField ID="hdnRowID" Value="-1" runat="server" />
                                            <asp:HiddenField ID="hdnRowID1" Value="0" runat="server" />
                                            <asp:HiddenField ID="hdnRowID2" Value="0" runat="server" />
                                <asp:HiddenField ID="hdnRecords" runat="server" />
                                <asp:HiddenField ID="hdnType" runat="server" />
                                  <asp:HiddenField ID="hdnmessages" runat="server" />
                                        </div>
                                        <div id="tabContentPrintPolicy" style="display: none;">
                                            <table class="w-100p bg-row b-tab" style="display:inline-table">
                                                <tr>
                                                    <td class="a-right">
                                            <asp:Label ID="lblCategory" runat="server" Text="Select Category" meta:resourcekey="lblCategoryResource1" />
                                                    </td>
                                                    <td>
                                                        <span class="richcombobox" style="width: 150px;">
                                                            <asp:DropDownList CssClass="ddl" ID="ddlCategory" Width="150px" runat="server" ToolTip="Select Category"
                                                                meta:resourcekey="ddlCategoryResource1">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                    <td class="a-right">
                                            <asp:Label ID="lblRoleName" runat="server" Text="Select Role" meta:resourcekey="lblRoleNameResource1" />
                                                    </td>
                                                    <td>
                                                        <span class="richcombobox" style="width: 150px;">
                                                            <asp:DropDownList CssClass="ddl" ID="ddlRole1" Width="150px" runat="server" ToolTip="Select Role"
                                                                meta:resourcekey="ddlRoleResource1">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                    <td class="a-right">
                                            <asp:Label ID="lblLocation" runat="server" Text="Select Location" meta:resourcekey="lblLocationResource1" />
                                                    </td>
                                                    <td>
                                                        <span class="richcombobox" style="width: 150px;">
                                                            <asp:DropDownList CssClass="ddl" ID="ddlLocation" Width="150px" runat="server" ToolTip="Select Location"
                                                                meta:resourcekey="ddlLocationResource1">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right" colspan="3">
                                            <asp:Label ID="lblValue" runat="server" Text="Value" meta:resourcekey="lblValueResource1" />
                                                    </td>
                                                    <td>
                                            <asp:TextBox ID="txtValue" runat="server" Width="150px" meta:resourcekey="txtValueResource1" />
                                                    </td>
                                                    <td>
                                            <asp:TextBox ID="txtId" runat="server" Text="0" Width="150px" Style="display: none;"
                                                meta:resourcekey="txtIdResource1" />
                                                    </td>
                                                    <td class="a-left">
                                            <asp:CheckBox ID="chkActive" runat="server" Text="Active" Checked="True" meta:resourcekey="chkActiveResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" class="a-center">
                                            <asp:Button ID="btnSavePrintPolicy" runat="server" Text="&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                OnClientClick="return onSavePrintPolicy();" meta:resourcekey="btnSavePrintPolicyResource1" />
                                            <asp:Button ID="btnResetPrintPolicy" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="return onPrintPolicyReset();"
                                                meta:resourcekey="btnResetPrintPolicyResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <div class="dataheaderInvCtrl">
                                                <table id="tblPrintPolicy" class="w-100p">
                                                    <thead>
                                                        <tr class="Duecolor h-17">
                                                            <th>
                                                                <asp:Label runat="server" ID="lblHeaderCategory" Text="Category" meta:resourcekey="lblCategoryResource1" />
                                                            </th>
                                                            <th>
                                                                <asp:Label runat="server" ID="lblHeaderRole" Text="Role" meta:resourcekey="lblRoleResource1" />
                                                            </th>
                                                            <th>
                                                                <asp:Label runat="server" ID="lblHeaderLocation" Text="Location" meta:resourcekey="lblLocationResource1" />
                                                            </th>
                                                            <th>
                                                                <asp:Label runat="server" ID="lblHeaderValue" Text="Value" meta:resourcekey="lblValueResource1" />
                                                            </th>
                                                            <th>
                                                                <asp:Label runat="server" ID="lblHeaderActive" Text="Active" meta:resourcekey="lblValueResource1" />
                                                            </th>
                                                            <th class="a-center">
                                                                &nbsp;
                                                            </th>
                                                            <th class="a-center">
                                                                &nbsp;
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Repeater ID="rptPrintPolicy" runat="server">
                                                            <ItemTemplate>
                                                                <tr class="h-17">
                                                                    <td class="a-left">
                                                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("ID") %>' Style="display: none;"
                                                                meta:resourcekey="lblIdResource1"></asp:Label>
                                                            <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("Type") %>' meta:resourcekey="lblCategoryResource2"></asp:Label>
                                                                    </td>
                                                                    <td class="a-left">
                                                            <asp:Label ID="lblRole" runat="server" Text='<%# Eval("RoleName") %>' meta:resourcekey="lblRoleResource2"></asp:Label>
                                                                    </td>
                                                                    <td class="a-left">
                                                            <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("LocationName").ToString()== "0" ? "" : Eval("LocationName").ToString() %>'
                                                                meta:resourcekey="lblLocationResource2"></asp:Label>
                                                                    </td>
                                                                    <td class="a-left">
                                                            <asp:Label ID="lblValue" runat="server" Text='<%# Eval("Value") %>' meta:resourcekey="lblValueResource2"></asp:Label>
                                                                    </td>
                                                                    <td class="a-left">
                                                            <asp:Label ID="lblActive" runat="server" Text='<%# Eval("IsActive").ToString()== "True" ? "Yes" : "No" %>'
                                                                meta:resourcekey="lblActiveResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-center">
                                                            <a href="#" style="color: Blue;" onclick="onPrintPolicyEdit(this)"><%=Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_26%></a>
                                                                    </td>
                                                                    <td class="a-center">
                                                            <a href="#" style="color: Blue;" onclick="onPrintPolicyDelete(this)"><%=Resources.Admin_ClientDisplay.Admin_PasswordPolicy_aspx_27%></a>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <input id="hdnLoginID" type="hidden" value="0" runat="server" />
                                            <input id="hdnOrgID" type="hidden" value="0" runat="server" />
                                            <input id="hdnSelectedRowIndex" type="hidden" value="0" runat="server" />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                         </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />       
        <input id="hdnSelectedDiv" type="hidden" runat="server" value="tabContentPasswordPolicy" />
    </form>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function() {
    var objAlert = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_Alert");
        $('body').append('<div id="ajaxBusy"><p><img src="../Images/working.gif">Please Wait...</p></div>');

        $('#ajaxBusy').css({
            display: "none",
            margin: "0px",
            paddingLeft: "0px",
            paddingRight: "0px",
            paddingTop: "0px",
            paddingBottom: "0px",
            position: "absolute",
            right: "3px",
            top: "150px",
            width: "auto"
        });
    });
    $(document).ajaxStart(function() {
        $('#ajaxBusy').show();
    }).ajaxStop(function() {
        $('#ajaxBusy').hide();
    });
    $(function() {
        $('[id^="tabContent"]').hide();
        $('#tabPasswordPolicy').addClass('active');
        $('#tabContentPasswordPolicy').show();
        $('#txtId').val('0');
        ChangeDDLItemListWidth();
        $('#ddlRole1').change(function() {
            loadLocation('');
        });
    });
    function onSavePrintPolicy() {
        var isError = false;
        var selectedCategory = $("#ddlCategory option:selected");
        var selectedRole = $("#ddlRole1 option:selected");
        var selectedLocation = $("#ddlLocation option:selected");
        var txtValue = $("#txtValue").val();
        var isActive = $("#chkActive").is(":checked");
        var active = false;
        var role = '';
        var location = '';
        if (isActive) {
            active = isActive;
        }
        if ($(selectedCategory).val() == '0') {
            var objSelCate = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_22") == null ? "Select category" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_22");
            // alert("Select category");
            ValidationWindow(objSelCate, objAlert);
            isError = true;
            return false;
        }
        if (txtValue == '') {
            // alert("Enter value");
            var objEnterVal = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_23") == null ? "Enter value" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_23");
            ValidationWindow(objEnterVal, objAlert);
            isError = true;
            return false;
        }
        if ($(selectedRole).val() != '0') {
            role = $(selectedRole).text();
        }
        if ($(selectedLocation).val() != '0') {
            location = $(selectedLocation).text();
        }
        $("#tblPrintPolicy tbody tr").each(function(i, n) {
        var objDuplicate = SListForAppMsg.Get("Admin_PasswordPolicy_aspx_24") == null ? "Duplicate entry found" : SListForAppMsg.Get("Admin_PasswordPolicy_aspx_24");
            var $row = $(n);
            var lblId = $row.find("span[id$='lblId']").html();
            if ($('#txtId').val() != lblId) {
                var lblCategory = $row.find("span[id$='lblCategory']").html();
                var lblRole = $row.find("span[id$='lblRole']").html();
                var lblLocation = $row.find("span[id$='lblLocation']").html();
                if ($(selectedCategory).text() == lblCategory && role == lblRole && location == lblLocation) {
                    //alert("Duplicate entry found");
                    ValidationWindow(objDuplicate, objAlert);
                    isError = true;
                    return false;
                }
            }
        });
        if (!isError) {
            var oPrintPolicy = {
                ID: $('#txtId').val(),
                OrgID: $('#hdnOrgID').val(),
                OrgAddressID: $(selectedLocation).val(),
                RoleID: $(selectedRole).val(),
                Type: $(selectedCategory).val(),
                Value: txtValue,
                IsActive: active,
                CreatedBy: $('#hdnLoginID').val()
            };
            $.ajax({
                type: "POST",
                url: "PasswordPolicy.aspx/SavePrintPolicy",
                data: "{PrintPolicy: '" + JSON.stringify(oPrintPolicy) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    var result = data.d;
                    if (result.Value.indexOf("success") >= 0) {
                        var row$;
                        var IsActiveChec;
                        if (active == true) 
                        {
                            IsActiveChec = "Yes";
                        }
                        else 
                        {
                            IsActiveChec = "No";
                        }
                        if ($('#txtId').val() == '0') {
                            row$ = $('<tr/>');
                            var tdCategory = $('<td/>').html('<span id="lblId" style="display:none;">' + result.ParentID + '</span><span id="lblCategory">' + $(selectedCategory).text() + '</span>');
                            var tdRole = $('<td/>').html('<span id="lblRole">' + role + '</span>');
                            var tdLocation = $('<td/>').html('<span id="lblLocation">' + location + '</span>');
                            var tdValue = $('<td align="right"/>').html('<span id="lblValue">' + txtValue + '</span>');
                            var tdActive = $('<td/>').html('<span id="lblActive">' + IsActiveChec + '</span>');
                            var tdEdit = $('<td align="center"/>').html('<a href="#" style="color: Blue;" onclick="onPrintPolicyEdit(this)">Edit</a>');
                            var tdDelete = $('<td align="center"/>').html('<a href="#" style="color: Blue;" onclick="onPrintPolicyDelete(this)">Delete</a>');
                            row$.append(tdCategory).append(tdRole).append(tdLocation).append(tdValue).append(tdActive).append(tdEdit).append(tdDelete);
                            $("#tblPrintPolicy tbody").append(row$);
                        }
                        else {
                            row$ = $("#tblPrintPolicy tbody tr:eq(" + $("#hdnSelectedRowIndex").val() + ")");
                            row$.find("span[id$='lblCategory']").html($(selectedCategory).text());
                            row$.find("span[id$='lblRole']").html(role);
                            row$.find("span[id$='lblLocation']").html(location);
                            row$.find("span[id$='lblValue']").html(txtValue);
                            row$.find("span[id$='lblActive']").html(IsActiveChec);
                        }
                        onPrintPolicyReset();
                    }
                    // alert(result.Value);
                    ValidationWindow(result.Value, objAlert);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                // alert(xhr.status);
                ValidationWindow(xhr.status, objAlert);
                }

            });
        }
        return false;
    }
    function loadLocation(locationName) {
        $("#ddlLocation").children('option:not(:first)').remove();
        var selectedRole = $("#ddlRole1 option:selected");
        if ($(selectedRole).val() != '0') {
            $.ajax({
                type: "POST",
                url: "PasswordPolicy.aspx/GetLocation",
                data: "{OrgID: " + $('#hdnOrgID').val() + ",LoginID: " + $('#hdnLoginID').val() + ",RoleID: " + $(selectedRole).val() + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    var lstLocation = data.d;
                    if (lstLocation.length > 0) {
                        for (var i = 0; i < lstLocation.length; i++) {
                            if (locationName != lstLocation[i].Location) {
                                $("#ddlLocation").append($("<option></option>").val(lstLocation[i].AddressID).html(lstLocation[i].Location));
                            }
                            else {
                                $("#ddlLocation").append($("<option selected='selected'></option>").val(lstLocation[i].AddressID).html(lstLocation[i].Location));
                            }
                        }
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                // alert(xhr.status);
                ValidationWindow(xhr.status, objAlert);
                }
            });
        }
    }
    function onPrintPolicyEdit(obj) {
        var Usrupdate = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_24") != null ? SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_24") : "Update";
        var Usrcancel= SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_25") != null ? SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_25") : "Cancel";
        var $row = $(obj).closest('tr');
        var rowIndex = $row.index();
        $('#txtId').val($row.find("span[id$='lblId']").html());
        $('#ddlCategory option').filter(function() { return $.trim($(this).text()) == $row.find("span[id$='lblCategory']").html(); }).prop('selected', true);
        $('#ddlRole1 option').filter(function() { return $.trim($(this).text()) == $row.find("span[id$='lblRole']").html(); }).prop('selected', true);
        loadLocation($row.find("span[id$='lblLocation']").html());
        $("#txtValue").val($row.find("span[id$='lblValue']").html());
        if ($row.find("span[id$='lblActive']").html() == "Yes") {
            //$('input[id$="chkActive"]').prop('checked', true);
            $("#chkActive").prop("checked", true);
        }
        else {
            //$('input[id$="chkActive"]').prop('checked', false);
            $("#chkActive").prop("checked", false);
        }
        $('#btnSavePrintPolicy').val(Usrupdate);
        $('#btnResetPrintPolicy').val(Usrcancel);
        $("#hdnSelectedRowIndex").val(rowIndex);
    }
    function onPrintPolicyReset() {
        var Usradd = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_22") != null ? SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_22") : "Save";
        var Usrreset = SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_23") != null ? SListForAppDisplay.Get("Admin_PasswordPolicy_aspx_23") : "Reset";
        $('#txtId').val('0');
        //$("#ddlCategory option:first").attr('selected', true);
        $("#ddlCategory").val($("#ddlCategory option:first").val());
        // $("#ddlRole1 option:first").attr('selected', true);
        $("#ddlRole1").val($("#ddlRole1 option:first").val());
        //$("#ddlLocation option:first").attr('selected', true);
        $("#ddlLocation").val($("#ddlLocation option:first").val());
        $('#txtId').val('0');
        $("#txtValue").val('');
        $('input[id$="chkActive"]').attr('checked', true);
        $('#btnSavePrintPolicy').val(Usradd);
        $('#btnResetPrintPolicy').val(Usrreset);
        $("#hdnSelectedRowIndex").val('0');
        return false;
    }
    function onPrintPolicyDelete(obj) {
        try {
            var $row = $(obj).closest('tr');
            var id = $row.find("span[id$='lblId']").html();
            $.ajax({
                type: "POST",
                url: "PasswordPolicy.aspx/DeletePrintPolicy",
                data: "{ID: " + id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    var result = data.d;
                    if (result.indexOf("success") >= 0) {
                        $(obj).closest('tr').remove();
                        onPrintPolicyReset();
                    }
                    // alert(result);
                    ValidationWindow(result, objAlert);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                // alert(xhr.status);
                ValidationWindow(xhr.status, objAlert);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }

    function ShowTabContent(tabId, DivId) {
        $('#TabsMenu li').removeClass('active');
        $('#' + tabId).addClass('active');
        $('[id^="tabContent"]').hide();
        $('#' + DivId).show();
        $('#hdnSelectedDiv').val(DivId);
    }
    function SetVisibleContent() {
        if ($('#hdnSelectedDiv').val() != '') {
            $('#' + $('#hdnSelectedDiv').val()).show();
        }
    }
    </script>