<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IPClientTpaInsurance.ascx.cs"
    Inherits="CommonControls_IPClientTpaInsurance" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table style="border-color: Red" runat="server" id="tbVisitClient" class="w-100p">
    <tr id="trchkcredit" style="display: none;">
        <td>
            <asp:CheckBox ID="chkcredit" runat="server" Text="Is CreditBill" meta:resourcekey="chkcreditResource3" />
        </td>
        <td>
            <asp:Label ID="lblEligibleRoomType" runat="server" Text="Eligible Room Type" meta:resourcekey="lblEligibleRoomTypeResource3"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlRoomType" runat="server" CssClass="bilddltb">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Label ID="Label1" runat="server" Text="Eligible Client Name" meta:resourcekey="lblEligibleClientNamResource3"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtEligibleClientName" Width="150px" runat="server" CssClass="biltextb"
                autoComplete="off" meta:resourcekey="txtEligibleClientNameResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtEligibleClientName"
                EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" OnClientItemSelected="ClientSelected1">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnEligibleClientID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnRateDetails" runat="server" Value="" />
        </td>
        <td>
            <asp:Label ID="lblEligibleRateType" runat="server" Text="Eligible Rate Type" meta:resourcekey="lblEligibleRateTypeResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlEligibleRateType" runat="server" CssClass="bilddltb" onblur="javascript:return getEligibleRateTypeID();">
            </asp:DropDownList>
            <asp:HiddenField ID="hdnEligibleRateTypeID" runat="server" Value="0" />
        </td>
    </tr>
    <tr id="trSelectClientName" style="display: none;">
        <td>
            <asp:Label ID="Rs_SelectClientName" runat="server" Text="Client Name" meta:resourcekey="Rs_SelectClientNameResource1"></asp:Label>
        </td>
        <td class="a-left">
            <asp:TextBox ID="txtClient" onKeyDown="javascript:clearClientControlsValue('Y');"
                Width="150px" runat="server" CssClass="biltextb" meta:resourcekey="txtClientResource2"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                EnableCaching="False" FirstRowSelected="False" CompletionInterval="1" MinimumPrefixLength="1"
                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" OnClientItemSelected="ClientSelected2">
            </ajc:AutoCompleteExtender>
        </td>
        <td>
            <asp:Label ID="Rs_SelectRateType" runat="server" Text="Select RateType" meta:resourcekey="Rs_SelectRateTypeResource1"></asp:Label>
        </td>
        <td class="a-left">
            <asp:DropDownList ID="ddlRateType" CssClass="bilddltb" runat="server" meta:resourcekey="ddlRateTypeResource2">
            </asp:DropDownList>
        </td>
        <td>
            <asp:CheckBox ID="chkIsAllMedical" Text="All Are Medical Items ?" runat="server"
                Enabled="False" meta:resourcekey="chkIsAllMedicalResource3" />
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblCopercent" runat="server" Text="Co-Payment Type" meta:resourcekey="lblCopercentResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList runat="server" ID="ddlCopaymentType" CssClass="bilddltb" onchange="SetFocus();">
            </asp:DropDownList>
            <span style="color: Red; font-weight: bold; font-size: 16px; vertical-align: middle;">
                *</span>
            <asp:TextBox ID="txtCoperent" runat="server" Text="0.00" Width="75px" Style="text-align: right;"
                onblur="getPrecision(this);return doValidatePercent(this);"    onkeypress="return ValidateOnlyNumeric(this);"  
                MaxLength="10" CssClass="biltextb" meta:resourcekey="txtCoperentResource3"></asp:TextBox><span
                    style="color: Red; font-weight: bold; font-size: 16px; vertical-align: middle;">*</span>
        </td>
        <td>
            <asp:Label runat="server" ID="txtCopaymentLogin" Text="Co-Payment Logic" meta:resourcekey="txtCopaymentLoginResource1"></asp:Label>
        </td>
        <td class="a-left">
            <asp:DropDownList runat="server" ID="ddlpaymentLogic" CssClass="bilddltb" meta:resourcekey="ddlpaymentLogicResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Label ID="lblClaimAmount" runat="server" Text="Co-Payment to be deducted from"
                meta:resourcekey="lblClaimAmountResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlClaimAmount" runat="server" CssClass="bilddltb" meta:resourcekey="ddlClaimAmountResource3">
            </asp:DropDownList>
        </td>
    </tr>
    <tr id="trlblPolicyNo" style="display: none">
        <td>
            <asp:Label ID="lblPolicyNo" runat="server" Text="Policy No" meta:resourcekey="lblPolicyNo1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtPolicyNo" runat="server" CssClass="biltextb" Width="150px" meta:resourcekey="txtPolicyNoResource1"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lblPolicyFrom" runat="server" Text="Policy Start Date" meta:resourcekey="lblPolicyFrom1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtPolicyFrom" runat="server" CssClass="biltextb" Width="150px"
                meta:resourcekey="txtPolicyFromResource1"></asp:TextBox>
            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtPolicyFrom"
                PopupButtonID="ImgBntCalc" Enabled="True" />
            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtPolicyFrom"
                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                CultureTimePlaceholder="" Enabled="True" />
            <asp:ImageButton Height="13px" ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
        </td>
        <td>
            <asp:Label ID="lblPolicyTo" runat="server" Text="Policy End Date" meta:resourcekey="lblPolicyTo1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtPolicyTo" runat="server" CssClass="biltextb" Width="150px" meta:resourcekey="txtPolicyToResource1"></asp:TextBox>
            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtPolicyTo"
                PopupButtonID="ImgPolicyTo" Enabled="True" />
            <ajc:MaskedEditExtender ID="MaskPolicyTo" runat="server" TargetControlID="txtPolicyTo"
                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                CultureTimePlaceholder="" Enabled="True" />
            <asp:ImageButton Height="13px" ID="ImgPolicyTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                CausesValidation="False" meta:resourcekey="ImgPolicyToResource1" />
        </td>
    </tr>
    <tr id="trPreAuthAmount" style="display: none">
        <td class="a-left">
            <asp:Label ID="PreAuthAmount" Text="Pre-Auth Type" runat="server" meta:resourcekey="PreAuthAmountResource11" />
        </td>
        <td class="a-left">
            <asp:DropDownList runat="server" ID="ddlPreAuthType" CssClass="bilddltb" onchange="SetPreAuthu();">
            </asp:DropDownList>
            <asp:TextBox ID="txtPreAuthPerent" runat="server" Text="0.00" Width="50px" Style="text-align: right;"
                onblur="getPrecision(this);return doValidatePercent(this);"    onkeypress="return ValidateOnlyNumeric(this);"  
                MaxLength="2" CssClass="biltextb" meta:resourcekey="txtCoperentResource3"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="Label2" Text="Pre-AuthAmount" runat="server" meta:resourcekey="PreAuthAmountResource1" />
        </td>
        <td class="a-left">
            <asp:TextBox onblur="getPrecision(this);" ID="txtAuthamount" Style="text-align: right;"
                runat="server"    onkeypress="return ValidateOnlyNumeric(this);"   MaxLength="15" Text="0.00"
                Width="75px" CssClass="biltextb" meta:resourcekey="txtAuthamountResource3"></asp:TextBox>
        </td>
        <td class="a-left">
            <asp:Label ID="lblPreAuthNumber" runat="server" CssClass="biltextb" Text="Pre-Auth Approval Number"
                meta:resourcekey="lblPreAuthNumberResource1"></asp:Label>
        </td>
        <td class="a-left">
            <asp:TextBox ID="txtPreAuthApprovalNumber" runat="server" CssClass="biltextb" Width="75px"
                meta:resourcekey="txtPreAuthApprovalNumberResource3"></asp:TextBox>
        </td>
        <td class="a-left">
            <asp:Button ID="btnAddClient" OnClientClick="javascript:return CheckClientList();"
                Style="display: none;" runat="server" Text="Add" CssClass="btn" Width="70px"
                meta:resourcekey="btnAddClientResource1" />
            <%-- </td>
        <td>--%>
            <asp:Button ID="btnClear" OnClientClick="javascript:return ClearClientValues();"
                runat="server" Text="Clear client details" CssClass="btn" Width="120px" meta:resourcekey="btnClearResource1" />
        </td>
    </tr>
