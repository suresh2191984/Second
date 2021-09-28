<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomizeClientFeeTypeRate.aspx.cs"
    Inherits="Admin_CustomizeClientFeeTypeRate" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Customize Client Fee Type Rate</title>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "Admin\\CustomizeClientFeeTypeRate.aspx.cs_1") {
                alert('Saved Successfully.');
            }

            else if (key == "Admin\\CustomizeClientFeeTypeRate.aspx.cs_2") {
                alert('There was a problem while saving the details, Please contact system administrator.');
            }
            else if (key == "Admin\\CustomizeClientFeeTypeRate.aspx.cs_3") {
                alert('There was a problem while saving the details, Please contact system administrator.');
            }
            else if (key == "Admin\\CustomizeClientFeeTypeRate.aspx.cs_4") {
                alert('There was a problem while saving the details, Please contact system administrator.');
            }
            else if (key == "Admin\\CustomizeClientFeeTypeRate.aspx.cs_5") {
                alert('Select Corporate & Room Type');
            }
            else if (key == "Admin\\CustomizeClientFeeTypeRate.aspx.cs_6") {
                alert('Select Insurance/TPA & Room Type');
            }
            else if (key == "Admin\\CustomizeClientFeeTypeRate.aspx.cs_7") {
                alert('Deleted successfully');
            }
           return true;
        }



        function pUserConfirmation() {
            var i;
            var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_16");
            if (userMsg != null) {
                i=confirm(userMsg);
            }
            else {
                i = confirm("Are you sure to Delete this Information?");
            }
            //i = confirm('Are you sure to Delete this Information?');
            if (i == true) {
                return;
            }
            else {
                return false;
            }
        }

        function SelectClientTPA() {
            if (document.getElementById('<%= rdoClient.ClientID %>').checked) {
                document.getElementById('<%= trClient.ClientID %>').style.display = "block";
                document.getElementById('<%= trTpaId.ClientID %>').style.display = "None";
            }
            else {
                document.getElementById('<%= trClient.ClientID %>').style.display = "none";
                document.getElementById('<%= trTpaId.ClientID %>').style.display = "block";
            }
            document.getElementById('<%= ddlClientTpa.ClientID %>').value = "0";
            document.getElementById('<%= ddlTpaId.ClientID %>').value = "0";
            document.getElementById('<%= ddlRoomType.ClientID %>').value = "0";
            fnClearDetailsGrid();
        }

        function fnClear() {
            document.getElementById('<%= rdoClient.ClientID %>').checked = true;
            document.getElementById('<%= ddlClientTpa.ClientID %>').value = 0;
            document.getElementById('<%= ddlTpaId.ClientID %>').value = 0;
            document.getElementById('<%= ddlRoomType.ClientID %>').value = 0;

            document.getElementById('<%= hdnDiscountID.ClientID %>').value = "";
            document.getElementById('<%= hdnRowCount.ClientID %>').value = "";
            document.getElementById('<%= hdnGRowCount.ClientID %>').value = "";
            document.getElementById('<%= hdnConfirmation.ClientID %>').value = "";
            document.getElementById('<%= hdnEditClick.ClientID %>').value = "";

            document.getElementById('rdoClient').disabled = "false";
            document.getElementById('rdoTPA').disabled = "false";
            document.getElementById('ddlClientTpa').disabled = "false";
            document.getElementById('ddlTpaId').disabled = "false";
            document.getElementById('ddlRoomType').disabled = "false";

            var grdrows = parseInt(document.getElementById('<%=hdnGRowCount.ClientID %>').value) + 2;
            for (i = 2; i < grdrows; i++) {
                var i2 = get2digit(i);
                document.getElementById('grdGroup_ctl' + i2 + '_btnEdit').disabled = false;
            }
        }

        function fnClearDetailsGrid() {
            var grdrows = parseInt(document.getElementById('<%=hdnRowCount.ClientID %>').value) + 2;
            for (i = 2; i < grdrows; i++) {
                var i2 = get2digit(i);
                document.getElementById('grdResult_ctl' + i2 + '_txtPercent').value = "";
                document.getElementById('grdResult_ctl' + i2 + '_ddlDiscEn').value = "DISC";
                document.getElementById('grdResult_ctl' + i2 + '_hdnClientType').value = "";
                document.getElementById('grdResult_ctl' + i2 + '_hdnClientId').value = "";
                document.getElementById('grdResult_ctl' + i2 + '_hdnRoomTypeId').value = "";
                document.getElementById('grdResult_ctl' + i2 + '_hdnFeeTypeId').value = "";
                document.getElementById('grdResult_ctl' + i2 + '_hdnFeeType').value = "";
            }
        }

        function fnClearAll() {
            fnClear();
            fnClearDetailsGrid();
            document.getElementById('<%= trClient.ClientID %>').style.display = "block";
            document.getElementById('<%= trTpaId.ClientID %>').style.display = "None";
        }

        function fnSaveValidate() {

            if ((document.getElementById('<%=rdoClient.ClientID %>').checked == false) && (document.getElementById('<%=rdoTPA.ClientID %>').checked == false)) {
                 var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_14");
                 if (userMsg != null) {
                     alert(userMsg);
                     return false;
                 }
                 else {
                     alert("Select Client Type");
                     return false;
                 }
                return false;
            }

            if (document.getElementById('<%=rdoClient.ClientID %>').checked == true) {
                if ((document.getElementById('<%= ddlClientTpa.ClientID %>').value == 0) && (document.getElementById('<%= ddlRoomType.ClientID %>').value == 0)) {
                    var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_8");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert("Select Client Type & Room Type");
                    return false;
                }
                    return false;
                }
                if ((document.getElementById('<%= ddlClientTpa.ClientID %>').value == 0) && (document.getElementById('<%= ddlRoomType.ClientID %>').value != 0)) {
                     var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_9");
                     if (userMsg != null) {
                         alert(userMsg);
                         return false;
                     }
                     else {
                         alert("Select Corporate ");
                         return false;
                     }
                    return false;
                }
                else if ((document.getElementById('<%= ddlClientTpa.ClientID %>').value != 0) && (document.getElementById('<%= ddlRoomType.ClientID %>').value == 0)) {
                     var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_10");
                     if (userMsg != null) {
                         alert(userMsg);
                         return false;
                     }
                     else {
                         alert("Select Room Type");
                         return false;
                     }
                    return false;
                }
            }

            if (document.getElementById('<%=rdoTPA.ClientID %>').checked == true) {
                if ((document.getElementById('<%= ddlTpaId.ClientID %>').value == 0) && (document.getElementById('<%= ddlRoomType.ClientID %>').value == 0)) {
                     var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_8");
                     if (userMsg != null) {
                         alert(userMsg);
                         return false;
                     }
                     else {
                    alert("Select Client Type & Room Type");
                    return false;
                    }
                    return false;
                }
                if ((document.getElementById('<%= ddlTpaId.ClientID %>').value == 0) && (document.getElementById('<%= ddlRoomType.ClientID %>').value != 0)) {
                    var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_11");
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                        alert("Select Insurance/TPA");
                        return false;
                    }
                    return false;
                }
                else if ((document.getElementById('<%= ddlTpaId.ClientID %>').value != 0) && (document.getElementById('<%= ddlRoomType.ClientID %>').value == 0)) {
                var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_10");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert("Select Room Type");
                    return false;
                }
                    return false;
                }
            }

            var grdrows = parseInt(document.getElementById('<%=hdnRowCount.ClientID %>').value) + 2;

            //Validation for both Discount % and Type
            for (i = 2; i < grdrows; i++) {
                var i2 = get2digit(i);
                var EmptyFldVal1 = false;
                if (document.getElementById('grdResult_ctl' + i2 + '_txtPercent').value != ""
                        && document.getElementById('grdResult_ctl' + i2 + '_ddlDiscEn').value != "0") {
                    EmptyFldVal1 = true;
                    break;
                }
            }
            if (EmptyFldVal1 == false) {
                var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_12");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert("Enter Discount/Enhancement (%) & Discount/Enhancement Type");
                    return false;
                }
                
                return false;
            }

            for (i = 2; i < grdrows; i++) {
                var i3 = get2digit(i);
                var EmptyFldVal2 = true;
                if (document.getElementById('grdResult_ctl' + i3 + '_txtPercent').value != ""
                        && (document.getElementById('grdResult_ctl' + i3 + '_txtPercent').value <= 0 ||
                        document.getElementById('grdResult_ctl' + i3 + '_txtPercent').value > 100)) {
                    EmptyFldVal2 = false;
                    break;
                }
            }
            if (EmptyFldVal2 == false) {
            var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_13");
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert("Discount/Enhancement (%) should be 0.1 to 100 ");
                return false;
            }
                return false;
            }
        }

        function get2digit(chkdigit) {
            if (chkdigit < 10) {
                return "0" + chkdigit;
            }
            else {
                return chkdigit.toString();
            }
        }

        function fnChkExistingConfig() {

            if (document.getElementById('<%= rdoClient.ClientID %>').checked) {
                if (document.getElementById('<%=ddlClientTpa.ClientID %>').value == '0') {
                var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_9");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Select Corporate.');
                    return false;
                }
                    return false;
                }
            }

            if (document.getElementById('<%= rdoTPA.ClientID %>').checked) {
                if (document.getElementById('<%=ddlTpaId.ClientID %>').value == '0') {
                var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_11");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Select Insurance/TPA.');
                    return false;
                }
                    return false;
                }
            }

            var exClientId;
            var grows;
            if (document.getElementById('<%=grdGroup.ClientID %>')) {
                grows = document.getElementById('<%=grdGroup.ClientID %>').rows.length;
            }
            else {
                grows = 0;
            }

            var exRoomTypeId;
            if (document.getElementById('<%= rdoClient.ClientID %>').checked) {
                exClientId = document.getElementById('<%=ddlClientTpa.ClientID %>').value;
            }
            if (document.getElementById('<%= rdoTPA.ClientID %>').checked) {
                exClientId = document.getElementById('<%=ddlTpaId.ClientID %>').value;
            }
            exRoomTypeId = document.getElementById('<%=ddlRoomType.ClientID %>').value;
            if (grows - 1 > 0) {
                var grdrows1 = (grows - 1) + 2;
                for (i = 2; i < grdrows1; i++) {
                    var i2 = get2digit(i);
                    var EmptyFldVal2 = true;
                    if (document.getElementById('grdGroup_ctl' + i2 + '_hdnClientId').value == exClientId
                        && document.getElementById('grdGroup_ctl' + i2 + '_hdnRoomTypeId').value == exRoomTypeId) {
                        EmptyFldVal2 = false;
                        break;
                    }
                }
                if (EmptyFldVal2 == false) {
                    var i;
                    var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_17");
                    if (userMsg != null) {
                        i=confirm(userMsg);
                    }
                    else {
                        i = confirm('Already the Client & Room type exists, Do you want to modify now?');
                    }

                    //i = confirm('Already the Client & Room type exists, Do you want to modify now?');
                    if (i == true) {
                        document.getElementById('<%=hdnConfirmation.ClientID %>').value = "true";
                        return true;
                    }
                    else {
                        document.getElementById('<%=hdnConfirmation.ClientID %>').value = "false";
                        document.getElementById('<%=ddlRoomType.ClientID %>').value = "0";
                        return false;
                    }
                }
            }
        }

        function ispercentage(obj, e, allowDecimal, allowNegative) {
            var key;
            var isCtrl = false;
            var keychar;
            var reg;
            if (window.event) {
                key = e.keyCode;
                isCtrl = window.event.ctrlKey
            }
            else if (e.which) {
                key = e.which;
                isCtrl = e.ctrlKey;
            }
            if (isNaN(key)) return true;
            keychar = String.fromCharCode(key);
            // check for backspace or delete, or if Ctrl was pressed
            if (key == 8 || isCtrl) {
                return true;
            }
            ctemp = obj.value;

            var index = ctemp.indexOf(".");
            var length = ctemp.length;
            ctemp = ctemp.substring(index, length);
            if (index < 0 && length > 1 && keychar != '.' && keychar != '0') {
                obj.focus();
                return false;
            }
            if (ctemp.length > 2) {
                obj.focus();
                return false;
            }
            if (keychar == '0' && length >= 2 && keychar != '.' && ctemp != '10' && ctemp.length > 3) {
                obj.focus();
                return false;
            }
            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;
            return isFirstN || isFirstD || reg.test(keychar);
        }

        function fnChkEditSaved() {
            if (hdnEditClick.Value == "E") {
             var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_15");
             if (userMsg != null) {
                 alert(userMsg);
                 return false;
             }
             else {
                 var result = alert("Changes not saved, Do you want to continue ?");
             }
                
                
                if (result == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }

        function fnChangeCursor(t) {
            if (t.disabled == true) {
                document.body.style.cursor = 'wait';
            }
            else {
                document.body.style.cursor = 'default';
            }
        }

        function fnCheckEditing(t) {
            if (t.disabled == true) {
                return false;
            }
            var grows;
            if (document.getElementById('<%=grdResult.ClientID %>')) {
                grows = document.getElementById('<%=grdResult.ClientID %>').rows.length;
            }
            else {
                grows = 0;
            }
            var grdrows = (grows - 1) + 2;
            for (i = 2; i < grdrows; i++) {
                var i2 = get2digit(i);
                var modified = true;
                if (document.getElementById('grdResult_ctl' + i2 + '_txtPercent').value != document.getElementById('grdResult_ctl' + i2 + '_hdnPercentDummy').value
                        || document.getElementById('grdResult_ctl' + i2 + '_ddlDiscEn').value != document.getElementById('grdResult_ctl' + i2 + '_hdnDiscEnDummy').value) {
                    modified = false;
                    break;
                }
            }
            if (modified == false && document.getElementById('<%=hdnEditClick.ClientID %>').value == 'E') {
                var result;
                var userMsg = SListForApplicationMessages.Get("Admin\\CustomizeClientFeeTypeRate.aspx.cs_18");
                if (userMsg != null) {
                    result=confirm(userMsg);
                }
                else {
                    result = confirm("Changes not saved, Do you want to continue ?");
                }
//                var result = confirm("Changes not saved, Do you want to continue ?")
                if (result == true) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }

    </script>

</head>
<body onload="SelectClientTPA()">
    <form id="form1" runat="server">
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                                <div id="divInv" runat="server" style="display: block;">
                                    <table class="dataheader2 defaultfontcolor" width="100%" id="casip">
                                        <tr>
                                            <td align="center" valign="middle" colspan="2">
                                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UdtPanel" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblClientType" Text="Select Type:" runat="server" meta:resourcekey="lblClientTypeResource1"></asp:Label>
                                                <asp:RadioButton GroupName="CorpIns" ID="rdoClient" runat="server" Text="Corporate"
                                                    onclick="javascript:SelectClientTPA()" TabIndex="1" meta:resourcekey="rdoClientResource1" />
                                                <asp:RadioButton GroupName="CorpIns" ID="rdoTPA" runat="server" Text="Insurance/TPA"
                                                    onclick="javascript:SelectClientTPA()" TabIndex="2" meta:resourcekey="rdoTPAResource1" />
                                            </td>
                                        </tr>
                                        <div id="divtrclicnt" style="display: none">
                                            <tr id="trClient" runat="server">
                                                <td runat="server">
                                                    <asp:Label ID="lblClientID" Text="Select" runat="server" meta:resourcekey="lblClientIDResource1"></asp:Label>
                                                </td>
                                                <td runat="server">
                                                    <asp:DropDownList class="ddl" ID="ddlClientTpa" runat="server" TabIndex="3"
                                                        AutoPostBack="True" OnSelectedIndexChanged="ddlClientTpa_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    &nbsp;
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                        </div>
                                        <div id="div1" style="display: block">
                                            <tr id="trTpaId" runat="server">
                                                <td runat="server">
                                                    <asp:Label ID="lblTpaId" Text="Select" runat="server" meta:resourcekey="lblTpaIdResource1"></asp:Label>
                                                </td>
                                                <td runat="server">
                                                    <asp:DropDownList class="ddl" ID="ddlTpaId" runat="server" TabIndex="4" AutoPostBack="True"
                                                        OnSelectedIndexChanged="ddlTpaId_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    &nbsp;
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                        </div>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblRoomType" Text="Select Room Type" runat="server" meta:resourcekey="lblRoomTypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList class="ddl" ID="ddlRoomType" runat="server" TabIndex="5" AutoPostBack="True"
                                                    OnSelectedIndexChanged="ddlRoomType_SelectedIndexChanged" onKeyUp="this.blur();"
                                                    meta:resourcekey="ddlRoomTypeResource1">
                                                </asp:DropDownList>
                                                &nbsp;
                                                <img src="../Images/starbutton.png" alt="" align="middle" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="HdnID" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:GridView ID="grdResult" Width="100%" runat="server" AutoGenerateColumns="False"
                                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="grdResult_RowDataBound"
                                                    OnPageIndexChanging="grdResult_PageIndexChanging" meta:resourcekey="grdResultResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Service Type" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFeeType" runat="server" Text='<%# Bind("FeeTypeDesc") %>' meta:resourcekey="lblFeeTypeResource1" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Discount / Enhancement">
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtPercent" EnableViewState="False" Width="50px" MaxLength="6" runat="server"
                                                                    Text='<%# Bind("DiscOrEnhancePercent") %>' Style="text-align: right;"
                                                                    meta:resourcekey="txtPercentResource1"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <%--    onkeypress="return ValidateOnlyNumeric(this);"  --%>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Discount / Enhancement Type" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:DropDownList class="ddlTheme" TabIndex="7" ID="ddlDiscEn" runat="server" DataValueField='<%# Bind("DiscOrEnhanceType") %>'
                                                                    meta:resourcekey="ddlDiscEnResource1">
                                                                    <asp:ListItem Text="Discount" Value="DISC" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                    <asp:ListItem Text="Enhancement" Value="ENHANCE" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hdnDiscEnDummy" Value='<%# Bind("DiscOrEnhanceType") %>' runat="server" />
                                                                <asp:HiddenField ID="hdnPercentDummy" Value='<%# Bind("DiscOrEnhancePercent") %>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Applyby">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="DdlAplyby" runat="server" >
                                                                    <asp:ListItem Text="Value" Value="Value"></asp:ListItem>
                                                                    <asp:ListItem Text="Percentage" Value="Percent"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:Label ID="hdnClientType" runat="server" Text='<%# Bind("ClientType") %>' meta:resourcekey="hdnClientTypeResource1" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="hdnClientId" runat="server" Text='<%# Bind("ClientId") %>' meta:resourcekey="hdnClientIdResource1" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:Label ID="hdnRoomTypeId" runat="server" Text='<%# Bind("RoomTypeId") %>' meta:resourcekey="hdnRoomTypeIdResource1" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                                <asp:Label ID="hdnFeeTypeId" runat="server" Text='<%# Bind("FeeTypeId") %>' meta:resourcekey="hdnFeeTypeIdResource1" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource8">
                                                            <ItemTemplate>
                                                                <asp:Label ID="hdnFeeType" runat="server" Text='<%# Bind("FeeType") %>' meta:resourcekey="hdnFeeTypeResource1" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <RowStyle HorizontalAlign="Left" />
                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="dataheader1" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" Width="75px" TabIndex="8"
                                                    OnClick="btnSave_Click" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                    meta:resourcekey="btnSaveResource1" />
                                                <asp:Button ID="btnClear" runat="server" Text="Clear All" CssClass="btn" TabIndex="9"
                                                    OnClientClick="javascript:return fnClearAll();" OnClick="btnClear_Click" class="btn"
                                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" meta:resourcekey="btnClearResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <asp:Label Width="140px" ID="lblGroupHeader" class="btn" Text="Configured Room Types"
                                                    runat="server" meta:resourcekey="lblGroupHeaderResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:GridView ID="grdGroup" CaptionAlign="Left" Width="100%" runat="server" AutoGenerateColumns="False"
                                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="grdGroup_RowDataBound"
                                                    OnPageIndexChanging="grdGroup_PageIndexChanging" OnRowDeleting="grdGroup_RowDeleting"
                                                    OnRowEditing="grdGroup_RowEditing" meta:resourcekey="grdGroupResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Corporate/Insurance/TPA" meta:resourcekey="TemplateFieldResource9">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblClientName" runat="server" Text='<%# Bind("ClientName") %>' meta:resourcekey="lblClientNameResource1" />
                                                                <asp:HiddenField ID="hdnClientId" runat="server" Value='<%# Bind("ClientId") %>' />
                                                                <asp:HiddenField ID="hdnRoomTypeId" runat="server" Value='<%# Bind("RoomTypeId") %>' />
                                                                <asp:HiddenField ID="hdnClientType" runat="server" Value='<%# Bind("ClientType") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Room Type" meta:resourcekey="TemplateFieldResource10">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRoomType" runat="server" Text='<%# Bind("RoomType") %>' meta:resourcekey="lblRoomTypeResource2" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource11">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnEdit" runat="server" OnClientClick="javascript:return fnCheckEditing(this.id);"
                                                                    CommandName="Edit" Text="Edit" Style='background-color: Transparent; color: Red;
                                                                    border-style: none; cursor: pointer' meta:resourcekey="btnEditResource1"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource12">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete"
                                                                    Style='background-color: Transparent; color: Red; border-style: none; cursor: pointer'
                                                                    OnClientClick="javascript:return pUserConfirmation(); " meta:resourcekey="btnDeleteResource1"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <RowStyle HorizontalAlign="Left" />
                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="dataheader1" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="20" align="center">
                                                &nbsp;
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
        <asp:HiddenField ID="hdnDiscountID" runat="server" />
        <asp:HiddenField ID="hdnRowCount" runat="server" />
        <asp:HiddenField ID="hdnGRowCount" runat="server" />
        <asp:HiddenField ID="hdnConfirmation" runat="server" />
        <asp:HiddenField ID="hdnEditClick" runat="server" />
        <asp:HiddenField ID="hdnApply" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
