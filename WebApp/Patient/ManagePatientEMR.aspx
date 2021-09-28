<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagePatientEMR.aspx.cs"
    Inherits="Patient_ManagePatientEMR" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%@ Register Src="~/CommonControls/ComplaintICDCodeBP.ascx" TagName="ComplaintICDCodeBP"
    TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/PatientPreference.ascx" TagName="PatientPreference"
    TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/CollectSample.js" language="javascript" type="text/javascript"></script>

<%--    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

   
    <style type="text/css">
        .style3
        {
            width: 93px;
        }
        .style5
        {
            width: 0%;
            height: 91px;
        }
        .style6
        {
            height: 91px;
        }
          .style1
        {
            width: 180px;
        }
        .style2
        {
            width: 250px;
        }
    </style>

    <script type="text/javascript">
        function showsearch() {
            document.getElementById('tblBkgrondProblems').style.display = 'table';
            document.getElementById('Div5').style.display = 'none';
            document.getElementById('Div6').style.display = 'block';

        }
        function Hidesearch() {
            document.getElementById('tblBkgrondProblems').style.display = 'none';
            document.getElementById('Div5').style.display = 'block';
            document.getElementById('Div6').style.display = 'none';
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="w-100p">
                            <tr class="v-top">
                                <td>
                                    <div class="dataheader3">
                                        <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server" GroupingText="Patient Details">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblSearchType" runat="server" Text="Search Type"></asp:Label>
                                                    </td>
                                                    <td colspan="5">
                                                        <asp:RadioButtonList onclick="javascript:clearPageControlsVal('N');" RepeatDirection="Horizontal"
                                                            ID="rblSearchType" runat="server" RepeatColumns="5">
                                                             <asp:ListItem Text="None" Value="4" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Name" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Number" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Mobile/Phone" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="Booking Number" Value="3"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="w-28p" colspan="2">
                                                        <table>
                                                            <tr>
                                                                <td class="a-left w-24p">
                                                                    <asp:Label ID="lblName" runat="server" Text="<u>N</u>ame" AssociatedControlID="txtName"
                                                                        AccessKey="N"></asp:Label>
                                                                </td>
                                                                <td class="a-left w-20p">
                                                                    <asp:DropDownList CssClass="ddl" ID="ddSalutation" runat="server">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:TextBox ID="txtName" onfocus="javascript:setPatientSearch();" onKeyDown="javascript:clearPageControlsVal('Y');"
                                                                          OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                        autocomplete="off" runat="server" CssClass="small" MaxLength="50"> </asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                                        ServiceMethod="GetLabQuickBillPatientListdetails" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
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
                                                            AccessKey="X"></asp:Label>
                                                    </td>
                                                    <td class="w-19p a-left">
                                                        <asp:DropDownList Width="70px" ID="ddlSex" onchange="setSexValueoptLab('ddlSex','ddSalutation');"  runat="server" CssClass="ddl">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <asp:Label ID="lblDOB" runat="server" Text="DO<u>B</u>" AssociatedControlID="tDOB"
                                                            AccessKey="B"></asp:Label>
                                                        <asp:TextBox CssClass="Txtboxsmall" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server"
                                                            onblur="javascript:countQuickAge(this.id);" Width="65px" Style="text-align: justify"
                                                            ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
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
                                                    <td id="tdSex1" runat="server" class="w-6p a-left">
                                                        <asp:Label ID="lblAge" runat="server" Text="Age"></asp:Label>
                                                    </td>
                                                    <td id="tdSex2" runat="server" class="w-14p a-left">
                                                        <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onchange="setDOBYear(this.id);"
                                                                 onkeypress="return ValidateOnlyNumeric(this);"    CssClass="Txtboxsmall"
                                                            Width="18%" runat="server" MaxLength="3" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                                        <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" Width="75px"
                                                            runat="server" CssClass="ddl">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                            Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                                        </ajc:TextBoxWatermarkExtender>
                                                    </td>
                                                    <%-- <td align="left" width="12%" id="tdVisitType1" runat="server" style="display: none;">
                                                        <asp:Label ID="Rs_SelectVisit" runat="server" Text="Visit Type:"></asp:Label>
                                                    </td>
                                                    <td align="left" id="tdVisitType2" runat="server" style="display: none;">
                                                        <asp:DropDownList Width="95px" CssClass="bilddltb" onfocus="javascript:CheckPatientName();"
                                                            ID="ddlVisitDetails" runat="server" onchange="ChangeVisit()">
                                                        </asp:DropDownList>
                                                    </td>--%>
                                                    <td>
                                                        <asp:Label ID="lblMarital" runat="server" Text="Marital Status"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="ddlsmall" ID="ddMarital" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblMobile" runat="server" Text="<u>M</u>obile" AssociatedControlID="txtMobileNumber"
                                                            AccessKey="M"></asp:Label>
                                                    </td>
                                                    <td class="a-left v-middle">
                                                        <%--<asp:CheckBox ID="chkMobileNotify" Text="SMS" ToolTip="Send SMS Notification" runat="server" />--%>
                                                        <asp:Label ID="lblCountryCode" runat="server"></asp:Label>
                                                        <asp:TextBox ID="txtMobileNumber" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                            runat="server" MaxLength="13" CssClass="Txtboxsmall"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td class="w-8p">
                                                        <asp:Label ID="lblLandLine" runat="server" Text="<u>T</u>elephone" AssociatedControlID="txtPhone"
                                                            AccessKey="T"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPhone" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                            runat="server" MaxLength="15" CssClass="Txtboxsmall"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblEmail" Text="<u>E</u>-mail" runat="server" AssociatedControlID="txtEmail"
                                                            AccessKey="E"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtEmail" autocomplete="off" runat="server" CssClass="small"
                                                             MaxLength="50"></asp:TextBox>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                            id="imageEmail" runat="server" />
                                                        <%-- <asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                                        ControlToValidate="txtEmail" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                                        ValidationGroup="register" meta:resourceKey="regValidatorResource1">Email 
                                                            not valid</asp:RegularExpressionValidator>--%>
                                                    </td>
                                                    <td class="w-10p a-left">
                                                        <asp:Label ID="lblAddress" Text="<u>A</u>ddress" runat="server" AssociatedControlID="txtAddress"
                                                            AccessKey="A"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtAddress" autocomplete="off" runat="server" CssClass="small"
                                                            MaxLength="250"></asp:TextBox>&nbsp;<img src="../Images/starbutton.png"
                                                                alt="" align="middle" style="display: none;" id="imageAddress" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblSuburban" runat="server" Text="Suburb" AssociatedControlID="txtSuburban"
                                                            AccessKey="B"></asp:Label>
                                                    </td>
                                                    <td>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:TextBox CssClass="Txtboxsmall" autocomplete="off" ID="txtSuburban"
                                                            runat="server" MaxLength="25"></asp:TextBox>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_City" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                                            AccessKey="Y"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox CssClass="small" autocomplete="off" ID="txtCity" runat="server"
                                                            MaxLength="25"></asp:TextBox>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                            id="imageCity" runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPinCode" runat="server" Text="<u>P</u>inCode" AssociatedControlID="txtPincode"
                                                            AccessKey="P"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPincode"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                            MaxLength="8" runat="server" autocomplete="off" CssClass="small"></asp:TextBox>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                            id="imagePincode" runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblCountry" runat="server" Text="<u>C</u>ountry" AssociatedControlID="ddCountry"
                                                            AccessKey="C"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddCountry" onchange="javascript:loadState();" runat="server"
                                                            CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr id="trUrnType" runat="server">
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_State" runat="server" Text="<u>S</u>tate" AssociatedControlID="ddState"
                                                            AccessKey="S"></asp:Label>
                                                    </td>
                                                    <td style="display: table-cell;"> 
                                                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <select id="ddState" runat="server" class="ddlsmall" onchange="javascript:onchangeState();">
                                                        </select>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_URNType" Text="URN Type" runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlUrnType" runat="server" onblur="CheckExistingURN1();"
                                                            onChange="javascript:return CheckMRD();" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_URNOf" runat="server" Text="URN Of"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlUrnoOf" runat="server" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_URN" Text="URN No" runat="server" />
                                                    </td>
                                                    <td>
                                                        <input type="hidden" id="hdnUrn" runat="server" value="0" />
                                                        <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" CssClass="small"
                                                            MaxLength="20" onblur="CheckExistingURN1();ConverttoUpperCase(this.id);"></asp:TextBox>
                                                    </td>
                                                    <td style="display: none">
                                                        <asp:Label ID="lblPatientType" runat="server" Text="Patient Type"></asp:Label>
                                                    </td>
                                                    <td style="display: none">
                                                        <asp:DropDownList ID="ddlPatientType" Width="93%" runat="server" CssClass="ddl">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="trPatientDetails" style="display: none;">
                                                        <div id="showimage" style="display: none; position: absolute; width: 460px; left: 50%;
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
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td class="colorforcontent">
                                    <div id="Div5" runat="server">
                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                            onclick="showsearch()" style="cursor: pointer" />
                                        <span class="dataheader1txt" style="cursor: pointer">&nbsp;<asp:Label ID="Label2"
                                            runat="server" Text="Show Background Problems & Patient Preference" onclick="showsearch()"
                                            meta:resourcekey="lblinvfilter1Resource1"></asp:Label></span></div>
                                    <div id="Div6" style="display: none;" runat="server">
                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                            onclick="Hidesearch()" style="cursor: pointer" />
                                        <span class="dataheader1txt" style="cursor: pointer">
                                            <asp:Label ID="Label4" runat="server" Text="Hide Background Problems & Patient Preference"
                                                onclick="Hidesearch()" meta:resourcekey="lblinvfilters1Resource1"></asp:Label></span></div>
                                </td>
                            </tr>
                        </table>
                        <table id="tblBkgrondProblems" class="dataheaderInvCtrl w-100p" style="display: none;">
                            <tr>
                                <td class="v-top style5">
                                    <table class="searchPanel w-100p">
                                        <tr>
                                            <td class="style6 v-top" style="height: 300px; width: 300px;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                          <asp:Label ID="lblBackgroundProblems" runat="server" Text="Background Problems" meta:resourcekey="lblBackgroundProblems1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <uc12:ComplaintICDCodeBP ID="ComplaintICDCodeBP1" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="style6 v-top" style="height:300px;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblPreference" runat="server" Text="Enter Patient Preference" meta:resourcekey="lblPreference1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <uc13:PatientPreference ID="PatientPreference1" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="dataheaderInvCtrl" class="a-center w-80p">
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnSaveEMR" runat="server" Text="Save" CssClass="btn" Width="50px"
                                        OnClick="btnSaveEMR_Click" OnClientClick="javascript:return validationEvents('After');" />
                                    <asp:Button ID="btnClose" runat="server" Text="Clear" CssClass="btn" Width="50px" OnClientClick="javascript:clearpatientbuttonClick();return false;" />
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" Width="50px" OnClick="btnBack_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />           
    <input type="hidden" id="hdnClienID" runat="server" value="0" />
    <input id="hdnDefaultCountryID" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultCountryStdCode" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnPreference" runat="server" />
    <input id="hdnGender" type="hidden" value="" runat="server" />
    <input id="hdnPatientStateID" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultStateID" type="hidden" value="0" runat="server" />
      <input id="hdnNewOrgID" type="hidden" value="0" runat="server" />
    <input type="hidden" runat="server" value="N" id="hdnIsEditMode" />
    <input id="hdnPatientID" type="hidden" value="-1" runat="server" />
    <input id="HDPatientVisitID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientNumber" type="hidden" value="0" runat="server" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedPatientTempDetails" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
    <input id="hdnPatientName" type="hidden" value="" runat="server" />
    </form>
</body>
</html>
