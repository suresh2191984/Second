<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DuePaymentType.ascx.cs"
    Inherits="CommonControls_DuePaymentType" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Panel ID="pres" runat="server" Width="100%" meta:resourcekey="presResource1">
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
            <td class="Duecolor" height="23" align="left">
                &nbsp;&nbsp;<asp:Label ID="Rs_PaymentModes" Text="Payment Modes" runat="server" meta:resourcekey="Rs_PaymentModesResource1" />
                &nbsp;
            </td>
            <td class="Duecolor" align="center">
                <asp:Label ID="Rs_SelectCurrencyType" Text="Select Currency Type" Font-Bold="True"
                    runat="server" meta:resourcekey="Rs_SelectCurrencyTypeResource1" />
                &nbsp;&nbsp; :
                <asp:DropDownList Width="150px" onchange="GetCurrencyValues();" CssClass="bilddltb"
                    ID="ddCurrency" runat="server" meta:resourcekey="ddCurrencyResource1">
                   
                </asp:DropDownList>
                <input id="hdnBaseCurrencyID" runat="server" type="hidden"></input>

            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dataheaderInvCtrl">
                    <table width="100%" border="1" cellspacing="1" cellpadding="1" class="tabletxt">
                        <tr align="center">
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Type" Text="Type" runat="server" meta:resourcekey="Rs_TypeResource1" />
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Amount" Text="Amount" runat="server" meta:resourcekey="Rs_AmountResource1" />
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ChequeandCardandDDNo" Text="Cheque/Card/DDNo." runat="server" meta:resourcekey="Rs_ChequeandCardandDDNoResource1" />
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_BankCardType" Text="Bank/Card Type" runat="server" meta:resourcekey="Rs_BankCardTypeResource1" />
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ServiceCharge" Text="Service Charge(%)" runat="server" meta:resourcekey="Rs_ServiceChargeResource1" />
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Total" Text="Total" runat="server" meta:resourcekey="Rs_TotalResource1" />
                            </td>
                            <td nowrap="nowrap" width="110px" style="display: none;">
                                <asp:Label ID="Rs_Remarks" Text="Remarks" runat="server" meta:resourcekey="Rs_RemarksResource1" />
                            </td>
                        </tr>
                        <tr align="center">
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="ddlPaymentType" runat="server" onchange="javascript:Paymentchanged();"
                                    meta:resourcekey="ddlPaymentTypeResource1">
                                 </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtAmount" onChange="javascript:changeAmountValues();"
                                       onkeypress="return ValidateOnlyNumeric(this);"   Width="65px" MaxLength="9" autocomplete="off"
                                    meta:resourcekey="txtAmountResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" Style="display: none;" ID="txtNumber"    onkeypress="return ValidateOnlyNumeric(this);"  
                                    autocomplete="off" Width="110px" MaxLength="19" meta:resourcekey="txtNumberResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" Style="display: none;" ID="txtBankType" Width="150px"
                                    meta:resourcekey="txtBankTypeResource1"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtBankType"
                                    EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="listtwo"
                                    CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                    ServiceMethod="GetBankName" ServicePath="~/InventoryWebService.asmx" DelimiterCharacters=""
                                    Enabled="True">
                                </cc1:AutoCompleteExtender>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtServiceCharge"    onkeypress="return ValidateOnlyNumeric(this);"  
                                    Width="60px" onChange="javascript:changeAmountValues();" Style="text-align: right;
                                    display: none;" MaxLength="9" autocomplete="off" meta:resourcekey="txtServiceChargeResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="txtTotalAmount" runat="server" autocomplete="off" MaxLength="9" Width="60px"
                                    meta:resourcekey="txtTotalAmountResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" style="display: none;">
                                <asp:TextBox ID="txtRemarks" runat="server" Width="150px" autocomplete="off" meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <input type="button" id="addNewPayment" value="Add" tooltip="Add" class="btn" tabindex=''
                                    onclick="PaymentTypeValidation();" />
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
</asp:Panel>

