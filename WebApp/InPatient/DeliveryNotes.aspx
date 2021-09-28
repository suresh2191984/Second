<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeliveryNotes.aspx.cs" Inherits="InPatient_DeliveryNotes"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Labour And DeliveryNotes</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function onClickAddComplicationItems() {
            var rwNumber = parseInt(220);
            var AddStatus = 0;
            var txtComplicationValue = document.getElementById('txtComplication').value.trim();
            document.getElementById('tblComplicationItems').style.display = 'block';
            var HidValue = document.getElementById('hdnComplicationItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnComplicationItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[1] != '') {
                        if (DiagnosisList[0] != '') {
                            rwNumber = parseInt(parseInt(DiagnosisList[0]) + parseInt(1));
                        }
                        if (txtComplicationValue != '') {
                            if (DiagnosisList[1] == txtComplicationValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }

            else {

                if (txtComplicationValue != '') {
                    var row = document.getElementById('tblComplicationItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplication(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComplicationValue;
                    document.getElementById('hdnComplicationItems').value += parseInt(rwNumber) + "~" + txtComplicationValue + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtComplicationValue != '') {
                    var row = document.getElementById('tblComplicationItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplication(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComplicationValue;
                    document.getElementById('hdnComplicationItems').value += parseInt(rwNumber) + "~" + txtComplicationValue + "^";
                }
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Complication already added');
                return false ;
                }
            }
            document.getElementById('txtComplication').value = '';
            return false;
        }

        function ImgOnclickComplication(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnComplicationItems').value;
            var list = HidValue.split('^');
            var newDiagnosisList = '';
            if (document.getElementById('hdnComplicationItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[0] != '') {
                        if (DiagnosisList[0] != ImgID) {
                            newDiagnosisList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnComplicationItems').value = newDiagnosisList;
            }
            if (document.getElementById('hdnComplicationItems').value == '') {
                document.getElementById('tblComplicationItems').style.display = 'none';
            }
        }
        function LoadDiagnosisItems() {
            var HidValue = document.getElementById('hdnComplicationItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnComplicationItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var DiagnosisList = list[count].split('~');
                    var row = document.getElementById('tblComplicationItems').insertRow(0);
                    row.id = DiagnosisList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplication(" + parseInt(DiagnosisList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = DiagnosisList[1];
                }
            }
        }



        //Instruction Items


        function onClickAddInsItems() {
            var rwNumber = parseInt(320);
            var AddStatus = 0;
            var txtComplicationValue = document.getElementById('txtIns').value.trim();
            document.getElementById('tblInsItems').style.display = 'block';
            var HidValue = document.getElementById('hdnInsItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnInsItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[1] != '') {
                        if (DiagnosisList[0] != '') {
                            rwNumber = parseInt(parseInt(DiagnosisList[0]) + parseInt(1));
                        }
                        if (txtComplicationValue != '') {
                            if (DiagnosisList[1] == txtComplicationValue) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }

            else {

                if (txtComplicationValue != '') {
                    var row = document.getElementById('tblInsItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickInsItems(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComplicationValue;
                    document.getElementById('hdnInsItems').value += parseInt(rwNumber) + "~" + txtComplicationValue + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtComplicationValue != '') {
                    var row = document.getElementById('tblInsItems').insertRow(0);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickInsItems(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComplicationValue;
                    document.getElementById('hdnInsItems').value += parseInt(rwNumber) + "~" + txtComplicationValue + "^";
                }
            }
            else if (AddStatus == 1) {
             var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Instruction already added');
                return false ;
                }
            }
            document.getElementById('txtIns').value = '';
            return false;
        }

        function ImgOnclickInsItems(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnInsItems').value;
            var list = HidValue.split('^');
            var newDiagnosisList = '';
            if (document.getElementById('hdnInsItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var DiagnosisList = list[count].split('~');
                    if (DiagnosisList[0] != '') {
                        if (DiagnosisList[0] != ImgID) {
                            newDiagnosisList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnInsItems').value = newDiagnosisList;
            }
            if (document.getElementById('hdnInsItems').value == '') {
                document.getElementById('tblInsItems').style.display = 'none';
            }
        }
        function LoadInsItems() {
            var HidValue = document.getElementById('hdnInsItems').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnInsItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var DiagnosisList = list[count].split('~');
                    var row = document.getElementById('tblInsItems').insertRow(0);
                    row.id = DiagnosisList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickInsItems(" + parseInt(DiagnosisList[0]) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = DiagnosisList[1];
                }
            }
        }

        function checkForValues() {

            if (document.getElementById("ddlGenerationType").options[document.getElementById("ddlGenerationType").selectedIndex].value == "--Select--") {
                 var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_3');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Select generation type');
                return false ;
                }
                document.getElementById("ddlGenerationType").focus();
                return false;
            }
            var HidValue = document.getElementById('hdnChkValues').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnChkValues').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var gridItems = list[count].split('~');
                    if (gridItems.length > 1) {
                        if (document.getElementById(gridItems[0]).value == '') {
                         var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_4');
                            if(userMsg !=null)
                             {
                                 alert(userMsg);
                                  return false;
                              }
                        else{
                            alert('Provide name for the child');
                            return false ;
                            }
                            document.getElementById(gridItems[0]).focus();
                            return false;
                        }
                        else {
                            if (document.getElementById(gridItems[1]).value == '') {
                             var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_5');
                               if(userMsg !=null)
                            {
                                  alert(userMsg);
                                  return false;
                            }
                            else{
                                alert('Provide the date of birth');
                                return false ;
                                }
                                document.getElementById(gridItems[1]).focus();
                                return false;
                            }
                        }
                        var obj = document.getElementById(gridItems[1]).value;
                        var currentTime;
                        tempdobDt = obj.split(' ');
                        dobDt = tempdobDt[0].split('-');
                        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                        var mMonth = dobDtTime.getMonth() + 1;
                        var mDay = dobDtTime.getDate();
                        var mYear = dobDtTime.getFullYear();
                        currentTime = new Date();
                        var month = currentTime.getMonth() + 1;
                        var day = currentTime.getDate();
                        var year = currentTime.getFullYear();
                        if (mYear > year) {
                         var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_6');
                               if(userMsg !=null)
                            {
                                  alert(userMsg);
                                  return false;
                            }
                            else{
                            alert('Invalid date');
                            return false ;
                            }
                            document.getElementById(gridItems[1]).focus();
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                         var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_6');
                               if(userMsg !=null)
                            {
                                  alert(userMsg);
                                  return false;
                            }
                            else{
                            alert('Invalid date');
                            return false ;
                            }
                            document.getElementById(gridItems[1]).focus();
                            return false;
                        }
                        else if (mYear == year && mMonth == month && mDay > day) {
                         var userMsg = SListForApplicationMessages.Get('InPatient\\DeliveryNotes.aspx_6');
                               if(userMsg !=null)
                            {
                                  alert(userMsg);
                                  return false;
                            }
                            else{
                            alert('Invalid date');
                            return false ;
                            }
                            document.getElementById(gridItems[1]).focus();
                            return false;
                        }

                    }
                }
            }
        }

        function ShowAPGAR(id) {
            var GridRowID = id.split('_');
            var txtOnemin = GridRowID[0] + "_" + GridRowID[1] + "_" + "txtOnemin";
            var txtfiveMin = GridRowID[0] + "_" + GridRowID[1] + "_" + "txtfiveMin";

            if (document.getElementById(id).value == "1") {
                document.getElementById(txtOnemin).readOnly = false;
                document.getElementById(txtfiveMin).readOnly = false;
                document.getElementById(txtOnemin).focus();

            }
            else {
                document.getElementById(txtOnemin).readOnly = true;
                document.getElementById(txtfiveMin).readOnly = true;
                document.getElementById(txtOnemin).value = "";
                document.getElementById(txtfiveMin).value = "";
            }
        }




        var ddlText, ddlValue, ddl, lblMesg;
        var ddlText1, ddlValue1, ddl1, lblMesg1;
        function CacheItems() {
            ddlText = new Array();
            ddlValue = new Array();
            ddl = document.getElementById('<%=ddlDelObstretician.ClientID %>');
            for (var i = 0; i < ddl.options.length; i++) {
                ddlText[ddlText.length] = ddl.options[i].text;
                ddlValue[ddlValue.length] = ddl.options[i].value;
            }


            ddlText1 = new Array();
            ddlValue1 = new Array();
            ddl1 = document.getElementById('<%=ddlNeonatologist.ClientID %>');
            for (var i = 0; i < ddl1.options.length; i++) {
                ddlText1[ddlText1.length] = ddl1.options[i].text;
                ddlValue1[ddlValue1.length] = ddl1.options[i].value;
            }
        }

        window.onload = CacheItems;


        function FilterItems(value) {
            value = value.toLowerCase();
            ddl.options.length = 0;
            for (var i = 0; i < ddlText.length; i++) {
                if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                    AddItem(ddlText[i], ddlValue[i]);
                }
            }

            if (ddl.options.length == 0) {
                AddItem("No Physician Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            ddl.options.add(opt);
        }
        function AddPhysician() {

            var ddlPhy = document.getElementById('<%= ddlDelObstretician.ClientID %>');
            var ddlPhyLength = ddlPhy.options.length;
            for (var i = 0; i < ddlPhyLength; i++) {
                if (ddlPhy.options[i].selected) {


                    if (ddlPhy.options[i].text != '--Select--') {

                        document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;

                    }

                }

            }
        }





        function FilterItems1(value) {
            ddl1.options.length = 0;
            for (var i = 0; i < ddlText1.length; i++) {
                if (ddlText1[i].toLowerCase().indexOf(value) != -1) {
                    AddItem1(ddlText1[i], ddlValue1[i]);
                }
            }

            if (ddl1.options.length == 0) {
                AddItem1("No Physician Found", "");
            }
        }

        function AddItem1(text1, value1) {
            var opt1 = document.createElement("option");
            opt1.text = text1;
            opt1.value = value1;
            ddl1.options.add(opt1);
        }
        function AddPhysician1() {

            var ddlPhy1 = document.getElementById('<%= ddlNeonatologist.ClientID %>');
            var ddlPhyLength1 = ddlPhy1.options.length;
            for (var i = 0; i < ddlPhyLength1; i++) {
                if (ddlPhy1.options[i].selected) {


                    if (ddlPhy1.options[i].text != '--Select--') {

                        document.getElementById('<%= txtNew1.ClientID %>').value = ddlPhy1.options[i].text;

                    }

                }

            }
        }




        
        
        
    </script>

    <style type="text/css">
        .style2
        {
            height: 19px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    <asp:HiddenField ID="hdnEdit" runat="server" />
                                    <asp:HiddenField ID="hdnChildCount" runat="server" />
                                    <asp:HiddenField ID="hdnNewChildCount" runat="server" />
                                </td>
                            </tr>
                            <tr class="defaultfontcolor">
                                <td style="padding-left: 150px;">
                                    <asp:Label ID="Rs_Type" Text="Type:" runat="server" meta:resourcekey="Rs_TypeResource1"></asp:Label>
                                    <asp:DropDownList ID="ddlNewbornDetails" runat="server" Enabled="False" AutoPostBack="True" CssClass ="ddlmedium"
                                        OnSelectedIndexChanged="ddlNewbornDetails_SelectedIndexChanged" meta:resourcekey="ddlNewbornDetailsResource1">
                                        <asp:ListItem meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                                        <asp:ListItem meta:resourcekey="ListItemResource2">Edit Labour And Delivery Notes</asp:ListItem>
                                        <asp:ListItem meta:resourcekey="ListItemResource3">Add More Child</asp:ListItem>
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
                                    <table class="dataheaderInvCtrl" cellpadding="0" cellspacing="0" border="0" width="100%"
                                        id="tbl1" runat="server" style="padding-left: 5px;">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td style="width: 110px;">
                                                <asp:Label ID="Rs_HusbandName" Text="Husband Name" runat="server" meta:resourcekey="Rs_HusbandNameResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" ID="txtHusbandName" CssClass ="Txtboxsmall" meta:resourcekey="txtHusbandNameResource1"></asp:TextBox>
                                                <asp:HiddenField ID="hdnBirthRegID" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 110px;">
                                                <asp:Label ID="Rs_DeliveryType" Text="Delivery Type" runat="server" meta:resourcekey="Rs_DeliveryTypeResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList runat="server" ID="ddlTOL"  CssClass ="ddlsmall" meta:resourcekey="ddlTOLResource1">
                                                </asp:DropDownList>
                                                <asp:DropDownList runat="server" ID="ddlMOD" CssClass ="ddlsmall" meta:resourcekey="ddlMODResource1">
                                                </asp:DropDownList>
                                                <asp:DropDownList runat="server" ID="ddlDS"  CssClass ="ddlsmall" meta:resourcekey="ddlDSResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_ProcedureType" Text="Procedure Type" runat="server" meta:resourcekey="Rs_ProcedureTypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlProcedureType" CssClass ="ddlsmall" meta:resourcekey="ddlProcedureTypeResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_AnesthesiaType" Text="Anesthesia Type" runat="server" meta:resourcekey="Rs_AnesthesiaTypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAnesthesiaType" runat="server"  CssClass ="ddlsmall" meta:resourcekey="ddlAnesthesiaTypeResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_LabourTmax" Text="Labour Tmax" runat="server" meta:resourcekey="Rs_LabourTmaxResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtLhours" Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"   CssClass ="Txtboxverysmall"
                                                    meta:resourcekey="txtLhoursResource1"></asp:TextBox>
                                                <asp:Label ID="Rs_hours" Text="hours" runat="server" meta:resourcekey="Rs_hoursResource1"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtLmin" Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"   CssClass ="Txtboxverysmall"
                                                    meta:resourcekey="txtLminResource1"></asp:TextBox>
                                                <asp:Label ID="min" Text="min" runat="server" meta:resourcekey="minResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_ROMLength" Text="ROM Length" runat="server" meta:resourcekey="Rs_ROMLengthResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtRomhours" Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"   CssClass ="Txtboxverysmall"
                                                    meta:resourcekey="txtRomhoursResource1"></asp:TextBox>
                                                <asp:Label ID="Rs_hours1" Text="hours" runat="server" meta:resourcekey="Rs_hours1Resource1"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtRommin" Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"   CssClass ="Txtboxverysmall"
                                                    meta:resourcekey="txtRomminResource1"></asp:TextBox>
                                                <asp:Label ID="Rs_min" Text="min" runat="server" meta:resourcekey="Rs_minResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_DeliveryTerm" Text="Delivery Term" runat="server" meta:resourcekey="Rs_DeliveryTermResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlDeliveryTerm" runat="server"  CssClass ="ddl" meta:resourcekey="ddlDeliveryTermResource1">
                                                    <asp:ListItem meta:resourcekey="ListItemResource4">Term</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource5">Pre-Term</asp:ListItem>
                                                    <asp:ListItem meta:resourcekey="ListItemResource6">Post-Term</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;&nbsp;
                                                <asp:TextBox runat="server" ID="txtWeeks" Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"   CssClass ="Txtboxsmall"
                                                    meta:resourcekey="txtWeeksResource1"></asp:TextBox>
                                                <asp:Label ID="Rs_Weeks" Text="Weeks" runat="server" meta:resourcekey="Rs_WeeksResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <table class="dataheaderInvCtrl" border="0" width="100%">
                                                <tr class="defaultfontcolor">
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="defaultfontcolor">
                                                    <td>
                                                        <asp:Label ID="Rs_noofgenerations" Text="no of generations" runat="server" meta:resourcekey="Rs_noofgenerationsResource1"></asp:Label>
                                                        <asp:DropDownList ID="ddlGenerationType" runat="server" AutoPostBack="True" CssClass="ddlsmall"  OnSelectedIndexChanged="ddlGenerationType_SelectedIndexChanged"
                                                            meta:resourcekey="ddlGenerationTypeResource1">
                                                            <asp:ListItem meta:resourcekey="ListItemResource7">--Select--</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource8">1</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource9">2</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource10">3</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource11">4</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource12">5</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hdnChkValues" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr class="defaultfontcolor">
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight: normal; color: #000;">
                                                        <asp:GridView ID="gvNewBornDetails" runat="server" AutoGenerateColumns="False" Width="100%"
                                                            OnRowDataBound="gvNewBornDetails_RowDataBound" meta:resourcekey="gvNewBornDetailsResource1">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                        <asp:TextBox ID="txtNewBornDetailID" runat="server" Text='<%# Bind("NewBornDetailID") %>'
                                                                            Visible="False" meta:resourcekey="txtNewBornDetailIDResource1"></asp:TextBox>
                                                                        <asp:TextBox ID="txtPatientID" runat="server" Text='<%# Bind("PatientID") %>' Visible="False"
                                                                            meta:resourcekey="txtPatientIDResource1"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="DOB" meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox runat="server" ID="txtDob" MaxLength="25" Text='<%# Bind("DOB") %>'
                                                                            Width="90px" meta:resourcekey="txtDobResource1"></asp:TextBox>
                                                                        <asp:LinkButton ID="lbtnDOB" runat="server" meta:resourcekey="lbtnDOBResource1"><img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a><img src="../Images/starbutton.png"  alt=""  align="middle" /></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Gender" meta:resourcekey="TemplateFieldResource3">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="ddlGender" runat="server" Width="60px" meta:resourcekey="ddlGenderResource1">
                                                                            <asp:ListItem meta:resourcekey="ListItemResource13">Male</asp:ListItem>
                                                                            <asp:ListItem meta:resourcekey="ListItemResource14">Female</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:TextBox ID="txtSex" runat="server" Text='<%# Bind("Sex") %>' Visible="False"
                                                                            meta:resourcekey="txtSexResource1"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Presentation" meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="ddlPresentation" runat="server" Width="70px" meta:resourcekey="ddlPresentationResource1">
                                                                        </asp:DropDownList>
                                                                        <asp:TextBox ID="txtPresentationID" runat="server" Text='<%# Bind("PresentationID") %>'
                                                                            Visible="False" meta:resourcekey="txtPresentationIDResource1"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Birth wt" meta:resourcekey="TemplateFieldResource5">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtBirthWeight" runat="server" Text='<%# Bind("BirthWeight") %>'
                                                                            Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtBirthWeightResource1"></asp:TextBox>kg
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Head circ" meta:resourcekey="TemplateFieldResource6">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtHeadCIRC" Wrap="False" runat="server" Text='<%# Bind("HeadCIRC") %>'
                                                                            Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtHeadCIRCResource1"></asp:TextBox>cm
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="CHL" meta:resourcekey="TemplateFieldResource7">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtCHL" runat="server" Text='<%# Bind("CHL") %>' Width="40px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                            meta:resourcekey="txtCHLResource1"></asp:TextBox>
                                                                        <asp:Label ID="Rs_cm" Text="cm" runat="server" meta:resourcekey="Rs_cmResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource8">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="ddlStatus" runat="server" Width="70px" onchange="javascript:ShowAPGAR(this.id);"
                                                                            meta:resourcekey="ddlStatusResource1">
                                                                            <asp:ListItem Value="1" Text="Live born" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="Still born" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:TextBox ID="txtStatus" runat="server" Text='<%# Bind("Status") %>' Visible="False"
                                                                            meta:resourcekey="txtStatusResource1"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="APGAR Score" meta:resourcekey="TemplateFieldResource9">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtAPGARScore" runat="server" Text='<%# Bind("APGARScore") %>' Visible="False"
                                                                            meta:resourcekey="txtAPGARScoreResource1"></asp:TextBox>
                                                                        <asp:TextBox ID="txtOnemin" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                            meta:resourcekey="txtOneminResource1"></asp:TextBox>
                                                                        <asp:Label ID="Rs_at1min" Text="at 1 min" runat="server" meta:resourcekey="Rs_at1minResource1"></asp:Label>
                                                                        <asp:TextBox ID="txtfiveMin" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                            meta:resourcekey="txtfiveMinResource1"></asp:TextBox>
                                                                        <asp:Label ID="Rs_at5min" Text="at 5 min" runat="server" meta:resourcekey="Rs_at5minResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Identification1" meta:resourcekey="TemplateFieldResource10">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtIdentiFicationMarks1" runat="server" Text='<%# Bind("IdentiFicationMarks1") %>'
                                                                            Width="80px" meta:resourcekey="txtIdentiFicationMarks1Resource1"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Identification2" meta:resourcekey="TemplateFieldResource11">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtIdentiFicationMarks2" runat="server" Text='<%# Bind("IdentiFicationMarks2") %>'
                                                                            Width="80px" meta:resourcekey="txtIdentiFicationMarks2Resource1"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                        <%--   <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlGenerationType" EventName="SelectedIndexChanged" />
                                            </Triggers>--%>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                        <table class="dataheaderInvCtrl" border="0" width="100%" id="tbl3" runat="server">
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:Label ID="Rs_DeliveringObstretician" Text="Delivering Obstretician" runat="server"
                                                    meta:resourcekey="Rs_DeliveringObstreticianResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)" CssClass="Txtboxsmall"
                                                    onblur="AddPhysician()" meta:resourcekey="txtNewResource1" />
                                                <asp:DropDownList ID="ddlDelObstretician" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlDelObstreticianResource1">
                                                </asp:DropDownList>
                                                <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                                                    WatermarkText="Type Physician Name" Enabled="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:Label ID="Rs_Neonatologist" Text="Neonatologist" runat="server" meta:resourcekey="Rs_NeonatologistResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtNew1" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems1(this.value)" CssClass ="Txtboxsmall"
                                                    onblur="AddPhysician1()" meta:resourcekey="txtNew1Resource1" />
                                                <ajc:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtNew1"
                                                    WatermarkText="Type Physician Name" Enabled="True" />
                                                <asp:DropDownList ID="ddlNeonatologist" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlNeonatologistResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr class="defaultfontcolor">
                                            <td>
                                                <asp:Label ID="Rs_DeliveryNotes" Text="Delivery Notes" runat="server" meta:resourcekey="Rs_DeliveryNotesResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <%-- <asp:TextBox ID="txtdeliveryNotes" runat="server" TextMode="MultiLine"></asp:TextBox>--%>
                                                <FCKeditorV2:FCKeditor ID="fckdeliveryNotes" runat="server" Height="200px" Width="100%">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <%--<table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%"
                                id="tbl4" runat="server">
                                <tr class="defaultfontcolor">
                                    <td style="width: 119px;">
                                        Complication
                                    </td>
                                    <td align="left">
                                        <asp:TextBox runat="server" ID="txtComplication" Style="width: 150px;" autocomplete="off"></asp:TextBox>
                                        <asp:Button ID="btnaddComplication" OnClientClick="javascript:return onClickAddComplicationItems();"
                                            runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" />
                                        <input type="hidden" id="hdnComplicationItems" runat="server" />
                                    </td>
                                </tr>
                                <tr valign="top" class="defaultfontcolor">
                                    <td valign="top" style="width: 119px;">
                                        <table id="tblComplicationItems" runat="server" cellpadding="4" cellspacing="0" border="0"
                                            width="50%">
                                        </table>
                                    </td>
                                </tr>
                            </table>--%>
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%"
                            id="tbl4" runat="server">
                            <tr class="defaultfontcolor">
                                <td valign="top">
                                    <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%"
                            id="tbl5" runat="server">
                            <tr class="defaultfontcolor">
                                <td style="width: 119px;">
                                    <asp:Label ID="Rs_Instruction" Text="Instruction" runat="server" meta:resourcekey="Rs_InstructionResource1"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="txtIns" Style="width: 150px;" autocomplete="off" CssClass ="Txtboxsmall"
                                        meta:resourcekey="txtInsResource1" ></asp:TextBox>
                                    <asp:Button ID="btnIns" OnClientClick="javascript:return onClickAddInsItems();" runat="server"
                                        Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        meta:resourcekey="btnInsResource1" />
                                    <input type="hidden" id="hdnInsItems" runat="server" />
                                </td>
                            </tr>
                            <tr valign="top" class="defaultfontcolor">
                                <td valign="top">
                                    <table id="tblInsItems" runat="server" cellpadding="4" cellspacing="0" border="0"
                                        width="50%">
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnFinish" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnFinish_Click" OnClientClick="javascript:return checkForValues();"
                                        meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        //LoadDiagnosisItems();
        LoadInsItems();
       
    </script>

</body>
</html>
