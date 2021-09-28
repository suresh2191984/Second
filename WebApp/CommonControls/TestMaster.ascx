<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TestMaster.ascx.cs" Inherits="CommonControls_TestMaster" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
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
        background-color: #F3E2A9;
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
    h1, h2, h3, h4, h5, h6
    {
        margin: 10px 0;
        font-family: inherit;
        font-weight: bold;
        line-height: 1;
        color: inherit;
        text-rendering: optimizelegibility;
    }
    h1 small, h2 small, h3 small, h4 small, h5 small, h6 small
    {
        font-weight: normal;
        line-height: 1;
        color: #999999;
    }
    h1
    {
        font-size: 36px;
        line-height: 40px;
    }
    h2
    {
        font-size: 30px;
        line-height: 40px;
    }
    h3
    {
        font-size: 24px;
        line-height: 40px;
    }
    h4
    {
        font-size: 18px;
        line-height: 20px;
    }
    h5
    {
        font-size: 14px;
        line-height: 20px;
    }
    h6
    {
        font-size: 12px;
        line-height: 20px;
    }
    h1 small
    {
        font-size: 24px;
    }
    h2 small
    {
        font-size: 18px;
    }
    h3 small
    {
        font-size: 14px;
    }
    h4 small
    {
        font-size: 14px;
    }
    .close
    {
        float: right;
        font-size: 20px;
        font-weight: bold;
        line-height: 20px;
        color: #000000;
        text-shadow: 0 1px 0 #ffffff;
        opacity: 0.2;
        filter: alpha(opacity=20);
    }
    .close:hover
    {
        color: #000000;
        text-decoration: none;
        cursor: pointer;
        opacity: 0.4;
        filter: alpha(opacity=40);
    }
    button.close
    {
        padding: 0;
        cursor: pointer;
        background: transparent;
        border: 0;
        -webkit-appearance: none;
    }
    .modal-backdrop
    {
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        z-index: 1040;
        background-color: #000000;
    }
    .modal-backdrop.fade
    {
        opacity: 0;
    }
    .modal-backdrop, .modal-backdrop.fade.in
    {
        opacity: 0.8;
        filter: alpha(opacity=80);
    }
    .modal
    {
        font-family: "Helvetica Neue" , Helvetica, Arial, sans-serif;
        font-size: 14px;
        display: none;
        position: fixed;
        top: 45%;
        left: 1%;
        z-index: 1050;
        margin: -250px 0 0 0;
        overflow: auto;
        color: #333333;
        padding: 3px;
        background-color: #e0ebf5;
        border: 1px solid #999;
        border: 1px solid rgba(0, 0, 0, 0.3); *border:1pxsolid#999;-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-webkit-box-shadow:03px7pxrgba(0, 0, 0, 0.3);-moz-box-shadow:03px7pxrgba(0, 0, 0, 0.3);box-shadow:03px7pxrgba(0, 0, 0, 0.3);-webkit-background-clip:padding-box;-moz-background-clip:padding-box;background-clip:padding-box;}
    .modal-header
    {
        padding: 9px 15px;
        border-bottom: 1px solid #eee;
    }
    .modal-header .close
    {
        margin-top: 2px;
    }
    .modal-header h3
    {
        margin: 0;
        line-height: 30px;
    }
    .modal-body
    {
        height: 500px;
        padding: 15px;
        overflow-y: auto;
    }
    .modal-form
    {
        margin-bottom: 0;
    }
    .modal-footer
    {
        padding: 10px 15px 5px;
        margin-bottom: 0;
        text-align: right;
        background-color: #e0ebf5;
        color: #333333;
        border-top: 1px solid #ddd;
        -webkit-border-radius: 0 0 6px 6px;
        -moz-border-radius: 0 0 6px 6px;
        border-radius: 0 0 6px 6px; *zoom:1;-webkit-box-shadow:inset01px0#ffffff;-moz-box-shadow:inset01px0#ffffff;box-shadow:inset01px0#ffffff;}
    .modal-footer:before, .modal-footer:after
    {
        display: table;
        line-height: 0;
        content: "";
    }
    .modal-footer:after
    {
        clear: both;
    }
    .modal-footer .btn + .btn
    {
        margin-bottom: 0;
        margin-left: 5px;
    }
    .modal-footer .btn-group .btn + .btn
    {
        margin-left: -1px;
    }
    fieldset
    {
        border: 1px solid black;
        padding: 5px;
        text-align: left;
    }
    legend
    {
        margin-bottom: 0px;
        margin-left: 5px;
        padding: 1px;
        font-size: 12px;
        font-weight: bold;
        color: White;
        text-align: right;
        background-color: #2C88B1;
    }
    #txtROReferenceRange
    {
        width: 180px;
        height: 80px;
    }
    #divGenderOtherCategory legend
    {
        text-align: left !important;
    }
</style>
<%--<script type="text/javascript" src="../Scripts/handsontable/lib/jquery-1.9.1.min.js?v=<%= System.Configuration.ConfigurationManager.AppSettings["jsDownloadVersion"]%>"></script>--%>

<script type="text/javascript" src="../Scripts/handsontable/dist/jquery.handsontable.full.js"></script>

<script type="text/javascript" src="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.js"></script>

<link rel="stylesheet" media="screen" href="../Scripts/handsontable/dist/jquery.handsontable.full.css" />
<link rel="stylesheet" media="screen" href="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.css" />
<style>
    ul.wordWheel
    {
        visibility: hidden;
    }
</style>

<script type="text/javascript">
    var htmlRenderer = function(instance, td, row, col, prop, value, cellProperties) {
        var escaped = Handsontable.helper.stringify(value);
        td.innerHTML = escaped;
        return td;
    };
    function SetClientID(source, eventArgs) {
        var clientid = eventArgs.get_value().split('|');
        document.getElementById('<%=hdnSelectedClientID.ClientID %>').value = clientid[0];

    }
    var lbldeletes = '<%=Resources.ClientSideDisplayTexts.Common_Delete %>';
    var lbledit = '<%=Resources.ClientSideDisplayTexts.Common_Edit %>'
    function ShowAlertMsg(key) {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_01") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_01") : "Unable to save test master details!";

        var userMsg = null; //SListForApplicationMessages.Get(key);
        if (userMsg != null) {
            // alert(userMsg);
            ValidationWindow(userMsg, AlrtWinHdr);
            return false;
        }
        else {
            //alert('Unable to save test master details!');
            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            return false;
        }

        return true;
    }
    var ddlRemarksType = '<%=ddlRemarksType.ClientID %>';
    var hdnIsRRXML = '<%=hdnIsRRXML.ClientID %>';
    var txtReferenceRange = '<%=txtReferenceRange.ClientID %>';
    var txtROReferenceRange = '<%=txtROReferenceRange.ClientID %>';
    var hdnOrgID = '<%=hdnOrgID.ClientID %>';
    var hdnLocationID = '<%=hdnLocationID.ClientID %>';
    var hdnProcessingLocation = '<%=hdnProcessingLocation.ClientID %>';
    var ddlAutoAuthorizeUser = '<%=ddlAutoAuthorizeUser.ClientID %>';
    var hdnAutoAuthorizeUser = '<%=hdnAutoAuthorizeUser.ClientID %>';
    var ddlAutoAuthorizeRole = '<%=ddlAutoAuthorizeRole.ClientID %>';
    var hdnInvID = '<%=hdnInvID.ClientID %>';
    var txtTestCodeScheme = '<%=txtTestCodeScheme.ClientID %>';
    var hdnSelectedRemarksID = '<%=hdnSelectedRemarksID.ClientID %>';
    var hdnRemarksContent = '<%=hdnRemarksContent.ClientID %>';
    var hdnRemarksType = '<%=hdnRemarksType.ClientID %>';
    var hdnRemarksTypeName = '<%=hdnRemarksTypeName.ClientID %>';
    var txtUOM = '<%=txtUOM.ClientID %>';
    var hdnUOMID = '<%=hdnUOMID.ClientID %>';
    var hdnIsChangesFromRRPopup = '<%=hdnIsChangesFromRRPopup.ClientID %>';
    var hdnAgeRangeAdd = '<%=hdnAgeRangeAdd.ClientID %>';
    var hdnGenderRangeAdd = '<%=hdnGenderRangeAdd.ClientID %>';
    var hdnOtherReferenceRangeAdd = '<%=hdnOtherReferenceRangeAdd.ClientID %>';
    var hdnRRStringAdd = '<%=hdnRRStringAdd.ClientID %>';
    var hdnRRXMLAdd = '<%=hdnRRXMLAdd.ClientID %>';
    var ddlRefRangeType = '<%=ddlRefRangeType.ClientID %>';
    var ddlRRSubCategory = '<%=ddlRRSubCategory.ClientID %>';
    var divScrolling = '<%=divScrolling.ClientID %>';
    var txtValueRange2 = '<%=txtValueRange2.ClientID %>';
    var txtAgeRange2 = '<%=txtAgeRange2.ClientID %>';
    var ddlCategory = '<%=ddlCategory.ClientID %>';
    var txtGenderValueEnd = '<%=txtGenderValueEnd.ClientID %>';
    var txtOtherRange2 = '<%=txtOtherRange2.ClientID %>';
    var ddlAgeType = '<%=ddlAgeType.ClientID %>';
    var ddlOperatorRange1 = '<%=ddlOperatorRange1.ClientID %>';
    var ddlOperatorRange2 = '<%=ddlOperatorRange2.ClientID %>';
    var ddlGenderValueOpt = '<%=ddlGenderValueOpt.ClientID %>';
    var ddlOtherRangeOpt = '<%=ddlOtherRangeOpt.ClientID %>';
    var txtAgeRange1 = '<%=txtAgeRange1.ClientID %>';
    var txtValueRange1 = '<%=txtValueRange1.ClientID %>';
    var txtGenderValueStart = '<%=txtGenderValueStart.ClientID %>';
    var txtGenderOther = '<%=txtGenderOther.ClientID %>';
    var txtOtherRange1 = '<%=txtOtherRange1.ClientID %>';
    var ddlInstrument = '<%=ddlInstrument.ClientID %>';
    var ddlKit = 0;
    var txtTestCode = "";
    var txtClient = '<%=txtClient.ClientID %>';
    var ddlReason = '<%=ddlReason.ClientID %>';
    var chkRefMappingActive = '<%=chkRefMappingActive.ClientID %>';
    var hdnSelectedInvRefMappingID = '<%=hdnSelectedInvRefMappingID.ClientID %>';
    var hdnSelectedClientID = '<%=hdnSelectedClientID.ClientID %>';
    var hdnSelectedDeviceMappingID = '<%=hdnSelectedDeviceMappingID.ClientID %>';
    var hdnSelectedRefMappingRowIndex = '<%=hdnSelectedRefMappingRowIndex.ClientID %>';
    var chkPrimary = '<%=chkPrimary.ClientID %>';
    var btnAddRefMapping = '<%=btnAddRefMapping.ClientID %>';
    var txtDisplayText = '<%=txtDisplayText.ClientID %>';
    var txtRemarks = '<%=txtRemarks.ClientID %>';
    var hdnLstInvRemarks = '<%=hdnLstInvRemarks.ClientID %>';
    var hdnLstInvOrgRefMapping = '<%=hdnLstInvOrgRefMapping.ClientID %>';
    var lblAjaxBusy = '<%=lblAjaxBusy.ClientID %>';
    var lblDelete = '<%=lblDelete.ClientID %>';
    var hdnTypeValue = '<%=hdnTypeValue.ClientID %>';
    var chkNormalValue = '<%=chkNormalValue.ClientID %>';
    var rdoResultTypeNumeric = '<%=rdoResultTypeNumeric.ClientID %>';
    var rdoResultTypeText = '<%=rdoResultTypeText.ClientID %>';
    var hdnSelectedAgeRowIndex = '<%=hdnSelectedAgeRowIndex.ClientID %>';
    var hdnSelectedCommonRowIndex = '<%=hdnSelectedCommonRowIndex.ClientID %>';
    var hdnSelectedOthersRowIndex = '<%=hdnSelectedOthersRowIndex.ClientID %>';
    var btnAddRRAge = '<%=btnAddRRAge.ClientID %>';
    var btnAddRRCommon = '<%=btnAddRRCommon.ClientID %>';
    var btnAddRROthers = '<%=btnAddRROthers.ClientID %>';
    var hdnReflexTestContent = '<%=hdnReflexTestContent.ClientID %>';
    var hdnCrossTestContent = '<%=hdnCrossTestContent.ClientID %>';
    var hdnLstInvValueRangeMaster = '<%=hdnLstInvValueRangeMaster.ClientID %>';
    var hdnlstInvCrossparameterTest = '<%=hdnlstInvCrossparameterTest.ClientID %>';
    var chkResultReportable = '<%=chkResultReportable.ClientID%>';
    var ChkChargeable = '<%=ChkChargeable.ClientID%>';
    var hdnLstCoAuth = '<%=hdnLstCoAuth.ClientID %>';
    var ddlDept1 = '<%=ddlDept1.ClientID %>';
    var hdnDept1 = '<%=hdnDept1.ClientID %>';
    var ddlDoctor = '<%=ddlDoctor.ClientID %>';
    var hdnDoctor = '<%=hdnDoctor.ClientID %>';
    var ddlRole = '<%=ddlRole.ClientID %>';
    var hdnRole = '<%=hdnRole.ClientID %>';
    var hdnSelectedLayout = '<%=hdnSelectedLayout.ClientID %>';
    var hdnHandsonTable1 = '<%=hdnHandsonTable1.ClientID %>';
    var hdnHandsonTable2 = '<%=hdnHandsonTable2.ClientID %>';
    var hdnIsEmptyHandsonTable1 = '<%=hdnIsEmptyHandsonTable1.ClientID %>';
    var hdnIsEmptyHandsonTable2 = '<%=hdnIsEmptyHandsonTable2.ClientID %>';
    var hdnHandsonTable1ColumnCount = '<%=hdnHandsonTable1ColumnCount.ClientID %>';
    var hdnHandsonTable2ColumnCount = '<%=hdnHandsonTable2ColumnCount.ClientID %>';
    var txtCommonSource = '<%=txtCommonSource.ClientID %>';
    var txtAgeSource = '<%=txtAgeSource.ClientID %>';
    var chkIsSourceText = '<%=chkIsSourceText.ClientID %>';
    var ddlOtherAgeType = '<%=ddlOtherAgeType.ClientID %>';
    var ddlOtherAgeOperator = '<%=ddlOtherAgeOperator.ClientID %>';
    var txtOtherAgeRange1 = '<%=txtOtherAgeRange1.ClientID %>';
    var txtOtherAgeRange2 = '<%=txtOtherAgeRange2.ClientID %>';
    var ddlAgeBulkData = '<%=ddlAgeBulkData.ClientID %>';
    var ddlAgeResult = '<%=ddlAgeResult.ClientID %>';
    var ddlAgeDevice = '<%=ddlAgeDevice.ClientID %>';
    var ddlCommonBulkData = '<%=ddlCommonBulkData.ClientID %>';
    var ddlCommonResult = '<%=ddlCommonResult.ClientID %>';
    var ddlCommonDevice = '<%=ddlCommonDevice.ClientID %>';
    var ddlOtherBulkData = '<%=ddlOtherBulkData.ClientID %>';
    var ddlOtherResult = '<%=ddlOtherResult.ClientID %>';
    var ddlOtherDevice = '<%=ddlOtherDevice.ClientID %>';
    var hdnReauthPrimary = '<%=hdnReauthPrimary.ClientID %>';
    var drpProcessLocation = '<%=drpProcessLocation.ClientID %>';
    var drpProcessingOrg = '<%=drpProcessingOrg.ClientID %>';
    var drpRegLocation = '<%=drpRegLocation.ClientID %>';
    var drpType = '<%=drpType.ClientID %>';
    var hdnInvLocationMapping = '<%=hdnInvLocationMapping.ClientID %>';
    var hdnInvLocation = '<%=hdnInvLocation.ClientID %>';
    var hdnSelectedOrgID = '<%=hdnSelectedOrgID.ClientID %>';
    var ddlType = '<%=ddlType.ClientID %>';
    var ddlRtype = '<%=ddlRtype.ClientID %>';
    var ddlRemarksType = '<%=ddlRemarksType.ClientID %>';
    var hdnSelectedRemarksID1 = '<%=hdnSelectedRemarksID1.ClientID %>';

    var txtConvUom = '<%=txtConvUom.ClientID %>';
    var hdnConvUOMID = '<%=hdnConvUOMID.ClientID %>';
    var txtConvFactor = '<%=txtConvFactor.ClientID %>';
    var txtConvDecimal = '<%=txtConvDecimal.ClientID %>';

    $(document).ready(function() {
        try {
            $('body').append('<div id="ajaxBusy"><p><img src="../Images/working.gif">' + $('#' + lblAjaxBusy).html() + '</p></div>');

            $('#ajaxBusy').css({
                display: "none",
                margin: "0px",
                paddingLeft: "0px",
                paddingRight: "0px",
                paddingTop: "0px",
                paddingBottom: "0px",
                position: "absolute",
                right: "50px",
                top: "170px",
                width: "auto"
            });
            ChangeDDLItemListWidth();
        }
        catch (e) {
            return false;
        }
    });
    function onFocusRemarks() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") : "Select remarks type";


        try {
            if ($('#' + ddlRemarksType + ' option:selected').val() == '0') {
                //alert("Select remarks type");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                $('#' + ddlRemarksType).focus();
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onFocusRemarks1() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") : "Select remarks type";

        try {
            if ($('#' + ddlRtype + ' option:selected').val() == '0') {
                //alert("Select remarks type");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                $('#' + ddlRtype).focus();

            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onFocusRemarksText() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") : "Select Remark";

        if (document.getElementById("<%=txttext.ClientID %>").value == "") {
            //alert('Select Remark');
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            return false;
        }
    }
    function onChangeRemarksType1() {

        try {
            var selectedRemarksType = $('#' + ddlRtype + ' option:selected');
            $('#' + hdnRemarksType).val($(selectedRemarksType).val());
            $('#' + hdnRemarksTypeName).val($(selectedRemarksType).text());
            $find('<%=ACEAddRemarks1.ClientID %>').set_contextKey($(selectedRemarksType).val());
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function SelectedRemarkID(Source, eventArgs) {

        var RemarkCode = eventArgs.get_value().split('~');
        var contents = $("#<%= txttext.ClientID %>").val();
        $("#<%= txttextRemark.ClientID %>").val(contents);
        $("#<%= txtRCode.ClientID %>").val(RemarkCode[1]);

        try {
            $('input[id$="hdnSelectedRemarksID1"]').val(RemarkCode[0]);
            $('#' + hdnRemarksContent).val(eventArgs.get_text());
        }
        catch (e) {
            return false;
        }
    }
    function onChangeRemarksType() {
        $get("<%=txtRemarks.ClientID %>").value = '';
        try {
            var selectedRemarksType = $('#' + ddlRemarksType + ' option:selected');
            $('#' + hdnRemarksType).val($(selectedRemarksType).val());
            $('#' + hdnRemarksTypeName).val($(selectedRemarksType).text());
            $find('<%=ACERemarks.ClientID %>').set_contextKey($(selectedRemarksType).val());
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onFocusReferenceRange() {
        try {
            if ($('#' + hdnIsRRXML).val() == 'true' && $.trim($('#' + txtReferenceRange).val()) != '') {
                $('#divReferenceRangeHint').show();
            }
            else {
                $('#divReferenceRangeHint').hide();
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onBlurReferenceRange() {
        try {
            if ($('#' + hdnIsRRXML).val() == 'true' && $.trim($('#' + txtReferenceRange).val()) != '') {
                $('#divReferenceRangeHint').show();
            }
            else {
                $('#divReferenceRangeHint').hide();
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }

    $(document).ajaxStart(function() {
        $('#ajaxBusy').show();
    }).ajaxStop(function() {
        $('#ajaxBusy').hide();
    });

    function onChangeAutoAuthorizeRole() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        try {
            $('#' + ddlAutoAuthorizeUser).children('option:not(:first)').remove();
            var selectedAutoAuthorizeRole = $('#' + ddlAutoAuthorizeRole + ' option:selected');
            if ($(selectedAutoAuthorizeRole).val() != '0') {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetAutoAuthorizeUser",
                    data: "{OrgID: " + $('#' + hdnOrgID).val() + ",RoleID: " + $(selectedAutoAuthorizeRole).val() + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        var lstAutoAuthorizeUser = data.d;
                        if (lstAutoAuthorizeUser.length > 0) {
                            for (var i = 0; i < lstAutoAuthorizeUser.length; i++) {
                                if ($('#' + hdnAutoAuthorizeUser).val() != lstAutoAuthorizeUser[i].LoginID) {
                                    $('#' + ddlAutoAuthorizeUser).append($("<option></option>").val(lstAutoAuthorizeUser[i].LoginID).html(lstAutoAuthorizeUser[i].Name));
                                }
                                else {
                                    $('#' + ddlAutoAuthorizeUser).append($("<option selected='selected'></option>").val(lstAutoAuthorizeUser[i].LoginID).html(lstAutoAuthorizeUser[i].Name));
                                }
                            }
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        // alert(xhr.status);
                        ValidationWindow(xhr.status, AlrtWinHdr);
                    }
                });
            }
            else {
                $('#' + hdnAutoAuthorizeUser).val('0');
            }
        }
        catch (e) {
            return false;
        }
    }
    function onChangeAutoAuthorizeUser() {
        try {
            var selectedAutoAuthorizeUser = $('#' + ddlAutoAuthorizeUser + ' option:selected');
            $('#' + hdnAutoAuthorizeUser).val($(selectedAutoAuthorizeUser).val());
        }
        catch (e) {
            return false;
        }
    }

    // Added By Murali------------////

    function onChangeddlRole() {

        try {
            $('#' + ddlDept1).children('option:not(:first)').remove();
            //$('#' + ddlDoctor).children('option:not(:first)').remove();

            var OrgId = $('#' + hdnOrgID).val();
            var roleID = $('#' + ddlRole + ' option:selected');
            if ($(roleID).val() != '0') {
                $.ajax({
                    type: "POST",
                    url: "../OPIPBilling.asmx/GetDeptName",
                    data: "{ OrgId: " + parseInt(OrgId) + ",roleID: " + $(roleID).val() + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function(data) {
                        var lstDept = data.d;
                        if (lstDept.length > 0) {
                            $('#' + ddlDept1).attr("disabled", false);
                            //$('#' + ddlDoctor).append('<option value="0">--Select--</option>');
                            $.each(lstDept, function(index, Item) {
                                $('#' + ddlDept1).append('<option value="' + Item.DeptID + '">' + Item.DeptName + '</option>');
                            });
                        }
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
            }
        }
        catch (e) {
            return false;
        }
    }

    function onChangeddlDept1() {

        try {
            $('#' + ddlDoctor).children('option:not(:first)').remove();
            var OrgId = $('#' + hdnOrgID).val();
            var deptID = $('#' + ddlDept1 + ' option:selected');
            var roleID = $('#' + ddlRole + ' option:selected');
            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/GetDoctorName",
                data: "{ OrgId: " + parseInt(OrgId) + ",deptID: " + $(deptID).val() + ",roleID: " + $(roleID).val() + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    var lstPhysician = data.d;
                    if (lstPhysician.length > 0) {
                        $('#' + ddlDoctor).attr("disabled", false);
                        //$('#' + ddlDoctor).append('<option value="0">--Select--</option>');
                        $.each(lstPhysician, function(index, Item) {
                            $('#' + ddlDoctor).append('<option value="' + Item.UserID + '">' + Item.UserName + '</option>');
                        });
                    }
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }
        catch (e) {
            return false;
        }
    }

    //----------------Murali-------------////
    function SelectedTestCodeScheme(Source, eventArgs) {
        try {
            var hdnTestCode = '<%=hdnTestCode.ClientID %>';
            var lstSelectedValue = eventArgs.get_value().split(':');

            var seletedReflextest = lstSelectedValue[0];
            //        var Isorderable = lstSelectedValue[1];
            //        $('input[id$="hdnSelectedReflexTest"]').val(lstSelectedValue[0]);
            //        $('input[id$="hdnIsOrderable"]').val(lstSelectedValue[1]);



            $('#' + hdnInvID).val(seletedReflextest);
            var lstSelectedText = eventArgs.get_text().split(':');
            if (lstSelectedText.length > 1 && lstSelectedText[1] != null) {
                $('#' + txtTestCodeScheme).val(lstSelectedText[1]);
                $('#' + hdnTestCode).val(lstSelectedText[1]);
            }
        }
        catch (e) {
            return false;
        }
    }
    function SelectedReflexTest(Source, eventArgs) {
        try {
            var lstSelectedValue = eventArgs.get_value().split(':');

            var seletedReflextest = lstSelectedValue[0];
            var Isorderable = lstSelectedValue[1];
            $('input[id$="hdnSelectedReflexTest"]').val(lstSelectedValue[0]);
            $('input[id$="hdnIsOrderable"]').val(lstSelectedValue[1]);
            $('input[id$="hdnTestType"]').val(lstSelectedValue[2]);
            //            $('#' + hdnSelectedReflexTest).val(lstSelectedValue[0]);
            //            $('#' + hdnIsOrderable).val(lstSelectedValue[1]); 

            var lstSelectedText = eventArgs.get_text().split(':');
            if (lstSelectedText.length > 1 && lstSelectedText[1] != null) {
                $('input[id$="txtReflexTesttMapping"]').val(lstSelectedText[0].trim());
                $('#' + hdnReflexTestContent).val(lstSelectedText[0].trim());
            }
        }
        catch (e) {
            return false;
        }
    }
    function SelectedCrossTest(Source, eventArgs) {
        try {
            var lstSelectedValue = eventArgs.get_value().split(':');
            $('input[id$="hdnSelectedCrossTest"]').val(lstSelectedValue[0]);
            var lstSelectedText = eventArgs.get_text().split(':');
            if (lstSelectedText.length > 1 && lstSelectedText[1] != null) {
                $('input[id$="txtCrossParameter"]').val(lstSelectedText[0].trim());
                $('#' + hdnCrossTestContent).val(lstSelectedText[0].trim());
            }
        }
        catch (e) {
            return false;
        }
    }
    function SelectedRemarks(Source, eventArgs) {
        try {
            var RemarkCode = eventArgs.get_value().split('~');
            $('input[id$="hdnSelectedRemarksID"]').val(eventArgs.get_value());
            $('#' + hdnRemarksContent).val(eventArgs.get_text());
        }
        catch (e) {
            return false;
        }
    }
    function TestCodeSchemePopulated(Source, eventArgs) {
        try {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('#' + hdnInvID).val('');
            }
        }
        catch (e) {
            return false;
        }
    }
    function CrossTestCodeSchemePopulated(Source, eventArgs) {
        try {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('#' + hdnInvID).val('');
            }
        }
        catch (e) {
            return false;
        }
    }

    function RemarksPopulated(Source, eventArgs) {
        try {
            var autoList = Source.get_completionList();
            if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                $('input[id$="hdnSelectedRemarksID"]').val('');
                $('#' + hdnRemarksContent).val('');
            }
        }
        catch (e) {
            return false;
        }
    }

    function btnReflexAdd() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_04") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_04") : "Selected Test is Not Orderable";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_05") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_05") : "Selected Test already exists";
        var UsrAlrtMsg3 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_06") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_06") : "Select a Test";
        var UsrAlrtMsg4 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_001") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_001") : "Don't add same test as reflex test!";
        try {
            var ParentinvID = $('#' + hdnInvID).val();
            var ReflexTestIDForVal = $('input[id$="hdnSelectedReflexTest"]').val();
            var IsOrderable = $('input[id$="hdnIsOrderable"]').val();
            var TestType = $('input[id$="hdnTestType"]').val();
            if (ParentinvID == ReflexTestIDForVal) {
                ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                //alert("Don't add same test as reflex test!");
                $('input[id$="txtReflexTesttMapping"]').val('');
                $('input[id$="hdnSelectedReflexTest"]').val('');
                $('input[id$="hdnTestType"]').val('');
                $('#' + hdnReflexTestContent).val('');
                $('input[id$="txtReflexTesttMapping"]').focus();
                return false;
            }
            if ($('input[id$="hdnSelectedReflexTest"]').val() != '') {
                var isExists = false;
                $('#tblReflex tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var ReflexTestID = $row.find($('input[id$="hdnReflexTestID"]')).val();
                    if ($('input[id$="hdnSelectedReflexTest"]').val() == ReflexTestID) {
                        isExists = true;
                    }
                });
                if (IsOrderable == 'N') {
                    //alert('Selected Test is Not Orderable');
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
                if (!isExists) {
                    var row$ = $('<tr/>');
                    var hdnReflexTestID = $('input[id$="hdnSelectedReflexTest"]').val();
                    var hdntsttype = $('input[id$="hdnTestType"]').val();
                    var hdnId = '<input id="hdnReflexTestID" type="hidden" runat="server" value="' + hdnReflexTestID + '" />';
                    var hdntype = '<input id="hdnTesttypes" type="hidden" runat="server" value="' + hdntsttype + '" />';
                    var tdName = $('<td/>').html(hdnId +hdntype+ $('#' + hdnReflexTestContent).val());
                    var IsReportable = $('#' + chkResultReportable).is(':checked') ? 'Y' : 'N';
                    var IsChargeable = $('#' + ChkChargeable).is(':checked') ? 'Y' : 'N';
                    var hdnReportable = '<input id="hdnReportable" type="hidden" runat="server" value="' + IsReportable + '" />';
                    var hdnChargeable = '<input id="hdnChargeable" type="hidden" runat="server" value="' + IsChargeable + '" />';
                    var tdIsReportable = $('<td/>').html(hdnReportable + IsReportable);
                    var tdIsChargeable = $('<td/>').html(hdnChargeable + IsChargeable);
                    var txtDelete = $('#' + lblDelete).html();
                    var inputDelete = '<input id="btnReflexdelete" runat="server" value="' + txtDelete + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onReflexDelete(this);" />';
                    var tdDelete = $('<td align="center"/>').html(inputDelete);
                    var rowLen = $('#tblReflex > tbody >tr').length;
                    var Slno = rowLen + 1;
                    var tdSLNo = $('<td>' + Slno + '</td>');
                    row$.append(tdName).append(tdIsReportable).append(tdDelete);
                    row$.append(tdIsReportable).append(tdIsChargeable).append(tdDelete);
                    $('#tblReflex tbody').append(row$);
                }
                else {
                    //alert('Selected Test already exists');
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                }
            }
            else {
                //alert('Select a Test');
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            }
            $('#' + txtRemarks).val('');
            $('input[id$="txtReflexTesttMapping"]').val('');
            $('input[id$="hdnSelectedReflexTest"]').val('');
            $('#' + hdnReflexTestContent).val('');
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function btnCrossParameterAdd() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_04") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_04") : "Selected Test is Not Orderable";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_05") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_05") : "Selected Test already exists";
        var UsrAlrtMsg3 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_06") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_06") : "Select a Test";
        var UsrAlrtMsg4 = "Don't add same test as Cross Parameter test!";
        try {
            var ParentinvID = $('#' + hdnInvID).val();
            var CrossTestIDForVal = $('input[id$="hdnSelectedCrossTest"]').val();
            if (ParentinvID == CrossTestIDForVal) {
                ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                //alert("Don't add same test as reflex test!");
                $('input[id$="txtCrossTesttMapping"]').val('');
                $('input[id$="hdnSelectedCrossTest"]').val('');
                $('#' + hdnCrossTestContent).val('');
                $('input[id$="txtCrossTesttMapping"]').focus();
                return false;
            }
            if ($('input[id$="hdnSelectedCrossTest"]').val() != '') {
                var isExists = false;
                $('#tblCross tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var CrossTestID = $row.find($('input[id$="hdnCrossTestID"]')).val();
                    if ($('input[id$="hdnSelectedCrossTest"]').val() == CrossTestID) {
                        isExists = true;
                    }
                });
                if (!isExists) {
                    var row$ = $('<tr/>');
                    var hdnCrossTestID = $('input[id$="hdnSelectedCrossTest"]').val();
                    var hdnId = '<input id="hdnCrossTestID" type="hidden" runat="server" value="' + hdnCrossTestID + '" />';

                    var tdName = $('<td/>').html(hdnId + $('#' + hdnCrossTestContent).val());
                    var txtDelete = $('#' + lblDelete).html();
                    var inputDelete = '<input id="btnCrossdelete" runat="server" value="' + txtDelete + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onCrossDelete(this);" />';
                    var tdDelete = $('<td align="center"/>').html(inputDelete);
                    var rowLen = $('#tblCross > tbody >tr').length;
                    var Slno = rowLen + 1;
                    var tdSLNo = $('<td>' + Slno + '</td>');
                    row$.append(tdName).append(tdDelete);

                    $('#tblCross tbody').append(row$);
                }
                else {

                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                }
            }
            else {
                //alert('Select a Test');
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            }
            $('input[id$="txtCrossTesttMapping"]').val('');
            $('input[id$="hdnSelectedCrossTest"]').val('');
            $('#' + hdnCrossTestContent).val('');
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onReflexDelete(obj) {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") : "Unable to delete";

        try {
            var lstInvValueRangeMaster = [];
            var $row = $(obj).closest('tr');

            var InvestigationID = $('#' + hdnInvID).val();
            var ReflexTestID = $row.find($('input[id$="hdnReflexTestID"]')).val();
            var IsReportabl = $row.find($('input[id$="hdnReportable"]')).val();
            var IsChargeabl = $row.find($('input[id$="hdnChargeable"]')).val();
            if (IsReportabl == 'Y') {
                var IsReportable = 'Y';
            }
            else {
                IsReportable = 'N';
            }
            if (IsChargeabl == 'Y') {
                var IsChargeable = 'Y';
            }
            else {
                IsChargeable = 'N';
            }
            var orgID = $('#' + hdnOrgID).val();
            lstInvValueRangeMaster.push({
                InvestigationID: InvestigationID,
                ReflexInvestigationID: ReflexTestID,
                OrgID: orgID,
                IsReportable: IsReportable,
                IsChargeable: IsChargeable,
                Type: 'Delete'

            });

            var JSONObject = lstInvValueRangeMaster;
            if (lstInvValueRangeMaster.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/DeleteReflexTest",
                    data: JSON.stringify({ lstInvValueRangeMaster: lstInvValueRangeMaster }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        $(obj).closest('tr').remove();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        // alert("Unable to delete");
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    }
                });


                function fnsuccesscallback(data) {
                    var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
                    ValidationWindow(data.d, AlrtWinHdr);
                    //alert(data.d);
                }
                function fnerrorcallback(data, status, error) {
                    var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
                    ValidationWindow(error, AlrtWinHdr);
                    // alert(error);
                }
            }
            $(obj).closest('tr').remove();
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onCrossDelete(obj) {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") : "Unable to delete";

        try {
            var lstInvValueRangeMaster = [];
            var $row = $(obj).closest('tr');

            var InvestigationID = $('#' + hdnInvID).val();
            var CrossTestID = $row.find($('input[id$="hdnCrossTestID"]')).val();

            var orgID = $('#' + hdnOrgID).val();
            lstInvValueRangeMaster.push({
                InvestigationID: InvestigationID,
                ReflexInvestigationID: CrossTestID,
                OrgID: orgID,
                Type: 'Cross Delete'

            });

            var JSONObject = lstInvValueRangeMaster;
            if (lstInvValueRangeMaster.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/DeleteReflexTest",
                    data: JSON.stringify({ lstInvValueRangeMaster: lstInvValueRangeMaster }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        $(obj).closest('tr').remove();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        // alert("Unable to delete");
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    }
                });


                function fnsuccesscallback(data) {
                    var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
                    ValidationWindow(data.d, AlrtWinHdr);
                    //alert(data.d);
                }
                function fnerrorcallback(data, status, error) {
                    var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
                    ValidationWindow(error, AlrtWinHdr);
                    // alert(error);
                }
            }
            $(obj).closest('tr').remove();
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function AddRemarks() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_08") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_08") : "Selected remarks already exists";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") : "Select Remark";

        try {
            if ($('input[id$="hdnSelectedRemarksID"]').val() != '' && $('#' + hdnRemarksContent).val() != '') {
                var isExists = false;
                $('#tblRemarks tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var remarksID = $row.find($('input[id$="hdnRemarksID"]')).val();
                    //Added by Vijayalakshmi.M
                    var hdnRemarksCode = $row.find($('input[id$="hdnRemarksID"]')).val().split('~');
                    var hdnRemarksId = hdnRemarksCode[0];
                    var hdnRemarksCode1 = $('input[id$="hdnSelectedRemarksID"]').val().split('~');
                    var hdnRemarksId1 = hdnRemarksCode1[0];
                    if (hdnRemarksId == hdnRemarksId1) {
                        //End
                        //if ($('input[id$="hdnSelectedRemarksID"]').val() == remarksID) {
                        isExists = true;
                    }
                });
                if (!isExists) {
                    var row$ = $('<tr/>');
                    var hdnSelRemarksID = $('input[id$="hdnSelectedRemarksID"]').val();
                    var hdnId = '<input id="hdnRemarksID" type="hidden" runat="server" value="' + hdnSelRemarksID + '" />';
                    var tdName = $('<td align="left"/>').html($('#' + hdnRemarksContent).val());
                    var tdType = $('<td align="left"/>').html(hdnId + $('#' + hdnRemarksTypeName).val());
                    var txtDelete = $('#' + lblDelete).html();
                    var inputDelete = '<input id="btnRemarks" runat="server" value="' + txtDelete + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onRemarksDelete(this);" />';
                    var tdDelete = $('<td align="center"/>').html(inputDelete);
                    row$.append(tdName).append(tdType).append(tdDelete);
                    $('#tblRemarks tbody').append(row$);
                }
                else {
                    // alert('Selected remarks already exists');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                }
            }
            else {
                // alert('Select a remarks');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }
            $('#' + txtRemarks).val('');
            $('input[id$="hdnSelectedRemarksID"]').val('');
            $('#' + hdnRemarksContent).val('');
        }
        catch (e) {
            return false;
        }
        return false;
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
    function AddUOM() {
        try {
            document.getElementById('TabContainer1_TabTestMaster_TM_hdnUOMButtonID').value = "TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_hypLnkUOM";
            window.open('../Admin/AddUOM.aspx' + '?IsPopUp=Y', '', 'width=800,height=600,ScrollBars=1');
        }
        catch (e) {
            return false;
        }
    }
    function setUOM(id) {
        try {
            ////debugger;
            document.getElementById('TabContainer1_TabTestMaster_TM_hdnUOMButtonID').value = id;
            window.open('../Admin/ChangeUOM.aspx' + '?IsPopUp=Y', '', 'width=800,height=600,ScrollBars=1');
        }
        catch (e) {
            return false;
        }
    }
    function SelectUOMCode1(id, uomID, uomCode) {
        ////debugger;
        var BtnValue = document.getElementById('TabContainer1_TabTestMaster_TM_hdnUOMButtonID').value;
        try {
            if (BtnValue == "TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_hypLnkUOM") {
                $('#' + txtUOM).val(uomCode);
                $('#' + hdnUOMID).val(uomID);
            }
            else if (BtnValue == "TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_hypLnkConvUOM") {
                $('#' + txtConvUom).val(uomCode);
                $('#' + hdnConvUOMID).val(uomID);
            }
            document.getElementById('TabContainer1_TabTestMaster_TM_hdnUOMButtonID').value = "";
        }
        catch (e) {
            return false;
        }
    }
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
    ////    function onSave() {

    ////        try {
    ////            if ($('[id$="ddlScheduleType"]').val() != -1) {

    ////                if ($('[id$="txtCOTValue"]').val() == '') {
    ////                    alert("Enter Processing Time Value");
    ////                    $('[id$="txtCOTValue"]').focus();
    ////                    return false;
    ////                }
    ////            }


    ////            if ($('#' + txtDisplayText).val() != '') {
    ////                var lstInvRemarks = [];
    ////                $('#tblRemarks tbody tr').each(function(i, n) {
    ////                    var $row = $(n);
    ////                    var remarksID1 = $row.find($('input[id$="hdnRemarksID"]')).val();
    ////                    var itemremarkid = remarksID1.split('~');
    ////                    var remarksID = itemremarkid[0];
    ////                    lstInvRemarks.push({
    ////                        remarksID: remarksID
    ////                    });
    ////                    if (lstInvRemarks.length > 0) {
    ////                        $('#' + hdnLstInvRemarks).val(JSON.stringify(lstInvRemarks));
    ////                    }
    ////                });
    ////                if (document.getElementById('TabContainer1_TabTestMaster_TM_ddlReasonn').value == "0") {
    ////                    alert('Kindly provide  Reason');
    ////                    return false;
    ////                }
    ////                //--Murali----//
    ////                var lstCoAuth = [];
    ////                $('#tblCoAuth tbody tr').each(function(i, n) {

    ////                    var $row = $(n);
    ////                    var hdnInvCoAuthID = $row.find($('input[id$="hdnInvCoAuthID"]')).val();
    ////                    var invID = $('#' + hdnInvID).val();
    ////                    var orgID = $('#' + hdnOrgID).val();
    ////                    var type = "Co-Auth";
    ////                    var roleID = $row.find($('input[id$="hdnRole"]')).val();
    ////                    var deptID = $row.find($('input[id$="hdnDept1"]')).val();
    ////                    var userID = $row.find($('input[id$="hdnDoctor"]')).val();
    ////                    var chkReauthPrimaryid = $row.find($('input[id$="hdnDoctor"]')).val();
    ////                    var chkReauthPrimary = $row.find($('input[id$="hdnReauthPrimary"]')).val();

    ////                    lstCoAuth.push({
    ////                        ID: hdnInvCoAuthID,
    ////                        InvestigationID: invID,
    ////                        OrgID: orgID,
    ////                        Type: type,
    ////                        RoleID: roleID,
    ////                        DeptID: deptID,
    ////                        UserID: userID,
    ////                        IsPrimary: chkReauthPrimary

    ////                    });

    ////                });
    ////                if (lstCoAuth.length > 0) {
    ////                    $('#' + hdnLstCoAuth).val(JSON.stringify(lstCoAuth));
    ////                }
    ////                //--- End Of Murali ----------//
    ////                var lstInvOrgRefMapping = [];
    ////                $('#tblInvRefMapping tbody tr').each(function(i, n) {
    ////                    var $row = $(n);
    ////                    var hdnInvRefMappingID = $row.find($('input[id$="hdnInvRefMappingID"]')).val();
    ////                    var hdnDeviceMappingID = $row.find($('input[id$="hdnDeviceMappingID"]')).val();
    ////                    var invID = $('#' + hdnInvID).val();
    ////                    var orgID = $('#' + hdnOrgID).val();
    ////                    var instrumentID = $row.find($('input[id$="hdnInstrumentID"]')).val();
    ////                    // var kitID = $row.find($('input[id$="hdnKitID"]')).val();
    ////                    var kitID = 0;
    ////                    var uOMID = $row.find($('input[id$="hdnRefMappingUOMID"]')).val();
    ////                    var uOMCode = $row.find($('span[id$="lblUOM"]')).html();
    ////                    var hdnRRXML = $row.find($('span[id$="lblRRXML"]'));
    ////                    var referenceRange = '';
    ////                    var isRRXML = false;
    ////                    if ($.trim($(hdnRRXML).html()) == '') {
    ////                        referenceRange = $row.find($('span[id$="lblReferenceRange"]')).html();
    ////                    }
    ////                    else {
    ////                        isRRXML = true;
    ////                        var lblRRString = $row.find($('input[id$="lblRRString"]'));
    ////                        referenceRange = $.trim($(lblRRString).val());
    ////                    }
    ////                    var isPrimary = $row.find($('span[id$="lblPrimary"]')).html();
    ////                    if ($.trim(uOMID) == '') {
    ////                        uOMID = '0';
    ////                    }
    ////                    if (isPrimary == 'Yes') {
    ////                        isPrimary = 'Y';
    ////                    }
    ////                    else {
    ////                        isPrimary = 'N';
    ////                    }
    ////                    var isActive = $row.find($('span[id$="lblActive"]')).html();
    ////                    if (isActive == 'Yes') {
    ////                        isActive = 'Y';
    ////                    }
    ////                    else {
    ////                        isActive = 'N';
    ////                    }
    ////                    var clientID = $row.find($('input[id$="hdnClientID"]')).val();
    ////                    var reasonCode = $row.find($('input[id$="hdnReasonCode"]')).val();
    ////                    // var testCode = $row.find("span[id$='lblTestCode']").html();
    ////                    var testCode = 0;
    ////                    lstInvOrgRefMapping.push({
    ////                        ID: hdnInvRefMappingID,
    ////                        InvestigationID: invID,
    ////                        OrgID: orgID,
    ////                        InstrumentID: instrumentID,
    ////                        KitID: kitID,
    ////                        UOMID: uOMID,
    ////                        UOMCode: uOMCode,
    ////                        ReferenceRange: referenceRange,
    ////                        IsPrimary: isPrimary,
    ////                        IsActive: isActive,
    ////                        ClientID: clientID,
    ////                        ReasonCode: reasonCode,
    ////                        TestCode: testCode,
    ////                        DeviceMappingID: hdnDeviceMappingID,
    ////                        IsRRXML: isRRXML
    ////                    });
    ////                });
    ////                if (lstInvOrgRefMapping.length > 0) {
    ////                    $('#' + hdnLstInvOrgRefMapping).val(JSON.stringify(lstInvOrgRefMapping));
    ////                }

    ////                var lstInvValueRangeMaster = [];
    ////                $('#' + hdnLstInvValueRangeMaster).val = '';
    ////                $('#tblReflex tbody tr').each(function(i, n) {
    ////                    var $row = $(n);
    ////                    var InvestigationID = $('#' + hdnInvID).val();
    ////                    var ReflexTestID = $row.find($('input[id$="hdnReflexTestID"]')).val();
    ////                    var IsReportabl = $row.find($('input[id$="hdnReportable"]')).val();
    ////                    var IsChargeabl = $row.find($('input[id$="hdnChargeable"]')).val();
    ////                    if (IsReportabl == 'Y' || IsReportabl == 'Yes') {
    ////                        var IsReportable = 'Y';
    ////                    }
    ////                    else {
    ////                        IsReportable = 'N';
    ////                    }
    ////                    if (IsChargeabl == 'Y' || IsChargeabl == 'Yes') {
    ////                        var IsChargeable = 'Y';
    ////                    }
    ////                    else {
    ////                        IsChargeable = 'N';
    ////                    }
    ////                    var orgID = $('#' + hdnOrgID).val();
    ////                    lstInvValueRangeMaster.push({
    ////                        InvestigationID: InvestigationID,
    ////                        ReflexInvestigationID: ReflexTestID,
    ////                        OrgID: orgID,
    ////                        IsReportable: IsReportable,
    ////                        IsChargeable: IsChargeable,
    ////                        Type: 'Add'
    ////                    });
    ////                });
    ////                if (lstInvValueRangeMaster.length > 0) {
    ////                    $('#' + hdnLstInvValueRangeMaster).val(JSON.stringify(lstInvValueRangeMaster));
    ////                }
    ////                //   ------ K.Bharathidhasan----------- //
    ////                var lstInvLocation = [];
    ////                $('#' + hdnInvLocation).val('');
    ////                $('#Tabel1 tbody tr').each(function(i, n) {
    ////                    var $row = $(n);
    ////                    var hdnInvestigationID = $row.find($('input[id$="hdnInvestigationID"]')).val();
    ////                    var invID = $('#' + hdnInvID).val();
    ////                    var orgID = $('#' + hdnOrgID).val();
    ////                    var locationID = $row.find($('input[id$="hdnRegLocation"]')).val();
    ////                    var processingOrgID = $row.find($('input[id$="hdnProcessingOrg"]')).val();
    ////                    var processingAddressID = $row.find($('input[id$="hdnProcLocation"]')).val();
    ////                    var type = $row.find($('input[id$="hdnType"]')).val();
    ////                    //                    var type = $row.find($('span[id$="spanType"]')).html();

    ////                    if (type == "INH" || type == "0") {
    ////                        type = 0;
    ////                    }
    ////                    else {
    ////                        type = 12;
    ////                    }
    ////                    var feeType = "INV";


    ////                    lstInvLocation.push({
    ////                        Id: hdnInvestigationID,
    ////                        InvestigationID: invID,
    ////                        OrgID: orgID,
    ////                        LocationID: locationID,
    ////                        ProcessingOrgID: processingOrgID,
    ////                        ProcessingAddressID: processingAddressID,
    ////                        Type: type

    ////                    });
    ////                    if (lstInvLocation.length > 0) {
    ////                        $('#' + hdnInvLocation).val(JSON.stringify(lstInvLocation));
    ////                    }


    ////                });

    ////                //   ------- end ------ //
    ////                $('#' + drpProcessingOrg).children('option:not(:first)').remove();
    ////                $('#' + drpProcessLocation).children('option:not(:first)').remove();
    ////                var table1 = $('#handontable1').handsontable('getInstance');
    ////                var table2 = $('#handontable2').handsontable('getInstance');
    ////                var tableRowsCount1 = table1.countRows();
    ////                var tableColsCount1 = table1.countCols();
    ////                var tableEmptyRowsCount1 = table1.countEmptyRows(true);
    ////                var tableEmptyColsCount1 = table1.countEmptyCols(true);

    ////                var tableRowsCount2 = table2.countRows();
    ////                var tableColsCount2 = table2.countCols();
    ////                var tableEmptyRowsCount2 = table2.countEmptyRows(true);
    ////                var tableEmptyColsCount2 = table2.countEmptyCols(true);

    ////                var tableDataRowsCount1 = tableRowsCount1 - tableEmptyRowsCount1;
    ////                var tableDataColsCount1 = tableColsCount1 - tableEmptyColsCount1;
    ////                var tableDataRowsCount2 = tableRowsCount2 - tableEmptyRowsCount2;
    ////                var tableDataColsCount2 = tableColsCount2 - tableEmptyColsCount2;

    ////                $('#' + hdnHandsonTable1ColumnCount).val(tableDataColsCount1);
    ////                $('#' + hdnHandsonTable2ColumnCount).val(tableDataColsCount2);

    ////                if (tableDataRowsCount1) {
    ////                    tableDataRowsCount1 = tableDataRowsCount1 - 1;
    ////                }
    ////                if (tableDataColsCount1) {
    ////                    tableDataColsCount1 = tableDataColsCount1 - 1;
    ////                }
    ////                if (tableDataRowsCount2) {
    ////                    tableDataRowsCount2 = tableDataRowsCount2 - 1;
    ////                }
    ////                if (tableDataColsCount2) {
    ////                    tableDataColsCount2 = tableDataColsCount2 - 1;
    ////                }
    ////                var tableData1 = table1.getData(0, 0, tableDataRowsCount1, tableDataColsCount1);
    ////                var tableData2 = table2.getData(0, 0, tableDataRowsCount2, tableDataColsCount2);

    ////                if (tableDataRowsCount1 == 0 && tableDataColsCount1 == 0) {
    ////                    $('#' + hdnIsEmptyHandsonTable1).val(true);
    ////                }
    ////                else {
    ////                    $('#' + hdnIsEmptyHandsonTable1).val(false);
    ////                    $('#' + hdnHandsonTable1).val(JSON.stringify(tableData1));
    ////                }
    ////                if (tableDataRowsCount2 == 0 && tableDataColsCount2 == 0) {
    ////                    $('#' + hdnIsEmptyHandsonTable2).val(true);
    ////                }
    ////                else {
    ////                    $('#' + hdnIsEmptyHandsonTable2).val(false);
    ////                    $('#' + hdnHandsonTable2).val(JSON.stringify(tableData2));
    ////                }
    ////                return true;
    ////            }
    ////            else {
    ////                alert("Enter display text");
    ////            }
    ////        }
    ////        catch (e) {
    ////            return false;
    ////        }
    ////        return false;
    ////    }
    function onSave() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_09") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_09") : "Kindly provide  Reason";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_10") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_10") : "Enter Processing Time Value";
        var Useyes = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065") : "Yes";
        var UseNo = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066") : "No";
        var UseY = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_067") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_067") : "Y";
        var UseN = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_068") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_068") : "N";
        var DeltaChkAlert = "Kindly Provide DeltaCheck Calculation";
        var AutoCertificationText = "Please select Auto Certify And Proceed  ";
        //debugger;
        try {
            if ($('[id$="ddlScheduleType"]').val() != -1) {

                if ($('[id$="txtCOTValue"]').val() == '') {
                    // alert("Enter Processing Time Value");
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    $('[id$="txtCOTValue"]').focus();
                    return false;
                }
            }


            if ($('#' + txtDisplayText).val() != '') {
                var lstInvRemarks = [];
                $('#tblRemarks tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var remarksID1 = $row.find($('input[id$="hdnRemarksID"]')).val();
                    var itemremarkid = remarksID1.split('~');
                    var remarksID = itemremarkid[0];
                    lstInvRemarks.push({
                        remarksID: remarksID
                    });
                    if (lstInvRemarks.length > 0) {
                        $('#' + hdnLstInvRemarks).val(JSON.stringify(lstInvRemarks));
                    }
                });
                if (document.getElementById('TabContainer1_TabTestMaster_TM_ddlReasonn').value == "0") {
                    //alert('Kindly provide  Reason');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                var chkDeltaCheck = '<%=chkDeltaCheck.ClientID%>';
                var IsDeltaCheck = $('#' + chkDeltaCheck).is(':checked') ? 'Y' : 'N';
                if (IsDeltaCheck == 'Y')
                 {
                    if (document.getElementById('TabContainer1_TabTestMaster_TM_TabContainer1_tabDeltaCheck_ddlDeltachkcalc').value == -1) {
                        //alert('Kindly provide  Reason');
                        ValidationWindow(DeltaChkAlert, AlrtWinHdr);
                        return false;
                    }
                }
                //--Murali----//

                
                    var ISneedalert = false;
                    if (document.getElementById('<%=chkdeviceerr.ClientID%>').checked == true ||
                    document.getElementById('<%=chkisQCstatus.ClientID%>').checked == true ||
                    document.getElementById('<%=chkiscritical.ClientID%>').checked == true ||
                    document.getElementById('<%=chkdeltaval.ClientID%>').checked == true ||
                    document.getElementById('<%=chkautoauth.ClientID%>').checked == true ||
                    document.getElementById('<%=chkcrossparam.ClientID%>').checked == true ||
                    document.getElementById('<%=chktechverify.ClientID%>').checked == true) {
					if (document.getElementById('<%=chkautocertify.ClientID%>').checked == false) {
                        ISneedalert = true;
                       }
					}

                    if (ISneedalert == true) {
                        ValidationWindow(AutoCertificationText, AlrtWinHdr);

                        return false;
                    }
                var lstCoAuth = [];
                $('#tblCoAuth tbody tr').each(function(i, n) {

                    var $row = $(n);
                    var hdnInvCoAuthID = $row.find($('input[id$="hdnInvCoAuthID"]')).val();
                    var invID = $('#' + hdnInvID).val();
                    var orgID = $('#' + hdnOrgID).val();
                    var type = "Co-Auth";
                    var roleID = $row.find($('input[id$="hdnRole"]')).val();
                    var deptID = $row.find($('input[id$="hdnDept1"]')).val();
                    var userID = $row.find($('input[id$="hdnDoctor"]')).val();
                    var chkReauthPrimaryid = $row.find($('input[id$="hdnDoctor"]')).val();
                    var chkReauthPrimary = $row.find($('input[id$="hdnReauthPrimary"]')).val();

                    lstCoAuth.push({
                        ID: hdnInvCoAuthID,
                        InvestigationID: invID,
                        OrgID: orgID,
                        Type: type,
                        RoleID: roleID,
                        DeptID: deptID,
                        UserID: userID,
                        IsPrimary: chkReauthPrimary

                    });

                });
                if (lstCoAuth.length > 0) {
                    $('#' + hdnLstCoAuth).val(JSON.stringify(lstCoAuth));
                }
                //--- End Of Murali ----------//
                var lstInvOrgRefMapping = [];
                $('#tblInvRefMapping tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var hdnInvRefMappingID = $row.find($('input[id$="hdnInvRefMappingID"]')).val();
                    var hdnDeviceMappingID = $row.find($('input[id$="hdnDeviceMappingID"]')).val();
                    var invID = $('#' + hdnInvID).val();
                    var orgID = $('#' + hdnOrgID).val();
                    var instrumentID = $row.find($('input[id$="hdnInstrumentID"]')).val();
                    // var kitID = $row.find($('input[id$="hdnKitID"]')).val();
                    var kitID = 0;
                    var uOMID = $row.find($('input[id$="hdnRefMappingUOMID"]')).val();
                    var uOMCode = $row.find($('span[id$="lblUOM"]')).html();
                    var hdnRRXML = $row.find($('span[id$="lblRRXML"]'));
                    var referenceRange = '';
                    var isRRXML = false;
                    if ($.trim($(hdnRRXML).html()) == '') {
                        referenceRange = $row.find($('span[id$="lblReferenceRange"]')).html();
                    }
                    else {
                        isRRXML = true;
                        var lblRRString = $row.find($('input[id$="lblRRString"]'));
                        referenceRange = $.trim($(lblRRString).val());
                    }
                    var isPrimary = $row.find($('span[id$="lblPrimary"]')).html();
                    if ($.trim(uOMID) == '') {
                        uOMID = '0';
                    }
                    if (isPrimary == Useyes) {
                        isPrimary = UseY;
                    }
                    else {
                        isPrimary = UseN;
                    }
                    var isActive = $row.find($('span[id$="lblActive"]')).html();
                    if (isActive == Useyes) {
                        isActive = UseY;
                    }
                    else {
                        isActive = UseN;
                    }
                    var clientID = $row.find($('input[id$="hdnClientID"]')).val();
                    var reasonCode = $row.find($('input[id$="hdnReasonCode"]')).val();
                    // var testCode = $row.find("span[id$='lblTestCode']").html();
                    var testCode = 0;
                    // Sathish.E//

                    //                    var ConUOMID = $row.find($('input[id$="hdnRefMappingConvUOMID"]')).val();
                    //                    var ConUOMCode = $row.find($('span[id$="lblConvUOMCode"]')).html();
                    //                    var ConvFactorValues = $row.find($('span[id$="lblConvFactor"]')).html();
                    //                    var ConvDecimal = $row.find($('span[id$="lblConvDecimal"]')).html();
                    //debugger;
                    var ConUOMID = $row.find("input[id$='hdnRefMapConv_UOMID']").val();
                    var ConUOMCode = $row.find("span[id$='lblRefMapConv_UOM']").html();
                    var ConvFactorValues = $row.find("span[id$='lblRefMapConv_Factor']").html();
                    var ConvDecimal = $row.find("span[id$='lblRefMapConvFac_DecimalPoint']").html();
                    if (ConvFactorValues == '' || ConvFactorValues == null) {
                        ConvFactorValues = 0;
                    }
                    if (ConvDecimal == '' || ConvDecimal == null) {
                        ConvDecimal = 0;
                    }
                    lstInvOrgRefMapping.push({
                        ID: hdnInvRefMappingID,
                        InvestigationID: invID,
                        OrgID: orgID,
                        InstrumentID: instrumentID,
                        KitID: kitID,
                        UOMID: uOMID,
                        UOMCode: uOMCode,
                        ReferenceRange: referenceRange,
                        IsPrimary: isPrimary,
                        IsActive: isActive,
                        ClientID: clientID,
                        ReasonCode: reasonCode,
                        TestCode: testCode,
                        DeviceMappingID: hdnDeviceMappingID,
                        IsRRXML: isRRXML,
                        CONV_UOMID: ConUOMID,
                        CONV_UOMCode: ConUOMCode,
                        CONV_Factor: ConvFactorValues,
                        ConvFac_DecimalPoint: ConvDecimal
                    });
                });
                if (lstInvOrgRefMapping.length > 0) {
                    $('#' + hdnLstInvOrgRefMapping).val(JSON.stringify(lstInvOrgRefMapping));
                }

                var lstInvValueRangeMaster = [];
                $('#' + hdnLstInvValueRangeMaster).val = '';
                $('#tblReflex tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var InvestigationID = $('#' + hdnInvID).val();
                    var ReflexTestID = $row.find($('input[id$="hdnReflexTestID"]')).val();
                    var IsReportabl = $row.find($('input[id$="hdnReportable"]')).val();
                    var IsChargeabl = $row.find($('input[id$="hdnChargeable"]')).val();
                    var reflexSampleType = $row.find($('input[id$="hdnTesttypes"]')).val();
                    if (IsReportabl == 'Y' || IsReportabl == 'Yes') {
                        var IsReportable = 'Y';
                    }
                    else {
                        IsReportable = 'N';
                    }
                    if (IsChargeabl == 'Y' || IsChargeabl == 'Yes') {
                        var IsChargeable = 'Y';
                    }
                    else {
                        IsChargeable = 'N';
                    }
                    var orgID = $('#' + hdnOrgID).val();
                    lstInvValueRangeMaster.push({
                        InvestigationID: InvestigationID,
                        ReflexInvestigationID: ReflexTestID,
                        OrgID: orgID,
                        IsReportable: IsReportable,
                        IsChargeable: IsChargeable,
                        reflexSampleType:reflexSampleType,
                        Type: 'Add'
                    });
                });
                if (lstInvValueRangeMaster.length > 0) {
                    $('#' + hdnLstInvValueRangeMaster).val(JSON.stringify(lstInvValueRangeMaster));
                }
                //santhosh for cross delta parameter
                var lstInvCrossparameterTest = [];
                $('#' + hdnlstInvCrossparameterTest).val = '';
                $('#tblCross tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var InveId = $('#' + hdnInvID).val();
                    var CrossTestID = $row.find($('input[id$="hdnCrossTestID"]')).val();
                    var orgID = $('#' + hdnOrgID).val();
                    lstInvCrossparameterTest.push({
                        InvestigationID: InveId,
                        ReflexInvestigationID: CrossTestID,
                        OrgID: orgID,
                        Type: 'Add'
                    });
                });
                if (lstInvCrossparameterTest.length > 0) {
                    $('#' + hdnlstInvCrossparameterTest).val(JSON.stringify(lstInvCrossparameterTest));
                }

                //End
                //   ------ K.Bharathidhasan----------- //
                var lstInvLocation = [];
                $('#' + hdnInvLocation).val('');
                $('#Tabel1 tbody tr').each(function(i, n) {
                    var $row = $(n);
                    var hdnInvestigationID = $row.find($('input[id$="hdnInvestigationID"]')).val();
                    var invID = $('#' + hdnInvID).val();
                    var orgID = $('#' + hdnOrgID).val();
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
                    var feeType = "INV";


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
                $('#' + drpProcessingOrg).children('option:not(:first)').remove();
                $('#' + drpProcessLocation).children('option:not(:first)').remove();
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

                $('#' + hdnHandsonTable1ColumnCount).val(tableDataColsCount1);
                $('#' + hdnHandsonTable2ColumnCount).val(tableDataColsCount2);

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
                    $('#' + hdnIsEmptyHandsonTable1).val(true);
                }
                else {
                    $('#' + hdnIsEmptyHandsonTable1).val(false);
                    $('#' + hdnHandsonTable1).val(JSON.stringify(tableData1));
                }
                if (tableDataRowsCount2 == 0 && tableDataColsCount2 == 0) {
                    $('#' + hdnIsEmptyHandsonTable2).val(true);
                }
                else {
                    $('#' + hdnIsEmptyHandsonTable2).val(false);
                    $('#' + hdnHandsonTable2).val(JSON.stringify(tableData2));
                }
                return true;
            }
            else {
                //alert("Enter display text");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function Validate() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") : "Select Remarks Type";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_12") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_12") : "Enter Remark Code";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") : "Enter New Remark";
        var UsrAlrtMsg3 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_14") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_14") : "Added Successfully";
        var UsrAlrtMsg4 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_15") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_15") : "Code already exists";
        var UsrAlrtMsg5 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_16") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_16") : "Error! Not Inserted";


        try {
            if ($('#' + ddlType + ' option:selected').val() == '0') {
                // alert("Select Remarks Type");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                $('#' + ddlType).focus();
                return false;
            }
            else if (document.getElementById("<%=txtremarkCode.ClientID %>").value == "") {
                //alert('Enter Remark Code');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                return false;

            }
            else if (document.getElementById("<%=txtremark.ClientID %>").value == "") {
                //alert('Enter New Remark');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                return false;

            }
            else {
                var RemarkCode = (document.getElementById("<%=txtremarkCode.ClientID %>").value);
                var Remark = (document.getElementById("<%=txtremark.ClientID %>").value);
                var RemarkType;
                if ($('#' + ddlType + ' option:selected').val() == 'M') {
                    RemarkType = 'M';
                }
                else if ($('#' + ddlType + ' option:selected').val() == 'T') {
                    RemarkType = 'T';
                }
                else if ($('#' + ddlType + ' option:selected').val() == 'I') {
                    RemarkType = 'I';
                }
                else if ($('#' + ddlType + ' option:selected').val() == 'N') {
                    RemarkType = 'N';
                }
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/InsertRemarks",
                    data: "{'RemarkType': '" + RemarkType + "','RemarkCode': '" + RemarkCode + "','Remark': '" + Remark + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        var lstresult = data.d;

                        if (lstresult == 0) {
                            //alert("Added Successfully");
                            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                            $('#' + ddlType + '').val('0');
                            document.getElementById("<%=txtremarkCode.ClientID %>").value = ""
                            document.getElementById("<%=txtremark.ClientID %>").value = ""
                        }
                        else {
                            //alert("Code already exists");
                            ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                            $('#' + ddlType + '').val('0');
                            document.getElementById("<%=txtremarkCode.ClientID %>").value = ""
                            document.getElementById("<%=txtremark.ClientID %>").value = ""
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        //alert("Error! Not Inserted");
                        ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                        $('#' + ddlType + '').val('0');
                        document.getElementById("<%=txtremarkCode.ClientID %>").value = ""
                        document.getElementById("<%=txtremark.ClientID %>").value = ""
                    }
                });
            }




        }
        catch (e) {
            return false;
        }
    }

    function ValidateRemarks() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_02") : "Select Remarks Type";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_03") : "Select Remarks";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_13") : "Enter New Remark";

        try {
            if ($('#' + ddlRtype + ' option:selected').val() == '0') {
                // alert("Select remarks type");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                $('#' + ddlRtype).focus();

            }
            else if (document.getElementById("<%=txttext.ClientID %>").value == "") {
                //alert('Select Remark');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                return false;
            }
            else if (document.getElementById("<%=txttextRemark.ClientID %>").value == "") {
                //alert('Enter New Remark');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                return false;
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function validateCurrency(amount) {
        var regex = /^[1-9]\d*(?:\.\d{0,2})?$/;
        return regex.test(amount);
    }
    function inputOnlyNumbers(evt) {
        var e = window.event || evt;
        var charCode = e.which || e.keyCode;
        if ((charCode > 47 && charCode < 58) || charCode == 8) {
            return true;
        }
        return false;
    }
    function ClearRefRangeValue() {
        try {
            $('#' + hdnIsRRXML).val('false');
            $('#' + hdnIsChangesFromRRPopup).val('false');
            $('#' + hdnAgeRangeAdd).val('');
            $('#' + hdnGenderRangeAdd).val('');
            $('#' + hdnOtherReferenceRangeAdd).val('');
            $('#' + hdnRRStringAdd).val('');
            $('#' + hdnRRXMLAdd).val('');
            $('#' + txtReferenceRange).val('');
            $('#' + txtROReferenceRange).val('');
            $('#' + txtReferenceRange).attr('readonly', false);
            $('#divReferenceRangeHint').hide();
        }
        catch (e) {
            return false;
        }
    }
    function ShowRemarkPopup() {
        $('#divModalAddRemarks').show();
        return false;
    }
    function ShowRefRangePopup() {
        var UsrAlrtMsg = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_011") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_011") : "Reference Range";
        var UsrAlrtMsg1 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_012") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_012") : "Critical Range";
        var UsrAlrtMsg2 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_013") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_013") : "Auto Authorization Range";
        var UsrAlrtMsg3 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_014") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_014") : "Domain Range";
        var UsrAlrtMsg4 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_015") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_015") : "Printable Range";
        var UsrAlrtMsg5 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_016") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_016") : "Sensitive Result Range";
        var UsrAlrtMsg6 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_017") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_017") : "Results Interpretation Range";


        $('#divModalRefRange').show();
        $('#tblRange tbody tr').remove();

        $('#' + ddlRefRangeType + ' option:first').attr('selected', true);
        onChangeRefRangeType();
        if ($('#' + hdnRRStringAdd).val() != '') {
            var ReferenceStr = $('#' + hdnRRStringAdd).val();
            var lstRefRange = ReferenceStr.split('#');
            if (lstRefRange != null) {
                if (lstRefRange.length == 1) {
                    var range;
                    var RefRangeStr = lstRefRange[0].split('$');
                    if (RefRangeStr.length >= 1) {
                        $('#' + ddlRefRangeType).val(RefRangeStr[0]);
                        onChangeRefRangeType();
                        if (RefRangeStr[0] == 'referencerange') {
                            // range = 'Reference Range';
                            range = UsrAlrtMsg;
                        }
                        else if (RefRangeStr[0] == 'panicrange') {
                            //range = 'Critical Range';
                            range = UsrAlrtMsg1;
                        }
                        else if (RefRangeStr[0] == 'autoauthorizationrange') {
                            //range = 'Auto Authorization Range';
                            range = UsrAlrtMsg2;
                        }
                        else if (RefRangeStr[0] == 'domainrange') {
                            //range = 'Domain Range';
                            range = UsrAlrtMsg3;
                        }
                        else if (RefRangeStr[0] == 'printablerange') {
                            //range = 'Printable Range';
                            range = UsrAlrtMsg4;
                        }
                        else if (RefRangeStr[0] == 'sensitiveresultrange') {
                            //range = 'Sensitive Result Range';
                            range = UsrAlrtMsg5;
                        }
                        else if (RefRangeStr[0] == 'resultsinterpretationrange') {
                            //range = 'Results Interpretation Range';
                            range = UsrAlrtMsg6;
                        }
                        loadRefRangeDetails(RefRangeStr[0], ReferenceStr, true, range);
                    }
                }
                else if (lstRefRange.length > 1) {
                    $('#' + ddlRefRangeType + ' > option:not(:first)').each(function() {
                        loadRefRangeDetails($(this).val(), ReferenceStr, false, $(this).text());
                    });
                }

                if ($('#tblRange tr').length > 2) {
                    $('#divReferenceRangeTable').show();

                }


            }

        }
        return false;
    }
    function loadRefRangeDetails(RangeType, ReferenceStr, isSingleRange, RangeTypeName) {
        try {
            var varAge = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_054') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_054') : "Age";
            var varCommon = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_055') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_055') : "Common";
            var varOther = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_056') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_056') : "Other";
            var varBoth = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_058') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_058') : "Both";
            var varFemale = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_059') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_059') : "Female";
            var varMale = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_060') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_060') : "Male";
            var varDays = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_061') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_061') : "Day(s)";
            var varMonths = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_062') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_062') : "Month(s)";
            var varWeeks = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_063') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_063') : "Week(s)";
            var varYears = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_064') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_064') : "Year(s)";
            var varNA = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_071') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_071') : "NA";
            var lstRefRange = ReferenceStr.split('#');
            if (lstRefRange != null && lstRefRange.length > 0) {
                $.each(lstRefRange, function(i, item) {
                    var RefRangeStr = item.split('$');
                    if (RefRangeStr.length >= 1) {
                        if (RefRangeStr[0] == RangeType) {
                            var lstSubCatagory = RefRangeStr[1].split('@');
                            $.each(lstSubCatagory, function(j, subItem) {
                                var tempRR = subItem.split('|');
                                if (tempRR.length > 1) {
                                    var addedValue = tempRR[0];
                                    var dataArray = new Array();
                                    var dataSubArray = new Array();
                                    dataArray = addedValue.split('^');
                                    var row$;
                                    if (tempRR[1] == "Age") {
                                        $('#divReferenceRangeTable').hide();
                                        for (var i = 0; i < dataArray.length - 1; i++) {
                                            row$ = $('<tr/>');
                                            dataSubArray = dataArray[i].split('~');
                                            if (dataSubArray[0] != "") {
                                                if (dataSubArray[0] == "Both") {
                                                    dataSubArray[0] = varBoth;
                                                }
                                                else if (dataSubArray[0] == "Female") {
                                                    dataSubArray[0] = varFemale;
                                                }
                                                else if (dataSubArray[0] == "Male") {
                                                    dataSubArray[0] = varMale;
                                                }
                                                else if (dataSubArray[0] == "NA") {
                                                    dataSubArray[0] = varNA;
                                                }
                                                else {
                                                    dataSubArray[0] = varBoth;
                                                }
                                            }
                                            if (dataSubArray[3] != "") {
                                                if (dataSubArray[3] == "Day(s)") {
                                                    dataSubArray[3] = varDays;
                                                }
                                                else if (dataSubArray[3] == "Month(s)") {
                                                    dataSubArray[3] = varMonths;
                                                }
                                                else if (dataSubArray[3] == "Week(s)") {
                                                    dataSubArray[3] = varWeeks;
                                                }
                                                else if (dataSubArray[3] == "Year(s)") {
                                                    dataSubArray[3] = varYears;
                                                }
//                                                else {
//                                                    dataSubArray[3] = varDays;
//                                                }
                                            }
                                            row$.append($('<td/>').html('<span>' + RangeTypeName + '</span>'));

                                            row$.append($('<td/>').html('<span>' + dataSubArray[0] + '</span>'));
                                            row$.append($('<td/>').html('<span>' + varAge + '</span>'));
                                            if (dataSubArray[1] == 'Between') {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[2] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[1] + ' ' + dataSubArray[2] + '</span>'));
                                            }
                                            row$.append($('<td/>').html('<span>' + dataSubArray[3] + '</span>'));
                                            row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            if (dataSubArray[4] == 'Between' || dataSubArray[4] == 'Source') {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[5] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[4] + ' ' + dataSubArray[5] + '</span>'));
                                            }
                                            row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            if (dataSubArray[4] == 'Source') {
                                                row$.append($('<td/>').html('<span>Y</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[6] != null && dataSubArray[6] != "") {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[6] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[7] != null && dataSubArray[7] != "") {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[7] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[8] != null && dataSubArray[8] != "") {
                                                var selectedDevice = $("#" + ddlAgeDevice + " option").filter(function(index) { return $(this).val() === dataSubArray[8]; });
                                                row$.append($('<td/>').html('<span>' + $(selectedDevice).text() + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            var hdnAgeRange = '<input id="hdnAgeRange" type="hidden" value="' + (dataArray[i] + "^") + '"/>';

                                            row$.append($('<td align="center"/>').html(hdnAgeRange + '<input id="btnEditAgeReferenceRange1" value="' + lbledit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditAgeReferenceRange(this);" />' + '<input id="btnDeleteAgeReferenceRange1" value="' + lbldeletes + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteAgeReferenceRange(this);"  />'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnRefRangeID" value="' + RefRangeStr[0] + '" ">' + '</span>'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnGenderValue"  value="' + dataSubArray[0] + '" ">' + '</span>'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnSubcategoryValue" value="' + dataSubArray[0] + '" ">' + '</span>'));
                                            var RefRange = '<input id="hdnRefRangeID"  value="' + RefRangeStr[0] + '"/>';
                                            var GenderVal = '<input id="hdnGenderValue"  value="' + dataSubArray[0] + '"/>';
                                            var SubCategory = '<input id="hdnSubcategoryValue" value="' + tempRR[1] + '"/>';
                                            row$.append($('<td style="display:none"/>').html('<input id="hdnRefRangeID"  value="' + RefRangeStr[0] + '"/>' + '<input id="hdnGenderValue"  value="' + dataSubArray[0] + '"/>' + '<input id="hdnSubcategoryValue" value="' + tempRR[1] + '"/>'));

                                            $('#tblRange tbody').append(row$);
                                        }

                                        if (isSingleRange) {
                                            $('#divReferenceRangeTable').show();
                                        }

                                        if (isSingleRange) {
                                            $('#' + ddlRRSubCategory + ' option').filter(function() { return $.trim($(this).text()) == $.trim(tempRR[1]); }).attr('selected', true);
                                        }
                                        onChangeRRSubCategory();
                                        if ($('#' + hdnAgeRangeAdd).val() == '') {
                                            $('#' + hdnAgeRangeAdd).val(RangeType + "$" + tempRR[0] + "|" + tempRR[1]);
                                        }
                                        else {
                                            $('#' + hdnAgeRangeAdd).val($('#' + hdnAgeRangeAdd).val() + "#" + RangeType + "$" + tempRR[0] + "|" + tempRR[1]);
                                        }
                                        $('#' + divScrolling).show();

                                        $('#' + hdnGenderRangeAdd).val('');
                                        $('#' + hdnOtherReferenceRangeAdd).val('');

                                        $('#divValueBetween').hide();
                                        $('#' + txtValueRange2).val('');

                                        $('#divAgeBetween').hide();
                                        $('#' + txtAgeRange2).val('');
                                    }
                                    if (tempRR[1] == "Common") {

                                        for (var i = 0; i < dataArray.length - 1; i++) {
                                            row$ = $('<tr/>');
                                            dataSubArray = dataArray[i].split('~');
                                            if (dataSubArray[0] != "") {
                                                if (dataSubArray[0] == "Both") {
                                                    dataSubArray[0] = varBoth;
                                                }
                                                else if (dataSubArray[0] == "Female") {
                                                    dataSubArray[0] = varFemale;
                                                }
                                                else if (dataSubArray[0] == "Male") {
                                                    dataSubArray[0] = varMale;
                                                }
                                                else if (dataSubArray[0] == "NA") {
                                                    dataSubArray[0] = varNA;
                                                }
                                                else {
                                                    dataSubArray[0] = varBoth;
                                                }
                                            }
                                            if (dataSubArray[3] != "") {
                                                if (dataSubArray[3] == "Day(s)") {
                                                    dataSubArray[3] = varDays;
                                                }
                                                else if (dataSubArray[3] == "Month(s)") {
                                                    dataSubArray[3] = varMonths;
                                                }
                                                else if (dataSubArray[3] == "Week(s)") {
                                                    dataSubArray[3] = varWeeks;
                                                }
                                                else if (dataSubArray[3] == "Year(s)") {
                                                    dataSubArray[3] = varYears;
                                                }
//                                                else {
//                                                    dataSubArray[3] = varDays;
//                                                }
                                            }
                                            row$.append($('<td/>').html('<span>' + RangeTypeName + '</span>'));
                                            row$.append($('<td/>').html('<span>' + dataSubArray[0] + '</span>'));
                                            row$.append($('<td/>').html('<span>' + varCommon + '</span>'));
                                            row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            if (dataSubArray[1] == 'Between' || dataSubArray[1] == 'Source') {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[2] + '</span>'));
                                            } else {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[1] + ' ' + dataSubArray[2] + '</span>'));
                                            }
                                            row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            if (dataSubArray[1] == 'Source') {
                                                row$.append($('<td/>').html('<span>Y</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[3] != null && dataSubArray[3] != "") {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[3] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[4] != null && dataSubArray[4] != "") {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[4] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[5] != null && dataSubArray[5] != "") {
                                                var selectedDevice = $("#" + ddlCommonDevice + " option").filter(function(index) { return $(this).val() === dataSubArray[5]; });
                                                row$.append($('<td/>').html('<span>' + $(selectedDevice).text() + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            var hdnGenderRange = '<input id="hdnGenderRange" type="hidden" value="' + (dataArray[i] + "^") + '"/>';

                                            row$.append($('<td align="center"/>').html(hdnGenderRange + '<input id="btnEditCommonReferenceRange" value="' + lbledit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditCommonReferenceRange(this);" />' + '<input id="btnDeleteCommonReferenceRange1" value="' + lbldeletes + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteCommonReferenceRange(this);" />'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnRefRangeID"  value="' + RefRangeStr[0] + '" ">' + '</span>'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnGenderValue"  value="' + dataSubArray[0] + '" ">' + '</span>'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnSubcategoryValue" value="' + dataSubArray[0] + '" ">' + '</span>'));
                                            var RefRange = '<input id="hdnRefRangeID"  value="' + RefRangeStr[0] + '"/>';
                                            var GenderVal = '<input id="hdnGenderValue"  value="' + dataSubArray[0] + '"/>';
                                            var SubCategory = '<input id="hdnSubcategoryValue" value="' + tempRR[1] + '"/>';
                                            row$.append($('<td style="display:none"/>').html('<input id="hdnRefRangeID"  value="' + RefRangeStr[0] + '"/>' + '<input id="hdnGenderValue"  value="' + dataSubArray[0] + '"/>' + '<input id="hdnSubcategoryValue" value="' + tempRR[1] + '"/>'));
                                            $('#tblRange tbody').append(row$);

                                        }

                                        if (isSingleRange) {
                                            $('#divReferenceRangeTable').show();
                                        }

                                        if (isSingleRange) {
                                            $('#' + ddlRRSubCategory + ' option').filter(function() { return $.trim($(this).text()) == $.trim(tempRR[1]); }).attr('selected', true);
                                        }
                                        onChangeRRSubCategory();
                                        if ($('#' + hdnGenderRangeAdd).val() == '') {
                                            $('#' + hdnGenderRangeAdd).val(RangeType + "$" + tempRR[0] + "|" + tempRR[1]);
                                        }
                                        else {
                                            $('#' + hdnGenderRangeAdd).val($('#' + hdnGenderRangeAdd).val() + "#" + RangeType + "$" + tempRR[0] + "|" + tempRR[1]);
                                        }
                                        $('#' + divScrolling).show();

                                        $('#' + hdnAgeRangeAdd).val('');
                                        $('#' + hdnOtherReferenceRangeAdd).val('');

                                        $('#' + txtGenderValueEnd).val('');
                                    }
                                    if (tempRR[1] == "Other") {

                                        for (var i = 0; i < dataArray.length - 1; i++) {
                                            row$ = $('<tr/>');
                                            dataSubArray = dataArray[i].split('~');
                                            if (dataSubArray[0] != "") {
                                                if (dataSubArray[0] == "Both") {
                                                    dataSubArray[0] = varBoth;
                                                }
                                                else if (dataSubArray[0] == "Female") {
                                                    dataSubArray[0] = varFemale;
                                                }
                                                else if (dataSubArray[0] == "Male") {
                                                    dataSubArray[0] = varMale;
                                                }
                                                else if (dataSubArray[0] == "NA") {
                                                    dataSubArray[0] = varNA;
                                                }
                                                else {
                                                    dataSubArray[0] = varBoth;
                                                }
                                            }
                                            if (dataSubArray[6] != "") {
                                                if (dataSubArray[6] == "Day(s)") {
                                                    dataSubArray[6] = varDays;
                                                }
                                                else if (dataSubArray[6] == "Month(s)") {
                                                    dataSubArray[6] = varMonths;
                                                }
                                                else if (dataSubArray[6] == "Week(s)") {
                                                    dataSubArray[6] = varWeeks;
                                                }
                                                else if (dataSubArray[6] == "Year(s)") {
                                                    dataSubArray[6] = varYears;
                                                }
                                                else {
                                                    dataSubArray[3] = varDays;
                                                }
                                            }
                                            row$.append($('<td/>').html('<span>' + RangeTypeName + '</span>'));
                                            row$.append($('<td/>').html('<span>' + dataSubArray[0] + '</span>'));
                                            row$.append($('<td/>').html('<span>' + varOther + '</span>'));
                                            if (dataSubArray[7] == 'Between') {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[8] + '</span>'));
                                            }
                                            else if (dataSubArray[7] != '') {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[7] + ' ' + dataSubArray[8] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            row$.append($('<td/>').html('<span>' + (dataSubArray[6] == '' ? '-' : dataSubArray[6]) + '</span>'));
                                            row$.append($('<td/>').html('<span>' + dataSubArray[1] + '</span>'));
                                            if (dataSubArray[2] == 'Between' || dataSubArray[2] == 'Source') {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[3] + '</span>'));
                                            } else {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[2] + ' ' + dataSubArray[3] + '</span>'));
                                            }
                                            if (dataSubArray[4] == '') {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));

                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[4] + '</span>'));

                                            }
                                            if (dataSubArray[2] == 'Source') {
                                                row$.append($('<td/>').html('<span>Y</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[9] != null && dataSubArray[9] != "") {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[9] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[10] != null && dataSubArray[10] != "") {
                                                row$.append($('<td/>').html('<span>' + dataSubArray[10] + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[11] != null && dataSubArray[11] != "") {
                                                var selectedDevice = $("#" + ddlOtherDevice + " option").filter(function(index) { return $(this).val() === dataSubArray[11]; });
                                                row$.append($('<td/>').html('<span>' + $(selectedDevice).text() + '</span>'));
                                            }
                                            else {
                                                row$.append($('<td/>').html('<span>' + '-' + '</span>'));
                                            }
                                            if (dataSubArray[12] == 'Text') {
                                                $('#' + rdoResultTypeText).attr('checked', true);

                                            }
                                            else if (dataSubArray[12] == 'Numeric') {
                                                $('#' + rdoResultTypeNumeric).attr('checked', true);
                                            }

                                            var hdnOtherRange = '<input id="hdnOtherRange" type="hidden" value="' + (dataArray[i] + "^") + '"/>';

                                            row$.append($('<td align="center"/>').html(hdnOtherRange + '<input id="btnEditOthersReferenceRange1" value="' + lbledit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditOthersReferenceRange(this);" />' + '<input id="btnDeleteOtherReferenceRange1" value="' + lbldeletes + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteOtherReferenceRange(this);" />'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnRefRangeID"  value="'+RefRangeStr[0] +'" ">' + '</span>'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnGenderValue" value="'+dataSubArray[0] +'" ">' + '</span>'));
                                            //                                            row$.append($('<td/>').html('<span id="hdnSubcategoryValue" value="' + dataSubArray[0] + '" ">' + '</span>'));
                                            var RefRange = '<input id="hdnRefRangeID"  value="' + RefRangeStr[0] + '"/>';
                                            var GenderVal = '<input id="hdnGenderValue"  value="' + dataSubArray[0] + '"/>';
                                            var SubCategory = '<input id="hdnSubcategoryValue" value="' + tempRR[1] + '"/>';
                                            row$.append($('<td style="display:none"/>').html('<input id="hdnRefRangeID"  value="' + RefRangeStr[0] + '"/>' + '<input id="hdnGenderValue"  value="' + dataSubArray[0] + '"/>' + '<input id="hdnSubcategoryValue" value="' + tempRR[1] + '"/>'));
                                            $('#tblRange tbody').append(row$);


                                        }

                                        if (isSingleRange) {
                                            $('#divReferenceRangeTable').show();
                                        }
                                        if (isSingleRange) {
                                            $('#' + ddlRRSubCategory + ' option').filter(function() { return $.trim($(this).text()) == $.trim(tempRR[1]); }).attr('selected', true);
                                        }
                                        onChangeRRSubCategory();
                                        if ($('#' + hdnOtherReferenceRangeAdd).val() == '') {
                                            $('#' + hdnOtherReferenceRangeAdd).val(RangeType + "$" + tempRR[0] + "|" + tempRR[1]);
                                        }
                                        else {
                                            $('#' + hdnOtherReferenceRangeAdd).val($('#' + hdnOtherReferenceRangeAdd).val() + "#" + RangeType + "$" + tempRR[0] + "|" + tempRR[1]);
                                        }
                                        $('#' + divScrolling).show();

                                        $('#' + hdnAgeRangeAdd).val('');
                                        $('#' + hdnGenderRangeAdd).val('');

                                        $('#' + txtOtherRange2).val('');
                                    }
                                }
                            });
                        }
                    }
                });
            }
        }
        catch (e) {
            return false;
        }
    }
    function HideRefRangePopup() {
        $('#divModalRefRange').hide();
        $('#divModalAddRemarks').hide();
        return false;
    }
    function EditFunction() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_34") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_34") : "Updated Successfully";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_35") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_35") : "Already exists";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_36") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_36") : "Oops! Error Occured";
        try {
            var RemarkId = document.getElementById(hdnSelectedRemarksID1).value;
            var Remark = (document.getElementById("<%=txttextRemark.ClientID %>").value);
            var RemarkCode = (document.getElementById("<%=txtRCode.ClientID %>").value);
            var RemarkType;
            if ($('#' + ddlRtype + ' option:selected').val() == 'M') {
                RemarkType = 'M';
            }
            else if ($('#' + ddlRtype + ' option:selected').val() == 'T') {
                RemarkType = 'T';
            }
            else if ($('#' + ddlRtype + ' option:selected').val() == 'I') {
                RemarkType = 'I';
            }
            else if ($('#' + ddlRtype + ' option:selected').val() == 'N') {
                RemarkType = 'N';
            }
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/UpdateRemarks",
                data: "{'RemarkType': '" + RemarkType + "',RemarkID:" + RemarkId + ",'Remarktext': '" + Remark + "','RemarkCode': '" + RemarkCode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {

                    var lstresultRemark = data.d;
                    if (lstresultRemark == 0) {
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        //alert("Updated Successfully");
                        $('#' + ddlRtype + '').val('0');
                        document.getElementById("<%=txttextRemark.ClientID %>").value = ""
                        document.getElementById("<%=txttext.ClientID %>").value = ""
                        document.getElementById("<%=txtRCode.ClientID %>").value = ""


                    }
                    else {
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        // alert("Already exists");
                        $('#' + ddlRtype + '').val('0');
                        document.getElementById("<%=txttextRemark.ClientID %>").value = ""
                        document.getElementById("<%=txttext.ClientID %>").value = ""
                        document.getElementById("<%=txtRCode.ClientID %>").value = ""
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    // alert("Oops! Error Occured");
                    $('#' + ddlRtype + '').val('0');
                    document.getElementById("<%=txttextRemark.ClientID %>").value = ""
                    document.getElementById("<%=txttext.ClientID %>").value = ""
                    document.getElementById("<%=txtRCode.ClientID %>").value = ""
                }
            });

        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onChangeRefRangeType() {
        try {

            var selectedRefRangeType = $('#' + ddlRefRangeType + ' option:selected');
            $('#' + ddlCategory + ' option:first').attr('selected', true);
            $('#' + ddlRRSubCategory + ' option:first').attr('selected', true);
            $("#tdAgeBulkData").hide();
            $("#tdCommonBulkData").hide();
            $("#tdOtherBulkData").hide();
            $("#tdAgeResult").hide();
            $("#tdCommonResult").hide();
            $("#tdOtherResult").hide();
            $("#tdAgeDevice").hide();
            $("#tdCommonDevice").hide();
            $("#tdOtherDevice").hide();
            onChangeRRSubCategory();
            if (selectedRefRangeType[0].innerHTML == 'Reference Range') {

                $("#tblRange tbody tr").each(function(i, n) {
                    var $row = $(n);
                    $row.show();
                    if ($row.find("td:eq(0)").find('span').html() != selectedRefRangeType[0].innerHTML) {
                        $row.hide();
                    }
                });

            }
            if (selectedRefRangeType[0].innerHTML == 'Critical Range') {
                $("#tblRange tbody tr").each(function(i, n) {
                    var $row = $(n);
                    $row.show();
                    if ($row.find("td:eq(0)").find('span').html() != selectedRefRangeType[0].innerHTML) {
                        $row.hide();
                    }
                });
            }
            if (selectedRefRangeType[0].innerHTML == 'Auto Authorization Range') {

                $("#tblRange tbody tr").each(function(i, n) {
                    var $row = $(n);
                    $row.show();
                    if ($row.find("td:eq(0)").find('span').html() != selectedRefRangeType[0].innerHTML) {
                        $row.hide();
                    }
                });
            }
            if (selectedRefRangeType[0].innerHTML == 'Domain Range') {
                $("#tblRange tbody tr").each(function(i, n) {
                    var $row = $(n);
                    $row.show();
                    if ($row.find("td:eq(0)").find('span').html() != selectedRefRangeType[0].innerHTML) {
                        $row.hide();
                    }
                });
            }
            if (selectedRefRangeType[0].innerHTML == 'Printable Range') {
                $("#tblRange tbody tr").each(function(i, n) {
                    var $row = $(n);
                    $row.show();
                    if ($row.find("td:eq(0)").find('span').html() != selectedRefRangeType[0].innerHTML) {
                        $row.hide();
                    }
                });
            }
            if (selectedRefRangeType[0].innerHTML == 'Sensitive Result Range') {
                $("#tblRange tbody tr").each(function(i, n) {
                    var $row = $(n);
                    $row.show();
                    if ($row.find("td:eq(0)").find('span').html() != selectedRefRangeType[0].innerHTML) {
                        $row.hide();
                    }
                });
            }

            if (selectedRefRangeType[0].innerHTML == 'Results Interpretation Range') {
                $("#tdAgeBulkData").show();
                $("#tdCommonBulkData").show();
                $("#tdOtherBulkData").show();
                $("#tdAgeResult").show();
                $("#tdCommonResult").show();
                $("#tdOtherResult").show();
                $("#tdAgeDevice").show();
                $("#tdCommonDevice").show();
                $("#tdOtherDevice").show();
                $("#tblRange tbody tr").each(function(i, n) {
                    var $row = $(n);
                    $row.show();
                    if ($row.find("td:eq(0)").find('span').html() != selectedRefRangeType[0].innerHTML) {
                        $row.hide();
                    }
                });
            }
        }
        catch (e) {
            return false;
        }
    }
    function onChangeRRCategory() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_20") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_20") : "Select range type";
        try {
            var selectedRRCategory = $('#' + ddlCategory + ' option:selected');
            var selectedRefRangeType = $('#' + ddlRefRangeType + ' option:selected');
            if ($(selectedRRCategory).val() != '0') {
                if ($(selectedRefRangeType).val() == '0') {
                    //alert("Select range type");
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    $('#' + ddlRefRangeType).focus();
                    // $('#' + ddlCategory + ' option:first').attr('selected', true);
                    return false;
                }
            }
        }
        catch (e) {
            return false;
        }
    }
    function onChangeRRSubCategory() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_20") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_20") : "Select range type";
        try {
            $('#divAgeReferenceRangeTable').hide();
            $('#divAgePanicRangeTable').hide();
            $('#divAgeAutoAuthorRangeTable').hide();
            $('#divAgeAutoExclusiveRangeTable').hide();
            $('#divAgeDomainRangeTable').hide();
            $('#divAgeSensitiveRangeTable').hide();
            $('#divCommonReferenceRangeTable').hide();
            $('#divCommonPanicRangeTable').hide();
            $('#divCommonAuthorRangeTable').hide();
            $('#divCommonExclusiveRangeTable').hide();
            $('#divCommonDomainRangeTable').hide();
            $('#divCommonSensitiveRangeTable').hide();
            $('#divOtherReferenceRangeTable').hide();
            $('#divOtherPanicRangeTable').hide();
            $('#divOtherAuthorRangeTable').hide();
            $('#divOtherExclusiveRangeTable').hide();
            $('#divOtherDomainRangeTable').hide();
            $('#divOtherSensitiveRangeTable').hide();
            var selectedRefRangeType = $('#' + ddlRefRangeType + ' option:selected');
            var selectedRRSubCategory = $('#' + ddlRRSubCategory + ' option:selected');
            $('#divAgeCategory').hide();
            $('#divGenderGeneralCategory').hide();
            $('#divGenderOtherCategory').hide();
            $('#trCategoryField').removeAttr('style');
            $('#' + divScrolling).css('height', '400px');
            onCancelAgeReferenceRange();
            onCancelCommonReferenceRange();
            onCancelOthersReferenceRange();
            if ($(selectedRRSubCategory).val() != '0') {
                if ($(selectedRefRangeType).val() == '0') {
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    //  alert("Select range type");
                    $('#' + ddlRefRangeType).focus();
                    $('#' + ddlRRSubCategory + ' option:first').attr('selected', true);
                    return false;
                }
                $('#trCategoryField').css('height', '100px');
                $('#' + divScrolling).css('height', '300px');
                if ($(selectedRRSubCategory).val() == 'Age') {
                    $('#divAgeBetween').hide();
                    $('#' + txtAgeRange2).val('');
                    $('#' + ddlAgeType + ' option:first').attr('selected', true);
                    $('#' + ddlOperatorRange1 + ' option:first').attr('selected', true);
                    $('#' + ddlOperatorRange2 + ' option:first').attr('selected', true);
                    $('#divAgeCategory').show();
                    if ($(selectedRefRangeType).val() == 'referencerange') {
                        $('#divAgeReferenceRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'panicrange') {
                        $('#divAgePanicRangeTable').show();
                        //                    document.getElementById('tblNormalValue').style.display = 'none';
                    }
                    else if ($(selectedRefRangeType).val() == 'autoauthorizationrange') {
                        $('#divAgeAutoAuthorRangeTable').show();
                        //                    document.getElementById('tblNormalValue').style.display = 'none';
                    }
                    else if ($(selectedRefRangeType).val() == 'autoexclusiverange') {
                        $('#divAgeAutoExclusiveRangeTable').show();
                        //                    document.getElementById('tblNormalValue').style.display = 'none';
                    }
                    else if ($(selectedRefRangeType).val() == 'domainrange') {
                        $('#divAgeDomainRangeTable').show();
                        //                    document.getElementById('tblNormalValue').style.display = 'none';
                    }
                    else if ($(selectedRefRangeType).val() == 'sensitiveresultrange') {
                        $('#divAgeSensitiveRangeTable').show();
                        //                    document.getElementById('tblNormalValue').style.display = 'none';
                    }
                }
                else if ($(selectedRRSubCategory).val() == 'Common') {
                    $('#divValueBetween').hide();
                    $('#' + txtValueRange2).val('');
                    $('#' + ddlGenderValueOpt + ' option:first').attr('selected', true);
                    $('#divGenderGeneralCategory').show();
                    if ($(selectedRefRangeType).val() == 'referencerange') {
                        $('#divCommonReferenceRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'panicrange') {
                        $('#divCommonPanicRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'autoauthorizationrange') {
                        $('#divCommonAuthorRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'autoexclusiverange') {
                        $('#divCommonExclusiveRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'domainrange') {
                        $('#divCommonDomainRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'sensitiveresultrange') {
                        $('#divCommonSensitiveRangeTable').show();
                    }
                }
                else if ($(selectedRRSubCategory).val() == 'Other') {
                    $('#divGenderValueBetween').hide();
                    $('#' + txtGenderValueEnd).val('');
                    $('#' + ddlOtherRangeOpt + ' option:first').attr('selected', true);
                    $('#divGenderOtherCategory').show();
                    if ($(selectedRefRangeType).val() == 'referencerange') {
                        $('#divOtherReferenceRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'panicrange') {
                        $('#divOtherPanicRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'autoauthorizationrange') {
                        $('#divOtherAuthorRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'autoexclusiverange') {
                        $('#divOtherExclusiveRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'domainrange') {
                        $('#divOtherDomainRangeTable').show();
                    }
                    else if ($(selectedRefRangeType).val() == 'sensitiveresultrange') {
                        $('#divOtherSensitiveRangeTable').show();
                    }
                }
            }
        }
        catch (e) {
            return false;
        }
    }
    function ShowOtherAgeBetween() {
        try {
            var selectedOtherAgeOperator = $('#' + ddlOtherAgeOperator + ' option:selected');
            $('#divOtherAgeBetween').hide();
            $('#' + txtOtherAgeRange2).val('');
            if ($(selectedOtherAgeOperator).val() == 'Between') {
                $('#divOtherAgeBetween').show();
            }
        }
        catch (e) {
            return false;
        }
    }
    function ShowAgeBetween() {
        try {
            var selectedOperatorRange1 = $('#' + ddlOperatorRange1 + ' option:selected');
            $('#divAgeBetween').hide();
            $('#' + txtAgeRange2).val('');
            if ($(selectedOperatorRange1).val() == 'Between') {
                $('#divAgeBetween').show();
            }
        }
        catch (e) {
            return false;
        }
    }
    function ShowValueBetween() {
        try {
            var selectedOperatorRange2 = $('#' + ddlOperatorRange2 + ' option:selected');
            $('#divValueBetween').hide();
            $('#divAgeSource').hide();
            $('#divAgeValue').show();
            $('#' + txtValueRange2).val('');
            $('#' + txtAgeSource).val('');
            if ($(selectedOperatorRange2).val() == 'Between') {
                $('#divValueBetween').show();
            }
            if ($(selectedOperatorRange2).val() == 'Source') {
                $('#divAgeSource').show();
                $('#divAgeValue').hide();
            }
        }
        catch (e) {
            return false;
        }
    }
    function ShowGenderValueBetween() {
        try {
            var selectedGenderValueOpt = $('#' + ddlGenderValueOpt + ' option:selected');
            $('#divGenderValueBetween').hide();
            $('#divCommonValue').show();
            $('#divCommonSource').hide();
            $('#' + txtGenderValueEnd).val('');
            $('#' + txtCommonSource).val('');
            if ($(selectedGenderValueOpt).val() == 'Between') {
                $('#divGenderValueBetween').show();
            }
            if ($(selectedGenderValueOpt).val() == 'Source') {
                $('#divCommonSource').show();
                $('#divCommonValue').hide();
            }
        }
        catch (e) {
            return false;
        }
    }
    function ShowOtherValueBetween() {
        try {
            var selectedOtherRangeOpt = $('#' + ddlOtherRangeOpt + ' option:selected');
            $('#divOtherValueBetween').hide();
            $('#' + txtOtherRange2).val('');
            if ($(selectedOtherRangeOpt).val() == 'Between') {
                $('#divOtherValueBetween').show();
            }
        }
        catch (e) {
            return false;
        }
    }
    function AddAgeReferenceRange() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_001") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_001") : "Select range type\n";
        var UsrAlrtMsg1 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_002") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_002") : "Select gender\n";
        var UsrAlrtMsg2 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_003") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_003") : "Select age type\n";
        var UsrAlrtMsg3 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_004") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_004") : "Select value operator\n";
        var UsrAlrtMsg4 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_005") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_005") : "Value end range cannot be blank\n";
        var UsrAlrtMsg5 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_006") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_006") : "Select age operator\n";
        var UsrAlrtMsg6 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_007") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_007") : "Age end range cannot be blank\n";
        var UsrAlrtMsg7 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_008") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_008") : "Age range cannot be blank\n";
        var UsrAlrtMsg8 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_009") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_009") : "Value range cannot be blank\n";
        var UsrAlrtMsg9 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_010") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_010") : "Select interpretation text\n";
        var UsrAlrtMsg10 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_018") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_018") : "Select show result from\n";
        var UsrAlrtMsg11 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_21") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_21") : "Range already Exist";


        try {
            var selectedRefRangeType = $('#' + ddlRefRangeType + ' option:selected');
            var message = '';
            var isRequiredMissing = false;
            var selectedGender = $('#' + ddlCategory + ' option:selected');
            var selectedRRSubCategory = $('#' + ddlRRSubCategory + ' option:selected');
            var selectedAgeType = $('#' + ddlAgeType + ' option:selected');
            var selectedValueOperator = $('#' + ddlOperatorRange2 + ' option:selected');
            var selectedAgeRangeOperator = $('#' + ddlOperatorRange1 + ' option:selected');
            var age = 0;
            var value = 0;

            if ($(selectedRefRangeType).val() == '0') {
                message += UsrAlrtMsg;
                //message += "Select range type\n";
                isRequiredMissing = true;
            }
            if ($(selectedGender).val() == '0') {
                //message += "Select gender\n";
                message += UsrAlrtMsg1;
                isRequiredMissing = true;
            }
            if ($(selectedAgeType).val() == '0') {
                // message += "Select age type\n";
                message += UsrAlrtMsg2;
                isRequiredMissing = true;
            }
            if ($(selectedValueOperator).val() == '0') {
                //message += "Select value operator\n";
                message += UsrAlrtMsg3;
                isRequiredMissing = true;
            }
            else if (($(selectedValueOperator).val() == 'Between') && $.trim($('#' + txtValueRange2).val()) == '') {
                //message += "Value end range cannot be blank\n";
                message += UsrAlrtMsg4;
                isRequiredMissing = true;
            }
            if ($(selectedAgeRangeOperator).val() == '0') {
                //message += "Select age operator\n";
                message += UsrAlrtMsg5;
                isRequiredMissing = true;
            }
            else if (($(selectedAgeRangeOperator).val() == 'Between') && ($.trim($('#' + txtAgeRange2).val()) == '')) {
                //message += "Age end range cannot be blank\n";
                message += UsrAlrtMsg6;
                isRequiredMissing = true;
            }
            if ($.trim($('#' + txtAgeRange2).val()) != '') {
                if ($.trim($('#' + txtAgeRange1).val()) == '') {
                    //message += "Age range cannot be blank\n";
                    message += UsrAlrtMsg7;
                    isRequiredMissing = true;
                }
                else {
                    age = $.trim($('#' + txtAgeRange1).val()) + "-" + $.trim($('#' + txtAgeRange2).val());
                }
            }
            else {
                if ($.trim($('#' + txtAgeRange1).val()) == '') {
                    //message += "Age range cannot be blank\n";
                    message += UsrAlrtMsg7;
                    isRequiredMissing = true;
                }
                else {
                    age = $.trim($('#' + txtAgeRange1).val());
                }
            }
            if ($.trim($('#' + txtValueRange2).val()) != '') {
                if ($.trim($('#' + txtValueRange1).val()) == '') {
                    //message += "Value range cannot be blank\n";
                    message += UsrAlrtMsg8;
                    isRequiredMissing = true;
                }
                else {
                    value = $.trim($('#' + txtValueRange1).val()) + "-" + $.trim($('#' + txtValueRange2).val());
                }
            }
            else {
                if ($.trim($('#' + txtValueRange1).val()) == '' && $.trim($('#' + txtAgeSource).val()) == '') {
                    //message += "Value range cannot be blank\n";
                    message += UsrAlrtMsg8;
                    isRequiredMissing = true;
                }
                else {
                    if ($(selectedValueOperator).val() == 'Source') {
                        value = $.trim($('#' + txtAgeSource).val());
                    }
                    else {
                        value = $.trim($('#' + txtValueRange1).val());
                    }
                }
            }
            var data = '';
            var result = '';
            var device = '';
            var devicetext = '';
            if ($(selectedRefRangeType).val() == 'resultsinterpretationrange') {
                var selectedAgeBulkData = $('#' + ddlAgeBulkData + ' option:selected');
                var selectedAgeResult = $('#' + ddlAgeResult + ' option:selected');
                var selectedAgeDevice = $('#' + ddlAgeDevice + ' option:selected');
                if ($(selectedAgeBulkData).val() == '0') {
                    // message += "Select interpretation text\n";
                    message += UsrAlrtMsg9;
                    isRequiredMissing = true;
                }
                else {
                    data = $(selectedAgeBulkData).val();
                }
                if ($(selectedAgeResult).val() == '0') {
                    //message += "Select show result from\n";
                    message += UsrAlrtMsg10;
                    isRequiredMissing = true;
                }
                else {
                    result = $(selectedAgeResult).val();
                }
                if ($(selectedAgeDevice).val() != '0') {
                    device = $(selectedAgeDevice).val();
                    devicetext = $(selectedAgeDevice).text();
                }
            }
            if (!isRequiredMissing) {
                var AgeRange = $(selectedGender).val() + "~" + $(selectedAgeRangeOperator).val() + "~" + age + "~" + $(selectedAgeType).val() + "~" + $(selectedValueOperator).val() + "~" + value + "~" + data + "~" + result + "~" + device + "^";
                $('#' + divScrolling).show();
                var row$;
                if ($('#' + hdnSelectedAgeRowIndex).val() == '') {
                    row$ = $('<tr/>');
                    var tdRangetype = $('<td/>').html('<span>' + $(selectedRefRangeType).text() + '</span>');
                    var tdGender = $('<td/>').html('<span>' + $(selectedGender).text() + '</span>');
                    var tdSubcategory = $('<td/>').html('<span>' + $(selectedRRSubCategory).text() + '</span>');
                    //                    var hdnRefRangeValue = $('<td/>').html('<span style="display:none;">' + $(selectedRefRangeType).val() + '</span>');
                    //                    var hdnGenderValue = $('<td/>').html('<span style="display:none;">' + $(selectedGender).val() + '</span>');
                    //                    var hdnSubcategoryValue = $('<td/>').html('<span style="display:none;">' + $(selectedRRSubCategory).val() + '</span>');
                    if ($(selectedAgeRangeOperator).val() == 'Between') {
                        var tdAgeOperator = $('<td/>').html('<span>' + age + '</span>');
                    }
                    else {
                        var tdAgeOperator = $('<td/>').html('<span>' + $(selectedAgeRangeOperator).text() + ' ' + age + '</span>');
                    }
                    var tdAgeType = $('<td/>').html('<span>' + $(selectedAgeType).text() + '</span>');
                    var tdReferenceName = $('<td/>').html('<span>' + '-' + '</span>');
                    if ($(selectedValueOperator).val() == 'Between' || $(selectedValueOperator).val() == 'Source') {
                        var tdValueOperator = $('<td/>').html('<span>' + value + '</span>');
                    }
                    else {
                        var tdValueOperator = $('<td/>').html('<span>' + $(selectedValueOperator).text() + ' ' + value + '</span>');
                    }
                    //  var tdValueRange = $('<td/>').html('<span>' + value + '</span>');
                    var tdIsNormal = $('<td/>').html('<span>' + '-' + '</span>');
                    var tdIsSourceText = '';
                    if ($(selectedValueOperator).val() == 'Source') {
                        tdIsSourceText = $('<td/>').html('<span>Y</span>');
                    }
                    else {
                        tdIsSourceText = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    var tdBulkData = '';
                    if (data == '') {
                        tdBulkData = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdBulkData = $('<td/>').html('<span>' + data + '</span>');
                    }
                    var tdResult = '';
                    if (result == '') {
                        tdResult = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdResult = $('<td/>').html('<span>' + result + '</span>');
                    }
                    var tdDevice = '';
                    if (device == '') {
                        tdDevice = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdDevice = $('<td/>').html('<span>' + devicetext + '</span>');
                    }
                    $("#tblRange tbody tr").each(function(i, n) {
                        var $row = $(n);
                        if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                            if ($row.find("input[id$='hdnAgeRange']").val() == AgeRange) {
                                //alert('Range already Exist');
                                ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
                                return false;
                            }

                        }

                    });
                    var hdnAgeRange = '<input id="hdnAgeRange" type="hidden" value="' + AgeRange + '"/>';
                    var tdDelete = $('<td align="center"/>').html(hdnAgeRange + '<input id="btnEditAgeReferenceRange" value="' + lbledit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditAgeReferenceRange(this);" />' + '<input id="btnDeleteAgeReferenceRange" value="' + lbldeletes + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteAgeReferenceRange(this);" />');

                    row$.append(tdRangetype).append(tdGender).append(tdSubcategory).append(tdAgeOperator).append(tdAgeType).append(tdReferenceName).append(tdValueOperator).append(tdIsNormal).append(tdIsSourceText).append(tdBulkData).append(tdResult).append(tdDevice).append(tdDelete);
                    var RefRange = '<input id="hdnRefRangeID"  value="' + $(selectedRefRangeType).val() + '"/>';
                    var GenderVal = '<input id="hdnGenderValue"  value="' + $(selectedGender).val() + '"/>';
                    var SubCategory = '<input id="hdnSubcategoryValue" value="' + $(selectedRRSubCategory).val() + '"/>';
                    row$.append($('<td style="display:none"/>').html('<input id="hdnRefRangeID"  value="' + $(selectedRefRangeType).val() + '"/>' + '<input id="hdnGenderValue"  value="' + $(selectedGender).val() + '"/>' + '<input id="hdnSubcategoryValue" value="' + $(selectedRRSubCategory).val() + '"/>'));
                    $('#tblRange tbody').append(row$);
                    $('#divReferenceRangeTable').show();

                }
                else {
                    var selectedRowIndex = $('#' + hdnSelectedAgeRowIndex).val();

                    row$ = $('#tblRange tbody tr:eq(' + selectedRowIndex + ')');
                    $('#divReferenceRangeTable').show();

                    row$.find("td:eq(1)").html('<span>' + $(selectedGender).text() + '</span>');
                    //  row$.find("td:eq(2)").html('<span>'  '</span>');
                    if ($(selectedAgeRangeOperator).val() == 'Between') {
                        row$.find("td:eq(3)").html('<span>' + age + '</span>');
                    }
                    else {
                        row$.find("td:eq(3)").html('<span>' + $(selectedAgeRangeOperator).text() + ' ' + age + '</span>');
                    }
                    row$.find("td:eq(4)").html('<span>' + $(selectedAgeType).text() + '</span>');
                    //row$.find("td:eq(5)").html('<span>' + $(selectedValueOperator).text() + '</span>');
                    if ($(selectedValueOperator).val() == 'Between' || $(selectedValueOperator).val() == 'Source') {
                        row$.find("td:eq(6)").html('<span>' + value + '</span>');
                    }
                    else {
                        row$.find("td:eq(6)").html('<span>' + $(selectedValueOperator).text() + ' ' + value + '</span>');
                    }
                    if (data == '') {
                        row$.find("td:eq(9)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(9)").html('<span>' + data + '</span>');
                    }
                    if (result == '') {
                        row$.find("td:eq(10)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(10)").html('<span>' + result + '</span>');
                    }
                    if (device == '') {
                        row$.find("td:eq(11)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(11)").html('<span>' + devicetext + '</span>');
                    }
                    $("#tblRange tbody tr").each(function(i, n) {
                        var $row = $(n);
                        if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                            if ($row.find("input[id$='hdnAgeRange']").val() == AgeRange) {
                                //alert('Range already Exist');
                                ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
                                return false;
                            }

                        }

                    });
                    row$.find("input[id$='hdnAgeRange']").val(AgeRange);
                }
                onCancelAgeReferenceRange();
                //$('#' + ddlCategory + ' option:first').attr('selected', true);
            }
            else {
                ValidationWindow(message, AlrtWinHdr);
                // alert(message);
            }
            $("#TabContainer1_TabTestMaster_TM_ddlOperatorRange1").val($("#TabContainer1_TabTestMaster_TM_ddlOperatorRange1 option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOperatorRange2").val($("#TabContainer1_TabTestMaster_TM_ddlOperatorRange2 option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlAgeType").val($("#TabContainer1_TabTestMaster_TM_ddlAgeType option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlRRSubCategory").val($("#TabContainer1_TabTestMaster_TM_ddlRRSubCategory option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlCategory").val($("#TabContainer1_TabTestMaster_TM_ddlCategory option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlRefRangeType").val($("#TabContainer1_TabTestMaster_TM_ddlRefRangeType option:first").val());
            $('#divAgeCategory').hide();
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onEditCoAuth(obj) {
        try {
            var Usrupdate = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") : "Update";
            var $row = $(obj).closest('tr');
            var rowIndex = $row.index();
            var hdntrRowindex = '<%=hdntrRowindex.ClientID %>';
            var btnAdd = '<%=btnAdd.ClientID %>';
            $("#" + btnAdd).val(Usrupdate);
            $("#" + hdntrRowindex).val(rowIndex);
            var hdnSelInvCoAuthID = $row.find("input[id$='hdnInvCoAuthID']").val();
            var selectedRole = $('#' + ddlRole + ' option:selected');
            var selectedDept = $('#' + ddlDept1 + ' option:selected');
            var selectedDoctor = $('#' + ddlDoctor + ' option:selected');
            var chkReauthPrimaryid = '<%=chkReauthPrimary.ClientID %>';
            var hdnRole = $row.find("input[id$='hdnRole']").val();
            document.getElementById(ddlRole).value = hdnRole;
            var hdnDept1 = $row.find("input[id$='hdnDept1']").val();
            var hdnDoctor = $row.find("input[id$='hdnDoctor']").val();
            var hdnReauthPrimary = $row.find("input[id$='hdnReauthPrimary']").val();
            onChangeddlRole(hdnDept1);
            //  document.getElementById(ddlDept1).value = ;
            //  $(selectedDept).val(hdnDept1)
            onChangeddlDept1(hdnDoctor);
            //   document.getElementById(ddlDoctor).value = hdnDoctor;

            if ($row.find("input[id$='hdnReauthPrimary']").val() == "Y") {
                $('#' + chkReauthPrimaryid).attr('checked', true);
            }
            else {
                $('#' + chkReauthPrimaryid).attr('checked', false);
            }

            return false;
        }
        catch (e) {
            return false;
        }
    }

    //---- Murali ----//
    function AddAuthorization() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_22") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_22") : "Only one primary record is possible";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_23") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_23") : "Select RoleName First";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_24") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_24") : "Select Doctor";
        var Usrupdate = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") : "Update";


        try {
            var btnAdd = '<%=btnAdd.ClientID %>';
            if ($("#" + btnAdd).val() == Usrupdate) {
                var row$;
                var rowindex = $("#<%=hdntrRowindex.ClientID %>").val();
                row$ = $('#tbltbodyCoAuth  > tr:eq(' + rowindex + ')');
                var selectedRole = $('#' + ddlRole + ' option:selected');
                var selectedDept = $('#' + ddlDept1 + ' option:selected');
                var selectedDoctor = $('#' + ddlDoctor + ' option:selected');
                var chkReauthPrimaryid = '<%=chkReauthPrimary.ClientID %>';
                var chkReauthPrimary = $('#' + chkReauthPrimaryid).is(':checked') ? 'Yes' : 'No';
                var chkReauthPrimary1 = $('#' + chkReauthPrimaryid).is(':checked') ? 'Y' : 'N';

                var hdnSelInvCoAuthID = row$.find("input[id$='hdnInvCoAuthID']").val();

                var flag = true;
                if (chkReauthPrimary1 == "Y") {
                    $("#tbltbodyCoAuth tr").each(function(i, n) {
                        var $row = $(n);
                        //   var sdsd = $row.find("input[id$='hdnReauthPrimary']").val();
                        if ($row.find("input[id$='hdnReauthPrimary']").val() == chkReauthPrimary1 && $row.index() != rowindex) {
                            //alert("Only one primary record is possible");
                            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                            flag = false;
                            return false;
                        }
                    });
                }
                if (flag) {
                    var hdnPrimary = $('#' + chkReauthPrimaryid).is(':checked') ? 'Y' : 'N';
                    var hdnInvCoAuthID = '<input id="hdnInvCoAuthID" type="hidden" value="' + hdnSelInvCoAuthID + '"/>';
                    var hdnRole = '<input id="hdnRole" type="hidden" value="' + $(selectedRole).val() + '"/>';
                    var hdnDept1 = '<input id="hdnDept1" type="hidden" value="' + $(selectedDept).val() + '"/>';
                    var hdnDoctor = '<input id="hdnDoctor" type="hidden" value="' + $(selectedDoctor).val() + '"/>';
                    var hdnReauthPrimary = '<input id="hdnReauthPrimary" type="hidden" value="' + hdnPrimary + '"/>';
                    var Role = $(selectedRole).val() == '0' ? '' : $(selectedRole).text();
                    var dept = $(selectedDept).val() == '0' ? '' : $(selectedDept).text();
                    var Doctor = $(selectedDoctor).val() == '0' ? '' : $(selectedDoctor).text();



                    row$.find("td:eq(0)").html(hdnInvCoAuthID + hdnRole + "<span id='lblRoleName'>" + Role + "</span>");
                    row$.find("td:eq(1)").html(hdnDept1 + "<span id='lblDeptName'>" + dept + "</span>");
                    row$.find("td:eq(2)").html(hdnDoctor + "<span id='lblDoctorName'>" + Doctor + "</span>");
                    row$.find("td:eq(3)").html(hdnReauthPrimary + "<span id='lblReauthPrimary'>" + chkReauthPrimary + "</span>");


                    $('#' + chkReauthPrimaryid).attr('checked', false);
                    $("#" + btnAdd).val('Add');
                    onCancelCoAuth();
                }



            }
            else {
                var message = '';
                var isRequiredMissing = false;
                var selectedRole = $('#' + ddlRole + ' option:selected');
                var selectedDept = $('#' + ddlDept1 + ' option:selected');
                var selectedDoctor = $('#' + ddlDoctor + ' option:selected');

                var chkReauthPrimaryid = '<%=chkReauthPrimary.ClientID %>';
                var chkReauthPrimary = $('#' + chkReauthPrimaryid).is(':checked') ? 'Y' : 'N';
                if ($(selectedRole).val() == '0') {
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    //alert("Select RoleName First");
                    return false;
                }
                else if ($(selectedDoctor).val() == '0') {
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    //alert("Select Doctor");
                    return false;
                }

                else {
                    var flag = true;
                    if (chkReauthPrimary == "Y") {
                        $("#tblCoAuth tbody tr").each(function(i, n) {
                            var $row = $(n);
                            //   var sdsd = $row.find("input[id$='hdnReauthPrimary']").val();
                            if ($row.find("input[id$='hdnReauthPrimary']").val() == chkReauthPrimary) {
                                // alert("Only one primary record is possible");
                                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                                flag = false;
                                return false;
                            }
                        });
                    }
                    if (flag) {
                        var vUseyes = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065") == null ? "Yes" : SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065");
                        var vUseno = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066") == null ? "No" : SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066");
                        var row$;
                        var roleName = $(selectedRole).val() == '0' ? '' : $(selectedRole).text();
                        var deptName = $(selectedDept).val() == '0' ? '' : $(selectedDept).text();
                        var doctorName = $(selectedDoctor).val() == '0' ? '' : $(selectedDoctor).text();

                        var hdnInvCoAuthID = '<input id="hdnInvCoAuthID" type="hidden" value="0"/>';
                        var hdnRole = '<input id="hdnRole" type="hidden" value="' + $(selectedRole).val() + '"/>';
                        var hdnDept1 = '<input id="hdnDept1" type="hidden" value="' + $(selectedDept).val() + '"/>';
                        var hdnDoctor = '<input id="hdnDoctor" type="hidden" value="' + $(selectedDoctor).val() + '"/>';
                        var hdnReauthPrimary1 = '<input id="hdnReauthPrimary" type="hidden" value="' + chkReauthPrimary + '"/>';
                        var chkResultAuthor = $('#' + chkReauthPrimaryid).is(':checked') ? vUseyes : vUseno;
                        row$ = $('<tr/>');
                        var tdRole = $('<td/>').html(hdnInvCoAuthID + hdnRole + "<span id='lblRoleName'>" + roleName + "</span>");
                        var tdDept = $('<td/>').html(hdnDept1 + "<span id='lblDeptName'>" + deptName + "</span>");
                        var tdDoctor = $('<td/>').html(hdnDoctor + "<span id='lblDoctorName'>" + doctorName + "</span>");
                        var tdReauthPrimary = $('<td/>').html(hdnReauthPrimary1 + "<span id='lblReauthPrimary'>" + chkResultAuthor + "</span>");
                        var btnEditCoAuth = '<input id="btnEditCoAuth" value="Edit" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 10px;" onclick="onEditCoAuth(this);"/>';
                        var btnDeleteCoAuth = '<input id="btnDeleteCoAuth" value="' + lbldeletes + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 10px;" onclick="onDeleteCoAuth(this);" />';
                        var tdAction = $('<td align="center" style="width: 20%"/>').html(btnEditCoAuth + btnDeleteCoAuth);
                        row$.append(tdRole).append(tdDept).append(tdDoctor).append(tdReauthPrimary).append(tdAction);

                        $('#tblCoAuth tbody').append(row$);
                        $('#' + chkReauthPrimaryid).attr('checked', false);
                        onCancelCoAuth();
                    }
                }
            }


            return false;
        }
        catch (e) {
            return false;
        }
    }



    function onDeleteCoAuth(obj) {

        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") : "Unable to delete";
        try {
            var btnAdd = '<%=btnAdd.ClientID %>';
            $("#" + btnAdd).val('Add');
            var $row = $(obj).closest('tr');
            var hdnSelInvCoAuthID = $row.find("input[id$='hdnInvCoAuthID']").val();
            if (hdnSelInvCoAuthID == '' || hdnSelInvCoAuthID == '0') {
                hdnSelInvCoAuthID = -1;
            }
            if (hdnSelInvCoAuthID == -1) {
                $(obj).closest('tr').remove();
            }
            else {
                var invID = $('#' + hdnInvID).val();
                var orgID = $('#' + hdnOrgID).val();
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/DeleteInvCoAuth",
                    data: "{ID: " + hdnSelInvCoAuthID + ",InvID: " + invID + ",OrgID: " + orgID + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        $(obj).closest('tr').remove();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        //alert("Unable to delete");
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    }
                });
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }


    //-- Commented by Murali--- //
    //    
    //    function onDeleteCoAuth(obj) {
    //        
    //        try {
    //            $(obj).closest('tr').remove();
    //        }
    //        catch (e) {
    //            return false;
    //        }
    //        return false;
    //    }
    function onCancelCoAuth() {
        try {
            $('#' + ddlRole + ' option:first').attr('selected', true);
            $('#' + ddlDept1 + ' option:first').attr('selected', true);
            $('#' + ddlDoctor + ' option:first').attr('selected', true);
        }
        catch (e) {
            return false;
        }
        return false;
    }

    //----------End of Murali---//

    function AddCommonReferenceRange() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_001") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_001") : "Select range type\n";
        var UsrAlrtMsg1 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_002") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_002") : "Select gender\n";
        var UsrAlrtMsg4 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_005") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_005") : "Value end range cannot be blank\n";        
        var UsrAlrtMsg8 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_009") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_009") : "Value range cannot be blank\n";
        var UsrAlrtMsg4 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_019") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_019") : "Select category\n";
        var UsrAlrtMsg5 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_020") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_020") : "Select value operator\n";
        var UsrAlrtMsg6 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_021") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_021") : "Value cannot be blank\n";
        var UsrAlrtMsg9 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_010") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_010") : "Select interpretation text\n";
        var UsrAlrtMsg10 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_018") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_018") : "Select show result from\n";
        var UsrAlrtMsg9 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_21") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_21") : "Range already Exist";

        try {
            var selectedRefRangeType = $('#' + ddlRefRangeType + ' option:selected');
            var message = '';
            var isRequiredMissing = false;
            var selectedGender = $('#' + ddlCategory + ' option:selected');
            var selectedRRSubCategory = $('#' + ddlRRSubCategory + ' option:selected');
            var selectedValueOperator = $('#' + ddlGenderValueOpt + ' option:selected');
            var value = 0;

            if ($(selectedRefRangeType).val() == '0') {
                // message += "Select range type\n";
                message += UsrAlrtMsg;
                isRequiredMissing = true;
            }
            if ($(selectedGender).val() == '0') {
                //message += "Select gender\n";
                message += UsrAlrtMsg1;
                isRequiredMissing = true;
            }
            if ($(selectedRRSubCategory).val() == '0') {
                //message += "Select category\n";
                message += UsrAlrtMsg4;
                isRequiredMissing = true;
            }
            if ($(selectedValueOperator).val() == '0') {
                //message += "Select value operator\n";
                message += UsrAlrtMsg5;
                isRequiredMissing = true;
            }
            else if (($(selectedValueOperator).val() == 'Between') && $.trim($('#' + txtGenderValueEnd).val()) == '') {
                //message += "Value end range cannot be blank\n";
                message += UsrAlrtMsg2;
                isRequiredMissing = true;
            }
            if ($.trim($('#' + txtGenderValueEnd).val()) != '') {
                if ($.trim($('#' + txtGenderValueStart).val()) == '') {
                    //message += "Value range cannot be blank\n";
                    message += UsrAlrtMsg3;
                    isRequiredMissing = true;
                }
                else {
                    value = $.trim($('#' + txtGenderValueStart).val()) + "-" + $.trim($('#' + txtGenderValueEnd).val());
                }
            }
            else {
                if ($.trim($('#' + txtGenderValueStart).val()) == '' && $.trim($('#' + txtCommonSource).val()) == '') {
                    //message += "Value cannot be blank\n";
                    message += UsrAlrtMsg6;
                    isRequiredMissing = true;
                }
                else {
                    if ($(selectedValueOperator).val() == 'Source') {
                        value = $.trim($('#' + txtCommonSource).val());
                    }
                    else {
                        value = $.trim($('#' + txtGenderValueStart).val());
                    }
                }
            }
            var data = '';
            var result = '';
            var device = '';
            var devicetext = '';
            if ($(selectedRefRangeType).val() == 'resultsinterpretationrange') {
                var selectedCommonBulkData = $('#' + ddlCommonBulkData + ' option:selected');
                var selectedCommonResult = $('#' + ddlCommonResult + ' option:selected');
                var selectedCommonDevice = $('#' + ddlCommonDevice + ' option:selected');
                if ($(selectedCommonBulkData).val() == '0') {
                    // message += "Select interpretation text\n";
                    message += UsrAlrtMsg7;
                    isRequiredMissing = true;
                }
                else {
                    data = $(selectedCommonBulkData).val();
                }
                if ($(selectedCommonResult).val() == '0') {
                    //message += "Select show result from\n";
                    message += UsrAlrtMsg8;
                    isRequiredMissing = true;
                }
                else {
                    result = $(selectedCommonResult).val();
                }
                if ($(selectedCommonDevice).val() != '0') {
                    device = $(selectedCommonDevice).val();
                    devicetext = $(selectedCommonDevice).text();
                }
            }
            if (!isRequiredMissing) {
                var GenderRange = $(selectedGender).val() + "~" + $(selectedValueOperator).val() + "~" + value + "~" + data + "~" + result + "~" + device + "^";
                $('#' + divScrolling).show();
                var row$;
                if ($('#' + hdnSelectedCommonRowIndex).val() == '') {
                    row$ = $('<tr/>');
                    var tdRangetype = $('<td/>').html('<span>' + $(selectedRefRangeType).text() + '</span>');
                    //var hdnRefRangeValue = '<input id="hdnRefRangeID" type="hidden" value=' + $(selectedRefRangeType).val() + '/>';
                    var tdGender = $('<td/>').html('<span>' + $(selectedGender).text() + '</span>');
                    //var hdnGenderValue = '<input id="hdnGenderVal" type="hidden" value=' + $(selectedGender).val() + '/>';
                    var tdSubcategory = $('<td/>').html('<span>' + $(selectedRRSubCategory).text() + '</span>');
                    //var hdnSubcategoryValue = '<input id="hdnSubcategoryValue" type="hidden" value=' + $(selectedRRSubCategory).val() + '/>';
                    var tdAgeRange = $('<td/>').html('<span>' + '-' + '</span>');
                    var tdAgeUnits = $('<td/>').html('<span>' + '-' + '</span>');
                    var tdReferenceName = $('<td/>').html('<span>' + '-' + '</span>');
                    var tdIsnormal = $('<td/>').html('<span>' + '-' + '</span>');
                    if ($(selectedValueOperator).val() == 'Between' || $(selectedValueOperator).val() == 'Source') {
                        var tdValueRange = $('<td/>').html('<span>' + value + '</span>');
                    }
                    else {
                        var tdValueRange = $('<td/>').html('<span>' + $(selectedValueOperator).text() + ' ' + value + '</span>');
                    }
                    var tdIsSourceText = '';
                    if ($(selectedValueOperator).val() == 'Source') {
                        tdIsSourceText = $('<td/>').html('<span>Y</span>');
                    }
                    else {
                        tdIsSourceText = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    var tdBulkData = '';
                    if (data == '') {
                        tdBulkData = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdBulkData = $('<td/>').html('<span>' + data + '</span>');
                    }
                    var tdResult = '';
                    if (result == '') {
                        tdResult = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdResult = $('<td/>').html('<span>' + result + '</span>');
                    }
                    var tdDevice = '';
                    if (device == '') {
                        tdDevice = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdDevice = $('<td/>').html('<span>' + devicetext + '</span>');
                    }
                    $("#tblRange tbody tr").each(function(i, n) {
                        var $row = $(n);
                        if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                            if ($row.find("input[id$='hdnGenderRange']").val() == GenderRange) {
                                //alert('Range already Exist');
                                ValidationWindow(UsrAlrtMsg9, AlrtWinHdr);
                                return false;
                            }
                        }

                    });

                    var hdnGenderRange = '<input id="hdnGenderRange" type="hidden" value="' + GenderRange + '"/>';

                    var tdDelete = $('<td align="center"/>').html(hdnGenderRange + '<input id="btnEditCommonReferenceRange" value="' + lbledit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditCommonReferenceRange(this);" />' + '<input id="btnDeleteCommonReferenceRange" value="' + lbldeletes + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteCommonReferenceRange(this);" />');

                    row$.append(tdRangetype).append(tdGender).append(tdSubcategory).append(tdAgeRange).append(tdAgeUnits).append(tdReferenceName).append(tdValueRange).append(tdIsnormal).append(tdIsSourceText).append(tdBulkData).append(tdResult).append(tdDevice).append(tdDelete);
                    var RefRange = '<input id="hdnRefRangeID"  value="' + $(selectedRefRangeType).val() + '"/>';
                    var GenderVal = '<input id="hdnGenderValue"  value="' + $(selectedGender).val() + '"/>';
                    var SubCategory = '<input id="hdnSubcategoryValue" value="' + $(selectedRRSubCategory).val() + '"/>';
                    row$.append($('<td style="display:none"/>').html('<input id="hdnRefRangeID"  value="' + $(selectedRefRangeType).val() + '"/>' + '<input id="hdnGenderValue"  value="' + $(selectedGender).val() + '"/>' + '<input id="hdnSubcategoryValue" value="' + $(selectedRRSubCategory).val() + '"/>'));
                    $('#tblRange tbody').append(row$);
                    $('#divReferenceRangeTable').show();

                }
                else {
                    var selectedRowIndex = $('#' + hdnSelectedCommonRowIndex).val();

                    row$ = $('#tblRange tbody tr:eq(' + selectedRowIndex + ')');
                    $('#divReferenceRangeTable').show();

                    row$.find("td:eq(1)").html('<span>' + $(selectedGender).text() + '</span>');
                    if ($(selectedValueOperator).val() == 'Between' || $(selectedValueOperator).val() == 'Source') {
                        row$.find("td:eq(6)").html('<span>' + value + '</span>');
                    } else {
                        row$.find("td:eq(6)").html('<span>' + $(selectedValueOperator).text() + ' ' + value + '</span>');
                    }
                    if ($(selectedValueOperator).val() == 'Source') {
                        row$.find("td:eq(8)").html('<span>Y</span>');
                    }
                    else {
                        row$.find("td:eq(8)").html('<span>-</span>');
                    }
                    if (data == '') {
                        row$.find("td:eq(9)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(9)").html('<span>' + data + '</span>');
                    }
                    if (result == '') {
                        row$.find("td:eq(10)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(10)").html('<span>' + result + '</span>');
                    }
                    if (device == '') {
                        row$.find("td:eq(11)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(11)").html('<span>' + devicetext + '</span>');
                    }
                    $("#tblRange tbody tr").each(function(i, n) {
                        var $row = $(n);
                        if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                            if ($row.find("input[id$='hdnGenderRange']").val() == GenderRange) {
                                ValidationWindow(UsrAlrtMsg9, AlrtWinHdr);
                                //  alert('Range already Exist');
                                return false;
                            }

                        }

                    });
                    row$.find("input[id$='hdnGenderRange']").val(GenderRange);

                }
                onCancelCommonReferenceRange();
                //                $('#' + ddlCategory + ' option:first').attr('selected', true);
            }
            else {
                // alert(message);
                ValidationWindow(message, AlrtWinHdr);
            }
            $("#TabContainer1_TabTestMaster_TM_ddlRRSubCategory").val($("#TabContainer1_TabTestMaster_TM_ddlRRSubCategory option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlCategory").val($("#TabContainer1_TabTestMaster_TM_ddlCategory option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlRefRangeType").val($("#TabContainer1_TabTestMaster_TM_ddlRefRangeType option:first").val());
            $('#divGenderGeneralCategory').hide();
            return false;
        }
        catch (e) {
            return false;
        }
    }

    function AddOtherReferenceRange() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_001") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_001") : "Select range type\n";
        var UsrAlrtMsg1 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_002") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_002") : "Select gender\n";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_019") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_019") : "Select category\n";
        var UsrAlrtMsg3 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_003") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_003") : "Select age type\n";
        var UsrAlrtMsg4 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_006") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_006") : "Select age operator\n";
        var UsrAlrtMsg5 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_022") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_022") : "Age value end range cannot be blank\n";
        var UsrAlrtMsg6 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_023") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_023") : "Age value range cannot be blank\n";
        var UsrAlrtMsg7 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_024") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_024") : "Age value cannot be blank\n";
        var UsrAlrtMsg8 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_025") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_025") : "Reference name cannot be blank\n";
        var UsrAlrtMsg9 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_004") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_004") : "Select value operator\n";
        var UsrAlrtMsg10 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_005") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_005") : "Value end range cannot be blank\n";
        var UsrAlrtMsg11 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_009") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_009") : "Value range cannot be blank\n";
        var UsrAlrtMsg12 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_021") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_021") : "Value cannot be blank\n";
        var UsrAlrtMsg13 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_010") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_010") : "Select interpretation text\n";
        var UsrAlrtMsg14 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_018") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_018") : "Select show result from\n";
        var UsrAlrtMsg15 = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_21") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_21") : "Range already Exist";
        var UseY = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_067") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_067") : "Y";
        var UseN = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_068") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_068") : "N";

        try {
            var selectedRefRangeType = $('#' + ddlRefRangeType + ' option:selected');
            var message = '';
            var isRequiredMissing = false;
            var selectedGender = $('#' + ddlCategory + ' option:selected');
            var selectedRRSubCategory = $('#' + ddlRRSubCategory + ' option:selected');
            var selectedValueOperator = $('#' + ddlOtherRangeOpt + ' option:selected');
            var selectedOtherAgeType = $('#' + ddlOtherAgeType + ' option:selected');
            var selectedOtherAgeOperator = $('#' + ddlOtherAgeOperator + ' option:selected');
            var value = 0;
            var ageValue = '';
            var TypeValue = $('#' + hdnTypeValue).val();


            if ($(selectedRefRangeType).val() == '0') {
                // message += "Select range type\n";
                message += UsrAlrtMsg;
                isRequiredMissing = true;
            }
            if ($(selectedGender).val() == '0') {
                // message += "Select gender\n";
                message += UsrAlrtMsg1;
                isRequiredMissing = true;
            }
            if ($(selectedRRSubCategory).val() == '0') {
                //message += "Select category\n";
                message += UsrAlrtMsg2;
                isRequiredMissing = true;
            }
            if ($(selectedOtherAgeType).val() == '0' && $(selectedOtherAgeOperator).val() != '0') {
                //message += "Select age type\n";
                message += UsrAlrtMsg3;
                isRequiredMissing = true;
            }
            if ($(selectedOtherAgeType).val() != '0' && $(selectedOtherAgeOperator).val() == '0') {
                //message += "Select age operator\n";
                message += UsrAlrtMsg4;
                isRequiredMissing = true;
            }
            if ($(selectedOtherAgeType).val() != '0' && $(selectedOtherAgeOperator).val() != '0') {
                if (($(selectedOtherAgeOperator).val() == 'Between') && $.trim($('#' + txtOtherAgeRange2).val()) == '') {
                    // message += "Age value end range cannot be blank\n";
                    message += UsrAlrtMsg5;
                    isRequiredMissing = true;
                }
                if ($.trim($('#' + txtOtherAgeRange2).val()) != '') {
                    if ($.trim($('#' + txtOtherAgeRange1).val()) == '') {
                        //message += "Age value range cannot be blank\n";
                        message += UsrAlrtMsg6;
                        isRequiredMissing = true;
                    }
                    else {
                        ageValue = $.trim($('#' + txtOtherAgeRange1).val()) + "-" + $.trim($('#' + txtOtherAgeRange2).val());
                    }
                }
                else {
                    if ($.trim($('#' + txtOtherAgeRange1).val()) == '') {
                        // message += "Age value cannot be blank\n";
                        message += UsrAlrtMsg7;
                        isRequiredMissing = true;
                    }
                    else {
                        ageValue = $.trim($('#' + txtOtherAgeRange1).val());
                    }
                }
            }
            if ($.trim($('#' + txtGenderOther).val()) == '') {
                //message += "Reference name cannot be blank\n";
                message += UsrAlrtMsg8;
                isRequiredMissing = true;
            }

            var ValueIsNormal = '';
            if (TypeValue == 'Numeric') {
                if (!($('#' + chkIsSourceText).is(':checked')) && $(selectedValueOperator).val() == '0') {
                    //message += "Select value operator\n";
                    message += UsrAlrtMsg9;
                    isRequiredMissing = true;
                }
                else if (($(selectedValueOperator).val() == 'Between') && $.trim($('#' + txtOtherRange2).val()) == '') {
                    //message += "Value end range cannot be blank\n";
                    message += UsrAlrtMsg10;
                    isRequiredMissing = true;
                }
                if ($.trim($('#' + txtOtherRange2).val()) != '') {
                    if ($.trim($('#' + txtOtherRange1).val()) == '') {
                        //message += "Value range cannot be blank\n";
                        message += UsrAlrtMsg11;
                        isRequiredMissing = true;
                    }
                    else {
                        value = $.trim($('#' + txtOtherRange1).val()) + "-" + $.trim($('#' + txtOtherRange2).val());
                    }
                }
                else {
                    if (!($('#' + chkIsSourceText).is(':checked')) && $.trim($('#' + txtOtherRange1).val()) == '') {
                        // message += "Value cannot be blank\n";
                        message += UsrAlrtMsg12;
                        isRequiredMissing = true;
                    }
                    else {
                        if ($('#' + chkIsSourceText).is(':checked')) {
                            value = '';
                        }
                        else {
                            value = $.trim($('#' + txtOtherRange1).val());
                        }
                    }
                }
            }
            //            else {
            var ValueIsNormal = $('#' + chkNormalValue).is(':checked') ? UseY : UseN;
            //            }
            var isSourceText = $('#' + chkIsSourceText).is(':checked') ? 'Y' : '-';
            var selectedOpr = $(selectedValueOperator).val() == '0' ? '' : $(selectedValueOperator).val();
            if (isSourceText == "Y") {
                selectedOpr = "Source";
            }
            var data = '';
            var result = '';
            var device = '';
            var devicetext = '';
            if ($(selectedRefRangeType).val() == 'resultsinterpretationrange') {
                var selectedOtherBulkData = $('#' + ddlOtherBulkData + ' option:selected');
                var selectedOtherResult = $('#' + ddlOtherResult + ' option:selected');
                var selectedOtherDevice = $('#' + ddlOtherDevice + ' option:selected');
                if ($(selectedOtherBulkData).val() == '0') {
                    // message += "Select interpretation text\n";
                    message += UsrAlrtMsg13;
                    isRequiredMissing = true;
                }
                else {
                    data = $(selectedOtherBulkData).text();
                }
                if ($(selectedOtherResult).val() == '0') {
                    //message += "Select show result from\n";
                    message += UsrAlrtMsg14;
                    isRequiredMissing = true;
                }
                else {
                    result = $(selectedOtherResult).text();
                }
                if ($(selectedOtherDevice).val() != '0') {
                    device = $(selectedOtherDevice).val();
                    devicetext = $(selectedOtherDevice).text();
                }
            }
            if (!isRequiredMissing) {
                var selectedAgeType = $(selectedOtherAgeType).val() == '0' ? '' : $(selectedOtherAgeType).text();
                var selectedAgeTypeVal = $(selectedOtherAgeType).val() == '0' ? '' : $(selectedOtherAgeType).val();
                var selectedAgeOpr = $(selectedOtherAgeOperator).val() == '0' ? '' : $(selectedOtherAgeOperator).val();
                var OtherRange = $(selectedGender).val() + "~" + $('#' + txtGenderOther).val() + "~" + selectedOpr + "~" + value + "~" + ValueIsNormal + "~" + isSourceText + "~" + selectedAgeTypeVal + "~" + selectedAgeOpr + "~" + ageValue + "~" + data + "~" + result + "~" + device + "~" + TypeValue + "^";
                $('#' + divScrolling).show();
                var row$;
                var tdRangetype = $('<td/>').html('<span>' + $(selectedRefRangeType).text() + '</span>');
                var tdGender = $('<td/>').html('<span>' + $(selectedGender).text() + '</span>');
                var tdSubcategory = $('<td/>').html('<span>' + $(selectedRRSubCategory).text() + '</span>');
                //                var hdnRefRangeValue = $('<td/>').html('<span style="display:none;">' + $(selectedRefRangeType).val() + '</span>');
                //                var hdnGenderValue = $('<td/>').html('<span style="display:none;">' + $(selectedGender).val() + '</span>');
                //                var hdnSubcategoryValue = $('<td/>').html('<span style="display:none;">' + $(selectedRRSubCategory).val() + '</span>');
                var tdAgeRange = '';
                if (selectedAgeOpr == 'Between') {
                    tdAgeRange = $('<td/>').html('<span>' + ageValue + '</span>');
                }
                else if (selectedAgeOpr != '') {
                    tdAgeRange = $('<td/>').html('<span>' + selectedAgeOpr + ' ' + ageValue + '</span>');
                }
                else {
                    tdAgeRange = $('<td/>').html('<span>' + '-' + '</span>');
                }
                var tdAgeUnits = $('<td/>').html('<span>' + (selectedAgeType == '' ? '-' : selectedAgeType) + '</span>');
                if ($('#' + hdnSelectedOthersRowIndex).val() == '') {
                    row$ = $('<tr/>');
                    var tdGender = $('<td/>').html('<span>' + $(selectedGender).text() + '</span>');
                    var tdReferenceName = $('<td/>').html('<span>' + $('#' + txtGenderOther).val() + '</span>');
                    var tdValueOperator = '';
                    var tdValueRange = '';
                    var IsNormal = '';
                    IsNormal = $('<td/>').html('<span>' + ValueIsNormal + '</span>');
                    var IsSource = '';
                    if ($('#' + chkIsSourceText).is(':checked')) {
                        IsSource = $('<td/>').html('<span>Y</span>');
                    }
                    else {
                        IsSource = $('<td/>').html('<span>-</span>');
                    }
                    if (TypeValue == 'Numeric') {
                        if (selectedOpr == 'Between' || $('#' + chkIsSourceText).is(':checked')) {
                            tdValueRange = $('<td/>').html('<span>' + value + '</span>');
                        }
                        else {
                            tdValueRange = $('<td/>').html('<span>' + selectedOpr + ' ' + value + '</span>');
                        }


                    }
                    if (TypeValue == 'Text') {
                        tdValueOperator = $('<td/>').html('<span>' + '' + '</span>');
                        tdValueRange = $('<td/>').html('<span>' + '' + '</span>');
                    }
                    var tdBulkData = '';
                    if (data == '') {
                        tdBulkData = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdBulkData = $('<td/>').html('<span>' + data + '</span>');
                    }
                    var tdResult = '';
                    if (result == '') {
                        tdResult = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdResult = $('<td/>').html('<span>' + result + '</span>');
                    }
                    var tdDevice = '';
                    if (device == '') {
                        tdDevice = $('<td/>').html('<span>' + '-' + '</span>');
                    }
                    else {
                        tdDevice = $('<td/>').html('<span>' + devicetext + '</span>');
                    }
                    $("#tblRange tbody tr").each(function(i, n) {
                        var $row = $(n);
                        if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                            if ($row.find("input[id$='hdnOtherRange']").val() == OtherRange) {
                                //alert('Range already Exist');
                                ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
                                return false;
                            }

                        }

                    });


                    var hdnOtherRange = '<input id="hdnOtherRange" type="hidden" value="' + OtherRange + '"/>';

                    var tdDelete = $('<td align="center"/>').html(hdnOtherRange + '<input id="btnEditOthersReferenceRange" value="' + lbledit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onEditOthersReferenceRange(this);" />' + '<input id="btnDeleteOtherReferenceRange" value="' + lbldeletes + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteOtherReferenceRange(this);" />');

                    row$.append(tdRangetype).append(tdGender).append(tdSubcategory).append(tdAgeRange).append(tdAgeUnits).append(tdReferenceName).append(tdValueRange).append(IsNormal).append(IsSource).append(tdBulkData).append(tdResult).append(tdDevice).append(tdDelete);
                    var RefRange = '<input id="hdnRefRangeID"  value="' + $(selectedRefRangeType).val() + '"/>';
                    var GenderVal = '<input id="hdnGenderValue"  value="' + $(selectedGender).val() + '"/>';
                    var SubCategory = '<input id="hdnSubcategoryValue" value="' + $(selectedRRSubCategory).val() + '"/>';
                    row$.append($('<td style="display:none"/>').html('<input id="hdnRefRangeID"  value="' + $(selectedRefRangeType).val() + '"/>' + '<input id="hdnGenderValue"  value="' + $(selectedGender).val() + '"/>' + '<input id="hdnSubcategoryValue" value="' + $(selectedRRSubCategory).val() + '"/>'));
                    $('#tblRange tbody').append(row$);
                    $('#divReferenceRangeTable').show();

                }
                else {
                    var selectedRowIndex = $('#' + hdnSelectedOthersRowIndex).val();

                    row$ = $('#tblRange tbody tr:eq(' + selectedRowIndex + ')');
                    $('#divReferenceRangeTable').show();

                    row$.find("td:eq(1)").html('<span>' + $(selectedGender).text() + '</span>');
                    if (selectedAgeOpr == 'Between') {
                        row$.find("td:eq(3)").html('<span>' + ageValue + '</span>');
                    }
                    else if (selectedAgeOpr != '') {
                        row$.find("td:eq(3)").html('<span>' + selectedAgeOpr + ' ' + ageValue + '</span>');
                    }
                    else {
                        row$.find("td:eq(3)").html('<span>' + '-' + '</span>');
                    }
                    row$.find("td:eq(4)").html('<span>' + (selectedAgeType == '' ? '-' : selectedAgeType) + '</span>');
                    row$.find("td:eq(5)").html('<span>' + $('#' + txtGenderOther).val() + '</span>');
                    if (TypeValue == 'Numeric') {
                        if (selectedOpr == 'Between' || $('#' + chkIsSourceText).is(':checked')) {
                            row$.find("td:eq(6)").html('<span>' + value + '</span>');
                        } else {
                            row$.find("td:eq(6)").html('<span>' + selectedOpr + ' ' + value + '</span>');
                        }
                    }
                    row$.find("td:eq(7)").html('<span>' + ValueIsNormal + '</span>');
                    row$.find("td:eq(8)").html('<span>' + isSourceText + '</span>');
                    if (data == '') {
                        row$.find("td:eq(9)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(9)").html('<span>' + data + '</span>');
                    }
                    if (result == '') {
                        row$.find("td:eq(10)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(10)").html('<span>' + result + '</span>');
                    }
                    if (device == '') {
                        row$.find("td:eq(11)").html('<span>-</span>');
                    }
                    else {
                        row$.find("td:eq(11)").html('<span>' + devicetext + '</span>');
                    }
                    $("#tblRange tbody tr").each(function(i, n) {
                        var $row = $(n);
                        if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                            if ($row.find("input[id$='hdnOtherRange']").val() == OtherRange) {
                                // alert('Range already Exist');
                                ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
                                return false;
                            }

                        }

                    });
                    row$.find("input[id$='hdnOtherRange']").val(OtherRange);
                }
                onCancelOthersReferenceRange();
            }
            else {
                ValidationWindow(message, AlrtWinHdr);
                //  alert(message);
            }
            $("#TabContainer1_TabTestMaster_TM_ddlOtherAgeType").val($("#TabContainer1_TabTestMaster_TM_ddlOtherAgeType option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherAgeOperator").val($("#TabContainer1_TabTestMaster_TM_ddlOtherAgeOperator option:first").val());
            $("#TabContainer1_TabTestMaster_TM_txtGenderOther").val($("#TabContainer1_TabTestMaster_TM_txtGenderOther option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherRangeOpt").val($("#TabContainer1_TabTestMaster_TM_ddlOtherRangeOpt option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlRRSubCategory").val($("#TabContainer1_TabTestMaster_TM_ddlRRSubCategory option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlRefRangeType").val($("#TabContainer1_TabTestMaster_TM_ddlRefRangeType option:first").val()); //
            $('#TabContainer1_TabTestMaster_TM_ddlCategory').val($('#TabContainer1_TabTestMaster_TM_ddlCategory option:first').val());
            $('#divGenderOtherCategory').hide();
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function SaveReferenceRange() {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        try {
            $('#' + hdnIsRRXML).val('false');
            $('#' + hdnIsChangesFromRRPopup).val('false');
            $('#' + hdnAgeRangeAdd).val('');
            $('#' + hdnGenderRangeAdd).val('');
            $('#' + hdnOtherReferenceRangeAdd).val('');
            $('#' + hdnRRStringAdd).val('');
            $('#' + hdnRRXMLAdd).val('');
            var tblAgeRangeValues = '';
            var tblGenderRangeValues = '';
            var tblAuthorGenderRangeValues = '';
            var tblExclusiveGenderRangeValues = '';
            var tblDomainGenderRangeValues = '';
            var tblSensitiveGenderRangeValues = '';
            var tblOtherRangeValues = '';
            var tblAuthorOtherRangeValues = ''
            var tblExclusiveOtherRangeValues = ''
            var tblDomainOtherRangeValues = ''
            var tblSensitiveOtherRangeValues = '';
            var tblPRAgeRangeValues = '';
            var tblAuthorAgeRangeValues = '';
            var tblExclusiveAgeRangeValues = '';
            var tblDomainAgeRangeValues = '';
            var tblSensitiveAgeRangeValues = '';
            var tblPRGenderRangeValues = '';
            var tblPROtherRangeValues = '';
            var lstReferenceRanges = '';
            var referenceRange = '';
            var panicRange = '';
            var AutoAuthorRange = '';
            var AutoExclusiveRange = '';
            var DomainRange = '';
            var PrintableRange = '';
            var SensitiveRange = '';
            var tblPrintRangeAgeRangeValues = '';
            var tblPrintRangeGenderRangeValues = '';
            var tblPrintRangeOtherRangeValues = '';
            var ResultsInterpretationRange = '';
            var tblResultsInterpretationRangeAgeValues = '';
            var tblResultsInterpretationRangeGenderValues = '';
            var tblResultsInterpretationRangeOtherValues = '';

            var varreferenceRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_047') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_047') : "Reference Range";
            var varPanicRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_048') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_048') : "Panic Range";
            var varCriticalRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_049') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_049') : "Critical Range";
            var AutoAuthorizationRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_050') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_050') : "Auto Authorization Range";
            var varDomainRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_051') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_051') : "Domain Range";
            var varPrintableRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_052') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_052') : "Printable Range";
            var SensitiveResultRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_053') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_053') : "Sensitive Result Range";
            var varAge = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_054') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_054') : "Age";
            var varCommon = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_055') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_055') : "Common";
            var varOther = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_056') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_056') : "Other";
            var varInterPretationRange = SListForAppDisplay.Get('CommonControls_TestMaster_ascx_057') != null ? SListForAppDisplay.Get('CommonControls_TestMaster_ascx_057') : "Results Interpretation Range";
            $("#tblRange tbody tr").each(function(i, n) {
                var $row = $(n);
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'referencerange') {
                    // $row.find("td").eq(0).find('span').html()
                    //  if ($row.find("td:eq(0)").find('span').html() == 'Reference Range') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Age') {
                        //if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                        tblAgeRangeValues += $row.find("input[id$='hdnAgeRange']").val();
                    }
                }
                //if ($row.find("td:eq(0)").find('span').html() == 'Reference Range') {
                // if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'referencerange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') {
                        tblGenderRangeValues += $row.find("input[id$='hdnGenderRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Reference Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'referencerange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblOtherRangeValues += $row.find("input[id$='hdnOtherRange']").val();
                    }
                }
                ////                if ($row.find("td:eq(0)").find('span').html() == 'Panic Range') {
                ////                    if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                //                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'panicrange') {
                //                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Age') {  
                //                        tblPRAgeRangeValues += $row.find("input[id$='hdnAgeRange']").val();
                //                    }
                //                }
                ////                if ($row.find("td:eq(0)").find('span').html() == 'Panic Range') {
                ////                    if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                //                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'panicrange') {
                //                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') { 
                //                        tblPRGenderRangeValues += $row.find("input[id$='hdnGenderRange']").val();
                //                    }
                //                }
                ////                if ($row.find("td:eq(0)").find('span').html() == 'Panic Range') {
                ////                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                //                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'panicrange') {
                //                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') { 
                //                        tblPROtherRangeValues += $row.find("input[id$='hdnOtherRange']").val();
                //                    }
                //                }

                //                if ($row.find("td:eq(0)").find('span').html() == 'Critical Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'panicrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Age') {
                        tblPRAgeRangeValues += $row.find("input[id$='hdnAgeRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Critical Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'panicrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') {
                        tblPRGenderRangeValues += $row.find("input[id$='hdnGenderRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Critical Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'panicrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblPROtherRangeValues += $row.find("input[id$='hdnOtherRange']").val();
                    }
                }


                //                if ($row.find("td:eq(0)").find('span').html() == 'Auto Authorization Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'autoauthorizationrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Age') {
                        tblAuthorAgeRangeValues += $row.find("input[id$='hdnAgeRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Auto Authorization Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'autoauthorizationrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') {
                        tblAuthorGenderRangeValues += $row.find("input[id$='hdnGenderRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Auto Authorization Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'autoauthorizationrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblAuthorOtherRangeValues += $row.find("input[id$='hdnOtherRange']").val();
                    }
                }

                //                if ($row.find("td:eq(0)").find('span').html() == 'Domain Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'domainrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Age') {
                        tblDomainAgeRangeValues += $row.find("input[id$='hdnAgeRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Domain Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'domainrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') {
                        tblDomainGenderRangeValues += $row.find("input[id$='hdnGenderRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Domain Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'domainrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblDomainOtherRangeValues += $row.find("input[id$='hdnOtherRange']").val();
                    }
                }

                //                if ($row.find("td:eq(0)").find('span').html() == 'Printable Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'printablerange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Age') {
                        tblPrintRangeAgeRangeValues += $row.find("input[id$='hdnAgeRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Printable Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'printablerange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') {
                        tblPrintRangeGenderRangeValues += $row.find("input[id$='hdnGenderRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Printable Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'printablerange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblPrintRangeOtherRangeValues += $row.find("input[id$='hdnOtherRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Sensitive Result Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'sensitiveresultrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblSensitiveAgeRangeValues += $row.find("input[id$='hdnAgeRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Sensitive Result Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'sensitiveresultrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') {
                        tblSensitiveGenderRangeValues += $row.find("input[id$='hdnGenderRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Sensitive Result Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'sensitiveresultrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblSensitiveOtherRangeValues += $row.find("input[id$='hdnOtherRange']").val();
                    }
                }

                //                if ($row.find("td:eq(0)").find('span').html() == 'Results Interpretation Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Age') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'resultsinterpretationrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Age') {
                        tblResultsInterpretationRangeAgeValues += $row.find("input[id$='hdnAgeRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Results Interpretation Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Common') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'resultsinterpretationrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Common') {
                        tblResultsInterpretationRangeGenderValues += $row.find("input[id$='hdnGenderRange']").val();
                    }
                }
                //                if ($row.find("td:eq(0)").find('span').html() == 'Results Interpretation Range') {
                //                    if ($row.find("td:eq(2)").find('span').html() == 'Other') {
                if ($row.find($('input[id$="hdnRefRangeID"]')).val() == 'resultsinterpretationrange') {
                    if ($row.find($('input[id$="hdnSubcategoryValue"]')).val() == 'Other') {
                        tblResultsInterpretationRangeOtherValues += $row.find("input[id$='hdnOtherRange']").val();
                    }
                }
            });
            if (tblAgeRangeValues.length > 0) {
                referenceRange += tblAgeRangeValues + "|Age";
            }
            if (referenceRange != '') {
                referenceRange = referenceRange + "@";
            }

            if (tblGenderRangeValues.length > 0) {
                referenceRange += tblGenderRangeValues + "|Common";
            }
            if (referenceRange != '') {
                referenceRange = referenceRange + "@";
            }

            if (tblOtherRangeValues.length > 0) {
                referenceRange += tblOtherRangeValues + "|Other";
            }
            if (referenceRange != '') {
                referenceRange = "referencerange$" + referenceRange;
            }

            if (tblPRAgeRangeValues.length > 0) {
                panicRange += tblPRAgeRangeValues + "|Age";
            }
            if (panicRange != '') {
                panicRange = panicRange + "@";
            }

            if (tblPRGenderRangeValues.length > 0) {
                panicRange += tblPRGenderRangeValues + "|Common";
            }
            if (panicRange != '') {
                panicRange = panicRange + "@";
            }

            if (tblPROtherRangeValues.length > 0) {
                panicRange += tblPROtherRangeValues + "|Other";
            }
            if (panicRange != '') {
                panicRange = "panicrange$" + panicRange;
            }


            if (tblAuthorAgeRangeValues.length > 0) {
                AutoAuthorRange += tblAuthorAgeRangeValues + "|Age";
            }

            if (AutoAuthorRange != '') {
                AutoAuthorRange = AutoAuthorRange + "@";
            }

            if (tblAuthorGenderRangeValues.length > 0) {
                AutoAuthorRange += tblAuthorGenderRangeValues + "|Common";
            }
            if (AutoAuthorRange != '') {
                AutoAuthorRange = AutoAuthorRange + "@";
            }

            if (tblAuthorOtherRangeValues.length > 0) {
                AutoAuthorRange += tblAuthorOtherRangeValues + "|Other";
            }
            if (AutoAuthorRange != '') {
                AutoAuthorRange = "autoauthorizationrange$" + AutoAuthorRange;
            }

            if (tblDomainAgeRangeValues.length > 0) {
                DomainRange += tblDomainAgeRangeValues + "|Age";
            }
            if (DomainRange != '') {
                DomainRange = DomainRange + "@";
            }

            if (tblDomainGenderRangeValues.length > 0) {
                DomainRange += tblDomainGenderRangeValues + "|Common";
            }
            if (DomainRange != '') {
                DomainRange = DomainRange + "@";
            }

            if (tblDomainOtherRangeValues.length > 0) {
                DomainRange += tblDomainOtherRangeValues + "|Other";
            }
            if (DomainRange != '') {
                DomainRange = "domainrange$" + DomainRange;
            }

            if (tblPrintRangeAgeRangeValues.length > 0) {
                PrintableRange += tblPrintRangeAgeRangeValues + "|Age";
            }
            if (PrintableRange != '') {
                PrintableRange = PrintableRange + "@";
            }

            if (tblPrintRangeGenderRangeValues.length > 0) {
                PrintableRange += tblPrintRangeGenderRangeValues + "|Common";
            }
            if (PrintableRange != '') {
                PrintableRange = PrintableRange + "@";
            }

            if (tblPrintRangeOtherRangeValues.length > 0) {
                PrintableRange += tblPrintRangeOtherRangeValues + "|Other";
            }
            if (PrintableRange != '') {
                PrintableRange = "printablerange$" + PrintableRange;
            }
            if (tblSensitiveAgeRangeValues.length > 0) {
                SensitiveRange += tblSensitiveAgeRangeValues + "|Age";
            }
            if (SensitiveRange != '') {
                SensitiveRange = SensitiveRange + "@";
            }

            if (tblSensitiveGenderRangeValues.length > 0) {
                SensitiveRange += tblSensitiveGenderRangeValues + "|Common";
            }
            if (SensitiveRange != '') {
                SensitiveRange = SensitiveRange + "@";
            }
            if (tblSensitiveOtherRangeValues.length > 0) {
                SensitiveRange += tblSensitiveOtherRangeValues + "|Other";
            }
            if (SensitiveRange != '') {
                SensitiveRange = "sensitiveresultrange$" + SensitiveRange;
            }


            if (tblResultsInterpretationRangeAgeValues.length > 0) {
                ResultsInterpretationRange += tblResultsInterpretationRangeAgeValues + "|Age";
            }
            if (ResultsInterpretationRange != '') {
                ResultsInterpretationRange = ResultsInterpretationRange + "@";
            }

            if (tblResultsInterpretationRangeGenderValues.length > 0) {
                ResultsInterpretationRange += tblResultsInterpretationRangeGenderValues + "|Common";
            }
            if (ResultsInterpretationRange != '') {
                ResultsInterpretationRange = ResultsInterpretationRange + "@";
            }

            if (tblResultsInterpretationRangeOtherValues.length > 0) {
                ResultsInterpretationRange += tblResultsInterpretationRangeOtherValues + "|Other";
            }
            if (ResultsInterpretationRange != '') {
                ResultsInterpretationRange = "resultsinterpretationrange$" + ResultsInterpretationRange;
            }

            if (referenceRange != '') {
                lstReferenceRanges = referenceRange;
            }
            if (panicRange != '') {
                lstReferenceRanges += lstReferenceRanges.length > 0 ? "#" + panicRange : panicRange;
            }
            if (AutoAuthorRange != '') {
                lstReferenceRanges += lstReferenceRanges.length > 0 ? "#" + AutoAuthorRange : AutoAuthorRange;
            }
            if (DomainRange != '') {
                lstReferenceRanges += lstReferenceRanges.length > 0 ? "#" + DomainRange : DomainRange;
            }
            if (PrintableRange != '') {
                lstReferenceRanges += lstReferenceRanges.length > 0 ? "#" + PrintableRange : PrintableRange;
            }
            if (SensitiveRange != '') {
                lstReferenceRanges += lstReferenceRanges.length > 0 ? "#" + SensitiveRange : SensitiveRange;
            }
            if (ResultsInterpretationRange != '') {
                lstReferenceRanges += lstReferenceRanges.length > 0 ? "#" + ResultsInterpretationRange : ResultsInterpretationRange;
            }
            if ($.trim(lstReferenceRanges) != '') {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/ConvertReferenceRangeXml",
                    data: "{rawData: '" + $.trim(lstReferenceRanges) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        var xmlContent = data.d;
                        $('#' + txtReferenceRange).val(xmlContent[1]);
                        $('#' + txtROReferenceRange).val($('<div></div>').html(xmlContent[1]).text());
                        $('#' + hdnRRXMLAdd).val(xmlContent[0]);
                        $('#' + hdnRRStringAdd).val(xmlContent[2]);

                        $('#' + hdnAgeRangeAdd).val('');
                        $('#' + hdnGenderRangeAdd).val('');
                        $('#' + hdnOtherReferenceRangeAdd).val('');

                        $('#divModalRefRange').hide();
                        $('#' + hdnIsRRXML).val('true');
                        $('#' + hdnIsChangesFromRRPopup).val('true');
                        $('#' + txtReferenceRange).attr('style', 'display:none');
                        $('#' + txtROReferenceRange).attr('style', 'display:block;width:180px; height:80px;');
                        $('#divReferenceRangeHint').show();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        // alert(xhr.status);
                        ValidationWindow(xhr.status, AlrtWinHdr);
                    }
                });
            }
            else {
                $('#' + hdnAgeRangeAdd).val('');
                $('#' + hdnGenderRangeAdd).val('');
                $('#' + hdnOtherReferenceRangeAdd).val('');

                $('#divModalRefRange').hide();
                $('#' + txtReferenceRange).val('');
                $('#' + hdnRRXMLAdd).val('');
                $('#' + hdnRRStringAdd).val('');
                $('#divReferenceRangeHint').hide();
            }

            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onLoadRefMapping() {

        try {
            if (document.getElementById('TabContainer1_TabTestMaster_TM_hdnView').value == 'Y') {

                var btnDeleteRefMapping = '<input class="del" id="btnDeleteRefMapping" value="' + lbldeletes + '" type="button" style="cursor:pointer;background: none;border: none;text-decoration: underline;" onclick="onDeleteRefMapping(this);" />';
                setTimeout(function() { $("input[class$='del']").hide(); }, 3000);


            }


        }
        catch (e) {
            return false;
        }
    }
    function onSaveRefMapping() {
        //debugger;
        var UsrAdd = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") : "Add";
        var Usrupdate = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") : "Update";
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_25") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_25") : "Test code can't be mapped without device";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_26") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_26") : "Atleast one value required";
        var UsrAlrtMsg2 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_22") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_22") : "Only one primary record is possible";
        var UsrAlrtMsg3 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_27") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_27") : "Reason is required while changing the details";
        var Useyes = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065") : "Yes";
        var UseNo = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066") : "No";
        var btnAddRefMapping = '<%=btnAddRefMapping.ClientID %>';


        try {
            var message = '';
            var isRequiredMissing = false;
            var selectedInstrument = $('#' + ddlInstrument + ' option:selected');
            // var selectedKit = $('#' + ddlKit + ' option:selected');
            var selectedKit = '0';
            var UOM = $.trim($('#' + txtUOM).val());
            var UOMID = $.trim($('#' + hdnUOMID).val()) == '' ? '0' : $.trim($('#' + hdnUOMID).val());
            // var TestCode = $.trim($('#' + txtTestCode).val());
            var TestCode = '';
            var selectedClient = $.trim($('#' + txtClient).val());
            var selectedClientId = 0;
            if (selectedClient == '') {
                selectedClientId = 0;
            } else {
                selectedClientId = $.trim($('#' + hdnSelectedClientID).val());
            }
            if (selectedClientId == 0) {
                selectedClient = '';
            }
            var ReferenceRange = $.trim($('#' + txtReferenceRange).val());
            //----- Sathish.E-------//

            var ConvUOM = $.trim($('#' + txtConvUom).val());
            var ConvUOMID = $.trim($('#' + hdnConvUOMID).val()) == '' ? '0' : $.trim($('#' + hdnConvUOMID).val());
            var ConvFactor = $.trim($('#' + txtConvFactor).val());
            var ConvDecimal = $.trim($('#' + txtConvDecimal).val());

            //----- Sathish.E-------//
            if ($(selectedInstrument).val() == '0' && TestCode != '') {
                //alert("Test code can't be mapped without device");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            if ($(selectedInstrument).val() == '0' && selectedKit == '0' && selectedClient == '' && ReferenceRange == '' && UOM == '' && TestCode == '') {
                // alert("Atleast one value required");
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                return false;
            }
            else {
                var selectedReason = $('#' + ddlReason + ' option:selected');
                var row$;
                var primary = $('#' + chkPrimary).is(':checked') ? Useyes : UseNo;
                var active = $('#' + chkRefMappingActive).is(':checked') ? Useyes : UseNo;
                var instrumentName = $(selectedInstrument).val() == '0' ? '' : $(selectedInstrument).text();
                var kitName = $(selectedKit).val() == '0' ? '' : $(selectedKit).text();
                var clientName = selectedClient == '0' ? '' : selectedClient;
                var hdnSelInvRefMappingID = $.trim($('#' + hdnSelectedInvRefMappingID).val()) == '' ? '0' : $.trim($('#' + hdnSelectedInvRefMappingID).val());
                var hdnSelDeviceMappingID = $.trim($('#' + hdnSelectedDeviceMappingID).val()) == '' ? '0' : $.trim($('#' + hdnSelectedDeviceMappingID).val());
                var hdnInvRefMappingID = '<input id="hdnInvRefMappingID" type="hidden" value="' + hdnSelInvRefMappingID + '"/>';
                var hdnDeviceMappingID = '<input id="hdnDeviceMappingID" type="hidden" value="' + hdnSelDeviceMappingID + '"/>';
                var hdnInstrumentID = '<input id="hdnInstrumentID" type="hidden" value="' + $(selectedInstrument).val() + '"/>';
                var hdnKitID = '<input id="hdnKitID" type="hidden" value="' + $(selectedKit).val() + '"/>'; //Vijayalakshmi.M
                //var hdnKitID = 0;
                var hdnClientID = '<input id="hdnClientID" type="hidden" value="' + selectedClientId + '"/>';
                var hdnRefMappingUOMID = '<input id="hdnRefMappingUOMID" type="hidden" value="' + UOMID + '"/>';
                var lblRRXML = '<span id="lblRRXML" style="display:none;">' + $('#' + hdnRRXMLAdd).val() + '</span>';
                var lblRRString = '<input id="lblRRString" type="hidden" value="' + $('#' + hdnRRStringAdd).val() + '"/>';
                var reasonName = $(selectedReason).val() == '0' ? '' : $(selectedReason).text();
                var hdnReasonCode = '<input id="hdnReasonCode" type="hidden" value="' + $(selectedReason).val() + '"/>';
                var multiplePrimary = false;
                //--------------Sathish.E---------------------//
                var hdnRefMappingConvUOMID = '<input id="hdnRefMappingConvUOMID" type="hidden" value="' + ConvUOMID + '"/>';
                if (primary == 'Yes') {
                    $('#tblInvRefMapping tbody tr').each(function(i, n) {
                        var $row = $(n);
                        var isPrimary = $row.find($('span[id$="lblPrimary"]')).html();
                        if (isPrimary == 'Yes') {

                            if ( $('#' + btnAddRefMapping).val() == UsrAdd) {
                                multiplePrimary = true;
                                return false;
                            }
                            else {
                                if ($('#' + hdnSelectedRefMappingRowIndex).val() != i) {
                                    multiplePrimary = true;
                                    return false;
                                }
                            }
                        }
                        else {
                            multiplePrimary = false;
                        }
                    });
                    if (multiplePrimary) {
                        //alert("Only one primary record is possible");
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                        return false;
                    }
                }
                if ($('#' + hdnSelectedRefMappingRowIndex).val() == '') {
                    row$ = $('<tr/>');
                    var tdInstrument = $('<td/>').html(hdnInvRefMappingID + hdnInstrumentID + hdnKitID + hdnDeviceMappingID + lblRRXML + lblRRString + "<span id='lblInstrumentName'>" + instrumentName + "</span>");
                    //var tdKit = $('<td/>').html("<span id='lblKitName'>" + kitName + "</span>");
                    var tdUOM = $('<td/>').html(hdnRefMappingUOMID + "<span id='lblUOM'>" + UOM + "</span>");
                    //var tdTestCode = $('<td/>').html("<span id='lblTestCode'>" + TestCode + "</span>");
                    var TestCode = 0;
                    var tdClientName = $('<td/>').html(hdnClientID + "<span id='lblClientName'>" + clientName + "</span>");
                    var tdReferenceRange = $('<td/>').html("<span id='lblReferenceRange'>" + ReferenceRange + "</span>");
                    var tdPrimary = $('<td/>').html("<span id='lblPrimary'>" + primary + "</span>");
                    var tdActive = $('<td/>').html("<span id='lblActive'>" + active + "</span>");
                    var tdReason = $('<td/>').html(hdnReasonCode + "<span id='lblReasonName'>" + reasonName + "</span>");
                    //------------Sathish.E-----------//
                    var tdConvUOM = $('<td/>').html(hdnRefMappingConvUOMID + "<span id='lblConvUOM'>" + ConvUOM + "</span>");
                    var tdConvFactor = $('<td/>').html("<span id='lblConvFactor'>" + ConvFactor + "</span>");
                    var tdConvDecimal = $('<td/>').html("<span id='lblConvDecimal'>" + ConvDecimal + "</span>");
                    //****Sathish.E*********//
                    var btnEditRefMapping = '<input id="btnEditRefMapping" value="' + lbledit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 0;" onclick="onEditRefMapping(this);" />';

                    var btnDeleteRefMapping = '<input id="btnDeleteRefMapping" value="' + lbldeletes + '" style="cursor:pointer;background: none;border: none;text-decoration: underline;" type="button" onclick="onDeleteRefMapping(this);" />';
                    var tdAction = $('<td align="center"/>').html(btnEditRefMapping + '&nbsp;' + btnDeleteRefMapping);
                    // row$.append(tdInstrument).append(tdKit).append(tdUOM).append(tdTestCode).append(tdClientName).append(tdReferenceRange).append(tdPrimary).append(tdActive).append(tdReason).append(tdAction);
                    row$.append(tdInstrument).append(tdUOM).append(tdClientName).append(tdReferenceRange).append(tdPrimary).append(tdActive).append(tdReason).append(tdConvUOM).append(tdConvFactor).append(tdConvDecimal).append(tdAction);

                    $('#tblInvRefMapping tbody').append(row$);
                }
                else {
                    if ($(selectedReason).val() == '0') {
                        //alert("Reason is required while changing the details");
                        ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                        return false;
                    }
                    var selectedRowIndex = $('#' + hdnSelectedRefMappingRowIndex).val();
                    row$ = $('#tblInvRefMapping tbody tr:eq(' + selectedRowIndex + ')');
                    //row$.find("span[id$='lblKitName']").html(kitName);
                    row$.find("input[id$='hdnRefMappingUOMID']").val(UOMID);
                    row$.find("span[id$='lblUOM']").html(UOM);
                    // row$.find("span[id$='lblTestCode']").html(TestCode);
                    row$.find("input[id$='hdnClientID']").val(selectedClientId);
                    row$.find("span[id$='lblClientName']").html(clientName);
                    row$.find("span[id$='lblReferenceRange']").html(ReferenceRange);
                    row$.find("span[id$='lblPrimary']").html(primary);
                    row$.find("span[id$='lblActive']").html(active);
                    row$.find("input[id$='hdnReasonCode']").val($(selectedReason).val());
                    row$.find("span[id$='lblReasonName']").html(reasonName);
                    //---------Sathish.E------//
                    row$.find("input[id$='hdnRefMappingConvUOMID']").val(ConvUOMID);
                    row$.find("span[id$='lblConvUOM']").html(ConvUOM);
                    row$.find("span[id$='lblConvFactor']").html(ConvFactor);
                    row$.find("span[id$='lblConvDecimal']").html(ConvDecimal);

                    row$.find("input[id$='hdnRefMapConv_UOMID']").val(ConvUOMID);
                    row$.find("span[id$='lblRefMapConv_UOM']").html(ConvUOM);
                    row$.find("span[id$='lblRefMapConv_Factor']").html(ConvFactor);
                    row$.find("span[id$='lblRefMapConvFac_DecimalPoint']").html(ConvDecimal);
                    row$.find("td:eq(0)").html(hdnInvRefMappingID + hdnInstrumentID + hdnKitID + hdnDeviceMappingID + lblRRXML + lblRRString + "<span id='lblInstrumentName'>" + instrumentName + "</span>");
                }
                $('#' + hdnSelectedInvRefMappingID).val('');
                $('#' + txtROReferenceRange).val('');
                $("#TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_ddlInstrument").val($("#TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_ddlInstrument option:first").val());
                onCancelRefMapping();
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onCancelAgeReferenceRange() {
        try {
            //  $('#' + ddlCategory + ' option:first').attr('selected', true);
            $('#' + ddlAgeType + ' option:first').attr('selected', true);
            $('#' + ddlOperatorRange2 + ' option:first').attr('selected', true);
            $('#' + ddlOperatorRange1 + ' option:first').attr('selected', true);
            $('#divAgeBetween').hide();
            $('#' + txtAgeRange1).val('');
            $('#' + txtAgeRange2).val('');
            $('#divValueBetween').hide();
            $('#divAgeValue').show();
            $('#divAgeSource').hide();
            $('#' + txtValueRange1).val('');
            $('#' + txtValueRange2).val('');
            $('#' + hdnSelectedAgeRowIndex).val('');
            $('#' + txtAgeSource).val('');
            $('#' + btnAddRRAge).val('Add');
            $('#' + ddlAgeBulkData + ' option:first').attr('selected', true);
            $('#' + ddlAgeResult + ' option:first').attr('selected', true);
            $('#' + ddlAgeDevice + ' option:first').attr('selected', true);
            $("#TabContainer1_TabTestMaster_TM_ddlAgeType").val($("#TabContainer1_TabTestMaster_TM_ddlAgeType option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOperatorRange1").val($("#TabContainer1_TabTestMaster_TM_ddlOperatorRange1 option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOperatorRange2").val($("#TabContainer1_TabTestMaster_TM_ddlOperatorRange2 option:first").val());
        }

        catch (e) {
            return false;
        }
        return false;
    }
    function onCancelCommonReferenceRange() {
        try {
            $("#TabContainer1_TabTestMaster_TM_ddlOtherAgeType").val($("#TabContainer1_TabTestMaster_TM_ddlOtherAgeType option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherAgeOperator").val($("#TabContainer1_TabTestMaster_TM_ddlOtherAgeOperator option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherRangeOpt").val($("#TabContainer1_TabTestMaster_TM_ddlOtherRangeOpt option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherResult").val($("#TabContainer1_TabTestMaster_TM_ddlOtherResult option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherResult").val($("#TabContainer1_TabTestMaster_TM_ddlOtherResult option:first").val());
            $("#TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_ddlInstrument").val($("#TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_ddlInstrument option:first").val());
            $('#TabContainer1_TabTestMaster_TM_ddlGenderValueOpt').val($('#TabContainer1_TabTestMaster_TM_ddlGenderValueOpt option:first').val());
            //$('#' + ddlCategory + ' option:first').attr('selected', true);
            //$('#' + TabContainer1_TabTestMaster_TM_ddlGenderValueOpt ).attr('selected', true);
            $('#divGenderValueBetween').hide();
            $('#divCommonValue').show();
            $('#divCommonSource').hide();
            $('#' + txtGenderValueStart).val('');
            $('#' + txtGenderValueEnd).val('');
            $('#' + txtCommonSource).val('');
            $('#' + hdnSelectedCommonRowIndex).val('');
            $('#' + btnAddRRCommon).val('Add');
            $('#' + ddlCommonBulkData + ' option:first').attr('selected', true);
            $('#' + ddlCommonResult + ' option:first').attr('selected', true);
            $('#' + ddlCommonDevice + ' option:first').attr('selected', true);
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onCancelOthersReferenceRange() {
        var UsrAdd = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") : "Add";
        try {
            $('#' + ddlCategory + ' option:first').attr('selected', true);
            $('#' + ddlOtherRangeOpt + ' option:first').attr('selected', true);
            $('#' + ddlOtherAgeType + ' option:first').attr('selected', true);
            $('#' + ddlOtherAgeOperator + ' option:first').attr('selected', true);
            $('#divOtherValueBetween').hide();
            $('#divOtherAgeBetween').hide();
            $('#' + txtGenderOther).val('');
            $('#' + txtOtherRange1).val('');
            $('#' + txtOtherRange2).val('');
            $('#' + txtOtherAgeRange1).val('');
            $('#' + txtOtherAgeRange2).val('');
            $('#' + chkNormalValue).attr('checked', false);
            $('#' + hdnSelectedOthersRowIndex).val('');
            $('#' + btnAddRROthers).val(UsrAdd);
            $('#' + chkIsSourceText).attr('checked', false);
            $('#' + ddlOtherBulkData + ' option:first').attr('selected', true);
            $('#' + ddlOtherResult + ' option:first').attr('selected', true);
            $('#' + ddlOtherDevice + ' option:first').attr('selected', true);
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onCancelRefMapping() {
        try {
            var UsrAdd = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") : "Add";
            $("#TabContainer1_TabTestMaster_TM_ddlOtherAgeType").val($("#TabContainer1_TabTestMaster_TM_ddlOtherAgeType option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherAgeOperator").val($("#TabContainer1_TabTestMaster_TM_ddlOtherAgeOperator option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherRangeOpt").val($("#TabContainer1_TabTestMaster_TM_ddlOtherRangeOpt option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherResult").val($("#TabContainer1_TabTestMaster_TM_ddlOtherResult option:first").val());
            $("#TabContainer1_TabTestMaster_TM_ddlOtherResult").val($("#TabContainer1_TabTestMaster_TM_ddlOtherResult option:first").val());
            $("#TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_ddlInstrument").val($("#TabContainer1_TabTestMaster_TM_TabContainer1_TabRangeMapping_ddlInstrument option:first").val());
            $('#' + ddlInstrument + ' option:first').attr('selected', true);
            // $('#' + ddlKit + ' option:first').attr('selected', true);
            $('#' + txtUOM).val('');
            $('#' + hdnUOMID).val('0');
            // $('#' + txtTestCode).val('');
            $('#' + txtClient).val('');
            //  $('#' + hdnClientId).val('0');
            $('#' + hdnSelectedClientID).val('0');
            $('#' + txtReferenceRange).val('');
            $('#' + hdnRRXMLAdd).val('');
            $('#' + hdnRRStringAdd).val('');
            $('#' + chkPrimary).attr('checked', false);
            $('#' + chkRefMappingActive).attr('checked', true);
            $('#' + ddlReason + ' option:first').attr('selected', true);
            $('#divReason').hide();
            $('#' + txtReferenceRange).attr('readonly', false);
            $('#divReferenceRangeHint').hide();
            $('#' + hdnSelectedRefMappingRowIndex).val('');
            $('#' + btnAddRefMapping).val(UsrAdd);
            //Sathish.E//
            $('#' + txtConvUOM).val('');
            $('#' + hdnConvUOMID).val('0');
            $('#' + txtConvFactor).val('');
            $('#' + txtConvDecimal).val('');
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onEditRefMapping(obj) {
        var Useyes = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_065") : "Yes";
        var UseNo = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_066") : "No";
        var Usrupdate = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") : "Update";
        try {
            var $row = $(obj).closest('tr');
            var rowIndex = $row.index();
            $('#' + btnAddRefMapping).val(Usrupdate);
            $('#' + hdnSelectedRefMappingRowIndex).val(rowIndex);
            $('#divReason').show();
            var hdnSelInvRefMappingID = $row.find("input[id$='hdnInvRefMappingID']").val();
            if (hdnSelInvRefMappingID != '') {
                $('#' + hdnSelectedInvRefMappingID).val(hdnSelInvRefMappingID);
            }
            var hdnSelDeviceMappingID = $row.find("input[id$='hdnDeviceMappingID']").val();
            if (hdnSelDeviceMappingID != '') {
                $('#' + hdnSelectedDeviceMappingID).val(hdnSelDeviceMappingID);
            }
            var lblInstrument = $row.find("input[id$='hdnInstrumentID']").val();
            if (lblInstrument != '') {
                $('#' + ddlInstrument).val(lblInstrument);
            }
            else {
                $('#' + ddlInstrument + ' option:first').attr('selected', true);
            }

            //            var lblKit = $row.find("input[id$='hdnKitID']").val();
            //            if (lblKit != '') {
            //                $('#' + ddlKit).val(lblKit);
            //            }
            //            else {
            //                $('#' + ddlKit + ' option:first').attr('selected', true);
            //            }

            var hdnRefMappingUOMID = $row.find("input[id$='hdnRefMappingUOMID']").val();
            $('#' + txtUOM).val($row.find("span[id$='lblUOM']").html());
            if (hdnRefMappingUOMID != '') {
                $('#' + hdnUOMID).val(hdnRefMappingUOMID);
            }

            // $('#' + txtTestCode).val($row.find("span[id$='lblTestCode']").html());

            var hdnRefmapClientID = $row.find("input[id$='hdnClientID']").val();
            if (hdnRefmapClientID != '') {
                document.getElementById('<%=hdnSelectedClientID.ClientID %>').value = hdnRefmapClientID;
            }

            $('#' + txtClient).val($row.find("span[id$='lblClientName']").text());

            $('#' + txtReferenceRange).val($row.find("span[id$='lblReferenceRange']").html());
            $('#' + txtROReferenceRange).val($row.find("span[id$='lblReferenceRange']").text());
            $('#' + txtReferenceRange).attr('style', 'display:none');
            $('#' + txtROReferenceRange).attr('style', 'display:block;width:180px; height:80px;');
            $('#' + hdnRRXMLAdd).val($row.find("span[id$='lblRRXML']").html());
            $('#' + hdnRRStringAdd).val($row.find("input[id$='lblRRString']").val());

            if ($row.find("span[id$='lblPrimary']").html() == Useyes) {
                $('#' + chkPrimary).attr('checked', true);
            }
            else {
                $('#' + chkPrimary).attr('checked', false);
            }

            if ($row.find("span[id$='lblActive']").html() == Useyes) {
                $('#' + chkRefMappingActive).attr('checked', true);
            }
            else {
                $('#' + chkRefMappingActive).attr('checked', false);
            }

            var lblReasonCode = $row.find("input[id$='hdnReasonCode']").val();
            if (lblReasonCode != '') {
                $('#' + ddlReason).val(lblReasonCode);
            }
            else {
                $('#' + ddlReason + ' option:first').attr('selected', true);
            }

            if ($.trim($('#' + hdnRRXMLAdd).val()) != '') {
                $('#' + hdnIsRRXML).val('true');
                $('#' + txtReferenceRange).attr('readonly', true);
                $('#divReferenceRangeHint').show();
            }
            else {
                $('#' + hdnIsRRXML).val('false');
                $('#' + txtReferenceRange).attr('readonly', false);
                $('#divReferenceRangeHint').hide();
            }
            /********* Sathish.E******* */

            var hdnRefMapConv_UOMID = $row.find("input[id$='hdnRefMapConv_UOMID']").val();
            $('#' + txtConvUom).val($row.find("span[id$='lblRefMapConv_UOM']").html());
            if (hdnRefMapConv_UOMID != '') {
                $('#' + hdnConvUOMID).val(hdnRefMapConv_UOMID);
            }

            $('#' + txtConvFactor).val($row.find("span[id$='lblRefMapConv_Factor']").text());
            $('#' + txtConvDecimal).val($row.find("span[id$='lblRefMapConvFac_DecimalPoint']").text());
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function htmlDecode(input) {
        try {
            var e = document.createElement('div');
            e.innerHTML = input;
            return e.childNodes[0].nodeValue;
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onEditAgeReferenceRange(obj) {
        try {
            var Usrupdate = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") : "Update";
            onCancelAgeReferenceRange();
            var $row = $(obj).closest('tr');
            var rowIndex = $row.index();
            $('#' + btnAddRRAge).val(Usrupdate);
            $('#' + hdnSelectedAgeRowIndex).val(rowIndex);
            $("#" + ddlRefRangeType + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(0).find('span').html(); }).attr('selected', 'selected');
            $("#" + ddlRRSubCategory + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(2).find('span').html(); }).attr('selected', 'selected');
            $("#" + ddlCategory + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(1).find('span').html(); }).attr('selected', 'selected');
            /***************Changed By Arivalagan.kk For browser compatability issue****************/
            var EditedRangeval = $('#' + ddlRefRangeType + ' option:contains("' + $row.find("td").eq(0).find('span').html() + '")').val();
            $('#' + ddlRefRangeType).val(EditedRangeval);
            //$("#" + ddlRefRangeType + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(0).find('span').html(); }).attr('selected', 'selected');
            /***************Changed By Arivalagan.kk For browser compatability issue****************/
            //            $('#' + ddlRRSubCategory).val($row.find("td").eq(2).find('span').html());
            //            $('#' + ddlCategory).val($row.find("td").eq(1).find('span').html());            
            var EditedRangeval1 = $('#' + ddlRRSubCategory + ' option:contains("' + $row.find("td").eq(2).find('span').html() + '")').val();
            var EditedRangeval2 = $('#' + ddlCategory + ' option:contains("' + $row.find("td").eq(1).find('span').html() + '")').val();
            $('#' + ddlRRSubCategory).val(EditedRangeval1);
            $('#' + ddlCategory).val(EditedRangeval2);
            $('#divAgeCategory').show();
            $('#trCategoryField').css('height', '100px');
            $('#' + divScrolling).css('height', '300px');
            $('#divGenderOtherCategory').hide();
            $('#divGenderGeneralCategory').hide();
            var bwtValue1 = $row.find("td").eq(3).find('span').html().split(' ');
            if (bwtValue1.length == 3 || bwtValue1.length == 1 || bwtValue1.length > 4) {
                $('#' + ddlOperatorRange1).val('Between');
            }
            else {
                $('#' + ddlOperatorRange1).val(htmlDecode($.trim(bwtValue1[0])));
            }
            if ($('#' + ddlOperatorRange1).val() != 'Between') {
                $('#' + txtAgeRange1).val($.trim(bwtValue1[1]));
                $('#' + txtAgeRange2).val('');
                $('#divAgeBetween').hide();
            }
            else {
                if (bwtValue1.length == 3) {

                    $('#' + txtAgeRange1).val($.trim(bwtValue1[0]));
                    $('#' + txtAgeRange2).val($.trim(bwtValue1[2]));
                    $('#divAgeBetween').hide();
                }
                else if (bwtValue1.length == 1) {
                    var bwtValue = $.trim(bwtValue1[0]).split('-');

                    $('#' + txtAgeRange1).val($.trim(bwtValue[0]));
                    $('#' + txtAgeRange2).val($.trim(bwtValue[1]));
                    $('#divAgeBetween').show();
                }
                else if (bwtValue1.length > 4) {
                $('#' + txtAgeRange1).val($.trim(bwtValue1[0]));
                $('#' + txtAgeRange2).val($.trim(bwtValue1[bwtValue1.length-1]));
                    $('#divAgeBetween').show();
                }
            }
            $("#" + ddlAgeType + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(4).find('span').html(); }).attr('selected', 'selected');
            var EditedRangeval3 = $('#' + ddlAgeType + ' option:contains("' + $row.find("td").eq(4).find('span').html() + '")').val();
            $('#' + ddlAgeType).val(EditedRangeval3);
            // $('#' + ddlAgeType).val($row.find("td").eq(4).find('span').html());
            $('#divAgeValue').show();
            $('#divAgeSource').hide();
            var hdnAgeRange = $row.find("input[id^='hdnAgeRange']").val();
            var lstAge = hdnAgeRange.split('~');
            var value = $row.find("td").eq(6).find('span').html();
            if (lstAge[4] == "Source") {
                $('#' + ddlOperatorRange2).val('Source');
                $('#' + txtAgeSource).val($.trim(value));
                $('#divAgeValue').hide();
                $('#divAgeSource').show();
            }
            else {
                var bwtRValue1 = value.split(' ');
                if (bwtRValue1.length == 1) {
                    $('#' + ddlOperatorRange2).val('Between');
                }
                else {
                    $('#' + ddlOperatorRange2).val(htmlDecode($.trim(bwtRValue1[0])));
                }
                if ($('#' + ddlOperatorRange2).val() != 'Between') {
                    $('#' + txtValueRange1).val($.trim(bwtRValue1[1]));
                    $('#' + txtValueRange2).val('');
                    $('#divValueBetween').hide();
                }
                else {
                    var bwtRValue = $.trim(bwtRValue1[0]).split('-');

                    $('#' + txtValueRange1).val($.trim(bwtRValue[0]));
                    $('#' + txtValueRange2).val($.trim(bwtRValue[1]));
                    $('#divValueBetween').show();

                }
            }
            if ($('#' + ddlRefRangeType).val() == 'resultsinterpretationrange') {
                $('#tdAgeBulkData').show();
                $('#tdAgeResult').show();
                $('#tdAgeDevice').show();
                $('#tdCommonBulkData').show();
                $('#tdCommonResult').show();
                $('#tdCommonDevice').show();
                $('#tdOtherBulkData').show();
                $('#tdOtherResult').show();
                $('#tdOtherDevice').show();
            }
            else {
                $('#tdAgeBulkData').hide();
                $('#tdAgeResult').hide();
                $('#tdAgeDevice').hide();
                $('#tdCommonBulkData').hide();
                $('#tdCommonResult').hide();
                $('#tdCommonDevice').hide();
                $('#tdOtherBulkData').hide();
                $('#tdOtherResult').hide();
                $('#tdOtherDevice').hide();
            }
            if (lstAge[6] != "") {
                $('#' + ddlAgeBulkData).val(htmlDecode(lstAge[6]));
            }
            else {
                $('#' + ddlAgeBulkData + ' option:first').attr('selected', true);
            }
            if (lstAge[7] != "") {
                $('#' + ddlAgeResult).val(lstAge[7]);
            }
            else {
                $('#' + ddlAgeResult + ' option:first').attr('selected', true);
            }
            if (lstAge[8] != "") {
                var device = lstAge[8].replace('^', '');
                $('#' + ddlAgeDevice).val(device);
            }
            else {
                $('#' + ddlAgeDevice + ' option:first').attr('selected', true);
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onEditCommonReferenceRange(obj) {
        try {
            var Usrupdate = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") : "Update";
            onCancelCommonReferenceRange();
            var $row = $(obj).closest('tr');
            var rowIndex = $row.index();
            $('#' + btnAddRRCommon).val(Usrupdate);
            $('#' + hdnSelectedCommonRowIndex).val(rowIndex);
            $("#" + ddlRefRangeType + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(0).find('span').html(); }).attr('selected', 'selected');
            $("#" + ddlRRSubCategory + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(2).find('span').html(); }).attr('selected', 'selected');
            $("#" + ddlCategory + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(1).find('span').html(); }).attr('selected', 'selected');
            //            $('#' + ddlRRSubCategory).val($row.find("td").eq(2).find('span').html());
            //            $('#' + ddlCategory).val($row.find("td").eq(1).find('span').html());
            /***************Changed By Arivalagan.kk For browser compatability issue****************/
            var EditedRangeval = $('#' + ddlRefRangeType + ' option:contains("' + $row.find("td").eq(0).find('span').html() + '")').val();
            $('#' + ddlRefRangeType).val(EditedRangeval);
            /***************Changed By Arivalagan.kk For browser compatability issue****************/
            $('#divGenderGeneralCategory').show();
            $('#divGenderOtherCategory').hide();
            $('#divAgeCategory').hide();
            $('#divCommonValue').show();
            $('#divCommonSource').hide();
            $('#trCategoryField').css('height', '100px');
            $('#' + divScrolling).css('height', '300px');
            var hdnGenderRange = $row.find("input[id^='hdnGenderRange']").val();
            var lstCommon = hdnGenderRange.split('~');
            var value = $row.find("td").eq(6).find('span').html();
            if (lstCommon[1] == "Source") {
                $('#' + ddlGenderValueOpt).val('Source');
                $('#' + txtCommonSource).val($.trim(value));
                $('#divCommonValue').hide();
                $('#divCommonSource').show();
            }
            else {
                var bwtValue1 = value.split(' ');
                if (bwtValue1.length == 1) {
                    $('#' + ddlGenderValueOpt).val('Between');
                }
                else {
                    $('#' + ddlGenderValueOpt).val(htmlDecode($.trim(bwtValue1[0])));
                }
                if ($('#' + ddlGenderValueOpt).val() != 'Between') {
                    $('#' + txtGenderValueStart).val($.trim(bwtValue1[1]));
                    $('#' + txtGenderValueEnd).val('');
                    $('#divGenderValueBetween').hide();
                }
                else {
                    var bwtValue = $.trim(bwtValue1[0]).split('-');
                    $('#' + txtGenderValueStart).val($.trim(bwtValue[0]));
                    $('#' + txtGenderValueEnd).val($.trim(bwtValue[1]));
                    $('#divGenderValueBetween').show();

                }
            }
            if ($('#' + ddlRefRangeType).val() == 'resultsinterpretationrange') {
                $('#tdAgeBulkData').show();
                $('#tdAgeResult').show();
                $('#tdAgeDevice').show();
                $('#tdCommonBulkData').show();
                $('#tdCommonResult').show();
                $('#tdCommonDevice').show();
                $('#tdOtherBulkData').show();
                $('#tdOtherResult').show();
                $('#tdOtherDevice').show();
            }
            else {
                $('#tdAgeBulkData').hide();
                $('#tdAgeResult').hide();
                $('#tdAgeDevice').hide();
                $('#tdCommonBulkData').hide();
                $('#tdCommonResult').hide();
                $('#tdCommonDevice').hide();
                $('#tdOtherBulkData').hide();
                $('#tdOtherResult').hide();
                $('#tdOtherDevice').hide();
            }
            if (lstCommon[3] != "") {
                $('#' + ddlCommonBulkData).val(htmlDecode(lstCommon[3]));
            }
            else {
                $('#' + ddlCommonBulkData + ' option:first').attr('selected', true);
            }
            if (lstCommon[4] != "") {
                $('#' + ddlCommonResult).val(lstCommon[4]);
            }
            else {
                $('#' + ddlCommonResult + ' option:first').attr('selected', true);
            }
            if (lstCommon[5] != "") {
                var device = lstCommon[5].replace('^', '');
                $('#' + ddlCommonDevice).val(device);
            }
            else {
                $('#' + ddlCommonDevice + ' option:first').attr('selected', true);
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onEditOthersReferenceRange(obj) {
        var Usrupdate = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_078") : "Update";
        try {
            onCancelOthersReferenceRange();
            var $row = $(obj).closest('tr');
            var rowIndex = $row.index();
            $('#' + btnAddRROthers).val(Usrupdate);
            $('#' + hdnSelectedOthersRowIndex).val(rowIndex);
           // $('#ddlRefRangeType').val($row.find("td").eq(0).find('span').html()).attr("selected", "selected");
            $("#" + ddlRefRangeType + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(0).find('span').html(); }).attr('selected', 'selected');
            $("#" + ddlRRSubCategory + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(2).find('span').html(); }).attr('selected', 'selected');
            $("#" + ddlCategory + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(1).find('span').html(); }).attr('selected', 'selected');
            //            $('#' + ddlRRSubCategory).val($row.find("td").eq(2).find('span').html());
            //            $('#' + ddlCategory).val($row.find("td").eq(1).find('span').html());
            /***************Changed By Arivalagan.kk For browser compatability issue****************/
            var EditedRangeval = $('#' + ddlRefRangeType + ' option:contains("' + $row.find("td").eq(0).find('span').html() + '")').val();
            $('#' + ddlRefRangeType).val(EditedRangeval);
            var EditedRangeval1 = $('#' + ddlRRSubCategory + ' option:contains("' + $row.find("td").eq(2).find('span').html() + '")').val();
            var EditedRangeval2 = $('#' + ddlCategory + ' option:contains("' + $row.find("td").eq(1).find('span').html() + '")').val();
            $('#' + ddlRefRangeType).val(EditedRangeval);
            $('#' + ddlRRSubCategory).val(EditedRangeval1);
            $('#' + ddlCategory).val(EditedRangeval2);
            //$("#" + ddlRefRangeType + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(0).find('span').html(); }).attr('selected', 'selected');
            /***************Changed By Arivalagan.kk For browser compatability issue****************/
            $("#" + ddlOtherAgeType + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(4).find('span').html(); }).attr('selected', 'selected');
            var ageType = $('#' + ddlOtherAgeType + ' option:contains("' + $row.find("td").eq(4).find('span').html() + '")').val();
            $("#" + ddlOtherAgeOperator + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(3).find('span').html(); }).attr('selected', 'selected');
            var ageRange = $('#' + ddlOtherAgeOperator + ' option:contains("' + $row.find("td").eq(3).find('span').html() + '")').val();
           //var ageType = $row.find("td").eq(4).find('span').html();
            var ageRange = $row.find("td").eq(3).find('span').html();
            if ($.trim(ageType) != '' && $.trim(ageType) != '-') {
                $('#' + ddlOtherAgeType).val(ageType);
            }
            if ($.trim(ageRange) != '' && $.trim(ageRange) != '-') {
                var bwtAgeValue = ageRange.split(' ');
                if (bwtAgeValue.length == 1) {
                    $('#' + ddlOtherAgeOperator).val('Between');
                }
                else {
                    $('#' + ddlOtherAgeOperator).val(htmlDecode($.trim(bwtAgeValue[0])));
                }
                if ($('#' + ddlOtherAgeOperator).val() != 'Between') {
                    $('#' + txtOtherAgeRange1).val($.trim(bwtAgeValue[1]));
                    $('#' + txtOtherAgeRange2).val('');
                    $('#divOtherAgeBetween').hide();
                }
                else {
                    var bwtValue = $.trim(bwtAgeValue[0]).split('-');
                    $('#' + txtOtherAgeRange1).val($.trim(bwtValue[0]));
                    $('#' + txtOtherAgeRange2).val($.trim(bwtValue[1]));
                    $('#divOtherAgeBetween').show();

                }
            }
            $('#divGenderOtherCategory').show();
            $('#divGenderGeneralCategory').hide();
            $('#divAgeCategory').hide();
            $('#trCategoryField').css('height', '100px');
            $('#' + divScrolling).css('height', '300px');
            $('#' + txtGenderOther).val($row.find("td:eq(5)").find('span').html());
            var hdnOtherRange = $row.find("input[id^='hdnOtherRange']").val();
            hdnOtherRange = hdnOtherRange.replace('^', '');
            var lstCommon = hdnOtherRange.split('~');
            ShowResultType(lstCommon[12]);
            var TypeValue = $('#' + hdnTypeValue).val();
            if (TypeValue == 'Numeric') {
                var value = $row.find("td").eq(6).find('span').html();
                //$("#" + ddlOtherRangeOpt + " option").filter(function(index) { return $(this).text() === $row.find("td").eq(6).find('span').html(); }).attr('selected', 'selected');
                //var value = $('#' + ddlOtherRangeOpt + ' option:contains("' + $row.find("td").eq(6).find('span').html() + '")').val();
                if (lstCommon[2] != "Source") {
                    var bwtValue1 = value.split(' ');
                    if (bwtValue1.length == 1) {
                        $('#' + ddlOtherRangeOpt).val('Between');
                    }
                    else {
                        $('#' + ddlOtherRangeOpt).val(htmlDecode($.trim(bwtValue1[0])));
                    }
                    if ($('#' + ddlOtherRangeOpt).val() != 'Between') {
                        $('#' + txtOtherRange1).val($.trim(bwtValue1[1]));
                        $('#' + txtOtherRange2).val('');
                        $('#divOtherValueBetween').hide();
                    }
                    else {
                        var bwtValue = $.trim(bwtValue1[0]).split('-');
                        $('#' + txtOtherRange1).val($.trim(bwtValue[0]));
                        $('#' + txtOtherRange2).val($.trim(bwtValue[1]));
                        $('#divOtherValueBetween').show();
                    }
                }
            }
            else {
                $('#' + txtOtherRange1).val('');
                $('#' + txtOtherRange2).val('');
                $('#divOtherValueBetween').hide();
            }
            var isNormal = $row.find("td:eq(7)").find('span').html();
            var isSourceText = $row.find("td:eq(8)").find('span').html();
            if (isNormal == 'Y') {
                //$('#' + chkNormalValue).attr('checked', true);
                $('input[id=' + chkNormalValue + ']').prop('checked', true);
            }
            else {
                //$('#' + chkNormalValue).attr('checked', false);
                $('input[id=' + chkNormalValue + ']').prop('checked', false);
            }
            if (isSourceText == 'Y') {
                // $('#' + chkIsSourceText).attr('checked', true);
                $('input[id=' + chkIsSourceText + ']').prop('checked', true);
            }
            else {
                //$('#' + chkIsSourceText).attr('checked', false);
                $('input[id=' + chkIsSourceText + ']').prop('checked', false);
            }
            if ($('#' + ddlRefRangeType).val() == 'resultsinterpretationrange') {
                $('#tdAgeBulkData').show();
                $('#tdAgeResult').show();
                $('#tdAgeDevice').show();
                $('#tdCommonBulkData').show();
                $('#tdCommonResult').show();
                $('#tdCommonDevice').show();
                $('#tdOtherBulkData').show();
                $('#tdOtherResult').show();
                $('#tdOtherDevice').show();
            }
            else {
                $('#tdAgeBulkData').hide();
                $('#tdAgeResult').hide();
                $('#tdAgeDevice').hide();
                $('#tdCommonBulkData').hide();
                $('#tdCommonResult').hide();
                $('#tdCommonDevice').hide();
                $('#tdOtherBulkData').hide();
                $('#tdOtherResult').hide();
                $('#tdOtherDevice').hide();
            }
            if (lstCommon[9] != "") {
                $('#' + ddlOtherBulkData).val(htmlDecode(lstCommon[9]));
            }
            else {
                $('#' + ddlOtherBulkData + ' option:first').attr('selected', true);
            }
            if (lstCommon[10] != "") {
                $('#' + ddlOtherResult).val(lstCommon[10]);
            }
            else {
                $('#' + ddlOtherResult + ' option:first').attr('selected', true);
            }
            if (lstCommon[11] != "") {
                var device = lstCommon[11].replace('^', '');
                $('#' + ddlOtherDevice).val(device);
            }
            else {
                $('#' + ddlOtherDevice + ' option:first').attr('selected', true);
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteAgeReferenceRange(obj) {
        try {
            $(obj).closest('tr').remove();

        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteCommonReferenceRange(obj) {
        try {
            $(obj).closest('tr').remove();
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteOtherReferenceRange(obj) {
        try {
            $(obj).closest('tr').remove();
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteRefMapping(obj) {
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_07") : "Unable to delete";
        try {
            $(obj).closest('tr').hide();
            var $row = $(obj).closest('tr');
            var refRnge = $(obj).closest('tr').find('td')[3];
            $(refRnge).find('span').html('');
            var hdnSelInvRefMappingID = $row.find("input[id$='hdnInvRefMappingID']").val();
            var hdnSelDeviceMappingID = $row.find("input[id$='hdnDeviceMappingID']").val();
            var lblRRString = $row.find($('input[id$="lblRRString"]'));
            $(lblRRString).val('');
            if (hdnSelInvRefMappingID == '' || hdnSelInvRefMappingID == '0') {
                hdnSelInvRefMappingID = -1;
            }
            if (hdnSelDeviceMappingID == '') {
                hdnSelDeviceMappingID = '0';
            }
            var invID = $('#' + hdnInvID).val();
            var orgID = $('#' + hdnOrgID).val();
            document.getElementById("<%= hdnDelSelInvRefMappingID.ClientID %>").value = hdnSelInvRefMappingID;
            document.getElementById("<%= hdnDelSelDeviceMappingID.ClientID %>").value = hdnSelDeviceMappingID;
            document.getElementById("<%= hdnInvID.ClientID %>").value = invID;
            
//            $.ajax({
//                type: "POST",
//                url: "../WebService.asmx/DeleteInvOrgRefMapping",
//                data: "{InvRefMappingID: " + hdnSelInvRefMappingID + ",DeviceMappingID: " + hdnSelDeviceMappingID + ",InvID: " + invID + ",OrgID: " + orgID + "}",
//                contentType: "application/json; charset=utf-8",
//                dataType: "json",
//                success: function Success(data) {
//                    $(obj).closest('tr').remove();
//                },
//                error: function(xhr, ajaxOptions, thrownError) {
//                    //alert("Unable to delete");
//                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
//                }
//            });
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function extractNumber(obj, decimalPlaces, allowNegative) {
        var temp = obj.value;

        // avoid changing things if already formatted correctly
        var reg0Str = '[0-9]*';
        if (decimalPlaces > 0) {
            reg0Str += '\\.?[0-9]{0,' + decimalPlaces + '}';
        } else if (decimalPlaces < 0) {
            reg0Str += '\\.?[0-9]*';
        }
        reg0Str = allowNegative ? '^-?' + reg0Str : '^' + reg0Str;
        reg0Str = reg0Str + '$';
        var reg0 = new RegExp(reg0Str);
        if (reg0.test(temp)) return true;

        // first replace all non numbers
        var reg1Str = '[^0-9' + (decimalPlaces != 0 ? '.' : '') + (allowNegative ? '-' : '') + ']';
        var reg1 = new RegExp(reg1Str, 'g');
        temp = temp.replace(reg1, '');

        if (allowNegative) {
            // replace extra negative
            var hasNegative = temp.length > 0 && temp.charAt(0) == '-';
            var reg2 = /-/g;
            temp = temp.replace(reg2, '');
            if (hasNegative) temp = '-' + temp;
        }

        if (decimalPlaces != 0) {
            var reg3 = /\./g;
            var reg3Array = reg3.exec(temp);
            if (reg3Array != null) {
                // keep only first occurrence of .
                //  and the number of places specified by decimalPlaces or the entire string if decimalPlaces < 0
                var reg3Right = temp.substring(reg3Array.index + reg3Array[0].length);
                reg3Right = reg3Right.replace(reg3, '');
                reg3Right = decimalPlaces > 0 ? reg3Right.substring(0, decimalPlaces) : reg3Right;
                temp = temp.substring(0, reg3Array.index) + '.' + reg3Right;
            }
        }

        obj.value = temp;
    }
    function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
        var key;
        var isCtrl = false;
        var keychar;
        var reg;

        if (window.event) {
            key = e.keyCode;
            isCtrl = window.event.ctrlKey
        }
        else if (e.which) {
            key = e.which;
            isCtrl = e.ctrlKey;
        }

        if (isNaN(key)) return true;

        keychar = String.fromCharCode(key);

        // check for backspace or delete, or if Ctrl was pressed
        if (key == 8 || isCtrl) {
            return true;
        }

        reg = /\d/;
        var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
        var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

        return isFirstN || isFirstD || reg.test(keychar);
    }

    function ShowResultType(ResultType) {
        if (ResultType == 'Numeric') {
            document.getElementById(hdnTypeValue).value = ResultType;
            document.getElementById('tblNumericValue').style.display = 'table';
            document.getElementById(ddlOtherRangeOpt).style.display = 'block';
            $('#' + hdnOtherReferenceRangeAdd).val('');
        }
        else {
            document.getElementById(hdnTypeValue).value = ResultType;
            document.getElementById('tblNumericValue').style.display = 'none';
            document.getElementById(ddlOtherRangeOpt).style.display = 'none';
            $('#' + hdnOtherReferenceRangeAdd).val('');
        }
        var selectedRefRangeType = $('#' + ddlRefRangeType + ' option:selected');
        if ($(selectedRefRangeType).val() == 'panicrange') {
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

    function changeLayout(layout) {
        try {
            $('#' + hdnSelectedLayout).val(layout);
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
    //    function ShowRemarkPopup() {
    //    debugger;
    //        $('#divModalAddRemarks').show();
    //    }
    function SelectedRemarkID(Source, eventArgs) {

        var RemarkCode = eventArgs.get_value().split('~');
        var contents = $("#<%= txttext.ClientID %>").val();
        $("#<%= txttextRemark.ClientID %>").val(contents);
        $("#<%= txtRCode.ClientID %>").val(RemarkCode[1]);

        try {
            $('input[id$="hdnSelectedRemarksID1"]').val(RemarkCode[0]);
            $('#' + hdnRemarksContent).val(eventArgs.get_text());
        }
        catch (e) {
            return false;
        }
    }
    function Hide() {
        $('#' + ddlRtype + '').val('0');
        document.getElementById("<%=txttextRemark.ClientID %>").value = ""
        document.getElementById("<%=txttext.ClientID %>").value = ""
        document.getElementById("<%=txtRCode.ClientID %>").value = ""
    }
</script>

<asp:Panel ID="pnlTestMaster" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlTestMasterResource1">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table class="w-100p">
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td align="center" colspan="8">
                                    <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"
                                        CssClass="padding5 bold TM-lblMessage"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <table class="w-100p">
                                        <tr>
                                            <td style="width: 116px;">
                                                <asp:Label ID="lblCode" Text="Name / Code" runat="server" meta:resourcekey="lblCodeResource1"></asp:Label>
                                            </td>
                                            <td style="width: 350px;">
                                                <asp:TextBox ID="txtTestCodeScheme" runat="server" MaxLength="50" Width="330px" CssClass="searchBox"
                                                    meta:resourcekey="txtTestCodeSchemeResource1" TabIndex="1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="ACETestCodeScheme" runat="server" TargetControlID="txtTestCodeScheme"
                                                    EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box mediumList"
                                                    CompletionListItemCssClass="wordWheel itemsMain mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                                    ServiceMethod="GetTestCodingScheme" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                    DelimiterCharacters=":" Enabled="True" OnClientItemSelected="SelectedTestCodeScheme"
                                                    OnClientPopulated="TestCodeSchemePopulated">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td class="a-left">
                                                <asp:Button ID="btnLoadTestDetails" runat="server" Text="&nbsp;&nbsp;&nbsp;Load&nbsp;&nbsp;&nbsp;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    meta:resourcekey="btnLoadTestDetailsResource1" OnClick="btnLoadTestDetails_Click"
                                                    OnClientClick="javascript:return onLoadRefMapping();" TabIndex="2" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 125px;">
                                    <asp:Label ID="lblName" Text="Name" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                </td>
                                <td style="width: 220px;">
                                    <asp:TextBox ID="txtName" runat="server" MaxLength="50" Width="170px" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtNameResource1" ReadOnly="True" Enabled="False"></asp:TextBox>
                                </td>
                                <td style="width: 125px;">
                                    <asp:Label ID="lblDisplayText" Text="Display Text" runat="server" meta:resourcekey="lblDisplayTextResource1"></asp:Label>
                                </td>
                                <td style="width: 220px;">
                                    <asp:TextBox ID="txtDisplayText" runat="server" MaxLength="100" Width="170px" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtDisplayTextResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td style="width: 125px;">
                                    <asp:Label ID="lblDeptName" Text="Department" runat="server" meta:resourcekey="lblDeptNameResource1"></asp:Label>
                                </td>
                                <td style="width: 220px;">
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlDept" CssClass="ddl">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                                <td style="width: 125px;">
                                    <asp:Label ID="Label1" Text="Dept Header" runat="server" meta:resourcekey="lblHeaderNameResource1"></asp:Label>
                                </td>
                                <td style="width: 220px;">
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlHeader" CssClass="ddl">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 125px;">
                                    <asp:Label ID="lblBillingName" Text="BillingName" runat="server" meta:resourcekey="lblBillingNameResource1"></asp:Label>
                                </td>
                                <td style="width: 220px;">
                                    <asp:TextBox ID="txtBillingName" runat="server" MaxLength="100" Width="170px" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtBillingNameResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td>
                                    <asp:Label ID="lblResultValue" Text="Result Value" runat="server" meta:resourcekey="lblResultValueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" Width="175px" ID="ddlResultValue" CssClass="ddl">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblTestSample" Text="Sample" runat="server" meta:resourcekey="lblSampleResource1"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlSample" CssClass="ddl">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                                <td>
                                    <asp:Label ID="lblAdditive" Text="Additive" runat="server" meta:resourcekey="lblAdditiveResource1"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlAdditive" CssClass="ddl">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMethod" Text="Method" runat="server" meta:resourcekey="lblMethodResource1"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlMethod" CssClass="ddl">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                                <td>
                                    <asp:Label ID="lblPrinciple" Text="Principle" runat="server" meta:resourcekey="lblPrincipleResource1"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlPrinciple" CssClass="ddl">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                                <td>
                                    <asp:Label ID="lblGender1" Text="Gender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="ddlsmall" Width="175px">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblSampleCondition1" Text="Pre Analytical Condition" runat="server"
                                        meta:resourcekey="lblSampleConditionResource1"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlPreSampleCondition" CssClass="ddl"
                                            meta:resourcekey="ddlSampleCondition1">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSampleCondition2" Text="Post Analytical Condition" runat="server"
                                        meta:resourcekey="lblSampleConditionResource2"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 175px;">
                                        <asp:DropDownList runat="server" Width="175px" ID="ddlPostSampleCondition" CssClass="ddl"
                                            meta:resourcekey="ddlSampleCondition2">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                                <td style="width: 125px;">
                                    <asp:Label ID="Label14" Text="Output Investigation Code" runat="server" meta:resourcekey="lbloutputcodeResource1"></asp:Label>
                                </td>
                                <td style="width: 220px;">
                                    <asp:TextBox ID="txtOutputCode" runat="server" MaxLength="10" Width="170px" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtOutputCodeResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="w-25p">
                                                <asp:Label ID="lblNonOrderable" Text="Non Orderable" runat="server" meta:resourcekey="lblNonOrderableResource1"></asp:Label>
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:CheckBox ID="chkNonOrderable" runat="server" meta:resourcekey="chkNonOrderableResource1" />
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:Label ID="lblIsActive" Text="Active" runat="server" meta:resourcekey="lblIsActiveResource1"></asp:Label>
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:CheckBox ID="chkIsActive" Checked="True" runat="server" meta:resourcekey="chkIsActiveResource1" />
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:Label ID="lblSynoptic" Text="Is Synoptic" runat="server" meta:resourcekey="lblSynoptic"></asp:Label>
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:CheckBox ID="ChkSynoptic" onchange="return ChangeSynoptic();" runat="server"
                                                    meta:resourcekey="ChkSynoptic" />
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:Label ID="lblIsFieldTest" Text="Field Test" runat="server" meta:resourcekey="lblIsFieldTestResource1"></asp:Label>
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:CheckBox ID="chkIsFieldTest" Checked="False" runat="server" meta:resourcekey="chkIsFieldTestResource1" />
                                            </td>
                                            <td class="w-25p">
                                                <asp:Label ID="lblIsSensitivetest" Text="Sensitive Test" runat="server" meta:resourcekey="lblNonOrderableResource11"></asp:Label>
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:CheckBox ID="ChkIsSensitivetest" runat="server" meta:resourcekey="chkNonOrderableResource1" />
                                            </td>
                                             <td class="w-25p">
                                                <asp:Label ID="Label15" Text="DeltaCheck" runat="server" meta:resourcekey="lblchkDeltaCheckResource11"></asp:Label>
                                            </td>
                                            <td class="w-20p a-center">
                                                <asp:CheckBox ID="chkDeltaCheck" runat="server" meta:resourcekey="chkDeltaCheckResource1" />
                                            </td>
                                            <td class="w-25p" style="display: none;">
                                                <asp:Label ID="Label16" Text="AutoCertification" runat="server" meta:resourcekey="lblchkAutoCertification"></asp:Label>
                                            </td>
                                            <td class="w-20p a-center"  style="display: none;">
                                                <asp:CheckBox ID="chkAutoCertification"  runat="server" meta:resourcekey="chkAutoCertification1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="v-top">
                                    <ajc:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" meta:resourcekey="TabContainer1Resource1">
                                        <ajc:TabPanel runat="server" HeaderText="General" ID="TabGeneral" meta:resourcekey="TabGeneralResource1"
                                            CssClass="dataheadergroup">
                                            <ContentTemplate>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblTestCategory" Text="Discount Category" runat="server" meta:resourcekey="lblTeCategoryResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <span class="richcombobox" style="width: 175px;">
                                                                <asp:DropDownList runat="server" Width="175px" ID="ddlTestCategory" CssClass="ddl">
                                                                </asp:DropDownList>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblClassification" Text="Classification" runat="server" meta:resourcekey="lblClassificationResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <span class="richcombobox" style="width: 175px;">
                                                                <asp:DropDownList runat="server" Width="175px" ID="ddlClassification" CssClass="ddl">
                                                                </asp:DropDownList>
                                                            </span>
                                                        </td>
                                                        <td colspan="2">
                                                            <fieldset>
                                                                <table class="w-100p bg-row">
                                                                    <tr class="colorforcontent">
                                                                        <td colspan="3" class="w-100p">
                                                                            <p>
                                                                                <%--Critical Results Call-Out--%>
                                                                                <%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_026 %>
                                                                            </p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:CheckBox ID="chkEmail" runat="server" meta:resourcekey="chkEmailResource1" />
                                                                            <asp:Label ID="labelEmail" runat="server" Text="Email" meta:resourcekey="labelEmailResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <span class="richcombobox" style="width: 75px;">
                                                                                <asp:DropDownList ID="drpEmailTemplate" runat="server" CssClass="ddl" Width="75px">
                                                                                </asp:DropDownList>
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBoxList ID="checklstDomain" runat="server" RepeatDirection="Horizontal"
                                                                                RepeatColumns="2" meta:resourcekey="checklstDomainResource1">
                                                                            </asp:CheckBoxList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:CheckBox ID="CheckSMS" runat="server" meta:resourcekey="CheckSMSResource1" />
                                                                            <asp:Label ID="labelSms" runat="server" Text="SMS" meta:resourcekey="labelSmsResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <span class="richcombobox" style="width: 75px;">
                                                                                <asp:DropDownList ID="drpSmsTemplate" runat="server" CssClass="ddl" Width="75px">
                                                                                </asp:DropDownList>
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBoxList ID="checklstDomain1" runat="server" RepeatDirection="Horizontal"
                                                                                RepeatColumns="2" meta:resourcekey="checklstDomain1Resource1">
                                                                            </asp:CheckBoxList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblScheduleType" runat="server" Text="TAT Schedule Type" meta:resourcekey="lblScheduleTypeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlScheduleType" runat="server" CssClass="ddl">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCutOffTime" Text="Processing Time" runat="server" meta:resourcekey="lblCutOffTimeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCOTValue" runat="server" MaxLength="3" Width="50px" CssClass="Txtboxsmall"
                                                                            meta:resourcekey="txtCOTValueResource1" onkeypress="return ValidateSpecialAndNumeric(this);"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;&nbsp;<asp:DropDownList runat="server" Width="110px" ID="ddlCOTType" CssClass="ddl" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="width: 115px;">
                                                            <asp:Label ID="lblprotocalgroup" Text="Protocal Group" runat="server" meta:resourcekey="lblprotocalgroupResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 220px;">
                                                            <span class="richcombobox" style="width: 175px;">
                                                                <asp:DropDownList runat="server" Width="175px" ID="ddlprotocalgroup" CssClass="ddl">
                                                                </asp:DropDownList>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblCostPerTest" Text="Cost Per Test" runat="server" meta:resourcekey="lblCostPerTestResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtCostPerTest" runat="server" MaxLength="15" Width="100px" CssClass="Txtboxsmall"
                                                                onblur="extractNumber(this,-1,false);" onkeyup="extractNumber(this,-1,false);"
                                                                onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtCostPerTestResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDecimalPlace" Text="Decimal Places" runat="server" meta:resourcekey="lblDecimalPlaceResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtDecimalPlace" runat="server" MaxLength="1" Width="50px" CssClass="Txtboxsmall"
                                                                meta:resourcekey="txtDecimalPlaceesource1" autocomplete="off" onkeypress="return ValidateSpecialAndNumeric(this);"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblCostPerReportableTest" Text="Cost Per Reportable Test" runat="server"
                                                                meta:resourcekey="lblCostPerReportableTestResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtCostPerReportableTest" runat="server" MaxLength="15" Width="100px"
                                                                CssClass="Txtboxsmall" onblur="extractNumber(this,-1,false);" onkeyup="extractNumber(this,-1,false);"
                                                                onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtCostPerReportableTestResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPrintSeparately" Text="Print Separately" runat="server" meta:resourcekey="lblPrintSeparatelyResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkPrintSeparately" runat="server" meta:resourcekey="chkPrintSeparatelyResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblMachineInterface" Text="Machine Interface" runat="server" meta:resourcekey="lblMachineInterfaceResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkMachineInterface" runat="server" meta:resourcekey="chkMachineInterfaceResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblRepeatable" Text="Repeatable" runat="server" meta:resourcekey="lblRepeatableResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkRepeatable" runat="server" meta:resourcekey="chkRepeatableResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDiscountable" Text="Discountable" runat="server" meta:resourcekey="lblDiscountableResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkDiscountable" runat="server" meta:resourcekey="chkDiscountableResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblServiceTax" Text="Service Tax" runat="server" meta:resourcekey="lblServiceTaxResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkServiceTax" runat="server" meta:resourcekey="chkServiceTaxResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblNABL" Text="NABL" runat="server" meta:resourcekey="lblNABLResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkNABL" runat="server" meta:resourcekey="chkNABLResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCAP" Text="CAP" runat="server" meta:resourcekey="lblCAPResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkCAP" runat="server" meta:resourcekey="chkCAPResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSTAT" Text="STAT" runat="server" meta:resourcekey="lblSTATResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkSTAT" runat="server" meta:resourcekey="chkSTATResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblQCData" Text="QC Data" runat="server" meta:resourcekey="lblQCDataResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkQCData" runat="server" meta:resourcekey="chkQCDataResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblNonReportable" Text="Non-Reportable" runat="server" meta:resourcekey="lblNonReportableResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkNonReportable" runat="server" meta:resourcekey="chkNonReportableResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSMS" Text="SMS" runat="server" meta:resourcekey="lblSMSResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkSMS" runat="server" meta:resourcekey="chkSMSResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                        <ajc:TabPanel runat="server" HeaderText="Codes" ID="TabCodes" meta:resourcekey="TabCodesResource1"
                                            CssClass="dataheadergroup">
                                            <ContentTemplate>
                                                <div class="mytable1 w-50p" style="overflow: auto; height: 220px;">
                                                    <table id="tblCodeSchema" class="w-100p gridView">
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
                                                            <asp:Repeater ID="rptCodeSchema" runat="server" OnItemDataBound="rptCodeSchema_ItemDataBound">
                                                                <ItemTemplate>
                                                                    <tr class="h-17">
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblCodeSchemeName" runat="server" Text='<%# Bind("CodingSchemaName") %>'
                                                                                meta:resourcekey="lblCodeSchemeNameResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblCodeName" runat="server" Text='<%# Bind("CodeName") %>' meta:resourcekey="lblCodeNameResource2"></asp:Label>
                                                                        </td>
                                                                        <td class="a-left">
                                                                            <asp:Label ID="lblIsPrimary" runat="server" Text='<%# Bind("IsPrimary") %>' meta:resourcekey="lblIsPrimaryResource2"></asp:Label>
                                                                            <asp:HiddenField ID="hdnisprimary" runat="server" Value='<%# Eval("IsPrimary") %>' />
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
                                                <table class="w-100p a-center">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblSelectLayout" runat="server" Text="Select Your Layout" CssClass="colorforcontent padding5"
                                                                meta:resourcekey="lblSelectLayoutResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div class="divlayout">
                                                    <input id="layout1" class="inputlayout" type="radio" checked="checked" value="" name="layout"
                                                        onclick="changeLayout('layout1');"></input>
                                                    <label class="labellayout l1img" for="layout1">
                                                        <%--Layout 1--%>
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_027 %>
                                                    </label>
                                                </div>
                                                <div class="divlayout">
                                                    <input id="layout2" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout2');"></input>
                                                    <label class="labellayout l2img" for="layout2">
                                                        <%--  Layout 2--%>
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_028 %>
                                                    </label>
                                                </div>
                                                <div class="divlayout">
                                                    <input id="layout3" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout3');"></input>
                                                    <label class="labellayout l3img" for="layout3">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_029 %>
                                                    </label>
                                                </div>
                                                <div class="divlayout">
                                                    <input id="layout4" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout4');"></input>
                                                    <label class="labellayout l4img" for="layout4">
                                                        <%--Layout 4--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_030 %>
                                                    </label>
                                                </div>
                                                <div class="divlayout">
                                                    <input id="layout5" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout5');"></input>
                                                    <label class="labellayout l5img" for="layout5">
                                                        <%-- Layout 5--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_031 %>
                                                    </label>
                                                </div>
                                                <div class="divlayout">
                                                    <input id="layout6" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout6');"></input>
                                                    <label class="labellayout l6img" for="layout6">
                                                        <%-- Layout 6--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_032 %>
                                                    </label>
                                                </div>
                                                <div class="divlayout">
                                                    <input id="layout7" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout7');"></input>
                                                    <label class="labellayout l7img" for="layout7">
                                                        <%-- Layout 7--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_033 %>
                                                    </label>
                                                </div>
                                                <div class="divlayout">
                                                    <input id="layout8" class="inputlayout" type="radio" value="" name="layout" onclick="changeLayout('layout8');"></input>
                                                    <label class="labellayout l8img" for="layout8">
                                                        <%-- Layout 8--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_034 %>
                                                    </label>
                                                </div>
                                                <table class="w-100p a-center" style="display: none;">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnAddTextArea" Text="Paragraph Text" runat="server" OnClientClick="showText();"
                                                                meta:resourcekey="btnAddTextAreaResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnAddTable" Text="Table" runat="server" OnClientClick="showHandsonTableData();"
                                                                meta:resourcekey="btnAddTableResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table class="w-100p a-center">
                                                    <tr>
                                                        <td>
                                                            <div id="divFCKeditor1" class="padding7">
                                                                <FTB:FreeTextBox ID="FCKeditor1" Width="100%" runat="server" Height="200px">
                                                                </FTB:FreeTextBox>
                                                                <%-- <FCKeditorV2:FCKeditor ID="FCKeditor1" Width="100%" runat="server" Height="200px" />--%>
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
                                                            <div id="divFCKeditor2" class="padding7" style="display: none;">
                                                                <FTB:FreeTextBox ID="FCKeditor2" Width="100%" runat="server" Height="200px">
                                                                </FTB:FreeTextBox>
                                                                <%--   <FCKeditorV2:FCKeditor ID="FCKeditor2" Width="100%" runat="server" Height="200px" />--%>
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
                                                                <FTB:FreeTextBox ID="FCKeditor3" Width="100%" runat="server" Height="200px">
                                                                </FTB:FreeTextBox>
                                                                <%-- <FCKeditorV2:FCKeditor ID="FCKeditor3" Width="100%" runat="server" Height="200px" />--%>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                        <ajc:TabPanel runat="server" HeaderText="Remarks" ID="TabNotesNRemarks" meta:resourcekey="TabNotesNRemarksResource1"
                                            CssClass="dataheadergroup">
                                            <ContentTemplate>
                                                <table class="w-100p a-center">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblRemarksType" Text="Type" runat="server" meta:resourcekey="lblRemarksTypeResource1"></asp:Label>
                                                            &nbsp;&nbsp;
                                                            <asp:DropDownList runat="server" Width="100px" ID="ddlRemarksType" CssClass="ddl"
                                                                meta:resourcekey="ddlRemarksTypeResource1" onchange="return onChangeRemarksType();">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblRemarksText" Text="Text" runat="server" meta:resourcekey="lblRemarksTextResource1"></asp:Label>&nbsp;
                                                            <asp:TextBox ID="txtRemarks" runat="server" MaxLength="50" Width="500px" CssClass="searchBox"
                                                                meta:resourcekey="txtRemarksResource1" TabIndex="1" onfocus="return onFocusRemarks();"></asp:TextBox>
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
                                                                OnClientClick="return AddRemarks()" Enabled="False" meta:resourcekey="btnAddRemarksResource1" />
                                                            <asp:Button ID="Button1" runat="server" Text="Add NewRemarks" Style="background-color: Transparent;
                                                                color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                font-size: 11px;" meta:resourcekey="btnAddNewRemarksResource1" OnClientClick="return ShowRemarkPopup();" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div class="mytable1" style="overflow: auto; height: 200px">
                                                                <table id="tblRemarks" class="w-98p">
                                                                    <thead>
                                                                        <tr class="dataheader1 h-17">
                                                                            <th>
                                                                                <asp:Label runat="server" ID="thRemarks" Text="Text" meta:resourcekey="thRemarksResource1" />
                                                                            </th>
                                                                            <th class="w-15p">
                                                                                <asp:Label runat="server" ID="thRemarksType" Text="Type" meta:resourcekey="thRemarksTypeResource1" />
                                                                            </th>
                                                                            <th class="w-5p a-center">
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
                                                                                        <asp:HiddenField ID="hdnRemarksID" runat="server" Value='<%# Eval("RemarksID") %>'
                                                                                            meta:resourcekey="hdnRemarksIDResource2" />
                                                                                        <asp:Label ID="lblRemarksType" runat="server" meta:resourcekey="lblRemarksTypeResource2"
                                                                                            Text='<%# Eval("RemarksType") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-center">
                                                                                        <asp:Button ID="btnRemarks" runat="server" Text="Delete" Style="background-color: Transparent;
                                                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                            font-size: 11px;" OnClientClick="onRemarksDelete(this);" meta:resourcekey="btnRemarksResource1" />
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
                                        <ajc:TabPanel runat="server" HeaderText="Range Mapping" ID="TabRangeMapping" meta:resourcekey="TabRangeMappingResource1"
                                            CssClass="dataheadergroup">
                                            <ContentTemplate>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblClientID" Text="Select Client" runat="server" meta:resourcekey="lblClientResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <span class="richcombobox">
                                                                <asp:TextBox ID="txtClient" runat="server" autocomplete="off" Width="125px" CssClass="AutoCompletesearchBox"
                                                                    meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClient"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                                    OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                    Enabled="True">
                                                                </ajc:AutoCompleteExtender>
                                                                <asp:HiddenField ID="hdnSelectedClientID" Value="0" runat="server" />
                                                                <%--   <asp:DropDownList runat="server" Width="175px" ID="ddlClient" CssClass="ddl" meta:resourcekey="ddlClientResource1">
                                                    </asp:DropDownList>--%>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDevice" Text="Select Device" runat="server" meta:resourcekey="lblDeviceResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList runat="server" Width="175px" ID="ddlInstrument" CssClass="ddl">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <%--<td style="width: 130px;">
                                                    <asp:Label ID="lblKit" Text="Select Kit" runat="server" meta:resourcekey="lblKitResource1"></asp:Label>
                                                </td>
                                                <td style="width: 225px;">
                                                    <span class="richcombobox" style="width: 175px;">
                                                        <asp:DropDownList runat="server" Width="175px" ID="ddlKit" CssClass="ddl" meta:resourcekey="ddlKitResource1">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>--%>
                                                        <td>
                                                            <asp:Label ID="lblUOM" Text="UOM" runat="server" meta:resourcekey="lblUOMResource1"></asp:Label>
                                                        </td>
                                                        <td class="v-middle">
                                                            <asp:TextBox ID="txtUOM" runat="server" MaxLength="50" Width="100px" CssClass="Txtboxsmall"
                                                                meta:resourcekey="txtUOMResource1"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnUOMID" runat="server" />
                                                            <asp:HyperLink ID="hypLnkUOM" runat="server" ToolTip="Click here to Change Unit Of Measurment"
                                                                ImageUrl="~/Images/datachooser.png" onmouseover="this.style.cursor='pointer';"
                                                                onclick="javascript:setUOM(id);" meta:resourcekey="hypLnkUOMResource1" />
                                                            <button id="btnAddUOM" runat="server" class="btn" onclick="return AddUOM();" meta:resourcekey="btnAddUOMResource1">
                                                                <%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_046 %></button>
                                                        </td>
                                                    </tr>
                                                    <tr id="trConvUOMFactor" runat="server" style="display: none;">
                                                        <td runat="server">
                                                            <asp:Label ID="lblConvUom" runat="server" Text="ConvUOM" meta:resourcekey="lblConvUomResource1"></asp:Label>
                                                        </td>
                                                        <td runat="server">
                                                            <asp:TextBox ID="txtConvUom" runat="server" Width="100px" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnConvUOMID" runat="server" />
                                                            <asp:HyperLink ID="hypLnkConvUOM" runat="server" ToolTip="Click here to Change Unit Of Measurment"
                                                                ImageUrl="~/Images/datachooser.png" onmouseover="this.style.cursor='pointer';"
                                                                onclick="javascript:setUOM(id);" />
                                                        </td>
                                                        <td runat="server">
                                                            <asp:Label ID="lblConvFactor" runat="server" Text="ConvFactorValue" meta:resourcekey="lblConvFactorResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtConvFactor" runat="server" Width="100px" CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblConvDecimal" runat="server" Text="ConvDecimalPoint" meta:resourcekey="lblConvDecimalResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtConvDecimal" runat="server" Width="100px" CssClass="Txtboxsmall"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <%--<td>
                                                    <asp:Label ID="lblTestCode" Text="Test Code" runat="server" meta:resourcekey="lblTestCodeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTestCode" runat="server" MaxLength="100" Width="170px" CssClass="Txtboxsmall"
                                                        meta:resourcekey="txtTestCodeResource1"></asp:TextBox>
                                                </td>--%>
                                                        <td>
                                                            <asp:Label ID="lblPrimary" Text="Primary" runat="server" meta:resourcekey="lblPrimaryResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkPrimary" runat="server" meta:resourcekey="chkPrimaryResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblRefMappingActive" Text="Active" runat="server" meta:resourcekey="lblRefMappingActiveResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkRefMappingActive" Checked="True" runat="server" meta:resourcekey="chkRefMappingActiveResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblReferenceRange" Text="Ranges" runat="server" meta:resourcekey="lblReferenceRangeResource1"></asp:Label>
                                                        </td>
                                                        <td rowspan="3">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtReferenceRange" runat="server" TextMode="MultiLine" Width="180px"
                                                                            Height="80px" CssClass="Txtboxsmall" meta:resourcekey="txtReferenceRangeResource1"
                                                                            onfocus="return onFocusReferenceRange();" onblur="return onBlurReferenceRange();"></asp:TextBox>
                                                                        <br />
                                                                        <asp:TextBox ID="txtROReferenceRange" Style="display: none; width: 180px; height: 80px;"
                                                                            ReadOnly="True" runat="server" TextMode="MultiLine" Width="180px" Height="80px"
                                                                            meta:resourcekey="txtROReferenceRangeResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td class="v-bottom a-left">
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Button ID="btnChangeRefRange" runat="server" Text="Change" Style="background-color: Transparent;
                                                                                        color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                        font-size: 11px;" meta:resourcekey="btnChangeRefRangeResource1" OnClientClick="return ShowRefRangePopup();" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    &nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Button ID="btnClearRefRange" runat="server" Text="Clear" Style="background-color: Transparent;
                                                                                        color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                        font-size: 11px;" meta:resourcekey="btnClearRefRangeResource1" OnClientClick="return ClearRefRangeValue();" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <p id="divReferenceRangeHint" style="margin: 2px 0 5px 0; font-size: 11px; color: #666;
                                                                            display: none; width: 200px;">
                                                                            <asp:Label ID="lblReferenceRangeHint" runat="server" Text="This reference range is formed as xml, if you want to edit use change link"
                                                                                meta:resourcekey="lblReferenceRangeHintResource1" />
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div id="divReason" style="display: none;">
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td class="w-80">
                                                                            <asp:Label ID="lblReason" Text="Reason" runat="server" meta:resourcekey="lblReasonResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" Width="175px" ID="ddlReason" CssClass="ddl">
                                                                            </asp:DropDownList>
                                                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td colspan="4">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" class="a-center">
                                                            <asp:Button ID="btnAddRefMapping" Style="cursor: pointer;" runat="server" Text="Add"
                                                                class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                meta:resourcekey="btnAddRefMappingResource1" OnClientClick="return onSaveRefMapping();" />
                                                            <asp:Button ID="btnCancelRefMapping" Style="cursor: pointer;" runat="server" Text="Cancel"
                                                                class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                meta:resourcekey="btnCancelRefMappingResource1" OnClientClick="return onCancelRefMapping();" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            <div class="mytable1" style="overflow: auto; height: 200px">
                                                                <table id="tblInvRefMapping" class="w-98p gridView">
                                                                    <thead>
                                                                        <tr class="dataheader1 h-17">
                                                                            <th>
                                                                                <asp:Label runat="server" ID="thInstrumentName" Text="Device" meta:resourcekey="thInstrumentNameResource1" />
                                                                            </th>
                                                                            <%--<th>
                                                                    <asp:Label runat="server" ID="thKitName" Visible="false"  Text="Kit" meta:resourcekey="thKitNameResource1" />
                                                                </th>--%>
                                                                            <th>
                                                                                <asp:Label runat="server" ID="thUOM" Text="UOM" meta:resourcekey="thUOMResource1" />
                                                                            </th>
                                                                            <%--<th>
                                                                    <asp:Label runat="server" ID="thTestCode" Text="Test Code" meta:resourcekey="thTestCodeResource1" />
                                                                </th>--%>
                                                                            <th>
                                                                                <asp:Label runat="server" ID="thClientName" Text="Client Name" meta:resourcekey="thClientNameResource1" />
                                                                            </th>
                                                                            <th>
                                                                                <asp:Label runat="server" ID="thReferenceRange" Text="Ranges" meta:resourcekey="thReferenceRangeResource1" />
                                                                            </th>
                                                                            <th class="w-10p a-center">
                                                                                <asp:Label runat="server" ID="thPrimary" Text="Primary" meta:resourcekey="thPrimaryResource1" />
                                                                            </th>
                                                                            <th class="w-10p a-center">
                                                                                <asp:Label runat="server" ID="thActive" Text="Active" meta:resourcekey="thActiveResource1" />
                                                                            </th>
                                                                            <th>
                                                                                <asp:Label runat="server" ID="thReasonCode" Text="Reason" meta:resourcekey="thReasonCodeResource1" />
                                                                            </th>
                                                                            <th id="thConvUOMCode" align="center" style="width: 10%;" runat="server">
                                                                                <asp:Label runat="server" ID="lblConvUOMCode" Text="ConvUOM" meta:resourcekey="lblConvUOMCodeResource1" />
                                                                            </th>
                                                                            <th id="thConvFactorValue" align="center" style="width: 10%;" runat="server">
                                                                                <asp:Label runat="server" ID="lblConvFactorValue" Text="ConvFactor" meta:resourcekey="lblConvFactorValueResource1" />
                                                                            </th>
                                                                            <th id="thConvdecimalvalue" align="center" style="width: 10%;" runat="server">
                                                                                <asp:Label runat="server" ID="lblConvdecimalvalue" Text="ConvDecimalPoint" meta:resourcekey="lblConvdecimalvalueResource1" />
                                                                            </th>
                                                                            <th class="w-10p a-center">
                                                                                <asp:Label runat="server" ID="thAction" Text="Action" meta:resourcekey="thActionResource1" />
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <asp:Repeater ID="rptInvRefMapping" runat="server" OnItemDataBound="rptInvRefMapping_ItemDataBound">
                                                                            <ItemTemplate>
                                                                                <tr class="h-17">
                                                                                    <td class="a-left">
                                                                                        <asp:HiddenField ID="hdnInvRefMappingID" runat="server" Value='<%# Eval("ID") %>'
                                                                                            meta:resourcekey="hdnInvRefMappingIDResource2" />
                                                                                        <asp:HiddenField ID="hdnInstrumentID" runat="server" Value='<%# Eval("InstrumentID") %>'
                                                                                            meta:resourcekey="hdnInstrumentIDResource2" />
                                                                                        <asp:HiddenField ID="hdnKitID" runat="server" Value='<%# Eval("KitID") %>' meta:resourcekey="hdnKitIDResource2" />
                                                                                        <asp:HiddenField ID="hdnDeviceMappingID" runat="server" Value='<%# Eval("DeviceMappingID") %>'
                                                                                            meta:resourcekey="hdnDeviceMappingIDResource2" />
                                                                                        <asp:HiddenField ID="lblRRString" runat="server" />
                                                                                        <asp:Label ID="lblRRXML" runat="server" Style="display: none;" meta:resourcekey="lblRRXMLResource2" />
                                                                                        <asp:Label ID="lblInstrumentName" runat="server" meta:resourcekey="lblInstrumentNameResource2"
                                                                                            Text='<%# Eval("InstrumentName") %>'></asp:Label>
                                                                                    </td>
                                                                                    <%-- <td align="left">
                                                                            <asp:Label ID="lblKitName" runat="server" meta:resourcekey="lblKitNameResource2"
                                                                                Text='<%# Eval("KitName") %>'></asp:Label>
                                                                        </td>--%>
                                                                                    <td class="a-left">
                                                                                        <asp:HiddenField ID="hdnRefMappingUOMID" runat="server" Value='<%# Eval("UOMID") %>'
                                                                                            meta:resourcekey="hdnRefMappingUOMIDResource2" />
                                                                                        <asp:Label ID="lblUOM" runat="server" meta:resourcekey="lblUOMResource2" Text='<%# Eval("UOMCode") %>'></asp:Label>
                                                                                    </td>
                                                                                    <%--<td align="left">
                                                                            <asp:Label ID="lblTestCode" runat="server" meta:resourcekey="lblTestCodeResource2"
                                                                                Text='<%# Eval("TestCode") %>'></asp:Label>
                                                                        </td>--%>
                                                                                    <td class="a-left">
                                                                                        <asp:HiddenField ID="hdnClientID" runat="server" Value='<%# Eval("ClientID") %>'
                                                                                            meta:resourcekey="hdnClientIDResource2" />
                                                                                        <asp:Label ID="lblClientName" runat="server" meta:resourcekey="lblClientNameResource2"
                                                                                            Text='<%# Eval("ClientName") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <asp:Label ID="lblReferenceRange" runat="server" meta:resourcekey="lblReferenceRangeResource2"
                                                                                            Text='<%# Eval("ReferenceRange") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <asp:Label ID="lblPrimary" runat="server" meta:resourcekey="lblPrimaryResource2"
                                                                                            Text='<%# Eval("IsPrimary") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <asp:Label ID="lblActive" runat="server" meta:resourcekey="lblActiveResource2" Text='<%# Eval("IsActive") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <asp:HiddenField ID="hdnReasonCode" runat="server" Value='<%# Eval("ReasonCode") %>'
                                                                                            meta:resourcekey="hdnReasonCodeResource2" />
                                                                                        <asp:Label ID="lblReasonName" runat="server" meta:resourcekey="lblReasonNameResource2"
                                                                                            Text='<%# Eval("ReasonName") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td id="tdRefMapConv_UOM" runat="server" align="left" style="display: none;">
                                                                                        <asp:HiddenField ID="hdnRefMapConv_UOMID" runat="server" Value='<%# Eval("CONV_UOMID") %>' />
                                                                                        <asp:Label ID="lblRefMapConv_UOM" runat="server" Text='<%# Eval("CONV_UOMCode") %>'
                                                                                            meta:resourcekey="lblRefMapConv_UOMResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td id="tdRefMapConv_Factor" runat="server" align="left" style="display: none;">
                                                                                        <asp:Label ID="lblRefMapConv_Factor" runat="server" Text='<%# Eval("CONV_Factor") %>'
                                                                                            meta:resourcekey="lblRefMapConv_FactorResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td id="tdRefMapConvFac_DecimalPoint" runat="server" align="left" style="display: none;">
                                                                                        <asp:Label ID="lblRefMapConvFac_DecimalPoint" runat="server" Text='<%# Eval("ConvFac_DecimalPoint") %>'
                                                                                            meta:resourcekey="lblRefMapConvFac_DecimalPointResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td class="a-center">
                                                                                        <asp:Button ID="btnEditRefMapping" runat="server" Text="Edit" Style="background-color: Transparent;
                                                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                            font-size: 0;" OnClientClick="return onEditRefMapping(this);" meta:resourcekey="btnEditRefMappingResource2" />
                                                                                        <asp:Button ID="btnDeleteRefMapping" runat="server" class="del" Text="Delete" Style="cursor: pointer;
                                                                                            background: none; border: none; text-decoration: underline;" OnClientClick="return onDeleteRefMapping(this);"
                                                                                            meta:resourcekey="btnDeleteRefMappingResource2" />
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
                                        <ajc:TabPanel runat="server" HeaderText="Reflex Testing Rules" ID="TabRefluxTestingRules"
                                            CssClass="dataheadergroup" meta:resourcekey="TabRefluxTestingRulesResource1">
                                            <ContentTemplate>
                                                <table>
                                                    <tr style="border: 2px solid #f00;">
                                                        <td class="v-top">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblReflexTest" Text="Reflex Test" runat="server" meta:resourcekey="lblReflexTestResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtReflexTesttMapping" Width="330px" CssClass="searchBox" runat="server"
                                                                            meta:resourcekey="txtReflexTesttMappingResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteReflexTesttMapping" runat="server" TargetControlID="txtReflexTesttMapping"
                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box mediumList"
                                                                            CompletionListItemCssClass="wordWheel itemsMain mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                                                            ServiceMethod="GetTestCodingScheme" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                            DelimiterCharacters=":" Enabled="True" OnClientItemSelected="SelectedReflexTest"
                                                                            OnClientPopulated="TestCodeSchemePopulated">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnReflexMap" runat="server" Text="Select" CssClass="btn" onmouseout="this.className='btn'"
                                                                            onmouseover="this.className='btn btnhov'" OnClientClick="return btnReflexAdd()"
                                                                            meta:resourcekey="btnReflexMapResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblResultReportable" Text="Result Reportable" runat="server" meta:resourcekey="lblResultReportableResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkResultReportable" runat="server" meta:resourcekey="chkResultReportableResource1" />
                                                                    </td>
                                                                    <%-- </tr>
                                                                <tr>--%>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblChargeable" Text="Chargeable" runat="server" meta:resourcekey="lblChargeableResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="ChkChargeable" runat="server" meta:resourcekey="ChkChargeableResource1" />
                                                                    </td>
                                                                </tr>
                                                                <%--<tr>
                                                            <td align="right">
                                                                <asp:Label ID="lblPerformReflextesting" Text="Perform Reflex Test Using" runat="server"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlReflexTestUsing" runat="server">
                                                                    <asp:ListItem>Same Sample</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>--%>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div class="mytable1" style="overflow: auto; height: 200px">
                                                                <table id="tblReflex" class="w-98p">
                                                                    <thead>
                                                                        <tr class="dataheader1 w-5p h-17">
                                                                            <th class="w-40p">
                                                                                <asp:Label runat="server" ID="lblTestName" Text="Test Name" meta:resourcekey="lblTestNameResource1" />
                                                                            </th>
                                                                            <th class="w-15p">
                                                                                <asp:Label runat="server" ID="lblIsReportable" Text="IsReportable" meta:resourcekey="lblIsReportableResource1" />
                                                                            </th>
                                                                            <th class="w-15p">
                                                                                <asp:Label runat="server" ID="lblChargeablee" Text="IsChargeable" meta:resourcekey="lblChargeableeResource1" />
                                                                            </th>
                                                                            <th class="w-15p">
                                                                                <asp:Label runat="server" ID="lblReflexAction" Text="Action" meta:resourcekey="lblReflexActionResource1" />
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <asp:Repeater ID="reflexRepeter" runat="server" OnItemDataBound="reflexRepeter_ItemDataBound">
                                                                            <ItemTemplate>
                                                                                <tr class="h-17">
                                                                                    <td class="a-left">
                                                                                        <asp:Label ID="lblReflexInvestigationName" runat="server" Text='<%# Eval("ReflexInvestigationName") %>'
                                                                                            meta:resourcekey="lblReflexInvestigationNameResource1"></asp:Label>
                                                                                        <asp:HiddenField ID="hdnReflexTestID" runat="server" Value='<%# Eval("ReflexInvestigationID") %>' />
                                                                                        <asp:HiddenField ID="hdnTesttypes" runat="server" Value='<%# Eval("reflexSampleType") %>' />
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <asp:Label ID="lblReportable" runat="server" Text='<%# Eval("IsReportable") %>' meta:resourcekey="lblReportableResource1"></asp:Label>
                                                                                        <asp:HiddenField ID="hdnReportable" runat="server" Value='<%# Eval("IsReportable") %>' />
                                                                                    </td>
                                                                                    <td class="a-left">
                                                                                        <asp:Label ID="lblChargeable" runat="server" Text='<%# Eval("IsChargeable") %>' meta:resourcekey="lblChargeableResource2"></asp:Label>
                                                                                        <asp:HiddenField ID="hdnChargeable" runat="server" Value='<%# Eval("IsChargeable") %>' />
                                                                                    </td>
                                                                                    <td class="a-center">
                                                                                        <asp:Button ID="btnReflexDelete" runat="server" Text="Delete" Style="background-color: Transparent;
                                                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                            font-size: 11px;" OnClientClick="return onReflexDelete(this);" meta:resourcekey="btnReflexDeleteResource1" />
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
                                        <ajc:TabPanel runat="server" HeaderText="Results Authorization" ID="TabPanel1" meta:resourcekey="TabResultsAuthorizationResource1"
                                            CssClass="dataheadergroup">
                                            <ContentTemplate>
                                                <table class="a-center w-100p">
                                                    <tr>
                                                        <td class="w-50p">
                                                            <fieldset>
                                                                <table class="w-100p bg-row">
                                                                    <tr class="colorforcontent">
                                                                        <td colspan="2">
                                                                            <p class="bold">
                                                                                <%--Co-Authorization--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_035 %>
                                                                            </p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="w-30p">
                                                                            <asp:Label runat="server" ID="Label6" Text="Role" meta:resourcekey="thRoleResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <span class="richcombobox">
                                                                                <asp:DropDownList ID="ddlRole" runat="server" CssClass="ddlsmall" onchange="onChangeddlRole();">
                                                                                </asp:DropDownList>
                                                                            </span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="w-30p">
                                                                            <asp:Label runat="server" ID="Label2" Text="Department" meta:resourcekey="thDepartmentResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <span class="richcombobox">
                                                                                <asp:DropDownList ID="ddlDept1" runat="server" CssClass="ddlsmall" onchange="onChangeddlDept1();">
                                                                                </asp:DropDownList>
                                                                            </span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="w-30p">
                                                                            <asp:Label runat="server" ID="Label3" Text="Doctor" meta:resourcekey="thDoctorResource2" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" ID="ddlDoctor" CssClass="ddlsmall">
                                                                            </asp:DropDownList>
                                                                            &nbsp;&nbsp;&nbsp;
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="w-30p">
                                                                            <asp:Label runat="server" ID="lblActive" meta:resourcekey="lblActiveResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="chkReauthPrimary" runat="server" Text="Primary" meta:resourcekey="chkReauthPrimaryResource1" />
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:Button ID="btnAdd" runat="server" Text="&nbsp;&nbsp;&nbsp;Add&nbsp;&nbsp;&nbsp;"
                                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                                OnClientClick="return AddAuthorization()" meta:resourcekey="btnAddAuthorizationResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" class="a-center">
                                                                            <div class="mytable1" class="overflowAuto h-100p">
                                                                                <table id="tblCoAuth" class="w-100p">
                                                                                    <thead>
                                                                                        <tr class="dataheader1 h-5">
                                                                                            <th>
                                                                                                <asp:Label runat="server" ID="Label7" Text="Role" meta:resourcekey="Label7Resource1" />
                                                                                            </th>
                                                                                            <th>
                                                                                                <asp:Label runat="server" ID="Label4" Text="Department" meta:resourcekey="Label4Resource1" />
                                                                                            </th>
                                                                                            <th>
                                                                                                <asp:Label runat="server" ID="Label5" Text="Doctor's Name" meta:resourcekey="Label5Resource1" />
                                                                                            </th>
                                                                                            <th>
                                                                                                <asp:Label runat="server" ID="Label9" Text="Primary" meta:resourcekey="Label9Resource1" />
                                                                                            </th>
                                                                                            <th class="a-center w-10p">
                                                                                                <asp:Label runat="server" ID="lblDeleteCoAuth" Text="Action" meta:resourcekey="thActionResource1" />
                                                                                            </th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody id="tbltbodyCoAuth">
                                                                                        <asp:Repeater ID="rptCoAuth" runat="server" OnItemDataBound="rptCoAuth_ItemDataBound">
                                                                                            <ItemTemplate>
                                                                                                <tr class="h-5">
                                                                                                    <td class="a-left">
                                                                                                        <asp:HiddenField ID="hdnInvCoAuthID" runat="server" Value='<%# Eval("ID") %>' meta:resourcekey="hdnInvCoAuthIDResource2" />
                                                                                                        <asp:HiddenField ID="hdnRole" runat="server" Value='<%# Eval("RoleID") %>' meta:resourcekey="hdnRoleResource2" />
                                                                                                        <%# Eval("RoleName")%>
                                                                                                    </td>
                                                                                                    <td class="a-left">
                                                                                                        <asp:HiddenField ID="hdnDept1" runat="server" Value='<%# Eval("DeptID") %>' meta:resourcekey="hdnDept1Resource2" />
                                                                                                        <%# Eval("DeptName")%>
                                                                                                    </td>
                                                                                                    <td class="a-left">
                                                                                                        <asp:HiddenField ID="hdnDoctor" runat="server" Value='<%# Eval("UserID") %>' meta:resourcekey="hdnDoctorResource2" />
                                                                                                        <%# Eval("UserName")%>
                                                                                                    </td>
                                                                                                    <td class="a-left">
                                                                                                        <asp:HiddenField ID="hdnReauthPrimary" runat="server" Value='<%# Eval("IsPrimary") %>'
                                                                                                            meta:resourcekey="hdnDoctorResource2" />
                                                                                                        <%# Eval("IsPrimary")%>
                                                                                                    </td>
                                                                                                    <td class="a-center w-20p">
                                                                                                        <%--<input id="btnEditCoAuth" runat="server" value="Edit" type="button" style="background-color: Transparent;
                                                                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                                            font-size: 10px;" onclick="onEditCoAuth(this);" />--%>
                                                                                                        <asp:Button ID="btnEditCoAuth" runat="server" Text="Edit" CssClass="btn" OnClientClick="onEditCoAuth(this);"
                                                                                                            meta:resourcekey="btnEditResource11" />
                                                                                                        <%--          <input id="btnDeleteCoAuth" runat="server" value="Delete" type="button" style="background-color: Transparent;
                                                                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                                            font-size: 10px;" onclick="onDeleteCoAuth(this);" meta:resourcekey="btnCoAuthResource1" />--%>
                                                                                                        <asp:Button ID="btnDeleteCoAuth" runat="server" Text="Delete" CssClass="btn" OnClientClick="return onDeleteCoAuth(this);"
                                                                                                            meta:resourcekey="btnCoAuthResource1" />
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
                                                            </fieldset>
                                                        </td>
                                                        <td class="w-30p v-top">
                                                            <fieldset>
                                                                <table class="w-100p bg-row">
                                                                    <tr class="colorforcontent">
                                                                        <td colspan="2">
                                                                            <p class="bold">
                                                                                <%--Auto-Authorization--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_036 %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="w-30p">
                                                                            <asp:Label ID="Label8" Text="Role" runat="server" meta:resourcekey="lblAutoAuthorizeRoleResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlAutoAuthorizeRole" runat="server" CssClass="ddl" meta:resourcekey="ddlAutoAuthorizeRoleResource1"
                                                                                onchange="onChangeAutoAuthorizeRole();">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="w-30p">
                                                                            <asp:Label ID="lblAutoAuthorizeUser" Text="User" runat="server" meta:resourcekey="lblAutoAuthorizeUserResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" Width="140px" ID="ddlAutoAuthorizeUser" CssClass="ddl"
                                                                                onchange="onChangeAutoAuthorizeUser();">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </td>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                        <ajc:TabPanel runat="server" HeaderText="Processing Location" ID="PnlProcessingLocation"
                                            CssClass="dataheadergroup" meta:resourcekey="PnlProcessingLocationResource1">
                                            <ContentTemplate>
                                                <table class="w-100p a-center">
                                                    <tr>
                                                        <td class="w-50p">
                                                            <fieldset>
                                                                <table class="w-100p bg-row">
                                                                    <tr class="colorforcontent">
                                                                        <td colspan="5">
                                                                            <p class="bold">
                                                                                <%--Processing Location Mapping--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_037 %>
                                                                            </p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblProcessedType" runat="server" Text="Processed Type" meta:resourcekey="lblProcessedTypeResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="a-left">
                                                                            <span class="richcombobox" style="width: 175px">
                                                                                <asp:DropDownList ID="drpType" runat="server" CssClass="ddlsmall" onchange="Onchangeprocesstype();">
                                                                                </asp:DropDownList>
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblRegLocation" runat="server" Text="Register Location" meta:resourcekey="lblRegLocationResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="a-left">
                                                                            <span class="richcombobox" style="width: 175px">
                                                                                <asp:DropDownList ID="drpRegLocation" runat="server" CssClass="ddlsmall" onchange="validateRegisterLocation();">
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
                                                                                <asp:DropDownList ID="drpProcessingOrg" runat="server" CssClass="ddlsmall" onchange="OnchangeOrg();">
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
                                                                            <asp:Button ID="btnProcessingLocation" Width="55px" runat="server" Text="ADD" CssClass="btn"
                                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return AddProcessingLocation()"
                                                                                meta:resourcekey="btnProcessingLocationResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <br />
                                                                <br />
                                                                <div id="divProcessLocMapping" class="mytable1" style="overflow: auto; height: 200px">
                                                                    <table id="Tabel1" class="w-98p gridView">
                                                                        <thead>
                                                                            <tr class="dataheader1 h-5">
                                                                                <th>
                                                                                    <%--TYPE--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_038 %>
                                                                                </th>
                                                                                <th>
                                                                                    <%--REGISTER LOCATION--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_039 %>
                                                                                </th>
                                                                                <th>
                                                                                    <%--PROCESSING ORG--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_040 %>
                                                                                </th>
                                                                                <th>
                                                                                    <%--PROCESSING LOCATION--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_041 %>
                                                                                </th>
                                                                                <th>
                                                                                    <%--TASK--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_042 %>
                                                                                </th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <asp:Repeater ID="rptInvLocationMapping" runat="server" OnItemDataBound="rptInvLocationMapping_ItemDataBound">
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
                                                                                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("OrgName") %>' meta:resourcekey="Label9Resource2"></asp:Label>
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
                                                                                            <asp:Button ID="btnDeleteLocation" runat="server"  Style="background-color: Transparent;
                                                                                                color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                                font-size: 10px;" OnClientClick="return DeleteLocation(this);" meta:resourcekey="btnDeleteLocationResource2" />
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
                                         <ajc:TabPanel runat="server" HeaderText="Delta Check" ID="tabDeltaCheck"
                                            CssClass="dataheadergroup" meta:resourcekey="PnlDeltaCheckResource1">
                                            <ContentTemplate>
                                                <table class="w-100p a-center">
                                                    <tr>
                                                        <td class="w-50p">
                                                            <fieldset>
                                                                <table class="w-100p bg-row">
                                                                    <tr class="colorforcontent">
                                                                        <td colspan="3">
                                                                            <p class="bold">
                                                                                
                                                                            </p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 350px;">
                                                                            <asp:Label ID="lblDeltachkcalc" runat="server" Text="Delta Check Calculation" meta:resourcekey="lblDeltachkcalcResource1"></asp:Label>
                                                                       
                                                                            <span class="richcombobox" style="width: 175px">
                                                                                <asp:DropDownList ID="ddlDeltachkcalc" runat="server" CssClass="ddlsmall">
                                                                                </asp:DropDownList>
                                                                            </span>
                                                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                        </td>
                                                                        <td style="width: 220px;">
                                                                            <asp:Label ID="lblDeltaUnit" runat="server" Text="Delta Limit" meta:resourcekey="lblDeltaUnitResource1"></asp:Label>
                                                                       
                                                                        <asp:TextBox ID="txtDeltaUnit" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);" MaxLength="5" Width="100px" CssClass="Txtboxsmall"
                                                                            meta:resourcekey="txtDeltaUnitResource1" ></asp:TextBox>
                                                                      </td>
                                                                       <td>
                                                                            <asp:Label ID="lblTimeframe" runat="server" Text="Time Frame" meta:resourcekey="lblTimeframeResource1"></asp:Label>
                                                                        
                                                                        <asp:TextBox ID="txtTimeFrame" runat="server" MaxLength="5" onkeypress="return ValidateSpecialAndNumeric(this);" Width="100px" CssClass="Txtboxsmall"
                                                                            meta:resourcekey="txtTimeFrameResource1" ></asp:TextBox>
                                                                           
                                                                            <span class="richcombobox" style="width: 220px">
                                                                                <asp:DropDownList ID="ddlTimeUnit" runat="server" CssClass="ddlsmall">
                                                                                </asp:DropDownList>
                                                                            </span>
                                                                      </td>
                                                                      
                                                                    </tr>
                                                                     <tr>
                                                                        <td style="width: 350px;">
                                                                            <asp:CheckBox ID="chkCrossParameter" Text="Show Cross Parameter" runat="server" meta:resourcekey="chkCrossParameterResource1" />
                                                                        </td>
                                                                         <td>
                                                                        <asp:Label ID="lblcross" Text="Cross Parameter List" runat="server" meta:resourcekey="lblcrossResource1"></asp:Label>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:TextBox ID="txtCrossParameter" Width="250px" CssClass="searchBox" runat="server"
                                                                            meta:resourcekey="txtCrossParameterResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteCrossParameter" runat="server" TargetControlID="txtCrossParameter"
                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box mediumList"
                                                                            CompletionListItemCssClass="wordWheel itemsMain mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                                                            ServiceMethod="GetTestCodingScheme" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                            DelimiterCharacters=":" Enabled="True" OnClientItemSelected="SelectedCrossTest"
                                                                            OnClientPopulated="CrossTestCodeSchemePopulated">
                                                                        </ajc:AutoCompleteExtender>
                                                                    
                                                                        <asp:Button ID="btnaddCross" runat="server" Text="Select" CssClass="btn" onmouseout="this.className='btn'"
                                                                            onmouseover="this.className='btn btnhov'" OnClientClick="return btnCrossParameterAdd()"
                                                                            meta:resourcekey="btnaddCrossResource1" />
                                                                     </td>
                                                                      
                                                                    </tr>
                                                                  <tr>
                                                                   <td colspan="2">
                                                            <div class="mytable1" style="overflow: auto; height: 200px">
                                                                  <table id="tblCross" class="w-35p">
                                                                    <thead>
                                                                        <tr class="dataheader1 w-5p h-17">
                                                                            <th class="w-40p">
                                                                                <asp:Label runat="server" ID="lblCrossTestName" Text="Test Name" meta:resourcekey="lblCrossTestNameResource1" />
                                                                            </th>
                                                                            <th class="w-15p">
                                                                                <asp:Label runat="server" ID="lblCrossAction" Text="Action" meta:resourcekey="lblCrossActionResource1" />
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <asp:Repeater ID="CrossRepeter" runat="server" OnItemDataBound="CrossRepeter_ItemDataBound">
                                                                            <ItemTemplate>
                                                                                <tr class="h-17">
                                                                                    <td class="a-left">
                                                                                        <asp:Label ID="lblCrossInvestigationName" runat="server" Text='<%# Eval("ReflexInvestigationName") %>'
                                                                                            meta:resourcekey="lblCrossInvestigationNameResource1"></asp:Label>
                                                                                        <asp:HiddenField ID="hdnCrossTestID" runat="server" Value='<%# Eval("ReflexInvestigationID") %>' />
                                                                                    </td>
                                                                                    <td class="a-center">
                                                                                        <asp:Button ID="btnCrossDelete" runat="server" Text="Delete" Style="background-color: Transparent;
                                                                                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                                                                            font-size: 11px;" OnClientClick="return onCrossDelete(this);" meta:resourcekey="btnCrossDeleteResource1" />
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
                                                                <br />
                                                                <br />
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                        <ajc:TabPanel runat="server" HeaderText="Auto Certify" ID="tbpnlautocertify"
                                            CssClass="dataheadergroup" meta:resourcekey="PnlDeltaCheckResource1">
                                            <ContentTemplate>
                                                <table class="w-100p a-center">
                                                    <tr>
                                                        <td class="w-50p">
                                                            <fieldset>
                                                                <table class="w-100p bg-row">
                                                                    <tr class="colorforcontent">
                                                                        <td colspan="3">
                                                                            <p class="bold">
                                                                                <%--Processing Location Mapping--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_088%>
                                                                            </p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td> 
                                                                        <asp:CheckBox ID="chkautocertify" runat="server"  Text="Auto Certify" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="chkdeviceerr" runat="server"   Text="Device Error" />
                                                                      </td>
                                                                       <td>
                                                                            <asp:CheckBox ID="chkisQCstatus" runat="server"  Text="QCStatus" />
                                                                      </td>
                                                                      <td>
                                                                            <asp:CheckBox ID="chkiscritical" runat="server"  Text="Critical Value" />
                                                                      </td>
                                                                      <td>
                                                                            <asp:CheckBox ID="chkdeltaval" runat="server"   Text="Delta Value" />
                                                                      </td>
                                                                       <td>
                                                                            <asp:CheckBox ID="chkautoauth" runat="server"  Text="Autoauthorization range" />
                                                                      </td>
                                                                       <td>
                                                                            <asp:CheckBox ID="chkgrpdepend" runat="server"   Text="Group Dependencies " Visible="false" />
                                                                      </td>
                                                                      <td>
                                                                            <asp:CheckBox ID="chkcrossparam" runat="server"   Text="Cross Parameter Check" />
                                                                      </td>
                                                                       <td>
                                                                            <asp:CheckBox ID="chktechverify" runat="server"  Text="Technician Verification Needed" />
                                                                      </td>
                                                                    </tr> 
                                                                </table>
                                                                <br />
                                                                <br />
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
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="w-45p a-right">
                                    <asp:Label ID="lblReason1" runat="server" Text="Select Reason" meta:resourcekey="lblReason1Resource1" />
                                    &nbsp;
                                    <asp:DropDownList ID="ddlReasonn" Width="173px" runat="server" AutoPostBack="false"
                                        CssClass="ddlmedium">
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                    <asp:Label ID="lblAjaxBusy" Text="Please Wait..." runat="server" Style="display: none;"
                                        meta:resourcekey="lblAjaxBusyResource1" />
                                    <asp:Label ID="lblDelete" Text="Delete" runat="server" Style="display: none;" meta:resourcekey="lblDeleteResource1" />
                                </td>
                                <td class="a-right">
                                    <asp:Button ID="btnSave" ToolTip="Click here to Save Details" Style="cursor: pointer;"
                                        runat="server" Text="&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" meta:resourcekey="btnSaveResource1"
                                        Enabled="False" OnClick="btnSave_Click" OnClientClick="return onSave()" />
                                </td>
                                <td class="a-left w-43p">
                                    <asp:Button ID="btnReset" runat="server" Text="&nbsp;&nbsp;&nbsp;Reset&nbsp;&nbsp;&nbsp;"
                                        ToolTip="Click here to Cancel, View Home Page" Style="cursor: pointer;" class="btn"
                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnCancelResource1"
                                        OnClick="btnReset_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div class="modal w-98p" id="divModalRefRange" style="height: 78%;">
                <div class="dialogHeader">
                    <table class="w-100p">
                        <tr>
                            <td>
                                <asp:Label ID="lblRefRangeModalHeader" runat="server" Text="Range Configuration"
                                    meta:resourcekey="lblRefRangeModalHeaderResource1"></asp:Label>
                            </td>
                            <td class="a-right">
                                <img id="imgPopupClose" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                    style="cursor: pointer;" onclick="return HideRefRangePopup();" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-body" style="overflow: hidden; height: 81%;">
                    <table class="w-100p">
                        <tr class="h-20" id="trMainCat">
                            <td class="a-center">
                                <table class="w-100p">
                                    <tr>
                                        <td class="a-right">
                                            <asp:Label ID="lblRefRangeType" Text="Select Range Type" runat="server" meta:resourcekey="lblRefRangeTypeResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:DropDownList ID="ddlRefRangeType" CssClass="ddl" runat="server" meta:resourcekey="ddlRefRangeTypeResource1"
                                                onchange="onChangeRefRangeType();">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblGender" Text="Gender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:DropDownList ID="ddlCategory" runat="server" meta:resourcekey="ddlCategoryResource1"
                                                CssClass="ddl" onchange="onChangeRRCategory();">
                                                <%--  <asp:ListItem Value="0" meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                                <asp:ListItem Value="Male" meta:resourcekey="ListItemResource2">Male</asp:ListItem>
                                                <asp:ListItem Value="Female" meta:resourcekey="ListItemResource3">Female</asp:ListItem>
                                                <asp:ListItem Value="Both" meta:resourcekey="ListItemResource4">Both</asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblRRSubCategory" Text="Sub Category" runat="server" meta:resourcekey="lblRRSubCategoryResource1"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:DropDownList ID="ddlRRSubCategory" runat="server" meta:resourcekey="ddlSubCategoryResource1"
                                                CssClass="ddl" onchange="onChangeRRSubCategory();">
                                                <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource5">Select</asp:ListItem>
                                                <asp:ListItem Value="Age" meta:resourcekey="ListItemResource6">Age</asp:ListItem>
                                                <asp:ListItem Value="Common" meta:resourcekey="ListItemResource7">Common</asp:ListItem>
                                                <asp:ListItem Value="Other" meta:resourcekey="ListItemResource8">Other</asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trCategoryField">
                            <td class="a-left">
                                <div id="divAgeCategory" style="display: none;">
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lbllblAgeRange" Text="Age Range" runat="server" meta:resourcekey="lblAgeRangeResource1"></asp:Label></legend>
                                        <table class="w-100p padding2">
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblAgeType" Text="Type" runat="server" meta:resourcekey="lblAgeTypeResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:DropDownList ID="ddlAgeType" runat="server" meta:resourcekey="ddlAgeTypeResource1"
                                                        CssClass="ddl">
                                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource9">Select Type</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource10">Years</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource11">Months</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource12">Weeks</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource41">Days</asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <table>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:DropDownList ID="ddlOperatorRange1" runat="server" meta:resourcekey="ddlOperatorRange1Resource1"
                                                                    onchange="ShowAgeBetween();" CssClass="ddl">
                                                                    <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource13">Select</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource14">&lt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource15">&lt;=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource16">=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource17">&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource18">=&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource19">Between</asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtAgeRange1" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                    onkeyup="extractNumber(this,-1,false);" meta:resourcekey="txtAgeRange1Resource1"
                                                                    MaxLength="10"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <div id="divAgeBetween" style="display: none;">
                                                                    -&nbsp;
                                                                    <asp:TextBox ID="txtAgeRange2" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                        onkeyup="extractNumber(this,-1,false);" meta:resourcekey="txtAgeRange2Resource1"
                                                                        MaxLength="10"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_value" Text="Value" runat="server" meta:resourcekey="Rs_valueResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlOperatorRange2" runat="server" meta:resourcekey="ddlOperatorRange2Resource1"
                                                                    onchange="ShowValueBetween();" CssClass="ddl">
                                                                    <%-- <asp:ListItem Value="0" meta:resourcekey="ListItemResource20">Select</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource21">&lt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource22">&lt;=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource23">=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource24">&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource25">=&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource26">Between</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource100">Source</asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <div id="divAgeValue">
                                                                    <asp:TextBox ID="txtValueRange1" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                        onkeyup="extractNumber(this,-1,false);" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                        meta:resourcekey="txtValueRange1Resource1" MaxLength="10"></asp:TextBox>
                                                                </div>
                                                                <div id="divAgeSource" style="display: none;">
                                                                    <asp:TextBox ID="txtAgeSource" runat="server" Width="200px" meta:resourcekey="txtValueRange1Resource1"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div id="divValueBetween" style="display: none;">
                                                                    -&nbsp;<asp:TextBox ID="txtValueRange2" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                        onkeyup="extractNumber(this,-1,false);" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                        meta:resourcekey="txtValueRange2Resource1" MaxLength="10"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-left" id="tdAgeBulkData" style="display: none;">
                                                    <asp:Label ID="lblAgeBulkData" Text="Interpretation" runat="server" meta:resourcekey="lblAgeBulkDataResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlAgeBulkData" runat="server" meta:resourcekey="ddlAgeBulkDataResource1"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left" id="tdAgeResult" style="display: none;">
                                                    <asp:Label ID="lblAgeResult" Text="Show Result From" runat="server" meta:resourcekey="lblAgeResultResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlAgeResult" runat="server" meta:resourcekey="ddlAgeResultResource1"
                                                        CssClass="ddl">
                                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource20">Select</asp:ListItem>
                                                        <asp:ListItem Value="Interpretation" meta:resourcekey="ListItemAgeResultTypeResource1">Interpretation</asp:ListItem>
                                                        <asp:ListItem Value="Interpretation and Value" meta:resourcekey="ListItemAgeResultTypeResource2">Interpretation and Value</asp:ListItem>
                                                   --%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left" id="tdAgeDevice" style="display: none;">
                                                    <asp:Label ID="lblAgeDevice" Text="Device" runat="server" meta:resourcekey="lblAgeDeviceResource1"></asp:Label>
                                                    <span class="richcombobox" style="width: 100px;">
                                                        <asp:DropDownList ID="ddlAgeDevice" Width="100px" runat="server" meta:resourcekey="ddlAgeDeviceResource1"
                                                            CssClass="ddl">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Button ID="btnAddRRAge" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return AddAgeReferenceRange();"
                                                        meta:resourcekey="btnAddRRAgeResource1" />
                                                    <asp:Button ID="btnCancelAge" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return onCancelAgeReferenceRange();"
                                                        meta:resourcekey="btnCancelAgeResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div id="divGenderGeneralCategory" style="display: none;">
                                    <fieldset>
                                        <table class="w-100p bg-row">
                                            <tr class="colorforcontent padding5">
                                                <td colspan="8">
                                                    <asp:Label ID="Label12" Text="Value Range" CssClass="bold" runat="server" meta:resourcekey="lblValueRangeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblValueRangeValue" Text="Value" runat="server" meta:resourcekey="lblValueRangeValueResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlGenderValueOpt" runat="server" meta:resourcekey="ddlGenderValueOptResource1"
                                                        onchange="ShowGenderValueBetween();" CssClass="ddl">
                                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource27">Select</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource28">&lt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource29">&lt;=</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource30">=</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource31">&gt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource32">=&gt;</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource33">Between</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource101">Source</asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <div id="divCommonValue">
                                                        <asp:TextBox ID="txtGenderValueStart" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                            onkeyup="extractNumber(this,-1,false);" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            meta:resourcekey="txtGenderValueStartResource1" MaxLength="10"></asp:TextBox>
                                                    </div>
                                                    <div id="divCommonSource" style="display: none;">
                                                        <asp:TextBox ID="txtCommonSource" runat="server" Width="200px" meta:resourcekey="txtCommonSourceResource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div id="divGenderValueBetween" style="display: none;">
                                                        -&nbsp;<asp:TextBox ID="txtGenderValueEnd" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                            onkeyup="extractNumber(this,-1,false);" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            meta:resourcekey="txtGenderValueEndResource1" MaxLength="10"></asp:TextBox>
                                                    </div>
                                                </td>
                                                <td class="a-left" id="tdCommonBulkData" style="display: none;">
                                                    <asp:Label ID="lblCommonBulkData" Text="Interpretation" runat="server" meta:resourcekey="lblCommonBulkDataResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlCommonBulkData" runat="server" meta:resourcekey="ddlCommonBulkDataResource1"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left" id="tdCommonResult" style="display: none;">
                                                    <asp:Label ID="lblCommonResult" Text="Show Result From" runat="server" meta:resourcekey="lblCommonResultResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlCommonResult" runat="server" meta:resourcekey="ddlCommonResultResource1"
                                                        CssClass="ddl">
                                                        <%-- <asp:ListItem Value="0" meta:resourcekey="ListItemResource20">Select</asp:ListItem>
                                                        <asp:ListItem Value="Interpretation" meta:resourcekey="ListItemCommonResultTypeResource1">Interpretation</asp:ListItem>
                                                        <asp:ListItem Value="Interpretation and Value" meta:resourcekey="ListItemCommonResultTypeResource2">Interpretation and Value</asp:ListItem>
                                                   --%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left" id="tdCommonDevice" style="display: none;">
                                                    <asp:Label ID="lblCommonDevice" Text="Device" runat="server" meta:resourcekey="lblCommonDeviceResource1"></asp:Label>
                                                    <span class="richcombobox" style="width: 100px;">
                                                        <asp:DropDownList ID="ddlCommonDevice" Width="100px" runat="server" meta:resourcekey="ddlCommonDeviceResource1"
                                                            CssClass="ddl">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Button ID="btnAddRRCommon" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return AddCommonReferenceRange();"
                                                        meta:resourcekey="btnAddRRCommonResource1" />
                                                    <asp:Button ID="btnCancelCommon" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return onCancelCommonReferenceRange();"
                                                        meta:resourcekey="btnCancelCommonResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div id="divGenderOtherCategory" style="display: none;">
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lblOtherRange" Text="Other Range" runat="server" meta:resourcekey="lblOtherRangeResource1"></asp:Label></legend>
                                        <table class="w-100p">
                                            <tr id="trNumericRange" runat="server">
                                                <td class="w-10p" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-1p">
                                                                <%--<input value="Numeric" type="radio" id="rdoResultTypeNumeric" name="rdoResultType"
                                                                 checked="true" onclick="ShowResultType('Numeric');" runat="server" />
                                                                 --%>
                                                                <asp:RadioButton ID="rdoResultTypeNumeric" GroupName="rdoResultType" runat="server"
                                                                    Checked="true" onclick="ShowResultType('Numeric');" />
                                                            </td>
                                                            <td class="w-5p">
                                                                <asp:Label ID="lblNumeric" Text="Numeric" runat="server" meta:resourcekey="lblNumericResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-left" runat="server">
                                                    <asp:Label ID="lblOtherAgeType" Text="Age Type" runat="server" meta:resourcekey="lblOtherAgeTypeResource1" />
                                                    <asp:DropDownList ID="ddlOtherAgeType" runat="server" meta:resourcekey="ddlOtherAgeTypeResource1"
                                                        CssClass="ddl">
                                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource9">Select Type</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource10">Years</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource11">Months</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource12">Weeks</asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource41">Days</asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left">
                                                    <table>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblOtherAgeValue" Text="Age Value" runat="server" meta:resourcekey="lblOtherAgeValueResource1" />
                                                                <asp:DropDownList ID="ddlOtherAgeOperator" runat="server" meta:resourcekey="ddlOtherAgeOperatorResource1"
                                                                    CssClass="ddl" onchange="ShowOtherAgeBetween();">
                                                                    <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource13">Select</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource14">&lt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource15">&lt;=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource16">=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource17">&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource18">=&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource19">Between</asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtOtherAgeRange1" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                    onkeyup="extractNumber(this,-1,false);" meta:resourcekey="txtOtherAgeRange1Resource1"
                                                                    MaxLength="10"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <div id="divOtherAgeBetween" style="display: none;">
                                                                    -&nbsp;
                                                                    <asp:TextBox ID="txtOtherAgeRange2" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                        onkeyup="extractNumber(this,-1,false);" meta:resourcekey="txtOtherAgeRange2Resource1"
                                                                        MaxLength="10"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td colspan="2" runat="server">
                                                    <asp:Label ID="Rs_ReferenceName" Text="Reference Name" runat="server" meta:resourcekey="Rs_ReferenceNameResource1"></asp:Label>
                                                    <asp:TextBox ID="txtGenderOther" runat="server" Width="250px" MaxLength="100" meta:resourcekey="txtGenderOtherResource1"></asp:TextBox>
                                                </td>
                                                <td class="a-left" runat="server">
                                                    <table id="tblNumericValue" style="display: table;" border="0" width="100%">
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblOtherRangeValue" Text="Range Value" runat="server" meta:resourcekey="lblOtherRangeValueResource1" />
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList ID="ddlOtherRangeOpt" runat="server" meta:resourcekey="ddlOtherRangeOptResource1"
                                                                    CssClass="ddl" onchange="ShowOtherValueBetween();">
                                                                    <%-- <asp:ListItem Value="0" meta:resourcekey="ListItemResource34">Select</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource35">&lt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource36">&lt;=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource37">=</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource38">&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource39">=&gt;</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource40">Between</asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox ID="txtOtherRange1" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                    onkeyup="extractNumber(this,-1,false);" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                    meta:resourcekey="txtOtherRange1Resource1" MaxLength="10"></asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <div id="divOtherValueBetween" style="display: none;">
                                                                    -&nbsp;<asp:TextBox ID="txtOtherRange2" runat="server" Width="25px" onblur="extractNumber(this,-1,false);"
                                                                        onkeyup="extractNumber(this,-1,false);" onkeypress="return ValidateSpecialAndNumeric(this);"
                                                                        meta:resourcekey="txtOtherRange2Resource1" MaxLength="10"></asp:TextBox>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-1p">
                                                                <%--  <input value="Text" type="radio" id="rdoResultTypeText" name="rdoResultType" onclick="ShowResultType('Text');"
                                                                    runat="server" />--%>
                                                                <asp:RadioButton ID="rdoResultTypeText" GroupName="rdoResultType" runat="server"
                                                                    onclick="ShowResultType('Text');" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblText" Text="Text" runat="server" meta:resourcekey="lblTextResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-left" id="tdOtherBulkData" style="display: none;">
                                                    <asp:Label ID="lblOtherBulkData" Text="Interpretation" runat="server" meta:resourcekey="lblOtherBulkDataResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlOtherBulkData" runat="server" meta:resourcekey="ddlOtherBulkDataResource1"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left" id="tdOtherResult" style="display: none;">
                                                    <asp:Label ID="lblOtherResult" Text="Show Result From" runat="server" meta:resourcekey="lblOtherResultResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlOtherResult" runat="server" meta:resourcekey="ddlOtherResultResource1"
                                                        CssClass="ddl">
                                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource20">Select</asp:ListItem>
                                                        <asp:ListItem Value="Interpretation" meta:resourcekey="ListItemOtherResultTypeResource1">Interpretation</asp:ListItem>
                                                        <asp:ListItem Value="Interpretation and Value" meta:resourcekey="ListItemOtherResultTypeResource2">Interpretation and Value</asp:ListItem>
                                                    --%></asp:DropDownList>
                                                </td>
                                                <td class="a-left" id="tdOtherDevice" style="display: none;">
                                                    <asp:Label ID="lblOtherDevice" Text="Device" runat="server" meta:resourcekey="lblOtherDeviceResource1"></asp:Label>
                                                    <span class="richcombobox" style="width: 100px;">
                                                        <asp:DropDownList ID="ddlOtherDevice" Width="100px" runat="server" meta:resourcekey="ddlOtherDeviceResource1"
                                                            CssClass="ddl">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkNormalValue" Text="Normal" runat="server" meta:resourcekey="chkNormalValueResource1" />
                                                    <asp:CheckBox ID="chkIsSourceText" Text="Is Source Text" runat="server" meta:resourcekey="chkIsSourceTextResource1" />
                                                </td>
                                                <td class="a-left">
                                                    <asp:Button ID="btnAddRROthers" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return AddOtherReferenceRange();"
                                                        meta:resourcekey="btnAddRROthersResource1" />
                                                    <asp:Button ID="btnCancelOthers" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return onCancelOtherReferenceRange();"
                                                        meta:resourcekey="btnCancelOthersResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <div id="divScrolling" runat="server" class="divRRpopup1 w-100p" style="height: 400px;">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <div id="divReferenceRangeTable" class="mytable1" style="display: none;">
                                                    <table id='tblRange' class="w-100p gridView">
                                                        <thead>
                                                            <tr class='dataheader1 h-20'>
                                                                <th>
                                                                    <asp:Label ID="thrangeType" Text="Range Type" runat="server" meta:resourcekey="thRangeTypeResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thGender" Text="Gender" runat="server" meta:resourcekey="thARGenderResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thSubcat" Text="Sub Category" runat="server" meta:resourcekey="thSubcatResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thAgeRange" Text="Age Range" runat="server" meta:resourcekey="thARAgeRangeResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thAgeunit" Text="Age Units" runat="server" meta:resourcekey="thARTypeResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thReferencename" Text="Reference Name" runat="server" meta:resourcekey="thReferenceNameRangeResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thValue" Text="Value" runat="server" meta:resourcekey="thARValueResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thisnormal" Text="Is Normal" runat="server" meta:resourcekey="thnormalResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thIsSourceText" Text="Is Source Text" runat="server" meta:resourcekey="thIsSourceResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thBulkData" Text="Interpretation" runat="server" meta:resourcekey="thBulkDataResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thResult" Text="Show Result From" runat="server" meta:resourcekey="thResultResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thDevice" Text="Device" runat="server" meta:resourcekey="thDeviceResource1" />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="thDelete" Text="Action" runat="server" meta:resourcekey="thARDeleteResource1" />
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnModalRefRangeSave" runat="server" Text="Save Changes" CssClass="btn"
                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnModalRefRangeSaveResource1"
                        OnClientClick="return SaveReferenceRange();" />
                    <asp:Button ID="btnModalRefRangeCancel" runat="server" Text="&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;"
                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                        OnClientClick="return HideRefRangePopup()" meta:resourcekey="btnModalRefRangeCancelResource1" />
                </div>
            </div>
            <asp:HiddenField ID="hdnHandsonTable1Data" runat="server" Value="" />
            <asp:HiddenField ID="hdnHandsonTable2Data" runat="server" Value="" />
            <asp:HiddenField ID="hdnProcessingLocation" runat="server" />
            <asp:HiddenField ID="hdnAutoAuthorizeUser" runat="server" />
            <asp:HiddenField ID="hdnSelectedLayout" runat="server" Value="layout1" />
            <asp:HiddenField ID="hdnHandsonTable1" runat="server" Value="" />
            <asp:HiddenField ID="hdnHandsonTable2" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsEmptyHandsonTable1" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsEmptyHandsonTable2" runat="server" Value="" />
            <asp:HiddenField ID="hdnHandsonTable1ColumnCount" runat="server" Value="0" />
            <asp:HiddenField ID="hdnTestCode" runat="server" Value="0" />
            <asp:HiddenField ID="hdnHandsonTable2ColumnCount" runat="server" Value="0" />
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnLoadTestDetails" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress DynamicLayout="true" ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="a-center w-20p">
                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                    meta:resourcekey="img1Resource1" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Panel>
<div class="modal" id="divModalAddRemarks" style="width: 750px;">
    <ajc:TabContainer ID="TabSave" runat="server" ActiveTabIndex="1" meta:resourcekey="TabSaveResource1">
        <ajc:TabPanel runat="server" HeaderText="Add Remarks" ID="Tab1Save" CssClass="dataheadergroup"
            meta:resourcekey="Tab1SaveResource1">
            <HeaderTemplate>
                <%--Add Remarks--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_043 %>
            </HeaderTemplate>
            <ContentTemplate>
                <div class="dialogHeader">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="lbladdReamrks" runat="server" Text="Add Remarks" meta:resourcekey="lbladdReamrksResource1"></asp:Label>
                            </td>
                            <td align="right">
                                <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                    style="cursor: pointer;" onclick="return HideRefRangePopup();" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-body" style="overflow: hidden; height: 300px;">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lbltype" Text="Select Type" runat="server" meta:resourcekey="lbltypeResource2"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlType" runat="server" meta:resourcekey="ddlTypeResource1">
                                                <%-- <asp:ListItem Value="0" meta:resourcekey="ListItemResource34">Select</asp:ListItem>
                                                <asp:ListItem Value="Medical" meta:resourcekey="ListItemResource35">Medical</asp:ListItem>
                                                <asp:ListItem Value="Technical" meta:resourcekey="ListItemResource36">Technical</asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblremarkcode" Text="Remark Code" runat="server" meta:resourcekey="lblremarkcodeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtremarkCode" runat="server" meta:resourcekey="txtremarkCodeResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblremarks" Text="Remarks" runat="server" meta:resourcekey="lblremarksResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtremark" runat="server" MaxLength="1000" TextMode="MultiLine"
                                                Width="250px" Height="100px" meta:resourcekey="txtremarkResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <%--  <input id="btnSubmit" onclick="return Validate();return false;" type="button" class="btn"
                        value="&nbsp;&nbsp;Add&nbsp;&nbsp" />--%>
                    <%--<asp:button id="btnSubmit" onclick="return Validate();return false;" runat="server"
                        value="&nbsp;&nbsp;Add&nbsp;&nbsp" CssClass="btn" />--%>
                    <asp:Button ID="btnSubmit" runat="server" Text="Add" CssClass="btn" OnClientClick="return Validate();"
                        meta:resourcekey="btnSubmitResource1" />
                    <asp:Button ID="btnRemarkCancel" runat="server" Text="&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;"
                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                        OnClientClick="return HideRefRangePopup()" meta:resourcekey="btnRemarkCancelResource1" />
                </div>
            </ContentTemplate>
        </ajc:TabPanel>
        <ajc:TabPanel runat="server" HeaderText="Edit Remarks" ID="tab2Edit" CssClass="dataheadergroup"
            meta:resourcekey="tab2EditResource1">
            <HeaderTemplate>
                <%--  Edit Remarks--%><%=Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_044 %>
            </HeaderTemplate>
            <ContentTemplate>
                <div class="dialogHeader">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="Label13" runat="server" Text="Edit Remarks" meta:resourcekey="Label13Resource1"></asp:Label>
                            </td>
                            <td align="right">
                                <img id="img2" runat="server" alt="Close" onclick="return HideRefRangePopup();" src="../Images/dialog_close_button.png"
                                    style="cursor: pointer;"></img>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-body" style="overflow: hidden; height: 300px;">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="Label10" runat="server" Text="Select Type" meta:resourcekey="Label10Resource2"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlRtype" runat="server" onchange="return onChangeRemarksType1();"
                                                meta:resourcekey="ddlRtypeResource1">
                                                <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource37" Text="Select"></asp:ListItem>
                                                <asp:ListItem Value="M" meta:resourcekey="ListItemResource38" Text="Medical"></asp:ListItem>
                                                <asp:ListItem Value="T" meta:resourcekey="ListItemResource39" Text="Technical"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblRemarkText" runat="server" Text="Remark Text" meta:resourcekey="lblRemarkTextResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txttext" runat="server" CssClass="searchBox" MaxLength="1000" onfocus="return onFocusRemarks1();"
                                                TabIndex="1" Width="500px" meta:resourcekey="txttextResource1"></asp:TextBox>
                                            &nbsp;
                                            <ajc:AutoCompleteExtender ID="ACEAddRemarks1" runat="server" CompletionInterval="0"
                                                CompletionListCssClass="wordWheel listMain .box bigList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 bigList"
                                                CompletionListItemCssClass="wordWheel itemsMain bigList" DelimiterCharacters=""
                                                EnableCaching="False" Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="SelectedRemarkID"
                                                OnClientPopulated="RemarksPopulated" ServiceMethod="GetRemarkDetails" ServicePath="~/WebService.asmx"
                                                TargetControlID="txttext" UseContextKey="True">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblRcode" runat="server" Text="Remark Code" meta:resourcekey="lblRcodeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRCode" runat="server" meta:resourcekey="txtRCodeResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table width="100%">
                                    <tr>
                                        <td align="right" style="width: 125px;">
                                            <asp:Label ID="lblRemarkss" runat="server" Text="Remarks" meta:resourcekey="lblRemarkssResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txttextRemark" runat="server" Height="100px" MaxLength="1000" onfocus="return onFocusRemarksText();"
                                                TextMode="MultiLine" Width="250px" meta:resourcekey="txttextRemarkResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnEdit" runat="server" OnClientClick="ValidateRemarks();return EditFunction();return false;"
                        CssClass="btn" Text="Update" meta:resourcekey="btnEditResource1" />
                    <asp:Button ID="btnClear" runat="server" OnClientClick="return Hide();" CssClass="btn"
                        Text="Clear" meta:resourcekey="btnClearResource1" />
                    <asp:Button ID="btnClose" runat="server" Text="&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;"
                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                        OnClientClick="return HideRefRangePopup()" meta:resourcekey="btnCloseResource1" />
                </div>
            </ContentTemplate>
        </ajc:TabPanel>
    </ajc:TabContainer>
</div>
<asp:HiddenField ID="hdnMessages" runat="server" />
<asp:HiddenField ID="hdnSelectedRemarksID1" runat="server" />
<asp:HiddenField ID="hdnSelectedRemarksID" runat="server" />
<asp:HiddenField ID="hdnRemarksContent" runat="server" />
<asp:HiddenField ID="hdnRemarksType" runat="server" />
<asp:HiddenField ID="hdnRemarksTypeName" runat="server" />
<asp:HiddenField ID="hdnOrgID" runat="server" />
<asp:HiddenField ID="hdnLocationID" runat="server" />
<asp:HiddenField ID="hdnInvID" runat="server" />
<asp:HiddenField ID="hdnLstInvRemarks" runat="server" />
<asp:HiddenField ID="hdnLstInvOrgRefMapping" runat="server" />
<asp:HiddenField ID="hdnSelectedRefMappingRowIndex" runat="server" />
<asp:HiddenField ID="hdnAgeRangeAdd" runat="server" />
<asp:HiddenField ID="hdnGenderRangeAdd" runat="server" />
<asp:HiddenField ID="hdnOtherReferenceRangeAdd" runat="server" />
<asp:HiddenField ID="hdnRRStringAdd" runat="server" />
<asp:HiddenField ID="hdnRRXMLAdd" runat="server" />
<asp:HiddenField ID="hdnIsRRXML" runat="server" Value="false" />
<asp:HiddenField ID="hdnIsPRXML" runat="server" Value="false" />
<asp:HiddenField ID="hdnIsOrderable" runat="server" />
<asp:HiddenField ID="hdnIsChangesFromRRPopup" runat="server" Value="false" />
<asp:HiddenField ID="hdnSelectedInvRefMappingID" runat="server" Value="0" />
<asp:HiddenField ID="hdnSelectedDeviceMappingID" runat="server" Value="0" />
<asp:HiddenField ID="hdnTypeValue" runat="server" Value="Numeric" />
<asp:HiddenField ID="hdnSelectedAgeRowIndex" runat="server" />
<asp:HiddenField ID="hdnSelectedCommonRowIndex" runat="server" />
<asp:HiddenField ID="hdnSelectedOthersRowIndex" runat="server" />
<asp:HiddenField ID="hdnSelectedReflexTest" runat="server" />
<asp:HiddenField ID="hdnReflexTestContent" runat="server" />

<asp:HiddenField ID="hdnSelectedCrossTest" runat="server" />
<asp:HiddenField ID="hdnCrossTestContent" runat="server" />
<asp:HiddenField ID="hdnLstInvValueRangeMaster" runat="server" />
<asp:HiddenField ID="hdnlstInvCrossparameterTest" runat="server" />
<asp:HiddenField ID="hdnDept1" runat="server" />
<asp:HiddenField ID="hdnDoctor" runat="server" />
<asp:HiddenField ID="hdnLstCoAuth" runat="server" />
<asp:HiddenField ID="hdnRole" runat="server" />
<asp:HiddenField ID="hdnView" runat="server" Value="N" />
<asp:HiddenField ID="hdntrRowindex" runat="server" />
<asp:HiddenField ID="hdnReauthPrimary" runat="server" />
<asp:HiddenField ID="hdnInvLocationMapping" runat="server" />
<asp:HiddenField ID="hdnInvLocation" runat="server" />
<asp:HiddenField ID="hdnSelectedOrgID" runat="server" />
<asp:HiddenField ID="hdnDelSelInvRefMappingID" runat="server" />
<asp:HiddenField ID="hdnDelSelDeviceMappingID" runat="server" />
<asp:HiddenField ID="hdnConfRefRange" runat="server" />
<asp:HiddenField ID="hdnUOMButtonID" runat="server" />

<asp:HiddenField ID="hdnTestType" runat="server" Value="" />
<script type="text/jscript">
    function OnchangeOrg() {
        //      //debugger;
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_28") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_28") : "Select Register Location";
        try {
            var ProcessType = $('#' + drpType + ' option:selected');
            var RegLocation = $('#' + drpRegLocation + ' option:selected');
            if ($(RegLocation).val() == '0') {
                $('[id$="drpProcessingOrg"] option:first').attr('selected', true);
                // alert("Select Register Location");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
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
                        //alert(xhr.status);
                        ValidationWindow(xhr.status, AlrtWinHdr);
                    }

                });
            }

        }

        catch (e) {
            return false;
        }

    }

    function Onchangeprocesstype() {
        //        //debugger;
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
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
                        // alert(xhr.status);
                        ValidationWindow(xhr.status, AlrtWinHdr);
                    }

                });

            }
        }
        catch (e) {
            return false;
        }
    }


    function AddProcessingLocation() {
        //    //debugger;
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_29") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_29") : "Select the Processing Location Values";
        var UsrDelete = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_081") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_081") : "Delete";
        try {
            var SelectType = $('#' + drpType + ' option:selected ');
            var SelectRegLocation = $('#' + drpRegLocation + ' option:selected ');
            var SelectProcOrg = $('#' + drpProcessingOrg + ' option:selected ');
            var SelectProcLocation = $('#' + drpProcessLocation + ' option:selected ');
            //              if ($(SelectType).val() == 'OUT') {
            //                  SelectProcLocation = $('#' + drpProcessingOrg + ' option:selected ');
            //              }

            if ($(SelectType).val() == '0' || $(SelectRegLocation).val() == '0' || $(SelectProcOrg).val() == '0' || $(SelectProcLocation).val() == '0') {
                //alert("Select the Processing Location Values");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;

            }
            else {
                //                //debugger;
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



                var $trow = "<tr><td>" + hdnInvestigationID + spanType + hdnType + Type + "</td><td>" + hdnRegLocation + RegLocation + "</td><td>" + hdnProcessingOrg + ProcessingOrg + "</td><td>" + hdnProcLocation + ProcLocation + "</td><td align='center'><input id='btnDeleteLocation' value='Delete' type='button' style='background-color: Transparent; color: Blue;  border-style: none; text-decoration: underline; cursor: pointer; font-size: 10px;' onclick='DeleteLocation(this);' /></td></tr>"

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
        //      //debugger;
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_045") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_045") : "Are you sure you wish to delete this record Permanently";
        var UsrAlrtMsg1 = SListForAppMsg.Get("CommonControls_TestMaster_ascx_30") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_30") : "Unable to delete";
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
                //var txtDelete = confirm('Are you sure you wish to delete this record Permanently');
                var txtDelete = confirm(UsrAlrtMsg);
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
                        // alert("Unable to delete");
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
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
        //    //debugger;
        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_39") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_TestMaster_ascx_31") != null ? SListForAppMsg.Get("CommonControls_TestMaster_ascx_31") : "Register Location Already Exists";
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
                    // alert("Register Location Already Exists");
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }

        }
    }
    function hidetask() {

        var tbl = document.getElementById("Tabel1");

        for (var i = 0; i < tbl.rows.length; i++) {
            for (var j = 0; j < tbl.rows[i].cells.length; j++) {

                if (j == 4)
                    tbl.rows[i].cells[j].style.display = "none";
            }
        }

    }
    function ChangeSynoptic() {
        var ChkSynoptic = '<%=ChkSynoptic.ClientID%>';
        var IsSynoptic = $('#' + ChkSynoptic).is(':checked') ? 'Y' : 'N';
        var chkNonOrderable = '<%=chkNonOrderable.ClientID%>';
        if (IsSynoptic == "Y") {
            $('#' + chkNonOrderable).prop('checked', true);
        }
        else {
            $('#' + chkNonOrderable).prop('checked', false);
        }
    }
 
</script>

