<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AmountApprovalDetails.ascx.cs"
    Inherits="CommonControls_AmountApprovalDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript">


    function AssignApprovalDetails() {       
        var PatientDetails = GetPatientDetails();
        var PayMentDetails = GetBPaymentDetails();
        var GetDspDataDetails = GetDspData();
        var GetGeneralAmountdetails = GetGeneralDetails();
        var PatientDetailsValue = PatientDetails + '~' + PayMentDetails + '~' + GetGeneralAmountdetails;

        while (count = document.getElementById('tblPatientDetails').rows.length) {

            for (var j = 0; j < document.getElementById('tblPatientDetails').rows.length; j++) {
                document.getElementById('tblPatientDetails').deleteRow(j);
            }
        }
        var Headrow = document.getElementById('tblPatientDetails').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        cell1.innerHTML = "Patient Name";
        cell2.innerHTML = "Age";
        cell3.innerHTML = "Visit Purpose";
        cell4.innerHTML = "Approval Status";
        cell5.innerHTML = "Approval Type";

        var row = document.getElementById('tblPatientDetails').insertRow(1);
        row.style.height = "13px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        cell1.innerHTML = PatientDetailsValue.split('~')[1];
        cell2.innerHTML = PatientDetailsValue.split('~')[2]
        cell3.innerHTML = PatientDetailsValue.split('~')[4];
        cell4.innerHTML = "Pending";
        cell5.innerHTML = PatientDetailsValue.split('~')[5];
        if (PatientDetailsValue.split('~')[5] == 'Cheque') {
            document.getElementById('tblChequeDetails').style.display = 'block'
            while (count = document.getElementById('tblChequeDetails').rows.length) {

                for (var j = 0; j < document.getElementById('tblChequeDetails').rows.length; j++) {
                    document.getElementById('tblChequeDetails').deleteRow(j);
                }
            }
            var Headrow = document.getElementById('tblChequeDetails').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            cell1.innerHTML = "Cheque No";
            cell2.innerHTML = "Cheque valid Date";
            cell3.innerHTML = "Bank Name";
            cell4.innerHTML = "Amount";
            var row = document.getElementById('tblChequeDetails').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = PatientDetailsValue.split('~')[8];
            cell2.innerHTML = PatientDetailsValue.split('~')[9];
            cell3.innerHTML = PatientDetailsValue.split('~')[7];
            cell4.innerHTML = PatientDetailsValue.split('~')[6];


        }

        if (PatientDetailsValue.split('~')[5] == 'Discount') {
        }

        document.getElementById('<%=btnAmountApprovalDetailsOk.ClientID %>').style.display = 'block';
        document.getElementById('<%=btnAmountApprovalDetailsCheckStatus.ClientID %>').style.display = 'none';
        document.getElementById('<%=btnReject.ClientID %>').style.display = 'none';
        document.getElementById('<%=btnClose.ClientID %>').style.display = 'block';
        document.getElementById('<%= lblDiscountAmountText.ClientID %>').innerHTML = PatientDetailsValue.split('~')[11];
        document.getElementById('<%= lblTotalAmounttext.ClientID %>').innerHTML = PatientDetailsValue.split('~')[12];
    }

    function fnSaveAmountApprovalDetails() {
        var PatientDetails = GetPatientDetails();
        var PayMentDetails = GetBPaymentDetails();
        var GetDspDataDetails = GetDspData();
        var GetGeneralAmountdetails = GetGeneralDetails();
        var Comments = document.getElementById('<%= txtComments.ClientID %>').value;
        var PatientDetailsValue = PatientDetails + '~' + PayMentDetails + '~' + GetGeneralAmountdetails + '~' + Comments;

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetBillApprovalDetails",
            data: "{PatientDetails: '" + PatientDetailsValue + "',AmountDetails: '" + GetDspDataDetails + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function Success(data) {

                document.getElementById('<%= hdnAmountApprovalDetailsID.ClientID %>').value = data.d;             
                document.getElementById('<%=btnAmountApprovalDetailsOk.ClientID %>').style.display = 'none';
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
                return false;
            }
        });


        document.getElementById('<%=btnAmountApprovalDetailsOk.ClientID %>').style.display = 'none';
        document.getElementById('<%=btnAmountApprovalDetailsCheckStatus.ClientID %>').style.display = 'block';
        document.getElementById('<%=btnReject.ClientID %>').style.display = 'block';
        document.getElementById('<%=btnClose.ClientID %>').style.display = 'none';

        return false;

    }
    function AmountApprovalDetailsCancel(obj) {
        var ApprovalId = document.getElementById('<%= hdnAmountApprovalDetailsID.ClientID %>').value;
        var RefType = "";
        var ApprovalStatus = "";
        var Comments = "";
        if (obj.value == "Check Status") {
            RefType = "STATUS";
        }
        else {
            RefType = "UPDATE";
            ApprovalStatus = "Reject";
            Comments = document.getElementById('<%= txtComments.ClientID %>').value;
            document.getElementById('<%= hdnApprovalType.ClientID %>').value = ApprovalStatus;
        }
       
        var PatientDetailsValue = "";
        var GetDspDataDetails = "";

        if (ApprovalId != "0") {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetUpdateAmountApprovalStatus",
                data: "{ID:'" + ApprovalId + "',RefType: '" + RefType + "',comments:'" + Comments + "',ApprovalStatus:'" + ApprovalStatus + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {                    
                    document.getElementById('<%= hdnStatus.ClientID %>').value = data.d.split('~')[0];
                    document.getElementById('<%= lblRejectComments.ClientID %>').innerHTML = data.d.split('~')[1];
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    return false;
                }
            });
            document.getElementById('<%= lblRejectComments.ClientID %>').style.display = 'none';
            var GetStatusValue = document.getElementById('<%= hdnStatus.ClientID %>').value;
            if (GetStatusValue == "Approve" || GetStatusValue == "Reject") {
                document.getElementById('<%=btnAmountApprovalDetailsOk.ClientID %>').style.display = 'none';
                document.getElementById('<%=btnAmountApprovalDetailsCheckStatus.ClientID %>').style.display = 'none';
                document.getElementById('<%=btnReject.ClientID %>').style.display = 'none';
                document.getElementById('<%=btnClose.ClientID %>').style.display = 'block';
                document.getElementById('<%=LblStatusDisplay.ClientID %>').innerHTML = "The Approval status is '" + GetStatusValue + "'";
            }
            else {
                document.getElementById('<%=LblStatusDisplay.ClientID %>').innerHTML = "The Approval status is Pending ";
            }
            
            if (GetStatusValue == "Reject")
            {
                document.getElementById('<%= lblRejectComments.ClientID %>').style.display = 'block';
            }

            return false;
        }
    }


    function AmountApprovalDetailsClose(obj) {
        var status = document.getElementById('<%= hdnStatus.ClientID %>').value;
        document.getElementById('<%=txtComments.ClientID %>').value = "";
        document.getElementById('<%= lblRejectComments.ClientID %>').value = "";
        document.getElementById('<%=LblStatusDisplay.ClientID %>').innerHTML = "";
        document.getElementById('<%=btnAmountApprovalDetailsOk.ClientID %>').style.display = 'block';
        FunClosePopup(document.getElementById('<%= hdnStatus.ClientID %>').value);
        return false;
    }


    function CreateTask(Obj) {

    }
     