</table>
<table style="border-color: Red" class="w-100p">
    <tr>
        <td>
            <table id="tblClientDetails" border="1" cellpadding="2" class="dataheaderInvCtrl a-left font11 w-100p">
            </table>
        </td>
    </tr>
</table>

<script type="text/javascript" language="javascript">

    var pVisti_Type = "";
    var ClientCorpID;
    var ClientCorpName;
    var ClientCorpCode;
    var ClientCorpRateID;
    var ClientCorpClientID;
    var ClientCorpMappingID;
    var Ismappeditem = "N";
    var IsDiscount = "N";
    var IsClientHaveAttributes = "N";
    var IsAllAreMedical = 'N';

    function fn_SetVisitType(visitType) {
        pVisti_Type = visitType;
        document.getElementById('<%= btnClear.ClientID %>').style.display = 'none';

        if ("<%=IsBilling %>" == "Y") {

            document.getElementById('<%= btnAddClient.ClientID %>').style.display = 'none';

        }
        if (pVisti_Type == "OP") {
            document.getElementById('<%= btnClear.ClientID %>').style.display = 'block';
            document.getElementById('<%= hdnSelectClientID.ClientID %>').value = 0;
            document.getElementById('<%= txtClient.ClientID %>').disabled = false;
            document.getElementById('<%= ddlRateType.ClientID %>').disabled = false;
            document.getElementById('<%= txtCoperent.ClientID %>').disabled = false;
            document.getElementById('<%= ddlpaymentLogic.ClientID %>').disabled = false;
            document.getElementById('<%= ddlClaimAmount.ClientID %>').disabled = false;
            document.getElementById('<%= txtAuthamount.ClientID %>').disabled = false;
            document.getElementById('<%= txtPreAuthApprovalNumber.ClientID %>').disabled = false;
            document.getElementById('<%= ddlCopaymentType.ClientID %>').disabled = false;


        }
        if (pVisti_Type == "IP") {

            document.getElementById('<%= hdnSelectClientID.ClientID %>').value = 0;
            document.getElementById('<%= txtClient.ClientID %>').disabled = true;
            document.getElementById('<%= ddlRateType.ClientID %>').disabled = true;
            document.getElementById('<%= txtCoperent.ClientID %>').disabled = true;
            document.getElementById('<%= ddlpaymentLogic.ClientID %>').disabled = true;
            document.getElementById('<%= ddlClaimAmount.ClientID %>').disabled = true;
            document.getElementById('<%= txtAuthamount.ClientID %>').disabled = true;
            document.getElementById('<%= txtPreAuthApprovalNumber.ClientID %>').disabled = true;
            document.getElementById('<%= ddlCopaymentType.ClientID %>').disabled = true;




        }
    }

    function ClientSelected2(source, eventArgs) {

        var list = eventArgs.get_value().split('^');
        var slist = eventArgs.get_value().split('###');
        setClientValues(slist);
        document.getElementById('<%= hdnRateValue.ClientID %>').value = '';
        document.getElementById('<%= hdnRateValue.ClientID %>').value = eventArgs.get_value() + '$';


    }

    function setClientValues(pList) {

        fn_bindRateType(pList, 'Add');
        var flist;
        if (pList.length > 0) {
            for (j = 0; j < pList.length - 1; j++) {
                flist = pList[j].split('^');
                if (flist != "") {
                    var rat = flist[4].split('~');
                    ClientCorpID = flist[0];
                    ClientCorpName = flist[2];
                    ClientCorpCode = flist[3];
                    ClientCorpRateID = rat[0];
                    ClientCorpClientID = flist[5];

                    ClientCorpMappingID = flist[6];
                    temp = flist[8];
                    Ismappeditem = flist[9];
                    IsDiscount = flist[10];
                    IsClientHaveAttributes = flist[18];
                    IsAllAreMedical = flist[19];
                }
            }
        }
        document.getElementById('<%= hdnIsMappedItem.ClientID %>').value = Ismappeditem;
        document.getElementById('<%= hdnIsDiscount.ClientID%>').value = IsDiscount;
        document.getElementById('<%= hdnClientID.ClientID %>').value = ClientCorpClientID;
        document.getElementById('<%= hdnClientName.ClientID%>').value = ClientCorpName;
        document.getElementById('<%= txtClient.ClientID%>').value = ClientCorpName;
        document.getElementById('<%= hdnClientCode.ClientID%>').value = ClientCorpCode;
        document.getElementById('<%= hdnClientRateID.ClientID%>').value = ClientCorpRateID;
        document.getElementById('<%= hdnClientMappingID.ClientID%>').value = ClientCorpMappingID;
        document.getElementById('<%= hdnClientattribExists.ClientID%>').value = IsClientHaveAttributes;

        if (IsAllAreMedical == 'Y') {
            document.getElementById('<%=chkIsAllMedical.ClientID %>').disabled = false;
            document.getElementById('<%=chkIsAllMedical.ClientID %>').checked = true;
            document.getElementById('<%=hdnIsAllMedical.ClientID %>').value = 'Y';
            document.getElementById('<%=chkIsAllMedical.ClientID %>').disabled = true;
        }
        else {
            document.getElementById('<%=chkIsAllMedical.ClientID %>').disabled = false;
            document.getElementById('<%=chkIsAllMedical.ClientID %>').checked = false;
            document.getElementById('<%=hdnIsAllMedical.ClientID %>').value = 'N';
            document.getElementById('<%=chkIsAllMedical.ClientID %>').disabled = true;
        }

        if (IsClientHaveAttributes.trim() == "Y") {
            PopUpAttributePage();
        }
        if (ClientCorpCode != "GENERAL")
            document.getElementById('<%= chkcredit.ClientID %>').checked = true;
        else
            document.getElementById('<%= chkcredit.ClientID %>').checked = false;

    }

    function PopUpAttributePage() {

        var pControl = document.getElementById('<%= hdnClientAttribValue.ClientID %>').id;
        var pClientID = document.getElementById('<%= hdnClientID.ClientID %>').value;
        var pVID = '<%= Request.QueryString["VID"] %>';
        var pID = '<%= Request.QueryString["PID"] %>';

        if (pVID == null || pVID == "") {
            pVID = pVID;
        }
        if (pID == null || pID == "") {
            pID = pID;
        }

        window.open("../InPatient/PopUpAttributePage.aspx?ClientID=" + pClientID + "&Con=" + pControl + "&IsPopup=Y&VID=" + pVID + "&PID=" + pID + "&type=CRP", 'POP', "height=400,width=590,scrollbars=no", true);
    }
    function CheckClientList() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vClinetName = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_01') == null ? "Please Select Client Name" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_01');
        var vRatecardName = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_02') == null ? "Please Select Ratecard Name" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_02');
        var vCoPaymentLogic = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_03') == null ? "Select Co-Payment Logic" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_03');
        var vCoPaymentDeductedFrom = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_04') == null ? "Select Co-Payment to be deducted from" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_04');

        var spaymentType = document.getElementById('<%= ddlCopaymentType.ClientID %>').selectedIndex;
        var spaymentLogic = document.getElementById('<%= ddlpaymentLogic.ClientID %>').selectedIndex;
        var sClaimAmount = document.getElementById('<%= ddlClaimAmount.ClientID %>').selectedIndex;
        var tlst = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");

        //        for (j = 0; j < tlst.length; j++) {
        //            if (tlst[j] != "" ) {
        //                s = tlst[j].split('~');
        //                if (s[0] == document.getElementById('<%= hdnClientID.ClientID %>').value && document.getElementById('<%= btnAddClient.ClientID %>').value != 'Update') {
        //                    alert("This client name already exist")
        //                    document.getElementById('<%= txtClient.ClientID %>').focus();
        //                    return false;
        //                    break;
        //                }
        //            }
        //        }
        if (document.getElementById('<%= hdnClientID.ClientID %>').value == "0") {
            //alert("Please Select Client Name");
            ValidationWindow(vClinetName, AlertType);
            return false;
        }
        else if (document.getElementById('<%= ddlRateType.ClientID %>').value == "0" || document.getElementById('<%= ddlRateType.ClientID %>').value == "") {
            //alert("Please Select Ratecard Name");
            ValidationWindow(vRatecardName, AlertType);
            return false;
        }
        //        else if (document.getElementById('<%= txtClient.ClientID %>').value == "" || spaymentType == 0) {
        //            alert("Select Co-Payment Type");
        //            document.getElementById('<%= ddlCopaymentType.ClientID %>').focus();
        //            return false;
        //        }
        else if (document.getElementById('<%= txtCoperent.ClientID %>').value >= 0 && spaymentType == 1 && spaymentLogic == 0) {
            //alert("Select Co-Payment Logic");
            ValidationWindow(vCoPaymentLogic, AlertType);
            document.getElementById('<%= ddlpaymentLogic.ClientID %>').focus();
            return false;

        }
        else if (document.getElementById('<%= txtCoperent.ClientID %>').value >= 0 && spaymentType == 1 && spaymentLogic > 0 && sClaimAmount == 0) {
            //alert("Select Co-Payment to be deducted from");
            ValidationWindow(vCoPaymentDeductedFrom, AlertType);
            document.getElementById('<%= ddlClaimAmount.ClientID %>').focus();
            return false;
        }
        else if (document.getElementById('<%= txtCoperent.ClientID %>').value >= 0 && spaymentType == 2 && sClaimAmount == 0) {
            //alert("Select Co-Payment to be deducted from");
            ValidationWindow(vCoPaymentDeductedFrom, AlertType);
            document.getElementById('<%= ddlClaimAmount.ClientID %>').focus();
            return false;
        }
        else {
            checkClientValue();
            return false;
        }

    }
    function setClientfocus() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vSelectClient = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_05') == null ? "Select Client" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_05');

        if (document.getElementById('<%= hdnSelectClientID.ClientID %>').value == "0" || document.getElementById('<%= hdnSelectClientID.ClientID %>').value == "") {
            //alert("Select Client");
            ValidationWindow(vSelectClient, AlertType);
            document.getElementById('<%= txtClient.ClientID %>').focus();
            return false;
        }
    }
    var isChoice = 0;




    function checkClientValue() {

        var vConfirmation = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_06') == null ? "Clicking 'Yes' will change all the previous bills of this visit to the new tariff; Clicking 'No' will cause the subsequent bills to have the new tariff. Click 'Cancel' if you do not want to change anything" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_06');

        var clientNewID = document.getElementById('<%= hdnClientID.ClientID %>').value;
        var clientoldID = document.getElementById('<%= hdnclientoldID.ClientID %>').value;
        if (document.getElementById('<%= btnAddClient.ClientID %>').value == 'Update') {

            document.getElementById('<%= btnAddClient.ClientID %>').style.display = "none";
            if (Number(document.getElementById('<%= hdnVisitClientID.ClientID %>').value) > 0) {
                var userMsg = "";
                userMsg = SListForApplicationMessages.Get('CommonControls\\IPClientTpaInsurance.ascx_3');
                if (userMsg == null) {
                    userMsg = vConfirmation;
                }
                if (clientNewID != clientoldID) {
                    vbMsg(userMsg, "");

                }
                else {
                    isChoice = 7
                }

                if (isChoice == "2") {
                    document.getElementById('<%= hdnRowEdit.ClientID %>').value = "";
                    document.getElementById('<%= btnAddClient.ClientID %>').value = "Add";
                    document.getElementById('<%= hdnClientChangedFlag.ClientID %>').value = "N";
                    //ClientValuesClear();
                    isChoice = 0;
                    return false;
                }
                else if (isChoice == "6") {
                    document.getElementById('<%= hdnClientChangedFlag.ClientID %>').value = "Y";
                    isChoice = 0;
                }
                else if (isChoice == "7") {
                    document.getElementById('<%= hdnClientChangedFlag.ClientID %>').value = "N";
                    isChoice = 0;
                }
            }
            sEditedData = document.getElementById('<%= hdnRowEdit.ClientID %>').value;

            //btnDelete(sEditedData);
            var a;
            var b = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");
            document.getElementById('<%= hdnClientvalues.ClientID %>').value = '';
            for (a = 0; a < b.length; a++) {
                if (b[a] != "") {
                    var y = b[a].split('~');
                    if (y[13] != sEditedData.split('~')[13]) {
                        document.getElementById('<%= hdnClientvalues.ClientID %>').value += b[a] + "^";
                    }
                }
            }

            document.getElementById('<%= hdnRowEdit.ClientID %>').value = "";
            document.getElementById('<%= btnAddClient.ClientID %>').value = "Add";

        }
        var pCID = 0
        var pCName = "";
        var pRateType = "";
        var pMedicalItems = "";
        var pCopayment = "";
        var pCoPaymentID = 0;
        var pDedeductedID = 0;
        var pPreAuthamt = "";
        var pPreAuthno = "";
        var pClientAttrib = "";
        var pRateID = 0;
        var pCoPaymentLogic = "";
        var pDededucted = "";
        var pVisitClientID = 0;
        var ClientCode = "";
        var PolicyNo;
        var PolicyFormDate;
        var PolicyTo;
        var CopaymentType = "";


        document.getElementById('<%= hdnValueStatus.ClientID %>').value = "Y";

        pVisitClientID = document.getElementById('<%= hdnVisitClientID.ClientID %>').value;
        pCID = document.getElementById('<%= hdnClientID.ClientID %>').value;
        pCName = document.getElementById('<%= txtClient.ClientID %>').value;
        pRateID = document.getElementById('<%= ddlRateType.ClientID %>').value;
        if (document.getElementById('<%= chkIsAllMedical.ClientID %>').checked == true)
            pMedicalItems = "Y";
        else
            pMedicalItems = "N";
        pCopayment = document.getElementById('<%= txtCoperent.ClientID %>').value;
        pCoPaymentID = document.getElementById('<%= ddlpaymentLogic.ClientID %>').value;
        pDedeductedID = document.getElementById('<%= ddlClaimAmount.ClientID %>').value;
        pPreAuthamt = document.getElementById('<%= txtAuthamount.ClientID %>').value;
        pPreAuthno = document.getElementById('<%= txtPreAuthApprovalNumber.ClientID %>').value;
        pClientAttrib = document.getElementById('<%= hdnClientAttribValue.ClientID %>').value;
        pRateType = document.getElementById('<%= ddlRateType.ClientID %>').options[document.getElementById('<%= ddlRateType.ClientID %>').selectedIndex].text;
        pCoPaymentLogic = document.getElementById('<%= ddlpaymentLogic.ClientID %>').options[document.getElementById('<%= ddlpaymentLogic.ClientID %>').selectedIndex].text;
        pDededucted = document.getElementById('<%= ddlClaimAmount.ClientID %>').options[document.getElementById('<%= ddlClaimAmount.ClientID %>').selectedIndex].text;
        ClientCode = document.getElementById('<%= hdnClientCode.ClientID%>').value;
        PolicyNo = document.getElementById('<%= txtPolicyNo.ClientID%>').value;
        PolicyFormDate = document.getElementById('<%= txtPolicyFrom.ClientID%>').value;
        PolicyTo = document.getElementById('<%= txtPolicyTo.ClientID%>').value;



        // var Combovalue = document.getElementById('<%= ddlCopaymentType.ClientID%>').selectedIndex;
        var Combovalue = '';
        // if (Combovalue > 0) {
        // var spaymentType = document.getElementById('<%= ddlCopaymentType.ClientID %>');
        // var sPaymentName = spaymentType.options[spaymentType.selectedIndex].innerHTML;
        var sPaymentName = document.getElementById('<%= ddlCopaymentType.ClientID %>').value;

        CopaymentType = sPaymentName//CopaymentType = document.getElementById('ddlCopaymentType.ClientID').options[document.getElementById('ddlCopaymentType.ClientID').selectedIndex].text;
        //}
        // else {
        //     CopaymentType = Combovalue; //CopaymentType =  document.getElementById('uctlClientTpa_ddlCopaymentType').selectedIndex
        // }

        document.getElementById('<%= hdnClientvalues.ClientID %>').value += pCID + "~" + pCName + "~" + pRateType + "~" + pRateID + "~" + pMedicalItems + "~" + pCopayment +
                        "~" + pCoPaymentLogic + "~" + pCoPaymentID + "~" + pDededucted + "~" + pDedeductedID + "~" + pPreAuthamt + "~" + pPreAuthno + "~" + pClientAttrib + "~" + pVisitClientID + "~" + ClientCode +
                        "~" + PolicyNo + "~" + PolicyFormDate + "~" + PolicyTo + "~" + CopaymentType + "^";

        SetEligibleClientvalue();

        fu_Tblist();


        //  ClientValuesClear();
        return false;


    }


    function fu_Tblist() {

        while (count = document.getElementById('tblClientDetails').rows.length) {

            for (var j = 0; j < document.getElementById('tblClientDetails').rows.length; j++) {
                document.getElementById('tblClientDetails').deleteRow(j);
            }
        }

        var IsClientNotGeneral = 0;
        var Headrow = document.getElementById('tblClientDetails').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);
        var cell7 = Headrow.insertCell(6);
        var cell8 = Headrow.insertCell(7);
        var cell9 = Headrow.insertCell(8);
        var cell10 = Headrow.insertCell(9);
        var cell11 = Headrow.insertCell(10);
        var cell12 = Headrow.insertCell(11);
        var cell13 = Headrow.insertCell(12);


        //        cell1.innerHTML = "Client Name";
        //        cell2.innerHTML = "RateType";
        //        cell3.innerHTML = "Copayment(%) ";
        //        cell4.innerHTML = "Co-Payment Logic";
        //        cell5.innerHTML = "Co-Payment to be deducted from";
        //        cell6.innerHTML = "Pre-AuthAmount";
        //        cell7.innerHTML = "Pre-Auth Approval Number";
        //        cell8.innerHTML = "All Are Medical Items?";
        //        cell9.innerHTML = "Action";
        document.getElementById('<%= hdnCreditClientPatient.ClientID %>').value = 'N';

        cell1.innerHTML = SHeaderList.ClientName;
        cell2.innerHTML = SHeaderList.RateType;
        cell3.innerHTML = SHeaderList.Copayment;
        cell4.innerHTML = SHeaderList.PaymentLogic;
        cell5.innerHTML = SHeaderList.ClaminLogin;
        cell6.innerHTML = SHeaderList.AuthAmount;
        cell7.innerHTML = SHeaderList.AuthApprovalNumber;
        cell8.innerHTML = SHeaderList.AllAreMedicalItems;
        cell9.innerHTML = SHeaderList.PolicyNo;
        cell10.innerHTML = SHeaderList.PolicyFrom;
        cell11.innerHTML = SHeaderList.PolicyTo;
        cell12.innerHTML = SHeaderList.PaymentType;
        cell13.innerHTML = SHeaderList.Action;
        // cell12.s
        cell12.style.display = 'none';

        document.getElementById('<%= hdnCreditClientPatient.ClientID %>').value = 'N';
        var x = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");
        var count = x.length;
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                y = x[i].split('~');

                var row = document.getElementById('tblClientDetails').insertRow(1);
                row.style.height = "13px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);
                var cell8 = row.insertCell(7);
                var cell9 = row.insertCell(8);
                var cell10 = row.insertCell(9);
                var cell11 = row.insertCell(10);
                var cell12 = row.insertCell(11);
                var cell13 = row.insertCell(12);
                cell12.style.display = 'none';
                cell1.innerHTML = y[1];
                cell2.innerHTML = y[2];
                cell3.innerHTML = y[5];
                cell4.innerHTML = y[7] == -1 ? '--' : y[6];
                cell5.innerHTML = y[9] == -1 ? '--' : y[8];
                cell6.innerHTML = y[10];
                cell7.innerHTML = y[11];
                cell8.innerHTML = y[4];
                cell9.innerHTML = y[15];
                cell10.innerHTML = y[16];
                cell11.innerHTML = y[17];
                cell12.innerHTML = y[18];

                if (y[13] == 0) {
                    if ("<%=IsBilling %>" == "Y") {
                        cell13.innerHTML = "<input name='" + x[i] + "' onclick='btnEdit_OnClick(name);' value = 'Select' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";
                    }
                    else {
                        cell13.innerHTML = "<input name='" + x[i] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;'  />";
                    }
                }
                else {
                    var Aci = "<%=IsBilling %>" == "Y" ? 'Select' : 'Edit';
                    cell13.innerHTML = "<input name='" + x[i] + "' onclick='btnEdit_OnClick(name);' value = '" + Aci + "' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                               "<input name='" + x[i] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer;display:none;'  />";
                }
                if (y[14] != "GENERAL" && y[14] != "0")
                    IsClientNotGeneral = 1;

                document.getElementById('<%= hdnCreditClientPatient.ClientID %>').value = 'Y';

            }


        }



        if (IsClientNotGeneral == 1)
            document.getElementById('<%= chkcredit.ClientID %>').checked = true;
        else
            document.getElementById('<%= chkcredit.ClientID %>').checked = false;

        // Check_ClientValidation();



    }
    function GetRateCardForClientID(ClientData) {

        var y = ClientData.split('~');
        ClientID = y[0];
        document.getElementById('<%= hdnclientoldID.ClientID %>').value = ClientID;
        var PlistValue = '';
        if (document.getElementById('<%= hdnRateValue.ClientID %>').value != '') {
            var CheckValue = document.getElementById('<%= hdnRateValue.ClientID %>').value.split('$');

            for (var a = 0; a < CheckValue.length; a++) {
                var SecondValue = CheckValue[a].split('###');
                for (var b = 0; b < SecondValue.length; b++) {
                    var GetValue = SecondValue[b].split('^');
                    if (GetValue[5] == ClientID) {
                        PlistValue = SecondValue;
                        break;
                    }

                }
                if (PlistValue != '') {
                    break;
                }
            }
        }

        if (PlistValue != '') {
            fn_bindRateType(SecondValue, 'Add');

            document.getElementById('<%= hdnClientID.ClientID %>').value = y[0];
            document.getElementById('<%= hdnSelectClientID.ClientID %>').value = y[0]
            document.getElementById('<%= txtClient.ClientID %>').value = y[1];
            document.getElementById('<%= ddlRateType.ClientID %>').value = y[3];
            if (y[4] == "Y") {
                document.getElementById('<%= chkIsAllMedical.ClientID %>').checked = y[4];
            }
            document.getElementById('<%= txtCoperent.ClientID %>').value = y[5];
            if (y[18] == "Value") {
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = true;

            }
            else {
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = false;
                document.getElementById('<%= ddlpaymentLogic.ClientID %>').value = y[7];
            }
            document.getElementById('<%= ddlClaimAmount.ClientID %>').value = y[9];
            document.getElementById('<%= txtAuthamount.ClientID %>').value = y[10];
            document.getElementById('<%= txtPreAuthApprovalNumber.ClientID %>').value = y[11];
            document.getElementById('<%= hdnClientAttribValue.ClientID %>').value = y[12];
            document.getElementById('<%= hdnVisitClientID.ClientID %>').value = y[13];
            document.getElementById('<%= hdnClientCode.ClientID%>').value = y[14];
            document.getElementById('<%= txtPolicyNo.ClientID %>').value = y[15];
            document.getElementById('<%= txtPolicyFrom.ClientID %>').value = y[16];
            document.getElementById('<%= txtPolicyTo.ClientID %>').value = y[17];
            if (y[18] == '') {
                document.getElementById('<%= ddlCopaymentType.ClientID %>').selectedIndex = 0;
            }
            else {
                document.getElementById('<%= ddlCopaymentType.ClientID %>').value = y[18];
            }

            document.getElementById('<%= btnAddClient.ClientID %>').value = "Update";
            document.getElementById('<%= btnAddClient.ClientID %>').style.display = "block";
            document.getElementById('<%= hdnRowEdit.ClientID %>').value = ClientData;
        }
        else {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetRateTypeMaster",
                data: "{ 'OrgID': '" + ClientID + "','OrgType': 'Client'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    if (data.d.length >= 1) {

                        fn_bindRateType(data.d, 'Edit');

                        document.getElementById('<%= hdnClientID.ClientID %>').value = y[0];
                        document.getElementById('<%= hdnSelectClientID.ClientID %>').value = y[0]
                        document.getElementById('<%= txtClient.ClientID %>').value = y[1];
                        document.getElementById('<%= ddlRateType.ClientID %>').value = y[3];
                        if (y[4] == "Y") {
                            document.getElementById('<%= chkIsAllMedical.ClientID %>').checked = y[4];
                        }
                        document.getElementById('<%= txtCoperent.ClientID %>').value = y[5];
                        if (y[18] == "Value") {
                            document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = true;

                        }
                        else {
                            document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = false;
                            document.getElementById('<%= ddlpaymentLogic.ClientID %>').value = y[7];
                        }
                        //document.getElementById('<%= ddlpaymentLogic.ClientID %>').value = y[7];
                        document.getElementById('<%= ddlClaimAmount.ClientID %>').value = y[9];
                        document.getElementById('<%= txtAuthamount.ClientID %>').value = y[10];
                        document.getElementById('<%= txtPreAuthApprovalNumber.ClientID %>').value = y[11];
                        document.getElementById('<%= hdnClientAttribValue.ClientID %>').value = y[12];
                        document.getElementById('<%= hdnVisitClientID.ClientID %>').value = y[13];
                        document.getElementById('<%= hdnClientCode.ClientID%>').value = y[14];
                        document.getElementById('<%= txtPolicyNo.ClientID %>').value = y[15];
                        document.getElementById('<%= txtPolicyFrom.ClientID %>').value = y[16];
                        document.getElementById('<%= txtPolicyTo.ClientID %>').value = y[17];
                        if (y[18] == '') {
                            document.getElementById('<%= ddlCopaymentType.ClientID %>').selectedIndex = 0;
                        }
                        else {
                            document.getElementById('<%= ddlCopaymentType.ClientID %>').value = y[18];
                        }

                        document.getElementById('<%= btnAddClient.ClientID %>').value = "Update";
                        document.getElementById('<%= btnAddClient.ClientID %>').style.display = "block";
                        document.getElementById('<%= hdnRowEdit.ClientID %>').value = ClientData;

                        // Check_ClientValidation();
                    }
                },
                failure: function(msg) {
                    alert(msg);
                }
            });
        }

    }

    function btnEdit_OnClick(sEditedData) {

        GetRateCardForClientID(sEditedData);


    }

    function ClearClientValues() {
        document.getElementById('<%= hdnClientID.ClientID %>').value = 0;

        ClientValuesClear();
        document.getElementById('<%= hdnClientvalues.ClientID %>').value = "";
        fu_Tblist();

        document.getElementById('<%= hdnEligibleClientID.ClientID %>').value = '0';
        document.getElementById('<%= hdnEligibleRateTypeID.ClientID %>').value = '0';
        document.getElementById('<%= txtEligibleClientName.ClientID %>').value = '';
        document.getElementById('<%= ddlEligibleRateType.ClientID %>').value = '0';
        document.getElementById('<%= ddlCopaymentType.ClientID %>').value = '0';
        fn_DisableClientCntorl(false);
        return false;
    }

    function ClientValuesClear() {
        if (document.getElementById('<%= btnAddClient.ClientID %>').style.display != "none") {
            document.getElementById('<%= hdnClientID.ClientID %>').value = 0;
        }
        document.getElementById('<%= hdnSelectClientID.ClientID %>').value = 0;
        document.getElementById('<%= txtClient.ClientID %>').value = "";
        document.getElementById('<%= chkIsAllMedical.ClientID %>').checked = false;
        document.getElementById('<%= txtCoperent.ClientID %>').value = 0;
        document.getElementById('<%= txtAuthamount.ClientID %>').value = 0;
        document.getElementById('<%= txtPreAuthApprovalNumber.ClientID %>').value = "";
        document.getElementById('<%= hdnClientAttribValue.ClientID %>').value = "";
        document.getElementById('<%= hdnVisitClientID.ClientID %>').value = 0;
        document.getElementById('<%= hdnRowEdit.ClientID %>').value = "";
        document.getElementById('<%= txtPolicyNo.ClientID %>').value = "";
        document.getElementById('<%= txtPolicyFrom.ClientID %>').value = "";
        document.getElementById('<%= txtPolicyTo.ClientID %>').value = "";
        document.getElementById('<%= ddlpaymentLogic.ClientID%>').selectedIndex = 0;
        document.getElementById('<%= ddlCopaymentType.ClientID%>').selectedIndex = 0;
        document.getElementById('<%= ddlClaimAmount.ClientID%>').selectedIndex = 0;
        document.getElementById('<%= ddlEligibleRateType.ClientID%>').selectedIndex = 0;
        document.getElementById('<%= txtEligibleClientName.ClientID %>').value = "";
    }

    function btnDelete(sEditedData) {
        var i;
        var x = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");
        document.getElementById('<%= hdnClientvalues.ClientID %>').value = '';
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != sEditedData) {
                    document.getElementById('<%= hdnClientvalues.ClientID %>').value += x[i] + "^";
                }
                //                var y = x[i].split('~');
                //                if (y[13] != sEditedData.split('~')[13]) {
                //                    document.getElementById('<%= hdnClientvalues.ClientID %>').value += x[i] + "^";
                //                }
            }
        }
        fu_Tblist();
        return false;
    }
    function getPrecision(obj) {

        obj.value = obj.value == "" ? parseFloat(0).toFixed(2) : parseFloat(obj.value).toFixed(2);
        Calc_Copayment();
    }

    function doValidatePercent(obj) {
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vCopaymentPercentage = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_07') == null ? "Copayment percentage must between 0 to 100" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_07');

        var Combovalue = document.getElementById('uctlClientTpa_ddlCopaymentType').selectedIndex;
        if (Combovalue == 1) {
            if (Number(obj.value) > 100) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\IPClientTpaInsurance.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    obj.value = "0.00";
                    obj.select();
                    return false;
                }
                else {
                    //alert("Copayment percentage must between 0 to 100");
                    ValidationWindow(vCopaymentPercentage, AlertType);
                    obj.value = "0.00";
                    obj.select();
                    return false;
                }
            }
            else {
                return true;
            }
        }
        else {
            return true;
        }
    }

    function fn_DisableClientCntorl(Istrue) {
        document.getElementById('<%=txtClient.ClientID %>').readOnly = Istrue;
        document.getElementById('<%=txtPreAuthApprovalNumber.ClientID %>').readOnly = Istrue;
        document.getElementById('<%=txtCoperent.ClientID %>').readOnly = Istrue;
        document.getElementById('<%=txtAuthamount.ClientID %>').readOnly = Istrue;
        document.getElementById('<%=tbVisitClient.ClientID %>').disabled = Istrue;
        document.getElementById('<%=tbVisitClient.ClientID %>').readOnly = Istrue;
    } 
