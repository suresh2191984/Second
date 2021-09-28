<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BroadcastHome.aspx.cs" Inherits="Broadcast_BroadcastHome" %>

<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Communication.ascx" TagName="Communication" TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Notice Board/Communication</title>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <style type="text/css">
        .style2
        {
            width: 148px;
        }
    </style>
</head>

<script type="text/javascript">

    function showDivPage(ddlCommType) {
        var comm1 = document.getElementById("div1");
        var comm2 = document.getElementById("div2");
        if (ddlCommType.value == "0") {
            comm1.style.display = "none";
            comm2.style.display = "none";
        }
        if (ddlCommType.value == "1") {
            comm1.style.display = "none";
            comm2.style.display = "block";
        }
        if (ddlCommType.value == "2") {
            comm1.style.display = "block";
            comm2.style.display = "none";
        }
    }

    function validateForm1() {        
        var dateEntered = document.getElementById("txtFDate1").value;
        var date1 = dateEntered.substring(0, 2);
        var month1 = dateEntered.substring(3, 5);
        var year1 = dateEntered.substring(6, 10);
        var dateToCompare1 = new Date(year1, month1 - 1, date1);
        var currentDate = new Date();
        var date2 = currentDate.getDate();
        var month2 = currentDate.getMonth() + 1;
        var year2 = currentDate.getFullYear();
        var dateToCompare2 = new Date(year2, month2 - 1, date2);
        var w = document.getElementById("txtFDate1").value;
        var y = document.forms["form1"]["txtSubject"].value;
        var z = FCKeditorAPI.GetInstance("FCKeditor2").GetHTML();
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
        if (document.getElementById('<%=ddlBroadcastedby.ClientID%>').selectedIndex == 0) {
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
        var x = FCKeditorAPI.GetInstance("FCKeditor1").GetHTML();
        var y = document.getElementById("txtFDate").value;
        var z = document.forms["form1"]["txtNBSubject"].value;
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

    function checkAllNBItem(obj1) {
        var checkboxCollection = document.getElementById('<%=chkDomain.ClientID %>').getElementsByTagName('input');

        for (var i = 0; i < checkboxCollection.length; i++) {
            if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                checkboxCollection[i].checked = obj1.checked;
            }
        }
    }
    function checkAllBItem(obj1) {
        var checkboxCollection = document.getElementById('<%=chkBroadcastTo.ClientID %>').getElementsByTagName('input');

        for (var i = 0; i < checkboxCollection.length; i++) {
            if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                checkboxCollection[i].checked = obj1.checked;
            }
        }
    }
</script>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="header">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
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
                    <div class="contentdata1">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <table border="0" cellpadding="2" cellspacing="0" width="100%">
                                    <tr id="trddlCommType" runat="server">
                                        <td>
                                            <strong>
                                                <asp:Label ID="lblCommType" runat="server" Text="Select Type" Width="13%"></asp:Label></strong>
                                            <asp:DropDownList ID="ddlCommType" runat="server" CssClass="ddl" onchange="javascript:showDivPage(this)">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr id="trlblDisplay" runat="server" style="display: block;">
                                        <td>
                                            <table border="0" cellpadding="2" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblDisplay" runat="server" Font-Bold="true"></asp:Label>
                                                        <hr />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="lnkBroadcast" runat="server" Text="Click Here" ForeColor="maroon"
                                                            Font-Underline="true" Font-Bold="true" OnClick="lnkBroadcast_Click"></asp:LinkButton>
                                                        to post more communication / Notice.
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <div id="div1" runat="server" style="display: none;">
                                    <table width="70%" class="dataheader3" border="0" cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td colspan="2">
                                                <table width="100%" border="0" cellpadding="4" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblAck" runat="server" Text=" Need to Acknowledge?" align="left"></asp:Label>
                                                            <asp:RadioButton ID="rbACKYes" runat="server" Text="Yes" GroupName="ACKYesNo" Checked="true" />
                                                            <asp:RadioButton ID="rbACKNo" runat="server" Text="No" GroupName="ACKYesNo" Checked="false" />
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
                                            <td>
                                                <asp:Label ID="lblNBSubject" runat="server" Text=" Subject:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtNBSubject" runat="server" Width="70%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMessage" runat="server" Text=" Message:" align="left" Width="15%"></asp:Label>
                                            </td>
                                            <td>
                                                <FCKeditorV2:FCKeditor ID="FCKeditor1" runat="server" Width="750px" Height="200px">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="Panel3" runat="server" GroupingText="Notice To" Width="100%">
                                                    <asp:CheckBox ID="chkCheckAll" runat="server" Checked="false" onclick="checkAllNBItem(this);"
                                                        Text="Select all" Font-Bold="true" />
                                                    <asp:CheckBoxList ID="chkDomain" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                                                    </asp:CheckBoxList>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr id="trSMSBlock" style="display: none;">
                                            <td colspan="2">
                                                <table width="100%" border="0" cellpadding="4" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 15%;">
                                                            <asp:Label ID="Label1" runat="server" Text="Send SMS:" align="left" Width="80%"></asp:Label>
                                                        </td>
                                                        <td style="width: 85%;">
                                                            <asp:RadioButton ID="rbYes" runat="server" Text="Yes" GroupName="YesNo" Checked="false" />
                                                            <asp:RadioButton ID="rbNo" runat="server" Text="No" GroupName="YesNo" Checked="true" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table width="70%" border="0" cellpadding="4" cellspacing="0">
                                                    <tr>
                                                        <td class="style2">
                                                            <asp:Label ID="lblValidity" runat="server" Text="Expires on <br>[Valid Till To Display]:"
                                                                align="left"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtFDate" CssClass="ddlsmall" runat="server" meta:resourcekey="txtFDateResource1"
                                                                Width="50%"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                PopupButtonID="ImgFDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button ID="btnNBSubmit" runat="server" Text=" Post " CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                OnClientClick="javascript:return validateForm2()" onmouseout="this.className='btn'"
                                                                meta:resourcekey="btnChangeResource2" OnClick="btnNBSubmit_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="div2" runat="server" style="display: none;">
                                    <table width="70%" class="dataheader3" border="0" cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblBroadcastedby" runat="server" Text="Sent By:" align="left"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlBroadcastedby" runat="server">
                                                </asp:DropDownList>
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
                                                <FCKeditorV2:FCKeditor ID="FCKeditor2" runat="server" Width="750px" Height="200px">
                                                </FCKeditorV2:FCKeditor>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="Panel1" runat="server" GroupingText="Sent To" Width="100%">
                                                    <asp:CheckBox ID="chkAll" runat="server" Checked="false" onclick="checkAllBItem(this);"
                                                        Text="Select all" Font-Bold="true" />
                                                    <asp:CheckBoxList ID="chkBroadcastTo" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                                                    </asp:CheckBoxList>
                                                </asp:Panel>
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
