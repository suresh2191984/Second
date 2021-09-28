<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BulkApprovel.aspx.cs" Inherits="Investigation_BulkApprovel"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Reference Control="BioPattern1.ascx" %>
<%@ Reference Control="BioPattern2.ascx" %>
<%@ Reference Control="BioPattern3.ascx" %>
<%@ Reference Control="FishPattern1.ascx" %>
<%@ Reference Control="FishPattern2.ascx" %>
<%@ Reference Control="ImageUploadpattern.ascx" %>
<%@ Register Src="ReflexTest.ascx" TagName="ReflexTest" TagPrefix="Reflex" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--<%@ OutputCache Duration="60" VaryByParam="vids;Invids" %>--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation Capture</title>

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script src="../Scripts/ResultCapture.js" type="text/javascript"></script>

    <style type="text/css">
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 130px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url(         '../Images/magnifying-glass.png' );
            background-repeat: no-repeat;
            padding-left: 20px !important;
            background-color: #F3E2A9;
        }
        .listMain
        {
            width: 350px !important;
        }
        .csspName span
        {
            width: 73px !important;
        }
        .ie .cssUnitName span
        {
            width: 75px !important;
        }
    </style>

    <script language="javascript" type="text/javascript">

//$('#Chkapprr').click(function(e){
//    var table= $(e.target).closest('ParthibanChk');
//    $('td input:checkbox',table).prop('checked',this.checked);
//});


        $(document).ready(function() {
        
 $('#ctl14').click(function() {
 
 var checkbox = $('#ctl14');
if(checkbox.prop('checked')==true){
   // $('#ParthibanChk tbody').prop('checked', true);  
   // $('[type="checkbox"]').is("   :checked",true)
 $('input[bulk=checkbox]').prop('checked', true);
 }
 else{
 $('input[bulk=checkbox]').prop('checked', false);
 }
});
        var PageHeader = SListForAppDisplay.Get('Investigation_BatchWiseEnterresult_aspx_04') == null ? "Batch Wise Validate Result" : SListForAppDisplay.Get('Investigation_BatchWiseEnterresult_aspx_04');
       var PageheaderApprove = SListForAppDisplay.Get('Investigation_BulkApproval_aspx_01') == null ? "Bulk Approval" : SListForAppDisplay.Get('Investigation_BulkApproval_aspx_01');
      // var PageheaderApprove=Investigation_BulkApproval_aspx_01 
        if (hdnActionName.value == 'Validate') {
                $("#Attuneheader_TopHeader1_lblvalue").text(PageHeader);
//               document.getElementById("DivApproval").style.diplay="none";
//               document.getElementById("DivSearchArea").style.diplay="block";
              //  $("#DivApproval").hide();
             $("#trApp").hide();
             $("#tdlblHeader").show();
          $("#tddlHeader").show();
          $("#tdlblProtocol").show();
          $("#tddlProtocol").show();
          $("#tdtxtWorkListID").show();
          $("#tdlblWorkListID").show();
           $("#tdchkIsMaster").show();
           
            }
            else if (hdnActionName.value == 'Approvel'){
                $("#Attuneheader_TopHeader1_lblvalue").text(PageheaderApprove);
//            document.getElementById("DivSearchArea").style.diplay="none";
//            document.getElementById("DivApproval").style.diplay="block";
           //  $("#DivSearchArea").hide();
           
          $("#tdlblHeader").hide();
          $("#tddlHeader").hide();
          $("#tdlblProtocol").hide();
          $("#tddlProtocol").hide();
          $("#tdtxtWorkListID").hide();
          $("#tdlblWorkListID").hide();
           $("#tdchkIsMaster").hide();
             $("#HidApp").hide();
            }
            else{
            $("#Attuneheader_TopHeader1_lblvalue").text(PageHeader);
//               document.getElementById("DivApproval").style.diplay="none";
//               document.getElementById("DivSearchArea").style.diplay="block";
              //  $("#DivApproval").hide();
             $("#trApp").hide();
             $("#tdlblHeader").show();
          $("#tddlHeader").show();
          $("#tdlblProtocol").show();
          $("#tddlProtocol").show();
          $("#tdtxtWorkListID").show();
          $("#tdlblWorkListID").show();
           $("#tdchkIsMaster").show();
            }
        });
        function ShowReportPreview(vid, roleId, invStatus) {
            try {
                $find("mpReportPreview").show();
                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
            }
            catch (e) {
                return false;
            }
        }
        
        function ChecKGroupSum() { //added Arivalagan.kk
        }
        function ShowAlertMsg() {
            /* Added By Venkatesh S */
            var vNeedToContinue = SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_01') == null ? "Do You need to continue" : SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_01');
            if (document.getElementById('hdncountsofdata').value > 0) 
			{
                if (ConfirmWindow(vNeedToContinue)) {
                    javascript: __doPostBack('btnBatchSearch', 'LoadPatterns');
                }
                else {
                    DInvest.Style.dispaly = "none";
                    return true;
                }
            }
            else {
                javascript: __doPostBack('btnBatchSearch', 'LoadPatterns');
            }

        }

        function expandBox(id) {
            if (document.getElementById(id).value != '') {
                document.getElementById(id).style.height = "80px";
            }
        }
        function collapseBox(id) {
            document.getElementById(id).style.height = "30px";
        }

        function appendDDLHdn(ddlid, hdnid) {
            var senderDDL = document.getElementById(ddlid);
            var senderHDN = document.getElementById(hdnid);
            document.getElementById(hdnid).value = senderDDL.options[senderDDL.selectedIndex].value;
        }

        function formatResult(txtid, DecimalPlaces) {
            var txtValue = document.getElementById(txtid).value;
            if (txtValue != null && $.trim(txtValue).length > 0 && !isNaN(txtValue)) {
                document.getElementById(txtid).value = +txtValue;
                if (DecimalPlaces != null && $.trim(DecimalPlaces).length > 0 && !isNaN(DecimalPlaces)) {
                    var decimalPlace = parseInt(DecimalPlaces);
                    if (decimalPlace > 0) {
                        document.getElementById(txtid).value = parseFloat(document.getElementById(txtid).value).toFixed(decimalPlace);
                    }
                }
            }
           // return false;
        }

        function GetDeviceValue(OrgId, VisitId, InvestigationID) {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vNoDeviceValue = SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_02') == null ? "No Device Value Found" : SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_02');
            var vCode = SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_05') == null ? "\nError Code:" : SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_05');
            var vDescription = SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_06') == null ? "\nError Description:" : SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_06');
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetDeviceValue",
                    data: "{OrgId: " + OrgId + ", VisitId:'" + VisitId + "', InvestigationID:'" + InvestigationID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        var lstDeviceValue = data.d;
                        if (lstDeviceValue.length > 0) {
                            var msg = "Following are the device value for test: " + lstDeviceValue[0].Name;
                            $.each(lstDeviceValue, function(i, obj) {
                                msg = msg + "\n" + obj.DeviceValue;
                            });
                            msg = msg + "" + vCode + " " + lstDeviceValue[0].ErrorCode + "" + vDescription + " " + lstDeviceValue[0].ErrorDescription
                            ValidationWindow(msg, AlertType);
                        }   
                        else {
                            ValidationWindow(vNoDeviceValue, AlertType);
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                    ValidationWindow(xhr.status, AlertType);
                    }
                });
            }
            catch (e) {
                return false;
            }
        }

        function ChangeComputationFieldEditOption(txtid) {
            try {
                var lstEditableFormulaFields = '';
                if (document.getElementById('hdnEditableFormulaFields') != null) {
                    lstEditableFormulaFields = document.getElementById('hdnEditableFormulaFields').value;
                    if (lstEditableFormulaFields.indexOf(txtid) >= 0) {
                        lstEditableFormulaFields = lstEditableFormulaFields.replace(txtid + "^", "").replace(txtid, "");
                        document.getElementById('hdnEditableFormulaFields').value = lstEditableFormulaFields;
                        ChecKGroupSum(txtid);
                    }
                    else {
                        lstEditableFormulaFields = lstEditableFormulaFields + txtid + "^";
                        document.getElementById('hdnEditableFormulaFields').value = lstEditableFormulaFields;
                    }
                }
            }
            catch (e) {
                return false;
            }
        }
        function onAutoSave() {
            try {
                var hdnLstControlID = JSON.parse($('#hdnLstControlID').val());
                var hdnLstPatternID = JSON.parse($('#hdnLstPatternID').val());
                var lstInvValues = [];
                var lstPatInv = [];
                var lstOfInvValues = [];
                var controlID = '';
                var LID = document.getElementById('hdnLID').value;
                var OrgID = document.getElementById('hdnOrgID').value;
                var lstImagePattern = [];
                var ChkorNot='';
                
                for (var i = 0; i < hdnLstControlID.length; i++) {
                    controlID = hdnLstControlID[i];
                    lstInvValues = [];
                    switch (hdnLstPatternID[i]) {
                        case 1:
                      
                            var Value = document.getElementById(controlID + '_txtValue').value;
                            var ddlstatus = document.getElementById(controlID + '_ddlstatus').value;
                            var Status = ddlstatus.split('_')[0];
                            var isSave = true;
                            if (Value == '' && Status == 'Pending') {
                                isSave = false;
                            }
                            if (isSave) {
                                var Name = document.getElementById(controlID + '_lblName').innerHTML;
                                var InvID = document.getElementById(controlID + '_lblInvID').innerHTML;
                                var VisitID = document.getElementById(controlID + '_lblPVisitID').innerHTML;
                                var Unit = document.getElementById(controlID + '_lblUnit').innerHTML;
                                var GroupID = document.getElementById(controlID + '_hdnGroupID').value;
                                var GroupName = document.getElementById(controlID + '_hdnGroupName').value;
                                var PackageID = document.getElementById(controlID + '_hdnPackageID').value;
                                var PackageName = document.getElementById(controlID + '_hdnPackageName').value;
                                var Dilution = document.getElementById(controlID + '_txtDilution').value;
                                var UID = document.getElementById(controlID + '_hdnUID').value;
                                var RefRange = document.getElementById(controlID + '_txtRefRange').value;
                                if (RefRange != '') {
                                    RefRange = replaceAll('\n', '<br>', RefRange);
                                }
                                var Reason = document.getElementById(controlID + '_txtReason').value;
                                var MedRemarks = document.getElementById(controlID + '_txtMedRemarks').value;
                                var AutoApproveLoginID = document.getElementById(controlID + '_hdnAutoApproveLoginID').value;
                                var AccessionNumber = document.getElementById(controlID + '_hdnAccessionNumber').value;
                                var LabNo = document.getElementById(controlID + '_hdnLabNo').value;
                                var hdnstatusreason = document.getElementById(controlID + '_hdnstatusreason').value;
                                var InvStatusReasonID = 0;
                                if (hdnstatusreason != '') {
                                    var lststatusreason = hdnstatusreason.split('~');
                                    InvStatusReasonID = lststatusreason[0];
                                    Reason = lststatusreason[1];
                                }
                                var OpinionUser = document.getElementById(controlID + '_hdnOpinionUser').value;
                                var OpinionLoginID = 0;
                                if (OpinionUser != null && OpinionUser != '') {
                                    OpinionLoginID = OpinionUser;
                                }
                                var IsAbnormal = document.getElementById(controlID + '_hdnIsAbnormal').value;
                                var RemarksID = 0;
                                var remarks = document.getElementById(controlID + '_hdnRemarksID').value;
                                if (remarks != '') {
                                    RemarksID = remarks;
                                }
                                var RefAppendString = document.getElementById(controlID + '_hdnRefAppendString').value;
                                var PrintableRange = document.getElementById(controlID + '_hdnPrintableRange').value;
                                if (PrintableRange != '') {
                                    PrintableRange = replaceAll('\n', '<br>', PrintableRange);
                                }
                                var IsAutoValidate = document.getElementById(controlID + '_hdnIsAutoValidate').value;
                                var ConvValue;
                                var ConvUOMCode = document.getElementById(controlID + '_hdnConvUOM').value;
                                var ConvFactor = document.getElementById(controlID + '_hdnConvFactor').value;
                                var ConvDecimal = document.getElementById(controlID + '_hdnConvDecimalPoint').value;
                                if (ConvFactor != '' && ConvFactor != 0) {
                                    ConvValue = $.trim((Value * ConvFactor).toFixed(ConvDecimal));
                                }
                                
                                else {
                                    ConvValue = 0;
                                }
                                var ConvReferenceRange = document.getElementById(controlID + '_hdnConvReferenceRange').value;

//          $("#ParthibanChk tr:not(:first)").each(function () { 
//                  var valueOfCell = $(this).find('td:last-child').text();
//                  var bool = valueOfCell != '';
//                 var checkbox  = $(this).find(":checkbox") 
//                 checkbox[0].checked = bool; 
//              });
              
//        $('ParthibanChk tr').each(function(i) {
//    // Cache checkbox selector
//    var $chkbox = $(this).find('input[type="checkbox"]');

//    // Only check rows that contain a checkbox
//    if($chkbox.length) {
//    var status = $chkbox.prop('checked');
//        console.log('Table row '+i+' contains a checkbox with a checked status of: '+status);
//         ChkorNot="Checked";
//    }
//});

//                                 var selectedRows = $( 'table.ParthibanChk' ).find( 'tbody' ) // select table body and
//            .find( 'tr' ) // select all rows that has
//            .has( 'input[type=checkbox]:checked' ) // checked checkbox element
//        console.log( 'selectedRows:', selectedRows );
//                             var result= $("tr:has(:checked)")
//                              if (result.length < 2) {
//                              ChkorNot="Checked";
//                              }
                                var checkboxes=$('#DInvest tbody').find('input[bulk="checkbox"]');
                                  if($(checkboxes[i]).is(':checked'))
                              {
                                ChkorNot="Checked";
                              }
                              else{
                              ChkorNot="UNChecked"
                              }
//                                 $('#ParthibanChk  tr').each(function (i, row) {
//                              var $actualrow = $(row);
//                              var Getrow=$actualrow.find('td')[0];
//                              var chkbox=$(Getrow).find('input[type="checkbox"]');
                            
//                          $checkbox = $actualrow.find('input:checked');
//                         console.log($checkbox);
                           //ChkorNot="Checked";
                             //});
//                                if($('[type="checkbox"]').is(":checked")){
//                               
//                                }else{
//                                
//                                }
//                                

//$.each($("input[name='case[]']:checked").closest("td").siblings("td"), function() {
// ChkorNot="checked";
// });
                                if(ChkorNot=="Checked"){
                                 
                                lstInvValues.push({
                                    Name: Name,
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Value: Value,
                                    UOMCode: Unit,
                                    CreatedBy: LID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    Orgid: OrgID,
                                    Status: Status,
                                    PackageID: PackageID,
                                    PackageName: PackageName,
                                    Dilution: Dilution,
                                    UID: UID,
                                    ConvValue: ConvValue,
                                    ConvUOMCode: ConvUOMCode,
                                    ChkorNot:ChkorNot
                                });
                                lstPatInv.push({
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Status: Status,
                                    ReferenceRange: RefRange,
                                    Reason: Reason,
                                    MedicalRemarks: MedRemarks,
                                    OrgID: OrgID,
                                    AutoApproveLoginID: AutoApproveLoginID,
                                    AccessionNumber: AccessionNumber,
                                    UID: UID,
                                    LabNo: LabNo,
                                    InvStatusReasonID: InvStatusReasonID,
                                    LoginID: OpinionLoginID,
                                    GroupID: GroupID,
                                    IsAbnormal: IsAbnormal,
                                    RemarksID: RemarksID,
                                    GroupName: RefAppendString,
                                    PrintableRange: PrintableRange,
                                    IsAutoValidate: IsAutoValidate,
                                    ConvReferenceRange: ConvReferenceRange
                                });
                                lstOfInvValues.push(lstInvValues);
                               }
                            }
                            break;
                        case 2:
                            var ddlValue = '';
                            var hdnDDL = document.getElementById(controlID + '_hdnDDL').value;
                            var ddl = document.getElementById(controlID + '_ddlData');
                            var ddlData = ddl.options[ddl.selectedIndex].text;
                            if (hdnDDL == "" || hdnDDL == "0") {
                                ddlValue = ddlData;
                            }
                            else {
                                ddlValue = hdnDDL;
                            }
                            var txtValue = document.getElementById(controlID + '_txtValue').value;
                            var ddlstatus = document.getElementById(controlID + '_ddlstatus').value;
                            var Status = ddlstatus.split('_')[0];
                            var isSave = true;
                            if (ddlValue == "Select" && txtValue == '' && Status == 'Pending') {
                                isSave = false;
                            }
                            if (isSave) {
                                var Value = '';
                                if (ddlValue != "Select") {
                                    if (txtValue == "") {
                                        Value = ddlValue;
                                    }
                                    else {
                                        Value = ddlValue + "," + txtValue;
                                    }
                                }
                                else if (txtValue != "") {
                                    Value = txtValue;
                                }
                                var Name = document.getElementById(controlID + '_lblName').innerHTML;
                                var InvID = document.getElementById(controlID + '_lblInvID').innerHTML;
                                var VisitID = document.getElementById(controlID + '_lblPVisitID').innerHTML;
                                var Unit = document.getElementById(controlID + '_lblUOM').innerHTML;
                                var GroupID = document.getElementById(controlID + '_hdnGroupID').value;
                                var GroupName = document.getElementById(controlID + '_hdnGroupName').value;
                                var PackageID = document.getElementById(controlID + '_hdnPackageID').value;
                                var PackageName = document.getElementById(controlID + '_hdnPackageName').value;
                                var Dilution = document.getElementById(controlID + '_txtDilution').value;
                                var UID = document.getElementById(controlID + '_hdnUID').value;
                                var RefRange = document.getElementById(controlID + '_txtRefRange').value;
                                if (RefRange != '') {
                                    RefRange = replaceAll('\n', '<br>', RefRange);
                                }
                                var Reason = document.getElementById(controlID + '_txtReason').value;
                                var MedRemarks = document.getElementById(controlID + '_txtMedRemarks').value;
                                var AutoApproveLoginID = document.getElementById(controlID + '_hdnAutoApproveLoginID').value;
                                var AccessionNumber = document.getElementById(controlID + '_hdnAccessionNumber').value;
                                var LabNo = document.getElementById(controlID + '_hdnLabNo').value;
                                var hdnstatusreason = document.getElementById(controlID + '_hdnstatusreason').value;
                                var InvStatusReasonID = 0;
                                if (hdnstatusreason != '') {
                                    var lststatusreason = hdnstatusreason.split('~');
                                    InvStatusReasonID = lststatusreason[0];
                                    Reason = lststatusreason[1];
                                }
                                var OpinionUser = document.getElementById(controlID + '_hdnOpinionUser').value;
                                var OpinionLoginID = 0;
                                if (OpinionUser != null && OpinionUser != '') {
                                    OpinionLoginID = OpinionUser;
                                }
                                var IsAbnormal = document.getElementById(controlID + '_hdnIsAbnormal').value;
                                var RemarksID = 0;
                                var remarks = document.getElementById(controlID + '_hdnRemarksID').value;
                                if (remarks != '') {
                                    RemarksID = remarks;
                                }
                                var PrintableRange = document.getElementById(controlID + '_hdnPrintableRange').value;
                                if (PrintableRange != '') {
                                    PrintableRange = replaceAll('\n', '<br>', PrintableRange);
                                }
                                var IsAutoValidate = document.getElementById(controlID + '_hdnIsAutoValidate').value;

                                lstInvValues.push({
                                    Name: Name,
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Value: Value,
                                    UOMCode: Unit,
                                    CreatedBy: LID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    Orgid: OrgID,
                                    Status: Status,
                                    PackageID: PackageID,
                                    PackageName: PackageName,
                                    Dilution: Dilution,
                                    UID: UID
                                });
                                lstPatInv.push({
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Status: Status,
                                    ReferenceRange: RefRange,
                                    Reason: Reason,
                                    MedicalRemarks: MedRemarks,
                                    OrgID: OrgID,
                                    AutoApproveLoginID: AutoApproveLoginID,
                                    AccessionNumber: AccessionNumber,
                                    UID: UID,
                                    LabNo: LabNo,
                                    InvStatusReasonID: InvStatusReasonID,
                                    LoginID: OpinionLoginID,
                                    GroupID: GroupID,
                                    IsAbnormal: IsAbnormal,
                                    RemarksID: RemarksID,
                                    GroupName: GroupName,
                                    PrintableRange: PrintableRange,
                                    IsAutoValidate: IsAutoValidate
                                });
                                lstOfInvValues.push(lstInvValues);
                            }
                            break;
                        case 3:
                            var ddlValue = '';
                            var hdnDDL = document.getElementById(controlID + '_hdnDDL').value;
                            var ddl = document.getElementById(controlID + '_ddlData');
                            var ddlData = ddl.options[ddl.selectedIndex].text;
                            if (hdnDDL == "" || hdnDDL == "0") {
                                ddlValue = ddlData;
                            }
                            else {
                                ddlValue = hdnDDL;
                            }
                            var ddlstatus = document.getElementById(controlID + '_ddlstatus').value;
                            var Status = ddlstatus.split('_')[0];
                            var isSave = true;
                            if (ddlValue == "Select" && Status == 'Pending') {
                                isSave = false;
                            }
                            if (isSave) {
                                var Value = (ddlValue == "Select" ? "" : ddlValue);
                                var Name = document.getElementById(controlID + '_lblName').innerHTML;
                                var InvID = document.getElementById(controlID + '_lblInvID').innerHTML;
                                var VisitID = document.getElementById(controlID + '_lblPVisitID').innerHTML;
                                var Unit = document.getElementById(controlID + '_lblUOM').innerHTML;
                                var GroupID = document.getElementById(controlID + '_hdnGroupID').value;
                                var GroupName = document.getElementById(controlID + '_hdnGroupName').value;
                                var PackageID = document.getElementById(controlID + '_hdnPackageID').value;
                                var PackageName = document.getElementById(controlID + '_hdnPackageName').value;
                                var Dilution = document.getElementById(controlID + '_txtDilution').value;
                                var UID = document.getElementById(controlID + '_hdnUID').value;
                                var RefRange = document.getElementById(controlID + '_txtRefRange').value;
                                if (RefRange != '') {
                                    RefRange = replaceAll('\n', '<br>', RefRange);
                                }
                                var Reason = document.getElementById(controlID + '_txtReason').value;
                                var MedRemarks = document.getElementById(controlID + '_txtMedRemarks').value;
                                var AutoApproveLoginID = document.getElementById(controlID + '_hdnAutoApproveLoginID').value;
                                var AccessionNumber = document.getElementById(controlID + '_hdnAccessionNumber').value;
                                var LabNo = document.getElementById(controlID + '_hdnLabNo').value;
                                var hdnstatusreason = document.getElementById(controlID + '_hdnstatusreason').value;
                                var InvStatusReasonID = 0;
                                if (hdnstatusreason != '') {
                                    var lststatusreason = hdnstatusreason.split('~');
                                    InvStatusReasonID = lststatusreason[0];
                                    Reason = lststatusreason[1];
                                }
                                var OpinionUser = document.getElementById(controlID + '_hdnOpinionUser').value;
                                var OpinionLoginID = 0;
                                if (OpinionUser != null && OpinionUser != '') {
                                    OpinionLoginID = OpinionUser;
                                }
                                var IsAbnormal = document.getElementById(controlID + '_hdnIsAbnormal').value;
                                var RemarksID = 0;
                                var remarks = document.getElementById(controlID + '_hdnRemarksID').value;
                                if (remarks != '') {
                                    RemarksID = remarks;
                                }
                                var PrintableRange = document.getElementById(controlID + '_hdnPrintableRange').value;
                                if (PrintableRange != '') {
                                    PrintableRange = replaceAll('\n', '<br>', PrintableRange);
                                }
                                var IsAutoValidate = document.getElementById(controlID + '_hdnIsAutoValidate').value;

                                lstInvValues.push({
                                    Name: Name,
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Value: Value,
                                    UOMCode: Unit,
                                    CreatedBy: LID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    Orgid: OrgID,
                                    Status: Status,
                                    PackageID: PackageID,
                                    PackageName: PackageName,
                                    Dilution: Dilution,
                                    UID: UID
                                });
                                lstPatInv.push({
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Status: Status,
                                    ReferenceRange: RefRange,
                                    Reason: Reason,
                                    MedicalRemarks: MedRemarks,
                                    OrgID: OrgID,
                                    AutoApproveLoginID: AutoApproveLoginID,
                                    AccessionNumber: AccessionNumber,
                                    UID: UID,
                                    LabNo: LabNo,
                                    InvStatusReasonID: InvStatusReasonID,
                                    LoginID: OpinionLoginID,
                                    GroupID: GroupID,
                                    IsAbnormal: IsAbnormal,
                                    RemarksID: RemarksID,
                                    GroupName: GroupName,
                                    PrintableRange: PrintableRange,
                                    IsAutoValidate: IsAutoValidate
                                });
                                lstOfInvValues.push(lstInvValues);
                            }
                            break;
                        case 46:
                            var Value = document.getElementById(controlID + '_txtValue').value;
                            var ddlstatus = document.getElementById(controlID + '_ddlstatus').value;
                            var Status = ddlstatus.split('_')[0];
                            var isSave = true;
                            if (Value == "" && Status == 'Pending') {
                                isSave = false;
                            }
                            if (isSave) {
                                var Name = document.getElementById(controlID + '_lblName').innerHTML;
                                var InvID = document.getElementById(controlID + '_lblInvID').innerHTML;
                                var VisitID = document.getElementById(controlID + '_lblPVisitID').innerHTML;
                                var GroupID = document.getElementById(controlID + '_hdnGroupID').value;
                                var GroupName = document.getElementById(controlID + '_hdnGroupName').value;
                                var UID = document.getElementById(controlID + '_hdnUID').value;
                                var Reason = '';
                                var MedRemarks = document.getElementById(controlID + '_txtMedRemarks').value;
                                var LabNo = document.getElementById(controlID + '_hdnLabNo').value;
                                var AccessionNumber = document.getElementById(controlID + '_hdnAccessionNumber').value;
                                var hdnstatusreason = document.getElementById(controlID + '_hdnstatusreason').value;
                                var InvStatusReasonID = 0;
                                if (hdnstatusreason != '') {
                                    var lststatusreason = hdnstatusreason.split('~');
                                    InvStatusReasonID = lststatusreason[0];
                                    Reason = lststatusreason[1];
                                }
                                var OpinionUser = document.getElementById(controlID + '_hdnOpinionUser').value;
                                var OpinionLoginID = 0;
                                if (OpinionUser != null && OpinionUser != '') {
                                    OpinionLoginID = OpinionUser;
                                }
                                var IsAutoValidate = document.getElementById(controlID + '_hdnIsAutoValidate').value;

                                lstInvValues.push({
                                    Name: Name,
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Value: Value,
                                    CreatedBy: LID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    Orgid: OrgID,
                                    Status: Status,
                                    UID: UID
                                });
                                lstPatInv.push({
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Status: Status,
                                    Reason: Reason,
                                    MedicalRemarks: MedRemarks,
                                    OrgID: OrgID,
                                    UID: UID,
                                    LabNo: LabNo,
                                    InvStatusReasonID: InvStatusReasonID,
                                    LoginID: OpinionLoginID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    AccessionNumber: AccessionNumber,
                                    IsAutoValidate: IsAutoValidate
                                });
                                lstOfInvValues.push(lstInvValues);
                            }
                            break;
                        case 49:
                            var Value = document.getElementById(controlID + '_txtValue').value;
                            var ddlstatus = document.getElementById(controlID + '_ddlstatus').value;
                            var Status = ddlstatus.split('_')[0];
                            var isSave = true;
                            if (Value == "" && Status == 'Pending') {
                                isSave = false;
                            }
                            if (isSave) {
                                var Name = document.getElementById(controlID + '_lblName').innerHTML;
                                var InvID = document.getElementById(controlID + '_lblInvID').innerHTML;
                                var VisitID = document.getElementById(controlID + '_lblPVisitID').innerHTML;
                                var GroupID = document.getElementById(controlID + '_hdnGroupID').value;
                                var GroupName = document.getElementById(controlID + '_hdnGroupName').value;
                                var UID = document.getElementById(controlID + '_hdnUID').value;
                                var Reason = '';
                                var MedRemarks = document.getElementById(controlID + '_txtMedRemarks').value;
                                var LabNo = document.getElementById(controlID + '_hdnLabNo').value;
                                var AccessionNumber = document.getElementById(controlID + '_hdnAccessionNumber').value;
                                var hdnstatusreason = document.getElementById(controlID + '_hdnstatusreason').value;
                                var InvStatusReasonID = 0;
                                if (hdnstatusreason != '') {
                                    var lststatusreason = hdnstatusreason.split('~');
                                    InvStatusReasonID = lststatusreason[0];
                                    Reason = lststatusreason[1];
                                }
                                var OpinionUser = document.getElementById(controlID + '_hdnOpinionUser').value;
                                var OpinionLoginID = 0;
                                if (OpinionUser != null && OpinionUser != '') {
                                    OpinionLoginID = OpinionUser;
                                }
                                var IsAutoValidate = document.getElementById(controlID + '_hdnIsAutoValidate').value;

                                lstInvValues.push({
                                    Name: Name,
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Value: Value,
                                    CreatedBy: LID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    Orgid: OrgID,
                                    Status: Status,
                                    UID: UID
                                });
                                lstPatInv.push({
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Status: Status,
                                    Reason: Reason,
                                    MedicalRemarks: MedRemarks,
                                    OrgID: OrgID,
                                    UID: UID,
                                    LabNo: LabNo,
                                    InvStatusReasonID: InvStatusReasonID,
                                    LoginID: OpinionLoginID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    AccessionNumber: AccessionNumber,
                                    IsAutoValidate: IsAutoValidate
                                });
                                lstOfInvValues.push(lstInvValues);
                            }
                            break;
                        case 45:
                            var ddlstatus = document.getElementById(controlID + '_ddlstatus').value;
                            var Status = ddlstatus.split('_')[0];
                            var isSave = true;
                            if (isSave) {
                                var Name = document.getElementById(controlID + '_lblName').innerHTML;
                                var InvID = document.getElementById(controlID + '_lblInvID').innerHTML;
                                var VisitID = document.getElementById(controlID + '_lblPVisitID').innerHTML;
                                var GroupID = document.getElementById(controlID + '_hdnGroupID').value;
                                var GroupName = document.getElementById(controlID + '_hdnGroupName').value;
                                var UID = document.getElementById(controlID + '_hdnUID').value;
                                var Reason = '';
                                var MedRemarks = document.getElementById(controlID + '_txtMedRemarks').value;
                                var LabNo = document.getElementById(controlID + '_hdnLabNo').value;
                                var AccessionNumber = document.getElementById(controlID + '_hdnAccessionNumber').value;
                                var hdnstatusreason = document.getElementById(controlID + '_hdnstatusreason').value;
                                var InvStatusReasonID = 0;
                                if (hdnstatusreason != '') {
                                    var lststatusreason = hdnstatusreason.split('~');
                                    InvStatusReasonID = lststatusreason[0];
                                    Reason = lststatusreason[1];
                                }
                                var OpinionUser = document.getElementById(controlID + '_hdnOpinionUser').value;
                                var OpinionLoginID = 0;
                                if (OpinionUser != null && OpinionUser != '') {
                                    OpinionLoginID = OpinionUser;
                                }
                                var IsAutoValidate = document.getElementById(controlID + '_hdnIsAutoValidate').value;

                                lstInvValues.push({
                                    Name: Name,
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Value: '',
                                    CreatedBy: LID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    Orgid: OrgID,
                                    Status: Status,
                                    UID: UID
                                });
                                lstPatInv.push({
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    Status: Status,
                                    Reason: Reason,
                                    MedicalRemarks: MedRemarks,
                                    OrgID: OrgID,
                                    UID: UID,
                                    LabNo: LabNo,
                                    InvStatusReasonID: InvStatusReasonID,
                                    LoginID: OpinionLoginID,
                                    GroupID: GroupID,
                                    GroupName: GroupName,
                                    AccessionNumber: AccessionNumber,
                                    IsAutoValidate: IsAutoValidate
                                });
                                lstOfInvValues.push(lstInvValues);
                                lstImagePattern.push({
                                    InvestigationID: InvID,
                                    PatientVisitID: VisitID,
                                    AccessionNumber: AccessionNumber
                                });
                            }
                            break;
                    }
                }
                document.getElementById('hdnInvValues').value = JSON.stringify(lstOfInvValues);
                document.getElementById('hdnPatInv').value = JSON.stringify(lstPatInv);
                document.getElementById('hdnLstImagePattern').value = JSON.stringify(lstImagePattern);
            }
            catch (e) {
                return false;
            }
        }
        function OnDirectApproval() {
      // $('input[bulk=checkbox]').change(function() {
   // var checks = $(this).parent().find('#ChkAppr');
  // var checks= $('#drawNewPattern').find('input[bulk="checkbox"]');

//    var allChecked = true;
//    var Count=0;
//    $.each(checks, function(idx, value) {
//        if (!$(this).is(':checked')) {
//        var Count=Count+1;
//        }

var checked =  $('#drawNewPattern').find('input[bulk="checkbox"]:checked').length;
//var checked = $('#drawNewPattern').find('input[bulk="checkbox"]');//.length > 0;

    if (checked==0){
        alert("Please check at least one checkbox");
        return false;
    }
         
//});
  else
  {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vGraphImage = SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_03') == null ? "Graph or image is not yet uploaded for some of the visit(s). Do you want to continue?" : SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_03');
            try {
                if (document.getElementById("hdnActionName").value == "Validate") {
                    if (document.getElementById("hdnNoGraphAttached").value != "") {
                        if (!ConfirmWindow(vGraphImage)) {
                            return false
                        }
                    }
                }
                
                try {
                    if (!ValidationFuntionEmptyValueFuntion()) {
                        return false;
                    }
                }
                catch (e) {
                }

                try {
                    if (!CheckSaveValidationFuntion()) {
                        return false;
                    }
                } catch (e) {

                }
                onAutoSave();
                document.getElementById('hdnButtonName').value = "save";
                document.getElementById('hdnDirectApproval').value = "1";
                var hdnOutOfRangeDetails = document.getElementById('hdnOutOfRangeDetails').value;
                var lstOutOfRangeDetails = {};
                if (hdnOutOfRangeDetails != "") {
                    lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
                }
                var hdnHighRangeDetails = document.getElementById('hdnHighRangeDetails').value;
                var lstHighRangeDetails = {};
                if (hdnHighRangeDetails != "") {
                    lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
                }
                var lstHign = [];
                for (prop1 in lstHighRangeDetails) {
                    lstHign.push(
                    {
                        Name: prop1,
                        Value: lstHighRangeDetails[prop1]
                    });
                }
                if (lstHign.length > 0) {
                    document.getElementById('hdnhigh').value = JSON.stringify(lstHign);
                }
                var lstTestName = "";
                for (property in lstOutOfRangeDetails) {
                    lstTestName += lstOutOfRangeDetails[property];
                }
                return postbackButtonClick();
            }
            catch (e) {
                return false;
            }
        }
        