</script>

<%-- document.getElementById('<%= hdnApprovalType.ClientID %>').value = PayMentDetails.split("~")[0];  97--%>
<table cellpadding="0" style="border: 0px; border-color: Red" runat="server" id="tbVisitClient"
    border="0" cellspacing="0" width="100%">
    <tr>
        <td align="center">
            <table cellpadding="0" style="border: 0px; border-color: Red" runat="server" id="Table1"
                border="0" cellspacing="0" width="90%">
                <tr align="left">
                    <td colspan="4">
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Label ID="lblHeaderText" runat="server" Font-Bold="true" Text="Amount Approval Details"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                    </td>
                </tr>
                <tr align="left">
                    <td colspan="4">
                        <table id="tblPatientDetails" border="1" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                            style="text-align: left; font-size: 11px;" width="100%">
                        </table>
                    </td>
                </tr>
                <tr align="left">
                    <td colspan="4">
                        <table id="tblChequeDetails" border="1" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                            style="text-align: left; font-size: 11px; display: none;" width="100%">
                        </table>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <asp:Label ID="lblComments" runat="server" Text="Comments:"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtComments" runat="Server" TextMode="MultiLine"></asp:TextBox>
                    </td>
                    <td align="right">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTotalAmount" runat="server" Text="TotalAmount:"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblTotalAmounttext" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDiscount" runat="server" Text="Discount Amount:"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblDiscountAmountText" runat="server" Text="0.00"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <table width="50px">
                            <tr>
                                <td align="right">
                                    <asp:Button ID="btnAmountApprovalDetailsOk" runat="server" Text="Send Approval" CssClass="btn"
                                        OnClientClick="return fnSaveAmountApprovalDetails()" />
                                </td>
                                <td align="left">
                                    <asp:Button ID="btnAmountApprovalDetailsCheckStatus" runat="server" Text="Check Status"
                                        CssClass="btn" OnClientClick="return AmountApprovalDetailsCancel(this)" />
                                    <input type="hidden" runat="server" id="hdnAmountApprovalDetailsID" value="0" />
                                    <input type="hidden" runat="server" id="hdnApprovalType" value="" />
                                    <input type="hidden" runat="server" id="hdnStatus" value="" />
                                </td>
                                <td align="right">
                                    <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn" OnClientClick="return AmountApprovalDetailsCancel(this)" />
                                </td>
                                <td>
                                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" OnClientClick="return AmountApprovalDetailsClose(this)" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <asp:Label ID="LblStatusDisplay" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <asp:Label ID="lblRejectComments" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
