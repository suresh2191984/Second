<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientVisit.aspx.cs" Inherits="Reception_PatientVisit"
    EnableEventValidation="false" EnableViewStateMac="false" meta:resourcekey="PageResource2" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ProcedureName.ascx" TagName="procedure" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/ConsultingName.ascx" TagName="consulting" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReferDoctor.ascx" TagName="ReferDoctor" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PrintPatientRegistration.ascx" TagName="PrintPatRegistration"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ReferedPhysician.ascx" TagName="ReferedPhysician"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/PatientVisitSummary.ascx" TagName="VisitSummary"
    TagPrefix="uc11" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="IPClientTpaInsurance"
    TagPrefix="uc12" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Visit</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .NoneDisplay
        {
            display: none;
        }
    </style>
</head>
<body onload="onComboFocus('dPurpose');" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="bsave">

    <script type="text/javascript">
    
 function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else
            {
            alert('This action cannot be performed for inpatients');
            return false ;
            }
         
           return true;
        }

        function CheckLocation(bid) {

            if (document.getElementById('hdnPID').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else { alert('Select visit detail'); }
                $get(bid).disabled = false;
                return false;
            }
            if (document.getElementById('<%=dPurpose.ClientID%>').options[document.getElementById('<%=dPurpose.ClientID%>').selectedIndex].value == '-----Select-----') {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Select visit purpose ');
                }
                $get(bid).disabled = false;
                document.getElementById('<%=dPurpose.ClientID%>').focus();
                return false;
            }
            // Cousulting
            if (document.getElementById('<%=dPurpose.ClientID%>').options[document.getElementById('<%=dPurpose.ClientID%>').selectedIndex].text == 'Consultation') {
                if (document.getElementById('usrConsulting_ddlSpeciality').options[document.getElementById('usrConsulting_ddlSpeciality').selectedIndex].text == '-----Select-----') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_3');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert('Select speciality name ');
                    }
                    document.getElementById('usrConsulting_ddlSpeciality').focus();
                    $get(bid).disabled = false;
                    return false;
                }
            }
            // Treatment Procedure
            if (document.getElementById('<%=dPurpose.ClientID%>').options[document.getElementById('<%=dPurpose.ClientID%>').selectedIndex].text == 'Treatment Procedure') {
                if (document.getElementById('usrProcedure_ddlProcedureName').options[document.getElementById('usrProcedure_ddlProcedureName').selectedIndex].text == '---------Select--------') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_4');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert('Select treatment procedure name ');
                    }
                    document.getElementById('usrProcedure_ddlProcedureName').focus();
                    $get(bid).disabled = false;
                    return false;
                }
            }
            if (document.getElementById('<%=ddlLocatiopn.ClientID%>').options[document.getElementById('<%=ddlLocatiopn.ClientID%>').selectedIndex].value == '------Select------') {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_5');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Select location');
                }
                document.getElementById('<%=ddlLocatiopn.ClientID%>').focus();
                $get(bid).disabled = false;
                return false;
            }
            if (document.getElementById('trBirthWeeks').style.display == 'block') {
                if (document.getElementById('txtBirthWeeks').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_6');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert('Provide child age');
                    }
                    document.getElementById('txtBirthWeeks').focus();
                    $get(bid).disabled = false;
                    return false;
                }
                return true;
            }
            //            if (document.getElementById('<%=dPurpose.ClientID%>').options[document.getElementById('<%=dPurpose.ClientID%>').selectedIndex].text == 'Consultation' && document.getElementById('usrConsulting_ddlSpeciality').options[document.getElementById('usrConsulting_ddlSpeciality').selectedIndex].text == 'ENT' && document.getElementById('hdnSex').value=='M') {
            //                alert('This Task Cannot  Be Performed For Male Patient');
            //                return false;
            //            }
            if (document.getElementById('<%=dPurpose.ClientID%>').options[document.getElementById('<%=dPurpose.ClientID%>').selectedIndex].text == 'Consultation' && document.getElementById('usrConsulting_ddlSpeciality').options[document.getElementById('usrConsulting_ddlSpeciality').selectedIndex].text == 'Gynaecology' && document.getElementById('hdnSex').value == 'M') {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('This task cannot  be performed for male patient');
                }
                $get(bid).disabled = false;
                return false;
            }
            if (document.getElementById('<%=dPurpose.ClientID%>').options[document.getElementById('<%=dPurpose.ClientID%>').selectedIndex].text == 'Consultation' && document.getElementById('usrConsulting_ddlSpeciality').options[document.getElementById('usrConsulting_ddlSpeciality').selectedIndex].text == 'ANC' && document.getElementById('hdnSex').value == 'M') {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientVisit.aspx_8');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('This task cannot  be performed for male patient');
                }
                $get(bid).disabled = false;
                return false;
            }
            $get(bid).disabled = true;
            javascript: __doPostBack(bid, '');

        }
        function SelectVisit(id, pid) {

            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(id).checked = true;
            document.getElementById('hdnPID').value = pid;

        }


        function OnSelectedIndexChange() {
            var ddlselectText = document.getElementById('<%=dPurpose.ClientID %>').options[document.getElementById('<%=dPurpose.ClientID %>').selectedIndex].text;

            if (ddlselectText == 'Consultation') {
                document.getElementById('divRefering').style.display = 'block';
                document.getElementById('divConsulting').style.display = 'block';
                document.getElementById('SecPageCheck').style.display = 'block';
                document.getElementById('divProcedure').style.display = 'none';
                document.getElementById('divRefer').style.display = 'none';
                document.getElementById('divClients').style.display = 'block';
                document.getElementById('trCorporateClientBlock').style.display = 'block';
                document.getElementById('trBirthWeeks').style.display = 'none';
                document.getElementById('trPriority').style.display = 'none';
                //document.getElementById('HealthPKG').style.display = 'none';
                return true;
            }
            else if (ddlselectText == 'Treatment Procedure') {
                document.getElementById('divProcedure').style.display = 'block';
                document.getElementById('divRefering').style.display = 'block';
                document.getElementById('divConsulting').style.display = 'none';
                document.getElementById('SecPageCheck').style.display = 'none';

                document.getElementById('divRefer').style.display = 'none';
                document.getElementById('divClients').style.display = 'block';
                document.getElementById('trCorporateClientBlock').style.display = 'block';
                document.getElementById('trBirthWeeks').style.display = 'none';
                document.getElementById('trPriority').style.display = 'none';
                //document.getElementById('HealthPKG').style.display = 'none';
                return true;
            }
            else if (ddlselectText == 'Lab Investigation') {
                document.getElementById('divRefer').style.display = 'block';
                document.getElementById('divRefering').style.display = 'block';
                document.getElementById('divProcedure').style.display = 'none';
                document.getElementById('divConsulting').style.display = 'none';
                document.getElementById('SecPageCheck').style.display = 'none';
                document.getElementById('divClients').style.display = 'block';
                document.getElementById('trCorporateClientBlock').style.display = 'block';
                document.getElementById('trBirthWeeks').style.display = 'none';
                document.getElementById('trPriority').style.display = 'block';
                //document.getElementById('HealthPKG').style.display = 'none';
                return true;
            }
            else if (ddlselectText == 'Admission') {
                document.getElementById('divRefer').style.display = 'none';
                document.getElementById('divRefering').style.display = 'block';
                document.getElementById('divProcedure').style.display = 'none';
                document.getElementById('divConsulting').style.display = 'none';
                document.getElementById('SecPageCheck').style.display = 'none';
                document.getElementById('divClients').style.display = 'none';
                document.getElementById('trCorporateClientBlock').style.display = 'none';
                document.getElementById('trBirthWeeks').style.display = 'none';
                document.getElementById('trPriority').style.display = 'none';
                //document.getElementById('HealthPKG').style.display = 'none';
                return true;
            }
            else if (ddlselectText == 'Immunization') {
                document.getElementById('divRefer').style.display = 'none';

                document.getElementById('divProcedure').style.display = 'none';
                document.getElementById('divRefering').style.display = 'block';
                document.getElementById('divConsulting').style.display = 'none';
                document.getElementById('SecPageCheck').style.display = 'none';
                document.getElementById('divClients').style.display = 'none';
                document.getElementById('trCorporateClientBlock').style.display = 'none';
                document.getElementById('trBirthWeeks').style.display = 'block';
                document.getElementById('trPriority').style.display = 'none';
                //document.getElementById('HealthPKG').style.display = 'none';
                return true;
            }
            //            else if (ddlselectText == 'Health Package') {
            //            document.getElementById('divRefer').style.display = 'none';
            //            document.getElementById('HealthPKG').style.display = 'block';
            //                
            //                document.getElementById('divProcedure').style.display = 'none';
            //                document.getElementById('divConsulting').style.display = 'none';
            //                document.getElementById('SecPageCheck').style.display = 'none';
            //                document.getElementById('divClients').style.display = 'none';
            //                document.getElementById('trCorporateClientBlock').style.display = 'none';
            //                document.getElementById('trBirthWeeks').style.display = 'none';
            //                document.getElementById('trPriority').style.display = 'none';
            //                return true;
            //            }
            else {
                document.getElementById('divProcedure').style.display = 'none';
                document.getElementById('divConsulting').style.display = 'none';
                document.getElementById('divRefer').style.display = 'none';
                document.getElementById('SecPageCheck').style.display = 'none';
                document.getElementById('divClients').style.display = 'none';
                document.getElementById('trCorporateClientBlock').style.display = 'none';
                document.getElementById('trBirthWeeks').style.display = 'none';
                document.getElementById('trPriority').style.display = 'none';
                //document.getElementById('HealthPKG').style.display = 'none';
                return true;
            }
            return false;
        }

        function PopupSecPage(pVid, patId) {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
            strFeatures = strFeatures + ",left=0,top=0";
            var strURL = "../Reception/PrintPage.aspx?vid= + '" + pVid + "'&pagetype=SPP&pid= + '" + patId + "'";
            window.open(strURL, "", strFeatures, true);
            return false;

        }

        function clientdata(id) {
            var hdn = document.getElementById('hdnclient').value;
            var list = hdn.split('^');
            for (var i = 0; i < list.length; i++) {
                var value = list[i].split('~');
                if (id == value[0]) {

                    document.getElementById('ddlRate').value = value[1];
                }
            }

        }

        function TokenGenerated(tokenNo, ScheduleID, ResourceTemplateID, startTime, EndTime) {

            document.getElementById('<%= hdnTokenNo.ClientID %>').value = tokenNo;
            document.getElementById('<%= hdnScheduleID.ClientID %>').value = ScheduleID;
            document.getElementById('<%= hdnResourceTemplateID.ClientID %>').value = ResourceTemplateID;
            document.getElementById('<%= hdnStartTime.ClientID %>').value = startTime;
            document.getElementById('<%= hdnEndTime.ClientID %>').value = EndTime;
        }

        function SelectAllActive(IDvals) {
            var objddown = document.getElementById(IDvals);
            var dropdownVal = objddown.value;
            ChangeSelection(IDvals);
            chkSource(dropdownVal);
        }

        function chkSource(value) {
            var invisibleSlots = document.getElementById('<%= ddlInvisibleSlots.ClientID %>');
            var drpSlots = document.getElementById('<%= ddlSlots.ClientID %>');
            var labelSchedules = document.getElementById('<%= lblScheduleDisp.ClientID %>');
            var divVisitSlots = document.getElementById('dvVisitSlots');
            var divVisitSlots1 = document.getElementById('dvVisitSlots1');
            var divVisitSlots2 = document.getElementById('dvVisitSlots2');
            var divVisitSlots3 = document.getElementById('dvVisitSlots3');
            var divTable = document.getElementById('divScheduletbl');

            var objSlotCount = document.getElementById('<%= hdnSlotCount.ClientID %>');

            var intVisibleCount = 0;
            intVisibleCount = invisibleSlots.length;
            var i = 0;

            drpSlots.options.length = 0;

            var optn = document.createElement("option");
            drpSlots.options.add(optn);
            optn.text = "--Select--";
            optn.value = "0";

            for (i = 1; i < invisibleSlots.length; i++) {
                var SelVAl = invisibleSlots.options[i].value;
                if (SelVAl.split('~')[1] == value) {
                    var opt = document.createElement("option");
                    drpSlots.options.add(opt);
                    opt.text = invisibleSlots.options[i].text;
                    opt.value = SelVAl;
                }
            }

            if (drpSlots.options.length <= 1) {
                drpSlots.style.display = 'none';
                labelSchedules.style.display = 'none';
                divVisitSlots.style.display = 'none';
                divVisitSlots1.style.display = 'none';
                divVisitSlots2.style.display = 'none';
                divVisitSlots3.style.display = 'none';
                divTable.style.display = 'none';
            }
            else {
                drpSlots.style.display = 'block';
                labelSchedules.style.display = 'block';
                divVisitSlots.style.display = 'block';
                divVisitSlots1.style.display = 'block';
                divVisitSlots2.style.display = 'block';
                divVisitSlots3.style.display = 'block';
                divTable.style.display = 'block';
            }

            if (objSlotCount.value == 1) {
                drpSlots.selectedIndex = 1;
                drpSlots.disabled = true;

                MakeVisibility(drpSlots.id);
            }
        }

        function ChangeSelection(IDvals) {
            var objddown = document.getElementById(IDvals);
            var dropdownVal = objddown.value;
            if (dropdownVal != "-----Select-----") {
                document.getElementById('dvVisitSlots').style.display = 'block';
            }
            else {
                document.getElementById('dvVisitSlots').style.display = 'none';
            }
        }

        function MakeVisibility(IDvals) {

            //get reference of GridView control
            var grid = document.getElementById('<%= gvToken.ClientID %>');
            var availableGrid = document.getElementById('<%= gvAvailableSlots.ClientID %>');
            if (grid != null) {
                grid.style.display = 'block';
            }
            if (availableGrid != null) {
                availableGrid.style.display = 'block';
            }

            var objddown = document.getElementById(IDvals);

            var dropdownVal = objddown.value;
            var schID = document.getElementById('<%= hdnScheduleID.ClientID %>');

            schID.value = dropdownVal.split('~')[0];

            var cell;
            var cell1;
            var cellAvailableToken;
            var cellBookedToken;
            var CelltokenVisited;


            if (grid != null) {
                if (grid.rows.length > 0) {
                    for (i = 1; i < grid.rows.length; i++) {
                        cell = grid.rows[i].cells[6];
                        CelltokenVisited = grid.rows[i].cells[7];

                        if ((cell.innerHTML == dropdownVal.split('~')[0]) && (CelltokenVisited.innerHTML == "B")) {
                            grid.rows[i].style.display = "block";
                        }
                        else {
                            grid.rows[i].style.display = "none";
                        }
                    }
                }
            }
            if (availableGrid != null) {
                if (availableGrid.rows.length > 0) {

                    for (i = 1; i < availableGrid.rows.length; i++) {
                        cell = availableGrid.rows[i].cells[6];

                        if (cell.innerHTML == dropdownVal.split('~')[0]) {
                            availableGrid.rows[i].style.display = "block";
                        }
                        else {
                            availableGrid.rows[i].style.display = "none";
                        }
                    }
                }
            }
            if ((grid != null) && (availableGrid != null)) {
                if (grid.rows.length > 0) {
                    if (availableGrid.rows.length > 0) {

                        for (i = 1; i < grid.rows.length; i++) {
                            cell1 = grid.rows[i].cells[6]; //ScheduleID
                            cellBookedToken = grid.rows[i].cells[1]; //TokenNumber
                            for (j = 1; j < availableGrid.rows.length; j++) {
                                cell = availableGrid.rows[j].cells[6]; //ScheduleID
                                cellAvailableToken = availableGrid.rows[j].cells[1]; //TokenNumber
                                if ((cell.innerHTML == cell1.innerHTML) && (cellAvailableToken.innerHTML == cellBookedToken.innerHTML)) {
                                    availableGrid.rows[j].style.display = "none";
                                }
                            }
                        }
                    }
                }
            }
        }

        function ChangeSPP() {
            if (document.getElementById('<%=dPurpose.ClientID%>').options[document.getElementById('<%=dPurpose.ClientID%>').selectedIndex].text == 'Consultation') {
                document.getElementById('SecPageCheck').style.display = 'block';
            }
            else {
                document.getElementById('SecPageCheck').style.display = 'none';
            }
        }

        function SelectCVisit(id, pid) {

            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(id).checked = true;
            document.getElementById('hdnPID').value = pid;
            //alert('Final');
        }
        function checkForOthers(id) {
            var grdID = id.split('_');
            var txtID = "gvKOS_" + grdID[1] + "_" + "txtOthers";
            var ddlCTxt = document.getElementById(id).options[document.getElementById(id).selectedIndex].text;
            if (ddlCTxt == "Other") {
                document.getElementById(txtID).style.display = 'block';
            }
            else {
                document.getElementById(txtID).style.display = 'none';
                document.getElementById(txtID).value = "";
            }
        }
        //        function popupprint() {
        //            var prtContent = document.getElementById('printPatientReg');
        //            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        //            //alert(WinPrint);
        //            WinPrint.document.write(prtContent.innerHTML);
        //            WinPrint.document.close();
        //            WinPrint.focus();
        //            WinPrint.print();
        //            WinPrint.close();
        //        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td height="32">
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="2" nowrap="nowrap" width="55%">
                                                <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap" width="45%">
                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait.... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div id="dicRef" runat="server" visible="false">
                                                    <asp:Label ID="Rs_Referral" Text="Referral" Font-Bold="True" runat="server" meta:resourcekey="Rs_ReferralResource1" />
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="grdResult" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                                ForeColor="#333333" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1"
                                                                CssClass="mytable1" DataKeyNames="PatientID" PagerSettings-Mode="NextPrevious">
                                                                <PagerTemplate>
                                                                    <tr>
                                                                        <td align="center" colspan="6">
                                                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" meta:resourcekey="lnkPrevResource1"
                                                                                Width="18px" />
                                                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" meta:resourcekey="lnkNextResource1"
                                                                                Width="18px" />
                                                                        </td>
                                                                    </tr>
                                                                </PagerTemplate>
                                                                <HeaderStyle CssClass="dataheader1" />
                                                                <PagerSettings Mode="NextPrevious" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource2" />
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:RadioButton ID="rdSel" runat="server" GroupName="PatientSelect" meta:resourcekey="rdSelResource1"
                                                                                ToolTip="Select Row" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-HorizontalAlign="Left"
                                                                        ItemStyle-Width="25%" meta:resourcekey="BoundFieldResource3">
                                                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" ItemStyle-HorizontalAlign="Left"
                                                                        ItemStyle-Width="10%" meta:resourcekey="BoundFieldResource4">
                                                                        <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Age" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1" Text='<%# Bind("Age") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="RelationName" HeaderText="Spouse/Father" ItemStyle-Width="18%"
                                                                        meta:resourcekey="BoundFieldResource5">
                                                                        <ItemStyle Width="18%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="MobileNumber" HeaderText="Phone Numbers" ItemStyle-Width="17%"
                                                                        meta:resourcekey="BoundFieldResource6">
                                                                        <ItemStyle Width="17%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Address" HeaderText="Address" ItemStyle-Width="25%" meta:resourcekey="BoundFieldResource7">
                                                                        <ItemStyle Width="25%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="CompressedName" HeaderText="Compressed Name" ItemStyle-Width="25%"
                                                                        meta:resourcekey="BoundFieldResource8" Visible="false">
                                                                        <ItemStyle Width="25%" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:GridView ID="gvInvestigations" Width="100%" runat="server" AllowPaging="True"
                                                                CellPadding="4" AutoGenerateColumns="False" ForeColor="#333333" OnPageIndexChanging="gvInvestigations_PageIndexChanging"
                                                                OnRowDataBound="gvInvestigations_RowDataBound" EmptyDataText="No Record Found"
                                                                PageSize="15" meta:resourcekey="gvInvestigationsResource1">
                                                                <HeaderStyle CssClass="Duecolor" />
                                                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Left" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="select" meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:RadioButton GroupName="Sele" AutoPostBack="True" OnCheckedChanged="rdoSelect_CheckedChanged"
                                                                                ID="rdoSelect" runat="server" meta:resourcekey="rdoSelectResource1" />
                                                                            <asp:HiddenField ID="hdnReferralID" runat="server" Value='<%# Bind("ReferralID") %>'>
                                                                            </asp:HiddenField>
                                                                            <asp:HiddenField ID="hdnReferralDetailsID" runat="server" Value='<%# Bind("ReferralDetailsID") %>'>
                                                                            </asp:HiddenField>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("ReferralNotes") %>'
                                                                                meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField HeaderText="Notes" DataField="ReferralStatus" meta:resourcekey="BoundFieldResource1" />
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="dataheaderInvCtrl">
                                                <uc11:VisitSummary ID="ucVisitSummary" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="dataheaderInvCtrl">
                                                <div id="divRefering">
                                                    <uc10:ReferedPhysician ID="Rfrdoctor" runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="left">
                                                <br />
                                                <div id="SecPageCheck" class="dataheaderInvCtrl" runat="server" style="width: 100%;
                                                    height: 20px; padding: 3px; padding-right: 0px;">
                                                    <asp:CheckBox ID="chkSecPage" Text="Print Secured Prescription Page" runat="server"
                                                        meta:resourcekey="chkSecPageResource1" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: bold; width: 15%;">
                                                            <asp:Label ID="Rs_VisitPurpose" Text="Visit Purpose" runat="server" meta:resourcekey="Rs_VisitPurposeResource1" />
                                                            :
                                                        </td>
                                                        <td style="width: 20%;">
                                                            <asp:UpdatePanel ID="pnlPurpose" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="dPurpose" ToolTip="Click here to select Visit Purpose" CssClass="ddlsmall"
                                                                        runat="server" onchange="javascript:ChangeSPP();" AutoPostBack="True" meta:resourcekey="dPurposeResource1">
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </td>
                                                        <td style="width: 65%;">
                                                            <table border="0" cellpadding="2" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <div id="divProcedure" style="display: none">
                                                                            <uc2:procedure ID="usrProcedure" runat="server" />
                                                                        </div>
                                                                        <div id="divRefer" style="display: none">
                                                                            <uc8:ReferDoctor ID="ReferDoctor1" runat="server" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div id="divConsulting" style="display: none">
                                                                            <uc7:consulting ID="usrConsulting" runat="server" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:DropDownList ID="dDoc" runat="server" Visible="False" CssClass="ddlsmall" meta:resourcekey="dDocResource1">
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="dCond" Visible="False" runat="server" CssClass="ddlsmall" meta:resourcekey="dCondResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trBirthWeeks" style="display: none">
                                            <td colspan="3">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="width: 14%;">
                                                            <asp:Label ID="lblBirthWeeks" runat="server" Text="Age:" meta:resourcekey="lblBirthWeeksResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtBirthWeeks" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtBirthWeeksResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trPriority" style="display: none">
                                            <td colspan="3">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="width: 14%;">
                                                            <asp:Label ID="lblPriority" runat="server" Text="Priority:" meta:resourcekey="lblPriorityResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlPriority" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlPriorityResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trCorporateClientBlock" style="display: none;">
                                            <td colspan="3" width="50%" align="left">
                                                <div class="colorforcontent" style="display: block; height: 15px; padding: 3px; padding-right: 0px;
                                                    padding-left: 0px; width: 50%;" id="ACX2plusMVitals">
                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                        style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);" />
                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);">
                                                        <asp:Label ID="Rs_SelectClientCorporate" Text="Select Client / Corporate" Font-Bold="True"
                                                            runat="server" meta:resourcekey="Rs_SelectClientCorporateResource1" /></span>
                                                </div>
                                                <div class="colorforcontent" style="display: none; height: 15px; padding: 3px; padding-left: 0px;
                                                    padding-right: 0px; width: 50%;" id="ACX2minusMVitals">
                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                        style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);" />
                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);">
                                                        <asp:Label ID="Rs1_SelectClientCorporate" Text="Select Client / Corporate" Font-Bold="True"
                                                            runat="server" meta:resourcekey="Rs1_SelectClientCorporateResource1" /></span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="ACX2responsesMVitals" style="display: none;" class="tablerow">
                                            <td colspan="3" style="padding: 0px;">
                                                <div id="divClients" style="display: block;">
                                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="50%">
                                                        <tr>
                                                            <td>
                                                                <uc12:IPClientTpaInsurance ID="IPClientTpaInsurance1" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <%-- <tr>
                                       <td colspan="3" style="width: 50%; padding: 0px;">
                                                <asp:Panel ID="pnlTVE" runat="server" ScrollBars="None">
                                                    <asp:TreeView ID="TVE" runat="server" CollapseImageUrl="~/Images/Exam_G.png" EnableViewState="true"
                                                        ExpandImageUrl="~/Images/Exam_R.png" ParentNodeStyle-CssClass="details_value"
                                                        RootNodeStyle-CssClass="details_value4">
                                                        <Nodes>
                                                            <asp:TreeNode SelectAction="None" Selected="false" Text="" Value="0"></asp:TreeNode>
                                                        </Nodes>
                                                    </asp:TreeView>
                                                </asp:Panel>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td colspan="3" style="width: 50%; padding: 0px;">
                                                <%-- <asp:Table ID="masterTab" CssClass="dataheaderInvCtrl" runat="server" CellPadding="2"
                                                    CellSpacing="0" BorderWidth="1">
                                                </asp:Table>--%>
                                                <asp:GridView ID="gvKOS" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvKOS_RowDataBound"
                                                    meta:resourcekey="gvKOSResource1">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chk" runat="server" meta:resourcekey="chkResource1" />
                                                                <asp:Label ID="lblKOSID" runat="server" Text='<%# Bind("KnowledgeOfServiceID") %>'
                                                                    Visible="False" meta:resourcekey="lblKOSIDResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblKOS" runat="server" Text='<%# Bind("KnowledgeOfServiceName") %>'
                                                                    meta:resourcekey="lblKOSResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlAttributes" runat="server" onchange="javascript:checkForOthers(this.id);"
                                                                    meta:resourcekey="ddlAttributesResource1">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource8">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtOthers" runat="server" meta:resourcekey="txtOthersResource1"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td>
                                                <asp:Label ID="Rs_Location" Text="Location" runat="server" meta:resourcekey="Rs_LocationResource1" />
                                                :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlLocatiopn" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlLocatiopnResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td>
                                                <asp:Label ID="Rs_AccompaniedBy" Text="Accompanied By" runat="server" meta:resourcekey="Rs_AccompaniedByResource1" />
                                                :
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tAccBy" runat="server" CssClass="Txtboxsmall" meta:resourcekey="tAccByResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div class="dataheader2" id="divScheduletbl" style="display: none;">
                                                    <table width="100%">
                                                        <tr>
                                                            <td nowrap="nowrap" width="50%" align="right">
                                                                <div id="dvVisitSlots2" style="display: none;">
                                                                    <asp:Label ID="lblScheduleDisp" runat="server" Text="Schedule :" meta:resourcekey="lblScheduleDispResource1"></asp:Label></div>
                                                            </td>
                                                            <td width="50%" align="left">
                                                                <div id="dvVisitSlots3" style="display: none;">
                                                                    <asp:DropDownList ID="ddlSlots" runat="server" onChange="MakeVisibility(this.id);"
                                                                        meta:resourcekey="ddlSlotsResource1">
                                                                    </asp:DropDownList>
                                                                    <asp:DropDownList ID="ddlInvisibleSlots" runat="server" Style="display: none;" meta:resourcekey="ddlInvisibleSlotsResource1">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td nowrap="nowrap" width="50%" valign="top">
                                                                <div id="dvVisitSlots" style="display: none;">
                                                                    <asp:Panel ID="pnlVisitSlots" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlVisitSlotsResource1">
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td class="colorforcontent" height="23" align="left">
                                                                                    <div id="ACX2VisitSlots" style="display: none;">
                                                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                            style="cursor: pointer" onclick="showResponses('ACX2VisitSlots','ACX2minusVisitSlots','ACX2responsesVisitSlots',1);" />
                                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2VisitSlots','ACX2minusVisitSlots','ACX2responsesVisitSlots',1);">
                                                                                            &nbsp;
                                                                                            <asp:Label ID="Rs_BookedSlots" Text="Booked Slots" runat="server" meta:resourcekey="Rs_BookedSlotsResource1" /></span>
                                                                                    </div>
                                                                                    <div id="ACX2minusVisitSlots" style="display: block;">
                                                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                            style="cursor: pointer" onclick="showResponses('ACX2VisitSlots','ACX2minusVisitSlots','ACX2responsesVisitSlots',0);" />
                                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2VisitSlots','ACX2minusVisitSlots','ACX2responsesVisitSlots',0);">
                                                                                            &nbsp;<asp:Label ID="Rs1_BookedSlots" Text="Booked Slots" runat="server" meta:resourcekey="Rs1_BookedSlotsResource1" />
                                                                                        </span>
                                                                                    </div>
                                                                                </td>
                                                                                <td height="23" align="left">
                                                                                    &nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="tablerow" id="ACX2responsesVisitSlots" style="display: block;">
                                                                                <td colspan="2">
                                                                                    <div class="filterdataheader2">
                                                                                        <asp:GridView ID="gvToken" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                                                                            Font-Names="Verdana" Font-Size="8pt" OnRowDataBound="gvToken_RowDataBound" Style="display: none;"
                                                                                            meta:resourcekey="gvTokenResource1">
                                                                                            <Columns>
                                                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                                                                    <ItemTemplate>
                                                                                                        <input id="rdoTokenID" endtime='<%# Eval("EndTime") %>' name="rdoTokenID" onclick="javascript:TokenGenerated(value,shid,rtid,starttime,endtime);"
                                                                                                            rtid='<%# Eval("ResourceTemplateID") %>' shid='<%# Eval("ScheduleID") %>' starttime='<%# Eval("StartTime") %>'
                                                                                                            type="radio" value='<%# Eval("TokenNumber") %>' />
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:BoundField DataField="TokenNumber" HeaderText="Token" meta:resourcekey="BoundFieldResource9" />
                                                                                                <asp:BoundField DataField="Description" HeaderText="Description" meta:resourcekey="BoundFieldResource10" />
                                                                                                <asp:BoundField DataField="ResourceID" HeaderText="PhyID" meta:resourcekey="BoundFieldResource11" />
                                                                                                <asp:BoundField DataField="StartTime" DataFormatString="{0:hh:mm tt}" HeaderText="From"
                                                                                                    meta:resourcekey="BoundFieldResource12" />
                                                                                                <asp:BoundField DataField="EndTime" DataFormatString="{0:hh:mm tt}" HeaderText="To"
                                                                                                    meta:resourcekey="BoundFieldResource13" />
                                                                                                <asp:BoundField DataField="ScheduleID" meta:resourcekey="BoundFieldResource14" />
                                                                                                <asp:BoundField DataField="BookingStatus" meta:resourcekey="BoundFieldResource15">
                                                                                                    <HeaderStyle CssClass="NoneDisplay" />
                                                                                                    <ItemStyle CssClass="NoneDisplay" />
                                                                                                </asp:BoundField>
                                                                                            </Columns>
                                                                                            <HeaderStyle Font-Bold="False" Font-Names="Verdana" Font-Size="8pt" />
                                                                                            <RowStyle ForeColor="#000000" />
                                                                                        </asp:GridView>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </div>
                                                            </td>
                                                            <td nowrap="nowrap" width="50%" valign="top">
                                                                <div id="dvVisitSlots1" style="display: none;">
                                                                    <asp:Panel ID="pnlAvailableSlots" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlAvailableSlotsResource1">
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td class="colorforcontent" height="23" align="left">
                                                                                    <div id="ACX2AvailableSlots" style="display: none;">
                                                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                            style="cursor: pointer" onclick="showResponses('ACX2AvailableSlots','ACX2minusAvailableSlots','ACX2responsesAvailableSlots',1);" />
                                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2AvailableSlots','ACX2minusAvailableSlots','ACX2responsesAvailableSlots',1);">
                                                                                            &nbsp;<asp:Label ID="Rs_AvailableSlots" Text="Available Slots" runat="server" meta:resourcekey="Rs_AvailableSlotsResource1" /></span>
                                                                                    </div>
                                                                                    <div id="ACX2minusAvailableSlots" style="display: block;">
                                                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                            style="cursor: pointer" onclick="showResponses('ACX2AvailableSlots','ACX2minusAvailableSlots','ACX2responsesAvailableSlots',0);" />
                                                                                        &nbsp;<asp:Label ID="Rs1_AvailableSlots" Text="Available Slots" runat="server" meta:resourcekey="Rs1_AvailableSlotsResource1" />
                                                                                    </div>
                                                                                </td>
                                                                                <td height="23" align="left">
                                                                                    &nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="tablerow" id="ACX2responsesAvailableSlots" style="display: block;">
                                                                                <td colspan="2">
                                                                                    <div class="filterdatahe">
                                                                                        <asp:GridView ID="gvAvailableSlots" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                                                                            Font-Names="Verdana" Font-Size="8pt" OnRowDataBound="gvToken_RowDataBound" Style="display: none;"
                                                                                            meta:resourcekey="gvAvailableSlotsResource1">
                                                                                            <Columns>
                                                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource10">
                                                                                                    <ItemTemplate>
                                                                                                        <input id="rdoTokenID" endtime='<%# Eval("EndTime") %>' name="rdoTokenID" onclick="javascript:TokenGenerated(value,shid,rtid,starttime,endtime);"
                                                                                                            rtid='<%# Eval("ResourceTemplateID") %>' shid='<%# Eval("ScheduleID") %>' starttime='<%# Eval("StartTime") %>'
                                                                                                            type="radio" value='<%# Eval("TokenNumber") %>' />
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:BoundField DataField="TokenNumber" HeaderText="Token" meta:resourcekey="BoundFieldResource16" />
                                                                                                <asp:BoundField DataField="Description" HeaderText="Description" meta:resourcekey="BoundFieldResource17">
                                                                                                    <HeaderStyle CssClass="NoneDisplay" />
                                                                                                    <ItemStyle CssClass="NoneDisplay" />
                                                                                                </asp:BoundField>
                                                                                                <asp:BoundField DataField="ResourceID" HeaderText="PhyID" meta:resourcekey="BoundFieldResource18" />
                                                                                                <asp:BoundField DataField="StartTime" DataFormatString="{0:hh:mm tt}" HeaderText="From"
                                                                                                    meta:resourcekey="BoundFieldResource19" />
                                                                                                <asp:BoundField DataField="EndTime" DataFormatString="{0:hh:mm tt}" HeaderText="To"
                                                                                                    meta:resourcekey="BoundFieldResource20">
                                                                                                    <HeaderStyle CssClass="NoneDisplay" />
                                                                                                    <ItemStyle CssClass="NoneDisplay" />
                                                                                                </asp:BoundField>
                                                                                                <asp:BoundField DataField="ScheduleID" meta:resourcekey="BoundFieldResource21" />
                                                                                            </Columns>
                                                                                            <HeaderStyle Font-Bold="False" Font-Names="Verdana" Font-Size="8pt" />
                                                                                            <RowStyle ForeColor="#000000" />
                                                                                        </asp:GridView>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="center">
                                                <asp:Button ID="bsave" Enabled="False" runat="server" OnClientClick="return CheckLocation(this.id);"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    Text=" Make Visit Entry " ToolTip="Click here to Save Visit Entry" OnClick="bsave_Click"
                                                    meta:resourcekey="bsaveResource1" />
                                                <asp:Button ID="btnPrint" Enabled="False" runat="server" OnClick="btnPrint_Click"
                                                    ToolTip="Click here to Print & Save Visit Entry" Text=" Print & Make Visit Entry "
                                                    OnClientClick="return CheckLocation(this.id);" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <%--<div id="printPatientReg" runat="server" style="display: none;">
                                                <uc9:PrintPatRegistration ID="ucPatReg" runat="server" />
                                            </div>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <ul id="dvErrorDisplay" runat="server" style="display: none;">
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    </div>
                    <asp:HiddenField ID="hdnTokenNo" runat="server" />
                    <asp:HiddenField ID="hdnScheduleID" runat="server" />
                    <asp:HiddenField ID="hdnResourceTemplateID" runat="server" />
                    <asp:HiddenField ID="hdnStartTime" runat="server" />
                    <asp:HiddenField ID="hdnEndTime" runat="server" />
                    <asp:HiddenField ID="hdnSlotCount" runat="server" />
                    <asp:HiddenField ID="hdnVisitPurposeId" runat="server" />
                    <asp:HiddenField ID="hdnRefId" runat="server" />
                    <asp:HiddenField ID="hdnRefdetailsId" runat="server" />
                    <asp:HiddenField ID="pSpecialityID" runat="server" />
                    <asp:HiddenField ID="pPhysicianID" runat="server" />
                    <asp:HiddenField ID="pPurposeName" runat="server" />
                    <input type="hidden" id="hdnMaster" runat="server" />
                    <input type="hidden" id="hdnChild" runat="server" />
                    <input type="hidden" id="hdnMasterID" runat="server" />
                    <input type="hidden" id="hdnUpdatedList" runat="server" />
                    <asp:HiddenField ID="hdnSex" runat="server" />
                    <asp:HiddenField ID="hdnURL" runat="server" />
                    <asp:HiddenField ID="hdnclient" runat="server" />
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnPID" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>

