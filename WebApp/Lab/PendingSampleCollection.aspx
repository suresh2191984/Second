<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingSampleCollection.aspx.cs"
    EnableEventValidation="false" Inherits="Lab_PendingSampleCollection" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Aberrant Sample</title>

    <script src="../Scripts/datetimepicker.js?v=<%= System.Configuration.ConfigurationManager.AppSettings["jsDownloadVersion"]%>" type="text/javascript"></script>
<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
    <script src="../Scripts/datetimepicker.js?v=<%= System.Configuration.ConfigurationManager.AppSettings["jsDownloadVersion"]%>" type="text/javascript"></script>

    <style type="text/css">
        .modalBackground1
        {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.9;
        }
    </style>
    <style type="text/css">
        .style18
        {
            width: 89px;
        }
    </style>

    <script type="text/javascript" language="javascript">

      

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



        //added by sudha from lal
	 function jsFunction(value) {
	            if (value != "1") {

	                $('#txtVisitID').val("");
	            }
           else{
            $('#txtVisitID').val($('#hdnvidtxt').val());
	            
	            }
	        }
	        function WaterMark(txttext, evt, defaultText) {
	            if (txttext.value.length == 0 && evt.type == "blur") {
                txttext.style.color = "gray";
	                txttext.value = defaultText;
	            }
	            if (txttext.value == defaultText && evt.type == "focus") {
	                txttext.style.color = "black";
	                txttext.value = "";
            }
        }
	
	//ended by sudha 
	
	
	
	
	
	function ValidateSelect15() {
         var bolSelected = 'false';
         var Outsourceselected = 'true';
       
         if ($('#ddlAction :selected').val() == 'Reprint_Barcode_SampleSearch' || $('#ddlAction :selected').val() == 'Reprint_TRFBarcode_SampleSearch' || $('#ddlAction :selected').val() == 'Bulk_Collect_Sample_SampleSearch') {
             var checkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxSelect"]:checkbox';
             var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
             if (checkedCheckboxes.length == 0) {
                 alert("Select a Sample");
                 return false;
             }
         }

         else {
             var checkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxSelect"]:checkbox';
             var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
             if (checkedCheckboxes.length == 0) {
                 alert("Select a Sample");
                 return false;
             }
             else if (checkedCheckboxes.length > 1) {

             if ($('#ddlAction :selected').val() != 'Send_Outsource_Details' || $('#ddlAction :selected').val() != 'Capture_OutSourcing_Details' || $('#ddlAction :selected').val() != 'Force_Outsource') {
                     alert("Dont Select more than one sample");
                     return false;
                 }
             }

         }
     }

function stop() {
    return false;
}

function setvalue1() {

  
   
         return false;
         stop();
     }


        /* Common Alert Validation */
        var AlertType;
        function setvalue() {
            if ($('#ddlAction :selected').val() == 'Associate_NewBarcode') {
                $('#txtNewBarcode').val("");
                $('#txtNewBarcode').show();
                $('#ddlReason').hide();
                $('#TxtAliquot').hide();
             $('#CheckBox_Slide').hide();
             $('#lblSlide').hide();


            }
            else {
                $('#txtNewBarcode').hide();
                $("#linkBarcodeLayerGenerate").hide();
            }
        }

        function ShowCollectSampleDateTimePopUp(SampleID, OldCollectedDatetime, VisitID) {



            document.getElementById('lblsamcolldatetxt1').innerText = OldCollectedDatetime;
            document.getElementById('hdnsampleid').value = SampleID;
            document.getElementById('hdnVisitId1').value = VisitID;

            $find("modalpopupcollectdate").show();
            return false;

        }


        function isNumerc(e, Id) {
            var key; var isCtrl;
            //debugger;
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190)) {
                        isCtrl = true;
                    }
                    else {
                        //if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }


        function checkAllRows(obj) {

            var objGridview = obj.parentNode.parentNode.parentNode;
            var list = objGridview.getElementsByTagName("input");

            for (var i = 0; i < list.length; i++) {
                var objRow = list[i].parentNode.parentNode;
                if (list[i].type == "checkbox" && obj != list[i]) {
                    if (obj.checked) {

                        //If the header checkbox is checked then check all 
                        //checkboxes and highlight all rows.

                        objRow.style.backgroundColor = "#99E5E5";
                        list[i].checked = true;
                    }
                    else {
                        objRow.style.backgroundColor = "#FFFFFF";
                        list[i].checked = false;
                    }
                }
            }
        }

        function checkUncheckHeaderCheckBox(obj) {
            var objRow = obj.parentNode.parentNode;

            if (obj.checked) {
                objRow.style.backgroundColor = "#99E5E5";
            }
            else {
                objRow.style.backgroundColor = "#FFFFFF";
            }
            var objGridView = objRow.parentNode;

            //Get all input elements in Gridview
            var list = objGridView.getElementsByTagName("input");
            for (var i = 0; i < list.length; i++) {
                var objHeaderChkBox = list[0];

                //Based on all or none checkboxes are checked check/uncheck Header Checkbox
                var checked = true;

                if (list[i].type == "checkbox" && list[i] != objHeaderChkBox) {
                    if (!list[i].checked) {
                        checked = false;
                        break;
                    }
                }
            }
            objHeaderChkBox.checked = checked;
        }
        
     
    </script>

    <script language="javascript" type="text/javascript">
        var userMsg;
        function SetSampleStatus(sender) {
            var chkStatus = document.getElementById('<%= chkAberrant.ClientID %>');
            var objSS = document.getElementById('<%= ddlSampleStatus.ClientID %>');
            var strSSL = document.getElementById('<%= hdnSampleStatus.ClientID %>').value.split('^');
            var l = strSSL.length;
            if (chkStatus.checked) {
                objSS.options.length = 0;
                document.getElementById('ddlSampleStatus').disabled = false;
                for (i = 0; i < l - 1; i++) {
                    var strSSL2 = strSSL[i].split('~');
                    var l1 = strSSL2.length;
                    for (m = 0; m < l1 - 1; m++) {
                        if (strSSL2[0] != 'All') {
                            newListItem = document.createElement("option");
                            objSS.options.add(newListItem);
                            newListItem.text = strSSL2[0];
                            newListItem.value = strSSL2[1];
                        }
                    }
                }
            }
            else {
                objSS.options.length = 0;
                newListItem = document.createElement("option");
                objSS.options.add(newListItem);
                newListItem.text = "All";
                newListItem.value = "0";
                document.getElementById('ddlSampleStatus').disabled = true;
            }
        }
        function CheckOnOff(rdoId, gridName) {
            var rdo = document.getElementById(rdoId);
            var all = document.getElementsByTagName("input");
            for (i = 0; i < all.length; i++) {
                if (all[i].type == "radio" && all[i].id != rdo.id) {
                    var count = all[i].id.indexOf(gridName);
                    if (count != -1) {
                        all[i].checked = false;
                    }
                }
            }
            rdo.checked = true;
        }

        function ValidateSearch() {
            /* Added By Venkatesh S */
            AlertType = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01');
            var vFromDate = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_02') == null ? "Select From date" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_02');
            var vToDate = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_03') == null ? "Select To date" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_03');
            var vDateValidation = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_04') == null ? "Please ensure that the To Date is greater than or equal to the From Date." : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_04');
            var vAberrantSample = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_05') == null ? "Select Aberrant Sample Status" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_05');
            var vFromBarcode = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_06') == null ? "Enter Barcode From" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_06');
            var vToBarcode = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_07') == null ? "Enter Barcode To" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_07');
            var vBarcodeValidation = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_08') == null ? "Enter Barcode From Greater Than Barcode To" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_08');
            var vSampleAliquot = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_09') == null ? "Select a Sample for Aliquot" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_09');

            var bolSelected = 'false';

            if (document.getElementById('txtFrom').value == '') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_1');
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlertType);
                    //alert(userMsg);
                    return false;

                }
                else {
                    ValidationWindow(vFromDate, AlertType);
                    return false;

                }
                document.getElementById('txtFrom').focus();
                return false;
            }

            if (document.getElementById('txtTo').value == '') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_2');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlertType);
                    return false;

                }
                else {
                    ValidationWindow(vToDate, AlertType);
                    return false;

                }
                document.getElementById('txtTo').focus();
                return false;
            }
            var StartDate = document.getElementById('txtFrom').value;
            var EndDate = document.getElementById('txtTo').value;
            var fromdate, todate, dt1, dt2, mon1, mon2, yr1, yr2, date1, date2;
            var fromdate = document.getElementById('txtFrom').value;
            var todate = document.getElementById('txtTo').value;
            var StartDate = document.getElementById('txtFrom').value;
            var EndDate = document.getElementById('txtTo').value;

            dt1 = parseInt(StartDate.substring(0, 2), 10);
            mon1 = parseInt(StartDate.substring(3, 5), 10);
            yr1 = parseInt(StartDate.substring(6, 10), 10);
            dt2 = parseInt(EndDate.substring(0, 2), 10);
            mon2 = parseInt(EndDate.substring(3, 5), 10);
            yr2 = parseInt(EndDate.substring(6, 10), 10);
