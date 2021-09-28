<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SurgeryAdvanceQuickBill.ascx.cs"
    Inherits="CommonControls_SurgeryAdvanceQuickBill" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<script type ="text/javascript" >
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
<asp:Panel ID="pres" runat="server" meta:resourcekey="presResource1">
    <table cellpadding="1" cellspacing="2" border="0" style="width: 100%">
        <tr>
            <td style="width: 100%;" align="center">
                <input type="hidden" id="Did" name="Did" />
                <input type="hidden" id="rid" name="rid" />
                <div id="divTreatment" runat="server">
                </div>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
            <td class="Duecolor" height="23" align="right">
                &nbsp;&nbsp;<asp:Label ID="Rs_PaymentType" runat="server" Text="Payment Type" meta:resourcekey="Rs_PaymentTypeResource1"></asp:Label>
            </td>
            <td class="Duecolor" align="right">
                <strong>
                    <asp:Label ID="Rs_SelectCurrencyType" runat="server" Text="Select Currency Type"
                        meta:resourcekey="Rs_SelectCurrencyTypeResource1"></asp:Label></strong>
                &nbsp;&nbsp; :
                <asp:DropDownList Width="150px" onchange="SurgeryGetCurrencyValues();" CssClass="ddlsmall" 
                    ID="ddCurrency" runat="server" TabIndex="37">
                </asp:DropDownList>
                <input id="hdnBaseCurrencyID" runat="server" type="hidden"> </input>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dataheaderInvCtrl">
                    <table width="100%" border="1" cellspacing="1" cellpadding="1" class="tabletxt">
                        <tr align="center">
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Type" runat="server" Text=" Type" meta:resourcekey="Rs_TypeResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Amount2" runat="server" Text="Amount(<%= CurrencyName %>)" meta:resourcekey="Rs_Amount2Resource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ChequeCardDDNo" runat="server" Text="Cheque/Card/DDNo." meta:resourcekey="Rs_ChequeCardDDNoResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_BankCardType" runat="server" Text="Bank/Card Type" meta:resourcekey="Rs_BankCardTypeResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ServiceCharge" runat="server" Text="Service Charge(%)" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Label1" runat="server" Text="Label" meta:resourcekey="Label1Resource1"></asp:Label><asp:Label
                                    ID="Rs_Total" runat="server" Text="Total(<%= CurrencyName %>)" meta:resourcekey="Rs_TotalResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" width="110px" style="display: none;">
                                <asp:Label ID="Rs_Remarks" runat="server" Text="Remarks" meta:resourcekey="Rs_RemarksResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr align="center">
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="ddlsmall"  onchange="javascript:SurgeryPaymentchanged();"
                                    TabIndex="38">
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtAmount"  CssClass="Txtboxsmall"  onChange="javascript:SurgerychangeAmountValues();"
                                       onkeypress="return ValidateOnlyNumeric(this);"   Width="65px" MaxLength="9" autocomplete="off"
                                    TabIndex="39"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtNumber" CssClass="Txtboxsmall"     onkeypress="return ValidateOnlyNumeric(this);"  
                                    autocomplete="off" Width="130px" MaxLength="19" TabIndex="40"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtBankType" CssClass="Txtboxsmall"  Width="130px" autocomplete="off" TabIndex="41"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtBankType"
                                    EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="listtwo"
                                    CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                    ServiceMethod="GetBankName" ServicePath="~/InventoryWebService.asmx" DelimiterCharacters=""
                                    Enabled="True">
                                </cc1:AutoCompleteExtender>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtServiceCharge"  CssClass="Txtboxsmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                    Width="60px" onChange="javascript:SurgerychangeAmountValues();" Style="text-align: right;"
                                    MaxLength="9" autocomplete="off" TabIndex="42"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="txtTotalAmount" runat="server" autocomplete="off" MaxLength="9" Width="60px"
                                    meta:resourcekey="txtTotalAmountResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" style="display: none;">
                                <asp:TextBox ID="txtRemarks" runat="server"  CssClass="Txtboxsmall" Width="150px" autocomplete="off" TabIndex="43"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <input type="button" id="addNewPayment" value="Add" tooltip="Add" class="btn" onclick="SurgeryPaymentTypeValidation();return false;"
                                    tabindex="44" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="dvPaymentTable" runat="server" style="width: 100%">
                </div>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdfDefaultPaymentMode" runat="server" />
    <asp:HiddenField ID="hdnIsAlready" Value="N" runat="server" />
    <asp:HiddenField ID="hdnBaseCurrencyValue" runat="server" />