</script>

<script>

    // loadVisitClientdetails();

    function loadVisitClientdetails() {
        var pVisitid = '<%=Request.QueryString["VID"] %>';
        getVisitClientdetails(pVisitid)
    }

    var IPType;
    function fn_SetVisitdetails(pvid, visitType, pCreditBill, pRoomTypeID) {
        getVisitClientdetails(pvid)

        document.getElementById('<%= ddlRoomType.ClientID %>').value = pRoomTypeID;
        document.getElementById('<%= chkcredit.ClientID %>').checked = pCreditBill == "Y" ? true : false;
        IPType = visitType;
    }

    function getVisitClientdetails(pvid) {

        if (pvid > 0 && pvid != "") {
            OPIPBilling.GetVisitClientMappingDetails(pvid, "<%=OrgID %>", fnBindData);
        }
    }


    function fnBindBaseClient(slist) {

        if (slist.length > 0) {
            var listLen = slist.length;
            for (var i = 0; i < listLen; i++) {
                if (slist[i].Value != "") {
                    document.getElementById('<%= hdnbaseClientValue.ClientID %>').value = slist[i].Value + "^";

                }

            }
        }
    }


    function fnBindData(pList) {

        document.getElementById('<%= hdnClientvalues.ClientID %>').value = '';
        document.getElementById('<%= hdnRateValue.ClientID %>').value = '';
        if (pList.length > 0) {
            var listLen = pList.length;
            for (var i = 0; i < listLen; i++) {
                document.getElementById('<%= hdnClientvalues.ClientID %>').value += pList[i].Description + "^";
                document.getElementById('<%= hdnRateValue.ClientID %>').value += pList[i].IsRateCardChanged + "$";

            }
        }

        fu_Tblist();

        if (IPType == "IP" && document.getElementById('<%= hdnQuikPatient.ClientID %>').value == "Y") {
            InPatientRegisterValidation();
        }
    }
    function fn_bindRateType(pList) {

        var GetCombo = document.getElementById('<%= ddlRateType.ClientID %>');
        GetCombo.options.length = 0;
        var isSelectVal = "";
        var GetList;
        if (pList.length > 0) {
            for (count = 0; count < pList.length - 1; count++) {
                GetList = pList[count].split('^');

                if (GetList != "") {
                    var GetComboList = GetList[4].split('~');
                    var tComblist1 = document.createElement("option");
                    GetCombo.options.add(tComblist1);
                    tComblist1.text = GetComboList[1];
                    tComblist1.value = GetComboList[0];
                    if (GetComboList[1].toUpperCase() == "GENERAL") {
                        isSelectVal = tComblist1.value;
                    }
                }
            }
        }
        var tComblist = document.createElement("option");
        GetCombo.options.add(tComblist);
        tComblist.text = "--Select--";
        tComblist.value = "0";
        if (isSelectVal != "") {
            document.getElementById('<%= ddlRateType.ClientID %>').value = isSelectVal;
        }

    }
    function fn_bindRateType(pList, GetPlace) {
        document.getElementById('<%= ddlRateType.ClientID %>').options.length = 0;
        var GetCombo = document.getElementById('<%= ddlRateType.ClientID %>');
        GetCombo.options.length = 0;
        var isSelectVal = "";
        var GetList;
        var RateArray = new Array();
        if (pList.length > 0) {
            if (GetPlace == 'Add') {
                for (count = 0; count < pList.length - 1; count++) {
                    GetList = pList[count].split('^');

                    if (GetList != "") {
                        var GetComboList = GetList[4].split('~');
                        var tComblist1 = document.createElement("option");
                        GetCombo.options.add(tComblist1);
                        tComblist1.text = GetComboList[1];
                        tComblist1.value = GetComboList[0];
                        if (GetComboList[1].toUpperCase() == "GENERAL") {
                            //isSelectVal = tComblist1.value;
                        }
                    }
                }
                //                var tComblist = document.createElement("option");
                //                GetCombo.options.add(tComblist);
                //                tComblist.text = "--Select--";
                //                tComblist.value = "0";
                if (isSelectVal != "") {
                    document.getElementById('<%= ddlRateType.ClientID %>').value = isSelectVal;
                }
            }
            else if (GetPlace == 'Edit') {
                for (count1 = 0; count1 < pList.length; count1++) {
                    RateArray[1] = pList[count1].RateId;
                    RateArray[0] = pList[count1].RateName;
                    RateArray[2] = pList[count1].ModifiedBy;
                    var tComblist2 = document.createElement("option");
                    GetCombo.options.add(tComblist2);
                    tComblist2.text = RateArray[0];
                    tComblist2.value = RateArray[1];
                    if (RateArray[0].toUpperCase() == "GENERAL") {
                        isSelectVal = RateArray[2];
                    }
                }

                //               if(pList.length==1)
                //               {
                //                   RateArray[1] = pList[0].RateId;
                //                   RateArray[0] = pList[0].RateName;
                //                   RateArray[2] = pList[0].ModifiedBy;
                //                   var tComblist2 = document.createElement("option");
                //                   GetCombo.options.add(tComblist2);
                //                   tComblist2.text = RateArray[0];
                //                   tComblist2.value = RateArray[1];
                //                   if (RateArray[0].toUpperCase() == "GENERAL") {
                //                       isSelectVal = RateArray[2];
                //                   }
                //               }
            }
            var tComblist3 = document.createElement("option");
            GetCombo.options.add(tComblist3);
            tComblist3.text = "--Select--";
            tComblist3.value = "0";
            if (isSelectVal != "") {
                document.getElementById('<%= ddlRateType.ClientID %>').value = isSelectVal;
            }
            if ("<%=IsBilling %>" == "Y" && document.getElementById('<%= hdnDepartmentDefaultRateID.ClientID %>').value != "0" && Number(document.getElementById('<%= hdnDepartmentDefaultRateID.ClientID %>').value) > 0) {
                document.getElementById('<%= ddlRateType.ClientID %>').value = document.getElementById('<%= hdnDepartmentDefaultRateID.ClientID %>').value;
            }
        }

    }
       