//            date1 = new Date(yr1, mon1, dt1);
            //            date2 = new Date(yr2, mon2, dt2);

            date1 = new Date(mon1 + "/" + dt1 + "/" + yr1);
            date2 = new Date(mon2 + "/" + dt2 + "/" + yr2);
            var eDate = new Date(EndDate);
            var sDate = new Date(StartDate);
            if (date1 != '' && date1 != '' && date1 > date2) {
                ValidationWindow(vDateValidation, AlertType);
                return false;
            }
            //            var datediff1 = document.getElementById('txtFrom').value;
            //            var datediff2 = document.getElementById('txtTo').value;
            //            dobDt = datediff1.split('/');
            //            dobDt1 = datediff2.split('/');
            //            var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
            //            var mMonth = dobDtTime.getMonth() + 1;
            //            var mDay = dobDtTime.getDate();
            //            var mYear = dobDtTime.getFullYear();
            //            var dobDtTime1 = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
            //            var mMonth1 = dobDtTime1.getMonth() + 1;
            //            var mDay1 = dobDtTime1.getDate();
            //            var mYear1 = dobDtTime1.getFullYear();
            //            var diff = ((dobDtTime1 - dobDtTime) / (24 * 3600 * 1000));
            //            if ((diff > 8) && (document.getElementById('txtVisitID').value == '') && (document.getElementById('txtBarCodeFrom').value == '') && (document.getElementById('txtPatientName').value == '') && (document.getElementById('txtTestName').value == '')) {
            //                alert('Provide / Select Only With in 7 days Records');
            //                return false;
            //            }
            var eDate = new Date(EndDate);
            var sDate = new Date(StartDate);

            if (document.getElementById('<%= chkAberrant.ClientID %>').checked) {
                if (document.getElementById('ddlSampleStatus').value == 'All') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_3');
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                        return false;

                    }
                    else {
                        ValidationWindow(vAberrantSample, AlertType);
                        return false;

                    }
                    document.getElementById('ddlSampleStatus').focus();
                    return false;
                }
            }
            if ((document.getElementById('txtBarCodeFrom').value == '') && (document.getElementById('txtBarcodeTo').value != '')) {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_2');
                if (userMsg != null) {
                    ValidationWindow(vFromBarcode, AlertType);
                    document.getElementById('txtBarCodeFrom').focus();
                    return false;

                }
                else {
                    ValidationWindow(vFromBarcode, AlertType);
                    document.getElementById('txtBarCodeFrom').focus();
                    return false;

                }
                document.getElementById('txtBarCodeFrom').focus();
                return false;
            }

            if ((document.getElementById('txtBarCodeFrom').value != '') && (document.getElementById('txtBarcodeTo').value == '')) {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_2');
                if (userMsg != null) {
                    ValidationWindow(vToBarcode, AlertType);
                    document.getElementById('txtBarcodeTo').focus();
                    return false;

                }
                else {
                    ValidationWindow(vToBarcode, AlertType);
                    document.getElementById('txtBarcodeTo').focus();
                    return false;

                }
                document.getElementById('txtBarcodeTo').focus();
                return false;
            }
            if ((document.getElementById('txtBarCodeFrom').value > document.getElementById('txtBarcodeTo').value)) {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_2');
                if (userMsg != null) {
                    ValidationWindow(vBarcodeValidation, AlertType);
                    document.getElementById('txtBarcodeTo').focus();
                    return false;

                }
                else {
                    ValidationWindow(vBarcodeValidation, AlertType);
                    document.getElementById('txtBarcodeTo').focus();
                    return false;

                }
                document.getElementById('txtBarcodeTo').focus();
                return false;
            }
        }

        function validateAliquot() {
            var bolSelected = 'false';

            var radios = document.getElementsByTagName('input');
            var value;
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].type === 'radio' && radios[i].checked) {
                    bolSelected = 'true';
                }
            }

            if (bolSelected == 'false') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_4');
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, AlertType);
                    return false;

                }
                else {

                    if ($("#hdnslidebarcode").val() == 'Y') {
                        alert('Select a Sample for Slide Barcode');
                        return false;
                    }
                    else {
                    ValidationWindow(vSampleAliquot, AlertType);
                    return false;
                    }

                }
                document.getElementById('TxtAliquot').value = 0;
                return false;
            }

        }

        function ValidateSelect11() {
            /* Added By Venkatesh S */
            AlertType = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01');
            var vSelectAction = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_10') == null ? "Select Action" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_10');
            var vSelectSample = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_11') == null ? "Select a Sample" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_11');
            var vSelectMoreSample = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_12') == null ? "Dont Select more than one sample" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_12');
            var vSelectReason = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_13') == null ? "Select Reason" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_13');
            var vAliquot = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_14') == null ? "Aliquot Value not Equal to Zero" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_14');
            var vAliquotValue = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_15') == null ? "Enter Aliquot Value" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_15');
            var vNewBarcode = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_16') == null ? "Enter NewBarcode Number" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_16');
            var vEightDigitBarcode = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_17') == null ? "Please Enter Eight Digit Barcode" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_17');
            var vBarcodeExists = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_18') == null ? "Given Barcode Already Exists" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_18');
            var vLocation= SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_34') == null ? "Please select location to transfer" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_34');
            var bolSelected = 'false';
            var Outsourceselected = 'true';
            //debugger;
            if ($('#ddlAction :selected').val() == '0') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_9');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlertType);
                    return false;

                }
                else {
                    ValidationWindow(vSelectAction, AlertType);
                    return false;
                }
            }
            //ddlAction.SelectedValue == "Reprint_Barcode_SampleSearch"
            if ($('#ddlAction :selected').val() == 'Reprint_Barcode_SampleSearch' || $('#ddlAction :selected').val() == 'Reprint_TRFBarcode_SampleSearch' || $('#ddlAction :selected').val() == 'Bulk_Collect_Sample_SampleSearch') {
                var checkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxSelect"]:checkbox';
                var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
                if (checkedCheckboxes.length == 0) {
                    ValidationWindow(vSelectSample, AlertType);
                    return false;
                }
            }


            //added by sudha
          if ($('#ddlAction :selected').val() == 'Collect_Sample_SampleSearch') 
	            {
	             var PatientVisitID = 0;
	                var exitFlag = false;
	                    $("#grdSample tr:not(:first)").each(function(i, n) {
                        var $row = $(n);
	                        var rbSelect = $row.find("input[id$='ChkbxSelect']").is(":checked");
	                        if (rbSelect) {
	                            var lblpvid = $row.find("span[id$='lblpvid']").html();
	                            if (PatientVisitID == 0) {
	                                PatientVisitID = lblpvid;
	                            }
	                            if (PatientVisitID != 0 && PatientVisitID != lblpvid) {
	                                alert('Cannot able to collect sample for more than one visit');
	                                exitFlag = true;
	                                return false;
	
	                            }
	                           
	                        }
	
	                    });
	                    if (exitFlag) return false;
	                
	            }
         //ended by sudha



            else {
                var checkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxSelect"]:checkbox';
                var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
                if (checkedCheckboxes.length == 0) {
                    ValidationWindow(vSelectSample, AlertType);
                    return false;
                }
                //else if (checkedCheckboxes.length > 1) {
                 //   if ($('#ddlAction :selected').val() != 'Send_Outsource_Details' && $('#ddlAction :selected').val() != 'Capture_OutSourcing_Details') {
                 //       ValidationWindow(vSelectMoreSample, AlertType);
                 //       return false;
                 //   }
               // }
            }
	    
	       if ($('#ddlAction :selected').val() == 'Inv_Reject_Sample_SampleSearch') {
                    ValidationWindow(vSelectMoreSample, AlertType);
                    return false;
                }
            $("#grdSample tr:not(:first)").each(function(i, n) {
                var $row = $(n);
                var rbSelect = $row.find("input[id$='ChkbxSelect']").is(":checked");
                if (rbSelect) {
                    var lblSampleStatus = $row.find("span[id$='lblSampleStatus']").html();
                    if ((lblSampleStatus != 'OutSource' && lblSampleStatus != 'Received') && $('#ddlAction :selected').val() == 'Capture_OutSourcing_Details' || (lblSampleStatus != 'OutSource' && lblSampleStatus != 'Received' && lblSampleStatus != 'Collected') && $('#ddlAction :selected').val() == 'Send_Outsource_Details') {
                        //if (lblSampleStatus != 'OutSource' && lblSampleStatus != 'Received') && $('#ddlAction :selected').val() == 'Capture_OutSourcing_Details' || lblSampleStatus != 'OutSource' && $('#ddlAction :selected').val() == 'Send_Outsource_Details') {
                        userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_5');
                        if (userMsg != null) {
                            // alert(userMsg);
                            ValidationWindow(userMsg, AlertType);
                            Outsourceselected = 'false';
                            return false;

                        }
                    }
                }
            });
            if (Outsourceselected == 'false') {
                return false;
            }
            var radios = document.getElementsByTagName('input');
            var value;
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].type === 'radio' && radios[i].checked) {
                    bolSelected = 'true';
                }
            }

            if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') && ($('#ddlReason :selected').val() == '0')) {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_7');
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, AlertType);
                    return false;
                }
                else {
                    ValidationWindow(vSelectReason, AlertType);
                    return false;
                }
            }
            if ($('#ddlAction :selected').val() == '0') {
                userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_9');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlertType);
                    return false;
                }
                else {
                    ValidationWindow(vSelectAction, AlertType);
                    return false;
                }
            }
            if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
                if ($('#TxtAliquot').val() == '0') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_10');
                    if (userMsg != null) {
                        if ($("#hdnslidebarcode").val() == 'Y') {
                            alert('Slide Barcode Value not Equal to Zero');
                            return false;
                        }
                        else {
                            alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                            return false;
                        }
                    }
                    else {
                        ValidationWindow(vAliquot, AlertType);
                        return false;
                    }
                }
            }
            if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
                if ($('#TxtAliquot').val() == '') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_11');
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                        return false;
                    }
                    else {
                        ValidationWindow(vAliquotValue, AlertType);
                        return false;
                    }
                }
            }
            if (($('#ddlAction :selected').val() == 'Force_Outsource' || $('#ddlAction :selected').val() == 'Outsource') && $('#ddloutlocation :selected').val() == 0) {
                ValidationWindow(vLocation, AlertType);
                return false;
            }
            if ($('#ddlAction :selected').val() == 'Associate_NewBarcode') {
                if ($('#txtNewBarcode').val() == '') {
                    ValidationWindow(vNewBarcode, AlertType);
                    $('#txtNewBarcode').show();
                    $('#txtNewBarcode').focus();
                    return false;
                }
                var barcodeNumber = document.getElementById('txtNewBarcode').value;
                if (barcodeNumber.length < 8) {
                    ValidationWindow(vEightDigitBarcode, AlertType);
                    $('#txtNewBarcode').focus();
                    return false;
                }
                else {
                    var OrgID = "<%= OrgID %>";
                    var Barcodenumber = $('#txtNewBarcode').val();
                    WebService.CheckExistingBarcode(OrgID, Barcodenumber, funNetBarcode);
                }
            }
            else {
                return true;
            }
        }
        function funNetBarcode(temp) {
            if (temp.length > 0) {
                $('#ddlAction').val(0);
                ValidationWindow(vBarcodeExists, AlertType);
                $('#ddlAction').val(0);
                return false;
            }
            else {
                document.getElementById("btnHiddne").click();
                return true;
            }
        }

        function SelectedTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName1 = TestDetails.split('~')[0];
            var TestName = TestName1.split(':')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = TestName;
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = TestID;
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = TestType;
            }
        }

        function SelectedUsers(source, eventArgs) {
            UserstDetails = eventArgs.get_value();

            var LoginID = UserstDetails;
            if (document.getElementById('<%=hdnUserLoginID.ClientID %>') != null) {
                document.getElementById('<%=hdnUserLoginID.ClientID %>').value = LoginID;
            }
        }

        function ClearTestDetails() {
            if (document.getElementById('txtTestName') != null) {
                document.getElementById('txtTestName').value = '';
            }
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = '';
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = '0';
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = '';
            }
        }

        function SelectedRefPhy(source, eventArgs) {
            RefPhyDetails = eventArgs.get_value();

            var RefPhyName = RefPhyDetails.split('~')[0];
            var RefPhyID = RefPhyDetails.split('~')[1];
            //var RefPhyOrg = RefPhyDetails.split('~')[2];
            if (document.getElementById('hdnRefPhyName') != null) {
                document.getElementById('hdnRefPhyName').value = RefPhyName;
            }
            if (document.getElementById('hdnRefPhyID') != null) {
                document.getElementById('hdnRefPhyID').value = RefPhyID;
            }
            //            if ((document.getElementById('hdnRefPhyOrg') != null)&&(document.getElementById('hdnRefPhyOrg') != undefined)) {
            //                document.getElementById('hdnRefPhyOrg').value = RefPhyOrg;
            //            }
        }

        function ClearRefPhyDetails() {
            if (document.getElementById('txtRefDrName') != null) {
                document.getElementById('txtRefDrName').value = '';
            }
            if (document.getElementById('hdnRefPhyName') != null) {
                document.getElementById('hdnRefPhyName').value = '';
            }
            if (document.getElementById('hdnRefPhyID') != null) {
                document.getElementById('hdnRefPhyID').value = '0';
            }
            if (document.getElementById('hdnRefPhyOrg') != null) {
                document.getElementById('hdnRefPhyOrg').value = '';
            }
        }

        function expandDropDownList(elementRef) {
            elementRef.style.width = '200px';
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
        function SetOutSourceDate() {
            NewCal('<%=txtOutsourcedTime.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }

        function SetOutSourceDate1() {
            NewCal('<%=txtNewCollectTime.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }
        function SetReceivedDate() {
            NewCal('<%=txtReceivedDateTime.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }
        function SetSamplereachedDate() {
            NewCal('<%=txtAcknowledgement.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }
        function TempDate() {
            $("#txtFrom").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100'
            });
            $("#txtTo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100'
            })
        }
        function LoadrdoBtns() {

            var Status = document.getElementById('ddlSampleStatus').value;
            if (Status == 12) {
                document.getElementById('tdRdoBtns').style.display = "table-cell";
                document.getElementById('RdoSendOutSource').checked = true;
                document.getElementById('RdoReceiveOutSource').checked = false;
                document.getElementById('Chkpkgout').checked = true;
            }
            else {
                document.getElementById('tdRdoBtns').style.display = "none";
                document.getElementById('Chkpkgout').checked = false;
            }
        }
        function ValidateRdoBtns() {
            document.getElementById('RdoReceiveOutSource').checked = true;
            document.getElementById('RdoReceiveOutSource').checked = false;
            $("#ddlAction option[value='Capture_OutSourcing_Details']").attr("disabled", "disabled");
            $("#ddlAction option[value='Force_Outsource']").removeAttr("disabled", false);
            $("#ddlAction option[value='Send_Outsource_Details']").removeAttr("disabled", false);
        }
        function ValidateRdoBtns123() {

            document.getElementById('RdoReceiveOutSource').checked = true;
            document.getElementById('RdoSendOutSource').checked = false;
            $("#ddlAction option[value='Send_Outsource_Details']").attr("disabled", "disabled");
            $("#ddlAction option[value='Force_Outsource']").attr("disabled", "disabled");
            $("#ddlAction option[value='Capture_OutSourcing_Details']").removeAttr("disabled", false);
        }
    </script>

    <script type="text/javascript">
        function checkForValues() {
            AlertType = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01');
            var vPageNo = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_19') == null ? "Please Enter Page No" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_19');
            var vCorrectPageNo = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_20') == null ? "Please Enter Correct Page No" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_20');

            if (document.getElementById('txtpageNo').value == "") {
                ValidationWindow(vPageNo, AlertType);
                return false;
            }

            if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) < Number(1)) {
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }

            if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) > Number(document.getElementById('<%= lblTotal.ClientID %>').innerText)) {
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }
        }
        function CallPrint() {
            ///hideColumn();
            var prtContent = document.getElementById('divPrintarea');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            // WinPrint.close();
            // ShowColumn();

            return false;
        }

    </script>

    <script type="text/javascript">

        function Actionstyle() {

            if ($('#ddlAction :selected').val() == 'Force_Outsource') {


              
            
            
                document.getElementById('tblaction').width = '100%';
                document.getElementById('Td1').width = '18%';
                document.getElementById('tblactiontd').align = 'center';
                document.getElementById('Td2').align = 'right';
                document.getElementById('Td3').align = 'left';

                //$('#').style.width = '80%';
                // $('#tblactiontd').column.attr('align', 'center');
                $('#txtNewBarcode').hide();
                $('#ddlReason').hide();
                $('#TxtAliquot').hide();
                $("#linkBarcodeLayerGenerate").hide();
                $('#CheckBox_Slide').hide();
                $('#Check_boxslide').hide();
                $('#lblSlide').hide();
                document.getElementById("Label8").style.display = "block";
                document.getElementById("ddloutlocation").style.display = "block";





            }

           
           
        }
    
    
        function DDLAction() {
            var slidepreparation = SListForAppDisplay.Get('Lab_PendingSampleCollection_aspx_11') == null ? "slide preparation" : SListForAppDisplay.Get('Lab_PendingSampleCollection_aspx_11');
            var slidepreparation1 = SListForAppDisplay.Get('Lab_PendingSampleCollection_aspx_12') == null ? "Ok" : SListForAppDisplay.Get('Lab_PendingSampleCollection_aspx_12');
          
            if ($('#ddlSampleStatus :selected').text() != "OutSource")
            
            {
                if ($('#ddlAction :selected').val() == 'Force_Outsource') {


                document.getElementById('tblaction').width = '100%';
                document.getElementById('Td1').width = '18%';
                document.getElementById('tblactiontd').align = 'center';
                document.getElementById('Td2').align = 'right';
                document.getElementById('Td3').align = 'left';

                //$('#').style.width = '80%';
                // $('#tblactiontd').column.attr('align', 'center');
                $('#txtNewBarcode').hide();
                $('#ddlReason').hide();
                $('#TxtAliquot').hide();
                $("#linkBarcodeLayerGenerate").hide();
                $('#CheckBox_Slide').hide();
                $('#Check_boxslide').hide();
                $('#lblSlide').hide();
                $('#txtReprintCount').hide();
                document.getElementById("Label8").style.display = "block";
                document.getElementById("ddloutlocation").style.display = "block";
                $('#ddloutlocation').val(0);

             


            }
            if ($('#ddlAction :selected').val() != 'Force_Outsource') {
                document.getElementById("Label8").style.display = "none";
                document.getElementById("ddloutlocation").style.display = "none";
                document.getElementById('tblaction').width = '50%';
                document.getElementById('Td1').width = '1%';
                document.getElementById('tblactiontd').align = 'right';
                document.getElementById('Td2').align = 'left';
                document.getElementById('Td3').align = 'right';
            }
           
            }




            if ($('#ddlAction :selected').val() == 'Reprint_TRFBarcode_SampleSearch' || $('#ddlAction :selected').val() == 'Send_Outsource_Details') {
                document.getElementById('Td2').align = 'right';
                document.getElementById('Td3').align = 'center';
                //VEL | 25-July-2019 | Enble reprint barcode | Start
                if ($('#ddlAction :selected').val() == 'Reprint_TRFBarcode_SampleSearch' && ($('#hdnEnableMultiplereprint').val()) == "Y") {
                    $('#txtReprintCount').show();
                }
                else {
                    $('#txtReprintCount').hide();
                }
                //VEL | 25-July-2019 | Enble reprint barcode | End
            }


            if ($('#ddlAction :selected').val() == 'Cancel_Sample_SampleSearch' || $('#ddlAction :selected').val() == 'Capture_OutSourcing_Details' || $('#ddlAction :selected').val() == 'Reprint_Barcode_SampleSearch') {
                document.getElementById('Td2').align = 'right';
                document.getElementById('Td3').align = 'center';
                //VEL | 25-July-2019 | Enble reprint barcode | Start
                if ($('#ddlAction :selected').val() == 'Reprint_Barcode_SampleSearch' && ($('#hdnEnableMultiplereprint').val()) == "Y") {
                    $('#txtReprintCount').show();
                }
                else {
                    $('#txtReprintCount').hide();
                }
                //VEL | 25-July-2019 | Enble reprint barcode | End
            }


            if ($('#ddlAction :selected').val() == 'Associate_NewBarcode') {
                $('#txtNewBarcode').show();
                $('#ddlReason').hide();
                $('#TxtAliquot').hide();
                $("#linkBarcodeLayerGenerate").hide();
                $('#CheckBox_Slide').hide();
                $('#Check_boxslide').hide();
                $('#lblSlide').hide();
                //VEL | 25-July-2019 | Enble reprint barcode | Start
                $('#txtReprintCount').hide();
                //VEL | 25-July-2019 | Enble reprint barcode | End

            }
            else if ($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch' || $('#ddlAction :selected').val() == 'Inv_Reject_Sample_SampleSearch') {
                $('#ddlReason').show();
                $('#txtNewBarcode').hide();
                $('#TxtAliquot').hide();
                $("#linkBarcodeLayerGenerate").hide();
                $('#CheckBox_Slide').hide();
                $('#Check_boxslide').hide();
                $('#lblSlide').hide();
                //VEL | 25-July-2019 | Enble reprint barcode | Start
                $('#txtReprintCount').hide();
                //VEL | 25-July-2019 | Enble reprint barcode | End 
            }
             else if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') 
           {
                $('#TxtAliquot').show();
                $('#ddlReason').hide();
                $('#txtNewBarcode').hide();
                $("#linkBarcodeLayerGenerate").show();
                $('#lblSlide').hide();
                $('#txtReprintCount').hide();

                if ($("#hdnslidebarcode").val() == 'Y') 
                {
                    if ($('#ddlAction :selected').text() == 'Block') {
                        document.getElementById("btnOK").value = "Block Preparation";
                        document.getElementById("HiddenField1").value = 'Block'
                        $('#CheckBox_Slide').hide();
                        $('#Check_boxslide').show();
                    }
                    else {
                        document.getElementById("btnOK").value = slidepreparation;
                        document.getElementById("HiddenField1").value = 'Slide'
                        $('#CheckBox_Slide').show();
                        $('#Check_boxslide').show();
                    }
                  
                }
                else 
                {
                    document.getElementById("btnOK").value = slidepreparation1;
                    $('#Check_boxslide').hide();
                    $('#lblSlide').hide();

                }


            }
            else {
                $('#TxtAliquot').hide();
                $('#ddlReason').hide();
                $('#txtNewBarcode').hide();
                $("#linkBarcodeLayerGenerate").hide();
                document.getElementById("btnOK").value = slidepreparation1;
                $('#CheckBox_Slide').hide();
                $('#Check_boxslide').hide();
                $('#lblSlide').hide();
                //$('#txtReprintCount').hide();
                //VEL | 25-July-2019 | Enble reprint barcode | Start
                if ($('#hdnEnableMultiplereprint').val() == "Y") {
                    $("#txtReprintCount").val('1');
                }
                //VEL | 25-July-2019 | Enble reprint barcode | End 
            }
        }
    
    
    </script>

    <script type="text/javascript">


        function Validatespeciman() {

            /* Added By Venkatesh S */
            AlertType = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01');
            var vSpecimenbarcode = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_21') == null ? "Select Specimenbarcode" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_21');
            var vSelectThe = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_22') == null ? "Select the" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_22');
            var vSpecimencount = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_23') == null ? "Specimencount" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_23');

            var checkBoxSelector = '#<%=Gvaliqoutbarcode.ClientID%> input[id*="ChkbxalioutSelect"]:checkbox';

            var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
            if (checkedCheckboxes.length == 0) {
                if ($("#hdnslidebarcode").val() == 'Y') {
                    alert('Select Slide Barcode');
                    return false;
                }
                else {


                ValidationWindow(vSpecimenbarcode, AlertType);
                    return false;
                }
            }
            else if (checkedCheckboxes.length > 0) {
                var tbl = $("[id$=Gvaliqoutbarcode]");
                var rows = tbl.find('tr');

                for (var index = 1; index < rows.length; index++) {
                    var row = rows[index];
                    var checked = $(row).find("[id*=ChkbxalioutSelect]").prop('checked');
                    var txtSpecimenCount = $(row).find("[id*=txtSpecimenCount]").val();
                    var lblaliqoutbarcode = $(row).find("[id*=lblaliqoutbarcode]").text();

                    if (checked) {
                        if (txtSpecimenCount == "") {


                            if ($("#hdnslidebarcode").val() == 'Y') {

                                alert("Required Barcode " + lblaliqoutbarcode + " SlideBarcodecount");
                                return false;
                            }
                            else {

                            ValidationWindow("" + vSelectThe + " " + lblaliqoutbarcode + " " + vSpecimencount + "");
                                return false;
                            }
                        }
                    }

                    //new 26/05/2015
                    if (checked) {
                        if (txtSpecimenCount != "") {
                            // alert("hi");
                            if (!checked) {
                                if ($("#hdnslidebarcode").val() == 'Y') {

                                    alert("Required Barcode " + lblaliqoutbarcode + " SlideBarcodecount");
                                    return false;
                                }
                                else {

                                ValidationWindow("" + vSelectThe + " " + lblaliqoutbarcode + " " + vSpecimencount + "");
                                    return false;
                                }
                            }
                        }
                    }
                    //new 26/05/2015


                }


            }
        }
        function hideTooltip() {
            //debugger;
            if (!datadiv_tooltip) {
                datadiv_tooltip = document.createElement('DIV');
                datadiv_tooltip.id = 'datadiv_tooltip';
                datadiv_tooltipShadow = document.createElement('DIV');
                datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

                document.body.appendChild(datadiv_tooltip);
                document.body.appendChild(datadiv_tooltipShadow);

                if (tooltip_is_msie) {
                    datadiv_iframe = document.createElement('IFRAME');
                    datadiv_iframe.frameborder = '5';
                    datadiv_iframe.style.backgroundColor = '#FFFFFF';
                    datadiv_iframe.src = '#';
                    datadiv_iframe.style.zIndex = 100;
                    datadiv_iframe.style.position = 'absolute';
                    document.body.appendChild(datadiv_iframe);
                }

            }
            datadiv_tooltip.style.display = 'none';
            datadiv_tooltipShadow.style.display = 'none';
            if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
        }
    
    </script>

    <script type="text/javascript">

        function ValidateSampleforspe() {
            AlertType = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_01');
            var vSelectMoreSample = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_12') == null ? "Dont Select more than one sample" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_12');
            var vSelectSample = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_24') == null ? "Select a Sample" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_24');
            var vSelectAliquotAction = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_26') == null ? "Select Aliquot Action" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_26');

            var ddlactionslect = $("#ddlAction option:selected").val();
            if (ddlactionslect != "Aliquot_SampleSearch") {
                if ($("#hdnslidebarcode").val() == 'Y') {
                    alert('Select Slide Barcode Action');
                    return false;
                }
                else {

                ValidationWindow(vSelectAliquotAction, AlertType);
                    return false;
                }

            }


            var ddlactionslect = $("#ddlAction option:selected").val();
            if (ddlactionslect != "Force_Outsource") {
                var ddloutlocation = $("#ddloutlocation option:selected").val();
                if ($("#ddloutlocation").val() == '0' || $("#ddloutlocation").val() == '') {
                    alert('Select Outsource location');
                    return false;
                }
               

            }
            
            
            
            var checkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxSelect"]:checkbox';
            var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
            if (checkedCheckboxes.length == 0) {
                ValidationWindow(vSelectSample, AlertType);
                return false;
            }
            if (checkedCheckboxes.length > 1) {
                ValidationWindow(vSelectMoreSample, AlertType);
                return false;
            }

        }
    
    
    
    </script>

    <script type="text/javascript">
        function checkNumeric(event) {

            var kCode = event.keyCode || event.charCode; // for cross browser check

            //FF and Safari use e.charCode, while IE use e.keyCode that returns the ASCII value
            if ((kCode > 57 || kCode < 48) && (kCode != 46 && kCode != 45)) {
                //code for IE
                if (window.ActiveXObject) {
                    event.keyCode = 0
                    return false;
                }
                else {
                    event.charCode = 0
                }
            }
        }
    </script>
      <style type="text/css">
        .modalBackground1
        {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.9;
        }
    </style>
    <style type="text/css">
        .style18
        {
            width: 89px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">

        <script type="text/javascript">
            //                            $(function() {
            //                                $("#txtFrom").datepicker({
            //                                    changeMonth: true,
            //                                    changeYear: true,
            //                                    maxDate: 0,
            //                                    yearRange: '1900:2100'
            //                                });
            //                                $("#txtTo").datepicker({
            //                                    changeMonth: true,
            //                                    changeYear: true,
            //                                    maxDate: 0,
            //                                    yearRange: '1900:2100'
            //                                })
            //                            });
            $(function() {
                $("#txtFrom").datepicker({
                    dateFormat: 'dd/mm/yy',
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {
                        $("#txtTo").datepicker("option", "minDate", selectedDate);

                        var date = $("#txtFrom").datepicker('getDate');
                        //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                        // $("#txtTo").datepicker("option", "maxDate", d);

                    }
                });
                $("#txtTo").datepicker({
                    dateFormat: 'dd/mm/yy',
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {
                        $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                    }
                })
            });

        </script>

        <asp:Panel ID="pnlSerch" class="w-100p" runat="server" meta:resourcekey="pnlSerchResource1">
        
     
        
        
        <asp:Label runat="server" Visible=false ForeColor="Red" ID="hdnMessages1"></asp:Label>
        
            <table cellpadding="2" class="searchPanel w-100p" cellspacing="2" border="0">
                <tr>
                    <td class="w-10p" align="right">
                        <span class="richcombobox" style="width: 75px;">
                       <%-- onChange="jsFunction(this.value); added by sudha from lal--%>
                            <asp:DropDownList CssClass="ddl" ID="ddlType" Width="75px" runat="server" BackColor="AliceBlue" onChange="jsFunction(this.value);">
                   <%--             <asp:ListItem Text="Visit No." Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                <asp:ListItem Text="Sample ID" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </span>
                        <%--                                    <asp:Label ID="Rs_FromVisitNo"  Text="Visit No" runat="server" 
                                        meta:resourcekey="Rs_FromVisitNoResource1"></asp:Label>--%>
                    </td>
                    <td class="w-20p">
                        <asp:TextBox ID="txtVisitID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromVisitResource1"></asp:TextBox>
                    </td>
                    <td class="w-10p" align="left">
                        <asp:Label ID="Rs_ToVisitNo" Text="Patient Name" runat="server" meta:resourcekey="Rs_ToVisitNoResource1"></asp:Label>
                    </td>
                    <td class="w-20p">
                        <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtToVisitResource1"></asp:TextBox>
                    </td>
                    <td align="left" class="w-10p">
                        <asp:Label ID="Rs_VisitType" Text=" Visit Type" runat="server" meta:resourcekey="Rs_VisitTypeResource1"></asp:Label>
                    </td>
                    <td class="w-20p">
                        <span class="richcombobox" style="width: 75px;">
                            <asp:DropDownList CssClass="ddl" ID="ddVisitType" Width="75px" runat="server" >
                           <%--     <asp:ListItem Text="Select" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                <asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <%=Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_05 %>
                    </td>
                    <td>
                        <span class="richcombobox" style="width: 130px;">
                            <asp:DropDownList CssClass="ddl" ID="ddlLocation" Width="130px" runat="server" meta:resourcekey="ddlLocationResource1">
                            </asp:DropDownList>
                        </span>
                    </td>
                    <td align="left">
                        <%=Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_06 %>
                    </td>
                    <td>
                        <span class="richcombobox" style="width: 130px;">
                            <asp:DropDownList CssClass="ddl" ID="ddClientName" Width="130px" runat="server" meta:resourcekey="ddClientNameResource1">
                            </asp:DropDownList>
                        </span>
                    </td>
                    <td align="left">
                        <%=Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_07 %>
                    </td>
                    <td>
                        <asp:TextBox ID="txtRefDrName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearRefPhyDetails();"
                            meta:resourcekey="txtRefDrNameResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtRefDrName" ServiceMethod="GetPhysician" ServicePath="~/WebService.asmx"
                            EnableCaching="False" BehaviorID="AutoCompleteExLstGrp12" CompletionInterval="2"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                            Enabled="True" OnClientItemSelected="SelectedRefPhy">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <%=Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_08 %>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearTestDetails();"
                            meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg" ServicePath="~/WebService.asmx"
                            EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                            Enabled="True" OnClientItemSelected="SelectedTest">
                        </ajc:AutoCompleteExtender>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label3" runat="server" Text="Sample" meta:resourcekey="Label3Resource1"></asp:Label>
                    </td>
                    <td>
                        <span class="richcombobox" style="width: 130px;">
                            <asp:DropDownList CssClass="ddl" Width="130px" ID="ddlSample" runat="server" meta:resourcekey="ddlSampleResource1">
                            </asp:DropDownList>
                        </span>
                    </td>
                    <td align="left">
                        <%=Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_09 %>
                    </td>
                    <td style="width: 20%;">
                        <span class="richcombobox" style="width: 80px;">
                            <asp:DropDownList CssClass="ddl" ID="ddlPriority" Width="80px" runat="server" Enabled="False">
                          <%--      <asp:ListItem Text="Select" Value="-1" Selected="True" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                <asp:ListItem Text="VIP" Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                <asp:ListItem Text="Emergency" Value="1" meta:resourcekey="ListItemResource8"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="Rs_From" runat="server" meta:resourcekey="Rs_FromResource1"></asp:Label>
                    </td>
                    <td>
                        <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="25" size="20"
                                        meta:resourcekey="txtFromResource1"></asp:TextBox>
                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="left">
                        <asp:Label ID="Rs_To" Text="To Date" runat="server" meta:resourcekey="Rs_ToResource1"></asp:Label>
                    </td>
                    <td>
                        <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:TextBox runat="server" ID="txtTo" MaxLength="25" CssClass="Txtboxsmall" size="20"
                                        meta:resourcekey="txtToResource1"></asp:TextBox>
                                    <img align="middle" alt="" src="../Images/starbutton.png" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblSampleStatus1" runat="server" Text="Sample Status" meta:resourcekey="lblSampleStatus1Resource1"></asp:Label>
                    </td>
                    <td>
                        <span class="richcombobox" style="width: 90px;">
                            <asp:DropDownList CssClass="ddl" ID="ddlSampleStatus" onchange="javascript:LoadrdoBtns();"
                                Width="90px" runat="server" meta:resourcekey="ddlSampleStatusResource1">
                            </asp:DropDownList>
                        </span>&nbsp;
                        <img align="middle" alt="" src="../Images/starbutton.png" />
                        <asp:HiddenField ID="hdnSampleStatus" runat="server" />
                        <asp:CheckBox ID="chkAberrant" TextAlign="Right" Text="Aberrant Sample" runat="server"
                            Onclick="SetSampleStatus(this.id)" meta:resourcekey="chkAberrantResource1" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <%=Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_10 %>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUsers" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtUsersResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoUsers" MinimumPrefixLength="2" runat="server" TargetControlID="txtUsers"
                            ServiceMethod="getUserNamesWithID" ServicePath="~/WebService.asmx" EnableCaching="False"
                            BehaviorID="AutoCompleteExLstGrp13" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedUsers">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnUserLoginID" Value="0" runat="server" />
                        <%--<asp:TextBox ID="txtUsers" runat="server"  CssClass="Txtboxsmall" ></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoUserd" MinimumPrefixLength="2" runat="server" TargetControlID="txtUsers"
                                             EnableCaching="false" ServiceMethod="getUserNamesWithID" ServicePath="~/WebService.asmx"
                                             CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                             BehaviorID="AutoCompleteExLstGrp13" CompletionInterval="2" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                             DelimiterCharacters=";,:" Enabled="true" OnClientItemSelected="SelectedUsers">
                                        </ajc:AutoCompleteExtender>                                                                                
                                        <asp:HiddenField ID="hdnUserLoginID" Value="0" runat="server" />--%>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblBarCodeFrom" Text="Barcode From" runat="server" meta:resourcekey="lblBarCodeFromResource1"></asp:Label>
                    </td>
                    <td>
                        <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:TextBox runat="server" ID="txtBarCodeFrom" CssClass="Txtboxsmall" MaxLength="25"
                                        size="20" onkeydown="return isNumerc(event,this.id);" meta:resourcekey="txtBarCodeFromResource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblBarCodeTo" Text="Barcode To" runat="server" meta:resourcekey="lblBarCodeToResource1"></asp:Label>
                    </td>
                    <td>
                        <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:TextBox runat="server" ID="txtBarcodeTo" MaxLength="25" CssClass="Txtboxsmall"
                                        size="20" onkeydown="return isNumerc(event,this.id);" meta:resourcekey="txtBarcodeToResource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="Label9" runat="server" Text="Register Location" meta:resourcekey="Label9Resource1"></asp:Label>
                    </td>
                    <td>
                        <span class="richcombobox" style="width: 172px;">
                            <asp:DropDownList ID="ddlRegLocation" runat="server" CssClass="ddl" Width="130px"
                                meta:resourcekey="ddlRegLocationResource1">
                            </asp:DropDownList>
                        </span>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblPreference" Text="Preference" runat="server" meta:resourcekey="lblPreferenceResource1"></asp:Label>
                    </td>
                    <td>
                        <span class="richcombobox" style="width: 80px;">
                            <asp:DropDownList ID="ddlPrefrence" CssClass="ddl" runat="server" Width="80px" meta:resourcekey="ddlPrefrenceResource1">
                            </asp:DropDownList>
                        </span>
                    </td>
                    <%--/* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */--%>
                    <%--<td align="left">
                       <asp:Label ID="lblToVisitNo" runat="server" Text="To VisitNo"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtToVisitNo" runat="server" CssClass="Txtboxsmall" 
                                                                MaxLength="25" size="20"></asp:TextBox>
                    </td> --%>
                     <td class="w-10p" align="left">
                        <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" meta:resourcekey="Rs_PatientNumberResource1"></asp:Label>
                    </td>
                    <td class="w-20p">
                        <asp:TextBox ID="txtPatientNumber" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                    <%--/* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */--%>
                </tr>
                <tr>
                    <td colspan="6" id="tdRdoBtns" style="display: none" align="right" runat="server">
                        <table class="w-65p">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOUTLOC" runat="server" Text="OutSourced Location" meta:resourcekey="lblOUTLOCResource1"></asp:Label>
                                    <asp:DropDownList ID="ddlOutSourcedLocations" runat="server" CssClass="ddl" Width="120px"
                                        meta:resourcekey="ddlOutSourcedLocationsResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblMode" runat="server" Text="Mode:" Font-Bold="True" meta:resourcekey="lblModeResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButton ID="RdoSendOutSource" runat="server" Text="Send for Outsourcing"
                                        onclick="javascript:ValidateRdoBtns()" meta:resourcekey="RdoSendOutSourceResource1" />
                                </td>
                                <td>
                                    <asp:RadioButton ID="RdoReceiveOutSource" runat="server" Text="Receive from Outsourcing"
                                        onclick="javascript:ValidateRdoBtns123()" meta:resourcekey="RdoReceiveOutSourceResource1" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkViewReport" Text="View Report" runat="server" ForeColor="Blue"
                                        Font-Bold="True" meta:resourcekey="chkViewReportResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%--  <asp:RadioButtonList ID="rdobtnStatus" runat="server" RepeatDirection="Horizontal"
                                            Style="display: none">
                                            <asp:ListItem>Send OutSource Samples</asp:ListItem>
                                            <asp:ListItem>Receive OutSource Samples</asp:ListItem>
                                        </asp:RadioButtonList>--%>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:CheckBox ID="Chkpkgout" Text="Outsource Entire Package Content" runat="server"
                            ForeColor="Blue" Font-Bold="True" meta:resourcekey="ChkpkgoutResource1" />
                    </td>
                    <td colspan="3" align="center">
                        <asp:Button ID="btnGo" runat="server" ToolTip="Click here to Generate Work Order"
                            Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                            Text="Search" OnClick="btnGo_Click" OnClientClick="return ValidateSearch();"
                            meta:resourcekey="btnFinishResource1" />
                    </td>
                    <td id="tdXLPrint" runat="server" align="center" style="display: none">
                        <table border="0" class="w-100p">
                            <tr>
                                <td align="right">
                                    <asp:ImageButton ID="btnConverttoXL" runat="server" OnClick="btnConverttoXL_Click"
                                        ImageUrl="~/Images/ExcelImage.GIF" meta:resourcekey="btnConverttoXLResource1" />
                                </td>
                                <td>
                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return CallPrint();"
                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server" id="IDColors">
                                        <td colspan="2"><b>SID : </b>
                                        <asp:TextBox ID="txtAuto" Enabled="false" runat="server" Width="10px" Height="10px" style="background-color:Green"></asp:TextBox>
                                            <asp:Label ID="lblAutoColor" Text="Barcode" runat="server"  meta:resourcekey="lblAutoColorResource1"></asp:Label>
                                        <asp:TextBox ID="txtblocks" Enabled="false" runat="server" Width="10px" Height="10px" style="background-color:Black"></asp:TextBox>
                                            <asp:Label ID="lblblockcolor" runat="server" Text="Block" meta:resourcekey="lblblockcolorResource1"></asp:Label>
                                            <asp:TextBox ID="txtSlides" Enabled="false" runat="server" Width="10px" Height="10px" style="background-color:Orange"></asp:TextBox>
                                            <asp:Label ID="lblslidescolor" Text="Slide" runat="server"  meta:resourcekey="lblslidescolorResource1"></asp:Label>
                                        </td>
                                        
                                        </tr>
            </table>
        </asp:Panel>
        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
            meta:resourcekey="lblStatusResource1"></asp:Label>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div align="center" id="processMessage" width="60%">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div runat="server" id="dInves" style="display: block;">
                    <table class="w-100p" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlSampleList" CssClass="dataheader2" BorderWidth="1px" runat="server"
                                    meta:resourcekey="pnlSampleListResource1">
                                    <table border="0" cellpadding="4" cellspacing="0" class="w-100p">
                                        <tr>
                                            <td>
                                                <div id="divPrintarea" runat="server" style="overflow: auto; height: 350px;">
                                                    <asp:GridView ID="grdOutSource" runat="server" AutoGenerateColumns="False" class="w-100p gridView"
                                                        AlternatingRowStyle-CssClass="trEven" AllowPaging="True" OnRowDataBound="grdOutSource_RowDataBound"
                                                        CellPadding="1" OnPageIndexChanging="grdOutSource_PageIndexChanging" meta:resourcekey="grdOutSourceResource1" >
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false" meta:resourcekey="TemplateFieldResource1">
                                                                <HeaderTemplate>
                                                                    <%-- <asp:CheckBox ID="ChkbxHeaderSelect" runat="server" />--%>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <%--<asp:RadioButton ID="rbSelect" GroupName="grpSelect" runat="server" OnClick="javascript:CheckOnOff(this.id,'grdSample');" />--%>
                                                                    <%-- <asp:CheckBox ID="ChkbxSelect" runat="server" />--%>
                                                                    <%-- <asp:HiddenField ID="hdnVisitId" runat="server" Value='<%# bind("PatientVisitID") %>' />
                                                                        <asp:HiddenField ID="hdnSampleId" runat="server" Value='<%# bind("SampleID") %>' />
                                                                        <asp:HiddenField ID="hdnGuid" runat="server" Value='<%# bind("gUID") %>' />
                                                                        <asp:HiddenField ID="hdnSampleTrackerID" runat="server" Value='<%# bind("SampleTrackerID") %>' />
                                                                        <asp:HiddenField ID="hdnOutSourcedOrgName" runat="server" Value='<%# bind("OutSourcedOrgName") %>' />
                                                                        <asp:HiddenField ID="hdnTaskID" runat="server" Value='<%# bind("TaskID") %>' />
                                                                        <asp:HiddenField ID="hdnSamplecollDate" runat="server" Value='<%# bind("SamplePickupDate") %>' />
                                                                        <asp:HiddenField ID="hdnInvID" runat="server" Value='<%# bind("InvestigationID") %>' />
                                                                        <asp:HiddenField ID="hdnAccessionNo" runat="server" Value='<%# bind("AccessionNumber") %>' />
                                                                        <asp:HiddenField ID="hdnAddressID" runat="server" Value='<%# bind("OutSourcingLocationID") %>' />--%>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ControlStyle-Width="15%" HeaderText="Patient" ItemStyle-HorizontalAlign="left" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPatientName" runat="server" Text='<%# bind("PatientName") %>' meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                                </ItemTemplate>
                                                               <%-- added by sudha Width="15%" change it for lal --%>
                                                                <ControlStyle Width="75%" />
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Visit Number" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPatientNo" runat="server" Text='<%# bind("PatientNumber") %>' meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Sample" ItemStyle-HorizontalAlign="Left" ItemStyle-ForeColor="Blue" meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSample" runat="server" Text='<%#bind("SampleDesc")%>' meta:resourcekey="lblSampleResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle ForeColor="Blue" HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Vacutainer / Additive" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblAdditive" runat="server" Text='<%# bind("SampleContainerName") %>'
                                                                        meta:resourcekey="lblAdditiveResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="SID" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource6">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblBarcode" runat="server" Text='<%#bind("BarcodeNumber")%>' meta:resourcekey="lblBarcodeResource1"></asp:Label>
                                                                    <asp:HiddenField ID="hdn_BarcodeNumber" runat="server" Value='<%# bind("BarcodeNumber") %>' />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Left" Visible="false" meta:resourcekey="TemplateFieldResource7">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSampleStatus" runat="server" Text='<%# bind("InvSampleStatusDesc") %>'
                                                                        meta:resourcekey="lblSampleStatusResource1"></asp:Label>
                                                                    <asp:HiddenField ID="hdnInvSampleStatusID" runat="server" Value='<%#bind("InvSampleStatusID")%>' />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Reason" Visible="false" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource8">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblReason" runat="server" Text='<%# bind("Reason") %>' meta:resourcekey="lblReasonResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Processing Location" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource9">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbllocation" runat="server" Text='<%# bind("LocationName") %>' meta:resourcekey="lbllocationResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Collected Location" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource10">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCollocation" runat="server" Text='<%# bind("CollectedLocationName") %>'
                                                                        meta:resourcekey="lblCollocationResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="OutSourced Location" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource11">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblutSourceLocation" runat="server" Text='<%# bind("OutSourcedOrgName") %>'
                                                                        meta:resourcekey="lblutSourceLocationResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField Visible="false" HeaderText="Test Name" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource12">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTestName" runat="server" Text='<%# bind("InvestigationName") %>'
                                                                        meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="OutsourcedDate" HeaderText="OutSourced Date" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                meta:resourcekey="BoundFieldResource1">
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ReceivedDate" HeaderText="Received Date" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                meta:resourcekey="BoundFieldResource2">
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <tr>
                                                    <td>
                                                        <div id="divgrdsample" runat="server">
                                                            <asp:GridView ID="grdSample" runat="server" AutoGenerateColumns="False" CssClass="w-100p searchPanel"
                                                                PageSize="10" DataKeyNames="PatientVisitID,SampleID,gUID,InvestigationID" PagerSettings-Mode="NextPrevious"
                                                                class="gridView w-100p" AllowPaging="True" OnRowCommand="grdSample_RowCommand"
                                                                OnRowDataBound="grdSample_RowDataBound" CellPadding="1" AlternatingRowStyle-CssClass="trEven" meta:resourcekey="grdSampleResource1">
                                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                    PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource13">
                                                                        <HeaderTemplate>
                                                                            <asp:CheckBox ID="ChkbxHeaderSelect" runat="server" onClick="checkAllRows(this);"
                                                                                meta:resourcekey="ChkbxHeaderSelectResource1" />
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <%--<asp:RadioButton ID="rbSelect" GroupName="grpSelect" runat="server" OnClick="javascript:CheckOnOff(this.id,'grdSample');" />--%>
                                                                            <asp:CheckBox ID="ChkbxSelect" runat="server" onClick="checkUncheckHeaderCheckBox(this);"
                                                                                meta:resourcekey="ChkbxSelectResource1" />
                                                                            <asp:HiddenField ID="hdnVisitId" runat="server" Value='<%# bind("PatientVisitID") %>' />
                                                                            <asp:HiddenField ID="hdnSampleId" runat="server" Value='<%# bind("SampleID") %>' />
                                                                            <asp:HiddenField ID="hdnGuid" runat="server" Value='<%# bind("gUID") %>' />
                                                                            <asp:HiddenField ID="hdnSampleTrackerID" runat="server" Value='<%# bind("SampleTrackerID") %>' />
                                                                            <asp:HiddenField ID="hdnOutSourcedOrgName" runat="server" Value='<%# bind("OutSourcedOrgName") %>' />
                                                                            <asp:HiddenField ID="hdnTaskID" runat="server" Value='<%# bind("TaskID") %>' />
                                                                            <asp:HiddenField ID="hdnSamplecollDate" runat="server" Value='<%# bind("SamplePickupDate") %>' />
                                                                            <asp:HiddenField ID="hdnInvID" runat="server" Value='<%# bind("InvestigationID") %>' />
                                                                            <asp:HiddenField ID="hdnAccessionNo" runat="server" Value='<%# bind("AccessionNumber") %>' />
                                                                            <asp:HiddenField ID="hdnAddressID" runat="server" Value='<%# bind("OutSourcingLocationID") %>' />
                                                                            <asp:HiddenField ID="hdnPatientName" runat="server" Value='<%# bind("PatientName") %>' />
                                                                            <asp:HiddenField ID="hdnORDStatus" runat="server" Value='<%# bind("ClientName") %>' />
                                                                            <asp:HiddenField ID="hdnBarcodeNumber" runat="server" Value='<%# bind("BarcodeNumber") %>' />
                                                                            <asp:HiddenField ID="hdnSamplename" runat="server" Value='<%# bind("SampleDesc") %>' />
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ControlStyle-Width="15%" HeaderText="Patient" ItemStyle-HorizontalAlign="left" meta:resourcekey="TemplateFieldResource14">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientName" runat="server" Text='<%#bind("PatientName")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ControlStyle Width="15%" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Visit Number" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource15">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientNo" runat="server" Text='<%# bind("PatientNumber") %>' meta:resourcekey="lblPatientNoResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sample" ItemStyle-HorizontalAlign="Left" ItemStyle-ForeColor="Blue" meta:resourcekey="TemplateFieldResource16">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSample" runat="server" Text='<%# bind("SampleDesc") %>' meta:resourcekey="lblSampleResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle ForeColor="Blue" HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Vacutainer / Additive" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource17">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAdditive" runat="server" Text='<%# bind("SampleContainerName") %>'
                                                                                meta:resourcekey="lblAdditiveResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="SID" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource18">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBarcode" runat="server" Text='<%# bind("BarcodeNumber") %>' Style="cursor: pointer;"
                                                                                Font-Underline="True" ForeColor="Green" meta:resourcekey="lblBarcodeResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource19">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSampleStatus" runat="server" Text='<%# bind("InvSampleStatusDesc") %>'
                                                                                meta:resourcekey="lblSampleStatusResource2"></asp:Label>
                                                                            <asp:HiddenField ID="hdnInvSampleStatusID" runat="server" Value='<%#bind("InvSampleStatusID")%>' />
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Reason" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource20">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblReason" runat="server" Text='<%# bind("Reason") %>' meta:resourcekey="lblReasonResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Processing Location" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource21">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbllocation" runat="server" Text='<%# bind("LocationName") %>' meta:resourcekey="lbllocationResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Collected Location" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource22">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCollocation" runat="server" Text='<%# bind("CollectedLocationName") %>'
                                                                                meta:resourcekey="lblCollocationResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="OutSourced Location" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource23">
                                                                        <ItemTemplate>
                                                                            <asp:DropDownList ID="ddlOutSourceLoc" runat="server" CssClass="ddl" Width="130px">
                                                                            </asp:DropDownList>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField Visible="false" HeaderText="OutSourced Location" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource24">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblutSourceLocation" runat="server" Text='<%# bind("OutSourcedOrgName") %>'
                                                                                meta:resourcekey="lblutSourceLocationResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Test Name" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource25">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTestName" runat="server" Text='<%# bind("InvestigationName") %>'
                                                                                meta:resourcekey="lblTestNameResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                     <asp:TemplateField HeaderText="Test Status" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource36">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTeststatus" runat="server" Text='<%# bind("Clientname") %>' ></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="CreatedAt" HeaderText="Event Date Time" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                        meta:resourcekey="BoundFieldResource3">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Collected Date Time" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource26">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCollectedDate" class="lblCollectefunc" runat="server" Style="cursor: pointer;"
                                                                                Font-Underline="True" ForeColor="Green" Text='<%# Eval("CollectedDate", "{0:dd-MM-yyyy hh:mm:ss tt}") %>'
                                                                                meta:resourcekey="lblCollectedDateResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                      </asp:TemplateField>
                                                                    
                                                                     <asp:TemplateField HeaderText="Visite Status" ItemStyle-HorizontalAlign="Left" Visible="false"  >
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblvisitestatus" runat="server" Text='<%# bind("Clientname") %>' meta:resourcekey="lblReasonResource2"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Collected By" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource37">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCollectedBy"  runat="server"  Text='<%# bind("CollectedBy") %>'
                                                                                meta:resourcekey="lblCollectedDateResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Received By" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource38">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblReceivedBy" runat="server"  Text='<%# bind("ReceivedBy") %>'
                                                                                meta:resourcekey="lblCollectedDateResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Received Date" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource39">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblReceivedDate" runat="server" 
                                                                                Text='<%# Eval("ReceivedDate", "{0:dd-MM-yyyy hh:mm:ss tt}") %>'
                                                                                meta:resourcekey="lblCollectedDateResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </td>
                                        </tr>
                                        <tr id="GrdFooter" runat="server" class="dataheaderInvCtrl">
                                            <td align="center" class="defaultfontcolor">
                                                <asp:Label ID="Label4" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                <asp:Label ID="Label5" runat="server" Text="Of" meta:resourcekey="Label5Resource1"></asp:Label>
                                                <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click"
                                                    meta:resourcekey="Btn_PreviousResource1" />
                                                <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click"
                                                    meta:resourcekey="Btn_NextResource1" />
                                                <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                <asp:Label ID="Label6" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label6Resource1"></asp:Label>
                                                <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxsmall" Width="30px" autocomplete="off"
                                                    meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo1_Click"
                                                    onmouseover="this.className='btn btnhov'" meta:resourcekey="btnGo1Resource1"
                                                    OnClientClick="return checkForValues()" />
                                                <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="pnlFooter" CssClass="dataheader2" BorderWidth="1px" runat="server"
                                    meta:resourcekey="pnlFooterResource1">
                                    <table width="50%" id="tblaction" runat="server">
                                        <tr>
                                            <td align="right" id='tblactiontd' runat="server">
                                                <table class="w-50p">
                                                    <tr>
                                                        <td id="Td2" style="color: #000;" align="right" runat="server" class="style18">
                                                            <asp:Label ID="lblReAssign" Text="Action" runat="server" meta:resourcekey="lblReAssignResource1"></asp:Label>
                                                        </td>
                                                        <td id="Td3" runat="server" style="color: #000;" align="right">
                                                            <span class="richcombobox" style="width: 130px;">
                                                                <asp:DropDownList runat="server" CssClass="ddl" Width="130px" ID="ddlAction" onchange="DDLAction();"
                                                                    OnSelectedIndexChanged="ddlAction_SelectedIndexChanged" meta:resourcekey="ddlActionResource1">
                                                                </asp:DropDownList>
                                                            </span>
                                                        </td>
                                                        
                                                        
                                                        <td id="Td1" style="color: #000;" align="right" runat="server" >
                                                            <asp:Label ID="Label8" Text="OutSourced Location" runat="server" meta:resourcekey="lblOUTLOCResource1"></asp:Label>
                                                        </td>
                                                     <td id="Tdlocation" runat="server">
                                    
                                                            <asp:DropDownList ID="ddloutlocation" runat="server" Width="100%" normalWidth="100px" CssClass="ddlsmall" meta:resourcekey="ddlOutSourcedLocationsResource1">
                                                                 
                                                                
                                                            </asp:DropDownList>
                                                        </td>
                                                        
                                                        <td id="TdReason" runat="server">
                                                            <asp:DropDownList ID="ddlReason" runat="server" Width="100px" normalWidth="100px"
                                                                onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                                                CssClass="ddlsmall" meta:resourcekey="ddlReasonResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td id="tdaliquot" runat="server">
                                                            <asp:TextBox ID="TxtAliquot" runat="server" Text="0" MaxLength="2" Width="25px" onkeyup="javascript: validateAliquot(this);"
                                                                Style="display: none;" meta:resourcekey="TxtAliquotResource1"></asp:TextBox>
                                                            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                                                                TargetControlID="TxtAliquot" Enabled="True">
                                                            </ajc:FilteredTextBoxExtender>
                                                               </td>
                                                               <td id="td5" runat="server">
                                                            <asp:TextBox ID="txtReprintCount" runat="server" Text="1" MaxLength="1" Width="25px"
                                                                Style="display: none;"></asp:TextBox>
                                                            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender3"
                                                                TargetControlID="txtReprintCount" Enabled="True">
                                                            </ajc:FilteredTextBoxExtender>
                                                               </td>
                                                        <td id="td_CheckBox_Slide" runat="server">
                                                            <asp:CheckBoxList ID="CheckBox_Slide" runat="server">
                                                            </asp:CheckBoxList> 
                                                        </td>
                                                        <td id="tdNewBarcode" runat="server">
                                                            <asp:TextBox ID="txtNewBarcode" runat="server" CssClass="Txtboxsmall" MaxLength="15"
                                                                Style="display: none;" meta:resourcekey="txtNewBarcodeResource1"></asp:TextBox>
                                                            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                                                                TargetControlID="txtNewBarcode" Enabled="True">
                                                            </ajc:FilteredTextBoxExtender>
                                                        </td>
                                                        <td id="Td4" align="right" runat="server">
                                                            <asp:Button ID="btnOK" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" Style="cursor: pointer;" OnClientClick="return ValidateSelect11();"
                                                                OnClick="btnOK_Click" meta:resourcekey="btnOKResource1" />
                                                        </td>
                                                        <td>
                                                            <%--<asp:Button ID="btnsecondlayer" runat="server" Text="BarcodeBlock" OnClientClick="return Validatespeciman();"
                                                                                      OnClick="Barcodesecondlayer" class="btn" />--%>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnHiddne" runat="server" Text="hidden" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnHiddne_Click" Style="display: none;"
                                                                meta:resourcekey="btnHiddneResource1" />
                                                            <div id="But" runat="server">
                                                                <asp:Button ID="linkBarcodeLayerGenerate" OnClientClick="return ValidateSampleforspe();"
                                                                    OnClick="LoadAliqout" runat="server" CssClass="btn" Text="Barcode/Block" meta:resourcekey="linkBarcodeLayerGenerateResource1" />
                                                            </div>
                                                            <asp:HiddenField runat="server" ID="hdnVisit" />
                                                            <asp:HiddenField runat="server" ID="hdnPatientNumber" />
                                                            <asp:HiddenField runat="server" ID="hdnPatID" />
                                                            <asp:HiddenField ID="hdnReasonList" runat="server" />
                                                            <asp:HiddenField ID="hdnReasonCtls" runat="server" />
                                                            <asp:HiddenField ID="hdnStatusCtls" runat="server" />
                                                            
                                                            <asp:HiddenField ID="hdnRefPhyName" runat="server" />
                                                            <asp:HiddenField ID="hdnRefPhyID" Value="0" runat="server" />
                                                            <asp:HiddenField ID="hdnRefPhyOrg" runat="server" />
                                                            <asp:HiddenField ID="hdnClickEvent" Value="No" runat="server" />
                                                            <asp:HiddenField ID="hdnTestCheckBoxId" runat="server" />
                                                            <asp:HiddenField ID="hdnPatientVisitID" runat="server" Value="-1" />
                                                            <asp:HiddenField ID="hdnslidebarcode" runat="server" Value="" />
                                                            <asp:HiddenField ID="hdnOrgID" runat="server" Value="" />
                                                            <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
							    <asp:HiddenField ID="hdnInvestigationID" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnEnableMultiplereprint" runat="server" Value="" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <ajc:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
                                                                DynamicServicePath="" TargetControlID="hidForModel" CancelControlID="imgPopupCloseAliqout"
                                                                PopupControlID="PanelAliqout">
                                                            </ajc:ModalPopupExtender>
                                                            <asp:Panel ID="PanelAliqout" BorderWidth="1px" runat="server" Width="270px" Height="85%"
                                                                CssClass="modalBackground1" Style="display: block; z-index: 999;" meta:resourcekey="PanelAliqoutResource1">
                                                                <asp:Panel ID="PanelAliqoutclose" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td>
                                                                            </td>
                                                                            <td align="right">
                                                                                <img id="imgPopupCloseAliqout" src="../Images/dialog_close_button.png" runat="server"
                                                                                    alt="Close" style="cursor: pointer;" onclick="return Actionstyle();" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                                <br />
                                                                <asp:Panel ID="plnsubaliqout" CssClass="Aliqoutcontentdata" runat="server" meta:resourcekey="plnsubaliqoutResource1">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td>
                                                                                <div id="divgvaliqout" align="center" class="w-100p" runat="server">
                                                                                    <asp:UpdatePanel ID="UpdatepanelAliqout" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:GridView ID="Gvaliqoutbarcode" align="center" runat="server" AutoGenerateColumns="False"
                                                                                                AllowPaging="true" CellPadding="4" ForeColor="#333333" GridLines="Both" CssClass="gridView w-100p"
                                                                                                OnPageIndexChanging="Gvaliqoutbarcode_PageIndexChanging" OnRowDataBound="Gvaliqoutbarcode_RowDataBound" meta:resourcekey="GvaliqoutbarcodeResource1">
                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                <Columns>
                                                                                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource27">
                                                                                                        <HeaderTemplate>
                                                                                                            <asp:CheckBox ID="ChkbxalioutHeader" runat="server" onClick="checkAllRows(this);"
                                                                                                                meta:resourcekey="ChkbxalioutHeaderResource1" />
                                                                                                        </HeaderTemplate>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:CheckBox ID="ChkbxalioutSelect" runat="server" onClick="checkUncheckHeaderCheckBox(this);"
                                                                                                                meta:resourcekey="ChkbxalioutSelectResource1" />
                                                                                                            <asp:HiddenField ID="hdnalioutVisitId" runat="server" Value='<%# bind("PatientVisitID") %>' />
                                                                                                            <asp:HiddenField ID="hdnalioutSampleId" runat="server" Value='<%# bind("SampleID") %>' />
                                                                                                            <asp:HiddenField ID="hdnaliqoutbarcode" runat="server" Value='<%#bind("BarcodeNumber") %>' />
                                                                                                        </ItemTemplate>
                                                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:TemplateField HeaderText="SpecimenBarcode" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource28">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:Label ID="lblaliqoutbarcode" runat="server" Text='<%#bind("BarcodeNumber") %>' meta:resourcekey="lblaliqoutbarcodeResource1">
                                                                                                            </asp:Label>
                                                                                                        </ItemTemplate>
                                                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:TemplateField HeaderText="SpecimenCount" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource29">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:TextBox ID="txtSpecimenCount" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                                                Width="30px" meta:resourcekey="txtSpecimenCountResource1"></asp:TextBox>
                                                                                                        </ItemTemplate>
                                                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                                                    </asp:TemplateField>
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                    <br />
                                                                                    <br />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="a-center">
                                                                                <asp:UpdatePanel ID="upbtnbarcode" runat="server">
                                                                                    <ContentTemplate>
                                                                                        <asp:Button ID="btnsecondlayer" runat="server" Text="BarcodeBlock" OnClientClick="return Validatespeciman();"
                                                                                            OnClick="Barcodesecondlayer" class="btn" meta:resourcekey="btnsecondlayerResource1" />
                                                                                    </ContentTemplate>
                                                                                </asp:UpdatePanel>
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                        <asp:HiddenField ID="hidForModel" runat="server" />
                                                                    </table>
                                                                </asp:Panel>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnVisitId1" runat="server" />
                    <asp:HiddenField ID="hdnsampleid" runat="server" />
                    <ajc:ModalPopupExtender ID="modalpopupcollectdate" runat="server" PopupControlID="DatePopupInvPanel1"
                        TargetControlID="hdnsampleid" BackgroundCssClass="modalBackground" CancelControlID="imgPopupClose1"
                        DynamicServicePath="" Enabled="True">
                    </ajc:ModalPopupExtender>
                    <asp:Panel ID="DatePopupInvPanel1" BorderWidth="1px" runat="server" Width="550px"
                        CssClass="modalPopup dataheaderPopup" Style="display: none; z-index: 999;" meta:resourcekey="DatePopupInvPanel1Resource1">
                        <asp:Panel ID="Panel3" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel3Resource1">
                            <table class="w-100p">
                                <tr>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblCollectedDate" runat="server" Text="Select Collected DateTime Details"
                                            meta:resourcekey="lblCollectedDateResource2"></asp:Label>
                                    </td>
                                    <td align="right">
                                        <img id="imgPopupClose1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                            class="imgPopupClose" style="cursor: pointer;" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <table class="w-100p" cellpadding="1" cellspacing="2" border="0">
                            <tr>
                                <td class="w-40p">
                                    <asp:Label ID="lblsampleCollected" Font-Bold="True" runat="server" Text="Sample Collected Date Time :"
                                        meta:resourcekey="lblsampleCollectedResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblsamcolldatetxt1" Font-Bold="True" ForeColor="Black" runat="server"
                                        Text="--" meta:resourcekey="lblsamcolldatetxt1Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trNewCollectedDate" runat="server">
                                <td>
                                    <asp:Label ID="lblCollectedTime" Font-Bold="true" runat="server" Text="New Collected Date Time:"   meta:resourcekey="lblCollectedTimeResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtNewCollectTime" CssClass="Txtboxsmall" MaxLength="25"
                                        size="20"></asp:TextBox>
                                    <%-- <a href="javascript:NewCssCal('<% =txtOutsourcedTime.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                    <img  src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>--%>
                                    <img onclick="return SetOutSourceDate1()" style="cursor: hand;" id="img4" src="../Images/Calendar_scheduleHS.png"
                                        width="16" height="16" border="0" alt="Pick a date" />
                                </td>
                            </tr>
                            <tr>
                            <td>
                            <asp:Label ID="lblSlide" Font-Bold="true" runat="server" Text="Slide Stain:"></asp:Label>
                            </td>
                            <td>
                             <asp:CheckBoxList ID="Check_boxslide" runat="server">
                             </asp:CheckBoxList>                            
                            
                            </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button ID="btnSave" CssClass="btn" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return ValidateSelect15();" 
                                        meta:resourcekey="btnSaveResource1" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                        DynamicServicePath="" TargetControlID="btnDummy1" CancelControlID="imgPopupClose"
                        Enabled="True" PopupControlID="InvPanel">
                    </ajc:ModalPopupExtender>
                    <asp:Panel ID="InvPanel" BorderWidth="1px" runat="server" Width="550px" Height="400px"
                        CssClass="modalPopup dataheaderPopup" Style="display: block; z-index: 999;" meta:resourcekey="InvPanelResource1">
                        <asp:Panel ID="Panel1" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Enter Outsourcing Details" meta:resourcekey="Label1Resource2"></asp:Label>
                                    </td>
                                    <td align="right">
                                        <img id="imgPopupClose" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                            style="cursor: pointer;" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <table class="w-100p" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td class="w-40p">
                                            <asp:Label ID="lblOutsourceOrg" Font-Bold="True" runat="server" Text="Outsourced Organization :"
                                                meta:resourcekey="lblOutsourceOrgResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblOutsourceOrgtxt" Font-Bold="True" ForeColor="Red" runat="server"
                                                Text="--" meta:resourcekey="lblOutsourceOrgtxtResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-40p">
                                            <asp:Label ID="lblsamcolldate" Font-Bold="True" runat="server" Text="Sample Collected Date :"
                                                meta:resourcekey="lblsamcolldateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblsamcolldatetxt" Font-Bold="True" ForeColor="Black" runat="server"
                                                Text="--" meta:resourcekey="lblsamcolldatetxtResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trOutsourceDt" runat="server" style="display: none">
                                        <td>
                                            <asp:Label ID="lblOutSourcedTime" Font-Bold="true" runat="server" meta:resourcekey="lblOutSourcedTimeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtOutsourcedTime" CssClass="Txtboxsmall" MaxLength="25"
                                                size="20"></asp:TextBox>
                                            <%-- <a href="javascript:NewCssCal('<% =txtOutsourcedTime.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                    <img  src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>--%>
                                            <img onclick="return SetOutSourceDate()" style="cursor: hand;" id="img1" src="../Images/Calendar_scheduleHS.png"
                                                width="16" height="16" border="0" alt="Pick a date" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblCourierDetails" Font-Bold="True" runat="server" Text="Comments:"
                                                meta:resourcekey="lblCourierDetailsResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtCourierDetails" TextMode="MultiLine" meta:resourcekey="txtCourierDetailsResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="trSamplrechdDt" style="display: none" runat="server">
                                        <td>
                                            <asp:Label ID="lblAcknowledgement" Font-Bold="true" runat="server" Text="SampleReached Date :"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtAcknowledgement" CssClass="Txtboxsmall" MaxLength="25"></asp:TextBox>
                                            <img onclick="return SetSamplereachedDate()" style="cursor: hand;" id="img3" src="../Images/Calendar_scheduleHS.png"
                                                width="16" height="16" border="0" alt="Pick a date" />
                                        </td>
                                    </tr>
                                    <tr id="trReceiveDt" style="display: none" runat="server">
                                        <td>
                                            <asp:Label ID="lblReceivedDateTime" Font-Bold="true" runat="server" meta:resourcekey="lblReceivedDateTimeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtReceivedDateTime" CssClass="Txtboxsmall" MaxLength="25"
                                                size="20"></asp:TextBox>
                                            <%-- <a href="javascript:NewCssCal('<% =txtReceivedDateTime.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                    <img  src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>--%>
                                            <img onclick="return SetReceivedDate()" style="cursor: hand;" id="img2" src="../Images/Calendar_scheduleHS.png"
                                                width="16" height="16" border="0" alt="Pick a date" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:Button ID="btnSaveOutsource" CssClass="btn" runat="server" Text="Save" OnClick="btnSaveOutsource_Click"
                                                meta:resourcekey="btnSaveOutsourceResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:Panel ID="Panel2" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Saved Outsourcing Details" meta:resourcekey="Label1Resource2"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdOutSourcedDetails" runat="server" CssClass="gridView w-100p"
                                        AlternatingRowStyle-CssClass="trEven" EmptyDataText="Outsourced Details are Not Saved"
                                        OnRowDataBound="grdOutSourcedDetails_RowDataBound" AutoGenerateColumns="False" meta:resourcekey="grdOutSourcedDetailsResource1"
                                        Height="12%" Style="margin-left: 0px">
                                        <Columns>
                                            <asp:TemplateField HeaderText="OutSourced Date" ItemStyle-HorizontalAlign="left" meta:resourcekey="TemplateFieldResource35">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOutSourcedDate" runat="server" Text='<%# Eval("OutsourcedDate", "{0:dd-MM-yyyy hh:mm:ss tt}")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Courier Details" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource31">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCourierDet" runat="server" Text='<%# bind("CourierDetails") %>'
                                                        meta:resourcekey="lblCourierDetResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sample Send Date" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource32">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAckment" runat="server" Text='<%# Eval("OutsourcedDate", "{0:dd-MM-yyyy hh:mm:ss tt}") %>'
                                                        meta:resourcekey="lblAckmentResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sample Received Date" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource33">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReceivedDate" runat="server" Text='<%# Eval("ReceivedDate", "{0:dd-MM-yyyy hh:mm:ss tt}") %>'
                                                        meta:resourcekey="lblReceivedDateResource1"></asp:Label>
                                                </ItemTemplate>
                                                
           
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="InvestigationID" ItemStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInvestigationID" runat="server" Text='<%# bind("InvestigationID") %>'
                                                        meta:resourcekey="lblReceivedDateResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="dataheader1" Width="8" Height="4%" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <ajc:ModalPopupExtender ID="ModalPopupBlockandSlidePreparation" runat="server" PopupControlID="PnlBlockandSlidePreparation"
                        TargetControlID="hdnsampleid" BackgroundCssClass="modalBackground" CancelControlID="imgPopupClose11"
                        DynamicServicePath="" Enabled="True">
                    </ajc:ModalPopupExtender>
                    <asp:Panel ID="PnlBlockandSlidePreparation" BorderWidth="1px" runat="server" 
                        CssClass="modalPopup dataheaderPopup" Style="display: none; z-index: 999; min-height: 200px; width:650px;"
                        meta:resourcekey="DatePopupInvPanel1Resource1">
                        <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel3Resource1">
                            <table class="w-100p">
                                <tr>
                                    <td style="text-align: center">
                                        <asp:Label ID="Label7" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td align="right">
                                        <img id="imgPopupClose11" src="../Images/dialog_close_button.png" runat="server"
                                            alt="Close" class="imgPopupClose" style="cursor: pointer;" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <table class="w-100p" border="0">
                            <tr id="tblBlockBarcode" style="width: 630px; height: 32px; padding: 2px; margin: auto;">
                                <td>
                                    Histo No : <asp:Label ID="lblHisto" Text="" runat="server"></asp:Label>
                                </td>
                                <td>
                                    Patient Name :  <asp:Label ID="lblPatientName" Text="" runat="server"></asp:Label>
                                </td>
                                <td>
                                    Tissue : <asp:Label ID="lblTissue" Text="" runat="server"></asp:Label>
                                </td>
                                <td>
                                    Barcode No : <asp:Label ID="lblBarCode" Text="" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <div style="height: 30px;">
                            <span style="padding: 9px; text-decoration: underline; font-weight: bold;">Block Details :</span></div>
                   <div id="tblBlockSildeArea" style="/* width: 650px; */height: 300px;overflow-y: auto;"></div>
                    </asp:Panel>
                    <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
                    <div id="iframeplaceholder">
                        <iframe runat="server" id="iframeBarcode" name="iframeBarcode" style="position: absolute;
                            top: 0px; left: 0px; width: 0px; height: 0px; border: 0px; overfow: none; z-index: -1">
                        </iframe>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
   <%-- added by sudha from lal--%>
    <asp:HiddenField ID="hdnvidtxt" runat="server" />
	<asp:HiddenField ID="hidval" runat="server" />
    <asp:HiddenField ID="hdnTestName" runat="server" />
    <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnTestType" runat="server" />
    </form>
    <style type="text/css">
        #tblBlockBarcode td
        {
            border: 1px solid black;
        }
        #tblBlock tr
        {
        }
    </style>
  <script type="text/javascript" language="javascript">

     
      function showBlockandSlidePreparation(SampleID, Barcode, PatientName) {
          
          document.getElementById('lblPatientName').innerHTML = PatientName;
          document.getElementById('lblBarCode').innerHTML = Barcode;

          GetBlockandSlidePreparation(SampleID, Barcode);
         
         
          return false;
      }

      function GetBlockandSlidePreparation(SampleID, Barcode) {
          //var SampleID = 0;
          var tblStruct = "";
          $.ajax({
              type: "POST",
              url: "../WebService.asmx/GetBlockSlidePreparationDetails",
              data: "{ 'VisitNumber': '" + parseInt(SampleID) + "','BarCode': '" + Barcode + "' }",
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function(msg) {
                  // $("#jsonResponse").html(msg);
                  //alert(msg);
                  var j = 0;
                  if (msg.d.length >= 1) {
                      $find("ModalPopupBlockandSlidePreparation").show();
                      if (msg.d[0].Type == "Block") {
                          document.getElementById('lblTissue').innerHTML = msg.d[0].Tissue;
                          document.getElementById('lblHisto').innerHTML = msg.d[0].HistoNumber;
                          
                          $("#PnlBlockandSlidePreparation").css("width", "650px");
                          $("#PnlBlockandSlidePreparation").css("left", "354px");
                          tblStruct = "<table border=1 style='width: 640px;padding: 10px;' id='tblBlock'><tr><th>S.NO</th><th>Block BarCode</th><th>Block Type</th><th> Action</th><tr>";
                          for (var i = 0; i <= msg.d.length - 1; i++) {

                              tblStruct += "<tr align='Center'> <td>" + ++j + "</td><td>" + msg.d[i].BarCode + "</td><td><input type='text' id='txtBlckType' class='blocktype' value='" + msg.d[i].BlockType + "'></input></td><td><input type='button'  value='EDIT' id='EditBlockID' onclick='EditBlockType(this);'><input type='button' id='myBtn'  value='Update' onclick='UpdateBlock(this);'></td></tr>";
                          }
                          tblStruct += "</table>";
                          document.getElementById('tblBlockSildeArea').innerHTML = tblStruct;
                          tblStruct = "";
                          $('.blocktype').attr('readOnly', true);
                          $('.blocktype').css('background-color', 'rgba(204, 203, 203, 0.3)');
                      }
                      else if (msg.d[0].Type == "Slide") {
                          $("#PnlBlockandSlidePreparation").css("width", "1000px");
                          $("#PnlBlockandSlidePreparation").css("left", "135px");
                          document.getElementById('lblTissue').innerHTML = msg.d[0].Tissue;
                          document.getElementById('lblHisto').innerHTML = msg.d[0].HistoNumber;
                          tblStruct = "<table border=1 id='tblBlock' style='margin-left: 24px; width: 950px;'><tr><th>S.NO</th><th>Block BarCode</th><th>Block Type</th><th>Slide Barcode</th><th>Slide Name</th><th>Slide Comments</th><th>Stain Type</th><th> Action</th><tr>";
                          for (var i = 0; i <= msg.d.length - 1; i++) {

                              tblStruct += "<tr align='Center'> <td>" + ++j + "</td><td>" + Barcode + "</td><td><span id='lblBlockType'>" + msg.d[i].BlockType + "</span></td><td> <span id='lblSlideBarcode'>" + msg.d[i].BarCode
                              + "</span></td><td><input type='text' style='width: 100px;' class='txtcommon' id='txtSlideName' value='" + msg.d[i].SlideName + "'></input></td><td><input type='text' style='width: 100px;'  class='txtcommon' id='txtSlidecmmt' value='"
                              + msg.d[i].SlideComments + "'></input></td><td><input type='text' style='width: 100px;'  class='txtcommon' id='txtStainType' value='" + msg.d[i].StainType + "'></input></td><td><input type='button' id='myBtn' onclick='EditSlideType(this);'  value='EDIT'><input type='button' id='myBtn'  value='Update' onclick='UpdateSlide(this);'></td></tr>";
                          }
                          tblStruct += "</table>";
                          document.getElementById('tblBlockSildeArea').innerHTML = tblStruct;
                          tblStruct = "";
                          $('.txtcommon').attr('readOnly', true);
                          $('.txtcommon').css('background-color', 'rgba(204, 203, 203, 0.3)');
                      }
                      //alert("Super");


                  }
                  else {
                      $find("ModalPopupBlockandSlidePreparation").hide();
                      document.getElementById('tblBlockSildeArea').innerHTML = "";
                  }

                  //                  var data = msg.d;

                  //                  alert(data);
              },
              error: function(msg) {
                  alert(msg.d);
              }

          });
      }

      function EditSlideType(input) {

          //$(input).closest("tr").find('.txtcommon').show();
          $(input).closest("tr").find('.txtcommon').attr('readOnly', false);
          $(input).closest("tr").find('.txtcommon').css('background-color', 'rgb(255, 255, 255)');
        
      }

      function UpdateSlide(input) {
      var SlideName=    $(input).closest("tr").find('#txtSlideName').val();
       var SlideComments=   $(input).closest("tr").find('#txtSlidecmmt').val();
      var StainType=    $(input).closest("tr").find('#txtStainType').val();
      var BlockType=    $(input).closest("tr").find('#lblBlockType').text();
      var BarCode=    $(input).closest("tr").find('#lblSlideBarcode').text();

      var PrimaryBarcode = document.getElementById('lblBarCode').innerHTML;
      if ($(input).closest("tr").find('.txtcommon').prop('readOnly')) {
      }
      else {
          var orgID = $('#hdnOrgID').val();
          $.ajax({
              type: "POST",
              url: "../WebService.asmx/UpdateBlockSlideDetails",
              data: "{ 'PrimaryBarcode': '" + PrimaryBarcode + "','BarcodeNumber': '" + BarCode + "','BlockType': '" + BlockType + "','SlideName': '" + SlideName + "','StainType': '" + StainType + "','SlideComments': '" + SlideComments + "','Orgid':'" + orgID + "' }",
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function(msg) {


                  var data = msg.d;
                  if (data >= 0) {
                      $(input).closest("tr").find('.txtcommon').attr('readOnly', true);
                      $(input).closest("tr").find('.txtcommon').css('background-color', 'rgb(137, 202, 88)');
                  }

              },
              error: function(msg) {
                  alert(msg.d);
              }

          });
      }
      }
      function EditBlockType(input) {

          $(input).closest("tr").find('.blocktype').attr('readOnly', false);
          $(input).closest("tr").find('.blocktype').css('background-color', 'rgb(255, 255, 255)');
          
      }
      function UpdateBlock(input) {
          var BlockType = $(input).closest("tr").find('.blocktype').val();
          var PrimaryBarcode = document.getElementById('lblBarCode').innerHTML;
          var BarCode = $(input).closest("tr").find("td:eq(1)").text();
          var SlideName = "";
          var StainType = "";
          var SlideComments = "";
          if ($(input).closest("tr").find('.blocktype').prop('readOnly')) {
          }
          else {
              var orgID = $('#hdnOrgID').val();
              $.ajax({
                  type: "POST",
                  url: "../WebService.asmx/UpdateBlockSlideDetails",
                  data: "{ 'PrimaryBarcode': '" + PrimaryBarcode + "','BarcodeNumber': '" + BarCode + "','BlockType': '" + BlockType + "','SlideName': '" + SlideName + "','StainType': '" + StainType + "','SlideComments': '" + SlideComments + "','Orgid':'" + orgID + "' }",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function(msg) {


                      var data = msg.d;

                      if (data >= 0) {
                          $(input).closest("tr").find('.blocktype').attr('readOnly', true);
                          $(input).closest("tr").find('.blocktype').css('background-color', 'rgb(137, 202, 88)');
                      }

                  },
                  error: function(msg) {
                      alert(msg.d);
                  }

              });
          }
      }
     
</script>
</body>
</html>
