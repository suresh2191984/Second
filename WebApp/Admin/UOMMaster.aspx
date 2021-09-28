<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UOMMaster.aspx.cs" Inherits="Admin_UOMMaster" %>

<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="Ucadd" TagPrefix="Uc10" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
--%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Organisation Location</title>
    <%--<link href="../StyleSheets/style.css" validateRequest="false" enableEventValidation="false"  rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function ButtonClick(buttonId) {
            var x = buttonId.split('^')[1];
            var Y = buttonId.split('^')[0];
            document.getElementById('hdnUOM').value += x;
            document.getElementById('Textarea1').value += Y;
            //document.getElementById('txtUpload').focus();
            return false;
        }
        function Cleartext() {
            document.getElementById('Textarea1').value = "";
            document.getElementById('hdnUOM').value = "";
            document.getElementById('txtDescription').value = "";
            document.getElementById('txtUploadDesc').value = "";
            document.getElementById('txtUpload').value = "";
            document.getElementById('Textarea1').focus();
            return false;
        }
        function chkINVList() {
            if (document.getElementById('txtUpload').value == "") {
                alert('Required Field cannot be Empty');
                return false;
            }
            else {
                var IsFalse = false;
                var isTrue = IsINVList(isTrue);
                if (IsFalse == isTrue) {
                    return false;
                }
                else {
                    document.getElementById('hdnINVList').value = "";
                    return true;
                }
            }
        }
        function IsINVList() {
            var isTrue = true;
            var x = document.getElementById('txtUpload').value;
            var y = document.getElementById('hdnINVList').value;
            var list = y.split('^');
            for (var i = 0; i < list.length; i++) {
                if (list[i] == x) {
                    alert('"' + x + '" Already Exists !!');
                    document.getElementById('Textarea1').value = "";
                    document.getElementById('hdnUOM').value = "";
                    document.getElementById('txtDescription').value = "";
                    document.getElementById('txtUploadDesc').value = "";
                    document.getElementById('txtUpload').value = "";
                    isTrue = false;
                    return isTrue;
                }
                else {
                    return isTrue;
                }
            }
        }
        function checkIsExists() {
            if (document.getElementById('Textarea1').value == "") {
                alert('Required Field cannot be Empty');
                return false;
            }
            return true;
        }
        function IsExists() {
            var x = document.getElementById('Textarea1').value;
            var y = document.getElementById('hdnUOMList').value;
            var list = y.split('^');
            for (var i = 0; i < list.length; i++) {
                if (list[i] == x) {
                    alert('"' + x + '" Already Exists !!');
                    document.getElementById('Textarea1').value = "";
                    document.getElementById('hdnUOM').value = "";
                    document.getElementById('txtDescription').value = "";
                    document.getElementById('txtUploadDesc').value = "";
                    document.getElementById('txtUpload').value = "";
                    return false;
                }
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server" name="form1">
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
                        <asp:UpdatePanel ID="pnlrate" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlAdd" CssClass="dataheader2" Style="width: 100%" BorderWidth="1px"
                                    runat="server">
                                    <div id="divInv" runat="server">
                                        <table border="0" align="center" width="100%">
                                            <tr>
                                                <td class="colorforcontent" height="23" align="left">
                                                    <div id="ACX2OPPmt" runat="server" style="display: block;">
                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                            <asp:Label ID="lblSymUpload" Text="Upload Symbols" runat="server"></asp:Label></span>
                                                    </div>
                                                    <div id="ACX2minusOPPmt" runat="server" style="display: none;">
                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                            <asp:Label ID="lblSymUpload1" Text="Upload Symbols" runat="server"></asp:Label></span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr align="center" id="ACX2responsesOPPmt" style="display: none;">
                                                <td valign="top">
                                                    <table border="0" height="50px" width="100%">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID="lblUpload" runat="server" Text="Upload Symbols"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtUpload" runat="server" ToolTip="Drag or Paste Symbol to Upload" CssClass ="Txtboxsmall"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDesc1" runat="server" Text="Description"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtUploadDesc" runat="server" ToolTip="Add Description" CssClass ="Txtboxsmall" ></asp:TextBox>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnUploadSymbols" runat="server" Text="Upload" class="btn" ToolTip="Click to Add Symbol to Keyboard"
                                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return chkINVList();"
                                                                    OnClick="btnUploadSymbols_Click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td valign="top">
                                                    <br />
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID="lblKey" runat="server" Text="UOM Symbol"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:TextBox ID="Textarea1" dir="ltr" Style="text-align: right;" ToolTip="Add Symbols" CssClass ="Txtboxsmall"
                                                                    runat="server"></asp:TextBox>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblDesc" runat="server" Text="Description"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <asp:TextBox ID="txtDescription" ToolTip="Add Description"  CssClass ="Txtboxsmall" dir="ltr" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnSave" runat="server" Text="Save" class="btn" ToolTip="Save" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" OnClientClick="return checkIsExists();" OnClick="btnSave_Click" />
                                                                <asp:HiddenField ID="hdnUOMList" runat="server" />
                                                                <asp:HiddenField ID="hdnINVList" runat="server" />
                                                                <asp:HiddenField ID="hdnUOM" runat="server" />
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn" ToolTip="Clear"
                                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return Cleartext();" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr align="justify">
                                                <td width="788px" align="left">
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <asp:Label ID="lblKeyDesc" runat="server" Text="Virtual Keyboard (For entering Symbols only)"></asp:Label>
                                                    <br />
                                                    <asp:Panel BorderWidth="2" ID="pSymbols" runat="server">
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