</script>

<script type="text/javascript">

    function getClientID(pvType) {
        var pCount = 0;
        var pVal = "";
        if (document.getElementById('<%= hdnSelectClientID.ClientID %>').value == "0" || document.getElementById('<%= hdnSelectClientID.ClientID %>').value == "") {
            var xtemp = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");
            for (ival = 0; ival < xtemp.length; ival++) {
                if (xtemp[ival] != "") {
                    pCount += 1;
                    pVal = xtemp[ival];
                }
            }
            if (pvType == "IP") {

                if (pCount >= 2) {

                    showResponses('divMore1', 'divMore2', 'divMore3', 1);
                    return 0;

                }


                else {
                    btnEdit_OnClick(pVal);
                }
            }
            if (pvType == "OP") {
                if (document.getElementById('<%= hdnClientID.ClientID %>').value == "0") {
                    setClientValues(document.getElementById('<%= hdnbaseClientValue.ClientID %>').value.split('###'));
                    document.getElementById('<%= hdnRateValue.ClientID %>').value = '';
                    document.getElementById('<%= hdnRateValue.ClientID %>').value = document.getElementById('<%= hdnbaseClientValue.ClientID %>').value + '$';
                }
                if (document.getElementById('tblClientDetails').rows.length == 1)
                    checkClientValue();
                var ttemp = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");
                for (ival = 0; ival < ttemp.length; ival++) {
                    if (ttemp[ival] != "") {

                        btnEdit_OnClick(ttemp[ival]);
                        break;
                    }
                }
            }

        }
        var cid = document.getElementById('<%= hdnSelectClientID.ClientID %>').value;
        return cid;
    }
    function getRateID() {
        var rid = document.getElementById('<%= ddlRateType.ClientID %>').value;
        return rid;
    }



    function fn_SetClientVisitDetails() {
        var tCount = 0;
        var ttemp = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");

        for (ival = 0; ival < ttemp.length; ival++) {
            if (ttemp[ival] != "") {
                tCount += 1;
            }
        }

        if (tCount == 0) {
            if (document.getElementById('<%= hdnClientID.ClientID %>').value == "0") {
                setClientValues(document.getElementById('<%= hdnbaseClientValue.ClientID %>').value.split('###'));
                document.getElementById('<%= hdnRateValue.ClientID %>').value = '';
                document.getElementById('<%= hdnRateValue.ClientID %>').value = document.getElementById('<%= hdnbaseClientValue.ClientID %>').value + '$';

            }

            checkClientValue();
        }
    }               
 
