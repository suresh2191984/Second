<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCommunication.aspx.cs"
    Inherits="Broadcast_ViewCommunication" EnableEventValidation="false" %>

<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/ViewCommunication.ascx" TagName="ViewComm" TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Communication</title>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script type="text/javascript" src="../Scripts/CallBack.js"></script>

    <style type="text/css">
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
    </style>

    <script type="text/javascript">
        var oldgridcolor;
        function SetMouseOver(element) {
            oldgridcolor = element.style.backgroundColor;
            element.style.backgroundColor = '#F0F0F0';
        }
        function SetMouseOut(element) {
            element.style.backgroundColor = oldgridcolor;
            element.style.textDecoration = 'none';

        }

        function validateForm1() {
            var dateEntered = document.getElementById('txtFDate1').value;
            var date1 = dateEntered.substring(0, 2);
            var month1 = dateEntered.substring(3, 5);
            var year1 = dateEntered.substring(6, 10);
            var dateToCompare1 = new Date(year1, month1 - 1, date1);
            var currentDate = new Date();
            var date2 = currentDate.getDate();
            var month2 = currentDate.getMonth() + 1;
            var year2 = currentDate.getFullYear();
            var dateToCompare2 = new Date(year2, month2 - 1, date2);
            var w = document.getElementById('txtFDate1').value;
            var y = document.getElementById('txtSubject').value;
            var z;
            if (FCKeditorAPI.GetInstance('FCKeditor1') != null)
                z = FCKeditorAPI.GetInstance('FCKeditor1').GetHTML();

            var chk = document.getElementById('chkBroadcastTo');
            var checkbox = chk.getElementsByTagName("input");
            var atLeast = 1;
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }
            if ($('#chkVisitNum').is(':checked')) {
                if ($('#txtVisitNum').val() == "") {
                    alert('Please verify the visit number');
                    document.getElementById("txtVisitNum").focus();
                    return false;
                }
                if ($('#trVisitDetails').html() == "") {
                    alert('Please verify the visit number');
                    document.getElementById("txtVisitNum").focus();
                    return false;
                }
            }
            //            if (atLeast > counter) {
            //                alert("Please select atleast " + atLeast + " item(s) in the Checkboxlist");
            //                return false;
            //            }

            if (w == null || w == "") {
                alert("Date should be selected");
                return false;
            }

            if (dateToCompare1 >= dateToCompare2) {
                return true;
            }
            else {
                alert("Date should not be lesser than current date");
                return false;
            }
            if (document.getElementById('ddlBroadcastedby').selectedIndex == 0) {
                alert("Please select ddl");
                return false;
            }
            if (y == null || y == "") {
                alert("Subject should be filled");
                return false;
            }
            if (z == null || z == "") {
                alert("Message should be filled");
                return false;
            }


        }

        function hideNCdiv() {
            document.getElementById('NewCommunication').style.display = "none";
        }

        function hideNBdiv() {
            document.getElementById('NoticeBoard').style.display = "none";
        }

        function showNCdiv() {
            document.getElementById('NewCommunication').style.display = "block";
            document.getElementById('NoticeBoard').style.display = "none";
            document.getElementById('tdShowMessage').style.display = "none";

        }

        function showNBdiv() {
            document.getElementById('NewCommunication').style.display = "none";
            document.getElementById('NoticeBoard').style.display = "block";
            document.getElementById('tdShowMessage').style.display = "none";
        }

        function checkAllBItem(obj1) {
            var checkboxCollection = document.getElementById('chkBroadcastTo').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function checkAllNBItem(obj1) {
            var checkboxCollection = document.getElementById('chkDomain').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function validateForm2() {
            var dateEntered = document.getElementById("txtFDate").value;
            var date1 = dateEntered.substring(0, 2);
            var month1 = dateEntered.substring(3, 5);
            var year1 = dateEntered.substring(6, 10);
            var dateToCompare1 = new Date(year1, month1 - 1, date1);
            var currentDate = new Date();
            var date2 = currentDate.getDate();
            var month2 = currentDate.getMonth() + 1;
            var year2 = currentDate.getFullYear();
            var dateToCompare2 = new Date(year2, month2 - 1, date2);
            var x = FCKeditorAPI.GetInstance("FCKeditor2").GetHTML();
            var y = document.getElementById("txtFDate").value;
            var z = document.getElementById('txtNBSubject').value;
            var chk = document.getElementById('chkDomain');
            var checkbox = chk.getElementsByTagName("input");
            var atLeast = 1;
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }
            if ($('#chkNBVisitNum').is(':checked')) {
                if ($('#txtNBVisitNum').val() == "") {
                    alert('Please verify the visit number');
                    document.getElementById("txtNBVisitNum.ClientID %>").focus();
                    return false;
                }
                if ($('#trNBVisitDetails').html() == "") {
                    alert('Please verify the visit number');
                    document.getElementById("txtNBVisitNum").focus();
                    return false;
                }
            }
            //            if (atLeast > counter) {
            //                alert("Please select atleast " + atLeast + " item(s) in the Checkboxlist");
            //                return false;
            //            }            
            if (x == null || x == "") {
                alert("Message should be filled");
                return false;
            }
            if (y == null || y == "") {
                alert("Date should be filled");
                return false;
            }
            if (z == null || z == "") {
                alert("Subject should be filled");
                return false;
            }
            if (dateToCompare1 >= dateToCompare2) {
                return true;
            }
            else {
                alert("Date should not be lesser than current date");
                return false;
            }
        }  
    </script>

</head>
<body>
    <form id="form2" runat="server">
    <div id="wrapper">
        <div id="header">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
                <Services>
                    <asp:ServiceReference Path="~/WebService.asmx" />
                </Services>
            </asp:ScriptManager>
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="../Images/Logo/Thyrocare.png" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc6:Header ID="Header1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="contentdata1">
                                <ul>
                                    <li>
                                        <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <table width="100%">
                                    <tr id="trNewNBComm" runat="server" style="display: block">
                                        <td>
                                            <input type="button" id="btnNewCommunciation" runat="server" width="10px" value=" New Communciation "
                                                onclick="javascript:showNCdiv();" class="btnCompose" style="cursor: pointer" />
                                            &nbsp;
                                            <input type="button" id="btnNoticeBoard" runat="server" width="10px" value=" New Notice "
                                                onclick="javascript:showNBdiv();" class="btnCompose" style="cursor: pointer" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="tdShowMessage" runat="server" style="display: block;">
                                            <asp:Label ID="lblShowMessage" runat="server" Font-Bold="true" Font-Size="11px" ForeColor="Green"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <uc7:ViewComm ID="ViewComm1" runat="server" />
                                        </td>
                                    </tr>
                                </table>

                                <script type="text/javascript" language="javascript">

                                    function AddItemInList(fromLeftToRight, isAll, list1, list2, roleLst, hdnRecList) {

                                        //var list1 = document.getElementById('<%= lstBXUsersComm.ClientID %>');

                                        //var list2 = document.getElementById('<%= lstBXRecipientlistComm.ClientID %>');

                                        if (Boolean(fromLeftToRight) == true) {

                                            MoveItems(list1, list2, isAll, roleLst, hdnRecList);

                                        }

                                        else {

                                            MoveItems(list2, list1, isAll, roleLst, hdnRecList);

                                        }
                                        // alert(hdnRecList.value);
                                        return false;

                                    }



                                    function MoveItems(listFrom, listTo, isAll, roleLst, hdnRecList) {

                                        var toBeRemoved = "";

                                        if (listFrom.options.length > 0) {

                                            for (i = 0; i < listFrom.length; i++) {

                                                if (listFrom.options[i].selected || (isAll == true)) {

                                                    if (Exist(listTo, listFrom.options[i].value, roleLst.options[roleLst.selectedIndex].text + "-" + listFrom.options[i].text) == 0) {

                                                        listTo[listTo.length] = new Option(roleLst.options[roleLst.selectedIndex].text + "-" + listFrom.options[i].text, listFrom.options[i].value, true);
                                                        //alert(listTo[listTo.length].options[i].value);
                                                        if (hdnRecList.value.trim() != "") {
                                                            hdnRecList.value = hdnRecList.value + "|" + roleLst.options[roleLst.selectedIndex].text + "-" + listFrom.options[i].text + "~" + listFrom.options[i].value + "~" + roleLst.options[roleLst.selectedIndex].value;
                                                        }
                                                        else {
                                                            hdnRecList.value = roleLst.options[roleLst.selectedIndex].text + "-" + listFrom.options[i].text + "~" + listFrom.options[i].value + "~" + roleLst.options[roleLst.selectedIndex].value;
                                                        }
                                                        toBeRemoved = toBeRemoved + listFrom.options[i].value + ',';

                                                    }

                                                }

                                            }
                                            //           for (i = 0; i < listTo.length; i++) {
                                            //               alert(listTo.options[i].text + "," + listTo.options[i].value);
                                            //           }
                                            ClearSelection(listTo);

                                            RemoveFromList(listFrom, toBeRemoved);

                                        }

                                        else {

                                            alert('Unable to Move Items. List is Empty!');

                                        }

                                    }
                                    function RemoveFromList(listFrom, items) {

                                        var toBeRemoved = items.split(',');

                                        for (var i = 0; i < toBeRemoved.length; i++) {

                                            for (var j = 0; j < listFrom.length; j++) {

                                                if (listFrom.options[j] != null && listFrom.options[j].value == toBeRemoved[i]) {

                                                    listFrom.options[j] = null;

                                                }

                                            }

                                        }

                                    }

                                    function ClearSelection(list) {

                                        list.selectedIndex = -1;

                                    }

                                    function Exist(list, value, txt) {

                                        var flag = 0;

                                        for (var i = 0; i < list.length; i++) {
                                            //  alert(list.options[i].value+"-"+ value);
                                            // if (list.options[i].value == value) {
                                            if ((list.options[i].value + list.options[i].text) == (value + txt)) {

                                                flag = 1;

                                                break;

                                            }

                                        }

                                        return flag;

                                    }






                                    function deleteValue(id, roleLst, hdnRecList, lstFromName) {
                                        var s = 1;
                                        var Index;


                                        var check = hdnRecList.value;
                                        if (id.selectedIndex == -1) {
                                            alert("Please select any item from the ListBox");
                                            return true;
                                        }
                                        var lstBXRecipientlistComm1 = document.getElementById("<%=lstBXRecipientlistComm.ClientID %>");
                                        while (s > 0) {
                                            Index = id.selectedIndex;
                                            var listadd = hdnRecList.value.split('|');
                                            if (Index >= 0) {
                                                var listdetails = listadd[Index].split('-')
                                                lstFromName[lstFromName.length] = new Option(listdetails[1].split('~')[0], listdetails[1].split('~')[1], true);

                                                id.options[Index] = null;
                                                --i;
                                            }
                                            else
                                                s = 0;
                                        }

                                        hdnRecList.value = "";
                                        for (i = 0; i < id.length; i++) {
                                            if (hdnRecList.value.trim() != "") {
                                                hdnRecList.value = hdnRecList.value + "|" + roleLst.options[roleLst.selectedIndex].text + "-" + id.options[i].text + "~" + id.options[i].value + "~" + roleLst.options[roleLst.selectedIndex].value;
                                            }
                                            else {
                                                //alert(id.options[i].text + "~" + id.options[i].value);
                                                hdnRecList.value = roleLst.options[roleLst.selectedIndex].text + "-" + id.options[i].text + "~" + id.options[i].value + "~" + roleLst.options[roleLst.selectedIndex].value;
                                            }
                                        }

                                        //alert(hdnRecList.value);
                                        return true;
                                    }

                                    function clearLoadRecipientList() {
                                        if (document.getElementById('<%=hdnRecipientListComm.ClientID %>').value.trim() != "") {
                                            var list1 = document.getElementById('<%=lstBXRecipientlistComm.ClientID %>');
                                            var toBeAdded = document.getElementById('<%=hdnRecipientListComm.ClientID %>').value.split('|');
                                            for (var i = 0; i < toBeAdded.length; i++) {
                                                var str = toBeAdded[i].split('~');
                                                list1[list1.length] = new Option(str[0], str[1], true);
                                            }
                                            //listTo[listTo.length] = new Option(listFrom.options[i].text, listFrom.options[i].value, true);
                                        }
                                    }

                                    function clearLoadRecipientListNB() {
                                        if (document.getElementById('<%=hdnRecipientListNB.ClientID %>').value.trim() != "") {
                                            var list1 = document.getElementById('<%=lstBXRecipientlistNB.ClientID %>');
                                            var toBeAdded = document.getElementById('<%=hdnRecipientListNB.ClientID %>').value.split('|');
                                            for (var i = 0; i < toBeAdded.length; i++) {
                                                var str = toBeAdded[i].split('~');
                                                list1[list1.length] = new Option(str[0], str[1], true);
                                            }
                                            //listTo[listTo.length] = new Option(listFrom.options[i].text, listFrom.options[i].value, true);
                                        }
                                    }

                                    function rolesFocus(x) {
                                        var lst = document.getElementById(x);
                                        if (lst && lst.selectedIndex - 1) {
                                            lst.focus();
                                            lst.selectedIndex = lst.selectedIndex;
                                        }
                                    }
                                 
                                </script>

                                <div id="NewCommunication" runat="server" style="display: none">
                                    <table width="70%" class="dataheader3" border="0" cellpadding="2" cellspacing="0">
                                        <tr style="display: none;">
                                            <td>
                                                <asp:Label ID="lblBroadcastedby" runat="server" Text="Sent By:" align="left"></asp:Label>
                                            </td>
                                            <td colspan="2">
                                                <asp:DropDownList ID="ddlBroadcastedby" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="left">
                                                <h3>
                                                    New Communication :
                                                </h3>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="colorforcontent" style="width: 30%;" height="23" align="left">
                                                <div id="ACX2plus1" style="display: none;">
                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                        style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                        &nbsp;<asp:Label ID="Rs_FilterResult1" runat="server" Text="Send To"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minus1" style="display: block;">
                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                        style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                        &nbsp<asp:Label ID="Rs_FilterResult2" runat="server" Text="Send To"></asp:Label></span>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <img id="imgReplyDivClose" runat="server" src="../Images/close_button.gif" width="20"
                                                    height="20" alt="show" align="middle" style="cursor: pointer" onclick="javascript:hideNCdiv();" />
                                            </td>
                                        </tr>
                                        <tr id="ACX2responses1" style="display: block;">
                                            <td colspan="3" style="background-color: #f7f7f7;">
                                                <table>
                                                    <tr>
                                                        <td style="font-weight: bold;">
                                                            Role:
                                                        </td>
                                                        <td style="font-weight: bold;">
                                                            Name:
                                                        </td>
                                                        <td style="font-weight: bold;">
                                                            Recipient List:&nbsp;&nbsp;&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:ListBox ID="ddlRolesComm" Width="250px" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRolesComm_SelectedIndexChanged">
                                                            </asp:ListBox>
                                                            <asp:HiddenField ID="hdnRecipientListComm" runat="server" />
                                                            <asp:HiddenField ID="hdnRoleIDComm" runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:ListBox ID="lstBXUsersComm" SelectionMode="Multiple" Width="300px" runat="server"
                                                                ondblclick="return AddItemInList(true,false,this.form.lstBXUsersComm,this.form.lstBXRecipientlistComm, this.form.ddlRolesComm, this.form.hdnRecipientListComm);">
                                                            </asp:ListBox>
                                                        </td>
                                                        <td>
                                                            <asp:ListBox ID="lstBXRecipientlistComm" SelectionMode="Multiple" Width="300px" runat="server"
                                                                ondblclick="deleteValue(this.form.lstBXRecipientlistComm,this.form.ddlRolesComm, this.form.hdnRecipientListComm,this.form.lstBXUsersComm);">
                                                            </asp:ListBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            [ Double Click to Add Recipient ] /
                                                            <input type="button" onclick="return AddItemInList(true,false,this.form.lstBXUsersComm,this.form.lstBXRecipientlistComm, this.form.ddlRolesComm, this.form.hdnRecipientListComm);"
                                                                value="Add >>">
                                                        </td>
                                                        <td>
                                                            [ Double Click to Remove Recipient ] /
                                                            <input type="button" name="delete" value="Remove" onclick="deleteValue(this.form.lstBXRecipientlistComm,this.form.ddlRolesComm, this.form.hdnRecipientListComm,this.form.lstBXUsersComm);" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" align="left">
                                                            <asp:CheckBox ID="chkVisitNum" runat="server" Text="Join with Visit Number" onclick="javascript:return ChkVisitNumbercheck()" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trVisitNum" style="display: none">
                                                        <td colspan="3" align="left">
                                                            <table width="40%">
                                                                <tr>
                                                                    <td>
                                                                        Visit Number
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtVisitNum" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="btnVerify" value="Verify" onclick="javascript:return GetVistDetails();" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <div id="trVisitDetails">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <style>
                                                    #tblborder
                                                    {
                                                        border-collapse: collapse;
                                                    }
                                                    #tblborder td
                                                    {
                                                        border: 1px solid black;
                                                        text-align: left;
                                                        height: 20px;
                                                        padding-left: 5px;
                                                    }
                                                    #tblborder th
                                                    {
                                                        border: 1px solid black;
                                                        text-align: center;
                                                        font-weight: bold;
                                                        height: 20px;
                                                    }
                                                </style>

                                                <script type="text/javascript">
                                                    function ChkVisitNumbercheck() {

                                                        if ($('#<%=chkVisitNum.ClientID %>').is(':checked')) {
                                                            document.getElementById('trVisitNum').style.display = 'block';
                                                            $('#<%=txtVisitNum.ClientID %>').val("");
                                                            $('#trVisitDetails').html("");
                                                        }
                                                        else {
                                                            document.getElementById('trVisitNum').style.display = 'none';
                                                            $('#<%=txtVisitNum.ClientID %>').val("");
                                                            $('#trVisitDetails').html("");
                                                        }
                                                    }
                                                    function GetVistDetails() {
                                                        document.getElementById('trVisitNum').style.display = 'block';
                                                        var orgid = 1;
                                                        var VisitNum = $('#<%=txtVisitNum.ClientID %>').val();
                                                        if (VisitNum.trim() != '') {
                                                            $.ajax({
                                                                type: "POST",
                                                                url: "../WebService.asmx/GetVisitNumber",
                                                                data: "{ 'VisitNumber': '" + VisitNum + "'}",
                                                                contentType: "application/json; charset=utf-8",
                                                                dataType: "json",
                                                                async: true,
                                                                success: function(data) {

                                                                    var Items = data.d;
                                                                    if (Items.length == 0) {
                                                                        $('#trVisitDetails').html("");
                                                                        alert("Please enter correct visit number")
                                                                    }
                                                                    else {
                                                                        BindFoodList(Items);
                                                                    }
                                                                },
                                                                failure: function(msg) {
                                                                    alert('error');
                                                                }
                                                            });
                                                        }
                                                    }
                                                    function BindFoodList(Items) {

                                                        $.each(Items, function(index, Item) {
                                                            var tblrow = "<td colspan='3'><table width='300px' id='tblborder'><tr><th>Name</th><th>Age</th><th>Gender</th></tr><tr><td>" + Item.Name + "</td><td>" + Item.Age + "</td><td>" + Item.Gender + "</td></tr></table></td>"
                                                            $('#trVisitDetails').html(tblrow);
                                                        });
                                                    }
                                                </script>

                                                <script type="text/javascript">
                                                    function ChkNBVisitNumbercheck() {

                                                        if ($('#<%=chkNBVisitNum.ClientID %>').is(':checked')) {
                                                            document.getElementById('trNBVisitNum').style.display = 'block';
                                                            $('#<%=txtNBVisitNum.ClientID %>').val("");
                                                            $('#trNBVisitDetails').html("");
                                                        }
                                                        else {
                                                            document.getElementById('trNBVisitNum').style.display = 'none';
                                                            $('#<%=txtNBVisitNum.ClientID %>').val("");
                                                            $('#trNBVisitDetails').html("");
                                                        }
                                                    }
                                                    function NBGetVistDetails() {
                                                        document.getElementById('trNBVisitNum').style.display = 'block';
                                                        var orgid = 1;
                                                        var VisitNum = $('#<%=txtNBVisitNum.ClientID %>').val();
                                                        if (VisitNum.trim() != '') {
                                                            $.ajax({
                                                                type: "POST",
                                                                url: "../WebService.asmx/GetVisitNumber",
                                                                data: "{ 'VisitNumber': '" + VisitNum + "'}",
                                                                contentType: "application/json; charset=utf-8",
                                                                dataType: "json",
                                                                async: true,
                                                                success: function(data) {

                                                                    var Items = data.d;
                                                                    if (Items.length == 0) {
                                                                        $('#trVisitDetails').html("");
                                                                        alert("Please enter correct visit number")
                                                                    }
                                                                    else {
                                                                        BindFoodListNB(Items);
                                                                    }
                                                                },
                                                                failure: function(msg) {
                                                                    alert('error');
                                                                }
                                                            });
                                                        }
                                                    }
                                                    function BindFoodListNB(Items) {

                                                        $.each(Items, function(index, Item) {
                                                            var tblrow = "<td colspan='3'><table width='300px' id='tblborder'><tr><th>Name</th><th>Age</th><th>Gender</th></tr><tr><td>" + Item.Name + "</td><td>" + Item.Age + "</td><td>" + Item.Gender + "</td></tr></table></td>"
                                                            $('#trNBVisitDetails').html(tblrow);
                                                        });
                                                    }
                                                </script>

                                                <asp:Panel ID="Panel1" runat="server" Style="display: none;" GroupingText="Send To"
                                                    Width="100%">
                                                    <asp:CheckBox ID="chkAll" runat="server" onclick="checkAllBItem(this);" Text="Select all"
                                                        Font-Bold="true" />
                                                    <asp:CheckBoxList ID="chkBroadcastTo" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                                                    </asp:CheckBoxList>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSubject" runat="server" Text="Subject:" align="left" Width="20%"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSubject" runat="server" Width="70%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblBroadcast" runat="server" Text="Message:" align="left" Width="20%"></asp:Label>
                                            </td>
                                            <td>
                                                <FCKeditorV2:FCKeditor ID="FCKeditor1" runat="server" Width="750px" Height="200px">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table width="70%" border="0" cellpadding="4" cellspacing="0">
                                                    <tr>
                                                        <td class="style2">
                                                            <asp:Label ID="lblValidity1" runat="server" Text="Expires on <br>[Valid Till To Display]:"
                                                                align="left"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtFDate1" CssClass="ddlsmall" runat="server" meta:resourcekey="txtFDateResource1"
                                                                Width="50%"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate1"
                                                                PopupButtonID="ImgFDate1" Enabled="True" />
                                                            <asp:ImageButton ID="ImgFDate1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <table width="100%" border="0" cellpadding="4" cellspacing="0">
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Button ID="btnBroadcastSubmit" runat="server" Text=" Post " CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            OnClientClick="javascript:return validateForm1();" onmouseout="this.className='btn'"
                                                                            meta:resourcekey="btnChangeResource2" OnClick="btnBroadcastSubmit_Click" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="NoticeBoard" runat="server" style="display: none;">
                                    <table width="70%" class="dataheader3" border="0" cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td align="left">
                                                <h3>
                                                    New Notice :
                                                </h3>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="background-color: #f7f7f7" cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <td colspan="2" class="colorforcontent" style="width: 30%;" height="23" align="left">
                                                            <div id="ACX2plus11" style="display: none;">
                                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                    style="cursor: pointer" onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',1);" />
                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',1);">
                                                                    &nbsp;<asp:Label ID="Rs_FilterResult11" runat="server" Text="Send To"></asp:Label></span>
                                                            </div>
                                                            <div id="ACX2minus11" style="display: block;">
                                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                    style="cursor: pointer" onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',0);" />
                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus11','ACX2minus11','ACX2responses11',0);">
                                                                    &nbsp<asp:Label ID="Rs_FilterResult21" runat="server" Text="Send To"></asp:Label></span>
                                                            </div>
                                                        </td>
                                                        <td align="right">
                                                            <img id="img2" runat="server" src="../Images/close_button.gif" width="20" height="20"
                                                                alt="show" align="middle" style="cursor: pointer" onclick="javascript:hideNBdiv();" />
                                                        </td>
                                                    </tr>
                                                    <tr id="ACX2responses11" style="display: block;">
                                                        <td colspan="2">
                                                            <table>
                                                                <tr>
                                                                    <td style="font-weight: bold;">
                                                                        Role:
                                                                    </td>
                                                                    <td style="font-weight: bold;">
                                                                        Name:
                                                                    </td>
                                                                    <td style="font-weight: bold;">
                                                                        Recipient List:&nbsp;&nbsp;&nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:ListBox ID="ddlRolesNB" Width="250px" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRolesNB_SelectedIndexChanged">
                                                                        </asp:ListBox>
                                                                        <asp:HiddenField ID="hdnRecipientListNB" runat="server" />
                                                                        <asp:HiddenField ID="hdnRoleIDNB" runat="server" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:ListBox ID="lstBXUsersNB" SelectionMode="Multiple" Width="300px" runat="server"
                                                                            ondblclick="return AddItemInList(true,false,this.form.lstBXUsersNB,this.form.lstBXRecipientlistNB, this.form.ddlRolesNB, this.form.hdnRecipientListNB);">
                                                                        </asp:ListBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ListBox ID="lstBXRecipientlistNB" SelectionMode="Multiple" Width="300px" runat="server"
                                                                            ondblclick="deleteValue(this.form.lstBXRecipientlistNB,this.form.ddlRolesNB, this.form.hdnRecipientListNB,this.form.lstBXUsersNB);">
                                                                        </asp:ListBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td>
                                                                        [ Double Click to Add Recipient ] /
                                                                        <input type="button" onclick="return AddItemInList(true,false,this.form.lstBXUsersNB,this.form.lstBXRecipientlistNB, this.form.ddlRolesNB, this.form.hdnRecipientListNB);"
                                                                            value="Add >>">
                                                                    </td>
                                                                    <td>
                                                                        [ Double Click to Remove Recipient ] /
                                                                        <input type="button" name="delete" value="Remove" onclick="deleteValue(this.form.lstBXRecipientlistNB,this.form.ddlRolesNB, this.form.hdnRecipientListNB,this.form.lstBXUsersNB);" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:Panel ID="Panel3" runat="server" GroupingText="Notice To" Style="display: none;"
                                                                Width="100%">
                                                                <asp:CheckBox ID="chkCheckAll" runat="server" Checked="false" Font-Bold="true" onclick="checkAllNBItem(this);"
                                                                    Text="Select all" />
                                                                <asp:CheckBoxList ID="chkDomain" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                                                                </asp:CheckBoxList>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblAck" runat="server" align="left" Text=" Need to Acknowledge?"></asp:Label>
                                                                        <asp:RadioButton ID="rbACKYes" runat="server" Checked="true" GroupName="ACKYesNo"
                                                                            Text="Yes" />
                                                                        <asp:RadioButton ID="rbACKNo" runat="server" Checked="false" GroupName="ACKYesNo"
                                                                            Text="No" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblPriority" runat="server" Text=" Priority:"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlPriorityList" runat="server">
                                                                <asp:ListItem Value="0">Normal</asp:ListItem>
                                                                <asp:ListItem Value="1">Medium</asp:ListItem>
                                                                <asp:ListItem Value="2">High</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" align="left">
                                                            <asp:CheckBox ID="chkNBVisitNum" runat="server" Text="Join with Visit Number" onclick="javascript:return ChkNBVisitNumbercheck()" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trNBVisitNum" style="display: none">
                                                        <td colspan="3" align="left">
                                                            <table width="40%">
                                                                <tr>
                                                                    <td>
                                                                        Visit Number
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtNBVisitNum" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" id="btnNBVerify" value="Verify" onclick="javascript:return NBGetVistDetails();" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <div id="trNBVisitDetails">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 10px">
                                                <table cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblNBSubject" runat="server" Text=" Subject:"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtNBSubject" runat="server" Width="70%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblMessage" runat="server" align="left" Text=" Message:" Width="15%"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <FCKeditorV2:FCKeditor ID="FCKeditor2" runat="server" Height="200px" Width="750px">
                                                            </FCKeditorV2:FCKeditor>
                                                        </td>
                                                    </tr>
                                                    <tr id="trSMSBlock" style="display: none;">
                                                        <td colspan="2">
                                                            <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td style="width: 15%;">
                                                                        <asp:Label ID="Label1" runat="server" align="left" Text="Send SMS:" Width="80%"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 85%;">
                                                                        <asp:RadioButton ID="rbYes" runat="server" Checked="false" GroupName="YesNo" Text="Yes" />
                                                                        <asp:RadioButton ID="rbNo" runat="server" Checked="true" GroupName="YesNo" Text="No" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <table border="0" cellpadding="4" cellspacing="0" width="70%">
                                                                <tr>
                                                                    <td class="style2">
                                                                        <asp:Label ID="lblValidity" runat="server" align="left" Text="Expires on &lt;br&gt;[Valid Till To Display]:"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFDate" runat="server" CssClass="ddlsmall" meta:resourcekey="txtFDateResource1"
                                                                            Width="50%"></asp:TextBox>
                                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                                            PopupButtonID="ImgFDate" TargetControlID="txtFDate" />
                                                                        <asp:ImageButton ID="ImgFDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            meta:resourcekey="ImgFDateResource1" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button ID="btnNBSubmit" runat="server" CssClass="btn" meta:resourcekey="btnChangeResource2"
                                                                            OnClick="btnNBSubmit_Click" OnClientClick="javascript:return validateForm2()"
                                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text=" Post " />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:UpdateProgress ID="UpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                        <ProgressTemplate>
                            <div id="progressBackgroundFilter">
                            </div>
                            <div align="center" id="processMessage">
                                <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                <br />
                                <br />
                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnBankName" runat="server" />
    <asp:HiddenField ID="hdnBankID" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
