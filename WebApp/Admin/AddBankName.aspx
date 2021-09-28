<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddBankName.aspx.cs" Inherits="Admin_AddBankName" 
meta:resourcekey="PageResource1"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Bank Master</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script type="text/javascript" language="javascript">
function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else  {
                alert('Updated');
                return false;
            }

           return true;
        }
        function showItemName() {
            tempX = event.clientX
            tempY = event.clientY
            var dd = document.getElementById('divItemName');
            dd.style.left = (tempX - 0) + "px";
            dd.style.top = (tempY - 0) + "px";
            dd.style.display = "block";


            var lstbox = document.getElementById('lstboxBankName');
            var lstboxlength = lstbox.options.length;
            document.getElementById('hdnBankID').value = '';

            for (var i = 0; i < lstboxlength; i++) {

                if (lstbox.options[i].selected) {
                    dd.innerHTML = lstbox.options[i].text;
                    document.getElementById('txtBankName').value = lstbox.options[i].text;
                    document.getElementById('hdnBankID').value = lstbox.options[i].value;

                }

            }

            return true
        }
        function hideItemName() {
            var dd = document.getElementById('divItemName');
            dd.style.display = "none";
        }


        var lstText, lstValue, lst, lblMesg;
        String.prototype.trim = function() {
            return this.replace(/^\s+|\s+$/g, '');
        }
        function CacheItems() {
            lstText = new Array();
            lstValue = new Array();
            lst = document.getElementById('lstboxBankName');
            for (var i = 0; i < lst.options.length;i++) {
                lstText[lstText.length] = lst.options[i].text;
                lstValue[lstValue.length] = lst.options[i].value;
            }
        }

        window.onload = CacheItems;

        function FilterItems(value) {
            lst = document.getElementById('lstboxBankName');
            lst.options.length = 0;

            if (value.trim() == '') {

                for (var i = 0; i < lstText.length; i++) {

                    AddItem(lstText[i], lstValue[i]);

                }
            } else {

                for (var i = 0; i < lstText.length; i++) {
                    if (lstText[i].toLowerCase().indexOf(value.trim().toLowerCase()) != -1) {
                        AddItem(lstText[i], lstValue[i]);
                    }
                }
            }




            if (lst.options.length == 0) {
                AddItem("No Bank Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            lst.options.add(opt);

        }

        function AddBank() {

            var txtBank = document.getElementById('txtBankName');
            var hdnBankName = document.getElementById('hdnBankName');

            if (document.getElementById('txtBankName').value.trim() == '') {
                var userMsg = SListForApplicationMessages.Get('Admin\\AddBankName.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Cannot be blank');
                    return false;
                }
             document.getElementById('txtBankName').focus(); FilterItems(''); return false; } else {

                for (var i = 0; i < lstText.length; i++) {
                    if (lstText[i].toLowerCase().trim().indexOf(txtBank.value.toLowerCase().trim()) != -1) {
                        if (lstText[i].toLowerCase().trim() == document.getElementById('txtBankName').value.toLowerCase().trim()) {
                            var userMsg = SListForApplicationMessages.Get('Admin\\AddBankName.aspx_2');
                            if (userMsg != null) {
                                alert(userMsg);
                                return false;
                            } else {
                            alert('Bank Already Exists');
                            return false;
                            }
                            FilterItems('');
                            document.getElementById('txtBankName').value = '';
                            document.getElementById('txtBankName').focus();
                            return false;

                        }
                    }
                }


                if (CheckIfExists(hdnBankName, txtBank.value.trim())) {
                    var userMsg = SListForApplicationMessages.Get('Admin\\AddBankName.aspx_3');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    } else {
                    alert('Bank already Added');
                    return false;
                    }
                    FilterItems('');
                    document.getElementById('txtBankName').value = '';
                    document.getElementById('txtBankName').focus();
                    return false;

                }

                hdnBankName.value += Math.floor(Math.random() * 500) + '~' + txtBank.value.trim() + '^';

                CreateTable();

                document.getElementById('txtBankName').value = '';
                document.getElementById('txtBankName').focus();
                FilterItems('');
            }
            return false;

        }

        function CheckIfExists(collectionObj, value) {

            BankRaw = collectionObj.value.split('^');
            for (var i = 0; i < BankRaw.length; i++) {
                if (BankRaw[i] != '') {
                    var Bank = BankRaw[i].split('~');
                    if (Bank[1].toLowerCase().trim() == value.toLowerCase().trim()) {

                        return true;

                    }
                }
            }

            return false
        }

        function CreateTable() {

            var tmpTable;
            tmpTable = "<table CELLSPACING=3px width=100%  CELLSPACING=0 style = 'border: thin solid #817679;'><tr><td colspan=2 align='Left'><b>"+"<%=Resources.ClientSideDisplayTexts.Admin_AddBankName_BankName%>"+"</b></td></tr>";

            var itemlist = new Array();
            var item = new Array();
            itemlist = document.getElementById('hdnBankName').value.split('^');

            for (var i = 0; i < itemlist.length - 1; i++) {

                var item = itemlist[i].split('~');


                tmpTable += "<tr><td><img id=imgbtn~" + Math.floor(Math.random() * 500) + " style='cursor:pointer;' OnClick=ImgOnclick(" + item[0] + "); src='../Images/Delete.jpg' /></td><td>" + item[1] + "</td>";
            }
            tmpTable += "</table>";

            document.getElementById('divTable').innerHTML = tmpTable;
        }


        function ImgOnclick(id) {

            var itemlist = new Array();
            itemlist = document.getElementById('hdnBankName').value.split('^');

            var j = 0;
            while (j < itemlist.length) {
                var item = itemlist[j].split('~');

                if (item[0] == id) {
                    itemlist.splice(j, 1);
                } else
                { j++; }

            }


            document.getElementById('hdnBankName').value = '';


            var newitem = new Array();

            for (var i = 0; i < itemlist.length; i++) {

                newitem = itemlist[i].split('~');


                if (newitem[0] != '' && newitem[1] != '') {
                    document.getElementById('hdnBankName').value += newitem[0] + '~' + newitem[1] + '^';
                }

            }

            if (document.getElementById('hdnBankName').value != '') {
                CreateTable();
            } else { ClearTable(); };

        }

        function ClearTable() {
            document.getElementById('divTable').innerHTML = '';


        }

        function ValidateDate() {
            var flag = 0;
            if (document.getElementById('txtBankName').value != '') {
                var lstbox = document.getElementById('lstboxBankName');
                var lstboxlength = lstbox.options.length;
                for (var i = 0; i < lstboxlength; i++) {
                    if (lstbox.options[i].text.toLowerCase().trim() == document.getElementById('txtBankName').value.toLowerCase().trim()) {
                        flag = 1;
                    }
                }
            }

            if (flag == 1) {
                var userMsg = SListForApplicationMessages.Get('Admin\\AddBankName.aspx_4');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                alert("Entered Bank Already Exists");
                return false;
                }
                document.getElementById('txtBankName').value = '';
                document.getElementById('txtBankName').focus();
                return false;
            }
            if (document.getElementById('txtBankName').value == '' && document.getElementById('hdnBankName').value == '') {
                var userMsg = SListForApplicationMessages.Get('Admin\\AddBankName.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                 alert("Enter The Bank Name");
                 return false;
                }
            }
            if (document.getElementById('txtBankName').value != '' && document.getElementById('hdnBankName').value == '') {
                var userMsg = SListForApplicationMessages.Get('Admin\\AddBankName.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }else
                { 
                alert("ADD The Bank");
                return false;
                }
            }
        }
        
    </script>

    <style type="text/css">
        .style2
        {
            height: 39px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="header">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:PatientHeader ID="PatientHeader1" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td align="left">
                                            <table>
                                                <tr>
                                                    <td class="style2">
                                                        <asp:Label ID="Rs_BankName" Text="Bank Name" runat="server" meta:resourcekey="Rs_BankNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="style2">
                                                        <asp:TextBox ID="txtBankName" autocomplete="off" runat="server" Width="290px" CssClass="Txtboxsmall" onkeyup="FilterItems(this.value)"
                                                            meta:resourcekey="txtBankNameResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="style2">
                                                        <asp:Button ID="btnAddTable" runat="server" Text="Add" 
                                                            OnClientClick="return AddBank()" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" 
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnAddTableResource1" />
                                                    </td>
                                                    <td class="style2">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="color: Red" colspan="4">
                                                        <asp:Label ID="Rs_info" Text="If you want to edit Bank name, Select the Bank from the below list"
                                                            runat="server" meta:resourcekey="Rs_infoResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <asp:Label ID="Rs_ExistingBanks" Text="Existing Banks" runat="server" meta:resourcekey="Rs_ExistingBanksResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <div id="divItems" runat="server">
                                                            <asp:ListBox ID="lstboxBankName" runat="server" Height="300px" Width="300px" meta:resourcekey="lstboxBankNameResource1">
                                                            </asp:ListBox>
                                                        </div>
                                                        <div id="divItemName" style="display: none; position: absolute; border: 1px solid #000;
                                                            background-color: white; padding: 5px;">
                                                        </div>
                                                    </td>
                                                    <td align="left" valign="top" width="30%">
                                                        <div id="divTable" runat="server" align="left">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr id="trResult" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblResult" Style="color: Red" runat="server" ></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnAdd" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnAdd_Click" OnClientClick="javascript:return ValidateDate();" meta:resourcekey="btnAddResource1"
                                                Width="49px" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
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
