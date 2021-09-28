<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabReport.aspx.cs" Inherits="Investigation_LabReport"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientAccessHeader.ascx" TagName="AdminHeader"
    TagPrefix="uc100" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .notification-bubble
        {
            background-color: #F56C7E;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.17) inset, 0 1px 1px rgba(0, 0, 0, 0.2);
            color: #FFFFFF;
            font-size: 9px;
            font-weight: bold;
            text-align: center;
            text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.2);
            -moz-transition: all 0.1s ease 0s;
            padding: 2px 3px 2px 3px;
        }
        .OutSrce
        {
            background-color: #D0FA58;
        }
    </style> 
    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
</head>
<body id="oneColLayout">
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" src=" " class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
                <uc100:AdminHeader ID="Header1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td valign="top" id="menu" style="display: block; width: 15%;" runat="server">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        runat="server" style="cursor: pointer;" />
                    <asp:UpdatePanel ID="udp1" runat="server">
                        <ContentTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
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
                                <table id="tblPatient" runat="server" width="100%" border="0" cellpadding="2" cellspacing="2">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel3" Width="100%" DefaultButton="btnSearch" BorderWidth="0px" runat="server"
                                                meta:resourcekey="Panel3Resource1">
                                                <div style="display: block; width: 100%" class="dataheader2">
                                                    <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblVisitNo" Text="Visit No" runat="server" meta:resourcekey="lblVisitNoaResource1"></asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtVisitNo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtVisitNoResource1"></asp:TextBox>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:Label ID="lblName" Text="Patient Name" runat="server" meta:resourcekey="lblNamesResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:TextBox ID="txtName" CssClass="Txtboxsmall" OnChange="javascript:GetText(document.getElementById('txtName').value);"
                                                                    runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                <div id="DivPatientName">
                                                                </div>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtName"
                                                                    FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                    MinimumPrefixLength="1" ServiceMethod="GetPatientListNameandID" ServicePath="~/InventoryWebService.asmx"
                                                                    DelimiterCharacters="" Enabled="True" CompletionListElementID="DivPatientName"
                                                                    OnClientShown="setAceWidth" OnClientItemSelected="SelectPatientName">
                                                                </cc1:AutoCompleteExtender>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:Label ID="lblMobile" Text="Contact No" runat="server" meta:resourcekey="lblconResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:TextBox ID="txtMobile" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trClient" style="display: block" runat="server">
                                                            <td>
                                                                <asp:Label ID="lblclient" Text="Client" runat="server" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox CssClass="Txtboxsmall" ID="txtClientName" runat="server" onBlur="return ClearFields();"
                                                                    meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                                <div id="aceClient">
                                                                </div>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                                    BehaviorID="AutoCompleteExLstGrp" CompletionListCssClass="wordWheel listMain .box"
                                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True"
                                                                    ServiceMethod="GetClientList" OnClientItemSelected="SelectedClientValue" ServicePath="~/WebService.asmx"
                                                                    DelimiterCharacters="" Enabled="True" CompletionListElementID="aceClient" OnClientShown="setAceWidth">
                                                                </cc1:AutoCompleteExtender>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblReferringPhysician" Text="Ref.Dr" runat="server" meta:resourcekey="lblReferPhysicianResource1"></asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="Txtboxsmall"
                                                                    onBlur="return ClearFields();" meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                                                                <div id="aceReferDR">
                                                                </div>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" TargetControlID="txtInternalExternalPhysician"
                                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                                    ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="GetReferingPhysicianID"
                                                                    DelimiterCharacters="" Enabled="True" CompletionListElementID="aceReferDR" OnClientShown="setAceWidth">
                                                                </cc1:AutoCompleteExtender>
                                                                <asp:HiddenField ID="hdnPhysicianValue" Value="0" runat="server"></asp:HiddenField>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblddlocation" Text="Reg.Location" runat="server" meta:resourcekey="lblddreglocationResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <span class="richcombobox" style="width: 155px;">
                                                                    <asp:DropDownList ID="ddlocation" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddlocationResource2">
                                                                    </asp:DropDownList>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr id="trDepartment" runat="server">
                                                            <td>
                                                                <asp:Label ID="Label10" Text="Department" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <span class="richcombobox" style="width: 155px;">
                                                                    <asp:DropDownList ID="drpdepartment" CssClass="ddl" Width="155px" runat="server"
                                                                        meta:resourcekey="drpdepartmentResource1">
                                                                    </asp:DropDownList>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTestName" Text="Test Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                                                    meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                                                <div id="aceDiv">
                                                                </div>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderTestName" MinimumPrefixLength="2"
                                                                    runat="server" TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg"
                                                                    ServicePath="~/WebService.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11"
                                                                    CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain1"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                                    OnClientItemSelected="SelectedTest" DelimiterCharacters="" CompletionListElementID="aceDiv"
                                                                    OnClientShown="setAceWidth">
                                                                </cc1:AutoCompleteExtender>
                                                                <asp:HiddenField ID="hdnTestID" Value="0" runat="server"></asp:HiddenField>
                                                                <asp:HiddenField ID="hdnTestType" runat="server"></asp:HiddenField>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label7" Text="Zone" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtzone" runat="server" CssClass="Txtboxsmall" AutoComplete="off"
                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onBlur="return ClearFields();"
                                                                    meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                                                <div id="Divzone">
                                                                </div>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                                                    OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                    Enabled="True" CompletionListElementID="Divzone" OnClientShown="setAceWidth">
                                                                </cc1:AutoCompleteExtender>
                                                                <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblStatus" Text="Visit Status" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <span class="richcombobox" style="width: 155px;">
                                                                    <asp:DropDownList ID="ddstatus" runat="server" CssClass="ddl" Width="155px">
                                                                        <asp:ListItem Text="---Select---" Value="---Select---"></asp:ListItem>
                                                                        <asp:ListItem Text="Approved" Value="Approve"></asp:ListItem>
                                                                        <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                                                                        <%--<asp:ListItem Text="Pending" Value="Pending" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                                                    </asp:DropDownList>
                                                                </span>
                                                            </td>
                                                            <td valign="top">
                                                                <asp:Label ID="Rs_RegisteredDate" runat="server" Text="Registered Date" meta:resourcekey="Rs_RegisteredDateResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                                                                <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                                                                <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                                                                <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                                                                <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                                                                <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                                                                <asp:HiddenField ID="hdnDateImage" runat="server" />
                                                                <asp:HiddenField ID="hdnTempFrom" runat="server" />
                                                                <asp:HiddenField ID="hdnTempTo" runat="server" />
                                                                <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                                <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                                <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                                                                <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                                                                <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                                                                <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                                                                <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                                                                <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                                                                <asp:HiddenField ID="hdnActionCount" runat="server" />
                                                                <asp:HiddenField runat="server" ID="hdnloginRoleName" />
                                                            </td>
                                                            <td>
                                                                <span class="richcombobox" style="width: 155px;">
                                                                    <asp:DropDownList ID="ddlRegisterDate" CssClass="ddl" Width="155px" onChange="javascript:return ShowRegDate();"
                                                                        runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                                                    </asp:DropDownList>
                                                                </span>
                                                                <div id="divRegDate" style="display: none" runat="server">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_FromDate" runat="server" Text="From Date" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_ToDate" runat="server" Text="To Date" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div id="divRegCustomDate" runat="server" style="display: none;">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                    ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                                                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                                    CultureTimePlaceholder="" Enabled="True" />
                                                                                <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                    ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr id="trhide1" runat="server">
                                                            <td width="15%">
                                                                <asp:Label runat="server" ID="lblPatientNo" Text="Patient No" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                            </td>
                                                            <td width="15%">
                                                                <asp:TextBox ID="txtPatientNo" onKeyPress="onEnterKeyPress(event);" MaxLength="16"
                                                                    runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                                                            </td>
                                                            <td id="tdlblLabNo" runat="server">
                                                                <asp:Label ID="lblLabNo" Text="Lab No" runat="server" meta:resourcekey="lblLabNoResource1"></asp:Label>
                                                            </td>
                                                            <td id="tdtxtLabNo" runat="server">
                                                                <asp:TextBox ID="txtLabNo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtLabNoResource1"></asp:TextBox>
                                                            </td>
                                                            <td id="tdlblddVisittype" runat="server">
                                                                <asp:Label ID="lblddVisittype" Text="Visit Type" runat="server" meta:resourcekey="lblddVisittypeResource1"></asp:Label>
                                                            </td>
                                                            <td id="tdrichcombobox" runat="server">
                                                                <span class="richcombobox" style="width: 155px;">
                                                                    <asp:DropDownList ID="ddVisitType" CssClass="ddl" Width="155px" runat="server" meta:resourcekey="ddVisitTypeResource1">
                                                                        <asp:ListItem Text="---Select---" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                        <asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr id="trhide3" runat="server">
                                                            <td id="tdlblRefOrg" runat="server">
                                                                <asp:Label ID="lblRefOrg" Text="Referring Organization" runat="server" meta:resourcekey="lblRefOrgResource1"></asp:Label>
                                                            </td>
                                                            <td id="tdtxtReferringHospital" runat="server">
                                                                <asp:TextBox ID="txtReferringHospital" runat="server" CssClass="Txtboxsmall" onBlur="return ClearFields();"
                                                                    meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                                    TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                                                    CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                    ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingOrgID"
                                                                    DelimiterCharacters="" Enabled="True">
                                                                </cc1:AutoCompleteExtender>
                                                                <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <%-- <tr>--%>
                                                            <td class="colorforcontent">
                                                                <div id="Div5" runat="server">
                                                                    &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                        onclick="showsearch()" style="cursor: pointer" />
                                                                    <span class="dataheader1txt" style="cursor: pointer">&nbsp;<asp:Label ID="Label2"
                                                                        runat="server" Text="More Search Options" onclick="showsearch()" meta:resourcekey="lblinvfilter1Resource1"></asp:Label></span></div>
                                                                <div id="Div6" style="display: none;" runat="server">
                                                                    &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                        onclick="Hidesearch()" style="cursor: pointer" />
                                                                    <span class="dataheader1txt" style="cursor: pointer">
                                                                        <asp:Label ID="Label4" runat="server" Text="Hide Search Options" onclick="Hidesearch()"
                                                                            meta:resourcekey="lblinvfilters1Resource1"></asp:Label></span></div>
                                                            </td>
                                                            <%--</tr>--%>
                                                            <td colspan="1" align="right" valign="middle">
                                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" OnClick="btnSearch_Click" TabIndex="13" meta:resourcekey="btnSearchResource1" />
                                                            </td>
                                                            <td colspan="1" align="left" valign="middle">
                                                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" TabIndex="14" OnClientClick="return ClearSearchFields();" />
                                                            </td>
                                                            <td colspan="3" align="left">
                                                                <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                                                    <ProgressTemplate>
                                                                        <div id="progressBackgroundFilter">
                                                                        </div>
                                                                        <asp:Image ID="imgProgressbar2" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                                        <asp:Label ID="Rs_Pleasewait2" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <div align="center">
                                </div>
                                <table id="tblgrdview" width="100%" runat="server" style="display: none;">
                                    <tr align="center">
                                        <td id="tdprevdue" runat="server" style="display: block;" colspan="5">
                                            <asp:Label ID="lblpreviousdue" runat="server" ForeColor="Red" Text="0" meta:resourcekey="lblpreviousdueResource1" />
                                        </td>
                                    </tr>
                                    <tr class="tablerow" id="ACX2responses3" style="display: block;">
                                        <td>
                                            <table style="width: 100%">
                                                <tr style="width: 100%">
                                                    <td>
                                                        <div id="divgv">
                                                            <table cellpadding="0" id="tabgrdResult" runat="server" cellspacing="0" style="padding: 15px;"
                                                                border="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <table border="1" id="GrdHeader" runat="server" style="display: block" width="100%">
                                                                            <tr class="dataheader1">
                                                                                <td align="center" style="width: 5%">
                                                                                    <asp:Label ID="RdSel" runat="server" Text="Select"></asp:Label>
                                                                                </td>
                                                                                <td align="center" style="width: 6%">
                                                                                    <asp:Label ID="Rs_Select" runat="server" Text="Print" meta:resourcekey="Rs_SelectResource1"></asp:Label>
                                                                                </td>
                                                                                <td align="center" style="width: 10%">
                                                                                    <asp:Label ID="lblVisitnos" runat="server" Text="Visit Number" meta:resourcekey="Rs_Visitno1Resource1"></asp:Label>
                                                                                </td>
                                                                                <td align="center" style="width: 13%">
                                                                                    <asp:Label ID="Rs_Name" runat="server" Text="Patient Name" meta:resourcekey="Rs_NamesResource1"></asp:Label>
                                                                                </td>
                                                                                <td align="center" style="width: 8%">
                                                                                    <asp:Label ID="Rs_Age" runat="server" Text="Gender/Age" meta:resourcekey="Rs_Age1Resource1"></asp:Label>
                                                                                </td>
                                                                                <td align="center" style="width: 10%">
                                                                                    <asp:Label ID="Rs_URNNo" runat="server" Text="VisitDate" meta:resourcekey="Rs_URNNoResource1"></asp:Label>
                                                                                </td>
                                                                                <td runat="server" align="center" id="tdorg" style="width: 15%">
                                                                                    <asp:Label ID="Rs_ToBePerformStatus" runat="server" Text="RefPhysicianName" meta:resourcekey="Rs_ToBePerformStatusResource1"></asp:Label>
                                                                                </td>
                                                                                <td runat="server" id="td12" align="center" style="width: 15%">
                                                                                    <asp:Label ID="Label9" runat="server" Text="Reg.Location" meta:resourcekey="Label9RegResource1"></asp:Label>
                                                                                </td>
                                                                                <td runat="server" id="td17" align="center" style="width: 12%">
                                                                                    <asp:Label ID="Label22" runat="server" Text="Client" meta:resourcekey="LabelclResource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table style="width: 100%; border-collapse: collapse;" rules="all" cellspacing="0"
                                                                            cellpadding="0">
                                                                            <asp:Repeater ID="grdResult1" runat="server" OnItemDataBound="grdResult1_ItemDataBound">
                                                                                <ItemTemplate>
                                                                                    <tr id="Tr1" runat="server" style="height: 30px;">
                                                                                        <td id="Td1" style="width: 5%;" nowrap="nowrap" align="center" runat="server">
                                                                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                                                        </td>
                                                                                        <td id="printimage" align="center" style="width: 3%" runat="server">
                                                                                            <img id="imgPrintReport" title="Print" runat="server" alt="Print" visible="false"
                                                                                                src="~/Images/printer.gif" style="cursor: pointer;" />
                                                                                            <asp:ImageButton ID="Image1" ImageUrl="../Images/WithStationary.ico" runat="server"
                                                                                                ToolTip="WithStationary" CommandName="ShowWithStationary" Style="cursor: pointer;
                                                                                                margin-left: 10px" OnClientClick="javascript:return GetDataForPrint(this);" />
                                                                                        </td>
                                                                                        <td id="printimage1" align="center" style="width: 3%" runat="server">
                                                                                            <asp:ImageButton ID="ImageButton1" ImageUrl="../Images/printer.gif" runat="server"
                                                                                                ToolTip="WithoutStationary" CommandName="ShowWithoutStationary" Style="cursor: pointer;
                                                                                                margin-left: 10px" OnClientClick="javascript:return GetDataForPrint(this);" />
                                                                                        </td>
                                                                                        <td id="PatientNumber" align="center" style="display: none" nowrap="nowrap" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                                                        </td>
                                                                                        <td id="Td16" align="center" style="width: 11%" nowrap="nowrap" runat="server">
                                                                                            <asp:LinkButton ID="Button1" runat="server" Text='<%#Eval("VisitNumber") %>' Style="color: Blue"
                                                                                                OnClientClick='<%# String.Format("ShowPopUp({0});return false;",Eval("VisitNumber"))%> ' />
                                                                                        </td>
                                                                                        <td id="PatientName" align="left" style="width: 14%" runat="server">
                                                                                            <asp:ImageButton ID="imgClick" ToolTip="Click here To View Visit details" runat="server"
                                                                                                ImageUrl="~/Images/plus.png" CommandName="ShowChild" OnClientClick="javascript:return GetData(this);" />
                                                                                            <%# DataBinder.Eval(Container.DataItem, "PatientName")%>
                                                                                        </td>
                                                                                        <td id="Age" align="left" width="9%" runat="server">
                                                                                            <asp:Label ID="lblAge" runat="server" Text='<%# Bind("PatientAge") %>'></asp:Label>
                                                                                        </td>
                                                                                        <td id="VisitDate" align="left" style="width: 11%" nowrap="nowrap" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "VisitDate")%>
                                                                                        </td>
                                                                                        <td id="ReferingPhysicianName" align="left" style="width: 15%" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "ReferingPhysicianName")%>
                                                                                        </td>
                                                                                        <td id="Location" align="left" style="width: 16%" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "Location")%>
                                                                                        </td>
                                                                                        <td id="Client" align="left" style="width: 15%" runat="server">
                                                                                            <%# DataBinder.Eval(Container.DataItem, "ClientName")%>
                                                                                        </td>
                                                                                        <td id="PatientVisitId" align="left" style="display: none" runat="server">
                                                                                            <asp:TextBox ID="txtPatientvisitId" Text='<%# Bind("PatientVisitId") %>' runat="server"></asp:TextBox>
                                                                                            <asp:TextBox ID="txtDispatch" Text='<%# Bind("Remarks") %>' runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                        <td id="Td14" align="left" style="display: none" runat="server">
                                                                                            <asp:TextBox ID="txtpatientId" Text='<%# Bind("PatientID") %>' runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <cc1:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                                                BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                                            </cc1:ModalPopupExtender>
                                                            <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
                                                                vertical-align: bottom; top: 80px;">
                                                                <table width="100%" align="center">
                                                                    <tr>
                                                                        <td align="right">
                                                                            <img src="../Images/Close_Red_Online_small.png" alt="Close" id="img2" onclick="ClosePopUp()"
                                                                                style="width: 5%; height: 5%; cursor: pointer;" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table style="width: 100%;">
                                    <div id="tblpage" runat="server" style="width: 100%;">
                                        <tr id="trFooter" runat="server" class="dataheaderInvCtrl">
                                            <td align="center" colspan="2" class="defaultfontcolor">
                                                <div id="divFooterNav" runat="server">
                                                    <asp:Label ID="Label12" runat="server" Text="Page"></asp:Label>
                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                    <asp:Label ID="Label13" runat="server" Text="Of"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                                                        CssClass="btn" meta:resourcekey="Btn_PreviousResource1" Style="width: 71px" />
                                                    <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                                                        meta:resourcekey="Btn_NextResource1" />
                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                    <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                    <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                    <asp:Label ID="Label14" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                        meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                    <asp:Button ID="Button1" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                                                        OnClick="btnGo_Click1" CssClass="btn" meta:resourcekey="btnGoResource1" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="trSelectVisit" runat="server" visible="false" align="center">
                                            <td class="defaultfontcolor">
                                                <asp:Label ID="lblSelectapatientvisit" runat="server" Text=" Select a patient visit"
                                                    meta:resourcekey="lblSelectapatientvisitResource1"></asp:Label>
                                                <asp:DropDownList ID="ddlVisitActionName" runat="server" Visible="False" meta:resourcekey="ddlVisitActionNameResource1">
                                                </asp:DropDownList>
                                                <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                                <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                                                <cc1:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                                                    TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                                                    CancelControlID="imgPDFReportPreview" DynamicServicePath="" Enabled="True">
                                                </cc1:ModalPopupExtender>
                                                <asp:Panel ID="pnlReportPreview" BorderWidth="1px" Height="500px" Width="1000px"
                                                    CssClass="modalPopup dataheaderPopup" runat="server" meta:resourcekey="pnlShowReportPreviewResource1"
                                                    Style="display: none">
                                                    <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="right" valign="middle" class="defaultfontcolor">
                                                                    <asp:Button ID="btnpdf" runat="server" Text="Print" OnClientClick="return pdfPrint();"
                                                                        CssClass="btn" Height="18px" OnClick="btnGo_Click" />
                                                                    &nbsp;&nbsp;
                                                                    <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" runat="server"
                                                                        alt="Close" style="cursor: pointer; height: 18Px;" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                    <table width="100%">
                                                        <tr>
                                                            <td valign="top">
                                                                <table id="Table2" runat="server" width="100%">
                                                                    <tr id="Tr8" runat="server">
                                                                        <td id="Td15" class="colorforcontent" style="width: 30%;" height="23" align="left"
                                                                            runat="server">
                                                                            <div id="Div3" style="display: block;">
                                                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                    style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',1);
                                                                                    showResponses('Div55','Div66','ACX3responses22',0);" />
                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',1);
                                                                                showResponses('Div55','Div66','ACX3responses22',0);">&nbsp;<asp:Label ID="Label16"
                                                                                    runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label>
                                                                                </span>
                                                                            </div>
                                                                            <div id="Div4" style="display: none;">
                                                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                    style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',0);showResponses('Div55','Div66','ACX3responses22',1);" />
                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div3','Div4','tblReportDetails',0);
                                                                                showResponses('Div55','Div66','ACX3responses22',1);">
                                                                                    <asp:Label ID="Label17" runat="server" Text=" Lab Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label>
                                                                                </span>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table id="tblReportDetails" style="display: none;" width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <ucPatientdet:PatientDetails ID="uctPatientDetail1" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center">
                                                                            <asp:GridView ID="grdPatientView" Width="70%" runat="server" CellSpacing="1" CellPadding="1"
                                                                                AllowPaging="True" PageSize="5" AutoGenerateColumns="False" ForeColor="#333333"
                                                                                CssClass="mytable1" OnRowDataBound="grdPatientView_RowDataBound" DataKeyNames="PatientID,PatientVisitID">
                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Patient Report">
                                                                                        <ItemTemplate>
                                                                                            <div align="center">
                                                                                                <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                                                    cellspacing="1" border="1" width="100%">
                                                                                                    <tr>
                                                                                                        <td align="right" style="width: 25%; background-color: #3a86da;">
                                                                                                            <asp:Label ID="lblVisitDate" runat="server" Text="Visit Date" ForeColor="White"></asp:Label>
                                                                                                        </td>
                                                                                                        <td align="left" style="width: 25%; background-color: #3a86da;">
                                                                                                            <asp:Label ID="lblDate" runat="server" Text='<%#  Eval("VisitDate")%>' ForeColor="White"></asp:Label>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="2" align="center">
                                                                                                            <asp:GridView ID="grdOrderedinv" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                                                PageSize="100" ForeColor="Black" GridLines="Both" Width="99%" CssClass="mytable1">
                                                                                                                <Columns>
                                                                                                                    <asp:TemplateField HeaderText="Test Name">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblTestName" runat="server" Text='<%# bind("Name") %>' />
                                                                                                                            <asp:Label CssClass="notification-bubble" runat="server" ID="lblPrintCount1" Text='<%# Eval("RoundNo").ToString()=="0" ? "0" : Eval("RoundNo").ToString() %> '></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="Status" HeaderText="Test Status" />
                                                                                                                    <asp:BoundField DataField="ReportStatus" HeaderText="Report Status" />
                                                                                                                    <asp:BoundField Visible="false" DataField="Priority" HeaderText="Priority" />
                                                                                                                </Columns>
                                                                                                            </asp:GridView>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Priority Report"
                                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" OnClientClick="return PriorityValidation();"
                                                                                OnClick="btnGenerateReport_Click" onmouseout="this.className='btn'" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td class="colorforcontent" style="width: 30%;" height="23" align="left">
                                                                            <div id="Div55" style="display: none;">
                                                                                &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                    style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                                    &nbsp;<asp:Label ID="Label18" runat="server" Text="Show PDF"></asp:Label></span></div>
                                                                            <div id="Div66" style="display: block;">
                                                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                    style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div55','Div66','ACX3responses22',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                                    <asp:Label ID="Label20" runat="server" Text="PDF Viewer"></asp:Label></span></div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table id="ACX3responses22">
                                                                    <tr>
                                                                        <td align="left">
                                                                            <div id="Divpdf" runat="server" style="width: 99%; height: auto;">
                                                                                <iframe runat="server" id="frameReportPreview" name="myname" style="width: 985px;
                                                                                    height: 400px; border: 0px; overflow: none;"></iframe>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMessage1" runat="server" meta:resourcekey="lblMessage1Resource1"></asp:Label>
                                                <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                                            </td>
                                        </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                                meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                            <cc1:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                                TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                                CancelControlID="imgCloseReport" DynamicServicePath="" Enabled="True">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" Width="90%" ScrollBars="Vertical"
                                                CssClass="modalPopup dataheaderPopup" runat="server" meta:resourcekey="pnlAttribResource1"
                                                Style="display: none">
                                                <asp:Panel ID="Panel2" runat="server" Style="padding: 2px; height: 25px;" meta:resourcekey="Panel1Resource1">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="center">
                                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                                    <ProgressTemplate>
                                                                        <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                                        <asp:Label ID="Rs_Pleasewait1" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblHint" runat="server" Font-Bold="True" Text="Hint: " meta:resourcekey="lblHintResource1" />
                                                                <span class="notification-bubble">&nbsp;&nbsp;</span>
                                                                <asp:Label ID="lblPrintCountHint" runat="server" Font-Bold="True" Text=" => Report print count"
                                                                    meta:resourcekey="lblPrintCountHintResource1" />
                                                            </td>
                                                            <td align="right">
                                                                <img id="imgCloseReport" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                                    style="cursor: pointer;" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <table width="100%">
                                                    <tr>
                                                        <td valign="top">
                                                            <table id="tblReport" runat="server" width="90%">
                                                                <tr id="Tr3" runat="server">
                                                                    <td id="Td3" class="colorforcontent" style="width: 30%;" height="23" align="left"
                                                                        runat="server">
                                                                        <div id="ACX3plus1" style="display: none;">
                                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);" />
                                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);">
                                                                                &nbsp;<asp:Label ID="lblReportTemplate" runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                                        <div id="ACX3minus1" style="display: block;">
                                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);" />
                                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);">
                                                                                <asp:Label ID="Label5" runat="server" Text="Report Details" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="ACX3responses1" style="display: block;" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <ucPatientdet:PatientDetails ID="uctPatientDetail" runat="server" />
                                                                        <asp:Label ID="lbluctPatientDetail" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td id="chdept" runat="server" style="display: none;">
                                                                        <asp:CheckBoxList ID="chkDept" runat="server" RepeatColumns="5" onclick="javascript:dispTask(this.id);"
                                                                            meta:resourcekey="chkDeptResource1">
                                                                        </asp:CheckBoxList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td id="lnkshwrpt" runat="server" style="display: none; color: Black;">
                                                                        <asp:Label ID="lblClickHere" runat="server" Text="Click Here !" meta:resourcekey="lblClickHereResource1"></asp:Label>
                                                                        <asp:LinkButton ID="lnkShowRecord" runat="server" ForeColor="Black" Font-Bold="True"
                                                                            Font-Underline="True" OnClick="lnkShowRecord_Click" meta:resourcekey="lnkShowRecordResource1"
                                                                            Text="DepartmentWise Filter Report "></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <table width="100%" id="tblResults" runat="server" border="0" cellpadding="0" cellspacing="0">
                                                                            <tr id="Tr4" runat="server">
                                                                                <td id="Td4" runat="server">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="width: 5%">
                                                                                                <img src="../Images/collapse_blue.jpg" id="imgClick" title="Show Report Template"
                                                                                                    style="display: none;" runat="server" onclick="javascript:return ShowReportDiv();" />
                                                                                            </td>
                                                                                            <td style="width: 95%">
                                                                                                <asp:Label runat="server" ID="lblHead" Text="Show Report Template" Style="display: none;"
                                                                                                    meta:resourcekey="lblHeadResource1"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr id="Tr5" runat="server">
                                                                                <td id="Td5" runat="server">
                                                                                    <div id="dReport" runat="server">
                                                                                        <asp:DataList ID="grdResultTemp" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                            RepeatColumns="2" OnItemDataBound="grdResultTemp_ItemDataBound" RepeatDirection="Horizontal"
                                                                                            OnItemCommand="grdResultTemp_ItemCommand" meta:resourcekey="grdResultTempResource1">
                                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                            <ItemTemplate>
                                                                                                <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                                                    cellspacing="0" border="0">
                                                                                                    <tr>
                                                                                                        <td valign="top">
                                                                                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;"
                                                                                                                cellspacing="0" border="0" width="100%">
                                                                                                                <tr>
                                                                                                                    <td style="height: 20px;" class="Duecolor">
                                                                                                                        <table width="100%">
                                                                                                                            <tr>
                                                                                                                                <td align="left">
                                                                                                                                    <asp:Label ID="lblReport" runat="server" Text=" Report" meta:resourcekey="lblReportResource1"></asp:Label>
                                                                                                                                </td>
                                                                                                                                <td>
                                                                                                                                    <asp:CheckBox ID="chkEnableAll" runat="server" meta:resourcekey="chkEnableAllResource1" />
                                                                                                                                    <asp:Label ID="lblEnableALL" runat="server" Text="Reprint" meta:resourcekey="lblEnableALLResource1"></asp:Label>
                                                                                                                                </td>
                                                                                                                                <td align="right">
                                                                                                                                    &nbsp<asp:CheckBox ID="chkSelectAll" runat="server" meta:resourcekey="chkSelectAllResource1" />
                                                                                                                                    <asp:Label ID="lblSelectALL" runat="server" Text="Selectall" meta:resourcekey="lblSelectALLResource1"></asp:Label>
                                                                                                                                    <asp:Label runat="server" ID="lblReportID" Style="display: none" Text='<%# Eval("TemplateID") %>'
                                                                                                                                        meta:resourcekey="lblReportIDResource1"></asp:Label>
                                                                                                                                    <asp:Label runat="server" ID="lblReportname" Style="display: none" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                        meta:resourcekey="lblReportnameResource1"></asp:Label>
                                                                                                                                </td>
                                                                                                                            </tr>
                                                                                                                        </table>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;"
                                                                                                                cellspacing="0" border="0" width="100%">
                                                                                                                <tr>
                                                                                                                    <td style="font-weight: normal;">
                                                                                                                        <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                                                            OnItemDataBound="grdResultDate_ItemDataBound" OnItemCommand="grdResultDate_ItemCommand"
                                                                                                                            RepeatColumns="2" RepeatDirection="Horizontal" meta:resourcekey="grdResultDateResource1">
                                                                                                                            <ItemStyle VerticalAlign="Top" />
                                                                                                                            <ItemTemplate>
                                                                                                                                <table>
                                                                                                                                    <tr>
                                                                                                                                        <td>
                                                                                                                                            <asp:Label runat="server" Font-Bold="True" ID="lblCreatedAt" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                                                                                                                            <asp:Label runat="server" ID="lblDtReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                                                                meta:resourcekey="lblDtReportIDResource1"></asp:Label>
                                                                                                                                            <asp:Label runat="server" ID="lbldtReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                                meta:resourcekey="lbldtReportnameResource1"></asp:Label>
                                                                                                                                        </td>
                                                                                                                                    </tr>
                                                                                                                                    <tr>
                                                                                                                                        <td style="font-weight: normal;">
                                                                                                                                            <asp:DataList ID="dlChildInvName" RepeatColumns="1" runat="server" OnItemCommand="dlChildInvName_ItemCommand"
                                                                                                                                                OnItemDataBound="dlChildInvName_ItemDataBound" Width="100%" meta:resourcekey="dlChildInvNameResource1">
                                                                                                                                                <ItemStyle VerticalAlign="Top" />
                                                                                                                                                <ItemTemplate>
                                                                                                                                                    <table>
                                                                                                                                                        <tr>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:CheckBox ID="ChkBox" onclick="javascript:return ChkIfSelected(this.id);" runat="server"
                                                                                                                                                                    meta:resourcekey="ChkBoxResource1" />
                                                                                                                                                            </td>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:Label runat="server" ID="lblInvname" Text='<%# Eval("InvestigationName") %> '
                                                                                                                                                                    meta:resourcekey="lblInvnameResource1"></asp:Label>
                                                                                                                                                                <asp:Label CssClass="notification-bubble" runat="server" ID="lblPrintCount" Text='<%# Eval("PrintCount").ToString()=="0" ? "0" : Eval("PrintCount").ToString() %> '></asp:Label>
                                                                                                                                                                <asp:Label runat="server" Style="display: none" ID="lblInvID" Text='<%# Eval("InvestigationID") %>'
                                                                                                                                                                    meta:resourcekey="lblInvIDResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblReportID" Style="display: none" Text='<%# Eval("TemplateID") %>'
                                                                                                                                                                    meta:resourcekey="lblReportIDResource2"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblReportname" Style="display: none" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                                                                                    meta:resourcekey="lblReportnameResource2"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblAccessionNo" Style="display: none" Text='<%# Eval("AccessionNumber") %>'
                                                                                                                                                                    meta:resourcekey="lblAccessionNoResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblPatientID" Style="display: none" Text='<%# Eval("PatientID") %>'
                                                                                                                                                                    meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lbldeptid" Style="display: none" Text='<%# Eval("DeptID") %>'
                                                                                                                                                                    meta:resourcekey="lbldeptidResource1"></asp:Label>
                                                                                                                                                                <asp:Label runat="server" ID="lblStatus" Style="display: none" Text='<%# Eval("Status") %>'
                                                                                                                                                                    meta:resourcekey="lblStatusResource2"></asp:Label>
                                                                                                                                                                <asp:Label ID="lblPackageName" runat="server" Text=""></asp:Label>
                                                                                                                                                            </td>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                                                                                                                                    runat="server" Visible="False" Text="Show" CommandName="ShowReport" meta:resourcekey="lnkShowResource1"
                                                                                                                                                                    OnClientClick="return ShowHideReport();"></asp:LinkButton>
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                    </table>
                                                                                                                                                </ItemTemplate>
                                                                                                                                            </asp:DataList>
                                                                                                                                        </td>
                                                                                                                                    </tr>
                                                                                                                                </table>
                                                                                                                            </ItemTemplate>
                                                                                                                        </asp:DataList>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="color: #000000; height: 20px;" align="center">
                                                                                                                        <asp:LinkButton ID="lnkShowReport" ForeColor="Black" runat="server" Text="ShowReport"
                                                                                                                            CommandName="ShowReport" Font-Underline="True" OnClientClick="javascript:return ValidateCheckBox();ShowHideReport();"
                                                                                                                            meta:resourcekey="lnkShowReportResource1"></asp:LinkButton>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </ItemTemplate>
                                                                                        </asp:DataList>
                                                                                    </div>
                                                                                </td>
                                                                                <td id="Td6" runat="server">
                                                                                    <table runat="server" border="0" visible="False" style="background-color: #fcecb6"
                                                                                        id="tblcontent">
                                                                                        <tr id="Tr6" runat="server">
                                                                                            <td id="Td7" class="alterimg" runat="server">
                                                                                            </td>
                                                                                            <td id="Td8" runat="server">
                                                                                                <b>
                                                                                                    <asp:Label ID="lblinstallviewer" runat="server" Text="If you are viewing the images for the first time, please install the viewer."
                                                                                                        meta:resourcekey="lblinstallviewerResource1"></asp:Label>
                                                                                                </b>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr id="Tr7" runat="server">
                                                                                            <td id="Td9" runat="server">
                                                                                                &nbsp;
                                                                                            </td>
                                                                                            <td id="Td10" runat="server">
                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <img src="../Images/box_menu_bullet.png" runat="server" id="imgInstallExe" alt="error" />
                                                                                                            <asp:HyperLink Font-Bold="True" ForeColor="Black" runat="server" ID="lnkInstall"
                                                                                                                Text="Click to download & install Viewer" meta:resourcekey="lnkInstallResource1"></asp:HyperLink>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgInsGuide" />
                                                                                                            <asp:LinkButton runat="server" Font-Bold="True" OnClick="lnkInsguide_Click" ForeColor="Black"
                                                                                                                ID="lnkInsguide" Text="Click to view the Installation Guide" meta:resourcekey="lnkInsguideResource1"></asp:LinkButton>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgUserGuide" />
                                                                                                            <asp:LinkButton runat="server" OnClick="lnkUserGuide_Click" Font-Bold="True" ForeColor="Black"
                                                                                                                ID="lnkUserGuide" Text="Click to view the Viewer User Guide" meta:resourcekey="lnkUserGuideResource1"></asp:LinkButton>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                                <td id="Td11" runat="server">
                                                                                    <asp:HiddenField runat="server" ID="hdnInstallationGuidePath" />
                                                                                    <asp:HiddenField runat="server" ID="hnUserGuidePath" />
                                                                                    <asp:HiddenField runat="server" ID="hdnIpaddress" />
                                                                                    <asp:HiddenField runat="server" ID="hdnPortNumber" />
                                                                                    <asp:HiddenField runat="server" ID="hdnPath" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <table width="90%">
                                                                <tr>
                                                                    <td class="colorforcontent" style="width: 30%;" height="23" align="left">
                                                                        <div id="ACX3plus2" style="display: none;">
                                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                                &nbsp;<asp:Label ID="Label3" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                                        <div id="ACX3minus2" style="display: block;">
                                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                                <asp:Label ID="Label6" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="ACX3responses2" style="display: block;" width="100%">
                                                                <tr>
                                                                    <td align="right">
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Button ID="btnPrint" OnClick="btnPrint_Click" runat="server" Text="Print Report"
                                                                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                                        Style="display: none;" meta:resourcekey="btnPrintResource1" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Button ID="btnSendMail" runat="server" Text="Send Mail" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                        onmouseout="this.className='btn'" OnClick="btnSendMail_Click" Style="display: none;"
                                                                                        meta:resourcekey="btnSendMailResource1" />
                                                                                    <asp:HiddenField ID="hdnShowReport" runat="server" Value="false" />
                                                                                    <asp:HiddenField ID="hdnPrintbtnInReportViewer" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top" style="width: 95%">
                                                                        <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                                                            Font-Size="8pt" meta:resourcekey="rReportViewerResource1" WaitMessageFont-Names="Verdana"
                                                                            WaitMessageFont-Size="14pt">
                                                                            <ServerReport ReportServerUrl="" />
                                                                        </rsweb:ReportViewer>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:UpdateProgress ID="UpdateProgress6" runat="server" AssociatedUpdatePanelID="udp1"
                        DynamicLayout="true">
                        <ProgressTemplate>
                            <div id="loading" class="loading">
                                <asp:Image ID="imgProgressbar5" runat="server" ImageUrl="~/Images/working.gif" />
                                <asp:Label ID="Rs_Pleasewait5" Text="Please wait...." runat="server" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table width="100%" id="tblPayments" visible="false" runat="server" border="0" cellpadding="0"
                    cellspacing="0">
                    <tr>
                        <td>
                            <asp:Label ID="lblThisBillhaspendingpaymentskindlymakepaymenttoviewreport" runat="server"
                                Text=" This Bill has pending payments kindly make payment to view report" meta:resourcekey="lblThisBillhaspendingpaymentskindlymakepaymenttoviewreportResource1"></asp:Label>
                            <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                OnClick="btnPayNow_Click" onmouseout="this.className='btn'" meta:resourcekey="btnPayNowResource1" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnHideReportTemplate" Value="0" runat="server" />
                <asp:HiddenField ID="hdnTemplateId" runat="server" />
                <asp:HiddenField ID="hdnlstInvSelected" runat="server" />
                <asp:HiddenField ID="hdnSelectedMailButton" runat="server" />
                <input type="hidden" id="hdnDue" runat="server" value="0.00" />
                <asp:HiddenField ID="hdOrgID" runat="server" />
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="hiddenTargetControlForModalPopup2" runat="server" Style="display: none"
                                meta:resourcekey="hiddenTargetControlForModalPopup2Resource1" />
                            <cc1:ModalPopupExtender ID="rptMdlPopup2" runat="server" PopupControlID="pnlAttrib2"
                                TargetControlID="hiddenTargetControlForModalPopup2" BackgroundCssClass="modalBackground"
                                CancelControlID="btnCnl2" DynamicServicePath="" Enabled="True">
                            </cc1:ModalPopupExtender>
                            <asp:Panel ID="pnlAttrib2" BorderWidth="1px" Height="95%" Width="80%" CssClass="modalPopup dataheaderPopup"
                                runat="server" meta:resourcekey="pnlAttrib2Resource1" Style="display: none; background-color: White;">
                                <table width="100%" style="height: 100%">
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnClientAttributes" runat="server" Text="Print" OnClientClick="return popupprint();"
                                                CssClass="btn" meta:resourcekey="btnClientAttributesResource1" />
                                            <%--<input type="button" id="btnClientAttributes" value="Print" class="btn" onclick="return popupprint();" />--%>
                                            <asp:Button ID="btnCnl2" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnCnl2Resource1" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <input type="hidden" id="hdnPDFType" name="PType" runat="server" />
                <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
                <input type="hidden" id="hdnPID" name="pid" runat="server" />
                <input type="hidden" id="hdnVID" name="vid" runat="server" />
                <input type="hidden" id="hdnVisitDetail" runat="server" />
                <input type="hidden" id="patOrgID" runat="server" name="patOrgID" />
                <input type="hidden" id="ChkID" runat="server" />
                <input type="hidden" id="hdndeptid" runat="server" />
                <input type="hidden" id="hdndeptvalues" runat="server" />
                <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
                <asp:HiddenField ID="Hdndisablebox" runat="server" />
                <asp:HiddenField ID="hdnHideDetails" Value="0" runat="server" />
                <asp:HiddenField ID="hdnReferralType" runat="server" />
                <asp:HiddenField ID="hdnEMail" runat="server" />
                <asp:HiddenField ID="hdnClientID" runat="server" />
                <asp:HiddenField ID="HdnID" runat="server" />
                <asp:HiddenField ID="hdncreditlimit" runat="server" Value="0.00" />
                <asp:HiddenField ID="hdnclientBlock" runat="server" />
                <asp:HiddenField ID="hdnrolename" runat="server" />
                <asp:HiddenField ID="hdndespatchvisit" runat="server" />
                <asp:HiddenField ID="hdndespatchClientId" runat="server" />
                <asp:HiddenField ID="hdnpreviousdue" runat="server" />
                <asp:HiddenField ID="hdnonoroff" runat="server" Value="N" />
                <asp:HiddenField ID="hdnclientdue" runat="server" Value="0.00" />
                <asp:HiddenField ID="hdnDispatchType" runat="server" Value="" />
                <asp:HiddenField ID="hdnDispatchMode" runat="server" Value="" />
                <input type="hidden" id="hdnHealthcheckup" runat="server" value="N" />
                <asp:HiddenField ID="hdnDispatch" runat="server" Value="" />
                <asp:HiddenField ID="hdnHomeList" runat="server" Value="" />
                <asp:HiddenField ID="hdnDoctorList" runat="server" Value="" />
                <asp:HiddenField ID="hdnPartial" runat="server" Value="" />
                <asp:HiddenField ID="hdnPending" runat="server" Value="" />
                <input type="hidden" id="hdnIsGeneralClient" runat="server" value="" />
                <input type="hidden" id="hdnPriority" name="Priority" runat="server" />
                <input type="hidden" id="hdnOrgID1" runat="server" />
                <input type="hidden" id="hdnLocationID" runat="server" />
                <input type="hidden" id="hdnTrustedOrg" runat="server" />
                <input type="hidden" id="hdnPatientID" runat="server" />
                <uc4:Footer ID="Footer1" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
            <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                CancelControlID="img1" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
            <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                            </td>
                            <td align="right">
                                <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                    style="cursor: pointer;" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <ul>
                    <li>
                        <uc5:ErrorDisplay ID="ErrorDisplay3" runat="server" />
                    </li>
                </ul>
                <table width="100%">
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="vertical-align: middle;">
                            <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                runat="server" meta:resourcekey="txtMailAddressResource1" />
                            <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                    meta:resourcekey="lblMailAddressHintResource1" />
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                    <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btnSendMailReport" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" OnClientClick="return CheckMailAddress();"
                                OnClick="btnSendMailReport_Click" meta:resourcekey="btnSendMailReportResource1" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table id="example" style="display: none">
                <thead>
                    <tr>
                        <th align="center">
                            Date Time
                        </th>
                        <th align="center">
                            User Name
                        </th>
                        <th align="center">
                            Location
                        </th>
                        <th align="center">
                            Activity
                        </th>
                        <th align="center">
                            Test Value
                        </th>
                        <th align="center">
                            Old Value
                        </th>
                        <th align="center">
                            Current Value
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdateLabelPrintPanel" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlPatientDetail" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                runat="server" meta:resourcekey="pnlPatientDetailResource1" ScrollBars="Auto"
                Style="display: none">
                <table>
                    <tr>
                        <td align="right">
                            <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                <ProgressTemplate>
                                    <asp:Image ID="imgProgressbar3" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbar3Resource1" />
                                    <asp:Label ID="Rs_Pleasewait3" Text="Please wait...." runat="server" meta:resourcekey="Rs_Pleasewait3Resource1" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <input id="imgCloseLabelReport" type="button" value="Close" name="Close" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <ucPatientdet:PatientDetails ID="PatientDetailsLabel" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="80%">
                                            <tr>
                                                <td>
                                                    <asp:Label nowrap="nowrap" ID="LabelDispatchType" runat="server" Text="Dispatch Type"
                                                        meta:resourcekey="LabelDispatchTypeResource1" />
                                                </td>
                                                <td>
                                                    <asp:Panel ID="chkDispatchTypeLabelPanel" runat="server" CssClass="dataheaderInvCtrl"
                                                        Font-Bold="true">
                                                        <asp:CheckBoxList ID="chkDispatchTypeLabel" RepeatDirection="Vertical" runat="server"
                                                            Font-Size="10px" Font-Bold="true">
                                                        </asp:CheckBoxList>
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                                    <asp:Label nowrap="nowrap" ID="LabelDispatchMode" runat="server" Text="Dispatch Mode"
                                                        meta:resourcekey="lLabelDispatchModeResource1" />
                                                </td>
                                                <td>
                                                    <asp:Panel ID="chkDespatchModeLabelPanel" runat="server" CssClass="dataheaderInvCtrl"
                                                        Width="98%" Font-Bold="true">
                                                        <asp:CheckBoxList ID="chkDespatchModeLabel" RepeatDirection="Horizontal" runat="server"
                                                            Font-Size="10px" Font-Bold="true">
                                                        </asp:CheckBoxList>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="ViewLabelPanel" runat="server" CssClass="dataheaderInvCtrl" Width="100%"
                                            Font-Bold="true">
                                            <table cellpadding="8" cellspacing="0" border="0" width="100%">
                                                <tr>
                                                    <td colspan="8">
                                                        <input id="rdLabel1" type="radio" name="label" runat="server" /><label id="lblLabel1"
                                                            runat="server"><asp:Label ID="Rs_CaseNoteSticker" Text="Case Note/ File Label" runat="server"
                                                                meta:resourcekey="Rs_CaseNoteStickerResource1"></asp:Label></label>
                                                        <input id="rdLabel2" type="radio" name="label" runat="server" value="2" /><label
                                                            id="lblLabel2" runat="server"><asp:Label ID="Rs_AddressSticker" Text="Patient Address Label"
                                                                runat="server" meta:resourcekey="Rs_AddressStickerResource1"></asp:Label></label>
                                                        <input id="rdDoctorDispatch" type="radio" name="label" runat="server" value="8" /><label
                                                            id="Label19" runat="server"><asp:Label ID="Rs_DoctorDispatchSticker" Text="Doctor Dispatch Label"
                                                                runat="server" meta:resourcekey="Rs_DoctorDispatchStickerResource1"></asp:Label></label>
                                                        <span style="white-space: nowrap">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="8">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnPrintLabel" runat="server" Text="View Label" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnPrintLabel_Click" meta:resourcekey="btnPrintLabelResource1" />
                                        <asp:HiddenField ID="hdnShowLabelReport" runat="server" Value="false" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="100%">
                                <tr>
                                    <td class="colorforcontent" style="width: 30%;" height="23" align="left">
                                        <div id="Div1" style="display: none;">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                &nbsp;<asp:Label ID="Label8" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                        <div id="Div2" style="display: block;">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                <asp:Label ID="Label15" runat="server" Text="Report Viewer" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <rsweb:ReportViewer ID="rReportViewer2" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                Font-Size="8pt" meta:resourcekey="rReportViewer2Resource1">
                                <ServerReport ReportServerUrl="" />
                            </rsweb:ReportViewer>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:HiddenField ID="hdnModelPopupPrintLabel" runat="server" />
            <cc1:ModalPopupExtender ID="ModalPopupLabelPrintExtender1" runat="server" PopupControlID="pnlPatientDetail"
                TargetControlID="hdnModelPopupPrintLabel" BackgroundCssClass="modalBackground"
                CancelControlID="imgCloseLabelReport" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
            <asp:HiddenField ID="HiddenField3" runat="server" />
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnPrintLabel" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>

    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <cc1:ModalPopupExtender ID="mdlPatientData" BehaviorID="mdlPatientData" runat="server"
        BackgroundCssClass="modalBackground" TargetControlID="hdnPatientData" PopupControlID="pnlPatientData" />
    <asp:Panel ID="pnlPatientData" runat="server" Style="display: none" BackColor="White">
        <asp:Label ID="lblPatientData" runat="server" Style="color: Black"></asp:Label>
    </asp:Panel>    
    <asp:HiddenField ID="hdnPatientData" runat="server" />
    <style type="text/css">
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }
        .modalPopup
        {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 300px;
            height: 140px;
        }
    </style>

   

    <style type="text/css">
        #tableBorder td
        {
            border: 1px solid #a0a0a0;
            text-align: center;
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
    <div id="iframeplaceholder">
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hndBillprintHide" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <script src="../Scripts/LabReportScript.js"type="text/javascript"></script>

    </form>
</body>
</html>
