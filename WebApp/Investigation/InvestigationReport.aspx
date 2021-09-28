<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationReport.aspx.cs"
    Inherits="Investigation_InvestigationReport" meta:resourcekey="PageResource1"
    EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="NotesPattern.ascx" TagName="NotesPattern" TagPrefix="uc41" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<%@ Register Src="~/CommonControls/DespatchQueue.ascx" TagName="DespatchQ" TagPrefix="uc11" %>
<%@ Register Src="~/CommonControls/AbberantQueue.ascx" TagName="AbbrentQueu" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
      <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
  <link rel="stylesheet" href="/resources/demos/style.css"/>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style type="text/css">
        .notification-bubble
        {
            background-color: #F56C7E;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.17) inset, 0 1px 1px rgba(0, 0, 0, 0.2);
            color: #FFFFFF;
            font-size: 9px;
            font-weight: bold;
            text-align: center;
            text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.2);
            -moz-transition: all 0.1s ease 0s;
            padding: 2px 3px 2px 3px;
        }
        .OutSrce
        {
            background-color: #D0FA58;
        }
        body:nth-of-type(1) img[src*="Blank.gif"]
        {
            display: none;
        }
        .mdlpop
        { 
            top: 30px !important; 
        }
    </style>

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />
  <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
      

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script type="text/javascript">
        /*Added for Technician Report Functionlity*/
        /*Start*/

        function ShowReportPreview1(vid, roleId, invStatus) {
            try {

                $find("mpReportPreviewProduct").show();
                $("#iframeplaceholderForProducttest").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
            }
            catch (e) {
                return false;
            }
        }
        function ShowReportPreviewmanual(vid, roleId, invStatus,Language) {
            try {

              //  $find("rptMdlPopup").show();
                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "&Language=" + Language + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
            }
            catch (e) {
                return false;
            }
        }
        function ShowReportPreviewForProduct(vid, roleId, invStatus) {
            try {
                debugger;
                calShowReport(true);
              //   $find("mpReportPreview").show();
                
                var strReportType = document.getElementById('hdnReportType').value;
                var pDeptID = $("#hdndrpdepartment").val();

                var AccNo = document.getElementById("hdnAccessionNumber").value.split(',');

               $("#tblReportDetails").hide();
               $("#grdPatientView").hide();
               $("#btnGenerateReport").hide();
               $("#btnpdf").hide();
               $("#tblReportDetails").hide();
               $("#Table2").hide();

    //Generate Report Working
            /*    $find("mpReportPreviewProduct").show();
                $("#iframeplaceholderForProducttest").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "&deptid=" + pDeptID + "&accessionnumber=" + ANo + "&WSReportNeed=Y" + "&ReportType=" + strReportType + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
*/

//Show report cal function
             //   $find("mpReportPreview").show();
              //  $("#iframeplaceholderForProduct").html("<iframe id='Iframe1' name='myname' src='PrintVisitDetails.aspx?vid=" + str[0] + "&roleid=" + str[1] + "&type=showreport&invstatus=" + str[2] + "&deptid=" + pDeptID + "&accessionnumber=" + ANo + "&WSReportNeed=Y" + "&ReportType=" + strReportType + "' style='width: 100%;height: 450px; border: 1px; overflow: auto;'></iframe>");
           
            }
            catch (e) {
                return false;
            }
        }


        
        /*End*/
       
        function setDeptFilter() {
            $("#hdndrpdepartment").val($("#drpdepartment").val());
            return false;
        }
        function setTestStatus() {
            $("#hdnTestStatus").val($("#ddstatus").val());
            return false;
        }
        function showHide() {
            $("#dvShow").hide();
            $("#tdChecknames").hide();
            $("#tdShowHideTestDetail").val("Show Test Details");
            $("#dvHide").show();
        }
        function Validate() {
           var ReportTypeText=  $("#ddlReportType").find("option:selected").text();           // Text
           var ReportTypeValue = $("#ddlReportType").find("option:selected").prop("value");    // Value
           if (ReportTypeValue == "0" || ReportTypeValue == "" || ReportTypeValue == null) {

               alert("Please Select Report Type");
               return false;
           }
           else if (($('.chkINV:checked').length == 0) && (ReportTypeText == "Interim" || ReportTypeText == "Single")) {
               alert("Please Select Atleast One Approved Investigation");
               return false;
           }
           else if (($('.chkINV:checked').length == 0) && ReportTypeText == "Provision") {
           alert("Please Select Atleast One Investigation");
           return false;
           }
           
           else if (ReportTypeText == "Final" || ReportTypeText == "Duplicate" || ReportTypeText == "Amended") {
               if (document.getElementById("hfApproveCount").value == "Approve") {
                   $('.chkINV').attr('checked', true);
                   $('.chkINV').attr('disabled', true);
                   $('.chkINVPro').attr('disabled', true);


               }
               else {
                   $('.chkINV').attr('disabled', true);
                   $('.chkINVPro').attr('disabled', true);
                   alert("Please Approve all Investigation");
                   return false;
               }
           }
           else if (ReportTypeText == "Cumulative") {
               if (document.getElementById("hfApproveCount").value == "Approve") {
                   $('.chkINV').attr('checked', true);
                   $('.chkINV').attr('disabled', true);
                   $('.chkINVPro').attr('checked', true);
                   $('.chkINVPro').attr('disabled', true);
               }
               else {
                   $('.chkINV').attr('disabled', true);
                   $('.chkINVPro').attr('disabled', true);
                   alert("Please Approve all Investigation");
                   return false;
               }

               var IsPreviousLabNumber = document.getElementById("hdnPreviousLabNumber").value;
               if (IsPreviousLabNumber == '0') {

                   alert("Cannot Generate Cumulative Report for this Patient !!");
                   return false;
               }

           }

        }
        
        function AddAccessionNumber(ID, varAccessionNumber,InvStatusValue) {
            debugger;
            var ReportType = $("#ddlReportType").find("option:selected").text();
            if (ReportType != "--Select--") {
//                var InvID = ID.split('~~');
//                var ID1 = InvID[0];
//                var InvName = InvID[1];
//                var IStatus = InvName.split(',');
                var InvSts = InvStatusValue;

                //Single-To avoid completed test in Report even its disabled
                if (ReportType == "Single") {
                    if (InvSts == "Completed") {                      
                        document.getElementById(ID).checked = false;
                    }
                }


                //Interim-To avoid completed test in Report even its disabled
                if (ReportType == "Interim") {
                    if (InvSts == "Completed") {
                        document.getElementById(ID).checked = false;
                    }
                }
               

                 var sAccNo = document.getElementById('hdnAccessionNumber').value.split(',');
                 document.getElementById('hdnAccessionNumber').value = "";
                 for (var i = 0; i < sAccNo.length; i++) {
                     if (sAccNo[i] != "" && sAccNo[i] != "0") {
                         if (sAccNo[i] != varAccessionNumber) {
                             document.getElementById('hdnAccessionNumber').value += sAccNo[i] + ",";
                         }
                     }
                 }
                 if (document.getElementById(ID).checked == true && document.getElementById('hdnAccessionNumber').value != "0") {
                     document.getElementById('hdnAccessionNumber').value += varAccessionNumber + ",";
                 }
                 
                if (ReportType == "Single") {
                    if (InvSts != "Approve") {
                        document.getElementById(ID).checked = false;
                        alert("Investigation was not Approved");
                        return false;
                    }
                    else {
                        $('.chkINV').attr('disabled', true);
                        document.getElementById(ID).disabled = false;
                        if (document.getElementById(ID).checked == false) {
                            $('.chkINV').attr('disabled', false);
                        }
                    }
                }
                if (ReportType == "Interim") {
                    if (InvSts != "Approve") {
                        document.getElementById(ID).checked = false;
                        alert("Investigation was not Approved");
                        return false;
                    }
                }
            }
            else {
                document.getElementById(ID).checked = false;
                alert("Please Select Report Type");
                return false;
            }
            return false;
        }
        function calSendMail() {
            debugger;


            //            var ID = document.getElementById('hfID').value;
            //            var pid = document.getElementById('hfPatientID').value;
            //            var rid = document.getElementById('hfRoleID').value;
            //            var orgid = document.getElementById('hfOrgID').value;
            //            var pvid = document.getElementById('hfPatientVisitID').value;
            //            var pgid = document.getElementById('hfPageID').value;
            //            var bname = "btnPRSendMail";
            //            var bval = "Send Mail";

            //            $.ajax({
            //                type: "POST",
            //                url: "../WebService.asmx/ProvisionalReportAttatchSendMail",
            //                data: "",
            //                contentType: "application/json; charset=utf-8",
            //                dataType: "json",
            //                success: function Success(data) {
            //                },
            //                error: function Error() {
            //                }

            //            });

        }

        function calShowReport(IsneedWSReport) {
            debugger;
            var sam = "";
            var pDeptID = $("#hdndrpdepartment").val();

            //            if (document.getElementById("rdbtnWithStationary").checked) {
                         //  IsneedWSReport = true;
            //            }
            //            if (document.getElementById("rdbtnWithOutStationary").checked) {
            //                IsneedWSReport = false;
            //            }
            var ANo = document.getElementById("hdnAccessionNumber").value.split(',');
            var str = document.getElementById("hdnParameters").value.split('#');
            document.getElementById("hfSelectedAccession").value
            var AccessNo = str[3].split('^');
            for (var a = 0; a < ANo.length - 1; a++) {
                for (var i = 0; i < AccessNo.length - 1; i++) {
                    var step = AccessNo[i].split('~');


                    if (ANo[a] == step[2]) {
                        if (sam == "") {
                            sam = AccessNo[i];
                        }
                        else {
                            sam += '^' + AccessNo[i];
                        }
                    }

                }
            }
            document.getElementById("hfSelectedAccession").value = sam;
            var strReportType = document.getElementById('hdnReportType').value;
        
           
         //   ShowReportPreview(str[0], str[1], str[2], sam, true, IsneedWSReport);
            //ReportType
            // $find("mpReportPreview").show();           
            $("#iframeplaceholder").html("<iframe id='Iframe1' name='myname' src='PrintVisitDetails.aspx?vid=" + str[0] + "&roleid=" + str[1] + "&type=showreport&invstatus=" + str[2] + "&deptid=" + pDeptID + "&accessionnumber=" + ANo + "&WSReportNeed=Y" + "&ReportType=" + strReportType + "' style='width: 100%;height: 450px; border: 1px; overflow: auto;'></iframe>");

            sHtml = "";
            AccNo = "";
            document.getElementById("hdnAccessionNumber").value = "";
            //Uncommented by Radha
           // showHide();
            
          //  showResponses('dvShow', 'dvHide', 'tdChecknames', 1);

            return false;
        }
        function CloseextShowLiveReport() {
            if ($find('extShowLiveReport') != null) {
                $find('extShowLiveReport').hide();
            }
        }

        function CheckReportTypeStatus(e) {
            debugger;
            $('.chkINV').attr('checked', false);
            document.getElementById('hdnReportType').value = "";
            document.getElementById('hdnSingle').value = e.value;
            var ReportType = $('#ddlReportType option[value=' + e.value + ']').text(); //$("#ddlReportType").find("option:selected").text();
            document.getElementById('hdnReportType').value = ReportType; 
             if (ReportType != "--Select--") {
                 if (ReportType == "Final" || ReportType == "Duplicate" || ReportType == "Amended" || ReportType == "Cumulative") {
                     if (document.getElementById("hfApproveCount").value == "Approve") {
                         $('.chkINV').attr('checked', true);
                         $('.chkINV').attr('disabled', true);
                         $('.chkINVPro').attr('checked', true);
                         $('.chkINVPro').attr('disabled', true);


                     }
                     else {
                         $('.chkINV').attr('disabled', true);
                         $('.chkINVPro').attr('disabled', true);
                        // alert("Please Approve all Investigation");
                         return false;
                     }
                 }
                 else if (ReportType == "Provision") {
                 $('.chkINVPro').attr('disabled', true);
                 $('.chkINV').attr('disabled', false);

                 }
                 else {
                     $('.chkINV').attr('disabled', false);
                     $('.chkINVPro').attr('disabled', true);

                return false;
                //                if (e.value == "Single") {

                //                    
                //                    if ($('[type="checkbox"]').is(":checked")) {
                //                    }
                //                    else {
                //                        alert("Please Select any one Test");
                //                        return false;
                //                    }
                //                }
            }


            //            var ReportType = e.value;
            //            var invid = document.getElementById('hdnAccessionNumber').value;
            //            var vid = document.getElementById('hdnVID').value;
            //            var OrgID = document.getElementById('hfOrgID').value;
            //            $.ajax({
            //                type: "POST",
            //                url: "../WebService.asmx/GetReportTypeStatus",
            //                data: "{VisitID: " + vid + ",OrgID: " + OrgID + ",InvID: ' " + invid + " ',ReportType: ' " + ReportType + "'}",
            //                contentType: "application/json; charset=utf-8",
            //                dataType: "json",
            //                success: function Success(data) {
            //                    if (data.d != '[]') {
            //                        alert(data.d);
            //                    }
            //                },
            //                error: function(xhr, ajaxOptions, thrownError) {

                 //                   
                 //                }
                 //            });
             }
        }

        function ShowReportPreviewForAll(vid, roleId, invStatus, AccessionNumber, OrgID, boolValue, IsneedWSReport) {
            debugger;
            var pInvStatus = $("#hdnTestStatus").val();
            $("#ddlReportType").prop('selectedIndex', 0);
            document.getElementById("hfSelectedAccession").value = "";
            invStatus = pInvStatus == "Completed" || pInvStatus == "Approve" ? pInvStatus : invStatus;

            var invS = invStatus.split(',');
            document.getElementById("hdnPreviousLabNumber").value = "";
            var lstPatientVisitInvestigation = "";
            if (AccessionNumber == "") {

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetPatientVisitInvestigation",
                    data: "{VisitID: " + vid + ",OrgID: " + OrgID + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        debugger;
                        lstPatientVisitInvestigation = data.d;
                        var invStatusFlag = false;
                        var AppCount = 0;
                        var ReceiveCount = 0;
                        //Added by Radha
                        //Blocked the "Not given","Cancel","OutSource" ,"Rejected" Status investigations for Manual Report generation
                        //START
                        var count = lstPatientVisitInvestigation.length;
                        var lstBlockStatusPVInvestigations = [];
            
                        for (var i = 0; i < count; i++) {
                            debugger;
                            if (lstPatientVisitInvestigation[i].Status != "Not given" && lstPatientVisitInvestigation[i].Status != "Cancel" && lstPatientVisitInvestigation[i].Status != "OutSource" && lstPatientVisitInvestigation[i].Status != "Rejected" && lstPatientVisitInvestigation[i].Status != "SampleCollected") {                      
                                lstBlockStatusPVInvestigations[lstBlockStatusPVInvestigations.length] = lstPatientVisitInvestigation[i]
                            }
                        }
                        lstPatientVisitInvestigation = lstBlockStatusPVInvestigations;

                        //END
                      
                        for (var i = 0; i < lstPatientVisitInvestigation.length; i++) {
                            document.getElementById("hdnPreviousLabNumber").value = lstPatientVisitInvestigation[i].IsPreviousLabNumber;

                            var InvestiogationId = lstPatientVisitInvestigation[i].ID;
                            var InvestiogationNameandStatus = lstPatientVisitInvestigation[i].InvestigationName + "," + lstPatientVisitInvestigation[i].Status;
                            var AccNum = lstPatientVisitInvestigation[i].AccessionNumber;
                            var DeptID = lstPatientVisitInvestigation[i].DeptID;
                            var InvestiogationStatus = lstPatientVisitInvestigation[i].Status;
                            if (DeptID == null || DeptID == '') {
                                DeptID = '@@'
                            }

                            AccessionNumber += lstPatientVisitInvestigation[i].ID + "#" + lstPatientVisitInvestigation[i].InvestigationName + "," + lstPatientVisitInvestigation[i].Status + "#" + lstPatientVisitInvestigation[i].AccessionNumber + "#" + DeptID + "#" + lstPatientVisitInvestigation[i].Status + "^";
                            if (lstPatientVisitInvestigation[i].Status == "Approve") {
                                AppCount++;
                            }
                            else if (lstPatientVisitInvestigation[i].Status == "SampleCollected" || lstPatientVisitInvestigation[i].Status == "SampleReceived" || lstPatientVisitInvestigation[i].Status == "Pending") {
                                ReceiveCount++;
                            }
                            if (invStatusFlag == false) {
                                for (j = 0; j < invS.length; j++) {
                                    invStatusFlag = lstPatientVisitInvestigation[i].Status.toLowerCase() == invS[j].toLowerCase() ? true : false;
                                    if (invStatusFlag) { break };
                                }
                            }
                        }
                        if (lstPatientVisitInvestigation.length == AppCount) {
                            document.getElementById("hfApproveCount").value = "Approve";
                        }
                        else {
                            document.getElementById("hfApproveCount").value = "";
                        }

                        document.getElementById("hfShowAllAccession").value = AccessionNumber;
                        if (invStatusFlag) {


                            ShowReportPreview(vid, roleId, invStatus, AccessionNumber, boolValue, IsneedWSReport);
                            if ($find('extShowLiveReport') != null)
                            $find("extShowLiveReport").show();
                        }
                        else {
                            CloseextShowLiveReport();
                            ValidationWindow('Manual Report Can not be generate against this Visit !!', 'Alert');

                            return false;
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {

                        alert(xhr.status);
                    }
                });
            }
            else {
                ShowReportPreview(vid, roleId, invStatus, AccessionNumber, boolValue, IsneedWSReport);
            }
        }
        function ShowReportPreview(vid, roleId, invStatus, AccessionNumber, boolValue, IsneedWSReport) {
            try {
                debugger;
               
                var SelectAccession = document.getElementById("hfSelectedAccession").value;
                var pDeptID = $("#hdndrpdepartment").val();

                var browser_info = perform_acrobat_detection();
                $find("extShowLiveReport").hide();
               // showHide();
                if (browser_info.acrobat == null) {

                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_4');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        alert("Please install adobe reader to perform print functionality");
                        return false;
                    }
                }
                else {

                    document.getElementById("hdnParameters").value = "";
                    var CheckID = "";
                    var showBool = false;
                    var AccNo = boolValue == true ? document.getElementById("hdnAccessionNumber").value : "";

                    var AccessNumber = document.getElementById("hfShowAllAccession").value;  //ShowAllAccession

                    var sAccessionNumber = AccessNumber.split("^");

                    var sHtml = "<table><tr>";
                    if (sAccessionNumber != "") {

                        for (var i in sAccessionNumber) {
                            var partsInvestigationID = sAccessionNumber[i].split("#")[0];

                            var partsInvestigationName = sAccessionNumber[i].split("#")[1];

                            var partsAccNumber = sAccessionNumber[i].split("#")[2];

                            var partsDeptID = sAccessionNumber[i].split("#")[3];
                            var InvestigationStatus = sAccessionNumber[i].split("#")[4];
                            pDeptID = "0";
                            var brVisible = i == sAccessionNumber.length ? "</tr>" : (i % 3 == 2) && i != 0 ? "</tr><tr>" : "";
                            //                            alert("iValue = " + i + "  count = " + sAccessionNumber.length + " Tag = " + brVisible);
                            var id = "chkInv" + partsInvestigationID + "~~" + partsInvestigationName;
                            var status = partsInvestigationName;


                            if (sAccessionNumber[i] != "" && pDeptID == "0") {
                                {

                                    showBool = true;
                                    if (InvestigationStatus == 'SampleReceived' || InvestigationStatus == 'Pending') {
                                        sHtml += " <td><input onclick='AddAccessionNumber(this.id,name,value);' disabled='true' type='checkbox' class='chkINVPro' id='" + id + "' name='" + partsAccNumber + "' value='" + InvestigationStatus + "'  /> " + partsInvestigationName + " </input></td> " + brVisible + "";
                                    }
                                    else {

                                        sHtml += " <td><input onclick='AddAccessionNumber(this.id,name,value);' type='checkbox' class='chkINV' id='" + id + "' name='" + partsAccNumber + "' value='" + InvestigationStatus + "'  /> " + partsInvestigationName + " </input></td> " + brVisible + "";
                                    }

                                }
                            }
                            else {


                                if (sAccessionNumber[i] != "" && partsDeptID == pDeptID) {

                                    showBool = true;
                                    if (invStatus == 'SampleReceived' || invStatus == 'Pending') {
                                        sHtml += " <td><input width='550px' onclick='AddAccessionNumber(this.id,name,value);' class='chkINVPro' disabled='true' type='checkbox' id='" + id + "' name='" + partsAccNumber + "' value='" + invStatus + "'  /> " + partsInvestigationName + " </input></td>" + brVisible + "";
                                    }
                                    {
                                        sHtml += " <td><input width='550px' onclick='AddAccessionNumber(this.id,name,value);' class='chkINV' type='checkbox' id='" + id + "' name='" + partsAccNumber + "' value='" + invStatus + "'  /> " + partsInvestigationName + " </input></td>" + brVisible + "";
                                    }
                                }

                            }

                        }
                    }
                  
                    if (!showBool) {

                        CloseextShowLiveReport();
                        alert("No Data Fetched for Selected Criteria !!");
                        return false;
                    }
                    var SRAccessionNo = document.getElementById('hdnAccessionNumber').value;
                    document.getElementById("hdnParameters").value = vid + "#" + roleId + "#" + invStatus + "#" + AccessionNumber;

                 
                    
                    //Commented By QBITZ Prakash.K
                    // sHtml += "<tr><td> <input type='button' onclick='calShowReport(" + true + ");' id='btnShowLiveReport' value='Show Report' class='btn' name ='ShowReport'></input></td>   </tr></table>";
                    sHtml += "</table>";
                    $("#tdChecknames").html(sHtml);
                    debugger;
                    if (IsneedWSReport != '' && IsneedWSReport != undefined && IsneedWSReport) {
                        $("#trShowReport").html("<td><iframe id='Iframe1' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "&deptid=" + pDeptID + "&accessionnumber=" + AccNo + "&WSReportNeed=Y" + "' style='width: 100%;height: 450px; border: 1px; overflow: auto;'></iframe></td>");
                    } else {
                        $("#trShowReport").html("<td><iframe id='Iframe1' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "&deptid=" + pDeptID + "&accessionnumber=" + AccNo + "' style='width: 100%;height: 450px; border: 1px; overflow: auto;'></iframe></td>");
                    }

                    $("#tblScroll").attr("style", "overflow:auto;");

                    sHtml = "";
                    AccNo = "";
                    document.getElementById("hdnAccessionNumber").value = "";
                }
            }
            catch (e) {
                return false;
            }
        }

//Added By QBITZ 
        function ClosePopUp() {
            $find('modalPopUp').hide();
        }
        function WaterMark(txtbox, evt, defaultText) {
            if (txtbox.value.length == 0 && evt.type == "blur") {
                txtbox.style.color = "gray";
                txtbox.value = defaultText;
            }
            if (txtbox.value == defaultText && evt.type == "focus") {
                txtbox.style.color = "black";
                txtbox.value = "";
            }
        }

        function OpenBillPrint1(url) {
            window.open(url, "labelprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
        function ShowAlertMsg(key) {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vAction = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_01') == null ? "This action cannot be performed for your role in this Organisation" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_01');
            var vURL = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_02') == null ? "URL Not Found" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_02');
            var vRepoart = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_03') == null ? "Report dispatched successfully" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_03');
            var vDispatch = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_04') == null ? "Report Email dispatched successfully" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_04');
            var vGetRepoart = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_05') == null ? "Unable to get the report. please contact system administrator" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_05');
            var vInvestigation = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_06') == null ? "selected Patient Dispatched Investigation Reports" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_06');

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_25") {
                //alert('This action cannot be performed for your role in this Organisation');
                ValidationWindow(vAction, AlertType);
            }

            else if (key == "Investigation\\InvestigationReport.aspx_26") {
                //alert('URL Not Found');
                ValidationWindow(vURL, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_27") {
                //alert('Report dispatched successfully');
                ValidationWindow(vDispatch, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_28") {
                //alert('Unable to dispatch the report. please contact system administrator');
                ValidationWindow(vRepoart, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_29") {
                //alert('Unable to get the report. please contact system administrator');
                ValidationWindow(vGetRepoart, AlertType);
            }
            else if (key == "Investigation\\InvestigationReport.aspx_30") {
                //alert(' selected Patient Dispatched Investigation Reports');
                ValidationWindow(vInvestigation, AlertType);
            }
            return true;
        }




        function checkdispatch() {
            //            if (document.getElementById('hdncourierboyid').value == "0") {
            //                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_1');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                }
            //                else {
            //                    alert('Enter the Correct Courier boy name');
            //                    return false;
            //                }
            //            }
            //            if (document.getElementById('txtcoruriersname').value == "") {
            //                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_2');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                } else {
            //                alert('Enter the Courier Boy name');
            //                return false;
            //                }
            //                document.getElementById('txtcoruriersname').focus();
            //               

            //            }
            //            if (document.getElementById('ddlDespatchMode').value == "0") {
            //                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_3');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                } else {
            //                alert('Select Dispatch mode');
            //                return false;
            //                }
            //                document.getElementById('ddlDespatchMode').focus();
            //            }
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vEmail = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_07') == null ? "You select despatch mode as E-mail , Provide e-mail address" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_07');
            var vMobileNo = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_08') == null ? "You select despatch mode as sms , Provide contact mobile number" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_08');
            var vName = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_09') == null ? "You select despatch mode as courier , Provide Courier boy name" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_09');

            var elements = document.getElementById('chkDespatchMode1');
            for (i = 0; i < elements.rows[0].cells.length; i++) {
                if (elements.cells[i].childNodes[0].checked) {
                    if (document.getElementById('chkDespatchMode1').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "email") {

                        if (document.getElementById('txtPatientMail').value.trim() == '') {
                            //alert("You select despatch mode as E-mail , Provide e-mail address");
                            ValidationWindow(vEmail, AlertType);
                            document.getElementById('txtPatientMail').focus();
                            return false;
                        }
                    }
                    if (document.getElementById('chkDespatchMode1').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "sms") {
                        if (document.getElementById('txtPatientMobileNo').value.trim() == '') {
                            //alert('You select despatch mode as sms , Provide contact mobile number');
                            ValidationWindow(vMobileNo, AlertType);
                            document.getElementById('txtPatientMobileNo').focus();
                            return false;
                        }
                    }
                    if (document.getElementById('chkDespatchMode1').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "courier") {


                        if (document.getElementById('txtcoruriersname').value.trim() == '') {
                            //alert("You select despatch mode as courier , Provide Courier boy name");
                            ValidationWindow(vName, AlertType);
                            document.getElementById('txtcoruriersname').focus();
                            return false;


                        }

                    }

                }
            }
        }
        function GetEmpIDs(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtcoruriersname').value = eventArgs.get_text();
            document.getElementById('hdncourierboyid').value = strVal.split('~')[0].trim();
            //            document.getElementById('txtPrsnMobile').value = strVal.split('~')[1].trim();
        }

        //------Murali Changes---- //

        function GetDocEmpIDs(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtDRCoruriersname').value = eventArgs.get_text();
            document.getElementById('hdncourierboyid1').value = strVal.split('~')[0].trim();
        }

        function dateselect(ev) {
            var calendarBehavior1 = $find("CalendarExtender3");
            var d = calendarBehavior1._selectedDate;
            var now = new Date();
            calendarBehavior1.get_element().value = d.format("MM/dd/yyyy") + " " + now.format("HH:mm:ss")
        }

        function dateselect1(ev) {
            var calendarBehavior2 = $find("CalendarExtender4");
            var d = calendarBehavior2._selectedDate;
            var now = new Date();
            calendarBehavior2.get_element().value = d.format("MM/dd/yyyy") + " " + now.format("HH:mm:ss")
        }

        //----------Murali Changes End---//

        function GetText(pName) {
            if (pName != "") {
                // var Temp = pName.split('(');
                //if (Temp.length >= 2) {
                document.getElementById('txtName').value = pName;
                // }
            }
        }
        function ShowHideReport() {
            var hdnHideReportTemplate = document.getElementById('hdnHideReportTemplate');
            if (hdnHideReportTemplate != null && typeof hdnHideReportTemplate != 'undefined') {
                if (document.getElementById('hdnHideReportTemplate').value == "1") {
                    showResponses('ACX3plus1', 'ACX3minus1', 'ACX3responses1', 0);
                    showResponses('ACX3plus2', 'ACX3minus2', 'ACX3responses2', 1);
                }
                else {
                    showResponses('ACX3plus1', 'ACX3minus1', 'ACX3responses1', 1);
                    showResponses('ACX3plus2', 'ACX3minus2', 'ACX3responses2', 0);
                }
            }
        }

        //----Murali----//

        function PrintReport(VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vPatient = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_10') == null ? "This Patient is having due amount,Do you want to print?" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_10');
            var btnok = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37') == null ? "Ok" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37');
            var btncancel = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38') == null ? "Cancel" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38');
            try {
                //if (IsGeneralClient == "N" && DueAmount > 0) {
                if (DueAmount > 0) {
                    var ans = window.ConfirmWindow(vPatient, AlertType, btnok, btncancel);
                    if (ans == true) {
                        return onPrintPolicy('batch', VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow);
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return onPrintPolicy('batch', VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow);
                }
            }
            catch (e) {
                return false;
            }
        }

        //-------Murali Ends--//

        function PrintBatchReport(VID, RoleID) {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vInstallAdobe = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_11') == null ? "Please install adobe reader to perform print functionality" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_11');
            var browser_info = perform_acrobat_detection();
            if (browser_info.acrobat == null) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Please install adobe reader to perform print functionality");
                    ValidationWindow(vInstallAdobe, AlertType);
                    return false;
                }
            }
            else {
                //******************Added and modifyed By arivalgan.k*****************************//
                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + VID + "&roleid=" + RoleID + "&type=ROUNDBPDF&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
                //$("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + VID + "&roleid=" + RoleID + "&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
                ///-------End-------///
            }
        }
        //******************Added and modifyed By arivalgan.k*****************************//
        function BtnPrintReport() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vInstallAdobe = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_11') == null ? "Please install adobe reader to perform print functionality" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_11');
            var browser_info = perform_acrobat_detection();
            if (browser_info.acrobat == null) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Please install adobe reader to perform print functionality");
                    ValidationWindow(vInstallAdobe, AlertType);
                    return false;
                }
            }
            else {
                //$("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
				$find("modalPopUp").show();
                var iframe = document.getElementById("ifPDF");
                iframe.style.display = "block";
                iframe.src = 'PrintVisitDetails.aspx';
            }
        }
        ///-------End-------///

        function setInputEnableState(reportViewer) {

            // It is ok to export if the viewer is not loading and is displaying a report.
            var disableInputs = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;


            $get("btnPrint").disabled = disableInputs;
        }

        function onReportViewerLoadingChanged(sender, e) {

            var propertyName = e.get_propertyName();

            if (propertyName === "isLoading" || propertyName === "reportAreaContentType") {
                setInputEnableState(sender);
            }
        }

        function onPrintButtonClicked() {
            var reportViewer = $find("rReportViewer");
            if (reportViewer != null) {
                reportViewer.invokePrintDialog();
            }
        }
        var hookedPropertyChangedEvent = false;

        function ReportLoad() {
            //            if (!hookedPropertyChangedEvent) {

            //                var reportViewer = $find("rReportViewer");
            //                reportViewer.add_propertyChanged(onReportViewerLoadingChanged);

            //                // Make sure the input controls are in the correct state initially
            //                setInputEnableState(reportViewer);

            //                // pageLoad is called after each asynchronous postback.  Only
            //                // hook the property changed event once.
            //                hookedPropertyChangedEvent = true;
            //            }
        }
        
        
        
    </script>

    <script type="text/javascript">

     
        //        $(document).ready(function() {
        //            var checkboxValues = [];

        //            $('#chkDept input[type=checkbox]').click(function() {
        //                $('input[type=checkbox]:checked').each(function() {
        //                    checkboxValues.push(this.value);
        //                    $("#msg").text(checkboxValues.toString());
        //                });
        //            });

        //            var values = checkboxValues.toString(); //Output Format: 1,2,3
        //        });
        function showInternalExternal(id) {
            if (document.getElementById(id).checked) {
                document.getElementById('tdRPinternal').style.display = "table-cell";
                document.getElementById('tdRPExternal').style.display = "none";
                document.getElementById('ddlPhysician').value = 0;

            }
            else {
                document.getElementById('tdRPinternal').style.display = "none";
                document.getElementById('tdRPExternal').style.display = "table-cell";
                document.getElementById('ddlRefPhysician').value = 0;
            }

        }
        function SelectVisit(id, vid, pid, patOrgID, email, CreditLimit, ClientBlock, ClientDue, DispatchTypeMode, DispatchType, DispatchValue, IsHealthCheckup,
        ClientID, IsGeneralClient, DueAmount, IsPrintAllow, IsDuebill) {
            //debugger;
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            //            var control = document.getElementById("chkSelectAll");
            //            document.getElementById("chkSelectAll").checked = false;
            //            control.disabled = true;

            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPID").value = pid;
            //            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("patOrgID").value = patOrgID;
            document.getElementById("hdnEMail").value = email;
            document.getElementById("hdncreditlimit").value = CreditLimit;
            document.getElementById("hdnclientBlock").value = ClientBlock;
            document.getElementById("hdnclientdue").value = ClientDue;
            document.getElementById("txtPatientMail").value = email;
            document.getElementById("hdnHealthcheckup").value = IsHealthCheckup;
            document.getElementById("hdnIsGeneralClient").value = IsGeneralClient;
            document.getElementById("hdnDue").value = DueAmount;
            document.getElementById("hdnClientID").value = ClientID;
            document.getElementById("hdnisduebill").value = IsDuebill;

        }
        function SelectDespatchVisit(id, vid, pid, patOrgID, email, pname, DispatchTypeMode, DispatchType, DispatchValue, IsHealthCheckup, DueAmount, ClientID) {
            //debugger;
            chosen = "";
            var len = document.forms[0].elements.length;
            //            for (var i = 0; i < len; i++) {
            //                if (document.forms[0].elements[i].type == "CheckBox") {
            //                    document.forms[0].elements[i].checked = false;
            //                }
            //            }

            document.getElementById("hdnDispatchType").value = DispatchType;
            document.getElementById("hdnDispatchMode").value = DispatchValue;
            document.getElementById("txtPatientMail").value = email;
            document.getElementById("hdnHealthcheckup").value = IsHealthCheckup;
            document.getElementById("hdnDue").value = DueAmount;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnClientID").value = ClientID;

            if (document.getElementById(id).checked == true) {
                document.getElementById("hdndespatchvisit").value += vid + '~' + pid + '~' + pname + '^';

            }
            else {
                if (document.getElementById('hdndespatchvisit').value != "") {
                    var s = document.getElementById('hdndespatchvisit').value.split("^");
                    document.getElementById('hdndespatchvisit').value = "";
                    document.getElementById('lbldespatchnames').value = "";
                    if (s != "") {
                        for (var i in s) {
                            var parts = s[i].split('~')[0];
                            if (vid != parts && parts != "") {
                                document.getElementById('hdndespatchvisit').value += s[i].split('~')[0] + '~' + s[i].split('~')[1] + '~' + s[i].split('~')[2] + '^';
                                document.getElementById('lbldespatchnames').value += s[i].split('~')[2] + '<br/><br/>';

                            }
                        }
                    }

                }
            }

        }


        function CheckVisitID(IsCumulative) {
          //  debugger;
            var check = "true";
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vpatient = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_12') == null ? "Selected client patient not having Health Check Up details..." : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_12');
            var vcheckbox = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_13') == null ? "Please select the checkbox and dispatch" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_13');
            var vrecord = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_14') == null ? "Select at least one record" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_14');
            var vBlocked = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_15') == null ? "Selected client was Blocked" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_15');
            var vSuspended = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_16') == null ? "This Client is Suspended and you will be able to see STAT and Critical Test reports only, Do you wish to Continue ?" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_16');
            var vproceed = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_17') == null ? "Select any one of the action to proceed" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_17');
            var btnok = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37') == null ? "Ok" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37');
            var btncancel = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38') == null ? "Cancel" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38');
            var vreplanguage = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_39') == null ? "Please select the language" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_39');
             
            document.getElementById("hdnPDFType").value = 'showreport&invstatus';
            var VisitID = document.getElementById("hdnVID").value;

           // $.ajax({
             //   type: "POST",
               // url: "../WebService.asmx/getconfidential",
                //data: "{ 'pvid':  " + VisitID + " }",
                //contentType: "application/json; charset=utf-8",
                //dataType: "json",
                //async: false,
                //success: function Success(data) {
                  //  if (data.d == "Y") {
                    //    ValidationWindow('You are not allowed to viwe the patient report though it has been marked as Confidential', AlertType);
                      //  check = "false";
