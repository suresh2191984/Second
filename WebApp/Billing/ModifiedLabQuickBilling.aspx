<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModifiedLabQuickBilling.aspx.cs"
    EnableEventValidation="false" Inherits="Billing_ModifiedLabQuickBilling" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/CollectSample.ascx" TagName="CollectSample" TagPrefix="CollectSample" %>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="~/CommonControls/NewDateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="DateTimePicker" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Billing</title>
<%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
--%>
    <script src="../Scripts/CommonBilling_Quantum.js" type="text/javascript"></script>

    <script src="../Scripts/LabQuickBilling_Quantum.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

 <%--  <script src="../Scripts/Loading.js" type="text/javascript"></script>--%>
    
  <%--   <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

<%--    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/CollectSample.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

  <%--  <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>--%>

    <link href="../StyleSheets/dialui.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />


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
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>

                                    </asp:UpdateProgress>--%>
                                <div id="progressBilling" style="display:none;">
                                    <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="Image1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                   </div>
                                </div>
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
                                       <%-- <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                                            style="cursor: pointer;" />--%>
                                        <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server" GroupingText="Patient Details">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <table class="w-100p" id="1">
                                                            <tr>
                                                                <td class="w-7p" runat="server" id="tdSearchType1">
                                                    <asp:Label ID="lblSearchType" runat="server" Text="Search Type" meta:resourcekey="lblSearchTypeResource1"></asp:Label>
                                                                </td>
                                                                <td colspan="6"  runat="server" id="tdSearchType2">
                                                                    <asp:RadioButtonList onclick="javascript:clearPageControlsValue('N');" RepeatDirection="Horizontal"
                                                                        ID="rblSearchType" runat="server" RepeatColumns="5">
                                                                        <%--<asp:ListItem Text="None" Value="4" style="display:none" ></asp:ListItem>--%>
                                                                        <asp:ListItem Text="Name" Value="0" Selected="True"></asp:ListItem>
                                                                        <asp:ListItem Text="Number" Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="Booking Number" Value="3"></asp:ListItem>
                                                                        <%--  <asp:ListItem Text="Mobile/Phone" Value="2"></asp:ListItem>
                                                                        <asp:ListItem Text="Booking Number" Value="3"></asp:ListItem>--%>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            <td class="a-center">
                                                             <img title="Show Previous Data and History" alt="" onclick="ShowPrevious();" src="../Images/collapse_blue.jpg"
                                                                        id="ShowPreviousData" style="cursor: pointer; display: none;" />
                                                            </td>
                                                                <td class="a-left" id="tdVisitType1" runat="server" style="display: none;">
                                                    <asp:Label ID="Rs_SelectVisit" runat="server" Text="Visit Type:" meta:resourcekey="Rs_SelectVisitResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left" id="tdVisitType2" runat="server" style="display: none;">
                                                                    <asp:DropDownList Width="95px" CssClass="bilddltb" onfocus="javascript:CheckPatientName();"
                                                                        ID="ddlVisitDetails" runat="server" onchange="ChangeVisit()">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                              <tr id="trExternalVisitID" runat="server" colspan="2">                                                                       
                                                                <td>
                                                    <asp:Label ID="lblExtVisitId" runat="server" Text="Lab Number" meta:resourcekey="lblExtVisitIdResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtExternalVisitID" runat="server" onblur="javascript:SelectedExtVisitID();fillTextbox();"
                                                                        MaxLength="9" CssClass="Txtboxsmall" onchange="CheckSMS();clearPageControlsValue('N');" 
                                                          OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" meta:resourcekey="txtExternalVisitIDResource1"></asp:TextBox>
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>                                                                
                                                            </tr>
                                                            <tr>
                                                                <td class="w-28p" colspan="2">
                                                                    <table>
                                                                        <tr>
                                                                            <td class="w-12p a-left">
                                                                                <asp:Label ID="lblName" runat="server" Text="<u>N</u>ame" AssociatedControlID="txtName"
                                                                    AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="w-20p a-left paddingL8">
                                                                                <asp:DropDownList CssClass="ddl" ID="ddSalutation" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="a-left" nowrap="nowrap">
                                                                                <asp:TextBox ID="txtName" onfocus="javascript:setPatientSearch();" onKeyDown="javascript:clearPageControlsValue('Y');"
                                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                                    autocomplete="off" runat="server" CssClass="Txtboxsmall"  meta:resourcekey="txtNameResource1">
                                                                                </asp:TextBox>
                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                                                    ServiceMethod="GetLabQuickBillPatientList_Quantum" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
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
                                                                <td class="w-5p a-left">
                                                                    <asp:Label ID="lblSex" runat="server" Text="Se<u>x</u>" AssociatedControlID="ddlSex"
                                                        AccessKey="X" meta:resourcekey="lblSexResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-19p a-left paddingL5">
                                                                    <asp:DropDownList ID="ddlSex" runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    <asp:Label ID="lblDOB" runat="server" Text="DO<u>B</u>" AssociatedControlID="tDOB"
                                                        AccessKey="B" meta:resourcekey="lblDOBResource1"></asp:Label>
                                                                    <%--<asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status"></asp:Label>
                                                                    <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" runat="server">
                                                                    </asp:DropDownList>--%>
                                                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                                    <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                                                        onblur="javascript:countQuickAge(this.id);" onchange="FutureDateValidation();"
																		 Width="87px" Style="text-align: justify"
                                                                        ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
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
                                                                <td class="w-9p a-left" id="tdSex1" runat="server">
                                                    <asp:Label ID="lblAge" runat="server" Text="Age" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-14p a-left" id="tdSex2" runat="server">
                                                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();setDDlDOBYear('ddlDOBDWMY',false);"
                                                                        onchange="setDOBYear(this.id,'LB');"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                        CssClass="Txtboxsmall w-18p" runat="server" MaxLength="3" Style="text-align: justify"
                                                                        meta:resourceKey="txtDOBNosResource1" />
                                                                    <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id,true);" ID="ddlDOBDWMY"
                                                                        runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                                        BehaviorID="txtwtrDob" Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked"
                                                                        WatermarkText="dd/MM/yyyy">
                                                                    </ajc:TextBoxWatermarkExtender>
                                                                </td>
                                                                <td id="trApprovalNo" runat="server" colspan="2">
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="a-left w-29p">
                                                                <asp:Label ID="lblApprovalNo" runat="server" Text="Approval No" meta:resourcekey="lblApprovalNoResource1"></asp:Label>
                                                                            </td>
                                                                            <td class="paddingL9">
                                                                                <asp:TextBox ID="txtApprovalNo" runat="server" AutoCompleteType="Disabled" MaxLength="13"
                                                                    CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" meta:resourcekey="txtApprovalNoResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td id="tdlblMarital" runat="server">
                                                    <asp:Label ID="lblMarital" runat="server" Text="Marital Status" meta:resourcekey="lblMaritalResource1"></asp:Label>
                                                                </td>
                                                                <td id="tdddMarital" runat="server">
                                                                    <asp:DropDownList CssClass="ddlsmall" ID="ddMarital" runat="server">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr id="tdContact" runat="server">
                                                                <td>
                                                                    <asp:Label ID="lblMobile" runat="server" Text="<u>M</u>obile +91" AssociatedControlID="txtMobileNumber"
                                                        AccessKey="M" meta:resourcekey="lblMobileResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left v-middle">
                                                    <asp:Label ID="lblCountryCode" runat="server" class="w-10p" Style="display: none"
                                                        meta:resourcekey="lblCountryCodeResource1"></asp:Label>
                                                                    <asp:TextBox ID="txtMobileNumber" Width="90%" autocomplete="off" onchange="CheckSMS();"
                                                                             onkeypress="return ValidateOnlyNumeric(this);"    runat="server"
                                                        MaxLength="13" CssClass="Txtboxsmall" meta:resourcekey="txtMobileNumberResource1"></asp:TextBox>
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" id="img1" runat="server" />
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" id="img2" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLandLine" runat="server" Text="<u>T</u>elephone" AssociatedControlID="txtPhone"
                                                        AccessKey="T" meta:resourcekey="lblLandLineResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPhone" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="15" CssClass="Txtboxsmall" meta:resourcekey="txtPhoneResource1"></asp:TextBox>
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" id="img3" runat="server" />
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" id="img4" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblEmail" Text="<u>E</u>-mail" runat="server" AssociatedControlID="txtEmail"
                                                        AccessKey="E" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtEmail" autocomplete="off" runat="server" onchange="CheckEmail();"
                                                        CssClass="Txtboxsmall" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                                        id="imageEmail" runat="server" />
                                                                    <%-- <asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                                        ControlToValidate="txtEmail" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                                        ValidationGroup="register" meta:resourceKey="regValidatorResource1">Email 
                                                            not valid</asp:RegularExpressionValidator>--%>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:Label ID="lblAddress" Text="<u>A</u>ddress" runat="server" AssociatedControlID="txtAddress"
                                                        AccessKey="A" meta:resourcekey="lblAddressResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAddress" autocomplete="off" runat="server" CssClass="Txtboxsmall"  meta:resourcekey="txtAddressResource1">
                                                                    </asp:TextBox>&nbsp;<img src="../Images/starbutton.png" alt="" align="middle"
                                                                            style="display: none;" id="imageAddress" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                    <asp:Label ID="lblPatientStatus" runat="server" Text="Patient Status:" meta:resourcekey="lblPatientStatusResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlPatientStatus" runat="server" CssClass="ddlsmall">
                                                                    </asp:DropDownList>
                                                                    <asp:Label ID="lblSuburban" runat="server" Text="Suburb" AssociatedControlID="txtSuburban"
                                                        AccessKey="B" meta:resourcekey="lblSuburbanResource1"></asp:Label>
                                                                    <asp:TextBox CssClass="Txtboxsmall" Width="91%" autocomplete="off" ID="txtSuburban"
                                                        runat="server" MaxLength="25" meta:resourcekey="txtSuburbanResource1"></asp:TextBox>
                                                                    <asp:Label ID="Rs_City" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                                        AccessKey="Y" meta:resourcekey="Rs_CityResource1"></asp:Label>
                                                                    <asp:TextBox CssClass="Txtboxsmall" Width="90%" autocomplete="off" ID="txtCity" runat="server"
                                                        MaxLength="25" meta:resourcekey="txtCityResource1"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                                        id="imageCity" runat="server" />
                                                                </td>
                                                                <td>
                                                    <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" meta:resourcekey="Rs_URNTypeResource1" />
                                                                </td>
                                                                <td class="paddingL5">
                                                                    <asp:DropDownList ID="ddlUrnType" runat="server" onblur="CheckExistingURN1();"
                                                                        onChange="javascript:return CheckMRD();" CssClass="ddlsmall">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                    <asp:Label ID="Rs_URN" Text="URN No" Width="135%" runat="server" meta:resourcekey="Rs_URNResource1" />
                                                                </td>
                                                                <td>
                                                                    <input type="hidden" id="hdnUrn" runat="server" value="0" />
                                                                    <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                                        onKeyDown="javascript:ClearDiscountLimitValues();" MaxLength="50"
                                                                        onblur="CheckExistingURN1();NricCheck(); " meta:resourcekey="txtURNoResource1"></asp:TextBox>
                                                                </td>
                                                                <td id="td2" nowrap="nowrap" class="w-7p">
                                                    <asp:Label ID="Label1" runat="server" Text="Ex Patient Number" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                </td>
                                                                <td id="td55">
                                                                    <asp:TextBox ID="txtExternalPatientNumber" autocomplete="off" CssClass="Txtboxsmall"
                                                        runat="server" meta:resourcekey="txtExternalPatientNumberResource1"></asp:TextBox>
                                                                </td>
                                                                <td id="tdlblUrnoOf" runat="server">
                                                    <asp:Label ID="Rs_URNOf" runat="server" Text="URN Of" meta:resourcekey="Rs_URNOfResource1"></asp:Label>
                                                                </td>
                                                                <td id="tdUrnoOf" runat="server">
                                                                    <asp:DropDownList ID="ddlUrnoOf" Width="91%" runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
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
                                                            <tr id="trPatientPriorityPart" runat="server">
                                                                <td>
                                                                    <asp:Label ID="lblCodeclientMap" runat="server" Text="Code"></asp:Label>
                                                                </td>
                                                                <td>
                                                    <asp:TextBox ID="TxtClientCodeMap" runat="server" CssClass="AutoCompletesearchBox"
                                                        meta:resourcekey="TxtClientCodeMapResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender10" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="3" ServiceMethod="GetClientRefPhyHosforCode"
                                                                        ServicePath="~/OPIPBilling.asmx" TargetControlID="TxtClientCodeMap" OnClientItemSelected="SelecetedCode">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td id="tdClientPart" runat="server" colspan="2">
                                                                    <asp:Label ID="Rs_ClientName" runat="server" AccessKey="C" AssociatedControlID="txtClient"
                                                        Text="&lt;u&gt;C&lt;/u&gt;lient Name" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                                    <asp:TextBox ID="txtClient" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox"
                                                                        onblur="ClearRate();" onfocus="CheckOrderedItems();" onKeyDown="return ValidateClientID(event);"
                                                                        onKeyUp="return ValidateClientAddress(this.id);" 
                                                                        ontextchanged="txtClient_TextChanged1"  meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="3" OnClientItemOver="SelectedTempClient"
                                                                        OnClientItemSelected="ClientSelected" ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx"
                                                                        TargetControlID="txtClient">
                                                                    </ajc:AutoCompleteExtender>
                                                                     <img src="../Images/starbutton.png" alt="" align="middle" id="img7" />
                                                                     <div id="DivClientAddress" style="display: none; position: absolute; width: 70px;
                                                                        left: 50%; top: 40%">
                                                                        <table class="w-50 modalPopup">
                                                                            <tr>
                                                                                <td id="Td1" style="cursor: move; cursor: pointer" class="w-50" onmousedown="initializedrag(event)">
                                                                    <asp:Label ID="lblClientAddress" runat="server" meta:resourcekey="lblClientAddressResource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                                <td id="tdRefDrPart" runat="server">
                                                                    <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                                        Text="Ref Dr." meta:resourcekey="lblRefbyResource1"></asp:Label>
                                                                </td>
                                                                <td id="tdRefDrParttxt" runat="server">
                                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox"
                                                                        onFocus="return getrefhospid(this.id)"  onBlur="CheckRefPhysician();" onKeyDown="javascript:ClearDiscountLimitValues();checkKey(event)"
                                                        meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                                        OnClientShown="DocPopulated" FirstRowSelected="false" MinimumPrefixLength="2"
                                                                        OnClientItemSelected="PhysicianSelected" ServiceMethod="GetRateCardForBilling"
                                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected" TargetControlID="txtInternalExternalPhysician">
                                                                    </ajc:AutoCompleteExtender>
                                                                   
                                                                    <img src="..\Images\expand.jpg" alt="" class="pointer v-bottom"
                                                                        id="ImgRefDr" onclick="javascript:minimumPrefixLength();" />
                                                                </td>
                                                                <td id="tdRefHosPart" runat="server">
                                                                    <asp:Label ID="lblReferingHospital" runat="server" AccessKey="H" AssociatedControlID="txtReferringHospital"
                                                        Text="Ref &lt;u&gt;H&lt;/u&gt;os" meta:resourcekey="lblReferingHospitalResource1"></asp:Label>
                                                                </td>
                                                                <td id="tdRefHosParttxt" runat="server">
                                                                    <asp:TextBox ID="txtReferringHospital" autocomplete="off" runat="server" CssClass="AutoCompletesearchBox"
                                                        onFocus="return getrefphysicianid(this.id)" meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                                        CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="3" OnClientItemSelected="GetReferingHospID"
                                                                        ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemOver="GetTempReferingHospID"
                                                                        TargetControlID="txtReferringHospital">
                                                                    </ajc:AutoCompleteExtender>
                                                                    <asp:HiddenField ID="hdnReferralType" runat="server" Value="0" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPriority" runat="server" Text="Priority" Visible="false"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlPriority" runat="server" CssClass="ddl w-10p" Visible="false">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr id="trUrnType" runat="server">
                                                                <td>
                                                                    <asp:Label ID="lblPinCode" runat="server" Text="<u>P</u>inCode" AssociatedControlID="txtPincode"
                                                        AccessKey="P" meta:resourcekey="lblPinCodeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPincode"       onkeypress="return ValidateOnlyNumeric(this);"   
                                                        MaxLength="8" runat="server" autocomplete="off" CssClass="Txtboxsmall" meta:resourcekey="txtPincodeResource1"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                                        id="imagePincode" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCountry" runat="server" Text="<u>C</u>ountry" AssociatedControlID="ddCountry"
                                                        AccessKey="C" meta:resourcekey="lblCountryResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddCountry" Width="90%" onchange="javascript:loadState();" runat="server"
                                                                        CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" id="img5" runat="server" />
                                                                </td>
                                                                <td align="left" nowrap="nowrap">
                                                                    <asp:Label ID="Rs_State" runat="server" Text="<u>S</u>tate" AssociatedControlID="ddState"
                                                        AccessKey="S" meta:resourcekey="Rs_StateResource1"></asp:Label>
                                                                </td>
                                                                <td style="display: table-cell;" nowrap="nowrap">
                                                                    <select id="ddState" runat="server" class="ddl" onchange="javascript:onchangeState();"
                                                                        style="width: 245px">
                                                                    </select>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" id="img6" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLocation" runat="server" Text="OnBehalf Of Location" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLocClient" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                                                        onblur="Location();" Width="91%" meta:resourcekey="txtLocClientResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="3" OnClientItemSelected="OnCollectioncenterselectedClient"
                                                                        ServiceMethod="GetCollectionCenterClientNames" ServicePath="~/WebService.asmx"
                                                                        TargetControlID="txtLocClient">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td style="display: none">
                                                    <asp:Label ID="lblPatientType" runat="server" Text="Patient Type" meta:resourcekey="lblPatientTypeResource1"></asp:Label>
                                                                </td>
                                                                <td style="display: none">
                                                                    <asp:DropDownList ID="ddlPatientType" Width="93%" runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr id="trVisitTypePart" runat="server" style="display: none;">
                                                                <td>
                                                                    <asp:Label ID="lblPatient" runat="server" Text="Vis<u>i</u>t Type" AssociatedControlID="ddlIsExternalPatient"
                                                        AccessKey="I" meta:resourcekey="lblPatientResource1"></asp:Label>
                                                                </td>
                                                                <td id="tdlblWardNo" style="display: table-cell;">
                                                                    <asp:DropDownList CssClass="ddl w-92p" onchange="javascript:SelectVisitType();"
                                                                        ID="ddlIsExternalPatient" runat="server">
                                                                        <asp:ListItem Text="OP" Value="0" Selected="True"></asp:ListItem>
                                                                        <asp:ListItem Text="IP" Value="1"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblWardno" runat="server" Text="<u>W</u>ard No" AssociatedControlID="txtWardNo"
                                                        AccessKey="W" meta:resourcekey="lblWardnoResource1"></asp:Label>
                                                                </td>
                                                                <td id="tdtxtWardNo" style="display: table-cell;">
                                                    <asp:TextBox ID="txtWardNo" CssClass="Txtboxsmall w-90p" runat="server" meta:resourcekey="txtWardNoResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr id="trSampleTRFPart" runat="server" style="display: none;">
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblSampleDate" runat="server" AccessKey="K" AssociatedControlID="txtSampleDate"
                                                        Text="Sample Pic&lt;u&gt;k&lt;/u&gt;up" meta:resourcekey="lblSampleDateResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtSampleDate" runat="server" CssClass="Txtboxsmall" onblur="AdditionalDetails();"
                                                        Width="50%" meta:resourcekey="txtSampleDateResource1"></asp:TextBox>
                                                                    <a href="javascript:NewCssCal('txtSampleDate','ddmmyyyy','arrow',true,12);document.getElementById('txtSampleDate').focus();">
                                                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                                                    <%--  <img id="img1" alt="Pick a date" border="0" height="16" onclick="datePick('txtSampleDate');document.getElementById('txtSampleDate').focus();"
                                                                        src="../Images/Calendar_scheduleHS.png" style="cursor: hand;" width="16" />--%>
                                                    <asp:TextBox ID="txtcurrendate" runat="server" CssClass="Txtboxsmall w-50p" Style="display: none;"
                                                        meta:resourcekey="txtcurrendateResource1"></asp:TextBox>
                                                                    &nbsp;
                                                                    <asp:CheckBox ID="chkSamplePickup" onclick="AdditionalDetails();" runat="server"
                                                                        Text="Collected?" />
                                                                </td>
                                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPhlebo0" runat="server" Text="Phlebotomist Name" meta:resourcekey="lblPhlebo0Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                    <asp:TextBox ID="txtPhleboName" runat="server" CssClass="AutoCompletesearchBox w-82p"
                                                        meta:resourcekey="txtPhleboNameResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPhlebo" runat="server" BehaviorID="AutoCompleteExLstGrp55"
                                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                        Enabled="True" MinimumPrefixLength="3" OnClientItemSelected="Selectedphlebotomist"
                                                                        ServiceMethod="FetchphlebotomistName" ServicePath="~/WebService.asmx" TargetControlID="txtPhleboName">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLogistics" runat="server" Text="Logistics Name"></asp:Label>
                                                                </td>
                                                                <td>
                                                    <asp:TextBox ID="txtLogistics" runat="server" CssClass="AutoCompletesearchBox w-78p"
                                                        meta:resourcekey="txtLogisticsResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderLogi" runat="server" BehaviorID="AutoCompleteExLstGrp48"
                                                                        CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                        Enabled="True" MinimumPrefixLength="3" OnClientItemSelected="SelectedLogistics"
                                                                        ServiceMethod="FetchLogisticsName" ServicePath="~/WebService.asmx" TargetControlID="txtLogistics">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td>
                                                    <asp:Label ID="lblRoundNo" runat="server" Text="Round No" meta:resourcekey="lblRoundNoResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                    <asp:TextBox ID="txtRoundNo" runat="server" autocomplete="off" CssClass="Txtboxsmall w-90p"
                                                        meta:resourcekey="txtRoundNoResource1"></asp:TextBox>
                                                                </td>
                                                                <td id="trPatientDetails" style="display: none;">
                                                                    <div id="showimage" style="display: none; position: absolute; width: 440px; left: 64%;
                                                                        top: 3%">
                                                                        <div onclick="hidebox();return false" class="divCloseRight">
                                                                        </div>
                                                                        <table width="453px" class="modalPopup dataheaderPopup">
                                                                            <tr>
                                                                                <td id="dragbar" style="cursor: move; cursor: pointer" class="w-100p" onmousedown="initializedrag(event)">
                                                                    <asp:Label ID="lblPatientDetails" runat="server" meta:resourcekey="lblPatientDetailsResource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
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
                                                            <tr>
                                                                <td >
                                                    <asp:Label ID="lblCC" runat="server" Text="Email CC" meta:resourcekey="lblCCResource1"></asp:Label>
                                                                </td>
                                                                <td >
                                                    <asp:TextBox ID="txtCC" Columns="17" runat="server" TextMode="MultiLine" meta:resourcekey="txtCCResource1"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                    <asp:Label ID="lblFax" runat="server" Text="FaxNumber" meta:resourcekey="lblFaxResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="FaxNumber" runat="server" TextMode="SingleLine" Width="150px" name="from"
                                                                        onblur="javascript:text_changed();"  meta:resourcekey="FaxNumberResource1"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                               
                                                                    <%-- <input type="checkbox" id="chkDespatchMode" onclick="chkAdditionalDetails();"/>  onclick="return chkAdditionalDetails();"  OnClientClick="chkAdditionalDetails();"--%>
                                                                    <asp:CheckBoxList ID="chkDespatchMode" RepeatDirection="Horizontal" runat="server" Font-Size="10px"
                                                                        Font-Bold="true" AutoPostBack="false" onclick="Validate();" OnSelectedIndexChanged="chkDespatchMode_SelectedIndexChanged"  OnClientClick="chkAdditionalDetails();">
                                                                    </asp:CheckBoxList>
                                                                </td>
                                                            </tr>
                                                            <tr id="tdAdditionalDetails" runat="server">
                                                                <td colspan="2" nowrap="nowrap">
                                                                    <asp:CheckBox ID="chkExcludeAutoathz" runat="server" Text="Exclude Auto Authorization" />
                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                    <input id="ChkTRFImage" runat="server" onclick="ShowTRFUpload(this, this.id);" type="checkbox"
                                                                        value="Upload" />
                                                                    <asp:Label ID="lblTRF" runat="server" AccessKey="U" AssociatedControlID="ChkTRFImage"
                                                        Style="color: #2C88B1; font-size: small;" Text="TRF Image &lt;u&gt;U&lt;/u&gt;pload"
                                                        meta:resourcekey="lblTRFResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <div id="TRFimage" style="display: none;">
                                                                        <asp:FileUpload ID="FileUpload1" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF"
                                                            class="multi" Width="340%" meta:resourcekey="FileUpload1Resource1" />
                                                                    </div>
                                                                </td>
                                                                <td nowrap="nowrap">
                                                                </td>
                                                                <td>
                                                    <asp:Label ID="lblnotification" runat="server" Text="Notification" meta:resourcekey="lblnotificationResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Panel ID="panelnotification" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="true"
                                                        Style="width: 230px;" meta:resourcekey="panelnotificationResource1">
                                                                        <asp:CheckBoxList ID="ChkNotification" RepeatDirection="Horizontal" runat="server"
                                                                            Font-Size="10px" Font-Bold="true">
                                                                        </asp:CheckBoxList>
                                                                        <asp:CheckBox ID="chkMobileNotify" Text="Sms" ToolTip="Send SMS Notification" Font-Bold="true"
                                                                            Font-Size="10px" runat="server" Style="display: none" />
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            
                                                            <tr id="trDispType" runat="server" style="display: none;">
                                                                <td>
                                                    <asp:Label ID="lblDespatchType" runat="server" Text="Dispatch Type" meta:resourcekey="lblDespatchTypeResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Panel ID="panelDispatchType" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="true"
                                                        Width="92%" meta:resourcekey="panelDispatchTypeResource1">
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
                                                                    <asp:Panel ID="panelDispatchMode" runat="server" CssClass="dataheaderInvCtrl" Font-Bold="true"  meta:resourcekey="panelDispatchModeResource1">
                                                                       <%-- <asp:CheckBoxList ID="chkDespatchMode" RepeatDirection="Horizontal" runat="server"
                                                                            Font-Size="10px" Font-Bold="true">
                                                                        </asp:CheckBoxList>--%>
                                                                        <asp:DropDownList ID="ddlDespatchMode" Style="display: none;" Width="86%" CssClass="ddl"
                                                                            runat="server">
                                                                        </asp:DropDownList>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr id="trEditRemarks" runat="server" style="display: none;">
                                                                <td>
                                                    <asp:Label ID="EditlblHistory" runat="server" Text="History " meta:resourcekey="EditlblHistoryResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="EditPatientHistory" CssClass="w-50p" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                                        onFocus="return expandTextBox(this.id)" TextMode="MultiLine"  meta:resourcekey="EditPatientHistoryResource1"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                    <asp:Label ID="EditlblRemarks" runat="server" Text="Remarks" meta:resourcekey="EditlblRemarksResource1"></asp:Label>
                                                                </td>
                                                                <td colspan="5">
                                                                    <asp:TextBox ID="EdittxtRemarks" CssClass="w-50p" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                                        onFocus="return expandTextBox(this.id)" TextMode="MultiLine"  meta:resourcekey="EdittxtRemarksResource1"></asp:TextBox>
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
                                                                    <asp:DropDownList ID="ddlRate" runat="server" Enabled="False" onChange="javascript:setRate(this.value);">
                                                                        <asp:ListItem Selected="True">--Select--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="display: none;">
                                                    <asp:Label ID="Rs_Nationality" runat="server" Text="Nationality" meta:resourcekey="Rs_NationalityResource1"></asp:Label>
                                                                    <asp:DropDownList CssClass="ddl" ID="ddlNationality" runat="server">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div id="ShowBillingItems" style="display: none; position: absolute; width: 35%;
                                                                        left: 61%; top: 1%">
                                                                        <div onclick="Itemhidebox();return false" class="divCloseRight">
                                                                        </div>
                                                                        <table class="w-32p modalPopup dataheaderPopup">
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
                                                                        <table class="w-32p modalPopup dataheaderPopup">
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
                                    <div class="v-top" style="display: none;">
                                        <div id="divBill1" onclick="showResponses('divBill1','divBill2','divBill3',1);" style="cursor: pointer;
                                            display: none;" runat="server">
                                            &nbsp;<img src="../Images/plus.png" alt="Show" />
                                        </div>
                                        <div id="divBill2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divBill1','divBill2','divBill3',0);"
                                            runat="server">
                                            &nbsp;<img src="../Images/minus.png" alt="Show" />
                                        </div>
                                    </div>
                                    <div>
                                        <BillingPart:BPart ID="billPart" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center dataheader3">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-center">
                                                <asp:Button ID="btnGenerate" runat="server" Width="100px" Text="Generate Bill" CssClass="btn"
                                                    OnClientClick="javascript:return validateEvents('After');" OnClick="btnGenerate_Click"
                                                    onmouseout="this.className='btn'" meta:resourcekey="btnGenerateResource1" />
                                                    <input type="button" runat="server" id="btnClose" value="Clear" class="btn" onclick="javascript:clearbuttonClick();" />
                                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" Style="display: none;"
                                                    OnClick="btnBack_Click"   meta:resourcekey="btnBackResource1"/>

                                                <asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn" Style="display: none;"    meta:resourcekey="btnCancelResource1"/>
                                            </td>
                                           
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p" id="trCollectSampledt" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <table class="dataheader2">
                                        <tr>
                                            <td colspan="1">
                                                <asp:Label ID="lblSampleDateTime" runat="server" meta:resourceKey="lblSampleDateTimeResource2"
                                                    Text="Sample Collected Date Time" Font-Bold="true"></asp:Label>
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
                                    <asp:Panel CssClass="dataheaderInvCtrl" runat="server" ID="pnlDept" meta:resourcekey="pnlDeptResource1">
                                        <table id="deptTab" runat="server" class="w-100p">
                                            <tr id="Tr1" class="Duecolor h-20" runat="server">
                                                <td id="Td3" runat="server">
                                    <asp:Label ID="lblDeptheader" runat="server" meta:resourcekey="lblDeptheaderResource1"> <b><%=Resources.Billing_ClientDisplay.Billing_ModifiedLabQuickBilling_aspx_01 %></b> </asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td id="Td58" class="w-100p a-left v-top" runat="server">
                                    <asp:DataList class="w-100p searchPanel" ID="repDepts" runat="server" RepeatColumns="5"
                                        meta:resourcekey="repDeptsResource1">
                                                        <ItemTemplate>
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td class="h-20">
                                                                        <asp:CheckBox ID="chkDept" runat="server" />
                                                        <asp:Label ID="lblDeptName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DeptName") %>'
                                                            meta:resourcekey="lblDeptNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="h-20">
                                                        <asp:Label ID="lblDeptID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DeptID") %>'
                                                            Visible="False" meta:resourcekey="lblDeptIDResource1"></asp:Label>
                                                        <asp:Label ID="lblRoleID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RoleID") %>'
                                                            Visible="False" meta:resourcekey="lblRoleIDResource1"></asp:Label>
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
                        <br /><br />
                    </div>
                   <%-- <div class="loading" align="center">
                        Loading...<br />
                        <br />
                        <img src="../Images/loader.gif" alt="" />
                    </div>--%>
            
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
        <asp:HiddenField ID="hdnLstPatientInvestigation" runat="server" />
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
        <asp:HiddenField ID="hdnDiscountLimitAmt" runat="server" />
        <asp:HiddenField ID="hdnSumDiscountAmt" runat="server" />
        <asp:HiddenField ID="hdnAvailableDiscountAmt" runat="server" />
        <asp:HiddenField ID="hdnDiscountLimitType" runat="server" />
        <asp:HiddenField ID="hdnPriRateType" runat="server" />
         <asp:HiddenField ID="hdnRoleName" runat="server" />
         <asp:HiddenField ID="hdnEditDDlDOB" runat="server" />
		  <asp:HiddenField ID="hdnBookedID" Value="0" runat="server" />
		   <asp:HiddenField ID="hdnEditddMarital" runat="server" />
		   <asp:HiddenField ID ="hdnDecimalAgeConfig" runat="server" />
		   <asp:HiddenField ID="hdnDoFrmVisit" runat="server"/>
		    <input type="hidden" runat="server" id="hdnDateFormatConfig" value="dd/MM/yyyy" />
		 <asp:HiddenField ID="hdnClientName" runat="server" />
		  <asp:HiddenField ID="hdntaskID" runat="server" />
		  <asp:HiddenField ID="hdnCalculateDays"  Value="0" runat="server" />
		  <asp:HiddenField ID="hdnCheckFlag1" runat="server" Value="Y" />
		  		 <asp:HiddenField ID="hdnIsContactNumbermMndatory" runat="server" Value="N" />
		  <asp:HiddenField ID="hdnAllowSplChar" runat="server" Value="N" />
		   <asp:HiddenField ID="hdnEditbillDisable" runat="server" Value="N" />
		   <asp:HiddenField ID="hdnEmergencyStatFee" runat="server" Value="N" />
		   <asp:HiddenField ID="hdnIsClientStat" runat="server" Value="N" />
		   <asp:HiddenField ID="hdnNeedAutoStatFee" runat="server" Value="N" />
		   <asp:HiddenField ID="hdnordereditems" runat="server" />
            <asp:HiddenField ID="hdnqrystrBillNo" runat="server" Value="0" />
            <asp:HiddenField ID="hdnUrnNo" runat="server" Value="0" />
            <asp:HiddenField ID="URNOFTypeID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnHideControls" runat="server" Value="N" />
			 <asp:HiddenField ID="hdnfaxnumber" runat="server" Value="" />
