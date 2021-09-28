<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WortixLabQuickBilling.aspx.cs"
    EnableEventValidation="false" Inherits="Billing_WortixLabQuickBilling" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>--%>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%--<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/CollectSample.ascx" TagName="CollectSample" TagPrefix="CollectSample" %>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/NewDateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="DateTimePicker" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc19" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../EMR/CapturePatientHistory.ascx" TagName="PatientCaptureHistory"
    TagPrefix="PHis" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Billing</title>
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
    <%--<asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                        <ProgressTemplate>
                                            <div id="progressBackgroundFilter">
                                            </div>
                                            <div align="center" id="processMessage" width="60%">
                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                                <br />
                                                <br />
                                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>--%>
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <div id="ViewTRF" runat="server" style="display: none">
                        <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                    </div>
                </td>
            </tr>
            <tr class="v-top">
                <td>
                    <div class="dataheader3">
                        <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server" GroupingText="Patient Details"
                            meta:resourcekey="PnlPatientDetailResource1">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr id="TrDoFromVisit" runat="server">
                                                <td width="7%" runat="server" id="tdSearchType12" nowrap="Nowrap">
                                                    <asp:Label ID="lblVisitNUmber" runat="server" ForeColor="Blue" meta:resourcekey="lblVisitNUmberResource1"><%=Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_11 %></asp:Label>
                                                </td>
                                                <td colspan="4" runat="server" id="tdSearchType21">
                                                    <asp:TextBox ID="txtDoFrmVisitNumber" TabIndex="-1" nowrap="nowrap" runat="server"
                                                        CssClass="AutoCompletesearchBox" meta:resourcekey="txtDoFrmVisitNumberResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderVisitNo" runat="server" TargetControlID="txtDoFrmVisitNumber"
                                                        ServiceMethod="GetLabQuickBillPatientListForClientBilling" ServicePath="~/OPIPBilling.asmx"
                                                        EnableCaching="False" CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" OnClientItemSelected="SelectedClientPatientForDoFromVisit"
                                                        Enabled="True" OnClientPopulated="onClientListPopulated">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td id="tdVisitType1" runat="server" align="left" style="display: none;">
                                                    <asp:Label ID="Rs_SelectVisit" runat="server" Text="Visit Type:" meta:resourcekey="Rs_SelectVisitResource1"></asp:Label>
                                                </td>
                                                <td id="tdVisitType2" runat="server" align="left" style="display: none;">
                                                    <asp:DropDownList TabIndex="-1" Width="95px" CssClass="bilddltb" onfocus="javascript:CheckPatientName();"
                                                        ID="ddlVisitDetails" runat="server" onchange="ChangeVisit()" meta:resourcekey="ddlVisitDetailsResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td runat="server" id="tdSearchType1">
                                                                <asp:Label ID="lblSearchType" runat="server" Text="Search Type" meta:resourcekey="lblSearchTypeResource1"></asp:Label>
                                                            </td>
                                                            <td runat="server" id="tdSearchType2">
                                                                <asp:RadioButtonList onclick="javascript:clearPageControlsValue('N');" RepeatDirection="Horizontal"
                                                                    ID="rblSearchType" runat="server" RepeatColumns="5" meta:resourcekey="rblSearchTypeResource1">
                                                                    <%--  <asp:ListItem Text="None" Value="4" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                    <asp:ListItem Text="Name" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                    <asp:ListItem Text="PID" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                    <asp:ListItem Text="Mobile/Phone" Value="2" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                    <asp:ListItem Text="Booking Number" Value="3" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                             
                                                                   
                                                                            <td id="InComCheck" runat="server">
                                                                                <asp:CheckBox ID="chkIncomplete" TextAlign="Left"  Style="display: none"  
                                                                                    onClick="Validategender();" runat="server" Text="Incomplete Registration" meta:resourcekey="chkIncompleteResource1" />
                                                                            </td>
                                                                            <td id="InComddl" runat="server">
                                                                                <asp:Label ID="lblUnknownFlag" runat="server" Text="Not Provided" Visible="false" meta:resourceKey="lblUnknownFlagResource2"></asp:Label>
                                                                                <asp:DropDownList CssClass="ddl" ID="ddlUnknownFlag" runat="server"  Visible="false"
                                                                                    Enabled="false" meta:resourceKey="ddlUnknownFlagResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        
                                                                  
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="a-center">
                                                    <img title="Show Previous Data and History" alt="" onclick="ShowPrevious();" src="../Images/collapse_blue.jpg"
                                                        id="ShowPreviousData" style="cursor: pointer; display: none;" />
                                                </td>
                                                <td colspan="4">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr id="trExternalVisitID" runat="server" colspan="2">
                                                <td>
                                                    <asp:Label ID="lblExtVisitId" runat="server" Text="Ext VisitID" meta:resourcekey="lblExtVisitIdResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtExternalVisitID" runat="server" MaxLength="13" CssClass="Txtboxsmall"
                                                        onchange="CheckSMS();"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" meta:resourcekey="txtExternalVisitIDResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table>
                                                        <tr>
                                                            <td class="w-50p a-left">
                                                                <asp:Label ID="lblName" runat="server" Text="<u>N</u>ame" AssociatedControlID="txtName"
                                                                    AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-16p a-left">
                                                                <asp:DropDownList CssClass="ddl" ID="ddSalutation" runat="server" meta:resourcekey="ddSalutationResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:TextBox ID="txtName" onfocus="javascript:setPatientSearch();"   OnKeyPress="return  ValidateMultiLangChar(this) || ValidateOnlyNumeric(this) ;"
                                                                    onblur="javascript:ConverttoUpperCase(this.id);PatientdetailsHide();" autocomplete="off"
                                                                    runat="server" CssClass="Txtboxsmall" onKeyDown="javascript:PatientdetailsHide();"
                                                                    meta:resourcekey="txtNameResource1"> <%--onKeyDown="javascript:clearPageControlsValue('Y');"--%> </asp:TextBox>
                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                                    ServiceMethod="GetQuickPatientSearch" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                                    CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                    OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient" Enabled="True"
                                                                    OnClientPopulated="onListPopulated" MinimumPrefixLength="2">
                                                                </ajc:AutoCompleteExtender>
                                                                <img src="../Images/starbutton.png" alt="" class="a-center" />
                                                            </td>
                                                            
                                                        </tr>
                                                    </table>
                                                </td>
                                                 <td>
                                                    <asp:Label ID="lblLastName" runat="server" Text="Last Name" meta:resourcekey="lblLastNameResource1" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall" ID="txtLastName" runat="server">
                                                    </asp:TextBox>
                                                </td>
                                                <td class="w-5p a-left">
                                                    <table>
                                                        <tr>
                                                            <td class="w=22p a-left">
                                                                <asp:Label ID="lblSex" runat="server" Text="Se<u>x</u>" AssociatedControlID="ddlSex"
                                                                    AccessKey="X" meta:resourcekey="lblSexResource1"></asp:Label>
                                                            </td>
                                                            <td class="w=15p a-right">
                                                                <asp:DropDownList Width="60px" ID="ddlSex" runat="server" CssClass="ddl" meta:resourcekey="ddlSexResource1">
                                                                </asp:DropDownList>
                                                                <img src="../Images/starbutton.png" class="InCom"  alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-16p a-left">
                                                    <asp:Label ID="lblDOB" runat="server" Text="DO<u>B</u>" AssociatedControlID="tDOB"
                                                        AccessKey="B" meta:resourcekey="lblDOBResource1"></asp:Label>
                                                    <%--<asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status"></asp:Label>
                                                                    <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" runat="server">
                                                                    </asp:DropDownList>--%>
                                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                    <asp:TextBox CssClass="small datePicker" ToolTip="dd/mm/yyyy" placeholder="dd/mm/yyyy"
                                                        ID="tDOB" runat="server" onchange="javascript:CalculateAge(this);"
                                                        onblur="javascript:CalculateAge(this);" onkeypress="return RestrictInput(event)" Width="120px" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourceKey="tDOBResource1" onkeydown="javascript:preventInput(event);"/>
                                                    <%--<ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                        CultureTimePlaceholder="" Enabled="True" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                                        PopupButtonID="ImgBntCalc" Enabled="True" />--%>
                                                    <img src="../Images/starbutton.png" class="InCom"  alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" class="InCom" alt="" align="middle" />
                                                </td>
                                                <td class="w-6p a-left" id="tdSex1" runat="server">
                                                    <asp:Label ID="lblAge" runat="server" Text="Age" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td class="w-14p a-left" id="tdSex2" runat="server">
                                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onchange="setDOBYear(this.id,'LB');"
                                                             onkeypress="return ValidateOnlyNumeric(this);"    CssClass="Txtboxsmall"
                                                        Width="18%" runat="server" MaxLength="3" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                                    <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id); changestatus(this.id);" ID="ddlDOBDWMY" Width="114px"
                                                        runat="server" CssClass="ddl" meta:resourcekey="ddlDOBDWMYResource1">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" class="InCom" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" class="InCom" alt="" align="middle" />
                                                    <%-- <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                                        Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" >
                                                                    </ajc:TextBoxWatermarkExtender>--%>
                                                </td>
                                               
                                            </tr>
                                            <tr>
                                             <td>
                                                    <asp:Label ID="lblMarital" runat="server" Text="Marital Status" meta:resourcekey="lblMaritalResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" ID="ddMarital" runat="server" meta:resourcekey="ddMaritalResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblMobile" runat="server" Text="<u>M</u>obile +91" AssociatedControlID="txtMobileNumber"
                                                        meta:resourcekey="lblMobileResource1" AccessKey="M"></asp:Label>
                                                </td>
                                                <td class="v-middle a-left">
                                                    <asp:Label ID="lblCountryCode" runat="server" Width="10%" Style="display: none" meta:resourcekey="lblCountryCodeResource1"></asp:Label>
                                                    <asp:TextBox ID="txtMobileNumber" autocomplete="off" onchange="CheckSMS();"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="13" CssClass="Txtboxsmall" meta:resourcekey="txtMobileNumberResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" class="InCom" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" class="InCom" alt="" align="middle" />
                                                </td>
                                                <td class="w-8p">
                                                    <asp:Label ID="lblLandLine" runat="server" Text="<u>T</u>elephone" AssociatedControlID="txtPhone"
                                                        AccessKey="T" meta:resourcekey="lblLandLineResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPhone" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="15" CssClass="Txtboxsmall" meta:resourcekey="txtPhoneResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" class="InCom" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" class="InCom" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblEmail" Text="<u>E</u>-mail" runat="server" AssociatedControlID="txtEmail"
                                                        AccessKey="E" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" autocomplete="off" MaxLength="100" runat="server" onchange="CheckEmail();"
                                                        CssClass="Txtboxsmall" onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');"
                                                        meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                        id="imageEmail" runat="server" />
                                                    <%-- <asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                                        ControlToValidate="txtEmail" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                                        ValidationGroup="register" meta:resourceKey="regValidatorResource1">Email 
                                                            not valid</asp:RegularExpressionValidator>--%>
                                                </td>
                                               
                                            </tr>
                                            <tr>
                                             <td class="w-10p a-left">
                                                    <asp:Label ID="lblAddress" Text="<u>A</u>ddress" runat="server" AssociatedControlID="txtAddress"
                                                        AccessKey="A" meta:resourcekey="lblAddressResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAddress" autocomplete="off" runat="server" CssClass="Txtboxsmall"
                                                        meta:resourcekey="txtAddressResource1"></asp:TextBox>&nbsp;<img src="../Images/starbutton.png"
                                                            alt="" align="middle" style="display: none;" id="imageAddress" runat="server" />
                                                </td>
                                               
                                                <td>
                                                    <asp:Label ID="Rs_City" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                                        AccessKey="Y" meta:resourcekey="Rs_CityResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall" autocomplete="off" ID="txtCity" runat="server"
                                                        MaxLength="25" meta:resourcekey="txtCityResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                        id="imageCity" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPinCode" runat="server" Text="<u>P</u>inCode" AssociatedControlID="txtPincode"
                                                        AccessKey="P" meta:resourcekey="lblPinCodeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPincode"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        MaxLength="8" runat="server" autocomplete="off" CssClass="Txtboxsmall" meta:resourcekey="txtPincodeResource1"></asp:TextBox>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                        id="imagePincode" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCountry" runat="server" Text="<u>C</u>ountry" AssociatedControlID="ddCountry"
                                                        AccessKey="C" meta:resourcekey="lblCountryResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddCountry" onchange="javascript:loadState();" runat="server"
                                                        CssClass="ddlsmall" meta:resourcekey="ddCountryResource1">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <%--<td align="left" nowrap="nowrap">
                                                                    <asp:Label ID="Rs_State" runat="server" Text="<u>S</u>tate" AssociatedControlID="ddState"
                                                                        AccessKey="S"></asp:Label>
                                                                </td>
                                                                <td style="display: block;" nowrap="nowrap">
                                                                    <select id="ddState" runat="server" class="ddl" onchange="javascript:onchangeState();"
                                                                        width="75%">
                                                                    </select>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>--%>
                                            </tr>
                                            <tr id="trUrnType" runat="server">
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="Rs_State" runat="server" Text="<u>S</u>tate" AssociatedControlID="ddState"
                                                        AccessKey="S" meta:resourcekey="Rs_StateResource1"></asp:Label>
                                                </td>
                                                <td style="display: table-cell;" nowrap="nowrap" class="w-19p">
                                                    <select id="ddState" runat="server" class="ddlsmall" onchange="javascript:onchangeState();">
                                                    </select>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" meta:resourcekey="Rs_URNTypeResource1" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlUrnType" runat="server" onblur="CheckExistingURN1();" onChange="javascript:return CheckMRD();"
                                                        CssClass="ddlsmall" meta:resourcekey="ddlUrnTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_URNOf" runat="server" Text="URN Of" meta:resourcekey="Rs_URNOfResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlUrnoOf" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlUrnoOfResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_URN" Text="URN No" runat="server" meta:resourcekey="Rs_URNResource1" />
                                                </td>
                                                <td>
                                                    <input type="hidden" id="hdnUrn" runat="server" value="0" />
                                                    <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                        onKeyDown="javascript:ClearDiscountLimitValues();" MaxLength="50" onblur="CheckExistingURN1();ConverttoUpperCase(this.id);"></asp:TextBox>
                                                </td>
                                                <td style="display: none">
                                                    <asp:Label ID="lblPatientType" runat="server" Text="Patient Type" meta:resourcekey="lblPatientTypeResource1"></asp:Label>
                                                </td>
                                                <td style="display: none">
                                                    <asp:DropDownList ID="ddlPatientType" runat="server" CssClass="ddl w-93p" meta:resourcekey="ddlPatientTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr id="trPatientPriorityPart" runat="server">
                                                <td id="tdClientPart" runat="server">
                                                    <asp:Label ID="Rs_ClientName" runat="server" AccessKey="C" AssociatedControlID="txtClient"
                                                        Text="&lt;u&gt;C&lt;/u&gt;lient Name" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                </td>
                                                <td id="tdClientParttxt" runat="server">
                                                    <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                        onblur="ClearRate();" onfocus="CheckOrderedItems();" meta:resourcekey="txtClientResource1"></asp:TextBox>
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
                                                        Text="Ref &lt;u&gt;H&lt;/u&gt;os" meta:resourcekey="lblReferingHospitalResource1"></asp:Label>
                                                </td>
                                                <td id="tdRefHosParttxt" runat="server">
                                                    <asp:TextBox ID="txtReferringHospital" autocomplete="off" runat="server" onblur="ClearHospitalID(this.id)"
                                                        onkeyup="SetContextKey()" CssClass="AutoCompletesearchBox" meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
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
                                                        Text="Ref Dr." meta:resourcekey="lblRefbyResource1"></asp:Label>
                                                </td>
                                                <td id="tdRefDrParttxt" runat="server">
                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox"
                                                        onFocus="return getrefhospid(this.id)" onKeyDown="javascript:ClearDiscountLimitValues();"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                        OnClientShown="DocPopulated" FirstRowSelected="true" MinimumPrefixLength="2"
                                                        OnClientItemSelected="PhysicianSelected" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected" TargetControlID="txtInternalExternalPhysician">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLocation" runat="server" Text="Proxy Registration By" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                    <asp:Label ID="lblPriority" runat="server" Text="Priority" Visible="False" meta:resourcekey="lblPriorityResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList Width="10%" ID="ddlPriority" runat="server" CssClass="ddl" Visible="False"
                                                        meta:resourcekey="ddlPriorityResource1">
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="txtLocClient" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                        onblur="Location();" meta:resourcekey="txtLocClientResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="OnCollectioncenterselectedClient"
                                                        ServiceMethod="GetCollectionCenterClientNames" ServicePath="~/WebService.asmx"
                                                        TargetControlID="txtLocClient">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr id="trVisitTypePart" runat="server" style="display: none;">
                                                <td>
                                                    <asp:Label ID="lblPatient" runat="server" Text="Vis<u>i</u>t Type" AssociatedControlID="ddlIsExternalPatient"
                                                        AccessKey="I" meta:resourcekey="lblPatientResource1"></asp:Label>
                                                </td>
                                                <td id="tdlblWardNo" style="display: table-cell;">
                                                    <asp:DropDownList CssClass="ddlsmall" onchange="javascript:SelectVisitType();" ID="ddlIsExternalPatient"
                                                        runat="server" meta:resourcekey="ddlIsExternalPatientResource1">
                                                        <%--<asp:ListItem Text="OP" Value="0" Selected="True" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblWardno" runat="server" Text="<u>W</u>ard No" AssociatedControlID="txtWardNo"
                                                        AccessKey="W" meta:resourcekey="lblWardnoResource1"></asp:Label>
                                                </td>
                                                <td id="tdtxtWardNo" style="display: table-cell;">
                                                    <asp:TextBox ID="txtWardNo" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtWardNoResource1"></asp:TextBox>
                                                </td>
                                                <td id="td2" nowrap="nowrap">
                                                    <asp:Label ID="Label1" runat="server" Text="Ex Patient Number" meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td id="td55">
                                                    <asp:TextBox ID="txtExternalPatientNumber" autocomplete="off" CssClass="Txtboxsmall"
                                                        runat="server" meta:resourcekey="txtExternalPatientNumberResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPatientStatus" runat="server" Text="Patient Status:" meta:resourcekey="lblPatientStatusResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlPatientStatus" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlPatientStatusResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr id="trSampleTRFPart" runat="server" style="display: none;">
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblSampleDate" runat="server" AccessKey="K" AssociatedControlID="txtSampleDate"
                                                        Text="Sample Pic&lt;u&gt;k&lt;/u&gt;up" meta:resourcekey="lblSampleDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtSampleDate" runat="server" CssClass="Txtboxsmall w-50p" onblur="AdditionalDetails();"
                                                        meta:resourcekey="txtSampleDateResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('txtSampleDate','ddmmyyyy','arrow',true,12);document.getElementById('txtSampleDate').focus();">
                                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                                    <%--  <img id="img1" alt="Pick a date" border="0" height="16" onclick="datePick('txtSampleDate');document.getElementById('txtSampleDate').focus();"
                                                                        src="../Images/Calendar_scheduleHS.png" style="cursor: hand;" width="16" />--%>
                                                    <asp:TextBox ID="txtcurrendate" runat="server" CssClass="Txtboxsmall" Style="display: none;"></asp:TextBox>
                                                    &nbsp;
                                                    <asp:CheckBox ID="chkSamplePickup" onclick="AdditionalDetails();" runat="server"
                                                        Text="Collected?" meta:resourcekey="chkSamplePickupResource1" />
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPhlebo0" runat="server" Text="Phlebotomist Name" meta:resourcekey="lblPhlebo0Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPhleboName" runat="server" CssClass="AutoCompletesearchBox" onkeydown="javascript:return javPhlebotomistDetails();"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPhlebo" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                        Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="Selectedphlebotomist"
                                                        ServiceMethod="FetchphlebotomistName" ServicePath="~/WebService.asmx" TargetControlID="txtPhleboName">
                                                    </ajc:AutoCompleteExtender>
                                                    <%--<img src="../Images/starbutton.png" alt="" class="a-center" />--%>
                                                    <span id="hideStar" runat="server">
                                                        <img src="../Images/starbutton.png" alt="" class="a-center" /></span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLogistics" runat="server" Text="Logistics Name" meta:resourcekey="lblLogisticsResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLogistics" runat="server" CssClass="AutoCompletesearchBox"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLogi" runat="server" BehaviorID="AutoCompleteExLstGrp48"
                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                        Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="SelectedLogistics"
                                                        ServiceMethod="FetchLogisticsName" ServicePath="~/WebService.asmx" TargetControlID="txtLogistics">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRoundNo" runat="server" meta:resourcekey="lblRoundNoResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRoundNo" runat="server" autocomplete="off" CssClass="Txtboxsmall"></asp:TextBox>
                                                </td>
                                                <td id="trPatientDetails" style="display: none;">
                                                    <div id="showimage" style="display: none;" class="showimage1">
                                                        <table border="0" width="100%" class="modalPopup dataheaderPopup">
                                                            <tr>
                                                                <td align="right">
                                                                    <div onclick="hidebox();return false" class="divCloseRight">
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td id="dragbar" style="cursor: move; cursor: pointer" class="w-100p" onmousedown="initializedrag(event)">
                                                                    <asp:Label ID="lblPatientDetails" runat="server" meta:resourcekey="lblPatientDetailsResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                            <td>
                                                    <asp:Label ID="lblSuburban" runat="server" Text="Suburb" AssociatedControlID="txtSuburban"
                                                        AccessKey="B" meta:resourcekey="lblSuburbanResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall" autocomplete="off" ID="txtSuburban" runat="server"
                                                        MaxLength="25" meta:resourcekey="txtSuburbanResource1"></asp:TextBox>
                                                </td>
                                                 <td>
                                                    <asp:Label ID="lblEntityCode" runat="server" Text="Entity Code" AssociatedControlID="txtEntitycode"
                                                        meta:resourcekey="lblEntityCodeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall"  ID="txtEntitycode" runat="server"
                                                      ></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblscopeproc" runat="server" Text="Scope of the procedure" AssociatedControlID="txtscopeproce"
                                                         meta:resourcekey="lblscopeprocResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall"  ID="txtscopeproce" runat="server"
                                                      ></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblpurposeproc" runat="server" Text="Purpose of the procedure" AssociatedControlID="txtpurposeproc"
                                                       meta:resourcekey="lblpurposeprocResource1" ></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall"  ID="txtpurposeproc" runat="server"
                                                      ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <%--<tr>
                                                                <td>
                                                                    <asp:Label ID="lblDespatchType" runat="server" Text="Dispatch Type"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:CheckBoxList ID="chkDisPatchType" RepeatDirection="Horizontal" runat="server">
                                                                    </asp:CheckBoxList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblDespatchmode" runat="server" Text="Dispatch Mode"></asp:Label>
                                                                </td>
                                                                <td colspan="5">
                                                                    <asp:CheckBoxList ID="chkDespatchMode" RepeatDirection="Horizontal" runat="server">
                                                                    </asp:CheckBoxList>
                                                                    <asp:DropDownList ID="ddlDespatchMode" Style="display: none;" Width="86%" CssClass="ddl"
                                                                        runat="server">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>--%>
                                            <tr id="tdAdditionalDetails" runat="server">
                                                <td colspan="2" nowrap="nowrap">
                                                    <asp:CheckBox ID="chkExcludeAutoathz" runat="server"  meta:resourcekey="chkExcludeAutoathzResource1" />
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <input id="ChkTRFImage" runat="server" onclick="ShowTRFUpload(this, this.id);" type="checkbox"
                                                        value="Upload" />
                                                    &nbsp;<asp:Label ID="lblTRF" runat="server" AccessKey="U" AssociatedControlID="ChkTRFImage"
                                                        Style="color: #2C88B1; font-size: small;" Text="TRF Image &lt;u&gt;U&lt;/u&gt;pload"
                                                        meta:resourcekey="lblTRFResource1"></asp:Label>
                                                </td>
                                                <td colspan="2">
                                                    <div id="TRFimage" style="display: none;">
                                                        <asp:FileUpload ID="FileUpload1" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF"
                                                            class="multi" meta:resourcekey="FileUpload1Resource1" />
                                                    </div>
                                                </td>
                                                <td>
                                                </td>
                                                <td nowrap="nowrap">
                                                </td>
                                            </tr>
                                            <tr id="trDispType" runat="server" style="display: none;">
                                                <td>
                                                    <asp:Label ID="lblDespatchType" runat="server" Text="Dispatch Type" meta:resourcekey="lblDespatchTypeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="panelDispatchType" runat="server" CssClass="dataheaderInvCtrl w-100p"
                                                        Font-Bold="True" meta:resourcekey="panelDispatchTypeResource1">
                                                        <asp:CheckBoxList ID="chkDisPatchType" RepeatDirection="Horizontal" runat="server"
                                                            Font-Size="10px" Font-Bold="true">
                                                        </asp:CheckBoxList>
                                                    </asp:Panel>
                                                </td>
                                                <%--<td>
                                                                    &nbsp;
                                                                </td>--%>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblDespatchmode" runat="server" Text="Dispatch Mode" meta:resourcekey="lblDespatchmodeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="panelDispatchMode" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="True"
                                                        meta:resourcekey="panelDispatchModeResource1">
                                                        <asp:CheckBoxList ID="chkDespatchMode" RepeatDirection="Horizontal" runat="server"
                                                            Font-Size="10px" Font-Bold="true">
                                                        </asp:CheckBoxList>
                                                        <asp:DropDownList ID="ddlDespatchMode" Style="display: none;" Width="86%" CssClass="ddl"
                                                            runat="server" meta:resourcekey="ddlDespatchModeResource1">
                                                        </asp:DropDownList>
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblnotification" runat="server" Text="Notification" meta:resourcekey="lblnotificationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="panelnotification" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="True"
                                                        meta:resourcekey="panelnotificationResource1">
                                                        <asp:CheckBoxList ID="ChkNotification" RepeatDirection="Horizontal" runat="server"
                                                            Font-Size="10px" Font-Bold="true">
                                                        </asp:CheckBoxList>
                                                        <asp:CheckBox ID="chkMobileNotify" Text="Sms" ToolTip="Send SMS Notification" Font-Bold="true"
                                                            Font-Size="10px" runat="server" Style="display: none" />
                                                    </asp:Panel>
                                                </td>
                                                <td id="trApprovalNo" runat="server" colspan="2">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td class="w-40p a-left">
                                                                <asp:Label ID="lblApprovalNo" runat="server" Text="Approval No" meta:resourcekey="lblApprovalNoResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-center">
                                                                <asp:TextBox ID="txtApprovalNo" runat="server" AutoCompleteType="Disabled" MaxLength="13"
                                                                    CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" Width="80%" meta:resourcekey="txtApprovalNoResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr id="trEditRemarks" runat="server" style="display: none;">
                                                <td>
                                                    <asp:Label ID="EditlblHistory" runat="server" Text="History " meta:resourcekey="EditlblHistoryResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="EditPatientHistory" Width="50%" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                        onFocus="return expandTextBox(this.id)" TextMode="MultiLine" meta:resourcekey="EditPatientHistoryResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="EditlblRemarks" runat="server" Text="Remarks" meta:resourcekey="EditlblRemarksResource1"></asp:Label>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="EdittxtRemarks" Width="76%" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                        onFocus="return expandTextBox(this.id)" TextMode="MultiLine" meta:resourcekey="EdittxtRemarksResource1"></asp:TextBox>
                                                </td>
                                                <td id="tdPatientHistory" runat="server" class="a-left" style="display:none">
                                                    <asp:LinkButton runat="server" ToolTip="Click Here to Patient History" ID="LinkPatientHistory"
                                                        Text="Capture Patient History" OnClientClick="Editpatienthistory();" Font-Underline="True"
                                                        ForeColor="Red" Font-Bold="True"></asp:LinkButton>
                                                    <div id="divHistoryDetail" style="display: none;">
                                                        <table class="w-100p a-center" cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor">
                                                            <tr id="divpatienthistory" runat="server">
                                                                <td id="td5" class="a-center" runat="server">
                                                                    <PHis:PatientCaptureHistory ID="patientcapturehistory1" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr style="display: none;">
                                                <td style="display: none;">
                                                    <asp:Label ID="lblCollectionCode" Text="<u>L</u>ocation" runat="server" AssociatedControlID="txtCollectionCode"
                                                        AccessKey="L" meta:resourcekey="lblCollectionCodeResource1"></asp:Label>
                                                </td>
                                                <td style="display: none;">
                                                    <asp:TextBox ID="txtCollectionCode" autocomplete="off" runat="server" CssClass="Txtboxsmall"
                                                        meta:resourcekey="txtCollectionCodeResource1"></asp:TextBox>
                                                </td>
                                                <td id="trRate" runat="server" style="display: none;">
                                                    Rate &nbsp;
                                                    <asp:DropDownList ID="ddlRate" runat="server" Enabled="False" onChange="javascript:setRate(this.value);"
                                                        meta:resourcekey="ddlRateResource1">
                                                        <%--   <asp:ListItem Selected="True" meta:resourcekey="ListItemResource6" Text="--Select--"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="display: none;">
                                                    <asp:Label ID="Rs_Nationality" runat="server" Text="Nationality" meta:resourcekey="Rs_NationalityResource1"></asp:Label>
                                                    <asp:DropDownList CssClass="ddl" ID="ddlNationality" runat="server" meta:resourcekey="ddlNationalityResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div id="ShowBillingItems" style="display: none; position: absolute; width: 43%;
                                                        right: 0%; top: 4%;">
                                                        <table class="modalPopup dataheaderPopup w-32p">
                                                            <tr>
                                                                <td class="a-right">
                                                                    <div onclick="Itemhidebox();return false" class="divCloseRight" style="margin: 0 0 0 0;">
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td id="Itemdragbar" style="cursor: move; cursor: pointer" class="w-100p">
                                                                    <asp:Label ID="lblPreviousItems" runat="server" meta:resourcekey="lblPreviousItemsResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="divShowClientDetails" style="display: none; position: absolute; width: 35%;
                                                        left: 61%; top: 1%">
                                                        <div onclick="Itemhidebox();return false" class="divCloseRight">
                                                        </div>
                                                        <table class="modalPopup dataheaderPopup w-32p">
                                                            <tr>
                                                                <td id="Td4" style="cursor: move; cursor: pointer" class="w-100p">
                                                                    <asp:Label ID="lblClientDetails" runat="server" meta:resourcekey="lblClientDetailsResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
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
            <tr id="trOrderCalcPart" runat="server" style="display: table-row;">
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
                    <div id="CoPayMent" style="display: none" runat="server" class="dataheader3">
                        <uc19:ClientTpa IsBilling="Y" ID="uctlClientTpa" runat="server" />
                    </div>
                    <div>
                        <BillingPart:BPart ID="billPart" runat="server" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="dataheader3 a-center">
                    <table class="w-100p">
                        <tr>
                            <td>
                                <asp:Button ID="btnGenerate" runat="server" Width="100px" Text="Generate Bill" CssClass="btn"
                                    OnClientClick="javascript:return  validateEvents('After');" OnClick="btnGenerate_Click"
                                    onmouseout="this.className='btn'" meta:resourcekey="btnGenerateResource1" />
                                <button runat="server" id="btnClose" class="btn" onclick="javascript:clearbuttonClick();">
                                    <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_10 %>
                                </button>
                                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" Style="display: none;"
                                    OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                <asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn" Style="display: none;"
                                    meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table id="tblDatepicker" runat="server" style="display: none;">
            <tr>
                <td>
                    <table class="dataheader2">
                        <tr>
                            <td colspan="1">
                                <asp:Label ID="lblSampleDateTime" runat="server" Text="Sample Collected Date Time"
                                    Font-Bold="True" meta:resourcekey="lblSampleDateTimeResource1"></asp:Label>
                            </td>
                            <td>
                                <DateTimePicker:DateTimePicker ID="DateTimePicker1" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table class="w-100p" id="trCollectSample" runat="server" style="display: none;">
            <tr>
                <td>
                    <CollectSample:CollectSample ID="ctlCollectSample" runat="server" />
                    <asp:Panel CssClass="dataheaderInvCtrl w-100p searchPanel" runat="server" ID="pnlDept"
                        meta:resourcekey="pnlDeptResource1">
                        <table id="deptTab" runat="server">
                            <tr id="Tr1" class="Duecolor h-20" runat="server">
                                <td id="Td3" runat="server">
                                    <asp:Label ID="lblDeptheader" runat="server" meta:resourcekey="lblDeptheaderResource1"> <%=Resources.Billing_ClientDisplay.Billing_LabQuickBilling_aspx_12%> </asp:Label>
                                </td>
                            </tr>
                            <tr id="Tr2" runat="server">
                                <td id="Td58" class="w-100p v-top a-left" runat="server">
                                    <asp:DataList class="w-100p" ID="repDepts" runat="server" RepeatColumns="5">
                                        <ItemTemplate>
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="h-20">
                                                        <asp:CheckBox ID="chkDept" runat="server" />
                                                        <asp:Label ID="lblDeptName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DeptName")%>'> </asp:Label>
                                                    </td>
                                                    <td class="h-20">
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
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Generate Work Order"
                        Style="cursor: pointer;" CssClass="btn" OnClick="btnFinish_Click" onmouseout="this.className='btn'"
                        onmouseover="this.className='btn btnhov'" Text="Generate Work Order" meta:resourcekey="btnFinishResource1" />
                    &nbsp;
                    <asp:Button ID="Button1" runat="server" Width="70px" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" Text="Cancel" OnClick="btnHome_Click" meta:resourcekey="Button1Resource1" />
                </td>
            </tr>
        </table>
        <div id="iframeplaceholder">
            <iframe runat="server" id='iframeBarcode' name='iframeBarcode' style='position: absolute;
                top: 0px; left: 0px; width: 0px; height: 0px; border: 0px; overflow: none; z-index: -1'>
            </iframe>
        </div>
        <div id="iframeplaceholderBill">
        </div>
        <br />
        <br />
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
    <input id="hdnEditBill" type="hidden" value="N" runat="server" />
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
    <input type="hidden" runat="server" id="hdnTpaRoundoff" />
    <input type="hidden" runat="server" id="hdnTpaRoundOffType" />
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
    <input type="hidden" id="HdnCoPay" runat="server" />
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
    <asp:HiddenField ID="hdnDOFromVisitFlag" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnDefaultClienID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnDefaultClienName" runat="server" />
    <input id="hdntaskID" type="hidden" value="-1" runat="server" />
    <input id="hdnddlsalutation" runat="server" value="0" type="hidden" />
    <asp:HiddenField ID="hdnSampleforPrevious" runat="server" />
    <asp:HiddenField ID="hdnIsEditRePush" runat="server" />
    <asp:HiddenField ID="hdnIsEditDeFlag" runat="server" />
    <asp:HiddenField ID="hdnPatientEmailId" runat="server" />
    <asp:HiddenField ID="hdnReferringDoctor" runat="server" />
    <asp:HiddenField ID="hdnDOBMonth" runat="server" />
    <asp:HiddenField ID="hdnPhoneNo" runat="server" />
    <asp:HiddenField ID="hdnMobileNo" runat="server" />
    <asp:HiddenField ID="hdnPatientAddress" runat="server" />
    <asp:HiddenField ID="hdnIncompleteAge" runat="server" />
    <asp:HiddenField ID="hdnddlDOBDWMY" runat="server" />
    <asp:HiddenField ID="hdnLocationClient" runat="server" />
    <asp:HiddenField ID="hdnPageType" runat="server" Value="B2C" />
    <asp:HiddenField ID="hdnMemberShipCardNo" runat="server" />
    <asp:HiddenField ID="hdnDue" runat="server" Value="" />
    <asp:HiddenField ID="HdnPhleboNameMandatory" runat="server" Value="Y" />
    <asp:HiddenField ID="hdnvisitnumber" runat="server" />
    <asp:HiddenField ID="hdnRoundNo" runat="server" />
    <asp:HiddenField ID="hdnCheckFlag" runat="server" />
    <asp:HiddenField ID="hdnClientFlag" runat="server" />
    <input type="hidden" id="HdnDueBillalertMsg" runat="server" value="N" />
    <asp:HiddenField ID="hdnPhlebotomist" runat="server" />
    <input id="hdnCollectionID" runat="server" value="0" type="hidden" />
    <input id="hdnTotalDepositAmount" runat="server" value="0" type="hidden" />
    <input id="hdnTotalDepositUsed" runat="server" value="0" type="hidden" />
    <input id="hdnAmtRefund" runat="server" value="0" type="hidden" />
    <input id="hdnThresholdType" runat="server" value="0" type="hidden" />
    <input id="hdnThresholdValue" runat="server" value="" type="hidden" />
    <input id="hdnThresholdValue2" runat="server" value="" type="hidden" />
    <input id="hdnThresholdValue3" runat="server" value="" type="hidden" />
    <input id="hdnVirtualCreditType" runat="server" value="0" type="hidden" />
    <input id="hdnVirtualCreditValue" runat="server" value="" type="hidden" />
    <input id="hdnMinimumAdvanceAmt" runat="server" value="0" type="hidden" />
    <input id="hdnMaximumAdvanceAmt" runat="server" value="0" type="hidden" />
    <input id="hdnchangedGender" runat="server" value="" type="hidden" />
    <input id="hdnDofromVisitfreeze" runat="server" value="N" type="hidden" />
    <input id="hdnBookingType" runat="server" value="N" type="hidden" />
    

     <asp:HiddenField ID="hdncollectcashforcreditclient" runat="server"  Value="N"/>
      <asp:HiddenField ID="hdnCheckIsDiscout" runat="server" Value="N" />
    <asp:HiddenField ID="hdnloadhistory" runat="server" Value="N" />
    <asp:HiddenField ID="hdnPatientHistory" runat="server" Value="" />
    <asp:HiddenField ID="hdnDisplayTblID" runat="server" Value="" />
    <asp:HiddenField ID="hdnPhcInvID" runat="server" Value="" />
        <asp:HiddenField ID="hdnConfigCapturehistory" runat="server" Value="N" />
    <%-- Added by Thamilselvan to store the MemberShipCardNo while Generate the Bill...--%>

    <script type="text/javascript">

        function preventInput(evnt) {
            //Checked In IE9,Chrome,FireFox
            if (evnt.which != 9) evnt.preventDefault();
        }

        if (document.getElementById('hdnBillGenerate').value == "Y") {
            document.getElementById('trCollectSample').style.display = "table";
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
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
                //return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
            }
        }
        function getrefhospid(source, eventArgs) {

            var sval = 0;

            var OrgID = document.getElementById('hdnOrgID').value;
            var rec = document.getElementById('hdfReferalHospitalID').value;
            var sval = "RPH" + "^" + OrgID + "^" + rec;
            $find('AutoCompleteExtenderRefPhy').set_contextKey(sval);
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
            if ($('#HdnPhleboNameMandatory').val() != 'N') {
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

    <%--Added by Thamilselvan to store the MemberShipCardNo while Generate the Bill--%>
    <div id="iframeBill1">
    </div>

    <script type="text/javascript">
        function Enabled() {

            document.getElementById('<%=ddSalutation.ClientID%>').disabled = true;
            document.getElementById('<%=txtName.ClientID%>').readOnly = true;
            document.getElementById('<%=txtReferringHospital.ClientID%>').readOnly = true;
            document.getElementById('<%=txtInternalExternalPhysician.ClientID%>').readOnly = true;
            document.getElementById('<%=ddlSex.ClientID%>').disabled = true;


            document.getElementById('<%=tDOB.ClientID%>').readOnly = true;
            document.getElementById('<%=txtDOBNos.ClientID%>').readOnly = true;
            document.getElementById("hdnddlDOBDWMY").value = document.getElementById('<%=ddlDOBDWMY.ClientID%>').value;
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

    <script type="text/javascript">
        function javPhlebotomistDetails() {
            /* Added By Venkatesh S */
            var vPhlebotomist = SListForAppMsg.Get('Billing_LabQuickBilling_aspx_04') == null ? "Please select Phlebotomist Name from the list" : SListForAppMsg.Get('Billing_LabQuickBilling_aspx_04');

            if ($('#HdnPhleboNameMandatory').val() != 'N') {
                document.getElementById('HdnPhleboID').value = "";

                $find('AutoCompleteExLstGrp55')._onMethodComplete = function(result, context) {

                    $find('AutoCompleteExLstGrp55')._update(context, result, false);
                    if (result == "") {
                        //alert('Please select Phlebotomist Name from the list');
                        ValidationWindow(vPhlebotomist, AlertType);
                        $('#txtPhleboName').val("");
                        document.getElementById('txtPhleboName').focus();
                        return false;
                    }
                };
            }
        }
    </script>

    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/CopaymentAndPreAuth.js" type="text/javascript"></script>

    <%-- <script src="../Scripts_New/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <%--   <script src="../scripts_New/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/CollectSample.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <%--   <script src="../Scripts_New/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>--%>
    <%--   <script src="../Scripts_New/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

   
    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>--%>
    <%--    <script type="text/javascript" src="../Scripts_New/datetimepicker_css.js"></script>--%>

    <script type="text/javascript" language="javascript">
        var AlertType;
        //Added the actionType to Generate the Bill in Poupups.... By Thamilselvan R....
        function OpenIframe(FinalBillID, patientVisitID) {
            $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&finalBillID=" + FinalBillID + "&actionType=DefaultPrint&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
        }

        $(document).ready(function() {
            AlertType = SListForAppMsg.Get('Billing_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_Header_Alert');
            CheckISEdit();
            $('INPUT[type="text"]').focus(function() {
                $(this).addClass("focus");
            });
            $('INPUT[type="text"]').blur(function() {
                $(this).removeClass("focus");
            });
            $("#txtExternalVisitID").focus();
            $('form').attr("keypress", "SuppressBrowserRefresh()");
        });

        function labQuickBilling() {
            window.location.assign("../Billing/LabQuickBilling.aspx?IsPopup=Y");
            return false;
        }
        function ClearHospitalID(id) {

            if (document.getElementById(id).value == "") {
                document.getElementById("hdnReferralType").value = "0";
                document.getElementById("hdfReferalHospitalID").value = "0";

                //alert(document.getElementById(id).value + "test" + document.getElementById("hdnReferralType").value);
            }
        }
        function AddBillingItemsDetailsForEdit(ClientID) {
            /* Added By Venkatesh S */
            var vAssociatedWithClient = SListForAppMsg.Get('Billing_LabQuickBilling_aspx_01') == null ? "Services are not Associated With this Client" : SListForAppMsg.Get('Billing_LabQuickBilling_aspx_01');
            var vTestServices = SListForAppMsg.Get('Billing_LabQuickBilling_aspx_02') == null ? "The Below Test Services are not Associated With this Client" : SListForAppMsg.Get('Billing_LabQuickBilling_aspx_02');
            var vContactAdmin = SListForAppMsg.Get('Billing_LabQuickBilling_aspx_03') == null ? "Please Contact Admin" : SListForAppMsg.Get('Billing_LabQuickBilling_aspx_03');

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
                            //alert('Services are not Associated With this Client');
                            ValidationWindow(vAssociatedWithClient, AlertType);
                            return false;
                        }
                        /******/
                        var IsNotMapService = 'N';
                        var lstNotMapService = '';
                        arrGotValue = list1[0].ProcedureName;
                        BilledList = arrGotValue.split('#');
                        for (var j = 0; j < BilledList.length - 1; j++) {
                            if (BilledList[j] != '' && BilledList[j].length > 0) {
                                arrGotValue = '';
                                arrGotValue = BilledList[j].split('^');
                                if (arrGotValue[19] == 'N') {
                                    IsNotMapService = 'Y';
                                    lstNotMapService += '\n' + arrGotValue[1].trim();
                                }
                            }
                        }
                        if (IsNotMapService == 'Y') {
                            if (!confirm('' + vTestServices + ' ' + lstNotMapService + '\n ' + vContactAdmin + '')) {
                                return false;
                            }
                            else {
                                return false;
                            }
                        }
                        /*****/
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
                                if (arrGotValue[19] == 'Y') {
                                    ID = arrGotValue[0];
                                    name = arrGotValue[1].trim();
                                    feeType = arrGotValue[2];
                                    amount = arrGotValue[3];
                                    Remarks = arrGotValue[5];
                                    isReimursable = arrGotValue[6];
                                    ReportDate = arrGotValue[7];
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
                                    //document.getElementById('billPart_btnAdd').disabled = false;
                                    var FeeID = document.getElementById('billPart_hdnID').value;
                                    var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;
                                    DuplicateInv(FeeID, FeeType);
                                }
                            }
                            else {

                                document.getElementById('billPart_txtTestName').value = '';
                                document.getElementById('billPart_txtTestName').focus();
                            }
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
                    document.getElementById('billPart_tblnetamt').style.display = "table";
                    document.getElementById('divOrder').style.display = "none";
                    document.getElementById('txtName').setAttribute('autocomplete', 'off');
                    AddBillingItemsDetailsForEdit(0);
                    Enabled();
                }
            }
        }
        function CheckSMS() {
            // var elements = document.getElementById('chkDespatchMode');
            if (document.getElementById('txtMobileNumber').value != '') {
                document.getElementById('chkMobileNotify').checked = true;
                document.getElementById('chkDespatchMode_1').checked = true;
                //elements.cells[1].childNodes[0].checked = true;
            }
            else {
                document.getElementById('chkMobileNotify').checked = false;
                //elements.cells[1].childNodes[0].checked = false;
                document.getElementById('chkDespatchMode_1').checked = false;
            }

            //var elements = document.getElementById('ChkNotification');
            if (document.getElementById('txtMobileNumber').value != '') {
                document.getElementById('chkDespatchMode_1').checked = true;
                //  elements.cells[1].childNodes[0].checked = true;
                document.getElementById('ChkNotification_1').checked = true;
            }
            else {
                document.getElementById('chkDespatchMode_1').checked = false;
                //elements.cells[1].childNodes[0].checked = false;
                document.getElementById('ChkNotification_1').checked = false;
            }
        }

        function CheckEmail() {
            //var elements = document.getElementById('chkDespatchMode');
            if (document.getElementById('txtEmail').value != '') {
                document.getElementById('chkDespatchMode_0').checked = true;
                //elements.cells[0].childNodes[0].checked = true;
            }
            else {
                //elements.cells[0].childNodes[0].checked = false;
                document.getElementById('chkDespatchMode_0').checked = false;

            }
            //        var elements = document.getElementById('ChkNotification');
            //        if (document.getElementById('txtEmail').value != '') {
            //            document.getElementById('ChkNotification_0').checked = true;
            //            elements.cells[0].childNodes[0].checked = true;
            //        }
            //        else {
            //            document.getElementById('ChkNotification_0').checked = false;
            //            elements.cells[0].childNodes[0].checked = false;
            //        }
        }
        // In Edit Bill cancel the backspace navigation By Nallathambi
        var KEYCODE_BACKSPACE = 8;
        $(document).keydown(SuppressKeyStrokes);
        function SuppressKeyStrokes(e) {
            if ((e.keyCode == KEYCODE_BACKSPACE && e.target.type == "text" && e.target.readOnly == true)) {

                e.preventDefault();
                e.stopImmediatePropagation();
                return false;
            }
        };
    </script>

    <style>
        .ddlsmall
        {
            width: 156px !important;
        }
        .AutoCompletesearchBox
        {
            width: 132px !important;
        }
        #showimage.showimage1
        {
            position: absolute;
            width: 440px;
            left: auto;
            right: 10%;
            top: 3%;
        }
        /*.divCloseRight
        {
            margin: -10px -11px 0 0px !important;
            background-image: url(../Themes/IB/Images/Delete.png) !important;
        }*/</style>

    <script type="text/javascript">
        function SetContextKey() {

            // var Getcontext = $find('AutoCompleteExtenderReferringHospital').get_contextKey();




            $find('AutoCompleteExtenderReferringHospital').set_contextKey($("#txtClient").val());
        }

        $(function() {
            $(".datePicker").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    //$(".datePicker").datepicker("option", "maxDate", selectedDate);

                    //var date = $("#txtFrom").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });

        });
    </script>

    <script type="text/javascript">
        $(document).on("click", "[id*=LinkPatientHistory]", function() {
             $("#divpatienthistory").dialog({
                width: 1000,
                height : 550,
                position: ['middle', 50],
                closeOnEscape: true,
                title: "Patient History",
                modal: true,
                buttons: {
                    "Save": {
                        text: 'Save',
                        id: 'DiaSave',
                        click: (function() {
                            SavePatientHistory();
                            $(this).dialog("close");
                            var emptyValue = $('[id$="hdnPatientHistory"]').val().split('~');
                            if (emptyValue.length ==0) {

                                alert("Please provide any one history...!");
                                return false;
                            }
                        })
                    },
                    "Update": {
                        text: 'Update',
                        id: 'DiaUpdate',
                        click: (function() {
                            UpdatePatientHistory();
                            $(this).dialog("close");
                        }),
                        style: 'display:none'
                        //disabled: true
                    },
                    "Cancel": function() {
                        $(this).dialog("close");
                    }
                }
            });
            return false;
        });

        function Editpatienthistory() {
            //debugger;
            $('option:not(:selected)').attr('disabled', true);
            $('input[type="text"], textarea').attr('readonly', 'readonly');
            $("input[id*='patientcapturehistory1_chk']").prop("disabled", true);

            $('#patientcapturehistory1_MSTPatientHisory').hide();
            $('#patientcapturehistory1_PanelSomaticpatientHistiry').hide();
            $('#patientcapturehistory1_PanelTSPBreastFormat').hide();
            $('#patientcapturehistory1_PanelTSPColon').hide();
            $('#patientcapturehistory1_PanelTSPLung').hide();
            $('#patientcapturehistory1_PatientHistorypanel').hide();

            var OrgID = $('#hdnOrgID').val();
            var VisitID = $('#hdnVisitID').val();
            AjaxcontentData = "{'OrgID':" + OrgID + ",'VisitID':" + VisitID + "}";
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetEditPatientHistory ",
                contentType: "application/json;charset=utf-8",
                data: AjaxcontentData,
                dataType: "json",
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice GetEditPatientHistory calling");
                    //$('#divHistoryDetail').hide();
                    return false;
                }
            });
        }
        var lstEdithis = [];
        function AjaxGetFieldDataSucceeded(result) {

            lstEdithis = result.d;
            if (lstEdithis.length == 0) {

                $('#DivalertHistory').show();
                $('.ui-dialog-buttonpane').find('button:first').css('display', 'none');
                
            }
            for (var i = 0; i < lstEdithis.length; i++) {

                //Germline Format

                if (lstEdithis[i].ActionType == "Germline Format") {

                    $('#patientcapturehistory1_lblformat').text(lstEdithis[i].Description);
                    $('#patientcapturehistory1_PatientHistorypanel').show();
                    $('.ui-dialog-buttonpane').find('button:first').css('display', 'none');
                    $('.ui-dialog-buttonpane').find('button:nth-child(2)').css('display', 'inline-block');
                    $('#patientcapturehistory1_lnkEditGermline').show();

                    if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                        $('#patientcapturehistory1_txtdescription').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                        $('#patientcapturehistory1_ddlAssinee').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Indications") {

                        $('#patientcapturehistory1_ddlindications').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                        $('#patientcapturehistory1_txtfamilyhistory').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Referal For") {

                        $('#patientcapturehistory1_ddlreferral').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {

                        $('#patientcapturehistory1_txtkeyfinding').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Germline Panel Type") {

                        $('#patientcapturehistory1_ddlpaneltype').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Is Affected with cancer") {

                        $('#patientcapturehistory1_ddlcancer').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                        $('#patientcapturehistory1_txttype').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                        $('#patientcapturehistory1_txtOptionalDescription').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {

                        $('#patientcapturehistory1_txtstrandcaseid').val(lstEdithis[i].AttributeValueName);
                    }

                  

                    if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkmoreinfo').prop('checked', true);
                        }
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                        $('#patientcapturehistory1_ddlethinicity').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkboxnewvalidation').prop('checked', true);
                        }

                    }
                }

                //MST Format
                else if (lstEdithis[i].ActionType == "MST Format") {

                    $('#patientcapturehistory1_lblMstName').text(lstEdithis[i].Description);
                    $('#patientcapturehistory1_MSTPatientHisory').show();
                    $('.ui-dialog-buttonpane').find('button:first').css('display', 'none');
                    $('.ui-dialog-buttonpane').find('button:nth-child(2)').css('display', 'inline-block');
                    $('#patientcapturehistory1_lnkEditMstcapturePatient').show();

                    if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                        $('#patientcapturehistory1_txtMSTDescription').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                        $('#patientcapturehistory1_ddlMstAssinee').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Indications") {

                        $('#patientcapturehistory1_ddlMSTIndicaions').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                        $('#patientcapturehistory1_txtMSTFamilyHistory').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Gene Name") {

                        $('#patientcapturehistory1_ddlMSTGeneName').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Mutation Descriptions") {

                        $('#patientcapturehistory1_txtMSTMutation').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                        $('#patientcapturehistory1_txtMSTOptionalDescription').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Related Requests") {

                        $('#patientcapturehistory1_txtMSTRelatedRequest').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {

                        $('#patientcapturehistory1_txtMSTKeyFinding').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Germline Panel Type") {

                        $('#patientcapturehistory1_ddlMSTGermlinePanel').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkMSTMoreInformation').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                        $('#patientcapturehistory1_ddlMSTEthncity').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkNewPanelValidation').prop('checked', true);
                        }

                    }
                }

                //Somatic Format
                else if (lstEdithis[i].ActionType == "Somatic Format") {

                    $('#patientcapturehistory1_lblSomaticTestname').text(lstEdithis[i].Description);
                    $('#patientcapturehistory1_PanelSomaticpatientHistiry').show();
                    $('.ui-dialog-buttonpane').find('button:first').css('display', 'none');
                    $('.ui-dialog-buttonpane').find('button:nth-child(2)').css('display', 'inline-block');
                    $('#patientcapturehistory1_lnkEditSomatichistory').show();

                    if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                        $('#patientcapturehistory1_txtSomaticdesc').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                        $('#patientcapturehistory1_ddlSomaticAssinee').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                        $('#patientcapturehistory1_txtSomaticTumour').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {

                        $('#patientcapturehistory1_txtSomaticTumar').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {

                        $('#patientcapturehistory1_txtSoamaticPathology').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {

                        $('#patientcapturehistory1_txtSomaticTheraphy').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {

                        $('#patientcapturehistory1_txtSomaticAddtstDone').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                        $('#patientcapturehistory1_txtSomaticFamilysty').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {

                        $('#patientcapturehistory1_txtSomaticKey').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {

                        $('#patientcapturehistory1_txtSomaticRelevant').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {

                        $('#patientcapturehistory1_txtSomaicStandCase').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkSomaticMoreInformation').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                        $('#patientcapturehistory1_ddlSomaticEthnicity').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkSomaticPanelValidation').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {

                        $('#patientcapturehistory1_ddlSomaticGeneResult').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "KRAS") {

                        $('#patientcapturehistory1_txtSomaticKRAS').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "PIKSCA") {

                        $('#patientcapturehistory1_txtSomaticPIKSCA').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "NRAS") {

                        $('#patientcapturehistory1_txtSomaticNRAS').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "BRAF") {

                        $('#patientcapturehistory1_txtSomaticBRAF').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "AKTI-KIT-EGFR-PGDFRA") {

                        $('#patientcapturehistory1_txtSomaticAkit').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                        $('#patientcapturehistory1_txtSomaticOptional').val(lstEdithis[i].AttributeValueName);
                    }
                }

                //TSP Breast Format
                else if (lstEdithis[i].ActionType == 'TSP Breast Format') {

                    $('#patientcapturehistory1_lblTSPTestName').text(lstEdithis[i].Description);
                    $('#patientcapturehistory1_PanelTSPBreastFormat').show();
                    $('.ui-dialog-buttonpane').find('button:nth-child(1)').css('display', 'none');
                    $('.ui-dialog-buttonpane').find('button:nth-child(2)').css('display', 'inline-block');
                    $('#patientcapturehistory1_lnkEditBreastHistory').show();

                    if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                        $('#patientcapturehistory1_txtTSPDescription').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                        $('#patientcapturehistory1_ddlTSPAssinee').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                        $('#patientcapturehistory1_txtTSPTumar').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {

                        $('#patientcapturehistory1_txtTSPBurden').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {

                        $('#patientcapturehistory1_txtTSPPathology').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {

                        $('#patientcapturehistory1_txtTSPTheraphy').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {

                        $('#patientcapturehistory1_txtTSPAdd').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                        $('#patientcapturehistory1_txtTSPOptional').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                        $('#patientcapturehistory1_txtTSPFamily').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {

                        $('#patientcapturehistory1_txtTSPKeyFind').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {

                        $('#patientcapturehistory1_txtTSPRelated').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {

                        $('#patientcapturehistory1_txtTSPStand').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkTSPInformation').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                        $('#patientcapturehistory1_ddlTSPEthnicity').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkTSPPanelValid').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {

                        $('#patientcapturehistory1_ddlTSPGene').val(lstEdithis[i].AttributeValueName);
                    }
                }
                //TSP Colon Format
                else if (lstEdithis[i].ActionType == "TSP Colon Format") {

                    $('#patientcapturehistory1_lblColon').text(lstEdithis[i].Description);
                    $('#patientcapturehistory1_PanelTSPColon').show();
                    $('.ui-dialog-buttonpane').find('button:first').css('display', 'none');
                    $('.ui-dialog-buttonpane').find('button:nth-child(2)').css('display', 'inline-block');
                    $('#patientcapturehistory1_lnkEditTSPColon').show();

                    if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                        $('#patientcapturehistory1_txtColonDesc').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                        $('#patientcapturehistory1_ddlColonAssinee').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                        $('#patientcapturehistory1_txtColonTumor').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {

                        $('#patientcapturehistory1_txtColonBurden').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {

                        $('#patientcapturehistory1_txtColonPathology').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {

                        $('#patientcapturehistory1_txtColonTherapy').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {

                        $('#patientcapturehistory1_txtColonAddtest').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                        $('#patientcapturehistory1_txtColonOptional').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                        $('#patientcapturehistory1_txtColonFamily').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {

                        $('#patientcapturehistory1_txtColonKeyFinding').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {

                        $('#patientcapturehistory1_txtColonRelated').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {

                        $('#patientcapturehistory1_txtColonStrend').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkColonMoreInfo').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                        $('#patientcapturehistory1_ddlcolonethnicity').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chkColonPanelValid').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {

                        $('#patientcapturehistory1_ddlColonGene').val(lstEdithis[i].AttributeValueName);
                    }
                }
                //TST lung Format
                else if (lstEdithis[i].ActionType == "TST lung Format") {

                    $('#patientcapturehistory1_lblTSPlungTestname').text(lstEdithis[i].Description);
                    $('#patientcapturehistory1_PanelTSPLung').show();
                    $('.ui-dialog-buttonpane').find('button:first').css('display', 'none');
                    $('.ui-dialog-buttonpane').find('button:nth-child(2)').css('display', 'inline-block');
                    $('#patientcapturehistory1_lnkEditTSPLung').show();

                    if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                        $('#patientcapturehistory1_txtlungdesc').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                        $('#patientcapturehistory1_ddlTSPlung').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                        $('#patientcapturehistory1_txtlungtumour').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {

                        $('#patientcapturehistory1_txtlungburden').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {

                        $('#patientcapturehistory1_txtlungpatho').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {

                        $('#patientcapturehistory1_txtlungtherapy').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {

                        $('#patientcapturehistory1_txtlungadd').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                        $('#patientcapturehistory1_txtlungoptional').val(lstEdithis[i].AttributeValueName);
                    }

                    if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                        $('#patientcapturehistory1_txtlungfamily').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {

                        $('#patientcapturehistory1_txtlungkey').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {

                        $('#patientcapturehistory1_txtlungreq').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {

                        $('#patientcapturehistory1_txtlungstrend').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chklunginfo').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                        $('#patientcapturehistory1_ddllungethn').val(lstEdithis[i].AttributeValueName);
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                        if (lstEdithis[i].AttributeValueName == "True") {
                            $('#patientcapturehistory1_chklungpanel').prop('checked', true);
                        }
                    }
                    if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {

                        $('#patientcapturehistory1_ddllunggene').val(lstEdithis[i].AttributeValueName);
                    }
                }
            }
        }


        //-----------------Update Patient History-----------------//


        function UpdatePatientHistory() {

            try {
                debugger;

                var lstResultValues = [];
                //-----------------------------Germline Format-----------------------//
                //              var  lsthdnloadhistory = $.parseJSON('[' + $('#hdnloadhistory').val() + ']');

                //                for (var i = 0; i < lsthdnloadhistory[0].length; i++) {
                for (var i = 0; i < lstEdithis.length; i++) {
                    if (lstEdithis[i].ActionType == 'Germline Format') {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtdescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Indications") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlindications option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtfamilyhistory').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Referal For") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlreferral option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtkeyfinding').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });

                        }


                        if ($.trim(lstEdithis[i].HistoryName) == "Germline Panel Type") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlpaneltype option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });

                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Is Affected with cancer") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlcancer option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });


                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txttype").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            }); 
                            
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({

                            AttributeValueName: $("#patientcapturehistory1_txtOptionalDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            }); 
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {

                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtstrandcaseid').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });

                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {

                            lstResultValues.push({
                            AttributeValueName: $("#patientcapturehistory1_chkmoreinfo").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlethinicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_chkboxnewvalidation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                    }


                    //------------------------MST Format----------------------------------------//
                    else if (lstEdithis[i].ActionType == 'MST Format') {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtMSTDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlMstAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Indications") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlMSTIndicaions option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtMSTFamilyHistory").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Gene Name") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlMSTGeneName option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Mutation Descriptions") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtMSTMutation").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtMSTOptionalDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Related Requests") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtMSTRelatedRequest").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtMSTKeyFinding").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Germline Panel Type") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlMSTGermlinePanel option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkMSTMoreInformation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlMSTEthncity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkNewPanelValidation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });
                        }
                    }
                    //------------------------Somatic Format---------------------------------------//
                    else if (lstEdithis[i].ActionType == 'Somatic Format') {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticdesc").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });

                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_ddlSomaticAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticTumour").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });

                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticTumar").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSoamaticPathology").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticTheraphy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {

                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticAddtstDone").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {

                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticFamilysty").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaticKey").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticRelevant").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({

                                AttributeValueName: $("#patientcapturehistory1_txtSomaicStandCase").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkSomaticMoreInformation ").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlSomaticEthnicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkSomaticPanelValidation ").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlSomaticGeneResult option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });

                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "KRAS") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticKRAS").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "PIKSCA") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticPIKSCA").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "NRAS") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticNRAS").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "BRAF") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticBRAF").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "AKTI-KIT-EGFR-PGDFRA") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticAkit").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtSomaticOptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                    }


                    //-------------------------TSP Breast Format  --------------------------//
                    else if (lstEdithis[i].ActionType == "TSP Breast Format") {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPDescription").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {

                            lstResultValues.push({
                            AttributeValueName: $("#patientcapturehistory1_txtTSPTumar").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPBurden").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPPathology").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPTheraphy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPAdd").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPOptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPFamily").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPKeyFind").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPRelated").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtTSPStand").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkTSPInformation").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPEthnicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkTSPPanelValid ").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPGene option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                    }
                    //--------------------TSP Colon Format---------------------------------------//
                    else if (lstEdithis[i].ActionType == "TSP Colon Format") {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonDesc").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlColonAssinee option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonTumor").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonBurden").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonPathology").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonTherapy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonAddtest").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonOptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }


                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonFamily").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonKeyFinding").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonRelated").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtColonStrend").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkColonMoreInfo").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlcolonethnicity option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chkColonPanelValid").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlColonGene option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                    }
                    //----------------------TST lung Format-----------------------------------------------------//
                    else if (lstEdithis[i].ActionType == "TST lung Format") {

                        if ($.trim(lstEdithis[i].HistoryName) == "Description") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungdesc").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Assignee") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddlTSPlung option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Type(If Selected)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungtumour").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Tumar Burden(Tumar %)") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungburden").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Pathology") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungpatho").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID

                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Therapy Information") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungtherapy").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Additional Test Done") {
                            lstResultValues.push({
                                AttributeValueName: $('#patientcapturehistory1_txtlungadd').val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "Optional Descriptions") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungoptional").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Family History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungfamily").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Key Finding") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungkey").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Relavent Clinical History") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungreq").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Strend Case ID") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_txtlungstrend").val(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }

                        if ($.trim(lstEdithis[i].HistoryName) == "More Information Requested") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chklunginfo").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Ethnicity") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddllungethn option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "UsedForNewPanelValidation") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_chklungpanel").is(':checked'),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                        if ($.trim(lstEdithis[i].HistoryName) == "Single Gene Result") {
                            lstResultValues.push({
                                AttributeValueName: $("#patientcapturehistory1_ddllunggene option:selected").text(),
                                HistoryID: lstEdithis[i].HistoryID,
                                PatientHistoryAttributeID: lstEdithis[i].PatientHistoryAttributeID,
                                ActionType: "Update",
                                PatientVisitID: lstEdithis[i].PatientVisitID,
                                InvestigationID: lstEdithis[i].InvID
                            });
                        }
                    }
                }

                var ss = JSON.stringify(lstResultValues);
                var AjaxContent = "{'lstUpdateHistory':'" + ss + "'}";
                //return false;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/UpdatePatientHistoryService",
                    contentType: "application/json; charset=utf-8",
                    data: AjaxContent,
                    dataType: "json",
                    success: function(data) {
                        alert("Updated Successfully");
                        $('#patientcapturehistory1_tblCapturePatientHistory').hide();
                        return false;
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error in Webservice Calling");

                        $('#patientcapturehistory1_tblCapturePatientHistory').hide();

                        return false;
                    }
                });
                return false;
            }

            catch (e) {
                alert("Unable to Save");
                return false;
            }
        }
        
    
    </script>
 <script type="text/javascript">

     function Validategender() {
         if (document.getElementById('chkIncomplete').checked == true) {
             document.getElementById('ddlSex').value = "0";
            
             //document.getElementById("ddlSex").value = 'U'
             $('#ddlDOBDWMY').val('UnKnown');
           $('#ddlSex').val('U');
             document.getElementById('tDOB').value = ''
             document.getElementById('tDOB').placeholder = "dd//mm//yyyy";
             document.getElementById('txtDOBNos').value = '';
             $('.InCom').hide();
             

            }
            else {
                document.getElementById('hdnIncompleteAge').value = 'N';
                $('.InCom').show();
                document.getElementById('tDOB').value = ''
                document.getElementById('tDOB').placeholder = "dd//mm//yyyy";
                $('#ddlDOBDWMY').val('Year(s)');
                $('#ddlSex').val('M');
                document.getElementById('txtDOBNos').value = '';
                //                document.getElementById('ImageDOB').style.display = 'block';
            }
        }
        function changestatus(ID) {
            debugger;
            if (ID == 'ddlDOBDWMY') {
                var e = document.getElementById(ID);
                var strUser = e.options[e.selectedIndex].value;
                if ((strUser == 'UnKnown')) {
                   // document.getElementById('ddlSex').value = "0";

                    document.getElementById("chkIncomplete").checked = true;
                    $('#ddlDOBDWMY').val('UnKnown');
                    //$('#ddlSex').val('U');
                    document.getElementById('tDOB').value = '';
                    document.getElementById('tDOB').placeholder = "dd//mm//yyyy";
                    document.getElementById('txtDOBNos').value = '';
                    $('.InCom').hide();
                }
                else  {
                   if (document.getElementById('chkIncomplete').style.Display == 'block') {
                        $('.InCom').show();
                        document.getElementById('tDOB').value = ''
                        document.getElementById('tDOB').placeholder = "dd//mm//yyyy";
                        //$('#ddlDOBDWMY').val('Year(s)');
                        //$('#ddlSex').val('M');
                        document.getElementById('txtDOBNos').value = '';
                        document.getElementById("chkIncomplete").checked = false;


                    }
                    
                    
                }

            }


        }
    </script>
    </form>
</body>
</html>
