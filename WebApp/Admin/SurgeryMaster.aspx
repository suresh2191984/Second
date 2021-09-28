<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SurgeryMaster.aspx.cs" Inherits="Admin_SurgeryMaster" %>

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
    <title>Surgery Master</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
      <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script type="text/javascript" language="javascript">

        function showItemName() {
            tempX = event.clientX
            tempY = event.clientY
            var dd = document.getElementById('divItemName');
            dd.style.left = (tempX - 0) + "px";
            dd.style.top = (tempY - 0) + "px";
            dd.style.display = "block";


            var lstbox = document.getElementById('lstBoxSurgery');
            var lstboxlength = lstbox.options.length;


            for (var i = 0; i < lstboxlength; i++) {

                if (lstbox.options[i].selected) {
                    dd.innerHTML = lstbox.options[i].text;

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
            lst = document.getElementById('lstBoxSurgery');
            for (var i = 0; i < lst.options.length; i++) {
                lstText[lstText.length] = lst.options[i].text;
                lstValue[lstValue.length] = lst.options[i].value;
            }
        }

        window.onload = CacheItems;

        function FilterItems(value) {
            lst = document.getElementById('lstBoxSurgery');
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
                AddItem("No Surgery Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            lst.options.add(opt);
        }

        function AddSurgery() {

            var txtsurgery = document.getElementById('txtSurgeryName');
            var hdnSurgery = document.getElementById('hdnSurgery');

            if (document.getElementById('txtSurgeryName').value.trim() == '')
            { alert('Cannot be blank'); document.getElementById('txtSurgeryName').focus(); FilterItems(''); return false; } else {

                for (var i = 0; i < lstText.length; i++) {
                    //if (lstText[i].toLowerCase().trim().indexOf(txtsurgery.value.toLowerCase().trim()) != -1) {
                    if (lstText[i].toLowerCase().trim() == document.getElementById('txtSurgeryName').value.toLowerCase().trim()) {
                        alert('Surgery Exists');
                        FilterItems('');
                        document.getElementById('txtSurgeryName').value = '';
                        document.getElementById('txtSurgeryName').focus();
                        return false;

                    }
                }


                if (CheckIfExists(hdnSurgery, txtsurgery.value.trim())) {
                    alert('Surgery already Added');
                    FilterItems('');
                    document.getElementById('txtSurgeryName').value = '';
                    document.getElementById('txtSurgeryName').focus();
                    return false;

                }

                hdnSurgery.value += Math.floor(Math.random() * 500) + '~' + txtsurgery.value.trim() + '^';

                CreateTable();

                document.getElementById('txtSurgeryName').value = '';
                document.getElementById('txtSurgeryName').focus();
                FilterItems('');
            }

        }

        function CheckIfExists(collectionObj, value) {

            SurgeryRaw = collectionObj.value.split('^');
            for (var i = 0; i < SurgeryRaw.length; i++) {
                if (SurgeryRaw[i] != '') {
                    var Surgery = SurgeryRaw[i].split('~');
                    if (Surgery[1].toLowerCase().trim() == value.toLowerCase().trim()) {

                        return true;

                    }
                }
            }

            return false
        }

        function CreateTable() {

            var tmpTable;
            tmpTable = "<table CELLSPACING=3px CELLSPACING=0 style = 'border: thin solid #817679;'><tr><td colspan=2 align='center'><b>Surgery Name</b></td></tr>";

            var itemlist = new Array();
            var item = new Array();
            itemlist = document.getElementById('hdnSurgery').value.split('^');

            for (var i = 0; i < itemlist.length - 1; i++) {

                var item = itemlist[i].split('~');


                tmpTable += "<tr><td><img id=imgbtn~" + Math.floor(Math.random() * 500) + " style='cursor:pointer;' OnClick=ImgOnclick(" + item[0] + "); src='../Images/Delete.jpg' /></td><td>" + item[1] + "</td>";
            }
            tmpTable += "</table>";

            document.getElementById('divTable').innerHTML = tmpTable;
        }


        function ImgOnclick(id) {

            var itemlist = new Array();
            itemlist = document.getElementById('hdnSurgery').value.split('^');

            var j = 0;
            while (j < itemlist.length) {
                var item = itemlist[j].split('~');

                if (item[0] == id) {
                    itemlist.splice(j, 1);
                } else
                { j++; }

            }


            document.getElementById('hdnSurgery').value = '';


            var newitem = new Array();

            for (var i = 0; i < itemlist.length; i++) {

                newitem = itemlist[i].split('~');


                if (newitem[0] != '' && newitem[1] != '') {
                    document.getElementById('hdnSurgery').value += newitem[0] + '~' + newitem[1] + '^';
                }

            }

            if (document.getElementById('hdnSurgery').value != '') {
                CreateTable();
            } else { ClearTable(); };

        }

        function ClearTable() {
            document.getElementById('divTable').innerHTML = '';


        }
            
        
    </script>

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
                                                    <td>
                                                        Surgey Name
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSurgeryName" runat="server"  CssClass ="Txtboxlarge" Width="290px" onkeyup="FilterItems(this.value)"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <input type="button" id="btnAddTable" value="Add" onclick="AddSurgery()" class="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <div id="divItems" runat="server">
                                                            <asp:ListBox ID="lstboxSurgery" runat="server" Height="300px" Width="300px"></asp:ListBox>
                                                        </div>
                                                        <div id="divItemName" style="display: none; position: absolute; border: 1px solid #000;
                                                            background-color: white; padding: 5px;">
                                                        </div>
                                                    </td>
                                                    <td align="right" valign="top" width="30%">
                                                        <div id="divTable" runat="server">
                                                        </div>
                                                        <asp:HiddenField ID="hdnSurgery" Value="" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnAdd" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnAdd_Click" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
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
        <div>
    </form>
</body>
</html>