<script language="javascript" type="text/javascript">
    function ReferralRowSelect(rid, pRefid, pRefdetailsId, pVisitPurpose, pPhysicianID, pSpecialityID, pPurposeName) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById("hdnVisitPurposeId").value = pVisitPurpose;
        document.getElementById("hdnRefId").value = pRefid;
        document.getElementById("hdnRefdetailsId").value = pRefdetailsId;
        document.getElementById("dPurpose").value = pVisitPurpose;
        document.getElementById("pSpecialityID").value = pSpecialityID;
        document.getElementById("pPhysicianID").value = pPhysicianID;
        document.getElementById("pPurposeName").value = pPurposeName;
        document.getElementById("usrConsulting_ddlConsultingName").value = pPhysicianID;
        OnSelectedIndexChange();
        ChangeSelection('usrConsulting_ddlConsultingName');
        chkSource(pPhysicianID);
    }

    //    function Show(PopUpUrl) {
    //        //alert('test');
    //        var ScreenWidth = window.screen.width;
    //        var ScreenHeight = window.screen.height;
    //        var movefromedge = 0;
    //        var WinPop = window.open(PopUpUrl, "", "toolbar=1,location=0,directories=0,status=0,scrollbars=1,menubar=1,resizable=1,");
    //    }
</script>

</html>
