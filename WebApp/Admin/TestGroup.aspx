<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="TestGroup.aspx.cs"
    Inherits="Admin_TestGroup" meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/PackageProfileControl1.ascx" TagName="PackageProfileControl"
    TagPrefix="uc9" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/ManageInvestigation.ascx" TagName="ManageInvestigation"
    TagPrefix="ucM" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <!-- loading tabular interpretation styles and jquery handsontable plugin css begins -->
    <%--    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
    <link rel="stylesheet" media="screen" href="../Scripts/handsontable/dist/jquery.handsontable.full.css" />
    <link rel="stylesheet" media="screen" href="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.css" />
    <!-- loading tabular interpretation styles and jquery handsontable plugin css ends -->
    <%--<script type="text/javascript" src="../Scripts/JsonScript.js"></script>--%>
    <%--    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>
    <script src="../Scripts/bid.js" type="text/javascript"></script>--%>
    <%-- <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <style type="text/css">
        .mytable1 td, .mytable1 th
        {
            border: 1px solid #686868;
            border-bottom: 1px solid #686868;
        }
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 130px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px !important;
            background-color: #F3E2A8;
        }
        .mediumList
        {
            min-width: 330px;
        }
        .bigList
        {
            min-width: 800px;
        }
        .listMain
        {
            min-height: 0px;
        }
        .wordWheel
        {
            ul.visibility:hidden;
        }
    </style>

    <script language="javascript" type="text/javascript">
        /* Extending handsontable cell type to support html rendering begins */
        var htmlRenderer = function(instance, td, row, col, prop, value, cellProperties) {
            var escaped = Handsontable.helper.stringify(value);
            td.innerHTML = escaped;
            return td;
        };
        /* Extending handsontable cell type to support html rendering ends */
        var popUpWin = null;

        function ShowAlertMsg(key) {
            //debugger;
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            var userMsg = SListForAppMsg.Get("Admin_TestGroup_aspx_01") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_01") : "Record saved successfully";
            var userMsg1 = SListForAppMsg.Get("Admin_TestGroup_aspx_02") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_02") : "No Such Records found";

            var userMsg2 = SListForAppMsg.Get("Admin_TestGroup_aspx_03") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_03") : "Select a group to add";
            var userMsg3 = SListForAppMsg.Get("Admin_TestGroup_aspx_04") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_04") : "Select a group to remove"; if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, Error);
            }
            else if (key == userMsg) {
                // alert('Record saved successfully');
                ValidationWindow(userMsg, Error);
            }

            //  else if (key == "Admin\\TestGroup.aspx.cs_10")
            else if (key == userMsg1) {
                //  alert('No Such Records found');
                ValidationWindow(userMsg1, Error);
            }

            else if (key == userMsg2) {
                ValidationWindow(userMsg2, Error);
                // alert('Select a group to add');
            }
            else if (key == userMsg3) {
                ValidationWindow(userMsg3, Error);
                //alert('Select a group to remove');
            }

            return true;
        }
        function Validatecomma(e) {
            var key = window.event ? e.keyCode : e.which;
            var text = String.fromCharCode(event.keyCode);
            var keyCodeEntered = (event.which) ? event.which : (window.event.keyCode) ? window.event.keyCode : -1;
            //var unicodeWord = RegExOnlyNumeric();
            if ( keyCodeEntered == 44) {
                return false;
            }
            else {
                return true;
            }
            return true;

        }
        function onRemarksDelete(obj) {
            try {
                $(obj).closest('tr').remove();
            }
            catch (e) {
                return false;
            }
            return false;
        }
        function IsValidGroup() {
            var userMsg4 = SListForAppMsg.Get("Admin_TestGroup_aspx_05") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_05") : "Provide the group name";
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            if ($('[id$="txtTestCodeScheme"]').val().trim() == "") {
                // var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx_1");
                if (userMsg4 != null) {
                    ValidationWindow(userMsg4, Error);
                    //alert(userMsg);
                    // return false;
                }
                else {
                    ValidationWindow(userMsg4, Error);
                    // alert('Provide the group name');
                    //return false;
                }
                document.getElementById('hdnInvID').Value = "";
                return false;
            }
        }
        function onSave() {
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            var userMsg5 = SListForAppMsg.Get("Admin_TestGroup_aspx_06") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_06") : "Enter group name";
            var userMsg6 = SListForAppMsg.Get("Admin_TestGroup_aspx_07") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_07") : "Kindly provide  Reason";
            var userMsg7 = SListForAppMsg.Get("Admin_TestGroup_aspx_08") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_08") : "Enter display text";
            var userMsg8 = SListForAppMsg.Get("Admin_TestGroup_aspx_21") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_21") : "Enter Processing Time Value";
            try {
                if ($('[id$="txtTestCodeScheme"]').val() == '') {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx.cs_13");
                    if (userMsg5 != null) {
                        ValidationWindow(userMsg5, Error);
                        //alert(userMsg);
                        // return false;
                    }
                    else {
                        ValidationWindow(userMsg5, Error);
                        //alert("Enter group name");
                        //return false;
                    }
                    document.getElementById('hdnInvID').Value = "";
                    return false;
                }
                if ($('[id$="ddlScheduleType"]').val() != -1) {

                    if ($('[id$="txtCutOffValue"]').val() == '') {
                        ValidationWindow(userMsg8, Error);
                        // alert("Enter Processing Time Value");
                        $('[id$="txtCutOffValue"]').focus();
                        return false;
                    }
                }

                if ($('[id$="txtDisplayText"]').val() != '') {
                    var lstInvRemarks = [];
                    $('[id$="tblRemarks"] tbody tr').each(function(i, n) {
                        var $row = $(n);
                        var remarksID = $row.find($('input[id$="hdnRemarksID"]')).val();
                        var itemremarkid = remarksID.split('~');
                        var remarksID = itemremarkid[0];
                        lstInvRemarks.push({
                            remarksID: remarksID
                        });
                        if (lstInvRemarks.length > 0) {
                            $('[id$="hdnLstInvRemarks"]').val(JSON.stringify(lstInvRemarks));
                        }
                    });
                    //   ------ K.Bharathidhasan----------- //
                    var lstInvLocation = [];
                    $('#' + hdnInvLocation).val('');
                    $('#Tabel1 tbody tr').each(function(i, n) {
                        var $row = $(n);
                        var hdnInvestigationID = $row.find($('input[id$="hdnInvestigationID"]')).val();
                        var invID = $('#hdnInvID').val();
                        var orgID = $('#hdnOrgID').val();
                        var locationID = $row.find($('input[id$="hdnRegLocation"]')).val();
                        var processingOrgID = $row.find($('input[id$="hdnProcessingOrg"]')).val();
                        var processingAddressID = $row.find($('input[id$="hdnProcLocation"]')).val();
                        var type = $row.find($('input[id$="hdnType"]')).val();
                        //                    var type = $row.find($('span[id$="spanType"]')).html();

                        if (type == "INH" || type == "0") {
                            type = 0;
                        }
                        else {
                            type = 12;
                        }
                        var feeType = "OUT";


                        lstInvLocation.push({
                            Id: hdnInvestigationID,
                            InvestigationID: invID,
                            OrgID: orgID,
                            LocationID: locationID,
                            ProcessingOrgID: processingOrgID,
                            ProcessingAddressID: processingAddressID,
                            Type: type

                        });
                        if (lstInvLocation.length > 0) {
                            $('#' + hdnInvLocation).val(JSON.stringify(lstInvLocation));
                        }


                    });

                    //   ------- end ------ //
                    if (document.getElementById('grouptab_AssociateGroupTab_ddlReasonn').value == "0") {
                        // alert('Kindly provide  Reason');
                        ValidationWindow(userMsg6, Error);
                        return false;
                    }
                    /* Getting entered tabular interpretation details begins */
                    $('#drpProcessingOrg').children('option:not(:first)').remove();
                    $('#drpProcessLocation').children('option:not(:first)').remove();
                    var table1 = $('#handontable1').handsontable('getInstance');
                    var table2 = $('#handontable2').handsontable('getInstance');
                    var tableRowsCount1 = table1.countRows();
                    var tableColsCount1 = table1.countCols();
                    var tableEmptyRowsCount1 = table1.countEmptyRows(true);
                    var tableEmptyColsCount1 = table1.countEmptyCols(true);

                    var tableRowsCount2 = table2.countRows();
                    var tableColsCount2 = table2.countCols();
                    var tableEmptyRowsCount2 = table2.countEmptyRows(true);
                    var tableEmptyColsCount2 = table2.countEmptyCols(true);

                    var tableDataRowsCount1 = tableRowsCount1 - tableEmptyRowsCount1;
                    var tableDataColsCount1 = tableColsCount1 - tableEmptyColsCount1;
                    var tableDataRowsCount2 = tableRowsCount2 - tableEmptyRowsCount2;
                    var tableDataColsCount2 = tableColsCount2 - tableEmptyColsCount2;

                    $('#hdnHandsonTable1ColumnCount').val(tableDataColsCount1);
                    $('#hdnHandsonTable2ColumnCount').val(tableDataColsCount2);

                    if (tableDataRowsCount1) {
                        tableDataRowsCount1 = tableDataRowsCount1 - 1;
                    }
                    if (tableDataColsCount1) {
                        tableDataColsCount1 = tableDataColsCount1 - 1;
                    }
                    if (tableDataRowsCount2) {
                        tableDataRowsCount2 = tableDataRowsCount2 - 1;
                    }
                    if (tableDataColsCount2) {
                        tableDataColsCount2 = tableDataColsCount2 - 1;
                    }
                    var tableData1 = table1.getData(0, 0, tableDataRowsCount1, tableDataColsCount1);
                    var tableData2 = table2.getData(0, 0, tableDataRowsCount2, tableDataColsCount2);

                    if (tableDataRowsCount1 == 0 && tableDataColsCount1 == 0) {
                        $('#hdnIsEmptyHandsonTable1').val(true);
                    }
                    else {
                        $('#hdnIsEmptyHandsonTable1').val(false);
                        $('#hdnHandsonTable1').val(JSON.stringify(tableData1));
                    }
                    if (tableDataRowsCount2 == 0 && tableDataColsCount2 == 0) {
                        $('#hdnIsEmptyHandsonTable2').val(true);
                    }
                    else {
                        $('#hdnIsEmptyHandsonTable2').val(false);
                        $('#hdnHandsonTable2').val(JSON.stringify(tableData2));
                    }
                    /* Getting entered tabular interpretation details ends */
                    return true;
                }
                else {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx.cs_14");
                    if (userMsg7 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg7, Error);
                        return false;
                    }
                    else {
                        // alert("Enter display text");
                        ValidationWindow(userMsg7, Error);
                        return false;
                    }
                }
            }
            catch (e) {
                return false;
            }
            return false;
        }
        function AddRemarks() {
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            var userMsg8 = SListForAppMsg.Get("Admin_TestGroup_aspx_09") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_09") : "Selected remarks already exists";
            var userMsg9 = SListForAppMsg.Get("Admin_TestGroup_aspx_10") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_10") : "Select a remark";
            try {
                if ($('[id$="hdnSelectedRemarksID"]').val() != '' && $('[id$="hdnRemarksContent"]').val() != '') {
                    var isExists = false;
                    $('[id$="tblRemarks"] tbody tr').each(function(i, n) {
                        var $row = $(n);
                        var remarksID = $row.find($('input[id$="hdnRemarksID"]')).val();
                        if ($('[id$="hdnSelectedRemarksID"]').val() == remarksID) {
                            isExists = true;
                        }
                    });
                    if (!isExists) {
                        var row$ = $('<tr/>');
                        var hdnSelectedRemarksID = $('[id$="hdnSelectedRemarksID"]').val();
                        var hdnId = '<input id="hdnRemarksID" type="hidden" runat="server" value="' + hdnSelectedRemarksID + '" />';
                        var tdName = $('<td/>').html($('[id$="hdnRemarksContent"]').val());
                        var tdType = $('<td/>').html(hdnId + $('[id$="hdnRemarksTypeName"]').val());
                        var txtDelete = $('[id$="lblDelete"]').html();
                        var inputDelete = '<input id="btnRemarks" runat="server" value="' + txtDelete + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onRemarksDelete(this);" />';
                        var tdDelete = $('<td/>').html(inputDelete);
                        row$.append(tdName).append(tdType).append(tdDelete);
                        $('[id$="tblRemarks"] tbody').append(row$);
                    }
                    else {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx.cs_15");
                        if (userMsg8 != null) {
                            //                            alert(userMsg);
                            ValidationWindow(userMsg8, Error);
                            return false;
                        }
                        else {
                            //alert('Selected remarks already exists');
                            ValidationWindow(userMsg8, Error);
                            return false;
                        }

                    }
                }
                else {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx.cs_16");
                    if (userMsg9 != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg9, Error);
                        return false;
                    }
                    else {
                        //alert('Select a remark');
                        ValidationWindow(userMsg9, Error);
                        return false;
                    }
                }
                $('[id$="txtRemarks"]').val('');
                $('[id$="hdnSelectedRemarksID"]').val('');
                $('[id$="hdnRemarksContent"]').val('');
            }
            catch (e) {
                return false;
            }
            return false;
        }


        function validateType() {
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            var userMsg10 = SListForAppMsg.Get("Admin_TestGroup_aspx_11") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_11") : "Select remarks type";
            if ($('[id$="ddlRemarksType"] option:selected').val() == '0') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx.cs_17");
                if (userMsg10 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg10, Error);
                    // return false;
                }
                else {
                    //alert("Select remarks type");
                    ValidationWindow(userMsg10, Error);
                    //return false;
                }
                $('[id$="ddlRemarksType"]').focus();
                return false;
            }
            else {
                var selectedRemarksType = $('[id$="ddlRemarksType"] option:selected');
                var txt = $(selectedRemarksType).text();
                var Value = $(selectedRemarksType).val();
                $('[id$="hdnRemarksTypeName"]').val($(selectedRemarksType).text());
                $find('grouptab_AssociateGroupTab_TabContainer1_TabNotesNRemarks_ACERemarks').set_contextKey(Value);
                return false;
            }
        }
        function inputOnlyNumbers(evt) {
            var e = window.event || evt;
            var charCode = e.which || e.keyCode;
            if ((charCode > 47 && charCode < 58) || charCode == 8) {
                return true;
            }
            return false;
        }
        function SelectedRemarks(Source, eventArgs) {
            try {
                $('[id$="hdnSelectedRemarksID"]').val(eventArgs.get_value());
                $('[id$="hdnRemarksContent"]').val(eventArgs.get_text());
            }
            catch (e) {
                return false;
            }
        }
        function RemarksPopulated(Source, eventArgs) {
            try {
                var autoList = Source.get_completionList();
                if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                    $('[id$="hdnSelectedRemarksID"]').val('');
                    $('[id$="hdnRemarksContent"]').val('');
                }
            }
            catch (e) {
                return false;
            }
        }
        function TestCodeSchemePopulated(Source, eventArgs) {
            try {
                var autoList = Source.get_completionList();
                if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                    $('[id$="hdnInvID"]').val('');
                }
            }
            catch (e) {
                return false;
            }
        }
        function SelectedTestCodeScheme(Source, eventArgs) {
            try {
                var lstSelectedValue = eventArgs.get_value().split(':');

                var seletedReflextest = lstSelectedValue[0];
                $('[id$="hdnInvID"]').val(seletedReflextest);
                var lstSelectedText = eventArgs.get_text().split(':');
                if (lstSelectedText.length > 1 && lstSelectedText[1] != null) {
                    $('[id$="txtTestCodeScheme"]').val(lstSelectedText[1]);
                }
            }
            catch (e) {
                return false;
            }
        }
        function validate() {
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            var userMsg11 = SListForAppMsg.Get("Admin_TestGroup_aspx_12") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_12") : "Provide the group name";
            var userMsg12 = SListForAppMsg.Get("Admin_TestGroup_aspx_13") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_13") : "Please Enter TCode";
            var _temp = 0; var flag = 'Correct';
            var value = document.getElementById('grouptab_Createtab_txtpackage').value;
            if (value.trim() == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx_1");
                if (userMsg11 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg11, Error);
                    return false;
                }
                else {
                    // alert('Provide the group name');
                    ValidationWindow(userMsg11, Error);
                    return false;
                }
                // return false;
            }
            $('#grouptab_Createtab_grdInvCodingScheme tbody tr td input:text').each(function() {
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
                ValidationWindow(userMsg12, Error);

                _temp = '';
                return false;
            }
        }
        function parent_click() {
            if (popUpWin && !popUpWin.closed)
            { popUpWin.focus(); }

        }
        function chkonchange_grp() {
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            var userMsg13 = SListForAppMsg.Get("Admin_TestGroup_aspx_14") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_14") : "Select the items in group master";
            var j = 0;
            var i = 0;
            $("#grouptab_addgrouptab_chklstGrp tr").each(function() {
                var Medtr = $(this).closest("tr");
                var chk = $(Medtr).find("input:checkbox[id$=grouptab_addgrouptab_chklstGrp_" + i + "]")[0].checked;
                if (chk == true) {
                    j = j + 1;
                }
                i = i + 1;
            });


            /* var tableBody = document.getElementById('grouptab_addgrouptab_chklstGrp').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
            var currentTd = tableBody.childNodes[i].childNodes[0];
            var listControl = currentTd.childNodes[0];
            if (listControl.checked == true) {
            j = j + 1;
            }
            }*/
            if (j == 0) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx_2");
                if (userMsg13 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg13, Error);
                    return false;
                }
                else {
                    //alert('Select the items in group master');
                    ValidationWindow(userMsg13, Error);
                    return false;
                }
                //return false;
            }
        }
        function chkGrponchange() {
            var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
            var userMsg14 = SListForAppMsg.Get("Admin_TestGroup_aspx_15") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_15") : "listControl";
            var userMsg15 = SListForAppMsg.Get("Admin_TestGroup_aspx_16") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_16") : "Select the items in group mapping master";
            var tableBody = document.getElementById('grouptab_addgrouptab_chkGrpMap').childNodes[0];
            var j = 0;
            alert(document.getElementById(tableBody).value);
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx.cs_18");
                if (userMsg14 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg14, Error);
                    return false;
                }
                else {
                    // alert('listControl');
                    ValidationWindow(userMsg14, Error);
                    return false;
                }
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\TestGroup.aspx_3");
                if (userMsg15 != null) {
                    //alert(userMsg15);
                    ValidationWindow(userMsg15, Error);
                    return false;
                }
                else {
                    //alert('Select the items in group mapping master');
                    ValidationWindow(userMsg15, Error);
                    return false;
                }
                // return false;
            }
        }
        /* Loading already saved tabular interpretation details begins */
        function loadInterpretationTableData(hdnHandsonTable1DataID, hdnHandsonTable2DataID) {
            try {
                $('#handontable1').handsontable({
                    minRows: 4,
                    minCols: 4,
                    startRows: 5,
                    startCols: 5,
                    rowHeaders: true,
                    colHeaders: true,
                    minSpareRows: 1,
                    minSpareCols: 1,
                    contextMenu: false,
                    manualColumnResize: true,
                    useFormula: false,
                    autoWrapRow: true,
                    cells: function(row, col, prop) {
                        this.renderer = htmlRenderer;
                    }
                });
                $('#handontable2').handsontable({
                    minRows: 4,
                    minCols: 4,
                    startRows: 5,
                    startCols: 5,
                    rowHeaders: true,
                    colHeaders: true,
                    minSpareRows: 1,
                    minSpareCols: 1,
                    contextMenu: false,
                    manualColumnResize: true,
                    useFormula: false,
                    autoWrapRow: true,
                    cells: function(row, col, prop) {
                        this.renderer = htmlRenderer;
                    }
                });
                if ($('#' + hdnHandsonTable1DataID).val() != "") {
                    var hdnHandson1Data = JSON.parse($('#' + hdnHandsonTable1DataID).val());
                    var handontab1 = $('#handontable1').handsontable('getInstance');
                    if (typeof handontab1 != 'undefined') {
                        handontab1.loadData(hdnHandson1Data);
                    }
                }
                else {
                    handontab1.loadData(new Array());
                }
                if ($('#' + hdnHandsonTable2DataID).val() != "") {
                    var hdnHandson2Data = JSON.parse($('#' + hdnHandsonTable2DataID).val());
                    var handontab2 = $('#handontable2').handsontable('getInstance');
                    if (typeof handontab2 != 'undefined') {
                        handontab2.loadData(hdnHandson2Data);
                    }
                }
                else {
                    handontab2.loadData(new Array());
                }
            }
            catch (e) {
                return false;
            }
        }
        /* Loading already saved tabular interpretation details ends */
        /* Initializing handsontable plugin begins */

        /* Initializing handsontable plugin ends */
        /* Handling tabular interpretation layout change event begins */
        function changeLayout(layout) {
            try {
                $('#hdnSelectedLayout').val(layout);
                $('#' + layout).attr('checked', true);

                $("#divFCKeditor1").hide();
                $("#divFCKeditor2").hide();
                $("#divFCKeditor3").hide();
                $("#divHandTable1").hide();
                $("#divHandTable2").hide();

                if (layout == "layout1" || layout == "layout3" || layout == "layout5" || layout == "layout7") {
                    $("#divFCKeditor1").show();
                }
                if (layout == "layout2" || layout == "layout3" || layout == "layout4" || layout == "layout5" || layout == "layout6" || layout == "layout7" || layout == "layout8") {
                    $("#divHandTable1").show();
                }
                if (layout == "layout4" || layout == "layout5" || layout == "layout6") {
                    $("#divFCKeditor2").show();
                }
                if (layout == "layout6" || layout == "layout7" || layout == "layout8") {
                    $("#divHandTable2").show();
                }
                if (layout == "layout8") {
                    $("#divFCKeditor3").show();
                }
            }
            catch (e) {
                return false;
            }
        }
        /* Handling tabular interpretation layout change event ends */
    </script>