//
  //                      return false;
//
  //                  }
    //                else {
      //                  return true;
        //            }
//
  //              },
    //            error: function(xhr, ajaxOptions, thrownError) {
      //              //alert(xhr.status);
        //            return false;
          //      }
            //});
            if (IsCumulative == true) {

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetCheckAvailableCumulative",
                    data: "{ 'pvisitID':  " + VisitID + " }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function Success(data) {
                        if (data.d == false) {
                            debugger;
                            ValidationWindow('Cumulative Report Not Available', AlertType);
                            IsCumulative = false;
                            check = "false";
                            return false;

                        }
                        else {
                            debugger;
                            return true;
                        }

                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        // alert(xhr.status);
                        return false;
                    }
                });
            }
            if ($('#ddlVisitActionName option:selected').val() == "Show_HealthReport_Patient") {
                if (document.getElementById('hdnHealthcheckup').value == "N") {

                    //alert('Selected client patient not having Health Check Up details...');
                    ValidationWindow(vpatient, AlertType);
                    return false;
                }
            }
            if (document.getElementById("ddlVisitActionName").value == "Manual_Generate_Report") {
                if (document.getElementById('ddlreplang').value == "0") {
                    ValidationWindow(vreplanguage, AlertType);
                    document.getElementById('ddlreplang').focus();
                    return false;
                }
            }
            var s = document.getElementById('hdnrolename').value;
            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                if (document.getElementById("ddlVisitActionName").value == "Dispatch_Report_InvestigationReport") {
                    var chkboxrowcount = $("#grdResult input:checkbox[id*='chkSel']:checked").size();
                    if (chkboxrowcount == 0) {
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        } else {
                            //alert("Please select the checkbox and dispatch");
                            ValidationWindow(vcheckbox, AlertType);
                            return false;
                        }
                    }

                    //                    var grid = document.getElementById('grdResult');
                    //                    var flag = 0;
                    //                    $('[id$="parentgrid"] tbody tr').each(function(i, n) {
                    //                        var $row = $(n);
                    //                        var remarksID = $row.find($('input[id$="chkSel"]')).val();
                    //                        if ($row.find($('input[id$="chkSel"]:checked'))) {
                    //                            flag = flag + 1;
                    //                        }

                    //                    });

                    //                    if (flag == 0) {
                    //                        alert("Select The check Box");
                    //                        return false;
                    //                    }
                    //                    if (document.getElementById("hdnDue").value != "0.00" && document.getElementById("hdnIsGeneralClient").value == "N") {
                    //                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_6');
                    //                        if (userMsg != null) {
                    //                            alert(userMsg);
                    //                            return false;
                    //                        } else {
                    //                            alert('Selected Patient having due amount');

                    //                            return false;
                    //                        }
                    //                    }
                    //                    if (document.getElementById("hdnclientdue").value != "0.00") {
                    //                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
                    //                        if (userMsg != null) {
                    //                            alert(userMsg);
                    //                            return false;
                    //                        } else {
                    //                            alert('Selected client patient having outstanding amount..');
                    //                            return false;
                    //                        }
                    //                    }

                    //                    if (document.getElementById("hdnDue").value != "0.00") {
                    //                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
                    //                        if (userMsg != null) {
                    //                            alert(userMsg);
                    //                            return false;
                    //                        } else {
                    //                            alert('Selected client patient having outstanding amount..');
                    //                            return false;
                    //                        }
                    //                    }

                }

            }



            if ($('#ddlVisitActionName option:selected').val() != "Dispatch_Report_InvestigationReport") {

                var chkboxrowcount1 = $("#grdResult input:radio[id*='rdSel']:checked").size();
                if (chkboxrowcount1 == 0) {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert("Select at least one record");
                        ValidationWindow(vrecord, AlertType);
                        return false;
                    }
                }

                if (chkboxrowcount1 > 1) {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert("Select only one record");
                        ValidationWindow(vrecord, AlertType);
                        return false;
                    }
                }



                else {
                    if (document.getElementById("hdnclientBlock").value == 'T') {
                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_11');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        } else {

                            //alert('Selected client was Blocked');
                            ValidationWindow(vBlocked, AlertType);
                            return false;
                        }
                    }
                    if (document.getElementById("hdnclientBlock").value == 'S') {
                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_11');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        }
                        else {
                            var IsContinue = ConfirmWindow(vSuspended, AlertType, btnok, btncancel);
                            if (IsContinue == true) {
                                return true;
                            }
                            else {
                                return false;
                            }
                            //alert('Selected Patient client was Blocked');
                            //return false;
                        }
                    }

                    if ($('#ddlVisitActionName option:selected').val() != "0") {
                        $('#hdnVisitDetail').val($('#ddlVisitActionName option:selected').text());
                        if ($('#ddlVisitActionName option:selected').val() == "Show_Report_InvestigationReport") {
                            $('#hdnHideDetails').val('1');
                        }
                        if (check == "false") {
                            check = "";
                            return false;
                        }
                        return true;
                    }
                    else {
                        var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_12');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        } else {
                            // alert('Select any one of the action to proceed');
                            ValidationWindow(vproceed, AlertType);
                            return false;
                        }
                    }
                }
            }

            var checkval = document.getElementById('hdnVID').value;






        }
        function CheckDue() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vSelectedPatient = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_18') == null ? "Selected patient having outstanding amount.." : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_18');

            var TrueFalse = "True";

            $("#divgv table tr").each(function() {
                var tr = $(this).closest("tr");
                if ($(tr).find("input:checkbox[id$=chkSel]").val() != undefined) {
                    var chk = $(tr).find("input:checkbox[id$=chkSel]").attr('checked') ? true : false;
                    if (chk == true) {
                        //debugger;
                        var PatClientID;
                        if (document.getElementById("hdnDue") != null) {
                            var hdnDue = document.getElementById("hdnDue").value;
                            if (document.getElementById("hdnClientID") != null) {
                                PatClientID = document.getElementById("hdnClientID").value;
                            }
                            if ((hdnDue != "0.00") && (hdnDue != "0") && (hdnDue != "-1")) {
                                var userMsg = "Selected patient having outstanding amount.."; //SListForApplicationMessages.Get('Investigation\\InvestigationReport_ascx_7');
                                if (userMsg != null) {
                                    alert(userMsg);
                                    TrueFalse = 'False';
                                    return false;
                                } else {
                                    //alert('Selected patient having outstanding amount..');
                                    ValidationWindow(vSelectedPatient, AlertType);
                                    TrueFalse = "False";
                                    return false;
                                }
                            }
                        }
                    }
                }
            });

            if (TrueFalse == "False") {
                return false;
            }

            $("#divgv table tr").each(function() {
                var tr = $(this).closest("tr");
                if ($(tr).find("input:radio[id$=rdSel]").val() != undefined) {
                    var chk = $(tr).find("input:radio[id$=rdSel]").attr('checked') ? true : false;
                    if (chk == true) {
                        var PatClientID;
                        if (document.getElementById("hdnDue") != null) {
                            var hdnDue = document.getElementById("hdnDue").value;
                            if (document.getElementById("hdOrgID") != null) {
                                if (document.getElementById("hdOrgID").value != null) {
                                    document.getElementById("patOrgID").value = document.getElementById("hdOrgID").value;
                                }
                                if (document.getElementById("hdnClientID") != null) {
                                    PatClientID = document.getElementById("hdnClientID").value;
                                }
                            }
                            if ((hdnDue != "0.00") && (hdnDue != "0") && (hdnDue != "-1")) {
                                var userMsg = "Selected patient having outstanding amount.."; //SListForApplicationMessages.Get('Investigation\\InvestigationReport_ascx_7');
                                if (userMsg != null) {
                                    alert(userMsg);
                                    TrueFalse = 'False';
                                    return false;
                                } else {
                                    //alert('Selected patient having outstanding amount..');
                                    ValidationWindow(vSelectedPatient, AlertType);
                                    TrueFalse = "False";
                                    return false;
                                }
                            }
                        }
                    }
                }
            });
            if (TrueFalse == "False") {
                return false;
            }
            if (document.getElementById('hdnpreviousdue').value != "") {
                var userMsg = "Selected patient having outstanding amount..";  //SListForApplicationMessages.Get('Investigation\\InvestigationReport_ascx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Selected patient having outstanding amount..');
                    ValidationWindow(vSelectedPatient, AlertType);
                    return false;
                }
            }

            if (TrueFalse == "False") {
                return false;
            }
            else {
                return true;
            }

        }

        function CheckVisitID1() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vRecord = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_14') == null ? "please select at least one record" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_14');
            var vOneRecord = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_19') == null ? "Select only one record" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_19');
            var s = document.getElementById('hdnrolename').value;
            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                var chkboxrowcount1 = $("#gvIndv input:checkbox[id*='chkSel1']:checked").size();
                if (chkboxrowcount1 == 0) {
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert("please select at least one record");
                        ValidationWindow(vRecord, AlertType);
                        return false;
                    }
                }
            }
            var TrueFalse = "True";

            //            $("#divIndv table tr").each(function() {
            //                var tr = $(this).closest("tr");
            //                if ($(tr).find("input:checkbox[id$=chkSel1]").val() != undefined) {
            //                    var chk = $(tr).find("input:checkbox[id$=chkSel1]").attr('checked') ? true : false;
            //                    if (chk == true) {
            //                        var hdnDue = $(tr).find("input:hidden[id$=hdnOutSourceDue]") ? $(tr).find("input:hidden[id$=hdnOutSourceDue]").val() : '';
            //                        if (hdnDue != "0.00") {
            //                            var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_7');
            //                            if (userMsg != null) {
            //                                alert(userMsg);
            //                                TrueFalse = 'False';
            //                                return false;
            //                            } else {
            //                                alert('Selected client patient having outstanding amount..');
            //                                TrueFalse = "False";
            //                                return false;
            //                            }
            //                        }
            //                    }
            //                }
            //            });

            //            if (TrueFalse == "False") {
            //                return false;
            //            }
            //            else {
            //                return true;
            //            }

            var chkboxrowcount1 = $("#gvIndv input:checkbox[id*='chkSel1']:checked").size();
            if (chkboxrowcount1 == 0) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Select at least one record");
                    ValidationWindow(vRecord, AlertType);
                    return false;
                }
            }

            if (chkboxrowcount1 > 1) {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_5');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Select only one record");
                    ValidationWindow(vOneRecord, AlertType);
                    return false;
                }
            }
        }




        function ChechVisitDate() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vProvideDate = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_20') == null ? "Provide visit date" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_20');

            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value != '' || document.getElementById('txtTo').value != '') {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_14');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Provide visit date');
                    ValidationWindow(vProvideDate, AlertType);
                    return false;

                }
                document.form1.txtFrom.focus();
            }
            return true;
        }

        function ChechVisit() {

            //            if (document.getElementById('txtPatientNo').value == '') {
            //                alert('Please Enter Patient No');
            //                document.form1.txtPatientNo.focus();
            //                return false;
            //            }

            //            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value == '' && document.getElementById('txtTo').value == '') {

            //                alert('Please Enter Atlease One Search option');
            //                document.form1.txtPatientNo.focus();
            //                return false;
            //            }
            return true;

        }
        function ShowReportDiv() {

            // alert(document.getElementById('dReport'));
            document.getElementById('dReport').style.display = 'block';
            return false;
        }
        function HideDiv() {
            document.getElementById('dReport').style.display = 'none';
            document.getElementById('imgClick').style.display = 'block';
            document.getElementById('lblHead').style.display = 'block';
            return true;
        }

        function ChkIfSelected(obj) {
            // alert(obj);
            if (document.getElementById(obj).checked) {
                document.getElementById('ChkID').value = obj + '^';
            }
            else {
                //alert('else');
                var chkSelectAllDynamicID = obj.substring(0, 19);
                document.getElementById(chkSelectAllDynamicID + '_chkSelectAll').checked = false;
                var x = document.getElementById('ChkID').value.split('^');
                document.getElementById('ChkID').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != '') {
                        if (x[i] != obj) {
                            document.getElementById('ChkID').value = x[i] + '^';
                        }
                    }

                }
            }
        }
        function IsSelected() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vInvestigation = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_21') == null ? "Select an investigation to display  report" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_21');
            if (document.getElementById('ChkID').value != '') {
                HideDiv();
                return true;
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_15');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Select an investigation to display  report');
                    ValidationWindow(vInvestigation, AlertType);
                    return false;

                }
            }
        }
        function launchSessionUrl(launchurl) {
            //alert('hello : ' + launchurl);
//            window.location.href = launchurl;
            window.open(launchurl);

        }
        function SelectAll(IsChecked) {
            var chkArrayMain = new Array();
            var UniqTemplateChkId = IsChecked.substring(0, 19);
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            if (document.getElementById(IsChecked).checked) {

                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        if (document.getElementById(chkArrayMain[i]).disabled == false) {
                            document.getElementById(chkArrayMain[i]).checked = true;
                        }
                    }
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        document.getElementById(chkArrayMain[i]).checked = false;
                    }
                }
            }

        }
        function HdnChkPerStatus(chkID) {
            if ($('#hdnchkApproveOly').val() == 'Y') {
                document.getElementById('lnkshwrpt').style.display = 'none';
                var chkboxwanttoCheck = [];
                if (chkID != "") {
                    chkboxwanttoCheck = chkID.split('~');
                    if (chkboxwanttoCheck.length > 0) {
                        $.each(chkboxwanttoCheck, function(i, l) {
                            document.getElementById(l).disabled = true;
                        });
                    }
                }
            }
        }
        function EnableAll(IsChecked) {
            var chkArrayMain = new Array();
            var chkArraydisable = new Array();
            var UniqTemplateChkId = IsChecked.substring(0, 19);
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            chkArraydisable = document.getElementById('Hdndisablebox').value.split('~');
            if (document.getElementById(IsChecked).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    var Status = $('#' + chkArrayMain[i]).closest('td').next('td').find('span[data="lblstatus"]').html();
                    if ($('#hdnrolename').val() == "Client" && Status == "Approve" && UniqTemplateChkId == chkArrayMain[i].substring(0, 19) && $('#hdnchkApproveOly').val() == 'Y') {
                        document.getElementById(chkArrayMain[i]).checked = true;
                    }
                    else {
                        if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19) && $('#hdnrolename').val() != "Client") {
                            document.getElementById(chkArrayMain[i]).disabled = false;
                            document.getElementById(chkArrayMain[i]).checked = true;
                        }
                    }
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    var Status = $('#' + chkArrayMain[i]).closest('td').next('td').find('span[data="lblstatus"]').html();
                    if ($('#hdnrolename').val() == "Client" && Status == "Approve" && UniqTemplateChkId == chkArrayMain[i].substring(0, 19) && $('#hdnchkApproveOly').val() == 'Y') {
                        document.getElementById(chkArrayMain[i]).checked = false;
                    }
                    else {
                        if ($('#hdnrolename').val() != "Client" && $('#hdnchkApproveOly').val() == 'Y') {

                            //if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                            document.getElementById(chkArrayMain[i]).disabled = false;
                            document.getElementById(chkArrayMain[i]).checked = false;
                        }
                        else {
                            if ($('#hdnchkApproveOly').val() != 'Y') {
                                document.getElementById(chkArrayMain[i]).checked = false;
                                if (chkArraydisable[i] > 0) {
                                    document.getElementById(chkArrayMain[i]).disabled = true;
                                }
                            }
                        }

                        //  }
                    }
                }
            }

        }
        function showReports(id) {
            var Obj = document.getElementById('chkDept');
            var chkArrayMain = document.getElementById('hdndeptid').value.split('^');
            if (document.getElementById('hdndeptid').value != "") {
                for (var count = 0; count < chkArrayMain.length; count++) {
                    var SpecList = chkArrayMain[count].split('~');
                    if (SpecList[0] != '' && SpecList[1] != "0") {
                        if (id == SpecList[1]) {
                            var Status = $('#' + SpecList[0]).closest('td').next('td').find('span[data="lblstatus"]').html();
                            if ($('#hdnrolename').val() == "Client" && Status != "Approve" && $('#hdnchkApproveOly').val() == 'Y') {

                            }
                            else {
                                document.getElementById(SpecList[0]).checked = true;
                            }

                        }


                    }



                }
            }
        }
        function dispTask(id) {



            var lists = "";
            var SpecList = "";
            var cboxObj = document.getElementById(id);
            var cboxList = cboxObj.getElementsByTagName('input');
            var lbList = cboxObj.getElementsByTagName('label');

            if (document.getElementById('hdndeptid').value != "") {
                var chkArrayMain = document.getElementById('hdndeptid').value.split('^');

                for (var count = 0; count < chkArrayMain.length; count++) {
                    SpecList = chkArrayMain[count].split('~');
                    if (SpecList[0] != '' && SpecList[1] != "0") {
                        //                         var chkid= SpecList[0];
                        document.getElementById(SpecList[0]).checked = false;




                    }



                }
            }

            for (var i = 0; i < cboxList.length; i++) {


                if (cboxList[i].checked) {
                    var s = document.getElementById('hdndeptvalues').value.split('^');
                    for (var count = 0; count < s.length; count++) {
                        var SpecLists = s[count].split('~');
                        if (lbList[i].innerHTML == SpecLists[1]) {


                            showReports(SpecLists[0]);

                        }
                    }
                }



            }
            //            document.getElementById('hdndeptid').value = "";

        }

        function showfalse(id) {




            var Obj = document.getElementById('chkDept');
            var chkArrayMain = document.getElementById('hdndeptid').value.split('^');
            if (document.getElementById('hdndeptid').value != "") {
                for (var count = 0; count < chkArrayMain.length; count++) {
                    var SpecList = chkArrayMain[count].split('~');
                    if (SpecList[0] != '' && SpecList[1] != "0") {
                        if (id == SpecList[1]) {
                            document.getElementById(SpecList[0]).checked = false;
                        }

                    }



                }
            }
        }

        function ValidateCheckBox() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vInvestigation = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_22') == null ? "Select an investigation" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_22');

            var chkArrayMain = new Array();
            var count = 0;
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            for (var i = 0; i < chkArrayMain.length; i++) {
                if (document.getElementById(chkArrayMain[i]).checked == true) {
                    count++;
                }
            }
            if (count > 0)
            { return true; } else {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_16');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Select an investigation');\
                    ValidationWindow(vInvestigation, AlertType);
                    return false;
                }

            }

        }



        function launchexe(ExeName, Path) {
            //            alert('a');
            //            var cmdline1 = "notepad.exe \"c:\\1.txt\"";
            //           var cmdline2 = "taskmgr.exe";
            //            document.apltLaunchExe.launch(cmdline1);
            document.apltLaunchExe.launch(cmdline2);
        }

        function launchexe_mv(patid, studyid, modality, imageserveripaddress, portnumber, loggedinusername) {
            //            alert('ts');
            var exename = 'launch_viewer_mv.exe';
            var args = patid + ' ' + studyid + ' ' + modality + ' ' + imageserveripaddress + ' ' + portnumber + ' ' + loggedinusername;
            var cmdline = exename + ' ' + args;
            document.apltLaunchExe.launch(cmdline);
            //            alert('ts1');
            return false;
            //            alert('ts');
        }


        function popupprint() {
            var prtContent = document.getElementById('printANCCS');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=1024,height=768');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            // WinPrint.close();
        }



        function pdfPrint() {
            document.getElementById("hdnPDFType").value = 'prtpdf';
            //            var prtContent = document.getElementById('Divpdf');
            //            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=1000,height=500');
            //            //alert(WinPrint);
            //            WinPrint.document.write(prtContent.innerHTML);
            //            WinPrint.document.close();
            //            WinPrint.focus();
            //            WinPrint.print();

        }
        function PriorityValidation() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vGenerated = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_23') == null ? "Already generated the priority report for this visit" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_23');
            if (document.getElementById("hdnPriority").value == '1') {
                ValidationWindow(vGenerated, AlertType);
                //alert('Already generated the priority report for this visit');
                return false;
            }
            //            if (document.getElementById("hdnPriority").value == '-1') {
            //                alert('Unable to set the priority for Dispatched Report');
            //                return false;
            //            }
        }


        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";

            document.getElementById('hdnTempFrom').value = "";
            document.getElementById('hdnTempTo').value = "";

            document.getElementById('hdnTempFromPeriod').value = "0";
            document.getElementById('hdnTempToPeriod').value = "0";
            if (document.getElementById('ddlRegisterDate').value == "0") {

                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayMonth').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "2") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayYear').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';

            }
            if (document.getElementById('ddlRegisterDate').value == "3") {
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'block';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

            }
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }
            if (document.getElementById('ddlRegisterDate').value == "4") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('txtFromPeriod').value = "";
                document.getElementById('txtToPeriod').value = "";

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';


            }

            if (document.getElementById('ddlRegisterDate').value == "5") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "6") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastMonthLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddlRegisterDate').value == "7") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastYearLast').value;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'block';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
        }
        function ShowAppDate() {
            document.getElementById('txtApFromDate').value = "";
            document.getElementById('txtApToDate').value = "";

            document.getElementById('hdnTempFrom1').value = "";
            document.getElementById('hdnTempTo1').value = "";

            document.getElementById('hdnTempFromPeriod1').value = "0";
            document.getElementById('hdnTempToPeriod1').value = "0";
            if (document.getElementById('ddl_Approvedate').value == "0") {

                document.getElementById('txtApFromDate').value = document.getElementById('hdnFirstDayWeek1').value;
                document.getElementById('txtApToDate').value = document.getElementById('hdnLastDayWeek1').value;

                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;
                document.getElementById('hdnTempFrom1').value = document.getElementById('hdnFirstDayWeek1').value;
                document.getElementById('hdnTempTo1').value = document.getElementById('hdnLastDayWeek1').value;

                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddl_Approvedate').value == "1") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;
                document.getElementById('txtApFromDate').value = document.getElementById('hdnFirstDayMonth1').value;
                document.getElementById('txtApToDate').value = document.getElementById('hdnLastDayMonth1').value;
                document.getElementById('hdnTempFrom1').value = document.getElementById('hdnFirstDayMonth1').value;
                document.getElementById('hdnTempTo1').value = document.getElementById('hdnLastDayMonth1').value;

                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddl_Approvedate').value == "2") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;
                document.getElementById('txtApFromDate').value = document.getElementById('hdnFirstDayYear1').value;
                document.getElementById('txtApToDate').value = document.getElementById('hdnLastDayYear1').value;
                document.getElementById('hdnTempFrom1').value = document.getElementById('hdnFirstDayYear1').value;
                document.getElementById('hdnTempTo1').value = document.getElementById('hdnLastDayYear1').value

                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';

            }
            if (document.getElementById('ddl_Approvedate').value == "3") {
                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'block';
                document.getElementById('divAppCustomDate').style.display = 'block';
                document.getElementById('divAppCustomDate').style.display = 'inline';
                document.getElementById('divAppCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod1').value = "1";
                document.getElementById('hdnTempToPeriod1').value = "1";

            }
            if (document.getElementById('ddl_Approvedate').value == "-1") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;

                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';


            }
            if (document.getElementById('ddl_Approvedate').value == "4") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;

                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';


            }

            if (document.getElementById('ddl_Approvedate').value == "5") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;
                document.getElementById('txtApFromDate').value = document.getElementById('hdnLastWeekFirst1').value;
                document.getElementById('txtApToDate').value = document.getElementById('hdnLastWeekLast1').value;
                document.getElementById('hdnTempFrom1').value = document.getElementById('hdnLastWeekFirst1').value;
                document.getElementById('hdnTempTo1').value = document.getElementById('hdnLastWeekLast1').value;

                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddl_Approvedate').value == "6") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;
                document.getElementById('txtApFromDate').value = document.getElementById('hdnLastMonthFirst1').value;
                document.getElementById('txtApToDate').value = document.getElementById('hdnLastMonthLast1').value;
                document.getElementById('hdnTempFrom1').value = document.getElementById('hdnLastMonthFirst1').value;
                document.getElementById('hdnTempTo1').value = document.getElementById('hdnLastMonthLast1').value;

                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddl_Approvedate').value == "7") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;
                document.getElementById('txtApFromDate').value = document.getElementById('hdnLastYearFirst1').value;
                document.getElementById('txtApToDate').value = document.getElementById('hdnLastYearLast1').value;
                document.getElementById('hdnTempFrom1').value = document.getElementById('hdnLastYearFirst1').value;
                document.getElementById('hdnTempTo1').value = document.getElementById('hdnLastYearLast1').value;

                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'block';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppDate').style.display = 'inline';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
            }
        }
        function onPrintReport(VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vPatientAmt = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_24') == null ? "This Patient having due amount" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_24');
            try {
                if (document.getElementById("hdnDue").value != "0.00" && document.getElementById("hdnDue").value != "0") {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_6');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                        //alert('This Patient having due amount');
                        ValidationWindow(vPatientAmt, AlertType);
                        return false;
                    }
                } else {

                    //return onPrintPolicy('single', 0, 0, 0);
                    return onPrintPolicy('single', VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow);

                }
            }
            catch (e) {
                return false;
            }
        }
        function onPrintSingleReport() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vUnable = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_25') == null ? "Unable to print report" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_25');
            var reportViewer = $find("rReportViewer");
            if (reportViewer != null) {
                var disablePrint = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;
                if (!disablePrint) {
                    reportViewer.invokePrintDialog();
                    return true;

                }
                else
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_17');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Unable to print report");
                    ValidationWindow(vUnable, AlertType);
                    return false;
                }
            }
            return false;
        }
        function PopupClose() {
            document.getElementById('hdnShowReport').value = 'false';
        }
        function CheckMailAddress() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vEmailAddress = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_26') == null ? "Provide a valid email address" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_26');
            var vEmail = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_27') == null ? "Provide a email address." : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_27');
            var txtMailAddress = $('#txtMailAddress');
            var mailAddresses = txtMailAddress.val().replace(' ', '');
            if (mailAddresses.length > 0) {
                var address = mailAddresses.split(',');
                var filter = /^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$/m;
                var isValid = true;
                for (var i = 0; i < address.length; i++) {
                    if (!filter.test(address[i])) {
                        isValid = false;
                    }
                }
                if (!isValid) {
                    var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_18');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {

                        //alert('Provide a valid email address.');
                        ValidationWindow(vEmailAddress, AlertType);
                        return false;
                    }
                    txtMailAddress.focus();

                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_19');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert("Provide a email address.");
                    ValidationWindow(vEmail, AlertType);
                    return false;
                }
                txtMailAddress.focus();
                return false;
            }
        }
        function SelectedPatient(source, eventArgs) {
            var isPatientDetails = "";
            isPatientDetails = eventArgs.get_value();
            //var PatientName = eventArgs.get_text().split(':')[0];
            var PatientName = eventArgs.get_text().split('(')[0];
            document.getElementById('txtName').value = PatientName;
        }
        function SelectedClientValue(source, eventArgs) {
            var Name = eventArgs.get_text();
            var ID = eventArgs.get_value();
            document.getElementById('hdnClientID').value = eventArgs.get_value().split('|')[0];
            if (Number(eventArgs.get_value().split('~')[1]) > 0) {
                document.getElementById('tdprevdue').style.display = 'block';
                document.getElementById('hdnpreviousdue').value = eventArgs.get_value().split('~')[1];
                document.getElementById('lblpreviousdue').value = eventArgs.get_value().split('~')[1];
            }
        }
        function GetReferingPhysicianID(source, eventArgs) {
            document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
            document.getElementById('hdnPhysicianValue').value = eventArgs.get_value();
        }
        function GetReferingOrgID(source, eventArgs) {
            document.getElementById('txtReferringHospital').value = eventArgs.get_text();
            var refHospID = eventArgs.get_value();
            document.getElementById('hdfReferalHospitalID').value = refHospID;
        }
        function SelectedTest(source, eventArgs) {
            document.getElementById('txtTestName').value = eventArgs.get_text();
            TestDetails = eventArgs.get_value();
            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('hdnTestID').value = TestID;
            document.getElementById('hdnTestType').value = TestType;
        }
        function Onzoneselected(source, eventArgs) {
            document.getElementById('txtzone').value = eventArgs.get_text();
            document.getElementById('hdntxtzoneID').value = eventArgs.get_value();
        }

        function ClearFields() {
            if (document.getElementById('txtClientName').value.trim() == "") {
                document.getElementById('hdnClientID').value = "";
            }
            if (document.getElementById('txtInternalExternalPhysician').value.trim() == "") {
                document.getElementById('hdnPhysicianValue').value = "0";
            }
            if (document.getElementById('txtReferringHospital').value.trim() == "") {
                document.getElementById('hdfReferalHospitalID').value = "0";
            }
            if (document.getElementById('txtTestName').value.trim() == "") {
                document.getElementById('hdnTestID').value = "0";
                document.getElementById('hdnTestType').value = "";
            }
            if (document.getElementById('txtzone').value.trim() == "") {
                document.getElementById('hdntxtzoneID').value = "0";
            }
            if (document.getElementById('txtPersonName').value.trim() == "") {
                document.getElementById('hdnEmpID').value = "0";
            }
        }
        function ClearSearchFields() {
            document.getElementById('txtVisitNo').value = "";
            document.getElementById('txtName').value = "";
            document.getElementById('txtMobile').value = "";
            document.getElementById('txtClientName').value = "";
            document.getElementById('txtInternalExternalPhysician').value = "";
            document.getElementById('ddlocation').value = "-1";
            document.getElementById('drpdepartment').value = "0";
            document.getElementById('txtTestName').value = "";
            document.getElementById('hdnTestID').value = "0";
            document.getElementById('txtzone').value = "";
            document.getElementById('hdntxtzoneID').value = "0";
            document.getElementById('ddstatus').value = "--Select--";
            document.getElementById('ddlRegisterDate').value = "--Select--";
            document.getElementById('ddl_Approvedate').value = "--Select--"; 
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
                document.getElementById('divRegCustomDate').style.display = 'none';
            }
            if (document.getElementById('ddl_Approvedate').value == "-1") {
                document.getElementById('txtApFromDate').disabled = true;
                document.getElementById('txtApToDate').disabled = true;

                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
                document.getElementById('divAppCustomDate').style.display = 'none';
            }
            document.getElementById('txtLabNo').value = "";
            document.getElementById('ddVisitType').value = "-1";
            document.getElementById('drplstPerson').value = "";
            document.getElementById('drpPriority').value = "0";
            document.getElementById('txtWardName').value = "";
            document.getElementById('chkDespatchMode').value = "";
            document.getElementById('ddlPriority').value = "";
            document.getElementById('txtReferringHospital').value = "";
            document.getElementById('hdfReferalHospitalID').value = "0";
            document.getElementById('txtPatientNo').value = "";
            //window.location.assign("../Investigation/InvestigationReport.aspx?IsPopup=Y");
            return false;
        }
        function GetEmpID(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtPersonName').value = eventArgs.get_text();
            document.getElementById('hdnEmpID').value = strVal.split('~')[0].trim();
        }
        function SetContextKey() {
            var deptName = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].text;
            var deptID = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].value;
            if (deptName == 'COURIER') {
                $find('AutoCompleteExtender3').set_contextKey(deptID);
            }
            return;
        }
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

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 45) || (key == 46) || (key == 95) || (key == 37) || (key == 36)) {
                isCtrl = true;
            }

            return isCtrl;
        }
        function validateonoroff() {
            document.getElementById('hdnonoroff').value = "N";
        }
        function checkForValues() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vPage = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_28') == null ? "Provide page number" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_28');
            var vCorrectPage = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_29') == null ? "Provide correct page number" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_29');

            if (document.getElementById('txtpageNo').value == "") {
                //alert('Provide page number');
                ValidationWindow(vPage, AlertType);
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPage, AlertType);
                return false;
            }
            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPage, AlertType);
                return false;
            }
            return true;
        }

        function SelectAllTest(sender) {

            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('hdndespatchClientId').value.split('~');
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                    //                    col_num = document.getElementById("rdSel").value;
                    //                    rows = document.getElementById("grdResult").rows;
                    //                    for(var j = 0; j < rows.count; j++) 
                    //                    {
                    //                    rows[i].cells[col_num].disable=true ;
                    //                    }
                }
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                    //                    col_num = document.getElementById("rdSel").value;
                    //                    rows = document.getElementById("grdResult").rows;
                    //                    for (var j = 0; j < rows.count; j++) {
                    //                        rows[i].cells[col_num].disable = false;
                    //                    }
                }
            }
        }
       
    </script>

