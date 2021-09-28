<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NonReimbursableMaster.aspx.cs"
    Inherits="Admin_NonReimbursableMaster" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Add NonReimbursable Items </title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc7:DocHeader ID="docHeader" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="pnl_Client" runat="server">
                            <ContentTemplate>
                                <table cellspacing="0" border="0" width="100%">
                                    <tr style="display: none;">
                                        <td>
                                            <asp:DropDownList ID="ddlType" onChange="javascript:return ShowDDl();" runat="server" CssClass="ddl"
                                                meta:resourcekey="ddlTypeResource1">
                                                <asp:ListItem Text="Select" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                <asp:ListItem Text="Client" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                <asp:ListItem Text="Insurance" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTpaName" Style="display: none" CssClass="ddl" runat="server" meta:resourcekey="ddlTpaNameResource1">
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="ddlCorporate" Style="display: none" CssClass="ddl" runat="server" meta:resourcekey="ddlCorporateResource1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-weight: bold;">
                                            <asp:Label ID="Rs_SelectNonReimbursableItemTypeToAdd" Text="Select NonReimbursable Item Type To Add"
                                                runat="server" meta:resourcekey="Rs_SelectNonReimbursableItemTypeToAddResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:RadioButtonList ID="rblFeeTypes" runat="server" RepeatDirection="Horizontal"
                                                RepeatColumns="10" onClick="Javascript:chkPros();" meta:resourcekey="rblFeeTypesResource1">
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="Rs_Description" Text="Description :" runat="server" meta:resourcekey="Rs_DescriptionResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <!-- ContextKey='<%# hdnFeeType1.Value.ToString() %>' -->
                                            <asp:TextBox ID="txtName" onkeyup="Javascript:chkPros();" CssClass="Txtboxlarge" runat="server"
                                                meta:resourcekey="txtNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtName"
                                                OnClientItemSelected="IAmSelected" EnableCaching="False" MinimumPrefixLength="1"
                                                CompletionInterval="0" FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                ServiceMethod="GetNonReimbursableItems" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                DelimiterCharacters="" Enabled="True">
                                            </ajc:AutoCompleteExtender>
                                            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClientClick="return addItems();" 
                                                CssClass="btn" meta:resourcekey="btnAddResource1"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table id="tblNRItems" class="dataheaderInvCtrl" runat="server" cellpadding="8" cellspacing="0"
                                                border="1" width="100%">
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validate();"
                                                OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID="hdnFeeType1" runat="server" />
        <asp:HiddenField ID="hdnFeeTypeSelected" runat="server" />
        <asp:HiddenField ID="hdnID" runat="server" />
        <asp:HiddenField ID="hdnNRItems" runat="server" />
        <asp:HiddenField ID="hdnSelectedText" runat="server" />
    </div>

    <script type="text/javascript">

        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else  {
                alert('NonReimbursableItems Added Sucessfully');
                return false;
            }
            return true;
        }

        function chkPros() {

            var RB1 = document.getElementById('<%=rblFeeTypes.ClientID%>');
            var radio = RB1.getElementsByTagName('input');
            var label = RB1.getElementsByTagName('label');
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked) {

                    document.getElementById('hdnFeeType1').value = radio[i].value;
                    document.getElementById('hdnSelectedText').value = label[i].innerHTML

                }
            }
            var orgID = '<%= OrgID %>';
            var sval = document.getElementById('hdnFeeType1').value;


            sval = sval + '~' + orgID;
            $find('AutoCompleteExtender3').set_contextKey(sval);
        }

        function IAmSelected(source, eventArgs) {
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());


            var id;
            var type;
            document.getElementById('hdnFeeTypeSelected').value = "";
            document.getElementById('hdnID').value = "";

            var lis = eventArgs.get_value().split('^');
            if (lis.length > 0) {
                for (i = 0; i < lis.length; i++) {
                    if (lis[i] != "") {
                        id = lis[0];
                        type = lis[1];
                        document.getElementById('hdnFeeTypeSelected').value = type;
                        document.getElementById('hdnID').value = id;

                    }
                }
            }
        }

        function ShowDDl() {

            var obj = document.getElementById('<%= ddlType.ClientID %>');

            if (obj.options[obj.selectedIndex].value == 1) {
                document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "block";
                document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
                document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
            }
            else if (obj.options[obj.selectedIndex].value == 2) {
                document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "block";
                document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
                document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
            }
            else {
                document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
                document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
                document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
                document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
            }
            return false;
        }


        function addItems() {

            if (document.getElementById('txtName').value == "") {

                var userMsg = SListForApplicationMessages.Get("Admin\\NonReimbursableMaster.aspx_1");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please enter non reimbursable items');
                    return false;
                }
                document.getElementById('txtName').focus();
                return false;
            }

            if (document.getElementById('hdnFeeTypeSelected').value == "") {

                var userMsg = SListForApplicationMessages.Get("Admin\\NonReimbursableMaster.aspx_2");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please enter avaialable items');
                    return false;
                }
                document.getElementById('txtName').value = "";
                document.getElementById('txtName').focus();
                return false;
            }
            if (document.getElementById('hdnID').value == "") {

                var userMsg = SListForApplicationMessages.Get("Admin\\NonReimbursableMaster.aspx_2");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please enter avaialable items');
                    return false;
                }
                document.getElementById('txtName').value = "";
                document.getElementById('txtName').focus();
                return false;
            }

            var FeeId = document.getElementById('hdnID').value;
            var FeeType = document.getElementById('hdnFeeTypeSelected').value;
            var NRItem = document.getElementById('txtName').value;
            var FeeDesc = document.getElementById('hdnSelectedText').value;
            var TpaType = "";
            var TpaID = "0";

            var rwNumber = parseInt(110);
            var AddStatus = 0;



            var HidValue = document.getElementById('hdnNRItems').value;
            var list = HidValue.split('^');
            document.getElementById('tblNRItems').style.display = 'block';

            if (document.getElementById('hdnNRItems').value != "") {

                for (var count = 0; count < list.length; count++) {
                    var NRList = list[count].split('~');
                    if (NRList[1] != '') {
                        if (NRList[0] != '') {
                            rwNumber = parseInt(parseInt(NRList[0]) + parseInt(1));
                        }
                        if (FeeId != '') {
                            if (NRList[2] == FeeType && NRList[3] == FeeId) {

                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (FeeId != '') {


                    if (document.getElementById('tblNRItems').rows.length < 1) {


                        var row = document.getElementById('tblNRItems').insertRow(0);
                        row.id = 0;
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);

                        cell1.innerHTML = "Delete";
                        cell1.width = "6%";
                        cell2.innerHTML = "Non Reimbursable Item";
                        cell3.innerHTML = "Description";

                    }
                    var row = document.getElementById('tblNRItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickNRItem(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = NRItem;
                    cell3.innerHTML = FeeDesc;
                    document.getElementById('hdnNRItems').value += parseInt(rwNumber) + "~" + NRItem + "~" + FeeType + "~" + FeeId + "~" + TpaType + "~" + TpaID + "~" + FeeDesc + "^";
                    AddStatus = 2;
                }
            }

            if (AddStatus == 0) {
                if (FeeId != '') {


                    if (document.getElementById('tblNRItems').rows.length < 1) {


                        var row = document.getElementById('tblNRItems').insertRow(0);
                        row.id = 0;
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);

                        cell1.innerHTML = "Delete";
                        cell1.width = "6%";
                        cell2.innerHTML = "Non Reimbursable Item";
                        cell3.innerHTML = "Description";

                    }
                    var row = document.getElementById('tblNRItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell3.innerHTML = FeeDesc;
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickNRItem(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = NRItem;

                    document.getElementById('hdnNRItems').value += parseInt(rwNumber) + "~" + NRItem + "~" + FeeType + "~" + FeeId + "~" + TpaType + "~" + TpaID + "~" + FeeDesc + "^";
                }
            }
            else if (AddStatus == 1) {

            var userMsg = SListForApplicationMessages.Get("Admin\\NonReimbursableMaster.aspx_4");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert("This Item Already Added!");
                return false;
            }
            }
            document.getElementById('txtName').value = "";
            document.getElementById('hdnFeeTypeSelected').value = "";
            document.getElementById('hdnID').value = "";
            return false;
        }
        function ImgOnclickNRItem(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnNRItems').value;
            var list = HidValue.split('^');
            var newNRList = "";
            if (document.getElementById('hdnNRItems').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var NRList = list[count].split('~');
                    if (NRList[0] != '') {
                        if (NRList[0] != ImgID) {
                            newNRList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnNRItems').value = newNRList;
            }
            if (document.getElementById('hdnNRItems').value == "") {
                document.getElementById('tblNRItems').style.display = 'none';
            }
        }
        function LoadNRItems() {
            var HidValue = document.getElementById('hdnNRItems').value;


            var list = HidValue.split('^');


            //            while (count = document.getElementById('hdnNRItems').rows.length) {

            //                for (var j = 0; j < document.getElementById('tblNRItems').rows.length; j++) {
            //                    document.getElementById('tblNRItems').deleteRow(j);

            //                }
            //            }

            if (document.getElementById('hdnNRItems').value != "") {


                var row = document.getElementById('tblNRItems').insertRow(0);
                row.id = 0;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);

                cell1.innerHTML = "Delete";
                cell1.width = "6%";
                cell2.innerHTML = "Non Reimbursable Item";
                cell3.innerHTML = "Description";

            }
            if (document.getElementById('hdnNRItems').value != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var CList = list[count].split('~');
                    var row = document.getElementById('tblNRItems').insertRow(1);
                    row.id = CList[0];
                    var rwNumber = CList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickNRItem(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = CList[1];
                    cell3.innerHTML = CList[6];

                }
            }
        }



        function validate() {
            if (document.getElementById('hdnNRItems').value == "") {

                var userMsg = SListForApplicationMessages.Get("Admin\\NonReimbursableMaster.aspx_5");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert("Please enter the NonReimbursableItems");
                    return false;
                }
               // return false;
            }
        }

          
    </script>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        LoadNRItems();       
    </script>

</body>
</html>