</script>

<input type="hidden" runat="server" value="N" id="hdnIsAllMedical" />
<input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
<input type="hidden" runat="server" value="N" id="hdnIsDiscount" />
<input type="hidden" runat="server" value="" id="hdnbaseClientValue" />
<input id="hdnClientID" type="hidden" value="0" runat="server" />
<input id="hdnSelectClientID" type="hidden" value="0" runat="server" />
<input id="hdnClientName" type="hidden" value="" runat="server" />
<input id="hdnClientCode" type="hidden" value="-1" runat="server" />
<input id="hdnClientRateID" type="hidden" value="-1" runat="server" />
<input id="hdnClientMappingID" type="hidden" value="0" runat="server" />
<input id="hdnClientattribExists" type="hidden" value="N" runat="server" />
<input type="hidden" id="hdnClientAttribValue" runat="server" />
<input type="hidden" id="hdnClientvalues" runat="server" />
<input type="hidden" id="hdnRowEdit" runat="server" />
<input type="hidden" id="hdnVisitClientID" value="0" runat="server" />
<input type="hidden" id="hdnOldClientValue" value="" runat="server" />
<input type="hidden" id="hdnValueStatus" value="N" runat="server" />
<input type="hidden" id="hdnQuikPatient" value="N" runat="server" />
<input type="hidden" id="hdnCreditClientPatient" value="N" runat="server" />
<input type="hidden" id="hdnDepartmentDefaultRateID" value="0" runat="server" />