</head>
<body onclick="parent_click();">
    <form id="form1" runat="server">

    <script type="text/javascript">

        var drpProcessLocation = '<%=drpProcessLocation.ClientID %>';
        var drpProcessingOrg = '<%=drpProcessingOrg.ClientID %>';
        var drpRegLocation = '<%=drpRegLocation.ClientID %>';
        var drpType = '<%=drpType.ClientID %>';
        var hdnInvLocationMapping = '<%=hdnInvLocationMapping.ClientID %>';
        var hdnInvLocation = '<%=hdnInvLocation.ClientID %>';
        var hdnSelectedOrgID = '<%=hdnSelectedOrgID.ClientID %>';

 
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True" ScriptMode="Release">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" id="tab">
        <div id="createprogressbar" style="display: none;" runat="server">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="a-center w-20p">
                <asp:Image ID="img3" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                    meta:resourcekey="img1Resource1" />
            </div>
        </div>
        <ajc:TabContainer ID="grouptab" runat="server" ActiveTabIndex="0" meta:resourcekey="grouptabResource2">
            <ajc:TabPanel ID="Createtab" runat="server" HeaderText="Create Group" meta:resourcekey="CreatetabResource1">
                <HeaderTemplate>
                    <asp:Label ID="lblCreateGroup" runat="server" Text="Create Group" Font-Names="Verdana"
                        Font-Size="9pt" meta:resourcekey="lblCreateGroupResource1"></asp:Label>
                </HeaderTemplate>
                <ContentTemplate>
                    <asp:UpdatePanel ID="updpnl" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img3" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <table class="w-100p">
                                <tr>
                                    <td class="w-20p">
                                        <asp:Label ID="lblpackage" runat="server" Font-Bold="True" Text="Enter the Group"
                                            meta:resourcekey="lblpackageResource1"></asp:Label>
                                    </td>
                                    <td class="w-15p">
                                        <asp:TextBox ID="txtpackage" CssClass="small" runat="server"   OnKeyPress="return Validatecomma(this);" meta:resourcekey="txtpackageResource1"></asp:TextBox>
                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                        <%--<asp:Label ID="lblAbbreviation" runat="server" Text="Abbreviation" meta:resourcekey="lblAbbreviationResource1" ></asp:Label>&nbsp;&nbsp;
                                                        <asp:TextBox ID="txtAbbreviation" Width="40px" CssClass="Txtboxsmall" runat="server"></asp:TextBox>&nbsp;&nbsp;&nbsp;--%>
                                    </td>
                                    <td class="w-65p">
                                        <asp:Button ID="Add" runat="server" Text="Add" OnClientClick="javascript:return validate()"
                                            CssClass="btn w-45" onmouseover="this.className='btn1 btnhov'" onmouseout="this.className='btn1'"
                                            OnClick="Add_Click" meta:resourcekey="AddResource1" />
                                    </td>
                                </tr>
                            </table>
                            <table class="w-75p">
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdInvCodingScheme" runat="server" AutoGenerateColumns="False"
                                            CssClass="mytable1 gridView w-100p m-auto" ForeColor="#333333" OnPageIndexChanging="grdInvCodingScheme_PageIndexChanging"
                                            OnRowDataBound="grdInvCodingScheme_OnRowDataBound" meta:resourcekey="grdInvCodingSchemeResource1">
                                            <Columns>
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                    <HeaderTemplate>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCodingSchemeNameMaster" runat="server" Text='<%# Eval("CodingSchemaName") %>'
                                                            meta:resourcekey="lblCodingSchemeNameMasterResource1"></asp:Label>
                                                        <asp:Label ID="lblCodingSchemeNameMasterID" runat="server" Style="display: none"
                                                            Text='<%# Eval("CodeTypeID") %>'></asp:Label>
                                                        <asp:Label ID="lblCodeMasterID" runat="server" Style="display: none" Text='<%# Eval("CodeMasterID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCodingSchemeNameMaster" runat="server" CssClass="small" Text='<%# Eval("CodeName") %>'
                                                            meta:resourcekey="txtCodingSchemeNameMasterResource1"></asp:TextBox>
                                           <asp:ImageButton ID="starbutton" runat="server" ImageUrl="~/Images/starbutton.png"
                                                            meta:resourcekey="starbuttonResource1" Enabled="false"/>
                                                            
                                                      
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td class="w-19p">
                                        <asp:Label ID="lblSearchGrp" runat="server" Font-Names="Verdana" Font-Bold="True"
                                            Font-Size="9pt" Text="Search Group" meta:resourcekey="lblSearchGrpResource1"></asp:Label>
                                    </td>
                                    <td class="w-15p">
                                        <asp:TextBox ID="txtSearchGrp" runat="server" CssClass="small marginL2" meta:resourcekey="txtSearchGrpResource1"></asp:TextBox>
                                    </td>
                                    <td class="w-5p">
                                        <asp:Button ID="btnSearchGrp" runat="server" Text="Search" CssClass="btn w-45" onmouseover="this.className='btn1 btnhov'"
                                            onmouseout="this.className='btn1'" OnClick="btnSearchGrp_Click" meta:resourcekey="btnSearchGrpResource1" />
                                    </td>
                                     <td class="w-70p">
                                        <asp:LinkButton ID="lnkCreateInvestigation" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="9pt" Text="Create Investigation" 
                                            Style="color: Blue" meta:resourcekey="lnkCreateInvestigationResource1"  OnClientClick="javascript:ShowPopUp();"
                                          />
                                    </td>
                                    <td>
                                        <div id="ExportXL" runat="server">
                                            <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                                Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="lblExportResource1"></asp:Label>
                                            <asp:ImageButton ID="ImageBtnExport" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                meta:resourcekey="imgBtnXLResource1" OnClick="ImageBtnExport_Click" Style="width: 16px" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdGroups" runat="server" AutoGenerateColumns="False" CellPadding="3"
                                            CssClass="mytable1 gridView w-100p m-auto" EmptyDataText="No Matching Records Found!"
                                            OnRowCommand="grdGroups_RowCommand" OnPageIndexChanging="grdGroups_PageIndexChanging"
                                            DataKeyNames="OrgGroupID,CodeName,DisplayText" meta:resourcekey="grdGroupsResource1">
                                            <Columns>
                                                <asp:BoundField DataField="OrgGroupID" HeaderText="Group ID" ItemStyle-HorizontalAlign="center"
                                                    meta:resourcekey="BoundFieldResource1">
                                                    <ItemStyle HorizontalAlign="left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CodeName" HeaderText="PrimaryCode" ItemStyle-HorizontalAlign="center"
                                                    meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DisplayText" HeaderText="Group Name" ItemStyle-HorizontalAlign="center"
                                                    meta:resourcekey="BoundFieldResource3">
                                                    <ItemStyle HorizontalAlign="left" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <table class="mytable1 w-100p">
                                                            <tr>
                                                                <td class="w-50p a-center">
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="EditGroups"
                                                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' meta:resourcekey="lnkEditResource1"></asp:LinkButton>
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
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <table class="w-100p">
                                            <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                <td class="defaultfontcolor a-center">
                                                    <asp:Label ID="Lblpage" runat="server" Text="Page" meta:resourcekey="LblpageResource1"></asp:Label>
                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                    <asp:Label ID="Labelof" runat="server" Text="Of" meta:resourcekey="LabelofResource1"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click"
                                                        meta:resourcekey="btnPreviousResource1" />
                                                    <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click"
                                                        meta:resourcekey="btnNextResource1" />
                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                    <asp:HiddenField ID="hdnTotalPage" runat="server" />
                                                    <asp:Label ID="Labelpagetogo" runat="server" Text="Enter The Page To Go:" meta:resourcekey="LabelpagetogoResource1"></asp:Label>
                                                    <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30" onkeypress="return ValidateOnlyNumeric(this);"
                                                        AutoComplete="off" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                    <asp:Button ID="btnGoes" runat="server" Text="Go" CssClass="btn" OnClick="btnGoes_Click"
                                                        OnClientClick="javascript:return validatePageNumber();" meta:resourcekey="btnGoesResource1" />
                                                    <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <input type="hidden" id="hdnGroupID" runat="server" />
                            <triggers>
                                           
                                           <asp:AsyncPostBackTrigger ControlID="Add" EventName="Click" />
                            </triggers>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="ImageBtnExport" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </ajc:TabPanel>
            <ajc:TabPanel ID="addgrouptab" runat="server" HeaderText="Add Group" meta:resourcekey="addgrouptabResource1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="pnl" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMasterGroup" runat="server" meta:resourcekey="lblMasterGroupResource1"
                                            Text="Master Group"></asp:Label>
                                        <asp:TextBox ID="txt_search" runat="server" CssClass="small" meta:resourcekey="txt_searchResource1"></asp:TextBox>
                                        <asp:Button ID="btnmassearch" runat="server" CssClass="btn" meta:resourcekey="btnmassearchResource1"
                                            OnClick="btnmassearch_Click" Text="Search" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMappedGroup" runat="server" meta:resourcekey="lblMappedGroupResource1"
                                            Text="Mapped Group."></asp:Label>
                                        <asp:TextBox ID="txt_searchmap" runat="server" CssClass="small" meta:resourcekey="txt_searchmapResource1"></asp:TextBox>
                                        <asp:Button ID="btnmapsearch" runat="server" CssClass="btn" meta:resourcekey="btnmapsearchResource1"
                                            OnClick="btnmapsearch_Click" Text="Search" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ancCSbg">
                                        <asp:Label ID="lblMasterGrp" runat="server" meta:resourcekey="lblMasterGrpResource1"
                                            Text="Master Group"></asp:Label>
                                    </td>
                                    <td>
                                    </td>
                                    <td class="ancCSbg">
                                        <asp:Label ID="lblGroupMappedLab" runat="server" Text="Group Mapped to Lab" meta:resourcekey="lblGroupMappedLabResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="h-51">
                                        <div class="ancCSviolet bg-row" style="overflow: scroll; border: 2px; border-color: #fff;
                                            height: 500px; width: 500px;">
                                            <asp:CheckBoxList ID="chklstGrp" runat="server" Height="100px" meta:resourcekey="chklstGrpResource1"
                                                Width="320px">
                                            </asp:CheckBoxList>
                                        </div>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                                    <asp:Button ID="btnGrpAdd" runat="server" CssClass="btn w-61 h-25" meta:resourcekey="btnGrpAddResource1"
                                                        OnClick="btnGrpAdd_Click" OnClientClick="javascript:return chkonchange_grp();"
                                                        Text="Add" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center h-15">
                                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                        <ProgressTemplate>
                                                            <div id="progressBackgroundFilter" class="a-center">
                                                            </div>
                                                            <div id="processMessage" class="a-center w-20p">
                                                                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                                    meta:resourcekey="img1Resource1" />
                                                            </div>
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnGrpRemove" runat="server" CssClass="btn h-26" meta:resourcekey="btnGrpRemoveResource1"
                                                        OnClick="btnGrpRemove_Click" OnClientClick="javascript:return chkGrponchange();"
                                                        Text="Remove" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="v-top">
                                        <div class="bg-row" style="overflow: scroll; height: 500px; width: 500px">
                                            <asp:CheckBoxList ID="chkGrpMap" runat="server" CssClass="h-100" meta:resourcekey="chkGrpMapResource1"
                                                Width="320px">
                                            </asp:CheckBoxList>
                                            <asp:LinkButton ID="lnk" runat="server" ForeColor="Red" meta:resourcekey="lnkResource1"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="Red" meta:resourcekey="LinkButton1Resource1"
                                                OnClick="Execute1"></asp:LinkButton>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                            <ajc:ModalPopupExtender ID="mpe" runat="server" TargetControlID="lnk" PopupControlID="ModalPanel"
                                DropShadow="True" BackgroundCssClass="modalBackground" OkControlID="btnMClose"
                                DynamicServicePath="" Enabled="True" />
                            <asp:Button ID="btnMClose" runat="server" Style="visibility: hidden" CssClass="btn"
                                meta:resourcekey="btnMCloseResource1" />
                            <asp:Button ID="btnMFinish" runat="server" Style="visibility: hidden" CssClass="btn"
                                meta:resourcekey="btnMFinishResource1" />
                            <asp:Panel ID="ModalPanel" runat="server" Style="display: none" CssClass="modalPopup"
                                Width="1000px" Height="550px" meta:resourcekey="ModalPanelResource1">
                                <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <table>
                                            <tr class="a-center">
                                                <td class="a-center">
                                                    <asp:Panel ID="Panel2" runat="server" ScrollBars="Both" meta:resourcekey="Panel2Resource1">
                                                        <ucM:ManageInvestigation ID="ManageInvestigation" runat="server" />
                                                        <asp:Button ID="OKButton" runat="server" Text="Close" OnClick="OKButton_Click" CssClass="btn"
                                                            meta:resourcekey="OKButtonResource1" />
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </ajc:TabPanel>
            <ajc:TabPanel ID="AssociateGroupTab" runat="server" HeaderText="Associate Group"
                meta:resourcekey="AssociateGroupTabResource1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdPnlAssociateGroup" runat="server">
                        <ContentTemplate>
                            <!-- Script to handle tabular interpretation layout change on ajax postback begins -->

                            <script type="text/javascript">

                                var prm = Sys.WebForms.PageRequestManager.getInstance();
                                if (prm != null) {
                                    prm.add_beginRequest(function(sender, e) {
                                        try {
                                            //Event raised when the Async Postback is started.

                                            //Detect whether the request is Async
                                            var isAsync = sender._postBackSettings.async;

                                            //Detect Id of the control that caused the postback.
                                            var controlId = sender._postBackSettings.sourceElement.id;

                                            //Id of the updatepanel that caused the postback
                                            var updatePanelId = sender._postBackSettings.panelID.split('|')[0];
                                        }
                                        catch (e) {
                                            return false;
                                        }
                                    });
                                    prm.add_endRequest(function(sender, e) {
                                        try {
                                            if (sender._postBackSettings != null) {
                                                $('#handontable1').handsontable({
                                                    minRows: 4,
                                                    minCols: 4,
                                                    startRows: 5,
                                                    startCols: 5,
                                                    rowHeaders: true,
                                                    colHeaders: true,
                                                    minSpareRows: 1,
                                                    minSpareCols: 1,
                                                    contextMenu: false,
                                                    manualColumnResize: true,
                                                    useFormula: false,
                                                    autoWrapRow: true,
                                                    cells: function(row, col, prop) {
                                                        this.renderer = htmlRenderer;
                                                    }
                                                });
                                                $('#handontable2').handsontable({
                                                    minRows: 4,
                                                    minCols: 4,
                                                    startRows: 5,
                                                    startCols: 5,
                                                    rowHeaders: true,
                                                    colHeaders: true,
                                                    minSpareRows: 1,
                                                    minSpareCols: 1,
                                                    contextMenu: false,
                                                    manualColumnResize: true,
                                                    useFormula: false,
                                                    autoWrapRow: true,
                                                    cells: function(row, col, prop) {
                                                        this.renderer = htmlRenderer;
                                                    }
                                                });
                                            }
                                        }
                                        catch (e) {
                                            return false;
                                        }
                                    });
                                }
                            </script>

                            <!-- Script to handle tabular interpretation layout change on ajax postback ends -->
                            <table class="w-100p">
                                <tr id="trAssociateGroup" runat="server">
                                    <td id="tdAssociateGroup" runat="server">
                                        <asp:Label ID="lblCode" Text="Group name / code " runat="server" meta:resourcekey="lblCodeResource1"></asp:Label>
                                        <asp:TextBox ID="txtTestCodeScheme" runat="server" MaxLength="50" CssClass="searchBox small"
                                            TabIndex="1" meta:resourcekey="txtTestCodeSchemeResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="ACETestCodeScheme" runat="server" TargetControlID="txtTestCodeScheme"
                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box mediumList"
                                            CompletionListItemCssClass="wordWheel itemsMain mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                            ServiceMethod="GetTestCodingScheme" ServicePath="~/WebService.asmx" UseContextKey="True"
                                            DelimiterCharacters=":" Enabled="True" OnClientItemSelected="SelectedTestCodeScheme"
                                            OnClientPopulated="TestCodeSchemePopulated" CompletionSetCount="20">
                                        </ajc:AutoCompleteExtender>
                                        <asp:Button ID="btnLoadGroupDetails" runat="server" Text="&nbsp;&nbsp;&nbsp;Load&nbsp;&nbsp;&nbsp;"
                                            CssClass="btn w-50" onmouseover="this.className='btn1 btnhov'" onmouseout="this.className='btn1'"
                                            OnClientClick="return IsValidGroup();" TabIndex="2" OnClick="btnLoadGroupDetails_Click"
                                            meta:resourcekey="btnLoadGroupDetailsResource1" />
                                    </td>
                                    <td runat="server">
                                        <asp:UpdateProgress ID="Progressbar" runat="server">
                                            <ProgressTemplate>
                                                <div id="progressBackgroundFilter" class="a-center">
                                                </div>
                                                <div id="processMessage" class="a-center w-20p">
                                                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                        meta:resourcekey="img1Resource1" />
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr id="trAssociateValues">
                                    <td colspan="2">
                                        <table class="w-100p bg-row">
                                            <tr>
                                                <td style="width: 110px;">
                                                    <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1" Text="Name"></asp:Label>
                                                </td>
                                                <td style="width: 205px;">
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="small" MaxLength="50" meta:resourcekey="txtNameResource1"
                                                        Width="170px"></asp:TextBox>
                                                </td>
                                                <td class="w-75">
                                                    <asp:Label ID="lblDisplayText" runat="server" meta:resourcekey="lblDisplayTextResource1"
                                                        Text="Display Text"></asp:Label>
                                                </td>
                                                <td style="width: 220px;">
                                                    <asp:TextBox ID="txtDisplayText" runat="server" CssClass="small" MaxLength="100" meta:resourcekey="txtDisplayTextResource1"
                                                        Width="170px"></asp:TextBox>
                                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                                </td>
                                                <td style="width: 75px;">
                                                    <asp:Label ID="lblBillingName" runat="server" meta:resourcekey="lblBillingName" Text="BillingName"></asp:Label>
                                                </td>
                                                <td style="width: 220px;">
                                                    <asp:TextBox ID="txtBillingName" runat="server" CssClass="Txtboxsmall" MaxLength="100"
                                                        Width="170px" meta:resourcekey="txtBillingNameResource1"></asp:TextBox>
                                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                                </td>
                                                <td style="width: 125px;">
                                                    <asp:CheckBox ID="chkIsActive" runat="server" meta:resourcekey="chkIsActiveResource1"
                                                        Text="Active" />
                                                </td>
                                                 <td style="width: 125px;">
                                                    <asp:CheckBox ID="chkIsFieldTest" runat="server" 
                                                        Text="IsFieldTest" />
                                                </td>
                                                <td style="width: 200px;">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-75">
                                                                <asp:Label ID="lblGender1" runat="server" meta:resourcekey="lblGenderResource1" Text="Gender"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="ddlsmall">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="v-top">
                                                    <ajc:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" meta:resourcekey="TabContainer1Resource1">
                                                        <ajc:TabPanel ID="TabGeneral" runat="server" CssClass="dataheadergroup" HeaderText="General"
                                                            meta:resourcekey="TabGeneralResource1">
                                                            <ContentTemplate>
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td style="width: 135px;">
                                                                            <asp:Label ID="lblScheduleType" runat="server" Text="TAT Schedule Type" meta:resourcekey="lblScheduleTypeResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlScheduleType" runat="server" CssClass="ddlsmall">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td style="width: 105px;">
                                                                            <asp:Label ID="lblCutoffTime" runat="server" meta:resourcekey="lblCutoffTimeResource1"
                                                                                Text="Processing Time"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 180px;">
                                                                            <table>
                                                                                <tr>
                                                                                    <td class="w-18p">
                                                                                        <asp:TextBox ID="txtCutOffValue" runat="server" CssClass="w-81p" MaxLength="3" meta:resourcekey="txtCutOffValueResource1"
                                                                                            onkeypress="return ValidateOnlyNumeric(this);"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="ddlCutOffType" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlCutOffTypeResource1" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td style="width: 135px;">
                                                                            <asp:Label ID="lblClassification" runat="server" meta:resourcekey="lblClassificationResource1"
                                                                                Text="Classification"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlClassification" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlClassificationResource1">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblTestCategory" runat="server" meta:resourcekey="lblTestCategoryResource1"
                                                                                    Text="Discount Category"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlTestCategory" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlTestCategoryResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblProtocalGroup" runat="server" Text="Protocal Group" meta:resourcekey="lblProtocalGroupResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlProtocalGroup" runat="server" CssClass="ddlsmall">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td nowrap="nowrap" style="width: 135px;">
                                                                                <asp:Label ID="lblsummaryworklist" runat="server" Text="Is Summary Worklist" meta:resourcekey="lblsummaryworklistResource1"></asp:Label>
                                                                            </td>
                                                                            <td style="width: 220px;">
                                                                                <asp:CheckBox ID="Chksummaryworklist" runat="server" TextAlign="Left" meta:resourcekey="ChksummaryworklistResource1" />
                                                                                &nbsp; &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                        <td style="width: 105px;">
                                                                            <asp:Label ID="lblNonOrderable" runat="server" meta:resourcekey="lblNonOrderableResource1"
                                                                                Text="Non-Orderable"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                            <asp:CheckBox ID="chkIsOrder" runat="server" meta:resourcekey="chkIsOrderResource1"
                                                                                TextAlign="Left" />
                                                                            &#160; &#160;
                                                                        </td>
                                                                        <td style="width: 105px;">
                                                                            <asp:Label ID="lblDiscountable" runat="server" meta:resourcekey="lblDiscountableResource1"
                                                                                Text="Discountable"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                            <asp:CheckBox ID="chkDiscount" runat="server" meta:resourcekey="chkDiscountResource1"
                                                                                TextAlign="Left" />
                                                                            &#160; &#160;
                                                                        </td>
                                                                        <td style="width: 105px;">
                                                                            <asp:Label ID="lblSynoptic"  Text="Synoptic Report" runat="server" meta:resourcekey="lblSynoptic"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                            <asp:CheckBox ID="ChkSynoptic" onchange="return ChangeSynoptic();" runat="server" meta:resourcekey="ChkSynoptic" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 105px;">
                                                                            <asp:Label ID="lblServiceTaxable" runat="server" meta:resourcekey="lblServiceTaxableResource1"
                                                                                Text="ServiceTaxable"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="chkServiceTax" runat="server" meta:resourcekey="chkServiceTaxResource1"
                                                                                TextAlign="Left" />
                                                                            &#160; &#160;
                                                                        </td>
                                                                        <td style="width: 105px;">
                                                                            <asp:Label ID="lblPrintSeparately" runat="server" meta:resourcekey="lblPrintSeparatelyResource1"
                                                                                Text="Print Separately"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                            <asp:CheckBox ID="chkPrintSeparately" runat="server" meta:resourcekey="chkPrintSeparatelyResource1"
                                                                                TextAlign="Left" />
                                                                            &#160; &#160;
                                                                        </td>
                                                                        <td style="width: 105px;">
                                                                            <asp:Label ID="lblIsSensitivetest" runat="server" meta:resourcekey="lblPrintSeparatelyResource11"
                                                                                Text="Sensitive Test"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                            <asp:CheckBox ID="ChkIsSensitivetest" runat="server" meta:resourcekey="chkPrintSeparatelyResource11"
                                                                                TextAlign="Left" />
                                                                            &#160; &#160;
                                                                        </td>
                                                                    </tr>
																	<tr>
																	<td style="width: 125px;">
                                                                        <asp:Label ID="Label14" Text="Output Grouping Code" runat="server" meta:resourcekey="lbloutputcodeResource1"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                            <asp:TextBox ID="txtOutputCode" runat="server" MaxLength="10" Width="170px" CssClass="Txtboxsmall"
                                                                                meta:resourcekey="txtOutputCodeResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td style="width: 125px;">
                                                                        <asp:Label ID="lblshowinstrctuin" Text="Show Group Instruction" runat="server" ></asp:Label>
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                             <asp:CheckBox ID="chkshowgrpinstruction" runat="server" 
                                                                                TextAlign="Left" />
                                                                        </td>
																	</tr>
                                                                </table>
                                                            </ContentTemplate>
                                                        </ajc:TabPanel>
                                                        <ajc:TabPanel ID="TabCodes" runat="server" CssClass="dataheadergroup" HeaderText="Codes"
                                                            meta:resourcekey="TabCodesResource1">
                                                            <ContentTemplate>
                                                                <div class="mytable1 w-50p" style="overflow: auto; height: 220px;">
                                                                    <table id="tblCodeSchema" class="w-100p">
                                                                        <thead>
                                                                            <tr class="dataheader1 h-17">
                                                                                <th>
                                                                                    <asp:Label runat="server" ID="lblCodeName" Text="Name" meta:resourcekey="lblCodeNameResource1" />
                                                                                </th>
                                                                                <th>
                                                                                    <asp:Label runat="server" ID="lblCodeValue" Text="Value" meta:resourcekey="lblCodeValueResource1" />
                                                                                </th>
                                                                                <th>
                                                                                    <asp:Label runat="server" ID="lblIsPrimary" Text="Primary" meta:resourcekey="lblIsPrimaryResource1" />
                                                                                </th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <asp:Repeater ID="rptCodeSchema" runat="server">
                                                                                <ItemTemplate>
                                                                                    <tr class="h-17">
                                                                                        <td class="a-left">
                                                                                            <asp:Label ID="lblCodeSchemeName" runat="server" meta:resourcekey="lblCodeSchemeNameResource1"
                                                                                                Text='<%# Bind("CodingSchemaName") %>'></asp:Label>
                                                                                        </td>
                                                                                        <td class="a-left">
                                                                                            <asp:Label ID="lblCodeName" runat="server" meta:resourcekey="lblCodeNameResource2"
                                                                                                Text='<%# Bind("CodeName") %>'></asp:Label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <asp:Label ID="lblIsPrimary" runat="server" meta:resourcekey="lblIsPrimaryResource2"
                                                                                                Text='<%# Bind("IsPrimary") %>'></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </ContentTemplate>
                                                        </ajc:TabPanel>
                                                        <ajc:TabPanel runat="server" HeaderText="Interpretation / Notes" ID="TabInterpretation"
                                                            meta:resourcekey="TabInterpretationResource1" CssClass="dataheadergroup">
                                                            <ContentTemplate>
                                                                <!-- tabular interpretation begins -->
                                                                <table class="a-center w-100p">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblSelectLayout" runat="server" Text="Select Your Layout" meta:resourcekey="lblSelectLayoutResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <div class="divlayout">
                                                                    <input id="layout1" class="inputlayout" type="radio" checked="checked" value="" name="layout"
                                                                        onclick="changeLayout('layout1');"></input>
                                                                    <label class="labellayout l1img" for="layout1">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_01 %>
                                                                    </label>
                                                                </div>
                                                                <div class="divlayout">
                                                                    <input id="layout2" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout2');"></input>
                                                                    <label class="labellayout l2img" for="layout2">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_02 %>
                                                                    </label>
                                                                </div>
                                                                <div class="divlayout">
                                                                    <input id="layout3" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout3');"></input>
                                                                    <label class="labellayout l3img" for="layout3">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_03 %>
                                                                    </label>
                                                                </div>
                                                                <div class="divlayout">
                                                                    <input id="layout4" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout4');"></input>
                                                                    <label class="labellayout l4img" for="layout4">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_04 %>
                                                                    </label>
                                                                </div>
                                                                <div class="divlayout">
                                                                    <input id="layout5" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout5');"></input>
                                                                    <label class="labellayout l5img" for="layout5">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_05 %>
                                                                    </label>
                                                                </div>
                                                                <div class="divlayout">
                                                                    <input id="layout6" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout6');"></input>
                                                                    <label class="labellayout l6img" for="layout6">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_06 %>
                                                                    </label>
                                                                </div>
                                                                <div class="divlayout">
                                                                    <input id="layout7" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout7');"></input>
                                                                    <label class="labellayout l7img" for="layout7">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_07 %>
                                                                    </label>
                                                                </div>
                                                                <div class="divlayout">
                                                                    <input id="layout8" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout8');"></input>
                                                                    <label class="labellayout l8img" for="layout8">
                                                                        <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_08 %>
                                                                    </label>
                                                                </div>
                                                                <table class="a-center w-100p">
                                                                    <tr>
                                                                        <td>
                                                                            <div id="divFCKeditor1" class="padding7">
                                                                                <%-- <FCKeditorV2:FCKeditor ID="FCKeditor1" Width="100%" runat="server" Height="200px" />--%>
                                                                                <FTB:FreeTextBox ID="FCKeditor1" Width="100%" runat="server" Height="200px">
                                                                                </FTB:FreeTextBox>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div id="divHandTable1" class="padding7" style="display: none;">
                                                                                <div id="handontable1">
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div id="divFCKeditor2" style="padding: 7px; display: none;">
                                                                                <%--   <FCKeditorV2:FCKeditor ID="FCKeditor2" Width="100%" runat="server" Height="200px" />--%>
                                                                                <FTB:FreeTextBox ID="FCKeditor2" Width="100%" runat="server" Height="200px">
                                                                                </FTB:FreeTextBox>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div id="divHandTable2" class="padding7" style="display: none;">
                                                                                <div id="handontable2">
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div id="divFCKeditor3" class="padding7" style="display: none;">
                                                                                <%--    <FCKeditorV2:FCKeditor ID="FCKeditor3" Width="100%" runat="server" Height="200px" />--%>
                                                                                <FTB:FreeTextBox ID="FCKeditor3" Width="100%" runat="server" Height="200px">
                                                                                </FTB:FreeTextBox>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <!-- tabular interpretation ends -->
                                                            </ContentTemplate>
                                                        </ajc:TabPanel>
                                                        <ajc:TabPanel runat="server" HeaderText="Remarks" ID="TabNotesNRemarks" CssClass="dataheadergroup"
                                                            meta:resourcekey="TabNotesNRemarksResource1">
                                                            <ContentTemplate>
                                                                <table class="a-center w-100p">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblRemarksType" Text="Type" runat="server" meta:resourcekey="lblRemarksTypeResource1"></asp:Label>
                                                                            &nbsp;&nbsp;
                                                                            <asp:DropDownList runat="server" ID="ddlRemarksType" CssClass="ddlsmall" meta:resourcekey="ddlRemarksTypeResource1">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblRemarksText" Text="Text" runat="server" meta:resourcekey="lblRemarksTextResource1"></asp:Label>&nbsp;
                                                                            <asp:TextBox ID="txtRemarks" onFocus="validateType();" runat="server" MaxLength="50"
                                                                                CssClass="Txtboxlarge" TabIndex="1" meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                                                                            &nbsp;
                                                                            <ajc:AutoCompleteExtender ID="ACERemarks" runat="server" TargetControlID="txtRemarks"
                                                                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box bigList"
                                                                                CompletionListItemCssClass="wordWheel itemsMain bigList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 bigList"
                                                                                ServiceMethod="GetRemarkDetails" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                DelimiterCharacters="" Enabled="True" OnClientItemSelected="SelectedRemarks"
                                                                                OnClientPopulated="RemarksPopulated">
                                                                            </ajc:AutoCompleteExtender>
                                                                            <asp:Button ID="btnAddRemarks" runat="server" Text="&nbsp;&nbsp;&nbsp;Add&nbsp;&nbsp;&nbsp;"
                                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                                OnClientClick="return AddRemarks()" meta:resourcekey="btnAddRemarksResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <div class="mytable1" style="overflow: auto; height: 200px">
                                                                                <table id="tblRemarks" class="w-100p">
                                                                                    <thead>
                                                                                        <tr class="dataheader1 h-17">
                                                                                            <th>
                                                                                                <asp:Label runat="server" ID="thRemarks" Text="Text" meta:resourcekey="thRemarksResource1" />
                                                                                            </th>
                                                                                            <th class="w-15p">
                                                                                                <asp:Label runat="server" ID="thRemarksType" Text="Type" meta:resourcekey="thRemarksTypeResource1" />
                                                                                            </th>
                                                                                            <th class="a-center w-5p">
                                                                                                <asp:Label runat="server" ID="lblAction" Text="Action" meta:resourcekey="lblActionResource1" />
                                                                                            </th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <asp:Repeater ID="rptRemarks" runat="server">
                                                                                            <ItemTemplate>
                                                                                                <tr class="h-17">
                                                                                                    <td class="a-left">
                                                                                                        <%# Eval("RemarksText") %>
                                                                                                    </td>
                                                                                                    <td class="a-left">
                                                                                                        <asp:HiddenField ID="hdnRemarksID" runat="server" Value='<%# Eval("RemarksID") %>' />
                                                                                                        <asp:Label ID="lblRemarksType" runat="server" Text='<%# Eval("RemarksType") %>' meta:resourcekey="lblRemarksTypeResource2"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="a-center">
                                                                                                        <asp:Button ID="btnRemarks" runat="server" CssClass="font11 btn" Text="Delete" Style="background-color: Transparent;
                                                                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;"
                                                                                                            OnClientClick="return onRemarksDelete(this);" meta:resourcekey="btnRemarksResource1" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                        </asp:Repeater>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ContentTemplate>
                                                        </ajc:TabPanel>
                                                        <ajc:TabPanel runat="server" HeaderText="Processing Location" ID="PnlProcessingLocation"
                                                            CssClass="dataheadergroup" meta:resourcekey="PnlProcessingLocationResource1">
                                                            <ContentTemplate>
                                                                <table class="a-center w-100p">
                                                                    <tr>
                                                                        <td class="w-50p">
                                                                            <fieldset>
                                                                                <legend>
                                                                                    <asp:Label ID="fldProcessingLocation" runat="server" Text="Processing Location Mapping"
                                                                                        meta:resourcekey="fldProcessingLocationResource1"></asp:Label>
                                                                                </legend>
                                                                                <table class="w-100p">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label ID="lblProcessedType" runat="server" Text="Processed Type" meta:resourcekey="lblProcessedTypeResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td class="a-left">
                                                                                            <span class="richcombobox" style="width: 175px">
                                                                                                <asp:DropDownList ID="drpType" runat="server" CssClass="ddlsmall" onchange="javascript:Onchangeprocesstype();"
                                                                                                    meta:resourcekey="drpTypeResource1">
                                                                                                </asp:DropDownList>
                                                                                            </span>
                                                                                        </td>
                                                                                        <td colspan="1">
                                                                                            <asp:Label ID="lblRegLocation" runat="server" Text="Register Location" meta:resourcekey="lblRegLocationResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td class="a-left" colspan="1">
                                                                                            <span class="richcombobox" style="width: 175px">
                                                                                                <asp:DropDownList ID="drpRegLocation" runat="server" CssClass="ddlsmall" onchange="javascript:validateRegisterLocation();"
                                                                                                    meta:resourcekey="drpRegLocationResource1">
                                                                                                </asp:DropDownList>
                                                                                            </span>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label ID="lblProcessingOrg" runat="server" Text="Processing Org" meta:resourcekey="lblProcessingOrgResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td class="a-left">
                                                                                            <span class="richcombobox" style="width: 175px">
                                                                                                <asp:DropDownList ID="drpProcessingOrg" runat="server" CssClass="ddlsmall" onchange="javascript:OnchangeOrg();">
                                                                                                </asp:DropDownList>
                                                                                            </span>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblProcessingLocation" runat="server" Text="Process Location" meta:resourcekey="lblProcessingLocationResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td class="a-left">
                                                                                            <span class="richcombobox" style="width: 175px">
                                                                                                <asp:DropDownList ID="drpProcessLocation" runat="server" CssClass="ddlsmall">
                                                                                                </asp:DropDownList>
                                                                                            </span>
                                                                                        </td>
                                                                                        <td class="a-left">
                                                                                            <asp:Button ID="btnProcessingLocation" runat="server" Text="Add" CssClass="btn w-55"
                                                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return AddProcessingLocation()"
                                                                                                meta:resourcekey="btnProcessingLocationResource1" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <br />
                                                                                <br />
                                                                                <div id="divProcessLocMapping" class="mytable1" style="overflow: auto; height: 200px;">
                                                                                    <table id="Tabel1" class="mytable1 w-100p">
                                                                                        <thead>
                                                                                            <tr class="dataheader1 h-5">
                                                                                                <th>
                                                                                                    <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_09 %>
                                                                                                </th>
                                                                                                <th>
                                                                                                    <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_10 %>
                                                                                                </th>
                                                                                                <th>
                                                                                                    <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_11 %>
                                                                                                </th>
                                                                                                <th>
                                                                                                    <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_12 %>
                                                                                                </th>
                                                                                                <th>
                                                                                                    
                                                                                                    <%=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_26 %>
                                                                                                </th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <asp:Repeater ID="rptInvLocationMapping" runat="server">
                                                                                                <ItemTemplate>
                                                                                                    <tr class="h-5">
                                                                                                        <td class="a-left">
                                                                                                            <asp:HiddenField ID="hdnInvestigationID" runat="server" Value='<%# Eval("Id") %>' />
                                                                                                            <asp:Label ID="lblType" runat="server" Text='<%# Eval("TypeName") %>' meta:resourcekey="lblTypeResource1"></asp:Label>
                                                                                                            <asp:HiddenField ID="hdnType" runat="server" Value='<%# Eval("Type") %>' />
                                                                                                            <span id="spanType" runat="server" style="display: none">
                                                                                                                <%# Eval("Type") %></span>
                                                                                                            <%--  <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TypeName") %>'/>--%>
                                                                                                        </td>
                                                                                                        <td class="a-left">
                                                                                                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("OrgName") %>' meta:resourcekey="Label9Resource1"></asp:Label>
                                                                                                            <asp:HiddenField ID="hdnRegLocation" runat="server" Value='<%# Eval("LocationID") %>' />
                                                                                                        </td>
                                                                                                        <td class="a-left">
                                                                                                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("ProcessingOrgName") %>' meta:resourcekey="Label10Resource1"></asp:Label>
                                                                                                            <asp:HiddenField ID="hdnProcessingOrg" runat="server" Value='<%# Eval("ProcessingOrgID") %>' />
                                                                                                        </td>
                                                                                                        <td class="a-left">
                                                                                                            <asp:Label ID="Label11" runat="server" Text='<%# Eval("ProcessingLocation") %>' meta:resourcekey="Label11Resource1"></asp:Label>
                                                                                                            <asp:HiddenField ID="hdnProcLocation" runat="server" Value='<%# Eval("ProcessingAddressID") %>' />
                                                                                                        </td>
                                                                                                        <td class="a-center">
                                                                                                            <input id="btnDeleteLocation" runat="server" class="font10" text="Delete" type="button" value="Delete" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline;
                                                                                                                cursor: pointer;" onclick="DeleteLocation(this);" />
                                                                                                                
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                            </fieldset>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ContentTemplate>
                                                        </ajc:TabPanel>
                                                    </ajc:TabContainer>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="a-center">
                                    <td colspan="2">
                                        <asp:Label ID="lblReason1" runat="server" Text="Select Reason" meta:resourcekey="lblReason1Resource1" />
                                        &nbsp;
                                        <asp:DropDownList ID="ddlReasonn" runat="server" AutoPostBack="false" CssClass="ddlsmall">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                        &nbsp;
                                        <asp:Label ID="lblAjaxBusy" Text="Please Wait..." runat="server" Style="display: none;"
                                            meta:resourcekey="lblAjaxBusyResource1" />
                                        <asp:Label ID="lblDelete" Text="Delete" runat="server" Style="display: none;" meta:resourcekey="lblDeleteResource1" />
                                        <asp:Button ID="btnSave" ToolTip="Click here to Save Details" Style="cursor: pointer;"
                                            runat="server" Text="&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;" CssClass="btn"
                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Enabled="False"
                                            OnClick="btnSave_Click" OnClientClick="return onSave()" meta:resourcekey="btnSaveResource1" />
                                        &nbsp;&nbsp;
                                        <asp:Button ID="btnReset" runat="server" Text="&nbsp;&nbsp;&nbsp;Reset&nbsp;&nbsp;&nbsp;"
                                            ToolTip="Click here to Cancel, View Home Page" Style="cursor: pointer;" CssClass="btn"
                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" OnClick="btnReset_Click"
                                            meta:resourcekey="btnResetResource1" />
                                    </td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="hdnHandsonTable1Data" runat="server" />
                            <asp:HiddenField ID="hdnHandsonTable2Data" runat="server" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnLoadGroupDetails" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </ajc:TabPanel>
        </ajc:TabContainer>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnSelectedRemarksID" runat="server" />
    <asp:HiddenField ID="hdnRemarksContent" runat="server" />
    <asp:HiddenField ID="hdnRemarksTypeName" runat="server" />
    <asp:HiddenField ID="hdnInvID" runat="server" />
    <asp:HiddenField ID="hdnshowid" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdncheckid" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hdnLstInvRemarks" runat="server" />

    <script type="text/javascript" language="javascript">

        function closepanel() {
            //window.opener =self;
            //window.close();
            //return false;
            //            window.location = "TestGroup.aspx";
            //                        var tabContainer = $find('grouptab');
            //alert(tabContainer);
            //                        tabContainer.set_activeTabIndex(1);
            //$find("grouptab_addgrouptab_mpe").hide();
        }
        function show(id) {
            //PageMethods.Execute(id);
            document.getElementById('hdnshowid').value = id;

            __doPostBack('grouptab$addgrouptab$LinkButton1', '')
            //document.getElementById('<LinkButton1').click();
            //return true;
            //            __doPostBack('Execute', id);


        }
        function clicked(id) {

            show(id);
            //window.setTimeout("show1()", 2000);
        }

        function show1() {
            //document.getElementById('hdncheckid').value = 0;
            //            var i = show(id);
            //            if (document.getElementById('hdncheckid').value == id) {
            //                alert(i);
            //$find("grouptab_addgrouptab_mpe").show();
            //$('#grouptab_addgrouptab_lnk').click();
            __doPostBack('grouptab$addgrouptab$lnk', '')
            //}
            // alert('hi');
        }
        function validatePageNumber() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vPageNotValid = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_08') == null ? "The Page is not valid" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_08');
            var Totalpage = document.getElementById('<%= hdnTotalPage.ClientID %>').value;
            var pageno = $('[id$="txtpageNo"]').val();
            if ($('[id$="txtpageNo"]').val().trim() == "") {

                return false;
            }
            if (parseInt(pageno) > parseInt(Totalpage)) {
                //alert("The Page is not valid");
                ValidationWindow(vPageNotValid, AlertType);
                $('[id$="txtpageNo"]').val('');
                return false;
            }         
            
        }
        
        
    </script>

    <%--
    <script type="text/javascript" src="../Scripts/handsontable/lib/jquery-1.9.1.min.js"></script>
