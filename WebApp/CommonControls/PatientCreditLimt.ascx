<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientCreditLimt.ascx.cs"
    Inherits="CommonControls_PatientCreditLimt" %>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript">
    function SetCreditLimitValues(TotalBilled, TotalReceived, DifferencebillRece, CreditLimt, BalanceCreditLimt, IsCreditBill, PreAuthAmount, NonMedicalAmount, isPortTrust, ClaimAmount) {

        if (IsCreditBill == 'Y') {
            IsCreditBillYes(TotalBilled, TotalReceived, DifferencebillRece, CreditLimt, BalanceCreditLimt, IsCreditBill, PreAuthAmount, NonMedicalAmount, isPortTrust, ClaimAmount);
        }
        if (IsCreditBill == 'N') {
            IsCreditBillNo(TotalBilled, TotalReceived, DifferencebillRece, CreditLimt, BalanceCreditLimt, IsCreditBill, PreAuthAmount, NonMedicalAmount, isPortTrust, ClaimAmount);
        }


    }
    function IsCreditBillYes(TotalBilled, TotalReceived, DifferencebillRece, CreditLimt, BalanceCreditLimt, IsCreditBill, PreAuthAmount, NonMedicalAmount, isPortTrust, ClaimAmount) {

        if (IsCreditBill == 'Y' && isPortTrust == 'Y') {
            document.getElementById('<%=tblCreditLimit.ClientID %>').style.display = "none";
        }
        else {
            document.getElementById('<%=hdnTotalBilled.ClientID %>').value = parseFloat(TotalBilled).toFixed(2);
            document.getElementById('<%=hdnTotalReceived.ClientID %>').value = parseFloat(TotalReceived).toFixed(2);
            document.getElementById('<%=hdnDifferencebillRece.ClientID %>').value = parseFloat(DifferencebillRece).toFixed(2);
            document.getElementById('<%=hdnCreditLimt.ClientID %>').value = parseFloat(CreditLimt).toFixed(2);
            document.getElementById('<%=hdnBalCreditLimit.ClientID %>').value = parseFloat(BalanceCreditLimt).toFixed(2);
            document.getElementById('<%=hdnIsCreditBill.ClientID %>').value = IsCreditBill;
            document.getElementById('<%=hdnIsPatientPortTrust.ClientID %>').value = isPortTrust;
            document.getElementById('<%=hdnPreAuthAmount.ClientID %>').value = PreAuthAmount;
            document.getElementById('<%=hdnClaimAmount.ClientID %>').value = ClaimAmount;


            document.getElementById('<%=lblTotalBilledText.ClientID %>').innerText = parseFloat(TotalBilled).toFixed(2);
            document.getElementById('<%=lblTotalReceivedText.ClientID %>').innerText = parseFloat(TotalReceived).toFixed(2);
            document.getElementById('<%=lblDifferenceText.ClientID %>').innerText = parseFloat(DifferencebillRece).toFixed(2);
            document.getElementById('<%=lblCreditLimitText.ClientID %>').innerText = parseFloat(CreditLimt).toFixed(2);
            document.getElementById('<%=lblBalCreditLimitText.ClientID %>').innerText = parseFloat(BalanceCreditLimt).toFixed(2);
            document.getElementById('<%=lblPreAuttxt.ClientID %>').innerText = parseFloat(PreAuthAmount).toFixed(2);
            document.getElementById('<%=lblClaimtxt.ClientID %>').innerText = parseFloat(ClaimAmount).toFixed(2);
            if ((TotalReceived - TotalBilled) > 0) {
                document.getElementById('<%=hdnCashInHand.ClientID %>').value = (Number(TotalReceived) - Number(TotalBilled)).toFixed(2);
                document.getElementById('<%=lblCashInHandtxt.ClientID %>').innerText = (Number(TotalReceived) - Number(TotalBilled)).toFixed(2);
                if (CreditLimt > 0) {
                    document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = ((Number(TotalReceived) + Number(PreAuthAmount) + Number(CreditLimt)) - Number(TotalBilled)).toFixed(2);
                }
                else {
                    document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = ((Number(TotalReceived) + Number(PreAuthAmount)) - Number(TotalBilled)).toFixed(2);
                }

            }
            else {
                document.getElementById('<%=hdnCashInHand.ClientID %>').value = "0.00";
                document.getElementById('<%=lblCashInHandtxt.ClientID %>').innerText = "0.00";
                if (CreditLimt > 0) {
                    document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = ((Number(TotalReceived) + Number(PreAuthAmount) + Number(CreditLimt)) - Number(TotalBilled)).toFixed(2);
                }
                else {
                    document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = ((Number(TotalReceived) + Number(PreAuthAmount)) - Number(TotalBilled)).toFixed(2);
                }
            }
            if (CreditLimt < 0) {
                document.getElementById('<%=tdCreditLimit.ClientID %>').style.display = "none";
                document.getElementById('<%=tdBalanceCreditLimit.ClientID %>').style.display = "none";
            }
            document.getElementById('<%=trClaimAmount.ClientID %>').style.display = "none";
            document.getElementById('<%=tblCreditLimit.ClientID %>').style.display = "block";
            document.getElementById('<%=trPreAuth.ClientID %>').style.display = "block";

        }

    }
    function IsCreditBillNo(TotalBilled, TotalReceived, DifferencebillRece, CreditLimt, BalanceCreditLimt, IsCreditBill, PreAuthAmount, NonMedicalAmount, isPortTrust, ClaimAmount) {
        document.getElementById('<%=hdnTotalBilled.ClientID %>').value = parseFloat(TotalBilled).toFixed(2);
        document.getElementById('<%=hdnTotalReceived.ClientID %>').value = parseFloat(TotalReceived).toFixed(2);
        document.getElementById('<%=hdnDifferencebillRece.ClientID %>').value = parseFloat(DifferencebillRece).toFixed(2);
        document.getElementById('<%=hdnCreditLimt.ClientID %>').value = parseFloat(CreditLimt).toFixed(2);
        document.getElementById('<%=hdnBalCreditLimit.ClientID %>').value = parseFloat(BalanceCreditLimt).toFixed(2);
        document.getElementById('<%=hdnIsPatientPortTrust.ClientID %>').value = isPortTrust;
        document.getElementById('<%=hdnIsCreditBill.ClientID %>').value = IsCreditBill;
        if ((TotalReceived - TotalBilled) > 0) {
            document.getElementById('<%=hdnCashInHand.ClientID %>').value = (Number(TotalReceived) - Number(TotalBilled)).toFixed(2);
            document.getElementById('<%=lblCashInHandtxt.ClientID %>').innerText = (Number(TotalReceived) - Number(TotalBilled)).toFixed(2);
            if (CreditLimt > 0) {
                document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = ((Number(CreditLimt) + Number(TotalReceived)) - Number(TotalBilled)).toFixed(2);
            }
            else {
                document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = (Number(TotalReceived) - Number(TotalBilled)).toFixed(2);
            }

        }
        else {
            document.getElementById('<%=hdnCashInHand.ClientID %>').value = "0.00";
            document.getElementById('<%=lblCashInHandtxt.ClientID %>').innerText = "0.00";
            if (CreditLimt > 0) {
                document.getElementById('<%=tdCreditLimit.ClientID %>').style.display = "block";
                document.getElementById('<%=tdBalanceCreditLimit.ClientID %>').style.display = "none";
                document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = ((Number(CreditLimt) + Number(TotalReceived)) - Number(TotalBilled)).toFixed(2);
            }
            else {

                document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerText = (Number(TotalReceived) - Number(TotalBilled)).toFixed(2);
            }
        }

        document.getElementById('<%=lblTotalBilledText.ClientID %>').innerText = parseFloat(TotalBilled).toFixed(2);
        document.getElementById('<%=lblTotalReceivedText.ClientID %>').innerText = parseFloat(TotalReceived).toFixed(2);
        document.getElementById('<%=lblDifferenceText.ClientID %>').innerText = parseFloat(DifferencebillRece).toFixed(2);
        document.getElementById('<%=lblCreditLimitText.ClientID %>').innerText = parseFloat(CreditLimt).toFixed(2);
        document.getElementById('<%=lblBalCreditLimitText.ClientID %>').innerText = parseFloat(BalanceCreditLimt).toFixed(2);

        if (CreditLimt < 0) {
            document.getElementById('<%=tdCreditLimit.ClientID %>').style.display = "none";
            document.getElementById('<%=tdBalanceCreditLimit.ClientID %>').style.display = "none";


        }
        document.getElementById('<%=tblCreditLimit.ClientID %>').style.display = "block";
        document.getElementById('<%=trPreAuth.ClientID %>').style.display = "none";
        document.getElementById('<%=trClaimAmount.ClientID %>').style.display = "none";



    }
    function clearCreditLimitValues() {
        document.getElementById('<%=hdnTotalBilled.ClientID %>').value = "";
        document.getElementById('<%=hdnTotalReceived.ClientID %>').value = "";
        document.getElementById('<%=hdnDifferencebillRece.ClientID %>').value = "";
        document.getElementById('<%=hdnCreditLimt.ClientID %>').value = "";
        document.getElementById('<%=hdnBalCreditLimit.ClientID %>').value = "";
        document.getElementById('<%=hdnIsCreditBill.ClientID %>').value = ""; ;
        document.getElementById('<%=hdnPreAuthAmount.ClientID %>').value = "";
        document.getElementById('<%=hdnNonMedicalAmount.ClientID %>').value = "";
        document.getElementById('<%=hdnCashInHand.ClientID %>').value = ""; ;
        document.getElementById('<%=hdnIsPatientPortTrust.ClientID %>').value = "";
        document.getElementById('<%=hdnClaimAmount.ClientID %>').value = "";



        document.getElementById('<%=lblTotalBilledText.ClientID %>').innerText = "";
        document.getElementById('<%=lblTotalReceivedText.ClientID %>').innerText = "";
        document.getElementById('<%=lblDifferenceText.ClientID %>').innerText = "";
        document.getElementById('<%=lblCreditLimitText.ClientID %>').innerText = "";
        document.getElementById('<%=lblBalCreditLimitText.ClientID %>').innerText = "";
        document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerHTML = "";
        document.getElementById('<%=lblCashInHandtxt.ClientID %>').innerHTML = "";
        document.getElementById('<%=lblPreAuttxt.ClientID %>').innerText = "";
        document.getElementById('<%=lblClaimtxt.ClientID %>').innerText = "";

        document.getElementById('<%=tblCreditLimit.ClientID %>').style.display = "none";
    }
    function setCreditBilled(GrandAmount) {
        var totalReceived = document.getElementById('<%=hdnTotalReceived.ClientID %>').value;
        var totalPreviousBilled = document.getElementById('<%=hdnTotalBilled.ClientID %>').value;
        var cashInHand = document.getElementById('<%=hdnCashInHand.ClientID %>').value;
        var creditLimit = document.getElementById('<%=hdnCreditLimt.ClientID %>').value;
        var claimAmount = document.getElementById('<%=hdnClaimAmount.ClientID %>').value;
        var preAuth = document.getElementById('<%=hdnPreAuthAmount.ClientID %>').value;

        if (creditLimit > 0)
            cashInHand = parseFloat((Number(totalReceived) + Number(creditLimit) + Number(preAuth)) - Number(totalPreviousBilled)).toFixed(2);
        else
            cashInHand = parseFloat((Number(totalReceived) + Number(preAuth)) - Number(totalPreviousBilled)).toFixed(2);
        var tempCreditLimit = Number(cashInHand) - Number(GrandAmount);
        document.getElementById('<%=lblNowBilledtxt.ClientID %>').innerHTML = Number(tempCreditLimit).toFixed(2);
    }
    function InvCreditLimitCheck(GrandTotal) {
        var TotalCashandCreditLimitinHand = 0;
        var resTrue = true;
        if (document.getElementById('<%=hdnIsCreditBill.ClientID %>').value == 'Y' && document.getElementById('<%=hdnIsPatientPortTrust.ClientID %>').value == 'Y') {
            resTrue = true;
        }
        else if (document.getElementById('<%=hdnOrgCreditLimt.ClientID %>').value == "Y" && document.getElementById('<%=hdnIsCreditBill.ClientID %>').value == 'N') {
            if (Number(document.getElementById('<%=hdnCreditLimt.ClientID %>').value) > 0) {
                if (((Number(document.getElementById('<%=hdnCreditLimt.ClientID %>').value) + Number(document.getElementById('<%=hdnTotalReceived.ClientID %>').value)) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value)) > 0) {
                    TotalCashandCreditLimitinHand = ((Number(document.getElementById('<%=hdnCreditLimt.ClientID %>').value) + Number(document.getElementById('<%=hdnTotalReceived.ClientID %>').value)) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value));
                }
                else {
                    TotalCashandCreditLimitinHand = 0;
                }
            }
            else {
                if ((Number(document.getElementById('<%=hdnTotalReceived.ClientID %>').value) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value)) > 0) {
                    TotalCashandCreditLimitinHand = Number(document.getElementById('<%=hdnTotalReceived.ClientID %>').value) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value);
                }
                else {
                    TotalCashandCreditLimitinHand = 0;
                }
            }
            if (Number(GrandTotal) > Number(TotalCashandCreditLimitinHand)) {
                resTrue = false;
            }
            else {
                resTrue = true;
            }
        }
        else if (document.getElementById('<%=hdnOrgCreditLimt.ClientID %>').value == "Y" && document.getElementById('<%=hdnIsCreditBill.ClientID %>').value == 'Y') {
            if (Number(document.getElementById('<%=hdnCreditLimt.ClientID %>').value) > 0) {
                TotalCashandCreditLimitinHand = (Number(document.getElementById('<%=hdnCreditLimt.ClientID %>').value) + Number(document.getElementById('<%=hdnTotalReceived.ClientID %>').value) + Number(document.getElementById('<%=hdnPreAuthAmount.ClientID %>').value)) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value);
            }
            else {
                TotalCashandCreditLimitinHand = (Number(document.getElementById('<%=hdnTotalReceived.ClientID %>').value) + Number(document.getElementById('<%=hdnPreAuthAmount.ClientID %>').value)) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value);
            }

            if (Number(GrandTotal) > Number(TotalCashandCreditLimitinHand)) {
                resTrue = false;
            }
            else {
                resTrue = true;
            }
        }
        else {
            resTrue = true;
        }
        return resTrue;


    }
    function getCashInHand() {
        var TotalCashandCreditLimitinHand = 0;
        if (document.getElementById('<%= hdnOrgCreditLimt.ClientID %>').value == "Y" && document.getElementById('<%= hdnIsCreditBill.ClientID %>').value == 'N') {
            if (Number(document.getElementById('<%= hdnCreditLimt.ClientID %>').value) > 0) {
                if (((Number(document.getElementById('<%= hdnCreditLimt.ClientID %>').value) + Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value)) - Number(document.getElementById('<%= hdnTotalBilled.ClientID %>').value)) > 0) {
                    TotalCashandCreditLimitinHand = ((Number(document.getElementById('<%= hdnCreditLimt.ClientID %>').value) + Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value)) - Number(document.getElementById('<%= hdnTotalBilled.ClientID %>').value));
                }
                else {
                    TotalCashandCreditLimitinHand = 0;
                }

            }
            else {
                if ((Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value)) > 0) {
                    TotalCashandCreditLimitinHand = Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value) - Number(document.getElementById('<%=hdnTotalBilled.ClientID %>').value);
                }
                else {
                    TotalCashandCreditLimitinHand = 0;
                }
            }


        }
        else if (document.getElementById('<%= hdnOrgCreditLimt.ClientID %>').value == "Y" && document.getElementById('<%= hdnIsCreditBill.ClientID %>').value == 'Y') {
            if (Number(document.getElementById('<%= hdnCreditLimt.ClientID %>').value) > 0) {
                if ((Number(document.getElementById('<%= hdnCreditLimt.ClientID %>').value) + Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value) + Number(document.getElementById('<%= hdnPreAuthAmount.ClientID %>').value)) - Number(document.getElementById('<%= hdnTotalBilled.ClientID %>').value) > 0) {
                    TotalCashandCreditLimitinHand = (Number(document.getElementById('<%= hdnCreditLimt.ClientID %>').value) + Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value) + Number(document.getElementById('<%= hdnPreAuthAmount.ClientID %>').value)) - Number(document.getElementById('<%= hdnTotalBilled.ClientID %>').value);        
                }
                else {
                    TotalCashandCreditLimitinHand = 0;
                }
                
            }
            else {
                if ((Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value) + Number(document.getElementById('<%= hdnPreAuthAmount.ClientID %>').value)) - Number(document.getElementById('<%= hdnTotalBilled.ClientID %>').value) > 0) {
                    TotalCashandCreditLimitinHand = (Number(document.getElementById('<%= hdnTotalReceived.ClientID %>').value) + Number(document.getElementById('<%= hdnPreAuthAmount.ClientID %>').value)) - Number(document.getElementById('<%= hdnTotalBilled.ClientID %>').value);
                }
                else {
                    TotalCashandCreditLimitinHand = 0;
                }
            }

        }
        return TotalCashandCreditLimitinHand.toFixed(2);

    }
    