<script type="text/javascript">
    function getClaimID() {
        var rid = document.getElementById('<%= ddlClaimAmount.ClientID %>').value;
        return rid;
    }

    function getPaymentlogicID() {
        var rid = document.getElementById('<%= ddlpaymentLogic.ClientID %>').value;
        return rid;
    }

    function getCoPaymentperent() {
        var rid = document.getElementById('<%= txtCoperent.ClientID %>').value;
        return rid;
    }
    function getPreAuthamount() {
        var rid = document.getElementById('<%= txtAuthamount.ClientID %>').value;
        return rid;
    }

    function getCreditBill() {
        return document.getElementById('<%= chkcredit.ClientID %>').checked;

    }
    function getVisitClientMappingID() {
        return document.getElementById('<%= hdnClientMappingID.ClientID %>').value;
    }
    function clearClientControlsValue(obj) {
        document.getElementById('<%= hdnClientID.ClientID %>').value = 0;
        document.getElementById('<%= hdnSelectClientID.ClientID %>').value = 0;
        document.getElementById('<%= chkIsAllMedical.ClientID %>').checked = false;
        document.getElementById('<%= txtCoperent.ClientID %>').value = 0;
        document.getElementById('<%= txtAuthamount.ClientID %>').value = 0;
        document.getElementById('<%= txtPreAuthApprovalNumber.ClientID %>').value = "";
        document.getElementById('<%= hdnClientAttribValue.ClientID %>').value = "";

        if (document.getElementById('<%= btnAddClient.ClientID %>').value == 'Add') {
            document.getElementById('<%= hdnVisitClientID.ClientID %>').value = 0;
        }

        //document.getElementById('<%= hdnRowEdit.ClientID %>').value = "";
        document.getElementById('<%= hdnIsMappedItem.ClientID %>').value = 'N';
        document.getElementById('<%= hdnIsDiscount.ClientID%>').value = 'N';
        document.getElementById('<%= hdnClientID.ClientID %>').value = 0;
        document.getElementById('<%= hdnClientName.ClientID%>').value = '';
        document.getElementById('<%= hdnClientCode.ClientID%>').value = 0;
        document.getElementById('<%= hdnClientRateID.ClientID%>').value = 0;
        document.getElementById('<%= hdnClientMappingID.ClientID%>').value = 0;
        document.getElementById('<%= hdnClientattribExists.ClientID%>').value = 'N';
        if (document.getElementById('<%= hdnQuikPatient.ClientID %>').value == "Y") {
            ClientChangeValidation();
        }
    }
      