</head>
<body id="oneColLayout">
    <form id="form1" runat="server" defaultbutton="btnSearch">

    <script type="text/jscript">

        function ShowPopUp(visitnumber) {
            var visitnovalue = visitnumber.innerText;
            //var ReturnValue = window.showModalDialog("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "dialogWidth=1000px;dialogHeight=750px;scroll:yes; status:yes;")
            var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnovalue, "", "height=800,width=1000,scrollbars=Yes");
        }

        jQuery(function($) {
            //debugger;
            var allCkBoxSelector = 'input[id*="chkAll"]:checkbox';
            var checkBoxSelector = '#<%=grdResult.ClientID%> input[id*="chkSel"]:checkbox';
            function ToggleCheckUncheckAllOptionAsNeeded() {
                var totalCkboxes = $(checkBoxSelector),
                    checkedCheckboxes = totalCkboxes.filter(":checked"),
                    noCheckboxesAreChecked = (checkedCheckboxes.length == 0),
                    allCkboxesAreChecked = (totalCkboxes.length == checkedCheckboxes.length);
                $(allCkBoxSelector).attr('checked', allCkboxesAreChecked);
            }

            $(allCkBoxSelector).live('click', function() {
                $(checkBoxSelector).attr('checked', $(this).is(':checked'));
                ToggleCheckUncheckAllOptionAsNeeded();
                var totalCkboxes = $(checkBoxSelector);
                $(totalCkboxes).each(function(i) {
                    if (this.disabled == false) {

                    } else {
                        $(this).attr('checked', false);
                    }
                });
            });
            $(checkBoxSelector).live('click', ToggleCheckUncheckAllOptionAsNeeded);
            ToggleCheckUncheckAllOptionAsNeeded();
        });



        function showsearch() {
            document.getElementById('trhide1').style.display = 'table-row';
            document.getElementById('trhide2').style.display = 'table-row';
            document.getElementById('trhide3').style.display = 'table-row';
            document.getElementById('Div5').style.display = 'none';
            document.getElementById('Div6').style.display = 'block';

        }
        function Hidesearch() {
            document.getElementById('trhide1').style.display = 'none';
            document.getElementById('trhide2').style.display = 'none';
            document.getElementById('trhide3').style.display = 'none';
            document.getElementById('Div5').style.display = 'block';
            document.getElementById('Div6').style.display = 'none';

        }
         function RedirectToReport(ctrl) {
            var url = $(ctrl).attr('ReportUrl');
            if (url == null || url == "") {
                window.open(url, '_blank');
            }
            else
                ValidationWindow("No Image Available", "Alert");
            return false;
        }





    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" id="contentdata">
        <%-- <div class="contentdata">--%>
        <table class="w-100p">
            <tr id="tdCustomerQueue" runat="server">
                <td class="w-100p a-right">
                    <asp:UpdatePanel ID="up1" runat="server">
                        <ContentTemplate>
                            <uc12:AbbrentQueu ID="abberent" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr id="tdAberrant" runat="server">
                <td class="w-100p a-left">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <uc11:DespatchQ ID="DespatchQueue" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <table id="tblPatient" runat="server" class="w-100p">
            <tr>
                <td>
                    <asp:Panel ID="Panel3" CssClass="w-100p" DefaultButton="btnSearch" BorderWidth="0px"
                        runat="server" meta:resourcekey="Panel3Resource1">
                        <div style="display: block;" class="dataheader2 w-100p">
                            <table class="w-100p searchPanel">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblVisitNo" Text="Visit No" runat="server" meta:resourcekey="lblVisitNoaResource1"></asp:Label>
                                    </td>
                                    <td class="a-left">
                                        <asp:TextBox ID="txtVisitNo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtVisitNoResource1"></asp:TextBox>
                                    </td>
                                    <td class="w-15p">
                                        <asp:Label ID="lblName" Text="Patient Name" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                    </td>
                                    <td class="w-15p">
                                        <asp:TextBox ID="txtName" CssClass="Txtboxsmall" OnChange="javascript:GetText(document.getElementById('txtName').value);"
                                            runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                        <div id="DivPatientName">
                                        </div>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtName"
                                            FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            MinimumPrefixLength="1" ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                                            DelimiterCharacters="" Enabled="True" CompletionListElementID="DivPatientName"
                                            OnClientShown="setAceWidth" OnClientItemSelected="SelectedPatient">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                    <td class="w-15p">
                                        <asp:Label ID="lblMobile" Text="Contact No" runat="server" meta:resourcekey="lblconResource1"></asp:Label>
                                    </td>
                                    <td class="w-15p">
                                        <asp:TextBox ID="txtMobile" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trClient" style="display: table-row" runat="server">
                                    <td>
                                        <asp:Label ID="lblclient" Text="Client" runat="server" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtClientName" runat="server" onBlur="return ClearFields();"
                                            meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                        <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
                                        <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
                                        <div id="aceClient">
                                        </div>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                            BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                            ServiceMethod="GetClientList" OnClientItemSelected="SelectedClientValue" ServicePath="~/WebService.asmx"
                                            DelimiterCharacters="" Enabled="True" CompletionListElementID="aceClient" OnClientShown="setAceWidth">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblReferringPhysician" Text="Ref.Dr" runat="server" meta:resourcekey="lblReferPhysicianResource1"></asp:Label>
                                    </td>
                                    <td class="a-left">
                                        <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="Txtboxsmall"
                                            onBlur="return ClearFields();" meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                                        <div id="aceReferDR">
                                        </div>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" TargetControlID="txtInternalExternalPhysician"
                                            EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                            ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="GetReferingPhysicianID"
                                            DelimiterCharacters="" Enabled="True" CompletionListElementID="aceReferDR" OnClientShown="setAceWidth">
                                        </cc1:AutoCompleteExtender>
                                        <asp:HiddenField ID="hdnPhysicianValue" Value="0" runat="server"></asp:HiddenField>
                                        <asp:HiddenField ID="hdnClientPortal" runat="server" />
                                        <asp:HiddenField ID="hdnLocationClient" runat="server" />
                                   <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
                                        <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblddlocation" Text="Reg.Location" runat="server" meta:resourcekey="lblddreglocationResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <span class="richcombobox" style="width: 155px;">
                                            <asp:DropDownList ID="ddlocation" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddlocationResource2">
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                </tr>
                                <tr id="trDepartment" runat="server">
                                    <td>
                                        <asp:Label ID="Label10" Text="Department" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <span class="richcombobox" style="width: 155px;">
                                            <asp:DropDownList ID="drpdepartment" CssClass="ddl" Width="155px" runat="server"
                                                meta:resourcekey="drpdepartmentResource1">
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTestName" Text="Test Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                    </td>
                                    <td class="a-left">
                                        <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                            meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                        <div id="aceDiv">
                                        </div>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtenderTestName" MinimumPrefixLength="2"
                                            runat="server" TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg"
                                            ServicePath="~/WebService.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11"
                                            CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain1"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                            OnClientItemSelected="SelectedTest" DelimiterCharacters="" CompletionListElementID="aceDiv"
                                            OnClientShown="setAceWidth">
                                        </cc1:AutoCompleteExtender>
                                        <asp:HiddenField ID="hdnTestID" Value="0" runat="server"></asp:HiddenField>
                                        <asp:HiddenField ID="hdnTestType" runat="server"></asp:HiddenField>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label7" Text="Zone" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtzone" runat="server" CssClass="Txtboxsmall" AutoComplete="off"
                                              OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onBlur="return ClearFields();"
                                            meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                        <div id="Divzone">
                                        </div>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                            OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                            Enabled="True" CompletionListElementID="Divzone" OnClientShown="setAceWidth">
                                        </cc1:AutoCompleteExtender>
                                        <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblStatus" Text="Status" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <span class="richcombobox" style="width: 155px;">
                                            <asp:DropDownList ID="ddstatus" runat="server" CssClass="ddl" Width="155px" meta:resourcekey="ddstatusResource1">
                                               <%-- <asp:ListItem Text="---Select---" Value="---Select---" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                                <%--<asp:ListItem Text="Non Printed" Value="Non Printed" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                <asp:ListItem Text="Printed" Value="Printed" meta:resourcekey="ListItemResource6"></asp:ListItem>--%>
                                                <%--<asp:ListItem Text="Pending" Value="Pending" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                    <td class="v-top">
                                        <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Registered Date" meta:resourcekey="Rs_RegisteredDateResource1"></asp:Label>
                                        <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                                        <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                                        <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                                        <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                                        <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                                        <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                                        <asp:HiddenField ID="hdnDateImage" runat="server" />
                                        <asp:HiddenField ID="hdnTempFrom" runat="server" />
                                        <asp:HiddenField ID="hdnTempTo" runat="server" />
                                        <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                        <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                        <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                                        <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                                        <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                                        <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                                        <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                                        <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                                        <asp:HiddenField ID="hdnActionCount" runat="server" />
                                        <asp:HiddenField runat="server" ID="hdnloginRoleName" />
                                    </td>
                                    <td>
                                        <span class="richcombobox" style="width: 155px;">
                                            <asp:DropDownList ID="ddlRegisterDate" CssClass="ddl" Width="155px" onChange="javascript:return ShowRegDate();"
                                                runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                            </asp:DropDownList>
                                        </span>
                                        <div id="divRegDate" style="display: none" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divRegCustomDate" runat="server" style="display: none;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td class="v-top" id="tdapprovetext" style="display: none;" runat="server">
                                        <asp:Label ID="Ap_ApprovedData" runat="server" Text="Approved Date" ></asp:Label>
                                         <asp:HiddenField ID="hdnFirstDayWeek1" runat="server" />
                                        <asp:HiddenField ID="hdnLastDayWeek1" runat="server" />
                                        <asp:HiddenField ID="hdnFirstDayMonth1" runat="server" />
                                        <asp:HiddenField ID="hdnLastDayMonth1" runat="server" />
                                        <asp:HiddenField ID="hdnFirstDayYear1" runat="server" />
                                        <asp:HiddenField ID="hdnLastDayYear1" runat="server" />
                                        <asp:HiddenField ID="hdnDateImage1" runat="server" />
                                        <asp:HiddenField ID="hdnTempFrom1" runat="server" />
                                        <asp:HiddenField ID="hdnTempTo1" runat="server" />
                                        <asp:HiddenField ID="hdnTempFromPeriod1" runat="server" />
                                        <asp:HiddenField ID="hdnTempToPeriod1" runat="server" />
                                        <asp:HiddenField ID="hdnLastMonthFirst1" runat="server" />
                                        <asp:HiddenField ID="hdnLastMonthLast1" runat="server" />
                                        <asp:HiddenField ID="hdnLastWeekFirst1" runat="server" />
                                        <asp:HiddenField ID="hdnLastWeekLast1" runat="server" />
                                        <asp:HiddenField runat="server" ID="hdnLastYearFirst1" />
                                        <asp:HiddenField ID="hdnLastYearLast1" runat="server" />
                                        <asp:HiddenField ID="hdnActionCount1" runat="server" />
                                        <asp:HiddenField runat="server" ID="hdnloginRoleName1" />
                                        </td>
                                        <td id="tdlblsrfid" runat="server" style="display:none;">
                                        <asp:Label ID="lblsrfid" runat="server" Text="SRFID"></asp:Label>
                                        <asp:HiddenField ID="hdnissrfidsearch" runat="server" Value="N" />
                                        </td>
                                        <td id="tdtxtsrfid" runat="server" style="display:none;">
                                        <asp:TextBox ID="txtsrfid" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                        </td>
                                         <td>
                                        <table id="tdapprovedateload" runat="server" style="display: none;">
                                         <tr>
                                         <td>
                                         <span class="richcombobox" style="width: 155px;">
                                            <asp:DropDownList ID="ddl_Approvedate" CssClass="ddl" Width="155px" onChange="javascript:return ShowAppDate();"
                                                runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                            </asp:DropDownList>
                                        </span>
                                      <div id="divAppDate" style="display: none" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Ap_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" ID="txtApFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Ap_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtApToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divAppCustomDate" runat="server" style="display: none;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Ap_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" ID="txtApFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcFrom1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender51" runat="server" TargetControlID="txtApFromPeriod"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Right" AcceptNegative="Right" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator51" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtApFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        <cc1:CalendarExtender ID="CalendarExtender11" runat="server" TargetControlID="txtApFromPeriod"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom1" Enabled="True" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Ap_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="w-70" runat="server" ID="txtApToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcTo1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender11" runat="server" TargetControlID="txtApToPeriod"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Right" AcceptNegative="Right" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator11" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtApToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        <cc1:CalendarExtender ID="CalendarExtender21" runat="server" TargetControlID="txtApToPeriod"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo1" Enabled="True" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        
                                         </td>
                                        </tr>
                                        </table>
                                        </td>
                                </tr>
                                <tr id="trhide1" runat="server">
                                    <td class="w-15p">
                                        <asp:Label runat="server" ID="lblPatientNo" Text="Patient No" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                    </td>
                                    <td class="w15p">
                                        <asp:TextBox ID="txtPatientNo" onKeyPress="onEnterKeyPress(event);" MaxLength="16"
                                            runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                                    </td>
                                    <td id="tdlblLabNo" runat="server">
                                        <asp:Label ID="lblLabNo" Text="Lab No" runat="server" meta:resourcekey="lblLabNoResource1"></asp:Label>
                                    </td>
                                    <td id="tdtxtLabNo" runat="server">
                                        <asp:TextBox ID="txtLabNo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtLabNoResource1"></asp:TextBox>
                                    </td>
                                    <td id="tdlblddVisittype" runat="server">
                                        <asp:Label ID="lblddVisittype" Text="Visit Type" runat="server" meta:resourcekey="lblddVisittypeResource1"></asp:Label>
                                    </td>
                                    <td id="tdrichcombobox" runat="server">
                                        <span class="richcombobox" style="width: 155px;">
                                            <asp:DropDownList ID="ddVisitType" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddVisitTypeResource1">
                                               <%-- <asp:ListItem Text="---Select---" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                <asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                </tr>
                                <tr id="trhide2" runat="server">
                                    <td style="display: none">
                                        <asp:Label ID="lblContactType" Text="Courier Person" runat="server" meta:resourcekey="lblContactTypeResource1"></asp:Label>
                                    </td>
                                    <td id="tdCourier" runat="server" style="display: none">
                                        <span class="richcombobox" style="width: 55px; display: none;">
                                            <asp:DropDownList runat="server" ID="drplstPerson" CssClass="ddl" Width="55px" meta:resourcekey="drplstPersonResource1">
                                            </asp:DropDownList>
                                        </span>
                                        <asp:TextBox ID="txtPersonName" runat="server" CssClass="Txtboxsmall" AutoComplete="off"
                                            onBlur="return ClearFields();" meta:resourcekey="txtPersonNameResource1"></asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtPersonName"
                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                            OnClientItemSelected="GetEmpID" ServicePath="~/WebService.asmx" UseContextKey="True"
                                            DelimiterCharacters="" Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                        <input type="hidden" id="hdnEmpID" value="0" runat="server" />
                                    </td>
                                    <td style="display: none">
                                        <asp:Label ID="Label21" Text="Priority Type" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                    </td>
                                    <td style="display: none">
                                        <span class="richcombobox" style="width: 155px;">
                                            <asp:DropDownList ID="drpPriority" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="drpPriorityResource1">
                                                <%--<asp:ListItem Value="0" Text="--Select--" Selected="True" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="Normal" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                <asp:ListItem Text="Emergency" Value="2" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                <asp:ListItem Text="VIP" Value="3" meta:resourcekey="ListItemResource11"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                    <td style="display: none">
                                        <asp:Label ID="lblwardName" Text="Ward Name" runat="server" meta:resourcekey="lblwardNameResource1"></asp:Label>
                                    </td>
                                    <td style="display: none">
                                        <asp:TextBox ID="txtWardName" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtWardNameResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="display: none">
                                        <asp:Label ID="lblDespatchType" runat="server" Text="Dispatch Type" meta:resourcekey="lblDespatchTypeResource1"></asp:Label>
                                    </td>
                                    <td style="display: none">
                                        <asp:Panel ID="panelDispatchType" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="True"
                                            meta:resourcekey="panelDispatchTypeResource1">
                                            <asp:CheckBoxList ID="chkDisPatchType" runat="server" Font-Size="10px" Font-Bold="True"
                                                meta:resourcekey="chkDisPatchTypeResource1">
                                            </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                    <td style="display: none">
                                        <asp:Label ID="lbldispatchmode" runat="server" Text="Dispatch Mode" meta:resourcekey="lbldispatchmodeResource1"></asp:Label>
                                    </td>
                                    <td style="display: none">
                                        <asp:Panel ID="panelDispatchMode" runat="server" CssClass="dataheaderInvCtrl" Width="47%"
                                            Font-Bold="True" meta:resourcekey="panelDispatchModeResource1">
                                            <asp:CheckBoxList ID="chkDespatchMode" RepeatDirection="Horizontal" RepeatColumns="1"
                                                runat="server" Font-Size="10px" Font-Bold="True" meta:resourcekey="chkDespatchModeResource1">
                                            </asp:CheckBoxList>
                                            <asp:DropDownList ID="DropDownList1" Style="display: none;" Width="86%" CssClass="ddl"
                                                runat="server" meta:resourcekey="DropDownList1Resource1">
                                            </asp:DropDownList>
                                        </asp:Panel>
                                    </td>
                                    <td class="v-top" style="display: none">
                                        <asp:Label ID="lblPreference" Text="Preference" runat="server" meta:resourcekey="lblPreferenceResource1"></asp:Label>
                                    </td>
                                    <td class="v-top" style="display: none">
                                        <span class="richcombobox w-80">
                                            <asp:DropDownList ID="ddlPriority" CssClass="ddl w-80" runat="server" meta:resourcekey="ddlPriorityResource1">
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                </tr>
                                <tr id="trhide3" runat="server">
                                    <td id="tdlblRefOrg" runat="server">
                                        <asp:Label ID="lblRefOrg" Text="Referring Organization" runat="server" meta:resourcekey="lblRefOrgResource1"></asp:Label>
                                    </td>
                                    <td id="tdtxtReferringHospital" runat="server">
                                        <asp:TextBox ID="txtReferringHospital" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                            meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                            TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                            CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                            ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingOrgID"
                                            DelimiterCharacters="" Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                        <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="Chkoutsource" Visible="false" runat="server" Text="OUTSOURCE" />
                                    </td>
                                </tr>
                                <tr>
                                    <%-- <tr>--%>
                                    <td class="colorforcontent">
                                        <div id="Div5" runat="server">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                onclick="showsearch()" style="cursor: pointer" />
                                            <span class="dataheader1txt" style="cursor: pointer">&nbsp;<asp:Label ID="Label2"
                                                runat="server" Text="More Search Options" onclick="showsearch()" meta:resourcekey="lblinvfilter1Resource1"></asp:Label></span></div>
                                        <div id="Div6" style="display: none;" runat="server">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                onclick="Hidesearch()" style="cursor: pointer" />
                                            <span class="dataheader1txt" style="cursor: pointer">
                                                <asp:Label ID="Label4" runat="server" Text="Hide Search Options" onclick="Hidesearch()"
                                                    meta:resourcekey="lblinvfilters1Resource1"></asp:Label></span></div>
                                    </td>
                                    <%--</tr>--%>
                                    <td colspan="1" class="a-right v-middle">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnSearch_Click" TabIndex="13" meta:resourcekey="btnSearchResource1" />
                                    </td>
                                    <td colspan="1" class="a-left v-middle">
                                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" TabIndex="14" OnClientClick="return ClearSearchFields();"
                                            meta:resourcekey="btnClearResource1" />
                                    </td>
                                    <td colspan="3" class="a-left">
                                        <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                            <ProgressTemplate>
                                                <div id="progressBackgroundFilter" class="a-center">
                                                </div>
                                                <div id="processMessage" class="a-center w-20p">
                                                    <asp:Image ID="img2" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                        meta:resourcekey="img1Resource1" />
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        
         <table id="tblExportCheck" class="w-100p" runat="server" style="display: none;">
        <tr>
        <td class="w-15p" runat="server" id="tdExportPdf">
        <asp:CheckBox ID="CheckBox1" runat="server"  Text="Click here to Export PDF"  />
        </td>
         <td class="w-15p" runat="server" id="tdExportWord" style="display: none;">
        <asp:CheckBox ID="chkExportWord" runat="server"  Text="Click here to Export Word Document" />
        </td>
        <td  colspan="5">
        </td>
        </tr>
        </table>
        
        <table id="tblgrdview" class="w-100p" runat="server" style="display: none;">
        <tr>
        <td>
        <asp:CheckBox ID="chkExportPdf" runat="server"  Text="Click here to Export PDF"   style="display: none;"/>
        </td>
        </tr>
            <tr>
                <td class="colorforcontent w-100p h-23 a-left">
                    <div id="ACX2plus3" style="display: none;">
                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                            onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">
                            &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Investigation Report" meta:resourcekey="lblinvfilterResource1"></asp:Label></span></div>
                    <div id="ACX2minus3" style="display: block;">
                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                            onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);">
                            <asp:Label ID="lblinvfilters" runat="server" Text="Investigation Report" meta:resourcekey="lblinvfiltersResource1"></asp:Label></span></div>
                </td>
            </tr>
            <tr class="a-center">
                <td id="tdprevdue" runat="server" style="display: table-cell;" colspan="5">
                    <asp:Label ID="lblpreviousdue" runat="server" ForeColor="Red" Text="0" meta:resourcekey="lblpreviousdueResource1" />
                </td>
            </tr>
            <tr id="ACX2responses3" style="display: table-row;">
                <td>
                    <table border="1" id="GrdHeader" class="w-100p" runat="server" style="display: table">
                        <tr class="dataheader1">
                            <td class="a-center w-5p">
                                <asp:Label ID="RdSel" runat="server" Text="Select" meta:resourcekey="RdSelResource1"></asp:Label>
                            </td>
                            <td class="a-center w-6p">
                                <asp:Label ID="Rs_Select" runat="server" Text="Print" meta:resourcekey="Rs_SelectResource1"></asp:Label>
                            </td>
                             <td class="a-center w-6p" Style="display: none">
                                <asp:Label ID="Rs_SelectCumulative" runat="server" Text="Cumulative" meta:resourcekey="Rs_SelectCumulativeResource1"></asp:Label>
                            </td>
                            <%--<td align="center" style="width: 10%;display:none">
                                                        <asp:Label ID="Rs_PatientNo1" runat="server" Text="Patient No." meta:resourcekey="Rs_PatientNo1Resource1"></asp:Label>
                                                    </td>--%>
                            <td class="a-center w-7p">
                                <asp:Label ID="lblVisitnos" runat="server" Text="Visit Number" meta:resourcekey="Rs_Visitno1Resource1"></asp:Label>
                            </td>
                             <%--    <%-- **************************--%>
                            <td class="a-center w-5p" Style="display: none">
                                <asp:Label ID="lbl_Labno" runat="server" Text="Lab Number" meta:resourcekey="Rs_Labno1Resource1"></asp:Label>
                            </td>
                           <%-- ************************--%>
                            <td class="a-center w-12p">
                                <asp:Label ID="Rs_Name" runat="server" Text="Patient Name" meta:resourcekey="Rs_NamesResource1"></asp:Label>
                            </td>
                            <td class="a-center w-7p">
                                <asp:Label ID="Rs_Age" runat="server" Text="Gender/Age" meta:resourcekey="Rs_Age1Resource1"></asp:Label>
                            </td>
                            <td class="a-center w-11p">
                                <asp:Label ID="Rs_URNNo" runat="server" Text="VisitDate" meta:resourcekey="Rs_URNNoResource1"></asp:Label>
                            </td>
                            <%-- <td align="center" visible="false">
                                                        <asp:Label ID="Rs_MobileNumber" runat="server" Text="VisitPurposeName" meta:resourcekey="Rs_MobileNumberResource1"></asp:Label>
                                                    </td>--%>
                            <%-- <td visible="false">
                                                        <asp:Label ID="Rs_Address" runat="server" Text="PhysicianName" meta:resourcekey="Rs_AddressResource1"></asp:Label>
                                                    </td>--%>
                            <td runat="server" id="tdorg" class="a-center w-13p">
                                <asp:Label ID="Rs_ToBePerformStatus" runat="server" Text="RefPhysicianName" meta:resourcekey="Rs_ToBePerformStatusResource1"></asp:Label>
                            </td>
                            <td runat="server" id="td12" class="a-center w-13p">
                                <asp:Label ID="Label9" runat="server" Text="Reg.Location" meta:resourcekey="Label9RegResource1"></asp:Label>
                            </td>
                            <td runat="server" id="td17" class="a-center w-13p">
                                <asp:Label ID="Label22" runat="server" Text="Client" meta:resourcekey="LabelclResource1"></asp:Label>
                            </td>
                            <%--  <td runat="server" align="center" id="tddue" style="width: 10%">
                                                        <asp:Label ID="Label10" runat="server" Text="DueAmount" meta:resourcekey="Label10Resource1"></asp:Label>
                                                    </td>--%>
                            <td runat="server" id="tdActionse" class="a-center w-5p" >
                                <asp:CheckBox ID="chkAll" runat="server" ToolTip="Select Row" Checked="false" meta:resourcekey="chkAllResource1" ></asp:CheckBox>
                            </td>
                            <td style="display: none;">
                                <asp:Label ID="Rs_TrackId" runat="server" Text="Select" meta:resourcekey="Rs_TrackIdResource1"></asp:Label>
                            </td>
                             <td   style="display: none;" >
                                <asp:Label ID="lblShowReport1" runat="server" Text=""  style="display:none"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p">
                        <tr class="w-100p">
                            <td>
                                <div id="divgv">
                                    <asp:GridView ID="grdResult" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                        DataKeyNames="PatientVisitID,Name" CssClass="w-100p searchPanel" OnRowDataBound="grdResult_RowDataBound"
                                        OnItemCommand="grdResult_ItemCommand" OnRowCommand="grdResult_RowCommand" ItemStyle-VerticalAlign="Top"
                                        RepeatDirection="Horizontal" OnPageIndexChanging="grdResult_PageIndexChanging"
                                        meta:resourcekey="grdResultResource1">
                                        <PagerStyle HorizontalAlign="Center" />
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField Visible="false" DataField="PatientVisitID" HeaderText="PatientVisitID"
                                                meta:resourcekey="BoundFieldResource1" />
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <table id="parentgrid" runat="server" class="w-100p a-left">
                                                        <tr id="Tr1" runat="server">
                                                            <td id="Td1" class="w-5p a-center" nowrap="nowrap" runat="server">
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                            </td>
                                                            <td id="printimage" class="w-3p a-center" runat="server">
                                                                <%--<img id="imgPrintReport" title="Print" runat="server" alt="Print" visible="false"
                                                                    src="~/Images/printer.gif" style="cursor: pointer;" />--%>
                                                                <asp:ImageButton ID="Image1" ImageUrl="../Images/WithStationary.ico" runat="server" 
																OnClientClick="return CheckVisitID(false);" meta:resourcekey="Image1Resource1"
                                                                   CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                    CommandName="ShowWithStationary" Style="cursor: pointer; margin-left: 10px" />
                                                            </td>
                                                            <td id="printimage1" class="a-center w-3p" runat="server">
                                                                <img id="imgPrintReport" title="Print" runat="server" alt="Print" visible="true"
                                                                    src="~/Images/printer.gif" style="cursor: pointer;" />
                                                                <asp:ImageButton ID="ImageButton1" ImageUrl="../Images/printer.gif" runat="server" meta:resourcekey="ImageButton1Resource1" OnClientClick="return CheckVisitID(false);"
                                                                     CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                    CommandName="ShowWithoutStationary" Style="cursor: pointer; margin-left: 10px" />
                                                            </td>
                                                              <td id="printimage2" class="w-3p a-center" runat="server" Style="display: none">
                                                                <%--<img id="imgPrintReport" title="Print" runat="server" alt="Print" visible="false"
                                                                    src="~/Images/printer.gif" style="cursor: pointer;" />--%>
                                                                <asp:ImageButton ID="ImageButton2" ImageUrl="../Images/WithStationary.ico" runat="server" 
																OnClientClick="return CheckVisitID(true);" meta:resourcekey="Image1Resource1"
                                                                   CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                    CommandName="ShowCumulativeWithStationary" Style="cursor: pointer; margin-left:23px" />
                                                            </td>
                                                            <td id="printimage3" class="a-center w-3p" runat="server" Style="display: none">
                                                               <%-- <img id="img4" title="Print" runat="server" alt="Print" visible="true"
                                                                    src="~/Images/printer.gif" style="cursor: pointer;" />--%>
                                                                <asp:ImageButton ID="ImageButton3" ImageUrl="../Images/printer.gif" runat="server" meta:resourcekey="ImageButton1Resource1" OnClientClick="return CheckVisitID(true);"
                                                                     CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                    CommandName="ShowCumulativeWithoutStationary" Style="cursor: pointer; margin-left: 10px" />
                                                            </td>
                                                            <td id="smartimage" class="a-center w-3p" runat="server" style="display:block;"> 
                                                                <asp:ImageButton ID="imgbtnsmart" ImageUrl="../Images/printer.gif" runat="server" meta:resourcekey="imgbtnsmartResource1" OnClientClick="return CheckVisitID(false);"
                                                                     CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                    CommandName="ShowSmartReport" Style="cursor: pointer; margin-left: 10px" />
                                                            </td>
                                                            
                                                            <td id="PatientNumber" class="a-center" style="display: none" nowrap="nowrap" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                            </td>
                                                            <td id="Td16" class="a-center w-9p" nowrap="nowrap" runat="server">
                                                                <%-- <asp:LinkButton ID="Button1" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                                    OnClientClick='<%# String.Format("ShowPopUp({0});return false;",Eval("VisitNumber"))%> ' />--%>
                                                                <asp:LinkButton ID="Button1" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                                    OnClientClick='<%# String.Format("ShowPopUp(this);return false;",Eval("VisitNumber"))%> ' />
                                                            </td>
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                             <td id="Labno" class="a-left w-5p" nowrap="nowrap" runat="server">
                                                                <asp:Label ID="Lab_Labno" runat="server" Text='<%# Bind("ExternalVisitID") %>'></asp:Label>
                                                            </td>
                                                            
                                                            
                                                            
                                                            
                                                            <td id="PatientName" class="a-left w-12p" runat="server">
                                                                <asp:ImageButton ID="imgClick" runat="server" meta:resourcekey="imgClickResource1"
                                                                    ImageUrl="~/Images/plus.png" CommandName="ShowChild" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                                <%# DataBinder.Eval(Container.DataItem, "PatientName")%>
                                                            </td>
                                                            <td id="Age" class="a-left w-9p" runat="server">
                                                                <asp:Label ID="lblAge" runat="server" Text='<%# Bind("PatientAge") %>'></asp:Label>
                                                            </td>
                                                            <td id="VisitDate" class="a-left w-11p" nowrap="nowrap" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "VisitDate")%>
                                                            </td>
                                                            <%--<td id="VisitPurposeName" align="left" style="width: 10%" nowrap="nowrap" runat="server" visible="false">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "VisitPurposeName")%>
                                                                                </td>--%>
                                                            <%-- <td id="PhysicianName" align="left" style="width: 10%" nowrap="nowrap" runat="server" visible="false">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "PhysicianName")%>
                                                                                </td>--%>
                                                            <td id="ReferingPhysicianName" class="a-left w-15p" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "ReferingPhysicianName")%>
                                                            </td>
                                                            <td id="Location" class="a-left w-13p" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "Location")%>
                                                            </td>
                                                            <%--  <td id="due" align="center" style="width: 10%" nowrap="nowrap" runat="server">
                                                                                        <%# DataBinder.Eval(Container.DataItem, "CopaymentPercent")%>
                                                                                        <asp:HiddenField ID="hdnDue" runat="server" Value='<%# Eval("CopaymentPercent") %>' />
                                                                                        <asp:HiddenField ID="hdOrgID" runat="server" Value='<%#Eval("OrgID") %>' />
                                                                                    </td>--%>
                                                            <td id="Client" class="a-left w-15p" runat="server">
                                                                <%# DataBinder.Eval(Container.DataItem, "ClientName")%>
                                                            </td>
                                                            
                                                            <td id="Td18" align="left" width="16%" runat="server" >
                                                                <%--<asp:ImageButton ID="Image2" runat="server" CssClass="h-30 w-32" ImageUrl="~/Images/outsource.png"  
                                                                    RowIndex='<%# Container.DisplayIndex %>' CommandName="TRF" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />--%>
                                                                    <asp:LinkButton ID="Image2" CssClass="outSource" Text="Out Source" runat="server" CommandName="TRF" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Visible="false" meta:resourcekey="lbloutsourceResource1"/>
                                                                    <asp:LinkButton ID="Image3" CssClass="noOutSource" Text="No Out Source" runat="server" Visible="false" meta:resourcekey="lblnooutsourceResource1" />
                                                            </td>
                                                            <td id="tdDespatch" class="a-center w-5p" nowrap="nowrap" runat="server" >
                                                                <asp:CheckBox ID="chkSel" runat="server" ToolTip="Select Row" />
                                                            </td>
                                                            <td id="PatientVisitId" align="left" style="display: none" runat="server">
                                                                <asp:TextBox ID="txtPatientvisitId" Text='<%# Bind("PatientVisitId") %>' runat="server"></asp:TextBox>
                                                                <asp:TextBox ID="txtDispatch" Text='<%# Bind("Remarks") %>' runat="server"></asp:TextBox>
                                                            </td>
                                                            <td id="Td14" class="a-left" style="display: none" runat="server">
                                                                <asp:TextBox ID="txtpatientId" Text='<%# Bind("PatientID") %>' runat="server"></asp:TextBox>
                                                            </td>
                                                            <td id="tddespatchstatus" class="a-left w-10p" runat="server" style="display: none;">
                                                                <asp:Label ID="lbldespatchstatus" runat="server" Text='<%# Bind("ReferralType") %>'></asp:Label>
                                                            </td>
                                                            <td id="td13" class="a-left w-10p" runat="server" style="display: none;">
                                                                <asp:Label ID="lblIsstat" runat="server" Text='<%# Bind("IsSTAT") %>'></asp:Label>
                                                            </td>
                                                            <td id="td19" align="left" width="10%" runat="server" style="display: none;">
                                                                <asp:Label ID="lbloutdoc" runat="server" Text='<%# Bind("IsOutDoc") %>'></asp:Label>
                                                            </td>
                                                                                                                      
                                                            
                                                            <td id="td25"  nowrap="nowrap" runat="server" >
                                                               <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Text="Show Report"
                                                                  Font-Underline="true" ForeColor="Blue"   style="display:none"   />
                                                            </td>
                                                            
                                                           
                                                        </tr>
                                                        <tr id="Tr2" runat="server" class="a-center">
                                                            <td id="Td2" colspan="11" runat="server" class="a-center">
                                                                <asp:TemplateField HeaderText="Questions" HeaderStyle-HorizontalAlign="Center">
                                                                    <itemtemplate>
                                                                                   
                                                                                    <div class="w-100p">
                                                                                            <div runat="server"  id="DivChild" style="display:none;" class="evenforsurg"  >
                                                                                               
                                                                                                    <asp:GridView ID="ChildGrid" EmptyDataText="No Record Found" runat="server" 
                                                                                                        AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"  OnRowDataBound="ChildGrid_RowDataBound"
                                                                                                        OnPageIndexChanging="ChildGrid_PageIndexChanging"
                                                                                                        DataKeyNames="VisitID"
                                                                                                        ForeColor="Black"  PageSize="20"
                                                                                                        CssClass="mytable1 gridView w-98p">
                                                                                                       
                                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                                        <Columns>
                                                                                                            <asp:BoundField Visible="False" DataField="PatientVisitID" 
                                                                                                                HeaderText="PatientVisitID" />
                                                                                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource25" >
                                                                                                                <ItemTemplate>
                                                                                                                    <%--<asp:RadioButton ID="rdSelect" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />--%>
                                                                                                                    <asp:CheckBox ID="Chkselectinv" runat="server" ToolTip="Select Row"  />
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:BoundField DataField="InvestigationNAme" HeaderText="Investigation List" meta:resourcekey="BoundFieldResource15" /> 
                                                                                                            <asp:TemplateField HeaderText="Report Status" meta:resourcekey="TemplateFieldResource24">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# bind("DisplayStatus") %>'/>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                           <asp:BoundField  HeaderText="Received Date" DataField="ModifiedAt" DataFormatString="{0:dd/MM/yy hh:mm tt}" />
                                                                                                        </Columns>
                                                                                                       </asp:GridView>&nbsp;
                                                                                                                                                                                                          
                                                                                                   </div>
                                                                                         </div>
                                                                                 </itemtemplate>
                                                                </asp:TemplateField>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false" >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsDueBill" runat="server"  Text='<%#Eval("IsDueBill") %>' >
                                                    </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    
                                    
                                    <asp:HiddenField ID="hfID" runat="server" />
                                    <asp:HiddenField ID="hfPatientID" runat="server" />
                                    <asp:HiddenField ID="hfRoleID" runat="server" />
                                    <asp:HiddenField ID="hfOrgID" runat="server" />
                                    <asp:HiddenField ID="hfPatientVisitID" runat="server" />
                                    <asp:HiddenField ID="hfPageID" runat="server" />
                                    <asp:HiddenField ID="hfButtonName" runat="server" />
                                    <asp:HiddenField ID="hfButtonValue" runat="server" />
                                    <asp:HiddenField ID="hfApproveCount" runat="server" />
                                    <asp:HiddenField ID="hfShowAllAccession" runat="server" />
                                    <asp:HiddenField ID="hfSelectedAccession" runat="server" />
                                    <ajc:ModalPopupExtender ID="extShowLiveReport" runat="server" DropShadow="false"
                                        PopupControlID="pnlShowLiveReport" BackgroundCssClass="modalBackground" Enabled="True"
                                        TargetControlID="btnCloseReport" CancelControlID="imgShowLiveReport">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlShowLiveReport" runat="server" Style="display: block; height: 590px;
                                        width: 1350px; vertical-align: bottom; top: 1010px;">
                                        <table id="Table3" runat="server" border="1" width="97%" align="center">
                                            <tr id="Tr10" runat="server" style="background-color: White;">
                                                <td id="Td23" runat="server">
                                                    <table width="100%" runat="server" id="tblScroll" border="0" style="overflow: scroll;
                                                        height: 35%; background-color: White;">
                                                        <tr>
                                                            <td>
                                                                <div class="dialogHeader">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblReportModalHeader" runat="server" Text="Generate Report" meta:resourcekey="lblReportModalHeaderResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="a-right">
                                                                                <img src="../Images/dialog_close_button.png" alt="Close" id="imgShowLiveReport" onclick="CloseextShowLiveReport()"
                                                                                    style="cursor: pointer;" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr id="Tr11" runat="server">
                                                            <td>
                                                                <div id="tdChecknamestoggle">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="colorforcontent w-100p h-23 a-left">
                                                                                <div id="dvShow" style="display: none;">
                                                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                                                                        onclick="showResponses('dvShow','dvHide','tdChecknames',1);" />
                                                                                    <span class="dataheader1txt pointer" onclick="showResponses('dvShow','dvHide','tdChecknames',1);">
                                                                                        &nbsp;<asp:Label ID="lblShowManualReport" runat="server" Text="Show Test Details" meta:resourcekey="lblShowManualReportResource1"></asp:Label></span></div>
                                                                                <div id="dvHide" style="display: block;">
                                                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                                                                                        onclick="showResponses('dvShow','dvHide','tdChecknames',0);" />
                                                                                    <span class="dataheader1txt pointer" onclick="showResponses('dvShow','dvHide','tdChecknames',0);">
                                                                             <asp:Label ID="lblHideManualReport" runat="server" Text="Hide Test Details " meta:resourcekey="lblHideManualReportResource1"></asp:Label></span></div>
                                                                            </td>
                                                                        </tr>
                                                                        <%--<tr>
                                                                            <td>
                                                                                <asp:RadioButton ID="rdbtnWithStationary" runat="server" Text="With Stationary" GroupName="WWS" Visible="true" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:RadioButton ID="rdbtnWithOutStationary" runat="server" Text="Without Stationary" Visible="true"
                                                                                    GroupName="WWS" />
                                                                            </td>
                                                                            
                                                                        </tr>--%>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblReportType" runat="server" Text="Report Type :" Style="font-weight: bolder;"></asp:Label>
                                                                                <asp:DropDownList ID="ddlReportType" runat="server" onchange="return CheckReportTypeStatus(this)">
                                                                                                                                                                    </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <div id="tdChecknames">
                                                                    </div>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Button ID="btnSendMailProvisionalReport" runat="server" Text="Send Mail" Class='btn'
                                                                                    OnClick="btnSendMailProvisionalReport_Click" Visible="false"/>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Button ID="btnSaveToDispatch" runat="server" Text="Generate Report" Class='btn'
                                                                              OnClientClick="return Validate();"      OnClick="btnGenerateReportManual_Click" />
                                                                            </td>
                                                                            <%--<td>
                                                                             <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Text="Show Report Preview" 
                                                                                 Font-Underline="true" ForeColor="Blue" />
                                                                            </td>--%>
                                                                            
                                                                             <td>
                                                                              
                                                                                  <input type="button" id="btnClose" value="Close" onclick="CloseextShowLiveReport()" cssclass="btn" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                       <%--Added by Radha--%>
                                                       <%--Start--%>
                                                      
                                                      <%--  <tr>
                                                            <td class="a-left">
                                                                <div id="DivpdfProduct" runat="server" class="w-99p" style="height: auto;">                                                    
                                                                    <iframe runat="server" id="iframeplaceholderForProduct" name="myname" style="width: 985px;
                                                                        height: 400px; border: 0px; overflow: none;"></iframe>
                                                                </div>
                                                            </td>
                                                        </tr>--%>
                                                     <%--End--%>
                                                    </table>
                                                    <table width="100%">
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input type="button" id="btnCloseReport" runat="server" style="display: none;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    
                                    <ajc:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                        BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
                                        vertical-align: bottom; top: 80px;" meta:resourcekey="pnlOthersResource1">
                                        <table class="w-100p a-center">
                                            <tr>
                                                <td class="a-right">
                                                    <img class="w-29 h-30 pointer" src="../Images/Close_Red_Online_small.png" alt="Close"
                                                        id="img2" onclick="ClosePopUp()" style="position: absolute; top: -8px; right: 10px;" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table id="Table1" runat="server" class="w-100p">
            <tr id="tblindv" style="display: none;">
                <td class="colorforcontent">
                    <div id="divIndv">
                        <asp:GridView ID="gvIndv" EmptyDataText="No Record Found" runat="server" AllowPaging="True"
                            CellPadding="1" AutoGenerateColumns="False" DataKeyNames="PatientVisitId" ForeColor="Black"
                            PageSize="10" OnRowDataBound="gvIndv_RowDataBound" CssClass="mytable1 w-100p gridView" meta:resourcekey="gvIndvResource1" >
                            <HeaderStyle CssClass="dataheader1" />
                            <Columns>
                                <asp:BoundField Visible="False" DataField="PatientVisitId" HeaderText="PatientVisitID"
                                    meta:resourcekey="BoundFieldResource2" />
                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSel1" runat="server" ToolTip="Select Row" meta:resourcekey="chkSel1Resource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="Print">
                                                        <ItemTemplate>
                                                            <img id="imgPrintReport" title="Print" runat="server" alt="Print" src="~/Images/printer.gif"
                                                                style="cursor: pointer;" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Patient No." meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpatientno" runat="server" Text='<%# bind("PatientNumber") %>' meta:resourcekey="lblpatientnoResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpatientname" runat="server" Text='<%# bind("PatientName") %>' meta:resourcekey="lblpatientnameResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpatientAge" runat="server" Text='<%# bind("PatientAge") %>' meta:resourcekey="lblpatientAgeResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Visit Date" meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVisitDate" runat="server" Text='<%# bind("VisitDate") %>' meta:resourcekey="lblVisitDateResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Investigation Name" meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <asp:Label ID="lblInvestigationname" runat="server" Text='<%# bind("Investigation") %>'
                                            meta:resourcekey="lblInvestigationnameResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Report Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReportStatus" runat="server" Text='<%# bind("Status") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLocation" runat="server" Text='<%# bind("Location") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="txtPatientvisitId" Text='<%# Bind("PatientVisitId") %>' runat="server"
                                            Style="display: none" />
                                        <asp:Label ID="txtDispatch" runat="server" Text='<%# bind("Remarks") %>' Style="display: none" />
                                        <asp:Label ID="txtpatientId" Text='<%# Bind("PatientID") %>' runat="server" Style="display: none" />
                                        <input id="hdnOutSourceDue" type="hidden" runat="server" value='<%# Eval("Due ")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        <table class="w-100p">
            <div id="tblpage" runat="server" class="w-100p">
                <tr id="trFooter" runat="server" class="dataheaderInvCtrl">
                    <td colspan="2" class="defaultfontcolor a-center">
                        <div id="divFooterNav" runat="server">
                            <asp:Label ID="Label12" runat="server" Text="Page" meta:resourcekey="Label12Resource1"></asp:Label>
                            <%--meta:resourcekey="Label1Resource1"--%>
                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                            <asp:Label ID="Label13" runat="server" Text="Of" meta:resourcekey="Label13Resource1"></asp:Label>
                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                            <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                CssClass="btn" meta:resourcekey="Btn_PreviousResource1" Style="width: 71px" />
                            <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                                meta:resourcekey="Btn_NextResource1" />
                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                            <asp:HiddenField ID="hdnPostBack" runat="server" />
                            <asp:HiddenField ID="hdnOrgID" runat="server" />
                            <asp:Label ID="Label14" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                            <asp:TextBox ID="txtpageNo" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                            <asp:Button ID="Button1" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                                OnClick="btnGo_Click1" CssClass="btn" meta:resourcekey="btnGoResource1" />
                        </div>
                    </td>
                </tr>
                <tr id="trOutSource" runat="server" visible="false" align="center">
                    <td class="defaultfontcolor">
                        <asp:Button ID="btnOutSouce" runat="server" Text="OutSourceDispatch" CssClass="btn"
                            onmouseover="this.className='btn btnhov'" OnClientClick="return CheckVisitID1()"
                            onmouseout="this.className='btn'" OnClick="btnOutSouce_Click" meta:resourcekey="btnOutSouceResource1" />
                    </td>
                </tr>
                <tr id="trSelectVisit" runat="server" visible="false" class="w-100p">
                <td class="w-50p" align="center" id="tdshowreport" runat="server">
                 <asp:Label ID="lblSelectapatientvisit" runat="server" Text=" Select a patient visit"
                            meta:resourcekey="lblSelectapatientvisitResource1"></asp:Label>
                        <asp:DropDownList ID="ddlVisitActionName" runat="server" Visible="False" meta:resourcekey="ddlVisitActionNameResource1"
                        onChange="Showreportlang()">
                        </asp:DropDownList><%--
                           <td id="tdreplang" runat="server"> 
                        <asp:Label ID="lblreplang" runat="server" Text="Report Language"  meta:resourcekey="lblreplangResource1" ></asp:Label>
                         </td>
                        <td id="tdddreplang" runat="server" style="width: 300px;">--%>
                        <asp:DropDownList CssClass="" style="display:none;"  ID="ddlreplang" runat="server"></asp:DropDownList>
                        <%--</td>--%>
                        <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            OnClientClick="return CheckVisitID(false)" onmouseout="this.className='btn'" OnClick="btnGo_Click"
                            meta:resourcekey="btnGoResource1" />
                        <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                        <ajc:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                            TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                            CancelControlID="imgPDFReportPreview" DynamicServicePath="" Enabled="True">
                        </ajc:ModalPopupExtender>
                        <asp:Panel ID="pnlReportPreview" BorderWidth="1px" Height="500px" Width="1000px"
                            CssClass="modalPopup dataheaderPopup" runat="server" meta:resourcekey="pnlShowReportPreviewResource1"
                            Style="display: none">
                            <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                                <table width="100%">
                                    <tr>
                                        <td align="right" valign="middle" class="defaultfontcolor">
                                            <asp:Button ID="btnpdf" runat="server" Text="Print" OnClientClick="return pdfPrint();"
                                                CssClass="btn" Height="18px" OnClick="btnGo_Click" meta:resourcekey="btnpdfResource1" />
                                            &nbsp;&nbsp;
                                            <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" runat="server"
                                                alt="Close" style="cursor: pointer; height: 18Px;" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <table class="w-100p">
                                <tr>
                                    <td class="v-top">
                                        <table id="Table2" runat="server" class="w-100p">
                                            <tr id="Tr8" runat="server">
                                                <td id="Td15" class="colorforcontent w-30p h-23 a-left" runat="server">
                                                    <div id="Div3" style="display: block;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',1);
                                                                                    showResponses('Div55','Div66','ACX3responses22',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',1);
                                                                                showResponses('Div55','Div66','ACX3responses22',0);">&nbsp;<asp:Label ID="Label16"
                                                                                    runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label>
                                                        </span>
                                                    </div>
                                                    <div id="Div4" style="display: none;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',0);showResponses('Div55','Div66','ACX3responses22',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',0);
                                                                                showResponses('Div55','Div66','ACX3responses22',1);">
                                                            <asp:Label ID="Label17" runat="server" Text=" Lab Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label>
                                                        </span>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tblReportDetails" style="display: none;" class="w-100p">
                                            <tr>
                                                <td>
                                                    <ucPatientdet:PatientDetails ID="uctPatientDetail1" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center">
                                                    <asp:GridView ID="grdPatientView" runat="server" AllowPaging="True" PageSize="5"
                                                        AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 w-70p gridView"
                                                        OnRowDataBound="grdPatientView_RowDataBound" DataKeyNames="PatientID,PatientVisitID" meta:resourcekey="grdPatientViewResource1" >
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Patient Report">
                                                                <ItemTemplate>
                                                                    <div class="a-center">
                                                                        <table class="dataheaderInvCtrl w-100p" style="border-collapse: collapse;" width="100%">
                                                                            <tr>
                                                                                <td class="a-right w-25p" style="background-color: #3a86da;">
                                                                                    <asp:Label ID="lblVisitDate" runat="server" ForeColor="White" meta:resourcekey="lblVisitDateResource2"
                                                                                        Text="Visit Date"></asp:Label>
                                                                                </td>
                                                                                <td class="a-left w-25p" style="background-color: #3a86da;">
                                                                                    <asp:Label ID="lblDate" runat="server" ForeColor="White" meta:resourcekey="lblDateResource1"
                                                                                        Text='<%# Eval("VisitDate") %>'></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" class="a-center">
                                                                                    <asp:GridView ID="grdOrderedinv" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                        CssClass="mytable1 gridView w-99p" ForeColor="Black" meta:resourcekey="grdOrderedinvResource1"
                                                                                        PageSize="100">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Test Name">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblTestName" runat="server" meta:resourcekey="lblTestNameResource15"
                                                                                                        Text='<%# bind("Name") %>'></asp:Label>
                                                                                                    <asp:Label ID="lblPrintCount1" runat="server" CssClass="notification-bubble" meta:resourcekey="lblPrintCount1Resource1"
                                                                                                        Text='<%# Eval("RoundNo").ToString()=="0" ? "0" : Eval("RoundNo").ToString() %>'></asp:Label>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <%-- <asp:BoundField DataField="RoundNo" HeaderText="Report Status" />--%>
                                                                                            <asp:BoundField DataField="Status" HeaderText="Test Status" meta:resourcekey="BoundFieldResource3" />
                                                                                            <asp:BoundField DataField="ReportStatus" HeaderText="Report Status" meta:resourcekey="BoundFieldResource4" />
                                                                                            <asp:BoundField DataField="Priority" HeaderText="Priority" meta:resourcekey="BoundFieldResource5"
                                                                                                Visible="False" />
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Priority Report"
                                                        CssClass="btn" onmouseover="this.className='btn btnhov'" OnClientClick="return PriorityValidation();"
                                                        OnClick="btnGenerateReport_Click" onmouseout="this.className='btn'" meta:resourcekey="btnGenerateReportResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="v-top">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="colorforcontent w-30p h-23 a-left">
                                                    <div id="Div55" style="display: none;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                                            onclick="showResponses('Div55','Div66','ACX3responses22',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                        <span class="dataheader1txt pointer" onclick="showResponses('Div55','Div66','ACX3responses22',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                            &nbsp;<asp:Label ID="Label18" runat="server" Text="Show PDF" meta:resourcekey="Label18Resource1"></asp:Label></span></div>
                                                    <div id="Div66" style="display: block;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                                                            onclick="showResponses('Div55','Div66','ACX3responses22',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                        <span class="dataheader1txt pointer" onclick="showResponses('Div55','Div66','ACX3responses22',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                            <asp:Label ID="Label20" runat="server" Text="PDF Viewer" meta:resourcekey="Label20Resource1"></asp:Label></span></div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="ACX3responses22">
                                            <tr>
                                                <td class="a-left">
                                                    <div id="Divpdf" runat="server" class="w-99p" style="height: auto;">
                                                        <iframe runat="server" id="frameReportPreview" name="myname" style="width: 985px;
                                                            height: 400px; border: 0px; overflow: none;"></iframe>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                         <table id="ACX3responses55">
                                            <tr>
                                                <td class="a-left">
                                                    <div id="DivpdfProduct" runat="server" class="w-99p" style="height: auto;">                                                    
                                                        <iframe runat="server" id="iframeplaceholderForProduct" name="myname" style="width: 985px;
                                                            height: 400px; border: 0px; overflow: none;"></iframe>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                </td>
                    <td  class="w-50p" align="Center" id="tdExportReport" runat="server" style="display:none;">
                      
                 <asp:Button ID="btnExportPDF" runat="server" Text="Export to PDF" CssClass="btn" 
                             OnClick="btnExportPDF_Click" 
                             />
               
                    </td>
                     <td  class="w-5p" id="tdExportWordDoc"  align="Center"  runat="server" style="display:none;">
                      
                 <asp:Button ID="btnExportWord" runat="server" Text="Export to Doc" CssClass="btn" style="display:none;"
                             OnClick="btnExportWord_Click" 
                             />
               
                    </td>
                    <td  class="w-40p">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMessage1" runat="server" meta:resourcekey="lblMessage1Resource1"></asp:Label>
                        <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                    </td>
                </tr>
                <%--   <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    Select a patient and one of the following  
                                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlTheme" onselectedindexchanged="dList_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="return pValidation()" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" />
                                </td>
                            </tr>--%>
        </table>
        <br />
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                </td>
            </tr>
        </table>
        <table class="w-100p" id="tblPayments" visible="false" runat="server">
            <tr>
                <td>
                    <asp:Label ID="lblThisBillhaspendingpaymentskindlymakepaymenttoviewreport" runat="server"
                        Text=" This Bill has pending payments kindly make payment to view report" meta:resourcekey="lblThisBillhaspendingpaymentskindlymakepaymenttoviewreportResource1"></asp:Label>
                    <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        OnClick="btnPayNow_Click" onmouseout="this.className='btn'" meta:resourcekey="btnPayNowResource1" />
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                            <cc1:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                CancelControlID="imgCloseReport" DynamicServicePath="" Enabled="True">
                            </cc1:ModalPopupExtender>
                            <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup w-65p"
                                runat="server" meta:resourcekey="pnlAttribResource1" Style="display: none">
                                <asp:Panel ID="Panel2" runat="server" CssClass="padding2 h-25" meta:resourcekey="Panel1Resource1">
                                    <table class="w-100p">
                                        <tr>
                                            <%--<td class="a-center">
                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                    <ProgressTemplate>
                                                        <div id="progressBackgroundFilter" class="a-center">
                                                        </div>
                                                        <div id="processMessage" class="a-center w-20p">
                                                            <asp:Image ID="img3" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                                meta:resourcekey="img1Resource1" />
                                                        </div>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>--%>
                                            <td>
                                                <asp:Label ID="lblHint" runat="server" Font-Bold="True" Text="Hint: " meta:resourcekey="lblHintResource1" />
                                                <span class="notification-bubble">&nbsp;&nbsp;</span>
                                                <asp:Label ID="lblPrintCountHint" runat="server" Font-Bold="True" Text=" => Report print count"
                                                    meta:resourcekey="lblPrintCountHintResource1" />
                                            </td>
                                            <td class="a-right">
                                                <img id="imgCloseReport" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                    class="pointer" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table class="w-100p">
                                    <tr>
                                        <td class="v-top">
                                            <table id="tblReport" runat="server" class="w-100p">
                                                <tr id="Tr3" runat="server">
                                                    <td id="Td3" class="colorforcontent w-30p h-23 a-left" runat="server">
                                                        <div id="ACX3plus1" style="display: none;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"" "
                                                                onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);" />
                                                            <span class="dataheader1txt pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);">
                                                                &nbsp;<asp:Label ID="lblReportTemplate" runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource50"></asp:Label></span></div>
                                                        <div id="ACX3minus1" style="display: block;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                                                                onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);" />
                                                            <span class="dataheader1txt pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);">
                                                                <asp:Label ID="Label5" runat="server" Text="Report Details" meta:resourcekey="lblLabel5Resource1"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="ACX3responses1" style="display: table;" class="w-100p">
                                                <tr>
                                                    <td>
                                                        <ucPatientdet:PatientDetails ID="uctPatientDetail" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="chdept" runat="server" style="display: none;">
                                                        <asp:CheckBoxList ID="chkDept" runat="server" RepeatColumns="5" onclick="javascript:dispTask(this.id);"
                                                            meta:resourcekey="chkDeptResource1">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="lnkshwrpt" runat="server" style="display: none; color: Black;">
                                                        <asp:Label ID="lblClickHere" runat="server" Text="Click Here !" meta:resourcekey="lblClickHereResource1"></asp:Label>
                                                        <asp:LinkButton ID="lnkShowRecord" runat="server" ForeColor="Black" Font-Bold="True"
                                                            Font-Underline="True" OnClick="lnkShowRecord_Click" meta:resourcekey="lnkShowRecordResource1"
                                                            Text="DepartmentWise Filter Report "></asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table class="w-100p" id="tblResults" runat="server">
                                                            <tr id="Tr4" runat="server">
                                                                <td id="Td4" runat="server">
                                                                    <table>
                                                                        <tr>
                                                                            <td class="w-5p">
                                                                                <img src="../Images/collapse_blue.jpg" id="imgClick" title="Show Report Template"
                                                                                    style="display: none;" runat="server" onclick="javascript:return ShowReportDiv();" />
                                                                            </td>
                                                                            <td class="w-95p">
                                                                                <asp:Label runat="server" ID="lblHead" Text="Show Report Template" Style="display: none;"
                                                                                    meta:resourcekey="lblHeadResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr id="Tr5" runat="server">
                                                                <td id="Td5" runat="server">
                                                                    <div id="dReport" runat="server">
                                                                        <asp:DataList ID="grdResultTemp" runat="server" CellPadding="4" ForeColor="#333333"
                                                                            RepeatColumns="2" OnItemDataBound="grdResultTemp_ItemDataBound" RepeatDirection="Horizontal"
                                                                            OnItemCommand="grdResultTemp_ItemCommand" meta:resourcekey="grdResultTempResource1">
                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                            <ItemTemplate>
                                                                                <table class="dataheaderInvCtrl searchPanel">
                                                                                    <tr>
                                                                                        <td class="v-top">
                                                                                            <table cellpadding="5" class="colorforcontentborder w-100p">
                                                                                                <tr>
                                                                                                    <td class="Duecolor h-20">
                                                                                                        <table class="w-100p">
                                                                                                            <tr>
                                                                                                                <td class="a-left">
                                                                                                                    <asp:Label ID="lblReport" runat="server" Text=" Report" meta:resourcekey="lblReportResource1"></asp:Label>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <asp:CheckBox ID="chkEnableAll" runat="server" meta:resourcekey="chkEnableAllResource1" />
                                                                                                                    <asp:Label ID="lblEnableALL" runat="server" Text="Reprint" meta:resourcekey="lblEnableALLResource1"></asp:Label>
                                                                                                                </td>
                                                                                                                <td class="a-right">
                                                                                                                    &nbsp<asp:CheckBox ID="chkSelectAll" runat="server" meta:resourcekey="chkSelectAllResource1" />
                                                                                                                    <asp:Label ID="lblSelectALL" runat="server" Text="Selectall" meta:resourcekey="lblSelectALLResource1"></asp:Label>
                                                                                                                    <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                                        meta:resourcekey="lblReportIDResource1"></asp:Label>
                                                                                                                    <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                        meta:resourcekey="lblReportnameResource1"></asp:Label>
                                                                                                                    <asp:HiddenField ID="HdnTemplatename" runat="server" Value='<%# Eval("TemplateName") %>' />
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
                                                                                            <table cellpadding="5" class="colorforcontentborder w-100p">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                                            OnItemDataBound="grdResultDate_ItemDataBound" OnItemCommand="grdResultDate_ItemCommand"
                                                                                                            RepeatColumns="2" RepeatDirection="Horizontal" meta:resourcekey="grdResultDateResource1">
                                                                                                            <ItemStyle VerticalAlign="Top" />
                                                                                                            <ItemTemplate>
                                                                                                                <table>
                                                                                                                    <tr>
                                                                                                                        <td>
                                                                                                                            <asp:Label runat="server" Font-Bold="True" ID="lblCreatedAt" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                                                                                                            <asp:Label runat="server" ID="lblDtReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                                                meta:resourcekey="lblDtReportIDResource1"></asp:Label>
                                                                                                                            <asp:Label runat="server" ID="lbldtReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                meta:resourcekey="lbldtReportnameResource1"></asp:Label>
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                    <tr>
                                                                                                                        <td>
                                                                                                                            <asp:DataList ID="dlChildInvName" RepeatColumns="1" runat="server" OnItemCommand="dlChildInvName_ItemCommand"
                                                                                                                                OnItemDataBound="dlChildInvName_ItemDataBound" CssClass="w-100p" meta:resourcekey="dlChildInvNameResource1">
                                                                                                                                <ItemStyle VerticalAlign="Top" />
                                                                                                                                <ItemTemplate>
                                                                                                                                    <table>
                                                                                                                                        <tr>
                                                                                                                                            <td>
                                                                                                                                                <asp:CheckBox ID="ChkBox" onclick="javascript:return ChkIfSelected(this.id);" runat="server"
                                                                                                                                                    meta:resourcekey="ChkBoxResource1" />
                                                                                                                                            </td>
                                                                                                                                            <td>
                                                                                                                                                <asp:Label runat="server" ID="lblInvname" Text='<%# Eval("InvestigationName") %> '
                                                                                                                                                    meta:resourcekey="lblInvnameResource1"></asp:Label>
                                                                                                                                                <asp:Label CssClass="notification-bubble" runat="server" ID="lblPrintCount" Text='<%# Eval("PrintCount").ToString()=="0" ? "0" : Eval("PrintCount").ToString() %> '></asp:Label>
                                                                                                                                                <asp:Label runat="server" Visible="False" ID="lblInvID" Text='<%# Eval("InvestigationID") %>'
                                                                                                                                                    meta:resourcekey="lblInvIDResource1"></asp:Label>
                                                                                                                                                <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                                                                    meta:resourcekey="lblReportIDResource2"></asp:Label>
                                                                                                                                                <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                                    meta:resourcekey="lblReportnameResource2"></asp:Label>
                                                                                                                                                <asp:Label runat="server" ID="lblAccessionNo" Visible="False" Text='<%# Eval("AccessionNumber") %>'
                                                                                                                                                    meta:resourcekey="lblAccessionNoResource1"></asp:Label>
                                                                                                                                                <asp:Label runat="server" ID="lblPatientID" Visible="False" Text='<%# Eval("PatientID") %>'
                                                                                                                                                    meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                                                                                                                                <asp:Label runat="server" ID="lbldeptid" Visible="False" Text='<%# Eval("DeptID") %>'
                                                                                                                                                    meta:resourcekey="lbldeptidResource1"></asp:Label>
                                                                                                                                                <asp:Label runat="server" ID="lblStatus" Visible="False" Text='<%# Eval("Status") %>'
                                                                                                                                                    meta:resourcekey="lblStatusResource2"></asp:Label>
                                                                                                                                                <asp:Label ID="lblPackageName" runat="server" Text=""></asp:Label>
                                                                                                                                                <asp:Label runat="server" ID="lblReportURl" Style="display: none;" Text='<%# Eval("IsDefault") %>'
                                                                                                                                                    meta:resourcekey="lbldeptidResource1"></asp:Label>
                                                                                                                                            </td>
                                                                                                                                            <td>
                                                                                                                                                <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                                                                                                                    runat="server" Visible="False" Text="Show" CommandName="ShowReport" meta:resourcekey="lnkShowResource1"
                                                                                                                                                    OnClientClick="return ShowHideReport();"></asp:LinkButton>
                                                                                                                                            </td>
                                                                                                                                            <td> <asp:LinkButton ID="lnkRISPdf" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                                                                                                                    runat="server" Visible="False" Text="View" CommandName="RISPDF"   ></asp:LinkButton>
                                                                                                                                                    </td>
                                                                                                                                        </tr>
                                                                                                                                    </table>
                                                                                                                                </ItemTemplate>
                                                                                                                            </asp:DataList>
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                </table>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:DataList>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="color: #000000;" class="a-center h-20">
                                                                                                        <asp:LinkButton ID="lnkShowReport" OnClientClick="javascript:return ValidateCheckBox();ShowHideReport();"
                                                                                                            runat="server" Text="ShowReport" CommandName="ShowReport" CssClass="btn" meta:resourcekey="lnkShowReportResource1"></asp:LinkButton>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                    </div>
                                                                </td>
                                                                <td id="Td6" runat="server">
                                                                    <table runat="server" visible="False" style="background-color: #fcecb6" id="tblcontent">
                                                                        <tr id="Tr6" runat="server">
                                                                            <td id="Td7" class="alterimg" runat="server">
                                                                            </td>
                                                                            <td id="Td8" runat="server">
                                                                                <b>
                                                                                    <asp:Label ID="lblinstallviewer" runat="server" Text="If you are viewing the images for the first time, please install the viewer."
                                                                                        meta:resourcekey="lblinstallviewerResource1"></asp:Label>
                                                                                </b>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="Tr7" runat="server">
                                                                            <td id="Td9" runat="server">
                                                                                &nbsp;
                                                                            </td>
                                                                            <td id="Td10" runat="server">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <img src="../Images/box_menu_bullet.png" runat="server" id="imgInstallExe" alt="error" />
                                                                                            <asp:HyperLink Font-Bold="True" ForeColor="Black" runat="server" ID="lnkInstall"
                                                                                                Text="Click to download & install Viewer" meta:resourcekey="lnkInstallResource1"></asp:HyperLink>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgInsGuide" />
                                                                                            <asp:LinkButton runat="server" Font-Bold="True" OnClick="lnkInsguide_Click" ForeColor="Black"
                                                                                                ID="lnkInsguide" Text="Click to view the Installation Guide" meta:resourcekey="lnkInsguideResource1"></asp:LinkButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgUserGuide" />
                                                                                            <asp:LinkButton runat="server" OnClick="lnkUserGuide_Click" Font-Bold="True" ForeColor="Black"
                                                                                                ID="lnkUserGuide" Text="Click to view the Viewer User Guide" meta:resourcekey="lnkUserGuideResource1"></asp:LinkButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td id="Td11" runat="server">
                                                                    <asp:HiddenField runat="server" ID="hdnInstallationGuidePath" />
                                                                    <asp:HiddenField runat="server" ID="hnUserGuidePath" />
                                                                    <asp:HiddenField runat="server" ID="hdnIpaddress" />
                                                                    <asp:HiddenField runat="server" ID="hdnPortNumber" />
                                                                    <asp:HiddenField runat="server" ID="hdnPath" />
                                                                    <asp:HiddenField runat="server" ID="hdnCollectVisitID" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="v-top">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="colorforcontent w-30p h-23 a-left">
                                                        <div id="ACX3plus2" style="display: none;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                                                onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                            <span class="dataheader1txt pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                &nbsp;<asp:Label ID="Label3" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                        <div id="ACX3minus2" style="display: block;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                                                                onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                            <span class="dataheader1txt pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                <asp:Label ID="Label6" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="ACX3responses2" style="display: table;" class="w-100p">
                                                <tr>
                                                    <td class="a-right">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnPrint" runat="server" Text="Print Report" OnClick="btnPrint_Click1"
                                                                        OnClientClick="PrintbtnConfirm();" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" Style="display: none;" meta:resourcekey="btnPrintResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnSendMail" runat="server" Text="Send Mail" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" OnClick="btnSendMail_Click" Style="display: none;"
                                                                        meta:resourcekey="btnSendMailResource1" />
                                                                    <asp:HiddenField ID="hdnShowReport" runat="server" Value="false" />
                                                                    <asp:HiddenField ID="hdnPrintbtnInReportViewer" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="v-top w-95p">
                                                        <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                                            Font-Size="8pt" meta:resourcekey="rReportViewerResource1" WaitMessageFont-Names="Verdana"
                                                            WaitMessageFont-Size="14pt">
                                                            <ServerReport ReportServerUrl="" />
                                                        </rsweb:ReportViewer>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" id="td21" runat="server">
                                                        <asp:Panel ID="Panelpdfupload" runat="server" Style="display: none; height: 540px;
                                                            width: 1050px;" ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup" meta:resourcekey="PanelpdfuploadResource1">
                                                            <%--<asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; 600px; width: 1050px;"
                                        ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup">--%>
                                                            <div id="div8">
                                                                <table border="0" cellpadding="2" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                                                    <tr id="tr9" runat="server">
                                                                        <td>
                                                                            <select id="ddlsourceimg" runat="server" class="ddl" style="width: 130px;" title="Select File Name to View">
                                                                            </select>
                                                                            <select id="ddlPdfsourcelist" runat="server" class="ddl" style="width: 130px;" title="Select File Name to View">
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trPicPatientpdf" runat="server">
                                                                        <td id="Td22" width="2%">
                                                                            <img id="img3" runat="server" alt="Patient Photo" src="~/Images/no_Docs.png" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trfrpdf" runat="server">
                                                                        <td>
                                                                            <iframe id="ifpdf2" runat="server" width="1000" height="550"></iframe>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
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
                    <%--For Outsource document--%>
                    <tr>
                        <td align="center" id="td20" runat="server">
                            <asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; height: 540px; width: 1050px;"
                                ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup" meta:resourcekey="pnlOutDocResource1">
                                <%--<asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; 600px; width: 1050px;"
                                        ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup">--%>
                                <div id="div7">
                                    <table border="0" cellpadding="2" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                        <tr id="trddlOutsourceDoc" runat="server">
                                            <td>
                                                <select id="ddlOutsourceDocList" runat="server" class="ddl" style="width: 130px;"
                                                    title="Select File Name to View">
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="trPicPatient1" runat="server">
                                            <td id="Td18" width="2%">
                                                <img id="imgPatient1" runat="server" alt="Patient Photo" src="~/Images/no_Docs.png" />
                                            </td>
                                        </tr>
                                        <tr id="trPDF1" runat="server">
                                            <td>
                                                <iframe id="ifPDF1" runat="server" width="1000" height="550"></iframe>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input id="btnClose1" runat="server" class="btn" type="button" value="Close" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="button" id="Button2" runat="server" style="display: none;" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                            <cc1:ModalPopupExtender ID="mpopOutDoc" runat="server" BackgroundCssClass="modalBackground"
                                DropShadow="false" PopupControlID="pnlOutDoc" CancelControlID="btnClose1" TargetControlID="Button2"
                                Enabled="True">
                            </cc1:ModalPopupExtender>
                        </td>
                    </tr>
                    <%-- Outsource doc End--%>
                </table>
                <asp:HiddenField ID="hdnHideReportTemplate" Value="0" runat="server" />
                <asp:HiddenField ID="hdnAccessionNumber" Value="0" runat="server" />
                <asp:HiddenField ID="hdnSingle" Value="0" runat="server" />
                <asp:HiddenField ID="hdnInvName" Value="0" runat="server" />
                <asp:HiddenField ID="hdnTemplateId" runat="server" />
                <asp:HiddenField ID="hdnlstInvSelected" runat="server" />
                <asp:HiddenField ID="hdnSelectedMailButton" runat="server" />
                <input type="hidden" id="hdnDue" runat="server" value="0.00" />
                <asp:HiddenField ID="hdOrgID" runat="server" />               
                
          
            
         
                
                
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updatePanel2" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="hiddenTargetControlForModalPopup2" runat="server" Style="display: none"
                                meta:resourcekey="hiddenTargetControlForModalPopup2Resource1" />
                            <cc1:ModalPopupExtender ID="rptMdlPopup2" runat="server" PopupControlID="pnlAttrib2"
                                TargetControlID="hiddenTargetControlForModalPopup2" BackgroundCssClass="modalBackground"
                                CancelControlID="btnCnl2" DynamicServicePath="" Enabled="True">
                            </cc1:ModalPopupExtender>
                            <asp:Panel ID="pnlAttrib2" BorderWidth="1px" Height="95%" Width="80%" CssClass="modalPopup dataheaderPopup"
                                runat="server" meta:resourcekey="pnlAttrib2Resource1" Style="display: none; background-color: White;">
                                <table class="w-100p" style="height: 100%">
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnClientAttributes" runat="server" Text="Print" OnClientClick="return popupprint();"
                                                CssClass="btn" meta:resourcekey="btnClientAttributesResource1" />
                                            <%--<input type="button" id="btnClientAttributes" value="Print" class="btn" onclick="return popupprint();" />--%>
                                            <asp:Button ID="btnCnl2" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnCnl2Resource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="v-top">
                                            <div class="w-100p" style="overflow: auto; height: 500px;">
                                                <div id="printANCCS">
                                                    <uc41:NotesPattern ID="FckEdit1" runat="server" />
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                    TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                    CancelControlID="img1" DynamicServicePath="" Enabled="True">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                    <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                </td>
                                <td align="right">
                                    <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        class="pointer" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="w-100p">
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right v-middle">
                                <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                            </td>
                            <td class="a-left">
                                <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                    runat="server" meta:resourcekey="txtMailAddressResource1" />
                                <p class="marginT2 marginB5 font11" style="color: #666;">
                                    <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                        meta:resourcekey="lblMailAddressHintResource1" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center" colspan="2">
                                <asp:Button ID="btnSendMailReport" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClientClick="return CheckMailAddress();"
                                    OnClick="btnSendMailReport_Click" meta:resourcekey="btnSendMailReportResource1" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="upMailReport" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <cc1:ModalPopupExtender ID="modelPopExtMailReport" runat="server" PopupControlID="pnlMailReport"
                    TargetControlID="HiddenField1" BackgroundCssClass="modalBackground" CancelControlID="imgPopupClose"
                    DynamicServicePath="" Enabled="True">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="pnlMailReport" BorderWidth="1px" Height="65%" Width="55%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                    <asp:Panel ID="Panel1" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="Dispatch Report" meta:resourcekey="Label1Resource2"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <img id="imgPopupClose" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <table class="w-80p">
                                    <tr>
                                        <td style="display: none">
                                            <asp:Label ID="lbldisptch" runat="server" Text="Dispatch Type" meta:resourcekey="lbldisptchResource1" />
                                        </td>
                                        <td style="display: none">
                                            <asp:Panel ID="panelDispatchType1" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="true"
                                                meta:resourcekey="panelDispatchType1Resource1">
                                                <asp:CheckBoxList ID="ChckdespatchType" RepeatDirection="Vertical" runat="server"
                                                    Font-Size="10px" Font-Bold="true" meta:resourcekey="ChckdespatchTypeResource1">
                                                </asp:CheckBoxList>
                                                <%--    <asp:DropDownList ID="ddldespatch" runat="server" CssClass="ddl" Width="155px" 
                                                                meta:resourcekey="ddldespatchResource1" />--%></asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="display: none">
                                            <asp:Label ID="lbldespatchmode" runat="server" Text="Dispatch Mode" meta:resourcekey="lbldispatchmodeResource1" />
                                        </td>
                                        <td style="display: none">
                                            <asp:Panel ID="panelDispatchMode1" runat="server" CssClass="dataheaderInvCtrl" Width="98%"
                                                Font-Bold="true" meta:resourcekey="panelDispatchMode1Resource1" >
                                                <asp:CheckBoxList ID="chkDespatchMode1" RepeatDirection="Horizontal" runat="server"
                                                    Font-Size="10px" Font-Bold="true" meta:resourcekey="chkDespatchMode1Resource1">
                                                </asp:CheckBoxList>
                                                <%-- <asp:DropDownList ID="ddlDespatchMode" runat="server" CssClass="ddl" 
                                                                Width="155px" meta:resourcekey="ddlDespatchModeResource1">
                                                            </asp:DropDownList>--%></asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblCourierBoyName" runat="server" Text="Courier Boy Name" meta:resourcekey="lblCourierBoyNameResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtcoruriersname" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtcoruriersnameResource1" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="txtcoruriersname"
                                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                OnClientItemSelected="GetEmpIDs" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                            <asp:HiddenField ID="hdncourierboyid" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label116" runat="server" Text="Dr Courier" meta:resourcekey="lblCourierBoyNameResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDRCoruriersname" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtcoruriersnameResource1" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" TargetControlID="txtDRCoruriersname"
                                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                OnClientItemSelected="GetDocEmpIDs" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                            <asp:HiddenField ID="hdncourierboyid1" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbldespatchdate" runat="server" Text="Dispatch Home Date" AssociatedControlID="txtdispatchdate"
                                                meta:resourcekey="lbldespatchdateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtdispatchdate" ToolTip="Home Delivery Date" runat="server" CssClass="txtboxps"
                                                meta:resourcekey="txtdispatchdateResource1" />
                                            <asp:ImageButton ID="imgbtnCalendar" runat="server" ImageUrl="../Images/Calendar_scheduleHS.png"
                                                meta:resourcekey="imgbtnCalendarResource1" />
                                            <cc1:CalendarExtender ID="CalendarExtender3" TargetControlID="txtdispatchdate" Format="MM/dd/yyyy"
                                                OnClientDateSelectionChanged="dateselect" PopupButtonID="imgbtnCalendar" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label117" runat="server" Text="Dispatch Dr Delivery Date"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtdispatchdate1" ToolTip="Dr Delivery Date" runat="server" CssClass="txtboxps"
                                                meta:resourcekey="txtdispatchdate1Resource1" />
                                            <asp:ImageButton ID="imgbtnCalendar1" runat="server" ImageUrl="../Images/Calendar_scheduleHS.png"
                                                meta:resourcekey="imgbtnCalendar1Resource1" />
                                            <cc1:CalendarExtender ID="CalendarExtender4" TargetControlID="txtdispatchdate1" Format="MM/dd/yyyy"
                                                OnClientDateSelectionChanged="dateselect1" PopupButtonID="imgbtnCalendar1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="display: none">
                                            <asp:Label ID="lblPatientMobileNo" runat="server" Text="Mobile No" meta:resourcekey="lblPatientMobileNoResource1" />
                                        </td>
                                        <td style="display: none">
                                            <asp:TextBox ID="txtPatientMobileNo" runat="server" meta:resourcekey="txtPatientMobileNoResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="display: none">
                                            <asp:Label ID="lblPatientMail" runat="server" Text="Mail To" meta:resourcekey="lblPatientMailResource1" />
                                        </td>
                                        <td style="display: none">
                                            <asp:TextBox ID="txtPatientMail" runat="server" TextMode="MultiLine" Columns="50"
                                                meta:resourcekey="txtPatientMailResource1" />
                                            &nbsp; &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblcomments" runat="server" Text="Comments" meta:resourcekey="lblcommentsResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtcomments" runat="server" TextMode="MultiLine" Columns="50" meta:resourcekey="txtcommentsResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="a-center">
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="v-top a-left" style="display: none;">
                                <asp:Label ID="lbldespatches" runat="server" Text="Dispatch Patients Investigations"
                                    Font-Bold="True" meta:resourcekey="lbldespatchesResource1" /><br />
                                <br />
                                <asp:Label ID="lbldespatchnames" runat="server" ForeColor="Red" meta:resourcekey="lbldespatchnamesResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center" colspan="2">
                                <asp:Button ID="btndespatch" runat="server" Text="Dispatch" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btndispatch_Click" OnClientClick="return checkdispatch();"
                                    meta:resourcekey="btndespatchResource1" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <%--<asp:AsyncPostBackTrigger ControlID="btndespatch" EventName="btndispatch_Click" />--%>
                <asp:PostBackTrigger ControlID="btndespatch" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdateLabelPrintPanel" runat="server">
            <ContentTemplate>
                <asp:Panel ID="pnlPatientDetail" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlPatientDetailResource1" ScrollBars="Auto"
                    Style="display: none">
                    <table>
                        <tr>
                            <td class="a-right">
                                <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbar3" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbar3Resource1" />
                                        <asp:Label ID="Rs_Pleasewait3" Text="Please wait...." runat="server" meta:resourcekey="Rs_Pleasewait3Resource1" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td class="right">
                                <%-- <img id="imgCloseLabelReport" src="../Images/dialog_close_button.png" runat="server"
                                                        alt="Close" style="cursor: pointer;" />--%>
                                <input id="imgCloseLabelReport" type="button" value="Close" name="Close" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <ucPatientdet:PatientDetails ID="PatientDetailsLabel" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="w-80p">
                                                <tr>
                                                    <td>
                                                        <asp:Label nowrap="nowrap" ID="LabelDispatchType" runat="server" Text="Dispatch Type"
                                                            meta:resourcekey="LabelDispatchTypeResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Panel ID="chkDispatchTypeLabelPanel" runat="server" CssClass="dataheaderInvCtrl"
                                                            Font-Bold="true" meta:resourcekey="chkDispatchTypeLabelPanelResource1">
                                                            <asp:CheckBoxList ID="chkDispatchTypeLabel" RepeatDirection="Vertical" runat="server"
                                                                Font-Size="10px" Font-Bold="true" meta:resourcekey="chkDispatchTypeLabelResource1">
                                                            </asp:CheckBoxList>
                                                        </asp:Panel>
                                                    </td>
                                                    <td>
                                                        <asp:Label nowrap="nowrap" ID="LabelDispatchMode" runat="server" Text="Dispatch Mode"
                                                            meta:resourcekey="lLabelDispatchModeResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Panel ID="chkDespatchModeLabelPanel" runat="server" CssClass="dataheaderInvCtrl"
                                                            Width="98%" Font-Bold="true" meta:resourcekey="chkDespatchModeLabelPanelResource1">
                                                            <asp:CheckBoxList ID="chkDespatchModeLabel" RepeatDirection="Horizontal" runat="server"
                                                                Font-Size="10px" Font-Bold="true" meta:resourcekey="chkDespatchModeLabelResource1">
                                                            </asp:CheckBoxList>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="ViewLabelPanel" runat="server" CssClass="dataheaderInvCtrl w-100p"
                                                Font-Bold="True" meta:resourcekey="ViewLabelPanelResource1">
                                                <table cellpadding="8" class="w-100p">
                                                    <tr>
                                                        <td colspan="8">
                                                            <%-- <input id="rdViewAllLabel" type="checkbox" name="label" runat="server" /><label id="Label16"
                                                                                        runat="server"><asp:Label ID="Label17" Text="View Label" runat="server" meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>--%>
                                                            <input id="rdLabel1" type="radio" name="label" runat="server" /><label id="lblLabel1"
                                                                runat="server"><asp:Label ID="Rs_CaseNoteSticker" Text="Case Note/ File Label" runat="server"
                                                                    meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>
                                                            <input id="rdLabel2" type="radio" name="label" runat="server" value="2" /><label
                                                                id="lblLabel2" runat="server"><asp:Label ID="Rs_AddressSticker" Text="Patient Address Label"
                                                                    runat="server" meta:resourcekey="Rs_AddressStickerResource1"></asp:Label></label>
                                                            <%-- <input id="rdHomeDispatch" type="radio" name="label" runat="server" value="7" /><label
                                                                                        id="Label18" runat="server"><asp:Label ID="Rs_HomeDispatchSticker" Text="Home Dispatch Label"
                                                                                            runat="server" meta:resourcekey="Rs_HomeDispatchStickerResource1"></asp:Label></label>--%>
                                                            <input id="rdDoctorDispatch" type="radio" name="label" runat="server" value="8" /><label
                                                                id="Label19" runat="server"><asp:Label ID="Rs_DoctorDispatchSticker" Text="Doctor Dispatch Label"
                                                                    runat="server" meta:resourcekey="Rs_DoctorDispatchStickerResource1"></asp:Label></label>
                                                            <span style="white-space: nowrap">
                                                                <%--  <input id="rdLabel3" type="radio" name="label" runat="server" value="3" /><label
                                                                                        id="lblLabel3" runat="server"><asp:Label ID="Rs_LabSticker" Text="Lab Label" runat="server"
                                                                                            meta:resourcekey="Rs_LabStickerResource1"></asp:Label></label>
                                                                                         <input id="rdDispatchSticker" type="radio" name="label" runat="server" value="4" /><label
                                                        id="Label4" runat="server"><asp:Label ID="Rs_DispatchSticker" 
                                                        Text="Dispatch Sticker" runat="server" meta:resourcekey="Rs_DispatchStickerResource1"></asp:Label></label>
                                                 
                                                  <input id="rdRadiology" type="radio" name="label" runat="server" value="5" /><label
                                                        id="Label5" runat="server"><asp:Label ID="Rs_RadiologySticker" 
                                                        Text="Radiology / Sonology  Sticker" runat="server" 
                                                        meta:resourcekey="Rs_RadiologyStickerResource1"></asp:Label></label>
                                                  <span style="white-space:nowrap">--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="8">
                                                            <%--        <input id="rdHealthCheckUp" type="radio" name="label" runat="server" value="6" /><label
                                                        id="Label16" runat="server"><asp:Label ID="Rs_HealthCheckUpSticker"  
                                                        Text="Health Check Up Sticker" runat="server" 
                                                        meta:resourcekey="Rs_HealthCheckUpStickerResource1"></asp:Label></label> </span>--%>
                                                            <%--     <input id="rdECGorStress" type="radio" name="label" runat="server" value="9" /><label
                                                        id="Label9" runat="server"><asp:Label ID="Rs_ECGorStress" 
                                                        Text="ECG / Stress Test Sticker" runat="server" meta:resourcekey="Rs_ECGorStressResource1"></asp:Label></label></span>
                                                 <input id="Checkbox1" type="checkbox" name="label" runat="server" checked value="1" /><label
                                                        id="Label3" runat="server"><asp:Label ID="Label6" 
                                                        Text="Case Note Sticker" runat="server" 
                                                        meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnPrintLabel" runat="server" Text="View Label" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnPrintLabel_Click" meta:resourcekey="btnPrintLabelResource1" />
                                            <asp:HiddenField ID="hdnShowLabelReport" runat="server" Value="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="v-top">
                                <table class="w-100p">
                                    <tr>
                                        <td class="colorforcontent w-30p h-23 a-left">
                                            <div id="Div1" style="display: none;">
                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                                    onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                <span class="dataheader1txt pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                    &nbsp;<asp:Label ID="Label8" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                            <div id="Div2" style="display: block;">
                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                                                    onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                <span class="dataheader1txt pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                    <asp:Label ID="Label15" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <rsweb:ReportViewer ID="rReportViewer2" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                    Font-Size="8pt" meta:resourcekey="rReportViewer2Resource1">
                                    <ServerReport ReportServerUrl="" />
                                </rsweb:ReportViewer>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:HiddenField ID="hdnModelPopupPrintLabel" runat="server" />
                <cc1:ModalPopupExtender ID="ModalPopupLabelPrintExtender1" runat="server" PopupControlID="pnlPatientDetail"
                    TargetControlID="hdnModelPopupPrintLabel" BackgroundCssClass="modalBackground"
                    CancelControlID="imgCloseLabelReport" DynamicServicePath="" Enabled="True">
                </cc1:ModalPopupExtender>
                <asp:HiddenField ID="HiddenField3" runat="server" />
                <asp:HiddenField ID="HdnReportParameter" runat="server" />
            </ContentTemplate>
            <Triggers>
                <%-- <asp:PostBackTrigger ControlID="btnPrintLabel" />--%>
                <asp:AsyncPostBackTrigger ControlID="btnPrintLabel" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
           <table class="w-95p" style="display: table;" runat="server" id="tblPDFReportViewerProduct">
                    <tr>
                        <td>
                            <%--       <asp:LinkButton ID="lnkPDFReportPreviewerProduct" runat="server" Text="Show Report Preview"
                                Font-Underline="true" ForeColor="Blue"  />--%>
                            <asp:HiddenField ID="hdnTargetCtlReportPreviewProduct" runat="server" />
                            <ajc:ModalPopupExtender ID="mpReportPreviewProduct" runat="server" PopupControlID="pnlReportPreviewProduct"
                                TargetControlID="hdnTargetCtlReportPreviewProduct" BackgroundCssClass="modalBackground"
                                CancelControlID="imgPDFReportPreviewProduct" DynamicServicePath="" Enabled="True">
                            </ajc:ModalPopupExtender>
                    <asp:Panel ID="pnlReportPreviewProduct" CssClass="modalPopup dataheaderPopup w-90p mdlpop"
                                runat="server"  Style="display: none;">
                                <asp:Panel ID="pnlReportPreviewHeaderProduct" runat="server" CssClass="dialogHeader" >
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblReportPreviewHeaderProduct" runat="server" Text="Report Preview" ></asp:Label>
                                            </td>
                                            <td class="a-right">
                                                <img id="imgPDFReportPreviewProduct" src="../Images/dialog_close_button.png" runat="server"
                                                    alt="Close" style="cursor: pointer;" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table class="w-100p">
                                    <tr style="vertical-align: top;">
                                        <td>
                                            <table id="tblViewPreviewTRF" runat="server" class="w-100p" style="display: none;">
                                                <tr id="Tr12" runat="server">
                                                    <td id="Td24" class="colorforcontent w-30p h-23 a-left" runat="server">
                                                        <div id="Div9" style="display: block;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);">
                                                                &nbsp;<asp:Label ID="Label23" runat="server" Text="Show TRF" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                        <div id="Div10" style="display: none;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);">
                                                                <asp:Label ID="Label24" runat="server" Text="Hide TRF" meta:resourcekey="lblReportTemplateResource11"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="Table4" class="v-top w-100p" style="display: none;">
                                                <tr class="v-top">
                                                    <td>
                                                        <TRF:ViewTRFImage ID="ViewPreviewTRF" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="h-5">
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="colorforcontent w-30p h-23 a-left">
                                                        <div id="Div11" style="display: none;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                &nbsp;<asp:Label ID="Label25" runat="server" Text="Show Report" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                        <div id="Div12" style="display: block;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                <asp:Label ID="Label26" runat="server" Text="Hide Report" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="Table5" style="display: table;" class="w-100p">
                                                <tr>
                                                    <td>
                                                        <div id="iframeplaceholderForProducttest" runat="server" class="w-100p" style="height: auto;">
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
        <br />
    </div>
    <input type="hidden" id="hdnPDFType" name="PType" runat="server" />
    <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
    <input type="hidden" id="hdnPID" name="pid" runat="server" />
    <input type="hidden" id="hdnVID" name="vid" runat="server" />
    <input type="hidden" id="hdnVisitDetail" runat="server" />
    <input type="hidden" id="patOrgID" runat="server" name="patOrgID" />
    <input type="hidden" id="ChkID" runat="server" />
    <input type="hidden" id="hdndeptid" runat="server" />
    <input type="hidden" id="hdndeptvalues" runat="server" />
    <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
    <asp:HiddenField ID="Hdndisablebox" runat="server" />
    <asp:HiddenField ID="hdnHideDetails" Value="0" runat="server" />
    <asp:HiddenField ID="hdnReferralType" runat="server" />
    <asp:HiddenField ID="hdnEMail" runat="server" />
    <asp:HiddenField ID="hdnClientID" runat="server" />
    <asp:HiddenField ID="HdnID" runat="server" />
    <asp:HiddenField ID="hdncreditlimit" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnclientBlock" runat="server" />
    <asp:HiddenField ID="hdnrolename" runat="server" />
    <asp:HiddenField ID="hdndespatchvisit" runat="server" />
    <asp:HiddenField ID="hdndespatchClientId" runat="server" />
    <asp:HiddenField ID="hdnpreviousdue" runat="server" />
    <asp:HiddenField ID="hdnonoroff" runat="server" Value="N" />
    <asp:HiddenField ID="hdnclientdue" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnDispatchType" runat="server" Value="" />
    <asp:HiddenField ID="hdnDispatchMode" runat="server" Value="" />
    <input type="hidden" id="hdnHealthcheckup" runat="server" value="N" />
    <asp:HiddenField ID="hdnDispatch" runat="server" Value="" />
    <asp:HiddenField ID="hdnHomeList" runat="server" Value="" />
    <asp:HiddenField ID="hdnDoctorList" runat="server" Value="" />
    <asp:HiddenField ID="hdnPartial" runat="server" Value="" />
    <asp:HiddenField ID="hdnPending" runat="server" Value="" />
    <input type="hidden" id="hdnIsGeneralClient" runat="server" value="" />
    <input type="hidden" id="hdnPriority" name="Priority" runat="server" />
       <asp:HiddenField ID="hdnClientPrtlChkLst" runat="server" Value="" />
	         
			   	          <asp:HiddenField ID="hdnchkApproveOly" runat="server" Value="" />
    <%-- <applet archive="launchexe_signed.jar" code="launchexe.class" id="apltLaunchExe"
            name="apltLaunchExe" width="1" height="1">
        </applet>--%>
    <%--
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript">
        function onPrintPolicy(printType, VID, RoleID, patOrgID, url, DispatchType, BillPrintUrl, ClientID, IsGeneralClient, DueAmount, IsPrintAllow) {
            /* Added By Venkatesh S */            
            var vExceeded = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_30') == null ? "You exceeded the maximum number of print(s). Are you sure you want to continue?" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_30');
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var btnok = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37') == null ? "Ok" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37');
            var btncancel = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38') == null ? "Cancel" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38');
            
            if (document.getElementById('hdnrolename').value == "Dispatch Controller") {
                window.open(url, "labelprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
            }

            // window.open(url, "labelprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
            if (document.getElementById('hndBillprintHide').value == "N") {
                window.open(BillPrintUrl, "BillPrint", "letf=0,top=-20,toolbar=0,scrollbars=yes,status=0");
            }
            var isPrintable = true;
            var isExceeded = false;
            var lstReportPrintHistory = [];
            var orgid = 0;
            var visitid = 0;
            try {
                if ($("#hdnlstInvSelected").val() != '') {
                    lstReportPrintHistory = JSON.parse($("#hdnlstInvSelected").val());
                    $.each(lstReportPrintHistory, function(i, obj) {
                        obj.CreatedAt = Date.parseLocale(obj.CreatedAt, 'dd-MM-yyyy hh:mm:sstt');
                        if (obj.CreatedAt == null) {
                            obj.CreatedAt = new Date();
                        }
                    });
                }
                else {
                    var AccessionNumber = 0;
                    var InvestigationID = 0;
                    lstReportPrintHistory.push({
                        AccessionNumber: AccessionNumber,
                        InvestigationID: InvestigationID
                    });
                }
                if (printType == 'batch') {
                    orgid = patOrgID;
                    visitid = VID;
                }
                else {
                    orgid = $("#patOrgID").val();
                    visitid = $("#hdnVID").val()
                }
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetPrintPolicy",
                    data: "{patOrgID: " + orgid + ",VisitID: " + visitid + ",PrintReport: '" + JSON.stringify(lstReportPrintHistory) + "',PrintType: '" + printType + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function Success(data) {
                        isExceeded = data.d;
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        return true;
                    }
                });
                if (isExceeded == true) {
                    var userMsg = SListForApplicationMessages.Get("Investigation\\InvestigationReport.aspx_40");
                    if (userMsg != null) {
                        confirm(userMsg);
                        return false;
                    }
                    else {
                        var result = ConfirmWindow(vExceeded,AlertType,btnok,btncancel);
                    }
                    if (result == true) {
                        isPrintable = true;
                    }
                    else {
                        isPrintable = false;
                    }
                }
                else {
                    isPrintable = true;
                }
                if (isPrintable) {
                    if (printType == 'batch') {
                        PrintBatchReport(VID, RoleID);
                        //                        var browser_info = perform_acrobat_detection();
                        //                        if (browser_info.acrobat == null) {
                        //                            alert("Please install adobe reader to perform print functionality");
                        //                        }
                        //                        else {
                        //                            $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + VID + "&roleid=" + RoleID + "' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
                        //                        }
                    }
                    else {
                        onPrintSingleReport();
                        //                        var reportViewer = $find("rReportViewer");
                        //                        if (reportViewer != null) {
                        //                            var disablePrint = reportViewer.get_isLoading() ||
                        //                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;
                        //                            if (!disablePrint) {
                        //                                reportViewer.invokePrintDialog();
                        //                                return true;
                        //                            }
                        //                            else {
                        //                                alert("Unable to print report");
                        //                                return false;
                        //                            }
                        //                        }
                    }
                }
            }
            catch (e) {
                return false;
            }
            return isPrintable;
        }
    </script>

    <script type="text/javascript" language="javascript">
        //        if (document.getElementById('hdnHideDetails').value == "1") {
        //            showResponses('ACX2plus3', 'ACX2minus3', 'ACX2responses3', 0);
        //        }
        if (document.getElementById('hdnReferralType').value == "I") {
            document.getElementById('tdRPinternal').style.display = 'table-cell';
            document.getElementById('tdRPExternal').style.display = 'none';
        }
        if (document.getElementById('hdnReferralType').value == "E") {
            document.getElementById('tdRPExternal').style.display = 'table-cell';
            document.getElementById('tdRPinternal').style.display = 'none';
        }
        ShowHideReport();
        function SetToDate() {
            NewCal('<%=txtdispatchdate.ClientID %>', 'ddmmyyyy', true, 12)
            return true;
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function() {
            //ChangeDDLItemListWidth();
        });
    </script>

    <script language="javascript" type="text/javascript">
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceDiv').style.width = 'auto';
            document.getElementById('aceClient').style.width = 'auto';
            document.getElementById('aceReferDR').style.width = 'auto';
            document.getElementById('DivPatientName').style.width = 'auto';
            document.getElementById('Divzone').style.width = 'auto';
        }
    </script>

    <div id="iframeplaceholder">
    </div>
    
     
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hndBillprintHide" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <asp:HiddenField ID="hdnPrintReport" runat="server" />
    <asp:HiddenField ID="hdnConfirmprint" runat="server" Value="No" />
    <asp:HiddenField ID="hdnParameters" Value="" runat="server" />
    <asp:HiddenField ID="hdnisduebill" runat="server" Value="0" />
      <asp:HiddenField ID="hdnPreviousLabNumber" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsAdvanceConsumed" runat="server" Value="0" />
    <asp:HiddenField ID="hdnResPrint" runat="server" Value="N" />
    
        <asp:HiddenField ID="hdnReportType" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
        function onChangeFile1(objID) {

            var orgId = $("[id$='hdnOrgID']").val();
            try {
                var index = objID.lastIndexOf("_");
                var prefixId = objID.substring(0, index + 1);
                $('#' + prefixId + 'trPicPatient1').hide();
                $('#' + prefixId + 'trPDF1').hide();
                $('#' + prefixId + 'imgPatient1').attr('src', '<%=ResolveUrl("~/Images/No_Docs.png")%>');
                $('#' + prefixId + 'ifPDF1').html('');
                selectedOption1 = $('#' + objID + ' option:selected');
                if ($(selectedOption1).val() != 0) {
                    if ($(selectedOption1).val().indexOf('.pdf') != -1) {
                        $('#' + prefixId + 'trPicPatient1').hide();
                        $('#' + prefixId + 'trPDF1').show();
                        $('#' + prefixId + 'ifPDF1').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption1).val() + '&OrgID=' + orgId + '")%>');
                    }
                    else {
                        $('#' + prefixId + 'trPicPatient1').show();
                        $('#' + prefixId + 'trPDF1').hide();
                        $('#' + prefixId + 'imgPatient1').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption1).val() + '&OrgID=' + orgId + '")%>');
                    }
                }
                return false;
            }
            catch (e) {
                return false;
            }
        }
        function Printalert(OrgId, Locationid, Visitid) {
            if (confirm("Do you want to Print?")) {
                $('#ifPDF').show();
                var Type = 'Print';
                var Emailaddress = '';
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/InsertNotificationManual",
                    contentType: "application/json; charset=utf-8",
                    data: "{ OrgId: '" + OrgId + "',Locationid: '" + Locationid + "',Visitid: '" + Visitid + "',Type: '" + Type + "',Emailaddress: '" + Emailaddress + "'}",
                    dataType: "json",
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        return false;
                    }
                });


            } else {
                //$find('modalPopUp').hide();
                // $('#ifPDF').hide();

            }
        }

        $('#chkExportPdf').click(function() {
            if ($(this).is(':checked')) {

                document.getElementById('tdExportReport').style.display = "table-cell";
                document.getElementById('tdshowreport').style.display = "none";

            }
            else {

                document.getElementById('tdshowreport').style.display = "table-cell";
                document.getElementById('tdExportReport').style.display = "none";
            }
        });
        $('#chkExportWord').click(function() {
            if ($(this).is(':checked')) {

                document.getElementById('tdExportWordDoc').style.display = "table-cell";
                //document.getElementById('tdshowreport').style.display = "none";

            }
            else {

               // document.getElementById('tdshowreport').style.display = "table-cell";
                document.getElementById('tdExportWordDoc').style.display = "none";
            }
        });
        function PrintbtnConfirm() {
            var vPrint = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_31') == null ? "Do you want to print?" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_31');
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var btnok = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37') == null ? "Ok" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_37');
            var btncancel = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38') == null ? "Cancel" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_38');
            var dummy = ConfirmWindow(vPrint, AlertType, btnok, btncancel);
            if (dummy==true) {
                document.getElementById("hdnConfirmprint").value = "Yes";
            } else {
                document.getElementById("hdnConfirmprint").value = "No";
            }
        }
        function Showreportlang() {
         if ($('#ddlVisitActionName option:selected').val() == "Manual_Generate_Report")
         {
          document.getElementById('ddlreplang').style.display = 'inline-block'; 
         }
         else {
             document.getElementById('ddlreplang').style.display = 'none'; 
         }
            
        }

    </script>

</body>
</html>

<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

