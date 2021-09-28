<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PaymentTypeDetails.ascx.cs"
    Inherits="CommonControls_PaymentTypeDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        width: 21px;
    }
    .searchBox
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: left;
        height: 15px;
        width: 130px;
        border: 1px solid #999999;
        font-size: 11px;
        margin-left: 0px;
        background-image: url('../Images/magnifying-glass.png');
        background-repeat: no-repeat;
        padding-left: 20px !important;
        background-color: #F3E2A9;
    }
    #tabDrg1 .gridHeader > td
    {
        color: #fff;
    }
</style>
<asp:Panel ID="pres" runat="server" class="b-grey" Width="713px" Style="overflow: auto;"
    meta:resourcekey="presResource1">
    <table class="w-100p bg-row">
        <tr>
            <td class="Duecolor h-23 a-left">
                &nbsp;&nbsp;<asp:Label ID="Rs_Pay_Mod" runat="server" Text="Payment Modes" meta:resourceKey="Rs_Pay_ModResource1"></asp:Label>&nbsp;
            </td>
            <td class="Duecolor a-center">
                <asp:Label ID="Rs_Select" runat="server" Text="Select Currency Type" Font-Bold="true"
                    meta:resourceKey="Rs_SelectResource1"></asp:Label>
                &nbsp;&nbsp; :
                <asp:DropDownList onchange="GetCurrencyValues();" CssClass="ddlsmall" ID="ddCurrency"
                    runat="server" meta:resourceKey="ddCurrencyResource1">
                </asp:DropDownList>
                <input id="hdnBaseCurrencyID" runat="server" type="hidden" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dataheaderInvCtrl">
                    <table>
                        <tr id="trERM" runat="server" style="display: none;">
                            <td nowrap="nowrap" runat="server">
                                <asp:CheckBox ID="chkPaybyEMI" runat="server" Text="Pay By EMI?" onClick="javascript:checkboxEMI(); Paymentchanged();" />
                            </td>
                        </tr>
                    </table>
                    <table class="tabletxt w-100p">
                        <tr class="a-left">
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Type" runat="server" Text="Type" meta:resourceKey="Rs_TypeResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblROI" runat="server" Text="EMI ROI" Style="display: none" meta:resourcekey="lblROIResource1"></asp:Label>
                                <%--EMIROI--%>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblTenor" runat="server" Style="display: none" Text="EMI Tenure" meta:resourcekey="lblTenorResource1"></asp:Label>
                                <%--EMITenure(only in Months)--%>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Amount" runat="server" Text="Amount" meta:resourceKey="Rs_AmountResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Bank" Style="display: none" runat="server" Text="Bank/Card Type"
                                    meta:resourceKey="Rs_BankResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" id="tdlblRs_Cheque_no">
                                <asp:Label ID="Rs_Cheque_no" Style="display: none" runat="server" Text="Cheque/Card/DDNo."
                                    meta:resourceKey="Rs_Cheque_noResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" id="tdlblUnits">
                                <asp:Label ID="lblUnits" Style="display: none" runat="server" Text="Units"></asp:Label>
                            </td>
                            <td nowrap="nowrap" id="tdlblCardHolderName" width="110px">
                                <asp:Label ID="Rs_CardHolderName" Style="display: none" runat="server" Text="Card Holder Name"
                                    meta:resourcekey="Rs_CardHolderNameResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" id="tdlblChequeDate">
                                <asp:Label ID="lblChequeDate" Style="display: none" runat="server" Text="Cheque valid Date"
                                    meta:resourcekey="lblChequeDateResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" id="tdlblRs_Ser_Cha">
                                <asp:Label ID="Rs_Ser_Cha" Style="display: none" runat="server" Text="Service Charge(%)"
                                    meta:resourceKey="Rs_Ser_ChaResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="TRs_Total" runat="server" Text="Total" meta:resourceKey="TRs_TotalResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" width="110px" style="display: none;">
                                <asp:Label ID="Rs_Remarks" runat="server" Text="Remarks" meta:resourceKey="Rs_RemarksResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr class="a-left">
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="ddlPaymentType" runat="server" onchange="javascript:Paymentchanged();"
                                    CssClass="ddlsmall" meta:resourceKey="ddlPaymentTypeResource1">
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtROI" Style="display: none;" CssClass="Txtboxverysmall"
                                       onkeypress="return ValidateOnlyNumeric(this);"   MaxLength="9" autocomplete="off" meta:resourcekey="txtROIResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtTenor" Style="display: none" CssClass="Txtboxverysmall"
                                       onkeypress="return ValidateOnlyNumeric(this);"   MaxLength="9" autocomplete="off" meta:resourcekey="txtTenorResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtAmount" onChange="javascript:changeAmountValues();"
                                    CssClass="small"   MaxLength="9" autocomplete="off"
                                    meta:resourceKey="txtAmountResource1"  onkeypress="return checksign(this);"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtBankType" Style="display: none" CssClass="searchBox small"
                                    meta:resourceKey="txtBankTypeResource1"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtBankType"
                                    EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    ServiceMethod="GetBankName" ServicePath="~/InventoryWebService.asmx" OnClientItemSelected="SelectedItemValue"
                                    DelimiterCharacters="" Enabled="True">
                                </cc1:AutoCompleteExtender>
                                <input type="hidden" runat="server" id="hdnReferenceID" />
                                <input type="hidden" runat="server" id="hdnReferenceType" />
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" Style="display: none;" ID="txtNumber" 
                                       onkeypress="return ValidateOnlyNumeric(this);"   autocomplete="off" CssClass="small"
                                    MaxLength="19" meta:resourceKey="txtNumberResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <div id="tdtxtUnits" runat="server" style="display: none;">
                                    <asp:TextBox ID="txtUnits" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                        CssClass="Txtboxverysmall" MaxLength="9" autocomplete="off"></asp:TextBox></div>
                            </td>
                            <td nowrap="nowrap">
                                <div id="tdCardHolder" runat="server" style="display: none;">
                                    <asp:TextBox ID="txtCardHolderName" runat="server" CssClass="Txtboxsmall" autocomplete="off"
                                         Style="margin-bottom: 0px" meta:resourcekey="txtCardHolderNameResource1"></asp:TextBox></div>
                            </td>
                            <td nowrap="nowrap" runat="server">
                                <div id="tdtxtDate" runat="server" style="display: none;">
                                    <asp:TextBox CssClass="small" ToolTip="dd/mm/yyyy" ID="txtDate" runat="server" />
                                    <cc1:MaskedEditExtender ID="MEDDate" runat="server" TargetControlID="txtDate" Mask="99/99/9999"
                                        MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <cc1:CalendarExtender ID="caldate" Format="dd/MM/yyyy" runat="server" TargetControlID="txtDate"
                                        PopupButtonID="ImgBnt" Enabled="True" />
                                    &nbsp;<asp:ImageButton CssClass="h-13" ID="ImgBnt" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntResource1" />
                                </div>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtServiceCharge"    onkeypress="return ValidateOnlyNumeric(this);"  
                                    CssClass="Txtboxverysmall" onblur="javascript:changeAmountValues()" onChange="javascript:changeAmountValues();"
                                    Style="display: none; text-align: right;" MaxLength="9" autocomplete="off" meta:resourceKey="txtServiceChargeResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="txtTotalAmount" runat="server" autocomplete="off" MaxLength="9" meta:resourceKey="txtTotalAmountResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" style="display: none;">
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="Txtboxsmall" autocomplete="off"
                                    meta:resourceKey="txtRemarksResource1" Style="margin-bottom: 0px"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                            <input type="button" value="Add" ID="addNewPayment" class="btn" onclick="javascript:if(PaymentTypeValidation())return false; else return false;"></input>
                                <%--<asp:Button ID="addNewPayment" Text="Add" ToolTip="Add" CssClass="btn" runat="server"
                                    OnClientClick="javascript:if(PaymentTypeValidation())return false; else return false;"
                                    meta:resourceKey="addNewPayment1" />--%>
                                <asp:Button ID="btnAmountPop" Style="display: none;" Text="Add" ToolTip="Add" CssClass="btn"
                                    runat="server" OnClientClick="return  valAmountApprovalDetails()" meta:resourceKey="addNewPayment1" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr id="trPaymentDetails" runat="server" style="display: none;">
            <td colspan="2" runat="server">
                <div id="dvPaymentTable" class="w-100p" runat="server">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden" runat="server" id="hdnIsRequired" value="" />
                <input type="hidden" runat="server" id="hdnPaymentDetails" value="" />
            </td>
        </tr>
    </table>
</asp:Panel>

<script type="text/javascript" language="javascript">
    /* Common Alert Validation */
    //var AlertType;
//    $(document).ready(function() {

//        
//        AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
//    });
   // var slist = { ChequeCardDDNo: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ChequeCardDDNo_1 %>', BankCardType: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_BankCardType_1 %>', CouponNumber: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponNumber %>', Coupon: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Coupon %>', CouponName: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponName %>' };
</script>

