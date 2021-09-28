<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AtomLabQuickBilling.aspx.cs"
    EnableEventValidation="false" Inherits="Billing_AtomLabQuickBilling" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/CollectSample.ascx" TagName="CollectSample" TagPrefix="CollectSample" %>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="billPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc19" %>

<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Billing</title>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/CollectSample.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/CopaymentAndPreAuth.js" type="text/javascript"></script>

    <style>
        .Txtboxsmall12
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 14px;
            width: 226px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
        }
    </style>
</head>
<body onload="CheckISEdit(),Location()">
    <form id="form1" oncontextmenu="return false;" runat="server" onkeydown="SuppressBrowserRefresh();">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p searchPanel">
            <tr>
                <td>
                    <div id="ViewTRF" runat="server" class="hide">
                        <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                    </div>
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <div class="w-100p">
                        <%-- <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                                            style="cursor: pointer;" />--%>
                        <asp:Panel class="w-100p" ID="PnlPatientDetail" runat="server" GroupingText="Patient Details">
                            <table class="w-100p" border="0">
                                <tr>
                                    <td>
                                        <table class="w-100p" id="1" border="0">
                                            <tr>
                                                <td colspan="3">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td runat="server" id="tdSearchType1">
                                                                <asp:Label ID="lblSearchType" runat="server" Text="Search Type"></asp:Label>
                                                            </td>
                                                            <td runat="server" id="tdSearchType2">
                                                                <asp:RadioButtonList onclick="javascript:clearPageControlsValue('N');" RepeatDirection="Horizontal"
                                                                    ID="rblSearchType" runat="server" RepeatColumns="5">
                                                                    <%--<asp:ListItem Text="None" Value="4" ></asp:ListItem>--%>
                                                                    <asp:ListItem Text="Name" Value="0" Selected="True"></asp:ListItem>
                                                                    <asp:ListItem Text="Number" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="Mobile/Phone" Value="2"></asp:ListItem>
                                                                    <%--<asp:ListItem Text="Booking Number" Value="3"></asp:ListItem>--%>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-center" width="20%">
                                                    <img title="Show Previous Data and History" alt="" onclick="ShowPrevious();" src="../Images/collapse_blue.jpg"
                                                        id="ShowPreviousData" style="cursor: pointer; display: none;" />
                                                </td>
                                                <td class="a-left hide" id="tdVisitType1" runat="server">
                                                    <asp:Label ID="Rs_SelectVisit" runat="server" Text="Visit Type:"></asp:Label>
                                                </td>
                                                <td align="left" id="tdVisitType2" runat="server" style="display: none;">
                                                    <asp:DropDownList CssClass="bilddltb" onfocus="javascript:CheckPatientName();" ID="ddlVisitDetails"
                                                        runat="server" onchange="ChangeVisit()">
                                                    </asp:DropDownList>
                                                </td>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr id="trExternalVisitID" runat="server" colspan="2">
                                                <td>
                                                    <asp:Label ID="lblExtVisitId" runat="server" Text="Lab Number"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtExternalVisitID" runat="server" onblur="javascript:SelectedExtVisitID();fillTextbox();"
                                                        MaxLength="9" CssClass="Txtboxsmall" onchange="CheckSMS();clearPageControlsValue('N');"
                                                          OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table border="0" cellpadding="0" cellspacing="0" class="w-75p">
                                                        <tr>
                                                            <td class="a-left" width="3%">
                                                                <asp:Label ID="lblName" runat="server" Text="<u>N</u>ame" AssociatedControlID="txtName"
                                                                    AccessKey="N"></asp:Label>
                                                            </td>
                                                            <td class="a-left" width="5%">
                                                                <asp:DropDownList CssClass="ddlsmall" ID="ddSalutation" runat="server" Width="70px">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:TextBox ID="txtName" onfocus="javascript:setPatientSearch();" onKeyDown="javascript:clearPageControlsValue('Y');"
                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                    autocomplete="off" runat="server" CssClass="Txtboxsmall12">
                                                                </asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                                    ServiceMethod="GetLabQuickBillPatientList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                                    CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                    OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient" Enabled="True"
                                                                    OnClientPopulated="onListPopulated">
                                                                </ajc:AutoCompleteExtender>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblSex" runat="server" Text="Se<u>x</u>" AssociatedControlID="ddlSex"
                                                        AccessKey="X"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList Width="70px" ID="ddlSex" runat="server" CssClass="ddl">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <asp:Label ID="lblDOB" runat="server" Text="DO<u>B</u>" AssociatedControlID="tDOB"
                                                        AccessKey="B"></asp:Label>
                                                    <%--<asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status"></asp:Label>
                                                                                <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" runat="server">
                                                                                </asp:DropDownList>--%>
                                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                    <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                                        onblur="javascript:countQuickAge(this.id);" onchange="FutureDateValidation();"
                                                        Width="87px" Style="text-align: justify" ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="MM/dd/yyyy" runat="server" TargetControlID="tDOB"
                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td id="tdSex1" runat="server" align="left">
                                                    <asp:Label ID="lblAge" runat="server" Text="Age"></asp:Label>
                                                </td>
                                                <td id="tdSex2" runat="server" align="left">
                                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();setDDlDOBYear('ddlDOBDWMY',false);"
                                                        onchange="setDOBYear(this.id,'LB');"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        CssClass="Txtboxsmall" Width="18%" runat="server" MaxLength="5" Style="text-align: justify"
                                                        meta:resourceKey="txtDOBNosResource1" />
                                                    <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id,true);" ID="ddlDOBDWMY"
                                                        Width="75px" runat="server" CssClass="ddl">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                        BehaviorID="txtwtrDob" Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked"
                                                        WatermarkText="dd/MM/yyyy">
                                                    </ajc:TextBoxWatermarkExtender>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblMobile" runat="server" Text="" AssociatedControlID="txtMobileNumber"
                                                        AccessKey="M"></asp:Label>
                                                </td>
                                                <td align="left" valign="middle">
                                                    <asp:Label ID="lblCountryCode" runat="server" Width="10%" Style="display: none"></asp:Label>
                                                    <asp:TextBox ID="txtMobileNumber" Width="90%" autocomplete="off" onchange="CheckSMS();"
                                                             onkeypress="return ValidateOnlyNumeric(this);"    runat="server"
                                                        MaxLength="13" CssClass="small"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td width="8%">
                                                    <asp:Label ID="lblLandLine" runat="server" Text="<u>T</u>elephone" AssociatedControlID="txtPhone"
                                                        AccessKey="T"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPhone" Width="82%" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="15" CssClass="small"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblEmail" Text="<u>E</u>-mail" runat="server" AssociatedControlID="txtEmail"
                                                        AccessKey="E"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" autocomplete="off" runat="server" onchange="CheckEmail();"
                                                        CssClass="small" Width="89%"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                        id="imageEmail" runat="server" />
                                                    <%-- <asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                                        ControlToValidate="txtEmail" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                                        ValidationGroup="register" meta:resourceKey="regValidatorResource1">Email 
                                                            not valid</asp:RegularExpressionValidator>--%>
                                                </td>
                                                <td width="8%" align="left">
                                                    <asp:Label ID="lblAddress" Text="<u>A</u>ddress" runat="server" AssociatedControlID="txtAddress"
                                                        AccessKey="A"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAddress" autocomplete="off" runat="server" CssClass="small" Width="90%"></asp:TextBox>&nbsp;<img
                                                        src="../Images/starbutton.png" alt="" align="middle" style="display: none;" id="imageAddress"
                                                        runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_City" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                                        AccessKey="Y"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="small" Width="90%" autocomplete="off" ID="txtCity" runat="server"
                                                        MaxLength="25"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                        id="imageCity" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPinCode" runat="server" Text="<u>P</u>inCode" AssociatedControlID="txtPincode"
                                                        AccessKey="P"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPincode" Width="89%"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        MaxLength="8" runat="server" autocomplete="off" CssClass="small"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                        id="imagePincode" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCountry" runat="server" Text="<u>C</u>ountry" AssociatedControlID="ddCountry"
                                                        AccessKey="C"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddCountry" Width="90%" onchange="javascript:loadState();" runat="server"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="Rs_State" runat="server" Text="<u>S</u>tate" AssociatedControlID="ddState"
                                                        AccessKey="S"></asp:Label>
                                                </td>
                                                <td style="display: block;" nowrap="nowrap">
                                                    <select id="ddState" runat="server" class="ddl" onchange="javascript:onchangeState();"
                                                        style="width: 245px">
                                                    </select>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                            <tr id="trUrnType" runat="server">
                                                <td id="tdClientPart" runat="server">
                                                    <asp:Label ID="Rs_ClientName" runat="server" AccessKey="C" AssociatedControlID="txtClient"
                                                        Text="&lt;u&gt;C&lt;/u&gt;lient Name"></asp:Label>
                                                </td>
                                                <td id="tdClientParttxt" runat="server">
                                                    <asp:TextBox ID="txtClient" runat="server" autocomplete="off" Width="82%" CssClass="AutoCompletesearchBox"
                                                        onKeyDown="javascript:clearRefdetails();" onblur="ClearRate();" onfocus="CheckOrderedItems();"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemOver="SelectedTempClient"
                                                        OnClientItemSelected="ClientSelected" ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx"
                                                        TargetControlID="txtClient">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td id="tdRefHosPart" runat="server">
                                                    <asp:Label ID="lblReferingHospital" runat="server" AccessKey="H" AssociatedControlID="txtReferringHospital"
                                                        Text="Ref &lt;u&gt;H&lt;/u&gt;os"></asp:Label>
                                                </td>
                                                <td id="tdRefHosParttxt" runat="server">
                                                    <asp:TextBox ID="txtReferringHospital" autocomplete="off" runat="server" CssClass="AutoCompletesearchBox"
                                                        onFocus="return getrefphysicianid(this.id)" Width="78%"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                        CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="GetReferingHospID"
                                                        ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemOver="GetTempReferingHospID"
                                                        TargetControlID="txtReferringHospital">
                                                    </ajc:AutoCompleteExtender>
                                                    <asp:HiddenField ID="hdnReferralType" runat="server" Value="0" />
                                                </td>
                                                <td id="tdRefDrPart" runat="server">
                                                    <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                                        Text="Ref Dr."></asp:Label>
                                                </td>
                                                <td id="tdRefDrParttxt" runat="server">
                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox"
                                                        onFocus="return getrefhospid(this.id)" onKeyDown="javascript:ClearDiscountLimitValues();"
                                                        Width="78%"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                        OnClientShown="DocPopulated" FirstRowSelected="true" MinimumPrefixLength="2"
                                                        OnClientItemSelected="PhysicianSelected" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected" TargetControlID="txtInternalExternalPhysician">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr id="tdAdditionalDetails" runat="server">
                                                <td colspan="2">
                                                    <input id="ChkTRFImage" runat="server" onclick="ShowTRFUpload(this, this.id);" type="checkbox"
                                                        value="Upload" />&nbsp;<asp:Label ID="lblTRF" runat="server" AccessKey="U" AssociatedControlID="ChkTRFImage"
                                                            Style="color: #2C88B1; font-size: small;" Text="TRF Image &lt;u&gt;U&lt;/u&gt;pload"></asp:Label>
                                                </td>
                                                <td colspan="2">
                                                    <div id="TRFimage" style="display: none;">
                                                        <asp:FileUpload ID="FileUpload1" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF"
                                                            class="multi" />
                                                    </div>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblDespatchmode" runat="server" Text="Dispatch Mode"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="panelDispatchMode" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="true">
                                                        <asp:CheckBoxList ID="chkDespatchMode" RepeatDirection="Horizontal" runat="server"
                                                            Font-Size="10px" Font-Bold="true">
                                                        </asp:CheckBoxList>
                                                        <asp:DropDownList ID="ddlDespatchMode" Style="display: none;" Width="86%" CssClass="ddl"
                                                            runat="server">
                                                        </asp:DropDownList>
                                                    </asp:Panel>
                                                </td>
                                                <td id="tdhideFields" style="display: none" runat="server">
                                                    <asp:Label ID="lblPatientStatus1" runat="server" Text="Patient Status:"></asp:Label>
                                                </td>
                                                <td id="tdhideFields1" nowrap="nowrap" style="display: none" runat="server">
                                                    <asp:DropDownList ID="ddlPatientStatus1" runat="server" CssClass="ddl" Width="93%">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8" class="colorforcontent w-100p h-23 a-left">
                                                    <div id="ACX2plus1" style="display: block;">
                                                        &nbsp;<img src="../Images/plus.png" alt="Show" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',2);" />
                                                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                            &nbsp;Additional details</span>
                                                    </div>
                                                    <div id="ACX2minus1" style="display: none;">
                                                        &nbsp;<img src="../Images/minus.png" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',2);">
                                                            &nbsp;Additional details</span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr class="tablerow" id="ACX2responses1" style="display: none;">
                                                <td colspan="8">
                                                    <div class="filterdataheader2 font14" style="font-family: Verdana;">
                                                        <table class="defaultfontcolor w-100p margin6">
                                                            <tr id="trPatientPriorityPart" runat="server">
                                                                <td>
                                                                    <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlUrnType" Width="92%" runat="server" onblur="CheckExistingURN1();"
                                                                        onChange="javascript:return CheckMRD();" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td id="tdlblUrnoOf" runat="server">
                                                                    <asp:Label ID="Rs_URNOf" runat="server" Text="URN Of"></asp:Label>
                                                                </td>
                                                                <td id="tdUrnoOf" runat="server">
                                                                    <asp:DropDownList ID="ddlUrnoOf" Width="91%" runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_URN" Text="URN No" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <input type="hidden" id="hdnUrn" runat="server" value="0" />
                                                                    <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" CssClass="small" onKeyDown="javascript:ClearDiscountLimitValues();"
                                                                        MaxLength="50" Width="89%" onblur="CheckExistingURN1();ConverttoUpperCase(this.id);"></asp:TextBox>
                                                                </td>
                                                                <td id="tdlblMarital" runat="server">
                                                                    <asp:Label ID="lblMarital" runat="server" Text="Marital Status"></asp:Label>
                                                                </td>
                                                                <td id="tdddMarital" runat="server">
                                                                    <asp:DropDownList CssClass="ddl" ID="ddMarital" Width="93%" runat="server">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr id="trVisitTypePart" runat="server">
                                                                <td>
                                                                    <asp:Label ID="lblPatient" runat="server" Text="Vis<u>i</u>t Type" AssociatedControlID="ddlIsExternalPatient"
                                                                        AccessKey="I"></asp:Label>
                                                                </td>
                                                                <td id="tdlblWardNo" style="display: block;">
                                                                    <asp:DropDownList CssClass="ddl" Width="92%" onchange="javascript:SelectVisitType();"
                                                                        ID="ddlIsExternalPatient" runat="server">
                                                                        <asp:ListItem Text="OP" Value="0" Selected="True"></asp:ListItem>
                                                                        <asp:ListItem Text="IP" Value="1"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblWardno" runat="server" Text="<u>W</u>ard No" AssociatedControlID="txtWardNo"
                                                                        AccessKey="W"></asp:Label>
                                                                </td>
                                                                <td id="tdtxtWardNo" style="display: block;">
                                                                    <asp:TextBox ID="txtWardNo" Width="90%" CssClass="small" runat="server"></asp:TextBox>
                                                                </td>
                                                                <td id="td2" nowrap="nowrap">
                                                                    <asp:Label ID="Label1" runat="server" Text="Ex Patient Number"></asp:Label>
                                                                </td>
                                                                <td id="td55">
                                                                    <asp:TextBox ID="txtExternalPatientNumber" autocomplete="off" Width="89%" CssClass="small"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPatientStatus" runat="server" Text="Patient Status:"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlPatientStatus" runat="server" CssClass="ddl" Width="93%">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr id="trSampleTRFPart" runat="server">
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblSampleDate" runat="server" AccessKey="K" AssociatedControlID="txtSampleDate"
                                                                        Text="Sample Pic&lt;u&gt;k&lt;/u&gt;up"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtSampleDate" runat="server" CssClass="small" onblur="AdditionalDetails();"
                                                                        Width="50%"></asp:TextBox>
                                                                    <a href="javascript:NewCssCal('txtSampleDate','ddmmyyyy','arrow',true,12);document.getElementById('txtSampleDate').focus();">
                                                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                                                    <%--  <img id="img1" alt="Pick a date" border="0" height="16" onclick="datePick('txtSampleDate');document.getElementById('txtSampleDate').focus();"
                                                                        src="../Images/Calendar_scheduleHS.png" style="cursor: hand;" width="16" />--%>
                                                                    <asp:TextBox ID="txtcurrendate" runat="server" CssClass="small" Style="display: none;"
                                                                        Width="50%"></asp:TextBox>
                                                                    &nbsp;
                                                                    <asp:CheckBox ID="chkSamplePickup" onclick="AdditionalDetails();" runat="server"
                                                                        Text="Collected?" />
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblPhlebo0" runat="server" Text="Phlebotomist Name"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPhleboName" runat="server" CssClass="AutoCompletesearchBox" Width="82%"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPhlebo" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                        Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="Selectedphlebotomist"
                                                                        ServiceMethod="FetchphlebotomistName" ServicePath="~/WebService.asmx" TargetControlID="txtPhleboName">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLogistics" runat="server" Text="Logistics Name"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLogistics" runat="server" CssClass="AutoCompletesearchBox" Width="78%"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLogi" runat="server" BehaviorID="AutoCompleteExLstGrp48"
                                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                        Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="SelectedLogistics"
                                                                        ServiceMethod="FetchLogisticsName" ServicePath="~/WebService.asmx" TargetControlID="txtLogistics">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblRoundNo" runat="server" Text="Round No"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtRoundNo" runat="server" autocomplete="off" CssClass="small" Width="90%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr id="trDispType" runat="server">
                                                                <td>
                                                                    <asp:Label ID="lblDespatchType" runat="server" Text="Dispatch Type"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Panel ID="panelDispatchType" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="true"
                                                                        Width="92%">
                                                                        <asp:CheckBoxList ID="chkDisPatchType" RepeatDirection="Horizontal" runat="server"
                                                                            Font-Size="10px" Font-Bold="true">
                                                                        </asp:CheckBoxList>
                                                                    </asp:Panel>
                                                                </td>
                                                                <td colspan="2" nowrap="nowrap">
                                                                    <asp:CheckBox ID="chkExcludeAutoathz" runat="server" Text="Exclude Auto Authorization" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblnotification" runat="server" Text="Notification"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Panel ID="panelnotification" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="true">
                                                                        <asp:CheckBoxList ID="ChkNotification" RepeatDirection="Horizontal" runat="server"
                                                                            Font-Size="10px" Font-Bold="true">
                                                                        </asp:CheckBoxList>
                                                                        <asp:CheckBox ID="chkMobileNotify" Text="Sms" ToolTip="Send SMS Notification" Font-Bold="true"
                                                                            Font-Size="10px" runat="server" Style="display: none" />
                                                                    </asp:Panel>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblSuburban" runat="server" Text="Suburb" AssociatedControlID="txtSuburban"
                                                                        AccessKey="B"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox CssClass="small" Width="90%" autocomplete="off" ID="txtSuburban" runat="server"
                                                                        MaxLength="25"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr id="trEditRemarks" runat="server" class="hide">
                                                                <td>
                                                                    <asp:Label ID="EditlblHistory" runat="server" Text="History "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="EditPatientHistory" Width="50%" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                                        onFocus="return expandTextBox(this.id)" TextMode="MultiLine"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="EditlblRemarks" runat="server" Text="Remarks"></asp:Label>
                                                                </td>
                                                                <td colspan="5">
                                                                    <asp:TextBox ID="EdittxtRemarks" Width="50%" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                                        onFocus="return expandTextBox(this.id)" TextMode="MultiLine"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td style="display: none;">
                                                                    <asp:Label ID="lblCollectionCode" Text="<u>L</u>ocation" runat="server" AssociatedControlID="txtCollectionCode"
                                                                        AccessKey="L"></asp:Label>
                                                                </td>
                                                                <td style="display: none;">
                                                                    <asp:TextBox ID="txtCollectionCode" autocomplete="off" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                </td>
                                                                <td id="trRate" runat="server" style="display: none;">
                                                                    Rate &nbsp;
                                                                    <asp:DropDownList ID="ddlRate" runat="server" Enabled="False" onChange="javascript:setRate(this.value);">
                                                                        <asp:ListItem Selected="True">--Select--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="display: none;">
                                                                    <asp:Label ID="Rs_Nationality" runat="server" Text="Nationality"></asp:Label>
                                                                    <asp:DropDownList CssClass="ddl" ID="ddlNationality" runat="server">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td id="trApprovalNo" runat="server">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td style="width: 40%" align="left">
                                                                                <asp:Label ID="lblApprovalNo" runat="server" Text="Approval No"></asp:Label>
                                                                            </td>
                                                                            <td align="center">
                                                                                <asp:TextBox ID="txtApprovalNo" runat="server" AutoCompleteType="Disabled" MaxLength="13"
                                                                                    CssClass="small"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" Width="80%"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td id="trPatientDetails" style="display: none;">
                                                                    <div id="showimage" style="display: none; position: absolute; width: 440px; left: 64%;
                                                                        top: 3%">
                                                                        <div onclick="hidebox();return false" class="divCloseRight">
                                                                        </div>
                                                                        <table border="0" width="453px" cellspacing="0" class="modalPopup dataheaderPopup"
                                                                            cellpadding="0">
                                                                            <tr>
                                                                                <td id="dragbar" style="cursor: move; cursor: pointer" width="100%" onmousedown="initializedrag(event)">
                                                                                    <asp:Label ID="lblPatientDetails" runat="server"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                                <td style="display: none">
                                                                    <asp:Label ID="lblPatientType" runat="server" Text="Patient Type"></asp:Label>
                                                                </td>
                                                                <td style="display: none">
                                                                    <asp:DropDownList ID="ddlPatientType" Width="93%" runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td>
                                                                    <asp:Label ID="lblLocation" runat="server" Text="OnBehalf Of Location" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                                    <asp:Label ID="lblPriority" runat="server" Text="Priority" Visible="false"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList Width="10%" ID="ddlPriority" runat="server" CssClass="ddl" Visible="false">
                                                                    </asp:DropDownList>
                                                                    <asp:TextBox ID="txtLocClient" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                                        onblur="Location();" Width="91%" meta:resourcekey="txtLocClientResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="OnCollectioncenterselectedClient"
                                                                        ServiceMethod="GetCollectionCenterClientNames" ServicePath="~/WebService.asmx"
                                                                        TargetControlID="txtLocClient">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td colspan="6">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">
                                                    <div id="ShowBillingItems" style="display: none; position: absolute; width: 35%;
                                                        left: 61%; top: 1%">
                                                        <div class="divCloseRight" onclick="Itemhidebox();return false">
                                                        </div>
                                                        <table border="0" cellpadding="0" cellspacing="0" class="modalPopup dataheaderPopup"
                                                            width="32%">
                                                            <tr>
                                                                <td id="Itemdragbar" style="cursor: move; cursor: pointer" width="100%">
                                                                    <asp:Label ID="lblPreviousItems" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="divShowClientDetails" style="display: none; position: absolute; width: 35%;
                                                        left: 61%; top: 1%">
                                                        <div class="divCloseRight" onclick="Itemhidebox();return false">
                                                        </div>
                                                        <table border="0" cellpadding="0" cellspacing="0" class="modalPopup dataheaderPopup"
                                                            width="32%">
                                                            <tr>
                                                                <td id="Td4" style="cursor: move; cursor: pointer" width="100%">
                                                                    <asp:Label ID="lblClientDetails" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
            <tr id="trOrderCalcPart" runat="server" class="displaytr">
                <td>
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
                     <div id="CoPayMent" style="display: none" runat="server" class="dataheader3">
                        <uc19:ClientTpa IsBilling="Y" ID="uctlClientTpa" runat="server" />
                    </div>
                    <div>
                        <BillingPart:BPart ID="billPart" runat="server" />
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" class="dataheader3">
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnGenerate" runat="server" Width="100px" Text="Generate Bill" CssClass="btn"
                                    OnClientClick="javascript:return validateEvents('After');" OnClick="btnGenerate_Click"
                                    onmouseout="this.className='btn'" meta:resourcekey="btnGenerateResource1" />
                            </td>
                            <td>
                                <input type="button" runat="server" id="btnClose" value="Close" class="btn" onclick="javascript:clearbuttonClick();" />
                            </td>
                            <td>
                                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" Style="display: none;"
                                    OnClick="btnBack_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn" Style="display: none;" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="100%" id="trCollectSample" runat="server" style="display: none;">
            <tr>
                <td>
                    <CollectSample:CollectSample ID="ctlCollectSample" runat="server" />
                    <div runat="server" id="divpanel">
                        <asp:Panel CssClass="dataheaderInvCtrl" runat="server" ID="pnlDept" meta:resourcekey="pnlDeptResource1">
                            <table id="deptTab" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr id="Tr1" style="height: 20px;" class="Duecolor" runat="server">
                                    <td id="Td3" runat="server">
                                        <asp:Label ID="lblDeptheader" runat="server"> <b>Select the Department for which the Samples has to be sent</b> </asp:Label>
                                    </td>
                                </tr>
                                <tr id="Tr2" runat="server">
                                    <td id="Td58" style="text-align: left; width: 100%;" valign="top" runat="server">
                                        <asp:DataList Width="100%" ID="repDepts" runat="server" RepeatColumns="5">
                                            <ItemTemplate>
                                                <table width="100%" border="0">
                                                    <tr>
                                                        <td style="height: 20px;">
                                                            <asp:CheckBox ID="chkDept" runat="server" />
                                                            <asp:Label ID="lblDeptName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DeptName")%>'> </asp:Label>
                                                        </td>
                                                        <td style="height: 20px;">
                                                            <asp:Label ID="lblDeptID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DeptID")%>'
                                                                Visible="False"> </asp:Label>
                                                            <asp:Label ID="lblRoleID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RoleID")%>'
                                                                Visible="False"> </asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Generate Work Order"
                        Style="cursor: pointer;" CssClass="btn" OnClick="btnFinish_Click" onmouseout="this.className='btn'"
                        onmouseover="this.className='btn btnhov'" Text="Generate Work Order" meta:resourcekey="btnFinishResource1" />
                    &nbsp;
                    <asp:Button ID="Button1" runat="server" Width="70px" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" Text="Cancel" OnClick="btnHome_Click" meta:resourcekey="Button1Resource1" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
    <input id="hdnMinimumDue" type="hidden" value="" runat="server" />
    <input id="hdnMinimumDuePercent" type="hidden" value="" runat="server" />
    <input id="hdnPatientID" type="hidden" value="-1" runat="server" />
    <input id="hdnPatientNumber" type="hidden" value="0" runat="server" />
    <input id="hdnMobileNumber" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedPatientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnOutSourceInvestigations" type="hidden" runat="server" />
    <input id="hdnOPIP" type="hidden" runat="server" value="OP" />
    <input id="hdnVisitPurposeID" type="hidden" value="-1" runat="server" />
    <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
    <input id="hdnExternalVisitID" type="hidden" value="0" runat="server" />
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
    <input id="hdnGender" type="hidden" value="" runat="server" />
    <input id="hdnClientID" type="hidden" value="-1" runat="server" />
    <input id="hdnTPAID" type="hidden" value="-1" runat="server" />
    <input id="hdnClientType" type="hidden" value="CRP" runat="server" />
    <input id="hdnPageUrl" type="hidden" runat="server" />
    <input id="hdnBaseRateID" type="hidden" value="0" runat="server" />
    <input id="hdnBaseClientID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientStateID" type="hidden" value="0" runat="server" />
    <input id="hdnPreviousVisitDetails" type="hidden" value="" runat="server" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <input id="hdnNewOrgID" type="hidden" value="0" runat="server" />
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
    <input type="hidden" id="hdnClientBalanceAmount" value="-1" runat="server" />
    <input type="hidden" id="hdnCashClient" runat="server" />
    <asp:HiddenField ID="hdnAttributeList" runat="server" />
    <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
    <input type="hidden" runat="server" id="hdnRoundOffType" />
    <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
    <input type="hidden" runat="server" value="LABB" id="hdnBillingPageName" />
    <input id="hdnMappingClientID" type="hidden" value="-1" runat="server" />
    <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
    <input type="hidden" runat="server" value="N" id="hdnIsEditMode" />
    <input id="hdnRateID" runat="server" type="hidden" value="0" />
    <input id="hdnDefaultCountryStdCode" type="hidden" value="0" runat="server" />
    <input id="hdnIsBillGenerated" runat="server" type="hidden" value="NO" />
    <input id="hdnInvList" type="hidden" value="" runat="server" />
    <input id="hdnHistoryList" type="hidden" value="" runat="server" />
    <input id="hdnInvIDHistoryList" type="hidden" value="" runat="server" />
    <input id="hdnSelectHistoryValue" type="hidden" value="" runat="server" />
    <asp:HiddenField ID="hdnfinalHistoryList" runat="server" />
    <input id="HDPatientVisitID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientName" type="hidden" value="" runat="server" />
    <input type="hidden" id="hdnClienID" runat="server" value="0" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input id="hdnBookingNo" type="hidden" runat="server" />
    <input type="hidden" id="hdnPatientAge" runat="server" />
    <input type="hidden" id="hdnPatientDOB" runat="server" />
    <input type="hidden" id="hdnPatientSex" runat="server" />
    <input type="hidden" id="hdnPatientReportStatus" runat="server" />
    <asp:HiddenField ID="hdnTodayVisitID" runat="server" />
    <input type="hidden" id="hdnVisitSubType" value="" runat="server" />
    <asp:HiddenField ID="hdnTempTodayVisitID" runat="server" />
    <asp:HiddenField ID="HdnPhleboName" runat="server" />
    <asp:HiddenField ID="HdnPhleboID" runat="server" />
    <asp:HiddenField ID="hdnLogisticsName" runat="server" />
    <asp:HiddenField ID="hdnLogisticsID" runat="server" />
    <asp:HiddenField ID="hdnEdtPhleboID" runat="server" />
    <asp:HiddenField ID="hdnEdtLogisticsID" runat="server" />
    <asp:HiddenField ID="hdnEditSex" runat="server" />
    <asp:HiddenField ID="hdnEdtPatientAge" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
    <asp:HiddenField ID="hdnIsCash" runat="server" />
    <asp:HiddenField ID="hdnDefaultClientRateID" runat="server" />
    <asp:HiddenField ID="hdnDiscountLimitAmt" runat="server" />
    <asp:HiddenField ID="hdnSumDiscountAmt" runat="server" />
    <asp:HiddenField ID="hdnAvailableDiscountAmt" runat="server" />
    <asp:HiddenField ID="hdnDiscountLimitType" runat="server" />
    <asp:HiddenField ID="hdnPriRateType" runat="server" />
    <asp:HiddenField ID="hdnRoleName" runat="server" />
    <asp:HiddenField ID="hdnEditDDlDOB" runat="server" />
    <asp:HiddenField ID="hdnBookedID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnEditddMarital" runat="server" />
    <asp:HiddenField ID="hdnDecimalAgeConfig" runat="server" />
    <asp:HiddenField ID="hdnDoFrmVisit" runat="server" />
    <asp:HiddenField ID="hdnClientCode" runat="server" />
    <asp:HiddenField ID="hdnckeckdueamt" runat="server" />
    <input type="hidden" runat="server" id="hdnDateFormatConfig" value="dd/MM/yyyy" />
    <asp:HiddenField ID="hdnCheckFlag" runat="server" />
    <asp:HiddenField ID="hdnSelectedoldClient" runat="server" />
    <asp:HiddenField ID="hdnClientFlag" runat="server" />
    <input type="hidden" id="HdnCoPay" runat="server" />
    <asp:HiddenField ID="HdnPhleboNameMandatory" runat="server" Value="N" />

    <script type="text/javascript">

        if (document.getElementById('hdnBillGenerate').value == "Y") {
            document.getElementById('trCollectSample').style.display = "block";
            showResponses('divBill1', 'divBill2', 'divBill3', 0);
            showResponses('divBill1', 'divBill2', 'divOrder', 0);
        }
        function ToInternalFormat(pControl) {
            // //debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.asNumber({ region: "<%=LanguageCode%>" });
            }
        }

        function ToTargetFormat(pControl) {
            // //debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
            }
        }
        function getrefhospid(source, eventArgs) {

            var sval = 0;

            var OrgID = document.getElementById('hdnOrgID').value;
            var rec = document.getElementById('hdfReferalHospitalID').value;
            var sval = "RPH" + "^" + OrgID + "^" + rec;
            $find('AutoCompleteExtenderRefPhy').set_contextKey(sval);
        }
        function getrefphysicianid(source, eventArgs) {

            var sval = 0;

            var OrgID = document.getElementById('hdnOrgID').value;
            var PhysicianID = document.getElementById('hdnReferedPhyID').value;


            var sval = OrgID + "~" + PhysicianID;
            $find('AutoCompleteExtenderReferringHospital').set_contextKey(sval);
        }

        function OnCollectioncenterselectedClient(source, eventArgs) {
            document.getElementById('txtLocClient').value = eventArgs.get_text();
            document.getElementById('hdnClienID').value = eventArgs.get_value();
        }
        function AdditionalDetails() {

            if (document.getElementById('chkSamplePickup').checked == true) {
                //document.getElementById('tdAdditionalDetails').style.display = 'block';
                document.getElementById('billPart_hdnIsCollected').value = "Y";
            }
            else {
                // document.getElementById('tdAdditionalDetails').style.display = 'none';               
                document.getElementById('billPart_hdnIsCollected').value = "N";
            }
            var CollectedDatetime = document.getElementById('txtSampleDate').value;
            if (CollectedDatetime != '') {

                document.getElementById('billPart_hdnCollectedDateTime').value = CollectedDatetime;
                document.getElementById('billPart_hdnIsCollected').value = "Y";
            }
            else {
                document.getElementById('billPart_hdnCollectedDateTime').value = "01-01-1900 07:00AM";
                document.getElementById('billPart_hdnIsCollected').value = "";
            }
        }



        function Location() {
            var Loc = document.getElementById('txtLocClient').value;
            if (Loc != '') {
                document.getElementById('billPart_hdnLocName').value = Loc;
            }
        }


        function Selectedphlebotomist(source, eventArgs) {
            PhleboDetails = eventArgs.get_value();

            var PhleboName = PhleboDetails.split('~')[0];
            var PhleboID = PhleboDetails.split('~')[1];
            if (document.getElementById('HdnPhleboName') != null) {
                document.getElementById('HdnPhleboName').value = PhleboName;
            }
            if (document.getElementById('HdnPhleboID') != null) {
                document.getElementById('HdnPhleboID').value = PhleboID;
            }
        }
        function SelectedLogistics(source, eventArgs) {
            LogisticsDetails = eventArgs.get_value();

            var LogisticsName = LogisticsDetails.split('~')[0];
            var LogisticsID = LogisticsDetails.split('~')[1];
            if (document.getElementById('hdnLogisticsName') != null) {
                document.getElementById('hdnLogisticsName').value = LogisticsName;
            }
            if (document.getElementById('hdnLogisticsID') != null) {
                document.getElementById('hdnLogisticsID').value = LogisticsID;
            }
        }
    </script>

    </form>

    <script type="text/javascript">
        function Enabled() {

            document.getElementById('<%=ddSalutation.ClientID%>').disabled = true;
            document.getElementById('<%=txtName.ClientID%>').readOnly = true;
            document.getElementById('<%=txtReferringHospital.ClientID%>').readOnly = true;
            document.getElementById('<%=txtInternalExternalPhysician.ClientID%>').readOnly = true;
            document.getElementById('<%=ddlSex.ClientID%>').disabled = true;


            document.getElementById('<%=tDOB.ClientID%>').readOnly = true;
            document.getElementById('<%=txtDOBNos.ClientID%>').readOnly = true;
            document.getElementById('<%=ddlDOBDWMY.ClientID%>').disabled = true;

            document.getElementById('<%=txtMobileNumber.ClientID%>').readOnly = true;
            document.getElementById('<%=txtPhone.ClientID%>').readOnly = true;
            document.getElementById('<%=txtEmail.ClientID%>').readOnly = true;

            document.getElementById('<%=txtAddress.ClientID%>').readOnly = true;
            document.getElementById('<%=txtPhone.ClientID%>').readOnly = true;
            document.getElementById('<%=txtEmail.ClientID%>').readOnly = true;

            document.getElementById('<%=txtCity.ClientID%>').readOnly = true;
            document.getElementById('<%=txtSuburban.ClientID%>').readOnly = true;
            document.getElementById('<%=txtPincode.ClientID%>').readOnly = true;


            document.getElementById('<%=ddCountry.ClientID%>').disabled = true;
            document.getElementById('<%=ddState.ClientID%>').disabled = true;
            document.getElementById('<%=ddMarital.ClientID%>').disabled = true;
            document.getElementById('<%=ddlUrnType.ClientID%>').disabled = true;

            document.getElementById('<%=ddlUrnoOf.ClientID%>').disabled = true;
            document.getElementById('<%=txtURNo.ClientID%>').readOnly = true;
            document.getElementById('<%=ddlPatientType.ClientID%>').disabled = true;


            document.getElementById('<%=txtLocClient.ClientID%>').readOnly = true;

            document.getElementById('<%=txtReferringHospital.ClientID%>').readOnly = true;

            document.getElementById('<%=txtInternalExternalPhysician.ClientID%>').readOnly = true;

        }
        function makeenable() {
            document.getElementById('<%=ddSalutation.ClientID%>').disabled = false;
            document.getElementById('<%=ddlSex.ClientID%>').disabled = false;


            document.getElementById('<%=ddlDOBDWMY.ClientID%>').disabled = false;

            document.getElementById('<%=ddState.ClientID%>').disabled = false;
            document.getElementById('<%=ddCountry.ClientID%>').disabled = false;
            //document.getElementById('<%=ddState.ClientID%>').disabled = true;
            document.getElementById('<%=ddlUrnType.ClientID%>').disabled = false;

            document.getElementById('<%=ddlUrnoOf.ClientID%>').disabled = false;
            document.getElementById('<%=ddlPatientType.ClientID%>').disabled = false;

        }
    </script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

