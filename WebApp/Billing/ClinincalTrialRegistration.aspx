<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClinincalTrialRegistration.aspx.cs"
    Inherits="Billing_ClinincalTrialRegistration" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ControlListDetails.ascx" TagName="ControlListDet"
    TagPrefix="ControlList" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="Payment" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="OtherCurrency" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Billing</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/CTRegistration.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" oncontextmenu="return false;" runat="server" onkeydown="SuppressBrowserRefresh();">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
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
                <uc4:MainHeader ID="MHead" runat="server" Visible="False" />
                <uc3:Header ID="userHeader" runat="server" />
            </div>
        </div>
        <table border="1" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="100%" valign="top" class="tdspace">
                    <div class="contentdata1">
                        <table style="border: thin;" width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr valign="top">
                                <td>
                                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                                        style="cursor: pointer;" />
                                    <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server" 
                                        GroupingText="Client Details" meta:resourcekey="PnlPatientDetailResource1">
                                        <table width="100%" id="1" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                            <td style="width: 20%; vertical-align: top">
                                                    <asp:Label ID="lblConsign" runat="server" Text="Consignment No." 
                                                        meta:resourcekey="lblConsignResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox ID="txtConsignment" Width="125px" onfocus="SetConsignContextKey();"
                                                        runat="server" CssClass="Txtboxsmall" 
                                                        meta:resourcekey="txtConsignmentResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoConsignment" runat="server" TargetControlID="txtConsignment"
                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="1"
                                                        MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetConsignmentNo"
                                                        ServicePath="~/OPIPBilling.asmx" 
                                                        OnClientItemSelected="ConsignmentSelected" DelimiterCharacters="" 
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                
                                                <td style="width: 20%; vertical-align: top">
                                                    <asp:Label ID="lblSitting" runat="server" Text="Study Protocol" 
                                                        meta:resourcekey="lblSittingResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox ID="txtSittingEpisode" onfocus="getSittingEpisoe();" Width="125px" runat="server"
                                                        CssClass="Txtboxsmall" meta:resourcekey="txtSittingEpisodeResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteSittingEpisode" runat="server" TargetControlID="txtSittingEpisode"
                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="1"
                                                        MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientEpisode"
                                                        ServicePath="~/OPIPBilling.asmx" 
                                                        OnClientItemSelected="SittingEpisodeSelected" DelimiterCharacters="" 
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td style="width: 20%; vertical-align: top">
                                                    <asp:Label ID="lblSiteNo" runat="server" Text="Site No." 
                                                        meta:resourcekey="lblSiteNoResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox ID="txtSiteNo" Width="125px" runat="server" onfocus="SetSiteContextKey();"
                                                        CssClass="Txtboxsmall" meta:resourcekey="txtSiteNoResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteSite" runat="server" TargetControlID="txtSiteNo"
                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="1"
                                                        MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientChildDetails"
                                                        ServicePath="~/OPIPBilling.asmx" 
                                                        OnClientItemSelected="SittingSiteSelected" DelimiterCharacters="" 
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td style="width: 20%; vertical-align: top">
                                                    <asp:Label ID="Rs_ClientName" runat="server" Text="CRO / Sponsor" 
                                                        meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox ID="txtClient" Width="125px" onchange="SetRateCard();" onfocus="CheckOrderedItems();"
                                                        runat="server" CssClass="Txtboxsmall" 
                                                        meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="1"
                                                        MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientListforSchedule"
                                                        ServicePath="~/WebService.asmx" OnClientItemOver="SelectedTempClient" 
                                                        OnClientItemSelected="ClientSelected" DelimiterCharacters="" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td style="width: 3%; vertical-align: top">
                                                    <asp:Label ID="lblName" runat="server" Text="Name" Style="display: none;" 
                                                        meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td style="width: 20%">
                                                    <asp:DropDownList CssClass="ddl" ID="ddSalutation" runat="server" 
                                                        Style="display: none;" meta:resourcekey="ddSalutationResource1">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" style="display: none;" />
                                                    &nbsp;
                                                    <asp:TextBox ID="txtName1" onKeyDown="javascript:clearPageControlsValue('Y');"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                        onblur="javascript:ConverttoUpperCase(this.id);LoadEpisodeBillingItemsForPatient();chkPatientRegisterCount();"
                                                        autocomplete="off" CssClass="Txtboxsmall" runat="server" Width="125px" 
                                                        Style="display: none" meta:resourcekey="txtName1Resource1"></asp:TextBox>
                                                </td>
                                                <td style="display: none">
                                                    <asp:Label ID="lblDOB" runat="server" Text="DOB" Style="display: none;" 
                                                        meta:resourcekey="lblDOBResource1"></asp:Label>
                                                </td>
                                                <td style="display: none">
                                                    <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB1" runat="server"
                                                        onblur="javascript:countQuickAge(this.id);" Width="75px" Style="text-align: justify;
                                                        display: none;" ValidationGroup="MKE" meta:resourcekey="tDOB1Resource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB1"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB1"
                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" style="display: none;" />
                                                    <asp:Label ID="lblAge" runat="server" Text="Age :" Style="display: none;" 
                                                        meta:resourcekey="lblAgeResource1"></asp:Label>
                                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        CssClass="Txtboxsmall" Width="8%" runat="server" MaxLength="3" Style="text-align: justify;
                                                        display: none;" meta:resourcekey="txtDOBNosResource1" />
                                                    <asp:DropDownList onChange="getDOB()" ID="ddlDOBDWMY" runat="server" CssClass="ddl"
                                                        Style="display: none;" meta:resourcekey="ddlDOBDWMYResource1">
                                                    </asp:DropDownList>
                                                    <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                        Enabled="True" TargetControlID="tDOB1" WatermarkCssClass="watermarked" WatermarkText="dd/mm/yyyy">
                                                    </ajc:TextBoxWatermarkExtender>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblSex" runat="server" Text="Sex" Style="display: none;" 
                                                        meta:resourcekey="lblSexResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList Width="57%" ID="ddlSex1" runat="server" CssClass="ddl" 
                                                        Style="display: none;" meta:resourcekey="ddlSex1Resource1">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" style="display: none;" />
                                                    &nbsp;
                                                    <asp:Label Style="display: none;" ID="lblMarital" runat="server" 
                                                        Text="Marital Status" meta:resourcekey="lblMaritalResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" 
                                                        runat="server" meta:resourcekey="ddMaritalResource1">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <div id="dis2" style="display: none;">
                                                        <asp:CheckBox onclick="AdhocChange();ScheduleChange();" ID="chkAdhocVisit1" 
                                                            runat="server" Text="Allow Adhoc Visit" 
                                                            meta:resourcekey="chkAdhocVisit1Resource1" />
                                                    </div>
                                                </td>
                                                <td>
                                                </td>
                                                <td id="trPatientDetails" style="display: none;">
                                                    <div id="showimage" style="display: none; position: absolute; width: 460px; left: 50%;
                                                        top: 3%">
                                                        <div onclick="hidebox();return false" class="divCloseRight">
                                                        </div>
                                                        <table border="0" width="453px" cellspacing="1" class="modalPopup dataheaderPopup"
                                                            cellpadding="1">
                                                            <tr>
                                                                <td id="dragbar" style="cursor: move; cursor: pointer" width="100%" onmousedown="initializedrag(event)">
                                                                    <asp:Label ID="lblPatientDetails" runat="server" 
                                                                        meta:resourcekey="lblPatientDetailsResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div id="ShowBillingItems" style="display: none; position: absolute; width: 460px;
                                                        left: 48%; top: 25%">
                                                        <div onclick="Itemhidebox();return false" class="divCloseRight">
                                                        </div>
                                                        <table border="0" width="200px" cellspacing="1" class="modalPopup dataheaderPopup"
                                                            cellpadding="1">
                                                            <tr>
                                                                <td id="Itemdragbar" style="cursor: move; cursor: pointer" width="100%">
                                                                    <asp:Label ID="lblPreviousItems" runat="server" 
                                                                        meta:resourcekey="lblPreviousItemsResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr style="width: 100%">
                                <td>
                                    <asp:Panel ID="PnlSubjectDetails" CssClass="dataheaderInvCtrl" runat="server" 
                                        GroupingText="Subject Details" meta:resourcekey="PnlSubjectDetailsResource1">
                                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td style="width: 15%; vertical-align: top">
                                                    <asp:Label ID="lblSubjectNo" runat="server" Text="Subject No" 
                                                        meta:resourcekey="lblSubjectNoResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox ID="txtSujectNo" Width="100px" runat="server" 
                                                        CssClass="Txtboxsmall" meta:resourcekey="txtSujectNoResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td style="width: 21%; vertical-align: top">
                                                    <asp:Label ID="Label4" runat="server" Text="Subject Initials/Name" 
                                                        meta:resourcekey="Label4Resource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox ID="txtName" Width="125px" runat="server" onkeydown="Cleargrid();" 
                                                        CssClass="Txtboxsmall" onblur="javascript:ConverttoUpperCase(this.id);LoadEpisodeBillingItemsForPatient();chkPatientRegisterCount();"
                                                        autocomplete="off" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" MinimumPrefixLength="2"
                                                        runat="server" TargetControlID="txtName" ServiceMethod="GetLabQuickBillPatientList"
                                                        ServicePath="~/OPIPBilling.asmx" EnableCaching="False" BehaviorID="AutoCompleteExLstGrp1"
                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                        OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient" 
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td style="width: 12%; vertical-align: top">
                                                    <asp:Label ID="lblGender" runat="server" Text="Gender" 
                                                        meta:resourcekey="lblGenderResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:DropDownList Width="37%" ID="ddlSex" runat="server" CssClass="ddl" 
                                                        meta:resourcekey="ddlSexResource1">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td style="width: 11%; vertical-align: top">
                                                    <asp:Label ID="lbldob1" runat="server" Text="DOB" meta:resourcekey="lbldob1Resource1" 
                                                       ></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                                        onblur="javascript:countQuickAge(this.id);" Width="75px" Style="text-align: justify;"
                                                        ValidationGroup="MKE" meta:resourcekey="tDOBResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="tDOB"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td style="width: 41%; vertical-align: top">
                                                    <asp:Label ID="lblSampleDateTime" runat="server" 
                                                        Text="Sample Pickup Date and Time" 
                                                        meta:resourcekey="lblSampleDateTimeResource1" ></asp:Label>
                                                    &nbsp;
                                                    <asp:TextBox CssClass="Txtboxsmall" runat="server" Width="120px" ID="txtSampleDate"
                                                        ToolTip="dd-MM-yyyy hh:mm:ssAM/PM" MaxLength="25" size="10" 
                                                        meta:resourcekey="txtSampleDateResource1"></asp:TextBox>
                                                    &nbsp; 
                                                    <a href="javascript:NewCssCal('<%= txtSampleDate.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                        &nbsp;
                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" style="width: 100%; vertical-align: top">
                                                    <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 32px">
                                                        <tr>
                                                            <td style="width: 25%; vertical-align: top">
                                                                <asp:Label ID="lblPatientStatusduringCollection" runat="server" 
                                                                    Text="Patient Status during Collection" meta:resourcekey="lblPatientStatusduringCollectionResource1" 
                                                                   ></asp:Label>
                                                                &nbsp;
                                                                <asp:DropDownList Width="27%" ID="ddlStatus" runat="server" CssClass="ddl" 
                                                                    meta:resourcekey="ddlStatusResource1">
                                                                </asp:DropDownList>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td style="width: 15%; vertical-align: top">
                                                                <div id="divAdhocVisit" style="display: none;">
                                                                    <asp:CheckBox onclick="AdhocChange();ScheduleChange();" ID="chkAdhocVisit" 
                                                                        runat="server" Text="UnScheduled Visit" 
                                                                        meta:resourcekey="chkAdhocVisitResource1" />
                                                                </div>
                                                            </td>
                                                            <td style="width: 15%; vertical-align: top">
                                                                <input id="chkUploadPhoto" runat="server" onclick="ShowUpload(this, this.id);"
                                                                    type="checkbox" value="Upload" />
                                                                <label ID="lblUploadPhoto" runat="server" for="chkUploadPhoto" 
                                                                    style="color: #2C88B1; font-size: small; font-weight: bold;">
                                                                    <asp:Label ID="lblTrfimageload" runat="server" Text="TRF Image Upload" meta:resourcekey="lblTrfimageloadResource1" 
                                                                    ></asp:Label>
                                                                </label>
                                                                <asp:HiddenField ID="hdnPatientImageName" runat="server" />
                                                            </td>
                                                            <td style="width: 60%; vertical-align: top">
                                                                <div id="TRFimage" style="display: none;">
                                                                    <asp:FileUpload ID="FileUpload1" runat="server" class="multi" 
                                                                        meta:resourcekey="FileUpload1Resource1" />
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
                                <td style="width: 350px;">
                                    <ControlList:ControlListDet ID="ucControlList" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="tblOrederedItems" border="1" cellpadding="1" cellspacing="0" class="dataheaderInvCtrl"
                                        style="text-align: left; font-size: 11px;" width="100%">
                                    </table>
                                </td>
                            </tr>
                            <tr id="trTest" runat="server" style="display: none">
                                <td valign="top">
                                    <div id="divOrder" class="dataheader3">
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="8%">
                                                    <asp:Label ID="lblTestName" Text="Test Name" runat="server" 
                                                        meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall" ID="txtTestName" onfocus="chkPros();" runat="server"
                                                        onchange="boxExpand(this);" onkeydown="javascript:clearfn();" onkeypress="javascript:clearfn();"
                                                        Width="200px" meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" OnClientItemSelected="IAmSelected"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetQuickBillItems"
                                                        FirstRowSelected="True" OnClientItemOver="SelectedTest" ServicePath="~/OPIPBilling.asmx"
                                                        UseContextKey="True" DelimiterCharacters="" Enabled="True" 
                                                        OnClientPopulated="InvPopulated">
                                                    </ajc:AutoCompleteExtender>
                                                    <input type="button" id="btnAdd" value="ADD" onclick="AddItems();" class="smallbtn" />
                                                    &nbsp;<asp:Label ID="lblInvType" runat="server" ForeColor="Red" 
                                                        Font-Bold="True" meta:resourcekey="lblInvTypeResource1"></asp:Label>
                                                    &nbsp;<asp:Label ID="alert" runat="server" ForeColor="Red" 
                                                        meta:resourcekey="alertResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="divBillItem" title="Billing Items">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr valign="top">
                                                <td>
                                                    <div class="divScroll" id="div1">
                                                    </div>
                                                    <span id="span1" style="text-align: center; font-weight: bold; color: Red; display: none;">
                                                        <asp:Label ID="lbladditems" runat="server" Text="Add Items" 
                                                        meta:resourcekey="lbladditemsResource1"></asp:Label>
                                                         </span>
                                                    <div class="divScroll" id="divItemTable">
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td class="dataheader3">
                                    <div style="vertical-align: text-top; display: none;">
                                        <div id="divBill1" onclick="showResponses('divBill1','divBill2','divBill3',1);" style="cursor: pointer;
                                            display: none;" runat="server">
                                            &nbsp;<img src="../Images/plus.png" alt="Show" />
                                        </div>
                                        <div id="divBill2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divBill1','divBill2','divBill3',0);"
                                            runat="server">
                                            &nbsp;<img src="../Images/minus.png" alt="Show" />
                                        </div>
                                    </div>
                                    <div id="divBill3" style="display: block;" title="Billing Details">
                                        <asp:Panel CssClass="dataheaderInvCtrl" ID="BillingPanel1" runat="server" 
                                            GroupingText="Billing Details" meta:resourcekey="BillingPanel1Resource1">
                                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                                <tr valign="top">
                                                    <td width="85%">
                                                        <table width="100%" border="0">
                                                            <tr valign="top">
                                                                <td>
                                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                                        <tr valign="top">
                                                                            <td>
                                                                                <span id="spanAddItems" style="text-align: center; font-weight: bold; color: Red;
                                                                                    display: none;">
                                                                                    <asp:Label ID="lbladditems1" runat="server" Text="Add Items" 
                                                                                    meta:resourcekey="lbladditems1Resource1"></asp:Label>
                                                                                     </span>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="trOtherCurrency" runat="server" style="display: none;">
                                                                            <td runat="server">
                                                                                <OtherCurrency:OtherCurrencyDisplay IsDisplayPayedAmount="false" ID="OtherCurrencyDisplay1"
                                                                                    runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="divPaymentType" runat="server">
                                                                            <td id="Td1" align="center" runat="server">
                                                                                <Payment:paymentType ID="PaymentType" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                                        <tr>
                                                                            <td>
                                                                                &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="tdDiscountLabel" Text="Select Discount" runat="server" 
                                                                                    meta:resourcekey="tdDiscountLabelResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList Enabled="False" CssClass="ddl" ID="ddDiscountPercent" ToolTip="Select the Discount"
                                                                                    onChange="javascript:SetNetValue();" runat="server" 
                                                                                    meta:resourcekey="ddDiscountPercentResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="left">
                                                                                <asp:Label ID="lblAuthorised" runat="server" Text="Authorise By" 
                                                                                    meta:resourcekey="lblAuthorisedResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAuthorised" onfocus="javascript:CheckBillItems();" CssClass="Txtboxsmall"
                                                                                    runat="server" meta:resourcekey="txtAuthorisedResource1" />
                                                                                <ajc:AutoCompleteExtender ID="AutoAuthorizer" runat="server" BehaviorID="AutoCompleteExLstGrpUN"
                                                                                    CompletionInterval="10" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                                    Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandLoginID"
                                                                                    ServicePath="~/WebService.asmx" TargetControlID="txtAuthorised" OnClientItemSelected="DiscountAuthSelected">
                                                                                </ajc:AutoCompleteExtender>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="left">
                                                                                <asp:Label ID="lblDiscountReason" runat="server" Text="Discount Reason" 
                                                                                    meta:resourcekey="lblDiscountReasonResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtDiscountReason" autocomplete="off" onfocus="javascript:CheckBillItems();"
                                                                                    CssClass="Txtboxsmall" Width="150px" runat="server" MaxLength="900" 
                                                                                    meta:resourcekey="txtDiscountReasonResource1" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td valign="top">
                                                                                <asp:Label ID="lblHistory" runat="server" Text="History :" 
                                                                                    meta:resourcekey="lblHistoryResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtPatientHistory" Width="150px" runat="server" MaxLength="900"
                                                                                    onBlur="return collapseTextBox(this.id);" onFocus="return expandTextBox(this.id)"
                                                                                    TextMode="MultiLine" meta:resourcekey="txtPatientHistoryResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="15%">
                                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" 
                                                                        meta:resourcekey="lblGrossResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtGross" Style="text-align: right" runat="server"
                                                                        Text="0.00" Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnGrossValue" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblDiscount" runat="server" Text="Discount" 
                                                                        class="defaultfontcolor" meta:resourcekey="lblDiscountResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtDiscount" Style="text-align: right"
                                                                        runat="server" Text="0.00" Enabled="False" 
                                                                        meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnDiscountAmt" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTaxt" Text="Tax" runat="server" 
                                                                        meta:resourcekey="lblTaxtResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" onChange="javascript:SetNetValue();" ID="txtTax"
                                                                        runat="server" Style="text-align: right" Text="0.00" 
                                                                        meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                                                    <asp:HiddenField ID="hdfTax" runat="server" />
                                                                    <div id="dvTaxDetails" align="left" runat="server">
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblServiceCharge" Text="Service Charge" runat="server" 
                                                                        meta:resourcekey="lblServiceChargeResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtServiceCharge" Style="text-align: right"
                                                                        Enabled="False" runat="server" Text="0.00" 
                                                                        meta:resourcekey="txtServiceChargeResource1" />
                                                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblRoundOffAmt" Text="Round Off" runat="server" 
                                                                        meta:resourcekey="lblRoundOffAmtResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtRoundoffAmt" Style="text-align: right"
                                                                        Enabled="False" runat="server" Text="0.00" 
                                                                        meta:resourcekey="txtRoundoffAmtResource1" />
                                                                    <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblNetValue" Text="Net Amount" runat="server" 
                                                                        meta:resourcekey="lblNetValueResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtNetAmount" Style="text-align: right"
                                                                        Enabled="False" runat="server" Text="0.00" 
                                                                        meta:resourcekey="txtNetAmountResource1" />
                                                                    <asp:HiddenField ID="hdnNetAmount" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblAmtReceived" Text="Amt Received" runat="server" 
                                                                        meta:resourcekey="lblAmtReceivedResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtAmtReceived" Style="text-align: right"
                                                                        Enabled="False" runat="server" Text="0.00" 
                                                                        meta:resourcekey="txtAmtReceivedResource1" />
                                                                    <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td>
                                                                    <asp:Label ID="lblDue" Text="Due" runat="server" 
                                                                        meta:resourcekey="lblDueResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtDue" Style="text-align: right" Enabled="False"
                                                                        runat="server" Text="0.00" meta:resourcekey="txtDueResource1" />
                                                                    <asp:HiddenField ID="hdnDue" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" class="dataheader3">
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnGenerate" runat="server" Width="100px" Text="Generate Bill" CssClass="btn"
                                                    OnClientClick="javascript:return validateEvents('After');"
                                                    OnClick="btnGenerate_Click" onmouseout="this.className='btn'" 
                                                    meta:resourcekey="btnGenerateResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnClose" runat="server" Width="70px" CssClass="btn" 
                                                    onmouseout="this.className='btn'" Text="Clear" OnClick="btnHome_Click" 
                                                    meta:resourcekey="btnCloseResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <input id="hdnPatientID" type="hidden" value="-1" runat="server" />
    <input id="hdnPatientNumber" type="hidden" value="0" runat="server" />
    <input id="hdnMobileNumber" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedPatientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnOutSourceInvestigations" type="hidden" runat="server" />
    <input id="hdnOPIP" type="hidden" runat="server" value="OP" />
    <input id="hdfBillType1" type="hidden" runat="server" />
    <input id="hdnFeeTypeSelected" type="hidden" runat="server" value="COM" />
    <input id="hdnName" type="hidden" runat="server" />
    <input id="hdnAmt" type="hidden" runat="server" value="0" />
    <input id="hdnReportDate" type="hidden" runat="server" />
    <input id="hdnRemarks" type="hidden" runat="server" />
    <input id="hdnIsRemimbursable" type="hidden" runat="server" />
    <input id="hdnPaymentControlReceivedtemp" type="hidden" value="0.00" runat="server" />
    <input id="hdnVisitPurposeID" type="hidden" value="-1" runat="server" />
    <input id="hdnDiscountApprovedBy" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhyID" type="hidden" value="-1" runat="server" />
    <input id="hdnReferedPhyName" type="hidden" value="" runat="server" />
    <input id="hdnReferedPhysicianCode" type="hidden" value="-1" runat="server" />
    <input id="hdnReferedPhysicianRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnReferingPhysicianClientID" type="hidden" value="0" runat="server" />
    <input id="hdnReferingPhysicianMappingID" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhyType" type="hidden" value="-1" runat="server" />
    <input id="hdnRefPhySpecialityID" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterID" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterName" type="hidden" value="" runat="server" />
    <input id="hdnCollectionCenterCode" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterClientID" type="hidden" value="0" runat="server" />
    <input id="hdnCollectionCenterMappingID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientID" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientName" type="hidden" value="" runat="server" />
    <input id="hdnSelectedClientCode" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientMappingID" type="hidden" value="0" runat="server" />
    <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
    <input id="hdnReferingHospitalName" type="hidden" value="0" runat="server" />
    <input id="hdnID" type="hidden" runat="server" />
    <input id="hdnRateID" runat="server" type="hidden" value="0" />
    <input id="hdnClientID" type="hidden" value="-1" runat="server" />
    <input id="hdnMappingClientID" type="hidden" value="-1" runat="server" />
    <input id="hdnTPAID" type="hidden" value="-1" runat="server" />
    <input id="hdnClientType" type="hidden" value="CRP" runat="server" />
    <input id="hdnPageUrl" type="hidden" runat="server" />
    <input id="hdnBaseRateID" type="hidden" value="0" runat="server" />
    <input id="hdnBaseClientID" type="hidden" value="0" runat="server" />
    <input id="hndLocationID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientStateID" type="hidden" value="0" runat="server" />
    <input id="hdnPreviousVisitDetails" type="hidden" value="" runat="server" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientAlreadyExists" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultCountryID" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultStateID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientAlreadyExistsWebCall" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultOrgBillingItems" type="hidden" value="" runat="server" />
    <input id="hdnIsReceptionPhlebotomist" value="N" runat="server" type="hidden" />
    <input id="hdnBillGenerate" value="N" runat="server" type="hidden" />
    <asp:HiddenField ID="hdnLstPatientInvSample" runat="server" />
    <asp:HiddenField ID="hdnLstSampleTracker" runat="server" />
    <asp:HiddenField ID="hdnLstPatientInvSampleMapping" runat="server" />
    <asp:HiddenField ID="hdnLstInvestigationValues" runat="server" />
    <asp:HiddenField ID="hdnLstCollectedSampleStatus" runat="server" />
    <input type="hidden" id="hdnVisitID" runat="server" />
    <input type="hidden" id="hdnGuID" runat="server" />
    <input type="hidden" id="hdnFinalBillID" value="-1" runat="server" />
    <input type="hidden" id="hdnPatineEpisodeDetails" value="" runat="server" />
    <input type="hidden" id="hdnClientByEpisodeID" value="-1" runat="server" />
    <input type="hidden" id="hdnNoOfPatient" value="0" runat="server" />
    <input type="hidden" id="hdnRegistredPatient" value="0" runat="server" />
    <input type="hidden" id="hdnAdhocVisit" value="N" runat="server" />
    <input type="hidden" id="hdnEpisodeVisitID" value="0" runat="server" />
    <input type="hidden" id="hdnClientBySiteID" value="0" runat="server" />
    <input type="hidden" id="hdnEpisodeClientID" value="0" runat="server" />
    <input type="hidden" id="hdnVisitTrackID" value="0" runat="server" />
    <input type="hidden" id="hdnClientBalanceAmount" value="-1" runat="server" />
    <asp:HiddenField ID="hdnCheckFlag" runat="server" />
    <asp:HiddenField ID="hdnClientFlag" runat="server" />
    <uc5:Footer ID="Footer1" runat="server" />

    <script type="text/javascript">
        function chkPros() {
            var orgID = '<%= OrgID %>';
            CallBillItems(orgID);
        }
        function ShowUpload(obj, id) {
            if (obj.checked) {
                document.getElementById('TRFimage').style.display = 'block';
            }
            else {
                document.getElementById('TRFimage').style.display = 'none';
            }
        }
        function ScheduleChange() {
            document.getElementById('trTest').style.display = "none";
            if (document.getElementById('chkAdhocVisit').checked) {
                document.getElementById('trTest').style.display = "block";

            }
             
        }
    </script>

    </form>
</body>
</html>
