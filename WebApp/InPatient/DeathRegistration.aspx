<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeathRegistration.aspx.cs"
    Inherits="InPatient_DeathRegistration" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="AdviceControl" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/ComplaintICDCodeBP.ascx" TagName="ComplaintICDCodeBP"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/CODICDCode.ascx" TagName="CODICDCode" TagPrefix="uc6" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Death Registration</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function checkForValues() {

            if (document.getElementById('txtDOD').value == "") {
                  var userMsg = SListForApplicationMessages.Get('InPatient\\DeathRegistration.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the date and time of death');
                return false;
                }
            }
        }


        function showContentHis(id) {

            var divid = 'div' + id;
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
            }
            else {
                document.getElementById(divid).style.display = 'none';
            }

        }


        function showOthersBoxHis(ddl) {

            var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;

            var strDiv = 'div' + ddl;

            if ((ddlValue == "Others") || (ddlValue == "Delivered")) {
                document.getElementById(strDiv).style.display = 'block';
            }
            else {
                document.getElementById(strDiv).style.display = 'none';
            }
        }

        // Show Hide MLC Details
        function showRTABlock() {

            if (document.getElementById('trRTABlock').style.display == "none") {
                document.getElementById('trRTABlock').style.display = "block";
            }
            else {
                document.getElementById('trRTABlock').style.display = "none";
            }
        }
        function showODBlock() {
            if (document.getElementById('trODBlock').style.display == "none") {
                document.getElementById('trODBlock').style.display = "block";
            }
            else {
                document.getElementById('trODBlock').style.display = "none";
            }
            if (document.getElementById('trODBlock1').style.display == "none") {
                document.getElementById('trODBlock1').style.display = "block";
            }
            else {
                document.getElementById('trODBlock1').style.display = "none";
            }

        }

        //Add Cause Of Death

        function onClickAddCOS() {
            var rwNumber = parseInt(500);
            var AddStatus = 0;

            var DeathTypeID = document.getElementById("ddlType").options[document.getElementById("ddlType").selectedIndex].value;
            var DeathTypeName = document.getElementById("ddlType").options[document.getElementById("ddlType").selectedIndex].text;

            var txtCOD = document.getElementById('txtCOD').value.trim();

            document.getElementById('tblCODItems').style.display = 'block';
            var HidValue = document.getElementById('hdnCOD').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnCOD').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var CODList = list[count].split('~');

                    if (CODList[1] != '') {
                        if (CODList[0] != '') {
                            rwNumber = parseInt(parseInt(CODList[0]) + parseInt(1));
                        }
                        if (DeathTypeName != '') {
                            if (CODList[2] == DeathTypeName) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (DeathTypeName != '') {
                    var row = document.getElementById('tblCODItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickCOD(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = DeathTypeName;
                    cell3.innerHTML = txtCOD;
                    document.getElementById('hdnCOD').value += parseInt(rwNumber) + "~" + DeathTypeID + "~" + DeathTypeName + "~" + txtCOD + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (DeathTypeName != '') {
                    var row = document.getElementById('tblCODItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickCOD(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = DeathTypeName;
                    cell3.innerHTML = txtCOD;
                    document.getElementById('hdnCOD').value += parseInt(rwNumber) + "~" + DeathTypeID + "~" + DeathTypeName + "~" + txtCOD + "^";
                }
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get('InPatient\\DeathRegistration.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Cause of death already added');
                return false ;
                }
            }
            document.getElementById('txtCOD').value = '';


            return false;

        }
        function ImgOnclickCOD(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnCOD').value;
            var list = HidValue.split('^');
            var newCODList = '';
            if (document.getElementById('hdnCOD').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var CODList = list[count].split('~');
                    if (CODList[0] != '') {
                        if (CODList[0] != ImgID) {
                            newCODList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnCOD').value = newCODList;
            }
            if (document.getElementById('hdnCOD').value == '') {
                document.getElementById('tblCODItems').style.display = 'none';
            }
        }


        function LoadCauseOfDeath() {
            var HidValue = document.getElementById('hdnCOD').value;

            var list = HidValue.split('^');
            if (document.getElementById('hdnCOD').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var CODList = list[count].split('~');
                    var row = document.getElementById('tblCODItems').insertRow(0);
                    row.id = CODList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickCOD(" + CODList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = CODList[2];
                    cell3.innerHTML = CODList[3];
                }
            }
        }





        //Add Organ Donation


        function onClickAddOrganDonation() {
            var rwNumber = parseInt(300);
            var AddStatus = 0;

            var OrgRegID = document.getElementById("ddlOrgReg").options[document.getElementById("ddlOrgReg").selectedIndex].value;
            var OrgRegName = document.getElementById("ddlOrgReg").options[document.getElementById("ddlOrgReg").selectedIndex].text;

            var txtOrg = document.getElementById('txtOrg').value.trim();

            document.getElementById('tblOD').style.display = 'block';
            var HidValue = document.getElementById('hdnOD').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnOD').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ODList = list[count].split('~');

                    if (ODList[1] != '') {
                        if (ODList[0] != '') {
                            rwNumber = parseInt(parseInt(ODList[0]) + parseInt(1));
                        }
                        if (OrgRegName != '') {
                            if (ODList[2] == OrgRegName) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (OrgRegName != '') {
                    var row = document.getElementById('tblOD').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOD(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = OrgRegName;
                    cell3.innerHTML = txtOrg;
                    document.getElementById('hdnOD').value += parseInt(rwNumber) + "~" + OrgRegID + "~" + OrgRegName + "~" + txtOrg + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (OrgRegName != '') {
                    var row = document.getElementById('tblOD').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickCOD(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = OrgRegName;
                    cell3.innerHTML = txtOrg;
                    document.getElementById('hdnOD').value += parseInt(rwNumber) + "~" + OrgRegID + "~" + OrgRegName + "~" + txtOrg + "^";
                }
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get('InPatient\\DeathRegistration.aspx_3');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Organ donation already added');
                return false ;
                }
            }
            document.getElementById('txtOrg').value = '';


            return false;

        }
        function ImgOnclickOD(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnOD').value;
            var list = HidValue.split('^');
            var newODList = '';
            if (document.getElementById('hdnOD').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var ODList = list[count].split('~');
                    if (ODList[0] != '') {
                        if (ODList[0] != ImgID) {
                            newODList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnOD').value = newODList;
            }
            if (document.getElementById('hdnOD').value == '') {
                document.getElementById('tblOD').style.display = 'none';
            }
        }


        function LoadOrganDonation() {
            var HidValue = document.getElementById('hdnOD').value;

            var list = HidValue.split('^');
            if (document.getElementById('hdnOD').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var ODList = list[count].split('~');
                    var row = document.getElementById('tblOD').insertRow(0);
                    row.id = ODList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickOD(" + ODList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ODList[2];
                    cell3.innerHTML = ODList[3];
                }
            }
        }

        //  //Add Organ Donation


        function expandBox(id) {
            document.getElementById(id).rows = "5";
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1";
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnFinish">
    <input type="hidden" id="hdnCOD" runat="server" />
    <input type="hidden" id="hdnOD" runat="server" />
    <input type="hidden" id="hdnType" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
   <ContentTemplate>--%>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:DocHeader ID="docHeader" runat="server" />--%>
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" OnClick="lnkHome_Click"
                                        meta:resourcekey="LinkButton1Resource1">Home&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" runat="server" style="display: block"
                            id="tblSelectOption">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center">
                                    <asp:Label ID="lblNeonatal" runat="server" Text="Death Registration" meta:resourcekey="lblNeonatalResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table2" runat="server"
                            class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000; padding-left: 10px;">
                                                <asp:Label ID="Rs_BloodGroup" Text="Blood Group:" runat="server" meta:resourcekey="Rs_BloodGroupResource1"></asp:Label>
                                                <asp:Label ID="lblBloodgroup" runat="server" meta:resourcekey="lblBloodgroupResource1"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; color: #000;">
                                                <asp:Label ID="Rs_DateofAdmission" Text="Date of Admission:" runat="server" meta:resourcekey="Rs_DateofAdmissionResource1"></asp:Label>
                                                <asp:Label ID="lblDateOfAdmission" runat="server" meta:resourcekey="lblDateOfAdmissionResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px; width: 200px; font-weight: bold;">
                                    <asp:Label ID="Rs_SurgeryDetails" Text="Surgery Details" runat="server" meta:resourcekey="Rs_SurgeryDetailsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000;">
                                                <asp:Table runat="server" ID="tblSurgeryDetail" CellPadding="5" CellSpacing="0" GridLines="Both"
                                                    meta:resourcekey="tblSurgeryDetailResource1">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="2" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <td style="padding-left: 10px; font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_Info1" Text="History Of Present Illness" runat="server" meta:resourcekey="Rs_Info1Resource1"></asp:Label>
                                            </td>
                                            <td style="font-weight: bold; height: 20px; color: #000;">
                                                <asp:Label ID="Rs_PastMedicalHistory" Text="Past Medical History" runat="server"
                                                    meta:resourcekey="Rs_PastMedicalHistoryResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <table class="dataheaderInvCtrl" cellspacing="0" border="0" width="50%">
                                                    <tr class="defaultfontcolor">
                                                        <td valign="top" style="padding-left: 10px;">
                                                            <asp:Table runat="server" ID="tbPresentHistory" CssClass="colorforcontentborder"
                                                                CellSpacing="0" BorderWidth="0px" meta:resourcekey="tbPresentHistoryResource1">
                                                            </asp:Table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top">
                                                <table class="dataheaderInvCtrl" cellspacing="0" border="0" width="50%">
                                                    <tr class="defaultfontcolor">
                                                        <td valign="top">
                                                            <asp:Table runat="server" ID="tbPasthistory" CssClass="colorforcontentborder" CellSpacing="0"
                                                                BorderWidth="0px" meta:resourcekey="tbPasthistoryResource1">
                                                            </asp:Table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" runat="server" class="dataheaderInvCtrl">
                            <tr>
                                <td style="padding-left: 10px; width: 200px; padding-top: 20px;">
                                    <asp:Label ID="Rs_Procedure" Text="Procedure" runat="server" meta:resourcekey="Rs_ProcedureResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" Rows="1" ID="txtProcedures" TextMode="MultiLine" Style="width: 220px;
                                        height: 60px;" meta:resourcekey="txtProceduresResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px; width: 200px; padding-top:20px;">
                                    <asp:Label ID="Rs_DateandTimeofDeath" Text="Date and Time of Death" runat="server"
                                        meta:resourcekey="Rs_DateandTimeofDeathResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtDOD" MaxLength="25" size="25" CssClass="Txtboxsmall" meta:resourcekey="txtDODResource1"></asp:TextBox>
                                    <a href="javascript:NewCal('<%=txtDOD.ClientID %>','ddmmyyyy',true,12)">
                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="Rs_Placeofoccurrence" Text="Place of occurrence" runat="server" meta:resourcekey="Rs_PlaceofoccurrenceResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPOC" runat="server" onchange="javascript:showOthersBoxHis(this.id);" CssClass ="ddlsmall"
                                        meta:resourcekey="ddlPOCResource1">
                                    </asp:DropDownList>
                                    <div id="divddlPOC" runat="server" style="display: none">
                                        <asp:TextBox ID="txtPOCOthers" runat="server" meta:resourcekey="txtPOCOthersResource1"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 10px;">
                                    <asp:Label ID="Rs_Typeofdeath" Text="Type of death" runat="server" meta:resourcekey="Rs_TypeofdeathResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTOD" runat="server" onchange="javascript:showOthersBoxHis(this.id);" CssClass="ddlsmall"
                                        meta:resourcekey="ddlTODResource1">
                                    </asp:DropDownList>
                                    <div id="divddlTOD" runat="server" style="display: none">
                                        <asp:TextBox ID="txtTODOthers" runat="server" meta:resourcekey="txtTODOthersResource1"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table1" runat="server"
                            class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000; padding-left: 10px;" colspan="4">
                                    <asp:Label ID="Rs_CauseOfDeath" Text="Cause Of Death" runat="server" meta:resourcekey="Rs_CauseOfDeathResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; height: 20px; color: #000; padding-left: 10px;" colspan="4">
                                    <asp:Label ID="Rs_Primarycausesofdeath" Text="Primary cause(s) of death" runat="server"
                                        meta:resourcekey="Rs_PrimarycausesofdeathResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; height: 20px; color: #000; padding-left: 10px;" colspan="4">
                                    <asp:Label ID="Rs_Secondarycausesofdeath" Text="Secondary cause(s) of death" runat="server"
                                        meta:resourcekey="Rs_SecondarycausesofdeathResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <uc10:ComplaintICDCodeBP ID="ComplaintICDCodeBP1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; height: 20px; color: #000; padding-left: 10px;" colspan="4">
                                    <asp:Label ID="Rs_AssociatedIllnesses" Text="Associated Illness(es)" runat="server"
                                        meta:resourcekey="Rs_AssociatedIllnessesResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <uc6:CODICDCode ID="CODICDCode1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblBackrountProblem"
                            runat="server" class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000; padding-left: 10px;" colspan="4">
                                    <asp:Label ID="Rs_RiskFactors" Text="Risk Factors" runat="server" meta:resourcekey="Rs_RiskFactorsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trchkTobaccochewing_1068" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkTobaccochewing_1068" runat="server" Text="Tobacco chewing" onclick="javascript:showContentHis(this.id);"
                                                    meta:resourcekey="chkTobaccochewing_1068Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkTobaccochewing_1068" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkTobaccochewing_1068" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblQty_25" runat="server" Text="Quantity" meta:resourcekey="lblQty_25Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDuration_24" runat="server" Text="Duration" meta:resourcekey="lblDuration_24Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtQty_72" runat="server" Width="50px" meta:resourcekey="txtQty_72Resource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDuration_24" runat="server" Width="50px" meta:resourcekey="txtDuration_24Resource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlDurationt_24" runat="server" meta:resourcekey="ddlDurationt_24Resource1">
                                                        <asp:ListItem Value="68" Text="year(s)" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Value="69" Text="day(s)" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        <asp:ListItem Value="70" Text="week(s)" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        <asp:ListItem Value="71" Text="month(s)" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr id="trchkSmoking_476" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkSmoking_476" runat="server" Text="Smoking" onclick="javascript:showContentHis(this.id);"
                                                    meta:resourcekey="chkSmoking_476Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkSmoking_476" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkSmoking_476" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblQtyTS_3" CssClass="defaultfontcolor" runat="server" Text="Quantity"
                                                        meta:resourcekey="lblQtyTS_3Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDurationTS_2" runat="server" CssClass="defaultfontcolor" Text="Duration"
                                                        meta:resourcekey="lblDurationTS_2Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtPacksTS_9" Width="35px" runat="server" meta:resourcekey="txtPacksTS_9Resource1"></asp:TextBox>
                                                    <asp:Label ID="lblPacksTS" runat="server" Text="Sticks/Day" meta:resourcekey="lblPacksTSResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDurationTS" Width="35px" runat="server" meta:resourcekey="txtDurationTSResource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlDurationTS" runat="server" meta:resourcekey="ddlDurationTSResource1">
                                                        <asp:ListItem Value="8" Text="year(s)" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                        <asp:ListItem Value="5" Text="day(s)" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                        <asp:ListItem Value="6" Text="week(s)" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                        <asp:ListItem Value="7" Text="month(s)" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr id="trchkAlcohol_369" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkAlcohol_369" runat="server" Text="Alcohol" onclick="javascript:showContentHis(this.id);"
                                                    meta:resourcekey="chkAlcohol_369Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkAlcohol_369" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkAlcohol_369" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblQtyAC_6" runat="server" Text="Quantity" meta:resourcekey="lblQtyAC_6Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDurationAC_5" runat="server" Text="Duration" meta:resourcekey="lblDurationAC_5Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtQtyAC" Width="35px" runat="server" meta:resourcekey="txtQtyACResource1"></asp:TextBox>
                                                    &nbsp;&nbsp;
                                                    <asp:DropDownList ID="ddlmlDoW" runat="server" meta:resourcekey="ddlmlDoWResource1">
                                                        <asp:ListItem Text="ml/Day" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                        <asp:ListItem Text="ml/week" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDurationAC" Width="35px" runat="server" meta:resourcekey="txtDurationACResource1"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlDurationAC" runat="server" meta:resourcekey="ddlDurationACResource1">
                                                        <asp:ListItem Value="16" Text="year(s)" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                                        <asp:ListItem Value="13" Text="day(s)" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                                        <asp:ListItem Value="14" Text="week(s)" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                                        <asp:ListItem Value="15" Text="month(s)" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr id="trchkIllicitdrugs_411" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkIllicitdrugs_411" runat="server" Text="Illicit drugs" onclick="javascript:showContentHis(this.id);"
                                                    meta:resourcekey="chkIllicitdrugs_411Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkIllicitdrugs_3" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkIllicitdrugs_411" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblType_26" runat="server" Text="Type" meta:resourcekey="lblType_26Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlType_26" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                                        meta:resourcekey="ddlType_26Resource1">
                                                        <asp:ListItem Text="Opiates" Value="73" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                                        <asp:ListItem Text="Cocaine" Value="74" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                                        <asp:ListItem Text="Inhalants" Value="75" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                                        <asp:ListItem Text="Crack" Value="76" meta:resourcekey="ListItemResource18"></asp:ListItem>
                                                        <asp:ListItem Text="Heroin" Value="77" meta:resourcekey="ListItemResource19"></asp:ListItem>
                                                        <asp:ListItem Text="Marijuana" Value="78" meta:resourcekey="ListItemResource20"></asp:ListItem>
                                                        <asp:ListItem Text="MDMA" Value="79" meta:resourcekey="ListItemResource21"></asp:ListItem>
                                                        <asp:ListItem Text="Hydrocodone" Value="80" meta:resourcekey="ListItemResource22"></asp:ListItem>
                                                        <asp:ListItem Text="PCP" Value="81" meta:resourcekey="ListItemResource23"></asp:ListItem>
                                                        <asp:ListItem Text="LSD" Value="82" meta:resourcekey="ListItemResource24"></asp:ListItem>
                                                        <asp:ListItem Text="Others" Value="83" meta:resourcekey="ListItemResource25"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div id="divddlType_26" runat="server" style="display: none">
                                                        <asp:TextBox ID="txtOthersTypeID_26" runat="server" meta:resourcekey="txtOthersTypeID_26Resource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr id="trchkPregnancy" runat="server" style="display: block;">
                                <td>
                                    <table cellpadding="0">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkPregnancy" runat="server" Text="Death Associated With Pregnancy"
                                                    onclick="javascript:showContentHis(this.id);" meta:resourcekey="chkPregnancyResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="defaultfontcolor" id="tr1chkPregnancy" runat="server" style="display: block;">
                                <td>
                                    <div id="divchkPregnancy" runat="server" style="display: none">
                                        <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPregnancyType" runat="server" Text="Type" meta:resourcekey="lblPregnancyTypeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlPregnancyType" runat="server" onchange="javascript:showOthersBoxHis(this.id);"
                                                        meta:resourcekey="ddlPregnancyTypeResource1">
                                                        <asp:ListItem Text="Not delivered" Value="1" meta:resourcekey="ListItemResource26"></asp:ListItem>
                                                        <asp:ListItem Text="Delivered" Value="2" meta:resourcekey="ListItemResource27"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div id="divddlPregnancyType" runat="server" style="display: none">
                                                        <asp:TextBox ID="txtDelivered" runat="server" meta:resourcekey="txtDeliveredResource1"></asp:TextBox>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblResuscitation"
                            runat="server" class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000; padding-left: 10px;" colspan="4">
                                    <asp:Label ID="Rs_ResuscitationAndSupport" Text="Resuscitation And Support" runat="server"
                                        meta:resourcekey="Rs_ResuscitationAndSupportResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkResuscitation" Text="Resuscitation And Support" runat="server"
                                        meta:resourcekey="chkResuscitationResource1" />
                                </td>
                                <td>
                                    <asp:Label ID="Rs_TypeOfLifeSupport" Text="Type Of Life Support" runat="server" meta:resourcekey="Rs_TypeOfLifeSupportResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlTOLS" CssClass ="ddlsmall" runat="server" meta:resourcekey="ddlTOLSResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td>
                                    <asp:CheckBox ID="chkROSC" Text="ROSC" runat="server" meta:resourcekey="chkROSCResource1" />
                                    &nbsp;
                                    <asp:TextBox runat="server" ID="txtROSC"  CssClass ="Txtboxverysmall" meta:resourcekey="txtROSCResource1"></asp:TextBox>&nbsp;min
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table3" runat="server"
                            class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000; padding-left: 10px;">
                                    <asp:Label ID="Rs_HospitalCourse" Text="Hospital Course" runat="server" meta:resourcekey="Rs_HospitalCourseResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <%--<td style="width: 114px;">
                                                Hospital Course
                                            </td>--%>
                                            <td colspan="2">
                                                <FCKeditorV2:FCKeditor ID="fckHospitalCourse" runat="server" Width="100%" Height="200px">
                                                </FCKeditorV2:FCKeditor>
                                                <%--<asp:TextBox ID="txtHospitalCourse" runat="server" Width="75%" TextMode="MultiLine"></asp:TextBox>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="Table5" runat="server"
                            class="dataheaderInvCtrl">
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkRTA" runat="server" onClick="javascript:showRTABlock();" Text="MLC Formalities"
                                                    meta:resourcekey="chkRTAResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trRTABlock" runat="server" style="display: none;" class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="98%">
                                        <tr class="defaultfontcolor">
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkRTAInfluenceOfDrugs" runat="server" Text="Under the influence of Alcohol / Drugs"
                                                    meta:resourcekey="chkRTAInfluenceOfDrugsResource1" />
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td style="width: 20%;">
                                                <asp:Label ID="Rs_EventLocation" Text="Event Location" runat="server" meta:resourcekey="Rs_EventLocationResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRTALocation" runat="server" CssClass ="Txtboxsmall" meta:resourcekey="txtRTALocationResource1"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_EventDate" Text="Event Date" runat="server" meta:resourcekey="Rs_EventDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRTADate" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtRTADateResource1"></asp:TextBox>
                                                <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtRTADate"
                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                    ControlToValidate="txtRTADate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />&nbsp;<img
                                                        src="../Images/starbutton.png" alt="" align="middle" />
                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtRTADate"
                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc" Enabled="True" />
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:Label ID="Rs_FIRNo" Text="FIR No" runat="server" meta:resourcekey="Rs_FIRNoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRTAFIRNo" runat="server" CssClass ="Txtboxsmall" meta:resourcekey="txtRTAFIRNoResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_FIRDate" Text="FIR Date" runat="server" meta:resourcekey="Rs_FIRDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFIRDate" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFIRDateResource1"></asp:TextBox>
                                                <asp:ImageButton ID="ImgBntCalcFIR" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcFIRResource1" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFIRDate"
                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender1"
                                                    ControlToValidate="txtFIRDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                <ajc:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="txtFIRDate"
                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFIR" Enabled="True" />
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:Label ID="Rs_PoliceStation" Text="Police Station" runat="server" meta:resourcekey="Rs_PoliceStationResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPoliceStation" runat="server"  CssClass ="Txtboxsmall" meta:resourcekey="txtPoliceStationResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_MLCNo" Text="MLC No" runat="server" meta:resourcekey="Rs_MLCNoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMLCNo" runat="server"  CssClass ="Txtboxsmall" meta:resourcekey="txtMLCNoResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="98%">
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:CheckBox ID="chkOD" runat="server" onClick="javascript:showODBlock();" Text="Organ Donation"
                                                    meta:resourcekey="chkODResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trODBlock" runat="server" style="display: none;" class="defaultfontcolor">
                                <td>
                                    <asp:Label ID="Rs_OrgansRegistered" Text="Organs Registered" runat="server" meta:resourcekey="Rs_OrgansRegisteredResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlOrgReg" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlOrgRegResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_RegisteredWithOrganisation" Text="Registered With Organisation"
                                        runat="server" meta:resourcekey="Rs_RegisteredWithOrganisationResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOrg" runat="server" MaxLength="60" CssClass ="Txtboxsmall" TabIndex="38" meta:resourcekey="txtOrgResource1"></asp:TextBox>
                                    <asp:Button ID="btnAddOrganDonation" OnClientClick="javascript:return onClickAddOrganDonation();"
                                        runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnAddOrganDonationResource1" />
                                </td>
                            </tr>
                            <tr id="trODBlock1" runat="server" style="display: none;" class="defaultfontcolor">
                                <td colspan="4">
                                    <table id="tblOD" class="dataheaderInvCtrl" runat="server" cellpadding="4" cellspacing="0"
                                        border="0" width="97%">
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnFinish" runat="server" Text="Save" CssClass="btn" OnClick="btnFinish_Click"
                                        OnClientClick="javascript:return checkForValues();" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <%-- </ContentTemplate>
      </asp:UpdatePanel>--%>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        LoadOrganDonation();
        //  LoadCauseOfDeath();
     
    </script>

</body>
</html>