<Attune:Attunefooter ID="Attunefooter" runat="server" /> 

    <script type="text/javascript">

        if (document.getElementById('hdnBillGenerate').value == "Y") {
            document.getElementById('trCollectSample').style.display = "table";
            document.getElementById('trCollectSampledt').style.display = "table";
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
             var sval = "RPH" + "^" + OrgID +"^" + rec;
            $find('AutoCompleteExtenderRefPhy').set_contextKey(sval);           
        }
        function getrefphysicianid(source, eventArgs) {

            var sval = 0;

            var OrgID = document.getElementById('hdnOrgID').value;
            var PhysicianID = document.getElementById('hdnReferedPhyID').value;


            var sval =  OrgID + "~" + PhysicianID;
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
            if (document.getElementById('txtLocClient') != null) {
                var Loc = document.getElementById('txtLocClient').value;

                if (Loc != '') {
                    document.getElementById('billPart_hdnLocName').value = Loc;
                }
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
        var atLeast = 1
        function Validate() {
            var CHK = document.getElementById("<%=chkDespatchMode.ClientID%>");
            var checkbox = CHK.getElementsByTagName("input");
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
                $('#<%=chkDespatchMode.ClientID %>').attr('checked', true);
                document.getElementById('FaxNumber').value = document.getElementById('hdnfaxnumber').value;
            }

            if (atLeast > counter) {
                $('[id$="FaxNumber"]').val("");
                return false;
            }
            else {
                $('#<%=chkDespatchMode.ClientID %>').attr('checked', true);
                document.getElementById('FaxNumber').value = document.getElementById('hdnfaxnumber').value;
                if (document.getElementById("<%=txtClient.ClientID%>").value == "")

                document.getElementById('FaxNumber').value = "";      

           }
            return true;


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
            if (document.getElementById('<%=txtMobileNumber.ClientID%>') != null) {
                document.getElementById('<%=txtMobileNumber.ClientID%>').readOnly = true;
            }
            if (document.getElementById('<%=txtPhone.ClientID%>') != null) {
                document.getElementById('<%=txtPhone.ClientID%>').readOnly = true;
            }
            if (document.getElementById('<%=txtEmail.ClientID%>') != null) {
                document.getElementById('<%=txtEmail.ClientID%>').readOnly = true;
            }
            if (document.getElementById('<%=txtAddress.ClientID%>') != null) {
                document.getElementById('<%=txtAddress.ClientID%>').readOnly = true;
            }
            if (document.getElementById('<%=txtPhone.ClientID%>') != null) {
                document.getElementById('<%=txtPhone.ClientID%>').readOnly = true;
            }
            if (document.getElementById('<%=txtEmail.ClientID%>') != null) {
                document.getElementById('<%=txtEmail.ClientID%>').readOnly = true;
            }

            if (document.getElementById('<%=txtCity.ClientID%>') != null) {
                document.getElementById('<%=txtCity.ClientID%>').readOnly = true;
            }


            if (document.getElementById('<%=txtSuburban.ClientID%>') != null) {
                document.getElementById('<%=txtSuburban.ClientID%>').readOnly = true;
            }
            if (document.getElementById('<%=txtPincode.ClientID%>') != null) {
                document.getElementById('<%=txtPincode.ClientID%>').readOnly = true;
            }

            if (document.getElementById('<%=ddCountry.ClientID%>') != null) {
                document.getElementById('<%=ddCountry.ClientID%>').disabled = true;
            }
            if (document.getElementById('<%=ddState.ClientID%>') != null) {
                document.getElementById('<%=ddState.ClientID%>').disabled = true;
            }
            document.getElementById('<%=ddMarital.ClientID%>').disabled = true;
            document.getElementById('<%=ddlUrnType.ClientID%>').disabled = true;

            document.getElementById('<%=ddlUrnoOf.ClientID%>').disabled = true;
            document.getElementById('<%=txtURNo.ClientID%>').readOnly = true;
            if (document.getElementById('<%=ddlPatientType.ClientID%>') != null) {
                document.getElementById('<%=ddlPatientType.ClientID%>').disabled = true;
            }

            if (document.getElementById('<%=txtLocClient.ClientID%>') != null) {
                document.getElementById('<%=txtLocClient.ClientID%>').readOnly = true;
            }

            document.getElementById('<%=txtReferringHospital.ClientID%>').readOnly = true;

            document.getElementById('<%=txtInternalExternalPhysician.ClientID%>').readOnly = true;

        }
        function makeenable() {
            document.getElementById('<%=ddSalutation.ClientID%>').disabled = false;
            document.getElementById('<%=ddlSex.ClientID%>').disabled = false;


            document.getElementById('<%=ddlDOBDWMY.ClientID%>').disabled = false;
            if (document.getElementById('<%=ddState.ClientID%>') != null) {
                document.getElementById('<%=ddState.ClientID%>').disabled = false;
            }
            if (document.getElementById('<%=ddCountry.ClientID%>') != null) {
                document.getElementById('<%=ddCountry.ClientID%>').disabled = false;
            }
            //document.getElementById('<%=ddState.ClientID%>').disabled = true;
            document.getElementById('<%=ddlUrnType.ClientID%>').disabled = false;
            if (document.getElementById('<%=ddlUrnoOf.ClientID%>') != null) {
                document.getElementById('<%=ddlUrnoOf.ClientID%>').disabled = false;
            }
            if (document.getElementById('<%=ddlPatientType.ClientID%>') != null) {
                document.getElementById('<%=ddlPatientType.ClientID%>').disabled = false;
            }

        }
        function CheckRefPhysician() {

            if (document.getElementById('txtInternalExternalPhysician').value != '') {
                if (document.getElementById('hdnReferedPhyID').value == '0') {
                    alert('Select the Refering Physician From List');
                    document.getElementById('txtInternalExternalPhysician').value = '';
                    document.getElementById('txtInternalExternalPhysician').focus();
                    return false;
                }
            }
            $find('AutoCompleteExtenderRefPhy').set_minimumPrefixLength(3);
        }
        function text_changed() {
            if (document.getElementById("<%= FaxNumber.ClientID %>").value == '')   //If textbox is empty
            {
                //document.getElementById("<%= chkDespatchMode.ClientID %>").checked = false;
                // $("[id*=chkDespatchMode] input:checkbox").prop('checked', false); //The checkbox is checked
                var chkBoxList = document.getElementById("<%= chkDespatchMode.ClientID %>");
                var chkBoxCount = chkBoxList.getElementsByTagName("input");
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                }
            }
            else {
                var chkBoxList = document.getElementById("<%= chkDespatchMode.ClientID %>");
                var chkBoxCount = chkBoxList.getElementsByTagName("input");
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                }
            }
        }
    </script>
