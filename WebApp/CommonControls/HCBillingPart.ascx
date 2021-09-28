<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HCBillingPart.ascx.cs"
    Inherits="CommonControls_HCBillingPart" %>
<%@ Register Src="OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay" TagPrefix="OtherCurrency" %>
<%@ Register Src="PaymentTypeDetails.ascx" TagName="paymentType" TagPrefix="Payment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/EMR/His.ascx" TagName="History" TagPrefix="His" %>

<script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

<script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

<%--<script src="../Scripts/CommonBilling.js" type="text/javascript"></script>--%>
<!-- Language converter -->

<script type="text/javascript">

    
    function fnCalTtlDisount() {
        //debugger;
        var total = 0.0;
        var checkBoxSelector = '#<%=gvMultiDisTypes.ClientID%> input[id*="CheckSelect"]:checkbox';
        var totalCkboxes = $(checkBoxSelector),
        checkedCheckboxes = totalCkboxes.filter(":checked")
        document.getElementById('billPart_hdnDisPercentage').value = '';
        document.getElementById('billPart_hdnDisReason').value = '';
        if (checkedCheckboxes.length == 0) {
            document.getElementById('billPart_hdnDiscountPercentage').value = total.toFixed(2);
            document.getElementById('billPart_lblTtlDiscountPercentage').innerText = '';
            SetNetValue('ADD');
            var modal = $find("billPart_MPEMultDisc");
            modal.hide();
            //alert("check at least one");
            return true;
        }
        else {
            var gridView1Control = document.getElementById('<%= gvMultiDisTypes.ClientID %>');
            $('input:checkbox[id$=CheckSelect]:checked', gridView1Control).each(function(item, index) {

                var tr = $(this).closest("tr");
                var DisID = $(tr).find("input:hidden[id$=hdDiscountID]");
                var RsnName = $(tr).find("span[id*=lblDiscountName]");

                var Discount = $(this).next('input:hidden[id$=hdDiscount]').val();
                var DisReason = $(this).next('input:hidden[id$=hdDiscountName]').val();
                total += parseFloat(Discount);
                //To save DiscountId and DiscountReason in PatientDiscount Table Store the vales in hidden field with comma seperator 
                document.getElementById('billPart_hdnDisPercentage').value = document.getElementById('billPart_hdnDisPercentage').value + ',' + DisID.val();
                document.getElementById('billPart_hdnDisReason').value = document.getElementById('billPart_hdnDisReason').value + ',' + RsnName.text();
                //alert(total);
            });
            if (total > 100) {
                alert("Discount Amount Greater than 100%.");
                return false;
            }
            else {
                var DiscountAmount = 0;
                var AvailableDiscountAmt = 0;
                var DiscountLimitAmt = 0;
                DiscountAmount = Number((document.getElementById('billPart_txtGross').value) * total / 100).toFixed(2);
                AvailableDiscountAmt = Number(Number(document.getElementById('hdnAvailableDiscountAmt').value)).toFixed(2);
                DiscountLimitAmt = document.getElementById('hdnDiscountLimitAmt').value;
                if (Number(DiscountAmount) <= Number(AvailableDiscountAmt)) {
                    document.getElementById('billPart_hdnDiscountPercentage').value = total.toFixed(2);
                    document.getElementById('billPart_lblTtlDiscountPercentage').innerText = total + "%";
                    //$find("billPart_lblTtlDiscountPercentage").text(total);
                    SetNetValue('ADD');
                    //$(checkBoxSelector).attr('checked', false);
                    var modal = $find("billPart_MPEMultDisc");
                    modal.hide();
                }
                else if (DiscountLimitAmt > 0) {
                    if (document.getElementById('hdnDiscountLimitType').value != "EMPL") {
                        alert("Referring Doctor discount limit is exceeded for this period, will not be able to provide further discounts.");
                        //("Insufficient Discount Limit");
                        return false;
                    }
                    else {
                        alert("Employee discount limit is exceeded for this period, will not be able to provide further discounts.");
                        return false;
                    }

                }
                else {
                    document.getElementById('billPart_hdnDiscountPercentage').value = total.toFixed(2);
                    document.getElementById('billPart_lblTtlDiscountPercentage').innerText = total + "%";
                    //$find("billPart_lblTtlDiscountPercentage").text(total);
                    SetNetValue('ADD');
                    //$(checkBoxSelector).attr('checked', false);
                    var modal = $find("billPart_MPEMultDisc");
                    modal.hide();
                }
            }
        }
        return true;
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
    function ClearPopUp1() {

        var otable = document.getElementById('tblGroupHistory');
        while (otable.rows.length > 1) {
            otable.deleteRow(otable.rows.length - 1);
        }
        var modal = $find('billPart_ModalPopupShow');
        modal.hide();
        //        document.getElementById('billPart_btnDummy').click();
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

    function TestNamePopulated(sender, e) {
        $find('billPart_AutoCompleteExtender3')._onMethodComplete = function(result, context) {
            $find('billPart_AutoCompleteExtender3')._update(context, result, /* cacheResults */false);
            if (result == "") {
                alert('Please select the investigation from the list');
                document.getElementById('billPart_txtTestName').value = '';
            }
        }
    } 
</script>

<table class="w-100p">
    <tr id="trOrderPart" runat="server" style="display: table-row;">
        <td class="v-top">
            <div id="divOrder" class="dataheader3 bg-row">
                <table class="w-100p">
                    <tr style="display: none">
                        <td colspan="5" class="v-top">
                            <asp:RadioButtonList ID="rblFeeTypes" runat="server" RepeatDirection="Horizontal"
                                RepeatColumns="8" onClick="Javascript:chkPros();resetpreviousradiodetails();"
                                meta:resourcekey="rblFeeTypesResource1">
                            </asp:RadioButtonList>
                            <asp:HiddenField ID="hdnFeeType1" runat="server" Value="COM" />
                        </td>
                    </tr>
                    <tr id="trSTATOutSource" runat="server" style="display: table-row;">
                        <td colspan="2">
                            <asp:TextBox ID="txtStatColor" Style="background-color: #EEB4B4;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                            <asp:Label ID="lblStatTestColor" Text="STAT Test" runat="server"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtOutsourceTest" Style="background-color: #D0FA58;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                            <asp:Label ID="lblOutSourceTestColor" runat="server" Text="Out Source"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtinvcolor" Style="background-color: #000000;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                            <asp:Label ID="lblinvcolor" Text="Investigation" runat="server"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtgrpcolor" Style="background-color: #C71585;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                            <asp:Label ID="lblgrpcolor" Text="Group" runat="server"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtpkgcolor" Style="background-color: #6699FF;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                            <asp:Label ID="lblpkgcolor" Text="Package" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                        </td>
                    </tr>
                    <tr>
                        <td class="w-8p">
                            <asp:Label ID="lblTestName" Text="Test Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                        </td>
                        <td class="w-50p">
                            <table class="w-100p">
                                <tr>
                                    <td class="w-75p">
                                        <asp:TextBox CssClass="AutoCompletesearchBox11" ID="txtTestName" onfocus="chkPros();"
                                            runat="server" onchange="boxExpand(this);" onkeydown="return (event.keyCode!=13);"
                                            onkeypress="javascript:clearfn();keypress();" Width="350px" Style="margin-top: 0px"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="BillingItemSelected"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                                            FirstRowSelected="false" OnClientItemOver="TempBillingItemSelected" ServicePath="~/OPIPBilling.asmx"
                                            UseContextKey="True" DelimiterCharacters="" OnClientShown="InvPopulated" Enabled="True"
                                            OnClientPopulated="onTestListPopulated">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:TextBox ID="txtVariableRate" runat="server" Style="display: none;" Width="40px"></asp:TextBox>
                                        <input type="button" id="btnAdd" value="ADD" width="150px" runat="server" onclick="AddItems();"
                                            class="btn" tabindex="-1" />
                                    </td>
                                    <td class="w-25p">
                                        <asp:Label ID="lblInvType" runat="server" ForeColor="Red" Font-Bold="True" meta:resourcekey="lblInvTypeResource1"></asp:Label>
                                        &nbsp;<asp:Label ID="alert" runat="server" ForeColor="Blue" meta:resourcekey="alertResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td id="tdHistory" runat="server" class="a-center" style="display: none;">
                            <asp:LinkButton runat="server" ToolTip="Click Here to Capture History" ID="LnkHistory"
                                OnClientClick="onShowHistoryNameList()" Font-Underline="true" ForeColor="Red"
                                Font-Bold="True">Capture History</asp:LinkButton>
                        </td>
                        <td id="tdAttributes" runat="server" class="a-center">
                            <asp:LinkButton runat="server" ToolTip="Click Here to Add Attributes" ID="LnkAttributes"
                                OnClientClick="onShowAttributes()" Font-Underline="true" ForeColor="Red" Font-Bold="True">Add Attributes</asp:LinkButton>
                        </td>
                        <td id="tdPreviousDue" runat="server" class="a-right">
                            <asp:Label ID="lblPreviousDue" ForeColor="Red" Font-Bold="True" Text="Previous Due:"
                                runat="server" meta:resourcekey="lblPreviousDueResource1"></asp:Label>
                            <asp:Label ID="lblPreviousDueText" Text="0.00" runat="server" meta:resourcekey="lblPreviousDueTextResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divBill3" title="Billing Details">
                <asp:Panel CssClass="dataheaderInvCtrl" ID="BillingPanel1" runat="server" GroupingText="Billing Details"
                    meta:resourcekey="BillingPanel1Resource1">
                    <table class="w-100p">
                        <tr class="v-top">
                            <td class="w-75p v-top">
                                <table class="w-100p">
                                    <tr class="v-top">
                                        <td  class="v-top w-65p">
                                            <table class="w-100p">
                                                <tr class="v-top">
                                                    <td>
                                                        <div class="w-100p" runat="server" id="divItemTable">
                                                        </div>
                                                        <span id="spanAddItems" runat="server" class="a-center" style="color: Red; display: none;">
                                                            Add Items </span>
                                                     </td>
                                                </tr>
                                                <tr id="trOtherCurrency" runat="server" style="display: none;">
                                                    <td id="Td1" runat="server">
                                                        <OtherCurrency:OtherCurrencyDisplay IsDisplayPayedAmount="false" ID="OtherCurrencyDisplay1"
                                                            runat="server" />
                                                    </td>
                                                </tr>
                                                <tr id="divPaymentType" runat="server">
                                                    <td id="Td2" class="a-center" runat="server">
                                                        <Payment:paymentType ID="PaymentType" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left v-bottom bold" style="display: none;" id="tdCopayment" runat="server">
                                                        <table border="1">
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <%-- <asp:Label ID="Label5" runat="server" Text="Medical Amount" />--%>
                                                                    <asp:Label ID="Label5" runat="server" Text="Billed Amount" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblMedical" runat="server" Text="0.00" />
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label13" runat="server" Text="Non Medical Amount" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblNonMedical" runat="server" Text="0.00" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label23" runat="server" Text="Actual Copayment " />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblActualCopaymenttxt" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label6" runat="server" Text="Difference Between Claim & Medical Amount " />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblDifferenceAmount" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblPreAuthAmt" Text="Patient Net Payable Amount" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                                <asp:HiddenField ID="hdnClaim" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnTotalCopayment" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnTowardsAmount" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnPreAuthType" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnPreAuthPercentage" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnPreAuthAmount" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnCoPaymentType" runat="server" Value=" " />
                                                                <asp:HiddenField ID="hdnClaimID" runat="server" Value="-1" />
                                                                <asp:HiddenField ID="hdnCoPaymentlogicID" runat="server" Value="-1" />
                                                                <asp:HiddenField ID="hdnCoPaymentPerCentage" runat="server" Value="0" />
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label4" runat="server" Text="Claim Amount " />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblClaminAmount" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="dvHealhcard" runat="server">
                                                <table style="padding-top: 5px">
                                                    <tr>
                                                       <td class="v-top a-left">
                                                            <div id="dvExistingCard" class="w-100p">
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td style="padding-left: 50px">
                                                                            <div id="DvCard" class="w-100p">
                                                                                <asp:Label ID="lblCardNo" runat="server" Text="Health&nbsp;card&nbsp;No"></asp:Label>
                                                                                <asp:TextBox ID="txtCardNo" runat="server"></asp:TextBox>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <input type="button" id="btnAddcardNo" value="Add" onclick="javascript:return GetMemberDetails('VerifyMember','CardNo');"
                                                                                    class="btn" />
                                                                                <asp:Label ID="lblMobileNumber" Text="Click Here To Use Mobile Number" runat="server"
                                                                                    onclick="javascript:ClickCardType('Mobile');" class="lnkOtp w-50p" Style="display: none"></asp:Label>
                                                                                <asp:Label ID="lblCardStatus" runat="server" ClientIDMode="Static"></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: none">
                                                                        <td>
                                                                            <div id="DvMobile" class="w-100p">
                                                                                <asp:Label ID="lblMobileNo" runat="server" Text="Mobile No" Width="60px"></asp:Label>
                                                                                <asp:TextBox ID="txtMobileNo" runat="server" onChange="javascript:GetMemberDetails('VerifyMember','MobileNo');"></asp:TextBox>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <asp:Label ID="lblCardNumber" Text="Click Here To Use Card Number" runat="server"
                                                                                    class="lnkOtp" onclick="javascript:ClickCardType('Card');" Width="50%"></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: none">
                                                                        <td>
                                                                            <asp:CheckBox ID="chkCredit" runat="server" ClientIDMode="Static" Text="Credit" Checked="true"
                                                                                Style="display: none" />
                                                                            <asp:CheckBox ID="chkRedeem" runat="server" ClientIDMode="Static" Text="Redeem" Style="display: none"
                                                                                onclick="javascript:ClickCardType('Redeem');" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <style type="text/css">
                                                                                #cardPoints tr td
                                                                                {
                                                                                    border: 1px solid black;
                                                                                }
                                                                            </style>
                                                                            <table id="cardPoints"  style="padding-top: 20px" width="350px">
                                                                               
                                                                                <tr id="trHeader" style="display: none" class="Duecolor">
                                                                                    <td class="Duecolor">
                                                                                        Card No
                                                                                    </td>
                                                                                    <td class="Duecolor">
                                                                                        Card Amount
                                                                                    </td>
                                                                                    <td class="Duecolor">
                                                                                        Action
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <%-- <td valign="top">
                                                             <asp:CheckBox ID="chkMycard" runat="server" ClientIDMode="Static" onclick="javascript:CheckMyCard();" />
                                                             <input type="checkbox" id="chkMycard" runat="serv1er" checked="false"  ClientIDMode="Static"/> 
                                                             <asp:Label ID="lblHealthcard" runat="server" Text="Health Coupon" ClientIDMode="Static"></asp:Label> 
                                                        </td>--%>
                                                        <td runat="server" id="tdMycard" class="v-top">
                                                            <div id="dvMycard">
                                                                <asp:RadioButton ID="rbNewCard" runat="server" Text="New Card" name="CardType" ClientIDMode="Static"
                                                                    onclick="javascript:ClickCardType('NewCard');" />
                                                                <asp:RadioButton ID="rbExistingCard" runat="server" Text="Existing Card" name="CardType"
                                                                    onclick="javascript:ClickCardType('ExistsCard');" ClientIDMode="Static" />
                                                            </div>
                                                        </td>
                                                     
                                                        <td class="v-top">
                                                            <div id="dvPoints" style="display: none">
                                                                <table>
                                                                    <tr id="trCreditPoints" style="display: none;">
                                                                        <td>
                                                                            <asp:Label ID="lblPoints" runat="server" Text="Your Current Points is:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblCreditPoints" runat="server" ClientIDMode="Static"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trCreditAmount" style="display: none;">
                                                                        <td>
                                                                            <asp:Label ID="lblValue" runat="server" Text="Your Current Points Rs:"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblCreditValue" runat="server" ClientIDMode="Static"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div id="DvRedeemOnetimePassword">
                                                    <asp:Panel ID="pnlRedeem" runat="server" GroupingText="Redeem">
                                                        <table>
                                                            <tr id="trOtp" style="display: none;">
                                                                <td>
                                                                    <input id="btnGenerateOTP" class="btn" type="button" value="Generate OTP" onclick="return GenerateOtp('Billing');" />
                                                                    <%--<asp:Button ID="btnGenerateOTP" Text="GenerateOTP" class="btn" runat="server"  OnClientClick="javascript:return GenerateOtp();" ></asp:Button>--%>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblOtp" runat="server" Text="Enter Your OTP:"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtOTP" runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <%-- <asp:LinkButton ID="lnkVerifyOtp" runat="server" Text="Click Here To Verify OTP" onclick="return VerifyOtp()" CssClass="lnkOtp" style="color:#2c88b1;" ></asp:LinkButton>--%>
                                                                    <input id="Button1" class="btn" type="button" value="Verify OTP" onclick="return VerifyOtp();" />
                                                                </td>
                                                            </tr>
                                                            <tr id="trOtpVerifyStatus" style="display: none;">
                                                                <td colspan="4">
                                                                    <asp:Label ID="lblOtpStatus" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </div>
                                        </td>
                                        <td align="right">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table id="tblnetamt" runat="server" style="display: none">
                                                            <tr id="tr1">
                                                                <td>
                                                                    <asp:Label ID="Label2" runat="server" meta:resourceKey="lblNetValueResource1" Text="Net Amount" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:TextBox ID="txtEdtNetAmt" runat="server" CssClass="Txtboxverysmall" Enabled="False"
                                                                        Style="text-align: right" Text="0.00" />
                                                                    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdBillDetails" runat="server">
                                                <tr id="trFoc">
                                                    <td colspan="2">
                                                        <div class="a-left">
                                                            <asp:CheckBox ID="chkFoc" runat="server" Checked="false" Enabled="false"></asp:CheckBox>
                                                            <asp:Label ID="lblFoc" Text="IS FOC" runat="server" meta:resourceKey="lblNetValueResource1" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="trnetamt" style="display: none">
                                                    <td style="display: none">
                                                        <asp:Label ID="Label1" Text="Net Amount" runat="server" meta:resourceKey="lblNetValueResource1" />
                                                    </td>
                                                    <td class="a-right" style="display: none">
                                                        <asp:TextBox CssClass="Txtboxverysmall" ID="TextBox1" Style="text-align: right" Enabled="False"
                                                            runat="server" Text="0.00" meta:resourceKey="txtNetAmountResource1" />
                                                        <asp:HiddenField ID="HiddenField1" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                                <tr id="trOrderedItemsCount" runat="server" style="display: none;">
                                                    <td class="a-left">
                                                        <asp:Label ID="lblOrderCount" ForeColor="Red" Font-Bold="True" Text="Ordered Items:"
                                                            runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ForeColor="Red" Font-Bold="True" ID="lblOrderedItemsCount" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trDiscountPart" runat="server">
                                                    <td>
                                                        <asp:Label ID="tdDiscountLabel" Text="Select Discount" runat="server" meta:resourceKey="tdDiscountLabelResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList Enabled="False" CssClass="ddl" ID="ddDiscountPercent" Width="98%"
                                                            ToolTip="Select the Discount" onChange="javascript:SetDiscountAmt();SetNetValue('ADD');IsCheckMyCard();"
                                                            runat="server" meta:resourceKey="ddDiscountPercentResource1">
                                                        </asp:DropDownList>
                                                        <asp:Button ID="btnDiscountPercent" runat="server" Enabled="false" Text="Discount"
                                                            CssClass="smallbtn" />
                                                        <asp:Label ID="lblTtlDiscountPercentage" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trDiscountType" runat="server" style="display: none">
                                                    <td>
                                                        <asp:Label ID="lblDiscountType" Text="Discount Type" runat="server" meta:resourceKey="tdDiscountLabelResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="ddl" ID="ddlDiscountType" Width="98%" ToolTip="Select the Discount"
                                                            runat="server" meta:resourceKey="ddDiscountPercentResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trSlab" runat="server" style="display: none">
                                                    <td>
                                                        <asp:Label ID="lblSlab" Text="Discount Slab" runat="server" meta:resourceKey="tdDiscountLabelResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="ddl" ID="ddlSlab" Width="95%" ToolTip="Select the Discount"
                                                            onChange="javascript:SetNetValue('ADD');" runat="server" meta:resourceKey="ddDiscountPercentResource1">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr id="trCeiling" runat="server" style="display: none">
                                                    <td>
                                                        <asp:Label ID="lblCeiling" Text="Discount Value" runat="server" meta:resourceKey="tdDiscountLabelResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCeiling" runat="server" onchange="javascript:SetNetValue('ADD');"
                                                            CssClass="AutoCompletesearchBox" onkeypress="return blockNonNumbers(this, event, true, false);"></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr id="tdDiscReason" runat="server">
                                                    <td class="a-left">
                                                        <asp:Label ID="lblDiscountReason" runat="server" Text="Discount Reason"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList Enabled="False" ID="ddlDiscountReason" runat="server" CssClass="ddl"
                                                            Width="95%" onchange="javascript:GetSelectedValue();">
                                                        </asp:DropDownList>
                                                        <asp:TextBox Style="display: none;" ID="txtDiscountReason" autocomplete="off" CssClass="Txtboxsmall"
                                                            Width="95%" runat="server" MaxLength="900" onfocus="javascript:CheckBillItems();" />
                                                        <%-- <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                    </td>
                                                </tr>
                                                <tr id="trAuthorisedBy" runat="server">
                                                    <td class="a-left">
                                                        <asp:Label ID="lblAuthorised" runat="server" Text="Authorise By"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtAuthorised" autocomplete="off" onfocus="javascript:CheckBillItems();"
                                                            CssClass="AutoCompletesearchBox" runat="server" Width="145px" />
                                                        <%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                        <ajc:AutoCompleteExtender ID="AutoAuthorizer" runat="server" CompletionInterval="10"
                                                            FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                            Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandLoginID"
                                                            ServicePath="~/WebService.asmx" TargetControlID="txtAuthorised" OnClientItemOver="DiscountAuthSelectedOver"
                                                            OnClientItemSelected="DiscountAuthSelected">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                                <tr id="trRSTax" runat="server">
                                                    <td>
                                                        <asp:Label ID="Rs_Tax" Text="Select Tax" runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList Enabled="False" CssClass="ddl" ID="ddlTaxPercent" Width="98%" ToolTip="Select the Tax"
                                                            onChange="javascript:SetTaxAmt();SetNetValue('ADD');" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trHistory" runat="server">
                                                    <td class="v-top">
                                                        <asp:Label ID="lblHistory" runat="server" Text="History :" meta:resourceKey="lblHistoryResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPatientHistory" Width="95%" runat="server" onBlur="return collapseTextBox(this.id);"
                                                            onFocus="return expandTextBox(this.id)" TextMode="MultiLine" onkeypress="javascript:return MaxLengthAlert(this.id);"
                                                            onChange="javascript:return MaxLengthAlert(this.id);" meta:resourceKey="txtPatientHistoryResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="trRemarks" runat="server">
                                                    <td>
                                                        <asp:Label ID="lblRemarks" runat="server" Text="Remarks" meta:resourceKey="lblRemarksResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRemarks" Width="95%" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                            onFocus="return expandTextBox(this.id)" TextMode="MultiLine" meta:resourceKey="txtRemarksResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="w-15p" runat="server" id="tdGrossBillDetails">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" meta:resourceKey="lblGrossResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtGross" Style="text-align: right" runat="server"
                                                Text="0.00" Enabled="False" meta:resourceKey="txtGrossResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnGrossValue" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trHealthCard" style="display: none;">
                                        <td>
                                            <asp:Label ID="lblRedeem" runat="server" Text="Redeem" class="defaultfontcolor" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtRedeem" Style="text-align: right"
                                                runat="server" Text="0.00" ReadOnly="true"></asp:TextBox>
                                            <%-- <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />--%>
                                        </td>
                                    </tr>
                                    <tr id="trDisAmount" runat="server">
                                        <td>
                                            <asp:Label ID="lblDiscount" runat="server" Text="Discount" class="defaultfontcolor"
                                                meta:resourceKey="lblDiscountResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtDiscount" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                onBlur="javascript:SetNetValue('ADD');" Style="text-align: right;" runat="server"
                                                Text="0.00" meta:resourceKey="txtDiscountResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnDiscountAmt" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trServiceCharge" runat="server">
                                        <td>
                                            <asp:Label ID="lblServiceCharge" Text="Service Charge" runat="server" meta:resourceKey="lblServiceChargeResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtServiceCharge" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" meta:resourceKey="txtServiceChargeResource1" />
                                            <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trTaxAmountPart" runat="server">
                                        <td>
                                            <asp:Label ID="lblTaxt" Text="Tax" runat="server" meta:resourceKey="lblTaxtResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                onChange="javascript:SetNetValue('ADD');" ID="txtTax" runat="server" Style="text-align: right"
                                                Text="0.00" meta:resourceKey="txtTaxResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdfTax" runat="server" />
                                            <div id="dvTaxDetails" align="left" runat="server">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="trRsEDSChess" runat="server">
                                        <td>
                                            <asp:Label ID="Rs_EDCess" Text="ED Cess(2%)" runat="server" />
                                            <asp:CheckBox runat="server" Width="7%" ToolTip="Add ED Cess to Bill" onclick="javascript:SetNetValue('ADD');"
                                                ID="chkEDCess" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtEDCess" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                onBlur="javascript:SetNetValue('ADD');" Style="text-align: right" runat="server"
                                                Text="0.00" />
                                            <asp:HiddenField ID="hdnEDCess" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trRssHEDChess" runat="server">
                                        <td>
                                            <asp:Label ID="Rs_SHEDCess" Text="SHED Cess(1%)" runat="server" />
                                            <asp:CheckBox runat="server" Width="7%" ToolTip="Add SHED Cess to Bill" onclick="javascript:SetNetValue('ADD');"
                                                ID="chkSHEDCess" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtSHEDCess" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                onBlur="javascript:SetNetValue('ADD');" Style="text-align: right" runat="server"
                                                Text="0.00" />
                                            <asp:HiddenField ID="hdnSHEDCess" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trRoundOffAmount" runat="server">
                                        <td>
                                            <asp:Label ID="lblRoundOffAmt" Text="Round Off" runat="server" meta:resourceKey="lblRoundOffAmtResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtRoundoffAmt" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" meta:resourceKey="txtRoundoffAmtResource1" />
                                            <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trNetValue" runat="server">
                                        <td>
                                            <asp:Label ID="lblNetValue" Text="Net Amount" runat="server" meta:resourceKey="lblNetValueResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtNetAmount" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" meta:resourceKey="txtNetAmountResource1" />
                                            <asp:HiddenField ID="hdnNetAmount" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trAmountReceived" runat="server">
                                        <td>
                                            <asp:Label ID="lblAmtReceived" Text="Amt Received" runat="server" meta:resourceKey="lblAmtReceivedResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtAmtReceived" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" meta:resourceKey="txtAmtReceivedResource1" />
                                            <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trDue" runat="server" style="display: table-row;">
                                        <td>
                                            <asp:Label ID="lblDue" Text="Due" runat="server" meta:resourceKey="lblDueResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtDue" Style="text-align: right" Enabled="False"
                                                runat="server" Text="0.00" meta:resourceKey="txtDueResource1" />
                                            <asp:HiddenField ID="hdnDue" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <input id="hdnDiscountApprovedBy" type="hidden" value="0" runat="server" />
                    <input type="hidden" runat="server" value="Y" id="hdnIsCashClient" />
                    <input type="hidden" runat="server" value="Y" id="hdnOrgid" />
                    <input type="hidden" runat="server" value="" id="hdnClientType" />
                    <input type="hidden" runat="server" value="" id="hdnReportCommitedDate" />
                    <input type="hidden" runat="server" value="Y" id="hdnValidation" />
                    <input id="hdfBillType1" type="hidden" runat="server" />
                    <input id="hndLocationID" type="hidden" value="0" runat="server" />
                    <input id="hdnFeeTypeSelected" type="hidden" runat="server" value="COM" />
                    <input id="hdnName" type="hidden" runat="server" />
                    <input id="hdnAmt" type="hidden" runat="server" value="0" />
                    <input id="hdnID" type="hidden" runat="server" />
                    <input id="hdnReportDate" type="hidden" runat="server" />
                    <input id="hdnRemarks" type="hidden" runat="server" />
                    <input id="hdnIsRemimbursable" type="hidden" runat="server" />
                    <input id="hdnPaymentControlReceivedtemp" type="hidden" value="0.00" runat="server" />
                    <input type="hidden" id="hdnActualAmount" value="0" runat="server" />
                    <input type="hidden" id="hdnBaseRateID" value="0" runat="server" />
                    <input type="hidden" id="hdnDiscountPolicyID" value="0" runat="server" />
                    <input type="hidden" id="hdnDiscountCategoryCode" value="" runat="server" />
                    <input type="hidden" id="hdnGender" runat="server" />
                    <input type="hidden" runat="server" value="N" id="hdnIsDiscount" />
                    <input type="hidden" runat="server" value="Y" id="hdnIsDiscountableTest" />
                    <input type="hidden" runat="server" value="Y" id="hdnIsTaxable" />
                    <input type="hidden" runat="server" value="N" id="hdnIsRepeatable" />
                    <input type="hidden" runat="server" value="N" id="hdnIsSTAT" />
                    <input type="hidden" runat="server" value="N" id="hdnIsSMS" />
                    <input type="hidden" runat="server" value="N" id="hdnIsOutSource" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountableTestTotal" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemableTestAmount" />
                    <input type="hidden" runat="server" value="0" id="hdnTaxableTestToal" />
                    <input type="hidden" runat="server" value="N" id="hdnIsNABL" />
                    <input type="hidden" runat="server" value="0" id="hdnBillingItemRateID" />
                    <input type="hidden" runat="server" value="0" id="hdnInvCode" />
                    <input type="hidden" runat="server" value="0" id="hdnOrgIDC" />
                    <input type="hidden" runat="server" value="N" id="hdnHasHistory" />
                    <input type="hidden" runat="server" value="N" id="hdnProcessingLoc" />
                    <input id="hdnInvHistory" type="hidden" runat="server" />
                    <input id="hdnHistoryAttributeList" type="hidden" runat="server" />
                    <asp:HiddenField ID="hdnAttributesList" runat="server" />
                    <input id="hdnCapture" type="hidden" runat="server" />
                    <input id="hdnHistoryTableList" type="hidden" runat="server" />
                    <input id="hdnHistoryTableLists" type="hidden" runat="server" />
                    <input id="hdnHistoryTableListsP" type="hidden" runat="server" />
                    <input type="hidden" runat="server" id="hdnIsInvestigationAdded" value="0" />
                    <asp:HiddenField ID="hdnfinduplicate" runat="server" />
                    <input type="hidden" runat="server" value="N" id="hdnoutsourcelocation" />
                    <input type="hidden" runat="server" id="hdnDiscountPercentage" value="0" />
                    <input type="hidden" runat="server" id="hdnAllowMulDisc" />
                    <input type="hidden" runat="server" id="hdnDisPercentage" />
                    <input type="hidden" runat="server" id="hdnDisReason" />
                    <input type="hidden" runat="server" id="hdnCpedit" value="N" />
                    <asp:HiddenField ID="hdnIsClientBilling" Value="N" runat="server" />
                    <asp:HiddenField ID="hdnIsBillable" Value="" runat="server" />
                    <asp:HiddenField ID="hdnIsCollected" Value="N" runat="server" />
                    <asp:HiddenField ID="hdnCollectedDateTime" Value="01/01/1900" runat="server" />
                    <asp:HiddenField ID="hdnLocName" runat="server" />
                    <asp:HiddenField ID="ZeroAmount" runat="server" />
                    <input id="hdnDeliveryDate" type="hidden" runat="server" />
                    <input type="hidden" runat="server" value="N" id="hdnIsHistoryMandatory" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountID" />
                    <%-- Added--%>
                    <input type="hidden" runat="server" value="0" id="hdnCeilingValue" />
                    <input type="hidden" runat="server" value="0" id="hdnMaxDiscount" />
                    <input type="hidden" runat="server" value="" id="hdnItems" />
                    <input type="hidden" runat="server" value="" id="hdnItemsNoDiscount" />
                    <input type="hidden" runat="server" value="" id="hdnItemLevelPercent" />
                    <input type="hidden" runat="server" value="" id="hdnItemLevelTotalPercent" />
                    <input type="hidden" runat="server" value="0" id="hdnIsNormalRateCard" />
                    <input type="hidden" runat="server" value="N" id="hdnIsSlabDiscount" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountSlab" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountCeiling" />
                    <input type="hidden" runat="server" value="0" id="hdnSlabPercentAndValue" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountDetails" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountType" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountReason" />
                    <input type="hidden" runat="server" value="" id="hdnDiscountReasonForFoc" />
                    <input type="hidden" runat="server" value="N" id="hdnIsRedeem" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemAmount" />
                    <%-- MyCard--%>
                    <input type="hidden" runat="server" value="N" id="hdnHasMyCard" />
                    <input type="hidden" runat="server" value="0" id="hdnExistingPatientID" />
                    <input type="hidden" runat="server" value="0" id="hdnMycardDetails" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemPoints" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemValue" />
                    <input type="hidden" runat="server" value="0" id="hdnMembershipCardMappingID" />
                    <input type="hidden" runat="server" value="" id="hdnOtpExist" />
                    <input type="hidden" runat="server" value="" id="hdnHealthCardItems" />
                    <input type="hidden" runat="server" value="" id="hdnlstHealthCardItems" />
                    <input type="hidden" runat="server" value="N" id="hdnHealthCardOTP" />
                    <input type="hidden" runat="server" value="" id="hdnmyCardDetailsbill" />
                    <input type="hidden" runat="server" value="" id="hdnMycarddetailsSave" />
                    <input type="hidden" runat="server" value="" id="hdnTotalRedeemPoints" />
                    <input type="hidden" runat="server" value="" id="hdnTotalRedeemAmount" />
                    <input type="hidden" runat="server" value="" id="hdntotalredemPoints" />
                    <input type="hidden" runat="server" value="" id="hdnHasClientHealthcoupon" />
                    <input type="hidden" runat="server" value="" id="hdnOrgHealthCoupon" />
                    <input type="hidden" runat="server" value="0" id="hdnReferedPhyID" />
                    <input type="hidden" runat="server" value="" id="hdnReferedPhyName" />
					  <asp:HiddenField ID="hdnallowduplicatetesttobill" runat="server"  Value="N" />
                </asp:Panel>
                <div class="w-100p">
                    <div id="divHistoryDetail" runat="server" class="w-100p">
                        <asp:Panel ID="PanelHistory" runat="server" ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup">
                            <div id="divHistory">
                                <table class="dataheader2 defaultfontcolor w-100p">
                                    <tr>
                                        <td id="Td3" class="w-100p">
                                            <His:History ID="UcHistory" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table class="w-100p h-100">
                                                <tr>
                                                    <td class="a-right">
                                                        <input type="button" runat="server" id="Butsave" class="btn" value="Save" onclick="return AddHistoryItemList();" />
                                                    </td>
                                                    <td class="margin0 padding0">
                                                        <input type="button" runat="server" id="ButEdit" class="btn" value="Edit" onclick="edits_Click();"
                                                            style="display: none;" />
                                                    </td>
                                                    <td class="margin0 padding0">
                                                        <input type="button" runat="server" id="ButPrint" class="btn" value="Print" onclick="popupprintHistory();"
                                                            style="display: none;" />
                                                    </td>
                                                    <td class="a-left">
                                                        <input id="Butclose" runat="server" class="btn" type="button" value="Close" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="PanelAttributes" runat="server" Style="height: 365px; width: 750px;"
                            ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup">
                            <div id="divAttributes">
                                <table class="w-100p a-center" cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor">
                                    <tr>
                                        <td id="Td4" class="w-100p">
                                            <His:History ID="UctHistory" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <ajc:ModalPopupExtender ID="MPEhistory" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="PanelHistory" CancelControlID="Butclose" TargetControlID="LnkHistory"
                            Enabled="True">
                        </ajc:ModalPopupExtender>
                        <ajc:ModalPopupExtender ID="PATattributes" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="PanelAttributes" TargetControlID="LnkAttributes"
                            Enabled="True">
                        </ajc:ModalPopupExtender>
                    </div>
                    <div id="dvInvstigationDetails" runat="server">
                        <asp:Panel ID="PanelGroup" runat="server" Style="height: 300px; width: 650px;" CssClass="modalPopup dataheaderPopup">
                            <asp:Panel ID="table_GroupItem" runat="server" Style="height: 260px; width: 650px;"
                                ScrollBars="Auto">
                                <table id="Group" class="a-center">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Lbl_GroupName" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblGroupHistory" class='dataheaderInvCtrl gridView' align="center" nowrap='nowrap'
                                    class="w-100p" style='font-size: 11px; border: none'>
                                    <tbody>
                                        <tr class='dataheader1'>
                                            <th scope='col' class="a-left w-7p paddingL2">
                                                S.No
                                            </th>
                                            <th scope='col' class="a-left w-53p paddingL2">
                                                Service Name
                                            </th>
                                            <th scope='col' class="a-left w-15p paddingL2">
                                                Service Type
                                            </th>
                                            <th scope='col' class="a-left w-25p paddingL2">
                                                Processing Location
                                            </th>
                                             <th scope='col' class="a-left w-25p paddingL2">
                                                
                                            </th>
                                        </tr>
                                        <tbody>
                                </table>
                            </asp:Panel>
                            <div id="Btn_Close">
                                <table class="a-center w-100p">
                                    <tr>
                                        <td class="a-center">
                                            <input id="Button2" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                type="button" value="Close" onclick="return ClearPopUp1();" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <ajc:ModalPopupExtender ID="MPEMultDisc" runat="server" TargetControlID="btnDiscountPercent"
                            PopupControlID="Panel1" BackgroundCssClass="modalBackground" Enabled="True" DropShadow="True"
                            DynamicServicePath="" CancelControlID="btnCancel" />
                        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Style="width: 400px;
                            height: 400px; overflow: scroll; overflow-x: hidden;" meta:resourcekey="Panel1Resource1">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div style="text-align: center;">
                                        Multiple Discount
                                    </div>
                                    <asp:GridView ID="gvMultiDisTypes" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        Width="100%" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                                        Font-Bold="False" Font-Names="Verdana" Font-Overline="False" Font-Size="9pt"
                                        Font-Strikeout="False" Font-Underline="False" DataKeyNames="Discount,DiscountName">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Select
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="CheckSelect" runat="server" />
                                                    <asp:HiddenField ID="hdDiscount" runat="server" Value='<%# Eval("Discount") %>' />
                                                    <asp:HiddenField ID="hdDiscountID" runat="server" Value='<%# Eval("DiscountID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Percentage
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDiscountPercentage" runat="server" Text='<%# Eval("DiscountPercentage") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Name
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDiscountName" runat="server" Text='<%# Eval("DiscountName") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdDiscountName" runat="server" Value='<%# Eval("DiscountName") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <div class="a-center">
                                        <input type="button" id="btnAddDisc" value="ADD" runat="server" class="smallbtn"
                                            onclick="javascript:return fnCalTtlDisount();" />
                                        <input type="button" id="btnCancel" value="Cancel" runat="server" class="smallbtn" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        <ajc:ModalPopupExtender ID="ModalPopupShow" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="PanelGroup" Enabled="True" TargetControlID="btnDummy">
                        </ajc:ModalPopupExtender>
                        <input type="button" id="btnDummy" runat="server" style="display: none;" />
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>
<style type="text/css">
    .lnkOtp
    {
        font-size: larger;
        font-weight: bold;
        font-style: italic;
        text-decoration: none;
        color: #2c88b1;
        cursor: pointer;
    }
</style>

<script type="text/javascript" language="javascript">
    function chkPros() {
        var orgID = '<%= OrgID %>';
        CallBillItems(orgID);
    }
</script>

<script type="text/javascript">

    //    $('#dvMycard').hide();
    $('#dvPoints').hide();
    //    $('#dvExistingCard').hide();
    $('#DvRedeemOnetimePassword').hide();
    //    $('#billPart_trHealthCard').hide();
    //    $("#DvCard").show();

    //    $("#DvMobile").hide();
    //    
    function CheckMyCard() {
        //ClearmycardDetails('Y');

        //            IsCheckMyCard();
        //            $('#dvMycard').hide();
        //            $('#trHealthCard').css("display", "none");
        //            $('#billPart_tdBillDetails').removeAttr("disabled");
        //            $('#dvExistingCard').hide();
        //            $('#billPart_txtDiscount').removeAttr("readonly");
        //            $("input#billPart_rbNewCard").attr('checked', false);
        //            $("input#billPart_chkRedeem").attr('checked', false);
        //            $("input#billPart_chkCredit").attr('checked', true);
        //            $("input#billPart_rbExistingCard").attr('checked', false);
        //            $('#dvExistingCard').hide();
        //            $('#dvPoints').hide();
        //      
        //            IsCheckMyCard();
        //            $('#trHealthCard').css("display", "");
        //            $('#dvMycard').show();
        //            $('#billPart_txtDiscount').attr('readonly', true);

        //            $('#billPart_tdBillDetails').attr('disabled', 'disabled');
        //            $('#dvExistingCard').show();
        //            $('#dvPoints').hide();

    }
    var Obj;
    function ClickCardType(obj) {

        if (obj == "NewCard") {
            //$("input#billPart_rbNewCard").click(function() {
            $('#dvExistingCard').hide();
            $('#dvPoints').hide();
            $("input#billPart_rbExistingCard").attr('checked', false);
            //});
        }
        else if (obj == "ExistsCard") {
            if (!$('#billPart_rbExistingCard').is(':checked')) {
                $('#dvExistingCard').hide();
                $('#dvPoints').hide();
                $("input#billPart_rbNewCard").attr('checked', false);
                $("input#billPart_chkRedeem").attr('checked', false);
                $("input#billPart_chkCredit").attr('checked', true);
            }
            else {
                //$("input#billPart_rbExistingCard").click(function() {
                $('#dvExistingCard').show();
                $('#dvPoints').hide();
                $("input#billPart_rbNewCard").attr('checked', false);
                $("input#billPart_chkRedeem").attr('checked', false);
                $("input#billPart_chkCredit").attr('checked', true);
            }
        }
        else if (obj == "Redeem") {
            // $("#billPart_chkRedeem").click(function() {
            // debugger;
            if (!$('#billPart_chkRedeem').is(':checked')) {

                SetNetValue('RedeemUncheck');
            }
            else {
                var MemberCardNo = $('#billPart_txtCardNo').val();
                var MobileNo = $('#billPart_txtMobileNo').val();
                if (MemberCardNo == "" && MobileNo == "") {
                    if ($('#billPart_txtMobileNo').is(':visible')) {
                        if (MobileNo == "") {
                            $("input#billPart_chkRedeem").attr('checked', false);
                            alert("Please enter the mobile number");
                        }
                    }
                    if ($('#billPart_txtCardNo').is(':visible')) {
                        if (MemberCardNo == "") {
                            $("input#billPart_chkRedeem").attr('checked', false);
                            alert("Please enter the card number");
                        }
                    }
                }
                else {

                    // $("#billPart_txtMobileNo").mask("999-999-9999");
                    var RedeemPoints = $('#billPart_lblCreditPoints').text();
                    var RedeemAmount = $('#billPart_lblCreditValue').text();
                    if (RedeemPoints != "" && RedeemAmount != "") {
                        //Create Credit detail table
                        var cardNo = $('#billPart_txtCardNo').val();
                        var RedeemTestTotalAmount = 0;
                        var TotalcardAmt1 = 0;

                        $('#cardPoints tr').each(function(i, n) {
                            if (i == 0) {
                            }
                            else {
                                var $row = $(n);
                                var lblCardAmt = $row.find($('span[id$="lblCardAmt"]')).html();
                                if (typeof (lblCardAmt) === "undefined") {
                                }
                                else {
                                    TotalcardAmt1 = parseFloat(TotalcardAmt1) + parseFloat(lblCardAmt);
                                }
                                //  previousRedemData = TotalcardAmt;
                            }
                        });

                        var lstHealthCardItems = document.getElementById('billPart_hdnHealthCardItems').value;
                        arrayMainData = lstHealthCardItems.split('-');
                        var ItemLevelRedemableAmt = 0.00;
                        var ItemLevelRedeemMasterpercent = 0;
                        if (arrayMainData.length > 0) {
                            for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {
                                var maindata = arrayMainData[iMain];
                                var data = maindata.split('~');
                                var Itemfeelid = data[0];
                                var ItemFeeType = data[1];
                                var IsRedeem = data[4];
                                if (data[2].trim() != "")
                                    ItemAmount = data[2];

                                if (data[3].trim() != "") {
                                    ItemLevelRedeemMasterpercent = data[3];
                                }
                                else {
                                    ItemLevelRedeemMasterpercent = 0.00;
                                }
                                if (IsRedeem == "Y") {
                                    ItemLevelRedemableAmt = Number(parseFloat(ItemLevelRedemableAmt)) + Number(parseFloat((parseFloat(ItemAmount) * parseFloat(ItemLevelRedeemMasterpercent)) / 100).toFixed());
                                }
                            }
                        }
                        RedeemTestTotalAmount = ItemLevelRedemableAmt;
                        //  AddCardPoints(cardNo, RedeemPoints, RedeemTestTotalAmount);
                        var totalredemPoints = AddCardPoints(cardNo, RedeemPoints, RedeemTestTotalAmount);
                        $("#billPart_txtCardNo").val("");
                        $("#billPart_hdnTotalRedeemPoints").val(RedeemPoints);
                        $("#billPart_hdnTotalRedeemAmount").val(RedeemAmount);
                        $("#billPart_hdntotalredemPoints").val(totalredemPoints);

                        if (RedeemTestTotalAmount < totalredemPoints) {
                            totalredemPoints = RedeemTestTotalAmount;
                        }
                        ItemLevelCreditCal(RedeemPoints, RedeemAmount, totalredemPoints);

                    }
                    $("input#billPart_chkCredit").attr('checked', true);
                    $('#trOtp').css("display", "");

                }
            }
        }
        else if (obj == 'Card') {
            //$("#billPart_lblCardNumber").click(function() {
            $('#dvExistingCard').show();
            $("#DvCard").show();
            $("#DvMobile").hide();
            //});
        }
        else if (obj == 'Mobile') {
            $("#billPart_lblMobileNumber").click(function() {
                $('#dvExistingCard').show();
                $("#DvCard").hide();
                $("#DvMobile").show();
            });
        }

    }
    //   $("#billPart_txtMobileNo").mask("999-999-9999");
</script>

<script type="text/javascript">
    var hdnHasMyCard = $('#billPart_hdnHasMyCard').val();

    // $('#dvMycard').hide();
    // $('#dvPoints').hide();
    // $('#dvExistingCard').hide();
    //  $('#DvRedeemOnetimePassword').hide();
    // $('#billPart_trHealthCard').hide();
    //  $("#DvCard").show();
    //  $("#DvMobile").hide();
    //  $("input#billPart_chkMycard").attr('checked', false);
    if (hdnHasMyCard == "Y") {
        //        $('#billPart_chkMycard').click(function() {
        //             if (!$(this).is(':checked')) {
        //                IsCheckMyCard();
        //                $('#dvMycard').hide();
        //                $('#trHealthCard').css("display", "none");
        //                $('#billPart_tdBillDetails').removeAttr("disabled");
        //                $('#dvExistingCard').hide();

        //            }
        //            else {
        //                IsCheckMyCard();
        //                $('#trHealthCard').css("display", "");
        //                $('#dvMycard').show();
        //                $('#billPart_tdBillDetails').attr('disabled', 'disabled');

        //            }
        //        });

        //        $("input#billPart_rbExistingCard").click(function() {
        //            $('#dvExistingCard').show();
        //            $('#dvPoints').hide();
        //            $("input#billPart_rbNewCard").attr('checked', false);
        //            $("input#billPart_chkRedeem").attr('checked', false);
        //            $("input#billPart_chkCredit").attr('checked', true);

        //        });
        //        $("input#billPart_rbNewCard").click(function() {
        //            $('#dvExistingCard').hide();
        //            $('#dvPoints').hide();
        //            $("input#billPart_rbExistingCard").attr('checked', false);
        //        });
        //        $("input#billPart_chkCredit").click(function() {
        //            var MemberCardNo = $('#billPart_txtCardNo').val();
        //            if (MemberCardNo == "") {
        //                $("input#billPart_chkCredit").attr('checked', false);
        //                alert("Please enter the card number");
        //            } else {
        //                $("input#billPart_chkRedeem").attr('checked', false);
        //                $('#DvRedeemOnetimePassword').hide();
        //            }
        //        });
        //Added
        //        $("#billPart_chkRedeem").click(function() {
        //            // debugger;
        //            var MemberCardNo = $('#billPart_txtCardNo').val();
        //            var MobileCardNo = $('#billPart_txtMobileNo').val();
        //            if (MemberCardNo == "" || MobileCardNo=="") {
        //                $("input#billPart_chkRedeem").attr('checked', false);
        //                alert("Please enter the card number");
        //            }
        //            else {
        //                var RedeemPoints = $('#billPart_lblCreditPoints').text();
        //                var RedeemAmount = $('#billPart_lblCreditValue').text();
        //                if (RedeemPoints != "" && RedeemAmount != "") {
        //                    ItemLevelCreditCal(RedeemPoints, RedeemAmount);
        //                }
        //                $("input#billPart_chkCredit").attr('checked', true);
        //                $('#trOtp').css("display", "");
        //              
        //            }

        //        });
        //        $("#billPart_lblCardNumber").click(function() {
        //            $('#dvExistingCard').show();
        //            $("#DvCard").show();
        //            $("#DvMobile").hide();
        //        });
        //        $("#billPart_lblMobileNumber").click(function() {
        //            $('#dvExistingCard').show();
        //            $("#DvCard").hide();
        //            $("#DvMobile").show();
        //        });
    }
	
	
	function keypress() {


        if (document.getElementById('hdnSelectedPatientID').value != '' && document.getElementById('hdnSelectedPatientID').value != null) {
            document.getElementById('tdChkNewPatient').style.display = 'none';
            document.getElementById('chkNewPatient').disabled = true;
        }
        else {
            document.getElementById('tdChkNewPatient').style.display = 'block';
            document.getElementById('chkNewPatient').checked = true;
            document.getElementById('chkNewPatient').disabled = false;
        }
        if (document.getElementById('txtPatientName').value == '') {
            alert('Provide Patient details Patient Name');
            document.getElementById('txtPatientName').focus();
            return false;
        }
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            alert('Provide Patient details patient sex');
            document.getElementById('ddlSex').focus();
            return false;

        }
        if (document.getElementById('txtDOBNos').value == '') {
            alert('Provide Patient details Patient Age');
            document.getElementById('txtDOBNos').focus();
            return false;
        }

        if (document.getElementById('txtAddress').value == '') {
            alert('Provide Patient details Collection Address');
            document.getElementById('txtAddress').focus();
            return false;
        }



        if (document.getElementById('txtpincode').value == '') {
            alert('Provide Patient details Pincode or Location');
            document.getElementById('txtpincode').focus();
            return false;
        }
        /*  if (document.getElementById('txtCity').value == '') {
        alert('Please Enter a City');
        document.getElementById('txtCity').focus();
        return false;
        }*/



        if (document.getElementById('txtMobile').value == '') {
            alert(' Mobile Number');
            document.getElementById('txtMobile').focus();
            return false;
        }
        //                if ($("#txtMobile").val() != '') {
        //                $("#txtMobile").val().length < 10 
        //                    alert('Please Enter Valid Ph.No');
        //                    document.getElementById('ddlUser').focus();
        //                    return false;
        //                }
        var ddlaction = document.getElementById('ddlOrg');
        if (ddlaction.options[ddlaction.selectedIndex].text == '--Select--') {
            alert('Provide Patient details Organization');
            return false;
        }

        var ddlLocation = document.getElementById('ddlLocation');
        if (ddlLocation.options[ddlLocation.selectedIndex].text == '--Select--') {
            alert('Provide Patient details Location');
            document.getElementById('ddlLocation').focus();
            return false;
        }
        //             ------Select------
        if (document.getElementById('ddlHCRole').options[document.getElementById('ddlHCRole').selectedIndex].text == '------Select------') {
            alert('Please Select a Role');
            document.getElementById('ddlHCRole').focus();
            return false;
        }

        if (document.getElementById('ddlUser').options[document.getElementById('ddlUser').selectedIndex].text == '------Select------') {

            alert('Provide Patient details Technician');
            document.getElementById('ddlUser').focus();
            return false;
        }


        if (document.getElementById('rdoPatientSave').checked == true) {
            //            if ($.trim($('[id$="hdfBillType1"]').val()) == '') {
            //                alert('Add Test to Book');
            //                return false;
            //            }

            if (document.getElementById('txtTime').value == '') {
                alert('Provide Patient details Sample Collection Time');
                return false;
            }
            else {
                //return ForFutureDate();   

                var CDate = document.getElementById('txtTime').value;
                return ForFutureDate(CDate);
            }

        }

    }


    function SetDiscountAmt() {

        debugger;
        var DiscountType = "";
        var pDiscountPercent = document.getElementById('billPart_ddDiscountPercent');
        if (pDiscountPercent.selectedIndex == 0 && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y")
            $('#billPart_dvHealhcard').show();
        else
            $('#billPart_dvHealhcard').hide();
        var DiscountPercent = pDiscountPercent.options[pDiscountPercent.selectedIndex].value;
        var DiscountPercentName = pDiscountPercent.options[pDiscountPercent.selectedIndex].Text;
        var SDiscountId = DiscountPercent.split('~');
        var DiscountId = SDiscountId[1];
        if (SDiscountId[3] != "") {
            DiscountType = SDiscountId[3];
        }
        document.getElementById('billPart_hdnDiscountDetails').value = DiscountPercentName + '~';

        if (document.getElementById('billPart_ddDiscountPercent').value == '0') {
            document.getElementById('billPart_txtDiscount').value = '0.00';
            ToTargetFormat($('#billPart_txtDiscount'));
            document.getElementById('billPart_hdnDiscountAmt').value = '0';
            ToTargetFormat($('#billPart_hdnDiscountAmt'));
        }
        if (document.getElementById('billPart_hdnDiscountPercentage').value == '0') {
            document.getElementById('billPart_txtDiscount').value = '0.00';
            ToTargetFormat($('#billPart_txtDiscount'));
            document.getElementById('billPart_hdnDiscountAmt').value = '0';
            ToTargetFormat($('#billPart_hdnDiscountAmt'));
        }
        /*************Added by Arivalagan.kk*****************/

        if ($('#billPart_ddDiscountPercent option:selected').val() != 0) {
            document.getElementById('billPart_txtAuthorised').disabled = false;
            document.getElementById('billPart_txtAuthorised').readOnly = false;
            document.getElementById('billPart_txtDiscountReason').readOnly = false;
            document.getElementById('billPart_ddlDiscountReason').disabled = false;
            document.getElementById('billPart_ddlDiscountType').disabled = false;
        }
        else if ($('#billPart_txtDiscount').val() > 0) {

            document.getElementById('billPart_txtAuthorised').disabled = false;
            document.getElementById('billPart_txtAuthorised').readOnly = false;
            document.getElementById('billPart_txtDiscountReason').readOnly = false;
            document.getElementById('billPart_ddlDiscountReason').disabled = false;
            document.getElementById('billPart_ddlDiscountType').disabled = false;
        }
        else {

            document.getElementById('billPart_txtAuthorised').disabled = true;
            document.getElementById('billPart_txtAuthorised').readOnly = true;
            document.getElementById('billPart_txtDiscountReason').readOnly = true;
            document.getElementById('billPart_ddlDiscountReason').disabled = true;
            document.getElementById('billPart_ddlDiscountType').disabled = true;
        }
        /************End*Added by Arivalagan.kk**************/
        var KeySlabDiscount = document.getElementById('billPart_hdnIsSlabDiscount').value;
        if (KeySlabDiscount == 'Y') {
            if (DiscountPercent == "0") {
                document.getElementById("billPart_trDiscountType").style.display = 'none';
                document.getElementById("billPart_trSlab").style.display = 'none';
                document.getElementById('billPart_ddlSlab').value = 0;
                document.getElementById("billPart_trCeiling").style.display = 'none';
                document.getElementById('billPart_txtCeiling').value = 0;
                document.getElementById('billPart_ddlDiscountReason').options.length = 0;
                var ddlDiscountReason = document.getElementById("billPart_ddlDiscountReason");
                var optn = document.createElement("option");
                ddlDiscountReason.options.add(optn);
                optn.text = "--Select--";
                optn.value = "0";

            } else {
                if (DiscountId != '' && DiscountId > 0) {
                    if (DiscountType == "Foc") {
                        document.getElementById("billPart_chkFoc").checked = true;
                        document.getElementById("billPart_trDiscountType").style.display = 'none';
                        document.getElementById("billPart_trSlab").style.display = 'none';
                        document.getElementById("billPart_trCeiling").style.display = 'none';
                        document.getElementById('billPart_txtAuthorised').disabled = false;
                        document.getElementById('billPart_chkEDCess').disabled = true;
                        document.getElementById('billPart_txtEDCess').disabled = true;
                        document.getElementById('billPart_chkSHEDCess').disabled = true;
                        document.getElementById('billPart_txtSHEDCess').disabled = true;
                        document.getElementById('billPart_txtTax').disabled = true;
                        document.getElementById('billPart_ddlTaxPercent').disabled = true;
                        document.getElementById('billPart_hdnDiscountType').value = 0;
                        document.getElementById('billPart_hdnSlabPercentAndValue').value = 0;
                        document.getElementById('billPart_hdnCeilingValue').value = "";

                        GetSlab(DiscountId);
                    }
                    else {
                        document.getElementById("billPart_chkFoc").checked = false;
                        document.getElementById("billPart_ddlSlab").options.length = 0;
                        document.getElementById('billPart_txtAuthorised').value = "";
                        document.getElementById('billPart_hdnDiscountCeiling').value = "0";
                        document.getElementById('billPart_txtCeiling').value = "";
                        document.getElementById('billPart_hdnCeilingValue').value = "";
                        GetSlab(DiscountId);
                    }
                }
            }
        }
        else {
            SetNetValue('ADD');
        }
    }

</script>