</script>

<table width="95%" cellpadding="2" cellspacing="2" class="defaultfontcolor">
    <tr>
        <td id="tblCreditLimit" runat="server" style="display: none;">
            <asp:Panel ID="Panel2" BorderWidth="1px" CssClass="dataheader2" runat="server">
                <table>
                    <tr align="left">
                        <td style="width: 210px;">
                            <asp:Label ID="lblTotalBilled" runat="server" Text="Total Billed Amount"></asp:Label>
                        </td>
                        <td style="width: 5px;">
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblTotalBilledText" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr align="left">
                        <td>
                            <asp:Label ID="lblTotalReceived" runat="server" Text="Total Received Amount"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblTotalReceivedText"
                                runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCashInHand" runat="server" Text="Cash In Hand"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblCashInHandtxt" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trPreAuth" runat="server">
                        <td>
                            <asp:Label ID="lblPreAut" runat="server" Text="Pre-Auth Amount"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblPreAuttxt" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trClaimAmount" runat="server">
                        <td>
                            <asp:Label ID="lblClaim" runat="server" Text="Claim Amount"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblClaimtxt" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="tdDifference" runat="server" style="display: none;" align="left">
                        <td>
                            <asp:Label ID="lblDifference" runat="server" Text="Difference between Billed & Received"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblDifferenceText" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="tdCreditLimit" runat="server" align="left">
                        <td>
                            <asp:Label ID="lblCreditLimit" runat="server" Text="Patient's Credit Limit"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblCreditLimitText" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="tdBalanceCreditLimit" style="display: none;" runat="server" align="left">
                        <td>
                            <asp:Label ID="lblBalCreditLimit" runat="server" Text="Remaining Credit Limit"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblBalCreditLimitText"
                                runat="server"></asp:Label>
                            <asp:HiddenField ID="hdnTotalBilled" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnTotalReceived" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnDifferencebillRece" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnCreditLimt" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnBalCreditLimit" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnIsCreditBill" runat="server" />
                            <asp:HiddenField ID="hdnPreAuthAmount" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnNonMedicalAmount" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnCashInHand" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnIsPatientPortTrust" Value="N" runat="server" />
                            <asp:HiddenField ID="hdnClaimAmount" Value="0.00" runat="server" />
                            <asp:HiddenField ID="hdnOrgCreditLimt" Value="N" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblNowBilled" runat="server" Text="Allowed Due"></asp:Label>
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label Style="text-align: right;" Font-Bold="true" ID="lblNowBilledtxt" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>
