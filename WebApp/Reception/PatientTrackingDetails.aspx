<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientTrackingDetails.aspx.cs"
    Inherits="Reception_PatientTrackingDetails"  EnableEventValidation="false"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="~/CommonControls/ViewCommunicationThread.ascx" TagName="CommThread"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../EMR/CapturePatientHistory.ascx" TagName="PatientCaptureHistory"
    TagPrefix="PHis" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Today's Patient Visits</title>
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <%--    <script type="text/javascript" src="../Scripts_New/datetimepicker_css.js"></script>--%>
    <%-- <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>--%>
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
 .datawrapcs td {

    /* css-3 */
    white-space: -o-pre-wrap; 
    word-wrap: break-word;
    white-space: pre-wrap; 
    white-space: -moz-pre-wrap; 
    white-space: -pre-wrap; 

}
       #lblStatus {
    padding-left: 0px !important;
               }
          #lblActionType
          {
                padding-right:40px !important;
          }     
        .gridView
        {
            table-layout: fixed;
        }
        .col
        {
            word-wrap: break-word;
        }
        .Progress
        {
            background-color: #CF4342;
            color: White;
        }
        .Progress img
        {
            vertical-align: middle;
            margin: 2px;
        }
        #UpdateProgress2
        {
            background-color: #CF4342;
            color: #fff;
            top: 0px;
            right: 0px;
            position: fixed;
        }
        #UpdateProgress2 img
        {
            vertical-align: middle;
            margin: 2px;
        }
        .style6
        {
            height: 22px;
        }
        .classNav
        {
            visibility: hidden !important;
            height: 0px !important;
            display: none !important;
        }
        .investigationO-auto{
            max-height: 223px;
            overflow: auto;
            }
            .lh15{
                line-height: 15px;
            }
            .max-height190{
                max-height: 190px;
                OVERFLOW: auto;
            }
    </style>
    <style>
        .GroupHeaderStyle
        {
            border: solid 1px Black;
            background-color: #e8e8e8;
            color: #ffffff;
            font-weight: bold;
            text-align: center;
        }
        .lh27{
                line-height: 27px;
            }
        
    </style>
 
    <script type="text/javascript" language="javascript">
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
        function DisableTRFCtrls() {
            //divLnkHistory divLnkDevicevalue  
            document.getElementById('divLnkHistory').style.display = 'none';
            document.getElementById('divLnkDevicevalue').style.display = 'none';
            document.getElementById('divOutsourceDoc').style.display = 'none';
            // 
            // document.getElementById('LnkHistory').style.display='none';
            // document.getElementById('LnkDevicevalue').style.display='none';
        }
        function hideHeader() {
            document.getElementById('header').style.display = 'none';
            document.getElementById('Attuneheader_menu').style.display = 'none';
            document.getElementById('imagetd').style.display = 'none';
            $("#navigation").addClass("classNav");
            document.getElementById('Attuneheader_TopHeader1_ImgBtnHome').style.display = 'none';
            document.getElementById('txtVisitNumber').disabled = true;
            document.getElementById('btnGo').disabled = true;
        }
        function validateMultipleEmailsCommaSeparated1(emailcntl, seperator) {
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") : "Invalid E-Mail ID";
    var value = emailcntl.value;
    if (value != '') {
        var result = value.split(seperator);
        for (var i = 0; i < result.length; i++) {
            if (result[i] != '') {
                if (!validateEmail(result[i])) {
                   // emailcntl.focus();
                    ValidationWindowEmail('' + UsrAlrtMsg + '');

                    var elements = document.getElementById('chkDespatchMode');
                    if (document.getElementById('txtMailAddress').value != '') {

                        //elements.cells[0].childNodes[0].checked = false;
                        document.getElementById('chkDespatchMode_0').checked = false;
                        /*changed by arivalagan.kk*/
                        //elements.cells[0].childNodes[0].checked = false;
                        /*changed by arivalagan.kk*/
                    }
                    return false;
                }
            }
        }
    }
    return true;
}

function validateEmail(field) {
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
    return (regex.test(field)) ? true : false;
}

function ValidationWindowEmail(message, tt) {
    jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        document.getElementById('txtMailAddress').focus();
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("Scripts_Common_js_Ok") == null ? "Ok" : SListForAppDisplay.Get("Scripts_Common_js_Ok");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }

                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "30px");
            }
        }).dialog("open");
}



