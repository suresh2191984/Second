<%@ Control Language="C#" EnableViewState="true" AutoEventWireup="true" CodeFile="QuickPatientReg.ascx.cs"
    Inherits="CommonControls_QuickPatientReg" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<table width="99%" border="0" cellspacing="0" class="biltb" cellpadding="0">
    <tr>
        <td colspan="9" id="tdTop" runat="server">
            <table class="dataheaderInvCtrl" width="100%">
                <tr>
                    <td colspan="9">
                        <input cssclass="bilddltb" type="radio" value="Name" name="searchType" runat="server"
                            id="rdoName" onclick="Javascript:SetSearchType('0');" tabindex="1" />
                        <asp:Label ID="Rs_Name" Text="Name" runat="server" meta:resourcekey="Rs_NameResource1" />
                        <input cssclass="bilddltb" type="radio" value="Patient Number" name="searchType"
                            runat="server" id="rdoNumber" onclick="Javascript:SetSearchType('1');" tabindex="2" />
                        <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                        <input cssclass="bilddltb" type="radio" value="Phone Number" name="searchType" runat="server"
                            id="rdoPhone" onclick="Javascript:SetSearchType('2');" tabindex="3" />
                        <asp:Label ID="Rs_PhoneNumber" Text="Phone Number" runat="server" meta:resourcekey="Rs_PhoneNumberResource1" />
                        <input cssclass="bilddltb" type="radio" value="MRD Number" name="searchType" runat="server"
                            id="rdoMrd" onclick="Javascript:SetSearchType('3');" tabindex="4" visible="false" />
                        <asp:Label ID="Rs_MRDNumber" runat="server" Text="MRD Number" Visible="False" meta:resourcekey="Rs_MRDNumberResource1"></asp:Label>
                        <asp:HiddenField ID="hdnSearchType" Value="0" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_SelectVisitType" runat="server" Text="Select Visit Type" meta:resourcekey="Rs_SelectVisitTypeResource1"></asp:Label>
                    </td>
                    <td>
                        <input cssclass="bilddltb" type="radio" value="OP" name="vType" runat="server" id="rdoOP"
                            onclick="Javascript:SetVisitTypePros('OP');" tabindex="1" />
                        <asp:Label ID="RS_OP" runat="server" Text=" OP" meta:resourcekey="RS_OPResource1"></asp:Label>
                        <input cssclass="bilddltb" type="radio" value="IP" name="vType" runat="server" id="rdoIP"
                            onclick="Javascript:SetVisitTypePros('IP');" tabindex="2" />
                        <asp:Label ID="RS_IP" runat="server" Text="IP" meta:resourcekey="RS_IPResource1"></asp:Label>
                        <input cssclass="bilddltb" type="radio" value="DayCare" name="vType" runat="server"
                            id="rdoDayCare" onclick="Javascript:SetVisitTypePros('DayCare');" tabindex="2" />
                        <asp:Label ID="RS_Daycare" runat="server" Text="DayCare" meta:resourcekey="RS_DaycareResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="RS_VisitPurpose" runat="server" Text="Visit Purpose:" meta:resourcekey="RS_VisitPurposeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="dPurpose" CssClass="bilddltb" ToolTip="Click here to select Visit Purpose"
                            runat="server" onfocus="javascript:CheckVisitType('N');" onchange="javascript:ChangePatientVisit();"
                            TabIndex="3" meta:resourcekey="dPurposeResource1">
                        </asp:DropDownList>
                        <asp:HiddenField ID="hdnVisitPurposeText" runat="server" />
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td>
                        <asp:Label ID="Rs_SelectOnOption" runat="server" Text=" Select On Option" meta:resourcekey="Rs_SelectOnOptionResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="bilddltb" onclick="javascript:CheckVisitType('N');" onchange="SetBillingOption();"
                            ID="ddlSelectOnOption" runat="server" TabIndex="4" meta:resourcekey="ddlSelectOnOptionResource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblDepartment" runat="server" Text="Department" meta:resourcekey="lblDepartmentResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddl" meta:resourcekey="ddlDepartmentResource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="Rs_SmartCardNo1" runat="server" Text="Smart Card No" meta:resourcekey="Rs_SmartCardNo1Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSCNo" CssClass="biltextb" runat="server" Width="140px" TabIndex="5"
                            meta:resourcekey="txtSCNoResource1"></asp:TextBox>
                        <asp:Button ID="btnSmartDummy" runat="server" Text="Go" CssClass="btn" OnClientClick="javascript:GetPatientDetailSC();return false;"
                            OnClick="btnSmartDummy_Click" Style="font-size: 11px; height: 18px;" TabIndex="6"
                            meta:resourcekey="btnSmartDummyResource1" />
                        <asp:HiddenField ID="hdnPatientDetailSC" runat="server" />
                        <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtSmartCardNo"
                            ServiceMethod="GetQuickBillPatientListSmartCard" ServicePath="~/OPIPBilling.asmx"
                            EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp111"
                            CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                            FirstRowSelected="false" OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient">
                        </ajc:AutoCompleteExtender>--%>
                    </td>
                    <td align="center">
                        <input id="btnReset" runat="server" type="reset" style="font-size: 11px; height: 18px;"
                            class="btn" title="Click to reset patient details" onclick="return ReSetCommonDetails();"
                            tabindex="7" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="7%">
            <asp:Label ID="Rs1_Name" runat="server" Text="Name:" meta:resourcekey="Rs_NameResource1"></asp:Label>
        </td>
        <td colspan="1" width="28%">
            <asp:DropDownList CssClass="bilddltb" ID="ddSalutation" runat="server" TabIndex="8"
                meta:resourcekey="ddSalutationResource1">
            </asp:DropDownList>
            <asp:TextBox ID="txtPatientName" autocomplete="off" CssClass="biltextb" onKeyDown="return CheckVisitType('Y');"
                onblur="ConverttoUpperCase(this.id);onChangeItem();" runat="server" Width="250px"
                TabIndex="9" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="1" runat="server"
                TargetControlID="txtPatientName" ServiceMethod="GetQuickBillPatientList" ServicePath="~/OPIPBilling.asmx"
                EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                OnClientItemOver="SelectedTemp" OnClientItemSelected="SelectedPatient" Enabled="True">
            </ajc:AutoCompleteExtender>
            <%--OnClientPopulating="BindLoadPatientDetails"--%>
        </td>
        <td width="20%">
            <div id="selectvisits" style="display: block;">
                <asp:Label ID="Rs_SelectVisit" runat="server" Text="Select Visit :" meta:resourcekey="Rs_SelectVisitResource1"></asp:Label>
                <asp:DropDownList CssClass="bilddltb" onfocus="javascript:CheckVisitType('N');CheckPatientName();"
                    ID="ddlVisitDetails" runat="server" onchange="ChangeVisit()" TabIndex="10" meta:resourcekey="ddlVisitDetailsResource1">
                </asp:DropDownList>
                <asp:HiddenField ID="hdnVisitID" runat="server" />
            </div>
            <div id="selectEpis" style="display: none;">
                <asp:Label ID="selectEpisode" runat="server" Text="Select Episode:" meta:resourcekey="selectEpisodeResource1"></asp:Label>
                <asp:DropDownList CssClass="bilddltb" onchange="ChangeEpisode()" ID="drpEpisode"
                    runat="server" TabIndex="10" meta:resourcekey="drpEpisodeResource1">
                </asp:DropDownList>
                <input cssclass="bilddltb" type="radio" value="NewVisit" name="vTypeday" runat="server"
                    id="rdoNewVisit" onclick="CheckSittings()" />
                <asp:Label ID="Label2" runat="server" Text=" NewSititng" meta:resourcekey="Label2Resource1"></asp:Label>
                <input cssclass="bilddltb" type="radio" value="ExistingVisit" name="vTypeday" runat="server"
                    id="rdoExisingvisit" onclick="CheckVisitSitting()" />
                <asp:Label ID="Label3" runat="server" Text="Other-Siting" meta:resourcekey="Label3Resource1"></asp:Label>
            </div>
        </td>
        <td width="11%">
            <asp:Label ID="Rs_VisitType" runat="server" Text="Visit Type :" meta:resourcekey="Rs_VisitTypeResource1"></asp:Label>
            <asp:Label CssClass="bilddltb" ID="lblVisitType" runat="server" meta:resourcekey="lblVisitTypeResource1"></asp:Label>
        </td>
        <td>
            <asp:Label ID="Rs_PatientNoIPNO" runat="server" Text="Patient No/ IP NO :" meta:resourcekey="Rs_PatientNoIPNOResource1"></asp:Label>
        </td>
        <td align="left">
            <asp:Label CssClass="bilddltb" ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
            <asp:Label CssClass="bilddltb" ID="lblIPNo" runat="server" meta:resourcekey="lblIPNoResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="9">
            <div style="vertical-align: text-top;">
                <div id="divDetails1" onclick="PatientDivCollapse(1);" style="cursor: pointer; display: none;"
                    runat="server">
                    &nbsp;<img src="../Images/plus.png" alt="Show" />
                    <strong>
                        <asp:Label ID="Rs_PatientDetails" runat="server" Text="Patient Details" meta:resourcekey="Rs_PatientDetailsResource1"></asp:Label></strong>
                </div>
                <div id="divDetails2" style="cursor: pointer; display: block; cursor: pointer;" onclick="PatientDivCollapse(0);"
                    runat="server">
                    <%--  &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                            <strong>Referring Physician </strong>--%>
                </div>
            </div>
            <div id="divDetails3" runat="server" style="display: block;" title="Patient Details">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="7%">
                            <asp:Label ID="Rs_DOB" runat="server" Text="DOB :" meta:resourcekey="Rs_DOBResource1"></asp:Label>
                        </td>
                        <td colspan="3" width="30%">
                            <asp:TextBox CssClass="biltextb" ToolTip="dd/mm/yyyy" ID="tDOB" runat="server" Width="130px"
                                onblur="javascript:countQuickAge(this.id);" MaxLength="1" Style="text-align: justify"
                                ValidationGroup="MKE" TabIndex="11" meta:resourcekey="tDOBResource1" />
                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                CultureTimePlaceholder="" Enabled="True" />
                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                PopupButtonID="ImgBntCalc" Enabled="True" />
                            &nbsp;<asp:ImageButton Height="13px" ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                CausesValidation="False" TabIndex="12" meta:resourcekey="ImgBntCalcResource1" />
                            <img src="../Images/starbutton.png" alt="" align="middle" />
                            &nbsp;&nbsp;<asp:Label ID="Rs_Age" runat="server" Text="Age :" meta:resourcekey="Rs_AgeResource1"></asp:Label>&nbsp;
                            <asp:TextBox CssClass="biltextb"    onkeypress="return ValidateOnlyNumeric(this);"   ID="txtDOBNos"
                                runat="server" onblur="ClearDOB()" Width="30px" MaxLength="4" Style="text-align: justify"
                                TabIndex="13" meta:resourcekey="txtDOBNosResource1" autocomplete="off" />
                            <asp:DropDownList CssClass="bilddltb" onChange="getDOB()" onblur="javascript:ClearDOB();"
                                ID="ddlDOBDWMY" runat="server" TabIndex="14" meta:resourcekey="ddlDOBDWMYResource1">
                            </asp:DropDownList>
                            <img src="../Images/starbutton.png" alt="" align="middle" />
                        </td>
                        <td width="10%" id="VisitEpisode" style="display: none;">
                            <div>
                                <asp:Label ID="Label4" runat="server" Text="No.Of Sittings :" meta:resourcekey="Label4Resource1"></asp:Label>
                                <asp:TextBox CssClass="biltextb" ID="txtnoofsit" ReadOnly="True" runat="server" Width="30px"
                                    MaxLength="3" Style="text-align: justify" meta:resourcekey="txtnoofsitResource1"
                                    autocomplete="off" />
                            </div>
                        </td>
                        <td width="12%">
                            <asp:Label ID="Rs_Sex" runat="server" Text="Sex :" meta:resourcekey="Rs_SexResource1"></asp:Label>
                            <%--</td>
                        <td >--%>
                            <asp:DropDownList CssClass="bilddltb" ID="ddlSex" runat="server" TabIndex="15" meta:resourcekey="ddlSexResource1">
                            </asp:DropDownList>
                            <img src="../Images/starbutton.png" alt="" align="middle" />
                        </td>
                        <td width="8%">
                            <asp:Label ID="Rs_MaritalStatus" runat="server" Text="Marital Status:" meta:resourcekey="Rs_MaritalStatusResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="bilddltb" ID="ddMarital" runat="server" Width="90px"
                                TabIndex="16" meta:resourcekey="ddMaritalResource1">
                            </asp:DropDownList>
                            <img src="../Images/starbutton.png" alt="" align="middle" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Rs_Address" runat="server" Text="Address :" meta:resourcekey="Rs_AddressResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox CssClass="biltextb" ID="txtAddress" runat="server" Width="300px" TabIndex="17"
                                meta:resourcekey="txtAddressResource1" autocomplete="off"></asp:TextBox>
                            <img src="../Images/starbutton.png" alt="" align="middle" />
                        </td>
                        <td width="10%" id="usedsit" style="display: none;">
                            <div>
                                <asp:Label ID="Label5" runat="server" Text="UsedSittings :" meta:resourcekey="Label5Resource1"></asp:Label>
                                &nbsp;&nbsp;
                                <asp:TextBox CssClass="biltextb" ID="txtUsedSittings" ReadOnly="True" runat="server"
                                    Width="30px" MaxLength="3" Style="text-align: justify" meta:resourcekey="txtUsedSittingsResource1"
                                    autocomplete="off" />
                            </div>
                        </td>
                        <td width="15%">
                            <div>
                                <asp:Label ID="Rs_City" runat="server" Text="City :" meta:resourcekey="Rs_CityResource1"></asp:Label>
                                <%-- </td>
                        <td >--%>
                                <asp:TextBox CssClass="biltextb" ID="txtCity" runat="server" MaxLength="25" TabIndex="18"
                                    meta:resourcekey="txtCityResource1" autocomplete="off"></asp:TextBox>
                                <img src="../Images/starbutton.png" alt="" align="middle" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Rs_Landline" runat="server" Text="Landline :" meta:resourcekey="Rs_LandlineResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="biltextb" ID="txtPhone" MaxLength="22" runat="server" TabIndex="19"
                                meta:resourcekey="txtPhoneResource1" autocomplete="off"></asp:TextBox>
                            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                                TargetControlID="txtPhone" Enabled="True">
                            </ajc:FilteredTextBoxExtender>
                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                alt="" align="middle" />
                        </td>
                        <td>
                            <asp:Label ID="Rs_Mobile" runat="server" Text="Mobile :" meta:resourcekey="Rs_MobileResource1"></asp:Label>
                            &nbsp;
                        </td>
                        <td>
                            <asp:TextBox CssClass="biltextb" ID="txtMobile" runat="server" MaxLength="11" TabIndex="20"
                                meta:resourcekey="txtMobileResource1" autocomplete="off"></asp:TextBox>
                            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                                TargetControlID="txtMobile" Enabled="True">
                            </ajc:FilteredTextBoxExtender>
                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                alt="" align="middle" />
                        </td>
                        <td>
                            <asp:Label ID="Rs_Nationality" runat="server" Text="Nationality" meta:resourcekey="Rs_NationalityResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="bilddltb" ID="ddlNationality" runat="server" TabIndex="21"
                                meta:resourcekey="ddlNationalityResource1">
                            </asp:DropDownList>
                        </td>
                        <td width="5%">
                            <asp:Label ID="Label1" runat="server" Text="Country" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddCountry" runat="server" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged"
                                TabIndex="22" meta:resourcekey="ddCountryResource1">
                            </asp:DropDownList>
                        </td>
                        <td align="right" style="display: none;">
                            <asp:Label ID="Rs_State" runat="server" Text="State" meta:resourcekey="Rs_StateResource1"></asp:Label>
                        </td>
                        <td style="display: none;">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddState" runat="server" TabIndex="23" meta:resourcekey="ddStateResource1">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="9" id="tabDetails" runat="server" style="display: none;">
            <asp:Table CellPadding="1" CssClass="dataheaderInvCtrl" CellSpacing="1" BorderWidth="1px"
                runat="server" ID="TblList" Width="100%" meta:resourcekey="TblListResource1">
            </asp:Table>
        </td>
    </tr>
    <tr>
        <td colspan="9" align="center">
            <table>
                <tr>
                    <td align="right">
                        <div id="dvHelp" width="400px" runat="server" class="dataheaderInvCtrl" align="Left">
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div style="position: absolute; left: 40%; top: 40%; visibility: visible; vertical-align: middle;
    z-index: 40; display: none" id="divProgress" align="center" valign="middle">
    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/ProgressBar.gif"
        meta:resourcekey="imgProgressbarResource1" />
