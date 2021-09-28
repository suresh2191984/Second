<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SurgeryAdvance.ascx.cs"
    Inherits="CommonControls_SurgeryAdvance" %>
<asp:Panel ID="pres" runat="server" Width="500px" meta:resourcekey="presResource1">
    <table cellpadding="0" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%"
        runat="server" style="display: none;" id="tbAdvance">
        <tr style="height: 10px;" runat="server">
            <td style="font-weight: normal; color: #000;" align="center" runat="server">
                <input type="hidden" id="Did" name="Did" />
                <input type="hidden" id="rid" name="rid" />
                <asp:GridView ID="gvTreatment" runat="server" AutoGenerateColumns="False" DataKeyNames="FeeID"
                    OnRowDataBound="gvTreatment_RowDataBound" Width="720px">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblSurgeryBillingID" runat="server" Text='<%#Bind("FeeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Treatment Name">
                            <ItemTemplate>
                                <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%#Bind("Description") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estimated Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Text='<%#Bind("Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Paid Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblAdvanceAmount" runat="server" Text='<%#Bind("AdvanceAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblCreatedAt" runat="server" Text='<%#Bind("CreatedAt") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <table>
        <tr align="right" style="display: none">
            <td align="right">
                <asp:CheckBox ID="chkisCreditTransaction" Text="Credit Transaction" runat="server"
                    class="defaultfontcolor" meta:resourcekey="chkisCreditTransactionResource1" />
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="Duecolor" width="25%" height="23" align="left">
                &nbsp;&nbsp;<asp:Label ID="Rs_PaymentType" runat="server" Text="Payment Type" meta:resourcekey="Rs_PaymentTypeResource1"></asp:Label>
            </td>
            <td width="75%" height="23" align="left">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="dataheader2">
                    <table width="100%" border="1" cellspacing="1" cellpadding="1" class="tabletxt">
                        <tr align="center">
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Type" runat="server" Text=" Type" meta:resourcekey="Rs_TypeResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Amount" runat="server" Text="Amount(<%= CurrencyName %>)" meta:resourcekey="Rs_AmountResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ChequeCardDDNo" runat="server" Text="Cheque/Card/DDNo." meta:resourcekey="Rs_ChequeCardDDNoResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_BankcardType" runat="server" Text="Bank/Card Type" meta:resourcekey="Rs_BankcardTypeResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_ServiceCharge" runat="server" Text="Service Charge(%)" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="Rs_Total" runat="server" Text="Total(<%= CurrencyName %>)" meta:resourcekey="Rs_TotalResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" width="110px" style="display: none;">
                                <asp:Label ID="Rs_Remarks" runat="server" Text="Remarks" meta:resourcekey="Rs_RemarksResource1"></asp:Label>
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
                                <asp:TextBox runat="server" ID="txtNumber"    onkeypress="return ValidateOnlyNumeric(this);"  
                                    autocomplete="off" Width="130px" MaxLength="19" meta:resourcekey="txtNumberResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtBankType" Width="130px" autocomplete="off" meta:resourcekey="txtBankTypeResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:TextBox runat="server" ID="txtServiceCharge"    onkeypress="return ValidateOnlyNumeric(this);"  
                                    Width="60px" onChange="javascript:changeAmountValues();" Style="text-align: right;"
                                    MaxLength="9" autocomplete="off" meta:resourcekey="txtServiceChargeResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <asp:Label ID="txtTotalAmount" runat="server" autocomplete="off" MaxLength="9" Width="60px"
                                    meta:resourcekey="txtTotalAmountResource1"></asp:Label>
                            </td>
                            <td nowrap="nowrap" style="display: none;">
                                <asp:TextBox ID="txtRemarks" runat="server" Width="150px" autocomplete="off" meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                            </td>
                            <td nowrap="nowrap">
                                <input type="button" id="addNewPayment" value="<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_Add %>" tooltip="Add" class="btn" onclick="PaymentTypeValidation();return false;" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
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

    function PaymentTypeValidation() {
        var ctlDp = document.getElementById('<%= ddlPaymentType.ClientID %>');
        var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value;
        var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');

        var PaymentAmount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var PaymentMethodNumber = document.getElementById('<%= txtNumber.ClientID %>').value;
        var PaymentBankType = document.getElementById('<%= txtBankType.ClientID %>').value;
        var PaymentRemarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
        var ServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        var TotalAmount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        if (document.getElementById("Did").value == '') {
            alert('select Treatment Plan');
            return false;
        }
        else if ((PaymentTypeID == "0") || (PaymentAmount == "")) {

            alert("Payment Type and Amount Required");
        }
        else if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
            alert("Please Enter Cheque/Card Number");
            document.getElementById('<%= txtNumber.ClientID %>').focus();
        }
        else if (PaymentName != 'Cash' && PaymentBankType == "") {
            alert("Please Enter Bank Name/Card Type");
            document.getElementById('<%= txtBankType.ClientID %>').focus();
        }
        else {
            PaymentAmount = format_number(PaymentAmount, 2);
            if (PaymentName != 'Cash') {
                ServiceCharge = format_number(ServiceCharge, 2);
            }
            if (Number(PaymentAmount) >= 0) {

                var returnType = ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge);
                if (returnType == true) {

                    var SelectedValue = document.getElementById("Did").value;
                    var SlectedRowID = document.getElementById("rid").value;


                    var SurgeryDetailIDAndName = new Array();
                    SurgeryDetailIDAndName = SelectedValue.split('~');
                    var SurgeryDetailID = SurgeryDetailIDAndName[0];
                    var SurgeryName = SurgeryDetailIDAndName[1];


                    var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber + "~"
                                + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID + "~"
                                + SurgeryDetailID + "~" + SurgeryName + "~" + SlectedRowID + "~" + ServiceCharge + "~" + TotalAmount;

                    CmdAddPaymentType_onclick(retval);
                }
            }
            else {
                alert("Amont should be greater than zero");
            }
        }

    }
    function CmdAddPaymentType_onclick(gotValue) {
        var PaymentViewStateValue = document.getElementById('<%= hdfPaymentType.ClientID %>').value;


        var PaymentarrayGotValue = new Array();
        PaymentarrayGotValue = gotValue.split('~');
        var SlectedRowID, SurgeryDetailID, SurgeryName, PaymentName, PaymentAmount, PaymentMethodNumber, PaymentBankType, PaymentRemarks, PaymentTypeID, ServiceCharge, TotalAmount;

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


        }
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;

        if (iPaymentAlreadyPresent == 0) {
            PaymentViewStateValue += "RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "|";
            document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymentViewStateValue;
            CreatePaymentTables();
            PaymentControlclear();
            SelectedRowClear(SlectedRowID);
        }
        else {
            alert("Payment Name already exists");
        }

    }

    function CreatePaymentTables() {
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML = "";
        var newPaymentTables, startPaymentTag, endPaymentTag;
        var PaymentViewStateValue = document.getElementById('<%= hdfPaymentType.ClientID %>').value;

        startPaymentTag = "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' ><TBODY><tr><td style=\"display:none\">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_DetailID %>"+"</td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_TreatmentName%>"+"</td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_Type %>"+"</td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_Amount %>"+" </td> <td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_ChequeCardDDNo %>"+"</td> <td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_BankCardType %>"+"</td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_ServiceCharge %>"+"</td><td style='display:none'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_Remarks %>"+"</td><td>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_TotalAmount %>"+"</td><td style=\"display:none\">"+"<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_RowID %>"+"</td><td></td> </tr>";
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
                    }
                }
                var chkBoxName = "RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "";
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

                newPaymentTables += "<TD><input name='RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "' onclick='btnPaymentEdit_OnClick(name);' value ='<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />|<input name='RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "~SurgeryDetailID^" + SurgeryDetailID + "~SurgeryName^" + SurgeryName + "~SlectedRowID^" + SlectedRowID + "~ServiceCharge^" + ServiceCharge + "~TotalAmount^" + TotalAmount + "' onclick='btnPaymentDelete_OnClick(name);' value ='<%=Resources.ClientSideDisplayTexts.CommonControls_SurgeryAdvance_Delete %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" +
                            "<TR>";


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


        DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;

        CreatePaymentTables();
    }

    function btnPaymentDelete_OnClick(sEditedData) {

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

        DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge);

        document.getElementById('<%= hdfPaymentType.ClientID %>').value = PaymenttempDatas;
        CreatePaymentTables();
    }

    function PaymentControlclear() {
        document.getElementById('<%= ddlPaymentType.ClientID %>').value = "0";
        document.getElementById('<%= txtAmount.ClientID %>').value = "";
        document.getElementById('<%= txtNumber.ClientID %>').value = "";
        document.getElementById('<%= txtBankType.ClientID %>').value = "";
        document.getElementById('<%= txtRemarks.ClientID %>').value = "";
        document.getElementById('<%= txtServiceCharge.ClientID %>').value = "";
        document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML = "";
    }
    function SelectedRowClear(RowID) {
        document.getElementById(RowID).checked = false;
        document.getElementById("Did").value = "";
        document.getElementById("rid").value = "";
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
        var txtTotalAMount = document.getElementById('<%= txtTotalAmount.ClientID %>').innerHTML;

        if ((PaymentTypeID != "0") || (PaymentAmount != "")) {
            //            alert("Payment Type and Amount Required");
            //        }
            //        else
            if (PaymentName != 'Cash' && PaymentMethodNumber == "") {
                alert("Please Enter Cheque/Card Number");
                document.getElementById('<%= txtNumber.ClientID %>').focus();
                return false;
            }
            else if (PaymentName != 'Cash' && PaymentBankType == "") {
                alert("Please Enter Bank Name/Card Type");
                document.getElementById('<%= txtBankType.ClientID %>').focus();
                return false;
            }
            else {
                PaymentAmount = format_number(PaymentAmount, 2);
                ServiceCharge = format_number(ServiceCharge, 2);

                if (Number(PaymentAmount) >= 0) {

                    var returnType = ModifyAmountValue(PaymentAmount, PaymentAmount, ServiceCharge);
                    if (returnType == true) {
                        var retval = PaymentName + "~" + PaymentAmount + "~" + PaymentMethodNumber
                                    + "~" + PaymentBankType + "~" + PaymentRemarks + "~" + PaymentTypeID
                                    + "~" + ServiceCharge + "~" + TotalAMount;
                        CmdAddPaymentType_onclick(retval);

                        return true;
                    }
                }
                else {
                    alert("Amont should be greater than zero");
                    return false;
                }
            }
        }
        else {
            return true;
        }
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

<asp:HiddenField ID="hdfPaymentType" runat="server" />
<%--<asp:HiddenField ID="hdnPaymentExists" runat="server" />--%>
<asp:HiddenField ID="hdnPaymentsDeleted" runat="server" />