--%>

    <script type="text/javascript" src="../Scripts/handsontable/dist/jquery.handsontable.full.js"></script>

    <script type="text/javascript" src="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.js"></script>

    <asp:HiddenField ID="hdnSelectedLayout" runat="server" Value="layout1" />
    <asp:HiddenField ID="hdnHandsonTable1" runat="server" />
    <asp:HiddenField ID="hdnHandsonTable2" runat="server" />
    <asp:HiddenField ID="hdnIsEmptyHandsonTable1" runat="server" />
    <asp:HiddenField ID="hdnIsEmptyHandsonTable2" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnHandsonTable1ColumnCount" runat="server" />
    <asp:HiddenField ID="hdnHandsonTable2ColumnCount" runat="server" />
    <asp:HiddenField ID="hdnInvLocationMapping" runat="server" />
    <asp:HiddenField ID="hdnInvLocation" runat="server" />
    <asp:HiddenField ID="hdnSelectedOrgID" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnLocationID" runat="server" />
    
 
    </form>
</body>
</html>

<script type="text/jscript">

    var drpProcessLocation = '<%=drpProcessLocation.ClientID %>';
    var drpProcessingOrg = '<%=drpProcessingOrg.ClientID %>';
    var drpRegLocation = '<%=drpRegLocation.ClientID %>';
    var drpType = '<%=drpType.ClientID %>';
    var hdnInvLocationMapping = '<%=hdnInvLocationMapping.ClientID %>';
    var hdnInvLocation = '<%=hdnInvLocation.ClientID %>';
    var hdnSelectedOrgID = '<%=hdnSelectedOrgID.ClientID %>';
    var hdnOrgID = '<%=hdnOrgID.ClientID %>';
    var hdnInvID = '<%=hdnInvID.ClientID %>';





    function OnchangeOrg() {
        var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
        var loc = SListForAppMsg.Get("Admin_TestInvestigation_aspx_21") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_21") : "Select Register Location";
        //   debugger;
        try {
            var ProcessType = $('#' + drpType + ' option:selected');
            var RegLocation = $('#' + drpRegLocation + ' option:selected');
            if ($(RegLocation).val() == '0') {
                $('[id$="drpProcessingOrg"] option:first').attr('selected', true);
                ValidationWindow(loc, Error);
                //alert("Select Register Location");
                return false;

            }
            $('#' + drpProcessLocation).children('option:not(:first)').remove();
            var processorgid = $('#' + drpProcessingOrg + ' option:selected');
            var processLocation = $('#' + drpProcessLocation + ' option:selected');
            $('#<%=drpProcessLocation.ClientID %>').prop('disabled', false);
            $('#' + hdnSelectedOrgID).val($(processorgid).val());
            if ($(processorgid).val() != '0') {

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetProcessingOrgLocation",
                    data: "{OrgID:" + $('#' + hdnSelectedOrgID).val() + ",OrgName:'" + $(processorgid).text() + "',Type:'" + $(ProcessType).val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function Success(data) {
                        var lstProcessLocation = data.d;
                        if (lstProcessLocation.length > 0) {
                            for (var i = 0; i < lstProcessLocation.length; i++) {
                                $('#' + drpProcessLocation).append($("<option></option>").val(lstProcessLocation[i].AddressID).html(lstProcessLocation[i].Location));
                            }
                        }

                        if ($(ProcessType).val() == 'OUT') {

                            //                           $('#drpProcessLocation').attr('selectedIndex', 2);
                            $('[id$="drpProcessLocation"] option:last').attr('selected', true);
                            $('#<%=drpProcessLocation.ClientID %>').prop('disabled', true);

                        }

                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        // alert(xhr.status);
                        ValidationWindow(xhr.status, Error);
                    }

                });
            }

        }

        catch (e) {
            return false;
        }

    }

    function Onchangeprocesstype() {
        //        debugger;
        try {

            $('#' + drpProcessingOrg).children('option:not(:first)').remove();
            var typeID = $('#' + drpType + ' option:selected');
            var orgID = $('#' + hdnOrgID).val();
            if ($(typeID).val() != '0') {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetTestProcessingOrgName",
                    data: "{OrgID: " + orgID + ",SubCategory:'" + $(typeID).val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "JSON",
                    success: function(data) {
                        var lstOrg = data.d;

                        if (lstOrg.length > 0) {
                            for (var i = 0; i < lstOrg.length; i++) {

                                $('#' + drpProcessingOrg).append($("<option></option>").val(lstOrg[i].OrgID).html(lstOrg[i].Name));
                            }
                        }

                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        //alert(xhr.status);
                        ValidationWindow(xhr.status, Error);
                    }

                });

            }
        }
        catch (e) {
            return false;
        }
    }


    function AddProcessingLocation() {
        //        debugger;
        try {
            var SelectType = $('#' + drpType + ' option:selected ');
            var SelectRegLocation = $('#' + drpRegLocation + ' option:selected ');
            var SelectProcOrg = $('#' + drpProcessingOrg + ' option:selected ');
            var SelectProcLocation = $('#' + drpProcessLocation + ' option:selected ');
            //              if ($(SelectType).val() == 'OUT') {
            //                  SelectProcLocation = $('#' + drpProcessingOrg + ' option:selected ');
            //              }

            if ($(SelectType).val() == '0' || $(SelectRegLocation).val() == '0' || $(SelectProcOrg).val() == '0' || $(SelectProcLocation).val() == '0') {
                var userMsg = SListForAppMsg.Get("Admin_TestGroup_aspx_17") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_17") : "Select the Processing Location Values";
                var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
                ValidationWindow(userMsg, Error);
                ///                alert("Select the Processing Location Values");
                return false;

            }
            else {
                //                debugger;
                var SelectType1 = $(SelectType).val();
                var hdnInvestigationID = '<input id="hdnInvestigationID" type="hidden" value="0"/>';
                var hdnType = '<input id="hdnType" type="hidden" value="' + $(SelectType).val() + '"/>';
                var hdnRegLocation = '<input id="hdnRegLocation" type="hidden" value="' + $(SelectRegLocation).val() + '">'
                var hdnProcessingOrg = '<input id="hdnProcessingOrg" type="hidden" value="' + $(SelectProcOrg).val() + '">'
                var hdnProcLocation = '<input id="hdnProcLocation" type="hidden" value="' + $(SelectProcLocation).val() + '">'
                var hdnInvestigationID = '<input id="hdnInvestigationID" type="hidden" value="0"/>';
                var spanType = '<span id="spanType" style="display:none">"' + SelectType1 + '"</span>';




                var Type = $(SelectType).text();
                var RegLocation = $(SelectRegLocation).text();
                var ProcessingOrg = $(SelectProcOrg).text();
                var ProcLocation = $(SelectProcLocation).text();

                //                var InvLocationMapping = document.getElementById(hdnInvLocationMapping).value.split("^");
                //                for (var i = 0; i < InvLocationMapping.length; i++) {
                //                    var Mappingvalues = InvLocationMapping[i].split("|");
                //                    
                //                    if (Mappingvalues[0] == $(hdnType).val() && Mappingvalues[1] == $(hdnRegLocation).val() && Mappingvalues[2] == $(hdnProcessingOrg).val() && Mappingvalues[3] == $(hdnProcLocation).val()) {
                //                        alert("Mapping Values Already Exists");
                //                        return false;
                //                    }

                //                }

                var $trow = "<tr><td>" + hdnInvestigationID + spanType + hdnType + Type + "</td><td>" + hdnRegLocation + RegLocation + "</td><td>" + hdnProcessingOrg + ProcessingOrg + "</td><td>" + hdnProcLocation + ProcLocation + "</td><td align='center'><input id='btnDeleteLocation' value='Delete' type='button' style='background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 10px;' onclick='DeleteLocation(this);' /></td></tr>"

                $("#Tabel1 tbody").append($trow);
                $('#' + drpType + ' option:first').attr('selected', true);
                $('#' + drpRegLocation + ' option:first').attr('selected', true);
                $('#' + drpProcessingOrg + ' option:first').attr('selected', true);
                $('#' + drpProcessLocation + ' option:first').attr('selected', true);
                $('#' + drpProcessingOrg).children('option:not(:first)').remove();
                $('#' + drpProcessLocation).children('option:not(:first)').remove();

                //                if ($(SelectType).val() != "" && $(SelectRegLocation).val() != "" && $(SelectProcOrg).val() != "" && $(SelectProcLocation).val() != "") {

                //                    document.getElementById(hdnInvLocationMapping).value += $(SelectType).val() + "|" + $(SelectRegLocation).val() + "|" + $(SelectProcOrg).val() + "|" + $(SelectProcLocation).val() + "^";
                //                }

                return false;
            }
        }
        catch (e) {
            return false;
        }

    }



    function DeleteLocation(obj) {
        //        debugger;
        try {
            var $row = $(obj).closest('tr');
            var hdnSelInvLocID = $row.find("input[id$='hdnInvestigationID']").val();
            if (hdnSelInvLocID == '' || hdnSelInvLocID == '0') {
                hdnSelInvLocID = -1;
            }
            if (hdnSelInvLocID == -1) {
                $(obj).closest('tr').remove();
            }
            else {
                var txtDelete = confirm('Are you sure to delete this record Permanently');
                if (txtDelete == false) {
                    return false;
                }
                var invID = $('#' + hdnInvID).val();
                var orgID = $('#' + hdnOrgID).val();
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/DeleteInvLocationMapping",
                    data: "{ID: " + hdnSelInvLocID + ",InvID: " + invID + ",OrgID: " + orgID + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        $(obj).closest('tr').remove();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        var userMsg = SListForAppMsg.Get("Admin_TestGroup_aspx_18") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_18") : "Unable to delete";
                        var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
                        ValidationWindow(userMsg, Error);
                        //alert("Unable to delete");
                    }
                });
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }

    function validateRegisterLocation() {
        //        debugger;

        document.getElementById(hdnInvLocationMapping).value = '';

        $('#Tabel1 tbody tr').each(function(i, n) {
            var $row = $(n);
            var RegLocation = $row.find("input[id$='hdnRegLocation']").val();
            document.getElementById(hdnInvLocationMapping).value += RegLocation + "|";

        });
        var SelectRegLocation = $('#' + drpRegLocation + ' option:selected').val();
        var oldvalue = document.getElementById(hdnInvLocationMapping).value.split("|");
        for (var i = 0; i < oldvalue.length; i++) {
            if (oldvalue[i] != "") {
                if (SelectRegLocation == oldvalue[i]) {
                    $('[id$="drpRegLocation"] option:first').attr('selected', true);
                    var userMsg = SListForAppMsg.Get("Admin_TestGroup_aspx_19") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_19") : "Register Location Already Exists";
                    var Error = SListForAppMsg.Get("Admin_TestGroup_aspx_22") != null ? SListForAppMsg.Get("Admin_TestGroup_aspx_22") : "Alert";
                    ValidationWindow(userMsg, Error);
                    //alert("Register Location Already Exists");
                    return false;
                }
            }

        }
    }
    $(document).ready(function() {
        try {
            $('#handontable1').handsontable({
                minRows: 4,
                minCols: 4,
                startRows: 5,
                startCols: 5,
                rowHeaders: true,
                colHeaders: true,
                minSpareRows: 1,
                minSpareCols: 1,
                contextMenu: false,
                manualColumnResize: true,
                useFormula: false,
                autoWrapRow: true,
                cells: function(row, col, prop) {
                    this.renderer = htmlRenderer;
                }
            });
            $('#handontable2').handsontable({
                minRows: 4,
                minCols: 4,
                startRows: 5,
                startCols: 5,
                rowHeaders: true,
                colHeaders: true,
                minSpareRows: 1,
                minSpareCols: 1,
                contextMenu: false,
                manualColumnResize: true,
                useFormula: false,
                autoWrapRow: true,
                cells: function(row, col, prop) {
                    this.renderer = htmlRenderer;
                }
            });
        }
        catch (e) {
            return false;
        }
    });
    function ChangeSynoptic() {
        var ChkSynoptic = '<%=ChkSynoptic.ClientID%>';
        var IsSynoptic = $('#' + ChkSynoptic).is(':checked') ? 'Y' : 'N';
        var chkIsOrder = '<%=chkIsOrder.ClientID%>';
        if (IsSynoptic == "Y") {
            $('#' + chkIsOrder).prop('checked', true);
        }
        else {
            $('#' + chkIsOrder).prop('checked', false);
        }
    }
    function ShowPopUp() {
        //  var visitnovalue = visitnumber.innerText;


        var ReturnValue = window.open("..\\Admin\\LabMaster.aspx?IsPopup=Y", "", "height=800,width=1000,scrollbars=Yes");


    }
 
</script>

