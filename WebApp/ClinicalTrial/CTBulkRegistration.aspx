<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CTBulkRegistration.aspx.cs"
    Inherits="ClinicalTrial_CTBulkRegistration" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ControlListDetails.ascx" TagName="ControlListDetails"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/1900")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }
    </script>

    <script type="text/javascript" language="javascript">

        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 46)) {
                isCtrl = true;
            }

            return isCtrl;
        }
        function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
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
            if (isCtrl || (key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 188) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46)) {
                //            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }

        
    </script>

    <style type="text/css">
        .style2
        {
            height: 40px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
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
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>
                                    <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel" runat="server">
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
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="2">
                                                <div>
                                                    <asp:Panel ID="pnlas" runat="server">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="Panel5" runat="server" GroupingText="Epiosde Visit Details">
                                                                        <table border="0" cellpadding="2" width="100%" class="dataheader3">
                                                                            <tr class="tablerow" id="ACX2responsesOPPmt" runat="server" style="display: block;">
                                                                                <td id="Td1" colspan="2" runat="server">
                                                                                    <table width="70%" border="0" cellpadding="2" cellspacing="0" align="center">
                                                                                        <tr id="Tr1" runat="server" width="100%">
                                                                                            <td id="TdSiteName1" style="width: 10%;" align="left" runat="server">
                                                                                                <asp:Label ID="Rs_ClientName" runat="server" Text="Site Name"></asp:Label>
                                                                                            </td>
                                                                                            <td id="TdSiteName2" style="width: 15%;" runat="server">
                                                                                                <asp:TextBox ID="txtClient" Width="125px" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Site Name"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientListforSchedule"
                                                                                                    ServicePath="~/WebService.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                                                                                    Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td id="Td2" style="width: 10%;" align="left" runat="server">
                                                                                                <asp:Label ID="lblEpisode" Text="Study/Protocol Name" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td id="Td3" runat="server" width="15%">
                                                                                                <asp:TextBox ID="txtEpisodeName" runat="server" ToolTip="Enter Study/Protocol Name"
                                                                                                    onfocus="getSittingEpisoe();" CssClass="Txtboxsmall"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteSittingEpisode" runat="server" TargetControlID="txtEpisodeName"
                                                                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientEpisode"
                                                                                                    ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="SittingEpisodeSelected"
                                                                                                    DelimiterCharacters="" Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                <%--onfocus="getSittingEpisoe();" --%>
                                                                                            </td>
                                                                                            <td id="Td10" style="width: 10%;" align="left" runat="server">
                                                                                                <asp:Label ID="lblConsign" runat="server" Text="Registration Track ID." ToolTip="Register with Existing Consignment No."></asp:Label>
                                                                                                &nbsp;
                                                                                            </td>
                                                                                            <td id="Td16" style="width: 15%;" align="left" runat="server">
                                                                                                <asp:TextBox ID="txtConsignment" Width="125px" onfocus="SetConsignContextKey();"
                                                                                                    onKeyDown="javascript:clearConsignmentValues('Y');" onblur="javascript:CheckConsignmentNo();"
                                                                                                    runat="server" CssClass="Txtboxsmall" ToolTip="Register with Existing Consignment No."></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoConsignment" runat="server" TargetControlID="txtConsignment"
                                                                                                    EnableCaching="false" FirstRowSelected="true" CompletionInterval="1" CompletionSetCount="10"
                                                                                                    MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetConsignmentNo"
                                                                                                    ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="ConsignmentSelected">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <%-- <input type="text" runat="server" title="dd-MM-yyyy hh:mm:ssAM/PM" id="testtext" /> --%>
                                                                                            </td>
                                                                                           <%-- <td>
                                                                                                <input type="button" id="btnTestDrive" onclick="TestDrive();" value="Test Drive" />
                                                                                            </td>--%>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td id="trPatientDetails" style="display: none;">
                                                                                                <div id="showimage" style="display: none; position: absolute; width: 460px; left: 50%;
                                                                                                    top: 3%">
                                                                                                    <div onclick="hidebox();return false" class="divCloseRight">
                                                                                                    </div>
                                                                                                    <table border="0" width="453px" cellspacing="1" class="modalPopup dataheaderPopup"
                                                                                                        cellpadding="1">
                                                                                                        <tr>
                                                                                                            <td id="dragbar" style="cursor: move; cursor: pointer" width="100%" onmousedown="initializedrag(event)">
                                                                                                                <asp:Label ID="lblPatientDetails" runat="server"></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <%-- <tr>
                                                                                            <td id="Td6" style="width: 10%;">
                                                                                                <asp:Button runat="server" Text="Save" ID="btnSave" OnClick="btnSave_Click" CssClass="btn" />
                                                                                            </td>
                                                                                        </tr>--%>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr runat="server" id="trConsignmentNoDetail" style="display: none;">
                                                                                <td width="50%">
                                                                                    <asp:Panel ID="Panel3" runat="server" GroupingText="Consignment Details">
                                                                                        <table id="tblConsignmentNoDetail" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                                            style="text-align: left; font-size: 11px;" width="100%">
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                                <td width="50%">
                                                                                </td>
                                                                            </tr>
                                                                            <tr runat="server" id="tdEpisodeVisitDetails" style="display: none;">
                                                                                <td colspan="2">
                                                                                    <table id="tblEpisodeVisitDetails" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                                        style="text-align: left; font-size: 11px;" width="100%">
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr id="tdSubjectVisitDetails" runat="server" style="display: none;">
                                                                <td>
                                                                    <asp:Panel ID="Panel1" runat="server" GroupingText="Subject Details">
                                                                        <table width="100%" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                            style="text-align: left; font-size: 11px;" width="100%">
                                                                            <tr>
                                                                                <td id="Td5" style="width: 10%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label1" runat="server" Text="Visit Name"></asp:Label>
                                                                                </td>
                                                                                <td id="Td18" style="width: 5%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label8" runat="server" Text="Subject No"></asp:Label>
                                                                                </td>
                                                                                <td id="Td6" style="width: 10%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label2" runat="server" Text="Subject Initials/Name"></asp:Label>
                                                                                </td>
                                                                                <td id="Td7" style="width: 10%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label3" runat="server" Text="DOB"></asp:Label>
                                                                                </td>
                                                                                <td id="Td8" style="width: 10%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label4" runat="server" Text="Age"></asp:Label>
                                                                                </td>
                                                                                <td id="Td9" style="width: 8%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label5" runat="server" Text="Gender"></asp:Label>
                                                                                </td>
                                                                                <td id="Td21" style="width: 8%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label16" runat="server" Text="Patient Status"></asp:Label>
                                                                                </td>
                                                                                <td id="Td22" style="width: 8%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label17" runat="server" Text="Visit Type"></asp:Label>
                                                                                </td>
                                                                                <td id="Td11" style="width: 35%;" align="left" runat="server">
                                                                                    <asp:Label ID="Label7" runat="server" Text="Sample Attributes"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td id="Td4" style="width: 10%;" align="left" runat="server" valign="top">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlVisitName" runat="server" onChange="javascript:LoadSampleAttributes(this.value);">
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:CheckBox ID="chkIsUnScheduleVisit" runat="server" Text="UnSchedule Visit" Font-Bold="true"
                                                                                                    OnClick="javascript:ClickUnScheduleVisit();" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td id="Td19" style="width: 5%;" align="left" runat="server" valign="top">
                                                                                    <asp:TextBox ID="txtSujectNo" Width="80px" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                                    <%-- <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                                </td>
                                                                                <td id="Td12" style="width: 10%;" align="left" runat="server" valign="top">
                                                                                    <asp:TextBox ID="txtSubjectName" runat="server" Width="110px" CssClass="Txtboxsmall"
                                                                                        onKeyDown="javascript:clearPageControlsValue('Y');"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                                                        onblur="javascript:ConverttoUpperCase(this.id);" autocomplete="off"></asp:TextBox>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" MinimumPrefixLength="2"
                                                                                        runat="server" FirstRowSelected="false" TargetControlID="txtSubjectName" ServiceMethod="GetLabQuickBillPatientList"
                                                                                        ServicePath="~/OPIPBilling.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp1"
                                                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                                        OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                </td>
                                                                                <td id="Td13" style="width: 10%;" align="left" runat="server" valign="top">
                                                                                    <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                                                                        onblur="javascript:countQuickAge(this.id);" Width="75px" Style="text-align: justify"
                                                                                        ValidationGroup="MKE" />
                                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                        CultureTimePlaceholder="" Enabled="True" />
                                                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                </td>
                                                                                <td id="Td14" style="width: 10%;" align="left" runat="server" valign="top">
                                                                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                        CssClass="Txtboxsmall" Width="20%" runat="server" MaxLength="3" Style="text-align: justify" />
                                                                                    <asp:DropDownList onChange="getDOB()" ID="ddlDOBDWMY" Width="60%" runat="server"
                                                                                        CssClass="ddl">
                                                                                    </asp:DropDownList>
                                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                    <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                                                        Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                                                                    </ajc:TextBoxWatermarkExtender>
                                                                                </td>
                                                                                <td id="Td15" style="width: 8%;" align="left" runat="server" valign="top">
                                                                                    <asp:DropDownList ID="ddlSex" runat="server">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td id="Td23" style="width: 8%;" align="left" runat="server" valign="top">
                                                                                    <asp:DropDownList ID="ddlPStatus" runat="server">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td id="Td24" style="width: 8%;" align="left" runat="server" valign="top">
                                                                                    <asp:DropDownList ID="ddlVType" runat="server">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td id="Td17" style="width: 35%;" align="left" runat="server" valign="top">
                                                                                    <table id="tblSampleAttributes" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                                        style="text-align: left; font-size: 11px;" width="100%" >
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td id="tdUnScheduleVisit" style="width: 10%; display: none;" align="left" runat="server"
                                                                                    valign="top" colspan="4">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td width="20%" class="style2">
                                                                                                <asp:Label ID="lblTestName" Text="Test Name" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td class="style2">
                                                                                                <asp:TextBox CssClass="AutoCompletesearchBox" ID="txtTestName" runat="server" onchange="boxExpand(this);"
                                                                                                    Width="200px" autocomplete="off"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="GeneralBillItemsAutoCompleteExtender" runat="server"
                                                                                                    TargetControlID="txtTestName" EnableCaching="False" MinimumPrefixLength="3" CompletionInterval="0"
                                                                                                    OnClientItemSelected="BillingItemSelected" CompletionListCssClass="wordWheel listMain .box"
                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                    ServiceMethod="GetBillingItems" FirstRowSelected="True" OnClientItemOver="SelectedTest"
                                                                                                    ServicePath="~/OPIPBilling.asmx" UseContextKey="True" DelimiterCharacters=""
                                                                                                    OnClientShown="InvPopulated" Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                <input type="button" id="Button1" value="ADD" onclick="AddItems();" class="smallbtn" />
                                                                                                &nbsp;<asp:Label ID="lblInvType" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                                                                                                &nbsp;<asp:Label ID="alert" runat="server" ForeColor="Red"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td id="tdBillingItems" style="width: 10%; display: none;" align="left" runat="server"
                                                                                    valign="top" colspan="4">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <table id="tblBillingItems" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                                                    style="text-align: left; font-size: 11px;" width="80%">
                                                                                                    <tr>
                                                                                                        <th style="width: 80%;">
                                                                                                            <asp:Label runat="server" ID="Label20" Text="Description" />
                                                                                                        </th>
                                                                                                        <th style="width: 20%;">
                                                                                                            <asp:Label runat="server" ID="Label21" Text="Action" />
                                                                                                        </th>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="right" colspan="3">
                                                                                                <input type="button" id="Button2" class="btn" style="width: 90px; height: 20px;"
                                                                                                    value="Get Samples" onclick="GetSamplesForInves();" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td id="tdUnSheduleOrderedInvs" style="width: 35%; display: none;" align="left" runat="server"
                                                                                    valign="top">
                                                                                    <table id="tblUnSheduleOrderedInvs" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                                        style="text-align: left; font-size: 11px;" width="100%">
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="9" align="right">
                                                                                    <input type="button" id="btnAdd" class="btn" style="width: 90px; height: 20px;" value="Add Subject"
                                                                                        onclick="CollectSamplePageAddSample();" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr id="trCollectionOfSubjects" runat="server" style="display: none;">
                                                                <td>
                                                                    <asp:Panel ID="Panel2" runat="server" GroupingText="Registration Queue">
                                                                        <table width="100%" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                            style="text-align: left; font-size: 11px;" width="100%">
                                                                            <tr>
                                                                                <td id="Td20" style="width: 100%;" align="left" runat="server">
                                                                                    <table id="tblCollectionOfSubjects" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                                                                        style="text-align: left; font-size: 12px;" width="100%">
                                                                                        <tr>
                                                                                            <th style="width: 10%;">
                                                                                                <asp:Label runat="server" ID="Label6" Text="VisitName" />
                                                                                            </th>
                                                                                            <th style="width: 5%;">
                                                                                                <asp:Label runat="server" ID="Label9" Text="Subject No" />
                                                                                            </th>
                                                                                            <th style="width: 10%;">
                                                                                                <asp:Label runat="server" ID="Label11" Text="Subject Initials/Name" />
                                                                                            </th>
                                                                                            <th style="width: 5%;">
                                                                                                <asp:Label runat="server" ID="Label10" Text="DOB" />
                                                                                            </th>
                                                                                            <th style="width: 5%;">
                                                                                                <asp:Label runat="server" ID="Label12" Text="Age" />
                                                                                            </th>
                                                                                            <th style="width: 5%;">
                                                                                                <asp:Label runat="server" ID="Label13" Text="Gender" />
                                                                                            </th>
                                                                                            <th style="width: 7%;">
                                                                                                <asp:Label runat="server" ID="Label18" Text="Patient Status" />
                                                                                            </th>
                                                                                            <th style="width: 3%;">
                                                                                                <asp:Label runat="server" ID="Label19" Text="Visit Type" />
                                                                                            </th>
                                                                                            <th style="width: 40%;">
                                                                                                <asp:Label runat="server" ID="Label14" Text="Sample Attributes" />
                                                                                            </th>
                                                                                            <th style="width: 5%;">
                                                                                                <asp:Label runat="server" ID="Label15" Text="Action" />
                                                                                            </th>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="8" align="center" id="tdbtnSave" runat="server" style="display: none;">
                                                                    <asp:Button runat="server" Text="Register Subjects with Sample" ID="btnSave" OnClick="btnSave_Click"
                                                                        OnClientClick="javascript:return SaveSubjectsList();" CssClass="btn" />
                                                                    <%-- <input type="button" id="btnSave" class="btn" style="width: 220px; height: 20px;"
                                                                        value="test" onclick="Test();" /> --%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <input id="hdnClientID" runat="server" type="hidden" />
                                                        <input id="hdnEpisodeID" runat="server" type="hidden" />
                                                        <input id="hdnOrgID" runat="server" type="hidden" />
                                                        <input id="hdnShippingCondition" runat="server" type="hidden" />
                                                        <input id="hdnCollectedDate" runat="server" type="hidden" />
                                                        <input id="hdnRateID" runat="server" type="hidden" />
                                                        <input id="hdnRateClientID" runat="server" type="hidden" />
                                                        <input id="hdnMappingClientID" runat="server" type="hidden" />
                                                        <input id="hdnLstobjPatient" runat="server" type="hidden" />
                                                        <input id="hdnLslstPatientDueChart" runat="server" type="hidden" />
                                                        <input id="hdnLslstInv" runat="server" type="hidden" />
                                                        <input id="hdnLslstFinalBill" runat="server" type="hidden" />
                                                        <input id="hdnLslstPatientInvSample" runat="server" type="hidden" />
                                                        <input id="hdnBaseClientID" runat="server" type="hidden" />
                                                        <input id="hdnBaseRateID" runat="server" type="hidden" />
                                                        <input id="hdnDeptID" runat="server" type="hidden" />
                                                        <input id="hdnConsignmentNo" runat="server" type="hidden" />
                                                        <input id="hdnPatientID" runat="server" type="hidden" />
                                                        <input id="hdnSelectedPatientTempDetails" runat="server" type="hidden" />
                                                        <input type="hidden" runat="server" value="N" id="hdnIsEditMode" />
                                                        <input type="hidden" runat="server" id="hdnConsignmentwithSampleCondition" />
                                                        <input type="hidden" id="hdnSelectedClientClientID" value="-1" runat="server" />
                                                        <input type="hidden" runat="server" id="hdnID" />
                                                        <input type="hidden" runat="server" id="hdnName" />
                                                        <input type="hidden" runat="server" id="hdnFeeTypeSelected" />
                                                        <input type="hidden" runat="server" id="hdnInvCode" />
                                                        <input type="hidden" runat="server" id="hdnIsOutSource" />
                                                        <input type="hidden" runat="server" id="hdnAmt" />
                                                        <input type="hidden" runat="server" id="hdnOrderedInvs" />
                                                        <input type="hidden" runat="server" id="hdnLslstPatientDueChartList" />
                                                        <input type="hidden" runat="server" id="hdnInvSampleMapping" />
                                                        <input type="hidden" runat="server" id="hdnPatientInvSampleMapping" />
                                                        <input type="hidden" runat="server" id="hdnLslstPatientInvSampleMapping" />
                                                        <input type="hidden" runat="server" id="hdnLslstInvestigationValues" />
                                                        <asp:HiddenField ID="hdnCheckFlag" runat="server" />
                                                        <asp:HiddenField ID="hdnClientFlag" runat="server" />
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/jquery.watermark.min.js" type="text/javascript"></script>

    <script src="../Scripts/EpisodeContainerSubjectTracking.js" type="text/javascript"></script>

    <%-- <script src="../Scripts/jquery.maskedinput-1.3.min.js" type="text/javascript"></script>--%>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">

    //$("#testtext").watermark(txtUserTitle);
    //    var txtUserTitle = 'dd-MM-yyyy hh:mm:ssAM/PM';
    //    $('input[id^="testtext"]').watermark(txtUserTitle);
    //    $('input[id^="testtext"]').mask(txtUserTitle);


    function getSittingEpisoe() {
        var OrgID = "<%=OrgID%>";
        var ClinetID = document.getElementById('hdnClientID').value;
        document.getElementById('hdnOrgID').value = OrgID
        var sval = OrgID + '~' + ClinetID + '~' + 'COM';
        $find('AutoCompleteSittingEpisode').set_contextKey(sval);

    }

    function countQuickAge(id) {
        //alert(document.getElementById(id).value);
        if (document.getElementById(id).value != '') {
            bD = document.getElementById(id).value.split('/');
            var agetemp = 0;
            dd = bD[0];
            mm = bD[1];
            yy = bD[2];
            main = "valid";
            if ((dd == "__") || (mm == "__") || (yy == "____")) {
                //document.getElementById('txtAge').value = '';
                return false;
            }
            if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
                main = "Invalid";
            else
                if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
                main = "Invalid";
            else
                if (mm == 2) {
                if (dd > 29)
                    main = "Invalid";
                else if ((dd > 28) && (!lyear(yy)))
                    main = "Invalid";
            }
            else
                if ((yy > 9999) || (yy < 0))
                main = "Invalid";
            else
                main = main;
            if (main == "valid") {
                function leapyear(a) {
                    if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
                        return true;
                    else
                        return false;
                }
                var days = new Date();

                var gdate = days.getDate();
                var gmonth = days.getMonth();
                var gyear = days.getFullYear();
                age = gyear - yy;
                if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
                    age = age;
                }
                else {
                    if (mm <= (gmonth)) {
                        age = age;
                    }
                    else {
                        age = age - 1;
                    }
                }
                if (age == 0)
                    age = age;
                agetemp = age;
                if (mm <= (gmonth + 1))
                    age = age - 1;
                if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
                    age = age + 1;
                var m;
                var n;
                if (mm == 12) { n = 31 - dd; }
                if (mm == 11) { n = 61 - dd; }
                if (mm == 10) { n = 92 - dd; }
                if (mm == 9) { n = 122 - dd; }
                if (mm == 8) { n = 153 - dd; }
                if (mm == 7) { n = 184 - dd; }
                if (mm == 6) { n = 214 - dd; }
                if (mm == 5) { n = 245 - dd; }
                if (mm == 4) { n = 275 - dd; }
                if (mm == 3) { n = 306 - dd; }
                if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
                if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
                if (gmonth == 1) m = 31;
                if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
                totdays = (parseInt(age) * 365);
                totdays += age / 4;
                totdays = parseInt(totdays) + gdate + m + n;
                months = age * 12;
                var t = parseInt(mm);
                months += 12 - mm;
                months += gmonth + 1;
                if (gmonth == 1) p = 31 + gdate;
                if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
                weeks = totdays / 7;
                weeks += " weeks";
                weeks = parseInt(weeks);
                if (agetemp <= 0) {
                    if (months <= 0) {
                        if (weeks <= 0) {
                            if (totdays >= 0) {
                                if (totdays == 1) {
                                    document.getElementById('txtDOBNos').value = totdays;
                                    document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                                }
                                else {
                                    document.getElementById('txtDOBNos').value = totdays;
                                    document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                                }
                            }
                        }
                        else {
                            if (weeks == 1) {
                                document.getElementById('txtDOBNos').value = weeks;
                                document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                            }
                            else {
                                document.getElementById('txtDOBNos').value = weeks;
                                document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                            }
                        }
                    }
                    else {
                        if (months == 1) {
                            document.getElementById('txtDOBNos').value = months;
                            document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                        }
                        else {
                            document.getElementById('txtDOBNos').value = months;
                            document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                        }
                    }
                }
                else {
                    if (agetemp == 1) {
                        document.getElementById('txtDOBNos').value = agetemp;
                        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                    }
                    else {
                        document.getElementById('txtDOBNos').value = agetemp;
                        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                    }
                }

                function lyear(a) {
                    if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                    else return false;
                }
                //document.getElementById('ddlSex').focus();
            }
            else {
                alert(main + ' Date');
                document.getElementById('txtDOBNos').value = '';
                document.getElementById('tDOB').value = '';
                document.getElementById('tDOB').value = '__/__/____';
                document.getElementById('tDOB').focus();
            }
        }
    }

    function getDOB() {
        if (document.getElementById('txtDOBNos').value == '') {
            alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        return true;
    }
    function ClearDOB() {

        if (document.getElementById('txtDOBNos').value <= 0) {
            document.getElementById('txtDOBNos').value = '';
        }
        if (document.getElementById('txtDOBNos').value >= 150) {
            alert('Provide a valid year');
            document.getElementById('tDOB').value = '__/__/____';
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('txtDOBNos').focus();
            return false;
        }
    }
</script>