<script type="text/javascript" language="javascript">
    var EMIValue = 0;
    function SelectedItemValue(source, eventArgs) {

        var varGetVal = eventArgs.get_value();
        var arrGetVal = new Array();
        arrGetVal = varGetVal.split("~");
        document.getElementById('<%=hdnReferenceID.ClientID %>').value = arrGetVal[0];
    }


    function ClearPaymentControlEvents() {
        document.getElementById('<%= hdfPaymentType.ClientID %>').value = "";
        PaymentControlclear();
        CreatePaymentTables();

    }
    function PaymentSaveValidationQuickBill() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vCardNo = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_01') == null ? "Please Enter Cheque/Card Number" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_01');
        var vCartType = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_02') == null ? "Please Enter Bank Name/Card Type" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_02');
        var vCouponUnits = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_03') == null ? "Please Enter Coupon Units" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_03');
        var vAmtValidation = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04') == null ? "Amount should be greater than zero" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04');
        var vChequeValidate = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_12') == null ? "Please enter the cheque valid Date" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_12');
        var vCardHolderName = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_23') == null ? "Please Enter Card Holder Name" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_23');
        var IsEMI = document.getElementById('<%=hdnIsEMI.ClientID %>').value;
        var alertpayment = false;

        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value.split('~')[0];
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = ToInternalFormat($('#<%= txtAmount.ClientID %>')); //document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ChequeValidDate = document.getElementById('<%= txtDate.ClientID %>').value;
        var ServiceCharge = ToInternalFormat($('#<%= txtServiceCharge.ClientID %>')); //document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = ToInternalFormat($('#<%= txtTotalAmount.ClientID %>'));  //document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        var Units = document.getElementById('<%= txtUnits.ClientID %>').value == "" ? "0" : document.getElementById('<%= txtUnits.ClientID %>').value;
        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        var EMIROI = document.getElementById('<%= txtROI.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtROI.ClientID %>').value;
        var EMITenor = document.getElementById('<%= txtTenor.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtTenor.ClientID %>').value;
        var EMIValue = 0;
        var CardHolderName = document.getElementById('<%= txtCardHolderName.ClientID %>').value

        if (PaymentTypeID != "0" && PaymentTypeID != "") {

            // This condition ll be check in billing page .

          //  if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
            if (PaymentTypeID != "1" && PaymentMethodNumber == "") {
                
                    //alert("Please Enter Cheque/Card Number");
                    ValidationWindow(vCardNo, AlertType);
                    
                document.getElementById('<%= txtNumber.ClientID %>').focus();
                return false;
            }
           // else if (PaymentName != 'Cash' && PaymentBankType == "") {
            else if (PaymentTypeID != "1" && PaymentBankType == "") {
               
                    //alert("Please Enter Bank Name/Card Type");\
                    ValidationWindow(vCartType, AlertType);
                    
                document.getElementById('<%= txtBankType.ClientID %>').value = "";
                document.getElementById('<%= txtBankType.ClientID %>').focus();
                return false;
            }
            else if (ChequeValidDate == "" && PaymentTypeID == "2") {
                // alert("Please enter the cheque valid Date");
                ValidationWindow(vChequeValidate, AlertType);
                document.getElementById('<%= txtDate.ClientID %>').value = "";
                return false;

            }
            else if (CardHolderName == "" && PaymentTypeID == "3") {
                // alert("Please enter the cheque valid Date");
                ValidationWindow(vCardHolderName, AlertType);
                document.getElementById('<%= txtCardHolderName.ClientID %>').value = "";
                return false;

            }
           // else if (PaymentName == 'Coupon' && Units == "") {
            else if (PaymentTypeID == "10" && Units == "") {
               
                    //alert("Please Enter Coupon Units");
                    ValidationWindow(vCouponUnits, AlertType);
                   
                document.getElementById('<%= txtUnits.ClientID %>').focus();
                return false;
            }
            else {
                PaymentAmount = format_number(PaymentAmount, 2);
               // if (PaymentName != 'Cash') {
                if (PaymentTypeID != "1") {
                    ServiceCharge = format_number(ServiceCharge, 2);
                }
                var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>'));                 //document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
                if (Number(PaymentAmount) >= 0) {


                    var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                    if (returnType == true) {
                        var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);

                        document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                        PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                        document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                        ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                        document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                        TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                        document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                        OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));


                        var retval = PaymentName + "~"
                        + PaymentAmount + "~"
                        + PaymentMethodNumber + "~"
                        + PaymentBankType + "~"
                        + PaymentRemarks + "~"
                        + PaymentTypeID + "~"
                        + ChequeValidDate + "~"
                        + ServiceCharge + "~"
                        + TotalAmount + "~"
                        + OtherCurrAmt + "~"
                        + EMIROI + "~"
                        + EMITenor + "~"
                        + EMIValue + "~"
                        + Units + "~"
                        + ReferenceID + "~"
                        + ReferenceType + "~" + CardHolderName;
                        CmdAddPaymentType_onclick(retval);
                        return true;
                    }
                    else {
                        if (Number(PaymentAmount) == 0) {

                        }
                        else {
                            return false;
                        }
                       
                    }
                }
                else {
                    
                   
                        //alert("Amount should be greater than zero");
                        ValidationWindow(vAmtValidation, AlertType);
                        
                }
            }
        }
        else {
            return true;
        }


    }

    function PaymentSaveValidation() {
        var AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        var vAmtValidation = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04') == null ? "Amount should be greater than zero" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04');

        var EMIValue = 0;
        var alertpayment = false;
        var IsEMI = document.getElementById('<%=hdnEMI.ClientID %>').value;
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value.split('~')[0];
        var IsRequired = ctlDp.options[ctlDp.selectedIndex].value.split('~')[1];
        var MaxLength = ctlDp.options[ctlDp.selectedIndex].value.split('~')[2];
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = ToInternalFormat($('#<%= txtAmount.ClientID %>')); //; document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ChequeValidDate = document.getElementById('<%= txtDate.ClientID %>').value;
        var ServiceCharge = ToInternalFormat($('#<%= txtServiceCharge.ClientID %>')); // document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = ToInternalFormat($('#<%= txtTotalAmount.ClientID %>')); //  document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;
        var Units = document.getElementById('<%= txtUnits.ClientID %>').value == "" ? "0" : document.getElementById('<%= txtUnits.ClientID %>').value;
        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        var EMIROI = document.getElementById('<%= txtROI.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtROI.ClientID %>').value;
        var EMITenor = document.getElementById('<%= txtTenor.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtTenor.ClientID %>').value;
        var CardHolderName = document.getElementById('<%= txtCardHolderName.ClientID %>').value

        if (PaymentTypeID != "0" && PaymentTypeID != "") {
            PaymentAmount = format_number(PaymentAmount, 2);
           // if (PaymentName != 'Cash') {
            if (PaymentTypeID != "0") {
                ServiceCharge = format_number(ServiceCharge, 2);
            }
            var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>')); // document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
            if (Number(PaymentAmount) >= 0) {


                var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                if (returnType == true && IsEMI == "N") {

                    var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                    EMIValue = 0;
                    document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                    PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                    ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                    TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                    OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));


                    var retval = PaymentName + "~"
                    + PaymentAmount + "~"
                    + PaymentMethodNumber + "~"
                    + PaymentBankType + "~"
                    + PaymentRemarks + "~"
                    + PaymentTypeID + "~"
                    + ChequeValidDate + "~"
                    + ServiceCharge + "~"
                    + TotalAmount + "~"
                    + OtherCurrAmt + "~"
                    + EMIROI + "~"
                    + EMITenor + "~"
                    + EMIValue + "~"
                    + Units + "~"
                    + ReferenceID + "~"
                    + ReferenceType + "~"
                    + CardHolderName;
                    CmdAddPaymentType_onclick(retval);
                    return true;
                }
                if (returnType == true && IsEMI == "Y") {

                    var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                    // formula for EMIVAlue =E = P×r×(1 + r)n/((1 + r)n - 1)
                    //P-Amount,r-Rateofintrest,n-Tenor
                    //12/(12X100)
                    var TotEMI = (TotalAmount * EMIROI / 100);
                    var MonthEMI = TotEMI / 12;
                    var TenureEMI = Number(MonthEMI) * Number(EMITenor);
                    var temp = Number(TotalAmount) + Number(TenureEMI);
                    if (temp != 0) {
                        var EMIValue = (Number(temp) / Number(EMITenor)).toFixed(2);
                    }
                    else {
                        var EMIValue = 0;
                    }
                    document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                    PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                    ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                    TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                    OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    //var EMIValue = (TotalAmount *(EMIROI/100)) * (1 + (EMIROI*EMIROI/100)) * (EMITenor) / (1 + (EMIROI*(EMIROI/100)) * (EMITenor - 1))).toFixed(2);
                    var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAmount + "~" + OtherCurrAmt + "~" + EMIROI + "~" + EMITenor + "~" + EMIValue + "~" + Units + "~" + ReferenceID + "~" + ReferenceType + "~" + CardHolderName;
                    CmdAddPaymentType_onclick(retval);
                    return true;
                }
            }
            else {
                
                    //alert("Amount should be greater than zero");
                    ValidationWindow(vAmtValidation, AlertType);
                    
            }
        }
        else {
            return true;
        }
        ClearPaymentControlEvents();

    }

    function PaymentTypeValidation() {
        var AlertType = SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03') == null ? "Alert" : SListForAppMsg.Get('CommonControls_PatientDetails_ascx_03');
        var slist = { ChequeCardDDNo: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ChequeCardDDNo_1 %>', BankCardType: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_BankCardType_1 %>', CouponNumber: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponNumber %>', Coupon: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Coupon %>', CouponName: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponName %>' };
        /* Added By Venkatesh S */
        var vCardNo = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_01') == null ? "Please Enter Cheque/Card Number" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_01');
        var vCartType = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_02') == null ? "Please Enter Bank Name/Card Type" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_02');
        var vCouponUnits = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_03') == null ? "Please Enter Coupon Units" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_03');
        var vAmtValidation = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04') == null ? "Amount should be greater than zero" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04');

        var vEnterAmt = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_05') == null ? "Please Enter Amount greater than 0" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_05');
        var vAmtRequired = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_06') == null ? "Payment Type and Amount Required" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_06');
        var vEMI = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_07') == null ? "Please enter Rate of Interest for EMI" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_07');
        var vTenorIntrest = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_08') == null ? "Please enter the Tenor of Interest" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_08');
        var vCheque = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_09') == null ? "Cheque no should be last" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_09');
        var vNo = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_10') == null ? "numbers" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_10');
        var vCardNoLast = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_11') == null ? "Card no should be last" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_11');
        var vChequeValidate = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_12') == null ? "Please enter the cheque valid Date" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_12');
        var vChequeValidateDate = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_13') == null ? "Please enter the Valid cheque Date" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_13');
        var vCashAlerdyExists = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_14') == null ? "Cash Payment mode already exists, Kindly edit then add amount" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_14');
        var DispPay = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_16') == null ? "The Payment details already exists, Kindly change Card details" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_16');
        var vCardHolderName = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_23') == null ? "Please Enter Card Holder Name" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_23');

        var alertpayment = false;
        var GetPaymentDetails = "";
        var IsEMI = document.getElementById('<%=hdnEMI.ClientID %>').value;
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        GetCurrencyValues(); //To Set the Currency details...
        //  var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value.split('~')[0];
        var IsRequired = ctlDp.options[ctlDp.selectedIndex].value.split('~')[1];
        var MaxLength = ctlDp.options[ctlDp.selectedIndex].value.split('~')[2];
        var IsValidMonth = ctlDp.options[ctlDp.selectedIndex].value.split('~')[3];
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');
        var PaymentAmount = ToInternalFormat($('#<%= txtAmount.ClientID %>'));
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ChequeValidDate = document.getElementById('<%= txtDate.ClientID %>').value;
        if (ChequeValidDate == "0") {
            ChequeValidDate = "";
        }
        if (document.getElementById('billPart_PaymentType_txtDate') != null) {
            document.getElementById('billPart_PaymentType_txtDate').value = "";
        }
        else {
         //   document.getElementById('<%= txtDate.ClientID %>').value = "";
        }
        var ServiceCharge = ToInternalFormat($('#<%= txtServiceCharge.ClientID %>'));
        var TotalAmount = ToInternalFormat($('#<%= txtTotalAmount.ClientID %>'));
        var Units = document.getElementById('<%= txtUnits.ClientID %>').value == "" ? "0" : document.getElementById('<%= txtUnits.ClientID %>').value;
        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        var EMIROI = document.getElementById('<%= txtROI.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtROI.ClientID %>').value;
        var EMITenor = document.getElementById('<%= txtTenor.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtTenor.ClientID %>').value;
        var EMIValue = 0;
        var GetTotalDays = parseInt(IsValidMonth) * 30;
        var oneDay = 24 * 60 * 60 * 1000;
        var TodayDate = new Date();
        var DayFormat = TodayDate.format("MM/dd/yyyy");
        var TodayMonth = DayFormat.split('/')[0];
        var TodayDay = DayFormat.split('/')[1];
        var TodayYear = DayFormat.split('/')[2];
        var GetDate = new Date(TodayYear, TodayMonth, TodayDay);
        var GetPaymentDate = "";
        var day = "";
        var month = "";
        var Year = "";
        var TargetDate = "0";
        var diffDays = "0"
        if (ChequeValidDate != "") {
            GetPaymentDate = ChequeValidDate.split('/');
            day = GetPaymentDate[0];
            month = (GetPaymentDate[1]);
            Year = GetPaymentDate[2];
            TargetDate = new Date(Year, month, day);
            diffDays = Math.round(Math.abs((GetDate.getTime(TodayYear, TodayMonth, TodayDay) - TargetDate.getTime(Year, month, day)) / (oneDay)));
        }
        else {
            TargetDate = new Date();
        }
        var CardHolderName = document.getElementById('<%= txtCardHolderName.ClientID %>').value;
        var AmtReceivedID = document.getElementById('<%= hdnAmtReceivedID.ClientID %>').value;
        if (PaymentAmount <= 0) {
           
            
                //alert("Please Enter Amount greater than 0");
                ValidationWindow(vAmtValidation, AlertType);
                
            document.getElementById('<%= txtAmount.ClientID %>').value = '';
            document.getElementById('<%= txtAmount.ClientID %>').focus();
            return false;
        }

        if ((PaymentTypeID == "0") || (PaymentAmount == "")) {
            
                //alert("Payment Type and Amount Required");
                ValidationWindow(vAmtRequired, AlertType);
                return false;
            
        }
       // else if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
        else if (PaymentTypeID != "1" && PaymentMethodNumber == "") {
           
                //alert("Please Enter Cheque/Card Number");
                ValidationWindow(vCardNo, AlertType);
            document.getElementById('<%= txtNumber.ClientID %>').focus();
            return false;
        }
      //  else if (PaymentName != 'Cash' && PaymentBankType == "") {
        else if (PaymentTypeID != "1" && PaymentBankType == "") {
           
           
                //alert("Please Enter Bank Name/Card Type");
                ValidationWindow(vCartType, AlertType);
                
            document.getElementById('<%= txtBankType.ClientID %>').focus();
            return false;
        }
        else if (CardHolderName == "" && PaymentTypeID == "3") {
            // alert("Please enter the cheque valid Date");
            ValidationWindow(vCardHolderName, AlertType);
            document.getElementById('<%= txtCardHolderName.ClientID %>').value = "";
            return false;

        }
        else if (PaymentTypeID == "10" && Units == "") {
            
                //alert("Please Enter Coupon Units");
                ValidationWindow(vCouponUnits, AlertType);
               
            document.getElementById('<%= txtUnits.ClientID %>').focus();
            return false;
        }
       // else if (IsEMI == "Y" && EMIROI == "" && PaymentName != 'Cash' && PaymentName != 'Coupon') {
        else if (IsEMI == "Y" && EMIROI == "" && PaymentTypeID != "1" && PaymentTypeID != "10") {
            
          
                //alert("Please enter Rate of Interest for EMI");
                ValidationWindow(vEMI, AlertType);
                return false;
            
        }
       // else if (IsEMI == "Y" && EMITenor == "" && PaymentName != 'Cash' && PaymentName != 'Coupon') {
        else if (IsEMI == "Y" && EMITenor == "" && PaymentTypeID != "1" && PaymentTypeID != "10") {
            
                //alert("Please enter the Tenor of Interest");
                ValidationWindow(vTenorIntrest, AlertType);
                return false;
           
        }
      //  else if (PaymentName == "Cheque" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {
        else if (PaymentTypeID == "2" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {

            //alert("Cheque no should be last " + MaxLength + " numbers");
            ValidationWindow(vCheque + " " + MaxLength + " " + vNo, AlertType);
            document.getElementById('<%= txtNumber.ClientID %>').value = "";
            return false;

        }
       // else if (PaymentName == "Credit/Debit Card" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {
        else if (PaymentTypeID == "3" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {

            //alert(" Card no should be last " + MaxLength + " numbers");
            ValidationWindow(vCardNoLast + "" + MaxLength + "" + MaxLength, AlertType);
            document.getElementById('<%= txtNumber.ClientID %>').value = "";
            return false;

        }
        //else if (ChequeValidDate == "" && PaymentName == "Cheque") {
        else if (ChequeValidDate == "" && PaymentTypeID == "2") {
            // alert("Please enter the cheque valid Date");
            ValidationWindow(vChequeValidate, AlertType);
            document.getElementById('<%= txtDate.ClientID %>').value = "";
            return false;

        }
       // else if (PaymentName == "Cheque" && (parseInt(GetTotalDays) < parseInt(diffDays) || (GetDate.getTime(TodayYear, TodayMonth, TodayDay) > TargetDate.getTime(Year, month, day)))) {
//        else if (PaymentTypeID == "2" && (parseInt(GetTotalDays) < parseInt(diffDays) || (GetDate.getTime(TodayYear, TodayMonth, TodayDay) > TargetDate.getTime(Year, month, day)))) {
//            //alert("Please enter the Valid cheque Date");
//            ValidationWindow("You have selected the past date.Please ensure.", AlertType);
//            document.getElementById('<%= txtDate.ClientID %>').value = "";
//        //    return false;

//        }
       // else if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
        else if (PaymentTypeID != "1" && PaymentMethodNumber == "") {
            
                //alert("Please Enter Cheque/Card Number");
                ValidationWindow(vCardNo, AlertType);
                
            document.getElementById('<%= txtNumber.ClientID %>').focus();
            return false;
        }
        //else if (PaymentBankType == "" && PaymentName != "Cash") {
        else if (PaymentBankType == "" && PaymentTypeID != "1") {
           
                //alert("Please Enter Bank Name/Card Type");
                ValidationWindow(vCartType, AlertType);
                
            document.getElementById('<%= txtBankType.ClientID %>').value = "";
            document.getElementById('<%= txtBankType.ClientID %>').focus();
            return false;
        }
        else {
            if (PaymentTypeID == "2" && (parseInt(GetTotalDays) < parseInt(diffDays) || (GetDate.getTime(TodayYear, TodayMonth, TodayDay) > TargetDate.getTime(Year, month, day)))) {
                //alert("Please enter the Valid cheque Date");
                ValidationWindow("You have selected the past date.Please ensure.", AlertType);
                //return true;

            }
            var AlreadypaymentModeExisits = 0;
            var CardNoExist = 0;
            var AlreadyPaymentModeValidation = document.getElementById('<%= hdfPaymentType.ClientID %>').value
            if (AlreadyPaymentModeValidation != "") {
                var x = AlreadyPaymentModeValidation.split("|");
                for (j = 0; j < x.length; j++) {
                    if (x[j] != "") {
                        var val = x[j].split("~");
                        if (val[6].split("^")[1] == PaymentMethodNumber && val[7].split("^")[1] != PaymentBankType) {
                            CardNoExist = 1;
                            break;
                        }
                        if (PaymentTypeID != "1" && (val[9].split("^")[1] == PaymentTypeID && val[6].split("^")[1] == PaymentMethodNumber && val[7].split("^")[1] == PaymentBankType)) {
                            AlreadypaymentModeExisits = 1;
                            break;
                        }
                    }
                }
            }

            if (AlreadypaymentModeExisits == 1) {
                //alert('Cash Payment mode already exists, Kindly edit then add amount');
				ValidationWindow(vCashAlerdyExists, AlertType);
                return false;
            }
            if (CardNoExist == 1) {
                //alert('The Payment details already exists, Kindly change Card details');
                ValidationWindow(DispPay, AlertType);
                return false;
            }
            PaymentAmount = format_number(PaymentAmount, 2);
            //if (PaymentName != 'Cash') {
            if (PaymentTypeID != "1") {
                ServiceCharge = format_number(ServiceCharge, 2);
            }
            var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>'));
            //document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
            if (Number(PaymentAmount) >= 0) {
                var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                if (returnType == true && IsEMI == "N") {
                    var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                    document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                    PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));
                    document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                    ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));
                    document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                    TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));
                    document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                    OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));
                    var retval = PaymentName + "~"
                    + PaymentAmount + "~"
                    + PaymentMethodNumber + "~"
                    + PaymentBankType + "~"
                    + PaymentRemarks + "~"
                    + PaymentTypeID + "~"
                    + ChequeValidDate + "~"
                    + ServiceCharge + "~"
                    + TotalAmount + "~"
                    + OtherCurrAmt + "~"
                    + EMIROI + "~"
                    + EMITenor + "~"
                    + EMIValue + "~"
                    + Units + "~"
                    + ReferenceID + "~"
                    + ReferenceType + "~"
                    + CardHolderName + "~"
                    + AmtReceivedID;
                    //                    var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                    //                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                    //                                    + "~" + ServiceCharge + "~" + TotalAmount + "~" + OtherCurrAmt + "~" + EMIROI + "~" + EMITenor + "~" + EMIValue + "~" + Units + "~" + ReferenceID + "~" + ReferenceType + "~" + CardHolderName;

                    document.getElementById('<%= hdnlastreceivedamt.ClientID %>').value = Number(ToInternalFormat($('#<%= hdnlastreceivedamt.ClientID %>'))) + Number(TotalAmount);
                    ToTargetFormat($('#<%= hdnlastreceivedamt.ClientID %>'))
                    CmdAddPaymentType_onclick(retval);
                    return true;
                }

                //check for EMI
                else if (returnType == true && IsEMI == "Y") {

                    var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                    // formula for EMIVAlue =E = P×r×(1 + r)n/((1 + r)n - 1)
                    //P-Amount,r-Rateofintrest,n-Tenor
                    var TotEMI = (TotalAmount * EMIROI / 100);
                    var MonthEMI = TotEMI / 12;
                    var TenureEMI = Number(MonthEMI) * Number(EMITenor);
                    var temp = Number(TotalAmount) + Number(TenureEMI);
                    if (temp != 0) {
                        var EMIValue = (Number(temp) / Number(EMITenor)).toFixed(2);
                    }
                    else {
                        var EMIValue = 0;
                    }

                    document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                    PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                    ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                    TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                    OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));
                    var retval = PaymentName + "~"
                    + PaymentAmount + "~"
                    + PaymentMethodNumber + "~"
                    + PaymentBankType + "~"
                                    + PaymentRemarks + "~"
                                    + PaymentTypeID + "~"
                                    + ChequeValidDate + "~"
                                    + ServiceCharge + "~"
                                    + TotalAmount + "~"
                                    + OtherCurrAmt + "~"
                                    + EMIROI + "~"
                                    + EMITenor + "~"
                                    + EMIValue + "~"
                                    + Units + "~"
                                    + ReferenceID + "~"
                                    + ReferenceType + "~"
                                    + CardHolderName;
                    document.getElementById('<%= hdnlastreceivedamt.ClientID %>').value = Number(ToInternalFormat($('#<%= hdnlastreceivedamt.ClientID %>'))) + Number(TotalAmount);
                    ToTargetFormat($('#<%= hdnlastreceivedamt.ClientID %>'))
                    CmdAddPaymentType_onclick(retval);
                    return true;
                }

                //END 
            }
            else {
              
                
                    //alert("Amont should be greater than zero");
                    ValidationWindow(vAmtValidation, AlertType);
                    return false;
                
            }
        }
        return false;
    }
    function PaymentsValidation() {
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vAmtValidation = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04') == null ? "Amount should be greater than zero" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04');

        var alertpayment = false;
        var IsEMI = document.getElementById('<%=hdnEMI.ClientID %>').value;
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        //var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value.split('~')[0];
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = ToInternalFormat($('#<%= txtAmount.ClientID %>'));  //document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = ToInternalFormat($('#<%= txtServiceCharge.ClientID %>'));  // document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = ToInternalFormat($('#<%= txtTotalAmount.ClientID %>'));  //document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;
        //        var Units = document.getElementById('<%= txtUnits.ClientID %>').value;
        //        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        //        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        var Units = document.getElementById('<%= txtUnits.ClientID %>').value == "" ? "0" : document.getElementById('<%= txtUnits.ClientID %>').value;
        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        var EMIROI = document.getElementById('<%= txtROI.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtROI.ClientID %>').value;
        var EMITenor = document.getElementById('<%= txtTenor.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtTenor.ClientID %>').value;
        var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>'))//; document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        var CardHolderName = document.getElementById('<%= txtCardHolderName.ClientID %>').value
        if (Number(PaymentAmount) >= 0) {
            var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
            if (returnType == true && IsEMI == "N") {
                var OtherCurrAmt = Number(TotalAMount) * Number(OtherCurrencyRate);

                document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAMount + "~" + OtherCurrAmt + "~" + EMIROI + "~" + EMITenor + "~" + EMIValue + "~" + Units + "~" + ReferenceID + "~" + ReferenceType + "~" + CardHolderName;
                CmdAddPaymentType_onclick(retval);
                return true;
            }
            if (returnType == true && IsEMI == "Y") {
                var OtherCurrAmt = Number(TotalAMount) * Number(OtherCurrencyRate);
                // formula for EMIVAlue =E = P×r×(1 + r)n/((1 + r)n - 1)
                var TotEMI = (TotalAmount * EMIROI / 100);
                var MonthEMI = TotEMI / 12;
                var TenureEMI = Number(MonthEMI) * Number(EMITenor);
                var temp = Number(TotalAmount) + Number(TenureEMI);
                if (temp != 0) {
                    var EMIValue = (Number(temp) / Number(EMITenor)).toFixed(2);
                }
                else {
                    var EMIValue = 0;
                }

                document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));


                // var EMIValue = (TotalAmount * (EMIROI*(EMIROI/100)) * (1 + (EMIROI*EMIROI/100)) * (EMITenor) / (1 + (EMIROI*(EMIROI/100)) * (EMITenor - 1))).toFixed(2);
                var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAMount + "~" + OtherCurrAmt + "~" + EMIROI + "~" + EMITenor + "~" + EMIValue + "~" + Units + "~" + ReferenceID + "~" + ReferenceType + "~" + CardHolderName;
                CmdAddPaymentType_onclick(retval);
                return true;
            }

        }
        else {
           
           
                //alert("Amuont should be greater than zero");
                ValidationWindow(vAmtValidation, AlertType);
                return false;
           
        }
    }
    function CmdAddPaymentType_onclick(gotValue) {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vPaymentName = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_15') == null ? "Payment Name already exists" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_15');
        var PaymentViewStateValue = document.getElementById('<%= hdfPaymentType.ClientID %>').value;

        var PaymentarrayGotValue = new Array();
        PaymentarrayGotValue = gotValue.split('~');
        var PaymentName,
        PaymentAmount,
        PaymentMethodNumber,
        PaymentBankType,
        PaymentRemarks,
        PaymentTypeID,
        ChequeValidDate,
        ServiceCharge,
        TotalAmount,
        OtherCurrAmt,
        EMIROI,
        EMITenor,
        EMIValue,
        Units,
        ReferenceID,
        ReferenceType,
        CardHolderName,
        AmtReceivedID;

        if (PaymentarrayGotValue.length > 0) {
            PaymentName = PaymentarrayGotValue[0];
            PaymentAmount = PaymentarrayGotValue[1];
            PaymentMethodNumber = PaymentarrayGotValue[2];
            PaymentBankType = PaymentarrayGotValue[3];
            PaymentRemarks = PaymentarrayGotValue[4];
            PaymentTypeID = PaymentarrayGotValue[5];
            ChequeValidDate = PaymentarrayGotValue[6];
            ServiceCharge = PaymentarrayGotValue[7];
            TotalAmount = PaymentarrayGotValue[8];
            OtherCurrAmt = PaymentarrayGotValue[9];
            EMIROI = PaymentarrayGotValue[10];
            EMITenor = PaymentarrayGotValue[11];
            EMIValue = PaymentarrayGotValue[12];
            Units = PaymentarrayGotValue[13];
            ReferenceID = PaymentarrayGotValue[14];
            ReferenceType = PaymentarrayGotValue[15];
            CardHolderName = PaymentarrayGotValue[16];
            AmtReceivedID = PaymentarrayGotValue[17];
        }
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;

        if (iPaymentAlreadyPresent == 0) {
            PaymentViewStateValue += "RID^" + 0
            + "~PaymentNAME^" + PaymentName
            + "~EMIROI^" + EMIROI
            + "~EMITenor^" + EMITenor
            + "~EMIValue^" + EMIValue
            + "~PaymentAmount^" + PaymentAmount
            + "~PaymenMNumber^" + PaymentMethodNumber
            + "~PaymentBank^" + PaymentBankType
            + "~PaymentRemarks^" + PaymentRemarks
            + "~PaymentTypeID^" + PaymentTypeID
            + "~ChequeValidDate^" + ChequeValidDate
            + "~ServiceCharge^" + ServiceCharge
            + "~TotalAmount^" + TotalAmount
            + "~OtherCurrAmt^" + OtherCurrAmt
            + "~Units^" + Units
            + "~ReferenceID^" + ReferenceID
            + "~ReferenceType^" + ReferenceType
            + "~CardHolderName^" + CardHolderName
            + "~AmtReceivedID^" + AmtReceivedID + "|";
            document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymentViewStateValue;
            CreatePaymentTables();
            PaymentControlclear();
            if (document.getElementById("uctrlBillSearch_Update") != null) {
                document.getElementById("uctrlBillSearch_Update").disabled = false;
            }

        }
        else {
           
                //alert("Payment Name already exists");
                ValidationWindow(vPaymentName, AlertType);
                return false;
            
        }

    }

    function CreatePaymentTables() {
        //debugger;
        var DispAmountReceivedID = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_18') == null ? "AmountReceivedID" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_18');
        var IsEMI = document.getElementById('<%=hdnEMI.ClientID %>').value;
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML = "";
        var newPaymentTables, startPaymentTag, endPaymentTag;
        var PaymentViewStateValue = document.getElementById('<%= hdfPaymentType.ClientID %>').value;
        var x = PaymentViewStateValue.split("|");
        var Row = 1;
        PaymentViewStateValue = "";
        for (j = 0; j < x.length; j++) {
            if (x[j] != "") {

                var val = x[j].split("~");
                if (val[0].split("^")[0] == "RID")//^" + 0 +
                {
                    //"RID^0~PaymentNAME^Cash~PaymentAmount^2.00~PaymenMNumber^~PaymentBank^~PaymentRemarks^~PaymentTypeID^1~ServiceCharge^0~TotalAmount^2.00|RID^0~PaymentNAME^Cash~PaymentAmount^2.00~PaymenMNumber^~PaymentBank^~PaymentRemarks^~PaymentTypeID^1~ServiceCharge
                    //RID^1PaymentNAME^CashPaymentAmount^2.00PaymenMNumber^PaymentBank^PaymentRemarks^PaymentTypeID^1ServiceCharge^0TotalAmount^2.00|
                    PaymentViewStateValue += "RID^" + Row + "~"
                    + val[1] + "~"
                    + val[2] + "~"
                    + val[3] + "~"
                    + val[4] + "~"
                    + val[5] + "~"
                    + val[6] + "~"
                    + val[7] + "~"
                    + val[8] + "~"
                    + val[9] + "~"
                    + val[10] + "~"
                    + val[11] + "~"
                    + val[12] + "~"
                    + val[13] + "~"
                    + val[14] + "~"
                    + val[15] + "~"
                    + val[16] + "~"
                    + val[17] + "~"
                    + val[18] + "|";

                    Row = Number(Row) + 1;
                }
            }
        }

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymentViewStateValue;

        if ('<%= EnabledCurrType %>' == true) {
            document.getElementById('<%= ddCurrency.ClientID %>').disabled = false;
        }

        if (x.length == 1) {
            document.getElementById('<%= ddCurrency.ClientID %>').disabled = false;
        }
        var TotalAmount = 0;
        var EMIValue = 0;
        var Units = 0;
        var AmtReceivedIDDisp = SListForAppDisplay.Get("CommonControls_PaymentTypeDetails_ascx_17") == null ? "AmtReceivedID" : SListForAppDisplay.Get("CommonControls_PaymentTypeDetails_ascx_17");
        startPaymentTag = '';
        if (IsEMI == "Y") {

            startPaymentTag = "<TABLE ID='tabDrg1' Border='1' class='w-100p' style='BackgroundColor:#ff6600;' ><TBODY><tr><td > " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Type_1 %>" + "</td><td Style='display:block'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EMIROI_1 %>" + "</td><td>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EMITenor_1 %>" + "</td><td>>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EMIValue_1 %>" + "</td><td >" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Amount_1 %>" + "</td> <td > " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ChequeCardDDNo_1 %>" + " </td> <td > " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_BankCardType_1 %>" + "</td> <td > " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ServiceCharge_1 %>" + "  </td><td style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Remarks_1 %>" + "</td><td > " + "Date" + "</td><td>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_TotalAmount_1  %>" + "</td><td></td><td style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Units_1 %>" + "</td><td style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ReferenceID_1 %>" + "</td><td style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ReferenceType_1 %>" + "</td><td style='display:block'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CardHolderName_1 %>" + "</td> <td> " + DispAmountReceivedID + " </td>" + "<td></td> </tr>";
            endPaymentTag = "</TBODY></TABLE>";
            newPaymentTables = startPaymentTag;

            var arrayPaymentMainData = new Array();
            var arrayPaymentSubData = new Array();
            var arrayPaymentChildData = new Array();
            var iarrayPMainDataCount = 0;
            var iarrayPSubDataCount = 0;

            arrayPaymentMainData = PaymentViewStateValue.split('|');
            if (arrayPaymentMainData.length > 0) {

                for (iarrayPMainDataCount = 0; iarrayPMainDataCount < arrayPaymentMainData.length - 1; iarrayPMainDataCount++) {

                    arrayPaymentSubData = arrayPaymentMainData[iarrayPMainDataCount].split('~');
                    for (iarrayPSubDataCount = 0; iarrayPSubDataCount < arrayPaymentSubData.length; iarrayPSubDataCount++) {
                        arrayPaymentChildData = arrayPaymentSubData[iarrayPSubDataCount].split('^');
                        if (arrayPaymentChildData.length > 0) {

                            if (arrayPaymentChildData[0] == "RID") {
                                RID = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentNAME") {
                                PaymentName = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentAmount") {
                                PaymentAmount = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymenMNumber") {
                                PaymentMethodNumber = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentBank") {
                                PaymentBankType = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentRemarks") {
                                PaymentRemarks = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentTypeID") {
                                PaymentTypeID = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ChequeValidDate") {
                                ChequeValidDate = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ServiceCharge") {
                                ServiceCharge = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "TotalAmount") {
                                TotalAmount = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "OtherCurrAmt") {
                                OtherCurrAmt = arrayPaymentChildData[1];
                            }

                            if (arrayPaymentChildData[0] == "EMIROI") {
                                EMIROI = arrayPaymentChildData[1];
                            }

                            if (arrayPaymentChildData[0] == "EMITenor") {
                                EMITenor = arrayPaymentChildData[1];
                            }

                            if (arrayPaymentChildData[0] == "EMIValue") {
                                EMIValue = arrayPaymentChildData[1];
                            }

                            if (arrayPaymentChildData[0] == "Units") {
                                Units = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ReferenceID") {
                                ReferenceID = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ReferenceType") {
                                ReferenceType = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "CardHolderName") {
                                CardHolderName = arrayPaymentChildData[1];
                            }

                        }
                    }
                    var chkBoxName = "RID^" + RID
                    + "~PaymentNAME^" + PaymentName
                    + "~EMIROI^" + EMIROI
                    + "~EMITenor^" + EMITenor
                    + "~EMIValue^" + EMIValue
                    + "~PaymentAmount^" + PaymentAmount
                    + "~PaymenMNumber^" + PaymentMethodNumber
                    + "~PaymentBank^" + PaymentBankType
                    + "~PaymentRemarks^" + PaymentRemarks
                    + "~PaymentTypeID^" + PaymentTypeID
                    + "~ChequeValidDate^" + ChequeValidDate
                    + "~ServiceCharge^" + ServiceCharge
                    + "~TotalAmount^" + TotalAmount
                    + "~OtherCurrAmt^" + OtherCurrAmt
                    + "~Units^" + Units
                    + "~ReferenceID^" + ReferenceID
                    + "~ReferenceType^" + ReferenceType
                    + "~CardHolderName^" + CardHolderName + "";

                    if (PaymentAmount != 0) {
                        document.getElementById('<%= ddCurrency.ClientID %>').disabled = true;
                        newPaymentTables += "<TR><TD >" + PaymentName + "</TD>";
                        newPaymentTables += "<TD >" + EMIROI + "</TD>";
                        newPaymentTables += "<TD >" + EMITenor + "</TD>";
                        newPaymentTables += "<TD >" + EMIValue + "</TD>";
                        newPaymentTables += "<TD >" + PaymentAmount + "</TD>";
                        newPaymentTables += "<TD >" + PaymentMethodNumber + "</TD>";
                        newPaymentTables += "<TD >" + PaymentBankType + "</TD>";
                        newPaymentTables += "<TD >" + ChequeValidDate + "</TD>";
                        newPaymentTables += "<TD >" + ServiceCharge + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + PaymentRemarks + "</TD>";
                        newPaymentTables += "<TD >" + TotalAmount + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + Units + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + ReferenceID + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + ReferenceType + "</TD>";
                        newPaymentTables += "<TD style='Display:block;'>" + CardHolderName + "</TD>";
                        newPaymentTables += "<TD><input name='RID^" + RID
                        + "~PaymentNAME^" + PaymentName
                        + "~EMIROI^" + EMIROI
                        + "~EMITenor^" + EMITenor
                        + "~EMIValue^" + EMIValue
                        + "~PaymentAmount^" + PaymentAmount
                        + "~PaymenMNumber^" + PaymentMethodNumber
                        + "~PaymentBank^" + PaymentBankType
                        + "~PaymentRemarks^" + PaymentRemarks
                        + "~PaymentTypeID^" + PaymentTypeID
                        + "~ChequeValidDate^" + ChequeValidDate
                        + "~ServiceCharge^" + ServiceCharge
                        + "~TotalAmount^" + TotalAmount
                        + "~OtherCurrAmt^" + OtherCurrAmt
                        + "~Units^" + Units
                        + "~ReferenceID^" + ReferenceID
                        + "~ReferenceType^" + ReferenceType
                        + "~CardHolderName^" + CardHolderName
                        + "' onclick='btnPaymentEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EDIT_1 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />|<input name='RID^" + RID
                        + "~PaymentNAME^" + PaymentName
                        + "~EMIROI^" + EMIROI
                        + "~EMITenor^" + EMITenor
                        + "~EMIValue^" + EMIValue
                        + "~PaymentAmount^" + PaymentAmount
                        + "~PaymenMNumber^" + PaymentMethodNumber
                        + "~PaymentBank^" + PaymentBankType
                        + "~PaymentRemarks^" + PaymentRemarks
                        + "~PaymentTypeID^" + PaymentTypeID
                        + "~ChequeValidDate^" + ChequeValidDate
                        + "~ServiceCharge^" + ServiceCharge
                        + "~TotalAmount^" + TotalAmount
                        + "~OtherCurrAmt^" + OtherCurrAmt
                        + "~Units^" + Units + "~ReferenceID^" + ReferenceID
                        + "~ReferenceType^" + ReferenceType
                        + "~CardHolderName^" + CardHolderName
                        + "' onclick='btnPaymentDelete_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Delete_1 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
                    }
                }
            }

            newPaymentTables += endPaymentTag;
            document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML += newPaymentTables;
        }


        else {
            startPaymentTag = "<TABLE  ID='tabDrg1' Border='1' class='w-100p gridView'><TBODY><tr class='gridHeader'><td>"
            + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Type_2 %>"
            + "</td><td Style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EMIROI_2 %>"
            + "</td><td Style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EMITenor_2 %>"
            + "</td><td Style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EMIValue_2 %>"
            + "</td><td> " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Amount_2 %>"
            + "</td><td>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ChequeCardDDNo_2 %>"
            + "</td><td> " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_BankCardType_2 %>"
            + "</td><td> " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Date_1 %>"
            + "</td><td> " + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ServiceCharge_2 %>"
            + "</td><td style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Remarks_2 %>"
            + "</td><td>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_TotalAmount_2 %>"
            + "</td><td  style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Units_2 %>"
            + "</td><td style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ReferenceID_2 %>"
            + "</td><td style='display:none'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ReferenceType_2 %>"
            + "</td><td>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CardHolderName_1 %>"
            + "</td><td>"+"<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CardHolderName_15 %>"+"</td><td style='display:none'>" + AmtReceivedIDDisp
            + "</td> </tr>";
            endPaymentTag = "</TBODY></TABLE>";
            newPaymentTables = startPaymentTag;

            var arrayPaymentMainData = new Array();
            var arrayPaymentSubData = new Array();
            var arrayPaymentChildData = new Array();
            var iarrayPMainDataCount = 0;
            var iarrayPSubDataCount = 0;

            arrayPaymentMainData = PaymentViewStateValue.split('|');
            if (arrayPaymentMainData.length > 0) {

                for (iarrayPMainDataCount = 0; iarrayPMainDataCount < arrayPaymentMainData.length - 1; iarrayPMainDataCount++) {

                    arrayPaymentSubData = arrayPaymentMainData[iarrayPMainDataCount].split('~');
                    for (iarrayPSubDataCount = 0; iarrayPSubDataCount < arrayPaymentSubData.length; iarrayPSubDataCount++) {
                        arrayPaymentChildData = arrayPaymentSubData[iarrayPSubDataCount].split('^');
                        if (arrayPaymentChildData.length > 0) {

                            if (arrayPaymentChildData[0] == "RID") {
                                RID = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentNAME") {
                                PaymentName = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "EMIROI") {
                                EMIROI = arrayPaymentChildData[1];
                            }

                            if (arrayPaymentChildData[0] == "EMITenor") {
                                EMITenor = arrayPaymentChildData[1];
                            }

                            if (arrayPaymentChildData[0] == "EMIValue") {
                                EMIValue = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentAmount") {
                                PaymentAmount = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymenMNumber") {
                                PaymentMethodNumber = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentBank") {
                                PaymentBankType = arrayPaymentChildData[1];
                            }

                            if (arrayPaymentChildData[0] == "PaymentRemarks") {
                                PaymentRemarks = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "PaymentTypeID") {
                                PaymentTypeID = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ChequeValidDate") {
                                ChequeValidDate = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ServiceCharge") {
                                ServiceCharge = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "TotalAmount") {
                                TotalAmount = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "OtherCurrAmt") {
                                OtherCurrAmt = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "Units") {
                                Units = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ReferenceID") {
                                ReferenceID = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "ReferenceType") {
                                ReferenceType = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "CardHolderName") {
                                CardHolderName = arrayPaymentChildData[1];
                            }
                            if (arrayPaymentChildData[0] == "AmtReceivedID") {
                                AmtReceivedID = arrayPaymentChildData[1];
                            }

                        }
                    }

                    var chkBoxName = "RID^" + RID
                    + "~PaymentNAME^" + PaymentName
                    + "~EMIROI^" + EMIROI
                    + "~EMITenor^" + EMITenor
                    + "~EMIValue^" + EMIValue
                    + "~PaymentAmount^" + PaymentAmount
                    + "~PaymenMNumber^" + PaymentMethodNumber
                    + "~PaymentBank^" + PaymentBankType
                    + "~PaymentRemarks^" + PaymentRemarks
                    + "~PaymentTypeID^" + PaymentTypeID
                    + "~ChequeValidDate^" + ChequeValidDate
                    + "~ServiceCharge^" + ServiceCharge
                    + "~TotalAmount^" + TotalAmount
                    + "~OtherCurrAmt^" + OtherCurrAmt
                    + "~Units^" + Units
                    + "~ReferenceID^" + ReferenceID
                    + "~ReferenceType^" + ReferenceType
                    + "~CardHolderName^" + CardHolderName
                    + "~AmtReceivedID^" + AmtReceivedID + "";
                    if (PaymentAmount != 0) {
                        document.getElementById('<%= ddCurrency.ClientID %>').disabled = true;
                        newPaymentTables += "<TR><TD >" + PaymentName + "</TD>";
                        newPaymentTables += "<TD >" + PaymentAmount + "</TD>";
                        newPaymentTables += "<TD >" + PaymentMethodNumber + "</TD>";
                        newPaymentTables += "<TD >" + PaymentBankType + "</TD>";
                        newPaymentTables += "<TD >" + ChequeValidDate + "</TD>";
                        newPaymentTables += "<TD >" + ServiceCharge + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + PaymentRemarks + "</TD>";

                        newPaymentTables += "<TD >" + TotalAmount + "</TD>";

                        newPaymentTables += "<TD style='Display:none;' >" + Units + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + ReferenceID + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + ReferenceType + "</TD>";
                        newPaymentTables += "<TD style='Display:block;'>" + CardHolderName + "</TD>";
                        newPaymentTables += "<TD style='Display:none;'>" + AmtReceivedID + "</TD>";

                        newPaymentTables += "<TD><input name='RID^" + RID
                        + "~PaymentNAME^" + PaymentName
                        + "~EMIROI^" + EMIROI
                        + "~EMITenor^" + EMITenor
                        + "~EMIValue^" + EMIValue
                        + "~PaymentAmount^" + PaymentAmount
                        + "~PaymenMNumber^" + PaymentMethodNumber
                        + "~PaymentBank^" + PaymentBankType
                        + "~PaymentRemarks^" + PaymentRemarks
                        + "~PaymentTypeID^" + PaymentTypeID
                        + "~ChequeValidDate^" + ChequeValidDate
                        + "~ServiceCharge^" + ServiceCharge
                        + "~TotalAmount^" + TotalAmount
                        + "~OtherCurrAmt^" + OtherCurrAmt
                        + "~Units^" + Units
                        + "~ReferenceID^" + ReferenceID
                        + "~ReferenceType^" + ReferenceType
                        + "~CardHolderName^" + CardHolderName
                        + "~AmtReceivedID^" + AmtReceivedID

                        + "' onclick='btnPaymentEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_EDIT_2%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />|<input name='RID^" + RID
                        + "~PaymentNAME^" + PaymentName
                        + "~EMIROI^" + EMIROI
                        + "~EMITenor^" + EMITenor
                        + "~EMIValue^" + EMIValue
                        + "~PaymentAmount^" + PaymentAmount
                        + "~PaymenMNumber^" + PaymentMethodNumber
                        + "~PaymentBank^" + PaymentBankType
                        + "~PaymentRemarks^" + PaymentRemarks
                        + "~PaymentTypeID^" + PaymentTypeID
                        + "~ChequeValidDate^" + ChequeValidDate
                        + "~ServiceCharge^" + ServiceCharge
                        + "~TotalAmount^" + TotalAmount
                        + "~OtherCurrAmt^" + OtherCurrAmt
                        + "~Units^" + Units + "~ReferenceID^"
                        + ReferenceID + "~ReferenceType^"
                        + ReferenceType + "~CardHolderName^"

                        + CardHolderName + "~AmtReceivedID^" + AmtReceivedID + "' class='deleteIcons' onclick='btnPaymentDelete_OnClick(name);' value ='<%=Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Delete_2 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
                    }
                }
            }

            newPaymentTables += endPaymentTag;
            document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML += newPaymentTables;
        }
        var ctrlPaymentType = document.getElementById('<%= ddlPaymentType.ClientID %>');

        var sPaymentType = trim(ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@')[0], ' ');

        if (sPaymentType != null)

            Paymentchanged();
        //document.getElementById('<%= ddlPaymentType.ClientID %>').focus();

        if (document.getElementById('<%= hdfPaymentType.ClientID %>').value != "") {
            document.getElementById('<%= trPaymentDetails.ClientID %>').style.display = "table-row";
        }
        else {
            document.getElementById('<%= trPaymentDetails.ClientID %>').style.display = "none";
        }
    }


    function btnPaymentEdit_OnClick(sEditedData) {
        if (document.getElementById('uctrlBillSearch_Update') != null) {
            document.getElementById("uctrlBillSearch_Update").disabled = true;
        }
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;
        var tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge;
        var lastRow = "N";

        var PaymenttempDatas = document.getElementById('<%= hdfPaymentType.ClientID %>').value;
        PaymentAAlreadyPresent = PaymenttempDatas.split('|');
        if (PaymentAAlreadyPresent.length > 0) {
            for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
                if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() == sEditedData.toLowerCase()) {
                    PaymentAAlreadyPresent[iPaymentCount] = "";
                }
            }
        }

        PaymenttempDatas = "";
        for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
            if (PaymentAAlreadyPresent[iPaymentCount] != "") {
                PaymenttempDatas += PaymentAAlreadyPresent[iPaymentCount] + "|";
            }
        }

        var PaymentarrayGotValue = new Array();
        var arrayPaymentName = new Array();
        var arrayAmount = new Array();
        var arrayChequeNo = new Array();
        var arrayBankName = new Array();
        var arrayRemarks = new Array();
        var arrayPaymentTypeID = new Array();
        var arrayDurationDaysCount = new Array();
        var arrayChequeValidDate = new Array();
        var arrayServiceCharge = new Array();
        var arrayTotalAmount = new Array();
        var arrayTotalUnits = new Array();
        var arrayReferenceID = new Array();
        var arrayReferenceType = new Array();
        var arrayEMIROI = new Array();
        var arrayEMITenure = new Array();


        PaymentarrayGotValue = sEditedData.split('~');
        var PaymentName,
        PaymentAmount,
        PaymentMethodNumber,
        PaymentBankType,
        PaymentRemarks,
        PaymentTypeID,
        ChequeValidDate,
        ServiceCharge,
        TotalAmount,
        EMIROI,
        EMITenure,
        TotalUnits,
        ReferenceID,
        ReferenceType,
        CardHolderName,
        AmtReceivedID;

        if (PaymenttempDatas.split('|').length == 1 || PaymenttempDatas == "") {
            lastRow = "Y";
        }
        //RID^1~PaymentNAME^Credit/Debit Card~EMIROI^4~EMITenor^12~EMIValue^48~PaymentAmount^100.00~PaymenMNumber^765757~PaymentBank^VIJAYA BANK
        //~PaymentRemarks^~PaymentTypeID^3~ServiceCharge^0.00~TotalAmount^100.00~OtherCurrAmt^100

        if (PaymentarrayGotValue.length > 0) {

            PaymentName = PaymentarrayGotValue[1];
            EMIROI = PaymentarrayGotValue[2];
            EMITenure = PaymentarrayGotValue[3];

            PaymentAmount = PaymentarrayGotValue[5];
            PaymentMethodNumber = PaymentarrayGotValue[6];
            PaymentBankType = PaymentarrayGotValue[7];
            PaymentRemarks = PaymentarrayGotValue[8];
            PaymentTypeID = PaymentarrayGotValue[9];
            ChequeValidDate = PaymentarrayGotValue[10];
            ServiceCharge = PaymentarrayGotValue[11];
            TotalAmount = PaymentarrayGotValue[12];

            TotalUnits = PaymentarrayGotValue[14];
            ReferenceID = PaymentarrayGotValue[15];
            ReferenceType = PaymentarrayGotValue[16];
            CardHolderName = PaymentarrayGotValue[17];
            AmtReceivedID = PaymentarrayGotValue[18];

            arrayPaymentName = PaymentName.split('^');
            arrayAmount = PaymentAmount.split('^');
            arrayChequeNo = PaymentMethodNumber.split('^');
            arrayBankName = PaymentBankType.split('^');
            arrayRemarks = PaymentRemarks.split('^');
            arrayPaymentTypeID = PaymentTypeID.split('^');
            arrayChequeValidDate = ChequeValidDate.split('^');
            arrayServiceCharge = ServiceCharge.split('^');
            arrayTotalAmount = TotalAmount.split('^');
            arrayEMIROI = EMIROI.split('^');
            arrayEMITenure = EMITenure.split('^');
            arrayTotalUnits = TotalUnits.split('^');
            arrayReferenceID = ReferenceID.split('^');
            arrayReferenceType = ReferenceType.split('^');
            arrayCardHolderName = CardHolderName.split('^');
            arrayAmtReceivedID = AmtReceivedID.split('^');

        }
        if (arrayAmtReceivedID.length > 0) {
            document.getElementById('<%= hdnAmtReceivedID.ClientID %>').value = arrayAmtReceivedID[1];
        }

        if (arrayPaymentName.length > 0) {
            var ddlPayType = document.getElementById('<%= ddlPaymentType.ClientID %>');
            for (var i = 0; i < ddlPayType.options.length; i++) {
                if (ddlPayType.options[i].value.split('~')[0] == arrayPaymentTypeID[1]) {
                    ddlPayType.selectedIndex = i;
                    break;
                }
            }
            // document.getElementById('<%= ddlPaymentType.ClientID %>').value = arrayPaymentTypeID[1];
        }
        if (arrayAmount.length > 0) {
            document.getElementById('<%= txtAmount.ClientID %>').value = arrayAmount[1];
            ToTargetFormat($('#<%= txtAmount.ClientID %>'));
            tmpPaymentAmount = arrayAmount[1];
        }
        if (arrayChequeNo.length > 0) {
            document.getElementById('<%= txtNumber.ClientID %>').value = arrayChequeNo[1];
        }
        if (arrayRemarks.length > 0) {
            document.getElementById('<%= txtBankType.ClientID %>').value = arrayBankName[1];
        }
        if (arrayBankName.length > 0) {
            document.getElementById('<%= txtRemarks.ClientID %>').value = arrayRemarks[1];
        }
        if (arrayChequeValidDate.length > 0) {
            document.getElementById('<%= txtDate.ClientID %>').value = arrayChequeValidDate[1];
        }
        if (arrayServiceCharge.length > 0) {
            document.getElementById('<%= txtServiceCharge.ClientID %>').value = parseInt(arrayServiceCharge[1]);
            ToTargetFormat($('#<%= txtServiceCharge.ClientID %>'));
            tmpServiceCharge = arrayServiceCharge[1];
        }
        if (arrayTotalAmount.length > 0) {
            document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = arrayTotalAmount[1];
            ToTargetFormat($('#<%= txtTotalAmount.ClientID %>'));
            tmpTotalAmount = arrayTotalAmount[1];
        }

        if (arrayEMIROI.length > 0) {
            document.getElementById('<%= txtROI.ClientID %>').value = arrayEMIROI[1];
            tmpEMIROI = arrayEMIROI[1];
        }

        if (arrayEMITenure.length > 0) {
            document.getElementById('<%= txtTenor.ClientID %>').value = arrayEMITenure[1];
            tmpEMITenure = arrayEMITenure[1];
        }


        if (arrayTotalUnits.length > 0) {
            document.getElementById('<%= txtUnits.ClientID %>').value = arrayTotalUnits[1];
        }
        if (arrayReferenceID.length > 0) {
            document.getElementById('<%= hdnReferenceID.ClientID %>').value = arrayTotalUnits[1];
        }
        if (arrayCardHolderName.length > 0) {
            document.getElementById('<%= txtCardHolderName.ClientID %>').value = arrayCardHolderName[1];
        }
        document.getElementById('<%= TempDataStore.ClientID %>').value = tmpPaymentAmount;
        tmpPaymentAmount = ToInternalFormat($('#<%= TempDataStore.ClientID %>'));
        document.getElementById('<%= TempDataStore.ClientID %>').value = tmpTotalAmount;
        tmpTotalAmount = ToInternalFormat($('#<%= TempDataStore.ClientID %>'));
        document.getElementById('<%= TempDataStore.ClientID %>').value = tmpServiceCharge;
        tmpServiceCharge = ToInternalFormat($('#<%= TempDataStore.ClientID %>'));


        DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;

        CreatePaymentTables();
        Paymentchanged();
        changeAmountValues();
    }

    function btnPaymentDelete_OnClick(sEditedData) {
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;
        var lastRow = "N";


        var PaymenttempDatas = document.getElementById('<%= hdfPaymentType.ClientID %>').value;
        PaymentAAlreadyPresent = PaymenttempDatas.split('|');
        if (PaymentAAlreadyPresent.length > 0) {
            for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
                if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() == sEditedData.toLowerCase()) {
                    PaymentAAlreadyPresent[iPaymentCount] = "";
                }
            }
        }
        PaymenttempDatas = "";
        for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
            if (PaymentAAlreadyPresent[iPaymentCount] != "") {
                PaymenttempDatas += PaymentAAlreadyPresent[iPaymentCount] + "|";
            }
        }
        var PaymentarrayGotValue = new Array();
        var arrayPaymentName = new Array();
        var arrayAmount = new Array();
        var arrayChequeNo = new Array();
        var arrayBankName = new Array();
        var arrayRemarks = new Array();
        var arrayPaymentTypeID = new Array();
        var arrayDurationDaysCount = new Array();
        var arrayChequeValidDate = new Array();
        var arrayServiceCharge = new Array();
        var arrayTotalAmount = new Array();
        var arrayEMIROI = new Array();
        var arrayEMITenure = new Array();

        PaymentarrayGotValue = sEditedData.split('~');
        var PaymentName,
        PaymentAmount,
        PaymentMethodNumber,
        PaymentBankType,
        PaymentRemarks,
        ChequeValidDate,
        PaymentTypeID,
        ServiceCharge,
        TotalAmount,
        EMIROI,
        EMITenure;
        if (PaymenttempDatas.split('|').length == 1 || PaymenttempDatas == "") {
            lastRow = "Y";
        }
        if (PaymentarrayGotValue.length > 0) {
            PaymentName = PaymentarrayGotValue[1];
            EMIROI = PaymentarrayGotValue[2];
            EMITenure = PaymentarrayGotValue[3];
            PaymentAmount = PaymentarrayGotValue[5];
            PaymentMethodNumber = PaymentarrayGotValue[6];
            PaymentBankType = PaymentarrayGotValue[7];
            PaymentRemarks = PaymentarrayGotValue[8];
            PaymentTypeID = PaymentarrayGotValue[9];

            ServiceCharge = PaymentarrayGotValue[11];
            ChequeValidDate = PaymentarrayGotValue[10];
            TotalAmount = PaymentarrayGotValue[12];

            TotalUnits = PaymentarrayGotValue[14];
            ReferenceID = PaymentarrayGotValue[15];
            ReferenceType = PaymentarrayGotValue[16];
            CardHolderName = PaymentarrayGotValue[17];

            arrayPaymentName = PaymentName.split('^');
            arrayAmount = PaymentAmount.split('^');
            arrayChequeNo = PaymentMethodNumber.split('^');
            arrayBankName = PaymentBankType.split('^');
            arrayRemarks = PaymentRemarks.split('^');
            arrayChequeValidDate = ChequeValidDate.split('^');
            arrayPaymentTypeID = PaymentTypeID.split('^');
            arrayServiceCharge = ServiceCharge.split('^');
            arrayTotalAmount = TotalAmount.split('^');
            arrayEMIROI = EMIROI.split('^');
            arrayEMITenure = EMITenure.split('^');
        }
        if (arrayAmount.length > 0) {
            tmpPaymentAmount = arrayAmount[1];
        }

        if (arrayServiceCharge.length > 0) {
            tmpServiceCharge = arrayServiceCharge[1];
        }
        if (arrayTotalAmount.length > 0) {
            lastRow
            tmpTotalAmount = arrayTotalAmount[1];
        }

        if (arrayEMIROI.length > 0) {
            tmpEMIROI = arrayEMIROI[1];
        }
        if (arrayEMITenure.length > 0) {
            tmpEMITenure = arrayEMITenure[1];
        }
        document.getElementById('<%= TempDataStore.ClientID %>').value = tmpPaymentAmount;
        tmpPaymentAmount = ToInternalFormat($('#<%= TempDataStore.ClientID %>'));
        document.getElementById('<%= TempDataStore.ClientID %>').value = tmpTotalAmount;
        tmpTotalAmount = ToInternalFormat($('#<%= TempDataStore.ClientID %>'));
        document.getElementById('<%= TempDataStore.ClientID %>').value = tmpServiceCharge;
        tmpServiceCharge = ToInternalFormat($('#<%= TempDataStore.ClientID %>'));


        DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);


        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;
        CreatePaymentTables();
        Paymentchanged();

    }

    function PaymentControlclear() {
        var slist = { ChequeCardDDNo: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ChequeCardDDNo_1 %>', BankCardType: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_BankCardType_1 %>', CouponNumber: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponNumber %>', Coupon: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Coupon %>', CouponName: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponName %>' };
        document.getElementById('<%= ddlPaymentType.ClientID %>').value = document.getElementById('<%= hdfDefaultPaymentMode.ClientID %>').value;
        document.getElementById('<%= txtAmount.ClientID %>').value = "";
        document.getElementById('<%= txtNumber.ClientID %>').value = "";
        document.getElementById('<%= txtBankType.ClientID %>').value = "";
        document.getElementById('<%= txtRemarks.ClientID %>').value = "";
        document.getElementById('<%= txtDate.ClientID %>').value = "";
        document.getElementById('<%= txtServiceCharge.ClientID %>').value = "0";
        document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = "";
        // document.getElementById('PaymentType_txtCardHolderName').value = "";
        // document.getElementById('billPart_PaymentType_txtCardHolderName').value = "";
        if (document.getElementById('billPart_PaymentType_txtCardHolderName') != null) {
            document.getElementById('billPart_PaymentType_txtCardHolderName').value = "";
        }
        else {
            document.getElementById('<%= txtCardHolderName.ClientID %>').value = "";
        }

        document.getElementById('<%= txtROI.ClientID %>').value = "";
        document.getElementById('<%= txtTenor.ClientID %>').value = "";
        if (document.getElementById('<%= ddlPaymentType.ClientID %>').value != 10) {
            document.getElementById('<%=Rs_Cheque_no.ClientID %>').innerHTML = slist.ChequeCardDDNo;
            document.getElementById('<%=Rs_Bank.ClientID %>').innerHTML = slist.BankCardType;
            document.getElementById('<%=lblUnits.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdtxtUnits.ClientID %>').style.display = 'none';

        }
        document.getElementById('<%= hdnPaymentDetails.ClientID %>').value = "";
        Paymentchanged();
    }

    function Paymentchanged() {
        var slist = { ChequeCardDDNo: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_ChequeCardDDNo_1 %>', BankCardType: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_BankCardType_1 %>', CouponNumber: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponNumber %>', Coupon: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_Coupon %>', CouponName: '<%= Resources.ClientSideDisplayTexts.CommonControls_PaymentTypeDetails_CouponName %>' };
        var IsEMI = 'N';
        var IsEMIConfig = document.getElementById('<%=hdnIsEMI.ClientID %>').value; //get Config Value isEMi or Not 

        if (IsEMIConfig == 'Y') {
            checkboxEMI();
            IsEMI = document.getElementById('<%=hdnEMI.ClientID %>').value; //if payment is emi based or not
        }

        var ctrlPaymentType = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var sPaymentType = trim(ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@')[0], ' ');
        var sPaymentTypeId = trim(ctrlPaymentType.options[ctrlPaymentType.selectedIndex].value.split('~')[0], ' ');
        var sPaymentIsRequired = trim(ctrlPaymentType.options[ctrlPaymentType.selectedIndex].value.split('~')[1], ' ');
        var sPaymentAmt = ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@')[1];
        var sLength = new Array();
        var sLength = ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@');
        var Amt = ToInternalFormat($('#<%= txtAmount.ClientID %>')); //        document.getElementById('<%= txtAmount.ClientID %>').value;
        var totAmt = ToInternalFormat($('#<%= txtTotalAmount.ClientID %>')); // document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;
        document.getElementById('<%= hdnIsRequired.ClientID %>').value = sPaymentIsRequired;
        if (sLength.length > 1) {
            sPaymentAmt = sPaymentAmt.split('%')[0];
            sPaymentAmt = Number(sPaymentAmt);

            var ServiceAmt = format_number((Number(Amt) * Number(sPaymentAmt)) / 100, 2);
            document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML =
            format_number(Number(ServiceAmt) + Number(Amt), 2);
            ToTargetFormat($('#<%= txtTotalAmount.ClientID %>'));

        }
        else {
            sPaymentAmt = 0;
            document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = format_number(Number(Amt), 2);
            ToTargetFormat($('#<%= txtTotalAmount.ClientID %>'));
        }
        //        if (sPaymentType != "Cheque") {
        //            document.getElementById('<%= txtServiceCharge.ClientID %>').value = sPaymentAmt;
        //            ToTargetFormat($('#<%= txtServiceCharge.ClientID %>'));
        //        }
        if (sPaymentTypeId == "1" && IsEMI == "N") {
            // if (sPaymentType == "Cash" && IsEMI == "N") {
            document.getElementById('<%= txtNumber.ClientID %>').style.display = 'None';
            document.getElementById('<%= txtBankType.ClientID %>').style.display = 'None';
            document.getElementById('<%= txtServiceCharge.ClientID %>').style.display = 'None';
            document.getElementById('<%=lblROI.ClientID %>').style.display = 'None';
            document.getElementById('<%=txtROI.ClientID %>').style.display = 'None';
            document.getElementById('<%=lblTenor.ClientID %>').style.display = 'None';
            document.getElementById('<%=txtTenor.ClientID %>').style.display = 'None';
            document.getElementById('<%=lblUnits.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdtxtUnits.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdCardHolder.ClientID %>').style.display = 'none';
            document.getElementById('<%=lblChequeDate.ClientID %>').style.display = 'None';
            document.getElementById('<%=tdtxtDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_Ser_Cha.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_CardHolderName.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_Cheque_no.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_Bank.ClientID %>').style.display = 'none';

            document.getElementById('<%= txtNumber.ClientID %>').value = '';
            document.getElementById('<%= txtBankType.ClientID %>').value = '';
            document.getElementById('<%= txtServiceCharge.ClientID %>').value = '';
            document.getElementById('<%=lblROI.ClientID %>').value = '';
            document.getElementById('<%=txtROI.ClientID %>').value = '';
            document.getElementById('<%=tdCardHolder.ClientID %>').value = '';
            document.getElementById('<%=lblChequeDate.ClientID %>').value = '';
            document.getElementById('<%=tdtxtDate.ClientID %>').value = '';
            document.getElementById('<%=Rs_Ser_Cha.ClientID %>').value = '';
            document.getElementById('<%=Rs_CardHolderName.ClientID %>').value = '';
            document.getElementById('<%=Rs_Cheque_no.ClientID %>').value = '';
            document.getElementById('<%=Rs_Bank.ClientID %>').value = '';

        }


        //  else if (sPaymentType == "Cash" && IsEMI == "Y") {

        else if (sPaymentTypeId == "1" && IsEMI == "Y") {

            document.getElementById('<%= txtNumber.ClientID %>').style.display = 'none';
            document.getElementById('<%= txtBankType.ClientID %>').style.display = 'none';
            document.getElementById('<%= txtServiceCharge.ClientID %>').style.display = 'none';
            document.getElementById('<%=lblROI.ClientID %>').style.display = 'none';
            document.getElementById('<%=txtROI.ClientID %>').style.display = 'none';
            document.getElementById('<%=lblTenor.ClientID %>').style.display = 'none';
            document.getElementById('<%=txtTenor.ClientID %>').style.display = 'none';
            document.getElementById('<%=lblUnits.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdtxtUnits.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdCardHolder.ClientID %>').style.display = 'none';
            document.getElementById('<%=lblChequeDate.ClientID %>').style.display = 'None';
            document.getElementById('<%=tdtxtDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_Ser_Cha.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_CardHolderName.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_Cheque_no.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_Bank.ClientID %>').style.display = 'none';
        }

        // else if (sPaymentType != "Cash" && sPaymentType != "Cheque" && IsEMI == "Y") {
        else if (sPaymentTypeId != "1" && sPaymentTypeId != "2" && IsEMI == "Y") {
            //            document.getElementById('<%= txtBankType.ClientID %>').value = sPaymentType;
            document.getElementById('<%= txtNumber.ClientID %>').style.display = 'Block';
            document.getElementById('<%= txtBankType.ClientID %>').style.display = 'Block';
            document.getElementById('<%= txtServiceCharge.ClientID %>').style.display = 'Block';
            document.getElementById('<%=lblROI.ClientID %>').style.display = 'Block';
            document.getElementById('<%=txtROI.ClientID %>').style.display = 'Block';
            document.getElementById('<%=lblTenor.ClientID %>').style.display = 'Block';
            document.getElementById('<%=txtTenor.ClientID %>').style.display = 'Block';
            document.getElementById('<%=lblUnits.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdtxtUnits.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdCardHolder.ClientID %>').style.display = 'none';
            document.getElementById('<%=lblChequeDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=tdtxtDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=Rs_Ser_Cha.ClientID %>').style.display = 'Block';
            document.getElementById('<%=Rs_CardHolderName.ClientID %>').style.display = 'Block';
            document.getElementById('<%=Rs_Cheque_no.ClientID %>').style.display = 'Block';
            document.getElementById('<%=Rs_Bank.ClientID %>').style.display = 'Block';

        }
       // else if (sPaymentType == "Coupon") {
        else if (sPaymentTypeId == "10") {
            document.getElementById('billPart_PaymentType_Rs_Cheque_no').innerHTML = slist.CouponNumber;
            document.getElementById('billPart_PaymentType_Rs_Bank').innerHTML = slist.CouponName;
            document.getElementById('billPart_PaymentType_txtNumber').style.display = 'Block';
            document.getElementById('billPart_PaymentType_lblChequeDate').style.display = 'none';
            document.getElementById('billPart_PaymentType_tdtxtDate').style.display = 'none';
            document.getElementById('billPart_PaymentType_txtBankType').style.display = 'Block';
            document.getElementById('billPart_PaymentType_lblUnits').style.display = 'block';
            document.getElementById('billPart_PaymentType_tdtxtUnits').style.display = 'block';
            document.getElementById('billPart_PaymentType_txtServiceCharge').style.display = 'none';
            document.getElementById('billPart_PaymentType_Rs_Ser_Cha').style.display = 'none';
            document.getElementById('billPart_PaymentType_hdnReferenceType').value = slist.Coupon;
            var sval;
            sval = '0' + '~' + sPaymentType;
            if ($find('billPart_PaymentType_AutoCompleteProduct') != null)
                $find('billPart_PaymentType_AutoCompleteProduct').set_contextKey(sval);
        }

        else {
         if (sPaymentTypeId == "11") {
           // if (sPaymentType == "Credit Note") {
                var sval;
                sval = '0' + '~' + 'sPaymentType';
                if ($find('<%= AutoCompleteProduct.ClientID %>') != null)
                    $find('<%= AutoCompleteProduct.ClientID %>').set_contextKey(sval);
                document.getElementById('<%=Rs_Cheque_no.ClientID %>').innerHTML = "CreditNote No";
                document.getElementById('<%=Rs_Bank.ClientID %>').style.display = 'none';
                document.getElementById('<%= txtBankType.ClientID %>').style.display = 'none'
            }
            else {
                document.getElementById('<%=Rs_Cheque_no.ClientID %>').innerHTML = slist.ChequeCardDDNo;
            }
            document.getElementById('<%=Rs_Bank.ClientID %>').innerHTML = slist.BankCardType;
            document.getElementById('<%= txtNumber.ClientID %>').style.display = 'Block';
           // if (sPaymentType == "Credit/Debit Card" && sPaymentType != "Cheque") {
            if (sPaymentTypeId == "3" && sPaymentTypeId != "2") {
                document.getElementById('<%=tdCardHolder.ClientID %>').style.display = 'block';
            }
            else {
                document.getElementById('<%=tdCardHolder.ClientID %>').style.display = 'none';
            }
            document.getElementById('<%= txtBankType.ClientID %>').style.display = 'Block';
            document.getElementById('<%= txtServiceCharge.ClientID %>').style.display = 'Block';
            document.getElementById('<%=lblROI.ClientID %>').style.display = 'none';
            document.getElementById('<%=txtROI.ClientID %>').style.display = 'none';
            document.getElementById('<%=lblTenor.ClientID %>').style.display = 'none';
            document.getElementById('<%=txtTenor.ClientID %>').style.display = 'none';

           // document.getElementById('<%=lblChequeDate.ClientID %>').style.display = sPaymentType == "Cheque" ? "block" : "none";
            document.getElementById('<%=lblChequeDate.ClientID %>').style.display = sPaymentTypeId == "2" ? "block" : "none";
            document.getElementById('<%=tdtxtDate.ClientID %>').style.display = sPaymentTypeId == "2" ? "block" : "none"; ;
            document.getElementById('<%=Rs_Ser_Cha.ClientID %>').style.display = 'Block';
           // if (sPaymentType == "Credit/Debit Card" && sPaymentType != "Cheque") {
            if (sPaymentTypeId == "3" && sPaymentTypeId != "2") {
                document.getElementById('<%=Rs_CardHolderName.ClientID %>').style.display = 'block';
            }
            else {
                document.getElementById('<%=Rs_CardHolderName.ClientID %>').style.display = 'none';
            }
            document.getElementById('<%=Rs_Cheque_no.ClientID %>').style.display = 'Block';
            document.getElementById('<%=Rs_Bank.ClientID %>').style.display = 'Block';

            var sval;
            sval = '0' + '~' + 'Bank';
            if ($find('<%= AutoCompleteProduct.ClientID %>') != null)
                $find('<%= AutoCompleteProduct.ClientID %>').set_contextKey(sval);

        }

        document.getElementById('<%=hdnIsRequired.ClientID %>').value = ctrlPaymentType.value.split('~')[1];

        document.getElementById('<%=btnAmountPop.ClientID %>').style.display = 'none';
        document.getElementById('addNewPayment').style.display = 'block';

        if (ctrlPaymentType.value.split('~')[1] == "Y" && "<%=IsQuickBilling%>" == "Y") {
            document.getElementById('<%=btnAmountPop.ClientID %>').style.display = 'block';
            document.getElementById('addNewPayment').style.display = 'none';
        }

        changeAmountValues();
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
    function SaveValidation() {
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vAmtValidation = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04') == null ? "Amount should be greater than zero" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_04');
        var EMIValue = 0;
        var IsEMIConfig = document.getElementById('<%=hdnIsEMI.ClientID %>').value; //get Config Value isEMi or Not 
        var IsEMI = document.getElementById('<%=hdnEMI.ClientID %>').value; //if payment is emi based or not 
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        // var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value.split('~')[0];
        var PaymentName = ctlDp.options[ctlDp.selectedIndex].innerHTML;

        var PaymentAmount = ToInternalFormat($('#<%= txtAmount.ClientID %>')); //        document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ChequeValidDate = document.getElementById('<%= txtDate.ClientID %>').value;
        var ServiceCharge = ToInternalFormat($('#<%= txtServiceCharge.ClientID %>')); // document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = ToInternalFormat($('#<%= txtTotalAmount.ClientID %>')); // document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;
        var EMIROI = document.getElementById('<%= txtROI.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtROI.ClientID %>').value;
        var EMITenor = document.getElementById('<%= txtTenor.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtTenor.ClientID %>').value;
        //        var Units = document.getElementById('<%= txtUnits.ClientID %>').value;
        //        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        //        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        var Units = document.getElementById('<%= txtUnits.ClientID %>').value == "" ? "0" : document.getElementById('<%= txtUnits.ClientID %>').value;
        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        //code added for bug fix - 0 amount begin
        //        alert(PaymentTypeID);
        //        alert(PaymentAmount);
        if ((PaymentTypeID != "0") && (PaymentAmount != "") && (PaymentAmount > 0)) {

            //code added for bug fix - 0 amount begin
            //            alert("Payment Type and Amount Required");
            //        }
            //        else
            //            if (PaymentName != 'Cash' && PaymentMethodNumber == "" ) {
            //                alert("Please Enter Cheque/Card Number");
            //                document.getElementById('<%= txtNumber.ClientID %>').focus();
            //                return false;
            //            }
            //            else if (PaymentName != 'Cash' && PaymentBankType == "") {
            //                alert("Please Enter Bank Name/Card Type");
            //                document.getElementById('<%= txtBankType.ClientID %>').focus();
            //                return false;
            //            }
            //            else {
            PaymentAmount = format_number(PaymentAmount, 2);
            ServiceCharge = format_number(ServiceCharge, 2);
            var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>')); //document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;

            if (Number(PaymentAmount) >= 0) {

                var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                if (returnType == true && IsEMI == "N") {

                    var OtherCurrAmt = Number(PaymentAmount) * Number(OtherCurrencyRate);

                    document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                    PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                    ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                    TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                    OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));


                    var retval = PaymentName + "~"
                    + PaymentAmount + "~"
                    + PaymentMethodNumber + "~"
                    + PaymentBankType + "~"
                    + PaymentRemarks + "~"
                    + PaymentTypeID + "~"
                    + ChequeValidDate + "~"
                    + ServiceCharge + "~"
                    + TotalAmount + "~"
                    + OtherCurrAmt + "~"
                    + EMIROI + "~"
                    + EMITenor + "~"
                    + EMIValue + "~"
                    + Units + "~"
                    + ReferenceID + "~"
                    + ReferenceType;
                    CmdAddPaymentType_onclick(retval);

                    return true;
                }
                if (returnType == true && IsEMI == "Y") {
                    var OtherCurrAmt = Number(PaymentAmount) * Number(OtherCurrencyRate);
                    // formula for EMIVAlue =EMI = (p*r) (1+r)^n
                    //P-Amount,r-Rateofintrest,n-Tenor
                    EMIValue = (TotalAmount * (EMIROI * (EMIROI / 100)) * (1 + (EMIROI * EMIROI / 100)) * (EMITenor) / (1 + (EMIROI * (EMIROI / 100)) * (EMITenor - 1))).toFixed(2);
                    document.getElementById('<%= TempDataStore.ClientID %>').value = PaymentAmount;
                    PaymentAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = ServiceCharge;
                    ServiceCharge = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = TotalAmount;
                    TotalAmount = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
                    OtherCurrencyRate = ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

                    var retval = PaymentName + "~"
                    + PaymentAmount + "~"
                    + PaymentMethodNumber + "~"
                    + PaymentBankType + "~"
                    + PaymentRemarks + "~"
                    + PaymentTypeID + "~"
                    + ChequeValidDate + "~"
                    + ServiceCharge + "~"
                    + TotalAMount + "~"
                    + OtherCurrAmt + "~"
                    + EMIROI + "~"
                    + EMITenor + "~"
                    + EMIValue + "~"
                    + Units + "~"
                    + ReferenceID + "~"
                    + ReferenceType;
                    CmdAddPaymentType_onclick(retval);

                    return true;
                }
            }


            else {
              
                
                    //alert("Amont should be greater than zero");
                    ValidationWindow(vAmtValidation, AlertType);
                    return false;
               
            }
            //}
        }
        else {
            return true;
        }

    }
    function changeAmountValues() {
        var sServiceAmount = ToInternalFormat($('#<%= txtServiceCharge.ClientID %>'))//; document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var sAmount = ToInternalFormat($('#<%= txtAmount.ClientID %>'))//; document.getElementById('<%= txtAmount.ClientID %>').value;
        sServiceAmount = Number(sServiceAmount);
        sAmount = Number(sAmount);

        if (sServiceAmount == '') {sServiceAmount = 0; }
        sAmount = sAmount + (sAmount * sServiceAmount / 100);
        document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = format_number(sAmount, 2);
        ToTargetFormat($('#<%= txtTotalAmount.ClientID %>'));

        return false;
    }

    function checksign(e) {
        e = window.event;
        var code = e.keyCode || e.which;
        
        if (code == 32) {
            return false;
        }
    }