//Added By QBITZ Prakash.K
function ValidateManual() {
    var ReportTypeText = $("#ddlReportType").find("option:selected").text();           // Text
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

function AddAccessionNumber(ID, varAccessionNumber, InvStatusValue) {
  
    var ReportType = $("#ddlReportType").find("option:selected").text();
    if (ReportType != "--Select--") {
        //                var InvID = ID.split('~~');
        //                var ID1 = InvID[0];
        //                var InvName = InvID[1];
        //                var IStatus = InvName.split(',');
        var InvSts = InvStatusValue;

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
function CloseextShowLiveReport() {
    if ($find('extShowLiveReport') != null)
    $find('extShowLiveReport').hide();
}

function CheckReportTypeStatus(e) {
    
    $('.chkINV').attr('checked', false);
    document.getElementById('hdnSingle').value = e.value;
    var ReportType = $('#ddlReportType option[value=' + e.value + ']').text(); //$("#ddlReportType").find("option:selected").text();
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
                 
                lstPatientVisitInvestigation = data.d;
                var invStatusFlag = false;
                var AppCount = 0;
                var ReceiveCount = 0;
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
                    else if (lstPatientVisitInvestigation[i].Status == "SampleCollected" || lstPatientVisitInvestigation[i].Status == "SampleReceived" || lstPatientVisitInvestigation[i].Status == "Pending"){
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
                            if (InvestigationStatus == 'SampleReceived' || InvestigationStatus == 'Pending' || InvestigationStatus == 'SampleCollected') {
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
                            if (invStatus == 'SampleReceived' || invStatus == 'Pending' || InvestigationStatus == 'SampleCollected') {
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
            // sHtml += "<tr><td> <input type='button' onclick='calShowReport(" + IsneedWSReport + ");' id='btnShowLiveReport' value='Show Report' class='btn' name ='ShowReport'></input></td>   </tr></table>";
            sHtml += "</table>";
            $("#tdChecknames").html(sHtml);
            
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

    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%--<ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
        <asp:UpdatePanel ID="UdtPanel" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UdtPanel" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img3" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                    <%--<ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div class="a-center" id="processMessage">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                        </div>
                    </ProgressTemplate>--%>
                </asp:UpdateProgress>
                <%--                <table class="w-100p">
                    <tr>
                        <td>
                            
                        </td>
                    </tr>
                </table>--%>
                <table cellspacing="6" class="w-100p searchPanel">
                    <tr>
                        <td class="v-top">
                            <div id="ViewTRF" runat="server">
                                <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                            </div>
                            <div id='TabsMenu' class="a-left">
                                <ul>
                                    <li id="li1" class="active" runat="server" onclick="DisplayTab('VREG')"><a href='#'>
                                        <span>
                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_01 %>
                                        </span></a></li>
                                    <li id="li2" runat="server" onclick="DisplayTab('EPI')"><a href="#"><span>
                                        <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_02 %>
                                    </span></a></li>
                                    <li id="li4" runat="server" onclick="DisplayTab('WLD')"><a href="#"><span>
                                        <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_03 %>
                                    </span></a></li>
                                    <li id="li5" runat="server" onclick="DisplayTab('NOT')"><a href="#"><span>
                                        <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_06 %>
                                    </span></a></li>
                                    <li id="li3" runat="server" onclick="DisplayTab('CDM')" style="display: none"><a
                                        href="#"><span>
                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_04 %></span></a></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdViewRegistration" runat="server">
                            <table class="w-100p">
                                <tr>
                                    <td colspan="3">
                                    </td>
                                </tr>
                                <tr>
                                    <td id="trVisitAction" runat="server" class="defaultfontcolor" colspan="3">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-40p">
                                                    <span >
                                                        <asp:RadioButtonList ID="rdbType" runat="server" RepeatDirection="Horizontal" >
                                                            <asp:ListItem Text="Visit Number/Lab Number" Value="1" Selected="True" meta:resourcekey="ListItemResource"></asp:ListItem>
                                                            <asp:ListItem Text="Barcode Number" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem> 
                                                            <asp:ListItem Text="Case Number" Value="3" meta:resourcekey="ListItemResource3" ></asp:ListItem>
															<asp:ListItem Text="Patient ID" Value="4"  meta:resourcekey="ListItemResource4"></asp:ListItem>
															<asp:ListItem Text="SRFID" Value="5"  meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </span>
                                                </td>
                                                <td class="a-left w-15p">
                                                    <asp:TextBox ID="txtVisitNumber" runat="server" CssClass="small" meta:resourcekey="txtVisitNumberResource1"></asp:TextBox>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Button ID="btnGo" runat="server" Text="Search" CssClass="btn w-60" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="return GetVisitNumbers()" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                                </td>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td id="tdsamplefloating" runat="server" style="display: none">
                                                                <table border="1" class="w-80p">
                                                                    <tr>
                                                                        <td id="tdtransist" runat="server" class="w-25p a-center">
                                                                            <asp:Label ID="Label1" Text="Transist" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                        </td>
                                                                        <td id="tdaccession" runat="server" class="w-25p a-center">
                                                                            <asp:Label ID="Label2" Text="Accession" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                        </td>
                                                                        <td id="tdtesting" runat="server" class="w-25p a-center">
                                                                            <asp:Label ID="Label3" Text="Testing" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                                                        </td>
                                                                        <td id="tdrepauth" runat="server" class="w-25p a-center">
                                                                            <asp:Label ID="Label4" Text="ReportAuth." runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                                                        </td>
                                                                        <td id="tdreppdf" runat="server" class="w-25p a-center">
                                                                            <asp:Label ID="Label5" Text="ReportPDF" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                        </tr>
                                                        <tr align="center">
                                                            <td>
                                                                <div>
                                                                    <table id="VisitNumbertbl" style="display: none">
                                                                        <thead>
                                                                            <tr>
                                                                                <th align="center">
                                                                                    Patient ID
                                                                                </th>
                                                                                <th align="center">
                                                                                    Patient Name
                                                                                </th>
                                                                                <th align="center">
                                                                                    Mobile Number
                                                                                </th>
                                                                                <th align="center">
                                                                                    Visit Number/ Lab Number
                                                                                </th>
                                                                                <th align="center">
                                                                                    Visit Date
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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trPatDetails" runat="server" style="display: none">
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-25p v-top">
                                                    <fieldset>
                                                        <legend class="bold" style="font-size: medium; font-style: normal">
                                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_07 %>
                                                        </legend>
                                                        <table cellspacing="5" class="w-100p bg-row">
                                                            <tr>
                                                                <td class="w-50p">
                                                                    <asp:Label ID="RS_PatName" runat="server" Text="Patient Name:" meta:resourcekey="RS_PatNameResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_PatAge" runat="server" Text="Patient Age :" meta:resourcekey="Rs_PatAgeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_Gender" runat="server" Text="Gender:" meta:resourcekey="Rs_GenderResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_DOB" runat="server" Text="DOB :" meta:resourcekey="Rs_DOBResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblDOB" runat="server" meta:resourcekey="lblDOBResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_Phoneno" runat="server" Text="Phone No :" meta:resourcekey="RS_PhonenoResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblphoneno" runat="server" meta:resourcekey="lblphonenoResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_EmalID" runat="server" Text="EmailID :" meta:resourcekey="Rs_EmalIDResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblEmailID" runat="server" meta:resourcekey="lblEmailIDResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_RefDR" runat="server" Text="Refering Doctor :" meta:resourcekey="RS_RefDRResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblRefDr" runat="server" meta:resourcekey="lblRefDrResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <%--surya changes Start--%>
                                                            
                                                               <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_PreviousLabNumber" runat="server" Text="Previous Lab Number :"
                                                                        meta:resourcekey="RS_PreviousLabNumberResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPreviousLabNumber" runat="server" meta:resourcekey="lblPreviousLabNumberResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            
                                                               <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ExternalPatientNumber" runat="server" Text="PatientNumber :"
                                                                        meta:resourcekey="RS_ExternalPatientNumberResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblExternalPatientNumber" runat="server" meta:resourcekey="lblExternalPatientNumberResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            
                                                               <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_IsCumulativeReport" runat="server" Text="IsCumulativeReport :"
                                                                        meta:resourcekey="RS_IsCumulativeReportResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblIsCumulativeReport" runat="server" meta:resourcekey="lblIsCumulativeReportResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                              
                                                               <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ReportingCenter" runat="server" Text="Reporting Center :" meta:resourcekey="RS_ReportingCenterResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblReportingCenter" runat="server" meta:resourcekey="lblReportingCenterResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ReportDeliveryMode" runat="server" Text="Report Delivery Mode :"
                                                                        meta:resourcekey="RS_ReportDeliveryModeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblReportDeliveryMode" runat="server" meta:resourcekey="lblReportDeliveryModeResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_Confidential" runat="server" Text="Confidential :" meta:resourcekey="RS_ConfidentialResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblConfidential" runat="server" meta:resourcekey="lblConfidentialResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            
                                                                 <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_SpeciesType" runat="server" Text="Species Type :" meta:resourcekey="RS_SpeciesTypeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblSpeciesType" runat="server" meta:resourcekey="lblSpeciesTypeResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                              <tr>
                                                                <td id="tdsrfID" runat="server" style="display:none">
                                                                    <asp:Label ID="RS_SRFID" runat="server" Text="SRF ID :"></asp:Label>
                                                                </td>
                                                                <td id="tdsrfID1" runat="server" style="display:none">
                                                                    <asp:Label ID="lblSRFId" runat="server" ></asp:Label>
                                                                </td>
                                                            </tr>
                                                              <tr>
                                                                <td id="tdtrfID" runat="server" style="display:none">
                                                                    <asp:Label ID="RS_TRFID" runat="server" Text="TRF ID :" ></asp:Label>
                                                                </td>
                                                                <td id="tdtrfID1" runat="server" style="display:none">
                                                                    <asp:Label ID="lblTRFId" runat="server" ></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr >
                                                            <td id="tvid" runat="server" style="display:none">
                                                            <asp:Label ID="lbl_Vid" runat="server" Text="Visit Number : "></asp:Label>
                                                            </td>
                                                            <td id="tvid1" runat="server" style="display:none">
                                                            <asp:Label ID="lbl_Visitnumber" runat="server" ></asp:Label>
                                                            </td>
                                                            </tr>
                                                            <tr>
                                                            <td id="tEVNo" runat="server" style="display:none">
                                                            <asp:Label ID="lbl_EVNo" runat="server" Text="External VID :"></asp:Label>
                                                            </td>
                                                            <td id="tEVNo1" runat="server" style="display:none">
                                                            <asp:Label ID="lbl_ExVisitNo" runat="server"></asp:Label>
                                                            </td>
                                                            </tr>
                                                            
                                                            
                                                            <%--surya changes Start--%> 
                                                        </table>
                                                    </fieldset>
                                                </td>
                                                <td class="w-25p v-top">
                                                    <fieldset>
                                                        <legend class="bold" style="font-size: medium; font-style: normal">
                                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_08 %>
                                                        </legend>
                                                        <table cellspacing="5" class="w-100p bg-row">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientNAme" runat="server" Text="Client Name:" meta:resourcekey="RS_ClientNAmeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientName" runat="server" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientCode" runat="server" Text="Client Code :" meta:resourcekey="RS_ClientCodeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientCode" runat="server" meta:resourcekey="lblClientCodeResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientAddress" runat="server" Text="Client Address :" meta:resourcekey="RS_ClientAddressResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientAddress" runat="server" meta:resourcekey="lblClientAddressResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientZone" runat="server" Text="Client Zone :" meta:resourcekey="RS_ClientZoneResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientZone" runat="server" meta:resourcekey="lblClientZoneResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_Clientphone" runat="server" Text="Client Phone No :" nowrap="nowrap"
                                                                        meta:resourcekey="Rs_ClientphoneResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientPhNo" runat="server" meta:resourcekey="lblClientPhNoResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_EmailD" runat="server" Text="Client EmailID :" nowrap="nowrap"
                                                                        meta:resourcekey="Rs_EmailDResource1"></asp:Label>
                                                                </td>
                                                                <td style="word-break: break-all">
                                                                    <asp:Label ID="lblClientEmail" runat="server" meta:resourcekey="lblClientEmailResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:TextBox ID="TextBox1" Style="background-color: White; vertical-align: text-top"
                                                                        ReadOnly="True" runat="server" CssClass="w-5 h-5" meta:resourcekey="TextBox1Resource1"></asp:TextBox>
                                                                    <asp:Label ID="Label8" Text="Active Client" runat="server" meta:resourcekey="Label8Resource1"></asp:Label>
                                                                    <asp:TextBox ID="TextBox2" Style="background-color: Orange; vertical-align: text-top"
                                                                        ReadOnly="True" runat="server" CssClass="w-5 h-5" meta:resourcekey="TextBox2Resource1"></asp:TextBox>
                                                                    <asp:Label ID="Label9" Text="Suspended Client" runat="server" meta:resourcekey="Label9Resource1"></asp:Label>
                                                                    <asp:TextBox ID="TextBox3" Style="background-color: Red; vertical-align: text-top"
                                                                        ReadOnly="True" runat="server" CssClass="w-5 h-5" meta:resourcekey="TextBox3Resource1"></asp:TextBox>
                                                                    <asp:Label ID="Label10" Text="Terminate Client" runat="server" meta:resourcekey="Label10Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <%--<tr>
                                                                                    <td>
                                                                                        <asp:Label ID="Rs_ClientPh" runat="server" Text="Phone No :"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblClientPhone" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>--%>
                                                        </table>
                                                    </fieldset>
                                                    <fieldset>
                                                                    <legend class="bold" style="font-size: medium; font-style: normal">
                                                                        <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_09 %>
                                                                    </legend>
                                                                    <table cellspacing="5" class="w-100p bg-row lh15">
                                                                        <tr>
                                                                            <td class="w-30p">
                                                                                <asp:Label ID="RS_SamCollectedby" runat="server" Text="RegisteredAt :" Font-Bold="True"
                                                                                    meta:resourcekey="RS_SamCollectedbyResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblSampleCollectedBy" runat="server" Font-Bold="True" meta:resourcekey="lblSampleCollectedByResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="RS_SamCollTime" runat="server" Text="RegisteredBy :" Font-Bold="True"
                                                                                    meta:resourcekey="RS_SamCollTimeResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblCollTime" runat="server" Font-Bold="True" meta:resourcekey="lblCollTimeResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="RS_SamPickupTime" runat="server" Text="PickUpTime :" meta:resourcekey="RS_SamPickupTimeResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblsampckuptime" runat="server" meta:resourcekey="lblsampckuptimeResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="rs_samRegTime" runat="server" Text="RegistrationTime" meta:resourcekey="rs_samRegTimeResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblSampleRegTime" runat="server" meta:resourcekey="lblSampleRegTimeResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </fieldset>
                                                </td>
                                                <td class="v-top">
                                                    <div >
                                                                            <fieldset class="marginB13">
                                                                    <legend class="bold" style="font-size: medium; font-style: normal">
                                                                        <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_12 %>
                                                                    </legend>
                                                                    <table cellspacing="5" class="w-100p">
                                                                        <tr id="trlegend" runat="server" class="lh20" style="display: table-row;">
                                                                            <td class="a-left">
                                                                                <asp:TextBox ID="txtStatColor" Style="background-color: gray; vertical-align: text-top"
                                                                                    ReadOnly="True" runat="server" CssClass="w-5 h-5" meta:resourcekey="txtStatColorResource1"></asp:TextBox>
                                                                                <asp:Label ID="lblStatTestColor" Text="Client Bill" runat="server" meta:resourcekey="lblStatTestColorResource1"></asp:Label>
                                                                                <asp:TextBox ID="txtInvoiceColor" Style="background-color: Lime; vertical-align: text-top"
                                                                                    ReadOnly="True" runat="server" CssClass="w-5 h-5" meta:resourcekey="txtInvoiceColorResource1"></asp:TextBox>
                                                                                <asp:Label ID="Label6" Text="Invoice Bill" runat="server" meta:resourcekey="Label6Resource1"></asp:Label>
                                                                                <asp:TextBox ID="txtDueBillColor" Style="background-color: IndianRed; vertical-align: text-top"
                                                                                    ReadOnly="True" runat="server" CssClass="w-5 h-5" meta:resourcekey="txtDueBillColorResource1"></asp:TextBox>
                                                                                <asp:Label ID="Label7" Text="Due Bill" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                                                                <asp:TextBox ID="TxtCopayment" Style="background-color: #FFDDAA; vertical-align: text-top"
                                                                                    ReadOnly="True" runat="server" CssClass="w-5 h-5" meta:resourcekey="TxtCopaymentResource1"></asp:TextBox>
                                                                                <asp:Label ID="lblCopay" Text="Co-Payment Bill" runat="server" meta:resourcekey="lblCopayResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <%--Added by Thamilselvan.R DataKeyNames,MembershipCardNo--%>
                                                                        <tr>
                                                                            <td class="w-30p">
                                                                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" DataKeyNames="BillID,MembershipCardNo"
                                                                                    class="gridView" CssClass="grdResult w-100p" OnRowDataBound="grdResult_RowDataBound"
                                                                                    OnRowCommand="grdResult_RowCommand" meta:resourceKey="grdResultResource1">
                                                                                    <Columns>
                                                                                        <%--Added by Thamilselvan...--%><asp:BoundField DataField="BillID" HeaderText="BillID"
                                                                                            meta:resourceKey="BoundFieldResource1" Visible="False" />
                                                                                        <asp:TemplateField Visible="False" HeaderText="Select" meta:resourceKey="TemplateFieldResource1">
                                                                                            <ItemTemplate>
                                                                                                <asp:RadioButton ID="rdSel" runat="server" GroupName="BillSelect" ToolTip="Select Row"
                                                                                                    meta:resourceKey="rdSelResource1" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle CssClass="w-3p" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField Visible="False" DataField="PatientNumber" HeaderText="Patient No"
                                                                                            meta:resourceKey="BoundFieldResource2">
                                                                                            <ItemStyle CssClass="w-4p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" meta:resourcekey="BoundFieldResource3">
                                                                                            <ItemStyle CssClass="w-15p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourceKey="BoundFieldResource30">
                                                                                            <HeaderStyle CssClass="a-left" />
                                                                                            <ItemStyle CssClass="a-left w-15p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="PatientVisitId" HeaderText="VisitID" meta:resourceKey="BoundFieldResource4"
                                                                                            Visible="false" />
                                                                                        <asp:BoundField DataField="PatientID" HeaderText="PID" meta:resourceKey="BoundFieldResource5"
                                                                                            Visible="false" />
                                                                                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd MMM yyyy hh:mm tt}"
                                                                                            HeaderText="Bill Date" meta:resourceKey="BoundFieldResource6">
                                                                                            <HeaderStyle CssClass="a-left" />
                                                                                            <ItemStyle CssClass="a-left w-15p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField Visible="False" DataField="Name" HeaderText="Patient Name" meta:resourceKey="BoundFieldResource7">
                                                                                            <HeaderStyle CssClass="a-left" />
                                                                                            <ItemStyle CssClass="w-18p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Amount" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                                                            HeaderText="Amount" ItemStyle-Width="3%" meta:resourcekey="BoundFieldResource8">
                                                                                            <HeaderStyle CssClass="a-left" />
                                                                                            <ItemStyle CssClass="w-3p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                                                            HeaderText="Amount Received" ItemStyle-Width="3%" meta:resourcekey="BoundFieldResource9">
                                                                                            <HeaderStyle CssClass="a-left" />
                                                                                            <ItemStyle CssClass="w-3p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="DrName" HeaderStyle-HorizontalAlign="left" HeaderText="Doctor Name"
                                                                                            ItemStyle-Width="17%" Visible="false" meta:resourcekey="BoundFieldResource10">
                                                                                            <HeaderStyle CssClass="a-left" />
                                                                                            <ItemStyle CssClass="w-17p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="RefOrgName" HeaderText="Hospital/CC/Branch" meta:resourceKey="BoundFieldResource10"
                                                                                            Visible="False">
                                                                                            <HeaderStyle CssClass="a-left" />
                                                                                            <ItemStyle CssClass="w-25p" />
                                                                                        </asp:BoundField>
                                                                                        <asp:TemplateField HeaderText="Bill Status" HeaderStyle-HorizontalAlign="left" Visible="false"
                                                                                            meta:resourcekey="TemplateFieldResource2">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblRefundstatus" Text='<%# Eval("RefundStatus") %>' runat="server"
                                                                                                    meta:resourcekey="lblRefundstatusResource1"></asp:Label>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer" ForeColor="Black"
                                                                                                    Text="View Bill" ID="lblViewBill" meta:resourcekey="lblViewBillResource1"></asp:Label>
                                                                                                <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer" ForeColor="Black"
                                                                                                    Text="Mail Bill" ID="lblMailBill" meta:resourcekey="lblMailBillResource1"></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="0" meta:resourcekey="TemplateFieldResource4">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer" ForeColor="Black"
                                                                                                    meta:resourcekey="lblViewBillB2CResource1" ID="lblViewBillB2C"></asp:Label>
                                                                                                <asp:Panel ID="dvDuePaidBill" runat="server">
                                                                                                    <%--  &nbsp; / &nbsp;--%>
                                                                                                    <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer; display: block;"
                                                                                                        meta:resourcekey="lblViewCompleteBillB2CResource1" ForeColor="Black" ID="lblViewCompleteBillB2C"></asp:Label>
                                                                                                </asp:Panel>
                                                                                                <%--  <asp:RadioButton ID="rdSel" runat="server" GroupName="BillSelect" ToolTip="Select Row"
                                                                                                    meta:resourcekey="rdSelResource1" />--%>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="MembershipCardNo" HeaderText="HealthCouponNo" Visible="false"
                                                                                            meta:resourcekey="BoundFieldResource11" />
                                                                                    </Columns>
                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                                    <PagerStyle CssClass="a-center" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </fieldset>
                                                                        </div>
                                                    <div id="history" runat="server">
                                                                            <table class="w-100p a-center">
                                                                                <tr>
                                                                                    <td class="w-50p v-top">
                                                                                        <fieldset>
                                                                                            <legend class="bold" style="font-size: medium; font-style: normal;">
                                                                                                <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_11 %>
                                                                                            </legend>
                                                                                            <asp:GridView ID="Bckgrd" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                                                                BorderColor="ActiveCaption" CssClass="dataheader2 gridView w-100p" meta:resourcekey="BckgrdResource1">
                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                <RowStyle CssClass="lh27"/>
                                                                                                <Columns >
                                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="C.History">
                                                                                                        <ItemTemplate>
                                                                                                            <asp:LinkButton runat="server" ToolTip="Click Here to Patient History" Text="View"
                                                                                                                ID="LinkPatientHistory" OnClientClick="Editpatienthistory()" Font-Underline="True"
                                                                                                                ForeColor="Black" Font-Bold="True"  meta:resourcekey="LinkPatientHistoryResource1"></asp:LinkButton>
                                                                                                        </ItemTemplate>
                                                                                                        <%--<ItemStyle HorizontalAlign="Center"></ItemStyle>--%>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:BoundField DataField="History" HeaderText="History" meta:resourcekey="BoundFieldResource1" />
                                                                                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" meta:resourcekey="BoundFieldResource2" />
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                            <div id="divHistoryDetail" style="display: none;">
                                                                                                <table class="w-100p a-center" cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor">
                                                                                                    <tr id="divpatienthistory" runat="server">
                                                                                                        <td id="td5" class="a-center" runat="server">
                                                                                                            <PHis:PatientCaptureHistory ID="patientcapturehistory1" runat="server" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </fieldset>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="General" colspan="3" >
                                                    <table class="w-100p">
                                                    <tr>
                                                            <td class="a-center" colspan="2">
                                                                <table class="w-100p a-center">
                                                                    <tr>
                                                                        <td>
                                                                            <fieldset>
                                                                                <legend class="bol" style="font-size: medium; font-style: normal">
                                                                                    <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_13 %>
                                                                                </legend>
                                                                                <table class="a-center w-100p">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:GridView ID="GrdSample" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                OnRowDataBound="GrdSample_Databound" ForeColor="#333333" BorderColor="ActiveCaption"
                                                                                                PageSize="15" CssClass="dataheader2 gridView w-100p datawrapcs" meta:resourcekey="GrdSampleResource1">
                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                <Columns>
                                                                                                    <asp:BoundField DataField="Testname" Visible="false" HeaderText="TestName" meta:resourcekey="BoundFieldResource12" />
                                                                                                    <asp:BoundField DataField="BarcodeNumber" HeaderText="Sample ID" meta:resourcekey="BoundFieldResource13" />
                                                                                                    <asp:BoundField DataField="SampleDesc" HeaderText="Sample Name" meta:resourcekey="BoundFieldResource14" />
                                                                                                    <asp:BoundField DataField="SampleContainerName" HeaderText="Container Name" meta:resourcekey="BoundFieldResource15" />
                                                                                                    <asp:BoundField DataField="Status" HeaderText="Sample Status" meta:resourcekey="BoundFieldResource16" />
                                                                                                    <asp:BoundField DataField="CollectedDateTime" HeaderText="Sample Collected At" meta:resourcekey="BoundFieldResource17" />
                                                                                                    <asp:BoundField DataField="PatientName" HeaderText="Sample CollectedBy" meta:resourcekey="BoundFieldResource18" />
                                                                                                    <asp:BoundField DataField="TransferedDateTime" HtmlEncode="false" HeaderText="TransferedDateTime"
                                                                                                        DataFormatString="{0:dd-MM-yyyy hh:mm tt}" meta:resourcekey="BoundFieldResource19" />
                                                                                                    <%-- <asp:TemplateField HeaderText="TransferedDateTime" Visible="true" ItemStyle-HorizontalAlign="Center" >
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblTransferedDateTime" ItemStyle-Width="10%" Visible="true" runat="server"
                                                                                                                                Text='<%# Eval("TransferedDateTime").ToString()=="01/01/0001 00:00:00"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("TransferedDateTime"))%>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>--%>
                                                                                                    <asp:BoundField DataField="Param2" HeaderText="Sample TransferBy" meta:resourcekey="BoundFieldResource20" />
                                                                                                    <asp:BoundField DataField="ReceivedDateTime" HtmlEncode="false" HeaderText="ReceivedDateTime"
                                                                                                        DataFormatString="{0:dd-MM-yyyy hh:mm tt}" meta:resourcekey="BoundFieldResource21" />
                                                                                                    <%--<asp:TemplateField HeaderText="ReceivedDateTime" Visible="true" ItemStyle-HorizontalAlign="Center">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblReceivedDateTime" ItemStyle-Width="10%" Visible="true" runat="server"
                                                                                                                                Text='<%# Eval("ReceivedDateTime").ToString()=="1/1/0001 00:00:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("ReceivedDateTime"))%>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>--%>
                                                                                                    <asp:BoundField DataField="Param1" HeaderText="Sample ReceivedBy" meta:resourcekey="BoundFieldResource22" />
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </fieldset>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td id="trreportdetails" runat="server" class="a-center" colspan="2">
                                                                <table class="w-100p a-center">
                                                                    <tr>
                                                                        <td>
                                                                            <fieldset>
                                                                                <legend class="bold" style="font-size: medium; font-style: normal">
                                                                                    <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_14 %></legend>
                                                                                <table class="w-100p a-center">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:GridView ID="GrdReport" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                CssClass="gridView w-100p dataheader2" ForeColor="#333333" BorderColor="ActiveCaption"
                                                                                                PageSize="15" OnPageIndexChanging="GrdReport_PageIndexChanging" OnRowDataBound="GrdReport_RowDataBound"
                                                                                                meta:resourcekey="GrdReportResource1">
                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                <Columns>
                                                                                                    <asp:BoundField DataField="GroupName" ItemStyle-Width="130%" ItemStyle-Wrap="true"
                                                                                                        HeaderText="TestName"  meta:resourcekey="BoundFieldResource23"/>
                                                                                                    <asp:BoundField DataField="Migrated_TestCode" HeaderText="TCODE" meta:resourcekey="BoundFieldResource24" />
                                                                                                    <asp:BoundField DataField="PerformingPhysicainName" HeaderText="Authorized by" meta:resourcekey="BoundFieldResource25" />
                                                                                                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd-MM-yyyy hh:mm tt}"
                                                                                                        HeaderText="Authorized time" meta:resourcekey="BoundFieldResource26" />
                                                                                                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd-MM-yyyy hh:mm tt}"
                                                                                                        HeaderText="Report Generated time" meta:resourcekey="BoundFieldResource27" />
                                                                                                    <asp:BoundField DataField="OrderedAt" DataFormatString="{0:dd-MM-yyyy hh:mm tt}"
                                                                                                        HeaderText="Report Printing time" meta:resourcekey="BoundFieldResource28" />
                                                                                                    <asp:TemplateField HeaderText="Report TAT" Visible="true" ItemStyle-HorizontalAlign="Center"
                                                                                                        meta:resourcekey="TemplateFieldResource5">
                                                                                                        <ItemTemplate>
                                                                                                        <asp:Label ID="lblCollectedDateTime" ItemStyle-Width="10%" runat="server" Text='<%# Eval("CollectedDateTime").ToString() == "01/01/0001 00:00:00" ? " " : Eval("CollectedDateTime").ToString() == "01/01/1753 00:00:00" ? " " : Eval("CollectedDateTime") %>'></asp:Label>
                                                                                                            <%--<asp:Label ID="lblCollectedDateTime" ItemStyle-Width="10%" runat="server" Text='<%# Eval("CollectedDateTime").ToString() == "01/01/0001 00:00:00" ? " " : Eval("CollectedDateTime") %>'></asp:Label>--%>
                                                                                                            <%--<asp:Label ID="lblCollectedDateTime" ItemStyle-Width="10%" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CollectedDateTime"))=="01-01-0001 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}",Eval("CollectedDateTime"))=="01-01-1753 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CollectedDateTime")) %>'
                                                                                                                meta:resourcekey="lblCollectedDateTimeResource1"></asp:Label>--%>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:BoundField DataField="DisplayStatus" HeaderText="Status" meta:resourcekey="BoundFieldResource31"/>
                                                                                                    <%--/* BEGIN | NA | Sabari | 20181202 | Created | HOLD */--%>
                                                                                                    <asp:TemplateField HeaderText="Report Status" Visible="true" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource6">
                                                                                                        <ItemTemplate>
                                                                                                        <asp:Label ID="lblReportStatus" ItemStyle-Width="10%" runat="server" Text=''></asp:Label>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <%--/* END | NA | Sabari | 20181202 | Created | HOLD */--%>
                                                                                                </Columns>
                                                                                            </asp:GridView>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </fieldset>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Button ID="btnViewReport" runat="server" Text="ViewReport" CssClass="btn" OnClick="btnViewreport_Click"
                                                                                meta:resourcekey="btnViewreportResource1" OnClientClick="javascript:return AssignReportValue();" />
                                                                             <asp:Button ID="btnManualReport" runat="server" Text="Manual Report" CssClass="btn" OnClick="btnManualReport_Click"
                                                                              meta:resourcekey="btnManualReportResource1"  /> 
                                                                            <asp:Button ID="btnViewCumulativeReport" runat="server" Text="View Cumulative Report" CssClass="btn" OnClick="btnViewCumulativeReport_Click"
                                                                                meta:resourcekey="btnViewCumulativeReportResource1" OnClientClick="javascript:return AssignReportValue();" />    
                                                                            <asp:Button ID="btnSendMailReport" runat="server" Text="Send Report Mail" CssClass="btn"
                                                                                OnClick="btnSendMail_Click" meta:resourcekey="btnSendMailReportResource1" OnClientClick="javascript:return AssignReportValue();" />
                                                                            <%--<asp:Button ID="btnViewBill" runat="server" Text="ViewBill" CssClass="btn" OnClick="btnViewreport_Click"
                                                                                                meta:resourcekey="btnViewreportResource1" OnClientClick="javascript:return AssignBillValue();" />
                                                                                            <asp:Button ID="btnSendMailBill" runat="server" Text="Send Bill Mail" CssClass="btn"
                                                                                                OnClick="btnSendMail_Click" meta:resourcekey="btnSendMailReportResource1" OnClientClick="javascript:return AssignBillValue();" />--%>
                                                                            <asp:Button ID="btnTrendReport" runat="server" Text="Trend Report" CssClass="btn"
                                                                                meta:resourcekey="btnTrendReportResource1" OnClientClick="javascript:return openPopup();" />
                                                                            <asp:Button ID="btncancel" OnClick="btnCancel_Click" runat="server" Text="Cancel"
                                                                                CssClass="btn" meta:resourcekey="btncancelResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trMailDetails">
                                                                        <td>
                                                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                                                                                    <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                                                                                        TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                                                                                        CancelControlID="img1" DynamicServicePath="" Enabled="True">
                                                                                    </cc1:ModalPopupExtender>
                                                                                    <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" CssClass="modalPopup dataheaderPopup w-30p"
                                                                                        runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                                                                                        <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="a-right">
                                                                                                        <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                                                                            style="cursor: pointer;" />
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </asp:Panel>
                                                                                        <%--<ul>
                                                                                                            <li>
                                                                                                                <uc6:ErrorDisplay ID="ErrorDisplay3" runat="server" />
                                                                                                            </li>
                                                                                                        </ul>--%>
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
                                                                                                    <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" CssClass="small" runat="server"
                                                                                                        meta:resourcekey="txtMailAddressResource1" onblur="javascript:return validateMultipleEmailsCommaSeparated1(this,',');"/>
                                                                                                    <p class="font11" style="margin: 2px 0 5px 0; color: #666;">
                                                                                                        <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                                                                                            meta:resourcekey="lblMailAddressHintResource1" />
                                                                                                    </p>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="2" class="a-center">
                                                                                                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
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
                                                                                            <tr>
                                                                                                <td class="a-center" colspan="2">
                                                                                                    <asp:Button ID="Send" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return ValidateEmail();" OnClick="btnSendMailReport_Click" meta:resourcekey="btnSendMailReportResource1" />
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                <asp:HiddenField ID="hdnCaseNumber" runat="server" />
                                                                                                    <asp:HiddenField ID="hdnPatientID" runat="server" />
                                                                                                    <asp:HiddenField ID="hdnVisitID" runat="server" />
                                                                                                    <asp:HiddenField ID="hdnPatientEmail" runat="server" />
                                                                                                    <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </ContentTemplate>
                                                                            </asp:UpdatePanel>
                                                                        </td>
                                                                        <td>
                                                                            <cc1:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                                                                BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                                                            </cc1:ModalPopupExtender>
                                                                            <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 900px;
                                                                                vertical-align: bottom; top: 80px;" meta:resourcekey="pnlOthersResource1">
                                                                                <table class="w-100p a-center">
                                                                                    <tr>
                                                                                        <td class="a-right">
                                                                                            <img src="../Images/Close_Red_Online_small.png" alt="Close" id="imgClose" onclick="ClosePopUp()"
                                                                                                class="w-31 h-31 pointer" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <iframe id="ifPDF" runat="server" width="900" height="550" style="background: #fff;">
                                                                                            </iframe>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-50p v-top">
                                                            <%--added by sudha--%>
                                                                <div class="dataheader2 max-height190" id="divGrdInv" runat ="server">
                                                                                <asp:UpdatePanel ID="UpdPnl1" runat="server">
                                                                                    <ContentTemplate>
                                                                                        <asp:DataList ID="GrdInv" runat="server" GridLines="Horizontal" RepeatColumns="1"
                                                                                            CssClass="w-100p gridView" RepeatDirection="Vertical" OnItemDataBound="GrdInv_ItemDataBound"
                                                                                            meta:resourcekey="GrdInvResource1">
                                                                                            <HeaderTemplate>
                                                                                                <table class="w-100p">
                                                                                                    <tr class="gridHeader">
                                                                                                        <td>
                                                                                                            <b>
                                                                                                                <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_16 %>
                                                                                                            </b>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <b>
                                                                                                                <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_17 %>
                                                                                                            </b>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <%--<td >
                                                                        <b> 
                                                                            INVESTIGATIONNAME
                                                                          </b>  
                                                                        </td>
                                                                        <td >
                                                                        <b> 
                                                                            STATUS
                                                                        <b>     
                                                                        </td>--%>
                                                                                                    <%--</tr>
                                                                    <tr>--%>
                                                                                            </HeaderTemplate>
                                                                                            <ItemTemplate>
                                                                                                <%--<td class="w-70p">--%>
                                                                                                <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("ReferredType")%>' meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                                                <td headers="Status">
                                                                                                    <%# DataBinder.Eval(Container.DataItem, "DisplayStatus")%>
                                                                                                </td>
                                                                                            </ItemTemplate>
                                                                                            <FooterTemplate>
                                                                                                </tr> </table>
                                                                                            </FooterTemplate>
                                                                                        </asp:DataList>
                                                                                    </ContentTemplate>
                                                                                </asp:UpdatePanel>
                                                                            </div>
                                                            </td>
                                                            <td class="v-top">
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td class="v-top w-50p hide">
                                                                            <fieldset class="hide">
                                                                                <legend class="bold" style="font-size: medium; font-style: normal">
                                                                                    <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_10 %>
                                                                                </legend>
                                                                                <table cellspacing="5" class="w-100p bg-row">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table border="1" class="w-75p">
                                                                                                <tr>
                                                                                                    <td id="tdb2b" runat="server" class="w-25p a-center">
                                                                                                        <asp:Label ID="RS_B2B" Text="B2B" runat="server" meta:resourcekey="RS_B2BResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td id="tdb2c" runat="server" class="w-25p a-center">
                                                                                                        <asp:Label ID="RS_B2C" Text="B2C" runat="server" meta:resourcekey="RS_B2CResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td id="tdhv" runat="server" class="w-25p a-center">
                                                                                                        <asp:Label ID="RS_homeVisit" Text="HV" runat="server" meta:resourcekey="RS_homeVisitResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table class="w-50p">
                                                                                                <tr id="tramt" runat="server">
                                                                                                    <td class="w-40p" nowrap="nowrap">
                                                                                                        <asp:Label ID="RS_AmtPaid" runat="server" Text="Amount Paid" meta:resourcekey="RS_AmtPaidResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="a-left">
                                                                                                        <asp:Label ID="lblAmtPaid" runat="server" meta:resourcekey="lblAmtPaidResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr id="trdue" runat="server">
                                                                                        <td>
                                                                                            <table class="w-50p">
                                                                                                <tr id="tr1" runat="server">
                                                                                                    <td class="w-40p" nowrap="nowrap">
                                                                                                        <asp:Label ID="RS_DueAmt" runat="server" Text="Due Amount" meta:resourcekey="RS_DueAmtResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td align="left">
                                                                                                        <asp:Label ID="lblDueAmt" runat="server" meta:resourcekey="lblDueAmtResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr id="trtotamt" runat="server">
                                                                                        <td>
                                                                                            <table class="w-50p">
                                                                                                <tr id="tr2" runat="server">
                                                                                                    <td class="w-40p" nowrap="nowrap">
                                                                                                        <asp:Label ID="Rs_GrandTotal" runat="server" Text="Total Amount" meta:resourcekey="Rs_GrandTotalResource1"></asp:Label>
                                                                                                    </td>
                                                                                                    <td class="a-left">
                                                                                                        <asp:Label ID="lbltotAmount" runat="server" meta:resourcekey="lbltotAmountResource1"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </fieldset>
                                                                        </td>
                                                                        <td class="a-center v-top aza">
                                                                       <%-- added by sudha--%>
                                                                        
                                                                            <div class="investigationO-auto" id="dvAccess" runat="server">
                                                                            <table class="gridView w-100p">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:GridView ID="gvInvestigationValues" AutoGenerateColumns="false" runat="server"
                                                                                            ForeColor="#333333" BorderColor="ActiveCaption" CssClass="dataheader2 gridView w-100p">
                                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                                            <Columns>
                                                                                                <asp:BoundField DataField="Name" HeaderText="Name"   meta:resourcekey="BoundFieldResource32" />
                                                                                                <asp:BoundField DataField="Value" HeaderText="Value"   meta:resourcekey="BoundFieldResource33" />
                                                                                                <asp:BoundField DataField="DeviceValue" HeaderText="Device Value"   meta:resourcekey="BoundFieldResource34" />
                                                                                                <asp:BoundField DataField="DeviceID" HeaderText="Device Name"   meta:resourcekey="BoundFieldResource35" />
                                                                                                <asp:BoundField DataField="Status" HeaderText="Status"   meta:resourcekey="BoundFieldResource36" />
                                                                                            </Columns>
                                                                                        </asp:GridView>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                                
                                                                            </div>    
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="trBillingDetails">
                                                            <td class="w-50p" colspan="2">
                                                                
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td colspan="2">
                                                                <table class="w-95p hide" style="display: none;" runat="server" id="CheakInv">
                                                                    <tr>
                                                                        <td class="h-23 a-left">
                                                                            <asp:HiddenField ID="HdnInvID" runat="server" />
                                                                            <div id="ACX2plus21" style="display: none;">
                                                                                <img src="../Images/showBids.gif" alt="Show" style="cursor: pointer" class="w-15 h-15 v-top"
                                                                                    onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',1);" />
                                                                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',1);">
                                                                                    <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_15 %></span>
                                                                            </div>
                                                                            <div id="ACX2minus21" style="display: block;">
                                                                                <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                                    onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);" />
                                                                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);">
                                                                                    &nbsp;<%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_15 %></span>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="displaytr" id="ACX2responses211" style="display: table-row;">
                                                                        <td colspan="2">
                                                                            
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%--<tr>
                                            <td colspan="2">
                                                <table border="0" cellpadding="0" cellspacing="3" width="100%">
                                                    <tr>
                                                        <td colspan="3" style="width:60%">
                                                        <fieldset>
                                                        <legend>PatientDetails</legend>
                                                        </fieldset>
                                                        </td>
                                                        <td class="style6" colspan="3">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lblpatname" runat="server" Text="Patient Name:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="lbltxtPatName" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lblClientName" runat="server" Text="Client Name:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="lbltxtclientName" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    <td>
                                                    
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lblPatientAge" runat="server" Text="Patient Age:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label2" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label3" runat="server" Text="Client Codee:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label4" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                    <td>
                                                    
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label1" runat="server" Text="Gender :" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label5" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label6" runat="server" Text="Client Address:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label7" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                    <td>
                                                    
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label8" runat="server" Text="DOB :" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label9" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label10" runat="server" Text="Client Zone:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label11" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>--%>
                            </table>
                            <table id="Worklist" class="w-99p" style="display: none;">
                                <tr>
                                    <td colspan="2">
                                        <fieldset>
                                            <legend class="bold" style="font-size: medium; font-style: normal">
                                                <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_18 %>
                                            </legend>
                                            <table class="w-100p">
                                                <thead>
                                                    <tr class="dataheader1 h-17">
                                                        <th>
                                                            <asp:Label ID="lblInvestigationName" runat="server" Text="Test Name" meta:resourcekey="lblInvestigationNameResource1" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="lblWorklistType" runat="server" Text="Worklist Type" meta:resourcekey="lblWorklistTypeResource1" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="lblWorklistId" runat="server" Text="Worklist Id" meta:resourcekey="lblWorklistIdResource1" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="lblIFromdate" runat="server" Text="From Date" meta:resourcekey="lblIFromdateResource1" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="lblToDate" runat="server" Text="To Date" meta:resourcekey="lblToDateResource1" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="lblCreatedAt" runat="server" Text="CreatedAt" meta:resourcekey="lblCreatedAtResource1" />
                                                        </th>
                                                        <th>
                                                            <asp:Label ID="lblCreatedBy" runat="server" Text="CreatedBy" meta:resourcekey="lblCreatedByResource1" />
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater ID="rptWorkList" runat="server">
                                                        <ItemTemplate>
                                                            <tr class="h-17">
                                                                <td>
                                                                    <asp:Label ID="lblInvestigationName" runat="server" Text='<%# Bind("InvestigationName") %>'
                                                                        meta:resourcekey="lblInvestigationNameResource2" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblWorklistType" runat="server" Text='<%# Bind("WorklistType") %>'
                                                                        meta:resourcekey="lblWorklistTypeResource2"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblWorklistId" runat="server" Text='<%# Bind("WorklistId") %>' meta:resourcekey="lblWorklistIdResource2"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblFromdate" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("Fromdate"))=="01-01-1900 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("Fromdate")) %>'
                                                                        meta:resourcekey="lblFromdateResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblToDate" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("ToDate"))=="01-01-1900 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("ToDate")) %>'
                                                                        meta:resourcekey="lblToDateResource2"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCreatedAt" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CreatedAt"))=="01-01-1900 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CreatedAt")) %>'
                                                                        meta:resourcekey="lblCreatedAtResource2"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCreatedBy" runat="server" Text='<%# Bind("Name") %>' meta:resourcekey="lblCreatedByResource2"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;" runat="server" id="WorklistNoRec">
                                                                <td>
                                                                    <asp:Label ID="lblWorklistNoRec" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                            <table id="Notification" class="w-99p" style="display: none;">
                                <tr>
                                    <td colspan="2">
                                        <fieldset>
                                            <legend class="bold" style="font-size: medium; font-style: normal">
                                                <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_19 %></legend>
                                            <table class="w-100p">
                                                <thead>
                                                    <tr class="dataheader1 h-17p">
                                                        <th class="w-12p">
                                                            <asp:Label ID="lblSmsActionType" runat="server" Text="ActionType" meta:resourcekey="lblSmsActionTypeResource1" />
                                                        </th>
                                                        <th class="w-11p">
                                                            <asp:Label ID="lblSmsMobilenumber" runat="server" Text="Mobile Number" meta:resourcekey="lblSmsMobilenumberResource1" />
                                                        </th>
                                                        <th class="w-6p">
                                                            <asp:Label ID="lblSmsStatus" runat="server" Text="Status" meta:resourcekey="lblSmsStatusResource1" />
                                                        </th>
                                                        <th class="w-11p">
                                                            <asp:Label ID="lblSmsCompletionTime" runat="server" Text="CompletionTime" meta:resourcekey="lblSmsCompletionTimeResource1" />
                                                        </th>
                                                        <th class="w-65p" style="text-align: left">
                                                            <asp:Label ID="lblSmsMessageContent" runat="server" Text="Message Content" meta:resourcekey="lblSmsMessageContentResource1" />
                                                        </th>
                                                        <%-- <th>
                                                                            <asp:Label ID="lblSmsMode" runat="server" Text="Mode" />
                                                                        </th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater ID="RptSmsNotification" runat="server">
                                                        <ItemTemplate>
                                                            <tr class="w-17p" style="border-bottom-color: White;">
                                                                <td class="w-12p" style="text-align: center">
                                                                    <asp:Label ID="lblActionType" runat="server" Text='<%# Bind("Type") %>' meta:resourcekey="lblActionTypeResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-11p" style="text-align: center">
                                                                    <asp:Label ID="lblValue" runat="server" Text='<%# Bind("Value") %>' meta:resourcekey="lblValueResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-6p">
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' meta:resourcekey="lblStatusResource2"></asp:Label>
                                                                </td>
                                                                <td class="w-11p">
                                                                    <asp:Label ID="lblCompletionTime" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CompletionTime"))=="01-01-1900 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CompletionTime")) %>'
                                                                        meta:resourcekey="lblCompletionTimeResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-65p" style="overflow-y: auto; text-align: left">
                                                                    <asp:Label ID="lblSmsContent" runat="server" Text='<%# Bind("Template") %>' meta:resourcekey="lblSmsContentResource1"></asp:Label>
                                                                </td>
                                                                <%-- <td style="width: 11%;">
                                                                                    <asp:Label ID="lblContextType" runat="server" Text='<%# Bind("ContextType") %>'></asp:Label>
                                                                                </td>--%>
                                                            </tr>
                                                            <tr style="display: none;" runat="server" id="SMSNoRec">
                                                                <td>
                                                                    <asp:Label ID="lblSMSNoRec" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <fieldset>
                                            <legend class="bold" style="font-size: medium; font-style: normal">
                                                <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_20 %></legend>
                                            <table class="w-100p">
                                                <thead>
                                                    <tr class="dataheader1 h-17p">
                                                        <th class="w-15p">
                                                            <asp:Label ID="lblActionType" runat="server" Text="ActionType" meta:resourcekey="lblActionTypeResource2" />
                                                        </th>
                                                        <th class="w-8p">
                                                        </th>
                                                        <th class="w-6p">
                                                            <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatusResource3" />
                                                        </th>
                                                        <th class="w-11p">
                                                            <asp:Label ID="lblCompletionTime" runat="server" Text="CompletionTime" meta:resourcekey="lblCompletionTimeResource2" />
                                                        </th>
                                                        <th class="w-65p" style="text-align: left">
                                                            <asp:Label ID="lblValue" runat="server" Text="EmailID" meta:resourcekey="lblValueResource2" />
                                                        </th>
                                                        <%--<th>
                                                                            <asp:Label ID="lblContextType" runat="server" Text="Mode" />
                                                                        </th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater ID="rptEmailNotification" runat="server">
                                                        <ItemTemplate>
                                                            <tr class="h-17p" style="border-bottom-color: White;">
                                                                <td class="w-15p">
                                                                    <asp:Label ID="lblActionType" runat="server" Text='<%# Bind("Type") %>' meta:resourcekey="lblActionTypeResource3"></asp:Label>
                                                                </td>
                                                                <td class="w-8p">
                                                                </td>
                                                                <td class="w-6p" style="text-align: center">
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' meta:resourcekey="lblStatusResource4"></asp:Label>
                                                                </td>
                                                                <td class="w-11p" style="text-align: center">
                                                                    <asp:Label ID="lblCompletionTime" runat="server" Text='<%# string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CompletionTime"))=="01-01-1900 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CompletionTime")) %>'
                                                                        meta:resourcekey="lblCompletionTimeResource3"></asp:Label>
                                                                </td>
                                                                <td class="w-65p" style="text-align: left">
                                                                    <asp:Label ID="lblValue" runat="server" Text='<%# Bind("Value") %>' meta:resourcekey="lblValueResource3"></asp:Label>
                                                                </td>
                                                                <%--  <td style="width: 11%;">
                                                                                    <asp:Label ID="lblContextType" runat="server" Text='<%# Bind("ContextType") %>'></asp:Label>
                                                                                </td>--%>
                                                            </tr>
                                                            <tr style="display: none;" runat="server" id="EmailNoRec">
                                                                <td>
                                                                    <asp:Label ID="lblEmailNoRec" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <asp:Button ID="btnShow" runat="server" CssClass="btn" Text="Show" Style="display: none;"
                            OnClientClick="return Validate()" meta:resourcekey="btnShowResource1" />
                        <td id="tdEpisodeHistory" runat="server" style="display: none;">
                            <cc1:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                PopupControlID="pnlPopup" />
                            <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Style="display: none"
                                BackImageUrl="~/Images/Loader.gif" meta:resourcekey="pnlPopupResource1">
                            </asp:Panel>
                            <table id="example" style="display: none">
                                <thead>
                                    <tr>
                                        <th class="a-center">
                                           <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_21 %> 
                                        </th>
                                        <th class="a-center">
                                           <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_22 %> 
                                        </th>
                                        <th class="a-center">
                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_23 %> 
                                        </th>
                                        <th class="a-center">
                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_24 %> 
                                        </th>
                                        <th class="a-center">
                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_25 %> 
                                        </th>
                                        <th class="a-center">
                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_26 %> 
                                        </th>
                                        <th class="a-center">
                                            <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_27 %> 
                                        </th>
                                        <th class="a-center">
                                           
                                            ActionType
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
         
                       
                           <%-- <table id="tblGrid" runat="server" width="100%" align="center" >
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend style="font-size: medium; font-weight: bold; font-style: normal">Audit History
                                                            </legend>
                                            <asp:Button ID="btnCopy" runat="server" Text="Copy" CssClass="btn" meta:resourcekey="btnCopyreportResource1" />
                                            <asp:Button ID="btnCSV" runat="server" Text="CSV" CssClass="btn" meta:resourcekey="btnCSVreportResource1" />
                                            <asp:Button ID="btnExcel" runat="server" Text="Excel" CssClass="btn" OnClick="btnExcel_Click"
                                                meta:resourcekey="btnExcelreportResource1" />
                                            <asp:Button ID="btnPDF" runat="server" Text="PDF" OnClick="btnPDF_Click" CssClass="btn" meta:resourcekey="btnPDFreportResource1" />
                                            <div class="dataTables_filter" id="example_filter">
                                                <label>
                                                    Search:
                                                    <asp:TextBox ID="txtSearch" onkeyup="Search();" runat="server" placeholder="Search"></asp:TextBox></div>
                                            <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="grdAudit" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False" Visible="false" 
                                                            CssClass="w-100p gridView" PageSize="10" PagerSettings-Mode="NextPreviousFirstLast"
                                                            class="gridView w-100p" OnRowDataBound="grdAudit_RowDataBound" OnDataBound="grdAudit_DataBound"
                                                            OnPageIndexChanging="grdAudit_PageIndexChanging" CellPadding="1" AlternatingRowStyle-CssClass="trEven"
                                                            OnRowCreated="grdAudit_RowCreated">
                                                            <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NextPreviousFirstLast"
                                                                NextPageText="Next" PageButtonCount="5" PreviousPageText="Previous" />
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <Columns>
                                                               
                                                                <asp:BoundField HeaderStyle-Width="13.28%" DataField="DateTime" HeaderText="Date Time" />
                                                                <asp:BoundField HeaderStyle-Width="14.28%" DataField="User" HeaderText="User Name" />
                                                                <asp:BoundField HeaderStyle-Width="14.28%" DataField="Location" HeaderText="Location" />
                                                                <asp:BoundField HeaderStyle-Width="15.28%" DataField="Activity" HeaderText="Activity" />
                                                                <asp:BoundField HeaderStyle-Width="14.28%" DataField="TestValue" HeaderText="Test Value" />
                                                                <asp:BoundField HeaderStyle-Width="14.28%" DataField="OldValues" HeaderText="Old Value" />
                                                                <asp:BoundField HeaderStyle-Width="14.28%" DataField="CurrentValues" HeaderText="Current Value" />
                                                               <asp:BoundField DataField="ActionType" HeaderText="ActionType" Visible="false" />
                                                            </Columns>
                                                            <EmptyDataTemplate>
                                                                <table class="w-100p gridView" cellspacing="0" cellpadding="1" rules="all" border="1"
                                                                    id="grdAudit" style="width: 100%; border-collapse: collapse;">
                                                                    <tbody>
                                                                        <tr class="dataheader1">
                                                                            <th scope="col" style="width: 13.28%;">
                                                                                Date Time
                                                                            </th>
                                                                            <th scope="col" style="width: 14.28%;">
                                                                                User Name
                                                                            </th>
                                                                            <th scope="col" style="width: 14.28%;">
                                                                                Location
                                                                            </th>
                                                                            <th scope="col" style="width: 15.28%;">
                                                                                Activity
                                                                            </th>
                                                                            <th scope="col" style="width: 14.28%;">
                                                                                Test Value
                                                                            </th>
                                                                            <th scope="col" style="width: 14.28%;">
                                                                                Old Value
                                                                            </th>
                                                                            <th scope="col" style="width: 14.28%;">
                                                                                Current Value
                                                                            </th>
                                                                        </tr>
                                                                </table>
                                                                No data available in table</EmptyDataTemplate>
                                                            <PagerStyle CssClass="paginate_active" HorizontalAlign="Right" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>--%>
                        </td>
                    </tr>
                    <tr>
                        <asp:Button ID="btnCommunication" runat="server" CssClass="btn" Text="Show" Style="display: none;"
                            OnClientClick="return Validate()" OnClick="btnCommunication_Click" meta:resourcekey="btnCommunicationResource1" />
                        <td id="tdCommunication" runat="server" style="display: none;">
                            <table class="a-center w-100p">
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend class="bold" style="font-size: medium; font-style: normal">
                                                <%=Resources.Reception_ClientDisplay.Reception_PatientTrackingDetails_aspx_28 %>
                                            </legend>
                                            <table class="w-100p a-center">
                                                <tr>
                                                    <td>
                                                        <div id="ViewCommunication" runat="server">
                                                            <uc8:CommThread ID="CommThread1" runat="server" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnSnapshotType" runat="server" />
                <asp:HiddenField ID="hdnFinalBillID" runat="server" />
                <asp:HiddenField ID="hdnFromDate" runat="server" />
                <asp:HiddenField ID="hdnToDate" runat="server" />
                <asp:HiddenField ID="hdnPatOrgID" runat="server" />
                <asp:HiddenField ID="hdnOrgID" runat="server" />
                
                <asp:HiddenField ID="hdnIsCompleteBill" runat="server" />
                <asp:HiddenField ID="hdnIsDueBill" runat="server" Value="0" />
                <%--Added by Thamilselvan for Complete Bill --%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%--Added by Thamilselvan for showing the IFrame in Model Popup...............--%>
    <asp:UpdatePanel ID="updatePNL" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnTargetCtlMailReport1" runat="server" />
            <cc1:ModalPopupExtender ID="modalpopupsendemails" runat="server" PopupControlID="SSRSPanel1"
                TargetControlID="hdnTargetCtlMailReport1" BackgroundCssClass="modalBackground"
                CancelControlID="btnCancels" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
            <asp:Panel ID="SSRSPanel1" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-70p"
                runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                <asp:Panel ID="Panel2" runat="server" CssClass="dialogHeader w-100p" Height="500px"
                    meta:resourcekey="Panel1Resource1">
                    <table class="w-100p">
                        <tr>
                            <td class="h-100p a-center">
                                <iframe id="CouponCardBillFrame" runat="server" name="myname" class="w-100p" style="height: 470px;
                                    overflow: none;"></iframe>
                                <input type="button" id="btnBillPrint" class="font14 h-25 w-45 a-center" style='background-color: Transparent;
                                    color: white; border-style: solid; border-width: thin; border-color: White;'
                                    value="Print" onclick="javascript:return OpenIframe1();" />
                                <asp:Button ID="btnCancels" CssClass="btn" runat="server" OnClick="btn_DisableIframSRC"
                                        Text="Close" meta:resourcekey="btnCancelsResource1" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdnSelectedMailButton" runat="server" />
    <asp:HiddenField ID="hdnEMail" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnflag" runat="server" />
    <asp:HiddenField ID="hdnBaseOrgId" runat="server" />
    <asp:HiddenField ID="hdnPHCorgID" runat="server" />
    
       <%--Added by QBITZ Prakash.K for Visit Search details Generate Manual Report...--%>
              <asp:HiddenField ID="hdnAccessionNumber" Value="0" runat="server" />
                <asp:HiddenField ID="hdnSingle" Value="0" runat="server" />
                <asp:HiddenField ID="hdnInvName" Value="0" runat="server" />
     <asp:HiddenField ID="hfApproveCount" runat="server" />
     <asp:HiddenField ID="hfReceiveCount" runat="server" />
     <asp:HiddenField ID="hfShowAllAccession" runat="server" />
     <asp:HiddenField ID="hfSelectedAccession" runat="server" />
     <asp:HiddenField ID="hdnPreviousLabNumber" runat="server" Value="0" />
     <asp:HiddenField ID="hdnParameters" Value="" runat="server" />
     <asp:HiddenField ID="hdnPageID" Value="0" runat="server" />
     <asp:HiddenField ID="hdnVisitNumber" Value="" runat="server" />
     <asp:HiddenField ID="hdnExternalBarcodeSearch" Value="" runat="server" />
     <asp:HiddenField ID="hdnSRFNumberSearch" Value="" runat="server" />
                                    <ajc:ModalPopupExtender ID="extShowLiveReport" runat="server" DropShadow="false"
                                        PopupControlID="pnlShowLiveReport" BackgroundCssClass="modalBackground" Enabled="True"
                                        TargetControlID="btnCloseReport" CancelControlID="imgShowLiveReport">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlShowLiveReport" runat="server" Style="display: block; height: 590px;
                                        width: 1000px; vertical-align: bottom; top: 1010px;">
                                       
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
                                                                                   Visible="false"/>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Button ID="btnSaveToDispatch" runat="server" Text="Generate Report" Class='btn'
                                                                              OnClientClick="return ValidateManual();"      OnClick="btnGenerateReportManual_Click" />
                                                                            </td>
                                                                             <td>
                                                                              
                                                                                  <input type="button" id="btnClose" value="Close" onclick="CloseextShowLiveReport()" cssclass="btn" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
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
                                     <%--End by QBITZ Prakash.K for Visit Search details Generate Manual Report...--%>
    </div>
    <%--Added by Thamilselvan R for Visit Search details showing SSRS Report...--%>
    <div id="iframeBill1">
    </div>
    <div id="MyDialog">
        </div>
        <div id="dialog1" style="display: none" >