<%--    <script src="../Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui.min.1.8.13.js" type="text/javascript"></script>--%>
</body>
</html>
<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        $('INPUT[type="text"]').focus(function() {
            $(this).addClass("focus");
        });
        $('INPUT[type="text"]').blur(function() {
            $(this).removeClass("focus");
        });
        $("#txtExternalVisitID").focus();
        
        $('#btnGenerate').click(function() {
        //ShowProgress();
        $('#progressBilling').attr("style", "display:block;");
        });
    });

        function labQuickBilling() {
            if (document.getElementById('hdnIsReceptionPhlebotomist').value == 'Y') {
                window.location.href("../Billing/ModifiedLabQuickBilling.aspx?IsPopup=Y&RCP=Y");
            }
            else {
                window.location.href("../Billing/ModifiedLabQuickBilling.aspx?IsPopup=Y");
            }
            return false;
        }
        function AddBillingItemsDetailsForEdit(ClientID) {

            var queryStringColl = getQueryStrings();
            var OrgID = document.getElementById('hdnOrgID').value;
            var BillNo = queryStringColl.billNo;
            document.getElementById('hdnqrystrBillNo').value = queryStringColl.billNo;
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

                            /******/
                            var IsNotMapService = 'N';
                            var lstNotMapService = '';
                            arrGotValue = list1[0].ProcedureName;
                            BilledList = arrGotValue.split('#');
                            for (var j = 0; j < BilledList.length - 1; j++) {
                                if (BilledList[j] != '' && BilledList[j].length > 0) {
                                    arrGotValue = '';
                                    arrGotValue = BilledList[j].split('^');
                                    if (arrGotValue[20] == 'N') {
                                        IsNotMapService = 'Y';
                                        lstNotMapService += '\n' + arrGotValue[1].trim();
                                    }
                                }
                            }
//                            if (IsNotMapService == 'Y') {
//                                if (!confirm('The Below Test Services are not Associated With this Client ' + lstNotMapService + '\n Please Contact Admin')) {
//                                    return false;
//                                }
//                                else {
//                                }

//                            }
                            /*****/
                            if (ClientID <= 0) {
                                document.getElementById('txtClient').value = list1[0].RefPhyName;
                                document.getElementById('billPart_hdnNeedAutoCalc').value = 'N';

                            }
                            else {
                                document.getElementById('billPart_hdnNeedAutoCalc').value = 'Y';
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
                                    if (arrGotValue[20] == 'Y') {
                                    ID = arrGotValue[0];
                                        //if (ClientID > 0) {
                                        //                                            if (arrGotValue[21] == 'Y') {
                                        //                                                document.getElementById('billPart_hdnAutoCalcGenBillItemID').value = ID;
                                        //                                                document.getElementById('billPart_hdnActualGenBillItemAmt').value=
                                        //                                            }
                                        // }
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
                                        if (arrGotValue[21] == 'Y') {
                                            document.getElementById('billPart_hdnAutoCalcGenBillItemID').value = ID;
                                            document.getElementById('billPart_hdnActualGenBillItemAmt').value = amount;
                                        }
                                    if (ClientID > 0) {
                                        document.getElementById('hdnSelectedClientClientID').value = ClientID;
                                    }
                                    else {
                                        document.getElementById('hdnSelectedClientClientID').value = arrGotValue[18];
                                    }
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
                        else {

                            document.getElementById('billPart_txtEdtNetAmt').value = 0.00;
                            alert('Services are not Associated With this Client');
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
            if (document.getElementById('txtMobileNumber') != null) {
                if (document.getElementById('txtMobileNumber').value != '') {
                    //                           document.getElementById('chkMobileNotify').checked = true;

                }
                else {
                    document.getElementById('chkMobileNotify').checked = false;
                }
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
    if (elements != null) {
        if (document.getElementById('txtEmail').value != '') {

            elements.cells[0].childNodes[0].checked = true;
        }
        else {
            elements.cells[0].childNodes[0].checked = false;

        }
    }
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
function NricCheck() {
    var txtLength = document.getElementById("txtURNo");
    var obj = document.getElementById('ddlUrnType');
    var length = txtLength.value.length;
    if (length != 0) {
        if (obj.options[obj.selectedIndex].value == 10 && (length < 12 || length > 12)) {
            alert('Invalid,NRIC Number Must Be 12 Digit');
            document.getElementById('txtURNo').focus();
        }
        return false;
    }
}
/***Added For Progress bar***/
$(document).ready(function() {
    $('#btnGenerate').click(function() {
        //ShowProgress();
        $('#progressBilling').attr("style", "display:block;");
    });
});
/***Added For Progress bar***/
    </script>