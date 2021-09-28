<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationResultsCapture.aspx.cs"
    Inherits="Investigation_InvestigationResultsCapture" EnableEventValidation="false"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="MicroPattern.ascx" TagName="MicroPattern" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>--%>
<%@ Register Src="BioPattern1.ascx" TagName="BioPattern1" TagPrefix="uc11" %>
<%@ Register Src="ClinicalPattern12.ascx" TagName="ClinicalPattern12" TagPrefix="uc17" %>
<%@ Register Src="ClinicalPattern13.ascx" TagName="ClinicalPattern13" TagPrefix="uc18" %>
<%@ Register Src="FluidPattern.ascx" TagName="FluidPattern" TagPrefix="uc23" %>
<%@ Register Src="BioPattern5.ascx" TagName="BioPattern5" TagPrefix="uc10" %>
<%@ Register Src="CommanPattern.ascx" TagName="CommanPattern" TagPrefix="uc24" %>
<%@ Register Src="HistoPathologyPattern.ascx" TagName="HistoPathologyPattern" TagPrefix="uc26" %>

<%@ Register Src="HistoPathologyPatternLilavathi.ascx" TagName="HistoPathologyPatternLilavathi" TagPrefix="uc66" %>

<%--<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>--%>
<%--<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="BioPattern2.ascx" TagName="BioPattern2" TagPrefix="uc6" %>
<%@ Register Src="BioPattern3.ascx" TagName="BioPattern3" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/SampleCollection.ascx" TagName="SampleCctrl" TagPrefix="uc25" %>
<%@ Register Src="BioPattern4.ascx" TagName="BioPattern4" TagPrefix="uc9" %>
<%@ Register Src="CultureandSensitivityReport.ascx" TagName="CultureandSensitivityReport"
    TagPrefix="uc27" %>
<%@ Register Src="CultureandSensitivityReportV1.ascx" TagName="CultureandSensitivityReportV1"
    TagPrefix="uc48" %>
<%@ Register Src="CultureandSensitivityReportV2.ascx" TagName="CultureandSensitivityReportV2"
    TagPrefix="uc50" %>
<%@ Register Src="StoneAnalysis.ascx" TagName="StoneAnalysis" TagPrefix="uc28" %>
<%@ Register Src="FluidAnalysisCellsPattern.ascx" TagName="FluidAnalysisCellsPattern"
    TagPrefix="uc29" %>
<%@ Register Src="FluidAnalysisChemistryPattern.ascx" TagName="FluidAnalysisChemistryPattern"
    TagPrefix="uc30" %>
<%@ Register Src="FluidAnalysisCytologyPattern.ascx" TagName="FluidAnalysisCytologyPattern"
    TagPrefix="uc31" %>
<%@ Register Src="FluidAnalysisImmunolgyPattern.ascx" TagName="FluidAnalysisImmunolgyPattern"
    TagPrefix="uc32" %>
<%@ Register Src="FungalSmearPattern.ascx" TagName="FungalSmearPattern" TagPrefix="uc33" %>
<%@ Register Src="MicroBioPattern1.ascx" TagName="MicroBioPattern1" TagPrefix="uc34" %>
<%@ Register Src="AntibodyWithMethod.ascx" TagName="AntibodyWithMethod" TagPrefix="uc29" %>
<%@ Register Src="AntibodyQualitative.ascx" TagName="AntibodyQualitative" TagPrefix="uc35" %>
<%@ Register Src="SemenAnalysis.ascx" TagName="SemenAnalysis" TagPrefix="uc36" %>
<%@ Register Src="Imaging.ascx" TagName="Imaging" TagPrefix="uc37" %>
<%@ Register Src="PeripheralSmear.ascx" TagName="PeripheralSmear" TagPrefix="uc38" %>
<%@ Register Src="BleedingTime.ascx" TagName="BleedingTime" TagPrefix="uc39" %>
<%@ Register Src="ImagingWithFCKEditor.ascx" TagName="ImagingWithFCKEditor" TagPrefix="uc40" %>
<%@ Register Src="TextualPattern.ascx" TagName="TextualPattern" TagPrefix="uc41" %>
<%@ Register Src="GTT.ascx" TagName="GTT" TagPrefix="uc42" %>
<%@ Register Src="aPTTPattern.ascx" TagName="aPTTPattern" TagPrefix="uc43" %>
<%@ Register Src="PTTPattern.ascx" TagName="PTTPattern" TagPrefix="uc44" %>
<%@ Register Src="BodyFluidAnalysis.ascx" TagName="BodyFluidAnalysis" TagPrefix="uc45" %>
<%@ Register Src="SmearAnalysis.ascx" TagName="SmearAnalysis" TagPrefix="uc46" %>
<%@ Register Src="SemenAnalysisNewPattern.ascx" TagName="SemenAnalysisNewPattern"
    TagPrefix="uc47" %>
<%@ Register Src="GTTContentPattern.ascx" TagName="GTTContentPattern" TagPrefix="uc49" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="ImageUploadpattern.ascx" TagName="ImagePattern" TagPrefix="ImageUpload" %>
<%@ Register Src="FishPattern1.ascx" TagName="FishPattern" TagPrefix="FishPatternforGenetics" %>
<%@ Register Src="FishPattern2.ascx" TagName="FishPattern2" TagPrefix="FishPattern2" %>
<%@ Register Src="FishResultPattern.ascx" TagName="FishResult" TagPrefix="FishResultPattern1" %>
<%@ Register Src="FishResultPattern1.ascx" TagName="FishResult1" TagPrefix="FishResultPattern2" %>
<%@ Register Src="MultiAddControl.ascx" TagName="MultiAdd" TagPrefix="MultiAddControl" %>
<%@ Register Src="HBVDRUG.ascx" TagName="MultiAdd" TagPrefix="MolBioPattern" %>
<%@ Register Src="ReflexTest.ascx" TagName="ReflexTest" TagPrefix="Reflex" %>
<%@ Register Src="BRCAPattern.ascx" TagName="BRCA" TagPrefix="BRCAPattern" %>
<%@ Register Src="BRCAPattern1.ascx" TagName="BRCA1" TagPrefix="BRCAPattern1" %>
<%@ Register Src="OrganismDrugPattern.ascx" TagName="OrganismDrug" TagPrefix="OrganismDrugPattern" %>
<%--/* BEGIN | sabari | 20181129 | Dev | Culture Report */--%>
<%@ Register Src="OrganismDrugPatternWithLevel.ascx" TagName="OrganismDrugWithLevel" TagPrefix="OrganismDrugPatternWithLevel" %>
<%--/* END | sabari | 20181129 | Dev | Culture Report */--%>
<%@ Register Src="MicroStainPattern.ascx" TagName="MicroStain" TagPrefix="MicroStainPattern" %>
<%@ Register Src="MicroBio1.ascx" TagName="MicroBio1" TagPrefix="MicroBioPattern" %>
<%@ Register Src="HEMATOLOGY.ascx" TagName="HEMATOLOGY" TagPrefix="HEMATOLOGYPattern" %>
<%@ Register Src="HistoPathologyPatternQuantum.ascx" TagName="HistoPathologyPatternQuantum"
    TagPrefix="uc53" %>
<%@ Register Src="PDFUploadpattern.ascx" TagName="PDFUPLOAD" TagPrefix="PDFUploadpattern" %>
<%@ Register Src="MultipleFileUpload.ascx" TagName="Multiple" TagPrefix="FUpload" %>
<%@ Register Src="ImageDescriptionpattern.ascx" TagName="ImageDescription" TagPrefix="ImageDescriptionpattern" %>
<%@ Register Src="Tablepatternautopopulate.ascx" TagName="Genera" TagPrefix="Tablepatternautopopulate" %>
<%@ Register Src="HistoImageDescriptionPattern.ascx" TagName="HistoDescription" TagPrefix="HistoImageDescriptionPattern" %>
<%@ Register Src="RichTextPattern.ascx" TagName="Textpattern" TagPrefix="RichTextPattern" %>
<%@ Register Src="GeneralPattern.ascx" TagName="Genera" TagPrefix="GeneralPattern" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="TablePatternV2.ascx" TagName="TableV2" TagPrefix="TablePatternV2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation Capture</title>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />


    
<script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript" language="javascript"></script>
<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui-1.10.4.custom.min.js" type="text/javascript" language="javascript"></script>

    <%--    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>--%>
    <%--
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>
    <%--    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script type="text/javascript" src="../Scripts/ResultCapture.js"></script>

  

    

    <script language="javascript" type="text/javascript">


