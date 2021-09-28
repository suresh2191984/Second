<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SampleBillPrint.ascx.cs"
    Inherits="CommonControls_SampleBillPrint" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>


<style type="text/css">
    .style1
    {
        height: 33px;
    }
</style>

<script language="javascript" type="text/javascript">
    var id, x, y, z, z1;
    function calculate(id) {

        x = id.split("_");

        if (x[1].substr(0, 4) == "Rate") {
            y = x[1].substr(4);
            document.getElementById(x[0] + '_Amount' + y).value = ((document.getElementById(id).value) * (document.getElementById(x[0] + '_Quantity' + y).value)).toFixed(2);
            if (document.getElementById(id).value == '') {
                document.getElementById(id).value = parseFloat(0).toFixed(2);
            }
            document.getElementById(id).value = parseFloat(document.getElementById(id).value).toFixed(2);

        }
        else {
            y = x[1].substr(8);
            document.getElementById(x[0] + '_Amount' + y).value = ((document.getElementById(id).value) * (document.getElementById(x[0] + '_Rate' + y).value)).toFixed(2);
            if (document.getElementById(id).value == '') {
                document.getElementById(id).value = parseFloat(0).toFixed(2);
            }
            document.getElementById(id).value = parseFloat(document.getElementById(id).value).toFixed(2);

        }
        //alert(x[0]+"_Rate"+y);

        total(id);
    }

    function setDiscount(id) {
        x = id.split("_");
        if ((document.getElementById(x[0] + '_ddDiscountPercent').value) == 'select') {
            document.getElementById(x[0] + '_txtDiscount').value = parseFloat(0).toFixed(2);
            document.getElementById(x[0] + '_txtDiscount').readOnly = false;
        }
    }

    function total(id) {


        var vCheckDiscount = SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_01') == null ? "please check the Discount" : SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_01');

        var vAmtReceived = SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_02') == null ? "please check the Amount Received" : SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_02');

        var SeleHosp = SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_03') == null ? "If Credit Bill, Please Select Hospital" : SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_03');


        var tax = 0;
        x = id.split("_");
        z = 0;
        z1 = 0;


        var rowcount = document.getElementById(x[0] + '_gridTab').rows.length;
        var rowlist = document.getElementById(x[0] + '_gridTab').rows;
        for (i = 1; i <= (rowcount - 1); i++) {
            if (rowlist[i].style.display != "none") {
                z1 += 1;
            }
        }

        if (z1 != 0) {

            for (i = 1; i <= (rowcount - 1); i++) {
                if (rowlist[i].style.display != "none") {
                    z = parseFloat(z) + parseFloat(document.getElementById(x[0] + '_Amount' + i).value);
                }
            }

            if (document.getElementById(x[0] + '_txtDiscount').value == '') {
                document.getElementById(x[0] + '_txtDiscount').value = parseFloat(0).toFixed(2);
            }
            if (document.getElementById(x[0] + '_txtTaxPercent').value == '') {
                document.getElementById(x[0] + '_txtTaxPercent').value = parseFloat(0).toFixed(2);
            }
            if (document.getElementById(x[0] + '_txtAmountReceived').value == '') {
                document.getElementById(x[0] + '_txtAmountReceived').value = parseFloat(0).toFixed(2);
                document.getElementById('<%= hdnAmountReceived.ClientID %>').value = parseFloat(0).toFixed(2);
            }



            //for (var i = 1; i <= 4; i++) {
            //z = parseFloat(z) + parseFloat(document.getElementById(x[0] + '_Amount' + i).value);
            //}

            document.getElementById(x[0] + '_txtGrossAmount').value = z.toFixed(2);
            //
            if ((document.getElementById(x[0] + '_ddDiscountPercent').value) != 'select') {
                document.getElementById(x[0] + '_txtDiscount').value = parseFloat((parseFloat(document.getElementById(x[0] + '_txtGrossAmount').value) / 100) * (document.getElementById(x[0] + '_ddDiscountPercent').value)).toFixed(2);
                document.getElementById(x[0] + '_txtDiscount').readOnly = true;
            }
            else {
                //this zero value assigning should be removed in case of Manual Discount Entry
                // document.getElementById(x[0] + '_txtDiscount').value = 0;
                document.getElementById(x[0] + '_txtDiscount').readOnly = false;
            }
            //
            if (parseFloat(document.getElementById(x[0] + '_txtTaxPercent').value) != 0) {

                tax = parseFloat(((parseFloat(document.getElementById(x[0] + '_txtGrossAmount').value) - parseFloat(document.getElementById(x[0] + '_txtDiscount').value)) / 100)).toFixed(2);
                tax = parseFloat(parseFloat(tax) * parseFloat(document.getElementById(x[0] + '_txtTaxPercent').value)).toFixed(2);
            }
            if (document.getElementById('<%= hdnIsRoundOff.ClientID %>').value == 'ON') {
                document.getElementById(x[0] + '_txtNetAmount').value = parseFloat(Math.round((parseFloat(document.getElementById(x[0] + '_txtGrossAmount').value) - parseFloat(document.getElementById(x[0] + '_txtDiscount').value)) + parseFloat(tax))).toFixed(2);
                document.getElementById(x[0] + '_txtNetAmount').value = parseFloat(Math.round(parseFloat(document.getElementById(x[0] + '_txtNetAmount').value) + parseFloat(document.getElementById(x[0] + '_txtPreviousDue').value))).toFixed(2);

            }
            else {
                document.getElementById(x[0] + '_txtNetAmount').value = parseFloat(((parseFloat(document.getElementById(x[0] + '_txtGrossAmount').value) - parseFloat(document.getElementById(x[0] + '_txtDiscount').value)) + parseFloat(tax))).toFixed(2);
                document.getElementById(x[0] + '_txtNetAmount').value = parseFloat((parseFloat(document.getElementById(x[0] + '_txtNetAmount').value) + parseFloat(document.getElementById(x[0] + '_txtPreviousDue').value))).toFixed(2);
            }


            if (document.getElementById(x[0] + '_chkUseCredit').checked) {
                document.getElementById(x[0] + '_txtAmountReceived').value = parseFloat(0).toFixed(2);
                document.getElementById('<%= hdnAmountReceived.ClientID %>').value = parseFloat(0).toFixed(2);
                document.getElementById(x[0] + '_txtAmountReceived').readOnly = true;
                document.getElementById(x[0] + '_txtAmountDue').value = parseFloat(document.getElementById(x[0] + '_txtNetAmount').value).toFixed(2);
            }
            else {
                document.getElementById(x[0] + '_txtAmountReceived').readOnly = false;
                if (parseFloat(document.getElementById(x[0] + '_txtAmountReceived').value) != 0) {
                    document.getElementById(x[0] + '_txtAmountDue').value = parseFloat((document.getElementById(x[0] + '_txtNetAmount').value) - document.getElementById(x[0] + '_txtAmountReceived').value).toFixed(2);
                }
                else {
                    document.getElementById(x[0] + '_txtAmountDue').value = parseFloat((document.getElementById(x[0] + '_txtNetAmount').value) - document.getElementById(x[0] + '_txtAmountReceived').value).toFixed(2);
                    // document.getElementById(x[0] + '_txtAmountDue').value = parseFloat(0).toFixed(2);
                }
            }



            document.getElementById(x[0] + '_txtDiscount').value = parseFloat(document.getElementById(x[0] + '_txtDiscount').value).toFixed(2);
            document.getElementById(x[0] + '_txtTaxPercent').value = parseFloat(document.getElementById(x[0] + '_txtTaxPercent').value).toFixed(2);
            document.getElementById(x[0] + '_txtAmountReceived').value = parseFloat(document.getElementById(x[0] + '_txtAmountReceived').value).toFixed(2);
            document.getElementById('<%= hdnAmountReceived.ClientID %>').value = parseFloat(document.getElementById(x[0] + '_txtAmountReceived').value).toFixed(2);


            if (parseFloat(document.getElementById(x[0] + '_txtDiscount').value) > parseFloat(document.getElementById(x[0] + '_txtGrossAmount').value)) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SampleBillPrint.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    // alert("please check the Discount");
                    ValidationWindow(vCheckDiscount, AlertType);
                }
                if ((document.getElementById(x[0] + '_ddDiscountPercent').value) != 'select') {
                    document.getElementById(x[0] + '_ddDiscountPercent').focus();
                }
                else {
                    document.getElementById(x[0] + '_txtDiscount').select();
                }
                return false;
            }

            if (parseFloat(document.getElementById(x[0] + '_txtAmountReceived').value) > parseFloat(document.getElementById(x[0] + '_txtNetAmount').value)) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SampleBillPrint.ascx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    //alert("please check the Amount Received");
                    ValidationWindow(vAmtReceived, AlertType);
                }
                document.getElementById(x[0] + '_txtAmountDue').value = parseFloat(0).toFixed(2);
                document.getElementById(x[0] + '_txtAmountReceived').select();
                return false;
            }

        }
        checkTotal(id);
        if (document.getElementById(x[0] + '_chkUseCredit').checked) {
            if (document.getElementById(x[0] + '_hdnCheckHospitalCredit').value == "1") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\SampleBillPrint.ascx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    // alert("If Credit Bill, Please Select Hospital");
                    ValidationWindow(SeleHosp, AlertType);
                }
                document.getElementById(x[0] + '_chkUseCredit').checked = false;
                document.getElementById('trHospital').style.display = "block";
                document.getElementById('ddlHospital').focus();
                return false;
            }
        }
        else {
            //        document.getElementById('trHospital').style.display = "none";
            //        document.getElementById(x[0] + '_hdnCheckHospitalCredit').value = "1";
            //        document.getElementById('ddlHospital').value = "0";
        }
        SetOtherCurrValues();
    }
    function checkTotal(id) {

        var vTolal = SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_04') == null ? "Total is Incorrect" : SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_04');

        x = id.split("_");
        if (parseFloat(document.getElementById(x[0] + '_txtNetAmount').value) != parseFloat(parseFloat(document.getElementById(x[0] + '_txtAmountReceived').value) + parseFloat(document.getElementById(x[0] + '_txtAmountDue').value))) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SampleBillPrint.ascx_4');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                //alert("Total is Incorrect");
                ValidationWindow(vTolal, AlertType);
            }
            return false;
        }

    }
    function SampleBillPrintDeleteRow(id, did) {

        var x;
        x = did.split("_");
        var count = 0;
        document.getElementById(id).style.display = "none";
        document.getElementById(did).value = document.getElementById(did).value + id + ",";
        var rowlist = document.getElementById(x[0] + '_gridTab').rows;
        var rowcount = document.getElementById(x[0] + '_gridTab').rows.length;
        for (i = 1; i < rowcount; i++) {
            if (rowlist[i].style.display == "none") {
                count = count + 1;
            }
        }

        if ((rowcount - 1) != 0) {
            total(did);
        }

        if (count == (rowcount - 1)) {

            document.getElementById(x[0] + '_txtGrossAmount').value = parseFloat(0).toFixed(2);
            document.getElementById(x[0] + '_txtNetAmount').value = parseFloat(0).toFixed(2);
            document.getElementById(x[0] + '_txtAmountDue').value = parseFloat(0).toFixed(2);
            document.getElementById(x[0] + '_txtAmountReceived').value = parseFloat(0).toFixed(2);
            document.getElementById('<%= hdnAmountReceived.ClientID %>').value = parseFloat(0).toFixed(2);
            document.getElementById(x[0] + '_gridTab').style.display = "none";
            //document.getElementById(x[0] + '_BtnTab').style.display = "none";
            document.getElementById(x[0] + '_linkTab').style.display = "none";
        }

    }


    function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {


        var vAmtGrt = SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_05') == null ? "Amount Entered is greater than Net Amount" : SListForAppMsg.Get('CommonControls_SampleBillPrint_ascx_05');


        //        var sVal = document.getElementById('<%= txtAmountReceived.ClientID %>').value;
        //        var sNetValue = document.getElementById('<%= txtNetAmount.ClientID %>').value;
        //        var tempService = document.getElementById('<%= txtServiceCharge.ClientID %>').value;

        //        ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

        //        sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 2);
        //        sVal = format_number(Number(sVal) + Number(TotalAmount), 2);

        var ConValue = "BillPrintCtrl_OtherCurrencyDisplay1";
        var sVal = getOtherCurrAmtValues("REC", ConValue);
        var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
        var tempService = getOtherCurrAmtValues("SER", ConValue);
        var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

        ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
        sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
        sVal = format_number(Number(sVal) + Number(TotalAmount), 4);


        if (Number(sNetValue) >= Number(sVal)) {
            sVal = format_number(sVal, 2);

            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);


            document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(pScrAmt, 2)
            document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2)
            document.getElementById('<%= txtAmountReceived.ClientID %>').value = format_number(pAmt, 2);
            document.getElementById('<%= hdnAmountReceived.ClientID %>').value = format_number(pAmt, 2);


            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('<%= txtNetAmount.ClientID %>').value = format_number(Number(pTotal), 2);
            total(document.getElementById('<%= txtAmountReceived.ClientID %>').id);
            SetOtherCurrValues();
            return true;
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\SampleBillPrint.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                // alert("Amount Entered is greater than Net Amount");
                ValidationWindow(vAmtGrt, AlertType);
            }
            return false;
        }
    }




    function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

        var ConValue = "BillPrintCtrl_OtherCurrencyDisplay1";
        var sVal = getOtherCurrAmtValues("REC", ConValue);
        var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
        var tempService = getOtherCurrAmtValues("SER", ConValue);
        var CurrRate = GetOtherCurrency("OtherCurrRate");

        sVal = Number(Number(sVal) - Number(TotalAmount));
        ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
        var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
        var pScrAmt = Number(pScr) * Number(CurrRate);
        var pAmt = Number(sVal) * Number(CurrRate);

        //        var sVal = document.getElementById('<%= txtAmountReceived.ClientID %>').value;
        //        sVal = format_number(Number(sVal) - Number(TotalAmount), 2);
        //        var tempService = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
        //        ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

        document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
        document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);

        document.getElementById('<%= txtAmountReceived.ClientID %>').value = format_number(sVal, 2);
        document.getElementById('<%= hdnAmountReceived.ClientID %>').value = format_number(sVal, 2);


        total(document.getElementById('<%= txtAmountReceived.ClientID %>').id);
        SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
        var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

        document.getElementById('<%= txtNetAmount.ClientID %>').value = format_number(Number(pTotal), 2);
        SetOtherCurrValues();
    }