</asp:Panel>

<script type="text/javascript" language="javascript">
    function SurgeryClearPaymentControlEvents() {
        document.getElementById('<%= hdfPaymentType.ClientID %>').value = "";
        document.getElementById('<%= divTreatment.ClientID %>').innerHTML = "";
        SurgeryCreatePaymentTables();

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

    function SurgeryPaymentSaveValidation() {
        var alertpayment = false;

        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        //        var PaymentName = Surgerytrim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');
        var paymenttype = ctlDp.options([ctlDp.selectedIndex].text);
        console.log(paymenttype);
        var PaymentName = $.trim(paymenttype);

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;




        if (PaymentTypeID != "0" && PaymentTypeID != "") {



            if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please Enter Cheque/Card Number");
                }
                document.getElementById('<%= txtNumber.ClientID %>').focus();
                return false;
            }
            else if (PaymentName != 'Cash' && PaymentBankType == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please Enter Bank Name/Card Type");
            }
                document.getElementById('<%= txtBankType.ClientID %>').focus();
                return false;
            }
            else {
                PaymentAmount = format_number(PaymentAmount, 2);
                if (PaymentName != 'Cash') {
                    ServiceCharge = format_number(ServiceCharge, 2);
                }
                var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
                if (Number(PaymentAmount) >= 0) {


                    var returnType = SurgeryModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                    if (returnType == true) {

                        if (document.getElementById("Did").value == '') {
                            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_3');
                            if (userMsg != null) {
                                alert(userMsg);
                            } else {
                                alert('There is no Surgery Items for this Patient, Add the Surgery Items.');
                            }
                            return false;
                        }

                        var SelectedValue = document.getElementById("Did").value;
                        var SlectedRowID = document.getElementById("rid").value;


                        var SurgeryDetailIDAndName = new Array();
                        SurgeryDetailIDAndName = SelectedValue.split('~');
                        var SurgeryDetailID = SurgeryDetailIDAndName[0];
                        var SurgeryName = SurgeryDetailIDAndName[1];
                        var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);

                        var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber + "~"
                                + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID + "~"
                                + SurgeryDetailID + "~" + SurgeryName + "~" + SlectedRowID + "~" + ServiceCharge + "~" + TotalAmount
                                + "~" + OtherCurrAmt;
                        SurgeryCmdAddPaymentType_onclick(retval);
                        return true;
                    }
                }
                else {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_5');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false ;
                    } else {
                        alert("Amount should be greater than zero");
                        return false ;
                    }
                    return false;
                }
            }
        }
        else {
            return true;
        }

    }

    function SurgeryPaymentTypeValidation() {

        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentName = Surgerytrim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        if (document.getElementById("Did").value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('There is no Surgery Items for this Patient, Add the Surgery Items.');
            }
            return false;
        }
        else if ((PaymentTypeID == "0") || (PaymentAmount == "")) {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_6');
        if (userMsg != null) {
            alert(userMsg);
        } else {

            alert("Payment Type and Amount Required");
        }
        }
        else if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert("Please Enter Cheque/Card Number");
        }
            document.getElementById('<%= txtNumber.ClientID %>').focus();
        }
        else if (PaymentName != 'Cash' && PaymentBankType == "") {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_2');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert("Please Enter Bank Name/Card Type");
        }
            document.getElementById('<%= txtBankType.ClientID %>').focus();
        }
        else {
            PaymentAmount = format_number(PaymentAmount, 2);
            if (PaymentName != 'Cash') {
                ServiceCharge = format_number(ServiceCharge, 2);
            }
            var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
            if (Number(PaymentAmount) >= 0) {

                var returnType = SurgeryModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                if (returnType == true) {

                    var SelectedValue = document.getElementById("Did").value;
                    var SlectedRowID = document.getElementById("rid").value;


                    var SurgeryDetailIDAndName = new Array();
                    SurgeryDetailIDAndName = SelectedValue.split('~');
                    var SurgeryDetailID = SurgeryDetailIDAndName[0];
                    var SurgeryName = SurgeryDetailIDAndName[1];
                    var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);

                    var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber + "~"
                                + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID + "~"
                                + SurgeryDetailID + "~" + SurgeryName + "~" + SlectedRowID + "~" + ServiceCharge + "~" + TotalAmount
                                + "~" + OtherCurrAmt;

                    SurgeryCmdAddPaymentType_onclick(retval);
                    return true;
                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false ;
                } else {
                    alert("Amont should be greater than zero");
                }
                return false;
            }
        }

    }
    function SurgeryCmdAddPaymentType_onclick(gotValue) {
        var PaymentViewStateValue = document.getElementById('<%= hdfPaymentType.ClientID %>').value;


        var PaymentarrayGotValue = new Array();
        PaymentarrayGotValue = gotValue.split('~');
        var SlectedRowID, SurgeryDetailID, SurgeryName, PaymentName, PaymentAmount, PaymentMethodNumber, PaymentBankType, PaymentRemarks, PaymentTypeID, ServiceCharge, TotalAmount, OtherCurrAmt;

        if (PaymentarrayGotValue.length > 0) {


            PaymentName = PaymentarrayGotValue[0];
            PaymentAmount = PaymentarrayGotValue[1];
            PaymentMethodNumber = PaymentarrayGotValue[2];
            PaymentBankType = PaymentarrayGotValue[3];
            PaymentRemarks = PaymentarrayGotValue[4];
            PaymentTypeID = PaymentarrayGotValue[5];
            SurgeryDetailID = PaymentarrayGotValue[6];
            SurgeryName = PaymentarrayGotValue[7];
            SlectedRowID = PaymentarrayGotValue[8];
            ServiceCharge = PaymentarrayGotValue[9];
            TotalAmount = PaymentarrayGotValue[10];
            OtherCurrAmt = PaymentarrayGotValue[11];


        }
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;

        if (iPaymentAlreadyPresent == 0) {
            PaymentViewStateValue += "RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "|";
            document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymentViewStateValue;
            SurgeryCreatePaymentTables();
            SurgeryPaymentControlclear();
            SurgerySelectedRowClear(SlectedRowID);
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_8');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Payment Name already exists");
            }
        }

    }

    function SurgeryCreatePaymentTables() {
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
                    PaymentViewStateValue += "RID^" + Row + "~" + val[1] + "~" + val[2] + "~" + val[3] + "~"
                    + val[4] + "~" + val[5] + "~" + val[6] + "~" + val[7] + "~" + val[8] + "~" + val[9]
                    + "~" + val[10] + "~" + val[11] + "~" + val[12] + "|";
                    Row = Number(Row) + 1;
                }
            }
        }

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymentViewStateValue;

        document.getElementById('<%= ddCurrency.ClientID %>').disabled = false;


        startPaymentTag = "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' Border='1' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1' style='font-weight: bold;'><td style=\"display:none\">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_DetailID %>"+"</td><td >"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_TreatmentName %>"+" </td><td > "+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_Type %>"+"</td><td >"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_Amount %>"+"</td> <td >"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_ChequeCardDDNo %>"+" </td> <td >"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_BankCardType %>"+"</td><td >"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_ServiceCharge %>"+"</td><td style='display:none'> "+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_Remarks %>"+" </td><td>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_TotalAmount %>"+"</td><td style=\"display:none\">"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_RowID %>"+"</td><td></td> </tr>";
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
                        if (arrayPaymentChildData[0] == "SurgeryDetailID") {
                            SurgeryDetailID = arrayPaymentChildData[1];

                        }
                        if (arrayPaymentChildData[0] == "SurgeryName") {
                            SurgeryName = arrayPaymentChildData[1];

                        }
                        if (arrayPaymentChildData[0] == "SlectedRowID") {
                            SlectedRowID = arrayPaymentChildData[1];

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
                    }
                }
                var chkBoxName = "RID^" + RID + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "";
                if (PaymentAmount != 0) {
                    document.getElementById('<%= ddCurrency.ClientID %>').disabled = true;
                    newPaymentTables += "<TR><TD style=\"display:none\">" + SurgeryDetailID + "</TD>";
                    newPaymentTables += "<TD >" + SurgeryName + "</TD>";
                    newPaymentTables += "<TD >" + PaymentName + "</TD>";
                    newPaymentTables += "<TD >" + PaymentAmount + "</TD>";
                    newPaymentTables += "<TD >" + PaymentMethodNumber + "</TD>";
                    newPaymentTables += "<TD >" + PaymentBankType + "</TD>";
                    newPaymentTables += "<TD style=\"display:none\">" + SlectedRowID + "</TD>";
                    newPaymentTables += "<TD >" + ServiceCharge + "</TD>";
                    newPaymentTables += "<TD style='Display:none;'>" + PaymentRemarks + "</TD>";
                    newPaymentTables += "<TD >" + TotalAmount + "</TD>";

                    newPaymentTables += "<TD><input name='RID^" + RID + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "' onclick='SurgerybtnPaymentEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />|<input name='RID^" + RID + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "' onclick='SurgerybtnPaymentDelete_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_Delete %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
                }

            }
        }

        newPaymentTables += endPaymentTag;
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML += newPaymentTables;
        //document.getElementById('<%= ddlPaymentType.ClientID %>').focus();

    }


    function SurgerybtnPaymentEdit_OnClick(sEditedData) {

        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;
        var tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge;

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
        var arraySurgeryDetailID = new Array();
        var arrayTreatmentName = new Array();
        var arraySlectedRowID = new Array();
        var arrayServiceCharge = new Array();
        var arrayTotalAmount = new Array();



        PaymentarrayGotValue = sEditedData.split('~');

        var SlectedRowID, SurgeryDetailID, PaymentName, PaymentAmount, PaymentMethodNumber, PaymentBankType, PaymentRemarks, PaymentTypeID, ServiceCharge, TotalAmount;

        if (PaymentarrayGotValue.length > 0) {
            PaymentName = PaymentarrayGotValue[1];
            PaymentAmount = PaymentarrayGotValue[2];
            PaymentMethodNumber = PaymentarrayGotValue[3];
            PaymentBankType = PaymentarrayGotValue[4];
            PaymentRemarks = PaymentarrayGotValue[5];
            PaymentTypeID = PaymentarrayGotValue[6];
            SurgeryDetailID = PaymentarrayGotValue[7]
            TreatmentName = PaymentarrayGotValue[8]
            SlectedRowID = PaymentarrayGotValue[9]
            ServiceCharge = PaymentarrayGotValue[10];
            TotalAmount = PaymentarrayGotValue[11];




            arrayPaymentName = PaymentName.split('^');
            arrayAmount = PaymentAmount.split('^');
            arrayChequeNo = PaymentMethodNumber.split('^');
            arrayBankName = PaymentBankType.split('^');
            arrayRemarks = PaymentRemarks.split('^');
            arrayPaymentTypeID = PaymentTypeID.split('^');
            arraySurgeryDetailID = SurgeryDetailID.split('^');
            arrayTreatmentName = TreatmentName.split('^');
            arraySlectedRowID = SlectedRowID.split('^');
            arrayServiceCharge = ServiceCharge.split('^');
            arrayTotalAmount = TotalAmount.split('^');

        }

        if (arrayPaymentName.length > 0) {
            document.getElementById('<%= ddlPaymentType.ClientID %>').value = arrayPaymentTypeID[1];
        }
        if (arrayAmount.length > 0) {
            document.getElementById('<%= txtAmount.ClientID %>').value = arrayAmount[1];
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
        if (arrayServiceCharge.length > 0) {
            document.getElementById('<%= txtServiceCharge.ClientID %>').value = arrayServiceCharge[1];
            tmpServiceCharge = arrayServiceCharge[1];
        }
        if (arrayTotalAmount.length > 0) {
            document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = arrayTotalAmount[1];
            tmpTotalAmount = arrayTotalAmount[1];
        }

        if (arraySlectedRowID.length > 0) {
            document.getElementById(arraySlectedRowID[1]).checked = true;
            document.getElementById("rid").value = arraySlectedRowID[1]
        }
        if (arraySurgeryDetailID.length > 0) {
            document.getElementById("Did").value = arraySurgeryDetailID[1] + "~" + arrayTreatmentName[1];
        }


        SurgeryDeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;

        SurgeryCreatePaymentTables();
    }

    function SurgerybtnPaymentDelete_OnClick(sEditedData) {

        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;


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
        var arraySurgeryDetailID = new Array();
        var arrayTreatmentName = new Array();
        var arraySlectedRowID = new Array();
        var arrayServiceCharge = new Array();
        var arrayTotalAmount = new Array();



        PaymentarrayGotValue = sEditedData.split('~');

        var SlectedRowID, SurgeryDetailID, PaymentName, PaymentAmount, PaymentMethodNumber, PaymentBankType, PaymentRemarks, PaymentTypeID, ServiceCharge, TotalAmount;

        if (PaymentarrayGotValue.length > 0) {
            PaymentName = PaymentarrayGotValue[1];
            PaymentAmount = PaymentarrayGotValue[2];
            PaymentMethodNumber = PaymentarrayGotValue[3];
            PaymentBankType = PaymentarrayGotValue[4];
            PaymentRemarks = PaymentarrayGotValue[5];
            PaymentTypeID = PaymentarrayGotValue[6];
            SurgeryDetailID = PaymentarrayGotValue[7]
            TreatmentName = PaymentarrayGotValue[8]
            SlectedRowID = PaymentarrayGotValue[9]
            ServiceCharge = PaymentarrayGotValue[10];
            TotalAmount = PaymentarrayGotValue[11];


            arrayPaymentName = PaymentName.split('^');
            arrayAmount = PaymentAmount.split('^');
            arrayChequeNo = PaymentMethodNumber.split('^');
            arrayBankName = PaymentBankType.split('^');
            arrayRemarks = PaymentRemarks.split('^');
            arrayPaymentTypeID = PaymentTypeID.split('^');
            arraySurgeryDetailID = SurgeryDetailID.split('^');
            arrayTreatmentName = TreatmentName.split('^');
            arraySlectedRowID = SlectedRowID.split('^');
            arrayServiceCharge = ServiceCharge.split('^');
            arrayTotalAmount = TotalAmount.split('^');

        }

        if (arrayAmount.length > 0) {
            tmpPaymentAmount = arrayAmount[1];
        }

        if (arrayServiceCharge.length > 0) {
            tmpServiceCharge = arrayServiceCharge[1];
        }
        if (arrayTotalAmount.length > 0) {
            tmpTotalAmount = arrayTotalAmount[1];
        }

        SurgeryDeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;
        SurgeryCreatePaymentTables();
    }

    function SurgeryPaymentControlclear() {
        document.getElementById('<%= ddlPaymentType.ClientID %>').value = document.getElementById('<%= hdfDefaultPaymentMode.ClientID %>').value;
        document.getElementById('<%= txtAmount.ClientID %>').value = "";
        document.getElementById('<%= txtNumber.ClientID %>').value = "";
        document.getElementById('<%= txtBankType.ClientID %>').value = "";
        document.getElementById('<%= txtRemarks.ClientID %>').value = "";
        document.getElementById('<%= txtServiceCharge.ClientID %>').value = "";
        document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = "";
        SurgeryPaymentchanged();
    }
    function clearSurgeryAdv() {
        SurgeryPaymentControlclear();
        document.getElementById('<%= hdfPaymentType.ClientID %>').value = "";
    }
    function SurgerySelectedRowClear(RowID) {
        document.getElementById(RowID).checked = false;
        document.getElementById("Did").value = "";
        document.getElementById("rid").value = "";
    }
    function SurgeryPaymentchanged() {
        var ctrlPaymentType = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var sPaymentType = Surgerytrim(ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@')[0], ' ');
        var sPaymentAmt = ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@')[1];
        var sLength = new Array();
        var sLength = ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@');
        var Amt = document.getElementById('<%= txtAmount.ClientID %>').value;
        var totAmt = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        if (sLength.length > 1) {
            sPaymentAmt = sPaymentAmt.split('%')[0];
            sPaymentAmt = Number(sPaymentAmt);

            var ServiceAmt = format_number((Number(Amt) * Number(sPaymentAmt)) / 100, 2);
            document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML =
            format_number(Number(ServiceAmt) + Number(Amt), 2);
        }
        else {
            sPaymentAmt = 0;
            document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = format_number(Number(Amt), 2);
        }
        document.getElementById('<%= txtServiceCharge.ClientID %>').value = sPaymentAmt;

        if (sPaymentType == "Cash") {
            document.getElementById('<%= txtNumber.ClientID %>').style.display = 'None';
            document.getElementById('<%= txtBankType.ClientID %>').style.display = 'None';
            document.getElementById('<%= txtServiceCharge.ClientID %>').style.display = 'None';
        }
        else {
            //            document.getElementById('<%= txtBankType.ClientID %>').value = sPaymentType;
            document.getElementById('<%= txtNumber.ClientID %>').style.display = 'Block';
            document.getElementById('<%= txtBankType.ClientID %>').style.display = 'Block';
            document.getElementById('<%= txtServiceCharge.ClientID %>').style.display = 'Block';
        }
    }

    function Surgerytrim(str, chars) {
        return Surgeryltrim(Surgeryrtrim(str, chars), chars);
    }

    function Surgeryltrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
    }

    function Surgeryrtrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
    }

    function SurgerySaveValidation() {
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentName = ctlDp.options[ctlDp.selectedIndex].innerHTML;

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var txtTotalAMount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        if ((PaymentTypeID != "0") || (PaymentAmount != "")) {
            //            alert("Payment Type and Amount Required");
            //        }
            //        else
            if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please Enter Cheque/Card Number");
                }
                document.getElementById('<%= txtNumber.ClientID %>').focus();
                return false;
            }
            else if (PaymentName != 'Cash' && PaymentBankType == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please Enter Bank Name/Card Type");
            }
                document.getElementById('<%= txtBankType.ClientID %>').focus();
                return false;
            }
            else {
                PaymentAmount = format_number(PaymentAmount, 2);
                ServiceCharge = format_number(ServiceCharge, 2);
                var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;

                if (Number(PaymentAmount) >= 0) {

                    var returnType = SurgeryModifyAmountValue(PaymentAmount, PaymentAmount, ServiceCharge);
                    if (returnType == true) {
                        var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                        var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAMount + "~" + OtherCurrAmt;
                        SurgeryCmdAddPaymentType_onclick(retval);

                        return true;
                    }
                }
                else {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_7');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert("Amont should be greater than zero");
                    }
                    return false;
                }
            }
        }
        else {
            return true;
        }
    }


    function SurgerychangeAmountValues() {
        var sServiceAmount = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var sAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        sServiceAmount = Number(sServiceAmount);
        sAmount = Number(sAmount);
        sAmount = sAmount + (sAmount * sServiceAmount / 100);
        document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = format_number(sAmount, 2);
        return false;
    }
