<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RecheckRegisteredVisits.aspx.cs"
    Inherits="Reception_RecheckRegisteredVisits" EnableEventValidation="false" meta:resourcekey="PageResource1"
    Culture="auto" UICulture="auto" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="uc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Recheck Registered Visit Details</title>

    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/RecheckRegistration.js" type="text/javascript"></script>

    <style type="text/css">
        .dataheaderPopup
        {
            background-image: url(../Images/whitebg.png);
            background-repeat: repeat;
            width: auto;
            margin-left: 0px;
            margin-top: 0px;
            margin-bottom: 10px;
            border-color: #f17215;
            border-style: solid;
            border-width: 5px;
            color: #000000;
        }
        .style2
        {
            height: 35px;
        }
        .style3
        {
            width: 27%;
            height: 27px;
        }
        .style4
        {
            height: 19px;
        }
        .recheckDetails table td{ padding:5px;}
    </style>

    <script type="text/javascript">

        function getrefhospid(source, eventArgs) {

            var sval = 0;

            var OrgID = document.getElementById('hdnOrgID').value;
            var rec = document.getElementById('hdfReferalHospitalID').value;
            var sval = "RPH" + "^" + OrgID + "^" + rec;
            $find('AutoCompleteExtenderRefPhy1').set_contextKey(sval);
        }


        function CheckEmail() {
            var elements = document.getElementById('chkDespatchMode');
            if (document.getElementById('txtEmail').value != '') {

                elements.cells[0].childNodes[0].checked = true;
            }
            else {
                elements.cells[0].childNodes[0].checked = false;

            }
        }


        function ShowPopUp(visitnumber) {
            var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
        }
        function CheckHubName(codeType, TxtID) {
            var txtValue = document.getElementById(TxtID).value.trim();


            if (txtValue != '') {
                if (document.getElementById('hdnHubID').value == '0') {
                    alert('Select the Hub Name From List')
                    document.getElementById('txtHub').focus();
                    document.getElementById('txtHub').value = '';
                    return false;
                }
            }
        }
        function CheckZoneName(codeType, TxtID) {
            var txtValue = document.getElementById(TxtID).value.trim();


            if (txtValue != '') {
                if (document.getElementById('hdntxtzoneID').value == '0') {
                    alert('Select the Zone Name From List')
                    document.getElementById('txtzone').focus();
                    document.getElementById('txtzone').value = '';
                    return false;
                }
            }
        }
        function OnHubSelected(source, eventArgs) {
            document.getElementById('txtHub').value = eventArgs.get_text();
            document.getElementById('hdnHubID').value = eventArgs.get_value();
            if (document.getElementById('hdnHubID').value != "0") {
                $find('AutoCompleteExtender2').set_contextKey('zone' + '~' + document.getElementById('hdnHubID').value);
            }
            else {
                $find('AutoCompleteExtender2').set_contextKey('');
            }
        }
        function ClearFields(Name) {
            if (Name == 'ZON') {
                document.getElementById('hdntxtzoneID').value = '0';
            }
        }
        function Onzoneselected(source, eventArgs) {
            document.getElementById('txtzone').value = eventArgs.get_text();
            document.getElementById('hdntxtzoneID').value = eventArgs.get_value();
            if (document.getElementById('hdntxtzoneID').value != "0") {
                $find('AutoCompleteExtender2').set_contextKey('route' + '~' + document.getElementById('hdntxtzoneID').value);
            }
            else {
                $find('AutoCompleteExtender2').set_contextKey('');
            }
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
        function DiscountAuthSelectedOver(source, eventArgs) {
            $find('AutoUser')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoUser')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    alert('Please select user from the list');
                    document.getElementById('txtUserName').value = '';
                }
            };
        }
        function DiscountAuthSelected(source, eventArgs) {
            if (eventArgs != undefined) {
                document.getElementById('hdnApprovedByID').value = eventArgs.get_value();
            }
            else {
                document.getElementById('hdnApprovedByID').value = "0";
            }
        }
        var userMsg;
        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_7") {
                alert('Please Proceed via Todays Patient Link');
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_8") {
                alert('This action cannot be performed for New born baby');
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_9") {
                alert('URL Not Found');
                return false;
            }
            else if (key == "Reception\\VisitDetails.aspx.cs_10") {
                alert('Munst CheckIn the Mrd File');
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_11") {
                alert('Visit State Already Closed');
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_12") {
                alert('Task Status Can not be Pending');
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_13") {
                alert('OP Visit Closed successfully');
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_14") {
                alert('Which is not OP Patient');
                return false;
            }
            else if (key == "ReceptionVisitDetails.aspx.cs_15") {
                alert('There is no CaseSheet for this Patient');
                return false;
            }
            return true;
        }

        function CheckValidation_alert() {
            //if (document.getElementById("hdnspecdept").value == 'Y') {
            if (document.getElementById("txtPname").value == "" && document.getElementById("txtFrom").value == "" && document.getElementById("txtTo").value == "" && document.getElementById("txtPatientNumber").value == "" && document.getElementById("ddlocations").value == "0") {
                alert("Please Select Any One");
                return false;
            }
            var StartDate = document.getElementById('txtFrom').value;
            var EndDate = document.getElementById('txtTo').value;
            var eDate = new Date(EndDate);
            var sDate = new Date(StartDate);
            //                if (StartDate != '' && StartDate != '' && sDate > eDate) {
            //                    alert("Please ensure that the To Date is greater than or equal to the From Date.");
            //                    return false;
            //                }
            //                else {
            //                    return true;
            //                }
            if (document.getElementById('txtFrom').value != '' && document.getElementById('txtTo').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Provide To date');
                }
                document.form1.txtTo.focus();
                return false;
            }

            else {
                return true;
            }
            //            }

            //            else {
            //                if (document.getElementById("txtPname").value == "" && document.getElementById("ddlDepartment").value == "0" && document.getElementById("ddlspeciality").value == "0" && document.getElementById("txtFrom").value == "" && document.getElementById("txtTo").value == "" && document.getElementById("txtPatientNumber").value == "" && document.getElementById("ddlocations").value == "0") {
            //                    alert("Please Select Any One");
            //                    return false;
            //                }

            //                else {
            //                    return true;
            //                }
            //            }
        }
        function isNumericss(e, Id) {

            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 1) {
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
        function PrintBill(obj) {

            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=no,height=600,width=800";
            // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
            strFeatures = strFeatures + ",left=0,top=0,";
            var PrintWindow = window.open(obj, "", strFeatures);
            PrintWindow.focus();
            PrintWindow.print();

        }
        function loaddrop(id) {

            var ddlobj = document.getElementById('ddlVisitActionName');
            var HidValue = document.getElementById('hdnvisit').value;
            var MasterID = id;
            var list = HidValue.split('^');

            if (ddlobj.Count <= 0) {
                if (document.getElementById('hdnvisit').value != "") {
                    ddlobj.options.length = 0;
                    for (var count = 0; count < list.length; count++) {
                        var Rate = list[count].split('~');
                        if (MasterID == Rate[0]) {
                            // var drp = eval(document.getElementById('ddlVisitActionName'));
                            var opt = document.createElement("option");
                            document.getElementById("ddlVisitActionName").options.add(opt);
                            opt.text = Rate[2];
                            opt.value = Rate[1];

                            //drp.appendChild(opt);

                            //document.getElementById("ddlVisitActionName").Items.Add(Rate[1]);
                            //document.getElementById("ddlVisitActionName").DataTextField = Rate[2];
                            //document.getElementById("ddlVisitActionName").DataValueField = Rate[1];
                            //document.getElementById("ddlVisitActionName").options[count] = new Option(Rate[2], Rate[1]);

                            //document.getElementById("ddlVisitActionName").Items.Add(Rate[2], Rate[1]);

                        }
                    }
                }
            }

        }

        function Select_Visit(id, vid, pid, PName, vtype, vstid, vs, PNo) {

            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }

            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPNO").value = PNo;
            document.getElementById("hdnPID").value = pid;
            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("visitState").value = vstid;
            document.getElementById("visittype").value = vtype;
            document.getElementById("isCredit").value = vs; //iscredit
            if (document.getElementById('ddlType').value == "Both") {
                loaddrop(vtype);
            }
        }

        function CheckVisitID() {
            //alert(document.getElementById('hdnVID').value);
            if (document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML == 'Edit Admission Patient Details') {


                if (document.getElementById("visitState").value == 'Discharged' && document.getElementById("isCredit").value == 'Y' && document.getElementById("visittype").value == 1) {
                    document.getElementById('hdnVisitDetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML;
                    return true;
                }
                else if (document.getElementById("visittype").value == 0) {
                    // Reception\VisitDetails.aspx_1
                    var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        alert('This is OP patient. So you can not Edit');

                        return false;
                    }
                }
                else {
                    //Reception\VisitDetails.aspx_2
                    var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        alert('This  is not a Discharged/Credit patient. So you can not Edit');

                        return false;
                    }
                }
            }
            if (document.getElementById('hdnVID').value == '') {
                //Reception\VisitDetails.aspx_3
                var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_3');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;

                }
                else {
                    alert('Select visit detail');

                    return false;
                }
            }


            else {

                document.getElementById('hdnVisitDetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML;
                //document.getElementById('hdndrpdowndetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedValue].innerTEXT;
                //destElement = document.getElementById("hdndrpdowndetail");

                //sourceElement = document.getElementById("ddlVisitActionName").options.text;

                //destElement.value = sourceElement(sourceElement.text);
                //                var e = document.getElementById("ddlVisitActionName"); // select element
                //                var strUser = e.options[e.selectedIndex].text;
                //                document.getElementById('hdndrpdowndetail').value = document.getElementById('ctl00_mainContent_ctl02_ddlVisitActionName')[document.getElementById('ctl00_mainContent_ctl02_ddlVisitActionName').selectedIndex].innerText
                //                alert(hdndrpdowndetail.value);
                //                alert(strUser);               ;

                var action = document.getElementById("ddlVisitActionName");

                var Actionname = action.options[action.selectedIndex].value;
                if (Actionname == "TRF_Upload") {
                    document.getElementById('divUpload').style.display = 'block';
                    document.getElementById('divphoto').style.display = 'none';
                }
                else if (Actionname == "Photo_Upload") {
                    document.getElementById('divUpload').style.display = 'none';
                    document.getElementById('divphoto').style.display = 'block';
                }
                else {
                    document.getElementById('divUpload').style.display = 'none';
                    document.getElementById('divphoto').style.display = 'none';
                }
                return true;


            }


        }

        function CheckVisitDate() {

            if (document.getElementById('txtFrom').value == '') {
                //Reception\VisitDetails.aspx_5
                var userMsg = SListForApplicationMessages.Get('Reception\\VisitDetails.aspx_6');
                if (userMsg != null) {
                    alert(userMsg);


                }
                else {
                    alert('Provide From date');


                }
                document.form1.txtFrom.focus();
                return false;
            }

            return true;

        }
        function storevalue() {
            var e = document.getElementById("ddlVisitActionName"); // select element
            var strUser = e.options[e.selectedIndex].text;

            document.getElementById('hdndrpdowndetail').value = strUser;
            //alert(document.getElementById('hdndrpdowndetail').value);
        }
        function PrintCaseSheet(vid, pid, vType) {
            window.open("../Physician/ViewIPCaseSheet.aspx?vid=" + vid + "&pid=" + pid + "&vType=" + vType + "&IsPopup=Y&Prt=Y" + "", '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            return false;
        }
        function OpenPopUp(patientVisitID, FinalBillID, BillNumber) {
            window.open("../Reception/ViewPrintPage.aspx?vid=" + patientVisitID + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + FinalBillID + "&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y", '', 'height=900,width=900,left=0,top=30,resizable=No,scrollbars=No,toolbar=no,menubar=no,location=no,directories=no, status=No');
        }
      
        
        
    </script>

    <script type="text/javascript">


        function PrintOpCard() {
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write($('#divGenerateVisit').html());
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function checkForValues() {

            if (document.getElementById('txtpageNo').value == "") {
                alert('Provide page number');
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                alert('Provide correct page number');
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerHTML)) {
                alert('Provide correct page number');
                return false;
            }


        }
        function MoveNext() {
            if (document.getElementById('lblCurrent').innerHTML == document.getElementById('lblTotal').innerHTML) {
                alert('This is Last Visit');
                return false;
            }
            else {
                //                document.getElementById("CheakInv").style.display = "none";
            }
        }
        function MovePrevious() {

            if (document.getElementById('lblCurrent').innerHTML == "1") {
                alert('This is First Visit');
                return false;
            }
            else {
                //                document.getElementById("CheakInv").style.display = "none";
            }
        }


        function ShowHeader() {
            try {
                if (document.getElementById('header').style.display == 'block')
                    document.getElementById('header').style.display = 'none';
                else
                    document.getElementById('header').style.display = 'block';
            }
            catch (e) {
            }
            return false;
        }
        function ShowHideHeader() {
            try {
                if (document.getElementById('imgShowHeader').src.split('Images')[1] == '/expand.jpg')
                    document.getElementById('imgShowHeader').src = '../Images/collapse.jpg';
                else if (document.getElementById('imgShowHeader').src.split('Images')[1] == '/collapse.jpg')
                    document.getElementById('imgShowHeader').src = '../Images/expand.jpg';
            }
            catch (e) {
            }
            return false;
        }
        function Showmenu1() {
            if (document.getElementById('menu').style.display == 'block')
                document.getElementById('menu').style.display = 'none';
            else
                document.getElementById('menu').style.display = 'block';

            return false;
        }
        function Showhide1() {
            if (document.getElementById('showmenu').src.split('Images')[1] == '/show.png') {
                document.getElementById('showmenu').src = '../Images/hide.png';
                document.getElementById('Content').style.width = '100%';
            }
            else if (document.getElementById('showmenu').src.split('Images')[1] == '/hide.png') {
                document.getElementById('showmenu').src = '../Images/show.png';
                document.getElementById('Content').style.width = '100%';
            }

        }
        function show() {
            if (document.getElementById('Filter').style.display == 'block')
                document.getElementById('Filter').style.display = 'none';
            else
                document.getElementById('Filter').style.display = 'block';

            return false;

        }
        function hide() {

            if (document.getElementById('Img2').src.split('Images')[1] == '/showBids.gif') {
                document.getElementById('Img2').src = '../Images/hideBids.gif';
                document.getElementById('Content').style.width = '100%';
            }
            else if (document.getElementById('Img2').src.split('Images')[1] == '/hideBids.gif') {
                document.getElementById('Img2').src = '../Images/showBids.gif';
                document.getElementById('Content').style.width = '100%';
            }

        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div style="display: none;">
        <ul>
        <li class="dataheader">
            <asp:Label ID="lbvisitdets" runat="server" Text="Visit Details :" meta:resourcekey="lbvisitdetsResource1"></asp:Label>
            (<asp:Label ID="lblPName" runat="server" meta:resourcekey="lblPNameResource1"></asp:Label>)
        </li>
        </ul>
    </div>
       
                    <div class="contentdata">
                       
                        <%-- <asp:UpdatePanel ID="pnl_Client" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <div class="Progress">
                                            <img src="../Images/working.gif" />
                                            <asp:Label ID="lbloading" runat="server" Text="Loading ..." meta:resourcekey="lbloadingResource1"></asp:Label>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>--%>
                        <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlFilterResource1">
                            <table class="w-100p">
                                <tr>
                                    <td class="a-left h-23">
                                        <img alt="" onclick="show();hide();" src="../Images/showBids.gif" id="Img2" style="cursor: pointer;" />
                                        <asp:Label ID="lblfilter" runat="server" Text="Search Filter"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <div style="display: none;" runat="server" id="Filter" class="w-100p">
                            <table class="dataheader3 w-100p" id="CheakInv">
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr class="h-26">
                                                <td class="defaultfontcolor w-17p v-top">
                                                    <asp:Label runat="server" ID="lblPatientNumber" Text="Patient Number" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:TextBox ID="txtPatientNumber" runat="server" CssClass="Txtboxsmall" TabIndex="1"
                                                        onblur="javascript:return CearetxtDate();" meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
                                                </td>
                                                <td class="defaultfontcolor w-17p v-top">
                                                    <asp:Label runat="server" ID="lblFilterPatientname" Text="Patient Name" meta:resourcekey="lblFilterPatientnameResource1"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:TextBox ID="txtPname" runat="server" TabIndex="2" CssClass="Txtboxsmall" onblur="javascript:return CearetxtDate();"></asp:TextBox>
                                                </td>
                                                <td class="w-16p v-top">
                                                    <asp:Label ID="lblFilterClientname" runat="server" Text="Client Name"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" Width="130px" CssClass="AutoCompletesearchBox"
                                                        TabIndex="3" onblur="javascript:return CearetxtDate();" onchange="SetClientID()"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                        OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                        OnClientItemOver="SelectedOver" Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr class="h-30">
                                                <td class="defaultfontcolor w-17p v-top">
                                                    <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" Width="120px" TabIndex="4"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <a href="javascript:NewCssCal('txtFrom','ddmmyyyy','arrow',true,12)">
                                                                    <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date"></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="defaultfontcolor w-17p v-top">
                                                    <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtTo" runat="server" TabIndex="5" Width="120px" CssClass="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,12)">
                                                                    <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-16p v-top">
                                                    <asp:Label runat="server" ID="lbl" Text="Doctor Name"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:TextBox ID="txtInternalExternalPhysician1" runat="server" CssClass="AutoCompletesearchBox"
                                                        onchange="SetPhysicianID()" Width="130px"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                        FirstRowSelected="true" MinimumPrefixLength="1" ServiceMethod="GetPhysician"
                                                        OnClientItemSelected="SetPhysicianID" OnClientItemOver="SelectedOverPhy" ServicePath="~/Webservice.asmx"
                                                        TargetControlID="txtInternalExternalPhysician1">
                                                    </cc1:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr class="h-30" id="HideSpec" runat="server">
                                                <td class="w-15p v-top">
                                                    <asp:Label ID="lblDepartment" runat="server" Text="Department"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:Label ID="Rs_Speciality" Text="Speciality" runat="server"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:DropDownList ID="ddlspeciality" runat="server" CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr class="h-30">
                                                <td class="defaultfontcolor w-15p v-top">
                                                    <asp:Label runat="server" ID="lblVisitType" Text="Visit Type" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:DropDownList ID="ddlType" runat="server" TabIndex="5" CssClass="ddlsmall" meta:resourcekey="ddlTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:Label ID="lblloc" Text="Location" runat="server"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:DropDownList ID="ddlocations" runat="server" TabIndex="5" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:Label ID="lblUserName" Text="Registered User" runat="server"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:TextBox ID="txtUserName" autocomplete="off" CssClass="AutoCompletesearchBox"
                                                        runat="server" Width="130px" onchange="DiscountAuthSelected()" />
                                                    <cc1:AutoCompleteExtender ID="AutoUser" runat="server" CompletionInterval="1" FirstRowSelected="true"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                        Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandID"
                                                        ServicePath="~/WebService.asmx" TargetControlID="txtUserName" OnClientItemOver="DiscountAuthSelectedOver"
                                                        OnClientItemSelected="DiscountAuthSelected">
                                                    </cc1:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr class="h-30">
                                                <td class="w-15p v-top">
                                                    <asp:Label ID="lblZone" Text="Zone" runat="server" meta:resourcekey="Label5Resource9"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:TextBox ID="txtzone" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox"
                                                        Width="130px" onBlur="CheckZoneName('Zone',this.id);"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                        onchange="javascript:return ClearFields('ZON');" meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                                        OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                        Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <asp:Label ID="drpStatus" runat="server" Text="Verification Status"></asp:Label>
                                                </td>
                                                <td class="w-15p v-top">
                                                    <span class="richcombobox">
                                                        <asp:DropDownList CssClass="ddlsmall" ID="ddlStatus" runat="server">
                                                            <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Text="Verify" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Not Verify" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td colspan="4" class="a-center">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1"
                                            OnClientClick="javascript:return CheckValidation_alert();" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table class="w-100p">
                            <tr style="display: none;">
                                <td>
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                        DataKeyNames="PatientVisitID,Name" Width="100%" OnPageIndexChanging="grdResult_PageIndexChanging"
                                        class="mytable1" meta:resourcekey="grdResultResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                    <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                                    <asp:HiddenField ID="hdnvisit" runat="server" />
                                    <asp:HiddenField ID="hdnPatOrgID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnPatientID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnVisitID" runat="server" Value="0" />
                                </td>
                            </tr>
                        </table>
                        <div id="TRFDETAILS" runat="server">
                            <table class="w-100p">
                                <tr class="dataheaderInvCtrl">
                                    <td class="defaultfontcolor a-right">
                                        <div>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <table class="w-100p bg-row" id="divFooterNav"
                                                            runat="server">
                                                            <tr>
                                                                <td class="w-15p a-center">
                                                                    <asp:Label ID="Label5" runat="server" meta:resourcekey="Label1Resource1" Text="Patient"></asp:Label>
                                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                                    <asp:Label ID="Label7" runat="server" meta:resourcekey="Label2Resource1" Text="Of"></asp:Label>
                                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                                    <asp:Button ID="Btn_Previous" runat="server" CssClass="btn" meta:resourcekey="Btn_PreviousResource1"
                                                                        OnClick="Btn_Previous_Click" Style="width: 71px" Text="Previous" Visible="false" />
                                                                </td>
                                                                <td class="w-10p a-center">
                                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/previousimage.png"
                                                                        OnClick="Btn_Previous_Click" OnClientClick="javascript:return MovePrevious();" />
                                                                    &nbsp;&nbsp;
                                                                    <asp:ImageButton ID="imgQuickDiagnosis" runat="server" ImageUrl="~/Images/nextimage.png"
                                                                        OnClick="Btn_Next_Click" OnClientClick="javascript:return MoveNext();" />
                                                                </td>
                                                                <td class="w-20p">
                                                                    <asp:Button ID="Btn_Next" runat="server" CssClass="btn" meta:resourcekey="Btn_NextResource1"
                                                                        OnClick="Btn_Next_Click" Text="Next" Visible="false" />
                                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                    <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                                    <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                                    <asp:Label ID="Label9" runat="server" meta:resourcekey="Label3Resource1" Text="Enter the Number to Go:"></asp:Label>
                                                                    <asp:TextBox ID="txtpageNo" runat="server" meta:resourcekey="txtpageNoResource1"
                                                                          onkeypress="return ValidateOnlyNumeric(this);"   Width="30px"></asp:TextBox>
                                                                </td>
                                                                <td class="w-10p a-left">
                                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/go-btn.png"
                                                                        OnClick="btnGo1_Click" OnClientClick="javascript:return checkForValues();" />
                                                                    <asp:Button ID="btnGo" runat="server" CssClass="btn" meta:resourcekey="btnGoResource1"
                                                                        OnClick="btnGo1_Click" OnClientClick="javascript:return checkForValues();" Text="Go"
                                                                        Visible="false" />
                                                                </td>
                                                                <td class="w-20p a-center">
                                                                    <asp:Button ID="btnVerify" Style="width: 120px" runat="server" Text="Verify" CssClass="btn"
                                                                        OnClick="btnVerify_Click" OnClientClick="return checkCancel()" />
                                                                    <asp:Button ID="btnEdit" Style="width: 120px" runat="server" Text="Edit" CssClass="btn"
                                                                        OnClick="btnEdit_Click" OnClientClick="return CheckEditData()" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <table class="w-100p searchPanel">
                                            <tr>
                                                <td  class="w-50p v-top">
                                                    <fieldset>
                                                        <legend class="bold">TRF Details</legend>
                                                        <asp:Panel ID="pnlOthers" runat="server" Width="100%" Style="overflow: auto;">
                                                            <div id="divFullImage">
                                                                <table class="w-100p dataheader2 defaultfontcolor">
                                                                    <tr id="trDropDown" runat="server">
                                                                        <td>
                                                                            <select id="ddlFileList" runat="server" class="ddl" style="width: 130px;" title="Select File Name to View">
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trPicPatient" runat="server">
                                                                        <td id="PicPatient" width="2%">
                                                                            <img id="imgPatient" runat="server" alt="Patient Photo" src="~/Images/noTRF.png" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trPDF" runat="server">
                                                                        <td>
                                                                            <iframe id="ifPDF" runat="server" width="640" height="460"></iframe>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </asp:Panel>
                                                    </fieldset>
                                                </td>
                                                <td  class="w-50p v-top recheckDetails">
                                                    <fieldset>
                                                        <legend class="bold">Patient Details</legend>
                                                        <table  class="w-100p">
                                                            <tr>
                                                                <td  class="w-20p">
                                                                    <asp:Label ID="HeadingVisitNumber" runat="server" Text="Visit Number :"></asp:Label>
                                                                </td>
                                                                <td  class="w-35p">
                                                                    <asp:Label ID="lblVisitNumber" runat="server" Style="width: 75px"></asp:Label>
                                                                </td>
                                                                <td  class="w-45p">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td  class="w-20p">
                                                                    <asp:Label ID="RS_PatName" runat="server" Text="Patient Name :"></asp:Label>
                                                                </td>
                                                                <td class="w-35p" id="tdNameReadmode" runat="server">
                                                                    <asp:Label ID="lblPatientName" runat="server" Style="width: 75px"></asp:Label>
                                                                </td>
                                                                <td class="w-45p" id="tdNameEditmode" runat="server">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList CssClass="ddl w-60" ID="ddSalutation" runat="server" TabIndex="1" Style="display: block;float: left;">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtName" TabIndex="2"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                                    autocomplete="off" runat="server" CssClass="Txtboxsmall" Style="display: inline;
                                                                                    width: 150px"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <span>
                                                                                    <img src="../Images/starbutton.png" alt="" align="middle" /></span>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td  class="w-20p">
                                                                    <asp:Label ID="Rs_PatAge" runat="server" Text="Patient Age :"></asp:Label>
                                                                </td>
                                                                <td  class="w-35p" id="tdAgeReadmode" runat="server">
                                                                    <asp:Label ID="lblAge" runat="server" Style="width: 75px;"></asp:Label>
                                                                </td>
                                                                <td  class="w-45p" id="tdAgeEditmode" runat="server">
                                                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" TabIndex="3" onblur="ClearDOB();" onchange="setDOBYear(this.id,'LB');"
                                                                             onkeypress="return ValidateOnlyNumeric(this);"    CssClass="Txtboxsmall w-18p"
                                                                        runat="server" MaxLength="5" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                                                    <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" TabIndex="4" Width="75px"
                                                                        runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                    <%--<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                    <cc1:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                                        Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                                                    </cc1:TextBoxWatermarkExtender>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td  class="w-20p">
                                                                    <asp:Label ID="Rs_DOB" runat="server" Text="DOB :"></asp:Label>
                                                                </td>
                                                                <td  class="w-35p" id="tdDOBReadmode" runat="server">
                                                                    <asp:Label ID="lblDOB" runat="server" Style="width: 75px"></asp:Label>
                                                                </td>
                                                                <td  class="w-45p" id="tdDOBEditmode" runat="server">
                                                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                                    <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" TabIndex="5" runat="server"
                                                                        onblur="javascript:countQuickAge(this.id);" Width="87px" Style="text-align: justify"
                                                                        ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
                                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                        CultureTimePlaceholder="" Enabled="True" />
                                                                    <cc1:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                    <span>
                                                                        <img src="../Images/starbutton.png" alt="" align="middle" /></span>
                                                                    <%--<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td  class="w-20p">
                                                                    <asp:Label ID="Rs_Gender" runat="server" Text="Gender :"></asp:Label>
                                                                </td>
                                                                <td  class="w-35p" id="tdGenderReadmode" runat="server">
                                                                    <asp:Label ID="lblGender" runat="server" Style="width: 75px; float: left;"></asp:Label>
                                                                </td>
                                                                <td  class="w-45p" id="tdGederEditmode" runat="server">
                                                                    <asp:DropDownList Width="70px" ID="ddlSex" runat="server" TabIndex="6" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                    <%-- <img src="../Images/starbutton.png" alt="" align="middle" style="display: block" />--%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="w-20p" >
                                                                    <asp:Label ID="Rs_PatientAddress" runat="server" Text="Patient Address1 :"></asp:Label>
                                                                </td>
                                                                <td class="w-35p"  id="tdPatientAddressReadmode" runat="server">
                                                                    <asp:Label ID="lblPatientAddress" runat="server" class="w-45" ></asp:Label>
                                                                </td>
                                                                <td class="w-45p" id="tdPatientAddressEditmode" runat="server">
                                                                 <asp:TextBox ID="txtAddress"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                                    runat="server" MaxLength="15"  CssClass="Txtboxsmall" Style="display: block"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                               <td class="w-20p" >
                                                                    <asp:Label ID="Rs_PatientAddress1" runat="server" Text="Patient Address2 :"></asp:Label>
                                                                </td>
                                                                <td class="w-30p"  id="tdPatientAddress1Readmode" runat="server">
                                                                    <asp:Label ID="lblPatientAddress1" runat="server" class="w-75" ></asp:Label>
                                                                </td>
                                                                <td class="w-45p"  id="tdPatientAddress1Editmode" runat="server">
                                                                 <asp:TextBox ID="txtPatientAddress1"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                                    runat="server" MaxLength="15"  CssClass="Txtboxsmall" Style="display: block"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                           
                                                              <tr>
                                                               <td class="w-20p" >
                                                                    <asp:Label ID="Rs_City" runat="server" Text="City:"></asp:Label>
                                                                </td>
                                                                <td class="w-35p"  id="tdCityReadmode" runat="server">
                                                                    <asp:Label ID="lblCity" runat="server" class="w-75" ></asp:Label>
                                                                </td>
                                                                <td class="w-45p" id="tdCityEditmode" runat="server">
                                                                 <asp:TextBox ID="txtCity"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                                    runat="server" MaxLength="15"  CssClass="Txtboxsmall" Style="display: block"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            
                                                            <tr>
                                                                <td class="w-25p" >
                                                                    <asp:Label ID="RS_Phoneno" runat="server" Text="Mobile No :"></asp:Label>
                                                                </td>
                                                                <td  class="w-35p" id="tdMobileReadmode" runat="server">
                                                                    <asp:Label ID="lblMobile" runat="server" Style="width: 75px"></asp:Label>
                                                                </td>
                                                                <td class="w-45p" id="tdMobileEditmode" runat="server">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <%--<asp:TextBox ID="txtMobile" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                    runat="server" MaxLength="15" CssClass="Txtboxsmall" Style="display: block"></asp:TextBox>--%>
                                                                                    <asp:TextBox ID="txtMobileNumber" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                    runat="server" MaxLength="15" TabIndex="7" CssClass="Txtboxsmall" Style="display: inline"></asp:TextBox>
                                                                            
                                                                            </td>
                                                                            <td>
                                                                                <span>
                                                                                    <img src="../Images/starbutton.png" alt="" align="middle" /></span>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="w-20p">
                                                                    <asp:Label ID="RS_Landlineno" runat="server" Text="Landline No :"></asp:Label>
                                                                </td>
                                                                <td class="w-35p" id="tdLandlineReadmode" runat="server">
                                                                    <asp:Label ID="lblLandline" runat="server" Style="width: 75px"></asp:Label>
                                                                </td>
                                                                <td class="w-45p" id="tdLandlineEditmode" runat="server">
                                                                    <%--<asp:TextBox ID="txtLandline" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                        runat="server" MaxLength="15" CssClass="Txtboxsmall" Style="display: block"></asp:TextBox>--%>
                                                                        <asp:TextBox ID="txtPhone" autocomplete="off"  TabIndex="8"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                        runat="server" MaxLength="15" CssClass="Txtboxsmall" Style="display: block"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="w-20p">
                                                                    <asp:Label ID="Rs_EmalID" runat="server" Text="EmailID :"></asp:Label>
                                                                </td>
                                                                <td class="w-35p" id="tdEmailReadmode" runat="server">
                                                                    <asp:Label ID="lblEmailID" runat="server" Style="width: 75px"></asp:Label>
                                                                </td>
                                                                <td class="w-45p" id="tdEmailEditmode" runat="server">
                                                                    <asp:TextBox ID="txtEmail" autocomplete="off" MaxLength="100" TabIndex="9" runat="server" CssClass="Txtboxsmall"
                                                                        onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');" Style="display: block"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="w-20p">
                                                                    <asp:Label ID="RS_RefDR" runat="server" Text="Refering Doctor :"></asp:Label>
                                                                </td>
                                                                <td class="w-35p" id="tdRefDrReadmode" runat="server">
                                                                    <asp:Label ID="lblRefDr" runat="server" Style="width: 75px"></asp:Label>
                                                                </td>
                                                                <td class="w-45p" id="tdRefDrEditmode" runat="server">
                                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" TabIndex="10" CssClass="AutoCompletesearchBox"
                                                                        onFocus="return getrefhospid(this.id)" Style="display: block"></asp:TextBox>
                                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy1" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                                        OnClientShown="DocPopulated" FirstRowSelected="true" MinimumPrefixLength="2"
                                                                        OnClientItemSelected="PhysicianSelected" ServiceMethod="GetRateCardForBilling"
                                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected" TargetControlID="txtInternalExternalPhysician">
                                                                    </cc1:AutoCompleteExtender>
                                                                </td>
                                                            </tr>
                                                           <%-- <tr >
                                                            <td><asp:Label ID="lblAddress" runat="server" style="display:none"></asp:Label>
                                                             <asp:TextBox ID="txtAddress" runat="server" style="display:none"></asp:TextBox> </td>
                                                            </tr>--%>
                                                        </table>
                                                    </fieldset>
                                                    <fieldset id="history" runat="server">
                                                        <legend class="bold">History And
                                                            Remarks </legend>
                                                        <asp:GridView ID="Bckgrd" runat="server" AutoGenerateColumns="False"
                                                            ForeColor="#333333" BorderColor="ActiveCaption" CssClass="dataheader2 w-100p gridView">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <Columns>
                                                                <%--<asp:TemplateField HeaderText="ID" InsertVisible="false">
                                                                            <ItemTemplate> 
                                                                                 
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                                <asp:TemplateField HeaderText="History">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="txtID" runat="server" Value='<%# Bind("ID2") %>' />
                                                                        <asp:Label ID="lblHistory" runat="server" Text='<%# Bind("History") %>'></asp:Label>
                                                                        <asp:TextBox ID="txtHistory" runat="server" Text='<%# Bind("History") %>' Style="display: none;"
                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Remarks">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                                                        <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>' Style="display: none;"
                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </fieldset>
                                                    <fieldset>
                                                        <legend style="font-size: medium; font-weight: bold; font-style: normal">Client Details</legend>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientNAme" runat="server" Text="Client Name :"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientName" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientCode" runat="server" Text="Client Code :"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientCode" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientAddress" runat="server" Text="Client Address :"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientAddress" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="RS_ClientZone" runat="server" Text="Client Zone :"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientZone" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_Clientphone" runat="server" Text="Client Phone No :" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientPhNo" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_EmailD" runat="server" Text="Client EmailID :" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="word-break: break-all">
                                                                    <asp:Label ID="lblClientEmail" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:TextBox ID="TextBox1" Style="background-color: White; vertical-align: text-top"
                                                                        ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                    <asp:Label ID="Label8" Text="Active Client" runat="server"></asp:Label>
                                                                    <asp:TextBox ID="TextBox2" Style="background-color: Orange; vertical-align: text-top"
                                                                        ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                    <asp:Label ID="Label6" Text="Suspended Client" runat="server"></asp:Label>
                                                                    <asp:TextBox ID="TextBox3" Style="background-color: Red; vertical-align: text-top"
                                                                        ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                    <asp:Label ID="Label10" Text="Terminate Client" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                    <fieldset>
                                                        <legend style="font-size: medium; font-weight: bold; font-style: normal">Ordered Investigations</legend>
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <div class="dataheader2">
                                                                        <%-- <asp:UpdatePanel ID="UpdPnl1" runat="server">
                                                                                    <ContentTemplate>--%>
                                                                        <asp:DataList ID="GrdInv" runat="server" GridLines="Horizontal" RepeatColumns="1"
                                                                            Width="100%" RepeatDirection="Vertical" OnItemDataBound="GrdInv_ItemDataBound">
                                                                            <HeaderTemplate>
                                                                                <table class="w-100p">
                                                                                    <tr>
                                                                                        <td>
                                                                                            &nbsp;
                                                                                        </td>
                                                                                        <td>
                                                                                            <b>INVESTIGATION NAME </b>
                                                                                        </td>
                                                                                        <td>
                                                                                            <b>STATUS </b>
                                                                                        </td>
                                                                                        <td>
                                                                                            &nbsp;
                                                                                        </td>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <td width="70%">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("ReferredType")%>'></asp:Label>
                                                                                </td>
                                                                                <td headers="Status">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "DisplayStatus")%>
                                                                                </td>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                </tr> </table>
                                                                            </FooterTemplate>
                                                                        </asp:DataList>
                                                                        <asp:HiddenField ID="hdnEdit" runat="server" />
                                                                        <%-- </ContentTemplate>
                                                                                </asp:UpdatePanel>--%>
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
                        </div>
                        <%--    </ContentTemplate>
                        </asp:UpdatePanel>--%>
                  
        <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
        <input id="Hidden1" type="hidden" value="0" runat="server" />
        <asp:HiddenField ID="hdnIsEditRePush" runat="server" />
		<asp:HiddenField ID="hdnIsEditDeFlag" runat="server" />
		
		<asp:HiddenField ID="hdnPatientEmailId" runat="server" />
		<asp:HiddenField ID="hdnReferringDoctor" runat="server" />
		<asp:HiddenField ID="hdnDOBMonth" runat="server" />
		<asp:HiddenField ID="hdnPhoneNo" runat="server" />
		<asp:HiddenField ID="hdnMobileNo" runat="server" />
		<asp:HiddenField ID="hdnPatientAddress" runat="server" Value="0" />
		<asp:HiddenField ID="hdnPatientAge" runat="server" />
        <asp:HiddenField ID="hdnPatientSex" runat="server" />
		<asp:HiddenField ID="hdnPatientName" runat="server" /> 
		
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" runat="server" />
        <input type="hidden" id="hdnPNO" name="pno" runat="server" />
        <input type="hidden" id="hdnVID" name="vid" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <input type="hidden" id="hdndrpdowndetail" runat="server" />
        <input type="hidden" id="visitState" runat="server" />
        <input type="hidden" id="isCredit" runat="server" />
        <input type="hidden" id="visittype" runat="server" />
        <input type="hidden" id="hdnspecdept" runat="server" />
        <input type="hidden" id="hdnPhysicianID" runat="server" value="0" />
        <input type="hidden" id="hdnHubID" runat="server" value="0" />
        <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
        <input type="hidden" id="hdnReferedPhyID" runat="server" />
        <input type="hidden" id="hdnReferedPhyName" runat="server" />
        <input type="hidden" id="hdnReferedPhysicianCode" runat="server" />
        <input type="hidden" id="hdnReferedPhyType" runat="server" />
         
        <input type="hidden" id="hdnSalutation" runat="server" />
        <input type="hidden" id="hdnSex" runat="server" />
        <input type="hidden" id="hdnDOBDWMY" runat="server" />
        <input type="hidden" id="hdntxtDOBNos" runat="server" />
        
        <asp:HiddenField ID="hdnApprovedByID" Value="0" runat="server" />
        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
        <asp:HiddenField ID="hdnTitleCode" runat="server" />
        <asp:HiddenField ID="hdnSearch" runat="server" />
        
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnlstpatientHistory" runat="server" />
        <div style="display: none" id="divGenerateVisit">
            <asp:Xml ID="XmlOP" runat="server"></asp:Xml>
        </div>