//        function ShowReportPreview(vid, roleId, invStatus) {
//            try {

//                $find("mpReportPreview").show();
//                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
//            }
//            catch (e) {
//                return false;
//            }
//        }
//        function ShowReportPreviewonReport(vid, roleId, invStatus) {

//            try {

//                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
//            }
//            catch (e) {
//                return false;
//            }
//        }
        var lockScript = true;
        bValidating = true;
        window.onbeforeunload = LeavePage;

        function LeavePage(e) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ReleaseCurrentTask",
                data: "{vid: '" + $("#hdnPatientVisitID").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    return false;
                }
            });
        }
        function changeTestName(x) {
            document.getElementById("testNameDIV").style.display = "block";
            document.getElementById("testNameLBL").innerHTML = document.getElementById(x).innerHTML;
            document.getElementById("testNameHDN").value = x;
            document.getElementById("testNameTXT").value = "";
            document.getElementById("testNameTXT").focus();

        }
        function setTestName() {
            if (document.getElementById("testNameTXT").value != "") {
                document.getElementById(document.getElementById("testNameHDN").value).innerHTML = document.getElementById("testNameTXT").value;
                z = document.getElementById("testNameHDN").value.split("~");
                document.getElementById("testNameHDN1").value += z[0] + "~" + document.getElementById("testNameTXT").value + "^";
            }
            document.getElementById("testNameTXT").value = "";
            document.getElementById("testNameDIV").style.display = "none";

        }
        function setTestNameClose() {
            document.getElementById("testNameDIV").style.display = "none";
        }




        function changeGroupName(x) {

            document.getElementById("groupNameDIV").style.display = "block";
            document.getElementById("groupNameLBL").innerHTML = document.getElementById(x).innerHTML;
            document.getElementById("groupNameHDN").value = x;
            //alert(x);
            document.getElementById("groupNameTXT").value = "";
            document.getElementById("groupNameTXT").focus();
        }
        function setGroupName() {
            //if (document.getElementById("groupNameTXT").value != "") {

            z = document.getElementById("groupNameHDN").value.split("~");
            z1 = document.getElementById(z[0]).innerText.split(":");

            document.getElementById("groupNameHDN1").value += z1[0].trim() + "~" + document.getElementById("groupNameTXT").value + "^";
            document.getElementById(document.getElementById("groupNameHDN").value).innerHTML = document.getElementById("groupNameTXT").value;
            //}
            document.getElementById("groupNameTXT").value = "";
            document.getElementById("groupNameDIV").style.display = "none";
            //alert(document.getElementById("groupNameHDN1").value);

        }
        function setGroupNameClose() {
            document.getElementById("groupNameDIV").style.display = "none";
        }


        // code added on 23-07-2010 QRM - Started

        function changeSourceName(x, ddlId, type) {


            var lstsource = document.getElementById("lstSource");
            var lstQRMaster = document.getElementById("lstQualitativeMaster");

            document.getElementById("sourceNameDIV").style.display = "block";
            //document.getElementById("sourceNameLBL").innerHTML = document.getElementById(x).innerHTML;
            //var ddlsource = document.getElementById("ddlSource");       

            var ddlsourceSender = document.getElementById(ddlId);
            document.getElementById("sourceSenderHDN").value = ddlId;
            z = document.getElementById("sourceSenderHDN").value.split("~");
            document.getElementById("sourceNameHDN1").value = z[0] + "~" + type;


            for (var i = lstsource.options.length - 1; i >= 0; i--) {
                lstsource.options[i] = null;
            }
            for (var i = 1; i < ddlsourceSender.length; i++) {

                var opt = document.createElement("option");
                opt.text = ddlsourceSender.options[i].text;
                opt.value = ddlsourceSender.options[i].Value;
                //  ddlsource.options.add(opt);
                lstsource.add(opt);

            }

            var listLength1 = lstQRMaster.options.length;
            var listLength2 = lstsource.options.length;

            for (var i = 0; i < listLength2; i++) {

                for (var j = 0; j < listLength1; j++) {

                    if (lstQRMaster.options[j].text == lstsource.options[i].text) {

                        lstQRMaster.options[j] = null
                        listLength1--;
                        j--;
                    }

                }
            }

            document.getElementById("lstQualitativeMaster").focus();

        }


        function setSourceNameClose() {
            document.getElementById("sourceNameDIV").style.display = "none";
        }





        function addSourceName() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vAdd = SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_01') == null ? "Please enter item to Add" : SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_01');
            var vItemList = SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_02') == null ? "Already exist in current item list." : SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_02');

            if (document.getElementById("sourceNameTXT").value != "") {
                var lstsource = document.getElementById("lstSource");
                for (var i = 0; i < lstsource.options.length; i++) {
                    if (lstsource[i].innerHTML == document.getElementById("sourceNameTXT").value) {
                        //alert("Already exist in current item list.");
                        ValidationWindow(vItemList, AlertType);
                        return false;
                    }
                }
                temp1 = document.getElementById("sourceNameHDN1").value;
                //document.getElementById("sourceNameHDN1").value = '';
                document.getElementById("sourceNameHDN").value += temp1 + "~" + document.getElementById("sourceNameTXT").value + "^";
                //alert(document.getElementById("sourceNameHDN").value);
                var ddlsourceSender = document.getElementById(document.getElementById("sourceSenderHDN").value);

                var opt = document.createElement("option");
                var opt1 = document.createElement("option");
                opt.text = document.getElementById("sourceNameTXT").value;
                opt.value = document.getElementById("sourceNameTXT").value;
                opt1.text = document.getElementById("sourceNameTXT").value;
                opt1.value = document.getElementById("sourceNameTXT").value;

                ddlsourceSender.options.add(opt);
                document.getElementById('lstSource').add(opt1);

                document.getElementById("sourceNameTXT").value = "";
                //alert(document.getElementById("sourceNameHDN").value);
                //document.getElementById("sourceNameDIV").style.display = "none";
                return true;
            }
            else {
                //alert('Please enter item to Add');
                ValidationWindow(vAdd, AlertType);
                return false;
            }
        }

        function DisplaySelectedItem(lstbox, textbox) {

            var lstQRMaster = document.getElementById(lstbox)

            var listLength = lstQRMaster.options.length;

            for (var i = 0; i < listLength; i++) {
                if (lstQRMaster.options[i].selected) {

                    document.getElementById(textbox).value = lstQRMaster.options[i].text
                }
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

        function displayProgress() {
            document.getElementById("btnSaveConfirm").style.display = "none";
            document.getElementById("divProgress").style.display = "block";
        }
        function OnDirectApproval() {
            try {
                //var result = CheckDifferentStatus();
                //if (!result) return false;
                try {
                    if (!ValidationFuntionEmptyValueFuntion()) {
                        return false;
                    }
                } catch (e) {
                }
                try {
                    if (!CheckSaveValidationFuntion()) {
                        return false;
                    }
                } catch (e) {
                }
                var vSelectStain = SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_03') == null ? "Select stain type\n" : SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_03');
                var vEnterStain = SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_04') == null ? "Enter stain result\n" : SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_04');
                var vAddStain = SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_05') == null ? "Add stain result" : SListForAppMsg.Get('Investigation_InvestigationResultsCapture_aspx_05');
                if (document.getElementById('5159~~0~0_ddlStainType') != null) {
                    var ddlStainTypeID = document.getElementById('5159~~0~0_ddlStainType');
                    var selectedStainResult = $.trim(document.getElementById('5159~~0~0_txtStainResult').value);
                    var message = '';

                    if (ddlStainTypeID.selectedIndex == 0) {
                        message += vSelectStain;

                    }
                    if (selectedStainResult == '') {
                        message += vEnterStain;
                    }
                    if (selectedStainResult != '') {
                        message += vAddStain;
                    }
                    if (message != '') {
                        alert(message);
                        window.location.reload();
                    }
                }
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
                var hdnSensitiveRangeDetails = document.getElementById('hdnSensitiveRangeDetails').value;
                var lstSensitiveRangeDetails = {};
                if (hdnSensitiveRangeDetails != "") {
                    lstSensitiveRangeDetails = JSON.parse(hdnSensitiveRangeDetails);
                }
                var lstSensitiveHign = [];
                for (prop1 in lstSensitiveRangeDetails) {
                    lstSensitiveHign.push(
                    {
                        Name: prop1,
                        Value: lstSensitiveRangeDetails[prop1]
                    });
                }
                if (lstSensitiveHign.length > 0) {
                    document.getElementById('hdnSensitivehigh').value = JSON.stringify(lstSensitiveHign);
                }
                var lstTestName = "";
                for (property in lstOutOfRangeDetails) {
                    lstTestName += lstOutOfRangeDetails[property];
                }
                //                HideProgress();
                //                if ($.trim(lstTestName).length > 0) {
                //                    document.getElementById('ltrlTestName').innerHTML = lstTestName;
                //                    document.getElementById("btnSaveConfirm").style.display = "block";
                //                    $find('mpeAttributeLocation').show();
                //                    return false;
                //                }
                //                else {
                //                    $find("mpeAttributeLocation").hide();
                //                }
                try {
                    if (document.getElementById('hdnFishResulPattern').value = "true") {
                        CallingSaveFishResultpattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnFishResulPattern1').value = "true") {
                        CallingSaveFishResultpattern1();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnMolbio').value = "true") {
                        CallingSaveMolBioPattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnBRCA').value = "true") {
                        CallingSaveBRCAPattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnBRCA1').value = "true") {
                        CallingSaveBRCA();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnMicroBio1').value = "true") {
                        CallingSaveMicroBio1Pattern();
                    }
                }
                catch (e) {
                }

                try {
                    if (document.getElementById('hdnIsCultureSensitivityV2').value = "true") {
                        CallingSaveCultureSensitiveV2();
                    }
                }
                catch (e) {
                }
                try {
                    CallingOrganisumDrugPatternDetails();
                }
                catch (e) {
                }
                try {
                    CallingMicroStainPatternDetails();
                }
                catch (e) {
                }
                try {
                    CallingSaveHEMATOLOGYPattern();
                }
                catch (e) {
                }
                try {
                    CallingSaveGeneralPattern();
                }

                catch (e) {
                }

                try {
                    CallingSaveTablepatternautopopulate();
                }

                catch (e) {
                }
               // if(((document.getElementById('btnApproval').disabled==false)||(document.getElementById('btnApproval1').disabled==false)))
                //{
                //document.getElementById('btnApproval').disabled=true;
                //document.getElementById('btnApproval1').disabled=true;
             //__doPostBack( 'btnApproval', 'btnApproval_Click' );
             // }
             
                return true;
            }
            catch (e) {
                return false;
            }
        }
        function OffDirectApproval() {
            try {
                try {
                    if (!CheckSaveValidationFuntion()) {
                        return false;
                    }
                } catch (e) {
                }
                //var result = CheckDifferentStatus();
                //if (!result) return false;
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
                var hdnSensitiveRangeDetails = document.getElementById('hdnSensitiveRangeDetails').value;
                var lstSensitiveRangeDetails = {};
                if (hdnSensitiveRangeDetails != "") {
                    lstSensitiveRangeDetails = JSON.parse(hdnSensitiveRangeDetails);
                }
                var lstSensitiveHign = [];
                for (prop1 in lstSensitiveRangeDetails) {
                    lstSensitiveHign.push(
                    {
                        Name: prop1,
                        Value: lstSensitiveRangeDetails[prop1]
                    });
                }
                if (lstSensitiveHign.length > 0) {
                    document.getElementById('hdnSensitivehigh').value = JSON.stringify(lstSensitiveHign);
                }
                var lstTestName = "";
                for (property in lstOutOfRangeDetails) {
                    lstTestName += lstOutOfRangeDetails[property];
                }
                //                HideProgress();
                //                if ($.trim(lstTestName).length > 0) {
                //                    document.getElementById('ltrlTestName').innerHTML = lstTestName;
                //                    document.getElementById("btnSaveConfirm").style.display = "none";
                //                    $find('mpeAttributeLocation').show();
                //                    return false;
                //                }
                //                else {
                //                    $find("mpeAttributeLocation").hide();
                //                }
                try {
                    if (document.getElementById('hdnFishResulPattern').value = "true") {
                        CallingSaveFishResultpattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnFishResulPattern1').value = "true") {
                        CallingSaveFishResultpattern1();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnMolbio').value = "true") {
                        CallingSaveMolBioPattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnBRCA').value = "true") {
                        CallingSaveBRCAPattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnBRCA1').value = "true") {
                        CallingSaveBRCA();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnMicroBio1').value = "true") {
                        CallingSaveMicroBio1Pattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnIsCultureSensitivityV2').value = "true") {
                        CallingSaveCultureSensitiveV2();
                    }
                }
                catch (e) {
                }
                try {
                    CallingOrganisumDrugPatternDetails();
                }
                catch (e) {
                }
                try {
                    CallingMicroStainPatternDetails();
                }
                catch (e) {
                }
                try {
                    CallingSaveHEMATOLOGYPattern();
                }
                catch (e) {
                }
                try {
                    CallingSaveGeneralPattern();
                }

                catch (e) {
                }



                try {
                    CallingSaveTablepatternautopopulate();
                }

                catch (e) {
                }
                return true;
            }
            catch (e) {
                return false;
            }
        }
        function HideProgress() {
            document.getElementById("divProgress").style.display = "none";
            return false;
        }
        function HideAbnormalPopup() {
            $find("mpeAttributeLocation").hide();
            return false;
        }

        function ProcessCallBackError(arg) {

            //alert('error'+arg);
            //document.getElementById("txtdummy").value = arg;
            //alert('Result value cannot be blank ');
        }
        function showConfirmpop() {

            document.getElementById('floatdiv').style.display = 'block';

        }

        function hideConfirmpop() {

            document.getElementById('floatdiv').style.display = 'none';
            document.getElementById("btnSave").style.display = "block";

        }
        function CheckError() {
            if (document.getElementById('hdnErrorCount').value <= 0) {

                return true;
            }
            else {

                return false;
            }
        }


        //code added for reference range - end

        // code added for group level comments - begin




        // code added for group level comments - ends
        function ChecKGroupSum() { //added Nicholas
        }

        //        function ChecKGroupSum() {
        //            alert(document.getElementById('2005~Differential Leukocyte Count~2817~0_txtValue').value);
        //            var iwi = parseFloat(document.getElementById('2005~Differential Leukocyte Count~2817~0_txtValue').value) + parseFloat(document.getElementById('2006~Differential Leukocyte Count~2817~0_txtValue').value);
        //            if (parseFloat(document.getElementById('2005~Differential Leukocyte Count~2817~0_txtValue').value) + parseFloat(document.getElementById('2006~Differential Leukocyte Count~2817~0_txtValue').value) > 100) {
        //                alert('gr');
        //            }
        //            else {
        //                alert('lsr');
        //            }
        //            return false;
        //                    //    var ControlIDs = document.getElementById('hdnIds').value;
        ////            var ID;
        ////            var CountVariable;
        ////            var TotalValue = 0, ValueToBeAdd = 0;

        ////            if (ControlIDs != '') {
        ////                ID = ControlIDs.split(',');
        ////                for (CountVariable = 0; CountVariable < ID.length; CountVariable++) {
        ////                    var ControlIdToGetValue = ID[CountVariable];
        ////                    alert(document.getElementById(ControlIdToGetValue).value);
        ////                    ValueToBeAdd = parseFloat(document.getElementById(ControlIdToGetValue).value);
        ////                    TotalValue = parseFloat(TotalValue) + parseFloat(ValueToBeAdd);
        ////                }
        ////                if (TotalValue == 100) {
        ////                    return true
        ////                }
        ////                else {
        ////                    return false;
        ////                }
        ////            }
        ////            if
        //        } 
        //        
        
        
    </script>

    <%--<script language="javascript" type="text/javascript">

        //alert('d');
        function fnenable2(ID) {
            alert(ID);
            //        var oEditor = document.getElementById('5331~~0_fckInvDetails').value;
            //        alert(oEditor);
            //        oEditor.disabled = false;

            var oEditor = FCKeditorAPI.GetInstance('5331~~0_fckInvDetails');
            alert(oEditor);
            oEditor.EditorDocument.body.disabled = true

        }