</div>
<asp:HiddenField ID="hdnPatientID" Value="0" runat="server" />
<asp:HiddenField ID="hdnPatientNumber" Value="0" runat="server" />
<asp:HiddenField ID="hdnOrgCreditLimtCtrl" runat="server" Value="N" />
<input type="hidden" id="hdnVal" runat="server" />
<input type="hidden" id="hdnVisitPurpose" runat="server" />
<input type="hidden" id="hdnVisitPurposeID" runat="server" />
<input type="hidden" id="hdnOldVisitPurposeID" runat="server" />
<input type="hidden" id="hdnVisitDetails" value="New Visit~-1" runat="server" />
<input type="hidden" id="hdnMakePayment" value="N" runat="server" />
<input type="hidden" id="hdnVisitSubType" value="" runat="server" />
<input type="hidden" id="hdnVisitSubTypeID" value="1" runat="server" />
<input type="hidden" id="hdnEpisodeID" value="0" runat="server" />
<input type="hidden" id="hdnRateID" value="0" runat="server" />
<input type="hidden" id="hdnClientID" value="0" runat="server" />
<input type="hidden" id="hdnClientName" value="" runat="server" />
<input type="hidden" id="hdnRateType" runat="server" />
<input type="hidden" id="hdnPreAmt" runat="server" />
<input type="hidden" id="hdnRefPhyID" value="0" runat="server" />
<input type="hidden" id="hdnreferralType" runat="server" />
<asp:HiddenField ID="hdnBillingLogic" runat="server" />
<input type="hidden" id="hdnLoadPatientDetails" runat="server" value="" />
<input type="hidden" id="hdnLoadPatientData" runat="server" value="0" />
<input type="hidden" id="hdnRedirectFlag" runat="server" />

<script type="text/javascript" language="javascript">
    var slist = { Name: '<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Name_1 %>',
        PatientNoIPNo: '<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_PatientNoIPNo %>',
        Age: '<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Age_1 %>',
        Type: '<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Type_1 %>',
        Sex: '<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Sex_1 %>',
        Address: '<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Address_1 %>',
        PhoneNo: '<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_PhoneNo_1 %>'
    };
</script>

