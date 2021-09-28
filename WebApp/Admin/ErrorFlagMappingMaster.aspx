<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErrorFlagMappingMaster.aspx.cs"
    Inherits="Admin_ErrorFlagMappingMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<title>Error Flag Mapping Master</title>--%>
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <%-- Add / Edit --%>

    <script type="text/javascript">
        function Add_Or_EditItem() {
            debugger;
            //var status = Validation();
            if (!Validation())
                return;

            var lstDevErrorInfo = [];
            var instrumentID = $.trim($('#hf_EqpName_Or_Code').val());
            var deviceCode = $.trim($('#txt_EqpName_Or_Code').val());
            var errorCode = $.trim($('#txt_Error_Code').val());
            var errorDesc = $.trim($('#txt_Error_Desc').val());
            var resultVal = $.trim($('#txt_ErrorRslt_Val').val());
            var orgId = $.trim($('#hdnOrgId').val());
            var locId = $.trim($('#hdnILocID').val());
            var isActive = "";
            
            var isEditMode = $.trim($('#hdnIsEditMode').val());
            if (isEditMode != "1") {
                isActive = '1';
            }
            else {
                isActive = document.getElementById('hdnEditFldFldActivOrNot').value;
            }
                
            lstDevErrorInfo.push({
                InstrumentID: instrumentID,
                DeviceCode: deviceCode,
                ErrorCode: errorCode,
                ErrorDescription: errorDesc,
                ResultValue: resultVal,
                OrgID: orgId,
                OrgAddressID: locId,
                IsActive: isActive
            });
            var _jsonStringData = JSON.stringify(lstDevErrorInfo);

            debugger;
            var dataStr = "";
            var urlPath = "";
            
            if (isEditMode != "1") {

                urlPath = "../WebService.asmx/AddDeviceErrorInfo";
                dataStr = "{ JsonStringData: '" + _jsonStringData + "'}";
            }
            else {
                urlPath = "../WebService.asmx/EditDeviceErrorInfo";

                var array = $('#hdnEditId').val().split('|');
                dataStr = "{ JsonStringData: '" + _jsonStringData + "',edit_EquipID:'" + array[0] + "',edit_ErrorCode:'" + array[1] + "'}";
            }

            $.ajax({
                type: "POST",
                url: urlPath,
                data: dataStr,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    var reslt = data.d;
                    var alertMsg = "";
                    if (reslt != '') {
                        if (isEditMode != "1")
                            msg = "Error Flag Mapping info Added..!";
                        else
                            msg = "Error Flag Mapping info Updated..!";
                    }
                    else {
                        alertMsg = "Unable to add/edit Device error code Info..";
                    }


                    $('#gv_Tbl').DataTable().fnDestroy();
                    GetData();

                    debugger;
                    Reset();
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }

            });
        }     
        
    </script>

    <%-- Reset --%>

    <script type="text/javascript">

        function Reset() {
            debugger;
            document.getElementById('txt_EqpName_Or_Code').value = "";
            document.getElementById('txt_Error_Code').value = "";
            document.getElementById('txt_Error_Desc').value = "";
            document.getElementById('txt_ErrorRslt_Val').value = "";
            document.getElementById('btn_AddErrorFlag').value = 'Add';

            document.getElementById('hdnIsEditMode').value = "0"; //true
            document.getElementById('hf_EqpName_Or_Code').value = "";
            document.getElementById('hdnEditId').value = "";
            document.getElementById('hdnEditFldFldActivOrNot').value = "";
        }
    </script>

    <%-- Import --%>

    <script type="text/javascript">

        function HideGetPathPopup() {

            document.getElementById("fileUpload").value = "";

            $find('mpeGetPath').hide();
            document.getElementById('hdnIsStopRender').value = "0"; //No
        }

        function ShowGetPathPopup() {
            debugger;
            document.getElementById('hdnIsStopRender').value = "1"; //Yes
            $find('mpeGetPath').show();
        }      
    </script>

    

    <script type="text/javascript">

        function Upload() {

            if (!validate_importFile()) {
                return;
            }
        }

        function validate_importFile() {

            if (!IsValidFileFormat()) {
                alert("Please upload a valid CSV file.");
                return false;
            }

            ReadImportFile();
        }

        function IsValidFileFormat() {
            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv)$/;
            if (regex.test($("#fileUpload").val().toLowerCase())) {
                return true;
            }
            else {
                return false;
            }
        }        
    </script>

    <script type="text/javascript">
        function Upload_new() {
            var fileUpload = document.getElementById("fileUpload");
            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
            if (regex.test(fileUpload.value.toLowerCase())) {
                debugger;
                if (typeof (FileReader) != "undefined") {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        debugger;
                        var linesArray = [];

                        //                        var table = document.createElement("table");
                        var rows = e.target.result.split("\n");
                        //first line is header.. So Skipped
                        var idx = 0;
                        for (var i = 1; i < rows.length; i++) {

                            if (rows[i] != "")
                                linesArray[idx++] = rows[i];
                        }
                        debugger;
                        if (IsValidImportFile(linesArray)) {
                            var jsonStr = GetJsonString(linesArray);
                            LoadImportedItemToGrid(jsonStr);
                        }

                    }
                    reader.readAsText(fileUpload.files[0]);
                } else {
                    alert("This browser does not support HTML5.");
                }
            } else {
                alert("Please upload a valid CSV file.");
            }
        }

        function IsValidImportFile(lineArrray) {

            for (var i = 0; i < lineArrray.length; i++) {
                var cellArray = lineArrray[i].split(",");
                var productName = "";
                for (var j = 0; j < cellArray.length; j++) {
                    var item = cellArray[j].trim();

                    switch (j) {
                        case 0:

                            break;

                        case 1:
                            if (item == "") {
                                alert("Equipment Name should not empty..!");
                                return false;
                            }
                            productName = item;
                            break;
                        case 2:
                            if (item == "") {
                                alert("Equipment Code should not empty..!");
                                return false;
                            }

                            if (!IsInstrumentAvailableByNameAndID(productName, item)) {
                                alert("Invalid Equipment Info..(Equipment Name:" + productName + ", Equipment Code:" + item);
                                return false;
                            }
                            break;

                        case 3:
                            if (item == "") {
                                alert("Error Code should not empty..!");
                                return false;
                            }

                            if (IsErrorCodeAvailable(productName, item)) {
                                alert("Error Code should be unique.(Equipment Name:" + productName + ",Error Code:" + item + ")..!");
                                return false;
                            }
                            break;
                        case 4:
                            if (item == "") {
                                alert("Error Description should not empty..!");
                                return false;
                            }
                            break;

                        case 5:
                            if (item != "") {

                                var str = item.trim();
                                var regex = /^[a-zA-Z ]*$/;
                                if (!regex.test(str)) {
                                    alert("Result value should be alphabet..!");
                                    return false;
                                }
                            }
                            break;
                        default:

                            break;
                    }
                }
            }
            return true;
        }

        function GetJsonString(lineArrray) {

            var isActive = "1";
            var lstDevErrorInfo = [];
            var orgId = $.trim($('#hdnOrgId').val());
            var locId = $.trim($('#hdnILocID').val());
            for (var i = 0; i < lineArrray.length; i++) {

                var line = $.trim(lineArrray[i]);
                var cellArray = line.split(",");

                var instrumentID = "";
                var idStr = GetInstrumentID(cellArray[1]);
                if (idStr != "") {
                    instrumentID = parseInt(idStr);
                }

                var resultVal = "";
                if (cellArray.length > 5)
                    resultVal = cellArray[5];

                lstDevErrorInfo.push({
                    InstrumentID: instrumentID,
                    ProductName: cellArray[1],
                    DeviceCode: cellArray[2],
                    ErrorCode: cellArray[3],
                    ErrorDescription: cellArray[4],
                    ResultValue: resultVal,
                    OrgID: parseInt(orgId),
                    OrgAddressID: parseInt(locId),
                    IsActive: isActive
                });
            }


            var _jsonStringData = JSON.stringify(lstDevErrorInfo);

            return _jsonStringData;
        }

        function LoadImportedItemToGrid(jsonItems) {

            debugger;

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ImportDeviceErrorInfo",
                data: "{ jsonItems: '" + jsonItems + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    var reslt = data.d;
                    var alertMsg = "";
                    if (reslt) {
                        alert("Imported Sucessfully..!");

                        //document.getElementById("fileUpload").value = "";
                        HideGetPathPopup();
                    }
                    else {
                        alert("Unable to Import..!");
                    }

                    $('#gv_Tbl').DataTable().fnDestroy();
                    GetData();

                    debugger;
                    Reset();
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }

            });
        }
             
    </script>

    <%-- Load DeviceFlagInfo For Edit--%>
    <script type="text/javascript">

        function LoadDeviceFlagInfo_Edit(data) {
            debugger;
            if (data == null)
                return;

            var array = data.split(",");
            document.getElementById('txt_EqpName_Or_Code').value = array[0];
            document.getElementById('txt_Error_Code').value = array[1];
            document.getElementById('txt_Error_Desc').value = array[2];
            document.getElementById('txt_ErrorRslt_Val').value = array[3];

            var ids = array[4].split("|");
            document.getElementById('hf_EqpName_Or_Code').value = ids[0];
            document.getElementById('hdnEditId').value = array[4]; //instrumentId+|+symbol

            document.getElementById('hdnIsEditMode').value = "1"; //true
            document.getElementById('btn_AddErrorFlag').value = 'Update';

            document.getElementById('hdnEditFldFldActivOrNot').value = array[5];
        }             
        
    </script>

    <%-- Delete --%>

    <script type="text/javascript">

        function DeleteDeviceInfo(data) {
            debugger;
            //alert('Delete-' + data);
            var txtCancel = confirm('Are you sure you wish to delete..?');
            if (txtCancel == false) {
                return false;
            }

            if (data == null)
                return;
            var array = data.split(",");

            DeleteErrorMapInfo(array[0], array[1]);
        }

        function DeleteErrorMapInfo(equipId, errorcode) {
            try {
                debugger;
                $.ajax(
                {
                    type: "POST",
                    url: "../WebService.asmx/DeleteDeviceErrorInfo",
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'equipId': '" + equipId + "','errorCode': '" + errorcode + "'}",
                    dataType: "json",
                    success: DeleteStatus,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError);
                        return false;
                    }
                });
            }
            catch (e) {

            }
        }

        function DeleteStatus(result) {
            debugger;
            if (result) {
                Reset();
                $('#gv_Tbl').DataTable().fnDestroy();
                GetData();
                //alert("Error Flag Mapping Info Deleted..!");
            }
            else
                alert("Unable to Delete Error Flag Mapping Info..!");

        }
    </script>

    <%-- Load and Draw Table --%>

    <script type="text/javascript">
       
        function DeviceInfoActivateOrNot(equipIdWithErrorCode) {
            try {
                debugger;
                var array = equipIdWithErrorCode.split("|");

                $.ajax(
                {
                    type: "POST",
                    url: "../WebService.asmx/DeviceErrorInfoActivateOrNot",
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'equipId': '" + array[0] + "','errorCode': '" + array[1] + "'}",
                    dataType: "json",
                    success: ActivateStatus,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError);
                        return false;
                    }
                });
            }
            catch (e) {

            }
        }

        function ActivateStatus(result) {
            debugger;
            if (result) {
                //Reset();
                $('#gv_Tbl').DataTable().fnDestroy();
                //alert("mes")
                GetData();

            }
            else
                alert("Unable to Activate/Deactivate Error Flag Mapping Info..!");

        }
        
    </script>

    <%-- Load and Draw Table --%>

    <script type="text/javascript">

        function GetData() {
            try {
                debugger;
                $.ajax(
                {
                    type: "POST",
                    url: "../WebService.asmx/GetErrorMapInfo",
                    contentType: "application/json; charset=utf-8",
                    data: "",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError);
                        $('#gv_Tbl').hide();

                        return false;
                    }
                });
            }
            catch (e) {

            }
        }

        function AjaxGetFieldDataSucceeded(result) {
            debugger;
            var oTable;

            if (result != "[]") {

                LoadErrorCodeHdnFld(result);

                debugger;
                oTable = $('#gv_Tbl').dataTable(
                {

                    oLanguage:
                    {
                        "sUrl": getLanguage()
                    },
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bRetrieve": true,
                    "serverSide": true,
                    "aaData": result.d,
                    "aoColumns":
                    [

                    {
                        "mDataProp": "SNO", sClass: "a-center",

                        //                        //                "mRender": function(data, type, row, meta) {
                        //                        "Render": function(data, type, row, meta) {
                        //                            alert(data);
                        //                            var id = meta.row + meta.settings._iDisplayStart + 1;
                        //                            return '<label id="SNO">' + meta.row + meta.settings._iDisplayStart + 1 + '</label>';
                        //                        }
                        "fnRenderer": function(oObj) {
                            return '<label id="sno">' + oObj.aData.SNO + '</label>';
                        }
                    },
                    { "mDataProp": "ProductName", sClass: "a-center",
                        "fnRenderer": function(oObj) {
                            return '<label id="productName">' + oObj.aData.ProductName + '</label>';
                        }
                    },
                    { "mDataProp": "DeviceCode", sClass: "a-center",
                        "fnRenderer": function(oObj) {
                            return '<label id="DeviceCode">' + oObj.aData.DeviceCode + '</label>';
                        }
                    },
                    { "mDataProp": "ErrorCode", sClass: "a-center",
                        "fnRenderer": function(oObj) {
                            return '<label id="ErrorCode">' + oObj.aData.ErrorCode + '</label>';
                        }
                    },
                    { "mDataProp": "ErrorDescription", sClass: "a-center",
                        "fnRenderer": function(oObj) {
                            return '<label id="ErrorDescription">' + oObj.aData.ErrorDescription + '</label>';
                        }
                    },
                    { "mDataProp": "ResultValue", sClass: "a-center",
                        "fnRenderer": function(oObj) {
                            return '<label id="ResultValue">' + oObj.aData.ResultValue + '</label>';
                        }
                    },
                    { "mDataProp": "DeviceErrorFlagId", sClass: "a-center",
                        "mRender": function(data, type, full) {
                            if (data != '') {
                                debugger;
                                var rowId = parseInt(full["SNO"]) - 1;
                                var editStr = full["ProductName"] + "," + full["ErrorCode"] + "," + full["ErrorDescription"] + "," + full["ResultValue"] + "," + data + "," + full["IsActive"];


                                var deleteStr = full["InstrumentID"] + "," + full["ErrorCode"] + "," + rowId;
                                //return '<a href="#" onClick=" EditDeviceInfo(\'' + editStr + '\');" return false;>E</a>&nbsp;&nbsp;<a href="#" onClick=" DeleteDeviceInfo(\'' + deleteStr + '\');" return false;>D</a>'; //well
                                var editImgPath = "..\\Images\\edit.png";
                                var deleteImgPath = "..\\Images\\delete.png";

                                var isActiveSte = "Active";
                                var activateDeactivateImgPath = "..\\Images\\Active.png";
                                if (full["IsActive"] == '0') {
                                    activateDeactivateImgPath = "..\\Images\\Inactive.png";
                                    isActiveSte = "In-active";
                                }

                                //var activateStr = full["InstrumentID"] + "," + full["ErrorCode"];
                                var activateStr = data;
                                return '<img src=\'' + activateDeactivateImgPath + '\' alt="Is Active" id="IsActive" title=\'' + isActiveSte + '\'  width="15" height="15" border="0" onClick=" DeviceInfoActivateOrNot(\'' + activateStr + '\');">&nbsp;|&nbsp;<img src=\'' + editImgPath + '\' alt="Edit" id="edit" width="15" height="15" border="0" onClick=" LoadDeviceFlagInfo_Edit(\'' + editStr + '\');">&nbsp;|&nbsp;<img src=\'' + deleteImgPath + '\' alt="Delete" id="delete"  width="15" height="15" border="0" onClick=" DeleteDeviceInfo(\'' + deleteStr + '\');">';
                            }
                        }
}],

                        "sPaginationType": "full_numbers",
                        "sZeroRecords": "No records found",
                        "bSort": false,
                        "bJQueryUI": true,
                        "iDisplayLength": 5,
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        "oTableTools":
                    {
                        "sSwfPath": "", //"../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                        //                        //                            "copy", "csv", "xls", "pdf",
                        //                             "xls",
                        //                             {
                        //                                 "sExtends": "collection",
                        //                                 "sButtonText": "Save",
                        //                                 "aButtons": ["csv", "xls", "pdf"]

                        //                             }
                          ]
                    }
                    });

                    debugger;

                    $('#gv_Tbl').show();

                }
            }

            function LoadErrorCodeHdnFld(result) {
                debugger;

                var str = "";
                var len = result.d.length;
                for (var i = 0; i < len; i++) {
                    var obj = result.d[i];
                    if (str != "")
                        str += ",";

                    str += obj.InstrumentID + "|" + obj.ErrorCode;
                }

                document.getElementById('hdnErrorCodeKeys').value = str.toLowerCase();
                debugger;
            }
                    
    </script>

    <%-- Validation --%>

    <script type="text/javascript">

        function Validation() {
            debugger;
            var eqipName = document.getElementById('txt_EqpName_Or_Code').value;
            var errorFlagCode = document.getElementById('txt_Error_Code').value;
            var errorFlagDesc = document.getElementById('txt_Error_Desc').value;
            var errorFlagResult = document.getElementById('txt_ErrorRslt_Val').value;

            if (eqipName == '' && errorFlagCode == '' && errorFlagDesc == '') {
                alert("Enter 'Equipment Name/Code, ErrorCode and Flag Description'");
                return false;
            }

            if (eqipName == '') {
                alert("Please Enter 'Equipment Name/Code' value");
                return false;
            }
            else {
                debugger;

                if (!IsInstrumentAvailable(eqipName)) {
                    debugger;
                    alert("Invalid 'Equipment Name/Code' Value..!");
                    //document.getElementById('txt_EqpName_Or_Code').value = "";
                    return false;
                }
            }

            if (errorFlagCode == '') {
                alert("Please Enter 'Code Sent From the Instrument'");
                return false;
            }
            else {
                if (IsErrorCodeAvailable(eqipName, errorFlagCode)) {
                    alert("'Code Sent From the Instrument' Should be unique..!");
                    return false;
                }
            }

            if (errorFlagDesc == '') {
                alert("Please Enter 'Flag Description'");
                return false;
            }
            //            if (errorFlagResult == '') {
            //                alert("Please Enter Result Value");
            //                return false;
            //            }

            //            if (!errorFlagResult.match(/^[a-zA-Z0-9]+$/)) {
            //                alert('Resilt Value - Only alphabets are allowed');
            //                return false;
            //            }

            return true;
        }
                
    </script>

    <%-- Equip Info --%>

    <script type="text/javascript">
        function IsInstrumentAvailableByNameAndID(_equipName, _equipCode) {
            var equipName = _equipName.toLowerCase();
            var equipCode = _equipCode.toLowerCase();

            var instrumentInfo = $('#hdnInstrumentKeys').val().split(",");
            for (var i = 0; i < instrumentInfo.length; i++) {
                var propArray = instrumentInfo[i].toLowerCase().split("|");

                if (propArray[1] == equipName && propArray[2] == equipCode) {
                    return true;
                }
            }
            return false;
        }

        function IsInstrumentAvailable(equipIdOrName) {
            debugger;
            var searchKey = equipIdOrName.toLowerCase();

            var instrumentInfo = $('#hdnInstrumentKeys').val().split(",");
            for (var i = 0; i < instrumentInfo.length; i++) {
                var propArray = instrumentInfo[i].toLowerCase().split("|");

                if (propArray[1] == searchKey || propArray[2] == searchKey) {
                    return true;
                }
            }
            return false;
        }

        function GetInstrumentID(equipIdOrName) {
            debugger;
            var searchKey = equipIdOrName.toLowerCase();

            var instrumentInfo = $('#hdnInstrumentKeys').val().split(",");
            for (var i = 0; i < instrumentInfo.length; i++) {
                var propArray = instrumentInfo[i].toLowerCase().split("|");

                if (propArray[1] == searchKey || propArray[2] == searchKey) {
                    return propArray[0];
                }
            }
            return "";
        }
        
    </script>

    <script type="text/javascript">
        function IsErrorCodeAvailable(equipIdOrName, errorCode) {
            debugger;
            var searchEquipId = GetInstrumentID(equipIdOrName);
            var searchErrorCode = errorCode.toLowerCase();
            var isEditMode = $('#hdnIsEditMode').val() == "1" ? true : false;
            var array = $('#hdnEditId').val().split('|');

            var errorFlagKeyArray = $('#hdnErrorCodeKeys').val().split(",");
            for (var i = 0; i < errorFlagKeyArray.length; i++) {
                var propArray = errorFlagKeyArray[i].toLowerCase().split("|");

                if (propArray[0] == searchEquipId && propArray[1] == searchErrorCode) {
                    if (isEditMode) {
                        if (array[0] == searchEquipId && array[1].toLowerCase() == searchErrorCode)
                            return false;
                        else
                            return true;
                    }
                    else {
                        return true;
                    }

                }
            }
            return false;
        }

        function IsEditedErrorCodeIsValid() {
            var isEditMode = $('#hdnIsEditMode').val() == "1" ? true : false;
            var array = $('#hdnEditId').val().split('|');

            if (isEditMode) {
                var searchEquipId = GetInstrumentID(equipIdOrName);
                var searchErrorCode = errorCode.toLowerCase();


            }
            return true;
        }

    </script>

    <%-- Equip Name Auto Complete --%>

    <script type="text/javascript">

        function SetInstrumentNameOrID(source, eventArgs) {
            var varGetVal = eventArgs.get_value();
            debugger;
            var list = eventArgs.get_value().split('~');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        var id = list[0];
                        var displayTxt = list[1];
                        document.getElementById('txt_EqpName_Or_Code').value = displayTxt;
                        document.getElementById('hf_EqpName_Or_Code').value = id;
                    }
                }
            }
        }
    </script>

    <%-- Common --%>

    <script type="text/javascript">

        function winClose() {

            window.close();
        }

        function DisableEnterKey(e) {
            debugger;
            var key;
            if (window.event)
                key = window.event.keyCode; //IE
            else
                key = e.which; //firefox     

            return (key != 13);
        }

        function importCancel() {
            HideGetPathPopup();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <%-- <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>--%>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="div_Error_Info">
            <table class="w-100p searchPanel">
                <tr>
                    <td>
                        <asp:Label ID="lbl_EqpName_Or_Code" runat="server" Text="Equipment Name/Code :"></asp:Label>
                    </td>
                    <td>
                        <%--<asp:TextBox ID="txt_EqpName_Or_Code" runat="server"  onchange="IsValidEquipName();">--%>
                        <asp:TextBox ID="txt_EqpName_Or_Code" runat="server" onkeydown="return DisableEnterKey()">                
                        </asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                        <div id="aceDiv" style="z-index: 99999">
                        </div>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txt_EqpName_Or_Code"
                            FirstRowSelected="true" ServiceMethod="GetAllInstrumentInfo" ServicePath="~/WebService.asmx"
                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="0"
                            DelimiterCharacters="" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected" OnClientItemSelected="SetInstrumentNameOrID"
                            UseContextKey="true">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_insrumnt_Code" runat="server" Text="Code Sent From the Instrument">
                        </asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_Error_Code" runat="server" TabIndex="1" meta:resourcekey="txt_Err_CodeResource1"
                            onkeydown="return DisableEnterKey()"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td>
                        <asp:Label ID="lbl_Error_Desc" runat="server" Text="Flag Description">
                        </asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_Error_Desc" runat="server" TextMode="MultiLine" TabIndex="2"
                            meta:resourcekey="txt_Err_DescResource1"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td>
                        <asp:Label ID="lbl_ErrorRslt_Val" runat="server" Text="Result Value">
                        </asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_ErrorRslt_Val" runat="server" autocomplete="off" TabIndex="3"
                            meta:resourcekey="txt_ErrCode_ResultResource1" onkeydown="return DisableEnterKey()"></asp:TextBox>
                    </td>
                    <td>
                        <table>
                            `
                            <tr>
                                <asp:Panel ID="panelContent" runat="server">
                                    <td>
                                        <%-- <asp:Button ID="btn_AddErrorFlag" runat="server" Text="Add" TabIndex="4" OnClientClick="return Validation()"
                                            OnClick="btn_AddErrorFlag_Click" />--%>
                                        <asp:Button ID="btn_AddErrorFlag" runat="server" Text="Add" TabIndex="4" OnClientClick="Add_Or_EditItem(); return false" />
                                        <%--<asp:Button ID="btnTest" runat="server" Text="test" TabIndex="4" OnClientClick="Add_Or_EditItem(); return false" />--%>
                                    </td>
                                    <td>
                                        <asp:Button ID="btn_Reset" runat="server" Text="Clear" TabIndex="5" OnClientClick="Reset(); return false" />
                                    </td>
                                </asp:Panel>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div id="div_Import_Export">
            <table width="99%" style="height: 35px">
                <tr align="right">
                    <td>
                        <asp:UpdatePanel ID="upnl_IMportExport" runat="server">
                            <Triggers>
                                <asp:PostBackTrigger ControlID="lbtn_Import_ErrorMapping" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:LinkButton ID="lbtn_Import_ErrorMapping" runat="server" Text="Import From Excel"
                                    Font-Underline="true" TabIndex="8" OnClientClick="ShowGetPathPopup();return false">
                                </asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr align="right">
                    <td>
                        <asp:LinkButton ID="lbtn_Export_ErrorMapping" runat="server" Text="Export From Table"
                            Font-Underline="true" TabIndex="9" OnClick="lbtn_Export_ErrorMapping_Click">
                        </asp:LinkButton>
                    </td>
                    <%--<td>
                        <asp:LinkButton ID="LinkButton1" runat="server" Text="Test From Table" TabIndex="9"
                            OnClientClick="ShowGetPathPopup();return false">
                        </asp:LinkButton>
                    </td>--%>
                </tr>
            </table>
        </div>
        <div id="div_Map_Info_In_Grid" align="left">
            <table id="gv_Tbl" style="display: none">
                <thead>
                    <tr>
                        <th class="a-center">
                            S.NO
                        </th>
                        <th class="a-center">
                            Equipment Name
                        </th>
                        <th class="a-center">
                            Equipment Code
                        </th>
                        <th class="a-center">
                            Code Sent From the Instrument
                        </th>
                        <th class="a-center">
                            Flag Description
                        </th>
                        <th class="a-center">
                            Result Value
                        </th>
                        <th class="a-center">
                            Action
                        </th>
                    </tr>
                </thead>
            </table>
        </div>
        <div id="ModalPopupDiv">
            <asp:Panel ID="pnlGetPath" Width="300px" Height="200px" runat="server" CssClass="modalPopup dataheaderPopup"
                Style="display: none" meta:resourcekey="pnlPatternsResource1">
                <table>
                    <tr>
                        <td>
                            <div style="width: 100%; height: 200px; overflow: auto;">
                                <%--<asp:FileUpload ID="ful_Import" runat="server" />
                                <br />
                                <br />
                                <asp:Button runat="server" ID="btnImport" Text="Import" OnClick="btnImport_Click" />
                                <asp:Button runat="server" ID="btnImportCancel" Text="Cancel" OnClientClick="importCancel(); return false" />--%>
                                <input type="file" id="fileUpload" />
                                <input type="button" id="upload" value="Upload" onclick="Upload_new()" <%--OnClick="btnImport_Click" --%> />
                                <asp:Button runat="server" ID="btnImportCancel" Text="Cancel" OnClientClick="importCancel(); return false" />
                            </div>
                            <asp:FileUpload ID="ful_Import" runat="server" Visible="false" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajc:ModalPopupExtender ID="mpeGetPath" runat="server" TargetControlID="btnDummy"
                PopupControlID="pnlGetPath" BackgroundCssClass="modalBackground" CancelControlID="btnDummy"
                DynamicServicePath="" Enabled="True" />
            <input type="button" id="btnDummy" runat="server" style="display: none;" />
        </div>
        <center>
            <table>
                <tr>
                    <td>
                        <asp:Button ID="btn_Save" runat="server" Text="Save" TabIndex="6" CssClass="btn"
                            OnClick="btn_Save_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btn_Close" runat="server" Text="Close" TabIndex="7" CssClass="btn"
                            OnClick="btn_Close_Click" />
                    </td>
                </tr>
            </table>
        </center>
    </div>
    <div id="dvCSV">
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hf_EqpName_Or_Code" runat="server" Value="" />
    <asp:HiddenField ID="hdnMessages" runat="server" Value="0" />
    <%--If Edit mode, return 1, otherwise 0--%>
    <asp:HiddenField ID="hdnIsEditMode" runat="server" />
    <%--instrumentId+|+symbol--%>
    <asp:HiddenField ID="hdnEditId" runat="server" />
    <asp:HiddenField ID="hdnIsRefreshTable" runat="server" Value="1" />
    <%--If Valid, return 1, otherwise 0--%>
    <asp:HiddenField ID="hdnIsValidInstrumentName" runat="server" Value="0" />
    <asp:HiddenField ID="hdnOrgId" runat="server" />
    <asp:HiddenField ID="hdnILocID" runat="server" />
    <asp:HiddenField ID="hdnInstrumentKeys" runat="server" />
    <asp:HiddenField ID="hdnErrorCodeKeys" runat="server" />
    <%--If Yes, return 1, otherwise 0--%>
    <asp:HiddenField ID="hdnIsStopRender" runat="server" Value="0" />

    <asp:HiddenField ID="hdnEditFldFldActivOrNot" runat="server" />
    
    <script type="text/javascript">
        $(document).ready(function() {
            GetData();
        });
    </script>

    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

</body>
</html>