</script>--%>
    <%--Script for AutoComplete of DrugList--%>

    <script type="text/javascript">
        if ($('.tb').length) {
            $(function() {

                $(".tb").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../WebService.asmx/FetchDrugList",
                            data: "{ 'drug': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.BrandName
                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });
            });
        }

        function reloadauto() {

            $(function() {

                $(".tb").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../WebService.asmx/FetchDrugList",
                            data: "{ 'drug': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.BrandName
                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });
            });
        }
	    
        
	    
	    
    </script>

    <style>
        #ViewTRF td
        {
            padding: 0;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="btnGo" enctype="multipart/form-data">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <div id="ViewTRF" runat="server" style="display: none">
                        <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="HDnInVID" runat="server" />
        
       
        
        <asp:UpdatePanel ID="UpdatePanel11" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar1" AssociatedUpdatePanelID="UpdatePanel11" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="imgProgressbar1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:Panel ID="pnlSerch" runat="server" BorderWidth="1px" CssClass="dataheader2 w-60p"
                    Style="display: none;" meta:resourcekey="pnlSerchResource1">
                    <input id="hdnVID" runat="server" type="hidden" value="0" />
                    <input id="hdnHeaderName" runat="server" type="hidden" value="0" />
                    <input id="hdnDept" runat="server" type="hidden" value="0" />
                    <input id="hdnInvRemarks" runat="server" type="hidden" value="" />
                    <table id="searchTab" runat="server" cellpadding="4" class="w-100p">
                        <tr>
                            <td class="a-left h-20 w-40p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblSearch" runat="server" Text="Enter Visit No to search"></asp:Label>
                            </td>
                            <td class="a-left h-20 w-40p" style="font-weight: normal; color: #000;">
                                <asp:TextBox ID="txtSearchTxt" runat="server"></asp:TextBox>
                                <ajc:FilteredTextBoxExtender ID="txtSearch" runat="server" FilterType="Numbers" TargetControlID="txtSearchTxt">
                                </ajc:FilteredTextBoxExtender>
                            </td>
                            <td class="a-left w-20p">
                                <asp:Button ID="btnGo" runat="server" CssClass="btn" OnClick="btnGo_Click" OnClientClick="return txtBoxValidation()"
                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Search" />
                            </td>
                            <td class="w-60p">
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <%-- <asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                    <table border="1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr style="height: 15px;" class="Duecolor">
                                            <td colspan="12">
                                                <b>Patient Details</b>
                                            </td>
                                        </tr>
                                        <tr style="height: 20px;">
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 9%;" align="left">
                                                Patient No:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                <asp:Label ID="lblPatientNo" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                VisitDate:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 7%;" align="left">
                                                <asp:Label ID="lblDate" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 11%;" align="left">
                                                Patient Name:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 15%;" align="left">
                                                <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                Gender:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                <asp:Label ID="lblGender" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 4%;" align="left">
                                                Age:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 9%;" align="left">
                                                <asp:Label ID="lblAge" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 7%;" align="left">
                                                Visit No:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                <asp:Label ID="lblVisitNo" runat="server"></asp:Label>
                                            </td>
                                          
                                        </tr>
                                        <tr>
                                            <td colspan="10">
                                                <%--<table border="0" cellpadding="0" cellspacing="0" visible="true" >
                                         <tr>
                                         <td>Referred by Dr.</td>
                                         <td><asp:DropDownList ID="ddlDoctor" runat="server" CssClass="ddlTheme12" onchange="javascript:datachanged();"></asp:DropDownList>
                                             <asp:HiddenField ID="hdnRefDoctor" runat="server" />
                                         </td>
                                         <td>
                                         <div id="divOtherDoctors" runat="server" style="display:none" >
                                            Dr. <asp:TextBox ID="txtOtherDoctors" runat="server" ></asp:TextBox>
                                         </div>
                                         </td>
                                         </tr>
                                         </table>--%>
                <%--     </td>
                                        </tr>
                                    </table>
                                </asp:Panel>--%>
                <div runat="server" id="divPatientDetails">
                    <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                </div>
                <div id="testNameDIV" runat="server" style="border-width: 1px; border-color: #000;
                    display: none; position: fixed; z-index: 2; top: 200px; left: 200px;">
                    <table cellpadding="3" class="divtablePop">
                        <tr class="h-20 evenforsurg">
                            <td>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_03 %>
                                        </td>
                                        <td class="a-right">
                                            <img id="imgbtn1" onclick="javascript:setTestNameClose();" src="../Images/Delete.jpg"
                                                style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="testNameLBL" runat="server" ForeColor="#ffffff"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="testNameTXT" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <input id="testNameHDN" runat="server" type="hidden" />
                                <input id="hdnstatuschange" runat="server" type="hidden" />
                                <input id="hdnabnormalchange" runat="server" type="hidden" />
                                <input id="testNameHDN1" runat="server" type="hidden" />
                                <asp:Label ID="Label1" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setTestName();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_04 %></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label2" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setTestNameClose();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_05 %></asp:Label>
                                <%--  <asp:Button ID="testNameBTNOk" OnClientClick="" runat="server" UseSubmitBehavior="false" CssClass="btn" Text="Change" onmouseout="this.className='btn'" 
                                                        onmouseover="this.className='btn btnhov'" />
                                    <asp:Button ID="testNameBTNCancel" runat="server" UseSubmitBehavior="false" CssClass="btn" Text="Cancel" onmouseout="this.className='btn'" 
                                                        onmouseover="this.className='btn btnhov'" />--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divMultiFile">
                    <FUpload:Multiple ID="MultiFile" runat="server" />
                </div>
                <%-- BEGIN --%>
                <%--Code added on 23-07-2010 QRM  --%>
                <input id="sourceSenderHDN" runat="server" type="hidden" />
                <input id="sourceNameHDN" runat="server" type="hidden" />
                <input id="sourceNameHDN1" runat="server" type="hidden" />
                <asp:HiddenField ID="hdnGenderAge" runat="server" />
                <asp:HiddenField ID="hdnValidateData" runat="server" />
                <asp:HiddenField ID="hdnAutoMedicalComments" runat="server" />
                <asp:HiddenField ID="hdnErrorCount" runat="server" />
                <asp:HiddenField ID="hdnOrgID" runat="server" />
                <asp:HiddenField ID="hdnhigh" runat="server" Value="" />
                <asp:HiddenField ID="hdnRecollectCountFlag" runat="server" Value="0" />
                <asp:HiddenField ID="hdnSensitivehigh" runat="server" Value="" />
                <div id="sourceNameDIV" runat="server" style="border-width: 1px; border-color: #000;
                    display: none; position: fixed; z-index: 2; top: 200px; left: 200px;">
                    <table border="0" cellpadding="3" cellspacing="0" style="background-color: #333;
                        border-color: #000; color: #fff;">
                        <tr style="height: 20px;" class="h-20 colorforcontent">
                            <td colspan="2">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_06 %>
                                        </td>
                                        <td class="a-right">
                                            <img id="img2" onclick="javascript:setSourceNameClose();" src="../Images/Delete.jpg"
                                                style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="sourceNameLBL" runat="server" ForeColor="#ffffff"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_07 %>
                            </td>
                            <td>
                                <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_08 %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="lstSource" runat="server"></asp:ListBox>
                            </td>
                            <td>
                                <asp:ListBox ID="lstQualitativeMaster" runat="server"></asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="sourceNameTXT" runat="server" Enabled="true" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center" colspan="2">
                                <input id="Hidden1" runat="server" type="hidden" />
                                <input id="Hidden2" runat="server" type="hidden" />
                                <asp:Label ID="Label5" runat="server" CssClass="btn" Font-Bold="true" ForeColor="#ffffff"
                                    OnClick="javascript:return addSourceName();" Style="cursor: pointer;">Add</asp:Label>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label6" CssClass="btn" runat="server" Font-Bold="true" ForeColor="#ffffff"
                                    OnClick="javascript:setSourceNameClose();" Style="cursor: pointer;">Cancel</asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <%--Code added on 23-07-2010 QRM --%>
                <%-- END--%>
                <%--Code added for Group Level Comments --%>
                <%-- BEGIN--%>
                <div id="groupCommentDIV" runat="server" style="border-width: 1px; border-color: #000;
                    display: none; position: fixed; z-index: 2; top: 200px; right: 200px;">
                    <table cellpadding="3" style="background-color: #333; border-color: #000; color: #fff;">
                        <tr class="h-20 colorforcontent">
                            <td>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_09 %>
                                        </td>
                                        <td class="a-right">
                                            <img id="img3" onclick="javascript:setGroupCommentClose();" src="../Images/Delete.jpg"
                                                style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="groupCommentLBL" runat="server" ForeColor="#ffffff"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblTechnicalRemarks" Text="Technical Remarks:" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="groupCommentTXT" runat="server" TextMode="MultiLine" Rows="2" Columns="6"
                                    Width="200px"></asp:TextBox>
                                <asp:HiddenField ID="hdnGrpTechRemChangedCtl" runat="server" />
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="groupCommentTXT" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarksGrpTech">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnInvRemGrpIDList" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMedicalRemarks" Text="Medical Remarks:" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtGrpCommentMed" runat="server" Columns="6" Rows="2" TextMode="MultiLine"
                                    Width="200px"></asp:TextBox>
                                <asp:HiddenField ID="hdnGrpMedRemChangedCtl" runat="server" />
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtGrpCommentMed" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarksGrpMed">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnInvMedRemGrpIDList" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <input id="groupCommentHDN" runat="server" type="hidden" />
                                <input id="groupCommentHDN1" runat="server" type="hidden" />
                                <input id="groupMedCommentHDN" runat="server" type="hidden" />
                                <input id="groupMedCommentHDN1" runat="server" type="hidden" />
                                <asp:Label ID="Label7" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setGroupComment();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_10 %></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label8" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setGroupCommentClose();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_11 %></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <%-- END--%>
                <div id="groupNameDIV" runat="server" style="border-width: 1px; border-color: #000;
                    display: none; position: fixed; z-index: 2; top: 200px;">
                    <table border="0" cellpadding="3" cellspacing="0" style="background-color: #333;
                        border-color: #000; color: #fff;">
                        <tr class="h-20 colorforcontent">
                            <td>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_12 %>
                                        </td>
                                        <td class="a-right">
                                            <img id="img1" onclick="javascript:setGroupNameClose();" src="../Images/Delete.jpg"
                                                style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="groupNameLBL" runat="server" ForeColor="#ffffff"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="groupNameTXT" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <input id="groupNameHDN" runat="server" type="hidden" />
                                <input id="groupNameHDN1" runat="server" type="hidden" />
                                <asp:Label ID="Label3" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setGroupName();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_04 %></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label4" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setGroupNameClose();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_05 %></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <table width="95%" runat="server" id="tblPDFReportViewer" border="0" cellpadding="0"
                    cellspacing="0">
                    <tr>
                        <td class="padding0">
                            <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                            <ajc:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                                TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                                CancelControlID="imgPDFReportPreview" DynamicServicePath="" Enabled="True">
                            </ajc:ModalPopupExtender>
                            <asp:Panel ID="pnlReportPreview" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                                runat="server" meta:resourcekey="pnlShowReportPreviewResource1" Style="display: none">
                                <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                                    <table width="100%">
                                        <tr>
                                            <td class="a-left padding0">
                                                <asp:Label ID="lblReportPreviewHeader" runat="server" Text="Report Preview" meta:resourcekey="lblReportPreviewHeaderResource2"></asp:Label>
                                            </td>
                                            <td class="a-right padding0">
                                                <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" runat="server"
                                                    alt="Close" style="cursor: pointer;" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table width="100%">
                                    <tr style="vertical-align: top;">
                                        <td class="padding0">
                                            <table id="tblViewPreviewTRF" runat="server" width="100%" style="display: none;">
                                                <tr id="Tr3" runat="server">
                                                    <td id="Td3" class="colorforcontent" style="width: 30%;" height="23" align="left"
                                                        runat="server">
                                                        <div id="ACX3plus1" style="display: block;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);">
                                                                &nbsp;<asp:Label ID="lblReportTemplate" runat="server" Text="Show TRF" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                        <div id="ACX3minus1" style="display: none;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);">
                                                                <asp:Label ID="Label12" runat="server" Text="Hide TRF" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="ACX3responses1" style="display: none; vertical-align: top;" width="100%">
                                                <tr style="vertical-align: top;">
                                                    <td>
                                                        <TRF:ViewTRFImage ID="ViewPreviewTRF" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height: 5px;">
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                    <td class="colorforcontent" style="width: 30%;" height="23" align="left">
                                                        <div id="ACX3plus2" style="display: none;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                &nbsp;<asp:Label ID="Label13" runat="server" Text="Show Report" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                        <div id="ACX3minus2" style="display: block;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                <asp:Label ID="Label14" runat="server" Text="Hide Report" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="ACX3responses2" style="display: table;" width="100%">
                                                <tr>
                                                    <td>
                                                        <div id="iframeplaceholder" style="width: 100%; height: auto;">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblResult" runat="server" ForeColor="#333" Visible="false">No Matching Records Found!</asp:Label>
                <table id="ucSCTab" runat="server" style="display: none;" class="w-100p">
                    <%--<tr>
                                        <td align="right">
                                            <asp:LinkButton ID="lnkCollectMoreSample" runat="server" Style="color: #000; padding-right: 25px;"
                                                ToolTip="Collect More Sample"> <u>Collect More Sample...</u></asp:LinkButton>
                                        </td>
                                    </tr>--%>
                                     <tr>
                        <%--<td>
                            <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Text="Show Report Preview"
                                Font-Underline="true" ForeColor="Blue" meta:resourcekey="lnkPDFReportPreviewerResource" />
                        </td>
                    </tr>
                    <tr>--%>
                        <td class="a-center padding0" colspan="8">
                            <asp:Panel ID="pnlLocation1" Width="1000px" Height="400px" runat="server" CssClass="modalPopup dataheaderPopup"
                                ScrollBars="Vertical" Style="display: none">
                                <br />
                                <table class="w-90p a-center">
                                    <tr>
                                        <td class="w-100p padding0">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblPName1" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblPAge1" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblSex1" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblVisitNo1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="colorforcontent h-23 a-left w-30p">
                                            <div id="DeltaPlus" style="display: block;" class="a-right">
                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaTable',1);">
                                                    &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Investigation Result History"
                                                        meta:resourcekey="lblinvfilterResource1"></asp:Label></span> &nbsp;<img src="../Images/Rotate360AntiClockwi2.png"
                                                            alt="Show Graph" width="15" height="15" align="top" style="cursor: pointer;"
                                                            onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaTable',1);" />&nbsp;
                                            </div>
                                            <div id="DeltaMinus" style="display: none;" class="a-right">
                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaGraph',0);">
                                                    &nbsp;<asp:Label ID="lblinvfilters" runat="server" Text="Investigation Result History"
                                                        meta:resourcekey="lblinvfiltersResource1"></asp:Label></span> &nbsp;<img src="../Images/Rotate360AntiClockwi2.png"
                                                            alt="Show Table" width="15px" height="15px" align="top" style="cursor: pointer"
                                                            onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaGraph',0);" />&nbsp;
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="trDeltaTable" runat="server" style="display: table-row;">
                                        <td>
                                            <table id="tblPatientTestHistory1" cellpadding="4" class="dataheaderInvCtrl w-100p"
                                                style="display: none;">
                                                <tr class="dataheader1">
                                                    <td class="w-10p">
                                                        <asp:Label ID="Label10" runat="server" Text="Select" meta:resourcekey="Label10Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-10p">
                                                        <asp:Label ID="Label11" runat="server" Text="Visit Number" meta:resourcekey="Label11Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="Rs_Date" runat="server" Text="Date" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-30p">
                                                        <asp:Label ID="Rs_InvestigationName" runat="server" Text="Investigation Name" meta:resourcekey="Rs_InvestigationNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="Rs_Value" runat="server" Text="Value" meta:resourcekey="Rs_ValueResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="Rs_ReferenceRange" runat="server" Text="Reference Range" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="Rs_Comments" runat="server" Text="Comments" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="Rs_Status" runat="server" Text="Investigation Status" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="lblKitAnalyzer" runat="server" Text="Kit/Analyzer" meta:resourcekey="lblKitAnalyzerResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trDeltaGraph" runat="server" style="display: none;">
                                        <td>
                                            <img id="ChartArea" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <button id="btnSetValues" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            onclick="return SetValues();">
                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_01 %></button>
                                                    </td>
                                                    <td class="a-left">
                                                        <button id="btnpopClose1" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            onclick="ClearPopUp1();">
                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_02 %></button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </asp:Panel>
                            <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                                CancelControlID="btnpopClose1" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation1"
                                TargetControlID="btnDummy1">
                            </ajc:ModalPopupExtender>
                            <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
                            <Reflex:ReflexTest ID="ucReflexTest" runat="server" />
                            <asp:HiddenField runat="server" ID="hdnPatternID" />
                            <asp:HiddenField runat="server" ID="hdnPatientInvID" />
                            <asp:HiddenField runat="server" ID="hdnMappingPatternID" />
                            <asp:HiddenField runat="server" ID="hdnIsDeltaCheckWant" Value="false" />
                            <asp:HiddenField runat="server" ID="hdnPatientVisitID" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%--<uc25:SampleCctrl ID="ucSC" runat="server" />--%>
                            <div id="Div2" style="display: none; color: #000;" class="h-20">
                                <img align="top" alt="hide" height="15px" onclick="showResponses('Div3','Div2','viewTab',0);"
                                    src="../Images/hideBids.gif" style="cursor: pointer" width="15px" />
                                <span onclick="showResponses('Div3','Div2','viewTab',0);" style="cursor: pointer;
                                    color: #000;">&nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_13 %>
                                </span>
                            </div>
                            <div id="Div3" style="display: none; color: #000;" class="h-20">
                                <img align="top" alt="Show" height="15" onclick="showResponses('Div3','Div2','viewTab',1);"
                                    src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                <span onclick="showResponses('Div3','Div2','viewTab',1);" style="cursor: pointer;
                                    color: #000;">&nbsp;View Investigation Values </span>
                            </div>
                            <table id="viewTab" style="display: none;" class="w-97p">
                                <tr>
                                    <td>
                                        <rsweb:ReportViewer ID="ReportViewer" runat="server" ProcessingMode="Remote">
                                            <ServerReport ReportServerUrl="" />
                                        </rsweb:ReportViewer>
                                    </td>
                                </tr>
                            </table>
                            <div id="DInvest" runat="server" visible="true">
                                <div id="ACX2minus4" style="display: none; color: #000;" class="h-20">
                                    <img align="top" alt="hide" height="15px" onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',0);"
                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15px" />
                                    <span onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',0);" style="cursor: pointer;
                                        color: #000;">&nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_14 %>
                                    </span>
                                </div>
                                <div id="ACX2plus4" style="display: none; color: #000;" class="h-20">
                                    <img align="top" alt="Show" height="15" onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',1);"
                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                    <span onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',1);" style="cursor: pointer;
                                        color: #000;">&nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_14 %>
                                    </span>
                                </div>
                                <table id="captureTab" style="display: table;" class="w-100p">
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnApproval1" runat="server" CssClass="btn" OnClick="btnApproval_Click"
                                                OnClientClick="return OnDirectApproval();" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Save And Home" meta:resourcekey="btnApproval1Resource1" />
                                            <asp:HiddenField ID="hdnDirectApproval" runat="server" Value="0" />
                                            <asp:Button ID="btnShowRR1" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                OnClientClick="return OffDirectApproval();" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Save And Continue" meta:resourcekey="btnShowRR1Resource1" />
                                            <asp:Button ID="Button3" runat="server" CssClass="btn" OnClick="Button1_Click" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Cancel" meta:resourcekey="Button3Resource1" />
                                        </td>
                                    </tr>
                                    <tr id="trRangeColor" runat="server" style="display: table-row;">
                                        <td>
                                            <asp:TextBox ID="txtAuto" Enabled="false" runat="server" Width="10px" Height="10px"></asp:TextBox>
                                            <asp:Label ID="lblAutoColor" Text="Auto Authorization Range" runat="server" meta:resourcekey="lblAutoColorResource1"></asp:Label>
                                            <asp:TextBox ID="txtPanic" Enabled="false" runat="server" Width="10px" Height="10px"></asp:TextBox>
                                            <asp:Label ID="lblPanicColor" runat="server" Text="Panic Range" meta:resourcekey="lblPanicColorResource1"></asp:Label>
                                            <asp:TextBox ID="txtReference" Enabled="false" runat="server" Width="10px" Height="10px"></asp:TextBox>
                                            <asp:Label ID="lblreferencecolor" Text="Normal Range" runat="server" meta:resourcekey="lblreferencecolorResource1"></asp:Label>
                                            <asp:TextBox ID="txtLower" Enabled="false" runat="server" Width="10px" Height="10px"></asp:TextBox>
                                            <asp:Label ID="lblLower" Text="Lower Abnormal Range" runat="server" meta:resourcekey="lblLowerResource1"></asp:Label>
                                            <asp:TextBox ID="txtHigher" Enabled="false" runat="server" Width="10px" Height="10px"></asp:TextBox>
                                            <asp:Label ID="lblHigher" Text="Higher Abnormal Range" runat="server" meta:resourcekey="lblHigherResource1"></asp:Label>
                                            <asp:TextBox ID="txtDeviceError" Enabled="false" runat="server" Width="10px" Height="10px"></asp:TextBox>
                                            <asp:Label ID="lblDeviceError" Text="Device Error" runat="server" meta:resourcekey="lblDeviceErrorResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Table ID="drawNewPattern" runat="server" class="w-100p searchPanel">
                                            </asp:Table>
                                            <div id="divSave" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <%-- <td>--%>
                                                        <%--<asp:Button ID="btnValidateAllRange" 
                                                                                    runat="server" CssClass="btn" OnClick="btnValidate_Click"   
                                                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                                                                                    Text="Validate All" />--%>
                                                        <%--</td>--%>
                                                        <%--<td class="w-40p a-right">
                                                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" OnClientClick="javascript:return ValidateUserResult1();"
                                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save &amp; Continue"
                                                                                Visible="false" />--%>
                                                        <%-- 
                                                                                <input ID="btnValidate" style="display:none;" runat="server" class="btn" 
                                                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" 
                                                                                    type="button" value="Save &amp; Continue" />--%>
                                                        <%-- </td>--%>
                                                        <td class="a-center">
                                                            <asp:Button ID="btnApproval" runat="server" CssClass="btn" OnClick="btnApproval_Click"
                                                                OnClientClick="return OnDirectApproval();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Save And Home" meta:resourcekey="btnApproval1Resource1" />
                                                            <asp:Button ID="btnShowRR" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                                OnClientClick="return OffDirectApproval();" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Save And Continue" meta:resourcekey="btnShowRR1Resource1" />
                                                            <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="Button1_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Cancel" meta:resourcekey="Button3Resource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divProgress" runat="server" style="position: absolute; top: 200px; left: 350px;
                                                display: none; z-index: 9999;" class="a-center">
                                                <table cellpadding="3" style="border-color: #000; color: #fff;">
                                                    <tr>
                                                        <td colspan="2">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div id="progressBackgroundFilter" class="a-center">
                                                            </div>
                                                            <div id="processMessage" class="a-center w-20p">
                                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                                <br />
                                                                <br />
                                                                <asp:Image ID="Image1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                                    meta:resourcekey="img1Resource1" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" BackgroundCssClass="modalBackground"
                                Drag="false" DropShadow="false" PopupControlID="pnlLocation" TargetControlID="btnDummy" />
                            <input id="btnDummy" runat="server" style="display: none;" type="button" />
                            <asp:Panel ID="pnlLocation" runat="server" Style="display: block; max-height: 200px;"
                                Width="400px">
                                <asp:UpdatePanel ID="selectpnl" runat="server">
                                    <ContentTemplate>
                                        <div id="floatdiv" class="w-100p" runat="server" style="display: block; border-width: 1px;
                                            border-color: #000; z-index: 100">
                                            <table class="w-100p" cellpadding="3" style="background-color: #333; border-color: #000;
                                                color: #fff;">
                                                <tr class="h-20 colorforcontent">
                                                    <td>
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td>
                                                                    <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_17 %>
                                                                </td>
                                                                <td align="right">
                                                                    <%--<img ID="img3" OnClick="javascript:hideConfirmpop();" 
                                                                                src="../Images/Delete.jpg" style="cursor:pointer;" />--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <font face="arial" size="2">
                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_15 %></font>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <div id="divscrl" class="w-100p" runat="server" style="overflow: auto; max-height: 190px;">
                                                            <table class="w-90p marginL10">
                                                                <font color="yellow" face="arial" size="2">
                                                                    <asp:Label ID="ltrlTestName" runat="server" Text=""></asp:Label>
                                                                </font>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center">
                                                        <font face="arial" size="2">
                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_16 %></font>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center">
                                                        <table class="w-20p">
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnSaveConfirm" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                                        OnClientClick="javascript:return displayProgress();" onmouseout="this.className='btn'"
                                                                        onmouseover="this.className='btn btnhov'" Text="Yes" meta:resourcekey="btnSaveConfirmResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCloseWarning" runat="server" CssClass="btn" OnClientClick="return HideAbnormalPopup();"
                                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="No"
                                                                        meta:resourcekey="btnCloseWarningResource1" />
                                                                    <%--
                                                                            <input ID="btnCloseWarning" runat="server" class="btn" 
                                                                                OnClick="javascript:hideConfirmpop();" onmouseout="this.className='btn'" 
                                                                                onmouseover="this.className='btn btnhov'" type="button" value="Close" />--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                            <asp:HiddenField ID="hdnIds" runat="server" />
                            <asp:HiddenField ID="hdnOutofrangeCount" runat="server" />
                            <%-- <asp:HiddenField runat="server" ID="hdnIsDeltaCheckWant" Value="false" />
                                                <asp:HiddenField runat="server" ID="hdnPatternID" />
                                            <asp:HiddenField runat="server" ID="hdnPatientInvID" />
                                            <asp:HiddenField runat="server" ID="hdnMappingPatternID" />
                                          
                                            <asp:HiddenField runat="server" ID="hdnPatientVisitID" />--%>
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
                <%-- <Reflex:ReflexTest ID="ucReflexTest" runat="server" />--%>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnShowRR" />
                <asp:PostBackTrigger ControlID="btnShowRR1" />
                <asp:PostBackTrigger ControlID="btnApproval" />
                <asp:PostBackTrigger ControlID="btnApproval1" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <ajc:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="modalBackground"
        CancelControlID="btnpopClose1" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation1"
        TargetControlID="btnDummy11">
    </ajc:ModalPopupExtender>
    <input id="btnDummy11" runat="server" style="display: none;" type="button"></input>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnpagearraw" runat="server" />
    <asp:HiddenField runat="server" ID="Reasonloading" Value="N" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnDCcheck" runat="server" Value="false" />
    <asp:HiddenField ID="hdnIsCultureSensitivityV2" runat="server" Value="false" />
    <asp:HiddenField ID="hdnFishResulPattern" runat="server" Value="false" />
    <asp:HiddenField ID="hdnFishResulPattern1" runat="server" Value="false" />
    <asp:HiddenField ID="hdnMolbio" runat="server" Value="false" />
    <asp:HiddenField ID="hdnBRCA" runat="server" Value="false" />
    <asp:HiddenField ID="hdnBRCA1" runat="server" Value="false" />
    <asp:HiddenField ID="hdnMicroBio1" runat="server" Value="false" />
    <asp:HiddenField ID="hdnUnCheckedAbnormalControl" runat="server" Value="" />
    <asp:HiddenField ID="hdnEditableFormulaFields" runat="server" Value="" />
    <asp:HiddenField ID="hdnComputationFieldList" runat="server" Value="" />
    <asp:HiddenField ID="hdnPatientGender" runat="server" Value="" />
    <asp:HiddenField ID="hdnDDLValues" runat="server" Value="" />
    <asp:HiddenField ID="hdnDomainvalue" runat="server" Value="false" />
    <asp:HiddenField ID="hdnOutOfRangeDetails" runat="server" Value="" />
    <asp:HiddenField ID="hdnHighRangeDetails" runat="server" Value="" />
    <asp:HiddenField ID="hdnIsExcludeAutoApproval" runat="server" Value="" />
    <asp:HiddenField ID="hdnlstNotYetResolvedRRParams" runat="server" Value="" />
    <asp:HiddenField ID="hdnlstreasons" runat="server" Value="" />
    <asp:HiddenField ID="hdnRefrtype" runat="server" Value="" />
    <asp:HiddenField ID="hdnRuleMedRemarks" runat="server" Value="N" />
    <asp:HiddenField ID="hdnAutoApproveQueueCount" runat="server" Value="0" />
    <asp:HiddenField ID="hdnNormalApproveTestCount" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCommonDCcheck" runat="server" Value="" />
    <asp:HiddenField ID="hdnIscommonValidation" runat="server" Value="" />
    <asp:HiddenField ID="hdnIsAutoAuthRecollect" runat="server" Value="" />
    <asp:HiddenField ID="hdnrerunrecollect" runat="server" Value="" />
    <asp:HiddenField ID="hdnGroupCollection" runat="server" Value="" />
    <asp:HiddenField ID="hdnRoleName" runat="server" Value="" />
    <asp:HiddenField ID="hdnSensitiveRangeDetails" runat="server" Value="" />
    <asp:HiddenField ID="hdnAgeDays" Value="0" runat="server" />
	
 
<asp:HiddenField ID="hdnRoleID" runat="server" Value="0" />
<asp:HiddenField ID="hdnloginid" runat="server" Value="0" />
<asp:HiddenField ID="hdnguid" runat="server" Value="" />
<asp:HiddenField ID="hdnAutoSave" runat="server" Value="" />
<asp:HiddenField ID="hdnVisitID" runat="server" Value=0 />
<asp:HiddenField ID="hdnPatOrgID" runat="server" Value=0 />
<asp:HiddenField ID="hdnMedicalRemarksList" runat="server" Value="" />
<div id="dialog1" style="display: none" >
    </form>
</body>

<script type="text/javascript">
<!--
    /* Script by: www.jtricks.com
    * Version: 20071017
    * Latest version:
    * www.jtricks.com/javascript/navigation/floating.html
    */

    var floatingMenuId = 'floatdiv';
    var floatingMenu =
{
    targetX: 'center',
    targetY: 'center',

    hasInner: typeof (window.innerWidth) == 'number',
    hasElement: typeof (document.documentElement) == 'object'
        && typeof (document.documentElement.clientWidth) == 'number',

    menu:
        document.getElementById
        ? document.getElementById(floatingMenuId)
        : document.all
          ? document.all[floatingMenuId]
          : document.layers[floatingMenuId]
};

    floatingMenu.move = function() {
        floatingMenu.menu.style.left = floatingMenu.nextX + 'px';
        floatingMenu.menu.style.top = floatingMenu.nextY + 'px';
    }

    floatingMenu.computeShifts = function() {
        var de = document.documentElement;

        floatingMenu.shiftX =
        floatingMenu.hasInner
        ? pageXOffset
        : floatingMenu.hasElement
          ? de.scrollLeft
          : document.body.scrollLeft;
        if (floatingMenu.targetX < 0) {
            floatingMenu.shiftX +=
            floatingMenu.hasElement
            ? de.clientWidth
            : document.body.clientWidth;
        }

        floatingMenu.shiftY =
        floatingMenu.hasInner
        ? pageYOffset
        : floatingMenu.hasElement
          ? de.scrollTop
          : document.body.scrollTop;
        if (floatingMenu.targetY < 0) {
            if (floatingMenu.hasElement && floatingMenu.hasInner) {
                // Handle Opera 8 problems
                floatingMenu.shiftY +=
                de.clientHeight > window.innerHeight
                ? window.innerHeight
                : de.clientHeight
            }
            else {
                floatingMenu.shiftY +=
                floatingMenu.hasElement
                ? de.clientHeight
                : document.body.clientHeight;
            }
        }
    }

    floatingMenu.calculateCornerX = function() {
        if (floatingMenu.targetX != 'center')
            return floatingMenu.shiftX + floatingMenu.targetX;

        var width = parseInt(floatingMenu.menu.offsetWidth);

        var cornerX =
        floatingMenu.hasElement
        ? (floatingMenu.hasInner
           ? pageXOffset
           : document.documentElement.scrollLeft) +
          (document.documentElement.clientWidth - width) / 2
        : document.body.scrollLeft +
          (document.body.clientWidth - width) / 2;
        return cornerX;
    };

    floatingMenu.calculateCornerY = function() {
        if (floatingMenu.targetY != 'center')
            return floatingMenu.shiftY + floatingMenu.targetY;

        var height = parseInt(floatingMenu.menu.offsetHeight);

        // Handle Opera 8 problems
        var clientHeight =
        floatingMenu.hasElement && floatingMenu.hasInner
        && document.documentElement.clientHeight
            > window.innerHeight
        ? window.innerHeight
        : document.documentElement.clientHeight

        var cornerY =
        floatingMenu.hasElement
        ? (floatingMenu.hasInner
           ? pageYOffset
           : document.documentElement.scrollTop) +
          (clientHeight - height) / 2
        : document.body.scrollTop +
          (document.body.clientHeight - height) / 2;
        return cornerY;
    };

    floatingMenu.doFloat = function() {
        // Check if reference to menu was lost due
        // to ajax manipuations
        if (!floatingMenu.menu) {
            menu = document.getElementById
            ? document.getElementById(floatingMenuId)
            : document.all
              ? document.all[floatingMenuId]
              : document.layers[floatingMenuId];

            initSecondary();
        }

        var stepX, stepY;

        floatingMenu.computeShifts();

        var cornerX = floatingMenu.calculateCornerX();

        var stepX = (cornerX - floatingMenu.nextX) * .07;
        if (Math.abs(stepX) < .5) {
            stepX = cornerX - floatingMenu.nextX;
        }

        var cornerY = floatingMenu.calculateCornerY();

        var stepY = (cornerY - floatingMenu.nextY) * .07;
        if (Math.abs(stepY) < .5) {
            stepY = cornerY - floatingMenu.nextY;
        }

        if (Math.abs(stepX) > 0 ||
        Math.abs(stepY) > 0) {
            floatingMenu.nextX += stepX;
            floatingMenu.nextY += stepY;
            floatingMenu.move();
        }

        setTimeout('floatingMenu.doFloat()', 20);
    };

    // addEvent designed by Aaron Moore
    floatingMenu.addEvent = function(element, listener, handler) {
        if (typeof element[listener] != 'function' ||
       typeof element[listener + '_num'] == 'undefined') {
            element[listener + '_num'] = 0;
            if (typeof element[listener] == 'function') {
                element[listener + 0] = element[listener];
                element[listener + '_num']++;
            }
            element[listener] = function(e) {
                var r = true;
                e = (e) ? e : window.event;
                for (var i = element[listener + '_num'] - 1; i >= 0; i--) {
                    if (element[listener + i](e) == false)
                        r = false;
                }
                return r;
            }
        }

        //if handler is not already stored, assign it
        for (var i = 0; i < element[listener + '_num']; i++)
            if (element[listener + i] == handler)
            return;
        element[listener + element[listener + '_num']] = handler;
        element[listener + '_num']++;
    };

    floatingMenu.init = function() {
        floatingMenu.initSecondary();
        floatingMenu.doFloat();
    };

    // Some browsers init scrollbars only after
    // full document load.
    floatingMenu.initSecondary = function() {
        floatingMenu.computeShifts();
        floatingMenu.nextX = floatingMenu.calculateCornerX();
        floatingMenu.nextY = floatingMenu.calculateCornerY();
        floatingMenu.move();
    }

    if (document.layers)
        floatingMenu.addEvent(window, 'onload', floatingMenu.init);
    else {
        floatingMenu.init();
        floatingMenu.addEvent(window, 'onload',
        floatingMenu.initSecondary);
    }


//-->
    $(document).ready(function() {


        setInterval(function() {
            if (($("#hdnAutoSave").val()) == "Y") {
            if (($("#hdnRoleName").val()) == "Lab Technician") {
                fnSaveAsDrafts();
                }
            }
        }, 50000);

        dialogfunc();

    });
    
    function fnSaveAsDrafts() {

        var visitid = $('[ID=hdnPatientVisitID]').val();
        var loginid = $('[ID=hdnloginid]').val();
        var orgid = $('[ID=hdnOrgID]').val();
        var LstInvValues = [];
        var lstpatientinv = [];
        if (visitid != 0 && visitid != "") {
            //txtorgan(Specimen) change begins//
            var OrganValue = $("[name*=fckInvDetails]");
            if (OrganValue.length > 0) {
                var Organvalues;
                var OrganInvID;
                var OrganName;
                var organDDlID;
                var organStatus;
                var FCKSection1;
                var OrganGroupid;
                var OrganGroupName;
                for (var i = 0; i < OrganValue.length; i++) {
                    var organfck = OrganValue[i].name.split("$")[0] + '_fckInvDetails';
                    //if (typeof CKeditorAPI != 'undefined') {
                    //FCKSection1 = FCKeditorAPI.GetInstance(organfck);
                    FCKSection1 = CKEDITOR.instances[organfck];

                    //  }
                    if (FCKSection1 != undefined) {
                        //// Organvalues = FCKSection1.GetHTML();
                        Organvalues = FCKSection1.getData();
                    }
                    if (Organvalues != "" && Organvalues != null && Organvalues != "<br />") {
                        OrganInvID = OrganValue[i].name.split("~")[0];
                        OrganGroupid = OrganValue[i].name.split("~")[2];
                        OrganGroupName = OrganValue[i].name.split("~")[1];
                        organDDlID = OrganValue[i].name.split("$")[0] + '_ddlstatus';
                        ////OrganName = $("[id*=lblName]").html();
                        var oname = $("[id*=lblName]");
                        var chkName;
                        for (var j = 0; j < oname.length; j++) {
                            chkName = oname[j].id.split("~")[0];
                            if (chkName == OrganInvID) {
                                OrganName = $(oname[j]).html();
                                OrganName = OrganName.replace("&amp;", "&");
                            }
                        }
                        //                        var oname = organDDlID.split("_")[0] + '_lblName';
                        //                        OrganName = $(oname).html();

                        var e = document.getElementById(organDDlID);
                        if (e != null) {
                            organStatus = e.options[e.selectedIndex].value.split("_")[0];
                        } else { organStatus = "Completed"; }
                        if (organStatus == "Pending" || organStatus == "PartiallyCompleted") {

                        LstInvValues.push({
                            InvestigationID: OrganInvID,
                            Name: OrganName,
                            Value: Organvalues,
                            PatientVisitID: visitid,
                            CreatedBy: loginid,
                            GroupName: OrganGroupName,
                            GroupID: OrganGroupid,
                            Orgid: orgid,
                                Status: "Pending",
                            PackageID: 0,
                            PackageName: null,
                            SequenceNo: 3
                            });
                        }
                    }
                }
            }

            var lstinvvalue = [];
            lstinvvalue.push(LstInvValues);

            //PatientInvestigation list  change Begins//
            var patientinv = $("[name*=fckInvDetails]");
            if (patientinv.length > 0) {
                var ptInvID;
                var ptDDlID;
                var ptStatus;
                var ptGroupId;
                for (var i = 0; i < patientinv.length; i++) {
                    ptInvID = patientinv[i].name.split("~")[0];
                    ptGroupId = patientinv[i].name.split("~")[2];
                    ptDDlID = patientinv[i].name.split("$")[0] + '_ddlstatus';
                    var e = document.getElementById(ptDDlID);
                    if (e != null) {
                        ptStatus = e.options[e.selectedIndex].value.split("_")[0];
                    } else {
                    ptStatus = "Completed";
                   }

                  //  ptStatus = 'Pending';
                   if (ptStatus == "Pending" || ptStatus == "PartiallyCompleted") {
                    lstpatientinv.push({
                        InvestigationID: ptInvID,
                        PatientVisitID: visitid,
                        GroupName: null,
                        GroupID: ptGroupId,
                        Orgid: orgid, //OrgID;
                           Status: "Pending",
                        Reason: null,
                        MedicalRemarks: null,
                        RemarksID: 0
                       });
                   }
                }
            }

            //PatientInvestigation list  change Begins//
            var vdata = {};
            vdata.LstinvValues = lstinvvalue;
            vdata.lstPatientInvs = lstpatientinv;
            vdata.vid = visitid;
            vdata.guid = $('[ID*=hdnguid]').val();
            vdata.orgid = orgid;
            if (vdata.lstPatientInvs.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "InvestigationResultsCapture.aspx/AutoSaveHisto",
                    data: JSON.stringify(vdata),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function Success(data) {
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(errorThrown);
                    }
                });
            }
        }
    }


   
</script>

<%--<script type="text/javascript" language="javascript">

    //get the list of id in corespond dropdownlists

    var CompletedOptionID = $("select[id*='_ddlstatus']").map(function() {
        return $(this).attr("id");
    });

    //check where  the selected values is completed on dropdown list
    
    for (var i = 0; i < CompletedOptionID.length; i++) {

        var completed = document.getElementById(CompletedOptionID[i]);

        if (completed.options[completed.selectedIndex].text === "Completed") {

            completed.style.display = "none";
        }
    }
    
    
</script>--%>

  <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>
</html>