</script>

<script type="text/javascript" language="javascript">
    function setIsAlert() {
        document.getElementById('<%= hdnIsAlready.ClientID %>').value = "N";
    }
    function GetSurgeryDetailForAdvance(tVisitID) {
        OPIPBilling.LoadSurgeryDetailForAdvance(tVisitID, loadSurgeryDetails);
    }
    function loadSurgeryDetails(pSurgeryList) {
        var listLen = pSurgeryList.length;
        if (listLen > 0) {
            var sVal = '';
            var Advamt = 0;
            var dueString = '';
            sVal = "<table Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 12px;'><tr class='dataheader1' style='font-weight: bold;'>" +
                    "<td align='center'><td align='left'>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_TreatmentName_1 %>"+"</td><td align='left'>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_EstimatedAmount %>"+"</td> <td align='left'>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_PaidAmount %>"+"</td><td align='left'>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvanceQuickBill_PaidDate %>"+"</td></tr>";

            if (pSurgeryList.length > 0) {

                for (var i = 0; i < listLen; i++) {
                    var rdo = "rdo" + pSurgeryList[i].FeeID;
                    var dec = pSurgeryList[i].FeeID + "~" + pSurgeryList[i].Description;
                    var rdo = "<input id='" + rdo + "' type='radio' name='sAdvance' value='" + rdo + "|" + dec + "'  onclick='SelectSurRdoValues(value);' />";
                    sVal += "<tr><td align='center'>" + rdo + "</td>";
                    sVal += "<td align='left'>" + pSurgeryList[i].Description + "</td>";
                    sVal += "<td align='left'>" + pSurgeryList[i].Amount + "</td>";
                    sVal += "<td align='left'>" + pSurgeryList[i].AdvanceAmount + "</td>";
                    sVal += "<td align='left'>" + dateformatchange(pSurgeryList[i].CreatedAt) + "</td></tr>";

                }
            }
            sVal += '</table>';
            document.getElementById('<%= divTreatment.ClientID %>').innerHTML = sVal;
        }
        else {
            if (document.getElementById('<%= hdnIsAlready.ClientID %>').value == "N") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SurgeryAdvanceQuickBill.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("There is no Surgery Items for this Patient, Add the Surgery Items.");
                }
                document.getElementById('<%= hdnIsAlready.ClientID %>').value = "Y";
            }
        }
    }




    function SelectSurRdoValues(sdid) {
        document.getElementById("Did").value = sdid.split('|')[1];
        document.getElementById("rid").value = sdid.split('|')[0];
    }