<script type="text/javascript" language="javascript">


    var fn_VisitType = '';
    function SetSearchType(obj) {

        document.getElementById('<%= rdoOP.ClientID %>').checked = false;

        document.getElementById('<%= rdoIP.ClientID %>').checked = false;
        //
        document.getElementById('<%=rdoDayCare.ClientID %>').checked = false;
        resetpatient();
        document.getElementById('<%=hdnSearchType.ClientID %>').value = obj;
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnPatientID.ClientID %>').value;
        if (Number(Pid) <= 0) {
            document.getElementById('<%=txtPatientName.ClientID %>').value = '';
        }

    }

    function SetVisitTypePros(obj) {
        setFeeTypeForVisit(obj);
        if (obj == "DayCare") {

            document.getElementById("selectvisits").style.display = "none";
            document.getElementById("selectEpis").style.display = "block";


            SetDayCareValues("");
        }
        else {
            document.getElementById("selectvisits").style.display = "block";
            document.getElementById("selectEpis").style.display = "none";


            document.getElementById("VisitEpisode").style.display = "none";
            document.getElementById("usedsit").style.display = "none";

        }


        var orgID = '<%= OrgID %>';
        var stype = document.getElementById('<%=hdnSearchType.ClientID %>').value;
        var s1val = orgID + '~' + obj + '~' + stype;
        fn_VisitType = obj;
        fn_SetVisitType(fn_VisitType);
        resetpatient();
        SetValueOPIO(obj);

        var pvalue = document.getElementById('<%= ddlSelectOnOption.ClientID %>').value;

        obj = obj == "DayCare" ? "IP" : obj;
        SetPanelOPorIP(obj, pvalue);
        GetCurrencyValues();
        SurgeryGetCurrencyValues();


        if (document.getElementById('<%= hdnRedirectFlag.ClientID %>').value != "Y") {
            $find('AutoCompleteExLstGrp11').set_contextKey(s1val);
        }

        document.getElementById('<%= ddlSelectOnOption.ClientID %>').disabled = false;
        if (obj == "OP") {
            document.getElementById('<%= ddlSelectOnOption.ClientID %>').disabled = true;
            document.getElementById('<%= ddlSelectOnOption.ClientID %>').value = "MAKE_BILL";

        }
        if (obj == "IP" && document.getElementById('<%= hdnMakePayment.ClientID %>').value == "N") {
            document.getElementById('<%= ddlSelectOnOption.ClientID %>').disabled = true;
            document.getElementById('<%= ddlSelectOnOption.ClientID %>').value = "MAKE_BILL";
        }


        SetBillingOption(obj);
        SetVisitPurpose(obj);


        // Code modified by Vijay TV to fix Bugtracker Issue ID 812 begins...
        // Set the 'Is Reimbursible' check box of Parent page (GenerateBill.Aspx) to Checked status. Since this control
        // is only in GenerateBill.Aspx, for other Parent pages, this will throw error and hence handled 'Undefined'
        if (parent.document.getElementById('chkIsRI') != undefined)
            parent.document.getElementById('chkIsRI').checked = false;
        // Code modified by Vijay TV to fix Bugtracker Issue ID 812 ends...
    }

    function SetVisitPurpose(obj) {

        var sSetVal = document.getElementById('<%= hdnVisitPurpose.ClientID %>').value.split("^");
        var ddlPurpose = document.getElementById('<%= dPurpose.ClientID %>');
        ddlPurpose.options.length = 0;

        var optn1 = document.createElement("option");
        ddlPurpose.options.add(optn1);
        optn1.text = "-----Select-----";
        optn1.value = "0";

        for (var i = 0; i < sSetVal.length; i++) {
            var value = sSetVal[i].split('~');
            if (obj == value[2]) {
                var optn = document.createElement("option");
                ddlPurpose.options.add(optn);
                optn.text = value[1];
                optn.value = value[0];
            }
        }
        document.getElementById('<%= hdnVisitPurposeID.ClientID %>').value = document.getElementById('<%= dPurpose.ClientID %>').value;
    }

    function ChangePatientVisit() {
                var e = document.getElementById('<%= dPurpose.ClientID %>');
        document.getElementById('<%= hdnVisitPurposeText.ClientID %>').value = e.options[e.selectedIndex].text;
        document.getElementById('<%= hdnVisitPurposeID.ClientID %>').value = document.getElementById('<%= dPurpose.ClientID %>').value;

        var drpSlots = document.getElementById('<%= ddlVisitDetails.ClientID %>');
        var pVisitID = document.getElementById('<%= hdnVisitID.ClientID %>').value;
        document.getElementById('<%= dPurpose.ClientID %>').disabled = false;
        if (pVisitID > 0) {

            if (document.getElementById('<%= rdoOP.ClientID %>').checked) {
                if (document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value != document.getElementById('<%= hdnVisitPurposeID.ClientID %>').value) {
                    drpSlots.disabled = true;
                }
                else {
                    drpSlots.disabled = false;
                }
            }
            if (document.getElementById('<%= rdoIP.ClientID %>').checked) {

                drpSlots.disabled = true;
                document.getElementById('<%= dPurpose.ClientID %>').value = document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value;
                //document.getElementById('<%= dPurpose.ClientID %>').disabled = true;
                document.getElementById('<%= hdnVisitPurposeID.ClientID %>').value = document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value;
            }

        }
        if (document.getElementById('<%= hdnVisitPurposeID.ClientID %>').value == '5') {
            document.getElementById('tdtempSave').style.display = "block";
        }
        else {
            document.getElementById('tdtempSave').style.display = "none";
        }
    }

    function ReSetCommonDetails() {
        // var response = window.confirm("Do you want to clear the form and reset the fields ?");
        var response;
        var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_20');
        if (userMsg == null)
            response = window.confirm('Do you want to clear the form and reset the fields?');
        else
            response = window.confirm(userMsg);
        if (response) { ReSetAllDetails(); } return false;
    }

    function ReSetAllDetails() {
        document.getElementById('<%= rdoOP.ClientID %>').checked = false;
        document.getElementById('<%= rdoIP.ClientID %>').checked = false;
        document.getElementById('<%=rdoDayCare.ClientID %>').checked = false;
        document.getElementById('ddlHospital').selectedIndex = 0;
        document.getElementById('<%=ddlNationality.ClientID %>').selectedIndex = 85;
        document.getElementById('<%=ddCountry.ClientID %>').selectedIndex = 73;

        document.getElementById("selectEpis").style.display = "none";
        document.getElementById("VisitEpisode").style.display = "none";
        document.getElementById("usedsit").style.display = "none";
        if (parent.document.getElementById('chkIsRI') != undefined)
            parent.document.getElementById('chkIsRI').checked = false;
        resetpatient();
        SetBillingOption();
        showHideUsageTab();
        return false;


    }

    function CheckVisitType(pVal) {
        var isTrue = false;
        if (document.getElementById('<%= rdoOP.ClientID %>').checked) {
            isTrue = true;
        }
        if (document.getElementById('<%= rdoIP.ClientID %>').checked) {
            isTrue = true;
        }
        if (document.getElementById('<%=rdoDayCare.ClientID %>').checked) {
            isTrue = true;
        }
        if (isTrue == false) {
            // alert("Select Any One Visit Type");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_1');
            if (userMsg == null)
                alert('Select any one Visit type');
            else
                alert(userMsg);

            return false;
        }
        if (pVal == "Y") {
            resetpatientDetails(false); DisplayData('', 0.00, '');
        }


    }

    function ResetToTodayVisit() {
        var drpSlots = document.getElementById('<%= ddlVisitDetails.ClientID %>');
        var drpSlotsLength = drpSlots.options.length;

        for (var i = 0; i < drpSlotsLength; i++) {

            if (drpSlots.options[i].text == 'Today\'s Visit') {

                drpSlots.selectedIndex = i;

            }


        }
    }
        
        
    
          
</script>