</div>
    </form>
    <%--   <script src="../Scripts_New/jquery-1.8.1.min.js" type="text/javascript"></script>--%>
    <%--    <script src="../Scripts_New/JsonScript.js" type="text/javascript"></script>--%>
    <%--   <script type="text/javascript" src="../Scripts_New/jquery-ui-1.8.19.custom.min.js"></script>--%>
    <%--    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>
--%>
    <%--  <script type="text/javascript" src="../Scripts_New/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
    
      <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <%--    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        function ClosePopUp() {
            $find('modalPopUp').hide();
        }

        //Added bt Thamilselvan to Call the Print Screen Popup While Clicking the PrintBill Button.... Changing same as Billing Page....
        function OpenIframe(FinalBillID, patientVisitID) {
            $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&finalBillID=" + FinalBillID + "&actionType=POPUP&type=printreport&invstatus=approve' style='position:absolute;overfow:none; z-index:-1'></iframe>");

        }
        function OpenIframe1() {
            var VisitIDs = $('#hdnVisitID').val();
            var FBillIDs = $('#hdnFinalBillID').val();
            var hdnFullBill = $('#hdnIsCompleteBill').val();
            if (hdnFullBill != 'Y') {
                $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + VisitIDs + "&finalBillID=" + FBillIDs + "&actionType=DefaultPrint&type=printreport&invstatus=approve' style='position:absolute;overfow:none; z-index:-1'></iframe>");
            }
            else {
                $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + VisitIDs + "&finalBillID=" + FBillIDs + "&actionType=DefaultPrint&isFullBill=Y&type=printreport&invstatus=approve' style='position:absolute;overfow:none; z-index:-1'></iframe>");
            }
        }

    </script>

    <script type="text/javascript">
        function GetData() {
            //debugger;
            try {
                var pop = $find("mdlPopup");
                pop.show();
                //var rdbType = $('input[id*=rdbType]').val();
                var rdbType = $("input:radio[name='rdbType']:checked").val();
                var ExternalVisitID = '';
                var ExternalBarcode = '';
                var Orgid = document.getElementById('hdnBaseOrgId').value;
                if (rdbType == 1) {
                    ExternalVisitID = document.getElementById('txtVisitNumber').value;
                }
                if (rdbType == 2) {
                    ExternalBarcode = document.getElementById('txtVisitNumber').value;
                    var ExBarcode;
                    ExBarcode = document.getElementById('hdnExternalBarcodeSearch').value;
                    if (ExBarcode == 'Y') {
                        ExternalVisitID = document.getElementById('hdnVisitNumber').value;
                        ExternalBarcode = '';
                    }
                }
                if (rdbType == 4) {
                    ExternalVisitID = document.getElementById('hdnVisitNumber').value;
                }
                if (rdbType == 5) {
                    var SRFNumber;
                    SRFNumber = document.getElementById('hdnSRFNumberSearch').value;
                    if (SRFNumber == 'Y')
                    { 
                    ExternalVisitID = document.getElementById('hdnVisitNumber').value;
                }
                }
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetAuditTrailReport",
                    contentType: "application/json; charset=utf-8",
                    data: "{ ExternalVisitID: '" + ExternalVisitID + "',ExternalBarcode: '" + ExternalBarcode + "',Orgid: '" + Orgid + "'}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        pop.hide();
                        return false;
                    }
                });

            }
            catch (e) {
                pop.hide();
                //alert(e);
            }
            //added by amar [reason: hanging the page]
            pop.hide();
            //added by amar
        }

        function AjaxGetFieldDataSucceeded(result) {
            //debugger;
            var pop = $find("mdlPopup");
            var oTable;
            if (result != "[]") {
                oTable = $('#example').dataTable({
                oLanguage: {
                "sUrl": getLanguage()
    },
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bRetrieve": true,
                    "serverSide": true,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
            { "mDataProp": "DateTime",
                "fnRender": function(oObj) {
                    var oldDate = new Date(parseInt(oObj.aData.DateTime.slice(6, -2)));
                    //   var DateTime = (oldDate.getDate() + '/' + (1 + oldDate.getMonth()) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + oldDate.getMinutes().toString().slice(-2));
                    var DateTime = (oldDate.getDate() + '/' + (1 + oldDate.getMonth()) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + (oldDate.getMinutes() < 10 ? '0' : '') +   oldDate.getMinutes().toString());
                    return DateTime;
                }
            },
            { "mDataProp": "User" },
            { "mDataProp": "Location" },
            { "mDataProp": "Activity" },
            { "mDataProp": "TestValue" },
            { "mDataProp": "OldValues" },
             { "mDataProp": "CurrentValues" },
            { "mDataProp": "ActionType"}],
                    "sPaginationType": "full_numbers",
                    "sZeroRecords": "No records found",
                    "bSort": false,
                    "bJQueryUI": true,
                    "iDisplayLength": 20,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons":
                        //                        [
                        //            {
                        //                "sExtends": "copy",
                        //                "sButtonText": "copy",
                        //                "oSelectorOpts": { filter: "applied", order: "current" }
                        //            },
                        //            {
                        //                "sExtends": "csv",
                        //                "sButtonText": "csv",
                        //                "oSelectorOpts": { filter: "applied", order: "current" }
                        //            },
                        //            {
                        //                "sExtends": "xls",
                        //                "sButtonText": "xls",
                        //                "oSelectorOpts": { filter: "applied", order: "current" }
                        //            },
                        //            {
                        //                "sExtends": "pdf",
                        //                "sButtonText": "pdf",
                        //                "oSelectorOpts": { filter: "applied", order: "current" },
                        //                "sPdfOrientation": "landscape"
                        //            }
                        //        ]

                        //                        
                         [
//                            "copy", "csv", "xls", "pdf",
                            "copy", "csv", "xls", 
                             {
                                 "sExtends": "collection",
                                 "sButtonText": "Save",
                                // "aButtons": ["csv", "xls", "pdf"]
                                 "aButtons": ["csv", "xls"]
                             }
                          ]

                    }



                });
                
                
                $('#example').show();
                $('#example').dataTable().rowGrouping({
                    iGroupingColumnIndex: 7
            							 , bHideGroupingColumn: true
           							, sGroupingColumnSortDirection: "DESC"//,
                    // iGroupingOrderByColumnIndex: 0
                });


								
                pop.hide();

            }
            
        }

    
       
    </script>

    <script type="text/javascript">
       
  
  
        var InformationMsg;
        var Error;
        $(document).ready(function() {
            Error = SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_02") != null ? SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_02") : "Information";
            InformationMsg = SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_01") != null ? SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_01") : "Enter Visit Number";
            dialogfunc();
        });
        function Validate() {

            if (document.getElementById('txtVisitNumber').value == '') {
                //alert('Enter Visit Number');
                ValidationWindow(InformationMsg, Error);
                return false;
            }

        }
        function DisplayTab(tabName) {

            $('#TabsMenu li').removeClass('active');
            if (tabName == 'VREG') {
                $('#hdnflag').val('0');
                document.getElementById('tdViewRegistration').style.display = 'table-cell';
                document.getElementById('General').style.display = 'table-cell';
                document.getElementById('tdCommunication').style.display = 'none';
                $('#li1').addClass('active');
                document.getElementById('tdEpisodeHistory').style.display = 'none';
                document.getElementById('Worklist').style.display = 'none';
                document.getElementById('Notification').style.display = 'none';


            }
            if (tabName == 'EPI') {
                $('#hdnflag').val('1');
                document.getElementById('tdViewRegistration').style.display = 'none';
                document.getElementById('tdCommunication').style.display = 'none';
                $('#li2').addClass('active');
                document.getElementById('tdEpisodeHistory').style.display = 'table-cell';
                //                var btnShow = document.getElementById('btnShow');
                //                btnShow.click();
                document.getElementById('Worklist').style.display = 'none';
                document.getElementById('Notification').style.display = 'none';
                Validate();
                GetData();
            }

            if (tabName == 'CDM') {
                if (document.getElementById('txtVisitNumber').value == '') {
                    document.getElementById('tdViewRegistration').style.display = 'table-cell';
                    document.getElementById('tdCommunication').style.display = 'none';
                    $('#li1').addClass('active');
                    document.getElementById('tdEpisodeHistory').style.display = 'none';
                    document.getElementById('tdEpisodeHistory').focus();
                    //alert('Enter Visit Number');
                    ValidationWindow(InformationMsg , Error);
                    document.getElementById('Worklist').style.display = 'none';
                    document.getElementById('Notification').style.display = 'none';
                    return false;
                }
                $('#hdnflag').val('2');
                document.getElementById('tdViewRegistration').style.display = 'none';
                document.getElementById('tdEpisodeHistory').style.display = 'none';

                $('#li3').addClass('active');
                document.getElementById('tdCommunication').style.display = 'table-cell';
                var btnCommunication = document.getElementById('btnCommunication');
                btnCommunication.click();
            }
            if (tabName == 'WLD') {
                $('#li4').addClass('active');
                document.getElementById('tdViewRegistration').style.display = 'table-cell';
                document.getElementById('Notification').style.display = 'none';
                document.getElementById('Worklist').style.display = 'table';
                document.getElementById('tdCommunication').style.display = 'none';
                document.getElementById('tdEpisodeHistory').style.display = 'none';
                document.getElementById('General').style.display = 'none';
            }
            if (tabName == 'NOT') {
                $('#li5').addClass('active');
                document.getElementById('tdViewRegistration').style.display = 'table-cell';
                document.getElementById('Notification').style.display = 'table';
                document.getElementById('tdCommunication').style.display = 'none';
                document.getElementById('tdEpisodeHistory').style.display = 'none';
                document.getElementById('Worklist').style.display = 'none';
                document.getElementById('General').style.display = 'none';
            }

        }


            
           
 
    </script>

    <script type="text/javascript" language="javascript">

        function AssignReportValue() {
            var objReport = SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_07") == null ? "Report" : SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_07");
            document.getElementById('hdnSnapshotType').value = objReport;
            return true;
        }
        function AssignBillValue() {
            var objBill = SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_08") == null ? "Bill" : SListForAppMsg.Get("Reception_PatientTrackingDetails_aspx_08");
            document.getElementById('hdnSnapshotType').value = objBill;
            return true;
        }