//        else
//        
//        {
//        document.getElementById('hdnCheckCount').value=Count;
//        alert("Please select one Test");
//        return false;
//        }
       }
        function OffDirectApproval() {
            try {
                document.getElementById('hdnDirectApproval').value = "0";
                var hdnOutOfRangeDetails = document.getElementById('hdnOutOfRangeDetails').value;
                var lstOutOfRangeDetails = {};
                if (hdnOutOfRangeDetails != "") {
                    lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
                }
                var hdnHighRangeDetails = document.getElementById('hdnHighRangeDetails').value;
                var lstHighRangeDetails = {};
                if (hdnHighRangeDetails != "") {
                    lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
                }
                var lstHign = [];
                for (prop1 in lstHighRangeDetails) {
                    lstHign.push(
                    {
                        Name: prop1,
                        Value: lstHighRangeDetails[prop1]
                    });
                }
                if (lstHign.length > 0) {
                    document.getElementById('hdnhigh').value = JSON.stringify(lstHign);
                }
                var lstTestName = "";
                for (property in lstOutOfRangeDetails) {
                    lstTestName += lstOutOfRangeDetails[property];
                }
                return true;
            }
            catch (e) {
                return false;
            }
        }
        function HideAbnormalPopup() {
            $find("mpeAttributeLocation").hide();
            return false;
        }
        //code added for reference range - end
        function SelectedInvestigation(source, eventArgs) {
            var TestDetails = eventArgs.get_value();
            var lstTestDetails = TestDetails.split('~');
            var TestName = lstTestDetails[0];
            var TestID = lstTestDetails[1];
            var TestType = lstTestDetails[2];
            $('#hdnTestName').val(TestName);
            $('#hdnTestID').val(TestID);
            $('#hdnTestType').val(TestType);
        }
        function ClearTestDetails() {
            if (document.getElementById('txtInvestigationName') != null) {
                document.getElementById('txtInvestigationName').value = '';
            }
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = '';
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = '';
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = '';
            }
        }
         function ClearTestDetails1() {
            if (document.getElementById('txtInvestigationName1') != null) {
                document.getElementById('txtInvestigationName1').value = '';
            }
            if (document.getElementById('hdnTestName1') != null) {
                document.getElementById('hdnTestName1').value = '';
            }
            if (document.getElementById('hdnTestID1') != null) {
                document.getElementById('hdnTestID1').value = '';
            }
            if (document.getElementById('hdnTestType1') != null) {
                document.getElementById('hdnTestType1').value = '';
            }
        }
        function BatchValidation() {
            /* Added By Venkatesh S */
             if (document.getElementById("hdnActionName").value == "Approvel") {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vEnterWorklistID = SListForAppMsg.Get('Investigation_BulkApprovel_aspx_04') == null ? "Enter Analyzer or Department or Header/Section or Visit Number or Test name" : SListForAppMsg.Get('Investigation_BulkApprovel_aspx_04');
            try {
                var ddlDevice = $("#ddlInstrument :selected").val();
                var ddlDept = $("#ddlDept :selected").val();
                var ddlHeader = $("#ddlHeader :selected").val();
                var ddlProtocol = $("#ddlProtocol :selected").val();
                if (ddlProtocol == '0' && $('#txtPatientID').val() == "" && ddlHeader == '0' && ddlDept == '0' && ddlDevice == '0' && ($('#txtFromVisitID').val() == "" || $('#txtFromVisitID').val() == "0") && ($('#txtToVisitID').val() == "" || $('#txtToVisitID').val() == "0") && ($('#txtWorkListID').val() == "" || $('#txtWorkListID').val() == "0") && ($('#txtInvestigationName').val() == "") && ($('#txtSampleID').val() == "" || $('#txtSampleID').val() == "0")) {
                    ValidationWindow(vEnterWorklistID, AlertType);
                    return false;
                }
                return postbackButtonClick();
            }
            catch (e) {
                return false;
            }
             }
           else if (document.getElementById("hdnActionName").value == "Approval")
           {
             //var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            //var vEnterWorklistID = SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_04') == null ? "Enter WorklistID or Analyzer or Department or Visit Number or Test name or SampleId" : SListForAppMsg.Get('Investigation_BatchWiseEnterresult_aspx_04');
            try {
                var ddlDevice1 = $("#ddlAnalyzer :selected").val();
                var ddlDept1 = $("#ddlDepartment :selected").val();
//                var ddlHeader = $("#ddlHeader :selected").val();
//                var ddlProtocol = $("#ddlProtocol :selected").val();
                if (ddlDept1 == '0' && ddlDevice1 == '0' && ($('#txtFromVisotNO').val() == "" || $('#txtFromVisotNO').val() == "0")) {
                    //ValidationWindow(vEnterWorklistID, AlertType);
                    return false;
                }
              //  return postbackButtonClick();
            }
            catch (e) {
                return false;
            }
           }
        }
        var updateProgress = null;

        function postbackButtonClick() {
            updateProgress = $find("<%= upProgress.ClientID %>");
            window.setTimeout("updateProgress.set_visible(true)", updateProgress.get_displayAfter());
            return true;
        }
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" enctype="multipart/form-data">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="upProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <input id="hdnVID" runat="server" type="hidden" value="0" />
                <input id="hdnHeaderName" runat="server" type="hidden" value="0" />
                <input id="hdnDept" runat="server" type="hidden" value="0" />
                <input id="hdnstatuschange" runat="server" type="hidden" />
                <input id="hdnIsAutoAuthRecollect" runat="server" type="hidden" value="" />
                <asp:HiddenField ID="hdnGenderAge" runat="server" />
                <asp:HiddenField ID="hdnValidateData" runat="server" />
                <asp:HiddenField ID="hdnErrorCount" runat="server" />
                <asp:HiddenField ID="hdnOrgID" runat="server" />
                <asp:HiddenField ID="hdnhigh" runat="server" Value="" />
                <asp:HiddenField ID="hdnRecollectCountFlag" runat="server" Value="0" />
                <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlFilterResource1">
                    <table class="defaultfontcolor w-100p searchPanel">
                        <tr>
                            <td>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <table class="w-100p" id="tblTotal" runat="server" style="display: none;">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblTotal" runat="server" Text="Total Records: " Font-Size="12" Font-Bold="true"
                                                            meta:resourcekey="lblTotalResource1"></asp:Label>
                                                        <asp:Label ID="lblTotalRecords" runat="server" Text="" Font-Size="12" Font-Bold="true"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblLoaded" runat="server" Text="Loaded Records: " Font-Size="12" Font-Bold="true"
                                                            meta:resourcekey="lblLoadedResource1"></asp:Label>
                                                        <asp:Label ID="lblLoadedRecords" runat="server" Text="" Font-Size="12" Font-Bold="true"></asp:Label>
                                                        <asp:HiddenField ID="hdnTotalLoadedRecords" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="a-center w-20p colorforcontent bold" style="color: White; font-size: medium;">
                                            <asp:Label ID="lblPageHeader" runat="server" Text="Batch Wise Enter Result" meta:resourcekey="lblPageHeaderResource1"></asp:Label>
                                        </td>
                                        <td class="w-20p a-center">
                                            <table class="w-100p" id="tblPageNo" runat="server" style="display: none;">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblPage" runat="server" Text="Page No: " Font-Size="12" Font-Bold="true"
                                                            meta:resourcekey="lblPageResource1"></asp:Label>
                                                        <asp:Label ID="lblPageNo" runat="server" Text="1" Font-Size="12" Font-Bold="true"></asp:Label>
                                                        <asp:HiddenField ID="hdnPageNo" runat="server" Value="1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="w-20p a-right">
                                            <asp:TextBox ID="txtinvcolor" runat="server" Height="5px" meta:resourcekey="txtinvcolorResource1"
                                                ReadOnly="True" Style="background-color: #000000;" TabIndex="-1" Width="5px"></asp:TextBox>
                                            <asp:Label ID="lblinvcolor" runat="server" meta:resourcekey="lblinvcolorResource1"
                                                Text="Investigation"></asp:Label>
                                            &nbsp;
                                            <asp:TextBox ID="txtgrpcolor" runat="server" Height="5px" meta:resourcekey="txtgrpcolorResource1"
                                                ReadOnly="True" Style="background-color: #C71585;" TabIndex="-1" Width="5px"></asp:TextBox>
                                            <asp:Label ID="lblgrpcolor" runat="server" meta:resourcekey="lblgrpcolorResource1"
                                                Text="Group"></asp:Label>
                                            &nbsp;
                                            <asp:TextBox ID="txtpkgcolor" runat="server" Height="5px" meta:resourcekey="txtpkgcolorResource1"
                                                ReadOnly="True" Style="background-color: #6699FF;" TabIndex="-1" Width="5px"></asp:TextBox>
                                            <asp:Label ID="lblpkgcolor" runat="server" meta:resourcekey="lblpkgcolorResource1"
                                                Text="Package"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnBatchSearch" meta:resourcekey="Panel1Resource1">
                                    <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-9p a-right">
                                                    <asp:Label ID="lblanalzer" runat="server" class="style1" meta:resourcekey="lblanalzerResource1"
                                                        Text="Analyzer Name"></asp:Label>
                                                </td>
                                                <td class="w-12p a-right">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlInstrument" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlInstrumentResource1">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="w-10p" id="tdchkIsMaster" style="display: none">
                                                    <asp:CheckBox ID="chkIsMaster" runat="server" meta:resourcekey="chkIsMasterResource1"
                                                        Text="From Master" />
                                                </td>
                                                <td class="w-6p a-right">
                                                    <asp:Label ID="lblDept" runat="server" class="style1" meta:resourcekey="lblDeptResource1"
                                                        Text="Department"></asp:Label>
                                                </td>
                                                <td class="w-12p a-left">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlDept" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlDeptResource1">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="w-10p a-right" id="tdlblHeader" style="display: none">
                                                    <asp:Label ID="lblHeader" runat="server" class="style1" meta:resourcekey="lblHeaderResource1"
                                                        Text="Header / Section"></asp:Label>
                                                </td>
                                                <td class="w-12p a-left" id="tddlHeader" style="display: none">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlHeader" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlHeaderResource1">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="w-10p a-right" id="tdlblProtocol">
                                                    <asp:Label ID="lblProtocol" runat="server" class="style1" meta:resourcekey="lblProtocolResource1"
                                                        Text="Protocol Group"></asp:Label>
                                                </td>
                                                <td class="w-13p a-left" id="tddlProtocol">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlProtocol" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlProtocolResource1">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="w-10p a-right">
                                                    <asp:Label ID="lblResultType" runat="server" class="style1" meta:resourcekey="lblResultTypeResource1"
                                                        Text="Result Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlResultType" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlResultTypeResource1">
                                                        <%--<asp:ListItem meta:resourcekey="ListItemResource1" Selected="True" Text="--Select--"
                                                            Value="0"></asp:ListItem>--%>
                                                        <%--<asp:ListItem meta:resourcekey="ListItemResource2" Text="Normal" Value="N"></asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource3" Text="Abnormal" Value="Y"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="w-10p a-right">
                                                    <asp:Label ID="lblPatientId" runat="server" class="style1" meta:resourcekey="lblPatientTypeResource1"
                                                        Text="PatientID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPatientID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtPatientIDResource1"></asp:TextBox>
                                                    <%--<asp:ListItem meta:resourcekey="ListItemResource1" Selected="True" Text="--Select--"
                                                            Value="0"></asp:ListItem>--%>
                                                    <%--<asp:ListItem meta:resourcekey="ListItemResource2" Text="Normal" Value="N"></asp:ListItem>
                                                        <asp:ListItem meta:resourcekey="ListItemResource3" Text="Abnormal" Value="Y"></asp:ListItem>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-right">
                                                    <asp:Label ID="lblFromVisitID" runat="server" class="style1" meta:resourcekey="lblFromVisitIDResource1"
                                                        Text="From Visit Number"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:TextBox ID="txtFromVisitID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromVisitIDResource1"></asp:TextBox>
                                                </td>
                                                <td id="HidApp">
                                                </td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblToVisitID" runat="server" class="style1" meta:resourcekey="lblToVisitIDResource1"
                                                        Text="To Visit Number"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtToVisitID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtToVisitIDResource1"></asp:TextBox>
                                                </td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblInvestigationName" runat="server" class="style1" meta:resourcekey="lblInvestigationNameResource1"
                                                        Text="Test Name"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:TextBox ID="txtInvestigationName" runat="server" CssClass="searchBox" meta:resourcekey="txtInvestigationNameResource1"
                                                        onfocus="javascript:ClearTestDetails();"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoInvestigations" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtInvestigationName" ServiceMethod="FetchInvestigationNameForOrg"
                                                        ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                        DelimiterCharacters=";,:" OnClientItemSelected="SelectedInvestigation" OnClientShown="TestPopulated">
                                                    </ajc:AutoCompleteExtender>
                                                    &nbsp;
                                                    <asp:HiddenField ID="hdnTestName" runat="server" Value="" />
                                                    <asp:HiddenField ID="hdnTestID" runat="server" Value="" />
                                                    <asp:HiddenField ID="hdnTestType" runat="server" Value="" />
                                                </td>
                                                <td class="a-right" id="tdlblWorkListID">
                                                    <asp:Label ID="lblWorkListID" runat="server" class="style1" meta:resourcekey="lblWorkListIDResource1"
                                                        Text="WorkList ID"></asp:Label>
                                                </td>
                                                <td class="a-left" id="tdtxtWorkListID">
                                                    <asp:TextBox ID="txtWorkListID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtWorkListIDResource1"></asp:TextBox>
                                                </td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblSampleId" runat="server" class="style1" meta:resourcekey="lblSampleIdResource1"
                                                        Text="Barcode Number"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSampleID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtSampleIDResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trApp">
                                                <td class="w-10p a-right">
                                                    <asp:Label ID="lblLocation" runat="server" class="style1" Text="Location"></asp:Label>
                                                </td>
                                                <td class="w-12p a-right">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="w-9p a-right">
                                                    <asp:Label ID="lblVisittype1" runat="server" class="style1" Text="Visit Type"></asp:Label>
                                                </td>
                                                <td class="w-10p a-left">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlVisitType1" runat="server" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="w-9p a-right">
                                                    <asp:Label ID="lblDeltacheck1" runat="server" class="style1" Text="Delta Check"></asp:Label>
                                                </td>
                                                <td class="w-10p a-left">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlDeltaCheck" runat="server" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td class="w-9p a-right">
                                                    <asp:Label ID="lblQcCheck" runat="server" class="style1" Text="QC Check"></asp:Label>
                                                </td>
                                                <td class="w-10p a-right">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList ID="ddlQcCheck" runat="server" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td id="tdchkDefault">
                                                    <asp:CheckBox ID="chkDefault" runat="server" Visible="false" Text="Set Default" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="12" class="a-center">
                                                    <asp:Button ID="btnBatchSearch" runat="server" CssClass="btn" Font-Bold="True" meta:resourcekey="btnBatchSearchResource1"
                                                        OnClick="btnBatchSearch_Click" OnClientClick="return BatchValidation()" Text="Search" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                                <div id="DivApproval" runat="server" visible="false">
                                    <table class="w-100p">
                                        <tr>
                                            <%-- <td class="w-12p a-right">
                                                <asp:Label ID="lblLocation" runat="server" class="style1" Text="Location"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>--%>
                                            <td class="w-12p a-right">
                                                <asp:Label ID="lblAnalyzer1" runat="server" class="style1" Text="Analyzer"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlAnalyzer" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                            <td class="w-12p a-right">
                                                <asp:Label ID="lblDepartments" runat="server" class="style1" Text="Department"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                            <td class="w-12p a-right">
                                                <asp:Label ID="lblresultTypes" runat="server" class="style1" Text="Result Type"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlResultypes" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                            <td class="w-12p a-right">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-10p a-right">
                                                <asp:Label ID="lblFromVisitNo" runat="server" class="style1" Text="From VisitNo"></asp:Label>
                                            </td>
                                            <td class="w-12p a-left">
                                                <span class="richcombobox">
                                                    <asp:TextBox ID="txtFromVisotNO" runat="server"></asp:TextBox>
                                                </span>
                                            </td>
                                            <td class="w-12p a-right">
                                                <asp:Label ID="lblToVisitNo" runat="server" class="style1" Text="To VisitNo"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:TextBox ID="txtToVisitNO" runat="server"></asp:TextBox>
                                                </span>
                                            </td>
                                            <td class="w-12p a-right">
                                                <asp:Label ID="lblTestNames" runat="server" class="style1" Text="Test Name"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:TextBox ID="txtInvestigationName1" runat="server" CssClass="searchBox" meta:resourcekey="txtInvestigationName1Resource"
                                                        onfocus="javascript:ClearTestDetails1();"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtInvestigationName1" ServiceMethod="FetchInvestigationNameForOrg"
                                                        ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                        DelimiterCharacters=";,:" OnClientItemSelected="SelectedInvestigation" OnClientShown="TestPopulated">
                                                    </ajc:AutoCompleteExtender>
                                                    &nbsp;
                                                    <asp:HiddenField ID="hdnTestName1" runat="server" Value="" />
                                                    <asp:HiddenField ID="hdnTestID1" runat="server" Value="" />
                                                    <asp:HiddenField ID="hdnTestType1" runat="server" Value="" />
                                            </td>
                                            <td class="w-12p a-right">
                                                <asp:Label ID="lblBarcodeNo" runat="server" class="style1" Text="Barcode No"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:TextBox ID="txtBarcodeNo" runat="server"></asp:TextBox>
                                                </span>
                                            </td>
                                            <td class="w-12p a-right">
                                            </td>
                                        </tr>
                                        <tr>
                                            <%-- <td class="w-12p a-right">
                                                <asp:Label ID="lblVisittype1" runat="server" class="style1" Text="Visit Type"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlVisitType1" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>--%>
                                            <%--   <td class="w-12p a-right">
                                                <asp:Label ID="lblDeltacheck1" runat="server" class="style1" Text="Delta Check"></asp:Label>
                                            </td>
                                           <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlDeltaCheck" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                            <td class="w-12p a-right">
                                                <asp:Label ID="lblQcCheck" runat="server" class="style1" Text="QC Check"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                                <span class="richcombobox">
                                                    <asp:DropDownList ID="ddlQcCheck" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>--%>
                                            <td class="w-12p a-right">
                                                <%--  <asp:CheckBox ID="chkDefault" runat="server" Text="Set Default" />--%>
                                            </td>
                                            <td colspan="2" class="w-12p a-right">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="12" class="a-center">
                                                <asp:Button ID="btnBatchSearch1" runat="server" CssClass="btn" Font-Bold="True" meta:resourcekey="btnBatchSearchResource1"
                                                    OnClick="btnBatchSearch_Click" OnClientClick="return BatchValidation()" Text="Search" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Label ID="lblResult" runat="server" ForeColor="#000333" meta:resourcekey="lblResultResource1"
                    Visible="False">No Matching Records Found!</asp:Label>
                <table id="ucSCTab" runat="server" style="display: table;" class="w-100p">
                    <tr>
                        <td>
                            <div id="DInvest" runat="server" style="display: none;">
                                <table id="captureTab" style="display: table;" class="w-100p">
                                    <tr id="trRangeColor" runat="server" style="display: table-row;">
                                        <td class="v-top h-30">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-center">
                                                        <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnApproval_Click"
                                                            OnClientClick="javascript:return OnDirectApproval();" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" Text="Save" Width="100" meta:resourcekey="btnSaveResource1" />
                                                        <asp:Button ID="btncancel" runat="server" CssClass="btn" OnClick="Button1_Click"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel"
                                                            Width="100" OnClientClick="javascript:OnCancelSet();" meta:resourcekey="btncancelResource1" />
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:ImageButton ID="imgNextPage" runat="server" ImageUrl="~/Images/nextimage.png"
                                                            OnClick="imgNextPage_Click" OnClientClick="return BatchValidation()" Width="40"
                                                            Height="30" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <div style="overflow: auto;">
                                                <asp:Table ID="drawNewPattern" runat="server" CssClass="w-100p">
                                                </asp:Table>
                                            </div>
                                            <div id="divSave" runat="server">
                                                <table class="defaultfontcolor w-30p">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="Button2" runat="server" CssClass="btn" OnClick="btnApproval_Click"
                                                                OnClientClick="javascript:return OnDirectApproval()" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Save" Width="100" meta:resourcekey="Button2Resource1" />
                                                            <asp:HiddenField ID="hdnDirectApproval" runat="server" Value="0" />
                                                            <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="Button1_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Cancel" Width="100" OnClientClick="javascript:OnCancelSet();"
                                                                meta:resourcekey="Button1Resource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:HiddenField ID="HDnInVID" runat="server" />
                            <asp:HiddenField runat="server" ID="hdnGroupCollection" />
                            <asp:HiddenField ID="hdnIds" runat="server" />
                            <asp:HiddenField ID="hdnOutofrangeCount" runat="server" />
                            <asp:HiddenField ID="hdnUnCheckedAbnormalControl" runat="server" Value="" />
                            <asp:HiddenField ID="hdncountsofdata" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnActionName" runat="server" Value="EnterResult" />
                            <asp:HiddenField ID="hdnDomainvalue" runat="server" Value="false" />
                            <asp:HiddenField ID="hdnOutOfRangeDetails" runat="server" Value="" />
                            <asp:HiddenField ID="hdnHighRangeDetails" runat="server" Value="" />
                            <asp:HiddenField ID="hdnIsExcludeAutoApproval" runat="server" Value="" />
                            <asp:HiddenField ID="hdnlstNotYetResolvedRRParams" runat="server" Value="" />
                            <input id="hdnabnormalchange" runat="server" type="hidden" />
                            <asp:HiddenField ID="hdnIsCancelLoad" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnNoGraphAttached" runat="server" Value="" />
                            <div id="DLoad" runat="server" visible="false">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                <ajc:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                    TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                    CancelControlID="imgPDFReportPreview" DynamicServicePath="" Enabled="True">
                </ajc:ModalPopupExtender>
                <asp:Panel ID="pnlReportPreview" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlShowReportPreviewResource1" Style="display: none">
                    <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                        <table class="w-100p">
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblReportPreviewHeader" runat="server" Text="Report Preview" meta:resourcekey="lblReportPreviewHeaderResource2"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" runat="server"
                                        alt="Close" style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <div id="iframeplaceholder" class="w-100p" style="height: auto;">
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnBatchSearch" />
                <asp:PostBackTrigger ControlID="btnSave" />
                <asp:PostBackTrigger ControlID="Button2" />
                <asp:PostBackTrigger ControlID="imgNextPage" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:Panel ID="pnlLocation1" Width="1000px" Height="400px" runat="server" CssClass="modalPopup dataheaderPopup"
            ScrollBars="Vertical" Style="display: none" meta:resourcekey="pnlLocation1Resource1">
            <br />
            <table class="a-center w-90p">
                <tr>
                    <td class="w-100p">
                        <table class="w-100p">
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblPName1" runat="server" meta:resourcekey="lblPName1Resource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblPAge1" runat="server" meta:resourcekey="lblPAge1Resource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblSex1" runat="server" meta:resourcekey="lblSex1Resource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblVisitNo1" runat="server" meta:resourcekey="lblVisitNo1Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="colorforcontent w-30p h-23 a-left">
                        <div id="DeltaPlus" class="a-right" style="display: block;">
                            <span class="dataheader1txt pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaTable',1);">
                                &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Investigation Result History"
                                    meta:resourcekey="lblinvfilterResource1"></asp:Label></span> &nbsp;<img src="../Images/Rotate360AntiClockwi2.png"
                                        alt="Show Graph" class="w-15 h-15 v-top pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaTable',1);" />&nbsp;
                        </div>
                        <div id="DeltaMinus" style="display: none;" class="a-right">
                            <span class="dataheader1txt pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaGraph',0);">
                                &nbsp;<asp:Label ID="lblinvfilters" runat="server" Text="Investigation Result History"
                                    meta:resourcekey="lblinvfiltersResource1"></asp:Label></span> &nbsp;<img src="../Images/Rotate360AntiClockwi2.png"
                                        alt="Show Table" class="w-15 h-15 v-top pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaGraph',0);" />&nbsp;
                        </div>
                    </td>
                </tr>
                <tr id="trDeltaTable" runat="server" style="display: table-row;">
                    <td>
                        <table id="tblPatientTestHistory1" class="dataheaderInvCtrl w-100p" style="display: none;">
                            <tr class="dataheader1">
                                <td class="w-10p">
                                    <asp:Label ID="Label11" runat="server" Text="Select"></asp:Label>
                                </td>
                                <td class="w-10p">
                                    <asp:Label ID="Label12" runat="server" Text="Visit Number"></asp:Label>
                                </td>
                                <td class="w-20p">
                                    <asp:Label ID="Rs_Date" runat="server" Text="Date"></asp:Label>
                                </td>
                                <td class="w-30p">
                                    <asp:Label ID="Rs_InvestigationName" runat="server" Text="Investigation Name"></asp:Label>
                                </td>
                                <td class="w-15p">
                                    <asp:Label ID="Rs_Value" runat="server" Text="Value"></asp:Label>
                                </td>
                                <td class="w-20p">
                                    <asp:Label ID="Rs_ReferenceRange" runat="server" Text="Reference Range"></asp:Label>
                                </td>
                                <td class="w-20p">
                                    <asp:Label ID="Rs_Comments" runat="server" Text="Comments"></asp:Label>
                                </td>
                                <td class="w-15p">
                                    <asp:Label ID="Rs_Status" runat="server" Text="Investigation Status"></asp:Label>
                                </td>
                                <td class="w-15p">
                                    <asp:Label ID="lblKitAnalyzer" runat="server" Text="Kit/Analyzer"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trDeltaGraph" runat="server" style="display: none;">
                    <td id="Td1" runat="server">
                        <img id="ChartArea" />
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <table>
                            <tr>
                                <td>
                                    <button id="btnSetValues"  class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" onclick="SetValues(); return false">
                                       
                                        <%=Resources.Investigation_ClientDisplay.Investigation_BulkApprovel_aspx_01%></button>
                                        <%-- onclick="return SetValues();">--%>
                                </td>
                                <td align="left">
                                    <button id="btnpopClose1" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        onclick="ClearPopUp1();">
                                        <%=Resources.Investigation_ClientDisplay.Investigation_BulkApprovel_aspx_02%></button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>
    </div>
    <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
        CancelControlID="btnpopClose1" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation1"
        TargetControlID="btnDummy1">
    </ajc:ModalPopupExtender>
    <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
    <Reflex:ReflexTest ID="ucReflexTest" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnLstControlID" runat="server" Value="" />
    <asp:HiddenField ID="hdnLstPatternID" runat="server" Value="" />
    <asp:HiddenField ID="hdnInvValues" runat="server" Value="" />
    <asp:HiddenField ID="hdnPatInv" runat="server" Value="" />
    <asp:HiddenField ID="hdnLstImagePattern" runat="server" Value="" />
    <asp:HiddenField ID="hdnEditableFormulaFields" runat="server" Value="" />
    <asp:HiddenField ID="hdnComputationFieldList" runat="server" Value="" />
    <asp:HiddenField ID="hdnPatientGender" runat="server" Value="" />
    <asp:HiddenField ID="hdnDDLValues" runat="server" Value="" />
    <asp:HiddenField runat="server" ID="hdnIsDeltaCheckWant" Value="false" />
    <asp:HiddenField runat="server" ID="hdnPatternID" />
    <asp:HiddenField runat="server" ID="hdnMappingPatternID" />
    <asp:HiddenField runat="server" ID="hdnPatientVisitID" />
    <asp:HiddenField runat="server" ID="hdnPatientInvID" />
    <asp:HiddenField ID="hdnDefaultDropDownStatus" runat="server" Value="" />
    <asp:HiddenField ID="hdnDCcheck" runat="server" Value="false" />
    <asp:HiddenField ID="hdnCommonDCcheck" runat="server" Value="" />
    <asp:HiddenField ID="hdnButtonName" runat="server" Value="" />
    <asp:HiddenField ID="hdnIscommonValidation" runat="server" Value="" />
    <asp:HiddenField ID="hdnLID" runat="server" Value="" />
    <asp:HiddenField ID="hdnrerunrecollect" runat="server" Value="" />
    <asp:HiddenField ID="hdnlstreasons" runat="server" Value="" />
    <asp:HiddenField ID="hdnRoleName" runat="server" Value="" />
    <asp:HiddenField ID="hdnMessages" runat="server" Value="" />
    <asp:HiddenField ID="hdnSensitiveRangeDetails" runat="server" Value="" />
    <asp:HiddenField ID="hdndeltaChecks" runat="server" />
    <asp:HiddenField ID="hdnCheckCount" runat="server" />
    <asp:HiddenField ID="hdnLstCoAuthorizeUser" runat="server" />
    </form>