</body>
</html>

<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        CheckISEdit();
        $('INPUT[type="text"]').focus(function() {
            $(this).addClass("focus");
        });
        $('INPUT[type="text"]').blur(function() {
            $(this).removeClass("focus");
        });
        $("#txtExternalVisitID").focus();
    });


    function AddBillingItemsDetailsForEdit(ClientID) {

        var queryStringColl = getQueryStrings();
        var OrgID = document.getElementById('hdnOrgID').value;
        var BillNo = queryStringColl.billNo;
        var VisitID = queryStringColl.VID;
        var PatientID = queryStringColl.PID
        var arrGotValue = new Array();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../OPIPBilling.asmx/GetBillingItemsDetailsForEdit",
            data: JSON.stringify({ OrgID: OrgID, BillNo: BillNo, VisitID: VisitID, PatientID: PatientID, ClientID: ClientID }),
            dataType: "json",
            success: function(data) {
                if (data.d.length > 0) {
                    clearBillPartValues();


                    var list = data.d;

                    if (list[0].length > 0) {
                        var list1 = list[0];
                        var list2 = list[1];
                    }
                    else {
                        alert('Services are not Associated With this Client');
                        return false;
                    }
                    document.getElementById('hdnClientCode').value = '';
                    document.getElementById('hdnClientCode').value = list1[0].BatchNo;
                    if (ClientID <= 0) {
                        document.getElementById('txtClient').value = list1[0].RefPhyName;

                    }
                    var gotValue = list2[0].ProcedureName;


                    document.getElementById('billPart_txtAmtReceived').value = list2[0].Amount;
                    ToTargetFormat($('#billPart_txtAmtReceived'));

                    document.getElementById('billPart_hdnAmountReceived').value = list2[0].Amount;
                    ToTargetFormat($('billPart_hdnAmountReceived'));
                    document.getElementById('billPart_txtNetAmount').value = list2[0].Amount;
                    ToTargetFormat($('#billPart_txtNetAmount'));

                    document.getElementById('billPart_hdnNetAmount').value = list2[0].Amount;
                    ToTargetFormat($('#billPart_hdnNetAmount'));
                    arrGotValue = list1[0].ProcedureName;
                    BilledList = arrGotValue.split('#');
                    for (var j = 0; j < BilledList.length - 1; j++) {
                        if (BilledList[j] != '' && BilledList[j].length > 0) {
                            arrGotValue = '';
                            arrGotValue = BilledList[j].split('^');
                            ID = arrGotValue[0];
                            name = arrGotValue[1].trim();
                            feeType = arrGotValue[2];
                            amount = arrGotValue[3];
                            Remarks = arrGotValue[5];
                            isReimursable = arrGotValue[6];
                            ReportDate = arrGotValue[19];
                            if (ReportDate == 'Jan  1 1753 12:00AM') {
                                ReportDate = '';
                            }
                            ActualAmount = arrGotValue[8];
                            IsDiscountable = arrGotValue[9];
                            IsTaxable = arrGotValue[10];
                            IsRepeatable = arrGotValue[11];
                            IsSTAT = arrGotValue[12];
                            IsSMS = arrGotValue[13];
                            IsNABL = arrGotValue[14];
                            RateID = arrGotValue[15];
                            HasHistory = arrGotValue[16];
                            ProcessingLoc = arrGotValue[17];
                            BaseRateID = arrGotValue[18];
                            IsOutSource = document.getElementById('billPart_hdnIsOutSource').value;
                            outRInSourceLocation = document.getElementById('billPart_hdnoutsourcelocation').value;
                            document.getElementById('billPart_hdnID').value = ID;
                            document.getElementById('billPart_hdnName').value = name;
                            document.getElementById('billPart_hdnFeeTypeSelected').value = feeType;
                            document.getElementById('billPart_hdnAmt').value = amount;
                            document.getElementById('billPart_hdnRemarks').value = Remarks;
                            document.getElementById('billPart_hdnIsRemimbursable').value = isReimursable;
                            document.getElementById('billPart_hdnReportDate').value = ReportDate;
                            document.getElementById('billPart_hdnActualAmount').value = ActualAmount;
                            document.getElementById('billPart_hdnIsDiscountableTest').value = IsDiscountable;
                            document.getElementById('billPart_hdnIsTaxable').value = IsTaxable;
                            document.getElementById('billPart_hdnIsRepeatable').value = IsRepeatable;
                            document.getElementById('billPart_hdnIsSTAT').value = IsSTAT;
                            document.getElementById('billPart_hdnIsSMS').value = IsSMS;
                            document.getElementById('billPart_hdnIsNABL').value = IsNABL;
                            document.getElementById('billPart_hdnBillingItemRateID').value = RateID;
                            document.getElementById('billPart_hdnHasHistory').value = HasHistory;
                            document.getElementById('billPart_hdnProcessingLoc').value = ProcessingLoc;
                            document.getElementById('billPart_hdnBaseRateID').value = BaseRateID;

                            //document.getElementById('billPart_btnAdd').disabled = false;
                            var FeeID = document.getElementById('billPart_hdnID').value;
                            var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;
                            DuplicateInv(FeeID, FeeType);

                        }
                        else {

                            document.getElementById('billPart_txtTestName').value = '';
                            document.getElementById('billPart_txtTestName').focus();
                        }
                    }
                    if (document.getElementById('hdnClientCode').value == 'GENERAL') {
                        alert('Can Change to GENERAL Client');
                        document.getElementById('btnGenerate').disabled = true;

                    }
                    else {
                        document.getElementById('btnGenerate').disabled = false;
                    }
                }
            },
            error: function(result) {
                alert("Error");
            }
        });
    }
    function CheckISEdit() {
        var QueryString = getQueryStrings();
        var IsCPEDIT = "N";
        if (QueryString != null) {
            IsCPEDIT = QueryString.CPEDIT;
            if (IsCPEDIT == "Y") {
                document.getElementById('billPart_hdnCpedit').value = IsCPEDIT;
                document.getElementById('billPart_tdBillDetails').style.display = "none";
                document.getElementById('billPart_tdGrossBillDetails').style.display = "none";
                document.getElementById('billPart_divPaymentType').style.display = "none";
                document.getElementById('billPart_tblnetamt').style.display = "block";
                document.getElementById('divOrder').style.display = "none";

                document.getElementById('txtName').setAttribute('autocomplete', 'off');
                AddBillingItemsDetailsForEdit(0);
                Enabled();
            }
        }
    }
    function CheckSMS() {

        if (document.getElementById('txtMobileNumber').value != '') {
            //                           document.getElementById('chkMobileNotify').checked = true;

        }
        else {
            document.getElementById('chkMobileNotify').checked = false;
        }
        // var elements = document.getElementById('ChkNotification');
        //  if (document.getElementById('txtMobileNumber').value != '') {

        //     elements.cells[1].childNodes[0].checked = true;
        // }
        //else {
        //   elements.cells[1].childNodes[0].checked = false;
        // }

    }

    function CheckEmail() {
        var elements = document.getElementById('chkDespatchMode');
        if (document.getElementById('txtEmail').value != '') {

            elements.cells[0].childNodes[0].checked = true;
        }
        else {
            elements.cells[0].childNodes[0].checked = false;

        }
    }
    // In Edit Bill cancel the backspace navigation By Nallathambi
    var KEYCODE_BACKSPACE = 8;
    $(document).keydown(SuppressKeyStrokes);
    function SuppressKeyStrokes(e) {
        if ((e.keyCode == KEYCODE_BACKSPACE && e.target.type == "text" && e.target.readOnly == true) || e.keyCode == 13) {
            e.preventDefault();
            e.stopImmediatePropagation();
            return false;
        }
    };

    function DisableSpace(e) {
        var k;
        document.all ? k = e.keyCode : k = e.which;
        return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 46 || k == 44 || (k >= 48 && k <= 57));
    }
    function fillTextbox() {
        var externalVisitID = document.getElementById('hdnExternalVisitID').value;
        var textBox = document.getElementById("txtExternalVisitID");
        var textLength = textBox.value.length;
        if (textBox.value != '' && textLength < 9) {
            alert('Invalid. Scan the correct barcode');
            document.getElementById('txtExternalVisitID').focus();
            return false;
        }
    }

    function clearRefdetails() {


        var refclient = document.getElementById('txtClient').value;
        if (refclient == "") {
            document.getElementById('txtReferringHospital').value = "";

            document.getElementById('txtInternalExternalPhysician').value = "";
            document.getElementById('hdnReferedPhyName').value = "";
        }

    }


</script>