<script type="text/javascript" language="javascript">

    function ClearPaymentControlEvents() {
        document.getElementById('<%= hdfPaymentType.ClientID %>').value = "";
        CreatePaymentTables();

    }

    function PaymentSaveValidation() {
        var alertpayment = false;

        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;




        if (PaymentTypeID != "0" && PaymentTypeID != "") {



            if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else { alert("Please Enter Cheque/Card Number"); }
                document.getElementById('<%= txtNumber.ClientID %>').focus();
                return false;
            }
            else if (PaymentName != 'Cash' && PaymentBankType == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_2');
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


                    var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                    if (returnType == true) {

                        var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                        var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAmount + "~" + OtherCurrAmt;
                        CmdAddPaymentType_onclick(retval);
                        return true;
                    }
                }
                else {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_3');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert("Amount should be greater than zero");
                    }
                    return false;
                }
            }
        }
        else {
            return true;
        }

    }

    function PaymentTypeValidation() {
        var alertpayment = false;

        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        //code added for bug fix - 0 amount begin
        if (PaymentAmount <= 0) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_4');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Please Enter Amount greater than 0");
            }
            document.getElementById('<%= txtAmount.ClientID %>').value = '';
            document.getElementById('<%= txtAmount.ClientID %>').focus();
            return false;
        }

        //code added for bug fix - 0 amount ends


        if ((PaymentTypeID == "0") || (PaymentAmount == "")) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Payment Type and Amount Required");
            }
            return false;
        }
        else if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
        } else {
            alert("Please Enter Cheque/Card Number");
        }
            document.getElementById('<%= txtNumber.ClientID %>').focus();
            return false;
        }
        else if (PaymentName != 'Cash' && PaymentBankType == "") {
        var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_2');
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


                var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                if (returnType == true) {

                    var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                    var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAmount + "~" + OtherCurrAmt;
                    CmdAddPaymentType_onclick(retval);
                    return true;
                }
            }
            else {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_8');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Amont should be greater than zero");
                }
                return false;
            }
        }

    }

    function PaymentsValidation() {
        var alertpayment = false;

        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        if (Number(PaymentAmount) >= 0) {
            var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
            if (returnType == true) {
                var OtherCurrAmt = Number(TotalAMount) * Number(OtherCurrencyRate);
                var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAMount + "~" + OtherCurrAmt;
                CmdAddPaymentType_onclick(retval);
                return true;
            }
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_8');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Amont should be greater than zero");
            }
            return false;
        }


    }

    function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

        var ConValue = "OtherCurrencyDisplay1";
        var sVal = getOtherCurrAmtValues("REC", ConValue);
        var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
        var tempService = getOtherCurrAmtValues("SER", ConValue);
        var CurrRate = GetOtherCurrency("OtherCurrRate");

        sVal = Number(Number(sVal) - Number(TotalAmount));
        ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
        var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
        var pScrAmt = Number(pScr) * Number(CurrRate);
        var pAmt = Number(sVal) * Number(CurrRate);


        document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
        var amtRec = document.getElementById('hdnDepositUsed').value;
        amtRec = 0;
        document.getElementById('hdnAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
        document.getElementById('txtAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);


        //    document.getElementById('hdnAmountRecieved').value = format_number(sVal, 2);
        //    document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);


        // totalCalculate();


        SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

        var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

        //document.getElementById('txtNetAmount').value = format_number(Number(pTotal), 2);
        document.getElementById('hdnNetAmount').value = format_number(Number(pTotal), 2);
        //CheckDueTotal();
    }

    function CmdAddPaymentType_onclick(gotValue) {
        var PaymentViewStateValue = document.getElementById('<%= hdfPaymentType.ClientID %>').value;


        var PaymentarrayGotValue = new Array();
        PaymentarrayGotValue = gotValue.split('~');
        var PaymentName, PaymentAmount, PaymentMethodNumber, PaymentBankType, PaymentRemarks, PaymentTypeID, ServiceCharge, TotalAmount, OtherCurrAmt;

        if (PaymentarrayGotValue.length > 0) {
            PaymentName = PaymentarrayGotValue[0];
            PaymentAmount = PaymentarrayGotValue[1];
            PaymentMethodNumber = PaymentarrayGotValue[2];
            PaymentBankType = PaymentarrayGotValue[3];
            PaymentRemarks = PaymentarrayGotValue[4];
            PaymentTypeID = PaymentarrayGotValue[5];
            ServiceCharge = PaymentarrayGotValue[6];
            TotalAmount = PaymentarrayGotValue[7];
            OtherCurrAmt = PaymentarrayGotValue[8];
        }
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;

        if (iPaymentAlreadyPresent == 0) {
            PaymentViewStateValue += "RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "|";
            document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymentViewStateValue;
            CreatePaymentTables();
            PaymentControlclear();
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_10');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Payment Name already exists");
            }
        }

    }

    function CreatePaymentTables() {
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
                    PaymentViewStateValue += "RID^" + Row + "~" + val[1] + "~" + val[2] + "~" + val[3] + "~" + val[4] + "~" + val[5] + "~" + val[6] + "~" + val[7] + "~" + val[8] + "~" + val[9] + "|";
                    Row = Number(Row) + 1;
                }
            }
        }

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymentViewStateValue;
        if ('<%= EnabledCurrType %>' == true) {
            document.getElementById('<%= ddCurrency.ClientID %>').disabled = false;
        }


        startPaymentTag = "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' Border='1' Width='100%' style='BackgroundColor:#ff6600;' ><TBODY><tr><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_Type %>"+"</td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_Amount %>"+" </td> <td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_ChequeCardDDNo %>"+"</td> <td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_BankCardType %>"+"</td> <td > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_ServiceCharge %>"+"</td><td style='display:none'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_Remarks %>"+"</td><td>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_TotalAmount %>"+"</td><td></td> </tr>";
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
                var chkBoxName = "RID^" + RID + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "";

                if (PaymentAmount != 0) {
                    document.getElementById('<%= ddCurrency.ClientID %>').disabled = true;
                    newPaymentTables += "<TR><TD >" + PaymentName + "</TD>";
                    newPaymentTables += "<TD >" + PaymentAmount + "</TD>";
                    newPaymentTables += "<TD >" + PaymentMethodNumber + "</TD>";
                    newPaymentTables += "<TD >" + PaymentBankType + "</TD>";
                    newPaymentTables += "<TD >" + ServiceCharge + "</TD>";
                    newPaymentTables += "<TD style='Display:none;'>" + PaymentRemarks + "</TD>";
                    newPaymentTables += "<TD >" + TotalAmount + "</TD>";

                    newPaymentTables += "<TD><input name='RID^" + RID + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "' onclick='btnPaymentEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_DuePaymentType_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                    //|<input name='RID^" + RID + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "~OtherCurrAmt^" + OtherCurrAmt + "' onclick='btnPaymentDelete_OnClick(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";
                    //document.getElementById('OtherCurrencyDisplay1_lblOtherCurrRecdAmount').value = PaymentAmount;
                }
            }
        }

        newPaymentTables += endPaymentTag;
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML += newPaymentTables;
        //document.getElementById('<%= ddlPaymentType.ClientID %>').focus();

    }


    function btnPaymentEdit_OnClick(sEditedData) {

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
        var arrayServiceCharge = new Array();
        var arrayTotalAmount = new Array();

        PaymentarrayGotValue = sEditedData.split('~');
        var PaymentName, PaymentAmount, PaymentMethodNumber, PaymentBankType, PaymentRemarks, PaymentTypeID, ServiceCharge, TotalAmount;
        if (PaymenttempDatas.split('|').length == 1 || PaymenttempDatas == "") {
            lastRow = "Y";
        }
        if (PaymentarrayGotValue.length > 0) {

            PaymentName = PaymentarrayGotValue[1];
            PaymentAmount = PaymentarrayGotValue[2];
            PaymentMethodNumber = PaymentarrayGotValue[3];
            PaymentBankType = PaymentarrayGotValue[4];
            PaymentRemarks = PaymentarrayGotValue[5];
            PaymentTypeID = PaymentarrayGotValue[6];
            ServiceCharge = PaymentarrayGotValue[7];
            TotalAmount = PaymentarrayGotValue[8];

            arrayPaymentName = PaymentName.split('^');
            arrayAmount = PaymentAmount.split('^');
            arrayChequeNo = PaymentMethodNumber.split('^');
            arrayBankName = PaymentBankType.split('^');
            arrayRemarks = PaymentRemarks.split('^');
            arrayPaymentTypeID = PaymentTypeID.split('^');
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

        DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;

        CreatePaymentTables();
        Paymentchanged();

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
        var arrayServiceCharge = new Array();
        var arrayTotalAmount = new Array();

        PaymentarrayGotValue = sEditedData.split('~');
        var PaymentName, PaymentAmount, PaymentMethodNumber, PaymentBankType, PaymentRemarks, PaymentTypeID, ServiceCharge, TotalAmount;
        if (PaymenttempDatas.split('|').length == 1 || PaymenttempDatas == "") {
            lastRow = "Y";
        }
        if (PaymentarrayGotValue.length > 0) {

            PaymentName = PaymentarrayGotValue[1];
            PaymentAmount = PaymentarrayGotValue[2];
            PaymentMethodNumber = PaymentarrayGotValue[3];
            PaymentBankType = PaymentarrayGotValue[4];
            PaymentRemarks = PaymentarrayGotValue[5];
            PaymentTypeID = PaymentarrayGotValue[6];
            ServiceCharge = PaymentarrayGotValue[7];
            TotalAmount = PaymentarrayGotValue[8];

            arrayPaymentName = PaymentName.split('^');
            arrayAmount = PaymentAmount.split('^');
            arrayChequeNo = PaymentMethodNumber.split('^');
            arrayBankName = PaymentBankType.split('^');
            arrayRemarks = PaymentRemarks.split('^');
            arrayPaymentTypeID = PaymentTypeID.split('^');
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
            //lastRow
            tmpTotalAmount = arrayTotalAmount[1];
        }

        DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;
        CreatePaymentTables();
        Paymentchanged();

    }

    function PaymentControlclear() {
        document.getElementById('<%= ddlPaymentType.ClientID %>').value = document.getElementById('<%= hdfDefaultPaymentMode.ClientID %>').value;
        document.getElementById('<%= txtAmount.ClientID %>').value = "";
        document.getElementById('<%= txtNumber.ClientID %>').value = "";
        document.getElementById('<%= txtBankType.ClientID %>').value = "";
        document.getElementById('<%= txtRemarks.ClientID %>').value = "";
        document.getElementById('<%= txtServiceCharge.ClientID %>').value = "0";
        document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = "";
        Paymentchanged();
    }

    function Paymentchanged() {

        var ctrlPaymentType = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var sPaymentType = trim(ctrlPaymentType.options[ctrlPaymentType.selectedIndex].text.split('@')[0], ' ');
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
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentName = ctlDp.options[ctlDp.selectedIndex].innerHTML;

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAMount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;
        //code added for bug fix - 0 amount begin
        if ((PaymentTypeID != "0") && (PaymentAmount != "") && (PaymentAmount > 0)) {
            //code added for bug fix - 0 amount begin
            //            alert("Payment Type and Amount Required");
            //        }
            //        else
            if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please Enter Cheque/Card Number");
                }
                document.getElementById('<%= txtNumber.ClientID %>').focus();
                return false;
            }
            else if (PaymentName != 'Cash' && PaymentBankType == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_2');
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

                    var returnType = ModifyAmountValue(PaymentAmount, PaymentAmount, ServiceCharge);
                    if (returnType == true) {

                        var OtherCurrAmt = Number(TotalAmount) * Number(OtherCurrencyRate);
                        var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAMount + "~" + OtherCurrAmt;
                        CmdAddPaymentType_onclick(retval);

                        return true;
                    }
                }
                else {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_8');
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
    function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {


        var ConValue = "OtherCurrencyDisplay1";

        var sVal = getOtherCurrAmtValues("REC", ConValue);
        var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
        var tempService = getOtherCurrAmtValues("SER", ConValue);
        var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

        ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
        sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
        sVal = format_number(Number(sVal) + Number(TotalAmount), 4);
        if (PaymentAmount > 0) {

            if (Number(sNetValue) >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)



                var amtRec = document.getElementById('hdnDepositUsed').value;
                amtRec = 0;
                document.getElementById('hdnAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
                document.getElementById('txtAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);

                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);


                //document.getElementById('txtNetAmount').value = format_number(Number(pTotal), 2);
                document.getElementById('hdnNetAmount').value = format_number(Number(pTotal), 2);
                //CheckDueTotal();
                return true;
            }
            else {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_14');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Amount provided is greater than net amount')
                }
                return false;
            }
        }
        else {
            return true;
        }
    }
    function CheckDueTotal() {
        var AmountRecieved = document.getElementById('txtAmountRecieved').value;
        var AmountRecieved = document.getElementById('hdnAmountRecieved').value;
        var GrandTotal = document.getElementById('hdnNetAmount').value;

        var serviceCharge = document.getElementById('txtServiceCharge').value;
        GrandTotal = parseFloat(GrandTotal);

        if (parseFloat(GrandTotal) >= parseFloat(AmountRecieved)) {
            //var AmountDue = document.getElementById('txtAmountDue').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);
            var AmountDue = document.getElementById('hdnAmountDue').value = parseFloat(parseFloat(GrandTotal) - parseFloat(AmountRecieved)).toFixed(2);

        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_15');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('Provide received amount less than or equal to net amount');
            }
            return false;
        }
        SetOtherCurrValues();

    }
    function changeAmountValues() {
        var sServiceAmount = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var sAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        sServiceAmount = Number(sServiceAmount);
        sAmount = Number(sAmount);
        sAmount = sAmount + (sAmount * sServiceAmount / 100);
        document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = format_number(sAmount, 2);
        return false;
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

<script type="text/javascript" language="javascript">
    function GetCurrencyValues() {
        var alert = SListForAppMsg.Get("CommonControls_Header_Alert") == null ? "Alert" : SListForAppMsg.Get("CommonControls_Header_Alert");
        var cur = SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_19") == null ? "Select Currency Type" : SListForAppMsg.Get("CommonControls_PaymentTypeDetails_ascx_19");
    
   // var cur = CommonControls_PaymentTypeDetails_ascx_19
        if (document.getElementById('<%= ddCurrency.ClientID %>').value == "0") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DuePaymentType.ascx_16');
            if (userMsg != null) {
                //  alert(userMsg);
                ValidationWindow(userMsg, alert);
            } else {
            ValidationWindow(cur, alert);
                alert("Select Currency Type");
            }
            document.getElementById('<%= ddCurrency.ClientID %>').focus();
            return false;
        }
        var BaseCurrencyID = document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value;
        var OtherCurrencyID = document.getElementById('<%= ddCurrency.ClientID %>').value.split('~')[0];
        var OtherCurrencyRate = document.getElementById('<%= ddCurrency.ClientID %>').value.split('~')[1];
        var OtherCurrency = document.getElementById('<%= ddCurrency.ClientID %>').options[document.getElementById('<%= ddCurrency.ClientID %>').selectedIndex].text;
        SetCurrencyValues(BaseCurrencyID, OtherCurrencyID, OtherCurrencyRate, OtherCurrency);
    }

    function SetCurrencyValues(BaseCurrencyID, OtherCurrencyID, OtherCurrencyRate, OtherCurrency) {
        document.getElementById('<%= hdnBaseCurrencyID.ClientID %>').value = BaseCurrencyID;
        document.getElementById('<%= hdnOtherCurrencyID.ClientID %>').value = OtherCurrencyID;
        document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value = OtherCurrencyRate;
        document.getElementById('<%= hdnOtherCurrency.ClientID %>').value = OtherCurrency;
        SetOtherCurrValues();
        isOtherCurrDisplay("B");
    }
    function GetCurrencyFormatValues(pAmount, pType) {

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
    function GetOtherCurrency(pType) {

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

    function SetPaybleOtherCurr(pnetAmt, ConValue, IsDisplay) {
        var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        var OtherCurrency = document.getElementById('<%= hdnOtherCurrency.ClientID %>').value;
        SetOtherCurrPayble(OtherCurrency, OtherCurrencyRate, pnetAmt, ConValue, IsDisplay);
        var pTotalNetAmt = Number(pnetAmt) / Number(OtherCurrencyRate);
        var pTempAmt = Number(pTotalNetAmt) * Number(OtherCurrencyRate);
        document.getElementById('<%= hdnPayVariableAmount.ClientID %>').value = Number(pnetAmt) - Number(pTempAmt);
    }

    function SetReceivedOtherCurr(sVal, pServiceCharge, ConValue) {
        var OtherCurrencyRate = document.getElementById('<%= hdnOtherCurrencyRate.ClientID %>').value;
        SetOtherCurrReceived(OtherCurrencyRate, sVal, pServiceCharge, ConValue);
        var pTotalNetAmt = Number(sVal) / Number(OtherCurrencyRate);
        document.getElementById('<%= hdnRecdAmount.ClientID %>').value = pTotalNetAmt;
    }
    
   
    

</script>