</body>
<%--<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>
<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

<script type="text/javascript" language="javascript">
    $(function() {
        try {
            ChangeDDLItemListWidth();
        }
        catch (e) {
        }
        return false;
    });
    function disableOnblur(e)
    {
    event.preventDefault();
    
    }
$('input[bulk=checkbox]').change(function() {
    var checks = $(this).parent().find('#ChkAppr');
    var allChecked = true;
    $.each(checks, function(idx, value) {
        if (!$(this).is(':checked')) {
         
           // allChecked = false;
             var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
    ff.prop('selectedIndex', 1);
        }
        else
        {
         var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
    ff.prop('selectedIndex', 0);
        }
        //var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
       // $("#647~~0~0~0~110_ddlstatus").prop('selectedIndex', 2);
        //ff.prop('selectedIndex', 1);
        //("#647~~0~0~0~110_ddlstatus").get(0).selectedIndex = 2; 
       // ff.value="Validate_2";
        //var dd= $(value).closest('tr').find('select[bulkapp="ddl"]')[0].name;
        
    });
    
//  // var dd= $(value).closest('tr').find('select[bulkapp="ddl"]').value;
//    if (allChecked) {
//    var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
//    ff.prop('selectedIndex', 1);
//   // $(dd).val("Parthiban");
//  //  $(dd).val("Validate_2");
//   //  $("#647~~0~0~0~110_ddlstatus")[0].selectedIndex=3;
//  //  $('#dd').val("Validate_2").attr("selected", "selected");
//        //$(this).parent().find('input[bulkapp=ddl]').val(2);
//    } else {
//     var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
//    ff.prop('selectedIndex', 0);
//   //  var dd= $(value).closest('tr').find('select[bulkapp="ddl"]');
//  //  $('#ddlstatus').val("Parthiban").attr("selected", "selected");;
//       // $(this).parent().find('input[bulkapp=ddl]s').val(1);
//    }
});