</div>
<Attune:Attunefooter ID="Attunefooter" runat="server" />
    <script type="text/javascript" language="javascript">
        //        function checkForValues() {

        //            if (document.getElementById('txtpageNo').value == "") {
        //                alert('Please Enter Page No');
        //                document.getElementById('txtpageNo').focus();
        //                return false;
        //            }

        //            if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) < Number(1)) {
        //                alert('Please Enter Correct Page No');
        //                document.getElementById('txtpageNo').value = "";
        //                document.getElementById('txtpageNo').focus();
        //                return false;
        //            }

        //            if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) > Number(document.getElementById('<%= lblTotal.ClientID %>').innerText)) {
        //                alert('Please Enter Correct Page No');
        //                document.getElementById('txtpageNo').value = "";
        //                document.getElementById('txtpageNo').focus();
        //                return false;
        //            }
        //        }
        function SelectedOver(source, eventArgs) {
            $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    alert('Please select from the list');
                    document.getElementById('txtClientName').value = '';

                }
            };
        }
        function SetClientID(source, eventArgs) {
            var ClientID = 0;
            if (eventArgs != undefined) {
                ClientID = eventArgs.get_value();
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID.split('|')[0];
            }
            else {
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID;
            }
        }
        function SelectedOverPhy(source, eventArgs) {
            $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
                $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
                if (result == "") {

                    alert('Please select from the list');
                    document.getElementById('txtInternalExternalPhysician').value = '';
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                }
            };
        }
        function SetPhysicianID(source, eventArgs) {
            if (eventArgs != undefined) {
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = eventArgs.get_value();
            }
            if (document.getElementById('txtInternalExternalPhysician').value == '') {
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0'
            }
            else if (document.getElementById('hdnPhysicianID') != null) {
                if (document.getElementById('<%=hdnPhysicianID.ClientID %>').value == '') {
                    alert('Please select from the list');
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                    document.getElementById('txtInternalExternalPhysician').value = '';
                }
            }
        }
        function CearetxtDate() {
            // document.getElementById('txtFrom').value = '';
            //document.getElementById('txtTo').value = '';

        }
    </script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">
        function IsRegistrationDeflag() {

            var OrgID = document.getElementById('hdnOrgID').value;

            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/RegistrationRepush",
                data: "{ OrgId: '" + OrgID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    if (data.d != [] && data.d.length > 0) {
                        var list = data.d;

                        for (i = 0; i < list.length; i++) {
                            if (document.getElementById(list[i].FieldId).value.trim() != document.getElementById(list[i].ControlId).value.trim()) {
                                if ((list[i].IsDeflag) == "Y") {
                                    document.getElementById('hdnIsEditDeFlag').value = 'Y';
                                    document.getElementById('hdnIsEditRePush').value = 'Y';
                                    break;
                                }
                            }
                        }
                    }
                    failure: function(msg) {
                        alert(msg);
                    }
                }
            });
        }
        function IsRegistrationRepush() {
            var OrgID = document.getElementById('hdnOrgID').value;

            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/RegistrationRepush",
                data: "{ OrgId: '" + OrgID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    if (data.d != [] && data.d.length > 0) {
                        var list = data.d;
                        for (i = 0; i < list.length; i++) {
                            if (document.getElementById(list[i].FieldId).value.trim() != document.getElementById(list[i].ControlId).value.trim()) {
                                if ((list[i].IsRepush) == "Y") {
                                    document.getElementById('hdnIsEditRePush').value = 'Y';
                                    break;
                                }
                            }
                        }
                    }

                },
                failure: function(msg) {
                    alert(msg);
                }
            });
        }
        function CheckEditData() {
//              debugger;
            var btnText = $('#btnEdit').val();
            //            var btnverify = $('#btnVerify').val();
            //if (document.getElementById('btnEdit').value == "Edit") {
            if (btnText == 'Edit') {
                document.getElementById('tdNameReadmode').style.display = 'none';
                document.getElementById('tdAgeReadmode').style.display = 'none';
                document.getElementById('tdDOBReadmode').style.display = 'none';
                document.getElementById('tdGenderReadmode').style.display = 'none';
                document.getElementById('tdMobileReadmode').style.display = 'none';
                document.getElementById('tdEmailReadmode').style.display = 'none';
                document.getElementById('tdRefDrReadmode').style.display = 'none';
                document.getElementById('tdLandlineReadmode').style.display = 'none';
                document.getElementById('tdNameEditmode').style.display = 'block';
                document.getElementById('tdAgeEditmode').style.display = 'block';
                document.getElementById('tdDOBEditmode').style.display = 'block';
                document.getElementById('tdGederEditmode').style.display = 'block';
                document.getElementById('tdMobileEditmode').style.display = 'block';
                document.getElementById('tdEmailEditmode').style.display = 'block';
                document.getElementById('tdRefDrEditmode').style.display = 'block';
                document.getElementById('tdLandlineEditmode').style.display = 'block';


                if ($('#Bckgrd tr').length > 1) {
                    $('#Bckgrd tr:not(:first)').each(function(i, n) {
                        $row = $(n);
                        $('[id$="lblHistory"]').hide();
                        $('[id$="txtHistory"]').show();
                        $('[id$="lblRemarks"]').hide();
                        $('[id$="txtRemarks"]').show();
                        //                        $('[id$="txtID"]').hide();
                    });

                }

                document.getElementById('btnEdit').value = 'Update and Verify';
                document.getElementById('hdnEdit').value = 'Update and Verify';
                document.getElementById('btnVerify').value = 'Cancel';

                document.getElementById('hdnPatientEmailId').value = document.getElementById('txtEmail').value;
                document.getElementById('hdnReferringDoctor').value = document.getElementById('txtInternalExternalPhysician').value;
                document.getElementById('hdnDOBMonth').value = document.getElementById('tDOB').value;
                document.getElementById('hdnPhoneNo').value = document.getElementById('txtPhone').value;
                document.getElementById('hdnMobileNo').value = document.getElementById('txtMobileNumber').value;
                document.getElementById('hdnPatientAddress').value = document.getElementById('txtAddress').value;
                document.getElementById('hdnPatientName').value = document.getElementById('txtName').value;
                document.getElementById('hdnPatientAge').value = document.getElementById('txtDOBNos').value;
                document.getElementById('hdnPatientSex').value = document.getElementById('ddlSex').value;
                return false;
            }

            if (btnText == 'Update and Verify') {
                var PatientName;
                var Age;
                var Dob;
                var Mobile;
                var Sex;
                if ($('#txtName').val() != null) {
                    PatientName = $('#txtName').val();
                }
                if ($('#txtDOBNos').val() != null) {
                    Age = $('#txtDOBNos').val();
                }
                if ($('#tDOB').val() != null) {
                    Dob = $('#tDOB').val();
                }
                if ($('#txtMobileNumber').val() != null) {
                    Mobile = $('#txtMobileNumber').val();
                }
                if (PatientName == '') {
                    alert('Patient name can not be empty');
                    $('#txtName').focus();
                    return false;
                }
                if (Age == '') {
                    alert('Age can not be empty');
                    $('#txtDOBNos').focus();
                    return false;
                }
                if (Dob == '') {
                    alert('Date of birth can not be empty');
                    $('#tDOB').focus();
                    return false;
                }
                if (document.getElementById('lblMobile').innerText!= '') {
                    if (Mobile == '') {
                        alert('Mobile number can not be empty');
                        $('#txtMobile').focus();
                        return false;
                    }
                }
                var lstpatientHistory = [];
                if ($('#Bckgrd tr').length > 1) {
                    $('#Bckgrd tr:not(:first)').each(function(i, n) {
                        $row = $(n);
                        lstpatientHistory.push({
                            HistoryExtID: $('[id$="txtID"]').val(),
                            Remarks: $('[id$="txtRemarks"]').val(),
                            DetailHistory: $('[id$="txtHistory"]').val()
                        });
                    });
                }

                if (lstpatientHistory.length > 0) {
                    $('#hdnlstpatientHistory').val(JSON.stringify(lstpatientHistory));
                }
              
                
                if (((document.getElementById('txtDOBNos').value.trim()) != (document.getElementById('hdnPatientAge').value.trim())) ||
                (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value != document.getElementById('hdnPatientSex').value) ||
                (document.getElementById('tDOB').value.trim() != document.getElementById('hdnDOBMonth').value)) {
                    var ans = window.confirm('There is a change in Age / Gender, Any Result entry completed reports for this Visit need to be re-validated');
                    if (ans == true) {
                        IsRegistrationDeflag()
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    IsRegistrationRepush()
                }
                                  
              
            }
        }

        function checkCancel() {
            //            debugger;
            var btnverify = $('#btnVerify').val();
            if (btnverify == 'Cancel') {
                document.getElementById('tdNameReadmode').style.display = 'block';
                document.getElementById('tdAgeReadmode').style.display = 'block';
                document.getElementById('tdDOBReadmode').style.display = 'block';
                document.getElementById('tdGenderReadmode').style.display = 'block';
                document.getElementById('tdMobileReadmode').style.display = 'block';
                document.getElementById('tdEmailReadmode').style.display = 'block';
                document.getElementById('tdRefDrReadmode').style.display = 'block';
                document.getElementById('tdLandlineReadmode').style.display = 'block';
                document.getElementById('tdNameEditmode').style.display = 'none';
                document.getElementById('tdAgeEditmode').style.display = 'none';
                document.getElementById('tdDOBEditmode').style.display = 'none';
                document.getElementById('tdGederEditmode').style.display = 'none';
                document.getElementById('tdMobileEditmode').style.display = 'none';
                document.getElementById('tdEmailEditmode').style.display = 'none';
                document.getElementById('tdRefDrEditmode').style.display = 'none';
                document.getElementById('tdLandlineEditmode').style.display = 'none';



                document.getElementById('ddSalutation').value = document.getElementById('hdnSalutation').value;
                document.getElementById('txtName').value = document.getElementById('lblPatientName').innerHTML;
                document.getElementById('txtDOBNos').value = document.getElementById('hdntxtDOBNos').value;
                document.getElementById('ddlDOBDWMY').value = document.getElementById('hdnDOBDWMY').value;
                document.getElementById('tDOB').value = document.getElementById('lblDOB').innerHTML;
                document.getElementById('ddlSex').value = document.getElementById('hdnSex').value;
                document.getElementById('txtInternalExternalPhysician').value = document.getElementById('lblRefDr').innerHTML; 
                document.getElementById('txtMobileNumber').value = document.getElementById('lblMobile').innerHTML;
                document.getElementById('txtPhone').value = document.getElementById('lblLandline').innerHTML;
                document.getElementById('txtEmail').value = document.getElementById('lblEmailID').innerHTML;
                
                
                
                

                if ($('#Bckgrd tr').length > 1) {
                    $('#Bckgrd tr:not(:first)').each(function(i, n) {
                        $row = $(n);
                        $('[id$="lblHistory"]').show();
                        $('[id$="txtHistory"]').hide();
                        $('[id$="lblRemarks"]').show();
                        $('[id$="txtRemarks"]').hide();



                        $('[id$="txtHistory"]').val($('[id$="lblHistory"]')[0].innerHTML);

                        $('[id$="txtRemarks"]').val($('[id$="lblRemarks"]')[0].innerHTML);


                        //                            $('[id$="txtID"]').hide();
                    });

                }

                document.getElementById('btnEdit').value = 'Edit';
                document.getElementById('hdnEdit').value = 'Edit';
                document.getElementById('btnVerify').value = 'Verify';

                return false;

            }



        }
        
        
    </script>

    <script type="text/javascript" language="javascript">
        function onChangeFile(objID) {
            //             debugger;
            var orgId = $("[id$='hdnOrgID']").val();
            try {
                var index = objID.lastIndexOf("_");
                $('#trPicPatient').hide();
                $('#trPDF').hide();
                $('#imgPatient').attr('src', '<%=ResolveUrl("~/Images/noTRF.png")%>');
                $('#ifPDF').html('');
                selectedOption = $('#' + objID + ' option:selected');
                if ($(selectedOption).val() != 0) {
                    if ($(selectedOption).val().indexOf('.pdf') != -1) {
                        $('#trPicPatient').hide();
                        $('#trPDF').show();
                        $('#ifPDF').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption).val() + '&OrgID=' + orgId + '")%>');
                    }
                    else {
                        $('#trPicPatient').show();
                        $('#trPDF').hide();
                        $('#imgPatient').attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=' + $(selectedOption).val() + '&OrgID=' + orgId + '")%>');
                    }
                }
                return false;
            }
            catch (e) {
                return false;
            }
        }
 
    </script>

    </form>
</body>
</html>