//Added for validating Email
        function ValidateEmail() {

            var valEmail;
            valEmail = document.getElementById('txtMailAddress').value;
            if ((valEmail == null) || (valEmail == "")) {
                alert("Enter valid Email Address");
                return false;
            }
            
            
        }
       
    </script>

    <script type="text/javascript">
        $(document).on("click", "[id*=LinkPatientHistory]", function() {
            $("#divHistoryDetail").dialog({
            width: 1050,
                height: 550,
                position: ['middle', 50],
                closeOnEscape: true,
                title: "View Patient History",
                modal: true,
                buttons: {
//                    "Save": {
//                        text: 'Save',
//                        id: 'DiaSave',
//                        click: (function() {
//                            SavePatientHistory();
//                            $(this).dialog("close");
//                        })
//                    },
//                    "Update": {
//                        text: 'Update',
//                        id: 'DiaUpdate',
//                        click: (function() {
//                            UpdatePatientHistory();
//                            $(this).dialog("close");
//                        }),
//                        style: 'display:none'
//                    },
                    "Cancel": function() {
                        $(this).dialog("close");
                    }
                }
            });
            return false;
        });

        function Editpatienthistory() {

            $(".tblCliHisClass").empty();
            var OrgID = $("#hdnPHCorgID").val();
            var VisitID = $('#hdnVisitID').val();
            AjaxcontentData = "{'OrgID':" + OrgID + ",'VisitID':" + VisitID + "}";
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetEditPatientHistory ",
                // url: "../WebService.asmx/GetEditPatientHistoryNew",
                contentType: "application/json;charset=utf-8",
                data: AjaxcontentData,
                dataType: "json",
                success: function Aj(dat) {
                    AjaxGetFieldDataSuccees(dat);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice GetEditPatientHistory calling");
                    //$('#divHistoryDetail').hide();
                    return false;
                }
            });
        }
        var lstEdithis = [];
        function AjaxGetFieldDataSuccees(result) {
         //   debugger;
            lstEdithis = result.d;

            if (lstEdithis.length > 0) {

                $(".tblCliHisClass").empty();
                $(".tblCliHisClass").append("<tr class='dataheader1'><th>Test Name</th><th>History Name</th> <th>History Value</th></tr>")

                for (var i = 0; i < result.d.length; i++) {
                    $(".tblCliHisClass").append("<tr><td>" + result.d[i].Description + "</td><td>" + result.d[i].HistoryName + "</td><td>" + result.d[i].AttributeValueName + "</td></tr>");

                }
                // $("#divPatientClinicalHistory").css();
               // $("#DiaSave").css("display", "none");
                $(".NoRecordsFoundClass").css("display", "none");

            }
            else {
                //alert('AS');

                $(".tblCliHisClass").empty();
                // $("#tblClinicalHistory").append("<tr ><td colspan='2'>No Records Found</td></tr>")

                $(".NoRecordsFoundClass").css("display", "block");
                //                $("#divPatientClinicalHistory").hide();
              //  $("#DiaSave").css("display", "none");


            }
            // return true;
        }



        //-----------------Update Patient History-----------------//


        function UpdatePatientHistory() {

            try {
               

                var lstResultValues = [];
                //-----------------------------Germline Format-----------------------//
                //              var  lsthdnloadhistory = $.parseJSON('[' + $('#hdnloadhistory').val() + ']');

                //                for (var i = 0; i < lsthdnloadhistory[0].length; i++) {
                for (var i = 0; i < lstEdithis.length; i++) {
                    if (lstEdithis[i].ActionType == 'Germline Format') {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtdescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Indications") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlindications option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtfamilyhistory').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Referal For") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlreferral option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtkeyfinding').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });

                        }


                        if ($.trim(lstEdithis[i].HistoryName) == "Germline Panel Type") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlpaneltype option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });

                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Is Affected with cancer") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlcancer option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });


                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txttype").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtOptionalDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {

                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtstrandcaseid').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkmoreinfo").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlethinicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_chkboxnewvalidation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                    }


                    //------------------------MST Format----------------------------------------//
                    else if (lstEdithis[i].ActionType == 'MST Format') {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtMSTDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlMstAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Indications") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlMSTIndicaions option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtMSTFamilyHistory").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Gene Name") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlMSTGeneName option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Mutation Descriptions") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtMSTMutation").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtMSTOptionalDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Related Requests") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtMSTRelatedRequest").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtMSTKeyFinding").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Germline Panel Type") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlMSTGermlinePanel option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkMSTMoreInformation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlMSTEthncity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkNewPanelValidation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }
                    }
                    //------------------------Somatic Format---------------------------------------//
                    else if (lstEdithis[i].ActionType == 'Somatic Format') {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticdesc").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });

                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlSomaticAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticTumour").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });

                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticTumar").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSoamaticPathology").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticTheraphy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticAddtstDone").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticFamilysty").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticKey").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticRelevant").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaicStandCase").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkSomaticMoreInformation ").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlSomaticEthnicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkSomaticPanelValidation ").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlSomaticGeneResult option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "KRAS") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticKRAS").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "PIKSCA") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticPIKSCA").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "NRAS") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticNRAS").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "BRAF") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticBRAF").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "AKTI-KIT-EGFR-PGDFRA") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticAkit").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticOptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                    }


                    //-------------------------TSP Breast Format  --------------------------//
                    else if (lstEdithis[i].ActionType == "TSP Breast Format") {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPTumaroption").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPBurden").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPPathology").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPTheraphy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPAdd").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPOptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPFamily").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPKeyFind").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPRelated").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPStand").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkTSPInformation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPEthnicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkTSPPanelValid ").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPGene option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                    }
                    //--------------------TSP Colon Format---------------------------------------//
                    else if (lstEdithis[i].ActionType == "TSP Colon Format") {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonDesc").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlColonAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonTumor").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonBurden").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonPathology").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonTherapy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonAddtest").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonOptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }


                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonFamily").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonKeyFinding").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonRelated").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonStrend").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkColonMoreInfo").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlcolonethnicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkColonPanelValid").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlColonGene option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                    }
                    //----------------------TST lung Format-----------------------------------------------------//
                    else if (lstEdithis[i].ActionType == "TST lung Format") {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungdesc").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPlung option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungtumour").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungburden").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungpatho").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID

                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungtherapy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {
                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtlungadd').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungoptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungfamily").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungkey").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungreq").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungstrend").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chklunginfo").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddllungethn option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chklungpanel").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddllunggene option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID
                            });
                        }
                    }
                }

                var ss = JSON.stringify(lstResultValues);

                var AjaxContent = "{'lstUpdateHistory':'" + ss + "'}";

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/UpdatePatientHistoryService",
                    contentType: "application/json; charset=utf-8",
                    data: AjaxContent,
                    dataType: "json",
                    success: function(data) {
                        alert("Updated Successfully");
                        $('#patientcapturehistory1_tblCapturePatientHistory').hide();
                        return false;
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error in Webservice Calling");

                        $('#patientcapturehistory1_tblCapturePatientHistory').hide();

                        return false;
                    }
                });
                return false;
            }
            catch (e) {
                alert("Unable to Save");
                return false;
            }
        }

        function openPopup(url, h, w, t) {
            var visitNumber = document.getElementById('txtVisitNumber').value;
            url = "Lab/PatientComparisonReport.aspx?VisitNumber=" + visitNumber;
            //if (url != null && h != null && w != null && t != null) {
               // url = "Lab / PatientComparisonReport.aspx"
                urlBase = location.href.substring(0, location.href.lastIndexOf("/") -9);
                url = urlBase + url;
                //window.open(url, '', 'width=800,height=600');
                $('#MyDialog').html('<iframe border=0 width="100%" height ="100%" src="' + url + '"> </iframe>');
                $("#MyDialog").dialog({
                    title: 'Trend Report',
                    modal: true,
                    autoOpen: true,
                    height: 700,
                    width: 2500,
                    resizable: false,
                    position: ['right-100', 'top+30'],
                    closeOnEscape: false,
                    dialogClass: "alert"
                });
                //}
                return false;
        }
    
    </script>
    