<script language="javascript" type="text/javascript">

    function onchangeName() {
        var dhelp = document.getElementById('<%= dvHelp.ClientID %>');
        dhelp.innerHTML = '';
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnPatientID.ClientID %>').value;
        var Vid = document.getElementById('<%=hdnVisitID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnVisitID.ClientID %>').value;
        if (Number(Pid) <= 0) {
            Pid = 0;
        }
        var OrgID = '<%= OrgID%>';
        if (document.getElementById('<%= rdoOP.ClientID %>').checked) {
            OPIPBilling.loadWebDueDetail(OrgID, Pid, 0, DueList);
            if (Pid > 0) {
                LoadPatientSavedDetails()
            }
        }
        if (document.getElementById('<%= rdoOP.ClientID %>').checked) {
            OPIPBilling.GetPatientDepositDetails(Pid, OrgID, fDepositDetail);
        }
        if (document.getElementById('<%= rdoIP.ClientID %>').checked || document.getElementById('<%=rdoDayCare.ClientID %>').checked) {
            OPIPBilling.InpatientDueDetails(Pid, 0, OrgID, DueAmount);
            if (document.getElementById('<%=hdnOrgCreditLimtCtrl.ClientID %>').value == "Y" && Pid > 0)
                OPIPBilling.GetBillSnapShot(Pid, Vid, OrgID, CreditDueAmount);

        }

    }
    function LoadPatientSavedDetails() {
        document.getElementById('dspData_hdfBillType1').value = '';
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../OPIPBilling.asmx/GetOrderServiceDetails",
            data: JSON.stringify({ VisitID: document.getElementById('<%= hdnPatientID.ClientID %>').value, ServiceNumber: '0', Type: 'QB' }),
            dataType: "json",
            success: function(data, value) {
                var GetData = data.d;
                $.each(GetData, function(index, Item) {
                    if (Item.Remarks != null && Item.Remarks != "") {
                        var ItemArray = Item.Remarks.split('###');
                        for (var i = 0; i < ItemArray.length; i++) {
                            var ItemSubArray = ItemArray[i].split('^');
                            FeeType = ItemSubArray[0];
                            FeeID = ItemSubArray[1];
                            OtherID = ItemSubArray[2];
                            Descrip = ItemSubArray[3];
                            Perphyname = ItemSubArray[4];
                            PerphyID = ItemSubArray[5];
                            Quantity = ItemSubArray[6];
                            Amount = ItemSubArray[7];
                            Total = ItemSubArray[8];
                            DTime = ItemSubArray[9];
                            IsRI = ItemSubArray[10];
                            DisorEnhpercent = ItemSubArray[11];
                            DisorEnhType = ItemSubArray[12];
                            Remarks = ItemSubArray[13];
                            ReimbursableAmount = ItemSubArray[14];
                            NonReimbursableAmount = ItemSubArray[15];
                            AMBCODE = ItemSubArray[16];
                            CmdAddBillItemsType_onclick(FeeType, FeeID, OtherID, Descrip, Perphyname, PerphyID, Quantity, Amount, Total, DTime, IsRI, DisorEnhpercent, DisorEnhType, Remarks, ReimbursableAmount, NonReimbursableAmount, AMBCODE);
                            ClearItemsInControl();
                            AddAmountinTextbox();

                            totalCalculate();
                            SetOtherCurrValues();

                            document.getElementById('chkIsRI').checked = true;
                            document.getElementById('hdnFreeTextAllow').value = "0";
                            document.getElementById('hdnFreeTextDescription').value = "";
                        }
                    }

                });


            },
            error: function(result) {
                alert("Error");
            }
        });
    }
    function DueAmount(tDueAmount) {
        IPDisplayDue(tDueAmount[0].DueAmount);
    }
    function CreditDueAmount(CreditDueAmt) {
        if (CreditDueAmt.length > 0) {
            SetCreditLimitValues(CreditDueAmt[0].GrossBillValue, CreditDueAmt[0].AmountReceived, CreditDueAmt[0].ToPay, CreditDueAmt[0].CreditLimt, CreditDueAmt[0].BalanceCreditLimit, CreditDueAmt[0].IsCreditBill, CreditDueAmt[0].PreAuthAmount, CreditDueAmt[0].NonMedicalAmount, CreditDueAmt[0].Comments, CreditDueAmt[0].TPAAmount)
        }
    }
    function fDepositDetail(tDeposit) {
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value;
        if (Number(Pid) <= 0) {
            Pid = 0;
        }
        if (tDeposit.length > 0) {
            setDepositValues(Pid, tDeposit[0].DepositID, tDeposit[tDeposit.length - 1].AmountDeposited, tDeposit[tDeposit.length - 1].PaidCurrencyAmount);
        }
    }
    function DueList(tmpVal) {
        var sVal = '';
        var dueamt = 0;
        var dueString = '';
        sVal = ' <table width="100%" border="0.2"><caption align="top">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_DueDetails %>"+"</caption><tr> <th scope="col"><div align="center">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_BillNo %>"+"</div></th><th scope="col"><div align="center">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_BillDate %>"+"</div></th><th scope="col"><div align="center">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_NetValue %>"+"</div></th><th scope="col"><div align="center">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Due %>"+"</div></th></tr>';
        if (tmpVal.length > 0) {
            var listLen = tmpVal.length;
            for (var i = 0; i < listLen; i++) {
                sVal += '<tr><td>' + tmpVal[i].BillNumber + '</td>';
                sVal += '<td>' + dateformatchange(tmpVal[i].CreatedAt) + '</td>';
                sVal += '<td>' + tmpVal[i].NetValue + '</td>';
                sVal += '<td>' + tmpVal[i].CurrentDue + '</td></tr>';
                dueamt = Number(tmpVal[i].PatientDue, 2) + Number(dueamt, 2);
                dueString = dueString + '|' + tmpVal[i].FinalBillID + '~' + tmpVal[i].CurrentDue + '|';
            }
        }
        sVal += '</table>';
        DisplayData(sVal, dueamt, dueString);
    }


    function checkPatientnVisit() {
        
        if (document.getElementById('<%= dPurpose.ClientID %>').value.trim() == "0") {
            // alert("Select The Visit Purpose");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_2');
            if (userMsg == null)
                alert('Select The Visit Purpose');
            else
                alert(userMsg);
            document.getElementById('<%= dPurpose.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%= txtPatientName.ClientID %>').value.trim() == "") {
            // alert("Enter The Patient Name");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_3');
            if (userMsg == null)
                alert('Enter The Patient Name');
            else
                alert(userMsg);
            document.getElementById('<%= txtPatientName.ClientID %>').focus();
            return false;
        }

        if (document.getElementById('<%= tDOB.ClientID %>').value.trim() == "" && document.getElementById('<%= txtDOBNos.ClientID %>').value.trim() == "") {
            // alert('Provide date of birth or age (in days or weeks or months or year) & choose appropriate one from the list')
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_4');
            if (userMsg == null)
                alert('Provide Date of Birth or Age (in Days or Weeks or Months or Year) & choose appropriate one from the list');
            else
                alert(userMsg);
            document.getElementById('<%= tDOB.ClientID %>').focus();
            return false;
        }

        if (document.getElementById('<%= txtDOBNos.ClientID %>').value.trim() == '') {
            // alert('Provide age (in days or weeks or months or year) & choose appropriate one from the list')
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_4');
            if (userMsg == null)
                alert('Provide age (in days or weeks or months or year) & choose appropriate one from the list');
            else
                alert(userMsg);
            document.getElementById('<%= txtDOBNos.ClientID %>').focus();
            return false;

        }
        if (document.getElementById('<%= txtDOBNos.ClientID %>').value.trim() <= 0) {
            document.getElementById('<%= txtDOBNos.ClientID %>').value = '';
        }

        if (document.getElementById('<%= ddlDOBDWMY.ClientID %>').value.trim() == 'Y') {

            if (document.getElementById('<%= txtDOBNos.ClientID %>').value.trim() >= 150) {
                // alert('Provide a valid year')
                var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_6');
                if (userMsg == null)
                    alert('Provide a valid year');
                else
                    alert(userMsg);
                document.getElementById('<%= txtDOBNos.ClientID %>').value = '';
                document.getElementById('<%= txtDOBNos.ClientID %>').focus();
                return false;
            }

        }
        if (document.getElementById('<%= ddlDOBDWMY.ClientID %>').value.trim() == 'M') {

            if (document.getElementById('<%= txtDOBNos.ClientID %>').value >= 2500) {
                // alert('Provide a valid month')
                var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_7');
                if (userMsg == null)
                    alert('Provide a valid month');
                else
                    alert(userMsg);
                document.getElementById('<%= txtDOBNos.ClientID %>').value = '';
                document.getElementById('<%= txtDOBNos.ClientID %>').focus();
                return false;
            }
        }
        if (document.getElementById('<%= ddMarital.ClientID %>').value.trim() == "0") {
            // alert("Select The Marital Status");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_8');
            if (userMsg == null)
                alert('Select The Marital Status');
            else
                alert(userMsg);
            document.getElementById('<%= ddMarital.ClientID %>').focus();
            return false;
        }
        
        if (document.getElementById('<%= txtAddress.ClientID %>').value.trim() == "") {
            // alert("Enter The Address");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_9');
            if (userMsg == null)
                alert('Enter The Address');
            else
                alert(userMsg);
            document.getElementById('<%= txtAddress.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%= txtCity.ClientID %>').value.trim() == "") {
            // alert("Enter The City");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_10');
            if (userMsg == null)
                alert('Enter The City');
            else
                alert(userMsg);
            document.getElementById('<%= txtCity.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%= txtPhone.ClientID %>').value.trim() == "" && document.getElementById('<%= txtMobile.ClientID %>').value.trim() == "") {
            // alert("Enter The Landline Number or Mobile Number");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_11');
            if (userMsg == null)
                alert('Enter The Landline Number or Mobile Number');
            else
                alert(userMsg);
            document.getElementById('<%= txtPhone.ClientID %>').focus();
            return false;
        }
        if (!setvalidateDaycare()) {
            return "Y";
        }

        document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value = document.getElementById('<%= hdnVisitPurposeID.ClientID %>').value;
        return true;

    }
    function resetpatient() {

        resetpatientDetails(true);
        setSexValue(document.getElementById('<%=ddlSex.ClientID %>').id, document.getElementById('<%=ddSalutation.ClientID %>').id);
        ClearReferringPhysician("ReferDoctor1");
        ClearReferringPhysician("ReferDoctor2");
        ItemscloseData();
        GetCurrencyValues();
        SurgeryGetCurrencyValues();
        showResponses('divRef1', 'divRef2', 'divRef3', 1);
        showResponses('divMore1', 'divMore2', 'divMore3', 0);
        PatientDivCollapse(1);
        ClearDisplayData();
        SetVisitDetails();
        clearCreditLimitValues();
        DisableReferDoctor("ReferDoctor1", "N");
        ClearClientValues();
        resetSurgeryPkg();
        ResetIsmapped();
        clearOldReferringdetails();



    }
    function resetpatientDetails(pType) {
        if (pType) {
            document.getElementById('<%= txtPatientName.ClientID %>').value = "";
            document.getElementById('<%= dPurpose.ClientID %>').value = "0";
            document.getElementById('<%=ddlSex.ClientID %>').value = "1";
        }
        document.getElementById('<%= dPurpose.ClientID %>').disabled = false;

        document.getElementById('<%= ddlVisitDetails.ClientID %>').disabled = false;
        document.getElementById('<%= txtSCNo.ClientID %>').value = "";
        document.getElementById('<%= txtSCNo.ClientID %>').disabled = false;

        document.getElementById('<%= txtDOBNos.ClientID %>').value = "";
        document.getElementById('<%= lblVisitType.ClientID %>').innerHTML = "";
        document.getElementById('<%= txtAddress.ClientID %>').value = "";
        document.getElementById('<%= lblIPNo.ClientID %>').innerHTML = "";
        document.getElementById('<%= tDOB.ClientID %>').value = "";
        document.getElementById('<%= txtCity.ClientID %>').value = "";
        document.getElementById('<%= ddMarital.ClientID %>').value = "S";

        document.getElementById('<%= txtMobile.ClientID %>').value = "";
        document.getElementById('<%= lblPatientNo.ClientID %>').innerHTML = "";
        document.getElementById('<%= txtPhone.ClientID %>').value = "";
        document.getElementById('<%= hdnPatientID.ClientID %>').value = 0;
        document.getElementById('<%= hdnVisitDetails.ClientID %>').value = "New Visit~-1";
        var dhelp = document.getElementById('<%= dvHelp.ClientID %>');
        dhelp.innerHTML = '';

        document.getElementById('<%= hdnVisitID.ClientID %>').value = "-1";
        document.getElementById('<%= hdnVisitSubTypeID.ClientID %>').value = "1";
        document.getElementById('<%= hdnEpisodeID.ClientID %>').value = "0";
        document.getElementById('<%=txtnoofsit.ClientID %>').value = "";
        document.getElementById('<%=txtUsedSittings.ClientID %>').value = "";
        document.getElementById('<%=rdoExisingvisit.ClientID %>').checked = false;
        document.getElementById('<%=rdoNewVisit.ClientID %>').checked = false;



    }
    function SetDayCareValues(dayCareList) {
        var list = dayCareList.split('^');
        var drpepisodes = document.getElementById('<%= drpEpisode.ClientID %>');
        drpepisodes.options.length = 0;
        var optn1 = document.createElement("option");
        drpepisodes.options.add(optn1);
        optn1.text = "-----Select-----";
        optn1.value = "0";
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                var res = list[i].split('~');
                var optn = document.createElement("option");
                drpepisodes.options.add(optn);
                optn.text = res[2];
                optn.value = list[i];
            }
        }
    }

    function ChangeEpisode() {
        var pDayList = document.getElementById('<%= drpEpisode.ClientID %>').value;
        var tList = pDayList.split('~');
        var tVisitID = tList[0];
        var tEpisodeID = tList[1];
        var UsedSittings = tList[7];
        var tPOAName = tList[2];
        var NoofSittings = tList[6];
        if (document.getElementById('<%= drpEpisode.ClientID %>').text == "-----Select-----") {
            document.getElementById('<%= txtUsedSittings.ClientID %>').text = "0";
            document.getElementById('<%= txtnoofsit.ClientID %>').text = "0";
        }
        if (document.getElementById('<%=rdoDayCare.ClientID %>').checked) {

            document.getElementById("VisitEpisode").style.display = "block";
            document.getElementById("usedsit").style.display = "block";

            document.getElementById('<%=txtnoofsit.ClientID %>').value = NoofSittings;
            document.getElementById('<%=txtUsedSittings.ClientID %>').value = UsedSittings;

        }
        else {
            document.getElementById("VisitEpisode").style.display = "none";
        }

        if (UsedSittings == 0) {

            document.getElementById('<%= rdoNewVisit.ClientID %>').checked = true;
            document.getElementById('<%=rdoDayCare.ClientID %>').checked = true;
        }
        else {
            document.getElementById('<%= rdoNewVisit.ClientID %>').checked = false;
            document.getElementById('<%= rdoExisingvisit.ClientID %>').checked = false;
        }
        document.getElementById('<%=rdoDayCare.ClientID %>').checked = true;
        document.getElementById('<%= hdnVisitID.ClientID %>').value = tVisitID;
        document.getElementById('<%= hdnEpisodeID.ClientID %>').value = tEpisodeID;


        document.getElementById('<%= hdnVisitDetails.ClientID %>').value = tPOAName + "~" + tVisitID;

        if (pDayList != "0") {
            SetVisitDetails();
        }
           // if (IsCreditBill == "Y") {
         //   getAdvanceDetails();
        // }
        getAdvanceDetails();

    }



    function SelectedPatient(source, eventArgs) {
                var isDayCareDetails = "";
        var isPatientDetails = "";

        isPatientDetails = eventArgs.get_value();
        var IsCreditBill = isPatientDetails.split('~')[16];
        var RefphyId = isPatientDetails.split('~')[30];
        var ReferralType = isPatientDetails.split('~')[31];
        var EligibleRoomTypeID = isPatientDetails.split('~')[32];
        var ISSurgeryPatient = isPatientDetails.split('~')[33];

        if (RefphyId <= 0) {
            DisableReferDoctor("ReferDoctor1", "N");
            document.getElementById('<%=hdnRefPhyID.ClientID %>').value = '0';
        }
        else {
            setReferringDetails("ReferDoctor1", RefphyId, ReferralType);
            DisableReferDoctor("ReferDoctor1", "Y");
            document.getElementById('<%=hdnRefPhyID.ClientID %>').value = RefphyId;
            document.getElementById('<%=hdnreferralType.ClientID %>').value = ReferralType;
        }

        if (document.getElementById('<%= rdoDayCare.ClientID %>').checked) {
            isPatientDetails = eventArgs.get_value().split('|')[0];
            isDayCareDetails = eventArgs.get_value().split('|')[1];
            SetDayCareValues(isDayCareDetails);


        }

        var tName = eventArgs.get_text().split(':')[0];
        var tNum = eventArgs.get_text().split(':')[1];
        var tvType = eventArgs.get_text().split(':')[2];
        var tVisitID = isPatientDetails.split('~')[0];
        var tSex = isPatientDetails.split('~')[1] == "M" ? "Male" : "Female";
        var tTITLECode = isPatientDetails.split('~')[2];
        var tAge = isPatientDetails.split('~')[3];
        var tAdd1 = isPatientDetails.split('~')[4];

        var tPOAName = isPatientDetails.split('~')[7];
        var IPNumber = isPatientDetails.split('~')[8];
        var TPNumber = '';
        if (isPatientDetails.split('~')[15].search(',') != -1)
        // TPNumber = isPatientDetails.split('~')[15].split(',')[1];
            TPNumber = isPatientDetails.split('~')[9];

        var Pid = isPatientDetails.split('~')[10];
        var visitState = isPatientDetails.split('~')[11];
        var DOB = isPatientDetails.split('~')[12];
        var MartialStatus = isPatientDetails.split('~')[13];
        var City = isPatientDetails.split('~')[14];
        var Mobile = isPatientDetails.split('~')[15].split(',')[0];
        var Nationality = isPatientDetails.split('~')[18];
        var StateID = isPatientDetails.split('~')[19];
        var CountryID = isPatientDetails.split('~')[20];
        var VisitPurpose = isPatientDetails.split('~')[21];
        var SmartCardNumber = isPatientDetails.split('~')[26];
        var VisitSubType = isPatientDetails.split('~')[27];
        document.getElementById('<%= txtPatientName.ClientID %>').value = tName;
        document.getElementById('<%= ddSalutation.ClientID %>').value = tTITLECode
        document.getElementById('<%= txtDOBNos.ClientID %>').value = tAge.split(' ')[0];
        document.getElementById('<%= ddlDOBDWMY.ClientID %>').value = tAge.split(' ')[1];
        document.getElementById('<%= lblVisitType.ClientID %>').innerHTML = tvType;
        document.getElementById('<%= txtAddress.ClientID %>').value = trim(tAdd1, ' ');
        document.getElementById('<%= lblIPNo.ClientID %>').innerHTML = '/' + IPNumber;
        document.getElementById('<%= tDOB.ClientID %>').value = DOB;
        document.getElementById('<%= txtCity.ClientID %>').value = City;
        document.getElementById('<%= ddMarital.ClientID %>').value = MartialStatus;
        document.getElementById('<%= txtMobile.ClientID %>').value = Mobile;
        document.getElementById('<%= ddlNationality.ClientID %>').value = Nationality;
        document.getElementById('<%=  ddCountry.ClientID %>').value = CountryID;
        document.getElementById('<%= ddState.ClientID %>').value = StateID;
        document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value = VisitPurpose;
        
        if (VisitPurpose == 5) {
            fn_disablePatientdemographics();
        }
        document.getElementById('<%= txtSCNo.ClientID %>').value = SmartCardNumber;
        document.getElementById('<%= txtSCNo.ClientID %>').disabled = true;
        if (VisitPurpose != 0) {
            document.getElementById('<%= dPurpose.ClientID %>').value = VisitPurpose;
        }

        document.getElementById('<%= lblPatientNo.ClientID %>').innerHTML = tNum;
        document.getElementById('<%= txtPhone.ClientID %>').value = TPNumber;
        if (IPNumber != 0)
            document.getElementById('<%=hdnPatientNumber.ClientID %>').value = IPNumber;
        else
            document.getElementById('<%=hdnPatientNumber.ClientID %>').value = tNum;
        document.getElementById('<%= hdnPatientID.ClientID %>').value = Pid;
        document.getElementById('<%= ddlSex.ClientID %>').value = isPatientDetails.split('~')[1];
        document.getElementById('<%= hdnVisitID.ClientID %>').value = tVisitID;
        document.getElementById('<%= hdnVisitSubTypeID.ClientID %>').value = VisitSubType;
        var dhelp = document.getElementById('<%= dvHelp.ClientID %>');
        dhelp.innerHTML = '';
        document.getElementById('<%= hdnVisitDetails.ClientID %>').value = tPOAName + "~" + tVisitID + "~" + RefphyId + "~" + ReferralType;
        SetVisitDetails();
        DeleteTable();
        onchangeName();
        GetCurrencyValues();
        SurgeryGetCurrencyValues();
        ChangePatientVisit();
        fn_SetVisitdetails(tVisitID, fn_VisitType, IsCreditBill, EligibleRoomTypeID)
        if (event.keyCode == 13)
            document.getElementById('QPR_tDOB').focus();
        if (ISSurgeryPatient == 'Y' && document.getElementById('<%= rdoIP.ClientID %>').checked == true) {
            document.getElementById('tdIsAddedtoServices').style.display = 'block';
            document.getElementById('ChkIsAddedtoServices').checked = true;
            ShowNHideBtn();
        }
        else if (ISSurgeryPatient != 'Y' && document.getElementById('<%= rdoIP.ClientID %>').checked == true) {
            document.getElementById('tdIsAddedtoServices').style.display = 'none';
            document.getElementById('ChkIsAddedtoServices').checked = false;
            ShowNHideBtn();
        }
        else {
        }

        SetValidation("Y");    
    }
    function trim(str, chars) {
        return ltrim(rtrim(str, chars), chars);
    }

    function ltrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
    }

    function rtrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
    }
    function onChangeItem() {
        var obj = document.getElementById('<%= hdnVisitDetails.ClientID %>');
        if (document.getElementById('<%= rdoIP.ClientID %>').checked) {
            if (obj.value.split('~')[0].toLowerCase() != "admitted") {
                //alert("This Patient Not Yet Admitted.");
                ReSetAllDetails();
                document.getElementById('<%= txtPatientName.ClientID %>').value = '';
                return;
            }
        }


        var dhelp = document.getElementById('<%= dvHelp.ClientID %>');
        dhelp.innerHTML = '';
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value;
        if (Number(Pid) <= 0) {
            Pid = 0;
        }
        if (Pid == 0) {
            var pvalue = document.getElementById('<%= ddlSelectOnOption.ClientID %>').value;
            SetPanelOPorIP("OP", pvalue);
        }

        SetBillingOption();


    }
    function CheckSittings() {

        var Noofsit = document.getElementById('<%= txtnoofsit.ClientID %>').value;
        var Usedsit = document.getElementById('<%= txtUsedSittings.ClientID %>').value;
        if (document.getElementById('<%= drpEpisode.ClientID %>').value == 0) {
            // alert('Select any one Episode');
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_12');
            if (userMsg == null)
                alert('Select any one Episode');
            else
                alert(userMsg);
            return false;
        }
        else {
            if (Usedsit == Noofsit) {
                // alert("Sitings are finished this Episode ");
                var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_13');
                if (userMsg == null)
                    alert('Sittings are finished for this Episode');
                else
                    alert(userMsg);
                document.getElementById('<%= rdoNewVisit.ClientID %>').checked = false;
                document.getElementById('<%= rdoExisingvisit.ClientID %>').checked = false;
                return false;
            }
            else {
                return true;
            }
        }


    }
    function CheckVisitSitting() {

        var Usedsit = document.getElementById('<%= txtUsedSittings.ClientID %>').value;
        if (Usedsit == 0) {
            // alert("Used Sitings are zero so please select Newsittings");
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_14');
            if (userMsg == null)
                alert('Used Sittings are zero. Please select New sittings');
            else
                alert(userMsg);
            document.getElementById('<%= rdoNewVisit.ClientID %>').focus();

            document.getElementById('<%= rdoExisingvisit.ClientID %>').checked = false;
            return false;
        }
        else {
            return true;
        }


    }
    function SelectedTemp(Source, eventArgs) {

        var tName = eventArgs.get_text().split(':')[0];
        var tNum = eventArgs.get_text().split(':')[1];
        var tvType = eventArgs.get_text().split(':')[2];
        var tVisitID = eventArgs.get_value().split('~')[0];
        var tSex = eventArgs.get_value().split('~')[1] == "M" ? "Male" : "Female";
        var tTITLECode = eventArgs.get_value().split('~')[2];
        var tAge = eventArgs.get_value().split('~')[3];
        var tAdd1 = eventArgs.get_value().split('~')[4];
        var tClientID = eventArgs.get_value().split('~')[5];
        var tRateID = eventArgs.get_value().split('~')[6];
        var tPOAName = eventArgs.get_value().split('~')[7];
        var IPNumber = eventArgs.get_value().split('~')[8];
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 begins ...
        //var TPNumber = eventArgs.get_value().split('~')[9]; 
        var TPNumber = eventArgs.get_value().split('~')[15]; // Associate the right index for Phone number from the ~ separated list
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 ends ...
        var dhelp = document.getElementById('<%= dvHelp.ClientID %>');
        var DOB = eventArgs.get_value().split('~')[12];
        var City = eventArgs.get_value().split('~')[14];
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 begins...
        // var urno = eventArgs.get_value().split('~')[15];
        var urno = eventArgs.get_value().split('~')[9]; // Associate the right index for URN from the ~ separated list
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 ends...

        var Tooltips = '<table border="0"><tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Name %></td><td>:</td><td align="left">' + tName + '</td></tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_PatientNo %></td><td>:</td> <td align="left">' + tNum + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_IPNo %></td><td>:</td> <td align="left">' + IPNumber + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_URNNo %></td><td>:</td> <td align="left">' + urno + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_DOB %></td><td>:</td> <td align="left">' + DOB + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Age %></td><td>:</td> <td align="left">' + tAge + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Sex %></td><td>:</td> <td align="left">' + tSex + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Address %></td><td>:</td> <td align="left">' + tAdd1 + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_City %></td><td>:</td> <td align="left">' + City + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_PhoneNo %></td><td>:</td> <td align="left">' + TPNumber + '</td> </tr>';
        Tooltips += '<tr><td><%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_VisitPurpose %></td><td>:</td> <td align="left">' + tPOAName + '</td> </tr> </table>';
        dhelp.innerHTML = Tooltips;

    }
    function dateformatchange(dateFormat) {
        var today = new Date();
        var dd = dateFormat.getDate();
        var mm = dateFormat.getMonth() + 1; //January is 0!
        var yyyy = dateFormat.getFullYear();
        if (dd < 10) { dd = '0' + dd }
        if (mm < 10) { mm = '0' + mm }
        var fmt = dd + '/' + mm + '/' + yyyy;
        if (fmt != '01/01/1800') {
            return fmt;
        }
        else {
            return '';
        }
    }
    var flag = 0;
    function ChangeVisit() {

        var obj = document.getElementById('<%= hdnVisitDetails.ClientID %>');
        var drpSlots = document.getElementById('<%= ddlVisitDetails.ClientID %>');
        var vClientID = document.getElementById('<%=hdnClientID.ClientID %>').value;
        var vRateID = document.getElementById('<%=hdnRateID.ClientID %>').value;
        var vPreAmt = document.getElementById('<%=hdnPreAmt.ClientID %>').value;
        var vClientName = document.getElementById('<%=hdnClientName.ClientID%>').value;

        document.getElementById('<%= hdnVisitID.ClientID %>').value = obj.value.split('~')[1];
        if (drpSlots.selectedIndex > -1) {
            if ((obj.value.split('~')[0] != "New Visit") && (obj.value.split('~')[0] != "Admitted") && (drpSlots.options[drpSlots.selectedIndex].text == "New Visit")) {

                document.getElementById('<%= hdnVisitID.ClientID %>').value = -1;

            }
            else if ((obj.value.split('~')[0] == "New Visit")) {

                DisableReferDoctor("ReferDoctor1", "N");
                resetRefPhyDetails("ReferDoctor1");
            }

            else {
                var RefphyId = obj.value.split('~')[2];
                var ReferralType = obj.value.split('~')[3];
                setReferringDetails("ReferDoctor1", RefphyId, ReferralType);
                DisableReferDoctor("ReferDoctor1", "Y");
                document.getElementById('<%=hdnRefPhyID.ClientID %>').value = RefphyId;
                document.getElementById('<%=hdnreferralType.ClientID %>').value = ReferralType;
            }
        }
        var objVisitType = document.getElementById('<%= ddlVisitDetails.ClientID %>');
        var vVisitType = '';
        if (objVisitType.selectedIndex > -1) {
            vVisitType = objVisitType.options[objVisitType.selectedIndex].text;
            if ((obj.value.split('~')[0] == "Today's Visit" || obj.value.split('~')[0] == "Follow-up Visit")) {
                if (flag >= 1 && (drpSlots.options[drpSlots.selectedIndex].text == "New Visit")) {
                    DisableReferDoctor("ReferDoctor1", "N");
                    resetRefPhyDetails("ReferDoctor1");
                }
                else {
                    if (RefphyId <= 0) {
                        DisableReferDoctor("ReferDoctor1", "N");
                    }
                    else {
                        setOldReferringdetails();
                        DisableReferDoctor("ReferDoctor1", "Y");
                    }
                }
            }
        }

        flag = flag + 1;

        var ddlVisitDetails = document.getElementById('<%=ddlVisitDetails.ClientID %>');
        if (ddlVisitDetails.options[ddlVisitDetails.selectedIndex].text == "Today's Visit")
            fn_DisableClientCntorl(true);
        else
            fn_DisableClientCntorl(false);
        

    }

    function ClearDOB() {
        var currentTime;
        if (document.getElementById('QPR_txtDOBNos').value <= 0) {
            document.getElementById('QPR_txtDOBNos').value = '';
        }
        if (document.getElementById('QPR_txtDOBNos').value >= 150) {
            // alert('Provide a valid year');
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_6');
            if (userMsg == null)
                alert('Provide a valid year');
            else
                alert(userMsg);
            document.getElementById('QPR_txtDOBNos').value = '';
            document.getElementById('QPR_txtDOBNos').focus();
            return false;
        }
    }