</script>



<asp:Table CellPadding="5" CssClass="colorforcontentborder w-100p"
    runat="server">
    <asp:TableRow>
        <asp:TableCell CssClass="w-65p">
            <div id="holder" class="ovrflowAuto">
                <asp:Table CellPadding="4" CssClass="colorforcontentborder w-100p"
                    runat="server" ID="linkTab">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:CheckBox ID="chkUseCredit" runat="server" ToolTip="Click here to Make Credit Bill"
                                onclick="javascript:total(this.id);" Text="Credit Bill" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Table CssClass="dataheader2 w-100p"
                    runat="server" ID="Table1">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Table CellPadding="4" CssClass="colorforcontentborder w-100p"
                                runat="server" ID="gridTab">
                                <asp:TableRow CssClass="colorbillprt h-15">
                                
                                    <%--<asp:TableHeaderCell CssClass="w-30p a-left" Width="30%"> Item </asp:TableHeaderCell><asp:TableHeaderCell--%>
                                    <asp:TableHeaderCell CssClass="w-30p a-left" Width="30%"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_01%> </asp:TableHeaderCell>
                                    <asp:TableHeaderCell CssClass="w-10p"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_02%>  </asp:TableHeaderCell>
                                    <asp:TableHeaderCell CssClass="w-10p"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_03%>  </asp:TableHeaderCell>
                                    <asp:TableHeaderCell  CssClass="w-10p"><%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_04%>  </asp:TableHeaderCell></asp:TableRow>
                            </asp:Table>
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Table CellPadding="4" CssClass="colorforcontentborder w-100p"
                                runat="server" ID="MasterTab">
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-20p" ColumnSpan="1" HorizontalAlign="left">
                                        <input type="hidden" id="hdnOrderedItems" value="" runat="server" />
                                       

                                           <asp:LinkButton ID="lnkAddMore" Visible="false" CssClass="colorsample" runat="server"
                                            OnClick="lnkAddMore_Click"><u><%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_05%> </u></asp:LinkButton></asp:TableHeaderCell><asp:TableHeaderCell

                                                CssClass="w-35p" ColumnSpan="2" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_06%>  </asp:TableHeaderCell><asp:TableHeaderCell
                                                   CssClass="w-10p" HorizontalAlign="right">
                                                    <input type="text" id="txtGrossAmount" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                        value="0.00" readonly="readonly" style="width: 75px; text-align: right; border-color: #d8d8d8;
                                                        background-color: #efefef; border-style: solid;" />
                                                </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-35p" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_07%>  </asp:TableHeaderCell><asp:TableHeaderCell
                                        CssClass="w-10p" HorizontalAlign="right">
                                        <asp:DropDownList ID="ddDiscountPercent" ToolTip="Select the Discount" onChange="javascript:setDiscount(this.id);total(this.id);"
                                            runat="server">
                                        </asp:DropDownList>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell CssClass="w-10p" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_08%>  </asp:TableHeaderCell><asp:TableHeaderCell
                                       CssClass="w-10p" HorizontalAlign="right">
                                        <input type="text" id="txtDiscount" tooltip="Discount" runat="server" onblur="javascript:total(this.id);"
                                            value="0.00"    onkeypress="return ValidateOnlyNumeric(this);"   style="width: 75px; text-align: right;" />
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-55p" ColumnSpan="3" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_09%>  </asp:TableHeaderCell><asp:TableHeaderCell
                                        CssClass="w-10p" HorizontalAlign="right">
                                        <input type="text" id="txtTaxPercent" tooltip="Tax" runat="server" onblur="javascript:total(this.id);"
                                            value="0.00"    onkeypress="return ValidateOnlyNumeric(this);"   style="width: 75px; text-align: right;" />
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-55p" ColumnSpan="3" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_10%> 
                                    </asp:TableHeaderCell><asp:TableHeaderCell CssClass="w-10p" HorizontalAlign="right">
                                        <input type="text"  class="w-75 a-right" id="txtPreviousDue" tooltip="Previous Due Amount" runat="server"
                                               onkeypress="return ValidateOnlyNumeric(this);"   value="0.00" readonly="readonly" style="border-color: #d8d8d8; background-color: #efefef; border-style: solid;" />
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-55p" ColumnSpan="3" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_11%>  </asp:TableHeaderCell>
                                    <asp:TableHeaderCell CssClass="w-10p" HorizontalAlign="right">
                                        <asp:TextBox ID="txtServiceCharge"  Enabled="false" runat="server" Text="0.00" TabIndex="9"
                                            CssClass="textBoxRightAlign w-75 a-right" Style="border-color: #d8d8d8;
                                            background-color: #efefef; border-style: solid;" />
                                        <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-55p" ColumnSpan="3" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_12%> 
                                    </asp:TableHeaderCell><asp:TableHeaderCell CssClass="w-10p" HorizontalAlign="right">
                                        <input type="text" id="txtNetAmount" tooltip="Net Amount" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                            value="0.00" readonly="readonly" class="w-75 a-right" style="border-color: #d8d8d8;
                                            background-color: #efefef; border-style: solid;" />
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-55p" ColumnSpan="3" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_13%>  </asp:TableHeaderCell>
                                    <asp:TableHeaderCell CssClass="w-10p" HorizontalAlign="right">
                                        <input type="text" id="txtAmountReceived" tooltip="Amount Received" runat="server"
                                            disabled="disabled" onblur="javascript:total(this.id);" value="0.00"    onkeypress="return ValidateOnlyNumeric(this);"  
                                            class="w-75 a-right" />
                                        <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-55p" ColumnSpan="3" HorizontalAlign="right"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_14%>  </asp:TableHeaderCell><asp:TableHeaderCell
                                        CssClass="w-10p" HorizontalAlign="right">
                                        <input type="text" id="txtAmountDue" runat="server" tooltip="Amount Due"    onkeypress="return ValidateOnlyNumeric(this);"  
                                            value="0.00" readonly="readonly" class="w-75 a-right" style="border-color: #d8d8d8;
                                            background-color: #efefef; border-style: solid;" />
                                    </asp:TableHeaderCell></asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableHeaderCell CssClass="w-55p" ColumnSpan="3" HorizontalAlign="Left">  </asp:TableHeaderCell><asp:TableHeaderCell
                                        CssClass="w-10p" HorizontalAlign="right">
                                        
                                        <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                    </asp:TableHeaderCell></asp:TableRow>
                            </asp:Table>
                        </asp:TableCell></asp:TableRow>
                </asp:Table>
            </div>
            <asp:Table Visible="false" CellPadding="4" CssClass="colorforcontentborder w-65p" 
                runat="server" ID="BtnTab">
                <asp:TableRow CssClass="h-15">
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="btnFinish" ToolTip="Click here to Save the Bill" Style="cursor: pointer;"
                            UseSubmitBehavior="true" runat="server" OnClientClick="return checkTotal(this.id);"
                            OnClick="btnFinish_Click" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" />
                        <asp:Button ID="btnCancel" runat="server" Text="Home" ToolTip="Click here to Cancel the Bill, View the Home Page"
                            Style="cursor: pointer;" OnClick="btnCancel_Click" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:TableCell><asp:TableCell CssClass="w-35p v-top">
            <br />
            <br />
            <input type="hidden" id="did" runat="server" />
             <input type="hidden" id="hdnIsRoundOff"  runat="server"/>
            <asp:Table CssClass="dataheaderInvCtrl w-100p"
                runat="server" ID="AddConTab">
                <asp:TableRow>
                    <asp:TableCell VerticalAlign="Top">
                        <asp:Table CssClass="colorforcontentborder w-100p"
                            runat="server" ID="Table2">
                            <asp:TableRow CssClass="colorbillprt h-15">
                                <asp:TableHeaderCell CssClass="w-100p" ColumnSpan="3" HorizontalAlign="Left">
                                    <label id="addNewItemCaption" runat="server">
                                    </label>
                                </asp:TableHeaderCell></asp:TableRow>
                            <asp:TableRow CssClass="h-30">
                                <asp:TableCell CssClass="w=20p"> <%=Resources.CommonControls_ClientDisplay.CommonControls_SampleBillPrint_ascx_15%>  </asp:TableCell><asp:TableCell CssClass="w=60p" HorizontalAlign="center">
                                    <input type="text" id="txtNewItemName" runat="server" value="" class="a-left" style="width: 150px;" />
                                </asp:TableCell><asp:TableCell CssClass="w=20p">
                                    <asp:Button ID="btnAddNewItem" OnClick="btnAddNewItem_Click" runat="server" Text="ADD"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
<uc9:paymentType ID="PaymentType" runat="server" />
<table id="commentsTab" runat="server">
    <tr id="commentsBlock" runat="server" style="display: block;">
        <td class="a-left v-middle paddingB5 paddingL20">
            <asp:Label ID="lblComments" runat="server" ForeColor="#000000" CssClass="font12" Font-Bold="true">Comments</asp:Label>
            <textarea id="txtComments" tabindex="4" runat="server" rows="2" cols="45"></textarea>
        </td>
    </tr>
</table>
<input type="hidden" id="hdnCheckHospitalCredit" value="0" runat="server" />

<script language="javascript" type="text/javascript">


    function SetOtherCurrValues() {
        var pnetAmt = 0;
        pnetAmt = document.getElementById('<%=txtNetAmount.ClientID %>').value == "" ? "0" : document.getElementById('<%=txtNetAmount.ClientID %>').value;
        var ConValue = "BillPrintCtrl_OtherCurrencyDisplay1";
        SetPaybleOtherCurr(pnetAmt, ConValue, true);
    }

    GetCurrencyValues();
</script>