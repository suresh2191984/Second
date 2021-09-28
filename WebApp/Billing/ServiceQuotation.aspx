<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ServiceQuotation.aspx.cs"
    EnableEventValidation="false" Inherits="Billing_ServiceQuotation" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Service Quotation</title>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
<script type="text/javascript" src="../Scripts/LabQuickBilling.js"></script>
    <script src="../Scripts/ServiceQuotation.js" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>
    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>
    <%--    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>
<link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />

    <link href="../QMS/Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />
   
</head>
<body>
    <form id="form1" oncontextmenu="return false;" runat="server" onkeydown="SuppressBrowserRefresh();">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table style="border: thin;" class="w-100p">
            <tr class="v-top">
                <td>
                    <div class="dataheader3">
                       <%-- <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                            style="cursor: pointer;" />--%>
                        <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server" GroupingText="Patient Details"
                            meta:resourcekey="PnlPatientDetailResource1">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-7p">
                                                    <asp:Label ID="lblName" runat="server" Text="<u>N</u>ame" AssociatedControlID="txtName"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td class="w-26p">
                                                    <table class="w-100p" cellspacing="1">
                                                        <tr>
                                                            <td class="w-18p">
                                                                <asp:DropDownList ID="ddSalutation" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtName" runat="server"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                    autocomplete="off" CssClass="small"  meta:resourcekey="txtNameResource1">
                                                                </asp:TextBox>
                                                                <%-- <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                                                    ServiceMethod="GetLabQuickBillPatientList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                                                    CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                                    Enabled="True">
                                                                                </ajc:AutoCompleteExtender>--%>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-6p">
                                                    <asp:Label ID="lblSex" runat="server" Text="Se<u>x</u>" AssociatedControlID="ddlSex"
                                                        AccessKey="X" meta:resourcekey="lblSexResource1"></asp:Label>
                                                </td>
                                                <td class="w-25p">
                                                    <asp:DropDownList ID="ddlSex" runat="server">
                                                    </asp:DropDownList>
                                                    <input id="Hidden2" type="hidden" value="M" runat="server" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <asp:Label ID="lblDOB" runat="server" Text="DO<u>B</u>" AssociatedControlID="tDOB"
                                                        AccessKey="B" meta:resourceKey="lblDOBResource1"></asp:Label>
                                                    <asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status" meta:resourcekey="lblMaritalResource1"></asp:Label>
                                                    <asp:DropDownList Style="display: none;" CssClass="ddlsmall" ID="ddMarital" runat="server">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                    <asp:TextBox ToolTip="dd/mm/yyyy" ID="tDOB" runat="server" onblur="javascript:countQuickAge(this.id);"
                                                        Style="text-align: justify" CssClass="small" ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr class="w-100p">
                                                            <td class="w-8p" id="tdSex1" runat="server">
                                                                <asp:Label ID="lblAge" runat="server" Text="Age " meta:resourceKey="lblAgeResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-60p" id="tdSex2" runat="server">
                                                                <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onchange="setDOBYear(this.id);"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    runat="server"
                                                                    CssClass="w-10p" MaxLength="3" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                                                                 <input type="hidden" id="hdnPatientDOB" runat="server" />
                                                                <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" runat="server"
                                                                    CssClass="ddlsmall">
                                                                </asp:DropDownList>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                                    Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                                                </ajc:TextBoxWatermarkExtender>
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
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-7p">
                                                    <asp:Label ID="lblMobile" runat="server" Text="<u>M</u>obile" AssociatedControlID="txtMobileNumber"
                                                        AccessKey="M" meta:resourcekey="lblMobileResource1"></asp:Label>
                                                </td>
                                                <td class="w-26p">
                                                    <%--  <asp:CheckBox ID="chkMobileNotify" Text="SMS" ToolTip="Send SMS Notification" runat="server" />
                                                                    <asp:Label ID="lblCountryCode" runat="server"></asp:Label>--%>
                                                    <asp:TextBox ID="txtMobileNumber" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="12" CssClass="small" meta:resourcekey="txtMobileNumberResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="w-6p">
                                                    <asp:Label ID="lblLandLine" runat="server" Text="<u>T</u>elephone" AssociatedControlID="txtPhone"
                                                        AccessKey="T" meta:resourcekey="lblLandLineResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p">
                                                    <asp:TextBox ID="txtPhone" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="15" CssClass="small" meta:resourcekey="txtPhoneResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-8p a-right">
                                                                <asp:Label ID="lblEmail" Text="<u>E</u>-mail" runat="server" AssociatedControlID="txtEmail"
                                                                    AccessKey="E" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:TextBox ID="txtEmail" autocomplete="off" runat="server" CssClass="small" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                                    id="imageEmail" runat="server" />
                                                                <%-- <asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                                        ControlToValidate="txtEmail" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                                        ValidationGroup="register" meta:resourceKey="regValidatorResource1">Email 
                                                            not valid</asp:RegularExpressionValidator>--%>
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
                                        <table class="w-100p" id="1">
                                            <tr>
                                                <td class="w-7p">
                                                    <asp:Label ID="Rs_ClientName" runat="server" Text="<u>C</u>lient Name" AssociatedControlID="txtClient"
                                                        AccessKey="C" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                </td>
                                                <td class="w-26p">
                                                    <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                        CssClass="small" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                                        Enabled="True" OnClientItemOver="SelectedTempClient">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td class="w-6p" id="tdRefDrPart" runat="server">
                                                    <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                                        Text="Ref Dr." meta:resourcekey="lblRefbyResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p" id="tdRefDrParttxt" runat="server">
                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox"
                                                         ></asp:TextBox>
                                                          <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                        OnClientShown="DocPopulated" FirstRowSelected="true" MinimumPrefixLength="2"
                                                        OnClientItemSelected="PhysicianSelected" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected" TargetControlID="txtInternalExternalPhysician">
                                                    </ajc:AutoCompleteExtender>--%>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <BillingPart:BPart ID="billPart" runat="server" />
                                    </td>
                                    <td>
                                        <div id="divPrint" runat="server" style="display: none;">
                                            <asp:Label ID="lblPrintCCBillDetail" runat="server" meta:resourcekey="lblPrintCCBillDetailResource1"></asp:Label>
                                        </div>
                                    </td>
                                    <td id="divShowClientDetails" class="w-35p" style="display: none; position: absolute;
                                        left: 62%; top: 1%">
                                        <div onclick="Itemhidebox();return false" class="divCloseRight">
                                        </div>
                                        <table cellspacing="1" class="w-32p modalPopup dataheaderPopup" cellpadding="1">
                                            <tr>
                                                <td id="Td5" class="w-100p" style="cursor: move; cursor: pointer">
                                                    <asp:Label ID="lblClientDetails" runat="server" meta:resourcekey="lblClientDetailsResource1" />
                                                    &nbsp;
                                                    <asp:DropDownList ID="ddCountry" onchange="javascript:loadState();" runat="server"
                                                        CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="ddlRate" runat="server" Enabled="False" CssClass="ddlsmall"
                                                        onChange="javascript:setRate(this.value);">
                                                       <%-- <asp:ListItem Selected="True" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr class="a-left">
                                                <td class="a-left w-15p">
                                                    <asp:CheckBox ID="chkboxPrintQuotation" Text="Print Quotation" runat="server" class="defaultfontcolor"
                                                                        Checked="true" meta:resourcekey="chkboxPrintQuotationResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="a-center">
                                    <td class="dataheader3">
                                                        <table>
                                            <tr>
                                                                <td>
                                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click"
                                                        OnClientClick="return checkgrp()" meta:resourcekey="btnSaveResource1" />
                                                                </td>
                                                                <td>
                                                    <asp:Button ID="btnSaveBook" runat="server" Text="Save&Book" CssClass="btn" OnClick="btnSaveBook_Click"
                                                        Visible="False" OnClientClick="return checkgrp()" meta:resourcekey="btnSaveBookResource1" />
                                                                </td>
                                                                <td>
                                                    <button runat="server" id="btnClose" class="btn" onclick="javascript:clearSQControls(1);">
                                                        <%=Resources.Billing_ClientDisplay.Billing_ServiceQuotation_aspx_01 %></button>
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
        </table>
    </div>
    <input id="hdnMinimumDue" type="hidden" value="" runat="server" />
    <input id="hdnMinimumDuePercent" type="hidden" value="" runat="server" />
    <input id="hdnPatientID" type="hidden" value="-1" runat="server" />
    <input id="hdnPatientNumber" type="hidden" value="0" runat="server" />
    <input id="hdnMobileNumber" type="hidden" value="0" runat="server" />
    <input id="hdnQuotesGivenBy" type="hidden" value="" runat="server" />
    <input id="hdnQuotesDate" type="hidden" value="" runat="server" />
    <input id="hdnPatientDetails" type="hidden" runat="server" />
    <input id="hdnSelectedPatientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnOutSourceInvestigations" type="hidden" runat="server" />
    <input id="hdnOPIP" type="hidden" runat="server" value="OP" />
    <input id="hdnVisitPurposeID" type="hidden" value="-1" runat="server" />
    <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhyName" type="hidden" value="" runat="server" />
    <input id="hdnReferedPhysicianCode" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhysicianRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnReferingPhysicianClientID" type="hidden" value="0" runat="server" />
    <input id="hdnReferingPhysicianMappingID" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhyType" type="hidden" value="" runat="server" />
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
    <input id="hdnClientID" type="hidden" value="-1" runat="server" />
    <input id="hdnTPAID" type="hidden" value="-1" runat="server" />
    <input id="hdnClientType" type="hidden" value="CRP" runat="server" />
    <input id="hdnPageUrl" type="hidden" runat="server" />
    <input id="hdnBaseRateID" type="hidden" value="0" runat="server" />
    <input id="hdnBaseClientID" type="hidden" value="0" runat="server" />
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
    <input id="hdnGender" runat="server" value="" type="hidden" />
    <asp:HiddenField ID="hdnLstPatientInvSample" runat="server" />
    <asp:HiddenField ID="hdnLstSampleTracker" runat="server" />
    <asp:HiddenField ID="hdnLstPatientInvSampleMapping" runat="server" />
    <asp:HiddenField ID="hdnLstInvestigationValues" runat="server" />
    <asp:HiddenField ID="hdnLstCollectedSampleStatus" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input type="hidden" id="hdnVisitID" runat="server" />
    <input type="hidden" id="hdnGuID" runat="server" />
    <input type="hidden" id="hdnFinalBillID" value="-1" runat="server" />
    <input type="hidden" id="hdnClientBalanceAmount" value="-1" runat="server" />
    <input type="hidden" id="hdnCashClient" runat="server" />
    <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
    <input type="hidden" runat="server" id="hdnRoundOffType" />
    <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
    <input type="hidden" runat="server" value="LABB" id="hdnBillingPageName" />
    <input id="hdnMappingClientID" type="hidden" value="-1" runat="server" />
    <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
    <input type="hidden" runat="server" value="N" id="hdnIsEditMode" />
    <input id="hdnRateID" runat="server" type="hidden" value="0" />
    <input id="Hidden1" type="hidden" value="0" runat="server" />
    <input type="hidden" runat="server" value="" id="hdnId" />
    <input type="hidden" runat="server" id="hdnDoFrmVisit" />
    <input type="text" runat="server" id="txtPhleboName" value="Y" />
      <asp:HiddenField ID="hdncollectcashforcreditclient" runat="server"  Value="N"/>
     <asp:HiddenField ID="HdnPhleboNameMandatory" runat="server" Value="N" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <input id="hdnMRPBillDisplay" type="hidden" value="N" runat="server" /> 
    <input id="hdnExternalBarcode" type="hidden" value="N" runat="server" /> 
    <input id="hdnAlrtBaseRateNotMappng" type="hidden" value="N" runat="server" /> 
    <input id="hdnTotalCreditLimit" runat="server" value="0" type="hidden" />
        <input id="hdnTotalCreditUsed" runat="server" value="0" type="hidden" />
        <input id="hdnCreditLimit" runat="server" value="0" type="hidden" />
        <input id="hdnCreditExpires" runat="server" value=0 type="hidden" />
    <asp:HiddenField ID="hdnTestHistoryPatient" Value="" runat="server" />

    <script type="text/javascript">

        if (document.getElementById('hdnBillGenerate').value == "Y") {
            document.getElementById('trCollectSample').style.display = "table-row";
            showResponses('divBill1', 'divBill2', 'divBill3', 0);
            showResponses('divBill1', 'divBill2', 'divOrder', 0);
        }
    </script>
 <script type="text/javascript" language="javascript">
         /* Common Alert Validation */
         var AlertType;
        $(document).ready(function() {
         autocomplete();
            $('INPUT[type="text"]').focus(function() {
                $(this).addClass("focus");
            });
            $('INPUT[type="text"]').blur(function() {
                $(this).removeClass("focus");
            });
             AlertType = SListForAppMsg.Get('Billing_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_Header_Alert');
        });
        function checkgrp() {
             /* Added By Venkatesh S */
             var vPatientName = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_01') == null ? "Enter Patient Name" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_01');
             var vDOB = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_02') == null ? "Enter DOB" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_02');
             var vTelephoneNo = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_03') == null ? "Provide contact mobile or telephone number" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_03');
             var vRefPhyName = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_05') == null ? "Enter Referring Physician Name" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_05');
             var vServiceQuotation = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_04') == null ? "Add Test to Print Service Quotation" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_04');
            if (document.getElementById('txtName').value == "") {
                 //alert('Enter Patient Name');
                 ValidationWindow(vPatientName, AlertType);
                document.getElementById('txtName').focus();
                return false;
            }
            else if (document.getElementById('txtDOBNos').value == "") {
                 //alert('Enter DOB');
                 ValidationWindow(vDOB, AlertType);
                document.getElementById('txtDOBNos').focus();
                return false;
            }
            if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
                 //alert('Provide contact mobile or telephone number');
                 ValidationWindow(vTelephoneNo, AlertType);
                 $('#txtMobileNumber').focus();
                 return false;
             }
             else if (document.getElementById('hdnReferedPhyID').value == 0 || document.getElementById('txtInternalExternalPhysician').value == '') {
                  
             ValidationWindow('Enter Referring Physician Name', AlertType);
                document.getElementById('txtInternalExternalPhysician').focus();
                 return false;
             }
             //            else if (document.getElementById('txtMobileNumber').value == "") {
             //                alert('Enter Mobile Number');
             //                document.getElementById('txtMobileNumber').focus();
             //                return false;
             //            }
             //            else if (document.getElementById('txtEmail').value == "") {
             //                alert('Enter Email');
             //                document.getElementById('txtEmail').focus();
             //                return false;
             //            }
             //            else if (document.getElementById('txtClient').value == "") {
             //                alert('Enter Client Name');
             //                document.getElementById('txtClient').focus();
             //                return false;
             //            }
             if ($.trim($('[id$="hdfBillType1"]').val()) == '') {
                 //alert('Add Test to Print Service Quotation');
                 ValidationWindow(vServiceQuotation, AlertType);
                 return false;
             }
         }

        function homeCollection() {
            var hdnID = document.getElementById('hdnId').value;
            window.location.href("../Lab/homecollection.aspx?bookingID=" + hdnID + "&IsPopup=Y");
        }
        function autocomplete() {
            $("#txtInternalExternalPhysician").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '../OPIPBilling.asmx/GetRateCardForBilling',

                        data: JSON.stringify({ prefixText: request.term, contextKey: "RPH" + '^' + document.getElementById('hdnOrgID').value + '^' + document.getElementById('hdfReferalHospitalID').value }),
                        dataType: "json",
                        success: function(data) {
                            if (data.d.length > 0) {

                                response($.map(data.d, function(item) {
                                    var txt = JSON.parse(item);
                                    var rsltlable = txt["First"];
                                    var rsltvalue = txt["Second"];
                                    return {
                                        label: rsltlable,
                                        val: rsltvalue
                                    }
                                }))
                            }
                            else {
                                response([{ label: "No Data found", val: -1}]);

                            }
                        },
                        error: function(response) {
                            alert(response.responseText);
                        },
                        failure: function(response) {
                            alert(response.responseText);
                        }
                    });
                },
                
                select: function(e, i) {
                    if (i.item.val == -1) {
                        $("#hdnReferedPhyID").val("");
                        $("#hdnReferedPhyName").val("")
                        $("#hdnReferedPhysicianCode").val("")
                        $("#hdnReferedPhyType").val("")
                    }
                    else {
                        //objAlert = SListForAppMsg.Get("Scripts_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_Alert");


                        var PhysicianID;
                        var PhysicianName;
                        var PhysicianCode;
                        var PhysicianType;
                        //document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
                        var PhyType;
                        var list = i.item.val.split('^');
                        //List[0] PhysicianType
                        //List[1] PhysicianID
                        //List[2] PhysicianName
                        //List[3] PhysicianCode
                        if (list.length > 0) {
                            for (i = 0; i < list.length; i++) {
                                if (list[i] != "") {
                                    PhysicianID = list[1];
                                    PhysicianName = list[2];
                                    PhysicianCode = list[3];
                                    PhysicianType = list[0].trim();
                                    PhyType = list[4];
                                }
                            }
                        }
                        document.getElementById('hdnReferedPhyID').value = PhysicianID;
                        document.getElementById('hdnReferedPhyName').value = PhysicianName;
                        document.getElementById('hdnReferedPhysicianCode').value = PhysicianCode;
                        document.getElementById('hdnReferedPhyType').value = PhysicianType;
                    }
                },
                minLength: 2
            });
        }
    </script>  

    </form>
</body>
</html>