$('input[name=ctl14]').change(function() {
    var checks = $('#drawNewPattern').find('input[bulk="checkbox"]');
    var allChecked = true;
    $.each(checks, function(idx, value) {
        if (!$(this).is(':checked')) {
         
            allChecked = false;
             var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
    ff.prop('selectedIndex', 1);
        }
        else
        {
         var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
    ff.prop('selectedIndex', 0);
        }
        //var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
       // $("#647~~0~0~0~110_ddlstatus").prop('selectedIndex', 2);
        //ff.prop('selectedIndex', 1);
        //("#647~~0~0~0~110_ddlstatus").get(0).selectedIndex = 2; 
       // ff.value="Validate_2";
        //var dd= $(value).closest('tr').find('select[bulkapp="ddl"]')[0].name;
        
    });

if (allChecked) {
   var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
   ff.prop('selectedIndex', 0);
   // $(dd).val("Parthiban");
  //  $(dd).val("Validate_2");
   //  $("#647~~0~0~0~110_ddlstatus")[0].selectedIndex=3;
  //  $('#dd').val("Validate_2").attr("selected", "selected");
        //$(this).parent().find('input[bulkapp=ddl]').val(2);
    } else {
     var ff=$(value).closest('tr').find('select[bulkapp="ddl"]');
    ff.prop('selectedIndex', 1);
   //  var dd= $(value).closest('tr').find('select[bulkapp="ddl"]');
  //  $('#ddlstatus').val("Parthiban").attr("selected", "selected");;
       // $(this).parent().find('input[bulkapp=ddl]s').val(1);
    }
});
</script>

</html>