</script>

<script language="javascript" type="text/javascript">

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
                                    document.getElementById('QPR_txtDOBNos').value = totdays;
                                    document.getElementById('QPR_ddlDOBDWMY').value = 'Day(s)';
                                }
                                else {
                                    document.getElementById('QPR_txtDOBNos').value = totdays;
                                    document.getElementById('QPR_ddlDOBDWMY').value = 'Day(s)';
                                }
                            }
                        }
                        else {
                            if (weeks == 1) {
                                document.getElementById('QPR_txtDOBNos').value = weeks;
                                document.getElementById('QPR_ddlDOBDWMY').value = 'Week(s)';
                            }
                            else {
                                document.getElementById('QPR_txtDOBNos').value = weeks;
                                document.getElementById('QPR_ddlDOBDWMY').value = 'Week(s)';
                            }
                        }
                    }
                    else {
                        if (months == 1) {
                            document.getElementById('QPR_txtDOBNos').value = months;
                            document.getElementById('QPR_ddlDOBDWMY').value = 'Month(s)';
                        }
                        else {
                            document.getElementById('QPR_txtDOBNos').value = months;
                            document.getElementById('QPR_ddlDOBDWMY').value = 'Month(s)';
                        }
                    }
                }
                else {
                    if (agetemp == 1) {
                        document.getElementById('QPR_txtDOBNos').value = agetemp;
                        document.getElementById('QPR_ddlDOBDWMY').value = 'Year(s)';
                    }
                    else {
                        document.getElementById('QPR_txtDOBNos').value = agetemp;
                        document.getElementById('QPR_ddlDOBDWMY').value = 'Year(s)';
                    }
                }

                function lyear(a) {
                    if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                    else return false;
                }
            }
            else {
                alert(main + ' Date');
                document.getElementById('QPR_txtDOBNos').value = '';
                document.getElementById('QPR_tDOB').value = '';
                document.getElementById('QPR_tDOB').value = '__/__/____';
                document.getElementById('QPR_tDOB').focus();
            }
        }
    }

    function getDOB() {
        if (document.getElementById('QPR_txtDOBNos').value == '') {
            // alert('Please Enter Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_4');
            if (userMsg == null)
                alert('Please Enter Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
            else
                alert(userMsg);
            document.getElementById('QPR_txtDOBNos').focus();
            return false;
        }
        return true;
    }
    function SetBillingOption(obj) {
        var pvalue = document.getElementById('<%= ddlSelectOnOption.ClientID %>').value;

        var pStatus = 'N';
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value;
        var tVisitID = document.getElementById('<%= hdnVisitID.ClientID %>').value;
        if (Number(Pid) > 0 && Number(tVisitID) > 0) {
            pStatus = 'Y';
        }
        if (document.getElementById('<%= rdoIP.ClientID %>').checked) {
            var pvalue = document.getElementById('<%= ddlSelectOnOption.ClientID %>').value;
            SetPanelOPorIP("IP", pvalue);
        }

        if (document.getElementById('<%= rdoDayCare.ClientID %>').checked) {
            var pvalue = document.getElementById('<%= ddlSelectOnOption.ClientID %>').value;
            SetPanelOPorIP("IP", pvalue);
            //            var pvaluess = document.getElementById('<%= drpEpisode.ClientID %>').text //document.getElementById('<%= drpEpisode.ClientID %>').value;
            //            setvalidateDaycare("DayCare", pvaluess);

        }
        setIsAlert();
        getAdvanceDetails();

        if ($('#hdnBillingLogic').val() == 'after' && obj == 'OP') {
            $('#divPaymentType').css('display', 'none');
            $('#tblAmount').css('display', 'none');
            $('#spanAmount1').css('display', 'none');
            $('#spanAmount2').css('display', 'none');
        }
        else if ($('#hdnBillingLogic').val() == 'after' && document.getElementById('<%= rdoIP.ClientID %>').checked == true) {
            $('#divPaymentType').css('display', 'block');
            $('#tblAmount').css('display', 'block');
            $('#spanAmount1').css('display', 'block');
            $('#spanAmount2').css('display', 'block');
            pBillingOption(pvalue, pStatus);
        }
        else if ($('#hdnBillingLogic').val() == 'normal') {
            pBillingOption(pvalue, pStatus);
        }

        GetCurrencyValues();
        SurgeryGetCurrencyValues();

    }
    function setvalidateDaycare() {

        if (document.getElementById('<%= rdoDayCare.ClientID %>').checked) {
            var test = document.getElementById('<%= drpEpisode.ClientID %>').value;
            if (test == "0") {
                // alert("Please Select Episode");
                var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_16');
                if (userMsg == null)
                    alert('Please select Episode');
                else
                    alert(userMsg);
                return false;
            }

        }
        return true;
    }
    function getAdvanceDetails() {
        var pvalue = document.getElementById('<%= ddlSelectOnOption.ClientID %>').value;
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value;
        if (Number(Pid) <= 0) {
            Pid = 0;
        }
        var pStatus = 'N';
        var tVisitID = document.getElementById('<%= hdnVisitID.ClientID %>').value;
        if (Number(Pid) > 0 && Number(tVisitID) > 0) {
            pStatus = 'Y';
        }
        var OrgID = '<%= OrgID%>';

        if (tVisitID > 0) {
            switch (pvalue) {
                case "MAKE_BILL":

                    break;
                case "COLLECT_ADVANCE":
                    OPIPBilling.loadPatientAdvanceDetails(tVisitID, Pid, OrgID, pAdvanceDetails);
                    break;
                case "SURGERY_BILL":
                    pBillingOption(pvalue, pStatus);
                    break;
                case "SURGERY_ADVANCE":
                    GetSurgeryDetailForAdvance(tVisitID);
                    break;
                default:
                    break;
            }
        }
    }

    function pAdvanceDetails(pList) {
        var sVal = '';
        var Advamt = 0;
        var dueString = '';
        sVal = "<table Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;'><tr class='dataheader1' style='font-weight: bold;'>" +
                    "<td align='left'>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_ReceiptNumber%>" + "</td><td align='left'>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Type %>" + "</td><td align='left'>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_Amount %>" + "</td> <td align='left'>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_QuickPatientReg_PaidDate %>" + "</td></tr>";

        if (pList.length > 0) {
            var listLen = pList.length;
            for (var i = 0; i < listLen; i++) {
                sVal += "<tr><td align='left'>" + pList[i].ReceiptNO + "</td>";
                sVal += "<td align='left'>" + pList[i].Remarks + "</td>";
                sVal += "<td align='left'>" + pList[i].AdvanceAmount + "</td>";
                sVal += "<td align='left'>" + dateformatchange(pList[i].PaidDate) + "</td></tr>";
                Advamt = Number(pList[i].AdvanceAmount, 2) + Number(Advamt, 2);
            }
        }
        sVal += '</table>';
        DisplayAdvancData(sVal, Advamt);

    }

    function PatientDivCollapse(pStatus) {

        if (pStatus == 0) {
            document.getElementById('<%= divDetails1.ClientID %>').style.display = 'block';
            document.getElementById('<%= divDetails2.ClientID %>').style.display = 'block';
            document.getElementById('<%= divDetails3.ClientID %>').style.display = 'none';
        }
        else {
            document.getElementById('<%= divDetails1.ClientID %>').style.display = 'none';
            document.getElementById('<%= divDetails2.ClientID %>').style.display = 'none';
            document.getElementById('<%= divDetails3.ClientID %>').style.display = 'block';
        }
    }
</script>

<script language="javascript" type="text/javascript">
    function SetVisitDetails() {
        var drpSlots = document.getElementById('<%= ddlVisitDetails.ClientID %>');
        var pVal = document.getElementById('<%= hdnVisitDetails.ClientID %>').value.split('~');
        var pSubType = document.getElementById('<%= hdnVisitSubType.ClientID %>').value.split('|');
        drpSlots.options.length = 0;
        var pTempVal = "";
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value;
        if (Number(Pid) <= 0) {
            Pid = 0;
        }

        for (var i = 0; i < pSubType.length; i++) {
            if (pSubType[i] != "") {
                var value = pSubType[i].split('^');
                if (value != "" && value[0] == "New Visit" && Pid == 0 && pVal[0] == "New Visit") {
                    pTempVal += pSubType[i] + "|";
                }

                if (value != "" && value[0] != "Today's Visit" && Pid > 0 && pVal[0] == "New Visit" && value[0] != "Admitted") {
                    pTempVal += pSubType[i] + "|";
                }

                if (value != "" && Pid > 0 && pVal[0] == "Today's Visit" && value[0] != "Admitted") {
                    pTempVal += pSubType[i] + "|";
                }

                if (value != "" && value[0] == "Admitted" && Pid > 0 && pVal[0] == "Admitted") {
                    pTempVal += pSubType[i] + "|";
                }
            }
        }
        var pResValue = "1";
        var pTemp = pTempVal.split('|')
        for (var i = 0; i < pTemp.length; i++) {
            if (pTemp[i] != "") {
                var Res = pTemp[i].split('^');
                var optn = document.createElement("option");
                drpSlots.options.add(optn);
                optn.text = Res[0];
                optn.value = Res[1];
                if (Res[1].split("~")[1] == document.getElementById('<%= hdnVisitSubTypeID.ClientID %>').value) {
                    pResValue = Res[1];
                }

            }
        }

        drpSlots.value = pResValue;
        if (document.getElementById('<%= rdoDayCare.ClientID %>').checked != true) {
            ChangeVisit();
        }
        // hdnVisitSubTypeID
    }
    function ResetOldValues(Obj) {
        
        SetVisitPurpose(Obj);
        document.getElementById('<%= dPurpose.ClientID %>').value = document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value;
        ChangePatientVisit();

        setOldReferringdetails();
        if (Obj != 'IP') {
            ResetToTodayVisit();
        }

    }
  
    

</script>

<script type="text/javascript" language="javascript">
    function DeleteTable() {
        var tab = document.getElementById('<%= TblList.ClientID %>');

        while (count = tab.rows.length) {

            for (var j = 0; j < tab.rows.length; j++) {
                tab.deleteRow(j);
            }
        }
        document.getElementById('<%= tabDetails.ClientID %>').style.display = "none";
    }

    function BindLoadPatientDetails(source, eventArgs) {
        // alert(source._completionListElement.outerHTML);
        DeleteTable();
        var tab = document.getElementById('<%= TblList.ClientID %>');

        var Headrow = tab.insertRow(0);
        Headrow.id = "HeadID";
        //    Headrow.style.backgroundColor = "#2c88b1";
        Headrow.style.fontWeight = "bold";
        //    Headrow.style.color = "#FFFFFF";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);

        cell1.innerHTML = slist.Name;
        cell2.innerHTML = slist.PatientNoIPNo;
        cell3.innerHTML = slist.Age;
        cell4.innerHTML = slist.Type;
        cell5.innerHTML = slist.Sex;
        cell6.innerHTML = slist.Address;
        cell7.innerHTML = slist.PhoneNo;


        var x = source._completionListElement.outerHTML.split("_value=");
        var plist = source._completionListElement.innerHTML;
        for (i = 1; i < x.length; i++) {
            if (x[i] != "") {

                y = x[i].split('__item>')[0].split('~');

                document.getElementById('<%= tabDetails.ClientID %>').style.display = "block";

                var tName = y[23];
                var tNum = y[24];
                var tvType = y[25];
                var tSex = y[1] == "M" ? "Male" : "Female";
                var tAge = y[3];
                var tAdd1 = y[4];
                var IPNumber = y[8];
                var TPNumber = y[9];
                var Mobile = y[15];
                var City = y[14];

                var tempPhone = trim(TPNumber, ' ');
                if (tempPhone.length = 1) {
                    tempPhone = trim(TPNumber, ',');
                }
                var pho

                if (Mobile != '') {
                    pho = Mobile;
                }

                if (tempPhone != '') {
                    pho = tempPhone;
                }

                if (tempPhone != '' && Mobile != '') {
                    pho = tempPhone + "/" + Mobile;
                }

                var row = tab.insertRow(1);
                row.style.height = "13px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);

                cell1.innerHTML = tName;
                cell2.innerHTML = tNum + "//" + IPNumber;
                cell3.innerHTML = tAge;
                cell4.innerHTML = tvType;
                cell5.innerHTML = tSex;
                cell5.innerHTML = tAdd1 + "," + City;
                cell7.innerHTML = pho;
            }
        }
    }
    function isCollapse() {
        var isTrue = true;
        if (document.getElementById('<%= dPurpose.ClientID %>').value == "0") {
            isTrue = false;
        }
        if (document.getElementById('<%= txtPatientName.ClientID %>').value == "") {
            isTrue = false;
        }

        if (document.getElementById('<%= tDOB.ClientID %>').value == "" && document.getElementById('<%= txtDOBNos.ClientID %>').value == "") {
            isTrue = false;
        }
        if (document.getElementById('<%= ddMarital.ClientID %>').value == "0") {
            isTrue = false;
        }
        if (document.getElementById('<%= txtAddress.ClientID %>').value == "") {
            isTrue = false;
        }
        if (document.getElementById('<%= txtCity.ClientID %>').value == "") {
            isTrue = false;
        }
        if (document.getElementById('<%= txtPhone.ClientID %>').value == "" && document.getElementById('<%= txtMobile.ClientID %>').value == "") {
            isTrue = false;
        }
        return isTrue;
    }
    function GetPatientDetailSC() {

        if (document.getElementById('<%= txtSCNo.ClientID %>').value.length > 0) {
            if (document.getElementById('<%= txtSCNo.ClientID %>').value != '') {
                $get('wrapper').className = 'BlockBackground';
                $get('wrapper').disabled = true;
                $get('divProgress').style.display = 'block';
                GetPatientDetail(document.getElementById('<%= txtSCNo.ClientID %>').value);
            } else {
                // alert('Smart Card No cannot be blank');
                var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_17');
                if (userMsg == null)
                    alert('Smart Card No cannot be blank');
                else
                    alert(userMsg);
                document.getElementById('<%= txtSCNo.ClientID %>').focus();
                return false;
            }
        }
    }
    function PopulatePatientDetail(arg) {
                $get('wrapper').className = '';
        $get('wrapper').disabled = false;
        $get('divProgress').style.display = 'none';
        if (arg == '') {
            // alert('No Patient Found');
            var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_18');
            if (userMsg == null)
                alert('No Patient Found');
            else
                alert(userMsg);
            return false;
        }
        var patientraw = new Array();
        patientraw = arg.split('^');
        var PatientHeader = patientraw[0].split(':');
        var PatientOther = patientraw[1].split('~');

        var tName = PatientHeader[0];
        var tNum = PatientHeader[1];
        var tvType = PatientHeader[2];
        var tVisitID = PatientOther[0];
        var tSex = PatientOther[1] == "M" ? "Male" : "Female";
        var tTITLECode = PatientOther[2];
        var tAge = PatientOther[3];
        var tAdd1 = PatientOther[4];
        var tClientID = PatientOther[5];
        var tRateID = PatientOther[6];
        var tPOAName = PatientOther[7];
        var IPNumber = PatientOther[8];
        var TPNumber = PatientOther[9];
        var Pid = PatientOther[10];
        var visitState = PatientOther[11];
        var DOB = PatientOther[12];
        var MartialStatus = PatientOther[13];
        var City = PatientOther[14];
        var Mobile = PatientOther[15];
        var IsCreditBill = PatientOther[16];

        var Nationality = PatientOther[18];
        var StateID = PatientOther[19];
        var CountryID = PatientOther[20];

        var VisitPurpose = PatientOther[21];
        var PreAuthAmount = PatientOther[22];
        var SmartCardNumber = PatientOther[26];
        var VisitSubType = PatientOther[27];


        document.getElementById('<%= txtPatientName.ClientID %>').value = tName;
        document.getElementById('<%= ddSalutation.ClientID %>').value = tTITLECode
        document.getElementById('<%= txtDOBNos.ClientID %>').value = tAge.split(' ')[0];
        document.getElementById('<%= ddlDOBDWMY.ClientID %>').value = tAge.split(' ')[1];
        document.getElementById('<%= lblVisitType.ClientID %>').innerHTML = tvType;
        document.getElementById('<%= txtAddress.ClientID %>').value = trim(tAdd1, ' ');
        document.getElementById('<%= lblIPNo.ClientID %>').innerHTML = '/' + IPNumber;
        document.getElementById('<%= tDOB.ClientID %>').value = DOB;
        document.getElementById('<%= txtCity.ClientID %>').value = City;
        document.getElementById('<%= ddMarital.ClientID %>').value = MartialStatus;
        document.getElementById('<%= txtMobile.ClientID %>').value = Mobile;
        document.getElementById('<%= ddlNationality.ClientID %>').value = Nationality;
        document.getElementById('<%=  ddCountry.ClientID %>').value = CountryID;
        document.getElementById('<%= ddState.ClientID %>').value = StateID;
        document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value = VisitPurpose;
        document.getElementById('<%= txtSCNo.ClientID %>').value = SmartCardNumber;
        document.getElementById('<%= hdnVisitSubTypeID.ClientID %>').value = VisitSubType;
        document.getElementById('<%= txtSCNo.ClientID %>').disabled = true;
        if (VisitPurpose != 0) {
            document.getElementById('<%= dPurpose.ClientID %>').value = VisitPurpose;
        }

        document.getElementById('<%= lblPatientNo.ClientID %>').innerHTML = tNum;
        var tempPhone = trim(TPNumber, ' ');
        if (tempPhone.length = 1) {
            tempPhone = trim(TPNumber, ',');
        }
        document.getElementById('<%= txtPhone.ClientID %>').value = tempPhone;
        //            document.getElementById('<%= ddlVisitDetails.ClientID %>').value =


        document.getElementById('<%= hdnPatientID.ClientID %>').value = Pid;
        document.getElementById('<%= ddlSex.ClientID %>').value = PatientOther[1];
        document.getElementById('<%= hdnVisitID.ClientID %>').value = tVisitID;

        var dhelp = document.getElementById('<%= dvHelp.ClientID %>');
        dhelp.innerHTML = '';

        document.getElementById('<%= hdnVisitDetails.ClientID %>').value = tPOAName + "~" + tVisitID;
        getAdvanceDetails();




        DeleteTable();
        onchangeName();
        GetCurrencyValues();
        SurgeryGetCurrencyValues();
        ChangePatientVisit();
        SetVisitDetails();
    }
    function CheckPatientName() {
        var isTrue = false;
        if (document.getElementById('<%= rdoOP.ClientID %>').checked) {
            isTrue = true;
        }
        if (document.getElementById('<%= rdoIP.ClientID %>').checked) {
            isTrue = true;
        }
        if (document.getElementById('<%= rdoDayCare.ClientID %>').checked) {
            isTrue = true;
        }
        if (isTrue) {
            if (document.getElementById('<%= txtPatientName.ClientID %>').value.trim() == "") {
                // alert("Enter The Patient Name");
                var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_3');
                if (userMsg == null)
                    alert('Enter The Patient Name');
                else
                    alert(userMsg);
                document.getElementById('<%= txtPatientName.ClientID %>').focus();
                return false;
            }
        }

    }

    function ProcessCallBackError(arg) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\QuickPatientReg.ascx_19');
        if (userMsg == null) {
            alert('There has been a problem in processing the smart card');
        }
        else {
            alert(userMsg);
            return false;
        }

    }



    function LoadPatientDetail() {

        //        document.getElementById('<%= tdTop.ClientID %>').disabled = true;
         
        //        document.getElementById('<%= rdoOP.ClientID %>').disabled = true;
        //        document.getElementById('<%= ddSalutation.ClientID %>').disabled = true;
        //        document.getElementById('<%= txtPatientName.ClientID %>').disabled = true;
        fn_SetSearchType(1)
        document.getElementById('<%= rdoOP.ClientID %>').checked = true;
        document.getElementById('<%= hdnRedirectFlag.ClientID %>').value = "Y";
        SetVisitTypePros('OP');
        
       
       
        isPatientDetails = document.getElementById('<%=hdnLoadPatientDetails.ClientID %>').value;
        var IsCreditBill = isPatientDetails.split('~')[16];
        var RefphyId = isPatientDetails.split('~')[30];
        var ReferralType = isPatientDetails.split('~')[31];

        var ISSurgeryPatient = isPatientDetails.split('~')[33];
        var ClientName = isPatientDetails.split('~')[36];

        var tName = isPatientDetails.split('~')[23];
        var tNum = isPatientDetails.split('~')[24];
        var tvType = isPatientDetails.split('~')[25];
        var tVisitID = isPatientDetails.split('~')[0];
        var tSex = isPatientDetails.split('~')[1] == "M" ? "Male" : "Female";
        var tTITLECode = isPatientDetails.split('~')[2];
        var tAge = isPatientDetails.split('~')[3];
        var tAdd1 = isPatientDetails.split('~')[4];

        var tPOAName = isPatientDetails.split('~')[7];
        var IPNumber = isPatientDetails.split('~')[8];
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 begins...
        // var TPNumber = isPatientDetails.split('~')[9];
        var TPNumber = '';
//        if (isPatientDetails.split('~')[15].search(',') != -1)
        //            TPNumber = isPatientDetails.split('~')[15].split(',')[1];
        TPNumber = isPatientDetails.split('~')[9];
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 ends...
        var Pid = isPatientDetails.split('~')[10];
        var visitState = isPatientDetails.split('~')[11];
        var DOB = isPatientDetails.split('~')[12];
        var MartialStatus = isPatientDetails.split('~')[13];
        var City = isPatientDetails.split('~')[14];
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 begins...
        // var Mobile = isPatientDetails.split('~')[15];
        var Mobile = isPatientDetails.split('~')[15].split(',')[0];
        // Code modified by Vijay TV to fix Bugtracker Issue ID 850 ends...


        var Nationality = isPatientDetails.split('~')[18];
        var StateID = isPatientDetails.split('~')[19];
        var CountryID = isPatientDetails.split('~')[20];


        var VisitPurpose = isPatientDetails.split('~')[21];

        var SmartCardNumber = isPatientDetails.split('~')[26];
        var VisitSubType = isPatientDetails.split('~')[27];




        document.getElementById('<%= txtPatientName.ClientID %>').value = tName;
        document.getElementById('<%= ddSalutation.ClientID %>').value = tTITLECode
        document.getElementById('<%= txtDOBNos.ClientID %>').value = tAge.split(' ')[0];
        document.getElementById('<%= ddlDOBDWMY.ClientID %>').value = tAge.split(' ')[1];
        document.getElementById('<%= lblVisitType.ClientID %>').innerHTML = tvType;
        document.getElementById('<%= txtAddress.ClientID %>').value = trim(tAdd1, ' ');
        document.getElementById('<%= lblIPNo.ClientID %>').innerHTML = '/' + IPNumber;
        document.getElementById('<%= tDOB.ClientID %>').value = DOB;
        document.getElementById('<%= txtCity.ClientID %>').value = City;
        document.getElementById('<%= ddMarital.ClientID %>').value = MartialStatus;
        document.getElementById('<%= txtMobile.ClientID %>').value = Mobile;
        document.getElementById('<%= ddlNationality.ClientID %>').value = Nationality;
        document.getElementById('<%=  ddCountry.ClientID %>').value = CountryID;
        document.getElementById('<%= ddState.ClientID %>').value = StateID;
        document.getElementById('<%= hdnOldVisitPurposeID.ClientID %>').value = VisitPurpose;
        
        document.getElementById('<%= txtSCNo.ClientID %>').value = SmartCardNumber;
        document.getElementById('<%= txtSCNo.ClientID %>').disabled = true;

        if (VisitPurpose != 0) {
            document.getElementById('<%= dPurpose.ClientID %>').value = VisitPurpose;
        }
        document.getElementById('QPR_dPurpose').value = '1';
        document.getElementById('<%= lblPatientNo.ClientID %>').innerHTML = tNum;
        document.getElementById('<%= txtPhone.ClientID %>').value = TPNumber;

        if (IPNumber != 0)
            document.getElementById('<%=hdnPatientNumber.ClientID %>').value = IPNumber;
        else
            document.getElementById('<%=hdnPatientNumber.ClientID %>').value = tNum;
        document.getElementById('<%= hdnPatientID.ClientID %>').value = Pid;
        document.getElementById('<%= ddlSex.ClientID %>').value = isPatientDetails.split('~')[1];
        //document.getElementById('<%= hdnVisitID.ClientID %>').value = tVisitID;
        document.getElementById('<%= hdnVisitSubTypeID.ClientID %>').value = VisitSubType;
        var dhelp = document.getElementById('<%= dvHelp.ClientID %>');
        dhelp.innerHTML = '';
        fn_disablePatientdemographics();
    }
    function fn_SetSearchType(obj) {
        document.getElementById('<%= rdoName.ClientID %>').checked = true;
        document.getElementById('<%= rdoOP.ClientID %>').checked = false;
        document.getElementById('<%= rdoIP.ClientID %>').checked = false;
        document.getElementById('<%=rdoDayCare.ClientID %>').checked = false;
        document.getElementById('<%=hdnSearchType.ClientID %>').value = obj;
        var Pid = document.getElementById('<%= hdnPatientID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnPatientID.ClientID %>').value;
        if (Number(Pid) <= 0) {
            document.getElementById('<%=txtPatientName.ClientID %>').value = '';
        }

    }
    function fn_disablePatientdemographics() {
        document.getElementById('<%= rdoName.ClientID %>').disabled = true;
        document.getElementById('<%= rdoNumber.ClientID %>').disabled = true;
        document.getElementById('<%= rdoPhone.ClientID %>').disabled = true;
        document.getElementById('<%= rdoOP.ClientID %>').disabled = true;
        document.getElementById('<%= rdoIP.ClientID %>').disabled = true;
        document.getElementById('<%= rdoDayCare.ClientID%>').disabled = true;
        document.getElementById('<%=dPurpose.ClientID%>').disabled = false;
        document.getElementById("<%=txtSCNo.ClientID%>").disabled = true;
        document.getElementById("<%=ddlSelectOnOption.ClientID%>").disabled = true;
        document.getElementById("<%=btnSmartDummy.ClientID%>").disabled = true;
        document.getElementById("<%=btnReset.ClientID%>").disabled = false;
        document.getElementById("<%=ddSalutation.ClientID%>").disabled = true;
        document.getElementById("<%=txtPatientName.ClientID%>").disabled = true;
        document.getElementById("<%=ddlVisitDetails.ClientID%>").disabled = true;
        document.getElementById("<%=tDOB.ClientID%>").disabled = true;
        document.getElementById("<%=ImgBntCalc.ClientID%>").disabled = true;
        document.getElementById("<%=txtDOBNos.ClientID%>").disabled = true;
        document.getElementById("<%=ddlDOBDWMY.ClientID%>").disabled = true;
        document.getElementById("<%=txtUsedSittings.ClientID%>").disabled = true;
        document.getElementById("<%=txtCity.ClientID%>").disabled = true;
        document.getElementById("<%=txtPhone.ClientID%>").disabled = true;
        document.getElementById("<%=txtMobile.ClientID%>").disabled = true;
        document.getElementById("<%=ddlNationality.ClientID%>").disabled = true;
        document.getElementById("<%=ddCountry.ClientID%>").disabled = true;
        document.getElementById("<%=ddState.ClientID%>").disabled = true;
        document.getElementById("<%=ddlSex.ClientID%>").disabled = true;
        document.getElementById("<%=txtAddress.ClientID%>").disabled = true;
        document.getElementById("<%=ddMarital.ClientID%>").disabled = true;

    }
    $(function() {
        if (document.getElementById('<%= hdnLoadPatientData.ClientID %>').value == 1) {
            LoadPatientDetail();

        }
    });
    document.getElementById('<%= rdoName.ClientID %>').checked = true;

    function GetPatientDetails() {
        var PatientDetails = "";
        var ddlsat = document.getElementById('<%=ddSalutation.ClientID %>');
        var GetSat = ddlsat.options[ddlsat.selectedIndex].innerHTML;
        var PatientName = document.getElementById('<%=txtPatientName.ClientID %>').value;
        var PatientId = document.getElementById('<%=hdnPatientID.ClientID %>').value;
        var PatientAge = document.getElementById('<%=txtDOBNos.ClientID %>').value;
        var PatientAgeDesc = document.getElementById('<%=ddlDOBDWMY.ClientID %>').value;
        if (PatientId == "") {
            PatientId = 0;
        }
        var VisitPurposeId = document.getElementById('<%=dPurpose.ClientID %>').value;
        var VisitPurposeValue = document.getElementById('<%=hdnVisitPurposeText.ClientID %>').value;
        PatientDetails = PatientId + '~' + GetSat + PatientName + '~' + PatientAge + ' ' + PatientAgeDesc + '~' + VisitPurposeId + '~' + VisitPurposeValue;
        return PatientDetails;
    }
</script>