</script>

<asp:HiddenField ID="hdfDefaultPaymentMode" runat="server" />
<asp:HiddenField ID="hdfPaymentType" runat="server" />
<%--<asp:HiddenField ID="hdnPaymentExists" runat="server" />--%>
<asp:HiddenField ID="hdnPaymentsDeleted" runat="server" />
<asp:HiddenField ID="hdnOtherCurrencyID" Value="0" runat="server" />
<asp:HiddenField ID="hdnOtherCurrencyRate" Value="0" runat="server" />
<asp:HiddenField ID="hdnOtherCurrency" runat="server" />
<asp:HiddenField ID="hdnPayVariableAmount" Value="0" runat="server" />
<asp:HiddenField ID="hdnRecdAmount" Value="0" runat="server" />
<asp:HiddenField ID="hdnBaseCurrencyValue" Value="0" runat="server" />
<asp:HiddenField ID="hdnlastreceivedamt" Value="0" runat="server" />
<asp:HiddenField ID="hdnEMI" Value="N" runat="server" />
<asp:HiddenField ID="hdnIsEMI" Value="N" runat="server" />
<input id="TempDataStore" type="hidden" value="0" runat="server" />
<asp:HiddenField ID="hdnAmtReceivedID" runat="server" Value="0" />

<script type="text/javascript" language="javascript">
    function GetCurrencyValues() {
        if (document.getElementById('<%= ddCurrency.ClientID %>').value == "0") {
            var AlrtWinHdr = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_19") != null ? SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_19") : "Select Currency Type";
            //var userMsg = SListForApplicationMessages.Get("CommonControls\\PaymentTypeDetails.ascx_13");
            if (UsrAlrtMsg != null) {
                //alert(UsrAlrtMsg);
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('<%= ddCurrency.ClientID %>').focus();
                return false;
            }
            else {
                //alert("Select Currency Type");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('<%= ddCurrency.ClientID %>').focus();
                return false;
            }

        }
        var BaseCurrencyID = document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value;
        var OtherCurrencyID = document.getElementById('<%= ddCurrency.ClientID %>').value.split('~')[0];
        var OtherCurrencyRate = document.getElementById('<%= ddCurrency.ClientID %>').value.split('~')[1];
        document.getElementById('<%= TempDataStore.ClientID %>').value = OtherCurrencyRate;
        ToTargetFormat($('#<%= TempDataStore.ClientID %>'));

        OtherCurrencyRate = ToInternalFormat($('#<%= TempDataStore.ClientID %>'));

        var OtherCurrency = document.getElementById('<%= ddCurrency.ClientID %>').options[document.getElementById('<%= ddCurrency.ClientID %>').selectedIndex].text;
        SetCurrencyValues(BaseCurrencyID, OtherCurrencyID, OtherCurrencyRate, OtherCurrency);
        if (BaseCurrencyID == OtherCurrencyID) {
            isOtherCurrDisplay1("N");
        }
        else {
            isOtherCurrDisplay1("B");
        }
    }

    function SetCurrencyValues(BaseCurrencyID, OtherCurrencyID, OtherCurrencyRate, OtherCurrency) {
        document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value = BaseCurrencyID;
        document.getElementById('<%= hdnOtherCurrencyID.ClientID %>').value = OtherCurrencyID;
        document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value = OtherCurrencyRate;
        document.getElementById('<%= hdnOtherCurrency.ClientID %>').value = OtherCurrency;
        SetOtherCurrValues();
        isOtherCurrDisplay1("B");
    }
    function GetCurrencyFormatValues(pAmount, pType) {

        var BaseCurrencyID = document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value;
        var OtherCurrencyID = document.getElementById('<%= hdnOtherCurrencyID.ClientID %>').value;
        var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>')); //document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        var OtherCurrency = document.getElementById('<%= hdnOtherCurrency.ClientID %>').value;


        if ("Add") {
            if (BaseCurrencyID != OtherCurrencyID) {
                var tAmt = document.getElementById('<%= hdnPayVariableAmount.ClientID %>').value;
                return pAmount = Number(Number(OtherCurrencyRate) * Number(pAmount)) + Number(tAmt);
            }
        }
        else if ("Edit") {
            if (BaseCurrencyID != OtherCurrencyID) {
                return pAmount = Number(Number(OtherCurrencyRate) * Number(pAmount));
            }
        }
        else {
            return pAmount;
        }

    }
    function GetOtherCurrency(pType) {

        var BaseCurrencyID = document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value;
        var OtherCurrencyID = document.getElementById('<%= hdnOtherCurrencyID.ClientID %>').value;
        var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>')); //document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        var OtherCurrency = document.getElementById('<%= hdnOtherCurrency.ClientID %>').value;

        if (pType == "BaseCurrID") {
            return BaseCurrencyID;
        }
        if (pType == "OtherCurrID") {
            return OtherCurrencyID;
        }
        if (pType == "OtherCurrRate") {
            return OtherCurrencyRate;
        }

    }

    function SetPaybleOtherCurr(pnetAmt, ConValue, IsDisplay) {
        var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>')); // document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        var OtherCurrency = document.getElementById('<%= hdnOtherCurrency.ClientID %>').value;
        SetOtherCurrPayble(OtherCurrency, OtherCurrencyRate, pnetAmt, ConValue, IsDisplay);
        var pTotalNetAmt = Number(pnetAmt) / Number(OtherCurrencyRate);
        var pTempAmt = Number(pTotalNetAmt) * Number(OtherCurrencyRate);
        document.getElementById('<%= hdnPayVariableAmount.ClientID %>').value = Number(pnetAmt) - Number(pTempAmt);
        ToTargetFormat($('#<%= hdnPayVariableAmount.ClientID %>'));

    }

    function SetReceivedOtherCurr(sVal, pServiceCharge, ConValue) {
        var OtherCurrencyRate = ToInternalFormat($('#<%= hdnOtherCurrencyRate.ClientID %>')); //document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        SetOtherCurrReceived(OtherCurrencyRate, sVal, pServiceCharge, ConValue);
        var pTotalNetAmt = Number(sVal) / Number(OtherCurrencyRate);
        document.getElementById('<%= hdnRecdAmount.ClientID %>').value = pTotalNetAmt;
        ToTargetFormat($('#<%= hdnRecdAmount.ClientID %>'))
    }


    function checkboxEMI() {

        if (document.getElementById('<%=chkPaybyEMI.ClientID %>').checked == true) {
            document.getElementById('<%= hdnEMI.ClientID %>').value = "Y";


        }
        else {
            document.getElementById('<%= hdnEMI.ClientID %>').value = "N";
        }
    }
    function settoPaymentControl(Amount) {
        document.getElementById('<%= txtAmount.ClientID %>').value = Amount;
        changeAmountValues();
    }
    function CheckBankAndCechno() {
        var BankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var CheckNo = document.getElementById('<%= txtNumber.ClientID %>').value;
        var orgID = document.getElementById('<%= hdnOrgID.ClientID %>').value;

        var AlrtWinHdr = SListForAppMsg.Get("CommonControls_Header_Alert") != null ? SListForAppMsg.Get("CommonControls_Header_Alert") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_20") != null ? SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_20") : "Sorry Given Bank/CardHolder Name & Card/cheque Number Already exist.\n Please try different Card/cheque Number.";
        var UsrAlrtMsgEmpty = SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_22") != null ? SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_22") : "Please Enter the Cheque/Card/DDNo";
        
        if (CheckNo != "") {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetChequeDeatails",
                data: "{BankName: '" + BankType + "',ChequeorCardNumber: '" + CheckNo + "',OrgID: '" + orgID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var lstLocation = data.d;
                    if (lstLocation.length > 0) {
                        // alert('Sorry Given Bank/CardHolder Name & Card/cheque Number Already exist.\n Please try different Card/cheque Number.');
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        document.getElementById('<%= txtNumber.ClientID %>').value = "";
                        document.getElementById('<%= txtNumber.ClientID %>').focus();
                        return false;
                    }
                    else {
                        return true;
                    }

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert(xhr.status);
					 ValidationWindow(xhr.status, AlrtWinHdr);
                    return true;
                }
            });
        }
        else {
            ValidationWindow(UsrAlrtMsgEmpty, AlrtWinHdr);
            //alert(UsrAlrtMsgEmpty);
            //var txtnum=document.getElementById('<%= txtNumber.ClientID %>');
            //document.getElementById('<%= txtNumber.ClientID %>').focus();
            //txtnum.focus();
            return false;
        }
    }

    function GetBPaymentDetails() {
        var PaymentDetails = document.getElementById('<%= hdnPaymentDetails.ClientID %>').value;
        return PaymentDetails;
    }
    function valAmountApprovalDetails() {
        var alertpayment = false;
        var GetPaymentDetails = "";
        var IsEMI = document.getElementById('<%=hdnEMI.ClientID %>').value;
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        //  var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value.split('~')[0];
        var IsRequired = ctlDp.options[ctlDp.selectedIndex].value.split('~')[1];
        var MaxLength = ctlDp.options[ctlDp.selectedIndex].value.split('~')[2];
        var IsValidMonth = ctlDp.options[ctlDp.selectedIndex].value.split('~')[3];
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');
        var PaymentAmount = ToInternalFormat($('#<%= txtAmount.ClientID %>'));
        var ChequeDate = document.getElementById('<%= txtDate.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = ToInternalFormat($('#<%= txtServiceCharge.ClientID %>'));
        var TotalAmount = ToInternalFormat($('#<%= txtTotalAmount.ClientID %>'));
        var Units = document.getElementById('<%= txtUnits.ClientID %>').value == "" ? "0" : document.getElementById('<%= txtUnits.ClientID %>').value;
        var ReferenceID = document.getElementById('<%= hdnReferenceID.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceID.ClientID %>').value;
        var ReferenceType = document.getElementById('<%= hdnReferenceType.ClientID %>').value == "" ? "0" : document.getElementById('<%= hdnReferenceType.ClientID %>').value;
        var EMIROI = document.getElementById('<%= txtROI.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtROI.ClientID %>').value;
        var EMITenor = document.getElementById('<%= txtTenor.ClientID %>').value == "" ? 0 : document.getElementById('<%= txtTenor.ClientID %>').value;
        var EMIValue = 0;
        var GetTotalDays = parseInt(IsValidMonth) * 30;
        var oneDay = 24 * 60 * 60 * 1000;
        var TodayDate = new Date();
        var DayFormat = TodayDate.format("MM/dd/yyyy");
        var TodayMonth = DayFormat.split('/')[0];
        var TodayDay = DayFormat.split('/')[1];
        var TodayYear = DayFormat.split('/')[2];
        var GetDate = new Date(TodayYear, TodayMonth, TodayDay);
        var GetPaymentDate = "";
        var day = "";
        var month = "";
        var Year = "";
        var TargetDate = "0";
        var diffDays = "0"
        if (ChequeDate != "") {
            GetPaymentDate = ChequeDate.split('/');
            day = GetPaymentDate[0];
            month = (GetPaymentDate[1]);
            Year = GetPaymentDate[2];
            TargetDate = new Date(Year, month, day);
            diffDays = Math.round(Math.abs((GetDate.getTime(TodayYear, TodayMonth, TodayDay) - TargetDate.getTime(Year, month, day)) / (oneDay)));
        }
        else {
            TargetDate = new Date();
        }
        var CardHolderName = document.getElementById('<%= txtCardHolderName.ClientID %>').value
        if (PaymentAmount <= 0) {
            
                alert("Please Enter Amount greater than 0");
                
            document.getElementById('<%= txtAmount.ClientID %>').value = '';
            document.getElementById('<%= txtAmount.ClientID %>').focus();
            return false;
        }

        if ((PaymentTypeID == "0") || (PaymentAmount == "")) {
           
                alert("Payment Type and Amount Required");
                return false;
            
        }
       // else if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
        else if (PaymentTypeID != "1" && PaymentMethodNumber == "") {
            
                alert("Please Enter Cheque/Card Number");
                return false;
           
        }
       // else if (PaymentName != 'Cash' && PaymentBankType == "") {
        else if (PaymentTypeID != "1" && PaymentBankType == "") {
           
                alert("Please Enter Bank Name/Card Type");
               
            document.getElementById('<%= txtBankType.ClientID %>').focus();
            return false;
        }

//        else if (PaymentName == 'Coupon' && Units == "") {
        else if (PaymentTypeID == "10" && Units == "") {
            
                alert("Please Enter Coupon Units");
                
            document.getElementById('<%= txtUnits.ClientID %>').focus();
            return false;
        }
       // else if (IsEMI == "Y" && EMIROI == "" && PaymentName != 'Cash' && PaymentName != 'Coupon') {
        else if (IsEMI == "Y" && EMIROI == "" && PaymentTypeID != "1" && PaymentTypeID != "10") {
            
                alert(" Please enter Rate of Interest for EMI");
                return false;
            
        }
        //else if (IsEMI == "Y" && EMITenor == "" && PaymentName != 'Cash' && PaymentName != 'Coupon') {
        else if (IsEMI == "Y" && EMITenor == "" && PaymentTypeID != "1" && PaymentTypeID != "10") {
            
                alert("Please enter the Tenor of Interest");
                return false;
           
        }
        //else if (PaymentName == "Cheque" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {
        else if (PaymentTypeID == "2" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {

            alert("Cheque no should be " + MaxLength + " numbers");
            document.getElementById('<%= txtNumber.ClientID %>').value = "";
            return false;

        }
       // else if (PaymentName == "Credit/Debit Card" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {
        else if (PaymentTypeID == "3" && parseInt(MaxLength) != 100 && (PaymentMethodNumber.length > parseInt(MaxLength) || PaymentMethodNumber.length != parseInt(MaxLength))) {

            alert(" Card no should be last " + MaxLength + " numbers");
            document.getElementById('<%= txtNumber.ClientID %>').value = "";
            return false;

        }
       // else if (ChequeDate == "" && PaymentName == "Cheque") {
        else if (ChequeDate == "" && PaymentTypeID == "2") {
            alert("Please enter the cheque valid Date");
            document.getElementById('<%= txtDate.ClientID %>').value = "";
            return false;

        }
//        else if (PaymentName == "Cheque" && (parseInt(GetTotalDays) < parseInt(diffDays) || (GetDate.getTime(TodayYear, TodayMonth, TodayDay) > TargetDate.getTime(Year, month, day)))) {
        else if (PaymentTypeID == "2" && (parseInt(GetTotalDays) < parseInt(diffDays) || (GetDate.getTime(TodayYear, TodayMonth, TodayDay) > TargetDate.getTime(Year, month, day)))) {

            alert("Please enter the Valid cheque Date");
            document.getElementById('<%= txtDate.ClientID %>').value = "";
            return false;

        }
        var AlreadypaymentModeExisits = 0;
        var CardNoExist = 0;
        var AlreadyPaymentModeValidation = document.getElementById('<%= hdfPaymentType.ClientID %>').value
        if (AlreadyPaymentModeValidation != "") {
            var x = AlreadyPaymentModeValidation.split("|");
            for (j = 0; j < x.length; j++) {
                if (x[j] != "") {
                    var val = x[j].split("~");
                    if (val[6].split("^")[1] == PaymentMethodNumber && val[7].split("^")[1] != PaymentBankType) {
                        CardNoExist = 1;
                        break;
                    }
                    if (PaymentTypeID != "1" && (val[9].split("^")[1] == PaymentTypeID && val[6].split("^")[1] == PaymentMethodNumber && val[7].split("^")[1] == PaymentBankType)) {
                        AlreadypaymentModeExisits = 1;
                        break;
                    }
                }
            }
        }

        if (AlreadypaymentModeExisits == 1) {
            alert('The Payment details already exists, Kindly change payment details');
            return false;
        }
        if (CardNoExist == 1) {
            alert('The Payment details already exists, Kindly change Card details');
            return false;
        }
        PaymentDate = ChequeDate;
        GetPaymentDetails = PaymentName + '~' + TotalAmount + '~' + PaymentBankType + '~' + PaymentMethodNumber + '~' + PaymentDate + '~' + CardHolderName;
        document.getElementById('<%= hdnPaymentDetails.ClientID %>').value = GetPaymentDetails;
        InsertBillpaymentDetails();
        return false;
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
       
</script>

<%-- <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>
     <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>--%>
<asp:HiddenField ID="hdnOrgID" runat="server" />