</script>

<script type="text/javascript" language="javascript">
    var SHeaderList = { ClientName: '<%=Resources.ClientSideDisplayTexts.CommonControls_IPClientTpaInsurance_ClientName %>',
        RateType: '<%=Resources.ClientSideDisplayTexts.CommonControls_IPClientTpaInsurance_RateType %>',
        Copayment: 'Copayment',
        PaymentLogic: '<%=Resources.ClientSideDisplayTexts.CommonControls_IPClientTpaInsurance_PaymentLogic %>',
        ClaminLogin: '<%=Resources.ClientSideDisplayTexts.CommonControls_IPClientTpaInsurance_ClaminLogin %>'

    };

    function SetValidation(CheckStatus) {
        document.getElementById('<%= hdnQuikPatient.ClientID %>').value = CheckStatus;

    }


    function InPatientRegisterValidation() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vInPatientDetails = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_08') == null ? "Please Register InPatient Details.." : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_08');

        var ClientValue = document.getElementById('<%= hdnClientvalues.ClientID %>').value;
        if (ClientValue == "") {
            //alert("Please Register InPatient Details..");
            ValidationWindow(vInPatientDetails, AlertType);
            IPType = "";
            ReSetAllDetails();
            return;
        }

    }
</script>

<script type="text/javascript">

    function GetCreditBill() {
        return document.getElementById('<%= hdnCreditClientPatient.ClientID %>').value
    }

    function ClientSelected1(source, eventArgs) {

        var list = eventArgs.get_value().split('^');
        var slist = eventArgs.get_value().split('###');
        document.getElementById('<%= hdnRateDetails.ClientID %>').value = eventArgs.get_value();
        fn_bindRateType1(slist);

        document.getElementById('<%= hdnEligibleClientID.ClientID %>').value = list[5];
        document.getElementById('<%= txtEligibleClientName.ClientID %>').value = list[1];
        getEligibleRateTypeID();

    }
    function fn_bindRateType1(pList) {

        document.getElementById('<%= ddlEligibleRateType.ClientID %>').options.length = 0;
        var GetCombo = document.getElementById('<%= ddlEligibleRateType.ClientID %>');
        GetCombo.options.length = 0;
        var isSelectVal = "";
        var GetList;
        var RateArray = new Array();
        if (pList.length > 0) {
            for (count = 0; count < pList.length - 1; count++) {
                GetList = pList[count].split('^');
                if (GetList != "") {
                    var GetComboList = GetList[4].split('~');
                    var tComblist1 = document.createElement("option");
                    GetCombo.options.add(tComblist1);
                    tComblist1.text = GetComboList[1];
                    tComblist1.value = GetComboList[0];
                    if (GetComboList[1].toUpperCase() == "GENERAL") {
                        isSelectVal = tComblist1.value;
                    }

                }
            }
            var tComblist = document.createElement("option");
            GetCombo.options.add(tComblist);
            tComblist.text = "--Select--";
            tComblist.value = "0";
            if (isSelectVal != "") {
                document.getElementById('<%= ddlEligibleRateType.ClientID %>').value = isSelectVal;
            }


        }

    }

    function Check_EligleRateCardValidation() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vClientName = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_09') == null ? "Please select Eligible Client Name..." : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_09');
        var vRateName = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_10') == null ? "Please select Eligible Rate Name..." : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_10');

        if (GetCreditBill() == "Y") {
            if (document.getElementById('<%= hdnEligibleClientID.ClientID %>').value == "0") {
                //alert('Please select Eligible Client Name...');\
                ValidationWindow(vClientName, AlertType);
                return false;
            }
            else if (document.getElementById('<%= ddlEligibleRateType.ClientID %>').value == "0") {
                //alert('Please select Eligible Rate Name...');
                ValidationWindow(vRateName, AlertType);
                return false;
            }
            document.getElementById('<%= hdnEligibleRateTypeID.ClientID %>').value = document.getElementById('<%= ddlEligibleRateType.ClientID %>').value;
        }
    }


    function getEligibleRateTypeID() {
        if (document.getElementById('<%= ddlEligibleRateType.ClientID %>').value != "0") {
            document.getElementById('<%= hdnEligibleRateTypeID.ClientID %>').value = document.getElementById('<%= ddlEligibleRateType.ClientID %>').value;
        }
        return false;

    }

    //Check_ClientValidation();
    function Check_ClientValidation() {
        if ("<%=IsBilling %>" != "Y") {
            var pCount = 0;

            var xtemp = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");
            for (ival = 0; ival < xtemp.length; ival++) {
                if (xtemp[ival] != "") {
                    pCount += 1;
                    pVal = xtemp[ival];
                }
            }

            if (pCount == 0 || document.getElementById('<%= btnAddClient.ClientID %>').value == 'Update') {
                document.getElementById('<%= btnAddClient.ClientID %>').style.display = "block";
            } else {
                document.getElementById('<%= btnAddClient.ClientID %>').style.display = "none";
            }
        }
    }

    function SetEligibleClientvalue() {
        if (document.getElementById('<%= hdnEligibleClientID.ClientID %>').value == "0" ||
            document.getElementById('<%= hdnEligibleRateTypeID.ClientID%>').value == "0") {
            document.getElementById('<%= hdnEligibleClientID.ClientID %>').value = document.getElementById('<%= hdnClientID.ClientID%>').value;
            document.getElementById('<%= hdnEligibleRateTypeID.ClientID %>').value = document.getElementById('<%= ddlRateType.ClientID %>').value == "0" || document.getElementById('<%= ddlRateType.ClientID %>').value == ""
               ? document.getElementById('<%= hdnClientRateID.ClientID %>').value : document.getElementById('<%= ddlRateType.ClientID %>').value;
            document.getElementById('<%= txtEligibleClientName.ClientID %>').value = document.getElementById('<%= txtClient.ClientID%>').value;
            document.getElementById('<%= ddlEligibleRateType.ClientID %>').value = document.getElementById('<%= hdnEligibleRateTypeID.ClientID %>').value;
        }
    }
    //    function SetPrecision(obj) {
    //      
    //        var Combovalue = document.getElementById('<%=ddlCopaymentType.ClientID %>').selectedIndex;
    //        if (Combovalue > 0) {
    //            document.getElementById('<%= txtCoperent.ClientID %>').focus();
    //        }
    //        if (Combovalue == 0) {
    //            alert('Please Select Co-Payment Type');
    //            document.getElementById('<%= ddlCopaymentType.ClientID %>').focus();
    //            return false;
    //        }
    //        onblur = "SetPrecision(this);"
    //    }
    function SetFocus() {
        //var spaymentType = document.getElementById('<%= ddlCopaymentType.ClientID %>');
        var sPaymentName = document.getElementById('<%= ddlCopaymentType.ClientID %>').value; // spaymentType.options[spaymentType.selectedIndex].innerHTML;
        if (sPaymentName != null && document.getElementById('<%= btnAddClient.ClientID %>').value == 'Add') {
            if (sPaymentName == "Percentage") //
            {
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = false;

            }
            else {
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').selectedIndex = 0;
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = true;
            }
        }
        else if (sPaymentName != null && document.getElementById('<%= btnAddClient.ClientID %>').value == 'Update') {
            if (sPaymentName == "Percentage") {
                document.getElementById('<%= txtCoperent.ClientID %>').value = "";
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = false;
                document.getElementById('<%= txtCoperent.ClientID %>').focus();
            }
            else {
                document.getElementById('<%= txtCoperent.ClientID %>').value = "";
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').selectedIndex = 0;
                document.getElementById('<%= ddlpaymentLogic.ClientID%>').disabled = true;
                document.getElementById('<%= txtCoperent.ClientID %>').focus();
            }
        }
        Calc_Copayment();
    }

    function Check_Finalvalidation() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('') == null ? "Alert" : SListForAppMsg.Get('');
        var vClientName = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_01') == null ? "Please Select Client Name" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_01');
        var vRatecardName = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_02') == null ? "Please Select Ratecard Name" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_02');
        var vCoPaymentLogic = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_03') == null ? "Select Co-Payment Logic" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_03');
        var vCoPaymentDeducedFrom = SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_04') == null ? "Select Co-Payment to be deducted from" : SListForAppMsg.Get('CommonControls_IPClientTpaInsurance_ascx_04');


        var spaymentType = document.getElementById('<%= ddlCopaymentType.ClientID %>').selectedIndex;
        var spaymentLogic = document.getElementById('<%= ddlpaymentLogic.ClientID %>').selectedIndex;
        var sClaimAmount = document.getElementById('<%= ddlClaimAmount.ClientID %>').selectedIndex;
        var tlst = document.getElementById('<%= hdnClientvalues.ClientID %>').value.split("^");

        if (document.getElementById('<%= hdnClientID.ClientID %>').value == "0") {
            //alert("Please Select Client Name");
            ValidationWindow(vClientName, AlertType);
            return false;
        }
        else if (document.getElementById('<%= ddlRateType.ClientID %>').value == "0" || document.getElementById('<%= ddlRateType.ClientID %>').value == "") {
            //alert("Please Select Ratecard Name");
            ValidationWindow(vRatecardName, AlertType);
            return false;
        }
        else if (document.getElementById('<%= txtCoperent.ClientID %>').value >= 0 && spaymentType == 1 && spaymentLogic == 0) {
            //alert("Select Co-Payment Logic");
            ValidationWindow(vCoPaymentLogic, AlertType);
            document.getElementById('<%= ddlpaymentLogic.ClientID %>').focus();
            return false;

        }
        else if (document.getElementById('<%= txtCoperent.ClientID %>').value >= 0 && spaymentType == 1 && spaymentLogic > 0 && sClaimAmount == 0) {
            //alert("Select Co-Payment to be deducted from");
            ValidationWindow(vCoPaymentDeducedFrom, AlertType);
            document.getElementById('<%= ddlClaimAmount.ClientID %>').focus();
            return false;
        }
        else if (document.getElementById('<%= txtCoperent.ClientID %>').value >= 0 && spaymentType == 2 && sClaimAmount == 0) {
            //alert("Select Co-Payment to be deducted from");
            ValidationWindow(vCoPaymentDeducedFrom, AlertType);
            document.getElementById('<%= ddlClaimAmount.ClientID %>').focus();
            return false;
        }
        else {
            return true;
        }
    }

    function SetPreAuthu() {
        var ddlPreAuthType = document.getElementById('<%= ddlPreAuthType.ClientID %>');
        var PreAutuName = ddlPreAuthType.options[ddlPreAuthType.selectedIndex].innerHTML;

        if (PreAutuName == "Percentage") {
            $('#<%= txtAuthamount.ClientID %>').val('0.00');
            $('#<%= txtAuthamount.ClientID %>').attr("disabled", true);
            $('#<%= txtPreAuthPerent.ClientID %>').attr("disabled", false);

        }
        else {
            $('#<%= txtPreAuthPerent.ClientID %>').val('0.00');
            $('#<%= txtAuthamount.ClientID %>').attr("disabled", false);
            $('#<%= txtPreAuthPerent.ClientID %>').attr("disabled", true);
        }
        return false;
    }

    function GetPreAuthType() {
        return $('#<%= ddlPreAuthType.ClientID %>').val();
    }
    function GetCopaymentType() {
        return $('#<%= ddlCopaymentType.ClientID %>').val();
    }

    function GetPreAuthamount() {
        return $('#<%= txtAuthamount.ClientID %>').val();
    }

    function GetPreAuthPerent() {
        return $('#<%= txtPreAuthPerent.ClientID %>').val();
    }
</script>

<script language="vbscript" type="text/vbscript">

Function vbMsg(isTxt,isCaption)
testVal = MsgBox(isTxt,3,isCaption)
isChoice = testVal
End Function

</script>

<asp:HiddenField ID="hdnRateValue" Value="" runat="server" />
<asp:HiddenField ID="hdnclientoldID" runat="server" />
<asp:HiddenField ID="hdnClientChangedFlag" Value="N" runat="server" />
