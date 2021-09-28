<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OPBillSettlement.aspx.cs"
    Inherits="Billing_OPBillSettlement" EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Billing Settlement</title>

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <style type="text/css">
        .Left
        {
            text-align: left;
        }
        .right
        {
            text-align: right;
        }
    </style>

    <script type="text/javascript">

        function ClientSelected(source, eventArgs) {

            var list = eventArgs.get_value().split('^');
            var slist = eventArgs.get_value().split('###');
            fn_bindRateType(slist);
            //setClientValues(slist);

            document.getElementById("hdnClientID").value = list[5];
            document.getElementById("txtClient").value = list[1];

            document.getElementById("hdnIsCreditBill").value = list[7] != "GENERAL" ? "Y" : "N";

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

    <script type="text/javascript">

        function CheckBilling1() {

            var alte = PaymentSaveValidation();

            if (alte == true) {

                var AmtRecieved = ToInternalFormat($('#<%= txtAmountRecieved.ClientID %>'))
                var AmtNet = ToInternalFormat($('#<%= txtNetValue.ClientID %>'));
                var IsCreditBill = document.getElementById('hdnIsCreditBill').value;
                var TowardsCopayment = ToInternalFormat($('#<%= hdnTowardsAmount.ClientID %>'));

                if (Number(AmtNet) > Number(AmtRecieved) && IsCreditBill == "N") {
                    var pBill = confirm("This BillAmount will be added to due.\n Do you want to continue");
                    if (pBill != true) {
                        document.getElementById('btnSave').style.display = 'block';
                        return false;
                    }
                }
                else if (Number(TowardsCopayment) > Number(AmtRecieved) && IsCreditBill == "Y") {
                    var pBill = confirm("This BillAmount will be added to due.\n Do you want to continue");
                    if (pBill != true) {
                        document.getElementById('btnSave').style.display = 'block';
                        return false;
                    }
                }
                document.getElementById('<%= btnSave.ClientID %>').disabled = false;
                $get('btnSave').disabled = true;
                javascript: __doPostBack('btnSave', '');
                return true;
            }
            else {

                return false;
            }

        }

        function CheckBilling11() {

            var AmtRecieved = ToInternalFormat($('#<%= txtAmountRecieved.ClientID %>'));
            var AmtNet = ToInternalFormat($('#<%= txtNetValue.ClientID %>'));

            if (Number(AmtNet) > Number(AmtRecieved)) {
                var pBill = confirm("This BillAmount will be added to due.\n Do you want to continue");
                if (pBill != true) {
                    document.getElementById('btnSave').style.display = 'block';
                    return false;
                }
            }
            document.getElementById('<%= btnSave.ClientID %>').disabled = false;
            return true;

        }      
 
    </script>

    <style type="text/css">
        .style1
        {
            height: 25px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function funcChkProcedures1(txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtNetValue, txtindDiscount,
                            hdnGross) {

            var Quantity = document.getElementById(txtQuantity);
            var UnitPrice = document.getElementById(txtUnitPrice);
            var Amount = document.getElementById(txtAmount);
            var hdnAmount = document.getElementById(hdnTotalAmount);
            var OldPrice = document.getElementById(hdnOldPrice);
            var OldQuantity = document.getElementById(hdnOldQuantity);
            var oldAmt = Number(ToInternalFormat($('#' + OldPrice.id))) * Number(ToInternalFormat($('#' + OldQuantity.id)));
            var Gross = document.getElementById(txtGross);
            var Discount = document.getElementById(txtDiscount);
            var RecievedAdvance = document.getElementById(txtRecievedAdvance);
            var GrandTotal = document.getElementById(txtNetValue);

            var OldPricetoDelete = chkIsnumber(ToInternalFormat($('#' + OldPrice.id)));
            var OldQuantitytoDelete = chkIsnumber(ToInternalFormat($('#' + OldQuantity.id)));

            var hdnGrossBillAmount = document.getElementById(hdnGross);
            var OldAmounttoDelete = format_number((Number(OldPricetoDelete) * Number(OldQuantitytoDelete)), 2);


            //            var IndividualDiscount = document.getElementById(txtindDiscount);
            //            if (IndividualDiscount == "" || IndividualDiscount == null) {
            //                IndividualDiscount = 0;
            //            }

            Quantity.value = chkIsnumber(ToInternalFormat($('#' + Quantity.id)));
            UnitPrice.value = chkIsnumber(ToInternalFormat($('#' + UnitPrice.id)));
            ToTargetFormat($('#' + Quantity.id));
            ToTargetFormat($('#' + UnitPrice.id));

            UnitPrice.value = format_number(Number(ToInternalFormat($('#' + UnitPrice.id))), 2);
            ToTargetFormat($('#' + UnitPrice.id));
            Amount.value = format_number((Number(ToInternalFormat($('#' + Quantity.id))) * Number(ToInternalFormat($('#' + UnitPrice.id)))), 2);
            ToTargetFormat($('#' + Amount.id));

            hdnAmount.value = ToInternalFormat($('#' + Amount.id));
            ToTargetFormat($('#' + hdnAmount.id));

            var newAmt = ToInternalFormat($('#' + Amount.id));
            Gross.value = format_number((Number(ToInternalFormat($('#' + Gross.id))) + Number(ToInternalFormat($('#' + Amount.id))) - Number(OldAmounttoDelete)), 2);

            //            hdnGross.value = Gross.value;
            ToTargetFormat($('#' + Gross.id));
            //   ToTargetFormat($('#' + hdnGross.id));

            ToTargetFormat($('#' + Discount.id));
            OldPrice.value = UnitPrice.value;
            OldQuantity.value = Quantity.value;

            ToTargetFormat($('#' + OldPrice.id));
            ToTargetFormat($('#' + OldQuantity.id));

            //            totalCalculate();
            //            ValidateDiscountReason();

            TotalMedial();
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



            if (Number(sNetValue) >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                ToTargetFormat($('#txtServiceCharge'));
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)
                ToTargetFormat($('#hdnServiceCharge'));
                document.getElementById('txtAmountRecieved').value = format_number(pAmt, 2);
                ToTargetFormat($('#txtAmountRecieved'));
                document.getElementById('hdnAmountReceived').value = format_number(pAmt, 2);
                ToTargetFormat($('#hdnAmountReceived'));

                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

                document.getElementById('txtNetValue').value = format_number(Number(pTotal), 2);
                ToTargetFormat($('#txtNetValue'));
                SetOtherCurrValues();
                return true;
            }
            else {
                alert('Amount provided is greater than net amount');
                return false;
            }
        }
        function SetOtherCurrValues() {
            var pnetAmt = 0;
            document.getElementById('txtNetValue').value = document.getElementById('txtNetValue').value == "" ? "0" : document.getElementById('txtNetValue').value;
            pnetAmt = ToInternalFormat($('#txtNetValue'));
            var ConValue = "OtherCurrencyDisplay1";


            if (ToInternalFormat($("#txtNetValue")).substring(0, 1) != "-") {
                SetPaybleOtherCurr(pnetAmt, ConValue, true);
            }
            else {
                SetPaybleOtherCurr(0, ConValue, true);
            }

        }

        function FuncChangeAmount(txtUnitPrice, hdnOldPrice,
                                     txtGross, txtDiscount,
                                     txtGrandTotal, hdnGross) {

            var UnitPrice = document.getElementById(txtUnitPrice);
            var OldPrice = document.getElementById(hdnOldPrice);
            var Gross = document.getElementById(txtGross);
            var Discount = document.getElementById(txtDiscount);
            var GrandTotal = document.getElementById(txtGrandTotal);
            var OldPricetoDelete = chkIsnumber(OldPrice.value);

            var hdnGrossBillAmount = document.getElementById(hdnGross);

            var OldAmounttoDelete = format_number(Number(OldPricetoDelete), 2);

            UnitPrice.value = chkIsnumber(UnitPrice.value);

            UnitPrice.value = format_number(Number(UnitPrice.value), 2);

            Gross.value = format_number((Number(Gross.value) + Number(UnitPrice.value) - Number(OldAmounttoDelete)), 2);
            hdnGrossBillAmount.value = Gross.value;

            OldPrice.value = UnitPrice.value;
            total();
        }
    
    </script>

</head>
<body oncontextmenu="return true;" onkeydown="SuppressBrowserRefresh();">
    <form id="form1" runat="server" defaultbutton="btnSave">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                        <asp:Label ID="lblError" runat="server" meta:resourcekey="lblErrorResource1"></asp:Label>
                                    </li>
                                </ul>
                                <table id="tblBilling" width="100%" border="0" runat="server" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="100%" class="dataheaderInvCtrl">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td align="left" nowspan="nowspan">
                                                        <asp:Label ID="lblClientNameText" runat="server" Text="Client Name : " Style="font-weight: bold;"> </asp:Label>
                                                        <asp:Label ID="lblClient" runat="server" Text=""> </asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="Label4" runat="server" Text="RateCard Name : " Style="font-weight: bold;"> </asp:Label>
                                                        <asp:Label ID="lblRateCard" runat="server" Text="" class="defaultfontcolor"> </asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label7" runat="server" Text="Change Client Name : " Style="font-weight: bold;"></asp:Label>
                                                        <asp:TextBox ID="txtClient" Width="150px" runat="server" CssClass="biltextb"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                            EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                            ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" OnClientItemSelected="ClientSelected">
                                                        </ajc:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnIsCreditBill" runat="server" Value="N" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text="Change RateCard Type : " Style="font-weight: bold;"></asp:Label>
                                                        <asp:DropDownList ID="ddlRateCard" runat="server">
                                                            <%--AutoPostBack="true" OnSelectedIndexChanged="ddlRateCard_SelectedIndexChanged"--%>
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hdnRateCardID" runat="server" Value="0" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnDifferenceCalculation" Text="Calculate Difference" runat="server"
                                                            OnClientClick="javascript:return showModalPopupForDifferenceAmount();" CssClass="dataheader1"
                                                            Style="display: none;" />
                                                        <asp:Button ID="btnChangeRateCard" Text="Change RateCard" runat="server" CssClass="dataheader1"
                                                            OnClick="btnChangeRateCard_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td class="style1">
                                                        <asp:Label ID="lblCopercent" runat="server" Text="Copayment Percentage" meta:resourcekey="lblCopercentResource1"></asp:Label>
                                                    </td>
                                                    <td class="style1">
                                                        <asp:TextBox ID="txtCoperent" runat="server" Text="0.00" Width="75px" Style="text-align: right;"
                                                             onkeypress="return ValidateOnlyNumeric(this);"  MaxLength="6" CssClass="biltextb" onblur="javascript:return doValidatePercent(this);"
                                                            onchange="javascript:return GetPreAmount();"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnCoPercentage" runat="server" Value="0" />
                                                    </td>
                                                    <td class="style1">
                                                        <asp:Label runat="server" ID="txtCopaymentLogin" Text="Co-Payment Logic" meta:resourcekey="txtCopaymentLoginResource1"></asp:Label>
                                                    </td>
                                                    <td align="Left" class="style1">
                                                        <asp:DropDownList runat="server" ID="ddlpaymentLogic" CssClass="bilddltb" onchange="javascript:return GetPreAmount();">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hdnPaymentlogin" runat="server" Value="-1" />
                                                    </td>
                                                    <td class="style1">
                                                        <asp:Label ID="lblClaimAmount" runat="server" Text="Co-Payment to be deducted from"
                                                            meta:resourcekey="lblClaimAmountResource1"></asp:Label>
                                                    </td>
                                                    <td class="style1">
                                                        <asp:DropDownList ID="ddlClaimAmount" runat="server" CssClass="bilddltb" onchange="javascript:return GetPreAmount();">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hdnClaimlogin" runat="server" Value="-1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="PreAuthAmount" Text="Pre-AuthAmount" runat="server" meta:resourcekey="PreAuthAmountResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtAuthamount" Style="text-align: right;" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                            MaxLength="15" Text="0.00" Width="75px" CssClass="biltextb" onchange="javascript:return GetPreAmount();"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnPerAuthAmount" runat="server" Value="0" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPreAuthNumber" runat="server" CssClass="biltextb" Text="Pre-Auth Approval Number"
                                                            meta:resourcekey="lblPreAuthNumberResource1"></asp:Label>
                                                    </td>
                                                    <td align="Left">
                                                        <asp:TextBox ID="txtPreAuthApprovalNumber" runat="server" CssClass="biltextb" Width="75px"
                                                            meta:resourcekey="txtPreAuthApprovalNumberResource3"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnClaim" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnCopayment" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnTowardsAmount" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnCoPaymentFinal" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divItems">
                                                <asp:GridView ID="gvBillingDetail" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvBillingDetail_RowDataBound"
                                                    meta:resourcekey="gvBillingDetailResource1" Width="100%">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <PagerStyle CssClass="dataheader1" />
                                                    <RowStyle HorizontalAlign="Left" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="BillNumber">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBillNumber" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BatchNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Description">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDescription" runat='server' Text='<%# Bind("FeeDescription") %>'
                                                                    meta:resourcekey="lblDescriptionResource1" Style="text-align: left;"></asp:Label>
                                                                <asp:Label ID="lblFeeID" runat='server' Text='<%# Bind("FeeID") %>' Visible="False"
                                                                    meta:resourcekey="lblFeeIDResource1"></asp:Label>
                                                                <asp:Label ID="lblFeeType" runat='server' Text='<%# Bind("FeeType") %>' Visible="False"
                                                                    meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                                                                <asp:Label ID="lblBillNo" runat="server" Text='<%# Bind("FinalBillID") %>' Style="display: none;"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="UnitPrice">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("Amount") %>' runat="server" />
                                                                <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                    Text='<%# Eval("Amount") %>'  onkeypress="return ValidateOnlyNumeric(this);"  Width="60px"
                                                                    meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Quantity">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("Quantity") %>' runat="server" />
                                                                <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                    Text='<%# Eval("Quantity") %>'  onkeypress="return ValidateOnlyNumeric(this);"  Width="60px"
                                                                    meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                                    Text='<%# NumberConvert(Eval("Quantity"),Eval("Amount")) %>' Width="60px" meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                                <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                <asp:Label ID="lblEditStats" runat="server" Visible="False" Text='<%# Eval("UseEdit") %>'
                                                                    meta:resourcekey="lblEditStatsResource1"></asp:Label>
                                                                <asp:Label ID="BillingDetailsID" runat="server" Visible="False" Text='<%# Eval("BillingDetailsID") %>'
                                                                    meta:resourcekey="BillingDetailsIDResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource1" />
                                                        <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='0'
                                                                     onkeypress="return ValidateOnlyNumeric(this);"  Width="60px" meta:resourcekey="txtDiscountResource1"
                                                                    ReadOnly="true"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="IsReimbursable" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="TemplateFieldResource8">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" meta:resourcekey="chkIsReImbursableItemResource1"
                                                                    onclick="javascript:return TotalMedial();" />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="dataheaderInvCtrl">
                                            <table width="100%">
                                                <tr>
                                                    <td valign="bottom">
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblCopaymentLogin" Text="" runat="server" Style="font-weight: bold;"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table cellpadding="3" cellspacing="0" border="1" width="60%">
                                                                                    <tr style="font-weight: bold;">
                                                                                        <td>
                                                                                            <asp:Label ID="Label5" runat="server" Text="Medical" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="Label3" runat="server" Text="NonMedical" />
                                                                                        </td>
                                                                                        <td nowrap="nowrap">
                                                                                            <asp:Label ID="lblPreAuthAmt" Text="Difference Pre-Auth & Medical" runat="server"></asp:Label>
                                                                                        </td>
                                                                                        <td nowrap="nowrap">
                                                                                            <asp:Label ID="Label11" Text="Towards-CoPay" runat="server"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="Label1" runat="server" Text="Actual CoPayment "></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="Label2" runat="server" Text="Claim Amount"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="Label12" runat="server" Text="Total"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr align="center">
                                                                                        <td>
                                                                                            <asp:Label ID="lblMedical" runat="server" Text="0.00" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblNonMedical" runat="server" Text="0.00" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblDifferenceAmount" runat="server" Text="0.00"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblTowardsCopayment" Text="0.00" runat="server"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblActcalCopayment" runat="server" Text="0.00"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblCalaminAmount" runat="server" Text="0.00"></asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblGrandCopaymentTotal" Text="0.00" runat="server"></asp:Label>
                                                                                            <asp:HiddenField ID="hdnVisitClientMappingID" runat="server" Value="0" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="22%">
                                                                    &nbsp;
                                                                </td>
                                                                <td width="31%" align="right">
                                                                    <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" meta:resourcekey="lblGrossResource1" />
                                                                </td>
                                                                <td width="20%" align="right" class="details_value">
                                                                    <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1" CssClass="textBoxRightAlign"
                                                                        Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnGross" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr valign="top">
                                                                <td align="right">
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtServiceCharge" Enabled="true" runat="server" Text="0.00" TabIndex="9"
                                                                        CssClass="textBoxRightAlign" meta:resourcekey="txtServiceChargeResource1" onchange="javascript:return TotalMedial();" />
                                                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Rs_RoundOffAmount" Text="Round Off Amount" runat="server" meta:resourcekey="Rs_RoundOffAmountResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtRoundOff" Enabled="true" runat="server" Text="0.00" TabIndex="9"
                                                                        CssClass="textBoxRightAlign" meta:resourcekey="txtRoundOffResource1" />
                                                                    <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right" nowrap="nowrap">
                                                                    <asp:Label ID="lblRecievedAmount" runat="server" Text="Previous Received Amount"
                                                                        class="defaultfontcolor" meta:resourcekey="lblRecievedAmountResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtPreviousRecievedAmount" runat="server" Text="0.00" TabIndex="7"
                                                                        CssClass="textBoxRightAlign" meta:resourcekey="txtRecievedAmountResource1" ReadOnly="true" />
                                                                    <asp:HiddenField ID="hdnPreviousRecievedAmount" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Net Value" class="defaultfontcolor"
                                                                        meta:resourcekey="lblGrandTotalResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtNetValue" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                                        CssClass="textBoxRightAlign" meta:resourcekey="txtGrandTotalResource1" />
                                                                    <asp:HiddenField ID="hdnNetValue" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" class="defaultfontcolor"
                                                                        meta:resourcekey="lblAmountRecievedResource1" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="10" Text="0" ReadOnly="True"
                                                                        CssClass="textBoxRightAlign" meta:resourcekey="txtAmountRecievedResource1" />
                                                                    <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label9" runat="server" Text="Amount to Refund" class="defaultfontcolor" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:CheckBox ID="ChkRefund" runat="server" onclick="javascript:return CheckValidation();" />
                                                                    <asp:TextBox ID="txtAmountRefunded" runat="server" TabIndex="10" Text="0" CssClass="textBoxRightAlign"
                                                                        meta:resourcekey="txtAmountRecievedResource1" Onchange="javascript:return AmountRefound();"
                                                                        Enabled="true" />
                                                                    <asp:HiddenField ID="hdnAmountRefunded" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trRefoundAmount" style="display: none;">
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Rs_ReasonforRefund" Text="Reason for Refund" runat="server" meta:resourcekey="Rs_ReasonforRefundResource1"></asp:Label>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtReasonForRefund" runat="server" TabIndex="8" MaxLength="150"
                                                                        CssClass="textBoxRightAlign" meta:resourcekey="txtReasonForRefundResource1" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trPayMode" style="display: none;">
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Rs_RefundMode" Text="Refund Mode" runat="server" meta:resourcekey="Rs_RefundModeResource1"></asp:Label>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:DropDownList ID="ddlPayMode" runat="server" onchange="javascript:showHide();"
                                                                        meta:resourcekey="ddlPayModeResource1">
                                                                        <asp:ListItem Value="0" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                                                                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource2">Cash</asp:ListItem>
                                                                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource3">Cheque</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr id="trbankName" style="display: none;">
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label Text="Bank Name" runat="server" ID="lblBankName" meta:resourcekey="lblBankNameResource1"></asp:Label>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtBankName" runat="server" MaxLength="150" CssClass="textBoxRightAlign"
                                                                        meta:resourcekey="txtBankNameResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr id="trCardNo" style="display: none;">
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="lblCardNo" runat="server" Text="Cheque Number" meta:resourcekey="lblCardNoResource1"></asp:Label>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:TextBox ID="txtCardNo" runat="server" MaxLength="150" CssClass="textBoxRightAlign"
                                                                        meta:resourcekey="txtCardNoResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="hdnOldFinalBillValue" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnNewFinalBillValue" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnEditVisitDetails" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <uc9:paymentType ID="PaymentType" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <table border="0">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnSave" Enabled="False" Text="Save" runat="server" TabIndex="11"
                                                            OnClick="btnSave_Click" CssClass="btn" OnClientClick=" return CheckBilling1();"
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnSaveResource1" />
                                                    </td>
                                                    <td align="left">
                                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" TabIndex="12"
                                                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlDifferenceCalc" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup">
                                                <table width="100%" cellpadding="5" cellspacing="5">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblDifferencText" runat="server" Text="Difference Between Rate Card Amount"></asp:Label>
                                                            <asp:Label ID="lblRateDifferenceAmount" runat="server" Text="0.00"></asp:Label>
                                                            <asp:HiddenField ID="hdnRateDifferenceAmount" Value="0" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <input type="button" id="btnAddToItem" class="btn" onclick="AddRow();" value="Add To Bill" />
                                                            <input type="button" id="btnItemCancel" class="btn" value="Cancel" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <asp:HiddenField ID="hdnRateDifferencePop" runat="server" />
                                            <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BehaviorID="mpeDifferenceBehavior"
                                                PopupControlID="pnlDifferenceCalc" CancelControlID="btnItemCancel" TargetControlID="hdnRateDifferencePop"
                                                DropShadow="false" Drag="false" BackgroundCssClass="modalBackground">
                                            </ajc:ModalPopupExtender>
                                        </td>
                                    </tr>
                                </table>
                                </div> </td> </tr> </table>
                                <input type="hidden" id="hdnCorporateDiscount" runat="server" />
                                <asp:TextBox ID="txtReceivedAdvance" Style="display: none;" runat="server" meta:resourcekey="txtReceivedAdvanceResource1"></asp:TextBox>
                                <asp:TextBox ID="txtPreviousAmountPaid" runat="server" Text="0.00" Style="display: none;"
                                    meta:resourcekey="txtPreviousAmountPaidResource1" />
                                <asp:TextBox ID="txtPreviousDue" runat="server" Text="0.00" Style="display: none;"
                                    meta:resourcekey="txtPreviousDueResource1" />
                                <asp:TextBox ID="txtRecievedAdvance" runat="server" Text="0.00" Style="display: none;"
                                    meta:resourcekey="txtRecievedAdvanceResource1" />
                                <asp:TextBox ID="txtRefundAmount" runat="server" Text="0.00" Style="display: none;"
                                    meta:resourcekey="txtRefundAmountResource1" />
                                <asp:HiddenField ID="hdnDiscountArray" runat="server" />
                                <asp:HiddenField ID="hdnDefaultRoundoff" runat="server" />
                                <asp:HiddenField ID="hdnRoundOffType" runat="server" />
                                <asp:HiddenField ID="hdntotalNonMedical" runat="server" />
                                <asp:HiddenField ID="hdntotalMedial" runat="server" />
                                 <asp:HiddenField ID="hdnoldRoundOff" runat="server" Value ="0"/>                                
                                <uc5:Footer ID="Footer1" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

                    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

                    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>
    </form>

    <script type="text/javascript">

        function showHide() {

            if (document.getElementById('ddlPayMode').value == "1") {
                document.getElementById('trbankName').style.display = "none";
                document.getElementById('trCardNo').style.display = "none";
            }
            if (document.getElementById('ddlPayMode').value == "2") {
                document.getElementById('trbankName').style.display = "block";
                document.getElementById('trCardNo').style.display = "block";

            }
            if (document.getElementById('ddlPayMode').value == "0") {
                document.getElementById('trbankName').style.display = "none";
                document.getElementById('trCardNo').style.display = "none";
            }
        }

        function GetPreAmount() {
            var Ratecard = document.getElementById('ddlRateCard').value;
            var Copercent = document.getElementById('txtCoperent').value;
            var Paymentlogic = document.getElementById('ddlpaymentLogic').value;
            var Claminlogic = document.getElementById('ddlClaimAmount').value;
            var PreAuthAmount = ToInternalFormat($('#txtAuthamount'));

            document.getElementById('hdnRateCardID').value = Ratecard != "" ? Ratecard : 0;
            document.getElementById('hdnCoPercentage').value = Copercent != "" ? Copercent : 0;
            document.getElementById('hdnPaymentlogin').value = Paymentlogic != "" ? Paymentlogic : -1;
            document.getElementById('hdnClaimlogin').value = Claminlogic != "" ? Claminlogic : -1;
            document.getElementById('hdnPerAuthAmount').value = PreAuthAmount != "" ? PreAuthAmount : 0;
            TotalMedial();

        }

        function TotalMedial() {

            var totalMedial = 0;
            var totalNonMedical = 0;
            var MainCheckBox;
            $("#divItems table tr").each(function() {
                var Medtr = $(this).closest("tr");
                if ($(Medtr).find("input:text[id$=txtAmount]").val() != undefined) {
                    var chk = $(Medtr).find("input:checkbox[id$=chkIsReImbursableItem]").attr('checked') ? true : false;
                    var Amount = 0;
                    Amount = $(Medtr).find("input:text[id$=txtAmount]") ? ToInternalFormat($(Medtr).find("input:text[id$=txtAmount]")) : 0;

                    if (chk == true) {
                        totalMedial = parseFloat(totalMedial) + parseFloat(Amount);
                    }
                    else {
                        totalNonMedical = parseFloat(totalNonMedical) + parseFloat(Amount);
                    }
                }

            });


            document.getElementById("hdntotalMedial").value = totalMedial;
            document.getElementById("hdntotalNonMedical").value = totalNonMedical;

            ToTargetFormat($('#hdntotalMedial'));
            ToTargetFormat($('#hdntotalNonMedical'));

            var RateCardDifference = ToInternalFormat($('#hdnRateDifferenceAmount'));
            document.getElementById("txtGross").value = (totalMedial + totalNonMedical +
            parseFloat(ToInternalFormat($('#hdnRateDifferenceAmount')))).toFixed(2);
            document.getElementById("hdnGross").value = document.getElementById("txtGross").value;
            ToTargetFormat($('#txtGross'));
            ToTargetFormat($('#hdnGross'));

            document.getElementById("hdnServiceCharge").value = ToInternalFormat($('#txtServiceCharge'));
            ToTargetFormat($('#hdnServiceCharge'));

            document.getElementById("txtNetValue").value = ((parseFloat(ToInternalFormat($('#hdnGross'))) +
            parseFloat(ToInternalFormat($('#hdnServiceCharge')))) - parseFloat(ToInternalFormat($('#hdnPreviousRecievedAmount')))).toFixed(2);

            document.getElementById("hdnNetValue").value = document.getElementById("txtNetValue").value;

            ToTargetFormat($('#hdnNetValue'));
            ToTargetFormat($('#txtNetValue'));
            ToTargetFormat($('#txtServiceCharge'));

            document.getElementById("txtPreviousRecievedAmount").value = ToInternalFormat($('#hdnPreviousRecievedAmount'));
            ToTargetFormat($('#txtPreviousRecievedAmount'));

            ShowCollectableAmount();
            SetOtherCurrValues();
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
            ToTargetFormat($('#txtServiceCharge'));
            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);
            ToTargetFormat($('#hdnServiceCharge'));

            document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);
            ToTargetFormat($('#txtAmountRecieved'));
            document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);
            ToTargetFormat($('#hdnAmountReceived'));

            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('txtNetValue').value = format_number(Number(pTotal), 2);
            ToTargetFormat($('#txtNetValue'));
            document.getElementById("hdnNetValue").value = format_number(Number(pTotal), 2);
            ToTargetFormat($('#hdnNetValue'));
            SetOtherCurrValues();
        }

        function Cal_Copayment() {
            if (document.getElementById('hdnIsCreditBill').value == "Y") {
                var totalNonMedical = ToInternalFormat($('#hdntotalNonMedical'));
                var totalMedial = ToInternalFormat($('#hdntotalMedial'));
                var CoPaymentlogic = document.getElementById('hdnPaymentlogin').value;
                var Copayment_Percentage = ToInternalFormat($('#hdnCoPercentage'));
                var PrAutAmount = ToInternalFormat($('#hdnPerAuthAmount'));
                var Claimlogin = document.getElementById('hdnClaimlogin').value;
                var _claimAmount = 0;


                if (Number(PrAutAmount) > 0 || Number(Copayment_Percentage) > 0) {

                    if (CoPaymentlogic == 0) {
                        if (Number(PrAutAmount) < Number(totalMedial)) {
                            _claimAmount = (Number(PrAutAmount) * Number(Copayment_Percentage)) / 100;
                        }
                        else {
                            _claimAmount = (Number(totalMedial) * Number(Copayment_Percentage)) / 100;
                        }
                    }
                    else if (CoPaymentlogic == 1) {
                        _claimAmount = (Number(totalMedial) * Number(Copayment_Percentage)) / 100;
                    }
                    else if (CoPaymentlogic == 2) {
                        _claimAmount = (Number(PrAutAmount) * Number(Copayment_Percentage)) / 100;
                    }


                }

                var NetValue = ToInternalFormat($('#txtNetValue'));
                document.getElementById("lblDifferenceAmount").innerHTML = (Number(NetValue) - Number(_claimAmount)).toFixed(2);

                document.getElementById("lblClaminAmount").innerHTML = Number(_claimAmount).toFixed(2);
                document.getElementById('hdnClaim').value = Number(_claimAmount).toFixed(2);
                document.getElementById('hdnTowardsAmount').value = (Number(NetValue) - Number(_claimAmount)).toFixed(2);

                ToTargetFormat($('#lblActualCopaymenttxt'));
                ToTargetFormat($('#lblClaminAmount'));
                ToTargetFormat($('#lblDifferenceAmount'));
                ToTargetFormat($('#hdnCopayment'));
                ToTargetFormat($('#hdnClaim'));
                ToTargetFormat($('#hdnTowardsAmount'));

            }

        }



        TotalMedial();

        var pVID = '<%= Request.QueryString["vid"] %>';

        function showModalPopupForDifferenceAmount() {
            GetBillingDetailsByRateTypeForOP();
            document.getElementById('<%= pnlDifferenceCalc.ClientID %>').style.display = "none";
            var modalPopupBehavior = $find('mpeDifferenceBehavior');
            modalPopupBehavior.show();
            return false;
        }
        function GetBillingDetailsByRateTypeForOP() {
            var arrGotValue = new Array();
            var RateId = document.getElementById('<%= hdnRateCardID.ClientID %>').value;
            var RateCardAmount = ToInternalFormat($('#' + '<%= hdnGross.ClientID %>'));
            var ToRateID = document.getElementById('<%= ddlRateCard.ClientID %>').value;
            var liOrgID = "<%=OrgID%>";

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../OPIPBilling.asmx/GetBillingDetailsByRateTypeForOP",
                data: JSON.stringify({ VisitID: pVID, BilledRateID: RateId, BilledRateCardAmount: RateCardAmount, SelectedRateID: ToRateID, OrgID: liOrgID, Type: 'OP' }),
                dataType: "json",
                success: function(data) {
                    if (data != null) {
                        document.getElementById('lblRateDifferenceAmount').innerHTML = Number(data.d).toFixed(2);
                        ToTargetFormat($('#lblRateDifferenceAmount'));
                        if (Number(data.d) <= 0) {
                            $('#btnAddToItem').attr('disabled', true);
                        }
                        else {
                            $('#btnAddToItem').attr('disabled', false);
                        }
                    }
                },
                error: function(result) {
                    $('#btnAddToItem').attr('disabled', true);
                    alert("Error");
                }
            });
        }
        function AddRow() {
            var countlength = document.getElementById('gvBillingDetail').rows.length;
            var Headrow = document.getElementById('gvBillingDetail').insertRow(countlength);
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);
            var cell7 = Headrow.insertCell(6);
            cell5.className = "right";
            cell6.className = "right";
            cell7.className = "right";
            cell1.innerHTML = "0";
            cell2.innerHTML = "Difference Amount";
            cell3.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='" + document.getElementById('lblRateDifferenceAmount').innerHTML + "' />";
            cell4.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='1'/>";
            cell5.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='" + document.getElementById('lblRateDifferenceAmount').innerHTML + "' />";
            cell6.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='0'/>";
            cell7.innerHTML = "<input type='Checkbox' name='chkIsReImbursableItem' id='chkIsReImbursableItem' readonly='true'/>";

            document.getElementById('hdnRateDifferenceAmount').value = ToInternalFormat($('#lblRateDifferenceAmount'));
            ToTargetFormat($('#hdnRateDifferenceAmount'));
            var modalPopupBehavior = $find('mpeDifferenceBehavior');
            modalPopupBehavior.hide();
            TotalMedial();
            $('#ddlRateCard').attr('disabled', true);
            $('#btnDifferenceCalculation').attr('disabled', true);
            return false;

        }

        function ShowCollectableAmount() {
            //    ShowCollectableAmount(var totalPaid , var totalNonMedical, var totalMedical, var Pre_AuthAmount, var Co_PaymentPercentage, var Co_PaymentLogic )
            /*
            * Step1: Calculate amount to be paid towards non-medical items
            * Step2: Calculate co-payment amount to be paid
            * Step3: Calculate difference between Pre-Auth and actual NetAmount
            * Step4: Calculate total (Step1 + Step2 + Step3)
            */
            var totalPaid = Number(ToInternalFormat($('#hdnPreviousRecievedAmount'))) + Number(ToInternalFormat($('#txtAmountRecieved')));
            var totalMedical = ToInternalFormat($('#hdntotalMedial'));
            var totalNonMedical = ToInternalFormat($('#hdntotalNonMedical'));
            //   var DiscountAmt = ToInternalFormat($('#txtDiscount'));
            var DiscountAmt = 0;
            var Co_PaymentLogic = document.getElementById('hdnPaymentlogin').value;
            var Co_PaymentPercentage = ToInternalFormat($('#hdnCoPercentage'));
            var Pre_AuthAmount = ToInternalFormat($('#hdnPerAuthAmount'));
            var Claim_DeductionLogic = document.getElementById('hdnClaimlogin').value;

            var _totNonMedicalAmt = 0;
            var _balAfterNonMedicalAmt = 0;
            var _balAfterNonMedicalCoPayment = 0;
            var _actualCoPayment = 0;
            var _totCoPaymentToPay = 0;
            var _diffInBillledVsPreAuth = 0;
            var _grandTotal = 0;
            var _grossBill = 0;
            var _claimAmount = 0;
            var _amountReceivable = 0;
            var ToWardsToNonMedicalPaid;
                     
            _grossBill = Number(totalMedical) + Number(totalNonMedical);

            /****************Step1: Calculate amount to be paid towards non-medical items, Starts***************************************************/
            if (Number(totalPaid) > Number(totalNonMedical)) {
                _totNonMedicalAmt = 0;
            }
            else {
                _totNonMedicalAmt = (Number(totalNonMedical) - Number(totalPaid));
            }
            /*******************Step1: Calculate amount to be paid towards non-medical items, Ends***************************************************/

            /*******************Step2: Calculate co-payment amount to be paid **************************************************/
            if ((Number(totalPaid) - Number(totalNonMedical)) > 0) {
                _balAfterNonMedicalAmt = Number(totalPaid) - Number(totalNonMedical);
                ToWardsToNonMedicalPaid = Number(totalPaid) - Number(totalNonMedical);
            }
            else {
                _balAfterNonMedicalAmt = 0;
            }

            if (Number(Co_PaymentLogic) == 0) {
                if (Number(totalMedical) < Number(Pre_AuthAmount)) {
                    _actualCoPayment = Number(totalMedical) * (Number(Co_PaymentPercentage) / 100);
                }
                else {
                    _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
                }
            }
            else if (Number(Co_PaymentLogic) == 1) {
                _actualCoPayment = Number(totalMedical) * (Number(Co_PaymentPercentage) / 100);
            }
            else if (Number(Co_PaymentLogic) == 2) {
                _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
            }



            if (Number(_balAfterNonMedicalAmt) > Number(_actualCoPayment)) {
                _totCoPaymentToPay = 0;
            }
            else {
                _totCoPaymentToPay = Number(_actualCoPayment) - Number(_balAfterNonMedicalAmt);
            }


            /*******************Step2: Calculate co-payment amount to be paid Ends **************************************************/
            if ((Number(_balAfterNonMedicalAmt) - Number(_actualCoPayment)) > 0) {
                _balAfterNonMedicalCoPayment = Number(_balAfterNonMedicalAmt) - Number(_actualCoPayment);
            }
            else {
                _balAfterNonMedicalCoPayment = 0;
            }

            /*******************Step3: Calculate difference between Pre-Auth and actual NetAmount, Starts ***************************/

            // Billed Amount
            if (Number(Claim_DeductionLogic) == 1) {


                _claimAmount = Number(totalMedical) - Number(_actualCoPayment);

                if (Number(_claimAmount) > Number(Pre_AuthAmount)) {
                    _claimAmount = Number(Pre_AuthAmount);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);

                if (Number(totalPaid) - Number(_amountReceivable) > 0) {
                    _diffInBillledVsPreAuth = 0;

                    ToWardsToPreAuthAndMedicalPaid = Number(totalPaid) - Number(_amountReceivable);

                    document.getElementById('lblDifferenceAmount').innerHTML = _diffInBillledVsPreAuth.toFixed(2);
                    ToTargetFormat($('#lblDifferenceAmount'));
                    document.getElementById('txtAmountRefunded').value = (Number(totalPaid) - Number(_amountReceivable) + Number(DiscountAmt)).toFixed(2);
                    ToTargetFormat($('#txtAmountRefunded'));
                    document.getElementById('hdnAmountRefunded').value = Number(ToInternalFormat($("#txtAmountRefunded")));
                    ToTargetFormat($('#hdnAmountRefunded'));
                }
                else {
                    _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                    document.getElementById('lblDifferenceAmount').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                    ToTargetFormat($('#lblDifferenceAmount'));
                    document.getElementById('txtAmountRefunded').value = "0.00";
                    document.getElementById('txtAmountRefunded').value = parseFloat(Number(ToInternalFormat($("#txtAmountRefunded"))) + Number(DiscountAmt)).toFixed(2);
                    ToTargetFormat($('#txtAmountRefunded'));
                    document.getElementById('hdnAmountRefunded').Value = ToInternalFormat($("#txtAmountRefunded"));
                    ToTargetFormat($('#hdnAmountRefunded'));

                    ToWardsToPreAuthAndMedicalPaid = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                }

                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);
            }

            //Pre Auth Amount
            else if (Number(Claim_DeductionLogic) == 2) {
                _claimAmount = Number(Pre_AuthAmount) - Number(_actualCoPayment);

                if (Number(_claimAmount) > Number(totalMedical)) {
                    _claimAmount = Number(totalMedical);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);

                if (Number(totalPaid) - Number(_amountReceivable) > 0) {
                    _diffInBillledVsPreAuth = 0;
                    document.getElementById('lblDifferenceAmount').innerHTML = _diffInBillledVsPreAuth.toFixed(2);
                    ToTargetFormat($('#lblDifferenceAmount'));
                    document.getElementById('txtAmountRefunded').value = (Number(totalPaid) - Number(_amountReceivable) + Number(DiscountAmt)).toFixed(2);
                    ToTargetFormat($('#txtAmountRefunded'));
                    document.getElementById('hdnAmountRefunded').value = Number(ToInternalFormat($("#txtAmountRefunded")));
                    ToTargetFormat($('#hdnAmountRefunded'));
                    ToWardsToPreAuthAndMedicalPaid = Number(totalPaid) - Number(_amountReceivable);


                }
                else {
                    _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                    document.getElementById('lblDifferenceAmount').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                    ToTargetFormat($('#lblDifferenceAmount'));
                    document.getElementById('txtAmountRefunded').value = "0.00";
                    document.getElementById('txtAmountRefunded').value = parseFloat(Number(ToInternalFormat($("#txtAmountRefunded"))) + Number(DiscountAmt)).toFixed(2);
                    ToTargetFormat($('#txtAmountRefunded'));
                    document.getElementById('hdnAmountRefunded').Value = ToInternalFormat($("#txtAmountRefunded"));
                    ToTargetFormat($('#hdnAmountRefunded'));

                    ToWardsToPreAuthAndMedicalPaid = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                }

                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);
            }

            //Lesser of Billed And Pre-Auth

            else if (Number(Claim_DeductionLogic) == 3 || Number(Claim_DeductionLogic)==-1) {
                if (Pre_AuthAmount < totalMedical) {
                    _claimAmount = Number(Pre_AuthAmount) - Number(_actualCoPayment);
                }
                else {
                    _claimAmount = Number(totalMedical) - Number(_actualCoPayment);
                }

                if (Number(_claimAmount) > Number(totalMedical)) {
                    _claimAmount = Number(totalMedical);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);

                if (Number(totalPaid) - Number(_amountReceivable) > 0) {
                    _diffInBillledVsPreAuth = 0;
                    document.getElementById('lblDifferenceAmount').innerHTML = _diffInBillledVsPreAuth.toFixed(2);
                    ToTargetFormat($('#lblDifferenceAmount'));
                    document.getElementById('txtAmountRefunded').value = (Number(totalPaid) - Number(_amountReceivable) + Number(DiscountAmt)).toFixed(2);
                    ToTargetFormat($('#txtAmountRefunded'));
                    document.getElementById('hdnAmountRefunded').value = Number(ToInternalFormat($("#txtAmountRefunded")));
                    ToTargetFormat($('#hdnAmountRefunded'));

                }
                else {
                    _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                    document.getElementById('lblDifferenceAmount').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                    ToTargetFormat($('#lblDifferenceAmount'));
                    document.getElementById('txtAmountRefunded').value = "0.00";
                    document.getElementById('txtAmountRefunded').value = parseFloat(Number(ToInternalFormat($("#txtAmountRefunded"))) + Number(DiscountAmt)).toFixed(2);
                    ToTargetFormat($('#txtAmountRefunded'));
                    document.getElementById('hdnAmountRefunded').Value = ToInternalFormat($("#txtAmountRefunded"));
                    ToTargetFormat($('#hdnAmountRefunded'));

                }
                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);

            }
            

            document.getElementById('lblNonMedical').innerHTML = Number(totalNonMedical).toFixed(2);
            document.getElementById('lblMedical').innerHTML = Number(totalMedical).toFixed(2);
            document.getElementById('lblTowardsCopayment').innerHTML = _totCoPaymentToPay.toFixed(2);
            document.getElementById('lblGrandCopaymentTotal').innerHTML = _grandTotal.toFixed(2);
            document.getElementById('hdnTowardsAmount').value = _grandTotal.toFixed(2);
            document.getElementById('hdnClaim').value = _claimAmount.toFixed(2);

            document.getElementById('lblActcalCopayment').innerHTML =  Number(_actualCoPayment).toFixed(2);
            document.getElementById('lblCalaminAmount').innerHTML =  Number(_claimAmount).toFixed(2);

            ToTargetFormat($('#lblMedical'));
            ToTargetFormat($('#lblNonMedical'));
            ToTargetFormat($('#hdnClaim'));
            ToTargetFormat($('#lblTowardsCopayment'));
            ToTargetFormat($('#lblGrandCopaymentTotal'));
            ToTargetFormat($('#hdnTowardsAmount'));

             var defRoundOff = ToInternalFormat($('#<%= hdnDefaultRoundoff.ClientID %>'));        
             var RoundOffType = document.getElementById('<%= hdnRoundOffType.ClientID %>').value;
             document.getElementById('<%= txtRoundOff.ClientID %>').value = getCustomRoundoff(_grandTotal, Number(defRoundOff), RoundOffType);
             ToTargetFormat($('#<%= txtRoundOff.ClientID %>'));
             document.getElementById('<%= hdnRoundOff.ClientID %>').value = ToInternalFormat($('#<%= txtRoundOff.ClientID %>'));
             ToTargetFormat($('#<%= hdnRoundOff.ClientID %>'));
            _grandTotal = format_number((Number(ToInternalFormat($('#<%= hdnRoundOff.ClientID %>'))) + Number(_grandTotal)), 2);                   
            document.getElementById('txtNetValue').value = Number(_grandTotal).toFixed(2);
            document.getElementById('hdnNetValue').value = Number(_grandTotal).toFixed(2);
                
            ToTargetFormat($('#txtNetValue'));
            ToTargetFormat($('#hdnNetValue'));

        }

        function fn_bindRateType(pList) {
            document.getElementById('<%= ddlRateCard.ClientID %>').options.length = 0;
            var GetCombo = document.getElementById('<%= ddlRateCard.ClientID %>');
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
                    document.getElementById('<%= ddlRateCard.ClientID %>').value = isSelectVal;
                }


            }
        }

        function GetBillingDetailsByRateTypeForOP() {
            var arrGotValue = new Array();
            var RateId = document.getElementById('<%= hdnRateCardID.ClientID %>').value;
            var RateCardAmount = ToInternalFormat($('#' + '<%= hdnGross.ClientID %>'));
            var ToRateID = document.getElementById('<%= ddlRateCard.ClientID %>').value;
            var liOrgID = "<%=OrgID%>";

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../OPIPBilling.asmx/GetBillingDetailsByRateTypeForOP",
                data: JSON.stringify({ VisitID: pVID, BilledRateID: RateId, BilledRateCardAmount: RateCardAmount, SelectedRateID: ToRateID, OrgID: liOrgID, Type: 'OP' }),
                dataType: "json",
                success: function(data) {
                    if (data != null) {
                        document.getElementById('lblRateDifferenceAmount').innerHTML = Number(data.d).toFixed(2);
                        ToTargetFormat($('#lblRateDifferenceAmount'));
                        if (Number(data.d) <= 0) {
                            $('#btnAddToItem').attr('disabled', true);
                        }
                        else {
                            $('#btnAddToItem').attr('disabled', false);
                        }
                    }
                },
                error: function(result) {
                    $('#btnAddToItem').attr('disabled', true);
                    alert("Error");
                }
            });
        }


        function AmountRefound() {
            var AmountRevd = ToInternalFormat($('#hdnPreviousRecievedAmount')) + ToInternalFormat($('#txtAmountRecieved'));
            var AmountRefound = ToInternalFormat($('#txtAmountRefunded'));

            if (AmountRefound >= AmountRevd) {
                document.getElementById("txtAmountRefunded").value = "0.00";
                ToTargetFormat($('#txtAmountRefunded'));
            }
            else {
                document.getElementById("hdnAmountRefunded").value = AmountRefound;
                ToTargetFormat($('#hdnAmountRefunded'));
            }

            return false;

        }


        function CheckValidation() {

            if (document.getElementById('ChkRefund').checked == false) {
                document.getElementById('trRefoundAmount').style.display = "none";
                document.getElementById('trPayMode').style.display = "none";
            }
            else {
                document.getElementById('trRefoundAmount').style.display = "block";
                document.getElementById('trPayMode').style.display = "block";

            }

        }

        function doValidatePercent(obj) {
            if (Number(obj.value) > 100) {
                alert("Copayment percentage must between 0 to 100");
                obj.value = "0.00";
                obj.select();
                return false;
            } else {
                return true;
            }
        }


        function getCustomRoundoff(roundoffVal, DefaultRound, RoundOffType) {
            var result = 0;
            if (RoundOffType.toLowerCase() == "lower value") {
                result = (Math.floor(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
            }
            else if (RoundOffType.toLowerCase() == "upper value") {
                result = (Math.ceil(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
            }
            else if (RoundOffType.toLowerCase() == "none") {
                result = format_number_withSignNone(roundoffVal, 2);
            }
            else {
                result = roundoffVal;
            }
            result = Number(result) - Number(roundoffVal);
            result = format_number_withSign(result, 2);
            return result;
        }
    </script>

</body>
</html>