</script>

<asp:HiddenField ID="hdfPaymentType" runat="server" />
<asp:HiddenField ID="hdnPaymentsDeleted" runat="server" />
<asp:HiddenField ID="hdnOtherCurrencyID" Value="0" runat="server" />
<asp:HiddenField ID="hdnOtherCurrencyRate" Value="0" runat="server" />
<asp:HiddenField ID="hdnOtherCurrency" runat="server" />
<asp:HiddenField ID="hdnPayVariableAmount" Value="0" runat="server" />
<asp:HiddenField ID="hdnRecdAmount" Value="0" runat="server" />

<script type="text/javascript" language="javascript">
    function SurgeryGetCurrencyValues() {
        var BaseCurrencyID = document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value;
        var OtherCurrencyID = document.getElementById('<%= ddCurrency.ClientID %>').value.split('~')[0];
        var OtherCurrencyRate = document.getElementById('<%= ddCurrency.ClientID %>').value.split('~')[1];
        var OtherCurrency = document.getElementById('<%= ddCurrency.ClientID %>').options[document.getElementById('<%= ddCurrency.ClientID %>').selectedIndex].text;
        SurgerySetCurrencyValues(BaseCurrencyID, OtherCurrencyID, OtherCurrencyRate, OtherCurrency);
    }

    function SurgerySetCurrencyValues(BaseCurrencyID, OtherCurrencyID, OtherCurrencyRate, OtherCurrency) {
        document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value = BaseCurrencyID;
        document.getElementById('<%= hdnOtherCurrencyID.ClientID %>').value = OtherCurrencyID;
        document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value = OtherCurrencyRate;
        document.getElementById('<%= hdnOtherCurrency.ClientID %>').value = OtherCurrency;
        SetOtherCurrValues();
        isOtherCurrDisplay("B");
    }
    function SurgeryGetCurrencyFormatValues(pAmount, pType) {

        var BaseCurrencyID = document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value;
        var OtherCurrencyID = document.getElementById('<%= hdnOtherCurrencyID.ClientID %>').value;
        var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
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
    function SurgeryGetOtherCurrency(pType) {

        var BaseCurrencyID = document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value;
        var OtherCurrencyID = document.getElementById('<%= hdnOtherCurrencyID.ClientID %>').value;
        var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
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

    function SurgerySetPaybleOtherCurr(pnetAmt, ConValue, IsDisplay) {
        var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        var OtherCurrency = document.getElementById('<%= hdnOtherCurrency.ClientID %>').value;
        SetOtherCurrPayble(OtherCurrency, OtherCurrencyRate, pnetAmt, ConValue, IsDisplay);
        var pTotalNetAmt = Number(pnetAmt) / Number(OtherCurrencyRate);
        var pTempAmt = Number(pTotalNetAmt) * Number(OtherCurrencyRate);
        document.getElementById('<%= hdnPayVariableAmount.ClientID %>').value = Number(pnetAmt) - Number(pTempAmt);
    }

    function SurgerySetReceivedOtherCurr(sVal, pServiceCharge, ConValue) {
        var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        SetOtherCurrReceived(OtherCurrencyRate, sVal, pServiceCharge, ConValue);
        var pTotalNetAmt = Number(sVal) / Number(OtherCurrencyRate);
        document.getElementById('<%= hdnRecdAmount.ClientID %>').value = pTotalNetAmt;
    }
    
   
    

</script>