<script type="text/javascript" language="javascript">

    function GetVisitNumbers() {
        try {
            var Orgid = document.getElementById('hdnBaseOrgId').value;
            var PageID = document.getElementById('hdnPageID').value;
            var PatientNumber = document.getElementById('txtVisitNumber').value;
            if (document.getElementById('txtVisitNumber').value == '') {
                alert('Enter the Number to Search');
                return false;
            }
            var radioButtons = document.getElementsByName('<%=rdbType.ClientID%>');
            var chkvalue = 0;
                for (var x = 0; x < radioButtons.length; x++) { 
                    if (radioButtons[x].checked) {
                        chkvalue= radioButtons[x].value;
                    }
                }
var ExBarcode;
                ExBarcode = document.getElementById('hdnExternalBarcodeSearch').value;
                if (chkvalue == "2" && ExBarcode=="Y" ) {
                    PatientNumber = PatientNumber + ",Barcode" ;
                }
				if (chkvalue == "5" ) {
                    PatientNumber = PatientNumber + ",SRFNumber";
                }
//changes by arun            
            if (vVisitnumber != PatientNumber && vSearchType != chkvalue) {
                vIsAvailGrpng = 0;
            }
            var vVisitnumber = PatientNumber;
            var vSearchType = chkvalue;
            //
                if (chkvalue == "4" || (chkvalue == "2" && ExBarcode=="Y") || chkvalue == "5") {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/GetVisitNumbersByPID",
                        contentType: "application/json; charset=utf-8",
                        data: "{ 'pPatientNumber': '" + PatientNumber + "','pPageID':" + PageID + "}",
                        dataType: "json",
                        success: AjaxGetFieldDataSucceeded2,
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            $('#VisitNumbertbl').hide();
                            return false;
                        }
                    });
                    if (document.getElementById('hdnVisitNumber').value == '')
                        return false;
                    else
                        return true;    
                }
                else
                    return true;
        }
        catch (e) {
        }
        return false;
    } 
    function AjaxGetFieldDataSucceeded2(result) {
        var oTable;
        if (result != "[]") {
            oTable = $('#VisitNumbertbl').dataTable({
                "bDestroy": true,
                "bAutoWidth": false,
                "bProcessing": true,
                "aaData": result.d,
                "aoColumns": [
                { "mDataProp": "PatientNumber" },
                { "mDataProp": "Name" },
                { "mDataProp": "MobileNumber" },
            { "mDataProp": "VisitNumber",
                "mRender": function(data, type, full) {

                    if (data != '') {
                        var Parameters = "'" + data + "'"; //,'" + full.Dilution + "','" + full.UOMCode + "','" + UniqueID + "_lblRangeCode'";
                        return '<span onclick="BindVisitNumber(' + Parameters + ')" id="Barcode' + data + '"><u>' + data + '</u></span>'

                    }
                }
            },
             { "mDataProp": "NextReviewDate" }],
            //{ "mDataProp": "Location"}],
                "bPaginate": false,
                "sZeroRecords": "No records found",
                "bSort": false,
                "bJQueryUI": true,
                "iDisplayLength": 20
            });
            $('#VisitNumbertbl').show();
            if(result.d.length==0)
                document.getElementById('trPatDetails').style.display = 'none'; 
        } else {
        $('#VisitNumbertbl').hide(); 
        }
    }

    function BindVisitNumber(data) {
        try {
            var VisitNumber = data;
            document.getElementById('hdnVisitNumber').value = VisitNumber;

            if (document.getElementById('hdnVisitNumber').value != '') { 
                $("#btnGo").click();
            }


        }
        catch (e) {
        }
    }


</script>


</body>
</html>
